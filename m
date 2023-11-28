Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77BD7FC6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbjK1VC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbjK1VCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:02:25 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A539D;
        Tue, 28 Nov 2023 13:02:31 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a48761e96so13174016d6.1;
        Tue, 28 Nov 2023 13:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701205351; x=1701810151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=flo9Wp7WqFxYcnDRVlIADypEJg813kdmo7cm1Yhfmx7tEfr4TEo/PE87pb/MfuxBaO
         6qSD5EvoU3JeV2+qzaICsGiHoRVzrn7wIG5pLKQkzS8WVK6rDVD+y5S6NT2dX0ZY0rn6
         b/SOidcj/dAHsr4MDWRKsFhb7hkwxbi8OpN3NZ6sMCb1fQ8Iq4vlJXeeCY0CUl389PW0
         Q5l0jIy8qfhe2oOX3DlW0tTsXBOStxwei5gODA11+rZuFPRWlc3YkUPImRfzyPMam7ld
         qrO1A80qZQTYWd9JouUkjkaYsiWusUK5+i3VG3++wmvfWyXMLuFL4h9f9TyfTJUG+oks
         YXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205351; x=1701810151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=E9zb6re2CNqBC/1PhPece83dNWldQyIU9tGYl1DWn6O05TeevIdDsjdW45Qe3FdGMj
         FxqvEzkr68fIdLq0U7EEFJQ4fSzBP6QHxwzHAsrrl6bw8+sNfxpdzFx6sDUdBrWFKUzD
         z1kUnIbAAltD1PYl5bAJU+8X04/nm8k1x7HD7z7wTKNxZ4FUOCJFoxqsEAu8rMQ86k32
         fbLn0pzBOneFEPZt1dVgcYrde5R1mg6d5pU5aEQzs//8qpfxIG4jvuJN3UKAF7elamzj
         TB4KDel7dG2d/S6Jd/rmFmPlHJOyHrSBojRUjjQM/9SnMQKOE3Vejox/Fj7ZISvpdsSA
         eCPA==
X-Gm-Message-State: AOJu0YwRdfWMxe+cyn+2OAsag9HWrEUcinfD/EJ3ViGEKZF31AEQqU+g
        36DqiPSaa2QuXeGCpUuEMWc=
X-Google-Smtp-Source: AGHT+IHvdIQ4P2xpE4t9kourHMRIG+9XmyoLK1o6I3iLJdpNg5Ta7hWYSNzjXm+dS0DJM+V4QqLfbg==
X-Received: by 2002:ad4:5cc7:0:b0:67a:4da4:e23c with SMTP id iu7-20020ad45cc7000000b0067a4da4e23cmr8302455qvb.56.1701205350707;
        Tue, 28 Nov 2023 13:02:30 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id ee17-20020a05620a801100b0077d84ad9744sm3748037qkb.36.2023.11.28.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:02:30 -0800 (PST)
From:   angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        angquan yu <angquan21@gmail.com>
Subject: [PATCH] Fix Format String Warning in breakpoint_test
Date:   Tue, 28 Nov 2023 15:02:06 -0600
Message-Id: <20231128210206.56868-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: angquan yu <angquan21@gmail.com>

This commit resolves a compiler warning regardingthe
use of non-literal format strings in breakpoint_test.c.

The functions `ksft_test_result_pass` and `ksft_test_result_fail`
were previously called with a variable `msg` directly, which could
potentially lead to format string vulnerabilities.

Changes made:
- Modified the calls to `ksft_test_result_pass` and `ksft_test_result_fail`
by adding a "%s" format specifier. This explicitly declares `msg` as a
string argument, adhering to safer coding practices and resolving
the compiler warning.

This change does not affect the functional behavior of the code but ensures
better code safety and compliance with recommended C programming standards.

The previous warning is "breakpoint_test.c:287:17:
warning: format not a string literal and no format arguments
[-Wformat-security]
  287 |                 ksft_test_result_pass(msg);
      |                 ^~~~~~~~~~~~~~~~~~~~~
breakpoint_test.c:289:17: warning: format not a string literal
and no format arguments [-Wformat-security]
  289 |                 ksft_test_result_fail(msg);
      |    "

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/breakpoints/breakpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test.c b/tools/testing/selftests/breakpoints/breakpoint_test.c
index 3266cc929..d46962a24 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -284,9 +284,9 @@ static void check_success(const char *msg)
 	nr_tests++;
 
 	if (ret)
-		ksft_test_result_pass(msg);
+		ksft_test_result_pass("%s", msg);
 	else
-		ksft_test_result_fail(msg);
+		ksft_test_result_fail("%s", msg);
 }
 
 static void launch_instruction_breakpoints(char *buf, int local, int global)
-- 
2.39.2

