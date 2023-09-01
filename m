Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAE78F759
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348207AbjIACyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjIACyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:54:35 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB3E77;
        Thu, 31 Aug 2023 19:54:31 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 147D43F6D7;
        Fri,  1 Sep 2023 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693536870;
        bh=lSaPvx3sAhBw4cusmWt0k53d12ZwR75nMlpV88WohRk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=NLu/chbrt43HF2oHZQxop45yHofW7KeCzkkKAZcSKafkaXRsEqcpIlJsbtIQbxXxN
         w0gX+I9htsKSnFF9PFCZgfm2fBBLOsyM7il6/cvUTMIuEOqWaJSIMBPfwcGQyVhGK+
         ABo8+fARxOeltm6wT9CICwiUlb5lCakPcFtpE9uw0wl0zAfLW1g5ATEBmKg8J6NFcM
         rsHcGDJB5lVBkXog7TibMNcE4/Koqz6db6dKkW6V2S6yx5h0hWdA5oXI9rtnjpgKgF
         6/A6693OnzPf2sjvZ4ajTVC2Tv+WlcU6+KzbmgCm7aM9FK8euZv+4scqO1zKU0UO/+
         0Qn/wZ/eo/7bw==
Message-ID: <7fe7fcb4-888b-086a-1a29-ee796859168c@canonical.com>
Date:   Thu, 31 Aug 2023 19:54:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] RFC: apparmor: Optimize retrieving current task
 secid
Content-Language: en-US
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        apparmor@lists.ubuntu.com
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230831232224.460363-1-vinicius.gomes@intel.com>
 <0def2030-78f7-2213-dab6-408622cc25b2@canonical.com>
 <87zg26mx0u.fsf@intel.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <87zg26mx0u.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 19:45, Vinicius Costa Gomes wrote:
> John Johansen <john.johansen@canonical.com> writes:
> 
>> On 8/31/23 16:22, Vinicius Costa Gomes wrote:
>>> When running will-it-scale[1] open2_process testcase, in a system with a
>>> large number of cores, a bottleneck in retrieving the current task
>>> secid was detected:
>>>
>>> 27.73% ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>       27.72%     0.01%  [kernel.vmlinux]      [k] security_current_getsecid_subj             -      -
>>> 27.71% security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>       27.71%    27.68%  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj             -      -
>>> 19.94% __refcount_add (inlined);__refcount_inc (inlined);refcount_inc (inlined);kref_get (inlined);aa_get_label (inlined);aa_get_label (inlined);aa_get_current_label (inlined);apparmor_current_getsecid_subj;security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>> 7.72% __refcount_sub_and_test (inlined);__refcount_dec_and_test (inlined);refcount_dec_and_test (inlined);kref_put (inlined);aa_put_label (inlined);aa_put_label (inlined);apparmor_current_getsecid_subj;security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>>>
>>> A large amount of time was spent in the refcount.
>>>
>>> The most common case is that the current task label is available, and
>>> no need to take references for that one. That is exactly what the
>>> critical section helpers do, make use of them.
>>>
>>> New perf output:
>>>
>>> 39.12% vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>       39.07%     0.13%  [kernel.vmlinux]          [k] do_dentry_open                                                               -      -
>>> 39.05% do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>       38.71%     0.01%  [kernel.vmlinux]          [k] security_file_open                                                           -      -
>>> 38.70% security_file_open;do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>       38.65%    38.60%  [kernel.vmlinux]          [k] apparmor_file_open                                                           -      -
>>> 38.65% apparmor_file_open;security_file_open;do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>>>
>>> The result is a throughput improvement of around 20% across the board
>>> on the open2 testcase. On more realistic workloads the impact should
>>> be much less.
>>> hrmmm, interesting. its a nice improvement
>>
>>> [1] https://github.com/antonblanchard/will-it-scale
>>>
>>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>
>> Acked-by: John Johansen <john.johansen@canonical.com>
>>
>> do you want me to pull this into apparmor-next or do you have another
>> tree in mind
>>
> 
> -next is fine.
> 
>>> ---
>>> Sending as RFC because I am not sure there's anything I am missing. My
>>> read of the code tells me it should be fine.
>>
>> it is
>>
> 
> Great. Do you want me to send a non-RFC version?
>
you can if you want but there is no need, I can do that small edit
  
>>>
>>>    security/apparmor/lsm.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>> index 108eccc5ada5..98e65c44ddd5 100644
>>> --- a/security/apparmor/lsm.c
>>> +++ b/security/apparmor/lsm.c
>>> @@ -766,9 +766,9 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
>>>    
>>>    static void apparmor_current_getsecid_subj(u32 *secid)
>>>    {
>>> -	struct aa_label *label = aa_get_current_label();
>>> +	struct aa_label *label = __begin_current_label_crit_section();
>>>    	*secid = label->secid;
>>> -	aa_put_label(label);
>>> +	__end_current_label_crit_section(label);
>>>    }
>>>    
>>>    static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
>>
> 
> Cheers,

