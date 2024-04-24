Return-Path: <linux-kernel+bounces-157113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D92D8B0CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35211F28F08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072A15FD07;
	Wed, 24 Apr 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbCUUbHv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C615E80A;
	Wed, 24 Apr 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969920; cv=none; b=T3oiNRL6AuUJKmOAmtg3RiF0Un+7KmdbbdxMQZaLOiMhpydWUHbuCqPUtV9tLxr5cPiA1+rM3MQmL0KhsxIq6AeuzCF/AoP/xO4p2GHgWKzcYDL8R4DNKY33QA7QrKyvg/HReE2iUtd9DlXCE8syneP/XqHc77zr5J3R9uRfOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969920; c=relaxed/simple;
	bh=VaK7Dc1ZgvBEif7TgA4tb6qDQZcFjHq4J5gOM7PFKSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZO+TX8DJO37EqEyAEAuK2EXHPa5ZmMEnxmtItrHqFz+ikG2abKKXk3VWGaYqAyEf90gpvv7Kr5ULZOojbvvCgQmjk1PFUt9blk34DqvUSn2zVRBiunknwcgXSHi4yylfL9HycpHNm4M1vm/bQtq42P8N/0bPwfJlZIwjWYtr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbCUUbHv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso6343387b3a.1;
        Wed, 24 Apr 2024 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969919; x=1714574719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jL5u74w472gVJgaoFOuurGlZOko3LllmO61ppXmRiz4=;
        b=kbCUUbHvb6kqlJysGrCiMp4wEBrqwI5jJgoXCK/Ct9PIfx9TiqIRsuYbehs6/tlsyx
         D14XPa7YFKSQnzMT1fgLsE6GBiE965oTg043e8p0h1BjtblSM/1/vD/D+Xs+iKMw/mAs
         CZlgXlUV/qsQOPBBIP/7blZZz88Frdy+3/IouDH0xTebmJr5msmPiuPTAO0XvoZDhw+8
         p/CvMhlrkR/F00P/ghKlhmhl/ffF6HK0+3EnOQHBEYADTrfCzaDF4Y+uMy2jnJQKb+Ry
         8bfLt2MAeNz2lOvJKQR3GxAO5C2z6MtLxhQ0OtpuzKjZcG30Ly+EsePLTxCH+WyDm5ZJ
         YF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969919; x=1714574719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL5u74w472gVJgaoFOuurGlZOko3LllmO61ppXmRiz4=;
        b=kAXqEoWC2UCrhdOK7a1QuQpzmnsjZhI+j0j8sC4SQTmmJDmelP6x8E5hIdPrNY4EDn
         QVcmaSiDU4oPhQq7mcK/GFQwf8YtHheuEJdV8PgCkrM6fWvFt4djGnDPTh4LlgvOBtv6
         lTvbMBIofJaFic0WOiXOK72B2QxIgUMi0D7IdX8j0Dzak9qyYHc04Wizw39abEWLZ5r2
         J4g1c0mwCGlUZM9f2O8N+c5qrEF5/qkuoUWlifi5bM/okv6miQxWxErxc3G54MYb/+DR
         UHGAUxNglcPgguQstLK/PsPLq3FY2YOP0s2eZXdtWvpMqHhPwVtw2uU1qVsr99uqmy+y
         Nx5g==
X-Forwarded-Encrypted: i=1; AJvYcCV2imJRMEtuG/vjajD6AXaWveg+xAT8a0ScYq31JY8CNT5T7Aq1HOTfWwfJp+Qf33G73QWsMhOj/bhKBev/UqCPqRz0TFhaAB55hKylv+swjsk4kKYe505d0IMoxB6lD4/RuRv2v/JPUbULsDAJwRwLvvWDujSHJ0EyvFQXaGgxOorKvmzB04BSXNPPM/HHsdRanvwIEDdOngUYVek=
X-Gm-Message-State: AOJu0YxlKE0aaUduyJpN76i/z3PI0M++Nw1Gh906oP8+MUmfgQ6yTTuu
	6UH37xAUP+BdloLgXQ9AEK/kCz9+dX4PK+K/YOaVNOReBkfyEj8C
X-Google-Smtp-Source: AGHT+IE49U7h6wBv9tAHHYnz5iq0qU+ilw050QEUjqScU0CG/D47UjZh+SWsBkObp/54Z41ZULTZ/Q==
X-Received: by 2002:a05:6a20:5606:b0:1a7:5184:8d14 with SMTP id ir6-20020a056a20560600b001a751848d14mr2731695pzc.46.1713969918691;
        Wed, 24 Apr 2024 07:45:18 -0700 (PDT)
Received: from [127.0.1.1] ([2001:ee0:50f5:5d0:6ca6:7f20:5242:67cc])
        by smtp.googlemail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm11495743pfr.38.2024.04.24.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:45:18 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 24 Apr 2024 21:44:21 +0700
Subject: [PATCH v2 4/6] qedf: ensure the copied buf is NUL terminated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-fix-oob-read-v2-4-f1f1b53a10f4@gmail.com>
References: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
In-Reply-To: <20240424-fix-oob-read-v2-0-f1f1b53a10f4@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
 Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Anil Gurumurthy <anil.gurumurthy@qlogic.com>, 
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Fabian Frederick <fabf@skynet.be>, Saurav Kashyap <skashyap@marvell.com>, 
 GR-QLogic-Storage-Upstream@marvell.com, 
 Nilesh Javali <nilesh.javali@cavium.com>, Arun Easi <arun.easi@cavium.com>, 
 Manish Rangankar <manish.rangankar@cavium.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Sunil Goutham <sgoutham@marvell.com>, 
 Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Saurav Kashyap <saurav.kashyap@cavium.com>, linux-s390@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>
X-Mailer: b4 0.13.0

Currently, we allocate a count-sized kernel buffer and copy count from
userspace to that buffer. Later, we use kstrtouint on this buffer but we
don't ensure that the string is terminated inside the buffer, this can
lead to OOB read when using kstrtouint. Fix this issue by using
memdup_user_nul instead of memdup_user.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/scsi/qedf/qedf_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd0..96174353e389 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -170,7 +170,7 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 	if (!count || *ppos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 

-- 
2.34.1


