Return-Path: <linux-kernel+bounces-131186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E2898422
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8807E1F24952
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD567640E;
	Thu,  4 Apr 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDIQIVuS"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1274E37
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223094; cv=none; b=Ek5aWYajoog++TTDQGIysotUsReEgq6Vk20VFTzyDNLovmLmDhPumOWAJIa2juRh9rsJmLfTBVHiwoMpX3d4YIe8H+oMIP8HuHdH7ZWJOgDszmmQTQ+kyNCf3gamLPRbp8Kxde2+QLaJeulOH9JayfyxSiO6+8cOPeqJjsPHsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223094; c=relaxed/simple;
	bh=eal+hbwuJR0GkxwgPiJg2NCYAvGM7tKiSJzcHq0j6dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGDu39kOOYYBTrgxVuEEeYsSH9NqfXMNATNNl/MffW/sO7CBxulMij+aD6K64wo2qV6NL802O00WeB8dPfbXtmV4kc1xHSOSq9gjJ/rGarkeG1cg6OjQcE2qn0QMciCWyAuylcxB9N0ZNT50RA3/WWEcUYctE+5T2CpuLf4ntt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDIQIVuS; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so757826276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712223091; x=1712827891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJzdwgYqSiXBG2wAbt+70V3f0hLZ0hXphRY5qJD39hQ=;
        b=IDIQIVuSWzz/kI90Xib4W+1zCVY4pIjQCEiWSvoH9xAYiIDaC3HmgZPB70q3bF5Zqw
         J3hlygutFS16HiA6/H5LLfPmfDTCBbjjPvquHBCVt6NyvlAanqlqHijX2yXkcRe3AIla
         IqkOX86dse2kSa0XxKO16AsIJlq1Nr2gNhAb/1B8szRxoaYtoN5h+HzVlszju4xMaqGH
         sbsO+JX9Czpr9v77XztS15C4DFvS6264r57pKsESNJeR4wm0QUtUz7x3aG+KgmpY70d1
         SN7d2gEhfeHJW1sikNgHU/8J+An0bRPLQjOZS+9r+vRbn5mm1Zs4XCvjE4dAnkr+pwwJ
         5wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223091; x=1712827891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJzdwgYqSiXBG2wAbt+70V3f0hLZ0hXphRY5qJD39hQ=;
        b=czi3IeQVkEFFV/ia7UfOapW2Kd6tMvzUBJN/Lk9FSndCnYVjeZTA8McUxzQD75nSlo
         AAy6SIgbfYWtvSKx/RufwkKZVArmBWlR7j1AFC++/zMZ1jfQE6vrhmgW8sM7/QQbIDB6
         3muZs1jZ3+eKz5Q6mhjkdNG4pTadVJfOPJUgRY8CdZg2xTwvyoTu7U2ZsR6iO0e6Ora5
         vj4Cq/OFpIHL4bNhqxtM7J9NsjiJu3ATpWtCFCBKshSIeZH1KpYlUEU4l/Jt3opXupss
         RdjWbLdVrSSpECVR7BgGQdn+ng+37teE5N7RdKfGLBu7Bp3zKLOulY369aZ9rm3M0acn
         K94Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSqoFQDS+G9O/4JEDEAr5HB5dKzhnz3JO3NaAdbdmR5bW6bV/sMtTrIZTP3PZvMbhDeeekmvt65yYmnDu9W4ulNDkKq0ETRJW0pcTg
X-Gm-Message-State: AOJu0Yz01VGDhkbm8eUdkLoAZCeYMcowNwQXyzSuDgAc5WJ11gDubnY4
	3CXK/SpzdgfT51syFsC0P/ydhekFEU7fUga2noiV+aY6ekjfP6wp3GNy4I+BqpJ/JXWnUyuiZmw
	JDdWfwZOadWbylO7EVd8wQd//2RiaoZdB8A0eeg==
X-Google-Smtp-Source: AGHT+IHTXtbKZV4PRrgxvlL/R1tUqcSFTjPcwK6//feDtYUO9NjrShijYYET6/+oeV22B9HIEQVjv5iZuw/cw+hBGTs=
X-Received: by 2002:a25:ac04:0:b0:dc7:423c:b8aa with SMTP id
 w4-20020a25ac04000000b00dc7423cb8aamr1828891ybi.12.1712223091503; Thu, 04 Apr
 2024 02:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 11:30:54 +0200
Message-ID: <CAPDyKFodTh-KN+=b1B3V+7aNEoR0SPo5-xjFaWu=gYEtsDy1pQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 16:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v2:
> 1. Add "wifi: ath10k: sdio: simplify module initialization" patch, from
>    my other patchset to avoid conflicts.
> 2. Add Acks/Rb tags.
> 3. Drop applied SDIO patch, which was the dependency for the rest
>    cleanups.
> 4. Update subjects according to feedback.
> - Link to v1: https://lore.kernel.org/r/20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org
>
> Merging
> =======
> With Acks from Kalle, please take entire set via mmc/sdio.

The series applied for next, thanks!

[...]

Kind regards
Uffe

