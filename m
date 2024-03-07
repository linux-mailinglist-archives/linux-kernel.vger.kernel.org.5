Return-Path: <linux-kernel+bounces-95352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA7874CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B8D284088
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AD8565A;
	Thu,  7 Mar 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFPInN2a"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE3839F6;
	Thu,  7 Mar 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808358; cv=none; b=PpYn1PHR2K/ASIDfZXMn8uvf2nrVt1SUvHQKR2eyBaeRuSvOZeh8Nl0idBGGDatv5ecwXLqLQLtztqLElHEj7ee6XQfuaunUzmEIaNab7CM+NR2u47dkXU50RxObVDTNLF9Pg7TA2fyls/rzDWE8OmQcc6i1+nlgsY8Crn4DkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808358; c=relaxed/simple;
	bh=yWA89RNGcTng5B3DQcpfH6WrYH6fr6hNFOMjzckc8wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g+MRssN+9EiBaFTc90MqHW6ftdHcz01J9yWuOfWCEu2F4lJiUAs9Apob+FL93qW1PSI7a4/o6MA00SRWK/OR8de52NTSjGxPs2jz+h+icOoEwb/zahu5NKVdnGUNSonDECzdNXksaA2rQYTh821OYbO8/lYnSiYswsbqM8ZzxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFPInN2a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e2774bdc7so550034f8f.0;
        Thu, 07 Mar 2024 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709808355; x=1710413155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PY1mUd4kv3FlWkn+eIDNZHfMhyNBjFnxhg0sQrefdgc=;
        b=iFPInN2aN4jI0qxXxKdNjue4ONwyieGRqw3O7Hnz3nxwxny7xgDJ/Lsf93kVgWqBHA
         VBKYkqf+TwQpsiKG9lJil1WjCkbDmZrbNO2SwOP/YrnCQXswwLS+EsPphF/8rPWiyn0v
         Z81zDXbpps5lHKwVZggFWwTIrdn8dvVn5ZfG+a/8Uj0y+d3DWW3ykPJyDm0Mc4fubaGH
         NywnnAcSfgwAXCf7wCPMBHllkl+Qw0Z58olWN6pGhQf5rlnM2SaBSXTx+022sUHk8ITU
         5+pM8QRg+KD+bFekwfgmp9DslOa1BgYEx+8ARPA+ublOz0YgGuDr+6FH2oHSMdMf46KT
         D9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808355; x=1710413155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY1mUd4kv3FlWkn+eIDNZHfMhyNBjFnxhg0sQrefdgc=;
        b=KjxOFw+KnoU7ONwD1bCLswjHIkQMEeRX2OT+iqBpeIW7lnSgUIWyHHg6lNGW9wAEuM
         YG7MNjZHK6dT3ukpDY0hPo8rlHqZimm4wHsz05yDETO5NtF9tFp0eHiQsDg24l9joCX1
         GWOJGC3Ml9T264DxlXqSaY7N8SYSd7vFamBl53CL5jQDj+9RA2WoXAo+lXwiRkVlTvpD
         4fCW5yC1YBr481s3rS9GEM3OCqY6i+zWfbk+hepb4EYElQhpnBhw5ig3gi19hsuWkPka
         5uhZXqKb6BFxhLh2W8Swm9ikaP3IPuzGF5WhgsAp31HANm3oqG6eWJwacre6Rw6kEWmP
         8xeg==
X-Forwarded-Encrypted: i=1; AJvYcCVd9JXtGdQJ4MKpb4VuS3QU31dLGBfQVGQEm1HIP7otgywq4nDcR0iwMn5jfmGlZvvqDEHOzSe+x8s350/VfgrqjAeReTSaKGr8XlEvhD64WbG+xKkZIkUHR4x0MFajCjXb3GinU77v29uuqClePPBTnvLWozpa6N80ExwpQlAhWXxuceFnRA==
X-Gm-Message-State: AOJu0Yx5l3cNWwfWrhSFzokSN/9TsLU47BotfK7oJwgNNnmtNQ8RGjfu
	2FJZheSU3DOzG4okHTtZfobBrENFlf+K5lE/dlHMiz2T0uX4ZQIP
X-Google-Smtp-Source: AGHT+IFkqp30WTOm1FOBZcmNn5eudsr0yZrcK+JhyLknYHSmm1fw/5YxIT2KiGKlZiVlrTYCNjb9lg==
X-Received: by 2002:adf:b60e:0:b0:33d:2d2c:f404 with SMTP id f14-20020adfb60e000000b0033d2d2cf404mr13151240wre.15.1709808354908;
        Thu, 07 Mar 2024 02:45:54 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bq26-20020a5d5a1a000000b0033e2777f313sm15206776wrb.72.2024.03.07.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:45:54 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: target: iscsi: remove unused variable xfer_len
Date: Thu,  7 Mar 2024 10:45:53 +0000
Message-Id: <20240307104553.1980860-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable xfer_len is being initialized and incremented but it is
never actually referenced in any other way. The variable is redundant
and can be removed.

Cleans up clang scan build warning:
drivers/target/iscsi/iscsi_target_erl1.c:586:45: warning: variable
'xfer_len' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/target/iscsi/iscsi_target_erl1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_erl1.c b/drivers/target/iscsi/iscsi_target_erl1.c
index 679720021183..d9a6242264b7 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.c
+++ b/drivers/target/iscsi/iscsi_target_erl1.c
@@ -583,7 +583,7 @@ int iscsit_dataout_datapduinorder_no_fbit(
 	struct iscsi_pdu *pdu)
 {
 	int i, send_recovery_r2t = 0, recovery = 0;
-	u32 length = 0, offset = 0, pdu_count = 0, xfer_len = 0;
+	u32 length = 0, offset = 0, pdu_count = 0;
 	struct iscsit_conn *conn = cmd->conn;
 	struct iscsi_pdu *first_pdu = NULL;
 
@@ -596,7 +596,6 @@ int iscsit_dataout_datapduinorder_no_fbit(
 			if (cmd->pdu_list[i].seq_no == pdu->seq_no) {
 				if (!first_pdu)
 					first_pdu = &cmd->pdu_list[i];
-				xfer_len += cmd->pdu_list[i].length;
 				pdu_count++;
 			} else if (pdu_count)
 				break;
-- 
2.39.2


