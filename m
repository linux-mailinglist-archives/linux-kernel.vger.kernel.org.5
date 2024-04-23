Return-Path: <linux-kernel+bounces-154462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC28ADC51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B351F21957
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5D1C68C;
	Tue, 23 Apr 2024 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YREF1ncp"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F618E1D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843679; cv=none; b=FIda29+23vpoZ+cy4CYywcu4yHOLBaxrg8LzVYSv2xR4hAIUIQOaFji0MU2NBBnAxNtLKzoZwele5/Yi0zxnHYMR75RtPUatrCediQ5poBl9j0QEymR3YGPx2ZkdPM3H/HCT5BKVDVZf0ymvUlG39ShyUrR6Gqtw9l5+wPkBT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843679; c=relaxed/simple;
	bh=+rXh4B5S1uh8zmTXh6puCWL3M5rykn5+v7UEjZMHFl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7CsXNr3hN4+qc7Va4k6byXsrQm5hE+81Ai/em0JRj9PQdQUp5wT+jAKy1x9iGsPJDLC7NiNRcFG+koOZnaU7BnD8m53MZaC/ivbR7P/+WekL4ymp8hyhHA5Q5dPr119E9lVOpBeCOcfOcWWoncB08JHZAO5t1s58XqET//48iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YREF1ncp; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c74a75d9adso2071911b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843677; x=1714448477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjJS7WqCOZAp/WxLm3nihNxnVyk7dtqgQ5dpKk/9wR4=;
        b=YREF1ncp4vF32MdVRf9a8yA8EwQojp0bijgROq2UXD+fgHdG5cMGQ2OopZoQxNivv/
         dlZqlRkhU2qv/qdSeI+hnkgSslhrdzKQpltz6G4BBDH6JWH7NvqtEPQz9onfyJo/soOX
         CjKHkAfZzoJrRX8RD611eArrv0zTRv43SgthiS/umiZDkeuvx2zLxdHbz1ASYeJOQ6MA
         AEZPeN4vV9j05HcQE7syfi8dqVRQ2tJFgNX6dgxksHcP1xc/e7H0izqEJREpbANT3zB2
         jizrHusGUhA+DA7KIJ0zxr8x4qgfVduqkM3UR+XJBOgiHxGV9LNhE7z8fPxXlCwbEB8c
         P07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843677; x=1714448477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjJS7WqCOZAp/WxLm3nihNxnVyk7dtqgQ5dpKk/9wR4=;
        b=a57WxvdVhB93bdMHG0Us2UIz/2OVRaf21CJY34scDK+Gyss/58+2fOUaOLXciKqDyO
         guijlRr6A6LfyVnI2nVaKVmvKyy059D7jvE5sJA3WbXhTIQhXo78qMLa8Q+gEmN6DReA
         EbgDkWKF58GLVppGK03jmCOxCHp/PSPk+7cCit3Vg2i4Hhw7fEHvXBfCs07dO2fHxc9M
         HNU8rXO6Ppp8CXCEmiP0zO49l05Pe9NX5ShnwSrTMFt4vfRVfCxzk0izte0nnibQ9ATp
         08r8+pgd7+X93ibWTywpEs72zS0L/sEkR5hVlm9OLhBBcOVypSohqplVO2CKlZlAjSqO
         R7Qw==
X-Gm-Message-State: AOJu0YyoZsOfNpKkRvJWRS0O2UGy9EaChBeaFjx/5H7fBL3uL6r6cOit
	p1KFJUW9bq707IxJW1eKY3zJDaIrp2FNO7q60Ae4+sQo0Zd0cn78jqrRkOqFtkWiY3kcAgHOusO
	C
X-Google-Smtp-Source: AGHT+IE/aRevXp1DoAmVuqihOBa4j/597rgYv21zcw5kCptxPV/GAXROJbpNbFqZnRba+Tfc/UXisQ==
X-Received: by 2002:aca:2404:0:b0:3c7:4f19:3b9e with SMTP id n4-20020aca2404000000b003c74f193b9emr11880071oic.0.1713843676781;
        Mon, 22 Apr 2024 20:41:16 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:16 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/4] Improve memory statistics for virtio balloon
Date: Tue, 23 Apr 2024 11:41:05 +0800
Message-Id: <20240423034109.1552866-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2 -> v3:
- A few coding style change in
  '[PATCH v3 1/4] virtio_balloon: separate vm events into a function'

v1 -> v2:
- Add a new patch 'virtio_balloon: separate vm events into a function'
  to avoid any compiler warnings(unused stack variable on
  CONFIG_VM_EVENT_COUNTERS=n)
- Suggested by David, use a loop 'for (zid = 0; zid < MAX_NR_ZONES; zid++)'
  to obtain all the stall events.

RFC -> v1:
- several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
- move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'

RFC version:
Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84

zhenwei pi (4):
  virtio_balloon: separate vm events into a function
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 61 ++++++++++++++++++++++-------
 include/uapi/linux/virtio_balloon.h | 16 +++++++-
 2 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.34.1


