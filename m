Return-Path: <linux-kernel+bounces-81264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1D86731B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35421F262D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF51DA2F;
	Mon, 26 Feb 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0ZOaD6e"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C91D54F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947143; cv=none; b=UKhe1DFrcuPhQ1P8uolshXxbNQfI1GMB+RfEJwuOoBV3ss9oENVHiNg7JuT2s35OuaWSejB+yZbV3CsCrfZibMXPP4nh41/fAZ3Z5edp4EVavm0bT7GA7Bbvtq5ZSo6EZcHZII7s6sB7DzyF7q/70LFhom7u6FEa0s4OG1zIbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947143; c=relaxed/simple;
	bh=59M376lOs4RpQY+QsNbUdwZI7JBMTstkeh/+AItoW50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0OfBVknTQ6HbX85fE1oAjlPvXK2IX6aFA1DJGMqWoy68x6LVZ1GGwbKmh52aHWenTM+xhnbFyYCrSAvULH/cUbNLcL4bGL6m0QsCcXYOuM/2bUVMNvhdFhBEZ0wyWqJyWifw2eQW9iaMCkqhIo6XHuY6OJF0dEU626N/5SxdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0ZOaD6e; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4cdfcb24b79so250334e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708947140; x=1709551940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59M376lOs4RpQY+QsNbUdwZI7JBMTstkeh/+AItoW50=;
        b=Z0ZOaD6eybQBscd+8EgGWeZd0VY13t1dTQJM1jgrTRfY5iEryI5L/xiqShblky8qXW
         qVNIfldjgR4jJwGX2CuI/WAeM7IR+4N/CUrw6Qgecq5RapwkStTBqM+0HGi8f2wUc1C/
         8PaGxyzR6lk6ilDx5Dv3+XCKu7u+a/tuv9+sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947140; x=1709551940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59M376lOs4RpQY+QsNbUdwZI7JBMTstkeh/+AItoW50=;
        b=xHxovdiVO1m/RqRyJ2Dm/Hme/YQTwMByxMS5et18zkNhbi7W+NaexlTJKQqd1AfKoG
         loZWJnzKyqWKFQ7O/mXYWGvlvKEnxYpOZeyCnb0bdai7VwHdF6pwbwfJktrkHSsKfg+F
         wSGJgHKrHvPHi16GccP+Oh/8WVRnM9+m57s2fmo8yJ1qTxHNBtOILPCQgIHp9/yz+blC
         NMYQJdyXIJuGxGPuRjrM8xZMqzQkxWEVHN4/kiHjw4DdfJpOH+066OTz38GJM0EnxPCI
         jAKkC5dWMYDSSKGVTddMrBH1HRCSnh+VI19s+o2pqNolB561cta5ET0eaanTIXTJUCwS
         Irlg==
X-Forwarded-Encrypted: i=1; AJvYcCVeX+g5HVdDpsR6vx1hQ7SbQMitojwsuRle/HYYH1Zivswnws39uaHK40bzTPcvkn5MZZnDXBTeZL58e0H7WrMdmWMb1OFI08TOsSHc
X-Gm-Message-State: AOJu0Yz+Q2jh10fQ++MlUcHjenE2WL2+Ck4heLos2TZUaElysGCYiMY+
	1KXY5yoXRiselhD6xW3IN1W+YoL+O5aCW8WUb2osBLtez944aYvSWyMV1ktkxPBADK2XjXuiHbt
	GwA==
X-Google-Smtp-Source: AGHT+IF1qNbcqJuN5THH5NMZNm9OJKAi1HKy3rBUy0tuXhW5DT2wlgh4h7b6dN+/XL2HsCRuisWSrQ==
X-Received: by 2002:a1f:e743:0:b0:4c0:25a4:95bb with SMTP id e64-20020a1fe743000000b004c025a495bbmr2699592vkh.8.1708947140573;
        Mon, 26 Feb 2024 03:32:20 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id et1-20020a0561221c0100b004d13bb918c4sm593163vkb.33.2024.02.26.03.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:32:20 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-471e6e9482eso128165137.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:32:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQub2jt/zZyi2LX7/7w17wAtRpXWS0fd0zP+vuLszpt0LYg+vgn/XVC8HUOrXjyOKIbHw9lC9aQcnaY+z5+fWcja9wH+aRHesSaADL
X-Received: by 2002:a05:6102:3a0f:b0:471:e2ca:4023 with SMTP id
 b15-20020a0561023a0f00b00471e2ca4023mr2137374vsu.25.1708947138994; Mon, 26
 Feb 2024 03:32:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226080721.3331649-1-fshao@chromium.org>
In-Reply-To: <20240226080721.3331649-1-fshao@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 26 Feb 2024 19:31:42 +0800
X-Gmail-Original-Message-ID: <CAC=S1niCFgbNjbnHmUD46N-9gSagYuExeQ+nUHvKOvNbS-jz1A@mail.gmail.com>
Message-ID: <CAC=S1niCFgbNjbnHmUD46N-9gSagYuExeQ+nUHvKOvNbS-jz1A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Support MT8195 OVL compatible in mtk_drm_drv
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:07=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> Specify the component type for mediatek,mt8195-disp-ovl in the MediaTek
> DRM driver on top of commit 76cdcb87d391 ("drm/mediatek: Add MT8195 ovl
> driver support").
>
> With this, the compatible can function as an independent fallback for
> other display overlays without relying on MT8192.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>

Please disregard this patch.

With the feedback in [1], I can also fix the issue from within the
SoC's device tree.
Even taking a step back, I just learned that this is a duplicate of
[2], so it makes no sense to merge mine in any case.
Sorry for the noise.

[1]: https://lore.kernel.org/all/c4814e25-42c9-4604-b86a-8ef0bd634f78@colla=
bora.com/
[2]: https://lore.kernel.org/all/20240215101119.12629-3-shawn.sung@mediatek=
com/

Regards,
Fei

