Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D277F1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348760AbjHQILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348870AbjHQILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:11:37 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92933359B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:11:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A41E40E0198;
        Thu, 17 Aug 2023 08:10:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dsaLMhCIx1WX; Thu, 17 Aug 2023 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692259846; bh=KosVJk9TqczkP8Tl2l3dW2XQ5WUolMhM7fcHi7ojzPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU5ypwRfFRuvhSlxCMQUekpfoB5WweTKuJm0mBQoPMOQWdP4n0S9YrfgpFjmKuk1P
         QWNXdhccvBmrtDS8jXal1WRQ6Cs6ARpOOtfRuyO8bSmMRLWlJYmAWF/EKLPgsOov8s
         ESaeKMmD/bIe5sQkfrJ4IaDthABIwkc1h+ow5MIZoCmegbEadDfll65SI80znjUSRT
         aaUtq6C/eRKqayz7C+4hl0cySihMGitBO03J9Eh9pvrauJJRvRCKlL7weImJu+nImm
         tdqMkMVhK/ajM/RTvuEPMryu+LAR+ZfpxRaxWc/VE8L0pcbCL0ujTzZ2xTngCtnWfp
         BEOB3tCNijR+xS6C1XF5YLhNmGAWtVFitaSiCoq533MC/U/mm8oMyyR/nbquY0BJGu
         JB/cfcqAplTAsvaJHEgUmboiXtHcoZ01qJABEGFca8FEtrO/Vqx3fLFnHF8bz9II+a
         ZkpldKqr9hYrjN84jg2IjvzZ9EPw04f3odYZq6pghCoJPjwqG9DcXGoKoCEeSLKly1
         neUnP07G1Qh5UeawHGCrMz8Gr0BUzcDtXjC8FP0mFNcnvDyTEEJm/Ta33/T/af/4uN
         /pkmFrLYGksUf8qL0Y9wwnQZObCJ/scvWds7wCM+ttEmamootGP4i8yb0mepHSh1lm
         Mb1flELPwQJNd3aXYSOP+ngc=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B8E340E0140;
        Thu, 17 Aug 2023 08:10:39 +0000 (UTC)
Date:   Thu, 17 Aug 2023 10:10:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling
 of nouveau_connector_create
Message-ID: <20230817081032.GAZN3V+NQ1blzQC2sU@fat_crate.local>
References: <20230814144933.3956959-1-kherbst@redhat.com>
 <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816145338.GIZNzi8o3d9x9bcPzX@fat_crate.local>
 <CACO55ttasKLxBTmZjN-XBOuJFC7rng2PbLgxCT8WT6ukOZNGzQ@mail.gmail.com>
 <20230816151252.GKZNzndDNySuWC+Vwz@fat_crate.local>
 <CACO55tunC5mEu3Tw64rKLqNM6MN6d=N90kYQKYwXWNMB=ahDaw@mail.gmail.com>
 <20230816221353.GXZN1KIXloRn8cGt5E@fat_crate.local>
 <CACO55ts7430tAUDC+0qY0EZ5ReO=2Rjwj1SzHaBLodmyBgrUrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACO55ts7430tAUDC+0qY0EZ5ReO=2Rjwj1SzHaBLodmyBgrUrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 01:18:12AM +0200, Karol Herbst wrote:
> do you have one of these? https://en.wikipedia.org/wiki/DMS-59

Ah, DMS == Dual Monitor Solution :-)

Yap, that's exactly what the GPU has. And the Y-cable is 2xDVI. It is
a Dell workstation and it came this way, meaning I haven't done any
changes there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
