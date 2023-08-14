Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9480C77C123
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHNT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjHNT5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:57:47 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E2E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:57:46 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A43BF40E0185;
        Mon, 14 Aug 2023 19:57:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5i1ehmysouWj; Mon, 14 Aug 2023 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692043062; bh=cm7QLxd7dysDbTX1iRCJaCpTVmJduNuzeIuidHz5Dcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3PR8C8rvQIiRSCXf8D3VbQba69MLdIQJRB2f0O8rX7x4Rqniw5nE/kzgh3299Z+E
         Bl0YnwwkpC8a3lEiYw9TsRbZOYcYN9DA20EAHvB18XZNCQNb14WFpWBCcEGBLFAHeR
         Du26Goz96goqZ+COeFEgTeTkYnUpNCnVSmdE63ePN7BiTaR7pEYKvR+pY645aQiM2M
         NLBhHgvYV47T4fKHN+aVyd9BcAYqTyGikdrDxQRe3nIjkPgCiEuXEIKaD+nMQCKC6S
         wISfLV340lFNhW+uj5gIzJNQVtt4NAo10Ujmq2+hlikYL8rC74EQP2nGVTBqAPzxDM
         w74F2HBhODHaYOT+X7+KULzygkvsuvBU29cAqGcObPTJAr7mWwzrOtQMW4wVS7EgY7
         9pZYSVoFLvRPzsZlvBfAa4NczRsmRe9eGOyFxBep/si0cYmTymbAYJ0e3azohsFD1T
         aRc8jQN21oBV0T5WHCo/MCRIlJtKveZUgZ2AoMp5QHtE+daHGMukGSHqzrkqtSzc0B
         vQ/FA8v3ouEWSTa6cethMrNF/T49z+MT4Vu5vNnnd/in6cocKpVQHEX18v1VNERBWK
         3ZN2Z1xrjl1okAXEUDVcAr2bCdCSMIgFw7r4AAgPss4yylrj1MHXIqguTC065iWykg
         WzQ/lcr4zfLwQOwfL401Vb/o=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCB8C40E0196;
        Mon, 14 Aug 2023 19:57:34 +0000 (UTC)
Date:   Mon, 14 Aug 2023 21:57:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: Re: [PATCH v2 00/11] Fix up SRSO stuff
Message-ID: <20230814195733.GIZNqHLQw79BvfjsXd@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local>
 <20230814195153.2zxtp6zx552trgh6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814195153.2zxtp6zx552trgh6@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:51:53PM -0700, Josh Poimboeuf wrote:
> >  * Regarding alignment - the instructions which need to be untrained,
> >  * must all start at a cacheline boundary for Zen1/2 generations. That
> >  * is, both the ret in zen_untrain_ret() and srso_safe_ret() in the
> >  * srso_untrain_ret() must both be placed at the beginning of
> >  * a cacheline.
> >  */
> 
> It's a good comment, but RET in srso_safe_ret() is still misaligned.
> Don't we need something like so?

Well, I guess that comment is still not good enough. Not the RET must be
cacheline-aligned but the function return sequences must be.

IOW, we need this:

<--- cacheline begin
SYM_INNER_LABEL(retbleed_return_thunk, SYM_L_GLOBAL)
        ret
        int3


and

<--- cacheline begin
SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
        lea 8(%_ASM_SP), %_ASM_SP
        ret
        int3

I'll improve on it before I apply it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
