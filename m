Return-Path: <linux-kernel+bounces-76164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D795985F3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E761C236B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4E364C2;
	Thu, 22 Feb 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXbWQKwZ"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56C2BB13;
	Thu, 22 Feb 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592362; cv=none; b=GD6xPbst9PMPY4XBlV97ey4q0vVvsHRDDnttamuS5P0KL5e2ZIqCf6/WzJAQsSnWs29qucTmDpBTgI4AZMdb0L31eMzigzgGo8KP4pvZvCLBK/1PyH6AMdvnAEdXxN1HQdLA6wRnGXTzbtispnqCM4eLVYrYa9h1Rn6TUcFajkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592362; c=relaxed/simple;
	bh=hotKw/G50Bray5/Zh1vjVRRxVKvESkQxWrfj9/dVSpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaKTnkbaPurd5rd8hJ00Q+OwwQyarp8juOhf7YLhoale3kiXNzNeqyBlFP7wKSylGh1JEzJLb9CygZCdZ+kIQ1g2vmvsT3z207Xk5eJA9HsCwNT7S95F/RRXxzw1EgO185DlNwlV8Q4smq08ybAXymJ9Q7QzmbyVO5l6wjA8Pd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXbWQKwZ; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c0485fc8b8so5896181b6e.3;
        Thu, 22 Feb 2024 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708592360; x=1709197160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dug1XgLbh8Sb0ZiHV0LuAfIHY/1jxdnm6P7dtGz/eSM=;
        b=BXbWQKwZld8WSiUC/AthZd9Z3XzvlzIrdKNdhjShQFA5oGzkReYPd2kDl8/5JG4ch4
         XwHfJxvXn7zHfWouyCpCTnsJzHi7ZLWfPHs6elCbF8x/seW94Yk34L5UfifEPRBKcB4A
         eT8m5WNiPEYhiwQ7e0p6VzEQ5535cZYpG2vMr8I7SUViI4VXglojhsUOJv09aVS6PyP/
         YLcU9bx3qdVJgAVth09iaBISvYyA80FFRuoHY2vpv7RNa8U4owJTVNaiKpX7f36gs79c
         m3tcOFzSkYO0CWwMz1Y0XBblEab0ZHPX40STbRWCVAXin4XN/Sa8mut5CwBmBaqXO4zC
         uj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592360; x=1709197160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dug1XgLbh8Sb0ZiHV0LuAfIHY/1jxdnm6P7dtGz/eSM=;
        b=J6AqIhaGJi2UhdmqShAfJpk+uRcZVSOEZ6dfp7/1HuqK3QKomxXJ6aWtxQiiAs6joz
         PuF/L7gWfyVz+gQ21/33Oq3Gfpo7fmhphhFzNniZh+qoBojTVfOvqk/zFY8V+7KTaNTK
         f1cl1YjVtjYPL1dEeK4p2GM8egubSXlRH8z7KoDOC8f+rPpPPA1Nr8ziEVCfyWglkboS
         /6GfSjw8NLGzj+3ommCJdv9GiCCrdW2dawOb1rMpXwuA66b4E5XMdX04Df/M7i87YJ5h
         4Yn6VrSyvM411Bqud5x38jy+qPIsRuj8sjg104OF+WEgPV0P/G1SC7vER0nE4eEL5w6T
         5TsQ==
X-Forwarded-Encrypted: i=1; AJvYcCViqTUYD9pSSuHIh9Eyt6IVTln9lkBvar9UW8sbrH5dixKjzMmxVCzUhL5KBp8ALGJMxKlAeDOubWNgRzZYIiBN2tDq37IEfujlgoUcbensIG8ehd6+iC0tydPsQroBILlJGV6w7Ll8Cw==
X-Gm-Message-State: AOJu0Ywh1OjTHVcgayovccyssJAyahh/yUg+hAiX8e5JI0y+wdoatpUu
	EBIcrny1PR5QxfOca5jAZqloEijhi5Dl72NkeQcU4H7/Ve/IlQru
X-Google-Smtp-Source: AGHT+IH09LjjSmuZp7oaAj1rWPbM0EwTzWDF80+d1tcfK0+B60TIkJ4txhqEo3VGbqEXT3k3nGSXvg==
X-Received: by 2002:a54:4898:0:b0:3be:d897:2880 with SMTP id r24-20020a544898000000b003bed8972880mr19100999oic.52.1708592359909;
        Thu, 22 Feb 2024 00:59:19 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id k18-20020aa788d2000000b006e4cb7f4393sm922356pff.165.2024.02.22.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:59:19 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Thu, 22 Feb 2024 16:59:13 +0800
Message-Id: <20240222085914.1218037-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..80009948e 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


