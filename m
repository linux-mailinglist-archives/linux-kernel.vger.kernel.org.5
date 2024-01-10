Return-Path: <linux-kernel+bounces-22622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E382A08E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F227C1C21B26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D14E1B2;
	Wed, 10 Jan 2024 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d32j8Kd3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462C74D586
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so17057525e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704912926; x=1705517726; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lV56HHPvogh+5biZ9cxmf8UKMIbrPi47569Laf2Liq8=;
        b=d32j8Kd3YFkahjDswf4DMAETaDnlxGXtOlejyaPPKBUtqu2q0XWewNf9D2H/5MRb/a
         klkYHjPj/nRy1QX22AUiLglogfUHfnyY2aUS1tOl6JvTMs+HS0SzBwf0VGAwS32kZwQ5
         NR6Ix2XhnRUnjheGeucvSjS0ubs7eYz1ixJMxZQHcqUea4ZLoxr6+Bl0Yo0ltsludW6Q
         C4owdJftqI3js5ZP2qd2qqIarFdas77b1fhuFv+fIxkAEYMl9avmNIxsaEyrglYXPixU
         kzr8XW4rad/ilntMP5ZgUMQ8kg/Ssp/tgfdeeMxAbXUXwnPwYe2/Fb1D/S5kUQNrgIFQ
         n0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912926; x=1705517726;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lV56HHPvogh+5biZ9cxmf8UKMIbrPi47569Laf2Liq8=;
        b=WbkPHWogrbulKrkRF0qUDwoWZgY8GZn7qfVbmyh5OebwiC7wYa/2SCD97V5Diw5JRh
         pKs0wnQO3/RLg5LSDNq6Fu3+lkJq6pP1550hLHE+Jsyl9o2aTsyZe1he254cDK/1Phdt
         z/3ynEjr/ZS4vwc2zEz+mWZwUqWoIxb0g3ZKgOGBL/KBVxWJJMy9AH5V+N7NgMSXE0z1
         hJELK44bbfwKTqqFEAh7wqwy+eQ7Ldd0MQmBPUz1byx2NLAuT+miHlzgJd5r47yhyWcd
         Q1pIGpsPKFcRb8P9+ww8SMnzyoM8JCJOYNlgH6HJn2yvmKDCl2+wuV8Fig4wkPFuodob
         pObA==
X-Gm-Message-State: AOJu0YyugqSr+NwuanbJAaJtWVcJcGd6AU3/hbTXOyVIMsEy2nQ4mgNU
	vgB2qg1mPK4zzrO5Zdq1Y7sizl1fiHqeiQ==
X-Google-Smtp-Source: AGHT+IEyQfEjny2UIgLvyyO/XaQhfliiz8XN1V0+gJkWSFVvUtdDc/2P7Y8p5KvXAASPa0T3jX3GCA==
X-Received: by 2002:a05:600c:5405:b0:40b:5e59:ccdb with SMTP id he5-20020a05600c540500b0040b5e59ccdbmr981187wmb.188.1704912926681;
        Wed, 10 Jan 2024 10:55:26 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm3131306wmo.42.2024.01.10.10.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:55:26 -0800 (PST)
Date: Wed, 10 Jan 2024 21:55:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: Fix a NULL vs IS_ERR() bug
Message-ID: <39b4278f-35d2-4071-a3aa-ec49705272af@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kunit_device_register() function doesn't return NULL, it returns
error pointers.  Change the KUNIT_ASSERT_NOT_NULL() to check for
ERR_OR_NULL().

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
It's a pity that there isn't a KUNIT_ASSERT_NOT_ERR_PTR() macro...

 lib/kunit/kunit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index c4259d910356..f7980ef236a3 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -720,7 +720,7 @@ static void kunit_device_cleanup_test(struct kunit *test)
 	long action_was_run = 0;
 
 	test_device = kunit_device_register(test, "my_device");
-	KUNIT_ASSERT_NOT_NULL(test, test_device);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_device);
 
 	/* Add an action to verify cleanup. */
 	devm_add_action(test_device, test_dev_action, &action_was_run);
-- 
2.43.0


