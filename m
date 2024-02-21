Return-Path: <linux-kernel+bounces-74433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924285D402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2AA1C22E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA5C3D57C;
	Wed, 21 Feb 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqiBVoc6"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590583FB26;
	Wed, 21 Feb 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508513; cv=none; b=OjM8St2IgJv08XUusVZ5kNVP72fcGO5GE8vxBtmMj4yl3GV7JfnCm43DRZtvbMTlbY2XqkYyvDdXvKewKX2IddNlsRdctiv0/sFsCoUL5/S6RH00qUg/VgDQDU+p1G71qpor2omaCciXNQ9c1Zphqu3Vt1ZYZPnIt6R7IgRFRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508513; c=relaxed/simple;
	bh=KvrYko7yQ7YG5N9k9gL8eUh9EO/Yp27eJfOJxnBH0qs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haQFA8qR0M/Xl8YovzQdjrGY+tGb3TtfgthD86pUbNjFFU8i+8WnDUKbRzih65maKPcxFaCMHw/7u5NIgI0eOFGGP/HlXdd24jLC9X/yPeZZpZjH9H8EeiSyv4z4GwwyIp7GY8mvRq7qSHeR1upDRqd0lp47zD9hNtFEBWeBcpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqiBVoc6; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c15b7b367aso49905b6e.1;
        Wed, 21 Feb 2024 01:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508511; x=1709113311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeRB8Ae3MB3D0N5Amo8nBZXsnfNgL0uq7S0EnYN/MPk=;
        b=UqiBVoc6SJNPBU2POP6NU5APTwiR7YxERLkS9T9OdZYU80+/1hx3b99nihZh/pfEf9
         /HAlCItJZ1ki2V6ktsskvfZgYpS0WwvJS0iEf8xvNmBXkzK6CKqbEBtcsMdq0zX1ViVX
         /7GmZvnhr/xSq4Coipuj8eouCClhB/cjRW6H5sBgyYPEA3XExniOYuJYKTKsWLfrvmtY
         QufLQsG62dRwMCBKeeblK086NZVZIMByLyGLa2FLwlhnDu0k3VDUZohzLsbMWZMH1zcP
         pdK7L+BcEw/nw6j6nsLBqwYtsnCx0Xic8/WUdrkiY7fZw2MGeZrTSgkX+Rdw46s/9OT2
         vWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508511; x=1709113311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeRB8Ae3MB3D0N5Amo8nBZXsnfNgL0uq7S0EnYN/MPk=;
        b=rbpKkuiB7MDW3awaTJ2IgD7as4A9P3edKRIbey4LGSiCaQIb9L78KFvkL/DRdZfM9a
         QipH6e6zJY5Q/7kLm5mnI359T0PdG1ld0Ud2KHbETuEWrTr4eK5VH1CHYGSTVGBQtCwe
         tdwcVG6jJNLmincnICy28dUBF/2V+kz+D4VUqiGOXwrludSayHuyX4BWXqKKDUovVZdC
         aAGyg6GZk+rUywjlWdY4HaZUwT2NA7LUK0OqoXb0AJwVHFj69F3ONuTyhyfSCH6kPQ86
         7uHjjzGrBGIEi1ClMzsvFS1NAwuZImYUYdo2QBP7qBy+Rbc+BSBM7I/sYBidBlx4KsJA
         A1eg==
X-Forwarded-Encrypted: i=1; AJvYcCVCnJmLM3D7mYeSLsfcugvuFkBDIAcnSc1xIhC3GHVtnvbMLaQ6VJTc+Oo3SRz6nikIBn+0oexkqpaAe4o76mndvLAAGe9oJ5yA+gfzS54klzx5YuVeD7q0nua02jMS8qGIgKLtCPkgpg==
X-Gm-Message-State: AOJu0YzaRnAX/pCX+tAIt0TB+NdA+QRMDa4dAxlrn2bxTONkILEIt8xM
	PUjO2A3G7JUs0lB9e9jSQgWT1h2YylysqsGrbV0diUD8brK9rymT
X-Google-Smtp-Source: AGHT+IExxMpSW5KGc7JdiMVfUhTqkZRdgnXU7hINm16MFTbij3Pmc6wBGllC0RqE1D9rQrP1LC1JKQ==
X-Received: by 2002:a05:6808:34c:b0:3bf:fcae:17c6 with SMTP id j12-20020a056808034c00b003bffcae17c6mr16681430oie.30.1708508511591;
        Wed, 21 Feb 2024 01:41:51 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:51 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] ARM: dts: aspeed: Harma: Add ltc4286 device
Date: Wed, 21 Feb 2024 17:39:24 +0800
Message-Id: <20240221093925.2393604-10-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ltc4286 device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d5c5c5b3ab4b..bbbab8023cd6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -271,6 +271,13 @@ tmp75@49 {
 		compatible = "ti,tmp75";
 		reg = <0x49>;
 	};
+
+	power-monitor@22 {
+		compatible = "lltc,ltc4286";
+		reg = <0x22>;
+		adi,vrange-low-enable;
+		shunt-resistor-micro-ohms = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


