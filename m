Return-Path: <linux-kernel+bounces-55421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768AF84BC7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA23AB23604
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C5D536;
	Tue,  6 Feb 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA/jIoV0"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19F12E68;
	Tue,  6 Feb 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241720; cv=none; b=LVWavspX+H5s40yu3ygFJMiGOkYzYYhj23e7EK7x9Os3+pwzheV4Vo2VD0Bo5dIPq3D270VVow9Ti/IVjq8cCnmsLMMH7VLMyYN+/WVxn0kByFsrwAZj9PKsD3CCfbwsSUbK53xGGysxUQ/7XyGC2D/IcUehltqfJLsElCeSa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241720; c=relaxed/simple;
	bh=j0zD9gFLpDaXaJbcOjoS2R/x7tRjwLTTsNmLaeDslac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJxMSYiLb76DIU9iQ6GNQ2iAe+QyQ3eUDYdw7dqUqlo3NywkBtjQFGlLscb4hW7rWGMCs2KxEF6WB07HIpwfSGU2rDUnYAGrbdlOcYV93SpapJfqZ6j1+h8oz+yl7JMFfT53JTpGk4BwZ+quiB640hizKUXXfAzb2GlJTgdN6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA/jIoV0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ff812442aso2948435e9.2;
        Tue, 06 Feb 2024 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707241717; x=1707846517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTtEBYn5HMxfoNFDDbyP4zpk1ZUKqPIq9B1e4+8nGHE=;
        b=YA/jIoV0y4ydO9DFH4xUebNq8Mih4g+ekfeaqLJb0kwWfI4AHqNN3rWR5vxGRwWSwv
         7SATDT9VQoCj6lK3WRLN5XRWI6Q8pqu5otPLOJDNA0L84qcibEtFZeiHGKg4X+udRV5p
         P3q5VtsGvXwNW+6HO5KTH0zFGVhRftQG6cjjDCrRMK7jgLr4SmrUfDJkGiwIOZEu8ku0
         3QaYLfHnr/aSRlaW5q8iy62G6PaXikwRN2SN6qT2KfiAzoVetDy2TXWdNTI9F4U86Ib3
         iQ+0pmgNW5844P69YcD4HR2iCZWkJi8fHKRKJAgncAW5fQDTM7ftNrQkJxpAl49MrRzj
         9AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241717; x=1707846517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTtEBYn5HMxfoNFDDbyP4zpk1ZUKqPIq9B1e4+8nGHE=;
        b=G7ZTzijhAA+ska6oBoouhn0A9O6NtblCqpVSuCMJdbvUKwvmRxjXils0QzH7HaW4MD
         wjnywlCB0fyPBbVzbZHyD2wVPQpIHCdHgxa6QW6ShZafhcE+ZO4TkqheLFevY5HhooHr
         w/jKZgjOPCQ6agDPiX/agfk+uH7O7EJPFlUytiWpayuhY0Nf8JyTlmLAU66LIuoQLXn9
         gr9THhaDSw+sKOjWcNCoB0nZfVYhj82MOvcWbKi1opPY5eaBV6OK5FBPXhsuS8zea8YP
         K6DRwhda6PLdmQ2rMzZKECyYFXEswHl+Tz7E81oqGfKbQj/p6x434OtsHqIhu33TLwMD
         LGJA==
X-Gm-Message-State: AOJu0YzgYT1Zo3gnXEocceEXA3Nymm+cWktSm7uXYP2n2SxknvoCveeQ
	gbYblToDLwxBPdGocRAd/5kBKe/rek+T3tVuPrr6ujeazkzSsNfW
X-Google-Smtp-Source: AGHT+IGOnCyT6CBuMAN3BVwvf9J0QHYMBB9K1MogSD8lzJNn9y3SV+aiYmuCQulFXmj2KgBEPaPtWg==
X-Received: by 2002:a05:600c:4f15:b0:40f:e4d6:7ef6 with SMTP id l21-20020a05600c4f1500b0040fe4d67ef6mr1276507wmq.23.1707241716697;
        Tue, 06 Feb 2024 09:48:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWdx42vPGXJ/UEcn9lXXuP+0jw/EUKC2rpCpUtPkQ4Fiwux+9S/V1KU1MI2bX8wdgVppO//VyQkqtrjdMKXi4s6WvbjdAOC1ZZixK8yOt78/+MMj+DnG0sVRYj2LJ3L9dFKYwzmwslBzyYE/43phc247FZXJCzG6dCgU6j3I01lxNQ0lKvah6lLudHCAvafWniUcwv5SNDIfcFvhoV9KLM50G7BuOZtIvPTgi002AHSqaO7RTcMLY9eaxWf2crnQk81B8w7W7tk/N+NMOU9+oHEeVmQxDW0lx5bXSGYjx5NiuXT3WsqLEdNwR2UOxpvoO2MpydAdczy3IPD14PWJStA2BokxP8jpDF0I+kaHCp8bXNYRxyoyIk+cfvtusUoESNzqbNafajLKpGCsXtFiIoj+7rW3B35EBtsJEIh13DaTkN3zSB1vjk3QRl0fKUImNqa3B3A8e0eaJKWfp6C4sDuEP6jDbG7oAu6BYCdnPfhmLfm1q6vgeKQUV86ycihD6JBoRbxD0nFPuel+OBULxMc1+ToOo9nDeIW6Fwv261ehn4nlwUWMh4aN0HTM73B6TRMKeluIrUSVWcnV+O6b2VcSFon4z43UTsF0xhDP5eYEozSy0BeeIseemxTXx9fBx8xqTIXlW+2hcBcCEMikn4uOuFHit98KI/LR8Ier6jDA0aP4HwbIZ2ftD0cpVO2OOjg6sUXsiCV1F1Z+FYAFwgbTXvqsYd7Dwee0EDTro6KPMuwdaFwvvChv9hyke/RjMJk4MpJNAwRPw==
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040fcaec04b8sm2676064wmb.22.2024.02.06.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:48:36 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH v2 2/6] clk: sunxi-ng: a64: Add constraints on PLL-MIPI's n/m
 ratio and parent rate
Date: Tue, 06 Feb 2024 18:48:34 +0100
Message-ID: <2922005.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-2-96a46a2d8c9b@oltmanns.dev>
References:
 <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-2-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 05. februar 2024 ob 16:22:25 CET je Frank Oltmanns napisal(a):
> The Allwinner A64 manual lists the following constraints for the
> PLL-MIPI clock:
>  - M/N <= 3
>  - (PLL_VIDEO0)/M >= 24MHz
> 
> Use these constraints.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



