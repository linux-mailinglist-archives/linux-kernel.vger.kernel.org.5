Return-Path: <linux-kernel+bounces-125887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DA892D70
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CD2833CB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5964D9F4;
	Sat, 30 Mar 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmT1BZSV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1C1DFC6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833031; cv=none; b=B54a9I9KLm7YZF44WhNh/VUVKOFwt5wPPd4l6u6tmbGIqRbelrSguCLOhuu6SUJOJ5u6ne4hh7GYtNl9laZhpupbJrHNnNDdtDjFCkS0hsVM46JCZbAfv5YdzjMjVm39aNWlDgET1vCKJyH7lf9M8rgg6eWPSKmAb38oD4K9TP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833031; c=relaxed/simple;
	bh=lpW/z88igPmtu+dPk6Bg5/M6be2ELRWCA4fiw4xQTvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS1sar1YmDqu1EiUhLsWX/F2qG+ZSKSVVh+BSA+y2eCEt8wgmoH6EJ9zOexB4dWkyFhGQqTnvcW2fbygrJDhDG875bRm2eppfhSCtuoKGGjO06HGP0lMNqNrLmjauiG/vzXcvf4flhuFdNGGG2951cca1G1K2F1rrX2aoNYOPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmT1BZSV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341e3682c78so1744688f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833028; x=1712437828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=lmT1BZSVVSPKWGgHfiytoJ+Ofrl4SkHaGZqmtLrRr9Xtp6NWN1fSkkfDwoAbSdPKGU
         7iICPbSYSWkoUys1nOax8ZNlxpQfq4PQJQ4TymEVCw3PkJzQTsCq7v7Undarn/f2KJj9
         ZG4QV60NcMb/lSCxXyT6TtbE/T3KI3GB/GjHWCbpmLOwf1Xb6WgjMLkLJ88lBAMR3Vur
         CTO1dryBej7ge6pn6C0Ijq3VRNqgK7SDTIyRth+3AeL0ZiRSUM93anFDVLadFESufJPL
         bPQQDMAzZMQiOF9PaZz+2bEIT1afJiAv9xX20LWUpM+NNBMnbp5GWBAf9our8hpGlmtU
         k/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833028; x=1712437828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z97AIqHn2/5k70KD5v0TW9sEzFkZvtBMo+aOjA2W+M0=;
        b=LN6EukO7x/miFXgVzeYBWPBHF5MKaL0/k2usNgFo64rZ+FRZIQg4gENQFEslrLZU3B
         ZslJ2cup96D8c8UluDpZPJzJV64/fKhb9YpCEaDC3X0ZH74RD+lXJ/OTlqxbvDyz6cLc
         eVCqMvicLLr6WTcAxQQGsEBmAoX5nLlQHRzC0GluGPRf+qoCr4GUhpoh+39dGWc6vYQ8
         eRyNe5ifDeY4F/om3TpVDUuUWNYJc47Ttyb8oPqbePV5uPMtx59Mu8AIUHvGuv6J6SCL
         gl9SaszuWA1emQeHafmY4MZdh4AIx4mlRFljqScFOYNODFEtkrS8a+qtq4xcY0O97Hez
         2iUw==
X-Forwarded-Encrypted: i=1; AJvYcCXeykk8WUuo+zuaSq0RZqJlkKLk1Y8uoPTtm5QI278pmyQIKEBoiY2SRzd908hejYalPQRYHj33KLaZKdmOYUlKk9t1FFnsTockcry/
X-Gm-Message-State: AOJu0Yy9THjSYK62Bav46nhST3lX5lfWLL8OIAJIbAf6W6cj047LIyzC
	MLYQYXly+7uMuSNBatu187U8OsQvhNyalLY3RdW8EvhJr88VU2JCCHKEH2BSKfQ=
X-Google-Smtp-Source: AGHT+IG/PwnuOG9GW/J71lWsyeYoc0pzt0O0RZTv5vm8EGRV8pODCFgM8sdpdU3qeNoyycuNuSNCcw==
X-Received: by 2002:a05:6000:4009:b0:33d:6fd8:90d3 with SMTP id cp9-20020a056000400900b0033d6fd890d3mr5016445wrb.4.1711833028607;
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm7288097wrf.82.2024.03.30.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 2/2] net: dsa: sja1105: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:23 +0100
Message-Id: <20240330211023.100924-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
References: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 6646f7fb0f90..fc262348a134 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3456,7 +3456,6 @@ MODULE_DEVICE_TABLE(spi, sja1105_spi_ids);
 static struct spi_driver sja1105_driver = {
 	.driver = {
 		.name  = "sja1105",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(sja1105_dt_ids),
 	},
 	.id_table = sja1105_spi_ids,
-- 
2.34.1


