Return-Path: <linux-kernel+bounces-151520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851318AB00A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FA51C22C11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F612F37B;
	Fri, 19 Apr 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bgeDXqXf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628212DD8F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535319; cv=none; b=mitljIthqSxB0HoE7Jo192bhjt0t9LqK3+lWGF8F4yyP6RgNGTn7Fv5WHENJarMs/J6vz+r0ZxA3J0LuY8buGJXyH2/3OYlMEwV9kJOBl4V6r7XDIFtOHLHQ99H3kYYwGNfc1O2SAlinCZpCpCEaPVnsBxchcJ6LWly+dc+fGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535319; c=relaxed/simple;
	bh=SOokn6hAfXRfXzM8wtwZF973hyHYm8001yb/KucN+yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDG/8SdcPGyuN2jnwjU+CpvacybMWirKnUk6ZlRLJtjg4hGaeTBTBiCamwvN/q/6t+Tjpz32MzhTkzTMsVrvQB/IBdnwzd0cIo6wNvQaYuaB0GrAFgVtaxCiwu3qf79cZIQp0anvAJ24oXyfosdqfYfSQNUhdTgV+SY64yCQZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bgeDXqXf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e40042c13eso16754505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713535317; x=1714140117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60bj08fNOYkyzGjFmyldnZhisQMFjo0YMqTtaPxORRQ=;
        b=bgeDXqXfN1uesqpIYgPTOCg9HwUKDMNUPjTcuVeYbshVLThDQb3rqo5EdeT4zH2has
         0YQuvYzjuObhlAvYUCYq58pXYzoNJ9taFs7X4NuMtuziljM3KEHmMzA6yz0Lcq86seLO
         VuX21HEcTE0FrBsx8osyoCksQEs7rySRpznzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535317; x=1714140117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60bj08fNOYkyzGjFmyldnZhisQMFjo0YMqTtaPxORRQ=;
        b=XzO3fGrgGxpbO2lGVyYUb1xQOuRp5zmTlkjWTyGz8LPZ0hldOeFRsJQbevhoTIm1gO
         pzqIKuiDB1mbX2zchDR59yMlmVZu+6/URhvRbNLqdQtfF0xruJgb7z4PTnDQML0318sj
         7WBUIehC6zvAHaJyEk5k5b8mcqg5vKNe4eHDYCASQ5ciwbO1B/3hJo3fAoyD/9W6PSvD
         EDaxrdbIHVwGYYLkqXEoJs04uj8XkqvPcy7fLQkko2mwwmoHXSCGh2piZlov146erhk8
         w0mWT8CXWYf3LtIv8N3aPnmiI5B8A+rfACvKRqM70Vv4wSXvJ/TKu0FK16a1kl+1PcEJ
         2Aow==
X-Forwarded-Encrypted: i=1; AJvYcCUTPjB8PL5ucqYNQeauVzfFraOTwDxD+t2Wtwl30VNx8+O1atz+rHqhBJliTKnymfRsKMbv+7YIwqrqJzGsdvbbJCRaemdPpVZAZYqD
X-Gm-Message-State: AOJu0YwYa97saHjqLyVOm1Cl3JFi6tpT1vFexUQvSqIGX/RDRBggXIIP
	tcRZtLcZO5w7HKBpQ9iWbqE3BkI2ZHGI+xt4ad3LlRbY/KSloQqqmGTYmMOohA==
X-Google-Smtp-Source: AGHT+IFxKIaiTQQnHHvaeNar935ymXBnwNgd3CdnYSm3XwjOGr+DFuZ5d0WL0a9FfnSo5+zx+j7sMg==
X-Received: by 2002:a17:902:b486:b0:1e2:718d:f290 with SMTP id y6-20020a170902b48600b001e2718df290mr2175867plr.67.1713535317611;
        Fri, 19 Apr 2024 07:01:57 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001e284b9b28asm3410545pln.129.2024.04.19.07.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:01:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] string: Prepare to merge strcat KUnit tests into string_kunit.c
Date: Fri, 19 Apr 2024 07:01:52 -0700
Message-Id: <20240419140155.3028912-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419140017.work.012-kees@kernel.org>
References: <20240419140017.work.012-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=keescook@chromium.org;
 h=from:subject; bh=SOokn6hAfXRfXzM8wtwZF973hyHYm8001yb/KucN+yA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmInlS+imGbP3YLDk5RSzjCVBlFhXpXtJzQQJGm
 h0NyeIBVWGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiJ5UgAKCRCJcvTf3G3A
 JkPcD/9hwNQiymaqHA9VWj14VNEZE4Km6N9feNZHjDYp+2MAxj8NUXO81sPxxv/w2XR7erfCHMP
 4SbtoE+nGHXRDbSioIkyVAsSJDQlZbqngPnPLgUQ1a3NQh4BjcA05Tf8Z/nqFE+3VLydiEA3u+3
 nEnON5PZEO7MJa4g2DXBGhonjgRXeQDl5WNdcUfQpUFJw92KDfV485RnQfHHGwV9iDSmmdBo6GY
 QOzU2WbovxDaNTXHQ21Ssj7sQBDH9uHCfSU2p+50nPtyRV86sXi0DxVRAWxOZ1FhGFWRk57h0Js
 tPxMRojOAdzBhiP9uYcZY+C6dFXwOCyx9yfq1UQZx0h7gMAnVX31bzRq79eoEiUQ1aU3V7Wl5Ta
 a1bn/Wu28FsrUuNecO7kgJKb5C3aVkN0J7ibAd7outSSPcJmZoTLFPVh+pvOSJXxYlZK5gqZyjB
 Df5EzAsWhnqD8FTXVSGc4/8b+1MvTzFvDfRiBZz9T+eiM7esjtiTqDxTzUOxTRdZ1bAgkanAo0k
 4jr5uy8WnrwVw+tDV0V7LvNr+VA8C8DopWurfl2UvPZg/qA8PpB1cssFyFAX0OyCI8engzk69mZ
 kzm1SjnJC/DDEs6jvqMk2HhyuSJQF1BUCfsWaJvZABj8yHZgozyTzOyyemz9lg5ZVMus2r+apiR Wrz7TD5G/7dJ8qA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The test naming convention differs between string_kunit.c and
strcat_kunit.c. Move "test" to the beginning of the function name.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-hardening@vger.kernel.org
---
 lib/strcat_kunit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/strcat_kunit.c b/lib/strcat_kunit.c
index e21be95514af..ca09f7f0e6a2 100644
--- a/lib/strcat_kunit.c
+++ b/lib/strcat_kunit.c
@@ -10,7 +10,7 @@
 
 static volatile int unconst;
 
-static void strcat_test(struct kunit *test)
+static void test_strcat(struct kunit *test)
 {
 	char dest[8];
 
@@ -29,7 +29,7 @@ static void strcat_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void strncat_test(struct kunit *test)
+static void test_strncat(struct kunit *test)
 {
 	char dest[8];
 
@@ -56,7 +56,7 @@ static void strncat_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void strlcat_test(struct kunit *test)
+static void test_strlcat(struct kunit *test)
 {
 	char dest[8] = "";
 	int len = sizeof(dest) + unconst;
@@ -88,9 +88,9 @@ static void strlcat_test(struct kunit *test)
 }
 
 static struct kunit_case strcat_test_cases[] = {
-	KUNIT_CASE(strcat_test),
-	KUNIT_CASE(strncat_test),
-	KUNIT_CASE(strlcat_test),
+	KUNIT_CASE(test_strcat),
+	KUNIT_CASE(test_strncat),
+	KUNIT_CASE(test_strlcat),
 	{}
 };
 
-- 
2.34.1


