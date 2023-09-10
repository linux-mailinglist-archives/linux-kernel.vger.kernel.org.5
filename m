Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830A6799C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 02:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbjIJAQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 20:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjIJAQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 20:16:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26F1BD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 17:16:27 -0700 (PDT)
X-QQ-mid: bizesmtp62t1694304964txspi1h0
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 10 Sep 2023 08:16:02 +0800 (CST)
X-QQ-SSF: 01200000000000101000000A0000000
X-QQ-FEAT: LE7C6P2vL8T8dkxfHfUMK4hSz907dsoEo8Skjve4CIaYwaWm+SWYl7AWRESLI
        ehkPraxg98x7BxgHqox8OAu/HvVe5UR7B/uh6GIpTqvIM4VlyioRIajkseCrD5vz0Zo+bMp
        2O1OS8zKXW3HL705eWwadY6uOGid8YnJBkt3hu4yQAl9QBxVhr72wpv5hgaPYrroUi1S8VB
        6tq+RaWxqUsVOblPxsz8V+MWqLRJwTyx2hOlBEl2ONG9mDsAtHeQTlSbEZbohMLT+PvaXl5
        3PhxYZfntGPUz9cQV6W/Vx+YT1KJurmcNGlWIyCN+TJ2pqo3xSYgtehlDyeqsJsNi51+461
        6PlUDSJeTOxhvyJadMEMCjQsNCPTILADZdTDnPvMeI5FpOUlN0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9083973876487166381
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     samuel@sholland.org
Cc:     aou@eecs.berkeley.edu, conor@kernel.org, falcon@tinylab.org,
        guoren@kernel.org, jszhang@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        wangjiexun@tinylab.org
Subject: Re: [PATCH v2] RISC-V: Fix use of non existent CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Sun, 10 Sep 2023 08:16:01 +0800
Message-Id: <20230910001601.371826-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0e270067-cd2d-ecd0-512b-5dce4865fa4c@sholland.org>
References: <0e270067-cd2d-ecd0-512b-5dce4865fa4c@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sep 2023 16:20:41 -0500, Samuel Holland wrote:=0D
>Hi,=0D
>=0D
>The patch is correct, though the subject isn't quite accurate.=0D
>CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK exists; it is defined in arch/Kconfig.=0D
>It's just the wrong option to use to guard the function definition.=0D
>=0D
=0D
I think I should send a new version of the patch with the subject:=0D
RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK. =0D
Does this subject look more appropriate?=0D
=0D
>On 9/6/23 07:32, Jiexun Wang wrote:=0D
>> If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT =0D
>> are enabled simultaneously under RISC-V architecture,=0D
>> it will result in a compilation failure:=0D
>> =0D
>> arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_sta=
ck'=0D
>>    64 | void do_softirq_own_stack(void)=0D
>>       |      ^~~~~~~~~~~~~~~~~~~~=0D
>> In file included from ./arch/riscv/include/generated/asm/softirq_stack.h=
:1,=0D
>>                  from arch/riscv/kernel/irq.c:15:=0D
>> ./include/asm-generic/softirq_stack.h:8:20: note: previous definition of=
 'do_softirq_own_stack' was here=0D
>>     8 | static inline void do_softirq_own_stack(void)=0D
>>       |                    ^~~~~~~~~~~~~~~~~~~~=0D
>>       =0D
>> After changing CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK to CONFIG_SOFTIRQ_ON_OWN=
_STACK,=0D
>> compilation can be successful.=0D
>> =0D
>> Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")=
=0D
>> Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>=0D
>> ---=0D
>> Changes in v2:=0D
>> - changed to a more suitable subject line=0D
>> - add a Fixes tag=0D
>> =0D
>> ---=0D
>>  arch/riscv/kernel/irq.c | 2 +-=0D
>>  1 file changed, 1 insertion(+), 1 deletion(-)=0D
>> =0D
>> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c=0D
>> index a8efa053c4a5..a86f272ae2c3 100644=0D
>> --- a/arch/riscv/kernel/irq.c=0D
>> +++ b/arch/riscv/kernel/irq.c=0D
>> @@ -60,7 +60,7 @@ static void init_irq_stacks(void)=0D
>>  }=0D
>>  #endif /* CONFIG_VMAP_STACK */=0D
>>  =0D
>> -#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=0D
>> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK=0D
>=0D
>It would be good to fix the #endif comment at the bottom of the function=0D
>as well.=0D
=0D
Thanks, I will fix this as well.=0D
=0D
Best regards,=0D
Jiexun Wang=0D
=0D
>=0D
>Regards,=0D
>Samuel=0D
>=0D
>>  void do_softirq_own_stack(void)=0D
>>  {=0D
