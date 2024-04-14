Return-Path: <linux-kernel+bounces-144075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A578A4188
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80C22814A2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79E522F1C;
	Sun, 14 Apr 2024 09:31:03 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D322EE4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087063; cv=none; b=IbN5qYr8mNoerPSJ7X8+LVrByacsuJm5AAw5fTYurlVC8EH0ugcbsSJIZ4133di5SX+CF2M0HiqgUshwun2cf/W/YMMlNol9GcGkA+Ww5YPYpCnu4YLwbSdeM5abAhT3fsVWdXGxNxm2kZp/iTH18FTOmzAL8XXCWitaA90g3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087063; c=relaxed/simple;
	bh=7Vs18BBTEq+uDJSc0vG9/S8HWFfEsMbP3UVDQBVdCYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSIrl9xFvc0svfNrJ1nwGlqc7ZJIyf+8wWqZNADPlmi1ab8/1lWMiD8kLKHcEvA2UncspszKGQG6EjW8VjA6KlgYZahROt1CfkbfmcJIZmAJ2NsGS3nE7xXsfyfoy0PtEwzt65cLfCkomFPbrl5ymXcdW2syIUVzo9H0N23N4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (172.16.235.25) with ESMTP
	id 661BA228000001C2; Sun, 14 Apr 2024 17:30:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 99913834210463
X-SMAIL-UIID: 6A06D89909764A51AFD5C6F46256CC27-20240414-173018-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+75ec36af46e2098f253c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] KASAN: slab-use-after-free Read in j1939_xtp_rx_dat_one
Date: Sun, 14 Apr 2024 17:30:11 +0800
Message-Id: <20240414093011.2358-1-hdanton@sina.com>
In-Reply-To: <000000000000a87d17061608997e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 23:27:33 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    2c71fdf02a95 Merge tag 'drm-fixes-2024-04-09' of https://g..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae00cb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2c71fdf02a95

--- x/net/can/j1939/transport.c
+++ y/net/can/j1939/transport.c
@@ -2122,10 +2122,12 @@ static void j1939_tp_cmd_recv(struct j19
 int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
+	int ret = 1;
 
 	if (!j1939_tp_im_involved_anydir(skcb) && !j1939_cb_is_broadcast(skcb))
 		return 0;
 
+	skb_get(skb);
 	switch (skcb->addr.pgn) {
 	case J1939_ETP_PGN_DAT:
 		skcb->addr.type = J1939_ETP;
@@ -2138,14 +2140,18 @@ int j1939_tp_recv(struct j1939_priv *pri
 		skcb->addr.type = J1939_ETP;
 		fallthrough;
 	case J1939_TP_PGN_CTL:
-		if (skb->len < 8)
-			return 0; /* Don't care. Nothing to extract here */
+		if (skb->len < 8) {
+			ret = 0; /* Don't care. Nothing to extract here */
+			break;
+		}
 
 		j1939_tp_cmd_recv(priv, skb);
 		break;
 	default:
-		return 0; /* no problem */
+		ret = 0; /* no problem */
+		break;
 	}
+	kfree_skb(skb);
 	return 1; /* "I processed the message" */
 }
 
--

