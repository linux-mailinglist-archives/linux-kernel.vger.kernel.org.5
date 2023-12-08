Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A380ACBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574657AbjLHTM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574654AbjLHTMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:12:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB8710DA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:12:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so30358517b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702062750; x=1702667550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4FGZcnm1uluLFPaSEUNrvTfpJlOw0WcvKHKK9pE/vY=;
        b=rLlkJo3m3jGjf4q0m3BDBDAuxYMa2f0ouPf3UlWAfJxjDvmafE8Hr3+z5hrvR4YXLB
         f6q/y4xmbA0+AaF0DiGQSeNlhmFV6Q48S58sg0pvOIK1AlyT/n1Hthf905KMqjR4PkJh
         4XRgezhWv2PVzxPvIWB5gf+2c3mNjn1pC2ujTFwg3ey8ACvQkB5K+bYNOU+qK9a6Cdm9
         LPs36/hM7Ps2Jks5mcXzN+aUGrX1lL3SxC14Y0H72LVq18HhBY9OiuCbobSxt4gjGfOt
         iJDHvH3KMSLoYTzWIevbjnzkJNxC5ZGBD1P4Y6VkKxfOIhzktlklk++1X/0Njiin09Yi
         bpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062750; x=1702667550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4FGZcnm1uluLFPaSEUNrvTfpJlOw0WcvKHKK9pE/vY=;
        b=vI2Lyitzn3P4UCuNARM3tsQd8GIQjAnpfmm23jSvG0qy4ZI9+FdNl4BXFxSNNfVQeT
         NJy6xn8z0zxhI9cCdxpksomW7NdNM8V/8bzbOxZs7vJvZS0eA68pdy798HPHmAyRooF0
         OJlVZWA55JN8YyKTo09/Cmt/R4x0RXKJujyQA9C5yTdlHVRaKbi4/zyPM60Llo1jZsQW
         wTjzOFtKBd5gkgrcSNSyTDer1COjuEmp1kPHMW37tm007V+Txs/LPI8jvqeQxUfR0cuJ
         cpDy4yI02jwaMwDj6OcdwcFJGAzblAKxU+fvdtkEuC4i8xL4acLapsrlzItmrI4Lq+LU
         VP3Q==
X-Gm-Message-State: AOJu0YzcjC5QgOgl032lafd1EhYVXkYdToMRhus7skqrmPu9L/uuCLt4
        SeEcjrB7DBtA1A6ORJPn38pS1HA/Hw==
X-Google-Smtp-Source: AGHT+IFz9RNgqFFJNGwhiJxIZm6Fz0EpoDETu6m3K4Q6CZzE7fMeSwt4lm+teSXQXGq7RC8mPelDicLLRA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:c1c:b0:5d8:8d39:f67e with SMTP id
 cl28-20020a05690c0c1c00b005d88d39f67emr5720ywb.7.1702062750743; Fri, 08 Dec
 2023 11:12:30 -0800 (PST)
Date:   Fri,  8 Dec 2023 19:12:22 +0000
In-Reply-To: <20231208191222.630119-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231208191222.630119-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208191222.630119-2-rmoar@google.com>
Subject: [PATCH v3 2/2] kunit: tool: add test for parsing attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test for parsing attributes to kunit_tool_test.py. Test checks
attributes are parsed and saved in the test logs.

This test also checks that the attributes have not interfered with the
parsing of other test information, specifically the suite header as
the test plan was being incorrectely parsed.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_tool_test.py           | 16 ++++++++++++++++
 .../kunit/test_data/test_parse_attributes.log    |  9 +++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/kunit/test_data/test_parse_attributes.log

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b28c1510be2e..2beb7327e53f 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -331,6 +331,22 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.parse_run_tests(file.readlines())
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
+	def test_parse_attributes(self):
+		ktap_log = test_data_path('test_parse_attributes.log')
+		with open(ktap_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+
+		# Test should pass with no errors
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=0))
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+
+		# Ensure suite header is parsed correctly
+		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
+
+		# Ensure attributes in correct test log
+		self.assertContains('# module: example', result.subtests[0].log)
+		self.assertContains('# test.speed: slow', result.subtests[0].subtests[0].log)
+
 	def test_show_test_output_on_failure(self):
 		output = """
 		KTAP version 1
diff --git a/tools/testing/kunit/test_data/test_parse_attributes.log b/tools/testing/kunit/test_data/test_parse_attributes.log
new file mode 100644
index 000000000000..74df125d0863
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_parse_attributes.log
@@ -0,0 +1,9 @@
+KTAP version 1
+1..1
+  KTAP version 1
+  # Subtest: suite
+  # module: example
+  1..1
+  # test.speed: slow
+  ok 1 test
+ok 1 suite
-- 
2.43.0.472.g3155946c3a-goog

