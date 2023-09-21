Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6517A9E55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjIUUAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjIUT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:59:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BE5809D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BdKb5EmyKQh6zjXSRICZvTdMTUVxdIjRuHFxEMonPvc=; b=Rz+hDcVLb9XQV177cM2trZLLbk
        Kt/DuViUTHSjgbNEa3maGTfhUAs1FAMrRGE04688hSkGYV8UIwcCILnnHbgoUzGAstoVXbOu83lK3
        y6EA0pNHP5eAs7HBtE8JO7MX7td1Mu7+BhlVW+eySmLe76iGmc5IRouiZnoFYz6P/gdE/TXe8XZrQ
        X5Y6+JInDPYtq94aUxh68pTnKQNnm34M7yjHcX/3TiAihi84q99tZeZebgsLqY4DZRDx+M5WGKJtN
        uyvVFDwfHLLL9mG8qfuvxNm5Sl8CUXrXCAG+OC9W6fnDaRgdUoL1nyV95JSnT8pBGSXIImaypR7gu
        5Xs7oLJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjNKN-00FWXy-2L;
        Thu, 21 Sep 2023 17:19:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0F483002F1; Thu, 21 Sep 2023 19:19:00 +0200 (CEST)
Date:   Thu, 21 Sep 2023 19:19:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for
 annotations
Message-ID: <20230921171900.GB29413@noisy.programming.kicks-ass.net>
References: <20230920001728.1439947-1-maskray@google.com>
 <20230921072655.GA14803@noisy.programming.kicks-ass.net>
 <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
 <20230921153537.GG14803@noisy.programming.kicks-ass.net>
 <CAFP8O3K6Lgxe=Res9d2GKipRYdXqzv3wa_0PLtDcyn7g7H=z5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3K6Lgxe=Res9d2GKipRYdXqzv3wa_0PLtDcyn7g7H=z5w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:26:43AM -0700, Fangrui Song wrote:

> I do not see why absolute things need 12 byte entries.
> We can freely use `.long .text.foo` even in ELFCLASS64 object files.
> There is no risk of overflow (the ultimate link .text.foo may have an
> address of 0xffffffff........) since the section will be discarded.

And you're sure no toolchain is going to be clever and tell me that the
absolute relocation will want to be 8 bytes and does not fit in the 4
bytes allotted?

Because clearly that is something some clever assembler is going to
complain about any day now.
