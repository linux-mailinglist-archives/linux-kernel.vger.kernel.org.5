Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953D7777DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbjHJMG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHJMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:06:27 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E061BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:06:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 580DB40E0185;
        Thu, 10 Aug 2023 12:06:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oDjC6S0CFkwY; Thu, 10 Aug 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691669183; bh=fDfBBBiNSG84AnWT8yp/i98sBqEGWPLaaQt5mR4kWwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnjBO0fsomAYvY89SfvKeb4YcngHB6lpOtRX3xUPxGsWremqCrqGCqHjvY7tkoxAo
         2z5uQhnSsfLbfSnx/Weuew9WVCKxTcXFMLd2wZOBPwgEG6TK48om0lSY5o8G2SS8K9
         0BrNJwfcH1Lbll+PyUAJhmxWipPHgXKoLbE9QL5k0tW35xnaghR5ORqJlhhtxp88Fc
         s072SXtBIcxrej5rqqKpqsyj0NCUtog15HisTqtWYWzakydwwwfaddoMJpagX70boi
         DhyTKwI+b+8S0jJDGhUX40yIXaFTnLjUQCamWWAnet2AFEuwVlnrPvOguviG+Ikssj
         9OWoMa2vYr+hNpyPvwpNupBoqyBjhsnd9uUnYI3kCXmdwePJ7L3+mLu9J2ZQxqBQyi
         6NNFRlxWjo2vQ3crT650ohKB3YyDpn0uvIyGUqMsl0bmYWLHTb2Fy7ZtzjNd6cOjqa
         wZZJHdC8IRyA/4263KjZtqxilqDIq/FEw7Qdh3o401uVuG1X38rSVv7dUHzMuiNMRw
         Mb6bXPLgaOKXDER2Tb4/8AYV0TpqT9Xu7XF5/r27ZuNngCmkuFgzYBn8ay7mHXJ40V
         EeoXhWJzjG5NxFJNoQdLoNqZW2xrIeDeVBuMd8LT/YYohtlCH2I0nJT88tarJejOzg
         n9J6CwLliRvGDddXRT/3C54M=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 598EB40E0140;
        Thu, 10 Aug 2023 12:06:16 +0000 (UTC)
Date:   Thu, 10 Aug 2023 14:06:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 04/17] objtool/x86: Fix SRSO mess
Message-ID: <20230810120615.GGZNTSt49g/2YCTGYI@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.715361518@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.715361518@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:22AM +0200, Peter Zijlstra wrote:
> arch_is_rethunk() indicates those functions that will be considered
> equivalent to INSN_RETURN and any callsite will be added to the
> .return_sites section.
> 
> Notably: srso_untrain_ret, srso_safe_ret and __ret do not qualify.

They do not qualify *anymore*. Before your changes, the last two would
call RET.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
