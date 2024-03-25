Return-Path: <linux-kernel+bounces-116898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD31888A4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747F12E4268
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578717AF9A;
	Mon, 25 Mar 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8DPXiPg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3571A0AE7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364118; cv=none; b=hzQknrkDWluAGSnziO34wKXUSVo1DDiY1+rl5vRxEytO3ukeKn27FHi+yiEtoyaiv6FR+ZjS+XDKiUoAyHa3/mcVY7zGs/yHDoXAQ9XO/2WvyOcBFnrxkejSBWjXFGyrD1fPDZHwm22t2N/geQH94nyrOW4FPN2+CJbSI2zjCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364118; c=relaxed/simple;
	bh=mgymItK7WgmH1MnYlpzSZntvur4MDFzPilSgMUUUbnk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pEBqCdslbpRtqHBxPoN6OxBaTkFLMRlGpN/9kJraqU6JPlZH5HrcY64U4vUYjCLua66bcz0SPpET4of0FcNHkAKngDUrBmfNe+okjzg+uU6RugIRrc6/Ve8BPETTPTncYZPRBZBI9ooDeUGI6nVkFKa1QQT9QEQtXBqlAhVzKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8DPXiPg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41489e975d6so3464165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364114; x=1711968914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnH613nBUeVax298UlBKbR2krvx0QgfXLhq8xs3I2/Y=;
        b=v8DPXiPgtXNIIZf4AZXh2j9n7c05MD5Axm4aa+W2PsHDBf5U8YGfnjMpmDWm3uVpWp
         EhrOEslvDRpS0z0SnJzCLJUm+/nssnHNFuPzJMMGii1BZ316NmSQRptqTcSIuytT2KmA
         ofsKH968ToPwIrt+hikhXF5DeXg6F3HhJILstECNoQ3tdKNGmonsYEn4Twd8TuYVnUGJ
         KyOBabU/K9icyBUeXXpBjWc0nWM+YoftHH3LcxQ9+hNELZqyGIKRmu8v2GHLUSvLRm7a
         pDOawm00Eoob3iPIKBgeM7ausGh4QcQmI71/oyAt6pDiPSHmhUpcc5IlJMjl3sK9pn/X
         vDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364114; x=1711968914;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnH613nBUeVax298UlBKbR2krvx0QgfXLhq8xs3I2/Y=;
        b=OUaj1cEKQQCaWMiDwQsXrIpgwALqA2PzWYkpSHpT5bFV/b1pHhJok8r/ldMhQtYTDU
         600SgqRGsuW1BpTLCzqNohOlO6+GI/LjYMvxSBNpAA9bcjv95iI9NjJEWJTmz2H+Oq7L
         f8Qv4D5G+J0YC1RKYA/3eOlM27kNCqdxAWqosqEHlhIhiymIPQST3kcQwsl1dbmyH5yd
         /x0nRDp07iCaHZfQ0VCVPO9pGfG+9mEnuS9FZqUIcTHJAJUbuGcox62lBxqdNOCJ7w0/
         ZBA0b4pyM3F2laghE/RPZuHZxW3ISS6X6aqMTgYUMEDFkYvJKl4Ujpp19IUWE05CiqKW
         /csQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6sCxLVpKEG/REYbJqMNITODLyFGrw0wltoBS4IpYFWbPJsF81Af1ak5rjkCmpE6RJMUg46iw9LNisQHf7IOMIVSsNdZvXO1Hkc4uD
X-Gm-Message-State: AOJu0YwnswvnU4/Af3u63KvmkRalsrdesV5oz5NxRbM/tsNNE+Nl7qzo
	+KlAJ1mMfZkjQ0+94Rxr+s8lPlZMMSeW7AkNUxQN0hYz0UBoM9GT4jnAR8myGPM=
X-Google-Smtp-Source: AGHT+IGwGU7gpQJqeexmqiCDr1Yg2n3xkuKSJhvlV6DEgZ55qS9f7MIRV9jlesIETW2qxwJx8OpcwQ==
X-Received: by 2002:a05:600c:1986:b0:413:1f65:ec19 with SMTP id t6-20020a05600c198600b004131f65ec19mr5038708wmq.37.1711364114083;
        Mon, 25 Mar 2024 03:55:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004146750314csm8161410wms.3.2024.03.25.03.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:55:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jianhua Lu <lujianhua000@gmail.com>, 
 Del Regno <angelogioacchino.delregno@somainline.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Rob Herring <robh@kernel.org>
In-Reply-To: <20240325103611.28240-1-krzysztof.kozlowski@linaro.org>
References: <20240325103611.28240-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH v4 1/3] dt-bindings: display: panel: add common
 dual-link schema
Message-Id: <171136411318.2357652.10037957949169924402.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 11:55:13 +0100
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

On Mon, 25 Mar 2024 11:36:09 +0100, Krzysztof Kozlowski wrote:
> Add schema with common properties shared among dual-link panel ICs.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: display: panel: add common dual-link schema
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/48a516363e294a4098622dd77a5ecd4ee924121f
[2/3] dt-bindings: display: novatek, nt35950: define ports
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1f6612e6852ecb053ce1e342d833ed7f395f7186
[3/3] dt-bindings: display: novatek, nt36523: define ports
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/90ed42ceda7667f5596d5e98530dd4119d786234

-- 
Neil


