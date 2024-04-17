Return-Path: <linux-kernel+bounces-147977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCF8A7C14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23551C21A36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A553801;
	Wed, 17 Apr 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb6kFZcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5ED535A9;
	Wed, 17 Apr 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333987; cv=none; b=giU0nnuHMcRJi9RNqFqxuYP4z+UgBdjSZjzLD6qAObHRwrZhuL6HgVf5Eo1NO/cvxFKkbnLtj02HTynXwN3tV0LZ/o6eh3hc1zY+NlpBXWj+MXp7CYDy+91T1DjbPvYNjkCuG6yzbymeEfNVEFgM3DoXM+9FUgpfMvJZrUvNJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333987; c=relaxed/simple;
	bh=VGmF4lsr+/pNl/QS+FJLIeXDsdk5sY7VV1Yx8agjmfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UD5QWboaew4kE7XurA/eqnDEyfEguwXLW9hpZ/uoxrcAriR5IlBcQv8zShPk+2DrDYlDoojBVoikJDa/10neIo+d0o1Z+Kgc4ZtS9dKOabxRIshZG8V0vL4uUibO6VBxzYKva5kBSrU0QXFupyrC3y2ORGOFKUX7sPB6AZvitCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb6kFZcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECE8C2BD11;
	Wed, 17 Apr 2024 06:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713333986;
	bh=VGmF4lsr+/pNl/QS+FJLIeXDsdk5sY7VV1Yx8agjmfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=eb6kFZcLivKxpEuKYcK15PQxYOvzPh1LgPvu7eDo7SvePQWmoGJv1M+GaiLoLcfma
	 z++AEPX8TqsJD8kFfayIg9+5TXxxGRwpzIKdizVXC66yYV4yDJtJtF+3J/EgIXNbpf
	 3ANOATpg2aOzxrw0oXmLcLhXx+4LQoddt15704DCkCsjHLNaNmWDrrpDrzlS6KBADP
	 E2u9isF1BkNogrjvhaVzXrcjrajVcxRdxH2FluLeWXZgYsDwGz/T8Hb/enC3KI+q8H
	 29uM1/EfrnSw4J9h/aggW9jZy4hWPCSs05YIDzVPDLwGlK9pRROmaPy/gx449q9Gth
	 +BZluUGmIQRVA==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ
Date: Tue, 16 Apr 2024 23:04:34 -0700
Message-ID: <20240417060434.47101-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Fix cpuid_deps[] to list the correct dependencies for GFNI, VAES, and
VPCLMULQDQ.  These features don't depend on AVX512, and there exist CPUs
that support these features but not AVX512.  GFNI actually doesn't even
depend on AVX.

This prevents GFNI from being unnecessarily disabled if AVX is disabled
to mitigate the GDS vulnerability.

This also prevents all three features from being unnecessarily disabled
if AVX512VL (or its dependency AVX512F) were to be disabled, but it
looks like there isn't any case where this happens anyway.

Fixes: c128dbfa0f87 ("x86/cpufeatures: Enable new SSE/AVX/AVX512 CPU features")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7174209d855..946813d816bf 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -42,11 +42,14 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_PCLMULQDQ,		X86_FEATURE_XMM2      },
 	{ X86_FEATURE_SSSE3,			X86_FEATURE_XMM2,     },
 	{ X86_FEATURE_F16C,			X86_FEATURE_XMM2,     },
 	{ X86_FEATURE_AES,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_SHA_NI,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_GFNI,			X86_FEATURE_XMM2      },
 	{ X86_FEATURE_FMA,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_VAES,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX       },
 	{ X86_FEATURE_AVX2,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512F,			X86_FEATURE_AVX,      },
 	{ X86_FEATURE_AVX512IFMA,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512PF,			X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512ER,			X86_FEATURE_AVX512F   },
@@ -54,13 +57,10 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512DQ,			X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512BW,			X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512VL,			X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512VBMI,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VBMI2,		X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_GFNI,			X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VAES,			X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_VNNI,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_BITALG,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_4VNNIW,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_4FMAPS,		X86_FEATURE_AVX512F   },
 	{ X86_FEATURE_AVX512_VPOPCNTDQ,		X86_FEATURE_AVX512F   },

base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
-- 
2.44.0


