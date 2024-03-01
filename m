Return-Path: <linux-kernel+bounces-87988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B912486DBD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F00ABB22AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CFC69943;
	Fri,  1 Mar 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="0Ak2i4vO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FB69311
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276683; cv=none; b=ItnuFGDNWnBwum5TQsInVdEMpnT56PDftFxv9dnlDUiHbr0FA1rVg8TyYOpUDZS7k4s+QJ9/BjPTW3vs+jCoNEPYbnWdo5KjCjUVfBAV9n7NNC7v1Wrd8+ebvDlxBegsVZ1+ym2ZsCa+OC4MLOwLc+9fNO6WlhlHqdEUDwkiTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276683; c=relaxed/simple;
	bh=o9pz1fk2aOp4FTnpNEe6vcQsleQQatyQgwaGbA6imWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3XOahn9mmcrLTFJNVIYg1Gop4DmpjCkCkehpAILwKQI8/nUMvH1ydxcfRSqZStjtyYVwY1DzZN/MuqSp7bVVgEUOtB12YGTXE7RGciQAQJYvnQK1LIr5/FxJP2w1EwWcFV6ICvld/0zpTNaLip5nE26ysOCcJXCrLPK4T7AlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=0Ak2i4vO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcad814986so15772945ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709276681; x=1709881481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I9y5UTmAvN64WBQDc3/nGiscexf4NuEbldIfBdk9l8=;
        b=0Ak2i4vOzdAv0MP8yo+m3lZ7xbl3HfICbqJKOeS9d9HIBLn+UphKWhJ5gCaMHGBUEu
         QSE9i7OOcyu9dYkl9oxjSAxOlRirf7CZM4sTDmCah1/aIz8tNh4kRAS5YnAP1N3lfKPz
         mckq/T64wArfSq61QNUPOh+EK56Em/vn+2UhvOZJdqSCB6wRBP4Zkgdk633I9iuTs109
         x5omRlk/ZrsXK+ZDjDectUijBwwmqXbFpp0BCrZEjhYt8ylxu84vW/ucHqQ/KC1Rld4t
         F0euM8eZM+xYN8vzpY+pvktScKJ3eDiEbqN9h3UKXbncxGHxVeIUqyLOwUaTQ+Cq/L8/
         SNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709276681; x=1709881481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I9y5UTmAvN64WBQDc3/nGiscexf4NuEbldIfBdk9l8=;
        b=OQXhodPT7ae+QqMLWUlfkGt/uvFPXUQa3cXKUJt6ntulmVjNIyfSvyC/fjHhmiA7iT
         fjBJ3H6LQpu13K/4dAK7S16QdQOpq8vxCEUNADJ/QRSFja/rAWZFsR6qvna9ytMeqjKX
         5GA6XmyhupSxIi+HfAoLHjC8aKr5hV3Eyba3eGEQJfZKM8mTy3p8p73dO6+3c2R54t1M
         mBv0pXiQxUIMsuu1SYjZ1/g0Q6xWBATBWslh0qlwsqzWlrs/VFHHZ8b6UbnI6JuW5nAU
         ksnnnXKIeq1M/TICrMxRerayTEZwH7f7KwyCy5rn2dLWc8plJ/jCOO8Vqt6qimJJWArC
         KziQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1Pgy5bkTNrsR2p0V4NLrp4fsUSDY6xBtuFb6ADt2GH5fN/t9FTyCV33bxAkeNncOAKwSUA3qAZN6K2nbOi37VxC4PTLwZ3A9by4R
X-Gm-Message-State: AOJu0Yw/pAGr/jRcdR6fLrCqOlnFUMXlji5TfPunQqQ5KKrTxqAVsWKk
	jP7+4tm6STE+Mi2mZ/dvqkqN32VMfdjuovqxRneY/kKHWm31V4bWQ5tQLQI7bxs=
X-Google-Smtp-Source: AGHT+IG1evhX78/me7PET0oAJgA3nxqOzq5iUYRGdsuy0iEq8MCjfjuExh8MPjsu4Icqji+9or42Vw==
X-Received: by 2002:a17:902:c947:b0:1dc:3e49:677d with SMTP id i7-20020a170902c94700b001dc3e49677dmr1048143pla.26.1709276681293;
        Thu, 29 Feb 2024 23:04:41 -0800 (PST)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id e5-20020a170902784500b001dcdf24e32csm1999601pln.111.2024.02.29.23.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:04:41 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: make module parameter scmd_timeout writable
Date: Fri,  1 Mar 2024 02:04:21 -0500
Message-ID: <20240301070422.1739020-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an scmd times out, block layer calls megasas_reset_timer to
make further decisions. scmd_timeout indicates when an scmd is really
timed-out. If we want to make this process more fast, we can decrease
this value. This patch allows users to change this value in run-time.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..2a165e5dc7a3 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -91,7 +91,7 @@ module_param(dual_qdepth_disable, int, 0444);
 MODULE_PARM_DESC(dual_qdepth_disable, "Disable dual queue depth feature. Default: 0");
 
 static unsigned int scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
-module_param(scmd_timeout, int, 0444);
+module_param(scmd_timeout, int, 0644);
 MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), default 90s. See megasas_reset_timer.");
 
 int perf_mode = -1;
-- 
2.43.0


