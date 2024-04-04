Return-Path: <linux-kernel+bounces-131434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E68987E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D971C21AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263436D1B9;
	Thu,  4 Apr 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGMfSK4c"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94964A31
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233825; cv=none; b=YkP9RoxD05xT0pdKJPotz6XxdY8Ww5QiCQyU0SQ9ydX8o1SrcYiTcQSF8furnQywvqToTRl84d2ZXyMP/1AtF59i4UeImNBd5NplqJkZSolixpvKMe42VaPtFyPJT2NVyklbur9Ctk2CiOKJ8JubmfIZ+3CT7YiNaFkmM3OpufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233825; c=relaxed/simple;
	bh=hMGCi5U/GTUr4s1TD2pXM9wRWDVE6D4wK5xdmE2YqBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2zhoSgT0bFGvMcrT9sylKbifljpq85nqQ/vaNVyxhvuRdWwZQhbE+vmCVKOErPruU6d/mR/EO8H7TeK/O17oGAzNSIhpNNdj9UpPk8KNzps5SKNhSl2he7qn/1mM3wyxJH1SIMXkcFiLAKDBhoQqk/updBirjFNA8ZBPBx6y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGMfSK4c; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51588f70d2dso1183102e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233822; x=1712838622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X20l1OIbEglZq76t9YzipvH9/8wF8pWqOBX+VeO6mJ4=;
        b=TGMfSK4ciAXhlZwN9Hw9BKWPyBitGFbI9rBqnGcUjxFtEZpKc1hfHxYLZbVGmnRd3r
         LhaDVaC7ylco8IfsqX6N14ilVKuRIoCY/qTj7oz8zDVwtGClFGduq59c7ve+r7XW4KfP
         5RGajWt9QpMgGiuTsY4R4pTk1f9F7JHyWryr7ycu2Ta7zuT8gjZnjba6BHvG5xYl8m7W
         5baGQj63oAKDwyLGKOOEgjdlyMIt0bSaIezmlequmffOelRSsls6asYpAjaCHRpb+fZb
         cHzKgoYGGQeNMOHMzrZin+bvplbyyDKeh5tvnmP9EuEtl42qTLG/hTevIj7rPwjlAbI4
         kUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233822; x=1712838622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X20l1OIbEglZq76t9YzipvH9/8wF8pWqOBX+VeO6mJ4=;
        b=uHOPie3SLavO4H92dTT5aiv/31mgPv7/jpvKIqG2UQKzm2pTzAp4EqkcSKH513ClEG
         3/kftR1vFqIfvTHyKktfx5nwhxwlfjW9rp1qtMyOFq+JbQfig6eyUjqxx1kPbZ6MnUW6
         acYkoplrAFy1QzsAKzv00pNTqFeUOTdBbnDSKGpOykJSleI6iOnq/+hl9mvva1W6VcBv
         YWs3Evh+2YjVN/n3sSBJYkbjYc5tm2k3sXqpljslBVc7EzXg5ZINtxI9oj/oX+ZMMqIk
         yq3nBO+rDP7KdVDz5PFEUgHR4XcpvFnpejnVWcZDTT9s6cpac6QuZBbXKhhVOyJphOr1
         cqeg==
X-Forwarded-Encrypted: i=1; AJvYcCUEBfrTr9M5GSpZDtytQW9OZiLk3tuNSxZP9b3VxwCN+G5OYBTZNzyChcGPCjXZflMeXHEPggsnuGYNlAQPcUxCOK/qFC26HeltbBZY
X-Gm-Message-State: AOJu0Yx2dY4BBQg2b0YByX5oEWasLMtOCnXUug4t+lLrWLeJlfPe6VbO
	nl8MQj3k5oLRWD1QXR0WFklROu/JgzzKE5SwxS/3PQBDAiCO1CgpDien5SrWWMA=
X-Google-Smtp-Source: AGHT+IFUb5zsg1JnqPSDM6WCJg3DgMPy79GM9WkgadXKzQqBbfSPE4iFlNdz1Kc4Oxni4f8yZOheig==
X-Received: by 2002:a05:6512:3707:b0:516:a115:4a4d with SMTP id z7-20020a056512370700b00516a1154a4dmr1578665lfr.68.1712233822050;
        Thu, 04 Apr 2024 05:30:22 -0700 (PDT)
Received: from eriador.lan (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id b19-20020a056512071300b00515abab7697sm2286667lfs.55.2024.04.04.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:30:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com,
	laurent.pinchart@ideasonboard.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V2 1/2] drm/bridge: adv7511: Allow IRQ to share GPIO pins
Date: Thu,  4 Apr 2024 15:30:19 +0300
Message-ID: <171223381119.1231870.1373781151741394452.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305004859.201085-1-aford173@gmail.com>
References: <20240305004859.201085-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 18:48:57 -0600, Adam Ford wrote:
> The IRQ registration currently assumes that the GPIO is dedicated
> to it, but that may not necessarily be the case. If the board has
> another device sharing the GPIO, it won't be registered and the
> hot-plug detect fails to function.
> 
> Currently, the handler reads two registers and blindly
> assumes one of them caused the interrupt and returns IRQ_HANDLED
> unless there is an error. In order to properly do this, the IRQ
> handler needs to check if it needs to handle the IRQ and return
> IRQ_NONE if there is nothing to handle.  With the check added
> and the return code properly indicating whether or not it there
> was an IRQ, the IRQF_SHARED can be set to share a GPIO IRQ.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/bridge: adv7511: Allow IRQ to share GPIO pins
      commit: f3d9683346d6b1d6e24f57e954385995601594d4

Best regards,
-- 
With best wishes
Dmitry


