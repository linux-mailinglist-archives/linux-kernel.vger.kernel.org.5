Return-Path: <linux-kernel+bounces-34495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DB837CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83FF28F1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA85C90A;
	Tue, 23 Jan 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OEYgJ61F"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0F15CD49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969758; cv=none; b=fi+WRa+tj79/yLEvRxskTL+sBbQvD6ZcaEQk+y/9RjpffZYY7bmx7uFQUkshZneCLEBzWtvxQTUyIQrdKu7a0nrhD8Ods+ptBi6snxmAyAB295BpkXvSIY/9CnmpEldbO2U5HYKZP80sKlQ8YQCCwnYlRPmy3aEIkkhGN5PJ2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969758; c=relaxed/simple;
	bh=E4fnTWRdYYjzKyqD4/S7hWZrsgLHeDrGLLUjsAQr6BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeWFqCjTKrn79MigbpyajGy5Cqsl3i4ts+8xlLlL0RXCPy8BCL7qnA6kZo4QYew9oM22qgNq+lunQNlWY3OHD43CzZYUstOz+xuP5QwqDMpQX24o41xk4IupKhCADdAyRXvT6lyT9SFJZyHyyAJW0UfGTXPjtGStyLBgn506Z5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OEYgJ61F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7431e702dso10690425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969756; x=1706574556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ozg2hLXb4DmKd1HybaSf4vbbssFf/awskMowmtEYutc=;
        b=OEYgJ61F8Nx+mz3V87A33fYK0ZzNj/GNdOOR490W+79OtdBN/Ee1TsRyeT2wWPzImY
         T3fosuo6LOH1/fbvbzr20xqwCnTT4Rfzk05nvoOsiRDKMdD56x+zF0j4dMY0J6NG7KBq
         +rLBWd04918N9pUYUPA10pNHGTIM+hy9wv1Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969756; x=1706574556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ozg2hLXb4DmKd1HybaSf4vbbssFf/awskMowmtEYutc=;
        b=wY+n116wFQebgvEqn8m1HyAmJb9d2jBu8bhJOBOudIWaBEzGs1H97c3Cgz+C5/maKH
         MaF2fKLnRsn+6xqbSZDr5LpefbC2FljT+xDjfGhTbyqvLasN55/N7HVEpUiHjKKvkOLg
         puev1ay7H7jdWfsUsD2xXGjOyvaf/VnSLGyiWgkQVAN9jiocV/9ZQWX/PQx65+Qa7ECj
         xv6LdEbtpjGx06FqyOW9z/G1mqUwco1xTKcpCdp01HLWraqmUF2z75ILfffGwX0422d0
         WSg5/iK4EV5xkcR6YvYtEobjQP7GW4nxngPsm4yD2FagcxLUPLduzWuyL8u6WRVdJ9Mn
         n4IQ==
X-Gm-Message-State: AOJu0Yxkc1KbLUhzeC0huPRh+Ofz43T/TZrlcic3WJH1/Kka3QRhZnko
	MGUysiBxdsx8EPrD5gcrI4aOIyMbCf6ok24OXxfjYdYUjfukMDHtysEn67quLQ==
X-Google-Smtp-Source: AGHT+IH3xItkb51q9poV3e4gk9+5kLPIsnJ/D1iDYZ2E26EFuOHRpQfvl1dXLHU1JWWRAwr3q4sIyw==
X-Received: by 2002:a17:902:da86:b0:1d7:510d:745 with SMTP id j6-20020a170902da8600b001d7510d0745mr1963425plx.86.1705969756440;
        Mon, 22 Jan 2024 16:29:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090276c200b001d5d736d1b2sm7671556plt.261.2024.01.22.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 70/82] remoteproc: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:45 -0800
Message-Id: <20240123002814.1396804-70-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3781; i=keescook@chromium.org;
 h=from:subject; bh=E4fnTWRdYYjzKyqD4/S7hWZrsgLHeDrGLLUjsAQr6BY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgL5LhyO8lbwwC9JZQAOOgJrqb3OX0EPvh6l
 8bugQLiKQ2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JnhyD/47D3dgLuSjvUBevHVUX8m0J9aMINDwyLe8YOJ3pS9h4ozZClTAxPECjJJWHjtLg7OJyvy
 xNz1BO/Z4axDLuZsrUujG5UW3sD8uYFJRWwGx0xeNzp5hLbUeLi/yJMah9zRJg9w038a3N6o53/
 /TmiV68eAjsRlBFm3aX7XiefhKVMLDKZhTNEf6CiWF9QfNPS69ktWpDj0ZUa6ui+cDBddo9V61U
 8nBaGbyQHfqJtg9gJaY8hkjJB+D2yT9PKxX1Ty/L50mjkHJAMd5po+wwYKl7tkgjizogRGvsMuT
 +vuIsRfaIQ6rcBLHGTf5vVH7rHZq1pd4CY5zUbo9L9n3uoizF0G1V60SZbG5aMW/E8CMonLRtnI
 knnFGL334iuQo0Gw2CVpMttL4qByUtAQB6n4N1tzT5RPMdiB3T+Ra2gPKRHWQ0pvbCSF9ZdBMR/
 CYnaCLhY5+gqCUlDxOH1w4FxQ1jT++o/5/tS3mDwe3Y4q4/SOskxXFy/lY7mXvF0mCsFY2gkdfF
 royUCOjy+Zt4PH8x+B6LXlzHbZIk7JT57rxoZ/T1VSCghRZmXE1qagz+W1f3UvBUiuTvi4gxm/Z
 MlAZvNbQSQN5ReZV+4nUMvwmaZhJzoKqPsXcgil6mWAuL6mKyS8mAC9pWH4z3nLENV5pftqUiJl XHm7uY9FF7gVkZw==
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
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-remoteproc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/remoteproc/pru_rproc.c             | 2 +-
 drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
 drivers/remoteproc/remoteproc_virtio.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 327f0c7ee3d6..834249ee3dd3 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -893,7 +893,7 @@ pru_rproc_find_interrupt_map(struct device *dev, const struct firmware *fw)
 			continue;
 
 		/* make sure we have the entire irq map */
-		if (offset + size > fw->size || offset + size < size) {
+		if (offset + size > fw->size || add_would_overflow(size, offset)) {
 			dev_err(dev, ".pru_irq_map section truncated\n");
 			return ERR_PTR(-EINVAL);
 		}
diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 94177e416047..b9231cf46d68 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -278,7 +278,7 @@ find_table(struct device *dev, const struct firmware *fw)
 		table = (struct resource_table *)(elf_data + offset);
 
 		/* make sure we have the entire table */
-		if (offset + size > fw_size || offset + size < size) {
+		if (offset + size > fw_size || add_would_overflow(size, offset)) {
 			dev_err(dev, "resource table truncated\n");
 			return NULL;
 		}
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..58742c666e35 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -298,7 +298,7 @@ static void rproc_virtio_get(struct virtio_device *vdev, unsigned int offset,
 	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
 	cfg = &rsc->vring[rsc->num_of_vrings];
 
-	if (offset + len > rsc->config_len || offset + len < len) {
+	if (offset + len > rsc->config_len || add_would_overflow(len, offset)) {
 		dev_err(&vdev->dev, "rproc_virtio_get: access out of bounds\n");
 		return;
 	}
@@ -316,7 +316,7 @@ static void rproc_virtio_set(struct virtio_device *vdev, unsigned int offset,
 	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
 	cfg = &rsc->vring[rsc->num_of_vrings];
 
-	if (offset + len > rsc->config_len || offset + len < len) {
+	if (offset + len > rsc->config_len || add_would_overflow(len, offset)) {
 		dev_err(&vdev->dev, "rproc_virtio_set: access out of bounds\n");
 		return;
 	}
-- 
2.34.1


