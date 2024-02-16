Return-Path: <linux-kernel+bounces-67874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B62785723A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237C9286D90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EA53AA;
	Fri, 16 Feb 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DxDCxmkx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E17F9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042125; cv=none; b=AIQFySvJ2gHjBV/sLl70sA2tulY1t5Bs+1I4W4UIF6JGiWZ6AEXH4CbWUYTOi11NqTN/+I/AqRZhzq7LCbLJ4GoZTEZZEffIJDnqbHPyhTwdUCPuNC42qh/Rj4xR54LoHuThGzFMPxitwYQBuFKrFvvhBFfifU3oCInkfgzH5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042125; c=relaxed/simple;
	bh=+ztwmbEweby5bHFMBlDPRY9F7IaAz7efgcfvXOjOMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtINdjCUmCoaFUENDLYxNqIizMisAou6ZZSS68l0gbF2MG4ki4fR6XmH3QNknndp1cgxn9Qx6IHRcbuS0Wq6uCVGWlBAcTZ0Mr+BJ+jKefWEPvw6qjx7ei/XDHP1mSsKLnfeoj5MsZwZKiZlg4+NZgTm6N8rU3vMO/NZeoxZDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DxDCxmkx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7881b1843so13147205ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708042122; x=1708646922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oULp81TNDm6rtXJp1+1NlVw8kUN7N6Lx6G6xlg9BNVs=;
        b=DxDCxmkxjrrukDu9xKwUBIYHc+JGcrFCNIUcqbUex3+GhYvfHY4QKNmZDYQF5bg32W
         1LZf4MdOo3ae1YogH6bNjOYX4GJ+4SvREvRnZJAye+iIRMK1TIbvaA24P12yZ07A8ARA
         D+XPXiB3RcSHUFCBbOHGYJZs4xWSyUp8To/xxuWUNYEqftMOMwZ2SC8B8FAYPXpIOgEc
         zVK4q9r9rJ5s9FisZPtsryqa0sD7A4kwfk9HGJ0HF+0IgIzYHCbyCiBo2OADL1Gfiya5
         iZT4vjEqE/6BX9N3/sxNegIejDaVAsqFmS9mtGQeqoLAvkPo0Tg3bGnpJc6/yxEuYeqv
         F2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042122; x=1708646922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oULp81TNDm6rtXJp1+1NlVw8kUN7N6Lx6G6xlg9BNVs=;
        b=voLaDMcx7GaI+sMbLX0+aMTv0cU5PYE6q7rRUES3GOfWaCfKvtGPoU1ohTiNZYmkEk
         cnSnlc4FyXkYaSrQiJpi9OD/71GmaVSf2YeDSvAF2M76il5Oh0cqB1EtyO5WPR4VEJ6e
         OM46stEuM1kWSzVfFqieGkrJMkQFQqzSr0e9U2RkUoCMnWT4eyCM6fjb80PvQbV5rpEH
         xTePD4jPkc08atyz2/f+yghvvbII29Z5YssaVNqB4SabAM2cG6XxbEE7YYtC+TeVTk/3
         rZfE7hRt3HJremtfG1DWtDk7YX3pMLS6AdG2i1XYwcyX9qgOi/dn+ruBxK6IF2s/j7jT
         Uywg==
X-Forwarded-Encrypted: i=1; AJvYcCVkiiwK+4n0IEk0BtNh0+EIWBOvQ/bpn56e1oWzWEjLaNuif6NOJ7VeLe6IEGZjgE1B8Dx6V/llBFLAh5PBZ77MRpkVylJRsShQ7JcT
X-Gm-Message-State: AOJu0YxXlr1zQdFiJwhiTtQp3FNGy0/d6/8RDTfE+o6YkPxiNArWjvdl
	HoZpm6IZSmkMZyOn7quSZ+wiNfe8qdfwQuiU7a3BVcnqR5oJy6NVFuvWgg3d2MM=
X-Google-Smtp-Source: AGHT+IG7WoMFGu0/RfCzt3XOL546mMsF4SOL7oXhsNzvqoggBob9r4cZ+ZAFJwFNFVhaS4ZZGy8jhQ==
X-Received: by 2002:a17:903:1212:b0:1d9:14fb:d142 with SMTP id l18-20020a170903121200b001d914fbd142mr3570668plh.32.1708042122114;
        Thu, 15 Feb 2024 16:08:42 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001db3d365082sm1789486plb.265.2024.02.15.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:08:41 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Lin <eric.lin@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v1 1/6] dt-bindings: cache: Document the sifive,perfmon-counters property
Date: Thu, 15 Feb 2024 16:08:13 -0800
Message-ID: <20240216000837.1868917-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216000837.1868917-1-samuel.holland@sifive.com>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SiFive Composable Cache controller contains an optional PMU with a
configurable number of event counters. Document a property which
describes the number of available counters.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index 7e8cebe21584..100eda4345de 100644
--- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -81,6 +81,11 @@ properties:
       The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
       The reserved memory node should be defined as per the bindings in reserved-memory.txt.
 
+  sifive,perfmon-counters:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description: Number of PMU counter registers
+
 allOf:
   - $ref: /schemas/cache-controller.yaml#
 
-- 
2.43.0


