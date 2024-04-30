Return-Path: <linux-kernel+bounces-164819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584438B8360
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131BD281455
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27902101A3;
	Tue, 30 Apr 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWHplws+"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA021018A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521116; cv=none; b=FbrmAKA93lVOnVErBidkeBpghzpCxl9hcHGiBovL6s8LPw4xnv8Y31rzYCPBUrbSv6/C1Rmi+7BaLFThLM4bjKr8CiOPtYrimUZRk+nFY9KfRW0fUvBn7G4EddFbfM/CjDuCI8O4gEp/LCREPTXIFfgLnI7Kg43wg4dE80fpNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521116; c=relaxed/simple;
	bh=q4hPe+xh62Uhmba9PSnhrp62is8QeTzw3cIQCnwAJEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZRqaod8Dw4J6xtZ0MPluEm98PR3qqQ5czuDbHNXW7A2GJqhefdm8m8oww3zqsbi0X4yC7PbYXGlo+XCQpwAzIH+OMx6vrBnFfpKmoUzq8rhezFE86U+VpquEk7vmz4ehvg8jSbUxywzaU88ygqoiU4JJTUq5oZ2oFQG6Byuv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWHplws+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f3efd63657so4023873b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521114; x=1715125914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4hPe+xh62Uhmba9PSnhrp62is8QeTzw3cIQCnwAJEs=;
        b=fWHplws+HuPMbth/LpVBuYyCKV3VezSbPCuMynJ43py3TiLLFXs0XF6Zy7+UAKBkcL
         L6xvJNDKll/sKysPKHifQgWCRNbdG2S9fAFMBoQ1RiM8q7kEGKLo9/g9VfwA4up+ccU+
         JPI1GPoNCpiP/Q/NNHke0c/iScOO1zickkY5GCKqyuioIv48OVzJICbW3OPGqolkl9CL
         GPvycfDVQMuGRh3q3I3/O8leXrGeMdvQSwX4ovya18su1I8vgWwUfXcZivIXRuV7jXlP
         GQKv+NkS/BPF/K6sfmc4mFoF3TkE3N5k48KyKFCzUpLDTrmxRIbBuTcwBA62o49TM2oF
         lVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521114; x=1715125914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4hPe+xh62Uhmba9PSnhrp62is8QeTzw3cIQCnwAJEs=;
        b=Jk6V8hq7mxWJIUAcjx9WWyiKH0N2yvPb7nKvcWrimcsQkZXYAYj+Y72ipTn1PWUXvF
         IG8iedW99MydXmNT3D+L0G72I1JDsUVPHlf67kxnR4zG5L/P2x8dYssjgjcHvZwaUiI7
         bErV3Vwe8ir1e2dvRrRzlQBSxcp8gVsxWDvJeYcKuCiBvgPwfP1Dlqu+2HIqrLeNVOnz
         KnUjSx2a4VIF1foSt5Yejb2GidzP3hBkYha2Szsj5/AWaUZy7faOzLfET3jDda5Qd3/e
         VcTfZEkn5nEp5oFYoHmj0b1y6KMtwaONqpra5kxBc1ZrO7antRgWBSVUclCgnFMH/D4P
         s/QA==
X-Gm-Message-State: AOJu0YwXIb37n8ABQe/PnSyxOz01GGnPZ8LS3FrJ4R4Ww06epkKdXy30
	C73jr8wPGBMZKJnyg+hphjbJZnSqDxJCZJGYxCO4bSfuzFNNdFF2DKsgQBh4ZN3LFRS8N44uarm
	bNQ==
X-Google-Smtp-Source: AGHT+IHPv5XeMbDkvtBTnEts/QdkOCkwWDd40+iQpyVBsIIp17OfrlSk+SNOnAl1YwhsfOoviBzkyHBxHOU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:13a3:b0:6f3:854c:de57 with SMTP id
 t35-20020a056a0013a300b006f3854cde57mr83407pfg.3.1714521114135; Tue, 30 Apr
 2024 16:51:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:17 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-9-edliaw@google.com>
Subject: [PATCH v1 08/10] selftests/rtc: Compile with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/rtc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
index 55198ecc04db..4ef7ee969003 100644
--- a/tools/testing/selftests/rtc/Makefile
+++ b/tools/testing/selftests/rtc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -D_GNU_SOURCE
 LDLIBS += -lrt -lpthread -lm

 TEST_GEN_PROGS = rtctest
--
2.45.0.rc0.197.gbae5840b3b-goog


