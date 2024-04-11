Return-Path: <linux-kernel+bounces-140787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779218A18F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259AB1F211BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CA53E12;
	Thu, 11 Apr 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SSJ8aiqo"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB95337F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849541; cv=none; b=qAhJgv/9jllge+SKCouPTraUXZt4vCPK+sz2jvkBmbnHwqFXdnIjKZ37srK0S5O/um3OBTmSWxUZf5+sZeyEbUgu6VEUq7ktSwuu4sU99Hvhu3lhYnCnMlOpFbnpNPG6+/moHpdosR+wn123P+NYMRiK8owocliw6wvFfNCtXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849541; c=relaxed/simple;
	bh=fwjOnCSBUcF3RfH5JrEHh3MbFgy/aD7CKledGMu4oXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bney4ewSsPBC8OOJy5z4nZxqqfv5dEpdvRSjVxg0eQkIwUoYjXSeJ932co4hNIF7AyoKJQw6humaSORtSLAOfqwaTNkMTo7PAtajRjAPew08R/h/IDavEd0GpM98/2RaZTTWIVAeXhXpV71+AI+RU/NGyfgV3GG4IwcjEXWPV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SSJ8aiqo; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16100639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849539; x=1713454339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qszcc7+Aw0jGDf//SUQC/piDZbAT+nT2K/TXHDYobA=;
        b=SSJ8aiqos4UXTu80zBWdGmPJBBnJFCf6NSeBj5EHZ7/SXXDz/4w1Azgtgd/PH5JqV9
         aEiZ3YmjMc+NODLWtNayXAwjGwGYFcI9YmKeN+QOQVw3xmLTngTtePoVt15DDbR/YN29
         pgHkI9MQU+Qx2C7903sQcl+35snI0iw0bfXPj+nBmkykMvlChzoGRgFABZpcP5YJQa5w
         lFe8uKXfnNghZb9lF+RyPTPKkhui5Wk8rKV8+VM/KFfMAItLcSuB4glh6da+3ElKn58N
         bshM+F29AeksPamYbX0/XSTIAx99uY7HuOKh8YWy/cfbXSXbBFFJ37ONzxarYgaXO1uD
         Bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849539; x=1713454339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qszcc7+Aw0jGDf//SUQC/piDZbAT+nT2K/TXHDYobA=;
        b=At+AAE/LUr19ZU3wZw7UeUfXqC/rRNEXxvo8oCT8bOtZ8MOZZJlIcZmWprURWyQSAE
         9yf47JXw7lOiiPmO6aqP2H+zfDkMCVOuYX7pWi9M6exVFgiYpZCLhI/llCbHgat/vm9b
         HKpUnkN3Caf1+crQJSYndVAlnBJbdiP26CQwiauk0nxlpSFQVCfJ4eLmMIZtJ6/+4pNu
         3ggIzvwlXJJUsjQzA3ON7qJeCG5gqmYybLw4WoGF6jCUuLt6n09OtLAjCYvKA/rEfHB+
         4HpfKONgf/Q0AiKoA25hbHWSCD2pDurkq98iaTuiRaQ4259oaZQoqhF45b1k1yG6f/Ev
         SqzA==
X-Gm-Message-State: AOJu0YyVZ/XN9FUHt1j9DqDzd9PvXwzjvROpgKb5I5oOpgOK4JGoFQ6o
	9qQqfA/hQtBScmuz+3O1aUxd1V7JGPHrrgyB7y4F4+bp/mF9BeUX/XAlsBLDXVnkumUCHiMSE0y
	S
X-Google-Smtp-Source: AGHT+IF0d6OnHYwx2CcC+sBVRefcg5XepSF/Sz/KtFW9/Szhwkn9T/oURJs/+s+QJqSDrMGFIdIcVQ==
X-Received: by 2002:a92:b10d:0:b0:36a:3ee8:b9f0 with SMTP id t13-20020a92b10d000000b0036a3ee8b9f0mr4227757ilh.0.1712849538775;
        Thu, 11 Apr 2024 08:32:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 030/437] char/powernv-op-panel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:50 -0600
Message-ID: <20240411153126.16201-31-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/char/powernv-op-panel.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/char/powernv-op-panel.c b/drivers/char/powernv-op-panel.c
index 3c99696b145e..8e9e2d47087f 100644
--- a/drivers/char/powernv-op-panel.c
+++ b/drivers/char/powernv-op-panel.c
@@ -40,11 +40,9 @@ static loff_t oppanel_llseek(struct file *filp, loff_t offset, int whence)
 	return fixed_size_llseek(filp, offset, whence, oppanel_size);
 }
 
-static ssize_t oppanel_read(struct file *filp, char __user *userbuf, size_t len,
-			    loff_t *f_pos)
+static ssize_t oppanel_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(userbuf, len, f_pos, oppanel_data,
-			oppanel_size);
+	return simple_copy_to_iter(oppanel_data, &iocb->ki_pos, oppanel_size, to);
 }
 
 static int __op_panel_update_display(void)
@@ -86,26 +84,25 @@ static int __op_panel_update_display(void)
 	return rc;
 }
 
-static ssize_t oppanel_write(struct file *filp, const char __user *userbuf,
-			     size_t len, loff_t *f_pos)
+static ssize_t oppanel_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	loff_t f_pos_prev = *f_pos;
+	loff_t f_pos_prev = iocb->ki_pos;
+	size_t len = iov_iter_count(from);
 	ssize_t ret;
 	int rc;
 
-	if (!*f_pos)
+	if (!iocb->ki_pos)
 		memset(oppanel_data, ' ', oppanel_size);
-	else if (*f_pos >= oppanel_size)
+	else if (iocb->ki_pos >= oppanel_size)
 		return -EFBIG;
 
-	ret = simple_write_to_buffer(oppanel_data, oppanel_size, f_pos, userbuf,
-			len);
+	ret = simple_copy_from_iter(oppanel_data, &iocb->ki_pos, len, from);
 	if (ret > 0) {
 		rc = __op_panel_update_display();
 		if (rc != OPAL_SUCCESS) {
 			pr_err_ratelimited("OPAL call failed to write to op panel display [rc=%d]\n",
 				rc);
-			*f_pos = f_pos_prev;
+			iocb->ki_pos = f_pos_prev;
 			return -EIO;
 		}
 	}
@@ -130,8 +127,8 @@ static int oppanel_release(struct inode *inode, struct file *filp)
 static const struct file_operations oppanel_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= oppanel_llseek,
-	.read		= oppanel_read,
-	.write		= oppanel_write,
+	.read_iter	= oppanel_read,
+	.write_iter	= oppanel_write,
 	.open		= oppanel_open,
 	.release	= oppanel_release
 };
-- 
2.43.0


