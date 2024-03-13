Return-Path: <linux-kernel+bounces-101619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3C87A984
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8AE1C220A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A7443D;
	Wed, 13 Mar 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z1dchkgn"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C94696
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340395; cv=none; b=C6iMdJYe9Rc8Ja4iURm4O4vpjX/gx0RH/vkLbTc1GzKt3jSc2aXyyxCN+U5p7+qF+vTy13jo8zdpWccvxoTfftGEx0p5pYNojG2XgQbrVWUv4BwHQRad5y1gEqB4+taSXmbOG5JQE/lGtv4BbLfZutAHPcfT5yYpNvqaTEvhC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340395; c=relaxed/simple;
	bh=EJQw2spgiDe18SYH9zz9HdonKRBjUkfcO0UXFy36YaU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXHjOGKJOKov1OLJQUqG+AllO3Om0uxkFWbY9W0p/Pl8PxqcpkR83GwvP8xGuRaXGa5/O2ItVJzy/BM07lVrPudHHUhF77JpXxBeG6u68u3iy+MEXwkvENyMQdQAJya2RkzwcVLmQHyVOf+GgHu4IxviLpq7Tn4DQiAi+Km728c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z1dchkgn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso105952221fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710340390; x=1710945190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frZJGewZzeJ3uIeDRmngnvwGZFXy0aAqB4wzRWvuYFc=;
        b=Z1dchkgnh7guU0VhT5i8Rt8m6rEQe2+vQAjwdhwOkohdBA60XaGbR0V02SmgZtkX4C
         TDi+q9BC9NIWmsU4YCzJX+EilbNUjVz8KvHdveD6M2t777RVg4lse3fQI9LjQetHEsph
         mX3LRwES8O5BszbWZ/6XRcnhyzuEwU7nr7S0a/TwXjnEcK3sswWMksaQTWofBthVfr1m
         nzjPBHMVGOSgU/IYI0D3AHbjWPbBb34Bk7vIMy1CKDwfFDvwenv00wQyYy6DqO5Dqr4e
         tu1a41Z1uK4vvsOz15zqhJ2TFub+EUOYzSBOlW58M1OfwffIym45wBQ5WLMwZp+XU40l
         nhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340390; x=1710945190;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frZJGewZzeJ3uIeDRmngnvwGZFXy0aAqB4wzRWvuYFc=;
        b=NUbH8ICJnqLAVzRyCgp20BA6yF+68C1ye118Ie8PI0/7PaXQR5v/iLATur05K7X1VK
         d0HDjQLVOAIyxs6IjhwI4hrAVvk+p/4SK4yCLI4H44SawYbN1eVdJP1kuZKwZhaiGOtt
         lCfnGalHiGyy9iqAmsstYBKM/Umbjrx3H3cBRCWWXCTJJGxj9MtvWcXqiroOIhJaiGxK
         GGa7wbjc+dRbfQP6hGxAkQuhOy/143TsM/3OJ/QcmbVGc7HMp8oouWkUKuCMXB6dyePY
         0foRtmV2xGjYxEUzp71ysECyXSdriJDerMKe9/M+QW69Rg1Uy3fGdWjCElw7JIUAbO4A
         ifMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCYnVtVSeGJNISUbYDIgEXG0PTO6vaGf8Fcb/SbvRqw2en5HagZJEvmF6+/0AomRD+ZW9nA8/EhMNZbfFmgI1RW0hhiO870e7COUbm
X-Gm-Message-State: AOJu0YwXzKInhufeVlG5R6xtbAXjmihRWVe7fvbMYz/Ghh52Tv5K8by6
	5m835vYWwSzgXDRBGbfs0PFX9MgYtECySq4JPF4PLC91Z8F1k7MBJORACE787fk=
X-Google-Smtp-Source: AGHT+IGc4/OG230i0WuTH+DEgo3X/n2bWgA2QDnELN/LQ+c+BqGPSX+yI/RIu0rb7SkOm+km48FmGA==
X-Received: by 2002:a2e:8e89:0:b0:2d2:d449:6425 with SMTP id z9-20020a2e8e89000000b002d2d4496425mr8400526ljk.35.1710340389826;
        Wed, 13 Mar 2024 07:33:09 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170906adcd00b00a46203a86basm3476615ejb.27.2024.03.13.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:33:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 13 Mar 2024 15:33:08 +0100
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] dmaengine: bcm2835: add BCM2711 40-bit DMA
 support
Message-ID: <ZfG5JLkcj4r-1cGY@apocalypse>
Mail-Followup-To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1710226514.git.andrea.porta@suse.com>
 <CAPY8ntCcz7ysTq_78Rb8ohLLETTYZeoZ3DXdPFvDLAkPc9jPWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntCcz7ysTq_78Rb8ohLLETTYZeoZ3DXdPFvDLAkPc9jPWw@mail.gmail.com>

On 17:16 Tue 12 Mar     , Dave Stevenson wrote:
> Hi Andrea
> 
> On Tue, 12 Mar 2024 at 09:12, Andrea della Porta <andrea.porta@suse.com> wrote:
> >
> > * Spam *
> > The BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> > to access the full 4GB of memory on a Pi 4.
> > This patchset aims to update the dma engine for BCM* chipset with respect
> > to current advancements in downstream vendor tree. In particular, it
> > supports the BCM2711 DMA engine in terms of extended DMA addressing to 40 bit.
> >
> > Changes with respect to the first version (see [1]) of this patchset:
> >
> > * dropped support of the new BCM2712. It will be the focus of a subsequent
> >   patch.
> >
> > * merged patchset from Stefan Wahren [2] to support newer chipset with a
> >   platform agnostic design, while also retaining the new features added
> >   from downstream [1], as follows:
> >
> >   - patches from 1 to 5 are preparatory, adding some features and bugfix
> >     common to all chipsets.
> >   - patches from 6 to 12 add hw abstraction
> >   - patches 13 to 15 eventually add 40 bit and BCM2711 support
> >
> > * fixed a couple of bugs from [2] relative to address shifting on 40 bit
> >   support specific code
> >
> > * added the relevant entries in the dts and DT binding that was missing
> >   in the first patch
> >
> > * used FIELD_PREP() wherever appropriate as advised in [3]
> >
> > * of_match_node() has been replaced by the more generic device_get_match_data(),
> >   as per [4]
> >
> > * fixed several errors and warnings from checkpatch
> >
> >
> > Please note that there is still a pending discussion around here [5]:
> > this patch still use the current approach (used in both downstream
> > code and in Stefan's redesigned patchset) of getting the address as it is
> > (dma_addr_t) and just add the relevant offset when needed (on 40 bit
> > channel, see .addr_offset in struct bcm2835_dma_cfg). This is not
> > optimal but still deemed as less hacky than using DMA internals (see
> > [6]). As soon as there will be guidelines for [5] or dma_map_resource()
> > will take care of dma_ranges, a subsequent patch will adjust accordingly.
> >
> > Since there is an ongoing effort from Dave Stevenson to upstream a
> > patchset with similar goals, I'm adding him to the email loop in order
> > seek for collaboration.
> 
> Please hold fire on these patches until we resolve the dma-ranges question.
> If the dma-ranges are defined correctly, then the cb_offset is not
> required as the mapping deals with it.
> 
> At present we have a mess with the 32bit DMA controllers, and need to
> clean it up whilst still having old DT files work. Fixing it up also
> requires fixing the DMA users (primarily MMC, SPI, and vc4 HDMI
> audio), so will need some care over patch ordering to avoid
> regressions.
> If at all possible then I would like to avoid the same mess on the 40
> bit controllers too.
>

I agree with you: I've just sent the entire patchset again for consistency since
I had an unlucky issue with the internal imap server that results in the patchset to be
splitted and to be *not* received by all intended recipients. I saw that you were
one of those so I apologize for the inconvenience. I'll wait for any guidelines
regarding dmap_map_resource() and how to proceed about that.

Many thanks,
Andrea
 
> Thanks
>   Dave
> 
> FWIW my work in progress branch is currently
> https://github.com/6by9/linux/tree/mainline_2712_rp1_dma_vc4_rc5,
> which includes my fixed up set of Stefan's patches, as well as all the
> other patches that need working on for Pi5 support upstream.
> 
> > Many thanks,
> >
> > Andrea
> >
> > Links:
> > [1] https://lore.kernel.org/linux-arm-kernel/cover.1706948717.git.andrea.porta@suse.com/
> > [2] https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad71146c@i2se.com/T/
> > [3] https://lore.kernel.org/linux-arm-kernel/YguMW8n1q0ZV5tKH@matsya/
> > [4] https://lore.kernel.org/linux-arm-kernel/1e71c153-e482-409c-b229-9b9c0662b67e@arm.com/
> > [5] https://lore.kernel.org/all/CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com/
> > [6] https://lkml.org/lkml/2024/2/5/1161
> >
> > Andrea della Porta (11):
> >   dmaengine: bcm2835: Fix several spellos
> >   dmaengine: bcm2835: Support common dma-channel-mask
> >   dmaengine: bcm2835: move CB info generation into separate function
> >   dmaengine: bcm2835: move CB final extra info generation into function
> >   dmaengine: bcm2835: make address increment platform independent
> >   dmaengine: bcm2385: drop info parameters
> >   dmaengine: bcm2835: pass dma_chan to generic functions
> >   dmaengine: bcm2835: introduce multi platform support
> >   dt-bindings: dma: Added bcm2711-dma
> >   dmaengine: bcm2835: Add BCM2711 40-bit DMA support
> >   ARM: dts: bcm2711: add bcm2711-dma node
> >
> > Dom Cobley (2):
> >   dmaengine: bcm2835: Support dma flags for multi-beat burst
> >   dmaengine: bcm2835: Fixes for dma_abort
> >
> > Phil Elwell (2):
> >   dmaengine: bcm2835: Add support for per-channel flags
> >   dmaengine: bcm2835: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and
> >     DMA_WIDE_DEST flag
> >
> >  .../bindings/dma/brcm,bcm2835-dma.yaml        |    4 +-
> >  arch/arm/boot/dts/broadcom/bcm2711.dtsi       |   16 +
> >  drivers/dma/bcm2835-dma.c                     | 1084 +++++++++++++----
> >  3 files changed, 892 insertions(+), 212 deletions(-)
> >
> > --
> > 2.35.3
> >
> >

