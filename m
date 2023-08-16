Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885E277DE19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbjHPKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbjHPKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:03:57 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075DC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:03:56 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EA9ED40E0140;
        Wed, 16 Aug 2023 10:03:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xZBDBaXCll6W; Wed, 16 Aug 2023 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692180232; bh=oHVGfQmdLztoSjvTf1LFJ+5NoFHy0dpxilKjS5Iw1vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=floOfcHckZfB6EmQGcU1bY0eevy710qB37uSuHVHdRSE/YmdhAwkCVj9b2S+WIMRz
         xMtpvhMWWw6TFsbjN/nfBWUxNZLL5zFIRu47ejORZThUn9ec9bC6qKrrlp6KWTRz9x
         f0p4szVPLH3VQXVg4FV95LMQXvjRq2HY+G80BLT81DjVfWBJXFGYEpHi96zPbw1rcv
         67csx543h6x7ySs0+BAU1sp07zS/imWSP5Tm4lVwP+ynfdGLfM3Cg3BnHAWS1soxsA
         FyiUJ6A27fxV8ddt7cZZbC7zT1rys2eoleIpaVgprPLLkJ9sUMGWbj/2Aq88bLzJeY
         KTFx/0nsoGNCNLH3pBvRT39kVY5dsr7FHaz9mcAZl1f/IaJyo1+kw3/YIWq/hmgzEL
         3S3S+hZcPbRXEbIkxkVhs5tSPOvghM97rxLJ02UNCeiB12TJm0hBw1VnC0d1H4szGI
         x/BWCRBk2ZDzCDkRLWUW/lfmIsXIb5EI1zcF0l6ENsQ3R3yvEoYdr23x6r/H2AHCn+
         yl8d4cp1aP3+fAAxJwrl9puIWL3P3lZa0RlRA57EgtxeTEDqwJVwDN7bvUtg1kErzF
         tT4NDQCTvOUxi8FO9oUEFYudxSiJjyWzKics4rA5SIa78a6zhEwyoKkgMjT1gjzFZJ
         2gevMpv8SARz2nguG+Wo4Qr8=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 867B540E0193;
        Wed, 16 Aug 2023 10:03:45 +0000 (UTC)
Date:   Wed, 16 Aug 2023 12:03:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] drm/nouveau/disp: fix use-after-free in error handling
 of nouveau_connector_create
Message-ID: <20230816100344.GEZNyfAIt0CJa+g6Sj@fat_crate.local>
References: <20230814144933.3956959-1-kherbst@redhat.com>
 <20230816093015.GDZNyXJ28y9uspb4Mr@fat_crate.local>
 <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACO55tu8ab-rxCzxFXbUh4Z=W9E-1f8sH6BVd=P+16dQ9PQNjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:51:50AM +0200, Karol Herbst wrote:
> Mind sharing your kernel logs with that patch applied? I suspect your
> system boots up but you might just not have the connector available or
> something? It could be that you have one of those GPUs affected by the
> original change and then we'd have to figure out what to do with that.

Lemme do the KASAN run you requested first. It is an old and slooow box,
the grandma. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
