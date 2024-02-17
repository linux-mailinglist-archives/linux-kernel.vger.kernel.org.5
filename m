Return-Path: <linux-kernel+bounces-69824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86C858EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72C72838EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D36350C;
	Sat, 17 Feb 2024 11:13:03 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869F63501
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708168383; cv=none; b=Ms6aAVTKNwnkKJMqdYzJ8sS/4jQKk6e+ikIOOalNro/zH0EU/L5sZ+vWhD02GQd+IyFlQkpTIoEUHSzDVaztRGnSWMjDCXoyiNrJcQZc7utCmThoubBBQawdplxr8BkhcnApdzgaaIQnhYDkv2egqSezatNX45rbZlzwxS14TnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708168383; c=relaxed/simple;
	bh=b3lczuQOxE96wfpRybcwX2csUDsya3Bh1fqq7RPSuX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwHIYcT4pIEbtjj5UtF2NyaNa54YD3BKq6Vsg/sXZbgmhM7owxxSunMCZ46K3I4nkJrYjg802uCAPdnqOMFBLFIo0P5XSPsvdvFaPzVSbE7yCwYzDK1w8882iWmloc35s2UqpGQD5WU3hgpRT8XrLHaROPhgLJOr5uXdYNj4lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.111])
	by sina.com (10.75.12.45) with ESMTP
	id 65D0913100006617; Sat, 17 Feb 2024 18:57:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 91722831457625
X-SMAIL-UIID: 34F35C6D0CF74015B4F1A669A1575099-20240217-185755-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in hci_conn_drop (2)
Date: Sat, 17 Feb 2024 18:57:42 +0800
Message-Id: <20240217105742.1194-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

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

