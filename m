Return-Path: <linux-kernel+bounces-116876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83288B138
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FF3C04092
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCED1B7CD8;
	Mon, 25 Mar 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOj+/INo"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDC1B7F48
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364724; cv=none; b=N9tLiwqUSAqQDE0GrbjaDA0+z49VHpgxuFzdbGSzI4bdi3UAQswUSV76jigYAg63jj2aGKWg9HXY/4LSU7YY9ILW8ArUGVw2iKLWLp90N3Qib7xWmkFJLa2BMhjhSEEHWZFxljphSJTWWny6iyjBEiN9zDfCpBvLgCEh3fsYq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364724; c=relaxed/simple;
	bh=Y2nmC+14ezRMy2mustue2MVUzVXwhFpv6ampXT6eUHg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe/DJQAu+O1/ysFWxlhGPIg7e0e/Zka/k4gf0vEglenXUKzXYD47u2wORmtwzKZo86PVkxGEOT9L6rc9WlsesWMPZCCi45hW5pa2XpeoRWpJXialrlwBWze4hI9hiRXCe2h2PcFSKnhaWJQjK9UWeerCnDrVyYU6ugFWVE15en4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOj+/INo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41489d59523so4036765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364720; x=1711969520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsjoNh+K8kiEw/9D4H6Eni8rIjOxLmAIKVvEa2HpqNg=;
        b=xOj+/INoYkyS4CfUNaK387Z4RrUDm/SPaTVARPxeFGeiizHmt8LbuK7UJ2rOEJV2R5
         DsxC+BBv2ffiw22F7BqLSwEAANP/zmu7NUtuRRXdijV+8c4Ur7C+92x7tS4lNIb/vc26
         76S+w8+/WhEJrAbIpZ90U2fCmdlLLRtxEFXvhxIg3SddXWnYLusdBxijD83aLa57TNS9
         7SbYtlc6qo1AdCjznK7LhVUy7eWY3DXd9vM8wX1RhgJFCgw+bwIGhSuiQ3GlTp9j0x7d
         n44gfqyHZQ22d2dbeZ6IIm+nDchUQnAxr1+2TV7KmmRBWk3hXfeDjhjouFi42r9TrJnH
         Y4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364720; x=1711969520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsjoNh+K8kiEw/9D4H6Eni8rIjOxLmAIKVvEa2HpqNg=;
        b=hZYo9ecxR0yzGvYLV/uX1m7TY2D/8v3Dm5TFAcADg2WhJHrRmkhILip7T+S6dqqHWG
         rjzl5W+IullnKb0Y08tgOVgRzK6zQa8fM3frxiOCeVqBrl8/TSBAmRyLpsWeUWv0Vbgu
         l6FYhCbPhSfttM9DmIguzCAIubtjTSa4WLKlMNrpY0CPQ1e+kKY4qRTK5gmCISGFvUOB
         jO1FISZK+9lkQQQDkOaUodbpxtYJnXjIU+20hxNcToap+Nk8cZfsdQCtgzgz2MWofh39
         BGZb4rNScyrVtyf+QGsUOwTekmP66ZV5ec3puxSci31rF/V+e/4Yhvbhahc0WyCWSKhv
         cfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9LX7oNxh8Q0iMBJ6uEMjuOfQq572mVTseeiUUcOWHxnCn/HorT3PFEotIsHMl2OxCtSSB6MpC7UYEsk38XVIzFgCefkU+6azZOxI
X-Gm-Message-State: AOJu0YzkliAfu0yTGAsT84KkfioLE1AWAymSFFDS/LhkQssn3Imv44MX
	UrNnoo6PQb1RfLHsbOXdQ0cTnNGIxfhmW6vFIfJ+nQ8t2rK3fKotXobSPXUvKaY=
X-Google-Smtp-Source: AGHT+IFf2BzSEVIyACoTBERhcHBMEiFMPo7KU1PU5LY5EETHIWOeFxhfF8SpIWBWaQEdNiEhHW38zw==
X-Received: by 2002:a05:600c:1389:b0:414:64d3:f33f with SMTP id u9-20020a05600c138900b0041464d3f33fmr4665364wmf.23.1711364720697;
        Mon, 25 Mar 2024 04:05:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id gw8-20020a05600c850800b004146dd6bfe2sm8053538wmb.47.2024.03.25.04.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:05:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Brad Larson <blarson@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amd: use capital "OR" for multiple licenses in SPDX
Date: Mon, 25 Mar 2024 12:05:15 +0100
Message-Id: <171136466537.36729.48377468659514562.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208105314.129095-1-krzysztof.kozlowski@linaro.org>
References: <20240208105314.129095-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 08 Feb 2024 11:53:14 +0100, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> 

Applied, thanks!

This was waiting on the lists for some time and no one picked it up, so... let
me know if I should drop it from my tree.

[1/1] arm64: dts: amd: use capital "OR" for multiple licenses in SPDX
      https://git.kernel.org/krzk/linux-dt/c/0ee41698e633d5d370fad06284cfa9b693937499

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

