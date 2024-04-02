Return-Path: <linux-kernel+bounces-127990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C76895425
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E58D2862CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68D7F7EC;
	Tue,  2 Apr 2024 13:01:08 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306A7E58A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062868; cv=none; b=YYaxaWF5k56kGfV0xSqjVW01xyyYgaywjyIfJZCR6IjfcaC+r+fIMX6EqFr6Fay3ZP3AjxYqV9ScSvWG24VO5qusDB1CleoayXDcdoMMYXyR/Nc5YcsyaAhL0ljz6Yqp0lXEUPT39Q+CWSbrooES/ezIHNf0Qb1fn2fIdpmYIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062868; c=relaxed/simple;
	bh=JOw/SYsFLuL+mWLs2z8AGRWIMJ2p3W/kaFJVqb+7TCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sgIb1I3+Sgt29GGxyCvSp57C9STDkOxX7SaqM2MfK4EpFkvCLUNGvpU/CV94xckg81llZq8AwPnEbjLdGL4bhQpAvihuLTy4GLPHNxjZSVS7ehSK3fmXVFDOPu3LUDTa6wpHDOws9i8gJLtXMqdgIEl2U79O/mzotNqBmgDa8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.84])
	by sina.com (172.16.235.25) with ESMTP
	id 660C0182000061EC; Tue, 2 Apr 2024 21:00:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 62554134210268
X-SMAIL-UIID: 2161B86758854EB5B26991735528F0B6-20240402-210054-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+05e63c0981a31f35f3fa@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in shmem_get_next_id
Date: Tue,  2 Apr 2024 21:00:40 +0800
Message-Id: <20240402130040.3715-1-hdanton@sina.com>
In-Reply-To: <000000000000a1ff78061517a148@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Apr 2024 23:58:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150d3cee180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/mm/shmem_quota.c
+++ y/mm/shmem_quota.c
@@ -116,7 +116,7 @@ static int shmem_free_file_info(struct s
 static int shmem_get_next_id(struct super_block *sb, struct kqid *qid)
 {
 	struct mem_dqinfo *info = sb_dqinfo(sb, qid->type);
-	struct rb_node *node = ((struct rb_root *)info->dqi_priv)->rb_node;
+	struct rb_node *node;
 	qid_t id = from_kqid(&init_user_ns, *qid);
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct quota_id *entry = NULL;
@@ -126,6 +126,11 @@ static int shmem_get_next_id(struct supe
 		return -ESRCH;
 
 	down_read(&dqopt->dqio_sem);
+	if (!info->dqi_priv) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+	node = ((struct rb_root *)info->dqi_priv)->rb_node;
 	while (node) {
 		entry = rb_entry(node, struct quota_id, node);
 
--

