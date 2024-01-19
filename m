Return-Path: <linux-kernel+bounces-30741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1E8323C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05E41C23760
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA742117;
	Fri, 19 Jan 2024 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4cdoNWc"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0E17F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635192; cv=none; b=j+ZC36w3HUlUkpW43InJzIgburGcaLkOdOna1tQqnO/p5or20ignIBfAxVynDYQpMC/c17AJhJlAest8Bvn2gVRzE89tmf/kwqPvWaDJgutZtPUFssF6oUu8NhyRmbmi68mE/6kJUBN5TXp6ZcLsQFfVNjzNqkNkKvi5omdV21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635192; c=relaxed/simple;
	bh=C5cJj4Ka7/foS1je4bNK0Ads/1y5LmH0u13xCV7j4Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRYtuwo8dpLSwLe+HsNbHx+ibwDSxsxEvrP1GXDuvrsRogQBd16DLisaWTzNO7yNAqRWhQp/3snGmM7lC0vy5U4FGTpFETOLnCgmsZQynMQNiQMVFiwSmsipwSdmqRXuTnWmSpKomw0S9PSJoj3h3HFtanU3fwYPFscPbmhFg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O4cdoNWc; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6d9ab48faeaso84914b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705635191; x=1706239991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEILTqh/RXJMBB+YR36HUlkVGyOVde6YUHPbxwHA7iM=;
        b=O4cdoNWcXDYveQQyj/Rf1xEa2qmiMoDICIO/8pyjH2GC9RO9dNVJ0+WObkuztrmoUD
         TZIFxgpB5KPu/kFZzBVSYY0Wl1MHjRyNjrmPlf91eFljbt3kSmdrQXbQy+MZ0SR+fJAw
         9kET4fPXJWPS095gL8SoGagnlIGbIdcksCd04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705635191; x=1706239991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEILTqh/RXJMBB+YR36HUlkVGyOVde6YUHPbxwHA7iM=;
        b=ItqZ/X8H6RFekCMddJGyLyuRZQy8Ao9UfZHWFTuUgB0o5MlltyXSkX5KSO5FYMlWzt
         vN4av4KhFwVdWsmyRR0lZisewMg2j2T0Hy06DDLfg6rncChZHvB8DVEKXYjTNBP90i0y
         RMqynDcw/uZGOJGKFZrjQ5PJLt6BR6VnxxNDYAb/BqNGAq+GU1IENZL3N8CnjAY16Fhf
         xB0OdI2tx0VyfBc0BxrVPX1kcQ8PSzx8Gy1QPEHhinof/vucJskuMxIWBxFExISmqKUJ
         f9fTFvzl7uIecPnq6QgO+G+OsvXeAOswOCHsMHMOxb9k2XxgHhD6YzH0W4fmjCjgLm/w
         iUbw==
X-Gm-Message-State: AOJu0YyNVl6WSgba6XPfR2j5Fvfz0wkOADQGawkmz7uFJKnlmHVmjI0l
	DWO64QJaygZhzYw1/tlmzyD9k/+Vq2yCXX/dC3cOYLgCuKcoF6Afn3p/OlRHBA==
X-Google-Smtp-Source: AGHT+IEFxeuO/fG6ld/BUBm6Yi4OVDK+ZMfI8nq9gNKpyVBzwG2r6sD51jIADODKtdwQtKWpJQbJlQ==
X-Received: by 2002:a05:6a00:db:b0:6db:936c:aabe with SMTP id e27-20020a056a0000db00b006db936caabemr1077205pfj.2.1705635190937;
        Thu, 18 Jan 2024 19:33:10 -0800 (PST)
Received: from localhost (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with UTF8SMTPSA id q16-20020a056a00085000b006d9aa04574csm3990493pfk.52.2024.01.18.19.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 19:33:10 -0800 (PST)
From: Tommy Chiang <ototot@chromium.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Tommy Chiang <ototot@chromium.org>
Subject: [PATCH] dma-buf: Add syntax highlighting to code listings in the document
Date: Fri, 19 Jan 2024 03:31:26 +0000
Message-ID: <20240119033126.1802711-1-ototot@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch tries to improve the display of the code listing
on The Linux Kernel documentation website for dma-buf [1] .

Originally, it appears that it was attempting to escape
the '*' character, but looks like it's not necessary (now),
so we are seeing something like '\*' on the webite.

This patch removes these unnecessary backslashes and adds syntax
highlighting to improve the readability of the code listing.

[1] https://docs.kernel.org/driver-api/dma-buf.html

Signed-off-by: Tommy Chiang <ototot@chromium.org>
---
 drivers/dma-buf/dma-buf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 8fe5aa67b167..e083a0ab06d7 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1282,10 +1282,12 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
  *   vmap interface is introduced. Note that on very old 32-bit architectures
  *   vmalloc space might be limited and result in vmap calls failing.
  *
- *   Interfaces::
+ *   Interfaces:
  *
- *      void \*dma_buf_vmap(struct dma_buf \*dmabuf, struct iosys_map \*map)
- *      void dma_buf_vunmap(struct dma_buf \*dmabuf, struct iosys_map \*map)
+ *   .. code-block:: c
+ *
+ *     void *dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
+ *     void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
  *
  *   The vmap call can fail if there is no vmap support in the exporter, or if
  *   it runs out of vmalloc space. Note that the dma-buf layer keeps a reference
@@ -1342,10 +1344,11 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF);
  *   enough, since adding interfaces to intercept pagefaults and allow pte
  *   shootdowns would increase the complexity quite a bit.
  *
- *   Interface::
+ *   Interface:
+ *
+ *   .. code-block:: c
  *
- *      int dma_buf_mmap(struct dma_buf \*, struct vm_area_struct \*,
- *		       unsigned long);
+ *     int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *, unsigned long);
  *
  *   If the importing subsystem simply provides a special-purpose mmap call to
  *   set up a mapping in userspace, calling do_mmap with &dma_buf.file will
-- 
2.43.0.381.gb435a96ce8-goog


