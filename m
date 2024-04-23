Return-Path: <linux-kernel+bounces-155971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D678AFC22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81C31C2277B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D42C6AF;
	Tue, 23 Apr 2024 22:47:00 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFD1C6BE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912419; cv=none; b=QdLficdO78KG9cNYta1+BSZltylMSODssbEZCwFea4HzbftlcMiuvEzdpFE6npBhA2mOvSF8GBi3/DXgHs1X/DkMi2cUi7tDU4i4mUs7fA29o5pfVqXyTN5BJ16m8kYGNwHfbk/vJ/9iH1Qh0Z9Pepd0rGefKAcSiKe2JcJ4H98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912419; c=relaxed/simple;
	bh=BwoJIuLDivt7puSYM+qJM1mK6bHhySm2Lc3Tjd/cnrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+A2O3qjpSKhHqJ5MPEs7oh6dX7M/Uvk8kKlBOpdqT1bML7yqmm+VARl7v85ca+396D9oCUk0ZlRev2+v+PKGGQvNFO8wztpNUNDhpIcfwb9NCdXwSKCOtD8+1znzpSMte5vrMzMfnAbjbNUqjikkPd3PGqbtNdS8DwLZSI4h9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.188])
	by sina.com (172.16.235.24) with ESMTP
	id 66283A2E00006439; Tue, 24 Apr 2024 06:46:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8475345089566
X-SMAIL-UIID: E2EC3C000C4F4225B05096877135F0A5-20240424-064609-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+41cf3f847df2c5f600a3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in netdev_queue_update_kobjects (2)
Date: Wed, 24 Apr 2024 06:46:08 +0800
Message-Id: <20240423224608.3180-1-hdanton@sina.com>
In-Reply-To: <0000000000000d3cfa0616b1576a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 08:46:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141dd66f180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  3cdb45594619

--- x/net/bluetooth/bnep/core.c
+++ y/net/bluetooth/bnep/core.c
@@ -540,16 +540,6 @@ static int bnep_session(void *arg)
 	return 0;
 }
 
-static struct device *bnep_get_device(struct bnep_session *session)
-{
-	struct l2cap_conn *conn = l2cap_pi(session->sock->sk)->chan->conn;
-
-	if (!conn || !conn->hcon)
-		return NULL;
-
-	return &conn->hcon->dev;
-}
-
 static const struct device_type bnep_type = {
 	.name	= "bluetooth",
 };
@@ -618,7 +608,6 @@ int bnep_add_connection(struct bnep_conn
 	bnep_set_default_proto_filter(s);
 #endif
 
-	SET_NETDEV_DEV(dev, bnep_get_device(s));
 	SET_NETDEV_DEVTYPE(dev, &bnep_type);
 
 	err = register_netdev(dev);
--

