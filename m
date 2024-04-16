Return-Path: <linux-kernel+bounces-146592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322508A67B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68ED1F21FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E75128373;
	Tue, 16 Apr 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJwRTdI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC0126F1E;
	Tue, 16 Apr 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261916; cv=none; b=WeO5fQ4PYMCKlaoVw5SamLQ/nyZFDmk2/OsPloahSvJJC3Y3rfDIF8tprgvyNoGxbzysHcXLZScEKXDzqAAz64xE4mYwaN9E1BY0ziya0KMsqxjGwB+oghatcoHTKN1HiaLMjK3olDbcsSrjuCCpboNyKQrbP8iZ9YDV1k8AYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261916; c=relaxed/simple;
	bh=m8UmET64JFRSVNpBc2wrAPbmY40xINLq85Nvqqp+9Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K89jrMFUY5UqtBHTijULqX2ALgOZVl98eDXJ6XeIy1xaqxeWj9in/zGS1tIr1hUwoOILG/eJivVi/YXPVMleihxgkFvVKGaDDlSZkpHTL6RQtwDxbMT6nFpzpRkSx/XFij4jJsmMmabhXNnXdfBqj4f6ZuaQ+5W1X33i7cBGGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwJwRTdI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3ff14f249so32321915ad.1;
        Tue, 16 Apr 2024 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261915; x=1713866715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=NwJwRTdI5IUAvMK7k8A1XB0aatc+PrnKCP55x5fsERDXrdAEWU2epA2Ja94OtsUjXA
         WHdKNKq6DpeYrL1zjOgDvJz8BLf03tiNPEGcNbTDEUvEFIMlv0J9YWnyr0BDWkVCQg8Z
         QVthRgsR4V5GQ9DrlLMWVZghWt629oJiWzB8herKzry5HnzZsdnVAVScgK7O2Sd7rko7
         1voVlVILcKPwyfwkqQcwuMtpjtZ03f4Qs0tIb4rtRlKZ1PD5uqP5QZJv3ea3iz9eGwND
         DBXawmMduyBM1y1VDXc1dMJiKu7uTdyf18DBMEkM6k2AuQ+CQ4AxhUSqfl+WTD0yrPr6
         F1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261915; x=1713866715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=dJ7lm4mQt6eBTCjnpOgELvGHXVUoGZ7xAMocB8FZuSPEU2XuP7oRXwD+SG8zcb3Kr/
         k6y4XoENkDZpca+OeEueoJcDLresNIBgQx5+PvIDwJSk6i0ZIzLjI40bctrRseFFtu1C
         23KQ3DlyUUtStOE+ItIPfNhoUwNqN/zhq5yxPIlGivrgcKsBC0KeuODayfXpPASOZl1a
         EjsHCjuyCunmZwe+5nNbrKDWTwtqdZwIg6xN8lPCLtPqnr2gBdkvkpaZwH43ooiJKK+k
         3tuFTSnsghUhU/hzEEJm/B6TbKqnYBRDhrjn6uXcbGVOackYwhVs2W0x/33gLqB5x5RY
         ydLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsnd2wQs+JjuQjHbbSW93JazzxI/i4Nk/JGnbA/ygj1ph+WwDDWGvhGL3phsWHDlmEntiAl8NrY1Od4PX8f2AsKK3/4ARzeIhNmxq3
X-Gm-Message-State: AOJu0YwljU7vf0SjF88kYuJoKcUzupiXhU/UD1KejSYOl/QNzhnwdJPk
	5QxhLwBfrYKniB/g02RSZ9nFCP1ssbIGnV1EurSO0WGbzGK/M5Pcj0RfOTDK
X-Google-Smtp-Source: AGHT+IFdcRNRsYKbIqCW78U070nwAVjO+s2mowaBGdKsFKwMaaXGereSSlJ8eoTKmjG1ZSI1yavjcw==
X-Received: by 2002:a17:903:40c7:b0:1e4:52c2:d05c with SMTP id t7-20020a17090340c700b001e452c2d05cmr2512373pld.29.1713261914760;
        Tue, 16 Apr 2024 03:05:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001e0b287c1d2sm9353651plg.215.2024.04.16.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:05:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v10 06/13] clk: hisilicon: Remove hisi_crg_funcs
Date: Tue, 16 Apr 2024 18:03:40 +0800
Message-ID: <20240416100347.395295-7-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416100347.395295-1-mmyangfl@gmail.com>
References: <20240416100347.395295-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After refactor, no one use hisi_crg_funcs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index bd8e76b1f6d7..db2324309d41 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -11,15 +11,9 @@
 struct hisi_clock_data;
 struct hisi_reset_controller;
 
-struct hisi_crg_funcs {
-	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
-	void (*unregister_clks)(struct platform_device *pdev);
-};
-
 struct hisi_crg_dev {
 	struct hisi_clock_data *clk_data;
 	struct hisi_reset_controller *rstc;
-	const struct hisi_crg_funcs *funcs;
 };
 
 /* helper functions for platform driver */
-- 
2.43.0


