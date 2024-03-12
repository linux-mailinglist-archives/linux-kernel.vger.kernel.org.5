Return-Path: <linux-kernel+bounces-100043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B452C87912F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C3BB22EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1037829F;
	Tue, 12 Mar 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cTqTNznD"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D97829A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236515; cv=none; b=a6qSwmaCtomqvZYRBVtzwQfHIm58AJRn01ncunvlzNzFZ30F3e/+yopaD7eH4e4XutzB0co+AGeRxwxqje76dMjH+BMgAZ/5nOL9pq61weXiCvK9/mckNqoyPW4/7hmj2qSxshujaPAwKY+lqB+zEFZDfxL4ZmMdLh8PwJrYcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236515; c=relaxed/simple;
	bh=DWv4Ts4UPDewpPAZDKo61Q6cBJ8156Q/JPUenZNlwS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sG0kyI1S3C3F7+VG3zrnxW52L1ep/69sWmimDSSe6LuzEX6CHI7xCCoon5WauKgsxh4GU6QCef6B7yXNAPmb7xDBB5Z2+hzARGEqxjjtFhrEf9w5ikKx08RR2u/IuvVI197atcFZ2Gw4aQxHadSpsPQIO+/RFtNG8PfeP78ShPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cTqTNznD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a450bedffdfso687327066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710236512; x=1710841312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwZhGhfqKNwGAAazIH0NZHq5xaKIh/aom8Ka+wD6k0o=;
        b=cTqTNznDZmvsPWVZT66oPREe0PSlZgk0NQqVYHSzR+qcxnpzwFdstF5c8OX5VWCkfj
         StjaUDvEJzJ09p3jujvrg1LTG8YopjXvB6JlO7Jx99+q9vVbp2HexjKtZBEm1WuH2yiM
         Q9CPH6rN+rapJ/mM0Z4jshMBponam/Dciljxa8l+at+tIwHWutUv2nOrfODhalbg4ccb
         2XO4zk/TXn19NFGFE2U+urVGJphWkLS2cedWAh+TNghKWrT5aGgvxsjECXD/28jMOvG+
         CVShTxv+Y1xW4uQdCDPI0iE3lr8g72thu/TZxFdQrIp4M2GlcmviVtw76skyDRnJv4Fc
         pPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236512; x=1710841312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwZhGhfqKNwGAAazIH0NZHq5xaKIh/aom8Ka+wD6k0o=;
        b=w5TMknCmPjrO+n9KBf+ylokwNZTq3B+AvOV8/FMZFAZmUSz4JFq/tcbDDJo/eeBAoW
         NX1YxB9VAMP7i6rQa5Df14d8jSeocjrSSBqpnKMSmvS/9NIvTxbizdCV4Qan5cIT62Fd
         hiquTzOEJbOkYQS83bjEiXLe9ho0rn9fMxHRJnZwmR388+KUMkWW3wcvLWxP/yL/Wx4B
         Zfz8QiTQnGLbmdGySZTYvKCPeyMWgkMJpL0Og61M2/kdSbrwvO1ZWGhPUR/s5rzoAh9b
         gTxL/MkNnMrT8oBhOGKNZaOv/HNwzar57BHs/jLnpbmdKnDhuE+mXDPhDsn9YWfmwqpq
         x4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzlhKIg1sI+foqIKX6qpNtSjq59+7njWOEAk912KJkgkDPFEA/i6oryC096QQG/mfEGzqlCL/OqL216nV/ISxu/74pxvxE6LKBQ+i5
X-Gm-Message-State: AOJu0Yy6sebJzcKUaGRNYsIMy9e56Wv9US7aMN+FBtKClLwWPvvmGi0M
	amhUx+Cp0qrkRssYVFNG4QgLjb8LicsoJWg7uKQZBg32v9u8jsTYg4ahg1VKFgQ=
X-Google-Smtp-Source: AGHT+IGZ51L07Hxzh1l+kWJcWu3Z+jyW9NEQT6L12fUL6Sj5QODioFM9B75fNjp+LPCzAWlnCP3kmw==
X-Received: by 2002:a17:906:264b:b0:a45:ba06:e501 with SMTP id i11-20020a170906264b00b00a45ba06e501mr5018173ejc.57.1710236512023;
        Tue, 12 Mar 2024 02:41:52 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170906e95600b00a4623030893sm2091961ejb.126.2024.03.12.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:41:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 03/15] include/scsi/scsicam.h: forward-declare struct block_device
Date: Tue, 12 Mar 2024 10:41:21 +0100
Message-Id: <20240312094133.2084996-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312094133.2084996-1-max.kellermann@ionos.com>
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
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


