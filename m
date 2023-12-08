Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0972B80ACB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574653AbjLHTMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574641AbjLHTMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:12:23 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A41712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:12:29 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id 6a1803df08f44-67ad8f3b956so61478306d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702062748; x=1702667548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=TtOpdMwpk3HmyGxPMn0lXTJ1YACZLpsGKVjALtvXPgYgZcY36t9V9cUvKebcqvVtLv
         rHzmU5w01VqPobGCR9NkYT/l+IzVWoLeh2hExeW2HZGo/kXu7oZ/KaqdW8qCO+AsT+yH
         rlObRSjtVUEdJG6ZycKmb+i0RZQOqhj+/StTJKaltqK56ZepK/fyzwWC7IlFA8Y2vX8U
         /aVX/poyzT/swMPh+JUF/qC7N4EvnO0Tbui9mDqtqJyZVTgVN+bPQT/ffOAccpXFWuLx
         6NE+ekEuL8Vx3+qoo9kQp+w8QpwZSIMOhtJW8+GxOuecEzCqpy0eKfoBOpEN0bGFxnGy
         Oo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062748; x=1702667548;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvef+BcVgEroNYpsUvlaSbQE1KPpVwrXco8mT3u6R8=;
        b=Ri4LZlZ9sCSEdlixVQ0lKnb4z+lVe1R8V1HgV2uQwhSt4aLIA9z2KEKnUnXFGOE3lp
         i4v7yrdB4SYCn8EoDuFFihtZVE8/hTvk97SUeuWY/FFFRYfRyvAGBqHhbWjLqMc33jrf
         LcSon0Rdk2cqfkEbWCNV3ZD1UoeTdfUpE44w9Izku/kUqOmu3XlvCCtJ9Az9nYZdwXIA
         NUWOAsERxmBHZr/2Sa7tpWajo1hDnc2cCArCckZL7TEgAPzgQBVKZFQv0JggMXTz3yiY
         2kn0yYrA/G2QCEJ5sH4+/w/8JSAxLmEqJKvbGovyy70ZQCFAsPgzNcvdXGsknvrKjLaU
         g/8Q==
X-Gm-Message-State: AOJu0Yw5E8FJ1qFSWD4bNbAW3DJgOF6zQ8E3sM6L0GAZgrWuQZN9lwjw
        lIovuNN34C5iAq8ArAve2btsgeHRRQ==
X-Google-Smtp-Source: AGHT+IGuOdD3gIEzMskxj65xx+SL0VrhBoEpExw0ALUkNEYuZ/zPOt9y7oxmzmGADGUzBYXekOw1J3gmSA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a0c:f7d1:0:b0:67a:dbad:8ebd with SMTP id
 f17-20020a0cf7d1000000b0067adbad8ebdmr11575qvo.5.1702062748417; Fri, 08 Dec
 2023 11:12:28 -0800 (PST)
Date:   Fri,  8 Dec 2023 19:12:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208191222.630119-1-rmoar@google.com>
Subject: [PATCH v3 1/2] kunit: tool: fix parsing of test attributes
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

