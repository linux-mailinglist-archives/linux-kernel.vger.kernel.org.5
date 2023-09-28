Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C47B2054
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjI1PD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1PDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:03:53 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF419E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:03:52 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C068040E00B3;
        Thu, 28 Sep 2023 15:03:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BXXeFrxH1MTH; Thu, 28 Sep 2023 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695913429; bh=36fJuoDKgrkFUfM/dN0U+p3MldqyXeYY9tSG7Iif6RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kf1d46P6NbiNXiz4G+rZbKB1yeFksa5OgxP/CUXP6lYZvbIbqXq6VLB4xVrcLna1f
         /ioLB//OjMPoYQ/Zx1f1lE87Bc3tfMvyBsxxncUAgtlcwrsdw9ppv84rsDuXptQV/H
         GoC6I4wehfYUYboDBdFYG6MTPeS98YBd5HYeUuUXcKja7p8OiRrdHNtchdCK828vR3
         1/CvqyLz/WVAFXpiEJBQSEx2hik1OLNZnN7wmk12E5N+Lkm+iwvXvKXrCZ0tP3R5Vr
         55tNkhM1e0tnOR8aE9b+ywbOWqJt/Y6kHY20d2qjwmEPOFNW6I1tT40D7pIFeX/Skr
         3E17MQugc9CmylNdXJBM4+2QHmEoOaVLRgg8UQ3kriKkxqir2Oi5Zv9vK0P0M/LkSf
         S7FbOsryyZPgs5YkHBi5Wqipndkd6BxY6Iyc1kheYuXE7hpZ84+fHxoWiMD9IAejki
         yb7yVpEpUqIgUcprMxue54DVw0uG4rxG5WZxeTrYNS900a77bkQ4QHXGE5ZzCH8CVG
         bo3npKOWkmYBdx2bHvfRhzbIT1qh7RXCXHzvoCk/uMvy0vMo/guWT6UdMfJBJe5lv8
         M5MIL8IoEvDsAM4YBJEC/j3f+3bfgbbf0eheGENNlc0znIr1y9sqT3N9bTUUKtPTqG
         VmA8e7GzH3TpSp7iffCautrc=
Received: from nazgul.tnic (unknown [88.128.88.93])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE3E540E0198;
        Thu, 28 Sep 2023 15:03:45 +0000 (UTC)
Date:   Thu, 28 Sep 2023 17:04:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpu/intel: Fix MTRR verification for TME
 enabled platforms
Message-ID: <20230928150405.GCZRWV5bjjUuWof3HQ@fat_crate.local>
References: <87il7xu7ki.fsf@jcompost-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il7xu7ki.fsf@jcompost-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:00:45PM -0700, Compostella, Jeremy wrote:
> On TME enabled platform, BIOS publishes MTRR taking into account Total
> Memory Encryption (TME) reserved bits.
> 
> generic_get_mtrr() performs a sanity check of the MTRRs relying on the
> `phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
> `x86_phys_bits' field.  But at the time the generic_get_mtrr()
> function is ran the `x86_phys_bits' has not been updated by
> detect_tme() when TME is enabled.
> 
> Since the x86_phys_bits does not reflect yet the real maximal physical
> address size yet generic_get_mtrr() complains by logging the following
> messages.
> 
>     mtrr: your BIOS has configured an incorrect mask, fixing it.
>     mtrr: your BIOS has configured an incorrect mask, fixing it.
>     [...]
> 
> For `x86_phys_bits' to be updated before generic_get_mtrr() runs, this
> patch moves the detect_tme() call from init_intel() to

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
