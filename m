Return-Path: <linux-kernel+bounces-140784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F378A18F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9AE280A84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0364E51033;
	Thu, 11 Apr 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lLz/deQf"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A685025E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849536; cv=none; b=l9ALHbMkkRIUPwTyMGeQTBT+PQkmiXsBmdwwu9DcSHPw1r5tq579NqUr0hFkcgCZowvDAtK5b09v8vNpRDU0BFY0uK4HeVka0wKjdLlWMia+FlxvGB2U06F030GfJnQTziFqKFQCzGWX66oxQ3mFuLuIx+8MndoOmnJiszCxRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849536; c=relaxed/simple;
	bh=YItkDFRLkk5y5vZRwpze5mLqlR7ULkpv5iErq+FgyZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojt+Lv0zwLlbfE4EDaj+TCaa0uzEfnpng6dqYjejMBCae1a5eJjdVKq2XQZ3XjaFrqDwyVqKAVBO/4Q+HHjegfZvY5H44I+Oqcr2v1pAZGuyRlvwhGUPh2wVfSTn5Ra51FdxOIPdFo+emMRylbsH3CkVtZxUjfS8eGMnfEOVNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lLz/deQf; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170422039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849533; x=1713454333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9D0JKg9r14NKJXa7r1LiBPVJDUbVoO37fXAYUxkSBY=;
        b=lLz/deQftHtlOm4DKRLtiUQ0qhyU5MaESxrpxuH8qv/sMdeg7RpBHb871PDpIuZTh2
         DqQ6b3Ee2lXusFZzebA10dT/A+rcjLd+s55eO6/8gFznzHhgf2RxNq0FMWeRwQRQqI2l
         s6RsyqQg+wCtgIvhUL0GQ7wnjLHqHF2gzbamnAya7uZUiPkfrxjKzOWqENIlrBPYx0vM
         tlXptQbv1wTk5Tl2F01GNcEb7hbcbz4GWygsLbHS3sssHBBk7ZTBREMpCXX4NRxVauSS
         xQcFKHrd1KXSFu0ulRfytztAqObP3Unh1a5N3rvnyjv+SBHptLfkB7NrAw6O7O/bCrwk
         +LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849533; x=1713454333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9D0JKg9r14NKJXa7r1LiBPVJDUbVoO37fXAYUxkSBY=;
        b=aTXIQF/HezWAINiOPRaXTpBDDM54rqnUlLAURFdmCLcnfDFQIPG8KoJrKX9NUi7+ci
         SbbC0wD3P76qft88KGUa9V7Ma1qB9gytF1ZS/QYrgEMg0QCayLfJyCRLUj4bzDqa9qqF
         giMAdJb93NAcx72Bi1wU/9u2etHNAvJF/EQQKBokn0WNbb/cza6Gn6rJLSNLmJdrFVhY
         +IP/zLtun5aSbcUgV3PtSx7T+1CPtfSnsy++cwKF2xXbDLqjJN4uao3bkS8Qzw91gqoU
         oYRonFnReXOPF76MU1Kec4RaANoilepJ+zGlk1YHX+xx2pu3gTdU7So6F6sTqCqxzDgn
         IB6g==
X-Gm-Message-State: AOJu0YwfzNFSaolabMN1PiabyBmAw5IaLGp3d2B1EOiBWwED4CDjzoTI
	1Sa8gixnrIWZIZHKGKbVRGOEYmTxisSZjE1ibewq7NSHdVqoKgdM9cGkTOEkc9Swd0LwBHaV552
	z
X-Google-Smtp-Source: AGHT+IHq5cOXZrThsNzOVETtqEL5/7PBrlJ56jmh56Lu9DB3zNGdl/bndf2LNbdfhsXIbrlOXQLWPg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr210954ioh.0.1712849533614;
        Thu, 11 Apr 2024 08:32:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 027/437] char/nwbutton: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:47 -0600
Message-ID: <20240411153126.16201-28-axboe@kernel.dk>
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
 drivers/char/nwbutton.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/char/nwbutton.c b/drivers/char/nwbutton.c
index ea378c0ed549..3b60ee911c68 100644
--- a/drivers/char/nwbutton.c
+++ b/drivers/char/nwbutton.c
@@ -165,14 +165,13 @@ static irqreturn_t button_handler (int irq, void *dev_id)
  * device at any one time.
  */
 
-static int button_read (struct file *filp, char __user *buffer,
-			size_t count, loff_t *ppos)
+static int button_read (struct kiocb *iocb, struct iov_iter *to)
 {
 	DEFINE_WAIT(wait);
 	prepare_to_wait(&button_wait_queue, &wait, TASK_INTERRUPTIBLE);
 	schedule();
 	finish_wait(&button_wait_queue, &wait);
-	return (copy_to_user (buffer, &button_output_buffer, bcount))
+	return (!copy_to_iter_full(&button_output_buffer, bcount, to))
 		 ? -EFAULT : bcount;
 }
 
@@ -184,7 +183,7 @@ static int button_read (struct file *filp, char __user *buffer,
 
 static const struct file_operations button_fops = {
 	.owner		= THIS_MODULE,
-	.read		= button_read,
+	.read_iter	= button_read,
 	.llseek		= noop_llseek,
 };
 
-- 
2.43.0


