Return-Path: <linux-kernel+bounces-34544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B034C837EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A45B24D98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449B13BE99;
	Tue, 23 Jan 2024 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8KUJJgt"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1E13B795
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970764; cv=none; b=sQW3k3XxSXPkyQL4j3b68SNQA2cxgoA7WP4Yx7ygWDD+KvMTUQ85RNH+nRV/+AzMuRRNqXiLMSBLWhz3hy8slbUM8clBm2YV1FOh3JgDDR0VywBoSkrbbUp9geVyz3UQRl+IfLOPs4HraOJykwlSYjEtgHkYo3vv/IBz5QiZW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970764; c=relaxed/simple;
	bh=rhiNkfwcsBY8pN0Aj3OX3M7epOQG7vcAhg9hdXLwAek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3TuJ66tW2b8kFepQCzMsTN738jHOcurAco8WLqWUd5k3KVbVrrK/LKW7Z7/dd6VulL8FUC2mD93Tor2K1IDgEcWRKUPBzq8Ap4krtQdcisCNTbhDtNHbea7TAIhi7VsTtJAR684QYQZlHpnrTYY6zqRAF3JKQyLyL26GtzmeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j8KUJJgt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dc1f02090fso454403b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970762; x=1706575562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koLuWwEc6R93KvA47iKWZn4p87NyejoVGKhwRpq6uhs=;
        b=j8KUJJgt1OC46MRP1rTSCjb3ikE3ot4TXw9Tukg8wx7H+83b6ohP4LHJ9UNddjKRl2
         fSHxXLpJPJivZGL1FttjKFG88OY1GIfXdbJmN3+4oYrwPx/KuMNiKYcL0usJSbXDhAA/
         pNz4tVDi9c8HBow8e9NE5hiv1GNBnowyNm78Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970762; x=1706575562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koLuWwEc6R93KvA47iKWZn4p87NyejoVGKhwRpq6uhs=;
        b=nH4Dzre987V+3928LlL46RUiQisZAI+gfZI7yd7STp0lKp0wDoMswklzAgqJw3wJjE
         fCOX22reNw+mAypaLcm0bjeGMmmI9y36lCDIGWkkRsmrVGRVtkCIHh3849SBw0mbxBMk
         vVAvFyX9VAtIs0cNkGRNy08tXBF2/HSZquGyhaPoyV5mBv2+XtGQ0GpusAQzVCJkK/hM
         +BHP9CwQviVifDAgxQvLDPlkiPcrsJSKxnbmn8P+W7+rrW7hS5H77I8jGvB/mp++9FQU
         sHfFEk+MR53hxX3XR2rN4xJK9f97ociJXY1Wfk3nPVH8mDlFFbXhsUUPzRBmm7fpeZfD
         JJHA==
X-Gm-Message-State: AOJu0Yy52FtyxS7Q88B0Zcaazx8sgzipDw+RqgdJjlysUeyVWvpv/JFw
	YzP7rM3+gG0NSxEps8Xr9h9M4iJ5B6s37zlGsdX+P4mCUKfMdYV+sRUONzmrjA==
X-Google-Smtp-Source: AGHT+IHnnbXv7LLoQQuo5IERPmQ1aDbHfWs5esMUO9nvMTULeZpbAQsvNcJD7PAXZFLGmSXlcp3hjA==
X-Received: by 2002:a05:6a00:1385:b0:6d9:bf50:196e with SMTP id t5-20020a056a00138500b006d9bf50196emr7531070pfg.19.1705970761998;
        Mon, 22 Jan 2024 16:46:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006dbca81cc36sm5095359pfd.188.2024.01.22.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/82] rds: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:04 -0800
Message-Id: <20240123002814.1396804-29-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=keescook@chromium.org;
 h=from:subject; bh=rhiNkfwcsBY8pN0Aj3OX3M7epOQG7vcAhg9hdXLwAek=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHOI22byaB9aq3JAA27hbl1bc2MNGKba4Qk
 /4yGoiLhCWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JrEqD/9OlGCVGN2v0bgu7DOOkBDw0dRbBn44WXpE64TTI2iaigc2NjR7rlxLD88o/toMj5HP2e8
 +KNhHHhwpn/78Xvy5Fu7OSRDC9Srz2FSdC3GIXCLEy3jHqWqKwpl8s89sAkiyFxj+oaSSd2hp1Z
 yyDFk5tnp4WFMby/w16JX9RJaUhf0Pac+SlpfX6LIhCtEDu16Ym3Zfy8+niKDzyKzgFnik3iBMB
 VlX0qsJgWtq/F5TyYJsdRkzQJiC6uqDjRDOmIrgGbtONP4N3x7eTO2RPGiq6W6sD6wqCCTfno+I
 TOyJBsebkoEC/gOponWRkhVaYuIKk76Rd+mpLbYKMeJ9sXs4c3jKafZerrydOpptCgnp1tAjfY0
 ubJ/wJ50cALOah3qX7E1BFVlS8g/8Cqst3G86qmJ+jErESB4X+ju8cl4kzQJrDdmKNVd/8RAdsb
 wNPuvNZwa3p4pqL+xtVz52yuC0AAOm1Ac9cbprphOD3okeaOY4R3ObpX9GV0e/990fYjXWl4bXk
 aTpyUseDCo88l0yQhgdSuHpJyQLFga2P8uROjArZRuSEBD9HUQ3LrxEC/e8Ns++bdkQ4Yu2PgDo
 Dty8RA9kx6885engKkChV3U1u51xbiNowBg4oJDE5G4q+gYIHu+fcsm6+5uoTqYHDGNdkR/t2tx b/RZj59k1eBK/EQ==
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

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: rds-devel@oss.oracle.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/rds/info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/info.c b/net/rds/info.c
index b6b46a8214a0..87b35d07ce04 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -163,6 +163,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 	unsigned long nr_pages = 0;
 	unsigned long start;
 	rds_info_func func;
+	unsigned long sum;
 	struct page **pages = NULL;
 	int ret;
 	int len;
@@ -175,7 +176,8 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 
 	/* check for all kinds of wrapping and the like */
 	start = (unsigned long)optval;
-	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1 || start + len < start) {
+	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1 ||
+	    check_add_overflow(start, len, &sum)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -184,7 +186,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 	if (len == 0)
 		goto call_func;
 
-	nr_pages = (PAGE_ALIGN(start + len) - (start & PAGE_MASK))
+	nr_pages = (PAGE_ALIGN(sum) - (start & PAGE_MASK))
 			>> PAGE_SHIFT;
 
 	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_KERNEL);
-- 
2.34.1


