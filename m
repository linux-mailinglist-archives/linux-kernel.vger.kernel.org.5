Return-Path: <linux-kernel+bounces-141100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1928A1A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCB41F22CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8FA1E314A;
	Thu, 11 Apr 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WsU+Nv+x"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD91E3123
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850036; cv=none; b=FiKfooPevnI/Giag8cPd0gFInKqr65B7LlNl575pgTii6jSritpgLwXb0kSbWTLVFG0IqoBGYovyuqA7MPBt2auETxlTzn0obreLYLkeyh2A/4HK8RhiU91g9WA72Lin7v23gkR1fJX/wT4dgL4M5dRt3m1SBlnVucpynICa8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850036; c=relaxed/simple;
	bh=8bicZQbR5m2GnpNZQdJYfFi51HQMVdJ5DvIl9f4EbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyGt/xVJ6x+Eay06oJT7wq1vxhKhJbllbhi/GtdAWbEt56ZFzueWBuGX8gLsZUBPEt2Jmsho7Pl0df+Z95k1hwf47pYPbbSDVl001M1nZFVyXkW3BwGU6CIC1qlA+SlXR+aqMLG5rVhrcoeVItjqYNyvk6VLSgDPuHiTrnNDETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WsU+Nv+x; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9883139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850034; x=1713454834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47AcYampKeXQ0+2Iq8emlTFqiO1ZspG1iXs14Hyverg=;
        b=WsU+Nv+xB0RwwQkccgsdjTbR/3n0bLFs3OOjl6wmQcRn8JfLTYBj948lchgYJ5BNyl
         li/vb0Yvtoz+5MEZXLChV8LnXQYhTP6bkQN2Yk+sQnW7v1zB4yPkiVN2wyGujdN+7Yc9
         aLe/A3EpZVSvA1Lcn4xiz1ALVSL5uG0taplOFQhsDG/0q7MnO5av/gickLKtTO++ZGfc
         +BbbT9aqxR233k0Dq92/EZ8EAwMIa2IKHMTiudhrgbEBYb0IpYfHrLgnn66Au1CVC4IX
         vw+sIlS8QkFMipElqj4rpxp7/mMl3OO6lb/l2kDu8UmB2rFP4n7G5fUeHyHMNFQaQebZ
         c5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850034; x=1713454834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47AcYampKeXQ0+2Iq8emlTFqiO1ZspG1iXs14Hyverg=;
        b=iGO3xP/0sdogNcp1VhGI0l2RKZ33exKK9MXYTARc7sd8l4XeV0hadt3/FdALBA8ncE
         pnTVryUzxbHOKUoyjGeHglHNPeqkuJP6tRokul/cn2KhxsceI1xJf6rFa3YVoRaAOgsV
         s833PIjh0HVViyKkpI5aGOwZmsCvcobMvfMVS9KcTo/fz1VC3vxN7XJnqqjmnutrc1fY
         41JI8I3rfK8rCqbqOV3EPbagrrt4ZJHKnDnMGya2MZfDq+wKD3vfCD76R2Te5J1NsjM5
         65xWTvFrQApsxbXGZlb8aNMDXC6J6Zgo1QRAk4jiUhbjlzgMlRFZrWv1HJMTpoYfBmu6
         IWrA==
X-Gm-Message-State: AOJu0YysPKBDs7S6FWL1QP/Bk5R43xY15OtGzDw/Ax7jlj0jMg6athOy
	0KpWFHzge2qoZi4SYV/GeZcNOLk0344kh1RX9h//eCnPpFRfLA5nf1JOZcoTFmsVU8RvHAOnWKg
	L
X-Google-Smtp-Source: AGHT+IEYHWlHdDNYKroQIYZoLudkzfECjrR35E/0LXNLmSytlsU4GE7JwO9dJ3AeipllalACceRrUw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr230741iof.0.1712850033685;
        Thu, 11 Apr 2024 08:40:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 322/437] drivers/net/ethernet/intel-ice: ensure the copied buf is NULL terminated
Date: Thu, 11 Apr 2024 09:17:42 -0600
Message-ID: <20240411153126.16201-323-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Currently, we allocate a count-sized kernel buffer and copy count bytes
from userspace to that buffer. Later, we use sscanf on this buffer but we
don't ensure that the string is terminated inside the buffer, this can lead
to OOB read when using sscanf. Fix this issue by using memdup_user_nul
instead of memdup_user.

Fixes: 96a9a9341cda ("ice: configure FW logging")
Fixes: 73671c3162c8 ("ice: enable FW logging")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index d252d98218d0..9fc0fd95a13d 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -171,7 +171,7 @@ ice_debugfs_module_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 8)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -257,7 +257,7 @@ ice_debugfs_nr_messages_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 4)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -332,7 +332,7 @@ ice_debugfs_enable_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 2)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
@@ -428,7 +428,7 @@ ice_debugfs_log_size_write(struct file *filp, const char __user *buf,
 	if (*ppos != 0 || count > 5)
 		return -EINVAL;
 
-	cmd_buf = memdup_user(buf, count);
+	cmd_buf = memdup_user_nul(buf, count);
 	if (IS_ERR(cmd_buf))
 		return PTR_ERR(cmd_buf);
 
-- 
2.43.0


