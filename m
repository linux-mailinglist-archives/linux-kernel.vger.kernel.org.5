Return-Path: <linux-kernel+bounces-75588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44985EB97
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D62843B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B387D128394;
	Wed, 21 Feb 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tE5CbTty"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC26128378
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553245; cv=none; b=KKR5cvvm18K8rEGfQDzq1kyQ6C6S1FwMbG1FhTpAjGveZYkslFMVkNeWG0ZrJeFVoG8NoyGw7iXds5tTccEERo7ZV5IhDjXlHqlHipHSCo/hVLRUXRho7+olBSxqc7SjFdxztI3ANFkjehyALM7LOPKb0omNs1oKrJeDxpNKd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553245; c=relaxed/simple;
	bh=iNidW3f5wsCISbKAXdYoDRvGkkbi4875RfDnKAT5TGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It9Jk4emL2F3YIGr2rTGdvDLvOVGkJLzD+WYvM/jQ/zzHcTyV9W8p+prQsWfvJkjXVo9vId1uONhIRyE6MrTNkHqNOYPfl0gXa19swO9ozgqBd8C/bPVAgRFSKOhQaJmvt0TO5J/DyQd+5JLSNORQT1BLgjSw5GDO0Tk500gTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tE5CbTty; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60495209415so70376037b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708553242; x=1709158042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cIdAj9Rc9YrdEZf80SuI9gbBcjMeYE4blz3NlBPNkk=;
        b=tE5CbTty8JoVcAb7WjBqLRfrAV27yaXE5g+MkmfL2vfm6VD/EBCADX6YbvvGGvfWqE
         ECkjUVRifnTAdb3lHfrQP2o4c7YOr0y1RfN37DQNm8QSR1XCDDdQTQw7ynSRW6rQGBi3
         4QGRhIwUT7iAJxV6VznNSo6iQ647Dagfkp3tyToU2dkjSo+Xid9+Mrn1lO3Qv9yu0iDE
         5uM2bl5B4bj+nMG/ZTKyVQVwIxtNBvg/W8GlZzPCR7hnyiAsWBvPrEnNNUoSSq94txlZ
         RAmC1Bke4WkKePOkoeR5bLH7FC4vvBfo+x7+zVTLs5OCMRtRf5EJUKfq9XLLa1JUupMO
         nO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553242; x=1709158042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cIdAj9Rc9YrdEZf80SuI9gbBcjMeYE4blz3NlBPNkk=;
        b=BjJV7Z8ULe1YUwiOBxMS3QMQ4i1tAvenr71jEHBLsYRp/VBlnyRVc7IyL6oMAz3PWJ
         66NMqZEuH9WQmHTBXOkHMRfHdOPBqkkJo4fgr+Y8JYKJlFMq3ljCKPua5nYhQ7GQny62
         vO4HHBL31frO4+lpC+0XZtHaO03+mzga8ecZU2jOLxb8HcfHRl1IAxSgdiKpJghsgU4M
         VSKAbLzwXIz9+voWYuecFqEpz58/PIlc8sF6FbAsEjBh1rD1GsYEWgbbu8N8BDbUtOfK
         U3mfFCPX6uTjf7EihH5xQVRYZP0DjeyfONFw9I13SBRxUQsozcN04z+2h9ghdOJ2ioVd
         UUQg==
X-Forwarded-Encrypted: i=1; AJvYcCV4b5pGudh+JF/DQqy5P988cqc4dJuPrx3qNrnV5ZvOaxGBzZ2SIJaY1oQEeShrFrSR2ojSQZy3/DuNKO3x8/xw+hsYJylWSv5ei53t
X-Gm-Message-State: AOJu0Yy1I8FRqGM99Ii0rTTy8qhMutDqyKo+8uYC5WRnc+1rI5m2aSP3
	8I7D0HWBDbMbjBVu4iWntbiq4sTmY3tBVI3HibxRhmrJZARBO1VfuuUe1cpqlMaSp91+7LDz4BA
	C/2bjBqn7aPN1/rz0mC6C4byn/xFBPCWuZH2KbA==
X-Google-Smtp-Source: AGHT+IHcXCkZHHGUkDm2xvIgiK6VurrE3eAJdP/r6uC/vcQd0YLTd8DmYtHQlaiiKrj98oMZezfQEBryKYUS8JEchGY=
X-Received: by 2002:a05:690c:86:b0:607:d9f7:e884 with SMTP id
 be6-20020a05690c008600b00607d9f7e884mr20419761ywb.4.1708553242109; Wed, 21
 Feb 2024 14:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240217093937.58234-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 23:07:11 +0100
Message-ID: <CACRpkdajVH4Y2K5W+o5XAoiEr57ObVbaR+9QdFV=Cp765B+dfQ@mail.gmail.com>
Subject: Re: [PATCH] phy: constify of_phandle_args in xlate
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 10:39=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The xlate callbacks are supposed to translate of_phandle_args to proper
> provider without modifying the of_phandle_args.  Make the argument
> pointer to const for code safety and readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
(...)
>  drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |  2 +-

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

