Return-Path: <linux-kernel+bounces-48254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CC845929
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0570628CE8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A65CDFD;
	Thu,  1 Feb 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH88rKnd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8753371;
	Thu,  1 Feb 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795174; cv=none; b=GbVUFqUcZefWuddCQx9kZL9atP1NH2rAJTFNbUM1LE1HJ6v0IImuOCLQOUdqXoGetGHXAVwjnL/XueRqABXK0dTfmG/K7FfbxiHOnww5uW51PzzG4z/T5jEiO5zFhQiWQY10taGXUALPtTZL0dXZGB3RWhhTLG9QN58Xhl7GJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795174; c=relaxed/simple;
	bh=jSS3kU/kYXHEvoe19QaywJy92OI0lG5OVz7ViCeEQ4g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WfP5VnOqsWouO8gZ+Csa+dmN//qMA0FlqRBnaY3ExBc06/Soh/LskY1jm6jGbrBR1PXD9rVb8ZMtfXIBsX4PNBh2tXN8tkHWGDIpgGENiDw0F6PJSuEGvDZallJV2HCnpI6SPChjcYCW8NAaVj80qa3zhIm9XiVzJ3fQ4bCluJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH88rKnd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fc2a6f8b6so1728755e9.2;
        Thu, 01 Feb 2024 05:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706795171; x=1707399971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eG1Hl/g1QZ4SFsqJkUJ95bOy1xVsUGP8RzV+23c+rYY=;
        b=SH88rKndQeFY4lzVrqe8+fls1KjhzEJW2NEEWS0TSoKB8JeZoZYeOju2pVIlVys6Qz
         66tnCp4y/pD9+4eS8T42ZwsYJPSNBBd+EuE35/wxEXiJmrufGeBSRYqFFn1UOij9x9x9
         rQYH9MAzo7fogQP/t54lh0D6Xg2UyvfjsurqgNZMWjcyOkvHNysLZ8R1liaUq/QuTjYG
         uOdOaeeoZwzoJfjOp18+m4OFlOKt8HVCLeX+QMsOOhQxrrprjUY1KzA/4RYzHvsrukrc
         meJKrUT2k3DpSMGqY/8rLT+mLIXr1o2yYjb3wao35IH6XzutPzHIhzeImrgDqV+0IZiX
         d98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795171; x=1707399971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG1Hl/g1QZ4SFsqJkUJ95bOy1xVsUGP8RzV+23c+rYY=;
        b=Kw9AdiHkZsQlsnWoo2jB5AgcNDmGwd/tw/LzbyuSCvMN9j3C0QVn1Rs4olG62YTHZ6
         E/FO95AwntBTVsVx9an1PD4EKV99PRJtYJJ0Ol9h9QwlQzAq+LYKUwLg9vGKS2f3o1dN
         Ggpqk4RbQOTRwozMDQMrflbCxh7q/sNYHY+TxHAMh3SGS6sV2RkPDH5D59GqORAfHYs+
         L5U6iGiEJx27yuJ8uPFiCT5hSvx4oXzkbg3wiA8r0uen2nmWt/MGbKs9fFakta9i+jcO
         Qdhok3xl4LWMWnuKv6jcRqiFq0r9xBlK0i97RHwBLE/TlduOqm4V6GpmyVuzZgjlO0S7
         IH7Q==
X-Gm-Message-State: AOJu0YxGwLdWA0yhroksrxgPqLJPUtwg+if+UU5347dZ2zRYuqu4oHcU
	L+XzLLQuuqZ0aXFCzuRpwY9Khmij8eBO3rZKgllaHidJ0SwetXfK
X-Google-Smtp-Source: AGHT+IHVmFU6ijb8MfVbOKpT3CZlGFfiCabmyzt+ymCHEkJo1kE58gqz0YVpLTjBDIrjnicVgj6B2g==
X-Received: by 2002:a05:600c:45d0:b0:40f:30b:ee96 with SMTP id s16-20020a05600c45d000b0040f030bee96mr3847044wmo.37.1706795170791;
        Thu, 01 Feb 2024 05:46:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgWuqDQRRvyHqkAxvyBsj8P9sX+1sn2aYJf9w8fg19NQd7NPgYao55LczFPgaS2lUNsjP7DocUMdZ9qvTIGatNhFn/x3UEXolbrLmILs88rU9JymzYrDKAs3xU1GYjWASo/FhJo/YCZ5S2Y6Ea5Si9bBRRxubGFq/CZ2uV29aYeVGrbzvmaOH3W7u7HTRd3It5/L0BB1vG49+LyZa8ZznpAAPCi0D7pCaKUVUkZmjc7pI8FIjj5375G5qiA9kDI7VCfAt0/XRvO0K42eAb+khDBw5gVWel4aWkHgbV/S4o6cZYM1XrPzOXRFgLBilXy4ANvriqtfJn2MXTI/dRqFhKyrmEQUCF7qcSrpn4LwObfAfSPKo5pSlkobFLsw0+1DEew8rvc+vO0a1gm3nVMBcPAOJOU9nnJ+zzEDLA+Gc=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b16-20020a5d6350000000b0033aeb0afa8fsm11691259wrw.39.2024.02.01.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:46:10 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 0/2] net: phy: qcom: qca808x: fixup qca808x LED
Date: Thu,  1 Feb 2024 14:45:59 +0100
Message-ID: <20240201134602.11085-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a bit embarassing and totally my fault so sorry for that!

While reworking the patch to phy_modify API, it was done a logic
error and made the brightness_set function broken. It wasn't
notice in last revisions test as the testing method was to verify
if hw control was correctly working.

Noticing this problem also made me notice an additional problem
with the polarity.

The introduced patch made the polarity configurable but I forgot
to add the required code to enable Active High by default.
(the PHY sets active low by default)

This wasn't notice with hw control testing as the LED blink on
traffic and polarity problem are not notice.

It might be worth discussing if needed a change in implementation
where the polarity function is always called but I think it's
better this way where specific PHY apply fixup with the help
of priv struct and on the config_init phase.

Christian Marangi (2):
  net: phy: qcom: qca808x: fix logic error in LED brightness set
  net: phy: qcom: qca808x: default to LED active High if not set

 drivers/net/phy/qcom/qca808x.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.43.0


