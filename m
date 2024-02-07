Return-Path: <linux-kernel+bounces-57272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8730584D605
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E785AB21515
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F71CD22;
	Wed,  7 Feb 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxX+C25m"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E271F947;
	Wed,  7 Feb 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346011; cv=none; b=btC/nANacixk6DZmQ5XnCNHi4xWvWs7/24wsgjCxUCh4BDK/zKAqJYH6vyeU1oEnKaaIQR6QBT4IPzhhz8eHzAxFp9SF+L26aNsViuCz3xi6ra3Jco8OKZSyE+01SXybHUaRd54DU2oH9yMkdHfBLdrxlXC5O5PBy86OsNMNaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346011; c=relaxed/simple;
	bh=x+UHYL03txX/IiQygGKZy2oVnfJX5rWtBgj4pmbaRd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bct1Gosu233gpcvmjJFZEZHQRfDEhdXjsH8z2M/gJpA7Gm2COP2Ee81RwV4j9KdKLLaxzb8DZ7HSmOYkT53FXHuyymM/X3ohMlDM5+zcflqLFG7xgCWB71sk309qrNkGGSPvwf0GQBy9kxcl7+54/TA2wwoqEwY2qtzHhEUSgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxX+C25m; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a38392b9917so159954266b.1;
        Wed, 07 Feb 2024 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707346008; x=1707950808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9FdIPkRnRC8GFhXD7gXQqpwUiJyXPG9kqjvS6nLa3I=;
        b=fxX+C25mnyIaPjiA4eK8qrUcD+GlqL/hP/WBrNZ/nANatovtEaeQ2vSGNhx1AtTulS
         gzzh219iBoReCUn0mXInq0IcuVU4oyzOoF1wDjXqY7+6fHmXrMvpgQZDiS/YVTTWizEf
         ydtxgvrpP7blXD6SR15HUy2HyGk+ITiYxt7VUZQoxOQbGQOhtcfWkxT4qEv6zMH9IpmC
         v7leKcG42jCMc0KHyTok6var+1AfPR+IhM61bHr2CQlrdWlZ9d4RhJmxVqgEceHzPXW5
         4v2OJ5AV0/xi/XriNtsvfo3GaMhAv8NwacTlc9TLAm9mrSB8DoiA3kOQC9KoJPQkjlia
         eD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707346008; x=1707950808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9FdIPkRnRC8GFhXD7gXQqpwUiJyXPG9kqjvS6nLa3I=;
        b=DaSQIWS4O/qujv8Bgte+wkw8c2Rkq6l4mt4yU+ZzJztWAMUq7OIdKTLda7hyeDZ82J
         ywbEcmcF0qkK6U3g91m8pvZsHJYyqm1PGZqGEtfjikHoNGUGTYf99AHkzhVfXA7zRNsZ
         V9xjVOSRaWfOMQB8fLRsUD28LBe+8GvSkty1iZTN7NAN7evwip3Gk2adWlk2E3dcIU3E
         36KCAL/QVTRF20Ji6W3V3fWop/t1LAiaSeuGU8ocRVxOg57wOXHWDBP2uyf6w/p05DsP
         BEJFbbSbu19d0dKSeLhwOzcPkoYC2r7s09nc/WY44amHZMLgxEWsrImNeiF+T18rCePP
         8yWg==
X-Forwarded-Encrypted: i=1; AJvYcCXyXzzWTxtiyCRenjCcjlRNWffPfLrn6QAWSj4V18AES96HTswn34VYzS9v+IZMBFtnEMyX4zY4yqMdylxOpPHAYCQyIgJquxktJLapRreMtl6DDH2/YNRUlgm2UJzMrZCKTYsDPKJzzgLqhAIV1pqOAtNuXDQU824sorWzPzd9cPXFjA==
X-Gm-Message-State: AOJu0YxWlWfgMX0AUjxQgr075Ad/RCKpmHMMU0zvOseFFDqyMWa70e2j
	TNEaZsSbc0RnIIlV6me8rkXo0D+Zlvz7k58pp6/BZceYMcXuND4=
X-Google-Smtp-Source: AGHT+IF0QPdMVJv15K2QOPbQPEqVG3lS1RLcmu2yTzxDvSwVgafg9vm3KWdW0FMS+sGUXy9xtRSTuQ==
X-Received: by 2002:a17:906:4a06:b0:a36:2da9:987e with SMTP id w6-20020a1709064a0600b00a362da9987emr5411183eju.5.1707346007918;
        Wed, 07 Feb 2024 14:46:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCQGQ62weSy2cPNUhFKLGMaBX4yA3vi+Q4FwaRc2QfdqBVHdUU2AIXB1XmA2UzNB/pxkVxxWgAn1G3mhrRmt7h+Nry5xb6oYYTpe7R1trhIuTKeLuXveDRNcmTAeEbibfmvNZMwHcdHEoc3yjSdO33WQ9RfyayLggJjzxMhdqiHQjCEA2MyogqUG2Ahytm+QLAjAV/aQGp+gbj3oiwqGhsDSc4eu1JN14EndRtcAddeVAWcfKaLjMauP0Lr6HeyovnZw0K3P8TTM8ZuLwFqyu0GstptVBvCqCHqA57kgcUpWthyTnlyicQGM6YTXOhO//mlt8xs6vadtilkpwXyRcra+9oFx11QFm0eUxQuq1rfKWyUi6LgXGTd3dK3czQc22i4tg85uodn/ui8Sr9OeALgDEPszdzgpXQHS93CfPYXH3QEEMzCY4Iw4Bw7rxCbaV21jTKfY6G0JDHMraLDFiegxZsbzvH42EVMgcgLdi+ykclr0n6aeYoWprAiSPQ5rWbkqOVbm1b+9QJIPz7xodU++g8zDD3DdmKwP0kfwX3B3aCVFS1xfBWQdZU50NszyGPo1vfT/Y9hZ8h4Md1+lLpz1AAlCyeQZypCQ==
Received: from frutis-latitude7490.lan (public-gprs393011.centertel.pl. [37.47.166.116])
        by smtp.googlemail.com with ESMTPSA id rs6-20020a170907036600b00a358b6242fcsm1217449ejb.114.2024.02.07.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 14:46:47 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Michal Simek <michal.simek@amd.com>,
	Marek Vasut <marex@denx.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Fabio Estevam <festevam@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
Date: Wed,  7 Feb 2024 23:45:23 +0100
Message-ID: <20240207224546.44030-2-frut3k7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207224546.44030-1-frut3k7@gmail.com>
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <20240207224546.44030-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Qualcomm QCA4024 to trivial devices.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 79dcd92c4a43..c6362e981920 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -309,6 +309,8 @@ properties:
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
+            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
+          - qca,qca4024
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.43.0


