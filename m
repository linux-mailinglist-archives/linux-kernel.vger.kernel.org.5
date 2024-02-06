Return-Path: <linux-kernel+bounces-55197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B6084B90A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCB528AB5B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80481369B4;
	Tue,  6 Feb 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="P4ty6tuF"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA2134CFB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232258; cv=none; b=uhQTgpr9f/EnaYxew4wMUJ8i9chqwsp4v8ui8Vr8BMChWqxoAjFhifeczHJw/xgrlZ2H6/krJUYRXRO5hbN/3+qbab0V5WjiZl7Pepgp9wnMUzY9hS2TIzZaB1ngnNh9zxTcWMpwz6csdoFugqRq757nRJf6mLrSM+ptsrBqPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232258; c=relaxed/simple;
	bh=osnqFI0ZtxEkvRbQ0EWBH7BL7X2o86yrUG9y9rOwtI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKz801q9qD6lQCWaWw8Y8u+JQOHuv4qF7D+/A6pJvfBREJuPRg4IXeepoA9rgADs0uNzpMDsXPQxH7AnaFntEQYOhhMJtE2C4lzZ7grBG+9dJXCsASjh6s+h8GkbViRazs75hDk+Q03ghDICbX1H5HKGf4XCUdL1YL2K9FbuZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com; spf=none smtp.mailfrom=hefring.com; dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b=P4ty6tuF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c4300518bso26197086d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1707232254; x=1707837054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYfFNAiageIfuh4cpngMOun9DVS7g39fafIbd6OpWGY=;
        b=P4ty6tuF3lnD/vP2lHwLsaYqiyTrK09sHgAeX9FAbdghmUbaHsi9sybwdouYgPGbDF
         93aU3aPWWFi2H5ii56tK36hc4K5y5T1u9uK0jIO/rrkuaRiuwpDGL/M83t7qklOVmBhG
         h3e+OAOShTVkzGmmmM/ULlUEkCMn278lS583FeQqjTEpeBHk6+fUFfZ+KfLbkf4VqAel
         s2I0KHSgKb8rx91ekhjQ3HxIPJ5m8kEmEHDqn2Rk/kYegR6BielkF8XuF7Wj3Pw61bjb
         jLIIVNuyHkkLq3jJqpjDJEh47lXS07qjslnyq8mMfs1D227eHW+S40N8KGIJcRE52ZsY
         c1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232254; x=1707837054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYfFNAiageIfuh4cpngMOun9DVS7g39fafIbd6OpWGY=;
        b=Oa3GR1GQ0Wwg2KWTjc8lkxQhUwse7oZy9NMJxTuk1zUo/7Y9e6QwZNHLWCFu6J73h2
         EPrb8CUUK1Xgfjl2t7tz05T6WToAPgO3hN8t4XHfN1Qr2mZthQIm8DWpPiNIuJbr4yzK
         r56uH7FNP4j5AprbcxI2fToFyg8n6/iPHUUDs4E3a8OVOzJlHkeADg8gTc+QHc7tUj4x
         PJJmkApHJkhsr5qnx31qEExDce00Jsip2O8tKJobTBcLFFwPXMhU6VrSHKfZ17OjUCon
         9T1ZvFD+tRl2eC9477VUe1FLaP61nQUv1R+58qha8Hc1GbGrX3fiqsUS572XwRdttooD
         +3ww==
X-Gm-Message-State: AOJu0Ywhi00SfpJnQdn/SQGM6z3jLXvKuWNTJUxd4rQKw86Ez6mx/S1D
	+eKUJU+SCFGprcjTSLL3JSRC1qDApqahN8lNRuO6E1svwzW6IWxTEpnWtjd5cHtej5B5Vk8pX5x
	7iPk=
X-Google-Smtp-Source: AGHT+IFd2Cwl2Ki6XrgGXh9DfcDLR1Dl/x4H6+7N97GLFsJK4P3ngm8vBHQ8ekDm1Fc/SQwcG1IZ4g==
X-Received: by 2002:a05:6214:2262:b0:68c:a7f6:12b2 with SMTP id gs2-20020a056214226200b0068ca7f612b2mr3736640qvb.8.1707232254207;
        Tue, 06 Feb 2024 07:10:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpxvvPlLKxDbC6P8YYRRL2v77MAgpJ3Xwr2pa35c4v0MFlgGUgk3Oz70gojR8ZlTNx4Albf4/vEBVcLo7na/+3ha3bx7dJGwlkc7WsgKouh+xYj7riiNc7ndIdv19qyVnvPj1hnOJRyV6B6w9hhgW6hRfQuDNJ0tSIjUqpkh0yXpvujo0DbDl5vOMwQOc=
Received: from localhost.localdomain ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id i11-20020ad44bab000000b0068c3a7e4789sm1074190qvw.103.2024.02.06.07.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:10:53 -0800 (PST)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] regmap: kunit: fix raw noinc write test wrapping
Date: Tue,  6 Feb 2024 10:10:05 -0500
Message-ID: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The raw noinc write test places a known value in the register following
the noinc register to verify that it is not disturbed by the noinc
write. This test ensures this value is distinct by adding 100 to the
second element of the noinc write data.

The regmap registers are 16-bit, while the test value is stored in an
unsigned int. Therefore, adding 100 may cause the register to wrap while
the test value does not, causing the test to fail. This patch fixes this
by changing val_test and val_last from unsigned int to u16.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-kernel/745d3a11-15bc-48b6-84c8-c8761c943bed@roeck-us.net/T/
---
 drivers/base/regmap/regmap-kunit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 026bdcb45127..4eb18f5d3265 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1202,7 +1202,8 @@ static void raw_noinc_write(struct kunit *test)
 	struct regmap *map;
 	struct regmap_config config;
 	struct regmap_ram_data *data;
-	unsigned int val, val_test, val_last;
+	unsigned int val;
+	u16 val_test, val_last;
 	u16 val_array[BLOCK_TEST_SIZE];
 
 	config = raw_regmap_config;
-- 
2.43.0


