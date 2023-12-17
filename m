Return-Path: <linux-kernel+bounces-2476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9FC815DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B7C1C2171E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284DF23DE;
	Sun, 17 Dec 2023 05:22:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCD23A2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7ce620dd9so8894239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 21:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702790561; x=1703395361;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghR1slSXmklyUshujcAyZtfMlYi5j8Gi7ox2aOWyDsI=;
        b=mAWW9i4ixeur1bmf2ZhK26+0/qSbEVc7hKacjRaZk6NvOABhij6Q3R0NRy/8KwBW3v
         u+C3urmvCvuri1xYh0PfckIEZubf3aXf/uOCFDnOJQDLSLkkRxVCCjAWSDyfXQkhkGjz
         BZ4GvvK9qyvSUXHjxRFwKKveESbxAB90VPUHs5PZMIS8eu5gVTn8ZvxFbCmvDL6oRPyf
         uYMQjuPERX2m6FgoWFa+nkvHez6ZuOj3TdqkWk4ae0zl53kp1YLcSDhpgq2Ga9NwH0TU
         6TfrMy+Wxuk4/hUb77H/9WJX6YtiK7g7g28+c0HOB0BgeKUXpMynRtcpNfoN8vo2L+ZM
         PElg==
X-Gm-Message-State: AOJu0Yw3YdOWC7d3FADVPZv3Nk/4b31fsMVZ72PfDfjWwzmEj9TrV/3U
	6qjxW5utpkP2Hpowcl9Gvj6XjA2BMOejygM72N2yBfCkr8RERlA=
X-Google-Smtp-Source: AGHT+IFBx4MdCcYkWvHVT1UKhCFOcDnpqN3DdTn3/k00f1GGU0q9flvp2TCF/oIjLpFIzk+E/fQH7yh0IdbCgZW/FF1n+ugwwejO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c5:b0:35f:9ef1:7add with SMTP id
 br5-20020a056e0223c500b0035f9ef17addmr194041ilb.4.1702790561732; Sat, 16 Dec
 2023 21:22:41 -0800 (PST)
Date: Sat, 16 Dec 2023 21:22:41 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f207c060cadd228@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [block?] INFO: task hung in bdev_release
Author: eadavis@qq.com

please test task hung in bdev_release

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  8c9660f65153

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b6414e1e645b..3a00ae9b4867 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -475,10 +475,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 		 */
 		struct nbd_sock *nsock = config->socks[cmd->index];
 		cmd->retries++;
-		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",
+		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds, nbd: %p, d: %p\n",
 			req, nbdcmd_to_ascii(req_to_nbd_cmd_type(req)),
 			(unsigned long long)blk_rq_pos(req) << 9,
-			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries);
+			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries,
+			nbd, nbd->disk);
 
 		mutex_lock(&nsock->tx_lock);
 		if (cmd->cookie != nsock->cookie) {
@@ -733,7 +734,7 @@ static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
 	if (result < 0) {
 		if (!nbd_disconnected(nbd->config))
 			dev_err(disk_to_dev(nbd->disk),
-				"Receive control failed (result %d)\n", result);
+				"Receive control failed (result %d), nbd: %p, d: %p\n", result, nbd, nbd->disk);
 		return result;
 	}
 
@@ -1394,6 +1395,9 @@ static int nbd_start_device(struct nbd_device *nbd)
 	}
 	set_bit(NBD_RT_HAS_PID_FILE, &config->runtime_flags);
 
+	if (num_connections == 1 && !nbd->tag_set.timeout)
+		nbd->tag_set.timeout = HZ * 1024;
+
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
 		struct recv_thread_args *args;
@@ -1424,6 +1428,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->nsock = config->socks[i];
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
+		printk("%p, %p, bs: %lld, blks: %lld, c: %d, %s\n", nbd, nbd->disk, config->bytesize, nbd_blksize(config), num_connections, __func__);
 	}
 	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
 }


