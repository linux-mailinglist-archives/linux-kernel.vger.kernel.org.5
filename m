Return-Path: <linux-kernel+bounces-102388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0287B17F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9312E282614
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474657330;
	Wed, 13 Mar 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNilWqOq"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259556B64
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356177; cv=none; b=Lg4HpbD72+qwoDkl70N+0q4rOUI9QLpV8SiXsmPO5vrAS3Znl7/AJxroBBf12N9A1fF8A+NLly4iwxxPkFnwxOs7eR7Q3gypn5Lbovyvcf8xXNFo5T9feNPLIaUTkNknBbr2gJVsDs20CodlF8pWE846LdUmXkI1RkfjgTjC0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356177; c=relaxed/simple;
	bh=SQS+ov8yIW6DEKRzVTZuSjdygsQnSqtlsD90R8giz/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UC8z5Wqlci5LZdSPSQMw+FDY+wOCNPdqQlNGH+r8sMdRZzdC9eaZF8TBAHTodK3gvcDOGn4bTlyOjb7/59ThhPTCDoJqh3hDrB6qig8jD5yrK92fcmG7ykci5oJIvGtCHUQOVSR2Yxj8X97RB/r2BpAqqjiFPmh834gTMrHGA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lNilWqOq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6b22af648so1067959b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710356175; x=1710960975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XAsXiIDC6OwZ+FdvxFgNYuLvw56oPhd3QbM/5nEMps=;
        b=lNilWqOq79hDVuTSXdXMCtyCBN5Y44x1C3HI1ZG5tM+vaIi/TovEVpgV4HgpMyXMCq
         rFfPx/UcBaonZNS+uqlgFkL8ha9R7ZOsPDz2gF848r/N/IoyVNZBBjYlJNIeSARrqWqu
         AMpnOaqHZi3QhH9hVOU2sw6HRaSJmCE5Avrew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710356175; x=1710960975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XAsXiIDC6OwZ+FdvxFgNYuLvw56oPhd3QbM/5nEMps=;
        b=w9yhaLTNKeh/oohUUBLALbv2KTmXHQvZrezS5TP3DEP7xEygHqcZ2vWL8XY0cyprpc
         LNr2xXG3cTG61h/pQOb5Pj5rRlQCkLsan3kAwoRqKa6LkelCFt7hKgAGMoYXpZJQjED+
         +iW4blfjg1apPMcdpSvDhDn53Aw949v8QJRhOG8ZmKe5gXB431lsEu67zP1rbPr4dy+I
         gEcOlCD3oIMQ14niFlN+h+/jYYxVlvhMLi5H1E/PGXpnMjO1wgqUzvy9+QzyyUfp9Vr9
         mv5fvm0ZP2BiBp3vmMP7wZ7w12Gkzt3auh4Kkee9WfwHHzn1o7DBMijLWYn6P9cORyDs
         hr8w==
X-Forwarded-Encrypted: i=1; AJvYcCV38NyJU91jRa/Ugc4JfHj88PkOTEIzaZPgLLGFmHptdrn1ghc/UWBoUsVULz+qxYUF3Fyh4fgEqcQpipfgH6i581TEXU/45dlNXrZa
X-Gm-Message-State: AOJu0YySo4Xc5mGoBQ5DceSZzI0+vvQNJHcpGd8sr0gFZY7ZH86XtIVS
	qxKQDpLR803/3NIhJbJDlL26nUoN8yeLFVXCte8ZzIMA4aFa744dIGx3Y4w8oA==
X-Google-Smtp-Source: AGHT+IGA4JGKwWWNLHCxq7izlVfvB2QGsE/36UJ5ZjuTNx2RCIULRNshQCd+NPhnH7MmJe3JVpwZYA==
X-Received: by 2002:a05:6a20:12c5:b0:1a1:87b5:4b28 with SMTP id v5-20020a056a2012c500b001a187b54b28mr4995408pzg.0.1710356175280;
        Wed, 13 Mar 2024 11:56:15 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79903000000b006e6b959b636sm1615689pff.53.2024.03.13.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:56:14 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/exec: execveat: Improve debug reporting
Date: Wed, 13 Mar 2024 11:56:10 -0700
Message-Id: <20240313185606.work.073-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=keescook@chromium.org;
 h=from:subject:message-id; bh=SQS+ov8yIW6DEKRzVTZuSjdygsQnSqtlsD90R8giz/g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl8fbKt7Aicr2v1jL2D5Cbtq5T6AALRK5Ut0QjW
 yJY662adQiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZfH2ygAKCRCJcvTf3G3A
 JhdZEACO826i+YbxlErFkdeBoatgCSeytNdOJhvq9RSnhz1h6CSrIOdrAzqhfHWtRFO1b/4Q4k/
 bfZpBWeYDrreNjcB4+axQl0dBlBLpcvZD/XhhZWF/q2qXA8G4R8sL+IQgxvbC1SfY43m4voENz/
 S11w3mMf4mhfsGrUCfSLJXUhkRSrw/uqmjZ2/158F5SiTU+x8c2QpqpXfd5nujAZQcLQefx3oji
 k68TQcM3f3oQeiAO0p011Bh9gHe92BSnjZB2Pfh3JJWeEOCOxR5/BEAQGF+Xwstsdc1gf5W2x47
 maW249sTvbIujyJMudbFe6ADnOxYZzMxcNzsg8f7Xm67xyv/pUv3PMMisH/FC5a5xDuOcuM56NJ
 M7qkV5lAuGdGpFWQgrZ9vrPqSWsnE/fl0u44X6E9CTRaboDIU0if+uAm24IYm/e4HaXu5L31l+1
 7OWMd0275j+zKuT5THdsQOMFsiP/Kl0jIChgbDt7IoViRJPOIsK2zLa6yzTrWCl85krYW/a2Gj5
 YetE0h8hI10kXC8d/ynnF3syoaeTcRxOOd/CYVx6MfouycA3E5sMntsQGGqDvnxnQLh+ZoSDoaJ
 zqDad87A49h4QoM2nZYN1m5WfK4xlatrRK0ZHnPBwQYV8X7BzT8LEGyHaT6OCqDmfVsCdSPNfE3
 cjjEus9 TFgxnctA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Children processes were reporting their status, duplicating the
parent's. Remove that, and add some additional details about the test
execution.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/exec/execveat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 0546ca24f2b2..6418ded40bdd 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -98,10 +98,9 @@ static int check_execveat_invoked_rc(int fd, const char *path, int flags,
 	if (child == 0) {
 		/* Child: do execveat(). */
 		rc = execveat_(fd, path, argv, envp, flags);
-		ksft_print_msg("execveat() failed, rc=%d errno=%d (%s)\n",
+		ksft_print_msg("child execveat() failed, rc=%d errno=%d (%s)\n",
 			       rc, errno, strerror(errno));
-		ksft_test_result_fail("%s\n", test_name);
-		exit(1);  /* should not reach here */
+		exit(errno);
 	}
 	/* Parent: wait for & check child's exit status. */
 	rc = waitpid(child, &status, 0);
@@ -226,11 +225,14 @@ static int check_execveat_pathmax(int root_dfd, const char *src, int is_script)
 	 * "If the command name is found, but it is not an executable utility,
 	 * the exit status shall be 126."), so allow either.
 	 */
-	if (is_script)
+	if (is_script) {
+		ksft_print_msg("Invoke script via root_dfd and relative filename\n");
 		fail += check_execveat_invoked_rc(root_dfd, longpath + 1, 0,
 						  127, 126);
-	else
+	} else {
+		ksft_print_msg("Invoke exec via root_dfd and relative filename\n");
 		fail += check_execveat(root_dfd, longpath + 1, 0);
+	}
 
 	return fail;
 }
-- 
2.34.1


