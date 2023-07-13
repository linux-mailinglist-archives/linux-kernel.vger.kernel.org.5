Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62875166B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGMCqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGMCp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:45:58 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ACD19BA;
        Wed, 12 Jul 2023 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1689216351; bh=gqz1bgvL/lc4UJv2uVXgCnOHv0QDm6yYBsD26lwdwp8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BzBBi+C00IuSe07iaacQw/Rel7MGQmTVUDl8U2srpx3+vUC2lgT4eXwe7XZnMj9cH
         wvOU3eM42Q0ppZyhciwLdOt9zeGR7iuQDV2cI0lCPWNU4Oa2iQ/GL0BNMYnqujb/2z
         pQMdRBzje3qDwknM47V5k+8tOn/ug4Xo0MfAtvgY=
Received: from [100.100.34.13] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9684C600DA;
        Thu, 13 Jul 2023 10:45:50 +0800 (CST)
Message-ID: <0797812f-20cd-9961-7a46-d8e6fefee788@xen0n.name>
Date:   Thu, 13 Jul 2023 10:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 02/10] tty: sysrq: switch sysrq handlers from int to u8
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
References: <20230712081811.29004-1-jirislaby@kernel.org>
 <20230712081811.29004-3-jirislaby@kernel.org>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230712081811.29004-3-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/12 16:18, Jiri Slaby (SUSE) wrote:
> The passed parameter to sysrq handlers is a key (a character). So change
> the type from 'int' to 'u8'. Let it specifically be 'u8' for two
> reasons:
> * unsigned: unsigned values come from the upper layers (devices) and the
>    tty layer assumes unsigned on most places, and
> * 8-bit: as that what's supposed to be one day in all the layers built
>    on the top of tty. (Currently, we use mostly 'unsigned char' and
>    somewhere still only 'char'. (But that also translates to the former
>    thanks to -funsigned-char.))
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> ---
>   arch/alpha/kernel/setup.c       |  2 +-
>   arch/loongarch/kernel/sysrq.c   |  2 +-
>   arch/mips/kernel/sysrq.c        |  2 +-
>   arch/powerpc/xmon/xmon.c        |  2 +-
>   arch/sparc/kernel/process_64.c  |  4 ++--
>   drivers/gpu/drm/drm_fb_helper.c |  2 +-
>   drivers/tty/sysrq.c             | 40 ++++++++++++++++-----------------
>   include/linux/sysrq.h           |  2 +-
>   kernel/debug/debug_core.c       |  2 +-
>   kernel/power/poweroff.c         |  2 +-
>   kernel/rcu/tree_stall.h         |  2 +-
>   11 files changed, 31 insertions(+), 31 deletions(-)
> 
> [snip]
> diff --git a/arch/loongarch/kernel/sysrq.c b/arch/loongarch/kernel/sysrq.c
> index 366baef72d29..e663c10fa39c 100644
> --- a/arch/loongarch/kernel/sysrq.c
> +++ b/arch/loongarch/kernel/sysrq.c
> @@ -43,7 +43,7 @@ static void sysrq_tlbdump_othercpus(struct work_struct *dummy)
>   static DECLARE_WORK(sysrq_tlbdump, sysrq_tlbdump_othercpus);
>   #endif
>   
> -static void sysrq_handle_tlbdump(int key)
> +static void sysrq_handle_tlbdump(u8 key)
>   {
>   	sysrq_tlbdump_single(NULL);
>   #ifdef CONFIG_SMP
> [snip]

Acked-by: WANG Xuerui <git@xen0n.name> # loongarch

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

