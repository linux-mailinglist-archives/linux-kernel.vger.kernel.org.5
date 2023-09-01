Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F87078F789
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348254AbjIADuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:50:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04418C;
        Thu, 31 Aug 2023 20:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693540248; x=1725076248;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=iaakvufsPSI4fOyOCZcSGBpreY75QiHRPYKuy7gdF98=;
  b=XcfUZVxODnk4qachp+3JRvVZf4ZP+RdcnyQR5aNfh7wTNyNYgQ63TXJl
   +/y9otEn3eLXbDUNbEkSBaHMSAjnEFT8WfKLGhPpfPSL/wq0FAA7iId1K
   k24RbFwjFYgzDGhkkOznlanf2H+bfYD2doNOUudZY1Q3AxsRHKe8BrJJy
   sUknvbvdgJ+B+//0lLdoBqfo19fp9AVSKe8qeNrdIDajWoxD7sHnShLXR
   BsFH4eb6L+SMceJxMITOgOnzdrxUrE2lmGPUAFL7T4R2Wv36S8aLszbY+
   ikx6EyGfloz8NpWJsMlFxQk6eJfZgEqfYJU114ENeqlzbxHvYfPIpiIGM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376062513"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="376062513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829974687"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="829974687"
Received: from vraghuna-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.213.167.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:50:46 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RFC: apparmor: Optimize retrieving current task
 secid
In-Reply-To: <7fe7fcb4-888b-086a-1a29-ee796859168c@canonical.com>
References: <20230831232224.460363-1-vinicius.gomes@intel.com>
 <0def2030-78f7-2213-dab6-408622cc25b2@canonical.com>
 <87zg26mx0u.fsf@intel.com>
 <7fe7fcb4-888b-086a-1a29-ee796859168c@canonical.com>
Date:   Thu, 31 Aug 2023 20:50:46 -0700
Message-ID: <87ttsemu09.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Johansen <john.johansen@canonical.com> writes:

> On 8/31/23 19:45, Vinicius Costa Gomes wrote:
>> John Johansen <john.johansen@canonical.com> writes:
>> 
>>> On 8/31/23 16:22, Vinicius Costa Gomes wrote:
>>>> When running will-it-scale[1] open2_process testcase, in a system with a
>>>> large number of cores, a bottleneck in retrieving the current task
>>>> secid was detected:
>>>>
>>>> 27.73% ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>>       27.72%     0.01%  [kernel.vmlinux]      [k] security_current_getsecid_subj             -      -
>>>> 27.71% security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>>       27.71%    27.68%  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj             -      -
>>>> 19.94% __refcount_add (inlined);__refcount_inc (inlined);refcount_inc (inlined);kref_get (inlined);aa_get_label (inlined);aa_get_label (inlined);aa_get_current_label (inlined);apparmor_current_getsecid_subj;security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>> 7.72% __refcount_sub_and_test (inlined);__refcount_dec_and_test (inlined);refcount_dec_and_test (inlined);kref_put (inlined);aa_put_label (inlined);aa_put_label (inlined);apparmor_current_getsecid_subj;security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>>
>>>> A large amount of time was spent in the refcount.
>>>>
>>>> The most common case is that the current task label is available, and
>>>> no need to take references for that one. That is exactly what the
>>>> critical section helpers do, make use of them.
>>>>
>>>> New perf output:
>>>>
>>>> 39.12% vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>>       39.07%     0.13%  [kernel.vmlinux]          [k] do_dentry_open                                                               -      -
>>>> 39.05% do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>>       38.71%     0.01%  [kernel.vmlinux]          [k] security_file_open                                                           -      -
>>>> 38.70% security_file_open;do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>>       38.65%    38.60%  [kernel.vmlinux]          [k] apparmor_file_open                                                           -      -
>>>> 38.65% apparmor_file_open;security_file_open;do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>>
>>>> The result is a throughput improvement of around 20% across the board
>>>> on the open2 testcase. On more realistic workloads the impact should
>>>> be much less.
>>>> hrmmm, interesting. its a nice improvement
>>>
>>>> [1] https://github.com/antonblanchard/will-it-scale
>>>>
>>>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>>
>>> Acked-by: John Johansen <john.johansen@canonical.com>
>>>
>>> do you want me to pull this into apparmor-next or do you have another
>>> tree in mind
>>>
>> 
>> -next is fine.
>> 
>>>> ---
>>>> Sending as RFC because I am not sure there's anything I am missing. My
>>>> read of the code tells me it should be fine.
>>>
>>> it is
>>>
>> 
>> Great. Do you want me to send a non-RFC version?
>>
> you can if you want but there is no need, I can do that small edit
>

I'll leave that to you, then. Thank you.

>>>>
>>>>    security/apparmor/lsm.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>>> index 108eccc5ada5..98e65c44ddd5 100644
>>>> --- a/security/apparmor/lsm.c
>>>> +++ b/security/apparmor/lsm.c
>>>> @@ -766,9 +766,9 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
>>>>    
>>>>    static void apparmor_current_getsecid_subj(u32 *secid)
>>>>    {
>>>> -	struct aa_label *label = aa_get_current_label();
>>>> +	struct aa_label *label = __begin_current_label_crit_section();
>>>>    	*secid = label->secid;
>>>> -	aa_put_label(label);
>>>> +	__end_current_label_crit_section(label);
>>>>    }
>>>>    
>>>>    static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
>>>
>> 
>> Cheers,
>

Cheers,
-- 
Vinicius
