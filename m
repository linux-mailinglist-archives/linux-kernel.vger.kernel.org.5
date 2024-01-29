Return-Path: <linux-kernel+bounces-42547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D78402EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E95284757
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995856451;
	Mon, 29 Jan 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX/1aYhA"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28A54650
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524756; cv=none; b=PQb40NQXHQLlPlayaqDxw2+LyramXY5V57wJvdhw+Fp79TE8szSQZMgr8zWI2yht9TjtLTDAglgQmTTvBvob7/qkgwBfl4fg0CLDpLQsSwbIhZFJBSyNyssDj9e0Z+jDOW+b9ccK5nb3IDBLfV5g1exE7if2isOXbqCgJC4t/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524756; c=relaxed/simple;
	bh=RbEdoHlE3mD+wu+k1PYg78r/i5aYkPtgRVob5cplWWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J9w7yd/ttH4UsuCk/B82n35p88TltXhz9ACWpBuaYqIvcodYS4JI3tjfz8oC7Xd1RQ+s24bEo2J9n5+vhX50PWS/5HGUGyYXjf+kpTw5YroMHNQGvYsWEhe4G6I5YCKL28pjWw86plB1Yrte+aiprRKLTol8eFQB5RwnWqxTygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eX/1aYhA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33af40493f4so213280f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706524752; x=1707129552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy4LSrThD6B1eb4xQvZN3hJ9wb7EqOezkE8yyXZlbIY=;
        b=eX/1aYhAuRC3P7GIQbQzihdqsLKoCci4J6N8U7/4pv9JzuwfYvOTe4KzD6/r/sOK08
         7ShWQcTzXr2zq0IinLjf2X7vVyqNz17/gueeVnRJFK3AxXkmbqYPkX9xCp78XXxH64EU
         vhmFbXpoZ8RUK8jDRnRO15ZgcNLoUFg/IZny0NbCofGw8NQjOaqbRyU4ZTXZWBDZ0QS4
         A+6PgwaEWvqpxU+Jh4yelRF/GncExYzKN0qSSngHhdL2ED8g/7eA6JHh6LTEojdMzewn
         qXytc20PZMRflHkW4kh7ETZXbCbdeqFnZCeOMc8GjxDtZTJV2rkVX91wUxgIJKmOW6Wi
         EKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524752; x=1707129552;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy4LSrThD6B1eb4xQvZN3hJ9wb7EqOezkE8yyXZlbIY=;
        b=mP4YBb2pVUPVrv9R0cFYM1OIr2SvoY2XJ+xx19mimxEeo0XGak4x0j9htzNURb2z54
         YsLoR9JQ3NNXnhzjtzajSwZExmTXEowwKXim1huMcKfxH/+PIYvJarcs1/ZgvzeFLdJe
         vfzYZDvwd6lT9KW4HVYa6ZmLUP6+RHiWjj1t4Q+mfz6mTyNMBvjKiYHjpIDhd8tn2cCj
         WsoEpL7rU5Amz5NUJuUKA5xu/s0WmFDugq5rziN0dmeeZ3hqcI5/XkoboZRj+cHGEnTF
         8rq9Icufs8UThvuwTcUAmew12EbTbXMovNOYZqUtTfOf4dvMj4rsiVmC2ppLDamZH8x8
         g0eQ==
X-Gm-Message-State: AOJu0YzmDaSPSSltcsq1bdsF2BPXKXKxybBXRj2E15afyD0wKW2msiWp
	KHiZyAlzQKgPKtQwENYmfk9X0lJ4lPvzd/kc4IXQJD8GgaoxrfKyywC85enuLLs=
X-Google-Smtp-Source: AGHT+IEO8b3pJJV7rJ7hOViBXy7NMTFzTO85zFdO9Ky08vsbwOJeCzVMmIHGj0zqkVpp+PEn3xCaGA==
X-Received: by 2002:a5d:5510:0:b0:337:bd95:b0f9 with SMTP id b16-20020a5d5510000000b00337bd95b0f9mr3463645wrv.35.1706524752598;
        Mon, 29 Jan 2024 02:39:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b0033af42529d4sm891148wrb.68.2024.01.29.02.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:39:12 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Yannic Moog <y.moog@phytec.de>
Cc: Primoz Fiser <primoz.fiser@norik.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
In-Reply-To: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
Subject: Re: (subset) [PATCH RFC for upstream 0/4] Add support for
 ETML1010G3DRA LVDS display on phyBOARD-Pollux
Message-Id: <170652475149.176242.14095285829208464241.b4-ty@linaro.org>
Date: Mon, 29 Jan 2024 11:39:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Fri, 26 Jan 2024 09:57:22 +0100, Yannic Moog wrote:
> This series adds the LVDS panel support in simple-panel, introduces
> device tree support for the LVDS panel on the phyBOARD-Pollux and
> enables the FSL_LDB config option needed for the driver for the imx8mp
> ldb bridge.
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/4] dt-bindings: display: panel-simple: add ETML1010G3DRA
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=7a61bbc10a7b2734fbffa4438340b6878cce2e5c
[2/4] drm/panel: simple: Add EDT ETML1010G3DRA panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=aeb262c353354eab81ab0d3242afa70984b7dc34

-- 
Neil


