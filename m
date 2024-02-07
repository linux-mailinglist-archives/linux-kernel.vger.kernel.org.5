Return-Path: <linux-kernel+bounces-56187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402C384C724
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D336A1F2595C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D82233E;
	Wed,  7 Feb 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9GhI38Y"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2CA24B39
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297562; cv=none; b=TpJUBgu5+b1+qXRzC3JmbkKKhKtfK4I/FbgkSUZkFSrcr5MqeObJcxoTdO/92Oa60TTAZCTTkNmyUEDnaYi5mNSZToDFXfhFMiI1qSrENEYo92MCzdsTK6M3zt3yDBQuW/PpaORYRDsnUEc8UaTAwdgic0jVUbOnq3HdXwGWGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297562; c=relaxed/simple;
	bh=CRsHaCDSsl2+2SPfE4krrU8l0Qy71ra3Ty3MVk3lKLA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GttkWcgyfgI02SqT3tlhfJYf2CL26X5A3ZoziUZO6qFrCZaBRnkYz+3r4q/tWvU079NImS3fHV1QtymUddVHL+7f2C/KiUMnYOnuh1QFoIo5RbuR96OGVFt+I9CMse8i57X7OC9G9SjMVCkvCZ/Gxv0msG2rnCccvgZ+Wr4Hgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w9GhI38Y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ff802496cso3602485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707297558; x=1707902358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaRiKb/w4iH5KbxLrr0CsrBk0xODem4EHSIMgHr4BH0=;
        b=w9GhI38Y+0KCqmz6D9R6ybzibVpsxfH65H/XILRk+h9KBPyS0RKVAoFRIhFiwlDabZ
         5rzRNpNnVH4tyc8yX0fJMFmP1e6D0Ak8C5mzB6XQHqqEOwfgbRt9Uho/7y5PcRrI8u6z
         im0cYTBIEUdRwG7UdazjexY6UeS7KO9L8Crhy9nJ+tkDNqNWRYWarjnzRSNNfwiQ5Ocd
         oZI97vP3xKPoCbL8M8VGcIuo8T8ZO/3jq5nJrMTq899yiiOrLssVivP/buAxQ1zbDNke
         nPoYXuoca5KYhrEgKtSg1KpY7grpgCBHUpOjwgdb1io4bpP/SXgb1JVBWOdm2csqW0fF
         lYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297558; x=1707902358;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaRiKb/w4iH5KbxLrr0CsrBk0xODem4EHSIMgHr4BH0=;
        b=hsStisqAUSVBUnAzXg7GwJJEsnG+aJvOSqNb5MxOxhdI8BHbyjKtqnyNoixWzzWZnq
         cdpcDkF9jhBkYze/DPBs+IlE3WqADuxMYZ4B5F5I/nt37M89Cj8GFvPDhzMwFVJRIoBR
         m16XezGSuQigV4e8MXJfoTqXq4OGbaEajuJlpofJJTVAAQRlEK3iM8gQUqqTjw9grm9v
         EcJEEk6pu6KTbqUQIyrC+mUtQHkn39Oj5vyvD65oVtjH6EaAAkJN7N9YMZ9/hd2azBzW
         HaTAq6gsZHOPATRwkoCVM2wpb0vLWIpqOXaK8kA8ZaAw2TsOo56iVyXkosQiwkGxNVes
         yptQ==
X-Gm-Message-State: AOJu0YyfzsNhXVga/zCPTEcUsO+2DPPF2wpbx7cIyDSbqxQezE9dXrBF
	aN3nFCb2U7g2miUvV6PbKdlHzWxxRo+OfzuY/k0YFM+OcWzlKnLjITiS/m3jPb0=
X-Google-Smtp-Source: AGHT+IFGQyyZHPIzn2dkD1ijtaQRSJPfvlhiX/TITJ7pLRltia26Y/6md7Btyg2bU3MuWqR3x8jxAQ==
X-Received: by 2002:a05:600c:1f86:b0:40f:dd3f:ba10 with SMTP id je6-20020a05600c1f8600b0040fdd3fba10mr3527983wmb.33.1707297558488;
        Wed, 07 Feb 2024 01:19:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLdxICuHk9a9uCPjkcqKn8D2izq4JpwnK5k1d2F6IeVq6PIRaTvmsmwfTVEOAFt0A2nwwC3Zpb+8KNn9SiBwy6LN7oXcPExw4oBvu2VEBYjClh4Ynd+fWiuDTvtrtAO1hTsF2ewoWIR/meWKN3YpFTEVdYttq8VbRrVXRdDYXENuA2pC95o6eCsNq6wXFDhfYH1HRCWdKKjUM2TifR0FaiUngrM+wyjVGO2XyCpP57F71z+RX8tNjpSVU6Mm0wrqH4Ue+WGvQ4RJCYV/+2hUqBYQkrCPn3HxSR+Pad7xDDC73t8F2m4c/Rk6SZji+G3eD49QL01HdSY+Gn
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r20-20020adfb1d4000000b00337d6f0013esm1003490wra.107.2024.02.07.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:19:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240205062711.3513-1-rdunlap@infradead.org>
References: <20240205062711.3513-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] drm/panel: re-alphabetize the menu list
Message-Id: <170729755771.1647630.8570612992728203897.b4-ty@linaro.org>
Date: Wed, 07 Feb 2024 10:19:17 +0100
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

On Sun, 04 Feb 2024 22:27:08 -0800, Randy Dunlap wrote:
> A few of the DRM_PANEL entries have become out of alphabetical order,
> so move them around a bit to restore alpha order.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: re-alphabetize the menu list
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=aaf7f80996834ae5e2fd46d03f6fdb852cfa9911

-- 
Neil


