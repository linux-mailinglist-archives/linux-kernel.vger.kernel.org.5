Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E77B3768
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjI2QBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2QBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:01:02 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D1139
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:01:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:49814)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFvG-008vng-VE; Fri, 29 Sep 2023 10:00:59 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42582 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFvF-00H9Oh-8k; Fri, 29 Sep 2023 10:00:58 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
References: <20230929021213.2364883-1-joel@joelfernandes.org>
Date:   Fri, 29 Sep 2023 11:00:49 -0500
In-Reply-To: <20230929021213.2364883-1-joel@joelfernandes.org> (Joel
        Fernandes's message of "Fri, 29 Sep 2023 02:12:12 +0000")
Message-ID: <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qmFvF-00H9Oh-8k;;;mid=<87bkdl55qm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19pIQoI2yAji5xXUZsxi83S5aP6GqyP94M=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Joel Fernandes (Google)" <joel@joelfernandes.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1064 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (0.9%), b_tie_ro: 8 (0.8%), parse: 1.50 (0.1%),
        extract_message_metadata: 29 (2.7%), get_uri_detail_list: 4.2 (0.4%),
        tests_pri_-2000: 14 (1.3%), tests_pri_-1000: 3.0 (0.3%),
        tests_pri_-950: 1.29 (0.1%), tests_pri_-900: 1.05 (0.1%),
        tests_pri_-200: 0.84 (0.1%), tests_pri_-100: 12 (1.2%), tests_pri_-90:
        420 (39.5%), check_bayes: 392 (36.9%), b_tokenize: 10 (0.9%),
        b_tok_get_all: 204 (19.2%), b_comp_prob: 5 (0.5%), b_tok_touch_all:
        167 (15.7%), b_finish: 2.1 (0.2%), tests_pri_0: 480 (45.1%),
        check_dkim_signature: 0.82 (0.1%), check_dkim_adsp: 7 (0.6%),
        poll_dns_idle: 0.88 (0.1%), tests_pri_10: 54 (5.1%), tests_pri_500: 33
        (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Joel Fernandes (Google)" <joel@joelfernandes.org> writes:

> During kexec reboot, it is possible for a race to occur between
> device_shutdown() and userspace.  This causes accesses to GPU after pm_runtime
> suspend has already happened. Fix this by calling freeze_processes() before
> device_shutdown().

Is there any reason why this same race with between sys_kexec and the
adreno_ioctl can not happen during a normal reboot?

Is there any reason why there is not a .shutdown method to prevent the
race?

I would think the thing to do is to prevent this race in
kernel_restart_prepare or in the GPUs .shutdown method.  As I don't see
anything that would prevent this during a normal reboot.

>
> Such freezing is already being done if kernel supports KEXEC_JUMP and
> kexec_image->preserve_context is true. However, doing it if either of these are
> not true prevents crashes/races.

The KEXEC_JUMP case is something else entirely.  It is supposed to work
like suspend to RAM.  Maybe reboot should as well, but I am
uncomfortable making a generic device fix kexec specific.


> This fixes the following crash during kexec reboot on an ARM64 device
> with adreno GPU:
>
> [  292.534314] Kernel panic - not syncing: Asynchronous SError Interrupt
> [  292.534323] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> [  292.534326] Call trace:
> [  292.534328]  dump_backtrace+0x0/0x1d4
> [  292.534337]  show_stack+0x20/0x2c
> [  292.534342]  dump_stack_lvl+0x60/0x78
> [  292.534347]  dump_stack+0x18/0x38
> [  292.534352]  panic+0x148/0x3b0
> [  292.534357]  nmi_panic+0x80/0x94
> [  292.534364]  arm64_serror_panic+0x70/0x7c
> [  292.534369]  do_serror+0x0/0x7c
> [  292.534372]  do_serror+0x54/0x7c
> [  292.534377]  el1h_64_error_handler+0x34/0x4c
> [  292.534381]  el1h_64_error+0x7c/0x80
> [  292.534386]  el1_interrupt+0x20/0x58
> [  292.534389]  el1h_64_irq_handler+0x18/0x24
> [  292.534395]  el1h_64_irq+0x7c/0x80
> [  292.534399]  local_daif_inherit+0x10/0x18
> [  292.534405]  el1h_64_sync_handler+0x48/0xb4
> [  292.534410]  el1h_64_sync+0x7c/0x80
> [  292.534414]  a6xx_gmu_set_oob+0xbc/0x1fc
> [  292.534422]  a6xx_get_timestamp+0x40/0xb4
> [  292.534426]  adreno_get_param+0x12c/0x1e0
> [  292.534433]  msm_ioctl_get_param+0x64/0x70
> [  292.534440]  drm_ioctl_kernel+0xe8/0x158
> [  292.534448]  drm_ioctl+0x208/0x320
> [  292.534453]  __arm64_sys_ioctl+0x98/0xd0
> [  292.534461]  invoke_syscall+0x4c/0x118
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ricardo Ribalda <ribalda@google.com>
> Cc: Ross Zwisler <zwisler@google.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Ricardo Ribalda <ribalda@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/kexec_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index e2f2574d8b74..6599f485e42d 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1299,6 +1299,12 @@ int kernel_kexec(void)
>  	} else
>  #endif
>  	{
> +		error = freeze_processes();
> +		if (error) {
> +			error = -EBUSY;
> +			goto Unlock;
> +		}
> +
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();

Eric
