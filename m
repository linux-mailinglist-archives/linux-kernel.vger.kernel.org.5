Return-Path: <linux-kernel+bounces-151612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597FE8AB122
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F821C20E50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ADB12F386;
	Fri, 19 Apr 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWyB7EJk"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEC1E893
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538585; cv=none; b=s+AvuBTmU0p6jLRj3fXGwFrzdEPjGPu/+LClMXNDlH1Fc09jBMjeLYT8AJUxpw9g0TRpIkUHLp2dd1TnyHpYsodnZ6c7vt+d0sW55ViWOKOExdyeIQtO1nydqpknYN1yORx9Pxs+RuW4IqZdXYCzJVVprffOud0G/8QpMuT7RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538585; c=relaxed/simple;
	bh=Q0DMgKt89CB4yXB+ZE/mFpUv1tejFz92Ss0E6QHU1VU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVRb9BiV9YesMYedlT0zUviW3Xzl3UfRTnlCmWVhhxhCF6mvzYXqbIH1J/w4r9R3N7E+gdbaJohXTuAvrohzIA0Zvf0espacRnZe3vLGIqGtIhwuo4NIhuOfJAwVyeBqVRrA/cqQykMfwGmg3FekFb87xiBmN23YMLUHZAljDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWyB7EJk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so20339635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713538583; x=1714143383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu2Kr/7dMp1ei+pNlkg8DmJKLAY+uTiFTE7eBjNQ2wM=;
        b=aWyB7EJkxR4HoF2VVmq35rlhug1wllBjnsYD3U29KQf8jME8WzMjFan01TQgSb+tXB
         qg31HtE1jgtFkiO5vUwAdVdHbzbtWEpgeLlLY0TADL0mhrqaaXi0bdBSXVEK1HnEiAWf
         KUF9lsC3OKXJ0ov5FZvSHlk5EVpnA76Gh63+YrtJ8hTSpWxVRUDuRPPh4abmDWuAaa/M
         mPkBf1xTgSR70vwqQgOxwCOGVVZ38rAwPfWOvxKGjpLbsvt0shq8QGVZoiaIGWjb5IrC
         LOArLMjd4/3dC11Mq8MdnWjuht3+lb/O7Xpi2BBQlpeV2Qk7cM1Ybxj8rutRPcZWvjbg
         fXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538583; x=1714143383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tu2Kr/7dMp1ei+pNlkg8DmJKLAY+uTiFTE7eBjNQ2wM=;
        b=bFj9c8r3cN+oabr062Sv0bBzmrVza5um5iwkfAfo/BngHm2IjDLKzib5uJpWvPPNYb
         clvvLYUQ7FGVRNXoK8geNfQ9lmAoQ6DezPLiSjPUOEYN0KIKIRc6dCpnNMqga2HZRDXJ
         sEEhW50i5rcuQHqk/Lf6/V3lq/GpnXQvqm0XqJl5/nFSGnPOPKU/NS5Js0boM3kM1hJN
         bXk0P+evokZmfkI3m7xcFqc4IrMqO6ZpPkO/roQ+Xs2QbNTSi1WepPYe/+aU2YiCRz5E
         LiFJSHvmVhmA3JQUOksQtK0GNXDMnhJl+XkQ17JWbD8qY11pThU6oYh27gcRZT/AatCp
         2mzQ==
X-Gm-Message-State: AOJu0YxLHJL2Zn2QTSC6pOEwngHa9+xZBKHFFMzTnCs+CHU4zmgsIXan
	jXfs3ZZ2k+yXpq2U7mXM+Tr4zMPEJEXF1Z01NJxcPoSd96kNq+18
X-Google-Smtp-Source: AGHT+IF7krE8KTRRfpVC07r98fcXr8hMWel/zy9luBADOVMZf725LXAXFizVwTt+mT4gEPdCxgGIPw==
X-Received: by 2002:a17:902:b70e:b0:1e4:5b89:dbfe with SMTP id d14-20020a170902b70e00b001e45b89dbfemr2138332pls.25.1713538582938;
        Fri, 19 Apr 2024 07:56:22 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id ki14-20020a170903068e00b001e434923462sm3448996plb.50.2024.04.19.07.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:56:22 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in vsock_assign_transport (2)
Date: Fri, 19 Apr 2024 23:56:19 +0900
Message-Id: <20240419145619.12563-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000be4e1c06166fdc85@google.com>
References: <000000000000be4e1c06166fdc85@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


please test uninit-value in vsock_assign_transport

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..652ef97a444b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -656,7 +656,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
-	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	vsock = kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!vsock)
 		return -ENOMEM;
 
-- 
2.34.1

