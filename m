Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827467E0086
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjKCIWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjKCIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:22:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B4123;
        Fri,  3 Nov 2023 01:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EPKbN/fAcNBie4nAiJk8hvrFfMadPTWNEWxizjzYh/k=; b=nNNyOoFxo0uwwVvNH/wBj6zyxi
        AAmkgPQPchCj3Moaubf3St2OGjUZ57ikTinRRjirtZGFU4gjc2/lXJ/sMLpSWhyq6Xd9vFgj370K7
        nWATYHpJlFWLlX4oYvz6APkQi38bApywqw116dvcerAEuqtGxAX4vMIlEjH9TUc9oclP+jENuvh8H
        rxbsnDBlCBtYqw9s4g8nNkJRsLhrFwzmllYGoYaFEHfsMWs5Ckn1fL7gaMyU084ZZgoWfoKO6Ue2X
        FfugdaZCdHPS5/wlzaIeM4cjoKzc46QMKLvKz8f6A3VqNBDq1iVgTvkoMnq5eUEdAv7gUi6xDFCKD
        ScKIZBag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qypRN-00AyPo-38;
        Fri, 03 Nov 2023 08:22:05 +0000
Date:   Fri, 3 Nov 2023 01:22:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, ndesaulniers@google.com,
        trix@redhat.com, 0x7f454c46@gmail.com, fruggeri@arista.com,
        noureddine@arista.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <ZUStrQCqBjBBB6dc@infradead.org>
References: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 01:23:35PM -0700, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
> 
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
> 
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
> 
>   net/ipv4/tcp_output.c:663:2: error: expected statement
>           }
>           ^
>   1 error generated.
> 
> Add a semicolon after the label to create an empty statement, which
> resolves the warning or error for all compilers.

Can you please just split the A0 handlig into a separate helper, which
shuld make the whole thing a lot cleaner?

