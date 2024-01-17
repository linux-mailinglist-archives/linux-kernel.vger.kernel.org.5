Return-Path: <linux-kernel+bounces-29138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD6830961
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4121F21892
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003212375D;
	Wed, 17 Jan 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWgK3Gdz"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0D23745
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504345; cv=none; b=bvBeFNxg826ohOE7LFoTc3ksru2Fv5zqIA4P4rp+Up/HFzQEU65yKpEVCfNx9JPnxls2VwE3OzgPL6uR5EkaTdeWuRfDQWLcuhjGm9e5umDnkirIujZ9FPf2XXnIsv7ijNiuzkEF63oTLX8KSxwJqixHeuoPieix+hix/oscGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504345; c=relaxed/simple;
	bh=GCZrQDHaMa0VPIX4o4j8+CDBJ3xXXLP0Tb/HGEhCxls=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=EcUSKs/bIz7nWD4/PHTvx+7yv43JxeJ+iXkzqatwhjgQvqGjwJt0I86yVWqCngX1UwuQjBx37YcH/3y5EhMsIFWQXFHT0K30TqVZW75jPdVzwhb6w8lFbt0ZePSq+vbNEls95xIvhtMJkxUDKd2FRf0uGdQu2CMS2IBhrC/GHUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rWgK3Gdz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-429c00bf0efso42480851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705504343; x=1706109143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixH1kcICmlswgGdL4OCIid5fgK6X+yz0saxJFyTHsOI=;
        b=rWgK3GdzTzArrviW7WadgwybrfuFdRWkr/vi3LRCs0Msc2VwyXdiSWOiBbmX8a5Lti
         kj2a9/PR7wJuH9MfqepJVjszeufZglTz8R4gtdihi62Zd5l+l5UobnYdv7f2V+eoWv4u
         I+lAOOQD66+4ydV1XH0b3AFtB6fiKSeFzaBlmaNC3x1nFD8+a0H/p6MXeVo7/BXyrKSg
         4pIo2L/q3GAtfLTdZ+xY430BZ8d2hB7GZgzdvC9AT/nky5XCKbeKYEcjF9l09uoNTu0o
         z1Dn5KI/pXNSggJt6d1d8kQi/C6tgvPDVDxtiY75OrWLO/o2UEAgrKDjBU0cRDloakhp
         wNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705504343; x=1706109143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixH1kcICmlswgGdL4OCIid5fgK6X+yz0saxJFyTHsOI=;
        b=Xb+uUHNSHCURCkIiBuP4ulJG9GTyncwVGMLHcuTIuMNxt/NlEBuV/OQTyrNVmA1jD4
         sdGlFTWtD+0TpIEUc+lTYoF3nmm7dflfUcNba5dmn2dULYogB2VStBHP6kOPwARF2iso
         Ox45rvc8Rs+LM0ji/wyi8UA/qvB6hO/5XPeYdmZ5AR8lulgWHtUZZUGMbM9K+iBF1ulx
         pLQFT0e42e4ywj3HOIF3D7hCJJMDEDEeJdW9lgo6jlg/XgsJzTNj9QzwKbkzC9ItZ9Gf
         DcpA8PI7kmLCLSG0ASJacSjiS2u27aM+r1FofPt5yy6cTibR9QnkanYFE6YbaXwMXfKk
         46lA==
X-Gm-Message-State: AOJu0Yz0EW8lOYJT0YAea1fEf2vpwOLPaTMhBCgSbu2KMO4Z8U8pORmU
	I0o1D9W1EFk8FGgMqsJd9+wI8GeLCPzR1g==
X-Google-Smtp-Source: AGHT+IGKpZZkvxd3eMsUpIls7FJA2Nl5Ug6PcJy3m/KUNJ109oGm7KrlaXZDhPDpTPidr1LTLydhHA==
X-Received: by 2002:ac8:578a:0:b0:42a:733:c26b with SMTP id v10-20020ac8578a000000b0042a0733c26bmr3066083qta.54.1705504342921;
        Wed, 17 Jan 2024 07:12:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a24c700b007816cf21f7asm4519337qkn.76.2024.01.17.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:12:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: codecs: wcd934x: drop unneeded regulator include
Date: Wed, 17 Jan 2024 16:12:08 +0100
Message-Id: <20240117151208.1219755-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
References: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver does not use any regulator code, so drop redundant include of
regulator/consumer.h header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1b6e376f3833..6813268e6a19 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/slimbus.h>
 #include <sound/pcm_params.h>
-- 
2.34.1


