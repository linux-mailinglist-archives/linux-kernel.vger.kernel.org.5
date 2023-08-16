Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3177EBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbjHPVap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbjHPVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:30:41 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630D2133
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:30:39 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7654C40E0197;
        Wed, 16 Aug 2023 21:30:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KyupikoFfpUa; Wed, 16 Aug 2023 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692221435; bh=rlYgRmCUS2irsIxRfkgntN2wZ0XiiGJ2sMbQRoRmsKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2rktd2MOutaZNCZqFdy2YmP94UwtD9kHQo4h4Wtu4/uIo7o78C6LK8EzWLr7NdC5
         vpfhOn7inHNFx8wBpMZHzSbcX9WF+7HL+S9099hUlujNYg0K0lNOANs0GN6GHx8rVa
         vJdZ7VfzCJ7EIzPAkQvFtQ+/3SYV5xWhM7MOu8sMlUaMpxkIGU7PsogAcxbArNX9v6
         ZkrgwrHT0TeEFFTLbCaxC2A2sCmooyTK0suhCJ815f1dybh8ubj3zc2a6GAkfcmcNo
         7uUX3CTnR/uHAh1j9NBHaYGjNcfQ4I8PntkM/xkl5Ymt689ukSsj4bn2wCvcpdSLSu
         +gkcDRe6ayM5fi0voyem7KSNGsRHXwYhu06H4HPD9G1CPUDTkcZhtHc7RelnYDoUOz
         ewLL+KQoLpve9wnvkrHVIIo15GksHolZBxESh0O7MV2gd+eyeVs4Ah8bq6DlYP9UsL
         HRTG2wE5rU+B4XXHrz3RNQXSebZbIWO/zFreLQ253DGhC/zHvK+QTsAeT280OpcYNE
         hJzrM5bZcloZrCehbGe/WWnL3pbaHxYn1tWTPmPWIJhDkuwjTQjAhrFh97BN+cw0bP
         BAw5oL1hoE4UX0CGNXwJriPQL2XROEbI9WtIIFJ4WltwNfziV+AKcLg2Szu56PBh/L
         D4mR8TBn1wIFMX7nX/DwVIxU=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DE1E40E0140;
        Wed, 16 Aug 2023 21:30:30 +0000 (UTC)
Date:   Wed, 16 Aug 2023 23:30:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jim Mattson <jmattson@google.com>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Message-ID: <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local>
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com>
 <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:23:52PM -0700, Jim Mattson wrote:
> Specifically, "Security Version Numbers (SVNs) of the currently
> executing platform firmware and microcode."

Yes, I know the microcode revision is part of the attestation. 

What exactly are you asking?

If you don't state your question, how do you expect me to answer?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
