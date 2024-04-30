Return-Path: <linux-kernel+bounces-164270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5DE8B7B93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3213E281665
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD38173333;
	Tue, 30 Apr 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DxtDsee1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401E13AA51
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490993; cv=none; b=k7deF4kDyUsFyoSMusniRqk+ffGcOPhiFuEwBQRhcEqiJdl5EVkPKe2yuXvHlfCjVZQLK6xp13E6R9mrxKz0rlrUn/UNGCWJhVkqqCqofnomj8Mrlucx5E30sLNX2hvkMgrzLIRhtSbXIooIlnPABytgyGBMwK6fUF+h4GoYc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490993; c=relaxed/simple;
	bh=DWv4Ts4UPDewpPAZDKo61Q6cBJ8156Q/JPUenZNlwS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gy0r7sTaD0lm32hAqv+svxxgHvRcMyJCodEOvwvj2Q6vo3MbEs45blHSwuwnsAFAmha1qNK/viJzMKfGZKoAIjy8jyYcIDtUIOwJZCdtMFNQVybHNZ+uhNoa+hpd98Fi+0ryoMGxullIiOb9gsFXmV2VEJeIuGjI4lBVGO6WuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DxtDsee1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a58e2740cd7so583125266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1714490989; x=1715095789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwZhGhfqKNwGAAazIH0NZHq5xaKIh/aom8Ka+wD6k0o=;
        b=DxtDsee1cf1TcS8HZnkvfrV339hWMODaxe2WkRwpQ8vneDRZBQCC4X0Rg+WQbokpnK
         m4XKfnczpRZPQ5Gt60Ak9ISNYI1gBSjCeTLbTXNqeI448g7darbGz/QS7AQXGN4/eoZ+
         lsvG6InUIhePINQIWRCSM5erDgMBBRJIXsqrXFb5M6ioxxGG/O14yihslgQ9z3ik9Dvu
         gzpuv7RCUy5ApJB048iBLKMYSlYW2xFO4scXAN0ms/xFFrcAwasBW5Ol9XjTkX/Vnfpg
         90Yl2uadCPXhx+D4gAwE1OyKMd0Tf7WgLOsuKki1p4ZdZL+p2e7WQyruK7wmH4YzPmh8
         0a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490989; x=1715095789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwZhGhfqKNwGAAazIH0NZHq5xaKIh/aom8Ka+wD6k0o=;
        b=XYHrcihNGnwKDpScINMwCUOA63ANkn0lbW28sFHlo2nwB0M16vlkNiCHCnQ9wIh1F4
         DgXyvJODb8XVh57GxgGL/hZcgpeiId3l1j1K2Sgej0c/HPHs0dp+knYnJToMq7ddD2zt
         xe9GA/7GRE07a83p2oODxCSxZYNH4XrNH+QkdVHFt3x4vRvWZaodkA2oUrXktfZkVZFM
         OoELOnpHc0R5mEXF9VYRGz7zQmlTagnDMtu51r3leBxobi5l5I+mw3808SRq51c5LG4u
         RXJ0qjxIFJphYp3+MzU3hwZUgg+SKftDWk3w2RNQ73+aD1uv2c9kAOKvtHMbi2HbG3P5
         PLjw==
X-Forwarded-Encrypted: i=1; AJvYcCW/8zhlfMdzcycTSeGRm1ZrL42QKLTU7oveZOhoGMlT9zsfvXiAYykNFErIMXag0Y9NZrwSWhozqpOoRisz2oEY/YJgwXJoSYdOYcM1
X-Gm-Message-State: AOJu0Ywl/DxVbkQQh/np2r2WCDVM5WmRr9/danB/cJERO8FrFGyTGjeD
	sUwjDQMYSeax6O9ekDAxnr9Q9QKB3rLYMi1sG/iF2JQbQ00efhfZR27AHMUTc3k=
X-Google-Smtp-Source: AGHT+IE1VIgErkqyF6WUC8MfU1x1HCl+cuI7ikKsJCapKlEG6DM2SQ6xcH5QUBhrwJPTKa2BHv9lYg==
X-Received: by 2002:a17:906:1cd8:b0:a58:b479:8fdc with SMTP id i24-20020a1709061cd800b00a58b4798fdcmr2923413ejh.1.1714490989389;
        Tue, 30 Apr 2024 08:29:49 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f06e100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f06:e100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709066d4a00b00a52567ca1b6sm15278137ejt.94.2024.04.30.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:29:49 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org,
	david@redhat.com.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 03/15] include/scsi/scsicam.h: forward-declare struct block_device
Date: Tue, 30 Apr 2024 17:29:19 +0200
Message-Id: <20240430152931.1137975-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430152931.1137975-1-max.kellermann@ionos.com>
References: <20240430152931.1137975-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After eliminating includes of linux/mm.h, the following build failure
occurred:

 In file included from drivers/scsi/fdomain.c:87:
 ./include/scsi/scsicam.h:16:31: error: 'struct block_device' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    16 | int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
       |                               ^~~~~~~~~~~~
 ./include/scsi/scsicam.h:17:27: error: 'struct block_device' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    17 | bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3]);
       |                           ^~~~~~~~~~~~
 ./include/scsi/scsicam.h:18:40: error: 'struct block_device' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
    18 | unsigned char *scsi_bios_ptable(struct block_device *bdev);
       |                                        ^~~~~~~~~~~~
 drivers/scsi/fdomain.c: In function 'fdomain_biosparam':
 drivers/scsi/fdomain.c:475:45: error: passing argument 1 of 'scsi_bios_ptable' from incompatible pointer type [-Werror=incompatible-pointer-types]
   475 |         unsigned char *p = scsi_bios_ptable(bdev);
       |                                             ^~~~
       |                                             |
       |                                             struct block_device *
 ./include/scsi/scsicam.h:18:54: note: expected 'struct block_device *' but argument is of type 'struct block_device *'
    18 | unsigned char *scsi_bios_ptable(struct block_device *bdev);
       |                                 ~~~~~~~~~~~~~~~~~~~~~^~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/scsi/scsicam.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/scsi/scsicam.h b/include/scsi/scsicam.h
index 6eb9fb7a57d0..c0de038b76b5 100644
--- a/include/scsi/scsicam.h
+++ b/include/scsi/scsicam.h
@@ -16,6 +16,8 @@
 
 #include <linux/types.h> // for sector_t
 
+struct block_device;
+
 int scsicam_bios_param(struct block_device *bdev, sector_t capacity, int *ip);
 bool scsi_partsize(struct block_device *bdev, sector_t capacity, int geom[3]);
 unsigned char *scsi_bios_ptable(struct block_device *bdev);
-- 
2.39.2


