Return-Path: <linux-kernel+bounces-34527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB8837DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB84289894
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17566162E31;
	Tue, 23 Jan 2024 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D717a4+h"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F516274B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970186; cv=none; b=BAQRtWoWk3fYOaqm/smL+Vvr09fq1FJ6xEBncRmcc9tcOe0vFawbri9r9sxpXRbMZKDbUD3ZDfllyLOgyx6u75UQWh8gaDsSws2jgByEG5S19fV5q9+f+TY2YAjvl+uwo4TAV2MqW88ve3wSNua2BTvoZJAxG9s9lOtApIPZ4wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970186; c=relaxed/simple;
	bh=ep/lIptA9L4lr+f06tjVEEoLQ4MXnnp5iyNA3nOOpBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTFCyCag5o5n7YMF8IZGZRaiQbsIjcLHgXkyabcCqdseKmJ7AGCeerB7k9ymfeoEv730RxFUG+PcruYCAA5N1sXzUOSb8+EWcNWXpQkYyyZt6i7++x3Pjrr+ztuuJJNDCcU11z95yOJyCkNLOjrQFHMJpEEtrmw0fxk7h5k1VD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D717a4+h; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1775821a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970184; x=1706574984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu7JD83IcutVIpR+vN3JS6ozq09X5iWFwWB5AcENu1U=;
        b=D717a4+hchIOaKmqCVEbuWLkT6x4LFiOyOsg9820QbdtTjnxtBvHUX6v4s6sZAbgvD
         D4akV6dkP7oQx+px2xduOIbAhE/yLcXvQFa9oQhjhlsoZtyGFvpTPXrv6LxqsYGwZgtO
         dX9BlM60yl+1W5Ip70JgQgCk7MGQ1OsMud9/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970184; x=1706574984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu7JD83IcutVIpR+vN3JS6ozq09X5iWFwWB5AcENu1U=;
        b=FNkH5eMguHVczx0tmGA4YGE4aybz0dDRMnFmApAzEwvwdYKTMaIVTtenWwKuqpIWAD
         lDu0Ztz2pxNuq4B49eaQoPWaXAmfNmR4p+gynHC20adf6c/bNRB1b0vxkRLT/o2MDakI
         Dnz+j7VaFh8fPO7dP/0uhjJnN6PqPULY8zGMTVGggB9IMcbCyix3pNZxV2fDDtws9EC0
         TZ0yMmRR6XI5Qth0PsLTxN4P0KDKGX9D5ZNWiPcspCG3wAWTbmHWy10qj5qOZmUvB8qO
         0CK595BJ9Wh7hIN5czLqL6bi8S5e6ofbVcCtBvzhwuNbWZZRnvXs5bA7e7LmNGUyzatu
         vvkA==
X-Gm-Message-State: AOJu0Yy/862tNedv6H5qc1OELhexZqSUQ2Fj5K2T7ZfKPIiVw8/c2hv/
	afonzCpCPkot1R/4QGxCeNre+NgQm+w1bwpWPRT1T2R/rhYQ0gKnCE3ZuWQiTA==
X-Google-Smtp-Source: AGHT+IHU9ZlgSYh0eMx7669Diqv2Km4wEiGnQJDHlmT3vbHjtvtixLA5vnHZex0ljbCE4nmOmTLkXQ==
X-Received: by 2002:a17:90b:3443:b0:290:20:2e7d with SMTP id lj3-20020a17090b344300b0029000202e7dmr2129175pjb.47.1705970184314;
        Mon, 22 Jan 2024 16:36:24 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sx7-20020a17090b2cc700b0029072c64439sm5247062pjb.5.2024.01.22.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 42/82] bcachefs: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:17 -0800
Message-Id: <20240123002814.1396804-42-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3557; i=keescook@chromium.org;
 h=from:subject; bh=ep/lIptA9L4lr+f06tjVEEoLQ4MXnnp5iyNA3nOOpBE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgI2+Elt1IhHtkv5xgC3b3FRvTtskbiERH9l
 1ZNTeeF/b2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JjCLD/9xtD8moVS+50gZifAJkdU1ZG18tKRem8TQm9iujCTKM7k0RA9Gt8uWtXoWJI2iqcmr7so
 6wDWNya25DwDHnA6i6cJcDCSKOUIWj9scqgsnc/vc4ITbCC36C8LufYn9hTR2C8dxojAdmv+oWg
 AbBeJl5BpJ/nNaasEJCbPtG/FaEqLUr1cVCXz1f4t/JfMlxIvR3A1axBfLBZIMGjQDtJYXHkL9p
 LFdbnw42F7LQAZdMegEC8ocQU04rYslKCLVrwhOjQCcsv6Ws6kE9vl7RJy+m+9uPUWC0Sl3Du+I
 kaPcZbyCi8S96+rC+3Sqkn8nxgB0Ji3KlCWYiom6XD/SCas2mJlZV/Fsgw4ZogGoScMiYHeDVxA
 3uTAn740ytyh0GrA0mTeQCmVpWEEgRgl8yAEEFpN/x5prVl7B7OWBB3fLqipeDFvn+08dE6MQ44
 bK5og4830KAx7t1L/91syH794xNxDXyBfKMXgc8jHBAoPFLHV3Z11nzBQfhMFaLNyc3nKMCbkiP
 HgAKEE2E/rqRQZXoovbv2UsHH9qCg3D+20pG3URgwo9T1LgXTwOm94X59lEyn4fM80SQYA4kwUq
 lecpfKL9uzLXFqhGSnccEE+zNNjAHSFYJQxxeCm4t8TK3hf2xjDUryQOdhwdB+FESFtDBAzIc48 oZI7aHBEQ8bWKPQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/bcachefs/bkey.c  | 4 ++--
 fs/bcachefs/fs.c    | 2 +-
 fs/bcachefs/quota.c | 2 +-
 fs/bcachefs/util.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/bcachefs/bkey.c b/fs/bcachefs/bkey.c
index 76e79a15ba08..c68f1cfd579e 100644
--- a/fs/bcachefs/bkey.c
+++ b/fs/bcachefs/bkey.c
@@ -448,7 +448,7 @@ static bool bkey_format_has_too_big_fields(const struct bkey_format *f)
 			: 0;
 		u64 field_offset = le64_to_cpu(f->field_offset[i]);
 
-		if (packed_max + field_offset < packed_max ||
+		if (add_would_overflow(packed_max, field_offset) ||
 		    packed_max + field_offset > unpacked_max)
 			return true;
 	}
@@ -664,7 +664,7 @@ int bch2_bkey_format_invalid(struct bch_fs *c,
 				: 0;
 			u64 field_offset = le64_to_cpu(f->field_offset[i]);
 
-			if (packed_max + field_offset < packed_max ||
+			if (add_would_overflow(packed_max, field_offset) ||
 			    packed_max + field_offset > unpacked_max) {
 				prt_printf(err, "field %u too large: %llu + %llu > %llu",
 					   i, packed_max, field_offset, unpacked_max);
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index ec419b8e2c43..00a606171656 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -901,7 +901,7 @@ static int bch2_fiemap(struct inode *vinode, struct fiemap_extent_info *info,
 	if (ret)
 		return ret;
 
-	if (start + len < start)
+	if (add_would_overflow(start, len))
 		return -EINVAL;
 
 	start >>= 9;
diff --git a/fs/bcachefs/quota.c b/fs/bcachefs/quota.c
index e68b34eab90a..1738b1fc1c75 100644
--- a/fs/bcachefs/quota.c
+++ b/fs/bcachefs/quota.c
@@ -392,7 +392,7 @@ static void __bch2_quota_transfer(struct bch_memquota *src_q,
 				  enum quota_counters counter, s64 v)
 {
 	BUG_ON(v > src_q->c[counter].v);
-	BUG_ON(v + dst_q->c[counter].v < v);
+	BUG_ON(add_would_overflow(v, dst_q->c[counter].v));
 
 	src_q->c[counter].v -= v;
 	dst_q->c[counter].v += v;
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index a135136adeee..2200c81edbd2 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -148,7 +148,7 @@ static int __bch2_strtou64_h(const char *cp, u64 *res)
 		return -ERANGE;
 
 	f_n = div_u64(f_n * b, f_d);
-	if (v + f_n < v)
+	if (add_would_overflow(v, f_n))
 		return -ERANGE;
 	v += f_n;
 
-- 
2.34.1


