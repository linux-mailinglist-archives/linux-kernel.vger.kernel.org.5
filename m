Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE44754E64
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGPKlp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 16 Jul 2023 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGPKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 06:41:44 -0400
X-Greylist: delayed 7800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 03:41:41 PDT
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBCD10FE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 03:41:41 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.20.214])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id EC7A926ADB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:14:42 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-mrj8j (unknown [10.111.208.242])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 99ADF1FD27;
        Sun, 16 Jul 2023 08:14:41 +0000 (UTC)
Received: from courmont.net ([37.59.142.101])
        by ghost-submission-6684bf9d7b-mrj8j with ESMTPSA
        id cq+yIfGms2S5WQAA6+Cy+A
        (envelope-from <remi@remlab.net>); Sun, 16 Jul 2023 08:14:41 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-101G004a0c16907-66a8-4560-aeaa-72d5ba9cf500,
                    9A40DBAC776A0F14B495AFA9937DD4B5A62724A9) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] riscv: stack: Fixup independent irq stack for
 CONFIG_FRAME_POINTER=n
Date:   Sun, 16 Jul 2023 11:14:40 +0300
Message-ID: <5540704.q0sY26EuUQ@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230716001506.3506041-2-guoren@kernel.org>
References: <20230716001506.3506041-1-guoren@kernel.org>
 <20230716001506.3506041-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 12029677557349816795
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeffgedthfegveefhffhffehvddtvdetgfelveeuueekkeetvefgtdfgffdvhfegveenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sunnuntaina 16. heinäkuuta 2023, 3.15.05 EEST guoren@kernel.org a écrit :
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The independent irq stack uses s0 to save & restore sp, but s0 would be
> corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber list to
> fix the problem.

Isn't it *always* corrupted? Shouldn't the clobber be always there? Am I 
guessing that the compiler whine that you can't mark the frame pointer as 
clobbered? If so, it would be worth mentioning in the commit log, IMO.

> Fixes: 163e76cc6ef4 ("riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK")
> Cc: stable@vger.kernel.org
> Reported-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/traps.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d..927347a19847 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -372,6 +372,9 @@ asmlinkage void noinstr do_irq(struct pt_regs *regs)
> 
>  		: [sp] "r" (sp), [regs] "r" (regs)
>  		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> 
>  		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> +#ifndef CONFIG_FRAME_POINTER
> +		  "s0",
> +#endif
>  		  "memory");
>  	} else
>  #endif


-- 
レミ・デニ-クールモン
http://www.remlab.net/



