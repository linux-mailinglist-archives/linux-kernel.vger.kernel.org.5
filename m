Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6078094B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbjLGViT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjLGViB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:38:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13D3843
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:34:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daee86e2d70so1911636276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 13:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701984857; x=1702589657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=V7RL33fGpxz5liHmJfJ19Gv4HVRjyW7C5bIK8yhkT5aETZHjatGv6RZLmeyU17g/qd
         vUTREXJ9Xjm5AB00QlBhK7xhq9Hyxx0G6EyI+OOJxQj7vjRBVk1qfYYhcO68grMXz0M0
         HxGgbwQ9jJgdsPyMk55EzgVCwtYkihg/FzGe2CxZjoJO6JFqGMgwwCIgEo5gNRozsWpU
         b07gISkkQ87nGOJt120mzrQaI0R99yOZHufCBm4oekrJ3wow8eVhL9JFJ4oJzSlgMYUY
         P8I7hbY2pTFevjMnQhrROLNafdK9Yy169h+h74QyhJxtHtxmcly4Y1LBJDEe5OHptN5Z
         0ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984857; x=1702589657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=kDpkxZcFVWqX5XJUTwYXr55xbXH4zS4jSSXfiqgTwjEvR2A5VMe8t9QShNX0UZCMJF
         sqnaA3X+cu2AZe/3GCmLhHKM1xAVop/Mf3RCLYF89fK6Jg9aVsrhcgqxEetX1kGSX2X5
         cmXGJ31Is7NHip0LcgfgLxjBFNYLnrr9K3Ze4xtXqN0brS1u1nCIZhDW/FUQrejLKleo
         alTZ0ik6iYkrlJnq6BUQDPUi80f7lClqzKXqCb66QGMvNRp5VpPNZoMYhluyxt59GFts
         bs6NCVpzpB2QIUPTrg7syJ7WrvEVfwEpumCHHDiOhweNVAj8TYIFIXh4Nut3ouN0xShd
         +7Lg==
X-Gm-Message-State: AOJu0Yy9JF3jgHBEHe78AcHEEderFjcwCXXo5l+uH+npuD/C3aviQKfK
        2TaL4DvS9EhPHPGm3exNiWGOVQ8VkQ==
X-Google-Smtp-Source: AGHT+IFcnTmpIxE1whdzzseWwxE7PYCbkOE0lyizRjIw5inFfT6N6kmdP3S7jk7PUBfYbA1A3Fdf7qTeBA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:d7d1:0:b0:db5:4b1d:c63c with SMTP id
 o200-20020a25d7d1000000b00db54b1dc63cmr35989ybg.11.1701984857742; Thu, 07 Dec
 2023 13:34:17 -0800 (PST)
Date:   Thu,  7 Dec 2023 21:34:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231207213410.417564-1-rmoar@google.com>
Subject: [PATCH v2 1/2] kunit: tool: fix parsing of test attributes
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

Add parsing of attributes as diagnostic data. Fixes issue with test plan
being parsed incorrectly as diagnostic data when located after
suite-level attributes.

Note that if there does not exist a test plan line, the diagnostic lines
between the suite header and the first result will be saved in the suite
log rather than the first test case log.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 79d8832c862a..ce34be15c929 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -450,7 +450,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log = []  # type: List[str]
-	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START]
+	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START, TEST_PLAN]
 	while lines and not any(re.match(lines.peek())
 			for re in non_diagnostic_lines):
 		log.append(lines.pop())
@@ -726,6 +726,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# test plan
 		test.name = "main"
 		ktap_line = parse_ktap_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
 	else:
@@ -737,6 +738,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		if parent_test:
 			# If KTAP version line and/or subtest header is found, attempt
 			# to parse test plan and print test header
+			test.log.extend(parse_diagnostic(lines))
 			parse_test_plan(lines, test)
 			print_test_header(test)
 	expected_count = test.expected_count

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.43.0.472.g3155946c3a-goog

