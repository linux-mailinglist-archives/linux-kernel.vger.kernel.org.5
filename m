Return-Path: <linux-kernel+bounces-137674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A789E5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6333B214FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074E158A3D;
	Tue,  9 Apr 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bCSsPGAj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82237C6C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712702582; cv=none; b=b8Wgi4zCPrRiAEGZ9Se68tL1qTSgtY+cvsuIoyZVwP1IbYmXpShDkew8OKOKA7b3WzJpD1QspDrZrvaF/GvF5Y++pcrhwUboSDccGlbjyywgikl5Y4gfmFvI0y49EIjCNnNiKiiLUk7Y2Jk0cphn3ZegB9bIE6ZL/d3XQDMOVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712702582; c=relaxed/simple;
	bh=EOPsmlwJFzGM2UI4dOfw8LD2YE7U8XKi3h9Rz8SnOGo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UlrhLgXQxiCo6sk/2xlhKLvM8lCsHPkcn1VLN4BLLhEVdGjtpleiM7fJlXNWoACrSo4UyiDI9QWwutqNtmqTYZOKh651ZEhsOIzZXKoFc0+i5cn0OmS/TVeUbZBE8YT1cl3A+iMwLwP83ws82MFWNjNrDLtefgGeKXf+iUd3O+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCSsPGAj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6167463c60cso70244617b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712702580; x=1713307380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvOU5J+d22A5HC2jQZ6Bg8Tqj0DfjFxuF6JsjQ8c2sA=;
        b=bCSsPGAj2sH3nm8iuc9uHWwxbeMLxKveiK608uUbrm/qgZRujlPVFzgM4hgJuVGy2o
         GWmWW4LMn/JLrJCBLaeYqmEuJ0Z2QXHLGnjGIUwMuGirgJ/j+N3kcVKBD324GELrDYvD
         rlpgmoXaCpqvFAodqxCgmVle1qwse+OXbHrCurV8QTnuSZekY+Pw8T9YX9RDry9DmE/m
         k81lJX2LI+PMjvYkegbybF5tav0mA3Mdui9yQC8JH6gbIxBOTltyggqJ3GY2FRuvWjGW
         1+cFWKkSldUox9uVW0/d7mul/6X10Vus7ISsbefgbxzAAekBm40QByEOeocGSuZwt9CZ
         JwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712702580; x=1713307380;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvOU5J+d22A5HC2jQZ6Bg8Tqj0DfjFxuF6JsjQ8c2sA=;
        b=q/Z2X1vMhxCvNrWWYmqaHYqL4iyCbueEW/RveSTNLA1oKSHxDBExQejrQpFqYOMHDq
         Vd4wUlhBHNPI69iX/+84QVbZ1cRymVSr0bCTy27iEbXPODClM94OnEJsPBMRyrRSKLWB
         8cljUCx2EQAVJ6WHueRi4NvapoOsBySNCicAfcOOX4XT97+On/abe4de7LRLy26LxPzh
         HdPELaUauV2gIMeDWwEz3EH+Xkbx3YAQSf+BiQrvtHh+6z0AcHtCZnMnI2baEchbMxHf
         WfctDL1vf/GAKPhBcdzKbDlrcMx7dZTpD3XWFRfqlCi91OxebzfVts0AdC6m735Dcf0P
         315A==
X-Forwarded-Encrypted: i=1; AJvYcCWk3BKHDa4pygaxSv9YilbjsV6Gzzm3jKFl8z6hcxe8RSILvTN3RZ51RfHn5T3Wtcay/Gwh3gSDkOOBh8gReKtxd2XWl1vSnvPIeTZD
X-Gm-Message-State: AOJu0YzJsfFfkqByxPlkKlJiLeQLxcPncMSdlF2dBvShCYzes4CSfiOD
	8hHPWlZB1865ZWIZp3+gjqH63UcI/112i0/Lm49TgyMPp+d1O3OTqAE54Z+bpdG/MYaexhA1KFq
	YBw==
X-Google-Smtp-Source: AGHT+IEG/dXsyx++mqFslFlSc76Kv14rRGbklYITWYGwB/A65qSHXmzSLYmI3ivC7yI9+fzybcMRqsjyIHQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a002:0:b0:614:2a7d:5ad3 with SMTP id
 x2-20020a81a002000000b006142a7d5ad3mr980648ywg.0.1712702579990; Tue, 09 Apr
 2024 15:42:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Apr 2024 15:42:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409224256.1581292-1-seanjc@google.com>
Subject: [PATCH] selftests: kselftest_harness: Print empty string, not empty
 fmt on PASS/FAIL
From: Sean Christopherson <seanjc@google.com>
To: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When printing nothing for the diagnostic on PASS/FAIL, use a string format
with an empty string, not an empty format with a NULL parameter.  Clang
complains about the empty format string, which in turn breaks building
with -Werror.

./kselftest_harness.h:1205:30: error: format string is empty [-Werror,-Wformat-zero-length]
                              diagnostic ? "%s" : "", diagnostic);
                                                  ^~
Fixes: 378193eff339 ("selftests: kselftest_harness: let PASS / FAIL provide diagnostic")
Cc: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..79ac9e9ada33 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1197,12 +1197,11 @@ void __run_test(struct __fixture_metadata *f,
 	if (t->results->reason[0])
 		diagnostic = t->results->reason;
 	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
-		diagnostic = NULL;
+		diagnostic = "";
 	else
 		diagnostic = "unknown";
 
-	ksft_test_result_code(t->exit_code, test_name,
-			      diagnostic ? "%s" : "", diagnostic);
+	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
 }
 
 static int test_harness_run(int argc, char **argv)

base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
-- 
2.44.0.478.gd926399ef9-goog


