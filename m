Return-Path: <linux-kernel+bounces-101230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C087A44C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA34F282977
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669C1B5BA;
	Wed, 13 Mar 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM2RGjQa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72D125C0;
	Wed, 13 Mar 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319999; cv=none; b=dqGVFRr3hlv9ULeV0nB4BKIsHajf5Pz3TUNWw/zT+74q+2HHb9BPdPLX7dgDP8Shxqy0KcQ97VcLihTSP9omNRKaB36IMtEaAU1FAIre40rIqIcBE2dbpHDiTUWw1rWEWZ3YlGop5MHd+qwUEPBwrDk7p3KP8YoucnPIQ1N/xBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319999; c=relaxed/simple;
	bh=a+rieUB3nCzUaqhZqKUxS2ElDgV7a9OYdadPfRgXx1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQV/dwNDb3hN9biJEweiAmJOCgWyLMVwr65OjUmRwujVzsJvg1VEbwjg0m87WpKaXhZgVB8p0o3T2wbehNOhjzwOAku82iHP0w3VuM3LvxmtDzqh+vpp7R9fcv6/PiqNrRnry6n7W1Tg5gIaucD/4uE0h7N2ni9Q4EazqacVv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM2RGjQa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so5173080a12.1;
        Wed, 13 Mar 2024 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710319996; x=1710924796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yweG9hIRFKQyYo1fdZnUFpZABdTF+shxA3D5c1UT5oQ=;
        b=hM2RGjQanKyHGkr1y+XokjOPQHbHDFiQ5FbvTMwzCBh8+VlOmVQ6GW8gW7gp8Ivub3
         fjK2++IzXLgvcEKCMIoPW0Hou55buVOwk8ZgqO8haxlKtsuOTHT2EzeoPrkBm5dhVJ00
         s05PBx1eRJR9ZMCCsehPSOGFkyXqWUWurZ5RvnItAlx4CcPeSt1EVFs5aFX5t7dMkA1I
         aMNcYNEFziWeqVb30cqOBEK+PVFZd60Y6k2neBtjB5IIy3GjLR14Tp8lvS3kSyIMYO4r
         uxO3l7FA65AcBYQBdXuUJAkWem3xpF9NAJomKihYfInN92xt+1m9tl6qFa6zbbS4uPgw
         3cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710319996; x=1710924796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yweG9hIRFKQyYo1fdZnUFpZABdTF+shxA3D5c1UT5oQ=;
        b=KKkeSIaCU8FFlB8SZ5EvUMO39ZqFzo4NcYm+WnRfw4utC55vNFEFUfu/4uYNSR7vFO
         /+kBwdC8DBcUGaUxIXB/gI0VtdMVqujDrpKVfyLwMko3ZeJYnaLVJmi4fgwx2WzlrzUM
         WmyNuWGScJxqFcJYQnhpmltL0FssL05Yk8E8JhE/09mUGjs2gjv4uhwryDLIXIxF12sM
         oeH7b+k6fmatWlnhsyOOyxvfNokoiPwJiQmJzvmNsLv/HIYDirKHxeN5Z9Jg1cGDveb5
         x4PGgBtlwlHu2yME1jlJnVzIJKCqvcEr52jhYSWtyfzwOtHxdUjzQkQYB6QWJ/jhSVa2
         jf6g==
X-Forwarded-Encrypted: i=1; AJvYcCXMUI2FtQtkuWdEJ6d2uDnZNCwN/411G2KzpaXoqjGGttI+6YcD3O8chNn9gIE7ci7+G7cAN2uyKhh7FAFRTpJQxCdzYe+7AfRIZAe531IU7lzT1lLrB2i1hvqNhmWCSUZuj3ulRRwvLtImkAsOGfD0ctxVZZzK5+6fisKXeujqiA5+BnGP
X-Gm-Message-State: AOJu0YwRgRvbNTSrXPBBr5pci/lokWyKILiKCodmn0y99TqTh2SQFlPq
	v7fKnQWJFrUYDi6HSVkV3oWAYeIuIvxDLHdegXCQELlvYsu6gEH1g004FoYC+aAtlk16JzFurRF
	csuHvfK5b75wYeyuD8mBAsv2XxVs=
X-Google-Smtp-Source: AGHT+IHd7J08pBgHLCf0ztlZ+XbOs+MP1ljuQd/tESI75Rxy4WQcrvNZX9ixvTusQ+jNH4dl3fGrVimzFVut5HkR/UA=
X-Received: by 2002:a17:907:7d8f:b0:a46:3ce4:5acb with SMTP id
 oz15-20020a1709077d8f00b00a463ce45acbmr2346152ejc.75.1710319995868; Wed, 13
 Mar 2024 01:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313054409.8073-1-zhi.mao@mediatek.com>
In-Reply-To: <20240313054409.8073-1-zhi.mao@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Mar 2024 10:52:39 +0200
Message-ID: <CAHp75VeHVJpiaCTdQHWQocE9PFLsGhu+a2TP7VSV34i02v-ksA@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: i2c: Add support for GC05A2 sensor
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com, 
	shengnan.wang@mediatek.com, yaya.chang@mediatek.com, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, yunkec@chromium.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, jacopo.mondi@ideasonboard.com, 
	10572168@qq.com, hverkuil-cisco@xs4all.nl, heiko@sntech.de, 
	jernej.skrabec@gmail.com, macromorgan@hotmail.com, linus.walleij@linaro.org, 
	hdegoede@redhat.com, tomi.valkeinen@ideasonboard.com, 
	gerald.loacker@wolfvision.net, bingbu.cao@intel.com, 
	dan.scally@ideasonboard.com, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:54=E2=80=AFAM Zhi Mao <zhi.mao@mediatek.com> wrot=
e:
>
> This series adds YAML DT binding and V4L2 sub-device driver for Galaxycor=
e's
> GC05A2 5-megapixel 10-bit RAW CMOS 1/5" sensor, with an MIPI CSI-2 image =
data
> interface and the I2C control bus.
>
> The driver is implemented with V4L2 framework.
>  - Async registered as a V4L2 sub-device.
>  - As the first component of camera system including Seninf, ISP pipeline=
.
>  - A media entity that provides one source pad in common.
>  - Used in camera features on ChromeOS application.
>
> Also this driver supports following features:
>  - manual exposure and analog gain control support
>  - vertical blanking control support
>  - test pattern support
>  - media controller support
>  - runtime PM support
>  - support resolution: 2592x1944@30fps, 1280x720@60fps

Not even going to do a thorough review as one should learn on the
previous reviews. Most of the comments that I had given to another
driver submission are applicable here. So, waiting for v2 with all
applicable being addressed.

--=20
With Best Regards,
Andy Shevchenko

