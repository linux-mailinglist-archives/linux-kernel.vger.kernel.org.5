Return-Path: <linux-kernel+bounces-123017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6DE89011C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9422F299508
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811912D1E9;
	Thu, 28 Mar 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8I3yIcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D382880;
	Thu, 28 Mar 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634746; cv=none; b=pN1rcF6129xR3vkULVnwu8ddyxHrRVphYLXirm1bDch+e/VPlmi2CIeshOxQHxPquAzDBGNBSHtb9wSn2/ZlPo3Bq2v1aQtHZiT4Nnkvwra9QPiqAds6Z74BQYaGw2vzAb/ikOjj5ACK9Fyv02IDrBgCxaSPJuNwil3p75AzwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634746; c=relaxed/simple;
	bh=zNvaXNiAxujiBLsJut5bqHVAOcViyLttpUXYqlyY1zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnUY5BWxDwW6pJVerghyXcLb40NJP6OI/IaHQRER1Szhy3KYM93sAZRX4lr54kO6DEun1NP0+xpxF/iqZsSFDd1xnDyPlKOxngrcW2A+/55okVRzBe8e1WHIDq6np5dZ79tzA06lrPcjM5sEwlTjNrsmi5z8wFN3QDq2UGijxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8I3yIcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7EBC43399;
	Thu, 28 Mar 2024 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634746;
	bh=zNvaXNiAxujiBLsJut5bqHVAOcViyLttpUXYqlyY1zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8I3yIcnVZWurSiHgMev/PaIZPsXUsNqVQKwHJ7+mgOKCcTPUXHUqEknMBntcAITu
	 lBy02fiZlzDY1HrIVoQ6ESWZpX1lmaA3l6htVPoAbw69TmEc+E9473jJ6QlohLlyqS
	 UvnWqh6+PSPbvVAseM27BsB1r34XDSYPszmmLgTuVSzOnsTLT0YhDQcHTrBtUGsHQz
	 x5iqy1CFrKZrcmoPc07sHv5F+4iVgPeDzXgUiw2CpeHLueJ835FfTGSTEMJzTp8nqF
	 H6czJFBuYYnPeGiMFd3KYXKRYt8+RywOmtLP0YP1mcjwGDZT8kfs3lYxjMUscxR1q+
	 tDvHoVJ3e2TIQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Chris Down <chris@chrisdown.name>,
	Petr Mladek <pmladek@suse.com>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 02/11] scsi: devinfo: rework scsi_strcpy_devinfo()
Date: Thu, 28 Mar 2024 15:04:46 +0100
Message-Id: <20240328140512.4148825-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

scsi_strcpy_devinfo() appears to work as intended but its semantics are
so confusing that gcc warns about it when -Wstringop-truncation is enabled:

In function 'scsi_strcpy_devinfo',
    inlined from 'scsi_dev_info_list_add_keyed' at drivers/scsi/scsi_devinfo.c:370:2:
drivers/scsi/scsi_devinfo.c:297:9: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
  297 |         strncpy(to, from, to_length);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reorganize the function to completely separate the nul-terminated from
the space-padded/non-terminated case. The former is just strscpy_pad(),
while the latter does not have a standard function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/scsi_devinfo.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index ba7237e83863..58726c15ebac 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -290,18 +290,28 @@ static struct scsi_dev_info_list_table *scsi_devinfo_lookup_by_key(int key)
 static void scsi_strcpy_devinfo(char *name, char *to, size_t to_length,
 				char *from, int compatible)
 {
-	size_t from_length;
+	int ret;
 
-	from_length = strlen(from);
-	/* This zero-pads the destination */
-	strncpy(to, from, to_length);
-	if (from_length < to_length && !compatible) {
-		/*
-		 * space pad the string if it is short.
-		 */
-		memset(&to[from_length], ' ', to_length - from_length);
+	if (compatible) {
+		/* This zero-pads and nul-terminates the destination */
+		ret = strscpy_pad(to, from, to_length);
+	} else {
+		/* no nul-termination but space-padding for short strings */
+		size_t from_length = strlen(from);
+		ret = from_length;
+
+		if (from_length > to_length) {
+			from_length = to_length;
+			ret = -E2BIG;
+		}
+
+		memcpy(to, from, from_length);
+
+		if (from_length < to_length)
+			memset(&to[from_length], ' ', to_length - from_length);
 	}
-	if (from_length > to_length)
+
+	if (ret < 0)
 		 printk(KERN_WARNING "%s: %s string '%s' is too long\n",
 			__func__, name, from);
 }
-- 
2.39.2


