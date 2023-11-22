Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13147F42F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbjKVJ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbjKVJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:56:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76793212E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:47:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C568C4167D;
        Wed, 22 Nov 2023 09:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646421;
        bh=qxIqlAUMc2bBTJ1O51B6Tb6fnmxFBkD4x3sOYOI7QNE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=syOMsnFWzOG+xmHUkIsaKs6NTpc6AaYK4nG1MDHbqXgrSkOqjN7up45LrEl5p7Kj8
         Ym73t13eE56T+NFw9qfvMT6cKIN/58qjCmJqzZxAJ1kGvbKFLul5nd9dC6SQUz1jrA
         EXxSfZQgZcLsl/twjdlg0vE6CSiRLXxi/NK/28aJYlwlXlwyWmtSXRBJT/xwFsHoxv
         cnjdJbcrEHQku+7vy1h9M37JgKh9Q68/onZlKJEqYCHDVnv0PkCs/RRlNmSkgV+RF4
         oOhzEu7XmVtkSX4RB82dUstRQ0AKsXe8scyUjoFXpHdqZZGidv6d7sY3xjsf23P0T0
         9QQcGPMdtp0aw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:41 +0000
Subject: [PATCH v7 31/39] kselftest/arm64: Allow signals tests to specify
 an expected si_code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-31-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qxIqlAUMc2bBTJ1O51B6Tb6fnmxFBkD4x3sOYOI7QNE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0OiKQHWj96U6Iv+vrEb7owlLDF7A+UeVAJW
 s3BN30QZ7mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NDgAKCRAk1otyXVSH
 0Cj/B/4v4VwoMeU53pDf1fNeG//YL1WSnuk6c3A7i2dDESTIut5NK5DCoQTU6va5PSrNx6bHcHQ
 U209ci3F/Zr+o/E5MK0xtlUtuT0eeijo8MCPj04SF2s9C7Dh86AMZ5nTAvggAIsFDYLgQgOmNM+
 XlQhib+aoBQStnNJmu+VdxLsNvBqIxdMk0E5RP7S8lMT9FNHmPXIsAfuYt4IpvN/kglnDyFWP2g
 AlBAMocbBXbx6N9D+rWLO3KOz7hiQ9AVkz/OUwp5hFzfb6hy96kQW529H3py/8jX/rxRH/DfOlw
 srt4yM6xjmvQ1TSj6Nvsge/pgI2bILXYvrzKkwYSC4BlkQsu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we ignore si_code unless the expected signal is a SIGSEGV, in
which case we enforce it being SEGV_ACCERR. Allow test cases to specify
exactly which si_code should be generated so we can validate this, and
test for other segfault codes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/test_signals.h  |  4 +++
 .../selftests/arm64/signal/test_signals_utils.c    | 29 ++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 7ada43688c02..ee75a2c25ce7 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -71,6 +71,10 @@ struct tdescr {
 	 * Zero when no signal is expected on success
 	 */
 	int			sig_ok;
+	/*
+	 * expected si_code for sig_ok, or 0 to not check
+	 */
+	int			sig_ok_code;
 	/* signum expected on unsupported CPU features. */
 	int			sig_unsupp;
 	/* a timeout in second for test completion */
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 89ef95c1af0e..63deca32b0df 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -143,16 +143,25 @@ static bool handle_signal_ok(struct tdescr *td,
 			"current->token ZEROED...test is probably broken!\n");
 		abort();
 	}
-	/*
-	 * Trying to narrow down the SEGV to the ones generated by Kernel itself
-	 * via arm64_notify_segfault(). This is a best-effort check anyway, and
-	 * the si_code check may need to change if this aspect of the kernel
-	 * ABI changes.
-	 */
-	if (td->sig_ok == SIGSEGV && si->si_code != SEGV_ACCERR) {
-		fprintf(stdout,
-			"si_code != SEGV_ACCERR...test is probably broken!\n");
-		abort();
+	if (td->sig_ok_code) {
+		if (si->si_code != td->sig_ok_code) {
+			fprintf(stdout, "si_code is %d not %d\n",
+				si->si_code, td->sig_ok_code);
+			abort();
+		}
+	} else {
+		/*
+		 * Trying to narrow down the SEGV to the ones
+		 * generated by Kernel itself via
+		 * arm64_notify_segfault(). This is a best-effort
+		 * check anyway, and the si_code check may need to
+		 * change if this aspect of the kernel ABI changes.
+		 */
+		if (td->sig_ok == SIGSEGV && si->si_code != SEGV_ACCERR) {
+			fprintf(stdout,
+				"si_code != SEGV_ACCERR...test is probably broken!\n");
+			abort();
+		}
 	}
 	td->pass = 1;
 	/*

-- 
2.39.2

