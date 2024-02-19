Return-Path: <linux-kernel+bounces-71317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B885A371
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624A1283B31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE2374F2;
	Mon, 19 Feb 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPbHtQk2"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212772E64F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345857; cv=none; b=EXncYQBpswgB+Frw/F6IBvELGlgsvZiFLhuarvof6d2ZNpm2lK6xR6YYVm757IRj/OwzhbTpP9mmbUrSWIjXOf4nxp17M3o+i3PhdASsuTPDhw5P8+M4AC8TGbYdTYpe8fhKwj+coFVXJ1s783YmqoTOUlZaOlybcRbL4QkDi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345857; c=relaxed/simple;
	bh=j2VOr3/LhJl7dc0tbZ1tSvDVzz/kS8XklbTcALRThk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6ug9uCh8A6k1BFpUlx5i0p6M5ZTQkq53w3DZylFstaMXcq+oeDcE8icq9qtUyprG4YjNmJdm0IP1FyYOsb6/idZ7THWXOU+44YreE9E1RSNkNeD+29bvEpcJ2l4jM5PqBrjarQvQh1VeRPFzYJZcf0nLCe4FO+rgQ4vdcKbtzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iPbHtQk2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5120ecfd75cso6206881e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345854; x=1708950654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InV03Ory8WK5p4H1r4kGN4/4DZ3sZm57s/DE6ff4jSU=;
        b=iPbHtQk2hA9IzK/7b779utZGGGsgX4sJxgC7GhXciivu4Tz0VJNdny/O1VSK2ueiNw
         7GVVf6jNtmF3+7C5Zb8Jg08L2AlJTQPaxnKgmRIkKrpg460TkfEe/cVOIcvLJLI7L1YG
         iw8b9DjMPn0JmbLZvYagnKzBRsGH0ZKmgv7wPmejjYiTq0D2VL9vmPl1Ib/uazKkgPae
         ObjHnvclLgAvtbQi8NkcNSErznAXpjYTMzBqrusnKWy5ZYAmj8jDLnfIvgtnqeJ3xkCv
         n+FZN0D+/EAqnxu5WcdDXFhSUZCipRf8Lj83ehAfvEj7CPiOM0767gvD8vNj1rWIHEhN
         /nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345854; x=1708950654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InV03Ory8WK5p4H1r4kGN4/4DZ3sZm57s/DE6ff4jSU=;
        b=WgnfN+z2DhDHqbVu5cJjvDTmEnMbpQxXnMnmihlD+OamFLbyL+axBWXv7Fy9eP56uW
         uVDKL2Lif+JE7Q6K/mvaz55VORG7VSeokju/WezrUbocVhIrwG6eJMrl/S0lVqta1wMc
         EOid8u2EHxVqSsAueUQZQ6AMSTY8ZYZzBTyy2tvrPfgilhbPKRxPvPeEK1txcbdCm6L4
         MaT1cpqfwQ1V3Q1D/kFoTiedcAtYsXuRF7h+ISwU3Y0c8TTHz9qcils2QUss3BRmwWHb
         V+Op0MVcIiDIwgYFTOQUG+ESZqGZfmpft0tB8WgCWl1lgPmpg9vrlN9a6OWTQvGjkjb4
         VYpA==
X-Forwarded-Encrypted: i=1; AJvYcCUHfJZiQJeaKXyQmWApomymv2CfeiVONNGKsWb7lS3fAyVV1GTSv6QallYMcCPL8Y7+3071yhfJj/AQ+kO6YOyLFUk+rnKHFA4r9zuF
X-Gm-Message-State: AOJu0YyreBsaos86EliPiw/sZAXFhAYwrh8JLJBsLfWBfVBVb5AaYLYc
	73IozPMTkgu9nnkKKKqPJ7kdbFuEDkK6HpTtSgN3VvJEzND6jpUTgXFCNnzgW+A=
X-Google-Smtp-Source: AGHT+IEcY4yQmQxAJ4WiHYNwm13YvwEPV231BSoILkJGjdFG/MMBbHe/M71wgEdW0/b/Egu1Mq4h0g==
X-Received: by 2002:a05:6512:3ba8:b0:512:a743:3ce3 with SMTP id g40-20020a0565123ba800b00512a7433ce3mr4488709lfv.23.1708345854485;
        Mon, 19 Feb 2024 04:30:54 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: msm: sm8650-mdss: Add missing explicit "additionalProperties"
Date: Mon, 19 Feb 2024 14:30:43 +0200
Message-Id: <170834569504.2610898.11072295234530995616.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202222338.1652333-1-robh@kernel.org>
References: <20240202222338.1652333-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 02 Feb 2024 16:23:37 -0600, Rob Herring wrote:
> In order to check schemas for missing additionalProperties or
> unevaluatedProperties, cases allowing extra properties must be explicit.
> 
> 

Applied, thanks!

[1/1] dt-bindings: display: msm: sm8650-mdss: Add missing explicit "additionalProperties"
      https://gitlab.freedesktop.org/lumag/msm/-/commit/4825b207002a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

