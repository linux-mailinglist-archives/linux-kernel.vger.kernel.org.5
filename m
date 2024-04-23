Return-Path: <linux-kernel+bounces-155923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B258AF8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFD31F2385C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277B14388D;
	Tue, 23 Apr 2024 21:31:42 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8F13E02C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907901; cv=none; b=OamqmoW7eSlZe7R77GC5HrTuglI+/Qms3fa4ThjdyRxdrLrzLcQf9QnuP9mPvhnASVh8BglnoyhCqfcfadsyBLaihAsLwktyg4zJcwCM1SMTmLOC59CEqhxMn/nneT+AC0lL5+SmxSCbbI2VGNOUiKpi2MLN4o3FLqPCypRTqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907901; c=relaxed/simple;
	bh=NcvEBJbMADFKETvubvmIIrt8KTc/o8vkNe/aSXZvSxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hC5I9ZFXv7lSdtyn65FA9VT7s848f9Upys+ryyt7sfUNqkrTQz/XHpq3sZmfa+XXm1o1V91aDYXq1u2NH3XD2psjAnSCXfhAUqbQP7EYQZoT3JEJftsPM+5MajchgeNUQlM5uVLUd7u6L0zNwfeMncz4J6nn+AkYg98aF6fq9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.188])
	by sina.com (172.16.235.25) with ESMTP
	id 662828B200004F1F; Tue, 24 Apr 2024 05:31:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 47432634210530
X-SMAIL-UIID: B3B0442BC54F4D9990B8E3D0C28A4759-20240424-053132-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
Date: Wed, 24 Apr 2024 05:31:31 +0800
Message-Id: <20240423213131.3040-1-hdanton@sina.com>
In-Reply-To: <000000000000afab690616b12f99@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 08:35:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144067cb180000

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

