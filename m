Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E797BCDE9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjJHK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbjJHK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:58:01 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45EAC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:57:59 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C062C40E0196;
        Sun,  8 Oct 2023 10:57:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5arru0iT7ia8; Sun,  8 Oct 2023 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696762675; bh=X6ZMUHp9c0/lKZrCVID+buHxxwyZLP+KkA6PO63U5Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6qF9xC4LoGLKhyeIwWl/ySAyKDKERual4fweyCH4YsIpcIawySjtoYOmXZzCHKcg
         exEEbsU8L3NfxSxmb1EEK9PILPG4GlYYQc/bJZBb77vd4IP7h8fptR+zwI9B39IQNu
         8DuBqwRXqKfeOMXK18/qJjsW1DKwMm+8rhxDoMTbhhGy9UyhxhSlkNUK8UPPmpu0qD
         N2U7tfsa2vt4O1n64a71l6/PTpJuD+HaGeGi8dd2TArrpiWfMJDd9tPnB1ctIBZ00q
         p359fJ9gTmnyc7FafbxQxOzoHDZB4C3MIu6Pi88yY9qOawOlZRgXo8AUmcEiXIVQXN
         GfmpaxbjDS/cuYHWUNU8ncZ8hbgzHfwzl5TjsG5QWtA+WmlegvI2Zdg1Z9Y+OvlpOq
         CePjkZGjmeWKurDzrHFezkCGPZzc1V8XdnlOHBWSImq1Ba3nV+jBVY3elTBHQh14H7
         Ns53vQpS24RLrHt66UWmdgZOLQLOl5ukpXaCaOtOhkadVOTKdJh4sgGtYS9vaesxnQ
         NBpUMyiHRyC7wI/QpvA5nnwswi74B6fdjfjc40HQ5Tev7CQyZyNIYBc9tDvUNKhvDB
         bUFjxt6BXT1gHUkwU8Uukw/kGCu7xpKPu42KDLDyhWrIroEJhHZFmuh2MmFnyktMDm
         CafwVGZAJSJEdlGPIwHA4O2o=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1CDA40E0177;
        Sun,  8 Oct 2023 10:57:47 +0000 (UTC)
Date:   Sun, 8 Oct 2023 12:57:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Lili Li <lili.li@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] EDAC/igen6: Fix slab-use-after-free in
 igen6_unregister_mci()
Message-ID: <20231008105740.GAZSKLJMLfbiDbZlm8@fat_crate.local>
References: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231008080231.51917-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 04:02:29PM +0800, Qiuxu Zhuo wrote:
> When unloading the igen6_edac driver, the EDAC core wrongly kfreed
> 'pvt_info,' which was private data and managed by the igen6_edac
> driver. This resulted in a slab-use-after-free bug. Fix it by adding
> a flag to indicate whether 'pvt_info' is managed by the EDAC core.
> The EDAC core will only kfree 'pvt_info' when the flag is set to true.

That's because your silly driver is wrongly allocating stuff:

igen6_probe() allocates the whole pvt struct and then
igen6_register_mci() assigns it piece-meal-wise to each MC's ->pvt_info.

On the unreg path, you then call edac_mc_free(), it frees ->mct_info and
then you do wonder why it complains when you call kfree(igen6_pvt) in
igen6_remove().

You should do the exact opposite of the allocation steps on the unreg
path and it'll all work fine. Definitely not add ugly hacks to the
EDAC core.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
