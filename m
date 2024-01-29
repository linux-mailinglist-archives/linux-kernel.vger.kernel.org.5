Return-Path: <linux-kernel+bounces-42921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020C8840895
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CAFB27B29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC08153BD6;
	Mon, 29 Jan 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3ud7PUj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC7153506
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538941; cv=none; b=Xv6QkzPAkCUABa1TSVSoi/wdFdCvwS4zrv9et3GJdbTM99CLWLKaV0fqWge8+jYDdW6uSwJh0/BORxVtLWbm1N+if2J3XWEE8u7aW6wPfMZCgMoxnoJual9fOcr/kzRRgEMuqkXoOxRIomMZUSzyT6OE4quhIQEBiRdDVi2soz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538941; c=relaxed/simple;
	bh=qKIghWBg+M0Dh/XZ6bWHGX2p/hwwGIxP2PIhUEg/+OE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svpmCBPsNWCSIrc4aG4A9UTbgzRlCMhs8mK0c1M5+Y9yJ369600TojI0JBWAhsbixgqDXWi+yw/s3WN4bhang6EjIfnGKZgvEpdBr66WZ9LUfHzr3MHvUOVfr/AZxHlMn8PCK7zwCi79fnGqsPbH7uF+fyCJgTk9EHcICeOpdUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3ud7PUj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2a17f3217aso391083966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706538938; x=1707143738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPhPmso2Tukg7NLAn/+WM+BVJTCFnMIZlThVcM5mWHE=;
        b=q3ud7PUj7QPgXOJC82NA4oNlvhXZAQdnuriLtsvTs6sHKMckXdGWl6kNtCdLxklRSS
         kMxP+8l7HK+Nvl9a6rx87NLlZedgak0xw8+FN4eefC18kxCnjsOAS2ZGNH25z/TRL2sw
         yEnqZbNXhRsal1GL7OgHB7Jb1fIvUtnqc8BwMYRn0/6KNiD00+g821N0GH7yYvComv4W
         Nn2oq1l13YczCaU/2OI1Ark7OKGpmslxCC/7Q2OsYo/nLo3ii2rTmITAiq4boI+45SnH
         6ZSINzmUCyx/mLMnyAq2XkS0cx2PDTR9fP+DXX+hrSaABxPqG7RbDSNYD3uS2HlWpqOH
         HAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538938; x=1707143738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPhPmso2Tukg7NLAn/+WM+BVJTCFnMIZlThVcM5mWHE=;
        b=t1lWqSsYJqA9LTA2CyJhj4nZ+zpxFBFEDE5AqbIAkaIoPrTk9EZ2ASSvnBD5jzw0ZX
         2MMvCiRdcdngNINP/ZKrVPl+MbdSXuG2Zm5oiMVuu5Hcym10Hv7RmRDjz7+dscNJ4Bhv
         HyXpCsjrL2hpP2CfZXZ+QH6jtACiJaPrtsnXpPv7am+13EXnNPrREBjid5Pu2NKIGTtq
         vj8jnsp3N0B3YwgIzdU5MEnjReuHkllGu1Lhjc26nFDJboKEQSsTchMciQLUDnBvSNaT
         KRWqjyuQwGu+SwcLNJCqZ0IdJAv3QDKm8C4ZOwePlBON3S/710dZv6TZQFmdmn0s45dA
         74xw==
X-Gm-Message-State: AOJu0YyIqoBn4FIXgDiZR34u6w7S3DGup8ycS2R6Um1ACIM7cqsSTcxX
	k8Cr0rb9x9WiULkPeqneztYtT3PvaTJdbQgWCGrWus37t13Xr/DTKksOrHNVd98=
X-Google-Smtp-Source: AGHT+IE/jmjtAp5FGOJs5Sf3U/EU/Onj0B5A6BEfEU+D04XcNvdeq48Brg0CKZMpP1rEhlTanM0D7A==
X-Received: by 2002:a17:906:3c59:b0:a34:9a5e:e15e with SMTP id i25-20020a1709063c5900b00a349a5ee15emr5105302ejg.28.1706538937910;
        Mon, 29 Jan 2024 06:35:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a3543718f5bsm2829269ejc.221.2024.01.29.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:35:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
Date: Mon, 29 Jan 2024 15:35:32 +0100
Message-Id: <20240129143534.109196-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changelog in individual patches.

v2:
https://lore.kernel.org/alsa-devel/20240125153110.410295-1-krzysztof.kozlowski@linaro.org/

v1:
https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  ASoC: codecs: tx-macro: split widgets per different LPASS versions
  ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+

 sound/soc/codecs/lpass-macro-common.h |   7 +
 sound/soc/codecs/lpass-tx-macro.c     | 671 +++++++++++++++++++-------
 2 files changed, 506 insertions(+), 172 deletions(-)

-- 
2.34.1


