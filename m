Return-Path: <linux-kernel+bounces-148183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17248A7ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8791C213BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5E13AD11;
	Wed, 17 Apr 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sj1NnL8k"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276913AA2C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344090; cv=none; b=rtwPQadtGGg1H6ktiX6pImm+jyBTh4FnitRT/nukoDBe90Yxdp7lGqrl94PWaHotABa70w1EM/HxEhyBLzZXDBvVadBmjgX+v4NdJFJwpZj5tn65FxjnWO070Z51lU9+NlhkN0KYDECAPNZ6ghYgomRZE/QhS/RtxajGRAAKQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344090; c=relaxed/simple;
	bh=N7A3jGE8bdkzDk1G6rtaXPVEo6AX7ewmylEEts1blXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyaQW66p/5ccA4k61LfsSUlpGZ41/oSh813x7qaMzh+wpRR7LJR2IqGD2L9auXkvmo/W9PJPuZrMu9NyOV8OtxORblZLmtr1pKg1MrqXv0IsQDkGbeKVhn/3LsCGbBtKa4/gp0ZvWhzEx23/anItV3BaxvaOW7DrBdhprNv8OZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sj1NnL8k; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c709e5e4f9so2669047b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713344088; x=1713948888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFkwjonhIvXxYdQf8hNNoSZ38i5oFeLHVaeXNjGQb1s=;
        b=Sj1NnL8kMJrjjfgxtdYSU+8E8DhU45UBpJ3lulEYxXqT9o0UHz84NyDV1S3y5k21oE
         1feff/0E6dPPiIpL2IeVZINgH/EOApT+tmzrCdQoQwq//QwCJgE4gC6ttIIv8T5Ez9bC
         uNgUAW024xHsJm1Dtl6GLTH3Zf7DX6RQqBSf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344088; x=1713948888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFkwjonhIvXxYdQf8hNNoSZ38i5oFeLHVaeXNjGQb1s=;
        b=sB3R7Rc8flfClYE5Exo+tSAeHZWfIdTavbnZv0NrlbBPq9k2cKZriTD9gUO0RqAEal
         IfckS3Tg1an5+Ln7eG9F0PSqLc2YYWxBQOaAQc6VjuWHJ1JI/WSbmAWbmGtYzQ7KLYFP
         15WVuTYUZRfdXgQemHZGJvLB/rT6DA4k8kziOHg0CNEV5d1qcekLP+ATzwHbQoYUcfwH
         QRKMum/qgMFDaCg0+qS17qi0GSeJzpMUB6M6R57tQWXokJ1L2eO0Z51JnFYzYf/1s9At
         dUsgvP5z9diLpBzXgzsNkSlgrYiuQ7ww4IKfSQucELnyhV9nv/LSqJWG1kKWCbakDp0+
         G5fw==
X-Forwarded-Encrypted: i=1; AJvYcCWO5++UQDhQxNoGkh2gFiHLIfxiELpw18ZxHgrb1TdheuPDBMWLz5HQo30ukMt8YRbwxYzXkD+18ugc6burHUkObMgCmWwyYivd5Sl9
X-Gm-Message-State: AOJu0YyaQoIP7gc9rZ8RtrjxeuDqueId+WpdJ04cF6kC3qw1ptZQ8EIV
	1/OY2T2RTXGTwaXUu8zuWEc7whxXIdEVQsVtQFG3XHy4FNuGPLxE6SIb3zp/eA==
X-Google-Smtp-Source: AGHT+IH/skKeDI2AaMFIPP2N6QCzxY8s6CJN0kGimah7GiAF0hypemY2faExIQIZPSQ6HyUknuYxUw==
X-Received: by 2002:a05:6808:10d3:b0:3c6:62f:4fd4 with SMTP id s19-20020a05680810d300b003c6062f4fd4mr20829154ois.4.1713344087913;
        Wed, 17 Apr 2024 01:54:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:c7f8:50e7:e1ff:743b])
        by smtp.gmail.com with UTF8SMTPSA id u21-20020aa78395000000b006edda81101esm2462698pfm.80.2024.04.17.01.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:54:47 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-dev@lists.oasis-open.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH 0/1] virtio: Add suspend support
Date: Wed, 17 Apr 2024 17:54:38 +0900
Message-ID: <20240417085440.4036535-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for the virtio device suspend feature
that is under discussion. Unfortunately, the virtio mailing list is
currently being migrated, so recent discussion of the proposal is not
archived anywhere. There current version of the proposal is a
combination of [1] and [2].

[1] https://lore.kernel.org/all/20230906081637.32185-3-lingshan.zhu@intel.com/
[2] https://lists.oasis-open.org/archives/virtio-comment/202402/msg00088.html

David Stevens (1):
  virtio: Add support for the virtio suspend feature

 drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
 include/linux/virtio.h             |  2 ++
 include/uapi/linux/virtio_config.h | 10 +++++++++-
 5 files changed, 74 insertions(+), 18 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.683.g7961c838ac-goog


