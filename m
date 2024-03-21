Return-Path: <linux-kernel+bounces-109537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8773B881AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85521C20E66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA12187F;
	Thu, 21 Mar 2024 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gdiDxgAv"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016CEC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984640; cv=none; b=NyCuJpaojqyYPrELrrNMvMuNNhw07VSbZSftzdg3F+LDjLoWMEBPb0W+fsPAVe7uFTYTPgzUiYExncdJ6CiBiQxnFqfPC+AGqjboMozNPp7/F6Y15CJMcgYoWyBigAVbaiEDk94MoULhIrvHwv/lme2M6KUpQZzh5Ilf5SQBCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984640; c=relaxed/simple;
	bh=kl/gBd+Lc3gNj5XO0OTXtqTZ86F3iToD6CkJPAtrC0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9Mp8oVjdR5dDnUe4LPDGj4NO3x+pnHy76onti3eXWwfSpkIFk65JnkfOoV8hFILmvhtWky950RQcLKkag61BD+BPhN3qQ/G3Y0NA7AH/ZPtd+cHfnLrGfgpdgQY0/aOfdgwk8OM0Vp08MNVpyfw09a3YOFrBfR0fU27gfa9G8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gdiDxgAv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-788598094c4so26564585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710984638; x=1711589438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRSqzJosPoKI6/qjkm8bzkMOGa+EX2021eXQBZPsvWc=;
        b=gdiDxgAvWQsof557JUlUTFD0gPDyRGRFDeI3UpVw8+NYhBbD2ZBKWGx3xKlEemjvqn
         T2vJEivWJIIzbNGD8mCDxXp8oQqaGRdfsCjBAY6/QIELDsC2wpmhUcjw6L0aDLOIZTS8
         +X3gbiXqy5BARBDHmtiSr7c3cnqPTFPiZUtxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984638; x=1711589438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRSqzJosPoKI6/qjkm8bzkMOGa+EX2021eXQBZPsvWc=;
        b=CodkG4NuKaBbVlARhplBxqPuuC3MyH0oqtzWqh3+EIuttxRKqMGnM0Ffm2Zxh14FNL
         DxeYWV/z0+Zgy7N4nTqm66lfPphEy7/m6EPsMJbW0okKbrOO0mdQWYkhid3v697v3DWQ
         D6cMsrrRz8LYsw91G97GW5grHJD47rD55WvoUTlLwLoQXqYFOTabnZFaAaRp09MJnh7G
         LGUDOiVuShchZzrncofAxKF89V9Qi5O2V+5Eeb5+BEnWH+Cyf7UbXwN3zoDku+Eq1HI7
         hzeFkuvPcX/FboKwPPf22/xN70xuBoX+Dm+A8d36HuHpdzxCIXrOYlJR1W422a+OnUeF
         3zxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeIEJt/RvqdYHArIJ1rlPGn7jtOTp/TJyXNqi95wDqAnPRYFaAV9b5qgwRRHw2i4LNaKzFfj2cHCHnHfIP139rECT2zCSy56V1aYni
X-Gm-Message-State: AOJu0YxbRlK/LHayP32s7LwfewEAFN8wRRczUhLSlMV1WpaRuiTg1kOd
	kJ3HFCBuaWQdo8JkWAbRH190aBHIP2tKuhjtWrpT8p931ubuJd0rw70HuRAUDEZ3o6xJZnNd330
	=
X-Google-Smtp-Source: AGHT+IELQCIYxX1ks+CpfT7OtuOzAf4Z+DIiVFEwIwS6fFzcle3k2lvos9qVE71qOSIUdmeUd1hghQ==
X-Received: by 2002:a05:6a20:6a08:b0:1a3:49a7:f56f with SMTP id p8-20020a056a206a0800b001a349a7f56fmr17972155pzk.2.1710984296424;
        Wed, 20 Mar 2024 18:24:56 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d837:1d3e:d3cd:7674])
        by smtp.gmail.com with UTF8SMTPSA id k10-20020a170902c40a00b001defa97c6basm11137159plk.235.2024.03.20.18.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 18:24:55 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 0/2] Improvements to virtio_balloon pm
Date: Thu, 21 Mar 2024 10:24:43 +0900
Message-ID: <20240321012445.1593685-1-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

The virtio_balloon driver uses wakeup sources to allow the guest to
enter system power management sleep states (e.g. s2idle) without running
the risk of becoming unresponsive to cooperative memory management
requests from the host. This series fixes an issue where wakeup sources
for inflate/deflate were improperly shared between drivers. It also
closes a race where stats requests that come in immediately before a
sleep state transition could fail to be handled in a timely manner.

v1: https://lore.kernel.org/lkml/20240318091034.535573-1-stevensd@google.com/

v1 -> v2:
 - Add comment about virtio-balloon's wakeup source
 - Rename virtio-balloon wakeup event macros

David Stevens (2):
  virtio_balloon: Give the balloon its own wakeup source
  virtio_balloon: Treat stats requests as wakeup events

 drivers/virtio/virtio_balloon.c | 84 +++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 29 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.291.gc1ea87d7ee-goog


