Return-Path: <linux-kernel+bounces-152946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074BB8AC679
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA841F214EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2E4F1E5;
	Mon, 22 Apr 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfsV8M9Y"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492352F9B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773608; cv=none; b=UVFMVOfB1OiVN1WSuDoNtEvkmYgIdnErmnHl7ZNjX+cMX6Hs/io3ZGGS3jg5lJcFXQO7/jvDAOTUSNcA30WZdnKo2hSO2EFaHDvjNAjhXBA6R6mSKJB7H0ritbET/rGpvC4mNF6PG1sT+FafT8iF3vNIYWQKI400iZkVjw6wETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773608; c=relaxed/simple;
	bh=FxkEBziKtQxhWojrucgf/WGamgoTlWr+LUFLjNsCl9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P0J0MGWZrslh3jHOx8WwxVgvcAioWFUVCOQUDkq5je/HBxypvr8nJcBUXhtG+eq7m6oJJggLYOiUI6/u8qMmI5BkaVLBeJwVuMDGqLItvaLplj1EEHePSWhexzx+7jpeg49DkXl+rwMMi9TKtEPDA3QgCnOZw59bOFudrp6pTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfsV8M9Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41a5958d7c2so4138005e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713773605; x=1714378405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS3mxjJZGylPMQWrV6fjHJvytyShfSYEN+VKk+SCWTk=;
        b=zfsV8M9Y15XQoTkCI46CIw+QrNcIbc9v8nztBFW83vYHLcQLfS+c0luHVs/6fvmH9z
         KDKE4F47VXEnxfA3r+aFMznif2560zr3N279qvFNbMdO7onun327KFsnxzNGm4eKVj0r
         3ngAUrGxRavZIc7IOA4/mTj2zxdjC/vEECtMZMnFadpqJdypIhX2Llaj0v6QWgqIrhxo
         p/TCeTH0S8gy+D5bI0Rnlw/swRw81k4q81RuLBb4B61YwIhHPQfeHPuple/lbnDWmKKd
         DoplkS1yufStngZgLN+QSkXyLf695kE3wqjuxJH1sXf6BVbey0lKXnoAnjkHwtASv+Z/
         vuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773605; x=1714378405;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS3mxjJZGylPMQWrV6fjHJvytyShfSYEN+VKk+SCWTk=;
        b=Aj+H2HpelUfVpmbxKPP7waUfTrsUemAWqKJilN5NJb4pT7UE4RgbeOdLmspILpjntI
         6OACQy6cUgbcJPG/Qn5x9Z3ve74LDHAjSqYYtXTZJgK/hfmnWlb4tMwCkSx4xpoET3be
         ApBqZ1vpzUGymttUTAc3C7c4tjbHuVJuYpmN36KmbJp0KQFySCVjiFfEF64K/TYcoykq
         vWfqQNo4hHWIgS4Ym1dXJ7Ar/JJm398ne0h2jTk3xdhYf39vX8Ijz2iCY6jkWZBlYWn9
         Dp6zrWMDoaZgmCBK4AYjkaPS9X+s+MWA7xFrRPfiWTYNZbGv5yXdHHeBPKyfGxaPxvnA
         H2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUvTkd7soFv+EfpXtz0q/82nL4PBgrR8WUceWkGxYNkl78NamVTj/54tDK+QUd/s1ucQ8+uBJytmFChb0PyB4EfoelGhstOSEHJtkCU
X-Gm-Message-State: AOJu0Yw30LolITVOxapYQm/TxNugiiwqGk2ZQOsp6nQ1cg2rm7w/Rs+G
	PkDys64ufgtOTSVgd+oMi0Wfb7MONSKvKWeN0qLSiG+FKnZulEUTgZOtvegxjgA=
X-Google-Smtp-Source: AGHT+IGPrO7v5/lKn4DROPvyQytV03lXmW3pR62NbGJT8AmgPph9yPGqucSHM/Ijoe+qpMFYe5TATA==
X-Received: by 2002:a05:600c:1394:b0:418:e6a1:c0e8 with SMTP id u20-20020a05600c139400b00418e6a1c0e8mr5978703wmf.7.1713773604900;
        Mon, 22 Apr 2024 01:13:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041638a085d3sm19437504wmq.15.2024.04.22.01.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:13:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: nick@khadas.com, linux-amlogic@lists.infradead.org, 
 quic_jesszhan@quicinc.com, sam@ravnborg.org, thierry.reding@gmail.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415031408.8150-1-jacobe.zang@wesion.com>
References: <20240415031408.8150-1-jacobe.zang@wesion.com>
Subject: Re: [PATCH v2 0/2] drm/panel: add Khadas TS050 V2 panel support
Message-Id: <171377360401.3418456.5122435310463743780.b4-ty@linaro.org>
Date: Mon, 22 Apr 2024 10:13:24 +0200
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

On Mon, 15 Apr 2024 11:14:06 +0800, Jacobe Zang wrote:
> Changes from v1 at [1]:
> - Fix name from "newts050" to "ts050v2"
> - Add specific description about controller change
> 
> [1]https://patchwork.kernel.org/project/linux-amlogic/list/?series=842707
> 
> Jacobe Zang (2):
>   dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel bindings
>   drm/panel: add Khadas TS050 V2 panel support
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel bindings
      (no commit info)
[2/2] drm/panel: add Khadas TS050 V2 panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/26f9339212db569310d4b0ef4284efcbb462a86f

-- 
Neil


