Return-Path: <linux-kernel+bounces-66616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB43855F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB352857F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75569D18;
	Thu, 15 Feb 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UF3wu1BC"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9669D04
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992429; cv=none; b=r4LDSXELfz3ELs8wbIXpUGrcwHcHReq4y5tjpEfaeXOrQct/GZqVQJX6+shP53zbL3AHw1RMYyafBLv4BPZxQqsot/JKXB+HVNtSYQjsXX/hB5ceru5oyzXIJvwJ8bkrpnVxy/4M49ye8Rtk6KyV39/1zze5avjIVX8+YamB7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992429; c=relaxed/simple;
	bh=ZdU4VeykU7M6Jfyac4J8/7W6yBvqeGFfqKVnXNdpFxk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Yq49jpKdCX+tcWJtCsuizFy375xHBg/6A0j+GySPWy0iJZuSJy95TvhZQK1XiyUtyxsWt2/EbPEm6E2bPCTiyF1JtPdWUxiNhBOsEFE2omNZ5ooHf0wfaaHOmNY0uBfUYEUQaNgFMBCLNhR8wWLl2dvnR3IOoNOa7TomzeYT05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UF3wu1BC; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707992117; bh=rxnDnn266sMDmHizmjyIVYluJ3+8lsiRplWvAA8yAew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UF3wu1BCkdt9Wkhz6SB3mqLssmKh7tfHg1Y3pm6fj0LXgrBYNmQTK9g/EcT1X3qkq
	 UQTYNHbS4wYdBhypW7QRMZq9hbXULC3t7IBSIxUpRhmqPmhMi5bdTD03v2ixBsHEdu
	 gACQl26bEbASIh1zVk8RwPnUW3lGAZIofll3+Ni8=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 3D00B63E; Thu, 15 Feb 2024 18:15:16 +0800
X-QQ-mid: xmsmtpt1707992116t3wprnbpf
Message-ID: <tencent_4E674FD48DC125910DEA92045DEADDA11907@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j82obyJWxrAi/6twAtn+h3mqbpRlOmLdB8QCxLBkaXTeXTApWnbU
	 85jma3daH0AlwaqYNY18pDO3kZx13eDH1Adhx0fSsJMhKaB4656dEJfN/p6qTY8lhLl84DKOAi+9
	 3a4aiTnjLl55Al6UaOr7eENlv4oN1RfIWERStf4U5oqZT6jyim5J0qVzaXX/qFbwSTHxgkRe3uVj
	 pBK8er5ck/vEnmNrJOHBNMt268rdrA9qkbsCur7GuSvL2aHSn345PXGtJLpokSULLmrGkALK/HC9
	 ORB1T8SDFUNaMJ+7DUIMTSMg1W/Q9SAe16kL53h3zDDaYGQXfj+vgzPcnJZmOpze2gnQlZonhq2h
	 CHCHZH4jZ4qDi6JaSuk8Spc5e5cWjQAeEzkvx0jyhTLhAEzs6tflWp9wvOUAZN2bAM4qXWFg4SBU
	 w80ByGa+nV4J6xBBojb6GSbCh4Zr5DxQgKS5W724NtMpiHpg2+lmgBpub7SEt10jc1HCybUFKHiZ
	 gowLIcVwQRV0GyUHRWFQvgkWSytH7T+XMKEDxr1RI937CmZrUGVOXR5JJXEH7Xe4n79io/b5j9Ep
	 lonCxSb1KRFaYRVeu1Kkxbp6NoRjP1HKUP+jaeBUX5rbq/ewEdWzM6K/oEeuijzFZkei9fkmeJxN
	 zdOHo2r7bqk4aSUsQOewO4Oen9CtlDbR7WVGn2IYfABnFs8ksEHEQvdBdHDRdd5sYqiU/EU1vF0q
	 cboAmOvYzJiQjzPrRULq+V6ZP2mM7oim6NdCRiQQa3eNjWH//5sTZcALlLl4pj1Z7WaVWAJxoX0/
	 7m7qnN785QardhKPyTydQumkNTo8Nak9fuzLai2ofnsQ5xIIjrk4l1xZ3kxOrVsAAPebCI4o8Ovf
	 I4thKlgmUq87Db/vMCBcRy+Fdt+TtOM1k5QUFGkXh/BUg5o/IP3dr4g98kzAkaSa4/BmPjyUJo1o
	 3co7EXS5ieNjWF9M1bsTNuNyx46HtK
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
Date: Thu, 15 Feb 2024 18:15:16 +0800
X-OQ-MSGID: <20240215101515.556063-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ec4c32061143ec95@google.com>
References: <000000000000ec4c32061143ec95@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in drm_atomic_helper_wait_for_vblanks

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 39ef0a6addeb..b16ff9020097 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1743,7 +1743,9 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	static DEFINE_MUTEX(lock);
 
+	mutex_lock(&lock);
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
 	drm_atomic_helper_commit_planes(dev, old_state, 0);
@@ -1757,6 +1759,7 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
+	mutex_unlock(&lock);
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
 


