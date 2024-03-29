Return-Path: <linux-kernel+bounces-124072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4A8911D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0B228A691
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640ED381D3;
	Fri, 29 Mar 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSV3564m"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5185240;
	Fri, 29 Mar 2024 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681334; cv=none; b=NSn4XyO82GAiLr3wcvByeQgLhtfXWe3JWmX1vI6/wewsTvVpDz7RBq/RZceoj+B7UBtNhAx6F1rCg6Eblbk9LedUWgSGL8VWGPrmNSjuarpzQcuevwYs3YZRTeyjCYfkYDbE1plDWzcLl7L1kjLB/zsRFgc39JZBhsij3Vs2G8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681334; c=relaxed/simple;
	bh=8V0U4DB9z5K4ycINEZCU0ZBS7/ypUDM+I7MWJRoz/5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1slR39Wv61NK+JUmoM897bYhRS10aE0QAaJ2l8ospiIR9UVVvdXOwE0zhuWy4BkNVGoZHDzDQfc2wWKcdImA1Dk/xdbpzHkcrhjeODVAFsGh5ou5hsOfMAXSx8D0R45UgORF43lS0rw1224KfqaIWStGMC6vNMi9jrhqIdbinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSV3564m; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69107859bedso8721856d6.2;
        Thu, 28 Mar 2024 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711681331; x=1712286131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l426lvUh6BeVGhTpyuaZE5yCtyB0uVXfxVVqg1kMx08=;
        b=NSV3564mXSYYHqdjBaiwZxrssiDgWBSs396tK6j+/Awx/Lo4mdxYrme77NfJpe4GWb
         kLNvBJaVBT2CRhjuzUBQeJ7jlM9Hhy1UxexxSDvqVdfuGm2/QgPxewNXpRzxbDOFEf1E
         4sLn4in+ejeiyMu6Mh20/xzYrkkPnk3AbdZp+nH/aNtQufjCzZ6lbSHdZY54DoPYn+GY
         rtsoRQn6+ajBB2VMf2QeKA23yxbji/zqQ8Y2OVEa8ZPr6tbOv5SDecRD3I1V+bRGcA3Z
         RFStQtELw/iJVrULHrhp7i+pLLJZ2xl9YIoCsdwsfMiazI4dJKd+pBJyrQMk0miBlwCe
         3R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711681331; x=1712286131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l426lvUh6BeVGhTpyuaZE5yCtyB0uVXfxVVqg1kMx08=;
        b=gs2VbVNJ2p7t3+EsT2ADiXQEocha7BANOd4HzCppTMB5mlD9xzP6yEtA2EOyQ1NSm7
         IWR1ssQsX+4UizuU9+CyEpzkl+RAY7mw3jnviwzImEmKF+RpkpvUEDbMl0DgPO6D+aBm
         x7nJnMSo3dAdC1av9VYxVd/yZsiQMfNJnDeMvtet2sXMApmDQTHEOYRYShE1rBT3Ir7c
         qr8equQP9Xpu6IUPDbYeD3qS5GofxfovoAvau7kx2NMDF2BWRQhSHdZiW9d0Vx307saz
         DYkIV2rzWBE96S0gZ8jErRPLM92qRVd6AtmS70Cv/hgpIaAycWEZwoNq5ZuLuarB4oHF
         saVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJl0MkYRvYUio1A5O/F9Ur9KblzCaiGQDmrCjjAlHk9giVsJVVA+zHWg29cLrJ+cSsdIlyTLCs3Dm8VzLw8d4mu8uokqDny+HVuoFNBk7ci4LtpWDPpC9n9h7F5Q33a3Mb
X-Gm-Message-State: AOJu0Yyh23ab57473vZ+SmP9Kcz9sjjTp/xdntUL0yCfJu10ZGC7K8D/
	5Eo/JN1BKhGTdD2xUoIex/UaPY6v2TivriQ7IWs4QSBGGVh4Q1zR
X-Google-Smtp-Source: AGHT+IGVivKY+Q00Qw5qKAM5GfkIGdVIVFj1+sHIQgR1GRlfbJbP0aPHt01EPP4snf2ol27b8XCZ2A==
X-Received: by 2002:a05:6214:1803:b0:691:3b1e:d44b with SMTP id o3-20020a056214180300b006913b1ed44bmr976803qvw.34.1711681331488;
        Thu, 28 Mar 2024 20:02:11 -0700 (PDT)
Received: from lima-default.myfiosgateway.com (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id s2-20020a0562140ca200b00698ecf70710sm441626qvs.65.2024.03.28.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:02:11 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@rutgers.edu,
	sn624@cs.rutgers.edu,
	sn349@cs.rutgers.edu,
	m.shachnai@rutgers.edu,
	paul@isovalent.com,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] Fix latent unsoundness in and/or/xor value tracking
Date: Thu, 28 Mar 2024 23:01:19 -0400
Message-Id: <20240329030119.29995-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scalar(32)_min_max_and/or/xor functions can exhibit unsound behavior
when setting signed bounds. The following example illustrates the issue for
scalar_min_max_and(), but it applies to the other functions.

In scalar_min_max_and() the following clause is executed when ANDing
positive numbers:

		/* ANDing two positives gives a positive, so safe to
		 * cast result into s64.
		 */
		dst_reg->smin_value = dst_reg->umin_value;
		dst_reg->smax_value = dst_reg->umax_value;

However, if umin_value and umax_value of dst_reg cross the sign boundary
(i.e., if (s64)dst_reg->umin_value > (s64)dst_reg->umax_value), then we
will end up with smin_value > smax_value, which is unsound.

Previous works [1, 2] have discovered and reported this issue. Our tool
Agni [3] consideres it a false positive. This is because, during the
verification of the abstract operator scalar_min_max_and(), Agni restricts
its inputs to those passing through reg_bounds_sync(). This mimics
real-world verifier behavior, as reg_bounds_sync() is invariably executed
at the tail of every abstract operator. Therefore, such behavior is
unlikely in an actual verifier execution.

However, it is still unsound for an abstract operator to exhibit behavior
where smin_value > smax_value. This patch fixes it, making the abstract
operator sound for all (well-formed) inputs.

It's worth noting that this patch only modifies the output signed bounds
(smin/smax_value) in cases where it was previously unsound. As such, there
is no change in precision. When the unsigned bounds (umin/umax_value) cross
the sign boundary, they shouldn't be used to update  the signed bounds
(smin/max_value). In only such cases, we set the output signed bounds to
unbounded [S64_MIN, S64_MAX]. We confirmed through SMT verification that
the problem occurs if and only if the unsigned bounds cross the sign
boundary.

[1] https://sanjit-bhat.github.io/assets/pdf/ebpf-verifier-range-analysis22.pdf
[2] https://github.com/bpfverif/agni
[3] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12

Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 76 +++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca6cacf7b42f..9bc4c2b1ca2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13318,18 +13318,19 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
-	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
+	if (dst_reg->s32_min_value >= 0 && smin_val >= 0 &&
+		(s32)dst_reg->u32_min_value < (s32)dst_reg->u32_max_value) {
+		/* ANDing two positives gives a positive, so safe to cast
+		 * u32 result into s32 when u32 doesn't cross sign boundary.
+		 */
+		dst_reg->s32_min_value = dst_reg->u32_min_value;
+		dst_reg->s32_max_value = dst_reg->u32_max_value;
+	} else {
 		/* Lose signed bounds when ANDing negative numbers,
 		 * ain't nobody got time for that.
 		 */
 		dst_reg->s32_min_value = S32_MIN;
 		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		/* ANDing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
 	}
 }
 
@@ -13351,18 +13352,19 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
-	if (dst_reg->smin_value < 0 || smin_val < 0) {
+	if (dst_reg->smin_value >= 0 && smin_val >= 0 &&
+		(s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
+		/* ANDing two positives gives a positive, so safe to cast
+		 * u64 result into s64, when u64 doesn't cross sign boundary.
+		 */
+		dst_reg->smin_value = dst_reg->umin_value;
+		dst_reg->smax_value = dst_reg->umax_value;
+	} else {
 		/* Lose signed bounds when ANDing negative numbers,
 		 * ain't nobody got time for that.
 		 */
 		dst_reg->smin_value = S64_MIN;
 		dst_reg->smax_value = S64_MAX;
-	} else {
-		/* ANDing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
 	}
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
@@ -13387,18 +13389,19 @@ static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->u32_min_value = max(dst_reg->u32_min_value, umin_val);
 	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
-	if (dst_reg->s32_min_value < 0 || smin_val < 0) {
+	if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
+		(s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
+		/* ORing two positives gives a positive, so safe to cast
+		 * u32 result into s32 when u32 doesn't cross sign boundary.
+		 */
+		dst_reg->s32_min_value = dst_reg->u32_min_value;
+		dst_reg->s32_max_value = dst_reg->u32_max_value;
+	} else {
 		/* Lose signed bounds when ORing negative numbers,
 		 * ain't nobody got time for that.
 		 */
 		dst_reg->s32_min_value = S32_MIN;
 		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		/* ORing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
 	}
 }
 
@@ -13420,18 +13423,19 @@ static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = max(dst_reg->umin_value, umin_val);
 	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
-	if (dst_reg->smin_value < 0 || smin_val < 0) {
+	if (dst_reg->smin_value >= 0 && smin_val >= 0 &&
+		(s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
+		/* ORing two positives gives a positive, so safe to cast
+		 * u64 result into s64 when u64 doesn't cross sign boundary.
+		 */
+		dst_reg->smin_value = dst_reg->umin_value;
+		dst_reg->smax_value = dst_reg->umax_value;
+	} else {
 		/* Lose signed bounds when ORing negative numbers,
 		 * ain't nobody got time for that.
 		 */
 		dst_reg->smin_value = S64_MIN;
 		dst_reg->smax_value = S64_MAX;
-	} else {
-		/* ORing two positives gives a positive, so safe to
-		 * cast result into s64.
-		 */
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
 	}
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
@@ -13453,10 +13457,10 @@ static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
 	/* We get both minimum and maximum from the var32_off. */
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = var32_off.value | var32_off.mask;
-
-	if (dst_reg->s32_min_value >= 0 && smin_val >= 0) {
-		/* XORing two positive sign numbers gives a positive,
-		 * so safe to cast u32 result into s32.
+	if (dst_reg->s32_min_value > 0 && smin_val > 0 &&
+		(s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
+		/* XORing two positives gives a positive, so safe to cast
+		 * u32 result into s32 when u32 doesn't cross sign boundary.
 		 */
 		dst_reg->s32_min_value = dst_reg->u32_min_value;
 		dst_reg->s32_max_value = dst_reg->u32_max_value;
@@ -13482,10 +13486,10 @@ static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
 	/* We get both minimum and maximum from the var_off. */
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = dst_reg->var_off.value | dst_reg->var_off.mask;
-
-	if (dst_reg->smin_value >= 0 && smin_val >= 0) {
-		/* XORing two positive sign numbers gives a positive,
-		 * so safe to cast u64 result into s64.
+	if (dst_reg->smin_value >= 0 && smin_val >= 0 &&
+		(s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
+		/* XORing two positives gives a positive, so safe to cast
+		 * u64 result into s64 when u64 doesn't cross sign boundary.
 		 */
 		dst_reg->smin_value = dst_reg->umin_value;
 		dst_reg->smax_value = dst_reg->umax_value;
-- 
2.40.1


