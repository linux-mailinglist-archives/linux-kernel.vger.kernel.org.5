Return-Path: <linux-kernel+bounces-139920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A951B8A0927
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495F21F21E09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784C13E8A3;
	Thu, 11 Apr 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DviqHZI4"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF013E88B;
	Thu, 11 Apr 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819191; cv=none; b=dPFa7jpN+o9Z1iiJYv7Pp4TdyyHxtrY4y3kXrGVng173lhEDqQulVejGubXYK7RRgjniwk+ofoYCFKsj9lYZRTGozulJWFtZn8PYqMvt7yE+Ljw+7ORkd5wv9lDqop8HcFtteAgtmvdZ4xwgRBc3lAcBBZwaDUH30Y11peQQywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819191; c=relaxed/simple;
	bh=m8UmET64JFRSVNpBc2wrAPbmY40xINLq85Nvqqp+9Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gqu9ifViuMd3TqmcEzTmz/I6bZIuEp/rckugzEXq7/LL7Q5EniQB+c53rqUT3gwnamfpSzNotTj5rkN6f2DinhAXuOTuB7H030KBiaxopQQFl2k/etQRXVdZiKEwA0mIB9kH149lqfU3GQYCClJiEL4/ACSqdbGmb4shckkfjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DviqHZI4; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-221e1910c3bso4234262fac.1;
        Thu, 11 Apr 2024 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819189; x=1713423989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=DviqHZI4YOOUQydkZihP6KbVgZqrkq+0QWS/gFexn7WKaE70rH8rp5r5dkKsuhZV30
         HTyR7qqSFP8h7yfZkTGHzqpHNDBx8HrL1F6ZNp40f7WJ/APvllmC4gi2oxaSittMDm2F
         c7bEyC15Rx8jqvvwr3J9w1wxW4PNDEgjT09ysQVU34oPgrzzUdaCwAwKMfgzItzBMgCt
         eIO+lW4Cx08YOSJPeL8CBkjY2qngbSJKJDI5sgE2+jVwHK8Zwu3+/THAnjT07XWLo1gF
         HHvUS1sYrTL33IOsaq89kKVXrVeLzXqqfSKY6qNhDPFw3NWPnqFLKmU1XyJV9aXu+8F0
         golQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819189; x=1713423989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=W1ofQdhp0bK1sB2LSR2uIxMiP9xAoAlQxd4dPLzVfGq5khiXYJEq9WrpelNUxxlDYz
         hzNqtGHy7eCAXKtu/QMUNqv68hoBR9l/l4P4eXmZoxnZDB/G16w0qeLj6IOIwOE7Yb+s
         9oY8X4u3po5P6onLTbrDBTH4ezUx6SIcQcBYT62BQdG6kZJKN7E3DyZEDELf1pCrZ1aS
         dTznqvJK4hif9323zJ/jfuVY/8eIVlRZddavWgqb1oC9Za60yKFc7Qs2C4BVNRTzVHrz
         Xt/3vSe7viGUq+ocXJQjh8V5JVK/XF4TiLURId3iBVvZ/hjWvhVcSFWsqOnhIRu2uQYN
         u6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUckgMwxGQxwWWacPlToDBwrA6i/IPmRMZl7KEhJ71Exob3XYEV9W9JcpsRjlpsXRbXBtGKK/9zlwykLcS9r8p53x4QWWra+gSx6AuQ
X-Gm-Message-State: AOJu0YyoqYjpXW6lXUo9lMP7YpNnCLvbFW57Q9rbripgcDubddY7UvsS
	ExjdpPfusbawdr4tB1GYXUblW0sy/zfaDvrRXMYwxSN/KXpJFMD3RSrPB6Cl
X-Google-Smtp-Source: AGHT+IH0ufYnSSqXI+3+cHDYLrOjh+LfQGRK7nqfBqX7ShaT9xZUS894U3/ZPhM80gBQJQyo0T2rAg==
X-Received: by 2002:a05:6870:d184:b0:22e:c8ee:9307 with SMTP id a4-20020a056870d18400b0022ec8ee9307mr5437450oac.29.1712819189115;
        Thu, 11 Apr 2024 00:06:29 -0700 (PDT)
Received: from d.wok.cipunited.com ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b006e6be006637sm647402pfc.135.2024.04.11.00.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:06:28 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v8 04/13] clk: hisilicon: Remove hisi_crg_funcs
Date: Thu, 11 Apr 2024 15:04:49 +0800
Message-ID: <20240411070503.38093-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411070503.38093-2-mmyangfl@gmail.com>
References: <20240411070503.38093-2-mmyangfl@gmail.com>
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


