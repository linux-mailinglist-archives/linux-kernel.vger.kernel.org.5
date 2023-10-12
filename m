Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5E7C70CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379138AbjJLO50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJLO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:57:25 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251890;
        Thu, 12 Oct 2023 07:57:23 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F3F140E01AE;
        Thu, 12 Oct 2023 14:57:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TD9AmtNuADqb; Thu, 12 Oct 2023 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697122640; bh=PpK5JSEHjxb7R7cDU1Nxot7FcmI5ydv5LNHuTP1O7kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGsfjGQYq9BpJs0S3tYqiajR0dLtJCe9Ar8jKuayjP1hUMsXRDtq9Ev2vKefOPjYF
         3hsAV1okNqgrTY10X2asDVBKCBsepC7RsK44CV1qsjOvMZywtAhJPB3MCJggcQgig+
         7bBHXc8Gs5syCuoCD7uKWOB4Sqe5oAdXWsCxRGtakGKMZUrGjhmrsMbp5WaxK8DbFI
         0r63fieVNuVmSzFV8Y5OILZMob7deh8AjdZ0IFThn2Lu7XDxfHNOt2tFVIMq2SAh8u
         Knelkc1zFZkoqy0FO6D1jR4M1Y2rmtPu2vNQjfbfVohWzf2b43QAsTm6GGcJlMxJm2
         HFFuTLeYSmhBECsZ2qbkxLRTpMiKGPQqZloQc5ScXw40OvpA3v1q80w8iD727QHTXD
         fCULMpC55ZZd+bVEGxaSpKTVoVMj7NHASwRDX2Qc8w/j6lG4t5yfIXtEK5GjzNQD2Y
         j5Dzc/fyake0gW0uE/3YJFaPDmWSUkOjhUm87bGws41PrC8dOpXlRHSHiuWcV/vbla
         ei9yA+AuL+EINxbsBFu8a1HAhOJlSfdJpTAtKHw7XaiVTtzZn2EwaNV8YAwY44N/+A
         KFkqLut1LYk/0veEXSt3qDGITVdwZUKlY5YEwHk5Bs/R5PU9B9LprvnzdwcJ9T7/XF
         egd71noOhoqak3pcRqaYnoaI=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FDAD40E01AA;
        Thu, 12 Oct 2023 14:57:13 +0000 (UTC)
Date:   Thu, 12 Oct 2023 16:57:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tony.luck@intel.com, naoya.horiguchi@nec.com
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid
 the capture kernel panic
Message-ID: <20231012145708.GIZSgJRIRq8OSF6UaB@fat_crate.local>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
 <20231010082836.GDZSULNGto0cPRPU26@fat_crate.local>
 <3f9e9468-ec74-42ad-8d42-c3f6fb8b5f74@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f9e9468-ec74-42ad-8d42-c3f6fb8b5f74@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:00:57AM +0800, Zhiquan Li wrote:
> Aha, this is the neat thing about the patch.  The main task of kdump
> kernel is providing a "window" - /proc/vmcore, for the dump program to
> access old memory.  A dump program running in userspace determines the
> "policy".  Which pages need to be dumped is determined by the
> configuration of dump program, it reads out the pages that the
> sustaining engineer is interested in and excludes the rest.  The de
> facto dump program (makedumpfile) already supports to identify those
> poisoned pages and exclude them a decade ago:

Yes, put that in your commit message.

> When we were developing the patch internally, Tony contributed a lot of
> precious ideas and guidance, not only the code change he mentioned in
> commit message.
> 
> The previous V2 sent by Tony missed the merge window of v6.5, so I
> re-based it onto the latest v6.6 rc, re-validated and re-send the patch.
>  And I will follow up the feedback from community.

Then you should ask Tony whether he wants Co-developed-by:. See

Documentation/process/submitting-patches.rst

for detail.

There it is also explained what an SOB chain is and how it should look
like.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
