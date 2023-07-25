Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE96C7617E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGYMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGYMAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:00:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB810D1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nDERFXrUTHMcnX/B9wmmuuCM/35oLwV5LmBLcKHQ7wo=; b=vVrOwE9e+Wq1O4vz+7qVdMBX2e
        Pbru78bvc4yve8vj0VufKsfCHTuJkwrcOHaj0Ok66ByYTJWcDmlN4oBalUd6ZG+gQOgd5m/QHvv3Q
        0P9J1P2AlzlEcaV5yU4HUb9oRegnf29+wlmHTuElBXOeKYnD1safRRwtrRY/C0JjPpTcEAfxZTs9e
        sj6pONddrXe46B0mympuVy+warKuGeKTsbTqkjO6y6HPPILntLtnDr76drWehoYLCo3+yVSWOJiJU
        BJ4x6zjRQyE7YgOeTgQHsCbRh99dZtGhBxcI84n6chk2Nwv1VxQaa96J81bjQkgoTRsuQh0Efwp9d
        H1/xLevA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOGhr-005RMi-IC; Tue, 25 Jul 2023 12:00:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96A3030056F;
        Tue, 25 Jul 2023 13:59:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FCDB2612ABE5; Tue, 25 Jul 2023 13:59:59 +0200 (CEST)
Date:   Tue, 25 Jul 2023 13:59:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 5/6] objtool: Add skipped member in struct reloc
Message-ID: <20230725115959.GE3765278@hirez.programming.kicks-ass.net>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
 <1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:15:09PM +0800, Tiezhu Yang wrote:
> There exist multiple relocation types in one location, such as a pair of
> R_LARCH_ADD32 and R_LARCH_SUB32 in section .rela.discard.unreachable and
> .rela.discard.reachable on LoongArch.
> 
> Here is an example:
> 
> $ readelf -rW init/main.o
> 
> Relocation section '.rela.discard.unreachable' at offset 0x3e20 contains 2 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> 0000000000000000  0000000a00000032 R_LARCH_ADD32          0000000000000000 .init.text + 230
> 0000000000000000  0000001a00000037 R_LARCH_SUB32          0000000000000000 L0^A + 0
> 

Please explain; why is this?

How does:

#define __annotate_unreachable(c) ({					\
	   asm volatile(__stringify_label(c) ":\n\t"                       \
			".pushsection .discard.unreachable\n\t"            \
			".long " __stringify_label(c) "b - .\n\t"          \
			".popsection\n\t" : : "i" (c));                    \
})
#define annotate_unreachable() __annotate_unreachable(__COUNTER__)

Manage to generate this..
