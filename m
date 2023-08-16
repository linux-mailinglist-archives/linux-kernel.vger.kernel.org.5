Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2177DE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbjHPKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbjHPKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:14:46 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E839271C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:14:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA57240E0140;
        Wed, 16 Aug 2023 10:14:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NAfdHTaWTMfe; Wed, 16 Aug 2023 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692180872; bh=/jqkabeqa2xpX4msrJ9nDrEwixGNYwvNlIatn/h8eC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcUEqyQqEFahZHh4B2yxjp2TdD9a6MbGbEi35aBGD1zSKpCkOaya44OLruJx6B7xy
         3EUgPTrB8ItN5n/8yF4ICsLLUAAgnPTXRAlKvfNwuK20UYJRcLRj5YCAnW6zUDsh6Z
         ai+DCmdR22HW9upLvnBP6TfAXjm69eLG2gTGDHr8f1Pn/lE+8vyhez1mFZITzKZcFT
         VJiZz7MAul9eWS4XwPATwU6qUmtJcPbY5EppsqDEPhAUYeFaHf7wbiyMrZdczw9QDj
         dy795PFdR5hcow8wWhzpwNWQavgrP37i3uuxjoflzSlbrjAat4MvLTDCJ1p2DSVP2Y
         uW9MOJSLsqLiLBuWQOsPpQUuZCWoytITKxFyEMvEjCr7QdhxelFynO/dj0sK6z+cUs
         XgBkVdL2JBeJk/iBGfqp9xXjrI0D/Cp08FNy6ILZHQxu2vhvDoJqnp1cwvP8yU1cYr
         /Nai/WDyWABzYAFful816QEi49Mv+2woilYgHL8ohxfNr+GwY08tB8ghAWZzz4ciqR
         5cSITEgcaev7io5NYkZxUOpmmva/VQ0h0nDhQ8j8w2ad8n6LbudOwq2Sn+1BuKDghf
         lyLFxqCNm/nF/grJ10dxpZnQItJgWkZ8bxS+o6SGhYupj8ICSI9maz4AnQoJTp7uXn
         JQ6Ic+9ArdUdXY3u/m7VSNS0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 613C540E0193;
        Wed, 16 Aug 2023 10:14:25 +0000 (UTC)
Date:   Wed, 16 Aug 2023 12:14:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling
 of nouveau_connector_create
Message-ID: <20230816101424.GGZNyhgP6GpqZx9xi3@fat_crate.local>
References: <20230814144933.3956959-1-kherbst@redhat.com>
 <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
 <20230816100344.GEZNyfAIt0CJa+g6Sj@fat_crate.local>
 <20230816101157.GFZNyg7QARIL+io6m4@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816101157.GFZNyg7QARIL+io6m4@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:11:57PM +0200, Borislav Petkov wrote:
> Does that help?

Btw, note that this is *plain* -rc5, without your patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
