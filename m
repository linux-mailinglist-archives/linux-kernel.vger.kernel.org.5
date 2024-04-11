Return-Path: <linux-kernel+bounces-140777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E488A18E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427402862DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C647F79;
	Thu, 11 Apr 2024 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WX0FuDOs"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124D3FBAC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849525; cv=none; b=lqnGjYeCNdHil3+rAKBmk6rzIDrxo0vJCQe0zV1eTWFeaCA1mONqb+8Ma37LSvF2+3pk8NfJprInHIfN9Wn/Qr1AVpB5p4tPY36uEQdl8Ifa7IygUUfJTQBBO+dV2StePh3uN0iGZK6x/o4E7oWn0pjGyt+u4sqK+6lInJgn9rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849525; c=relaxed/simple;
	bh=ODL8Qc6Qxk64Ikichns/9t2AN2UvFOfrmKdPSjlw50w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kvoz59M1NscdBO2pRGI496W95Wf3EcUh6NMO19WTH0/fECBC5xF/dMX/MPfT0cMJhzhX+eYtF0VUvNMo5zZpLrlIwI7AEBNANYtgb5aZ9jsTRsZN/HRrWreFkvT1sm9xv8vzJNG2U7+GMvbO5DRJLRYUxiQXnvUlQ7Ncvdn1KzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WX0FuDOs; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a34b68277so105065ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849523; x=1713454323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgsmHLXf46AC60qodwDWVXJd+Quh9W4tnnD4KDeL7e0=;
        b=WX0FuDOscsMpPAmVBkHPz51EXSnVmNmAJ98gQo/rv+6eSAaFWSiKrm2ZkFj6kom4DX
         Aj6kL3pgq/r9C24yKNQEpKOfB98Q1vRGj7tzCR4HBKLrMu9+OypL9ZNTzn9UHzMkacWK
         F/lipalPluiQwmQDJbfdHaWdS+AAXpsXAhYrukjQBPpusyuqEXlRQ2FByNcbq4VRidif
         tJui/7/ddoVznjuGWsgrYEOlS5V4Ee04dBytDnVW5jAmiGpBINC5t2zyQN6hG1+sXtsz
         3iHNF2/IQxiRJ1Wp1pPyxPB/zUPM4E7YagF+yaAP3QlWt9I9M6pXmKAVbXEFIzsP8jjP
         jORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849523; x=1713454323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgsmHLXf46AC60qodwDWVXJd+Quh9W4tnnD4KDeL7e0=;
        b=ATOpbHR0VXepU50fEn9vzcmSRg89kZoKoTF39hwec9Lc6CdxKHrp3qeIZNlvdz5Dfw
         F8vb3L/G35gnHo9kmkKjMIuqmDxooCWS4tf2xBtj5gFKIPcFawcgbl2R4xORr2iKGDCU
         nFIWRCV6BChBL0hc0Vewb0cJCOysFgqRaSb4SXOtN5jIFPnzH0oLjewHYTcRZXQ+h4vV
         iV8EJ9BTCi1DM/yZC2/jkoBfYOlCEFFiB1eFxVCkbCZJTbGZ4+gSsWsYlVWqtCjlnd7A
         8FJdbqHelXx8BkeoM54uZKOl+OyDm8k5m53OptArEfazqAAgPvniHU41iqwNa/mJxLvu
         y22Q==
X-Gm-Message-State: AOJu0Yx6bI+SscHvJA1JisOgq0a1FXfvUp3EAvO1HcxvcYzS7Egx0yjK
	v2BOcGe4dlovfRooU+wD1e/rRI77kFhQOAvT8kYokJFMRG1cHZBxZgvP4Rbbz3poDBpQXMkk44k
	x
X-Google-Smtp-Source: AGHT+IFqOE6yIiq/cRDFkY6LvcvF+nD6R7Rn08enOtCZtSeR57SMusn1AsolOPDd2plFPpe8dUAuFA==
X-Received: by 2002:a92:de05:0:b0:368:b52b:b449 with SMTP id x5-20020a92de05000000b00368b52bb449mr5459539ilm.0.1712849523125;
        Thu, 11 Apr 2024 08:32:03 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 020/437] char/hw_random: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:40 -0600
Message-ID: <20240411153126.16201-21-axboe@kernel.dk>
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
 drivers/char/hw_random/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index a3bbdd6e60fc..810c3dd013b0 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -290,11 +290,12 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 	put_rng(rng);
 	goto out;
 }
+FOPS_READ_ITER_HELPER(rng_dev_read);
 
 static const struct file_operations rng_chrdev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= rng_dev_open,
-	.read		= rng_dev_read,
+	.read_iter	= rng_dev_read_iter,
 	.llseek		= noop_llseek,
 };
 
-- 
2.43.0


