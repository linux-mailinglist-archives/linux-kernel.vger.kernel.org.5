Return-Path: <linux-kernel+bounces-34505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D4C837DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2A228BC47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36155EE83;
	Tue, 23 Jan 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q88LuU0a"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1A58228
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970161; cv=none; b=AJ0AUO/2EGFEe9H+2GVCfvZZ0AWs106pa7htbIcD9WKc/Vz41EL463EJ1K/aVJRc9aOI9DUD0KAmiB4dO0KW1Me6My8Vtgjw2OHq+CQ+uT4YY8ywmFuPGh+9UZNZHdZ0oHDcAKbwqWemdN2ppKDkcp4ekcMdne163LQnWkxKDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970161; c=relaxed/simple;
	bh=NqZesPGdhPMPIXo9vzbA31ktFf0tGVVn+vj19wjCjyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c3KTkPafIj/PIvMcZhlqZbW/5TyW6yawZ9Gckqnnikzv0uUFzUaiAf1NdzuxBGS3I/TnMbph2zMilT58oab66bAvcNCVJedeO2wknAk9tJyiaeJOtKxdoda8SM5AtkoTB/WcXlCY3+t8AYBKoIlQkq/FM5A/VZg2C8Rhc4j5m3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q88LuU0a; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso1784036b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970158; x=1706574958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug/eJpZr5lllg7fGddUawSE71HAAShvEy2mnfZ3dSCI=;
        b=Q88LuU0aCSdlMIjPCD+2vN4/TKC4zvp5U9k4fGRAOAl/oKS80yxBw8KPyg3uri24yx
         d+4zNimaNpDjwKiC9iqJUbdfelVkQl/AlM00ynYs9RIKVP0oLp/P+6w6UVHlPSQdg34w
         /SdaeMsd6/On8+6dUiUn9cmSOvrcLOHav46Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970158; x=1706574958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug/eJpZr5lllg7fGddUawSE71HAAShvEy2mnfZ3dSCI=;
        b=TMoFp5MaWgw88lHisNR9yiMM6Pcu1rUeIog0eDB7cYwXMrkJMhBqPirkenh7sXOGao
         t0VU1qyPF1q8umcQxiAa6XwsnLXI+GIDDXgvb37tNIjXYAhW69UqF15iaOAatTX4h4+a
         wrwquWFhCbUhvTc6383xEse/A53X9ibLw1T7GRHFgkv7f2oSub/wCWb79qiAZgB+HM4I
         XQ5lEzBwBQ8m6sve1HscTds87VVQqP8ROnFF0Dm+cIgR4HFLmFksHwpvi+kDTQzEzwS7
         7UGV144DGvbEOvVtR6zN0kmJ8fdqAhkKgio/Dscp4zHuP13+mylkSGHxp2lA0AKUVziC
         Bodg==
X-Gm-Message-State: AOJu0YwaI7+eIzBniYE0R74uXYMvv/85ujR2uQBYHtEjPAXaK08FMYeX
	QGWxDkht+kE1valOILHF8U8Zh8OR/zs3XZVyn61RCt+/4xoAHumqJlvM+E5wGQ==
X-Google-Smtp-Source: AGHT+IGbHO8F/hVPNAS+cYdBXp0aETE+5zl8nFoMOWvMrZu0haS/FCh6jw4MqmTh+lKcIiTOdQpn4w==
X-Received: by 2002:a17:903:189:b0:1d5:c77c:1bad with SMTP id z9-20020a170903018900b001d5c77c1badmr3603424plg.111.1705970157756;
        Mon, 22 Jan 2024 16:35:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ki12-20020a170903068c00b001d739667fc3sm3599795plb.207.2024.01.22.16.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 77/82] virtio: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:52 -0800
Message-Id: <20240123002814.1396804-77-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=keescook@chromium.org;
 h=from:subject; bh=NqZesPGdhPMPIXo9vzbA31ktFf0tGVVn+vj19wjCjyg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMtLBZT/T1zFr3Pk7LIqHdfeKoLB+DZJ6nU
 eJpFhVGy+SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 Jr4wD/wNabBI/0k3KRp2JIInEpH4vZHXxi+YXYN1Q6ldFb4lgheY70n+09zwS5YCFmaS7Phow0q
 sQ3NGqc/LMQu52WIyo9eugQ66X+NsHyvKquukfCdLtx9jSzToGbIYd3DB7x1EEPHipoH7lvtgRD
 nHtsh3kq/C+p70AybGlMydqgrrPNb1DfboeLRz6rxhIfDmWVI5kH+L5Z0ZNxYR3cZC1UOdz2GsH
 KtsEbUpmOKyh2q+iG4Y4H4OtA819vV908Jkbrzzo666no9Hz7D2Hjobm86ELfkhgFZa1vC6CEDk
 8U6VsHqeS46f14sFovFnBkEUS94+Z6gIjrvogisCPd9R3N9fV9/0WsPm5aNbWjXhHnCEkAV2gEB
 aEHMvQSF+FMpizGRzlqkGgFJMIN3SlKmVZH7t/ukK0Lc4kmSKkRYvqf8JMnlbdjnpruwRJf7K+J
 s2JFixwTZjankT9R4zLLM/lfaoqTW626q9FqA+biBMk7J+INeZZ8mXCYTmjch3KoF7TCRQW0Ix5
 cZXEgUMIySr4lY4yafH6qxLzcfXHPLJPd5D38PR+eEu8djg/Lnn9abNdmb3uTneMPskrwx2EaH4
 PL3NCneQumc5tifvlHneHC5q0YWKR5J4nwuLNsc3GN0YIAGrN2jiQuCqADn3NM/LbxnUwX7Jsxw lLlz7iPwOj69EMA==
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..710d3bd45b4f 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -59,7 +59,7 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 
 	length -= start;
 
-	if (start + offset < offset) {
+	if (add_would_overflow(offset, start)) {
 		dev_err(&dev->dev,
 			"virtio_pci: map wrap-around %u+%u\n",
 			start, offset);
@@ -81,7 +81,7 @@ vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 	if (len)
 		*len = length;
 
-	if (minlen + offset < minlen ||
+	if (add_would_overflow(minlen, offset) ||
 	    minlen + offset > pci_resource_len(dev, bar)) {
 		dev_err(&dev->dev,
 			"virtio_pci: map virtio %zu@%u "
-- 
2.34.1


