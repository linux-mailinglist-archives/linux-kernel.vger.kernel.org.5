Return-Path: <linux-kernel+bounces-144928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68818A4CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568651F22674
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A95D494;
	Mon, 15 Apr 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV/u8K7Q"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FD5CDF2;
	Mon, 15 Apr 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177795; cv=none; b=e5gmvVNvXcj8y330vO4AvlSh0DHdjhhsHpMownPaMTt3F39k7iL4R29WyHB1XN0RO7UYzHnskuXLNquPKLA5zn2kHISffRMhzzjZ3la0SXs3idFEX1bmvvJ0+ktBtt/wRv8SBPPfsUmlo+swfcjwqF9JGL3ew0BZkg8/NJJgkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177795; c=relaxed/simple;
	bh=JH8MwSqAFsToS72JrtYEmcRE4rjWLv1Y2iqEBiPTQWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pMKdryB7F8DZP7hk2Ny4IyiqVagyM3aFEc/OMVtb4eZ0u//0UveFx4EYcuSjUgnsFUC9zMiuYfPj/5dNcW84GF3WVBqx9+fdNJT5Em/Dj3GBYUjnW/UZsSVqQweM/6NUfbIbcg8zNS0MyAppFqqYCF7Y2PgAHGZO65YyQjdmcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV/u8K7Q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4187ccbcd40so995825e9.0;
        Mon, 15 Apr 2024 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177792; x=1713782592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGlqpDyUhGBRXzHvkf8TtBlz3ioiJxXAC/pC1sOteu0=;
        b=HV/u8K7QXINww6/jW4AMvSkcsKs75mnTUNQorQG3RQelUyCDDAOq2/s5H2/LWnsrR8
         ZTCs/NBriv3fuU2uEaJSSyhjcMjSWnBgsYhMiAFnI6BVUyrFfcMJ27xFOpA0XrscYrht
         VrHEdRNkfxy/h6FsP2usLDFBYAs2iXPsXICxJMDQ5+db+1uZ6lyhkrbYVZ4a05ykniAf
         8X7mDCBuEfPvXTb/1TKUIXERvdLQUNZmoJm82elKdJN9+MgIyAZzQr7uLUfwlB9bFYrI
         rklE4/ujcjIhjbmXn/TFOfw+5LzZ+QPQ3N7SHprl+tkVuB00ElsrIRyKzCdtjMMzyD6d
         niCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177792; x=1713782592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGlqpDyUhGBRXzHvkf8TtBlz3ioiJxXAC/pC1sOteu0=;
        b=FMHC57aiMfm2oLm0zRKqpuWyBF5yCk3KOvzoyoRfpsn7S7HNyOiJ8hUnqnvvJ00cN9
         Y3KYaEiEQoFTjDtoqgp8PCuGBrEDVLyBuYbvqt+XMVd3qNwcN3CiTnelSLDF2MD8qZBD
         A6XF3wXxP6dzf9A+b2BjSz89fLg+eEwkDLf1G+y8FK3WI6DdlyIgxlOyZeEVuLI6sRUc
         RjEbyruSBf4/QBW0WBTSPLkM5pYX/rspQ1qhuDNwOdhlF2HNl+NCMu9WuTRuJZKit+ax
         MG8bqPcL+R1hPIzqJtxxJD7n6uQCKKEPULFBnqLTEbYl8opj3suGNyMkM669XXVVkjoe
         fCCA==
X-Forwarded-Encrypted: i=1; AJvYcCV6AN0v5CHAFtjUPHAAsaTHYWICr+EZ1PpDyJXTZ8JzSlqtXDRUB6mQhAFxyq3re0Zaa0O/kQQ9Az90GsNv1xgfOTsKuHpOn1KQ92Tl35dfszaSJuqBDE3WH76+TYeIeFCqBNzdGPkGuA==
X-Gm-Message-State: AOJu0YxN9jGi5PvzD1QOSjqNUvXoqWaZwV2j8ayl/EOfBKTemIm4vcb1
	DB7kQe9seA2xaHV8QOFUxC0xMZkU6uUnJQj8I9Fi/M3SJLNZbDpN
X-Google-Smtp-Source: AGHT+IFUh7ZU3mQagTnSA3Pee9OfW0ReK4jV92+h6qmgPB0mYLosPais5W1sqc+HwGsg+SL/dMS5QA==
X-Received: by 2002:a05:600c:4ecf:b0:416:3365:b9c7 with SMTP id g15-20020a05600c4ecf00b004163365b9c7mr6939172wmq.13.1713177792425;
        Mon, 15 Apr 2024 03:43:12 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b00417f65fb982sm12726072wmb.6.2024.04.15.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:43:12 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E . J . Bottomleye" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: bnx2fc: remove redundant assignment to variable i
Date: Mon, 15 Apr 2024 11:43:11 +0100
Message-Id: <20240415104311.484890-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable i is being assigned a value that is never read, the
following code path via the label ofld_err never refers to the
variable. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/scsi/bnx2fc/bnx2fc_tgt.c:132:5: warning: Value stored to 'i'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/bnx2fc/bnx2fc_tgt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index d91659811eb3..eb3209103312 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -128,10 +128,8 @@ static void bnx2fc_offload_session(struct fcoe_port *port,
 			BNX2FC_TGT_DBG(tgt, "ctx_alloc_failure, "
 				"retry ofld..%d\n", i++);
 			msleep_interruptible(1000);
-			if (i > 3) {
-				i = 0;
+			if (i > 3)
 				goto ofld_err;
-			}
 			goto retry_ofld;
 		}
 		goto ofld_err;
-- 
2.39.2


