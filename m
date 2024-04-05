Return-Path: <linux-kernel+bounces-133253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DF89A140
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DF628803F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E719171083;
	Fri,  5 Apr 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9WwOLrq"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602E16F85A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331066; cv=none; b=AjrUXuZ9Q6XdjOEb1zeKjRBxuXpXzDlxu2FmD7XsR0vSBIaXjglq2KT2q3Id/9ZfEdQmybbJXaCRi5ebvRfAkeUYReaSb5g+01r6Jo7b92uUgprgDTLiFPkIxWWAdDiwXgdDEsR9OYLyrAm5O6bf1qv8WiFhq1uiY5lK6Yhwl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331066; c=relaxed/simple;
	bh=y+Iw4yTueQ6xIajMKm0MGMYQKvNZ8/tLiEnP9hFNvE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PiJZKbM2RGlJfWs0/ki27aBFvC4L78CBPto36DIoYuRrS0ptUVVXyULPIqQfAW1E2e1g05cp4HBp5/bI64aEYkaCh/v3eiUGhJ02Yhmajb+M3D/0eLvGMugw9uBMQQgN6EFROROTnb4rzKqGBhQ2/JQiB7Q9uHdgAW3lfGHFPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9WwOLrq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so27409911fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331063; x=1712935863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SS16wuno39hi9Kx30J1PofJZCgdGOIuxdr7bBF8mXmE=;
        b=F9WwOLrqsiutrdef9QIM+TVIQvTreiJ8q8+Sx0QoiuFhy6iiaNSnEMqxhdJBTG1sZb
         ISep3eemnY4xuubXzDOnkPqbzgZj3DcjNHPwRSWDcs40nw+dd7hXh0rjE+nl7XLS4MK0
         QTfIwd2adtJeRYNcLCaHHTEDSmE0iPqiwQiyviZ9oG/dCsNcDKKdXETc814XIroTv55v
         JAzQAeWHYIMD9mbalbCfYesQ5pup3BY3rEgU56xsZ/aa/XbBk6VtW0lEPTgUSB49TjkK
         j/JpV7ySxMiRXWb1X6Z2PS9BGXaIQUzek4BxQ4ShhxWo9qsHsthdLUDYBVZsn3A3ILnS
         K/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331063; x=1712935863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SS16wuno39hi9Kx30J1PofJZCgdGOIuxdr7bBF8mXmE=;
        b=klUBLK18VjePACD7qZN3Q2VcqW7dnsKJmF8gb4hWB0G6h474R0ELcKZODxh3Zc3Xb1
         XLJz7IdsSq+dvHn0+bKvSyuhW0LQSS/wUx5Fbn4rt1g4PB0r1o/LoOYQ0BL2OxtBOqnI
         T+Pwt5uJ0kZvll037TelrblrHeUp5hPiG+FeS26mZKrW3fJlA7gf2vfPGyyCX5u1UIAC
         wGYa6mtdPqgMpSWXSKfVUimwn4RkxOLoW7y/+ksQuTYgTk4qyxiitkQDBREhg7XyRrY5
         OY1nGec/Sep+149nxGpg4CnnduIaS79nSt2JV7+QP8aHADeeEcOFdgzC1Q4dPGQIb4VX
         ejXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIefANtL/B3NBtRX94JrFpTi1IOeVRkHrd1FaHQJHc+j5t3G6xIDlDKaYClhmjoywi6JAK8XLNzbfm48XCBkpte/NJvslhEmGHjA4Y
X-Gm-Message-State: AOJu0Yz596cY/tzBZgWTY1Eehv4LuVjpDJnbBwXkpMHG6h5ZigWHdij7
	GHOEYOL7O8AvK5xnzlNmd1BB7kZbYXOfAakucaOKbXXOfbfBXn+r
X-Google-Smtp-Source: AGHT+IG+sRwiunYU741Mny17rGJ3l8Sy2B7PsFFqnAp0oSBk2M/7j7AvU9Dkc9YywVBpoRQH9rVdJQ==
X-Received: by 2002:a19:3813:0:b0:516:d14a:9692 with SMTP id f19-20020a193813000000b00516d14a9692mr1320618lfa.6.1712331062959;
        Fri, 05 Apr 2024 08:31:02 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id ca19-20020aa7cd73000000b0056dfda8eef3sm906752edb.54.2024.04.05.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:31:02 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	christian.koenig@amd.com,
	megi@xff.cz,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v2 0/3] drm/lima: fix devfreq refcount imbalance for job timeouts
Date: Fri,  5 Apr 2024 17:29:48 +0200
Message-ID: <20240405152951.1531555-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 reference:
https://patchwork.freedesktop.org/series/131902/

Changes v1 -> v2:
- Split synchronize_irq of pp bcast irq change into (new) patch 2.

Erico Nunes (3):
  drm/lima: add mask irq callback to gp and pp
  drm/lima: include pp bcast irq in timeout handler check
  drm/lima: mask irqs in timeout path before hard reset

 drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
 drivers/gpu/drm/lima/lima_bcast.h |  3 +++
 drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
 drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/lima/lima_sched.c |  9 +++++++++
 drivers/gpu/drm/lima/lima_sched.h |  1 +
 6 files changed, 51 insertions(+)

-- 
2.44.0


