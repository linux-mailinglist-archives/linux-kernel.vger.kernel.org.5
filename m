Return-Path: <linux-kernel+bounces-138677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C591889F8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF3285440
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A030161301;
	Wed, 10 Apr 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJGt5fwT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF5160792;
	Wed, 10 Apr 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756946; cv=none; b=ezy1cP5dySAsfmZcCXlVWTg16fl6L5wNs5NE4a0m8lu046a824akPuNZR9TjFgxjCVEfgJoz8LJaOR2NzPqToC/8deqDYUagv+17bM4Duw8b+Ek+JMqUDq73C7Q+67ljSWD9XmF5qgKHjgv75zguzwWghalVg2lMQ/tmQD+2iio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756946; c=relaxed/simple;
	bh=z7WWEmfGexfSzYypM+C/PDKMr6HcbNcz0JwCfglFf74=;
	h=From:To:Cc:Subject:Date:Message-Id; b=u5VNLOiodPa+MHxm1f59uaoohc3yugS57gFFJNsIV9+NEdE03eh1BTs+AyH+lmfhju+cLjlb06wxbOdlh3RSYVePyLTDmy4igsmesgu0V+gYH0WFxs+C3M2yce+sr7RxtgdcNDnf3pzeNo9Hz9DXXdSI6LPUmKBDVMxnbdcHR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJGt5fwT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so499287b3a.2;
        Wed, 10 Apr 2024 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712756944; x=1713361744; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACLCyOatAYHZP8xv0gaT1bpB8I1NWTCVByRXRODXmv0=;
        b=XJGt5fwTMN6Rf74ILGm9Jrlj0FJq8MY3WEsloe/priEoipmnazSbPFO0IG1aRJvS4v
         p52WTJVSJHiVZECbngEkXd0pmDK3scfD47tgYAyI1EaTii5/eKd0PiFHoQbtc+ywmvog
         zxM0t9K4/lTTBW+dZlbYv6oQ0XOK98dFFtEgiLUawsXawX7/pQUYxEoj1/7ap70nSIni
         q9ltonwAwDh6rKmRBmlz+TXDgUhS5sXF2iMzR+6LpSUJVCtuo9xbrpEDXYAuOLqOAdpr
         ys+UyVNJ4VIPMtlLS6F6LaC2UnOVqRDA2gm6i8gGf3bpmrqi6HNWXD+ic87XVQ4NIpS1
         ZNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756944; x=1713361744;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACLCyOatAYHZP8xv0gaT1bpB8I1NWTCVByRXRODXmv0=;
        b=N4QpI279kPosKBdBBwFVHV2wp3UvxCQ8nmdIOIHli70j0z6Hqloi6hS+P7mkCGYFKR
         wMX6tOZPoSnWlMXwYzXeLZZZmIGpwYVS2RU6CY1dP/L7Xf9t/MaERcWvBoYWpI/HzQVC
         jTAxtE4i5evlNBLP3Zp90mJ9Uy6cW6Fo9I0+5OlfKx9r1O7IiDZDJEHQeNw0LC6QK1Tg
         uhU29I3VbkA3JHc4ELs+tF6UKL1QFNl1TYOXyZpYraxlfGxbuGGRDzeUcGMnBUQzXnia
         6AeuewWIZRoUmt23CCDo6ZC3froL059GbEWo0NRRO0pDfY/JxLrJSiouLj3mMNKsLeUu
         s7sw==
X-Forwarded-Encrypted: i=1; AJvYcCW/tRsC8SLyDQabClJZQXGjv+G5xdeH0JV4994rIRn70JH6X3ZUMeO4/qlmQVn4KMP7u2qV6BBKesF+65d+Wx6DeOfVb0NkXyjnyO4F/4avoBIb1E9SAw0MJnVPvA8SkM/889v1Hh4L+2g=
X-Gm-Message-State: AOJu0YzutGQ4Mq6zvapQLZgry2KxOyyEQ1pHb2IArDb2DrFHrxI+tWNV
	l4rn46pHjLM9EwQWjtRbdF1Y3RL/qRtiKWnphvxBDxvDU/FWDCLR
X-Google-Smtp-Source: AGHT+IHO3kGHgMGpUXi/eSh3m6nOB3bT+ywRDnFn56Xe+Ug77Cp1eZrdh3ySGDZWlrVGM2CK9KMw2g==
X-Received: by 2002:a05:6a20:324f:b0:1a3:aed1:4d50 with SMTP id hm15-20020a056a20324f00b001a3aed14d50mr2901107pzc.31.1712756943937;
        Wed, 10 Apr 2024 06:49:03 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id h11-20020a63210b000000b005dcc8a3b26esm9630636pgh.16.2024.04.10.06.49.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:49:03 -0700 (PDT)
From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To: Justin Sanders <justin@coraid.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH] aoe: fix the potential use-after-free problem in more places
Date: Wed, 10 Apr 2024 21:48:58 +0800
Message-Id: <20240410134858.6313-1-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Chun-Yi Lee <jlee@suse.com>

For fixing CVE-2023-6270, f98364e92662 patch moved dev_put() from
aoecmd_cfg_pkts() to tx() to avoid that the tx() runs into use-after-free.

But Nicolai Stange found more places in aoe have potential use-after-free
problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
packet to tx queue. So they should also use dev_hold() to increase the
refcnt of skb->dev.

This patch adds dev_hold() to those functions and also uses dev_put()
when the skb_clone() returns NULL.

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
Fixes: f98364e92662 ("aoe: fix the potential use-after-free problem in
aoecmd_cfg_pkts")
Reported-by: Nicolai Stange <nstange@suse.com>
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 drivers/block/aoe/aoecmd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index cc9077b588d7..fcedbad8e3be 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -361,6 +361,7 @@ ata_rw_frameinit(struct frame *f)
 	}
 
 	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 }
 
@@ -401,7 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
-	}
+	} else
+		dev_put(f->t->ifp->nd);
 	return 1;
 }
 
@@ -483,10 +485,13 @@ resend(struct aoedev *d, struct frame *f)
 	memcpy(h->dst, t->addr, sizeof h->dst);
 	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 	skb = skb_clone(skb, GFP_ATOMIC);
-	if (skb == NULL)
+	if (skb == NULL) {
+		dev_put(t->ifp->nd);
 		return;
+	}
 	f->sent = ktime_get();
 	__skb_queue_head_init(&queue);
 	__skb_queue_tail(&queue, skb);
@@ -617,7 +622,8 @@ probe(struct aoetgt *t)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
-	}
+	} else
+		dev_put(f->t->ifp->nd);
 }
 
 static long
@@ -1395,6 +1401,7 @@ aoecmd_ata_id(struct aoedev *d)
 	ah->cmdstat = ATA_CMD_ID_ATA;
 	ah->lba3 = 0xa0;
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 
 	d->rttavg = RTTAVG_INIT;
@@ -1404,6 +1411,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb)
 		f->sent = ktime_get();
+	else
+		dev_put(t->ifp->nd);
 
 	return skb;
 }
-- 
2.35.3


