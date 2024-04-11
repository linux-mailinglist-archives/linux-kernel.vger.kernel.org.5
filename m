Return-Path: <linux-kernel+bounces-140944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564C8A19C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC41F2289E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237320FA94;
	Thu, 11 Apr 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b8n0a6t7"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39E201276
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849797; cv=none; b=FSt1VMDQ+c0TKleq8icI74fGnHNy57CeZ74hOsQM9yUdviw/vpho1Fd+EcwRg91SqWETIpJQ01sx1Pzb+1r9lCEi6svwxtPf07x+xBiLi+4BRc/LuT04SiK1quuwEAXLrAibqQB32MhTMC9pn6+k06xtx6d/Phu2E0GpDOb8Zpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849797; c=relaxed/simple;
	bh=V+A1nkvhvl13IKYVCuIvkbQ3Di0+j6PDDLeyNjLNF0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tz3WJ+cou1yFe04mBUq3PDxw6DiST+1iZ9S4rG6bYIQAASCM5sV/Ls1T1/8Xb4Q/+I08jvsII1loA2BsgmCKtFzA0IljaUHTSoUVm2MkzR/g7wgfiAX3HZWD2CDnXU4dNxwK4QAIjaGCHkCBUYMOwC6lwtrdr+tgXT1jEPhWztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b8n0a6t7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9799239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849795; x=1713454595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL9L1IR48g0iaoEF/IzKduE9IDhjnV8jH6inAswZfn4=;
        b=b8n0a6t7ZNczWIpFW1fLa1IEoY24JF88tgKuEQXG2stKYytTbT9347zR7WecAIL/2Q
         RGswxR8GeHzktzg5t7pa94qvN1Lpvf1i7bLijAu7tShOJUKgVN1276i28+RANgmaoIuB
         T5Pn1ABbYrE/MQtERvIeKP7P0twTUI7+tU1px7KTajZl9vlA+o2g5LFBnXjh9py+/QdY
         937thj5kfU/N0FRiY8viVE+p9opsdi046nJTqDt7heYrdmLrICXOhiXpdIaKQ+Ei3Trq
         GUUmbv5PbCb4Bdd4RdFpQG6S7HXILrW/kDXWSd9kfyfqLrtJrrn3vbe+ZilvFPVbu+bM
         xM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849795; x=1713454595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL9L1IR48g0iaoEF/IzKduE9IDhjnV8jH6inAswZfn4=;
        b=RBHi5zu8JZscIhR2m2hArmQbCxFWcLYl2m3Dl6IAim8qSQMnNTFDQl3jgqExZ+HCpR
         KQxIGRimF9q4jEMbhV1doahqWYyXPsYJYWabm5wo/8+AQMjKUZDxoCf3eqs0IEaygmww
         oJfPnmdxcgyFVWn/wvJIBnRfn1hALsmZ9qAojreRbjhMSyyqXq6MTONbPBjz/AF2jEsW
         AzYmhth8Qc6syjKd2KdZ1Pnj9w9yuKvah5NEi7qBS0jFzrqslk9o0BIic9HaSE84H5VQ
         BPwbkSXqEFrShD2uAp2w56dF1OEuDddtTzdt7uqxdAp1j/8PYZWtH/oY8GWbaT6ZDbzK
         5DBQ==
X-Gm-Message-State: AOJu0YwMPI5nrfJgeZB4a44/oAypH6hal+SWCR/YqeYptLY+jxBDairE
	ATcZ6vz37t5vveCownV+wICQuHw8WXTIJ7V96SNpLYK7LElBVZPEyDvj9vE8odjemAIejobNrjA
	m
X-Google-Smtp-Source: AGHT+IE7ijAhUAHN0aF688PmYfj/x2MabXvHSCzq9Re3QssMmQ0rj6gmkFdLgWE/XTvBiV+/2H9Sgw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr218449iof.0.1712849795569;
        Thu, 11 Apr 2024 08:36:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 175/437] soc: aspeed: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:15 -0600
Message-ID: <20240411153126.16201-176-axboe@kernel.dk>
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
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 888b5840c015..e807893b1624 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -98,6 +98,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 
 	return copied;
 }
+FOPS_READ_ITER_HELPER(snoop_file_read);
 
 static __poll_t snoop_file_poll(struct file *file,
 				    struct poll_table_struct *pt)
@@ -110,7 +111,7 @@ static __poll_t snoop_file_poll(struct file *file,
 
 static const struct file_operations snoop_fops = {
 	.owner  = THIS_MODULE,
-	.read   = snoop_file_read,
+	.read_iter   = snoop_file_read_iter,
 	.poll   = snoop_file_poll,
 	.llseek = noop_llseek,
 };
-- 
2.43.0


