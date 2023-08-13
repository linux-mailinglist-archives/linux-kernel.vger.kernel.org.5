Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3277A6E1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjHMOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:19:59 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEF10FC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:19:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7B23540E0195;
        Sun, 13 Aug 2023 14:19:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b3Dc-pOvR-_j; Sun, 13 Aug 2023 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691936395; bh=Ikll8sNbMqlBqkwitjtaer8Ua46WTTXt7+Lsp1w8wDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCWTsAEOjxe4ymgkU5mMUzv3epDmr8ipDV72zaAj43kNbfdOo9v7LxwszITjG5Iet
         w/15SqWQLZ7UZ8luDMWl7PR+YhaI3+nrrmC2myvCEGeU1DPEn5di5WpQb6E+MKW3xP
         n2P0K/cbj9loIQqMbq7OGPrPJkJiDW40Ena7rK9wd1OiH5RFhMSxj89PHzJduF/CPC
         8jQ72vnmLWhld/kB6riyvphB2FCCDCwAaia9jsfJ1o9D7bX0gXirKtoJh1d7o9JE1m
         lM1mrP5KmQacQA++pdsRXEIqCFxQN9wEseHSfPNNdUWzQl60WlJ9mxq9wuGafZ93N3
         NaVmRzYZq847PrbMgpWQJkr4T5d4tBLnzY8Qm+zMKWQ2GEHmc1+QMDCe4rP0pQnjXv
         d0YO29wGdfaXFQwAh+PggzLInj6k3vwu7CKlKIft6+py/MyihGhSnFy3PzyM4vpluI
         ykDq5EJLghPBMmnKyItN0y8C3Q1SDMJA+ahlDzuXBsi22zYEIrO23sfupcu0JeJ2Lg
         cSzkZ9EfjxTXXTZXSXNcNTG5P3Sce5v0/nYa34HgtPffPuI9o8nbF9aJButskdEUjJ
         LUmxtdJquZQrnZKzWZnDIdd405gPZyFSLas8wY11LHRb/wed0nqALThj17Scg7X++B
         QPIB2D0rAUZ0S2cMV1tRxbDY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E49E040E00B0;
        Sun, 13 Aug 2023 14:19:51 +0000 (UTC)
Date:   Sun, 13 Aug 2023 16:19:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
Message-ID: <20230813141945.GFZNjmgZbHvMhLYtJl@fat_crate.local>
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local>
 <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
 <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local>
 <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
 <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local>
 <CABXGCsO5=tEB29apcnPRF92yLQR-LD--vSGYPfLWAm0Z+++HRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsO5=tEB29apcnPRF92yLQR-LD--vSGYPfLWAm0Z+++HRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 04:38:59PM +0500, Mikhail Gavrilov wrote:
> Too sad, this means that others must also face this problem. And not
> everyone will know about a possible solution.

Nah, most people search the net and usually find the documentation, as
past experience shows. In this case, they will find:

https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html

It will be there next week but here's the source:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/hw-vuln/srso.rst

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
