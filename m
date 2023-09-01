Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE778F6E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjIABwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIABwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:52:05 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0FF10CF;
        Thu, 31 Aug 2023 18:51:27 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4C6093F6B8;
        Fri,  1 Sep 2023 01:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693533083;
        bh=rplkTKhvtPisTVAsQEjgHF7Fo1OdEcCi6oyRjCs/dOI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BpAGfGwYjjogUTRS4JY5IvvAmVyy0cS9We5tQ9PfLBqeqMsE+n3wKUVJbbJLjCWtj
         YvuFYR5SeQeuxJidN0ZtAb2F0JeBXZmacuuhnu4m5giB9/zdzRd5llFdRKFQwy/ouJ
         gC0cPtkrEoTjVP0VYXoqw3/jmd7iehAPFLg41sQrmTaFDoeS/vOqiwu/XyGIF8sirM
         bCZ6FjD2a7fOJRNeSkR8IWmPV/SabBR6y18nrVVrh8Y1UQqcYrGrTiTQZwt1z3+U2Y
         iFEfKFvLIRfXR16pKcjWxb02e0HvRM6RVc4ckG9P5JfbVGT97akJ5VIrRomT8UjPpI
         mEgLfRtGqhOpQ==
Message-ID: <0def2030-78f7-2213-dab6-408622cc25b2@canonical.com>
Date:   Thu, 31 Aug 2023 18:51:20 -0700
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
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230831232224.460363-1-vinicius.gomes@intel.com>
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

On 8/31/23 16:22, Vinicius Costa Gomes wrote:
> When running will-it-scale[1] open2_process testcase, in a system with a
> large number of cores, a bottleneck in retrieving the current task
> secid was detected:
> 
> 27.73% ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>      27.72%     0.01%  [kernel.vmlinux]      [k] security_current_getsecid_subj             -      -
> 27.71% security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
>      27.71%    27.68%  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj             -      -
> 19.94% __refcount_add (inlined);__refcount_inc (inlined);refcount_inc (inlined);kref_get (inlined);aa_get_label (inlined);aa_get_label (inlined);aa_get_current_label (inlined);apparmor_current_getsecid_subj;security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
> 7.72% __refcount_sub_and_test (inlined);__refcount_dec_and_test (inlined);refcount_dec_and_test (inlined);kref_put (inlined);aa_put_label (inlined);aa_put_label (inlined);apparmor_current_getsecid_subj;security_current_getsecid_subj;ima_file_check;do_open (inlined);path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_x64 (inlined);do_syscall_64;entry_SYSCALL_64_after_hwframe (inlined);__libc_open64 (inlined)
> 
> A large amount of time was spent in the refcount.
> 
> The most common case is that the current task label is available, and
> no need to take references for that one. That is exactly what the
> critical section helpers do, make use of them.
> 
> New perf output:
> 
> 39.12% vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>      39.07%     0.13%  [kernel.vmlinux]          [k] do_dentry_open                                                               -      -
> 39.05% do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>      38.71%     0.01%  [kernel.vmlinux]          [k] security_file_open                                                           -      -
> 38.70% security_file_open;do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
>      38.65%    38.60%  [kernel.vmlinux]          [k] apparmor_file_open                                                           -      -
> 38.65% apparmor_file_open;security_file_open;do_dentry_open;vfs_open;path_openat;do_filp_open;do_sys_openat2;__x64_sys_openat;do_syscall_64;entry_SYSCALL_64_after_hwframe;__libc_open64 (inlined)
> 
> The result is a throughput improvement of around 20% across the board
> on the open2 testcase. On more realistic workloads the impact should
> be much less.
> hrmmm, interesting. its a nice improvement

> [1] https://github.com/antonblanchard/will-it-scale
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Acked-by: John Johansen <john.johansen@canonical.com>

do you want me to pull this into apparmor-next or do you have another
tree in mind

> ---
> Sending as RFC because I am not sure there's anything I am missing. My
> read of the code tells me it should be fine.

it is

> 
>   security/apparmor/lsm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 108eccc5ada5..98e65c44ddd5 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -766,9 +766,9 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
>   
>   static void apparmor_current_getsecid_subj(u32 *secid)
>   {
> -	struct aa_label *label = aa_get_current_label();
> +	struct aa_label *label = __begin_current_label_crit_section();
>   	*secid = label->secid;
> -	aa_put_label(label);
> +	__end_current_label_crit_section(label);
>   }
>   
>   static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)

