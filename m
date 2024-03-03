Return-Path: <linux-kernel+bounces-89640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D305D86F376
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A21F21D4B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67B5CB5;
	Sun,  3 Mar 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yD03v/WP"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F87F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709435054; cv=none; b=UH18Tqzt5cb/vPI8zP3iKq8YLzWuRLT0iv1lX/QFHAE1FMDgraNE0OtrBDqNZGLI6r8k7HDX8SjaRA0ej566vRoedPgEZxO3q4pQ1Y3wgVh7iMAoBb0+qJh2iR8+6j1msUq7EKb/IqRQh5lRyFvI9GSWkhSsiGtHEMMbcDOCmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709435054; c=relaxed/simple;
	bh=bvsAFbdOceGaJh/xNDTlqquJ5u9tn/gHWjotlPelnzM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jy7INOUVAmtolUDvJvvBZD1N4zdXo2aleu5AMBv5raP/JuH5lPPBEH7h/+mzmo5qymwpjf7NbUw7wqixnmGgGYSO2TQhijLsB15D0BpkMhrYZN44zxAG6Wi6lY+fhcKomwBIooetAAYROHSXw+hwe63+4XTM7whYwu9QqZz6nIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yD03v/WP; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709434742; bh=4B6VFs/HdgVIfEnBI1FSGNUsahA/M0i8oBqkPIYLPag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yD03v/WPlaErEnpfI5PNHSYH+Y7wOPPee3525Ozc0jSldElAfWTQLzvFFzuWr2za2
	 aoEcAIBVkANH4gvpunIXjESZ+ZRP2mAUMv5asn6UCO0Bl4734rJSbKjzUCYFsqYZal
	 B46McZRu8+Tj1fSrADPKPRU0Ivh95x/Acu71IjI8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id EC13B6E5; Sun, 03 Mar 2024 10:59:01 +0800
X-QQ-mid: xmsmtpt1709434741tgzo8cvpx
Message-ID: <tencent_5436144A4A74DD76DD66D03C89363E96E009@qq.com>
X-QQ-XMAILINFO: MZ4XH1L85f1rlgDm9Gp5U1REGCZSds9b2g9BlnK9NcipZXWOW/wMRNuRJknsAO
	 GcIJhAr/SaxzbHWFQypeoIfWsgj/9043XknIvZ9jcpU2Nxihy1f87UtBMeSI1gGQvjCI7kwuUQR0
	 K62r1qvUcm4kfXeWVOsMyWGTvWdxETQKfrOxlhGMtxnhfEQnOvH8JGgU1j2/pAA/eNxr8RkC0zgG
	 RuzYIi7ZaHmNz0qaDHRd2jd7IW0IJ23gBSMyzWkq2ju/uZ7/KO469jNRqYWB5sAs2Dqbqrxh4Faj
	 pOIh9TrHHLBQEywRm5vSz7pgIDMJEOZrfqF0kfTTK9zAsTUnejJN+uMo3POpSnzIVhevQKVqSr+s
	 ZmgrmGEcIwk5XFYNxYZ84wBNDonvKe/hgyAqlz0CmWkHhZbZLF8yVXqkB8HTrEl8n9mY6ZKRQiqi
	 xKtiEDSOlnSt0Dyb7rp5rq41qwtUfsN1WGqz+6okHFIUdMiCh3DrgDa/3O3Pql5aWBnQ+EYDCRng
	 9Q2Lrdui4DxNGYLutiItFtrIOMLuOqMlpKndYYkJGvv9iQg0zl22X6IzqghhcF9S1k7OkezEIThk
	 bmNoMAVG3WR0qdTNCv7t2ueW1NXhWoOHIp9WnhpDTx5rTf5Eul9aoDIOslyJyGN7OvKKOy32UjOX
	 FixcLQbkXzBqMqfHmTANUf+dUBE30CeYRI0aRJQsx7CeqLxKP3DbgpEwIq0BczvaOhxgy9a11Fd8
	 +mXYawHLjPRblvHQdmZdQARXUOU+2stkQDMFlif4CVgcicLOprPj9LsYXbsu2Y1RRW7zfIsKZp/L
	 924KM0xDrwKoyo4+/EIuCkSd/2nz2pG1cu+KYVzIO+gkqJIBudYJPs71Uby6XsihjK+v0Oh7GTcr
	 +QLj74Ic2CJn6Rieu3AKEMhapXWqkV3be6ULNErrXXlJhTX7bUjS0YcTeRKbgPAW0nmFMmhMKO
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
Date: Sun,  3 Mar 2024 10:59:02 +0800
X-OQ-MSGID: <20240303025901.4139828-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000c0550506125e4118@google.com>
References: <000000000000c0550506125e4118@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test mp capable for rds

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index fba82d36593a..7fe1a79bd63d 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -301,6 +301,10 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			kfree(sg);
 		}
 		ret = PTR_ERR(trans_private);
+		printk("ret: %d, %s\n", ret, __func__);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc6..9efda3283753 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1314,9 +1314,6 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 	/* Parse any control messages the user may have included. */
 	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
 	if (ret) {
-		/* Trigger connection so that its ready for the next retry */
-		if (ret ==  -EAGAIN)
-			rds_conn_connect_if_down(conn);
 		goto out;
 	}
 


