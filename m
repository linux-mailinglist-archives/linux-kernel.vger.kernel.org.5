Return-Path: <linux-kernel+bounces-152814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B972D8AC4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7706A280D57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A248787;
	Mon, 22 Apr 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EK8OrJFo"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3448781
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769302; cv=none; b=fYDou0NkGJrXeBaMt8EfRpQZJEfcIKtRCGePeHguvJP/I0YkJgNrPWAlFIBFWepqFzDleOVC7PwTbVZT8gqHy0Rr/k9RPw9uFJ5NiZxs10SSGJW4Dm37odBsT95Ko+85hC4PEbFuv9ez6Lw8qn4u9QCuxWAS3JbYvRDZcDbDXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769302; c=relaxed/simple;
	bh=EocOFi6jpL3NawVx7Uyo1nJQzARyB+e3oj4NB4mpF80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvPZ085la1wHzYsvyRVoa/bBhIU7p9yPtC13JOILEyzNla9fqMe9aN5+c556ZJAhiEbK2WjcixZiZYiTPLgLzdjVSFuPaWA+8Ky1hgz3bhwHXR8kgebuGvTG6IPo3C/MrS/6JQaxYRALgWVXGeYiPQATQruMcQDquXzJQx7Ggno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EK8OrJFo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so4041509b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713769297; x=1714374097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCSO3DBXAP020biPDVOFMShhruKddjro8yUAaqTBNH0=;
        b=EK8OrJFoIVUTGOiRYnCBvP/WKNEi/K+S7wHom8zhgFPlzfUDnJSxk7ILjtiFDXueaG
         Fw8Hj47FJ20373ysVhoXYTEYe3elk1cE9QsCakUayIsKshpwvYTKySsYqvXo/zEIkAhI
         NITg0UaFYjDhmHQqiiJ0Wo0WhEQdZCGzLkJao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713769297; x=1714374097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCSO3DBXAP020biPDVOFMShhruKddjro8yUAaqTBNH0=;
        b=H5LJhkncAliAidQbN8R1jR2UQ0enJPR3Eu8c8nu5ey8G7K3hiX85/v6vv4qndu7+e1
         WFU0/tFtxnUDhOFrHudatH6LeEsBkMfKT978WVK0bwjzGITcw7xZsSMEZ+Tr9HbkZ4h4
         em7QMPOsL8rcEuJ/KuHVI5mTaRsG6FvBXftDrPsMKBWc2balzg0JVGBlEoUZSflJIqx5
         heVYNFhhKxhqE4TjTaQuiVjWe3FusKKxowqKkxpGoFKZL0sUK2tB2V2TiFGc9P7ZEWE4
         e8l7HNQq/wFmbJB8GBAPgyN3c5/qpLg8KuY/zZu1KUnzi/FQZrw2Txr/0oFsgWgjWlSw
         BNyA==
X-Forwarded-Encrypted: i=1; AJvYcCXw+u7QRKgyTys+70eFRETYtRUaTcExoqgj7QjqVlRO7vYrZI92dbdeAO4xl34a8XdIuMWt1RlvyldywLiWvrFJzRWHOhKY6KE/IvNO
X-Gm-Message-State: AOJu0YxyknxCehmCXBqmJ1NTGHbB140yaTyRWWCCoZGQnWQaYcMzxRYN
	EgJ1cZRAlH1IoU3FLTkOqw/vXyWs6T7U1JSkHh3MUFRWrDmuoezNzvCj92KLQg==
X-Google-Smtp-Source: AGHT+IE9ipOcgG52IC1TkXYf/uOIFgKc4zPGU8336WExD6rgd2fXIg7a0e2ELUT5f+/LCjxl0E6R+Q==
X-Received: by 2002:a05:6a00:2181:b0:6e8:f66f:6b33 with SMTP id h1-20020a056a00218100b006e8f66f6b33mr11716708pfi.4.1713769296972;
        Mon, 22 Apr 2024 00:01:36 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:abfb:1876:7a20:8e16])
        by smtp.gmail.com with UTF8SMTPSA id km18-20020a056a003c5200b006efbc365de9sm7145191pfb.121.2024.04.22.00.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:01:35 -0700 (PDT)
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
Subject: [PATCH v2 0/1] virtio: Add suspend support
Date: Mon, 22 Apr 2024 16:01:27 +0900
Message-ID: <20240422070128.1980027-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
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

v1 -> v2:
 - Check for device removal while waiting for suspend bit.
 - Don't try to suspend uninitialized deivces.
 - Use msleep instead of mdelay.

David Stevens (1):
  virtio: Add support for the virtio suspend feature

 drivers/virtio/virtio.c            | 60 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 34 ++++++++---------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++
 include/linux/virtio.h             |  8 ++++
 include/uapi/linux/virtio_config.h | 10 ++++-
 5 files changed, 112 insertions(+), 19 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.769.g3c40516874-goog


