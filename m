Return-Path: <linux-kernel+bounces-152171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE158ABA3B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215601C20A69
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07321400B;
	Sat, 20 Apr 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbNr7bP1"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430612E5D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713600856; cv=none; b=itS2Qk2Mdi/gdtM/5hgbkhpJbcYG1UTUKAARUmYgBvBbD6dkN8ZxJge2TbSJErDWUJVhoD1RC35wZHUhCtxTEzFedBgMuraNf44ZWaqDURGHzmUL/ouy/ZuGUjAf3BqZCVlOeQ9C7118B3DkLD+nkAYU0LLc2uJBblC86K2UwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713600856; c=relaxed/simple;
	bh=wOPDWk9dxtivo+c/DyNEydCMdaSFTWmGxym+AjmL7lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXr+BRFNRaVcU1bMMZIB7ZIPhM7rGbciiioRxRTs6IEvq9tklmGwC3UP1+vaOiZRJBskHKNOuXq9ySc24e7G0rCv+wXKWXBEAmUjSRDT9agOl3z4OBTuJcOFEmlN50oD5EBtDVSFLoAJhbUMkhmnj97Vd3hnnSKZPibEAMCx1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbNr7bP1; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb7a0b3fe7so1686059a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713600854; x=1714205654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6l2tf4k2g0Mpsl5bMqBpfrHHHKYYGuCbn8ZU/OwjIY=;
        b=GbNr7bP1qlRtexUulhyN4imqpmXz+h0EktJPv436LMf6OGQGi0IVRlIzExLE5irnmR
         7kx9JSo01MGOBHV2ioV2Ql7Y8Mn3lq2GaosSa8yFn/AV5VaqWQ8Bvjv6gV5CecNeeCEz
         aMEknXw3RkaZKP2MpYxfe4bHBAtdw4MJ/9uhiCRnPMLm1hPubz3mS4Ywshlp9PFuSZYB
         KB0FBtSh8hCh7X6EgDzHQrX8uGZe8p0oRGIIf07Jy0DKL2WK/x1ZRZmz0vwUmNleHE2l
         gY1TICaVPqHpl1bq5gVzkfP8ffaQYMtEvZhQnJlXCUR/9rmI94r8IXDwvuF5KoFEPUNs
         PShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713600854; x=1714205654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6l2tf4k2g0Mpsl5bMqBpfrHHHKYYGuCbn8ZU/OwjIY=;
        b=j4+lKPJaUgC5b7IhsPlyYpsSQQo9D1xAbmg6rwSFMBPllxeRQtOpkNPmDOfZmZFhek
         1gjUoQpQYczMaG0NsygHLy+lufb438L2PvaH/wkFjeufJr6mj19FmN3VUoCL6OkrlWwu
         tgBYf94DAiihbrpm6qr+OVqkD807lIcEP+N/ltFDn+UPvsIynvBrdO8tff+F0cwQYQSb
         gWWoQQLmRT4VlFghagvMfIOYK7NeXPzcYgOQkiqfcpbZBi55S4jPPVqkKue7FVGKNM/O
         VsPVXi1lhbZIF5F74I5gHs67VkGdcSk30034ZdgSbZ2GwHIcFIGhEqTwllAHshi/CpoP
         Qa2Q==
X-Gm-Message-State: AOJu0Yzj5VMKqcdey9ojlA9vn/BH1CUWAZFUIrISyq1cCT6xgzwJlzpi
	b+iPZNqI7xF2ow+Sa9vOQxTiu1xB32tkHWmABA65Qi/wINLNnxag
X-Google-Smtp-Source: AGHT+IHYu4KbACuGe9pRI5pdkefskUY6mRNCcVf+d2vKmwNdlf2lADtZ5C3cs6Im0myL6J6nIgxIuA==
X-Received: by 2002:a05:6870:d886:b0:22e:7b1b:32a3 with SMTP id oe6-20020a056870d88600b0022e7b1b32a3mr5424862oac.52.1713600853754;
        Sat, 20 Apr 2024 01:14:13 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a630400b002a42d247a93sm4245033pjj.36.2024.04.20.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 01:14:13 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+d4c06e848a1c1f9f726f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in input_event (2)
Date: Sat, 20 Apr 2024 17:14:09 +0900
Message-Id: <20240420081409.63736-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000f454c105d0722c63@google.com>
References: <000000000000f454c105d0722c63@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test deadlock in input_event

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/fcntl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 54cc85d3338e..b2d06c845a18 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -848,11 +848,11 @@ int send_sigurg(struct fown_struct *fown)
 			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		read_lock_irq(&tasklist_lock);
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		read_unlock_irq(&tasklist_lock);
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
-- 
2.34.1

