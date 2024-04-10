Return-Path: <linux-kernel+bounces-137843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A589E834
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132EB1C20CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCA026AF1;
	Wed, 10 Apr 2024 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjU7UDT3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0437BE65
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716322; cv=none; b=tAArxVW4FsPloXN1Eo55qdy/kswhJb2NZLlr35q7k//j0dS1I9wvAwg9sHElXW0pXcWWTdbt798X4JVjMCjgrju8VXnoFGZheFgmOUyeleORltOl2b5WXe3o9GP5gjT+dg6tk+6F+nAAYV0guAvcLtBD7o1tBvV4VAH1e/7J904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716322; c=relaxed/simple;
	bh=YjgtW4O6D2pXnUbiSWCX6yFlJl3/FlPx89ObJDsmd4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUuyuF+rrcaMGij1Vzk3uoqym9zRsm25cJKd0nQKPk5iHE4BLu4OqJw861ez7nqgPC9iGkVRa1dQQ+cgpW01UUDidsJZC7F4TvYFPeFNlGVbt5oRmvjRQs0uFv4zGKq+46Mxa0m3tB76KTxG+y48doWru2W3t7BUhzP+MLUMalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fjU7UDT3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e455b630acso13654975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712716320; x=1713321120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KD7JtgThpycUE0Aoq39Xz82TRgRPhpFUOyCtv6+6to=;
        b=fjU7UDT3MoWobcYGAgSKElcFxd34Vf0Pvi0Em5Uq9q0giX/FL1fw5F4KXEJt+abLlo
         5ZDn47jZzpL10MEQmnz8BFiu08y2Xn5vdH/1HvU7Myo9StvcomJvaahHSGrOij2O0nRI
         vIl+xK9pNWKBXMmCdmiPHTJyRloA/JEGcCLHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712716320; x=1713321120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KD7JtgThpycUE0Aoq39Xz82TRgRPhpFUOyCtv6+6to=;
        b=lD495CvhKxZVNQBovZ0rbGDFTq2+jsfekK7YdBNfuM3hWtdZeaBHfnvcsG1ylQyimu
         V6fnb4GjnQs+9p6KaYY3rfO8ZNbyRdl1WyNp6SEeI4hTJM0hyQ3q9BjEt8kXGsfAfRcQ
         sGEGp6Hk51Ky9AVnq2UYfUp3mKFa+MTViJg+6xtk3bESjOIfAQF1ZBU7tz3Y+rCM71fz
         1R8BsbblM06Tkg7cZCzgk6p3WKQfc8SxYb25PpjEvyw9xpzYu9EaCkWT2mx7yadKe3Pg
         7oBOOMP3cK5/v8U1ogMIGwbMdq7CWUuXuJBqbyoKdSDKeR5pWtVVr6RBcAGeOeO9yJzZ
         K16w==
X-Forwarded-Encrypted: i=1; AJvYcCVO5W0NE5qoo4nYMnpuXXMAmxEQK402TF5pEKImTzhR057G7qZ+cfiOIOgbnHSuBFjGQG3eSstpgmxoUFFHTYwzEVdN0tIpse5sQMLQ
X-Gm-Message-State: AOJu0YxZ3UHUVa1uDwOi5KtJsPW5DwXEcRDI9+Ug6s2iS7W6WRP7l7B/
	/EOiZ8B4E+2t0luTP05DlmhNMkreBy+Lbtm9VJjwpRqL+OjD2+B4XAHTiGQnbA==
X-Google-Smtp-Source: AGHT+IGK5+IVt9ffYwPxvjBBeO6J4R3cyKBA+dTzAWvukG+Y4c/pPGLemMX+MoytVkvXxRVdvhZjGQ==
X-Received: by 2002:a17:902:c40b:b0:1e3:cce4:bfe8 with SMTP id k11-20020a170902c40b00b001e3cce4bfe8mr1604177plk.65.1712716320011;
        Tue, 09 Apr 2024 19:32:00 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001e469386fddsm3402718plh.40.2024.04.09.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 19:31:58 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	linux-scsi@vger.kernel.org,
	Charles Bertsch <cbertsch@cox.net>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com
Subject: [PATCH 5/5] scsi: qla2xxx: Avoid possible run-time warning with long model_num
Date: Tue,  9 Apr 2024 19:31:54 -0700
Message-Id: <20240410023155.2100422-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410021833.work.750-kees@kernel.org>
References: <20240410021833.work.750-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=keescook@chromium.org;
 h=from:subject; bh=YjgtW4O6D2pXnUbiSWCX6yFlJl3/FlPx89ObJDsmd4s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmFfoafjIE7L1Xkdq4ShmgZE4CB2Na7WaiwJOSS
 I9Jcsw3XHuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZhX6GgAKCRCJcvTf3G3A
 JhtmD/9shMgZv7rVK+0Mwdq8ecrDZWaUePVJYR1eQqMEaRcD2YKHpUX3PXy0NKn0/DijSgeXsoF
 PYlUwU+BXXwfykEox5jZsEjNMxNDr3rnSxW8OaaSRQK+ZC9iawBZlCM257vLD9I35JGr88LnN34
 ER1rAXVQaFRhM/6FD6zDgQmp37vJwZtGJcODZV2g17MQXMSCEyFKrrNWw5YDjG64WofATwOS+HI
 aThrvEabIPgDEG9i9IsnprEz9GuQnMes9MM+OzmeDxjL8Xc99JO2Fs0L9WN6Tj5KmUPTKCBlf+U
 WS3qDIbVz3GTzLs14JNnm0vZIR3knFZwaNXE4y6XddzWFf2TBGsZ9wQY1vyWJsEu/V1ysb65/LG
 RU6RyNmr5XUGOMKBUqGHqas+GBA854pMpyue5ny8qiRW+ZIVwDWj662+w0C4CCwSHwq24fAgCll
 1rlUTo1TXclEKPELVV3nYd7+ArsRzpl+BuHP8c92XGuZTQ7r4xwEo5YK3w4XpkPQbItCCc0hjF6
 jj992WUyLhiTMhPv5zcMEJWCDjcLpbFWhKDyOlrfXKWt8OZSZUImTG44ACawfksi4j7CphlfT3T
 VcYuCjQ7gmoYkYytfyB3KJW4TsuGHSrIWRT+8EbTlWys+nRFuCoqHnWpYPof+NikrvnggJQQF8H kXcrrYQNc/4FBwA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The prior strlcpy() replacement of strncpy() here (which was
later replaced with strscpy()) expected pinfo->model_num (and
pinfo->model_description) to be NUL-terminated, but it is possible
it was not, as the code pattern here shows vha->hw->model_number (and
vha->hw->model_desc) being exactly 1 character larger, and the replaced
strncpy() was copying only up to the size of the source character
array. Replace this with memtostr(), which is the unambiguous way to
convert a maybe not-NUL-terminated character array into a NUL-terminated
string.

Fixes: 527e9b704c3d ("scsi: qla2xxx: Use memcpy() and strlcpy() instead of strcpy() and strncpy()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/qla2xxx/qla_mr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 083f94e43fba..82a7e21ddc83 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1909,10 +1909,8 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 	if (fx_type == FXDISC_GET_CONFIG_INFO) {
 		struct config_info_data *pinfo =
 		    (struct config_info_data *) fdisc->u.fxiocb.rsp_addr;
-		strscpy(vha->hw->model_number, pinfo->model_num,
-			ARRAY_SIZE(vha->hw->model_number));
-		strscpy(vha->hw->model_desc, pinfo->model_description,
-			ARRAY_SIZE(vha->hw->model_desc));
+		memtostr(vha->hw->model_number, pinfo->model_num);
+		memtostr(vha->hw->model_desc, pinfo->model_description);
 		memcpy(&vha->hw->mr.symbolic_name, pinfo->symbolic_name,
 		    sizeof(vha->hw->mr.symbolic_name));
 		memcpy(&vha->hw->mr.serial_num, pinfo->serial_num,
-- 
2.34.1


