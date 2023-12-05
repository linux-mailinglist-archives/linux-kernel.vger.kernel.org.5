Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D280573F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346826AbjLEOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjLEOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:24:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801EA1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:24:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3623C433C8;
        Tue,  5 Dec 2023 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701786291;
        bh=jSFY6ngQogrJiHDWxQDhDnPQplkFw+RxN+tqq7rkIuo=;
        h=From:Date:Subject:To:Cc:From;
        b=ObTgFDce5CvhMAMYEA6xBNyyNpWqZoRQQHEafkBJcRAImxgmUw6JapCLHVe0/KPIA
         ivH3Rr68X6GB0oRlwU0FVxjxLugOzNweBspkXo6VagoGzOGKK8YHtrOx53pxXI1dMI
         RAwh9wFtW6VuYwyMUAA+qgxUxdk9DUcVVAkVvUlPFUPH17ABOaHqEdahnVgu55CZnP
         pJwha/E2rKEiEZH8+Xy0dKYfBl3Y9BGG7bI3wHRSHCd2+6zpnxOCXCPioWVbWF5fjn
         UsdeVC4qz0hCDAUQz5TkLJpWeJKzf2g/A1N61ztFnulc5sFXDkgGH5MFejFFRlsohL
         tlV2zqXFkuFlw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 14:24:44 +0000
Subject: [PATCH] kselftest/arm64: Log SVCR when the SME tests barf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-kselftest-log-svcr-v1-1-b77abd9ee7f3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKwyb2UC/x3MOQqAQAxA0atIagMzcQOvIhaDRg2uJCKCeHcHy
 1f8/4CxChvUyQPKl5jsW4RPE+imsI2M0kcDOco8uRyDrmWOs/EynGwnLvuIdnWKWUWBvCvIBYa
 YH8qD3P+6ad/3A78DbpBqAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jSFY6ngQogrJiHDWxQDhDnPQplkFw+RxN+tqq7rkIuo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlbzKw2Ip54YYzvTRn+xfMczlGiTTrq6VEnNtVDHUC
 1ipV8PiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW8ysAAKCRAk1otyXVSH0L+nB/
 9AEoTq/6l+kDAJJrqW6eA7/Z8Sk3UANVz/z15sCRGFBi646UnGEG9TDE/Q+I4lp6/BUz7uN0+RKSSc
 XbRlqSzis7IAU6V4xOLsebhtJqF2WSPS4S0l0CMba53T6ZKJfVs01wWXOwf+wGEw4aHmUSnt38mua+
 16fUYtPXp2+JGX+x7YQnEK8pX9L/fYCUbPAC7s6//uFTM1X2l2JlAVopI90qJPcIVwdb56CvaR3y+u
 ycE3GzoZIuCHAhTaH595OjEQ/HyxssSBSmPScw7HNSIDhXmJ8xvYOd9Yn0LDvFfUFxD8mqv7b9cl4I
 KXz6xl70OqxV2H58KCtNqSirp6O+iY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failure we log the actual and expected value of the register we detect
a mismatch in. For SME one obvious potential source of corruption would be
if we had corrupted SVCR since changes in streaming mode will reset the
register values, log the value to aid in understanding issues.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-test.S | 10 ++++++++++
 tools/testing/selftests/arm64/fp/za-test.S  |  6 ++++++
 tools/testing/selftests/arm64/fp/zt-test.S  |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 547d077e3517..fff60e2a25ad 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -515,6 +515,10 @@ function barf
 	mov	x11, x1	// actual data
 	mov	x12, x2	// data size
 
+#ifdef SSVE
+	mrs	x13, S3_3_C4_C2_2
+#endif
+
 	puts	"Mismatch: PID="
 	mov	x0, x20
 	bl	putdec
@@ -534,6 +538,12 @@ function barf
 	bl	dumphex
 	puts	"]\n"
 
+#ifdef SSVE
+	puts	"\tSVCR: "
+	mov	x0, x13
+	bl	putdecn
+#endif
+
 	mov	x8, #__NR_getpid
 	svc	#0
 // fpsimd.c acitivty log dump hack
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 9dcd70911397..095b45531640 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -333,6 +333,9 @@ function barf
 //	mov	w8, #__NR_exit
 //	svc	#0
 // end hack
+
+	mrs	x13, S3_3_C4_C2_2
+
 	smstop
 	mov	x10, x0	// expected data
 	mov	x11, x1	// actual data
@@ -356,6 +359,9 @@ function barf
 	mov	x1, x12
 	bl	dumphex
 	puts	"]\n"
+	puts	"\tSVCR: "
+	mov	x0, x13
+	bl	putdecn
 
 	mov	x8, #__NR_getpid
 	svc	#0
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index d63286397638..b5c81e81a379 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -267,6 +267,8 @@ function barf
 //	mov	w8, #__NR_exit
 //	svc	#0
 // end hack
+
+	mrs	x13, S3_3_C4_C2_2
 	smstop
 	mov	x10, x0	// expected data
 	mov	x11, x1	// actual data
@@ -287,6 +289,9 @@ function barf
 	mov	x1, x12
 	bl	dumphex
 	puts	"]\n"
+	puts	"\tSVCR: "
+	mov	x0, x13
+	bl	putdecn
 
 	mov	x8, #__NR_getpid
 	svc	#0

---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231204-arm64-kselftest-log-svcr-372a210520ae

Best regards,
-- 
Mark Brown <broonie@kernel.org>

