Return-Path: <linux-kernel+bounces-46265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB5843D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C061C2110C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695CC745E7;
	Wed, 31 Jan 2024 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5ao1Qb6"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396969E03;
	Wed, 31 Jan 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698335; cv=none; b=iTQ3PW81BrcjY6s3xTOii9e1ftW7sSHrkP2DtFSzJJzdcyVH0yvgPI8/4KdzPEqjXHmk9KlmPxgAXeixyeejBe9Dul0+GVG2z/VyNNTFByrVuNExlKktcX138OOffOFSFUXh7IWReWK0WNz0x901eMcikwsvNXy/yxHLtT2GR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698335; c=relaxed/simple;
	bh=SlNK0oOfr0weMAeD+jzFsEe2QFa0qB5VzVfQW3juYYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4Ofq8buOjva4ufv10k/WVayEIPGZjaTwfAUDNyF4h1uwVcyq31d38EOkr8JVuZKLHsJATYqclPIH+zywlunL3Q78sclTatxvzMrM8sNWiypJpHZM7YGRUG55Ngl4FlmowBkUQEBqLBz3g/Dor3PpnjBmsn46sLc5VFUIPUCHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5ao1Qb6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d057003864so25189361fa.3;
        Wed, 31 Jan 2024 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706698332; x=1707303132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+A1jezCER+1byDBGN2CrUyy9/w5awZMP5yKpGAyNfg=;
        b=c5ao1Qb6IfDtQ87oeBoPOlnyUSAPduZ2b45zxnIEf+IB00XMiBBKKLB1zfUBdsUTEa
         HGnt9zRBuMAAuQvJVi86PDF1QUlhxidB/Ue6bz2Pk/AMN4mERVe14TTTBxd+vg62eYut
         61wmKuBBBr+MxjfhJGRL279mSJ/IJTJ4LliZzN15aHeZCIwKyw4SvNUEf5XOI96zWoaD
         7Em5GW8VKBO5DcXh6RrUM/BYJ6XSbohEBryYLu3mfJR8tGw+UbNp7ClIX0JSTdWlN7CQ
         blUxRd7C66UvK/H/bmp3psRG4hUNoeoEp+wtGHcVWyfnA3cJP5RLCVQB7ULCuMZMtVuX
         bTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698332; x=1707303132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+A1jezCER+1byDBGN2CrUyy9/w5awZMP5yKpGAyNfg=;
        b=gp/0Q6zTYEjaznVo5rfe1Y4/j+bkc/48/VdneWxBa/qJo4tdgZPk3M0FR22jX05W1M
         +ZSQd+eVrquXjJFZPKbiiDahuXbzBQr85zOOVQ7OpXLOxI9Jo9Vpndr07gPbQAi3+Npn
         p91zYDY61AirnwuFFQeJ1NKNXSpQahRfTl9f+tDs1COX7ftjVHgILgooaWRwrB+k6DZV
         oZ2j1b7bcNWQI1/zfkSYAalhHUoafVhwKd6R+qqBXhTVJamuzOkNMC7XAVDI6CapiJem
         ZZG13+YpzhBGi78h3sBAKNnUWlLj6ZIgMOfTXji37pbVCB/Tv1lSzbgyvTmTYJboewtD
         xJlQ==
X-Gm-Message-State: AOJu0YzZk3NNENLdqUdnb7gnrCi48+ntj1ujXjyrwyZGgvFE7jDPARek
	6yIqMfEFyK+fafMWC0U52nCbu1T0JCW0TLBe6rCrenL7rZTZOS85
X-Google-Smtp-Source: AGHT+IHiMoHbrG2iF1DrQaSLHk3TTz7Cn8UwxrzxAGFfXsNYu8OyVyCBEitD3PDHqP75eizZyyosQw==
X-Received: by 2002:a05:651c:105:b0:2cf:2c54:d8f7 with SMTP id a5-20020a05651c010500b002cf2c54d8f7mr833859ljb.8.1706698331852;
        Wed, 31 Jan 2024 02:52:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPrB3sm1rRvndMXKIO2k/etxXt8lFAdS4S6TpeDn5hDO3coF0f9uzK6lzVayPD35z1JUXsS5Cx4qacGCuzBjkCOE1sbCC+ly203NAwGsR64urLMO2G6NWxtb5W7WT7JDuBqoqmjuORv6EzGsbSEbXC7n7aBJuiNEY7rM+PlBCjj9NMvlcDJ++j+v7t6kS3nPpV6EbGAzLA+qA8RfeccHa+3z5P721y0Dj3LoQJpU74NskuQs5ccfQ2qJ7zyhz5m5KwdKD2un+kPr3hx0fABJyal/ttpfMP2GK/CEfu+KP6jAYVKOk2rDFl36O55E7NrAIVGMuvb5Ipc2tfGftkRSxJtjtTvmzfa4GsSYw2Z5nR2CU0City9u5sQpw9oivASRO1Mw==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b0055e96290001sm4753966edz.27.2024.01.31.02.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:52:11 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v1 2/4] dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880
Date: Wed, 31 Jan 2024 12:51:51 +0200
Message-Id: <20240131105153.8070-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240131105153.8070-1-clamor95@gmail.com>
References: <20240131105153.8070-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Add a compatible for the LG Optimus Vu P895 and Optimus 4X P880.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index fcf956406168..9b3c565b21c4 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -64,6 +64,14 @@ properties:
       - items:
           - const: asus,tf700t
           - const: nvidia,tegra30
+      - description: LG Optimus 4X P880
+        items:
+          - const: lge,p880
+          - const: nvidia,tegra30
+      - description: LG Optimus Vu P895
+        items:
+          - const: lge,p895
+          - const: nvidia,tegra30
       - items:
           - const: toradex,apalis_t30-eval
           - const: toradex,apalis_t30
-- 
2.40.1


