Return-Path: <linux-kernel+bounces-70305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D888595CE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF201F2181D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39A14A9E;
	Sun, 18 Feb 2024 08:54:14 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FF1096F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246454; cv=none; b=Ott1cTnGYoDuDimFRcjpCUaFvJRu/gN/2KCAGS5fe2mejolrxD4nCk0c3Kvu1N5j+836bEBeLvPRCa8tfttGircG0K7AmSbNhZYgXZQQ8MTwqTAl2Drwje0ly0KGL0zZ31XDFLhUv03wKwovI71p/YYjN2+l9Hs3qw4pmvjk3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246454; c=relaxed/simple;
	bh=KL+tFSq1Z5R4Nx+TJZnToDwfQkgYJMyBTOdqIxvJcqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0pVGrlB+bbIEnGjnViQvhJQhVTC7248ufSNVd4A8JyW8f/7YmQ3oWLwm5AymphObMU2r1jmif86mCWsDIm90aLvjehG/LtRnhVg2x1FaPIuG0C+iOZ4A4c6MhS7R7HXRoyNErMrHEXkfjM3XWuxnSRY6IJSJofj8zLvmEe9ThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.133])
	by sina.com (172.16.235.25) with ESMTP
	id 65D1C36800003407; Sun, 18 Feb 2024 16:44:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46224334210328
X-SMAIL-UIID: 4D2A949D34894645AA6FAB0B1A39F847-20240218-164428-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in hci_conn_drop (2)
Date: Sun, 18 Feb 2024 16:44:14 +0800
Message-Id: <20240218084414.1254-1-hdanton@sina.com>
In-Reply-To: <00000000000026188206118a5952@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 18:09:19 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2c3b09aac00d Add linux-next specific files for 20240214
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c27a58180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  2c3b09aac00d

--- x/net/bluetooth/sco.c
+++ y/net/bluetooth/sco.c
@@ -297,6 +297,7 @@ static int sco_connect(struct sock *sk)
 		sco_sock_set_timer(sk, sk->sk_sndtimeo);
 	}
 
+	hci_conn_get(hcon);
 	release_sock(sk);
 
 unlock:
@@ -439,12 +440,15 @@ static void __sco_sock_close(struct sock
 	case BT_CONNECTED:
 	case BT_CONFIG:
 		if (sco_pi(sk)->conn->hcon) {
+			struct hci_conn *hcon = sco_pi(sk)->conn->hcon;
+
 			sk->sk_state = BT_DISCONN;
 			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
 			sco_conn_lock(sco_pi(sk)->conn);
-			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
 			sco_conn_unlock(sco_pi(sk)->conn);
+
+			hci_conn_put(hcon);
 		} else
 			sco_chan_del(sk, ECONNRESET);
 		break;
--

