Return-Path: <linux-kernel+bounces-132762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315D8999D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443C61C21400
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87CD160862;
	Fri,  5 Apr 2024 09:50:29 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210D16079B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310629; cv=none; b=o/FH/AYUB0GRuTOCPsvFfjJ3wvIWHwP6VNHCmgPUR0o/ZdxpfjrI3rUncrxY70p9PG2hUJw/Jxb8SF+Q3aWBhC/K1K2+eyC4b37y/P5mE7XgSodKVHikB2cIZtYnma2WY4zi8x38laGrqweCNVOOYzT6kCfWjB6Ti59vVfCLcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310629; c=relaxed/simple;
	bh=ld7MABUIT4GwB7SBBdUAqHWGXEUI6Uu+yUkMDyLDVj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBaYfnWNYXK/JuvZUfuC5dJok3eG+vn3xLiXYy7HtlWXsyONLPKbroLgInjSqBRPX1GeirZInssnbJiL46CuJ697D/giUsFuj0hwpCn4pvV0Zt9eQ3YMpMD/jtvt1iJ5lmjK/QxonP/p4okGR42hUHw2BaJsqxo3cSCkZuuDEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.172])
	by sina.com (10.75.12.45) with ESMTP
	id 660FC92D00009DCE; Fri, 5 Apr 2024 17:49:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 88954431457930
X-SMAIL-UIID: 469E1AF257C64CE583A829E75E09A4B8-20240405-174935-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+837ba09d9db969068367@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
Date: Fri,  5 Apr 2024 17:49:24 +0800
Message-Id: <20240405094924.896-1-hdanton@sina.com>
In-Reply-To: <0000000000007558ae061553f41b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 23:56:28 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1777929d180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/net/bluetooth/hci_sock.c
+++ y/net/bluetooth/hci_sock.c
@@ -1946,7 +1946,7 @@ static int hci_sock_setsockopt_old(struc
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
+		if (len < sizeof(opt) || copy_from_sockptr(&opt, optval, sizeof(opt))) {
 			err = -EFAULT;
 			break;
 		}
--

