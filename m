Return-Path: <linux-kernel+bounces-137838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EDA89E82C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A1F1C22DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FDDC144;
	Wed, 10 Apr 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RhBMpdHB"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857015CB5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716320; cv=none; b=OMtmNkTPZQPPjGtPUFYAeaEdG+fTOKjNf1XhzZQQuds2SiufoF7dQGXslALiPJhFzcXysBGYksGjlSIZ3qq6/NgPRcaDG4v93yZrE2KMDd+PScahMKVnXPE28WGcXcSUMpp56U3ZauL0GMWYmRqm8JXLWAyriON+iMpT9gqSFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716320; c=relaxed/simple;
	bh=U04NgByTSLz3ezEZdZ9fh7Nk8N6aKk3aFVSqTRfRHjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ambKiowpgDkyWTs2Qsv5WyLAGO84Rs8RlcG/+E0fzwzRP2iTb3PEMevyPAx/mh6eSuz2eYZWm8AZsWTix0QBw0zDLlGFGR+l2NMdwDsVLj1c0t0yMO5uPHOBagnaZMpn1wq4zud5risdZ7zaAfjD+w8Dh4JUBSzrYvbdv6osqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RhBMpdHB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so4922387a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712716317; x=1713321117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlPZnmbgI1osTC93HPkRH848zgm3O+BOnZN3oq69oh0=;
        b=RhBMpdHBSMCgij83Cs2UFmtMNeQloXFhW7aAz58ETUvP416Mn4xplkZzzpgF5ndy2O
         zBTm8ciEzPQ/AKq4SCyQuW8ob+mD9MB6Fj7pWwEuHeV4VvcfvLTZCbwCbxmpfl6CpWND
         9NrPmpFUSDoHiBJVcFv822FYVxARwa9avku2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712716317; x=1713321117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlPZnmbgI1osTC93HPkRH848zgm3O+BOnZN3oq69oh0=;
        b=k/X29Dontegh+RU1ukoitm3Acm679dpteiVm4qOne0DOjfCDDQpFzPuDdKjWU4VOZS
         8CLtU02DEmWCCmf5EqdFdi6AkSIxe5XtIAPAcm8oHXRASFLjmIArVH+UlJFekR9gdBnc
         NaJojyYQCDsqjTUBVg7V1qdCZwcGbldkDL6C33H/AvhtxREG3uLk8i4QHYaNsf5LHqfi
         dhTWhHpFWIOdk5gjSRW6Q4VAzJ1+MuoEqm79KePHLeEczf7MbMQMCtPCHVRWQZ/7Azhq
         yx+0erQlwuYppfvAwWjy2J5+9hYEkLdom5KMCLam1VnRyv/VykX+KPZis+OfPXYvDplr
         9b6g==
X-Forwarded-Encrypted: i=1; AJvYcCVMUNqAsiIUuKWBsx4MazBKcEklerJHwjPi13IrCLvCxM5MsI60BPgmbFGqlqYmLQQyYjPaBgzjH/7QEfDCigoYUZ6Y7AP4aw6hETG3
X-Gm-Message-State: AOJu0Yx/stC+3dWHEdX9Q0X9b6683okpRveioYqv/8rBe5Lk2SbCILB7
	CdWJ3PsCgAQkNIFyPDTy3jajhdDcJL9XqlJIeO9fVf6VUP4KEeSKIHU8oOnAiQ==
X-Google-Smtp-Source: AGHT+IHfu78WL0uAZuDeq/rlPxqp3NVD2u7O2q3IqroeTJfRqm4Rp6+M6UwBBFdMN6WcRcmEZ3JqtA==
X-Received: by 2002:a17:90a:d918:b0:29b:fb23:863e with SMTP id c24-20020a17090ad91800b0029bfb23863emr1952806pjv.17.1712716316789;
        Tue, 09 Apr 2024 19:31:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b002a2b06ce909sm377923pjy.17.2024.04.09.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 19:31:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	Charles Bertsch <cbertsch@cox.net>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: [PATCH 3/5] scsi: mpt3sas: Avoid possible run-time warning with long manufacturer strings
Date: Tue,  9 Apr 2024 19:31:52 -0700
Message-Id: <20240410023155.2100422-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410021833.work.750-kees@kernel.org>
References: <20240410021833.work.750-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3122; i=keescook@chromium.org;
 h=from:subject; bh=U04NgByTSLz3ezEZdZ9fh7Nk8N6aKk3aFVSqTRfRHjg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmFfoaalwyvrfJyK8QIq7jmpi8j+mOqTzMVE7Um
 sEjOcCl/WSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZhX6GgAKCRCJcvTf3G3A
 JmufD/9ZRH3yvaQcFC4/t2XLUlydOVs8JOSZfUGQuJvfCw04zGXkb1ifJ2XBR1NnzlI8BmHEzKa
 GXMKW0wDvIaC6h9gSbRqVZUIr6BM5BNfW6mDoywzySg0bfALOE7RA0lEYN4SNMRIURimdHR/+x2
 RKtaoqzrJRBzhQxoVBmUvM/K/HIoJrGfKjVvq9vz9asbgVPFlUKh2vtmtlF2TGM5dfJ0RvJBlXn
 RGfNjoCmh6HQieSmaroLtXhKPs301s7PjJzIC4KvxBro1mMf2dksl5wKXtuJGlfo05gwqaNvPVK
 tBG4Nb71gynpv7I9pzqPi/rviXyauLY5A8firvTXxSoYPbZrrxXDzbtbEpiVsD/7qb8H4lmKnEA
 PLNDtqVKSZmeDn9tJ0MZEKlP2HC6DcAuCUoKoahUv5d6vcAEc2cJ/rE48qirb9xpivUo+zhRLK3
 JymNPRKUukbz45C85+u7NjdSAytO0HLyb2QZa9aVX3epJ25QZwwRNbVroRe/lq8rIYelMGoUR8g
 d6RpVTr/gVw+h/BYTvSC4kBwIHFEmtBKkeTqvDLc/YFjsdGzJit3yzVjRKTaucTgNn2kgyOPWf8
 eoMNopJ9h7NfqQd9yx5LH/58wQl367q0F9kbBZJGKwhEKY1HDeo8Afm+ZyXX9j1Uf77yKOoYixP r8BS5P3p6k2SJtg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The prior strscpy() replacement of strncpy() here expected the
manufacture_reply strings to be NUL-terminated, but it is possible
they are not, as the code pattern here shows, e.g., edev->vendor_id
being exactly 1 character larger than manufacture_reply->vendor_id,
and the replaced strncpy() was copying only up to the size of the
source character array. Replace this with memtostr(), which is the
unambiguous way to convert a maybe not-NUL-terminated character array
into a NUL-terminated string.

Fixes: b7e9712a02e8 ("scsi: mpt3sas: Replace deprecated strncpy() with strscpy()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 258647fc6bdd..1320e06727df 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4774,7 +4774,7 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPTER *ioc)
 	char desc[17] = {0};
 	u32 iounit_pg1_flags;
 
-	strscpy(desc, ioc->manu_pg0.ChipName, sizeof(desc));
+	memtostr(desc, ioc->manu_pg0.ChipName);
 	ioc_info(ioc, "%s: FWVersion(%02d.%02d.%02d.%02d), ChipRevision(0x%02x)\n",
 		 desc,
 		 (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 76f9a9177198..d84413b77d84 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -458,17 +458,13 @@ _transport_expander_report_manufacture(struct MPT3SAS_ADAPTER *ioc,
 			goto out;
 
 		manufacture_reply = data_out + sizeof(struct rep_manu_request);
-		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
-			sizeof(edev->vendor_id));
-		strscpy(edev->product_id, manufacture_reply->product_id,
-			sizeof(edev->product_id));
-		strscpy(edev->product_rev, manufacture_reply->product_rev,
-			sizeof(edev->product_rev));
+		memtostr(edev->vendor_id, manufacture_reply->vendor_id);
+		memtostr(edev->product_id, manufacture_reply->product_id);
+		memtostr(edev->product_rev, manufacture_reply->product_rev);
 		edev->level = manufacture_reply->sas_format & 1;
 		if (edev->level) {
-			strscpy(edev->component_vendor_id,
-				manufacture_reply->component_vendor_id,
-				sizeof(edev->component_vendor_id));
+			memtostr(edev->component_vendor_id,
+				 manufacture_reply->component_vendor_id);
 			tmp = (u8 *)&manufacture_reply->component_id;
 			edev->component_id = tmp[0] << 8 | tmp[1];
 			edev->component_revision_id =
-- 
2.34.1


