Return-Path: <linux-kernel+bounces-18300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E04825B20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F78D285671
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B13608A;
	Fri,  5 Jan 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="KTtF4lJL";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="lrcgdxHr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx5.ucr.edu (mx.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074A36082
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1704483261; x=1736019261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x/CY9SqhV19ov+IBOCB9G6eSjA+hDFL4XhUcPEIpaC8=;
  b=KTtF4lJLqRsC6ZhLAbvOXkzp5iRIqQ83cUzIO7J9NB9ABgwqygK3ViQD
   SUQs3ZaWXyofVoeo5xwrJmwaBSSnWG4jIT3t2RuKO564hlPJICNY3T1Xc
   6+GjRepydcTjYEZzpCTOXBHc86l0+d2XemFWtegDbfDPmZOhyuTUsaSZS
   m9u1gjNE+PyWZ30HxjzKnqUSK0Y6k8J8ZMS+I2tUpJwvSiHOMWc2V1BoI
   I4NCq+3JiSls838wHZbVbFClbTIK8Npe/X4iwAsP6px1L0GWzlY48hHUv
   e7YDJWSsgzkS61h4WvMqwoey8fRIUZSUspGKytFpQ470BqPRxh8e61nD4
   g==;
X-CSE-ConnectionGUID: CKrCfVssQnGW0X1at4vJuQ==
X-CSE-MsgGUID: 24zRvTYBT8q3W3uYgSADyQ==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2024 11:33:12 -0800
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28be2bd2ba4so1599703a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 11:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1704483191; x=1705087991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxlsttIvEzyojTFQZ0SaO2ARdSYUd7/ebhcJHQ29FLg=;
        b=lrcgdxHr9FN5y22HLhPyKjcFHFmtgzqhGtMOn7LyM4F1Eva598J+hFxwZYYzl6+Nqs
         HZObsc0VPvxk5ekBXtCVtLOI5T6axGoSu20djkwgTA7Q8GcOt38u9sX9NCMDM/vDxsn3
         0MpZ0qYoL1F03IoEcmBqaLxesqNrGaR4jBPPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704483191; x=1705087991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxlsttIvEzyojTFQZ0SaO2ARdSYUd7/ebhcJHQ29FLg=;
        b=YfBd+7ZRSgqrGk9qOZAEcnPKWL/CY5BcHmDanJNkT7wg6KGQP08ssq/Be9+RmnlGbx
         W1Hx85878efI0XIiWmDx3UuBZ+/9AA5WQj14uCnrSEevD6NLSKX/AUIgnU9rXQqJUB80
         yvJAV2ePx+8QOO4sQnUN/fOoZt35r43eD1W93DuGX60Uz7sOHdjdq/iFtp6slIn4Up1r
         hkM1rcl8b6ntptbWhHD84ql/yrtHmQEVgZl4KxL4HQUN/YFSJ7tutCeZRWz8oiIJ9QRG
         AlyDmeRfkbToDvt7ecGP+2Nv8lzl4K2utzfWOHXIcY2sWwQp7l8EERPaEFM13pJycFpa
         WjlQ==
X-Gm-Message-State: AOJu0YxINFTZ1wDpJPPCkKAn509dq07IdJtPKGPMuQ6KD2pzG2yuR/W0
	t3t8oZrs+hFrRnr2BgtH35bcsCu5mV9Yc4q0NyP5YmI0dH/7tF4voN9Rcg+LiczQgPDPYToIrPf
	LQS6ccHIbNLSXv6giI+M9mCntzbwzsuyYwg==
X-Received: by 2002:a17:90a:ba97:b0:28b:e9ed:2a9d with SMTP id t23-20020a17090aba9700b0028be9ed2a9dmr2132123pjr.50.1704483191634;
        Fri, 05 Jan 2024 11:33:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHioz/I4K9ut3ub7C76aj18It19F6YjEnZGz+AiRTzVsSogT/oTQ7Gu4049ADVceQNy/syT3g==
X-Received: by 2002:a17:90a:ba97:b0:28b:e9ed:2a9d with SMTP id t23-20020a17090aba9700b0028be9ed2a9dmr2132116pjr.50.1704483191306;
        Fri, 05 Jan 2024 11:33:11 -0800 (PST)
Received: from localhost (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with UTF8SMTPSA id sc1-20020a17090b510100b0028d0b013880sm1598264pjb.0.2024.01.05.11.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 11:33:11 -0800 (PST)
From: Xiaochen Zou <xzou017@ucr.edu>
To: aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Xiaochen Zou <xzou017@ucr.edu>
Subject: [PATCH] fs/bfs: Null check to prevent null-ptr-deref bug
Date: Fri,  5 Jan 2024 11:33:31 -0800
Message-Id: <20240105193331.1180331-1-xzou017@ucr.edu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to ea2b62f3058 (fs/sysv: Null check to prevent
null-ptr-deref bug), bfs is lack of return value check for
sb_getblk(). Adding a null check to prevent null-ptr-defer bug

Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>
---
 fs/bfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index adc2230079c6..35688424bde3 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -39,6 +39,8 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (unlikely(!new))
+		return -ENOMEM;
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);
-- 
2.25.1


