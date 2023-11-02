Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECBA7DFB90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbjKBUbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjKBUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:31:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085F7188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:31:03 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77891f362cfso114478385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698957061; x=1699561861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDmEeaAuqX9A7RBszMcn1w/iYiD0m14dhC0ZJpYnrrA=;
        b=qFuUOkMuwaciRNT22gtJS1+0AVrXItsinfImhIGnRHaDgPSPsjIZxhiUluzeLgmQDT
         xgsD3RyV4RJc8LpySplQOlAkS9mGKe66S+Rb3S20VQI9fMPv/9an59zdve2V4OZLflAQ
         LLTe2/iy3elzMzXpU0mizXM7LC3qgb4Isx6cgPHoHimE4d7JnjM7Ri2jd0tj59kwXviH
         vtGyE+5i0SK/61N5QBGIYoxz4QQL2GAwa+aKQWo1rur/ddAmNvGeJeLZGLOkuzv5DegG
         2lS1pQfqYp1niYjs6BO8dZ0LdMOD108SGBvzGoEyHC59J9NNv93R0Nwsbx68s7U+YeU9
         SRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957061; x=1699561861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDmEeaAuqX9A7RBszMcn1w/iYiD0m14dhC0ZJpYnrrA=;
        b=qa6wEz4EzLUf82lcMqzgIUGA0TV3+G9ZendM5OPyIxpe18HPUgTman96Gj+f00f5Ri
         kLhL1muZTfvlD4Xnf7xkl2Vspt1bzehhWrROmOBm4NM3yz3jt4F6fSXQfs9hscQ9EQX6
         fcFHBVdayPhxWkSxQY6FOSsdm4d1WqFpfnnyQsD+/UEhV6EXetQkTpM8VcsZQ89QUqrG
         KRQNW8fIwiAt0uP0NDMNptGmRrVc4cI1BG74DgglWC4g/xsFWCFYGT2fCSM9burZmhNl
         dGzhBcAnjSOFrcGSuhvYRLVJnqMzCJwJq4WF2KN5+TyY9awffDtIeY2GXpHXF7apFrhN
         cD9Q==
X-Gm-Message-State: AOJu0Ywlwzqc4IaGHj0hyuiDg6ScwuDxP7GmHfirB6dIZdOycG3NYSKD
        XzG1CaKJ/WE35a2U1u/K+bqi5Drez47mE1JKZz4=
X-Google-Smtp-Source: AGHT+IFIMo8zdgOfIHao2wsvrxXWrnb4t4umXQSSMlCIpK/vjwc4wMtuB65+QVKTEsPNkQCg2Zh3MQ==
X-Received: by 2002:a05:620a:4110:b0:779:d1a6:ee5c with SMTP id j16-20020a05620a411000b00779d1a6ee5cmr993034qko.32.1698957061253;
        Thu, 02 Nov 2023 13:31:01 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id m17-20020a05620a24d100b00774292e636dsm92164qkn.63.2023.11.02.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:31:00 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 2/2] regmap: kunit: add noinc write test
Date:   Thu,  2 Nov 2023 16:30:39 -0400
Message-ID: <20231102203039.3069305-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102203039.3069305-1-ben.wolsieffer@hefring.com>
References: <20231102203039.3069305-1-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for writing to a noinc register, which verifies that the
write does not touch adjacent registers. This test succeeds with [1]
applied and fails without it.

[1] 984a4afdc87a ("regmap: prevent noinc writes from clobbering cache")

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/base/regmap/regmap-kunit.c | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index e14cc03a17f6..026bdcb45127 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1186,6 +1186,65 @@ static void raw_write(struct kunit *test)
 	regmap_exit(map);
 }
 
+static bool reg_zero(struct device *dev, unsigned int reg)
+{
+	return reg == 0;
+}
+
+static bool ram_reg_zero(struct regmap_ram_data *data, unsigned int reg)
+{
+	return reg == 0;
+}
+
+static void raw_noinc_write(struct kunit *test)
+{
+	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val, val_test, val_last;
+	u16 val_array[BLOCK_TEST_SIZE];
+
+	config = raw_regmap_config;
+	config.volatile_reg = reg_zero;
+	config.writeable_noinc_reg = reg_zero;
+	config.readable_noinc_reg = reg_zero;
+
+	map = gen_raw_regmap(&config, t, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	data->noinc_reg = ram_reg_zero;
+
+	get_random_bytes(&val_array, sizeof(val_array));
+
+	if (config.val_format_endian == REGMAP_ENDIAN_BIG) {
+		val_test = be16_to_cpu(val_array[1]) + 100;
+		val_last = be16_to_cpu(val_array[BLOCK_TEST_SIZE - 1]);
+	} else {
+		val_test = le16_to_cpu(val_array[1]) + 100;
+		val_last = le16_to_cpu(val_array[BLOCK_TEST_SIZE - 1]);
+	}
+
+	/* Put some data into the register following the noinc register */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 1, val_test));
+
+	/* Write some data to the noinc register */
+	KUNIT_EXPECT_EQ(test, 0, regmap_noinc_write(map, 0, val_array,
+						    sizeof(val_array)));
+
+	/* We should read back the last value written */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &val));
+	KUNIT_ASSERT_EQ(test, val_last, val);
+
+	/* Make sure we didn't touch the register after the noinc register */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 1, &val));
+	KUNIT_ASSERT_EQ(test, val_test, val);
+
+	regmap_exit(map);
+}
+
 static void raw_sync(struct kunit *test)
 {
 	struct raw_test_types *t = (struct raw_test_types *)test->param_value;
@@ -1284,6 +1343,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(raw_read_defaults, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_write_read_single, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_write, raw_test_types_gen_params),
+	KUNIT_CASE_PARAM(raw_noinc_write, raw_test_types_gen_params),
 	KUNIT_CASE_PARAM(raw_sync, raw_test_cache_types_gen_params),
 	{}
 };
-- 
2.42.0

