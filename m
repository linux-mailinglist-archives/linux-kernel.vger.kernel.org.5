Return-Path: <linux-kernel+bounces-140891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B558A196B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33F5283FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A015B105;
	Thu, 11 Apr 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WCMQtTXb"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AA15AD90
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849718; cv=none; b=pIFNc/ldDf6XSCS02gOIyNT4s2jgx6gR/zrqVoYDDGMGtJsOBcey0DDFVojZNXIAbklOWLQwGXzqsw5MmkRSIr/SRPiK02bRH450gGQIwwHvDhr55ISqiMMd7PqN5G8zerqrl90jYZMlj61ywtwAgv/JCmxUe8xBRCanr7qMcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849718; c=relaxed/simple;
	bh=Ef8mpBPqAAkAYVkK4V7JtRUnBI5JfRMSzve1tv51A0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWvCbcKwVnjwlMmfiWj7ZnWHTdBT5ukxX9TjvxWgcq61ApPWjR+BSjGD1z4h2/KxYY8VNp940bf1nLUYKDZKR+thjbo6yuwtw2XAiUBgP6pdiAgdSG5EK7ULWmILq0kYaddDHYhqQ27yV4WYsSQ9oQdUTHsmgJsP9Je8KpmEhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WCMQtTXb; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58042339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849716; x=1713454516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiKRdqQmS9PhNJtP0NzU3N6F8lDnfHCp7WW9oGKSL7M=;
        b=WCMQtTXbI/Z54qDYIZJd6IRTO1h3gwYa7DYCP2lBx5GVB84tYtR5JYXtBwZlqzt1qh
         6C9Ww9MjYg3wFiXKEEU1YWn64jisgngbFoDg/8rpwftfd9oed9OBtGSFSodecptghuBb
         mI3yAheXTIWvLz7GPX9hICxHToRt/Q8wHfGBBD9O0MRYswrmE0a/fbwjMzN4ZIl+TPLo
         MxFrS9ftQ+dRksjSTXUT5Nl/4lzSBlr80L2YwSVvkZk+TwD2TuAxODXWy6TN7O6WJrWe
         IpL/07d0aenrsZDlcj3f28g/HN3zDVRDu+Rs+0lUFBI+eCaY46xPLbl3E94PUB86I57c
         fQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849716; x=1713454516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiKRdqQmS9PhNJtP0NzU3N6F8lDnfHCp7WW9oGKSL7M=;
        b=HignR0/eKiI3BDzFDjkmw7mPWuT5hUuNzTGKIUA8Q3y2j1Xmi+6U/aOv4KNxlzn9yZ
         XYEupVZmYI3ocQRPc/eUqJnynDH1LEaLDmar9qNnFStzmUHRj+2rCYAk+wsq5ThjPZf9
         3rafMVM2rxxFMgT+XC9VdWt0n9Ym4ps5egJ1HkBdgvuKBYD+0uHwSysqvZS/ZDOLsfQV
         iWMYINEutOJhSWxwNRqaX0YKvJXJ19chVs+RoDVPRoZ5jr7bFRIKLDJhqJUkIb0Gqo5s
         Gcfohq0BwFRwAdKMJ0qYYfK0kkjoR6ZuMVQRgQ0q9omy63T0tigFTN5Ov3C5LEXfSmE2
         HgTw==
X-Gm-Message-State: AOJu0YwWX+4UTRC8WdcCtTSMrP8aDCNApXwnziB+s2odnqn1YYvntq4f
	SmDbI5DvcGLWs1sJX/As2dZqCGVycdC6s6NjMKde0optv0PC3NX0cq1/14cxsyyIPAe8ShT9+YO
	/
X-Google-Smtp-Source: AGHT+IHmIvW0MVKAxrMqGrl0sD1TlkrxNeOP4WCwMoMrbQhMSwsqNF/TC24FA8qu2YbXj6VAgfAIHQ==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr203036iog.0.1712849715921;
        Thu, 11 Apr 2024 08:35:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 127/437] firmware: psci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:27 -0600
Message-ID: <20240411153126.16201-128-axboe@kernel.dk>
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
 drivers/firmware/psci/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..06a9aa74c1a5 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -440,7 +440,7 @@ static const struct file_operations psci_debugfs_ops = {
 	.owner = THIS_MODULE,
 	.open = psci_debugfs_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek
 };
 
-- 
2.43.0


