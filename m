Return-Path: <linux-kernel+bounces-43895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FE841A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A451F1C216B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83D374FB;
	Tue, 30 Jan 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gLOMxG1p"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A575374C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585067; cv=none; b=iesoA1ThNz2nzeKdLqyzXdCpoDdMVRWBrX6QP1LPYOzsWejl2CVIN+WL9y5EZHaXGX8wyWhhXGd9A3aqYnJta6XOVs3L38on5ThNAgE+oeWfjZflChXe3VwH2ASOMpRa7Xq4qWpF8+qGwAhLZGvFTf/LdSVLpLnSfvVS8i8Fma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585067; c=relaxed/simple;
	bh=2+uQW6vtXQgsn7x7dCsjLPIbYKGMAsogMteK1KvP9Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcC/PEWJENKEB3HVZogh0oNT45oZXuDgdNhY5l0b5oe7pTmxOJRLV3xel7zDFyVoi8RsBllJrtyTpETSt3QOtRiNZ2mk2SfYTmjcG5TbMf9IT0VDyh+y2UXoeotCfPhZ2VPBkLksXqfNKNeQj/M6+36tylNIvcsbbUzORt71Qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gLOMxG1p; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso4259827e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706585063; x=1707189863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTNL9ohxLrANr0wy+wFa79m7nHa0bIs2wMJPrxNz1A8=;
        b=gLOMxG1p1U8kfUAIDMX876l2OQ+xEvomSl3ddD9B9WdjGRw4vidZYoAG8sxoMfJVB2
         p19BNQtz/sIaGbKn4GgrSn9cp72fPhbFFx8FOglmt+mqcfxVzHRhJVwqiMY2ZNzQAWeL
         9Hxrv13pCd+PWZmmFffIAXUAI0vHqVCbLvfww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706585063; x=1707189863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTNL9ohxLrANr0wy+wFa79m7nHa0bIs2wMJPrxNz1A8=;
        b=UzoIVodXpN8Ybt3T4zOBLpMfKD2HivvYJh40WM2SegiMSdb0xXCOQ014iOX1cEhIcb
         CdqlMP/FdMcT01p9mmal96Ca9swBG9KFMWjFnIp6pqd3LEoa50gmn4avAN9BSWQKdiGO
         OU9QCR2DArvLWIppAGhrNDckmyf9E9psKAlSnW5ycctzE1rX554PgMl0aRrPAra0+9La
         x3RJ8H4OX+yo533bT47R3+9jEyMLhQ1snpy+nXijA8r/4NRKbuo1zG+bI4GP1lgZBopo
         rl8/hmSb1eacDoKnKXNfdr0T+qoakfnFhsS/uezT8YNlWxuUZmcFo6NKUvrFv/K+qiyG
         kHDA==
X-Gm-Message-State: AOJu0YwOokHw2lRgo+Xag8kQ/yia6OBOnJWw5GqoR4Mkq3yXKEF4G7d/
	3pB1BF3e5tBlHGCei6CZUvFX5nj3V/TevgFlYwZtoKss6eUGb6Mn9GH93b8q+9tJq7dXbUfkieC
	ii1Sl+uwhLWAsh1FfPNhjsS36ofs2FyrMi2PG
X-Google-Smtp-Source: AGHT+IHasIeOeQNhmIgzA0J3oP+hkDAX7iNew/UQEnuWH9J+d2zxww/qMxouAz63r8GpwRI6Q1usW0Rn5MblFlW2xIM=
X-Received: by 2002:a05:6512:401c:b0:50e:7bc5:20d8 with SMTP id
 br28-20020a056512401c00b0050e7bc520d8mr5731043lfb.4.1706585063646; Mon, 29
 Jan 2024 19:24:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127084258.68302-1-eugen.hristev@collabora.com>
 <170652472373.127352.5854831299483160743.b4-ty@collabora.com> <282822ba-0e96-4078-a807-4b0b08e42014@collabora.com>
In-Reply-To: <282822ba-0e96-4078-a807-4b0b08e42014@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 30 Jan 2024 11:24:12 +0800
Message-ID: <CAGXv+5Em3HUJV1pv177LUwf9iMhKSLcGhVAt6ON9YZMNaT2oZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: media: mediatek-jpeg-encoder: change
 max iommus count
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Drop a bunch of people from CC)

On Mon, Jan 29, 2024 at 6:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/01/24 11:41, AngeloGioacchino Del Regno ha scritto:
> >
> > On Sat, 27 Jan 2024 10:42:57 +0200, Eugen Hristev wrote:
> >> MT8186 has 4 iommus in the list, to cope with this situation, adjust
> >> the maxItems to 4 (instead of previous 2).
> >> Add also minItems as 2 to keep compatibility with current devices.
> >>
> >>
> >
> > Applied to v6.4-next/dts64, thanks!
> >
>
> Sorry, typo: v6.8-next/dts64

I was wondering, what script produces this email?

AFAIK `b4 ty` gives a simple thank you letter without branch or commit
hashes.

ChenYu

> > [1/2] dt-bindings: media: mediatek-jpeg-encoder: change max iommus coun=
t
> >        commit: b824b32dd5e98221cbe2e8bcccc6fb4134e35fc1
> > [2/2] arm64: dts: mediatek: mt8186: Add jpgenc node
> >        commit: 4c5b46fbf52d52b0f392f0fc3913560bad438e49
> >
> > Best regards,
>
>

