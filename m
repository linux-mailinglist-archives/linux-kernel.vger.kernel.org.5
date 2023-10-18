Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D819C7CE8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjJRUbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjJRUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:30:48 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6F1707
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:30:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E359A40E0193;
        Wed, 18 Oct 2023 20:30:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YEKlIWsWXDRJ; Wed, 18 Oct 2023 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697661017; bh=4C30a8rQS+V0ME+vB94Juw0kFJz6JAduzH0ZiNJh7E4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0Nkq3Ten4wXflZEmK+BRNNGLeUryPXa8cROtVvx5CP4xQHDz2E1mt5UeQ/91F9gk
         DgD9DeJ2xRDgWeb1Gp6O7r5bferLQjcBLY9oOwjiZjmGD7pYpXtS/n5cnrBdQCfNuQ
         285sFqXftw0TRZpz8CUX5I8/4wOlpmUcOJvwMq1FtBFw9lFV8C/pHw55SJm39kX3dS
         gEAKOrRWKqKLCfH6Dq9jRBZPNVROTVTYd9CC/1pwTI5ykWuQdmrkO33CMFakr/VTOv
         wb6GR/YBxHp8sk8D9MzCRP4+i+uzH+/1gzRA3tHJXJ8HwMj59BbXxYXMOk0R5a/11a
         FDcguPASdb9GAnLD0fhj9tPgCHzrsRcVUqZr3etTvgmnM7SUHxbL3LnU0wUm91sC5m
         4fVOLKeNrqXaZ4V74F1dDD/vzNEsKEhBqy5Nm+FYA9D/6Mil3fBks9F8pYxt+koJHP
         F6xPgeJu4kLBtPwv6SowpiNB678eWJ2OSYMoU2DciOshAtlyB0WTvQRlGnyfqN2Y2g
         tM5PCuL80xMSqrv3Nwut4wfYeBfbjYEJNmhqJ+MTWtzwFML2bNBgqCR6Q+ikSFVFO1
         8UpRs2zigYll3p8LlmBUJ/XEpSWVmHIOuXWgS7ZMI5DLg8Cyy+kiQMgKg9ALZNyc1a
         jXac2EV3qg4KswSd2XcQgKtA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CC9640E0177;
        Wed, 18 Oct 2023 20:30:07 +0000 (UTC)
Date:   Wed, 18 Oct 2023 22:30:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH v2] x86/mm: fix pg_level_to_pfn for 5-level paging mode.
Message-ID: <20231018203003.GIZTBAS1KUpS7nk8VH@fat_crate.local>
References: <20231018190626.445926-1-Ashish.Kalra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018190626.445926-1-Ashish.Kalra@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:06:26PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Add support for 5-level paging in pg_level_to_pfn().
> 
> This issue was found during working on SNP guest kexec support,
> this helper function is used during early boot stage for setting
> of C-bit on the PTEs and additionally need this same helper for
> switching shared pages to private during guest kexec.

How to write a proper commit message:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
