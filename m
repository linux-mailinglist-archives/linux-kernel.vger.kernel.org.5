Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D4805F97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbjLEUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:39:04 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C35129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:39:10 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-77dca1d6a08so828375085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701808749; x=1702413549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yd7GThBDMFg3IYSnPer/AdnP24vZnl3M/lgBnBxitXE=;
        b=r9xutZFF5fAQE8GZbP00Aa2g/hGs8YDy8RDC+0MP/GTJhNkm71qzYoBeeYuFKwYkU7
         126P+1KeWKfCCB7RHj1Jbt1EZb6USNBV11bGzMGWuGxTIrf7WKABbqhoFuIp2U8mJvx8
         x24HADTXHxgKvqst/tjVcdiXD7Dl5rHoPhT5ozSENxdjChhK6Gw+yNfB4wykobQpZK4w
         rb7LrTfSEKoBCeml5/uAmAD7o6bKAcDi2BBYnS4ajB8u+KPoBi7jvi7AANyVAw/MglpA
         imstNrGyRN4SFL4LTLcXPQqw/FVp3qk+JUbgOjPfVZ0pPfIQMMOsJdNb6Cq7RRXO2EZT
         f6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701808749; x=1702413549;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yd7GThBDMFg3IYSnPer/AdnP24vZnl3M/lgBnBxitXE=;
        b=PlsbGyT+MT5RyhKpWtUukdjW5s6gSvrdJAMRoDBvPT6HQoEIWDGRNaq4+CXuYVev0J
         KlIWN35tpjpf4ZTyIx6+y8usi3cHXuv91yqwR37rpC1kosu4Vrf9QlsM20ykZD5ZtFta
         QNSvo+E7FVu+ubzoySHP53Gj8ZEBQK5Lj0yVXIBlw0xyKjLBhOlbeS+aa6mbIV0WFqWw
         WWjOfMEZeQ9wf1RO1+yN6ef7Q0Y8pm2b8RwiGIQLK+P8Edv5qEFDlfBVzRpbEppGmSpU
         mYqWF4aLoxRHLKKXXrpWQyfbxtvFtKVs4f6MeunQqc1t8aTvyvt1Lg066vSRQ+sTHP/K
         ioeA==
X-Gm-Message-State: AOJu0YyHO9mZllIgxaoY/xLy2kWPo8FZVvxf2UOV8dcF96xOQkSIk0BG
        yIZRjYAN/v6MDNvuadtJuQP6mn1KaQ==
X-Google-Smtp-Source: AGHT+IH0cd2HLFsC8CxaZuQ7ewPF5xTgOB6kCd9NRSSMtX79MgZW4qJ/dust0PqxwCuD94P1XVpaYtIuBw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:622a:4413:b0:423:6f2b:5a04 with SMTP id
 ka19-20020a05622a441300b004236f2b5a04mr26155qtb.10.1701808749501; Tue, 05 Dec
 2023 12:39:09 -0800 (PST)
Date:   Tue,  5 Dec 2023 20:38:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231205203852.1700497-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: fix parsing of test attributes
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

Add parsing of attributes as diagnostic data. Fixes issue with test plan
being parsed incorrectly as diagnostic data when located after
suite-level attributes.

Note that if there does not exist a test plan line, the diagnostic lines
between the suite header and the first result will be saved in the suite
log rather than the first test case log.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Note this patch is a resend but I removed the second patch in the series
so now it is a standalone patch.

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
2.43.0.rc2.451.g8631bc7472-goog

