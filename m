Return-Path: <linux-kernel+bounces-30466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074B831F09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD211F2256B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C62D61E;
	Thu, 18 Jan 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlWjCP1q"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCB2D603
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602029; cv=none; b=ZH42v9IICmfs6pXEUgbjilXzcz0uAewjpGyPr/AQiQtwG6UpncOEFc6pjP36v+BFKfc8XFTXVEjjQSYdvAxeAV1N0DCUNA+MJnGe5WZEgRh117pis2m1A1vc1ZO1BsShS9ZxB2aOSMnP2WjFZxs9+6h69eT1iglMPUksi7PA+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602029; c=relaxed/simple;
	bh=Y4wmMazQYQJZUJH7gTHSE/jgCDvQWE1mnVYqHc036PU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uyhqmBFqSlKZmknMM4JrTr8G1p9r9AFfWGRDr8mKugu7JGJ77xktR4jifrhXkEyskwn94NYCLI23HiBY43w6xgS2Z14muBAxX8YBLrJvFzn2OT0wV6ntUloqvlOPoC/iJad/3cbiprZhfwOfuIOzGmEllze/NuC5b/BWUuXwC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zokeefe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlWjCP1q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zokeefe.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ecfd153ccfso226953347b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705602027; x=1706206827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4qEVRx2ddSU7H+X65h3lnAP0N9W1FBS+7gcr4VsH4g=;
        b=mlWjCP1qM64P8Kge4a/CapRQne+ORn8IAAvnAnQm128jFDVKElCrP+mNNQs93C+18D
         ffi+RJh4/8UTnHZmPPjUeYbjg6azzPhlyKFcFJs4toF1QQj2b5uMPnPD+XwwRKlyQmq+
         ifpSdcOckKcpTssqitaUs7BEjzVbSM6pJaT71y1ePOxTy22CpoxTv0RASie3UPInvkQZ
         z+jg8wiQ48tsZwXkK3VjhF75FOYaItxisSQRyG5QHTVd4e9MAivUiQoRT2YTIhvRj20Q
         nbF2wntuLIBx4ACAhursubRgCbFqnLwPCUIQbMZHTtlhd+gOyxKDfktao4xyuZ76zFL7
         ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705602027; x=1706206827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4qEVRx2ddSU7H+X65h3lnAP0N9W1FBS+7gcr4VsH4g=;
        b=LVU8NdWs+FCEh/tLMOFPsYEePHn6I0jO7EKK5+BJ4xUDVLb0W2ki+izPDw6SkZSWf/
         NC7Fxx1p6PJsxYihRtNRJDMlWbvB4yw9m8PbvZLRTZwY3K7tV2exFCzF+du2bTqcHNux
         4lYL9XTkexLdeGWsCPwpDr7BUos7VYcqitLXygP5l1z/WwjfVWHA0xq6eZoFjzipEW0d
         6eUI6xjB9BATe8nHtdFYoB29jn7N6x4ia3b0qCYZyYsTiyahcj/4fN6lbCBUh+9I2zEU
         7BU6pxuDB61hsBFGrjfqQqMje4euNzaRfbiA3UMU9/+Ufq04B1WyDGsN/YKzH90/IG62
         sTfA==
X-Gm-Message-State: AOJu0YzLouc+XZ/f+qni21pZYTkAWiLP8FOkvGnPUgiPsIm4iLhqJ9x+
	VlXZgKu4LD5cLAUaOjhrOZy0XsJ/0ngGxb0m1iBZ+vOLiL9XA2fmOR6sfnwM/OSsafQT9UGLzpT
	C8qxWqQ==
X-Google-Smtp-Source: AGHT+IGLUNghu6mxF3SS7FJWjiDaHrXi0fENYH/7FmfNi5ZJUccLxbTU4wHujCNx5nF1YSmUscKnrwovWwgK
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2971])
 (user=zokeefe job=sendgmr) by 2002:a05:6902:181f:b0:dbd:b91e:9b87 with SMTP
 id cf31-20020a056902181f00b00dbdb91e9b87mr525809ybb.2.1705602027541; Thu, 18
 Jan 2024 10:20:27 -0800 (PST)
Date: Thu, 18 Jan 2024 10:19:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118181954.1415197-1-zokeefe@google.com>
Subject: [PATCH] mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again
From: "Zach O'Keefe" <zokeefe@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Zach O'Keefe" <zokeefe@google.com>, Maxim Patlasov <MPatlasov@parallels.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(struct dirty_throttle_control *)->thresh is an unsigned long, but is
passed as the u32 divisor argument to div_u64().  On architectures where
unsigned long is 64 bytes, the argument will be implicitly truncated.

Use div64_u64() instead of div_u64() so that the value used in the "is
this a safe division" check is the same as the divisor.

Also, remove redundant cast of the numerator to u64, as that should
happen implicitly.

This would be difficult to exploit in memcg domain, given the
ratio-based arithmetic domain_drity_limits() uses, but is much easier in
global writeback domain with a BDI_CAP_STRICTLIMIT-backing device, using
e.g. vm.dirty_bytes=(1<<32)*PAGE_SIZE so that dtc->thresh == (1<<32)

Fixes: f6789593d5ce ("mm/page-writeback.c: fix divide by zero in bdi_dirty_limits()")
Cc: Maxim Patlasov <MPatlasov@parallels.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index cd4e4ae77c40a..02147b61712bc 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1638,7 +1638,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
-- 
2.43.0.429.g432eaa2c6b-goog


