Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D476E7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjHCMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjHCMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:11:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582642D49
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zV+MKFs0Ek/F4CDO6/XiX2nafcwDJWDb5aXZEN1DceI=; b=S9FNMwBMzkvE+fZ14ylxcUw30g
        ev4K4QQWOYn5S5GLUsYACkTA/cXow8hT4p401VAdYWjkh5K+p47n3jJswhzTnR8gJtgDsvyOKX4vf
        EMMDOQPLlrWCgZiPrFwtF1mgSjIYPa2cbIzekZ9V3/LscpwRT96CJUPRkQXN/5Bg/C8yo5GRb1Or8
        1kUNoiuolfemDWXkFD9/dTTV+E/GH4V6bM+C2Ko2sC7rE9EEy4xibszDtRiQZ9dOKgdXpfsHejDqA
        HNAKzY/gvBUhUFq1dF+E/wn0Rbt1KB+lkm5NHoWck30+DsZ8g33ve1ILu9Cp5H8gkHTyWZM5nJ1nX
        IOvpnU3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRXAW-003Xnq-OW; Thu, 03 Aug 2023 12:11:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 434E330007E;
        Thu,  3 Aug 2023 14:11:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29CFE20727FD6; Thu,  3 Aug 2023 14:11:03 +0200 (CEST)
Date:   Thu, 3 Aug 2023 14:11:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 5/6] objtool: Add skipped member in struct reloc
Message-ID: <20230803121103.GE214207@hirez.programming.kicks-ass.net>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
 <1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn>
 <20230725115959.GE3765278@hirez.programming.kicks-ass.net>
 <b111cb87-3f30-860a-640b-2f7264a16838@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b111cb87-3f30-860a-640b-2f7264a16838@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:36:24PM +0800, Tiezhu Yang wrote:

> > 			".long " __stringify_label(c) "b - .\n\t"          \

> I discussed offline with the engineers who are familiar with gnu
> assembler of LoongArch, maybe it can modify the gnu assembler
> to use R_LARCH_32_PCREL to replace a pair of R_LARCH_ADD32 and
> R_LARCH_SUB32, then I will test it again and drop this change if
> possible.

Yes, this is exactly what PC relative relocations are for.
