Return-Path: <linux-kernel+bounces-59294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B71384F4A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF9A1C230DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C152D044;
	Fri,  9 Feb 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northern.tech header.i=@northern.tech header.b="dmQ57Xu0"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FC28DD3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478160; cv=none; b=Mc/Gw06cjaB3mea/7eVMXAdbaHCKb+/Aqp8nx+I6DpEU83r21YOjHbyyUGlOYC6PmKU55J2z2iqmlI0S5Hw49hpBWfrO8c06obKdj+y2v2s8GPzT03OCt8zxnzVZBhRSs5uXI6YQhlsbxPOnJhBj5n8Rg0DLPHNkAtkbc+P7Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478160; c=relaxed/simple;
	bh=uXn05HTNeK17S4EFHfrNe1D1KfUmXrN5DtMJAXiQlIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ojv02aSMq9S1XUshz2TWGNWYQFjMmBB0ZthW1LMnUVXjUhK/otdcMldN/1hisWf9EWxUkwexRn4y/S3NyevK8ZEfCc6aVUU6bFi3ow2JplZF4tnwFmen/V83XvwSfLZyuehZgixeK/M2Q6l5Wv/IHaiCW4U8Ox/hrQVwgRMnM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=northern.tech; spf=pass smtp.mailfrom=northern.tech; dkim=pass (2048-bit key) header.d=northern.tech header.i=@northern.tech header.b=dmQ57Xu0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=northern.tech
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51032058f17so1027335e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northern.tech; s=google; t=1707478155; x=1708082955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyFCxCsEZK8CXF6NB/E1Fpp2yQNMSs6bghTaRTsKzw4=;
        b=dmQ57Xu0u+X2r6e194nQ5LMpIUoxNm5MWgwmrzyHmtZ4pjXNUWx2zjFobmlN9At7uK
         R1ZjNi5JIc6DHO6f1hFjn2/xMWC4Sr4Q28PHaLKvECQCixbQbYWmtOXAj4EaHZJPmDg0
         NvYpeJ64AvqgkGvCPlQd3v0yWQ9McUC7hAH12cqVZtRB9px9Stnql32klOWwYNgwyEDx
         aBdzJuVaMdrXhTCxSszes+Re9O6ERDVypjDhYxqZBqXtwGGQknmBTEr7Jh2nUYNOjuuj
         pT9zvFJ0mwiJArsGq+ugR/l75ZXep7olvqxs8dDrrtf1LAt3FNg/o+yLqG6yKN4ztiQV
         iIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478155; x=1708082955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyFCxCsEZK8CXF6NB/E1Fpp2yQNMSs6bghTaRTsKzw4=;
        b=qaDrsxQFLxCpF4Qfm4wB6jWerIoxmnBBlP0mQDPqbILkdOJ8SCrhfoY4H3l7es8Ixw
         WJxtZxp+gjdhP1qt/NDpgN02WDZi3EGhIZKjHaKIOTZzmHHpVmqzz8s9b6oRbCPwB2Ma
         s641te+g6PgwIRmcmDp2CjUHIgbY5fsI4HinKmC9fznR2wCWKY7BPBkd7sVAxPEKr1Qg
         fpyBAelI4448AOGxJGX7mvPKvkQX3+97m3ZMDaPH8OAbAZJIhbQFRSxlerOatmOLbDd0
         Zq9SQpUB0G1c9+wwC3FiZUA5mboLDBOBcK6z/hxYQYclkO6K5hEOMv9uC/viZJfbPbUc
         +z2A==
X-Forwarded-Encrypted: i=1; AJvYcCUyPv9eZS8ylO1qjv63GL6gYSDLhlTDPPWIchSRvlQuBjWZmhEE73fV5LKJBc1zPoMqn0LbeB9QkPYUnmhGiBstsfbQneSOf51PErOd
X-Gm-Message-State: AOJu0YxDMBlxVk1Mq8TvwuFFnyWbN0h+fsKvrUxUKFZ0jaiwtJA0ySZX
	6qxhavJnsAFhvYUmWqHdJKO20Nmb8fyA2gKRYzdNnfKeCAU6Mr6OWlmNNiRY1O9Tv5yfnVbIZMb
	2sqh5/Y7v8i81BmrECI0LSgXrdKbmZlo40NPYdn7xkFntX0/FYS4mTo/OZyED05+3M0nM9Q==
X-Google-Smtp-Source: AGHT+IHdzCEB8/xRoowQ4A7RyhL8lGJOHjysQWb0vn2jNrf+kFLWRRNAzDZxgIVVWWQLQrknLNIrHA==
X-Received: by 2002:ac2:457b:0:b0:511:5f08:f147 with SMTP id k27-20020ac2457b000000b005115f08f147mr805451lfm.25.1707478155262;
        Fri, 09 Feb 2024 03:29:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcS4zzPPC8FbJWfRCm0E7vCFdz+Z6eLuubnzXSb/Qunsfwwn8BDs7Gp9P3jWMbydXyKGob+H19eU5jxd1ZvAZrhWJdDfeOaJjLwNnJ+RGHX2ouGPEL+DqCvSNYaRPabg5vG3ie5gmkTqnqD97f/0xAFoQIhj1hccR3lbpRAgPkCQdbkEO4pswpz9JqWStPzDSIFbiyE6gGyUUmTN3NnjHYuaj+cbjpx1CmJfHnn3P/XICwg3NBnqIfXiFt8W5JAIkWM/ccTFpoFHIcdy9fzYMNQq9/Kqz9n0+ehR6ez0eLxLCzIYV9dm9rDYHnexbIKSX87lXZZPxbsf/JniSuiKBw9EWm95qnvAT2TJX03ef51TnaXacx3eRXijccb/9/qiHn9PBzSdKcwJbP6Sw6hs1l2GRxU33PyJqV289Agjz9nmCNR+UqSXnWgIW2olcBcdeYNjGnCXztO8KW4GxDWy0hDfp16GgZLwA3DKQhwD070i6ZFc3jBUn08KXC6dbaTyKW20W0wseUswt0PwyflnI/Jdhbr6Af9g==
Received: from olepor.localhost ([2a02:d140:c013:1837:ca5b:76ff:fefb:c875])
        by smtp.gmail.com with ESMTPSA id h3-20020a197003000000b0051154ac7267sm264061lfc.25.2024.02.09.03.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:29:14 -0800 (PST)
From: "Ole P. Orhagen" <ole.orhagen@northern.tech>
To: linux-arm-kernel@lists.infradead.org
Cc: linus.walleij@linaro.org,
	ole@orhagen.no,
	kristian.amlie@northern.tech,
	"Ole P. Orhagen" <ole.orhagen@northern.tech>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Shawn Guo <shawnguo@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: dts: vexpress: Set stdout-path to serial0 in the chosen node
Date: Fri,  9 Feb 2024 12:28:01 +0100
Message-ID: <20240209112807.1345164-2-ole.orhagen@northern.tech>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify v2m_serial0 as the device for boot console output through the
stdout-path in the chosen node.

Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>
---
 arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
index 5916e4877eac..8bf35666412b 100644
--- a/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/arm/vexpress-v2p-ca9.dts
@@ -20,7 +20,9 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	chosen { };
+	chosen {
+		stdout-path = &v2m_serial0;
+	};
 
 	aliases {
 		serial0 = &v2m_serial0;
-- 
2.43.0


