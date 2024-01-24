Return-Path: <linux-kernel+bounces-37066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE583AADF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3702B1F2AAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B00277F07;
	Wed, 24 Jan 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdaHa4OL"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148CA48
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102738; cv=none; b=X/Ihr8Cr81ni6pw6vKLxRUddv5jKtHOlg7/QkSzUhobj4RY/jCjpOcMJYGHWmiOXkicRFchKUrBKpUMKhEYXken4DnLQNMYFr2eCuZJQ62MEXUtY30cGJiUNcmDKoi4O9OJjKPc7fhPFukOTnRJlsMfbrm63Fj+Lv2mXNnxWLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102738; c=relaxed/simple;
	bh=7zah0DOTpon6kBDXk1RtXagUR60WInE/OpoPBqo429I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAMcMWEsDvkwlQJUylR71o8p0GVzqxWZSXronB7t9Hsn8wiR4EHGv7a6UG/TwjA1z+swBRqAyECczoDrjH1EIxvrFlmgIXrG0dIHHTCa8urUZd45bnheqo5uDba4yMUmAn31oIU4B7HxvUlZa81T+Ba+EXkjqosPN+2hIB/Ku0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdaHa4OL; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-210c535a19bso2759841fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706102734; x=1706707534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yu0JA5DFgFaU5CwNCOFmY77G5L3S5T+P8RtJ0zkQaJo=;
        b=EdaHa4OLQw3FsXCYcTFMQekiPtg0oaJo2A0lUiFJJSgkuAWYDmoxTsfypCE4ZvDECc
         u47fVEySP+DvvJte8m5ejdQnSdniP1IE22K1G7sFClBc/6eRNeJKl3fHrBziEtH/IOdY
         OMCXTf/gj0+evOUQqvFnYPZdia3N2icMXbFV7+dJPUbJ5MKzbyvGsZomCX3GuK1Gtpe0
         HCQAyp7UvKqFIYZjN6OaoHoMN7oIOd++EyjdEqiVWYOZIw0/M9grESYz9s4hnSr8cRKB
         LIacX50kQjOgwZRia6UDRzycrcKZQ0GGShV1Lp2klDHVlLZfnnz6yuUpu5es77L07UOx
         WVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706102734; x=1706707534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu0JA5DFgFaU5CwNCOFmY77G5L3S5T+P8RtJ0zkQaJo=;
        b=gG/EZLVkRrdcjGNtGVOUH6VxDH0qmgRijkRiFrVSX6xVMk5plACns/68snswHXLoYk
         8ACgxyLqkMVRBNU3wYaPnbPd2SgAL3SJdOHv3ZQ3M0diRZOQgZyc39XP7MR16L0SR1lJ
         nHG6GJaSGWDAApvosxQfj3hHlgJUedNidVAqu5wGlMP9j7M45bBmB229/x5HuXvo3atg
         pkcfZEFDSOh60OwU06IKkfw6ryFEmoIJqmMbmtMvsvNBOTQ53vq5XqlTDArAmaurt1hF
         vvPLx4Cez4FY3IRpHM32MKeKzyIf02B1IZSNdTFcin3nx/9whO15zTVpAkwEJBuriJr/
         CSTQ==
X-Gm-Message-State: AOJu0Yz9cX2xel401tHtD7bW+eASfEoC7thO57q3ucmgXFzc58EgNT8s
	vwfqqvXtyI3KxYsRqq8rHrsrMEUMB57htbVLT8AUU6/NLqhh5dV0D4cSAZcQeKGEC4vMZhSGveI
	DxBr7GafQe8Qx5PzuJ02XMYE0KUc=
X-Google-Smtp-Source: AGHT+IEW5PoeqcIOrC1/orXHLsWdUYhfJGnZD6id55p9vFC93T8lqRhoeEsyoAC6IGunPwnO9Pt1AivCT/dXiJQh+yg=
X-Received: by 2002:a05:6870:f208:b0:208:b33e:7 with SMTP id
 t8-20020a056870f20800b00208b33e0007mr3261589oao.19.1706102734254; Wed, 24 Jan
 2024 05:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de>
In-Reply-To: <20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 24 Jan 2024 14:25:23 +0100
Message-ID: <CAH9NwWdohzT=3asJVGWJECDKRxguXRRr40QsHJYecWibT75Agg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/etnaviv: Disable SH_EU clock gating on the
 i.MX8MP NPU
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mi., 24. Jan. 2024 um 10:22 Uhr schrieb Philipp Zabel
<p.zabel@pengutronix.de>:
>
> The vendor kernel sets a previously unknown clock gating bit in the
> VIVS_PM_MODULE_CONTROLS register to disable SH_EU clock gating.
>
> Import new headers from rnndb for the definition and set the bit
> for the VIPNano-Si+ NPU on i.MX8MP.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks - series is
  Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
> Philipp Zabel (2):
>       drm/etnaviv: Update hardware headers from rnndb
>       drm/etnaviv: Disable SH_EU clock gating on VIPNano-Si+
>
>  drivers/gpu/drm/etnaviv/cmdstream.xml.h |  52 ++++++++++++++--
>  drivers/gpu/drm/etnaviv/common.xml.h    |  12 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c   |   4 ++
>  drivers/gpu/drm/etnaviv/state.xml.h     | 101 +++++++++++++++++++++++++++-----
>  drivers/gpu/drm/etnaviv/state_blt.xml.h |  20 +++----
>  drivers/gpu/drm/etnaviv/state_hi.xml.h  |  28 +++++----
>  6 files changed, 174 insertions(+), 43 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240124-etnaviv-npu-627f6881322c
>
> Best regards,
> --
> Philipp Zabel <p.zabel@pengutronix.de>
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy

