Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A088094B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjLGViX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjLGViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:38:04 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C10F3C0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:34:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ce16bc121aso16450837b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701984865; x=1702589665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHU5YaTcNBQsG81gTEGmTL6T2FG7lJRntfdwIVI0JxE=;
        b=HzZ30J4sxVPo/p8CNdxpezWdqNjSqnjl9rCLm0XyFiDERXJvGlQQB//JvHlDNaftxF
         6XwslLMyzJCYdaIc48hKaYeHmLbP/XUW8+z83ay95bj1h9PsXgtVKndT+8zKIMTlI3sp
         bx3VSCPY+lgGxp7c+zV69q13OiBvJUQ/o7Z/FbjXK5xPfoyGnNloiHH5TAalUaeCNdn5
         1VISW6agL5Tyv7wc5qFgbxiHfR6D29maCXuup4+gpx+VRgrMCICJmpoCexywMKDCVtNE
         bDd+rNQSVka/4HRQz4lBDc/knHyEstKrK9xDLxxz6Xusym+6RQxOrnhbzkjrYcWV+iaw
         gcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984865; x=1702589665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHU5YaTcNBQsG81gTEGmTL6T2FG7lJRntfdwIVI0JxE=;
        b=ZVCCng4RxhwWS1hepRx5Vk+RNVjd9MfeiO3uO2tkYKPVPyn3HfyHRKJlWyEmEhfuj3
         daF0NkasYZHyKhkAYcox0LCv8ih/f98Ghmg4qG50puSQeecvW/4jTa4JI3WfRGOdVZIa
         XSz/K7JTtOkUibk1dvGQt7lN1QmUFnVqLlHk4aI+GK0P5nMjFR6dygchSCIkS6HdUo3F
         /fEEvreGhdYnS7QmkPytDXQpaJLqSmjoNz9iTs7FmHXv7LDpaAMkP5/SdrAjhV1+To/f
         rJ4mTSi30uyJ+1cLYDfXdeM2nHpBtJ//nY6lsVPrgBxDSBp/y2FB1gqnAxZ1ajrKE/b5
         E3sQ==
X-Gm-Message-State: AOJu0YzQCGiGPzsnBftm3popTT/oPqRqXgr2VA0JXbOKS1CcMV8T5DbT
        Crd5Xqiou5HrOKRXbZ910+IUxVg4YQ==
X-Google-Smtp-Source: AGHT+IEZKCrsH1xkOF2RQlJeghzypFLltAvtQadwuDk7oRPwDM5B3HQNivo6VPZzxQJSpsr6jXtRX+1MSg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:4687:b0:5d7:7d30:595c with SMTP id
 gx7-20020a05690c468700b005d77d30595cmr41357ywb.9.1701984865678; Thu, 07 Dec
 2023 13:34:25 -0800 (PST)
Date:   Thu,  7 Dec 2023 21:34:10 +0000
In-Reply-To: <20231207213410.417564-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231207213410.417564-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207213410.417564-2-rmoar@google.com>
Subject: [PATCH v2 2/2] kunit: tool: add test for parsing attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 000000000000..1a13c371fe9d
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
\ No newline at end of file
-- 
2.43.0.472.g3155946c3a-goog

