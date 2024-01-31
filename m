Return-Path: <linux-kernel+bounces-45566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646B843278
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B435B282945
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD101C2D;
	Wed, 31 Jan 2024 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="t4Ty4Pxl"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6147363
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663139; cv=none; b=cqBoHfl/qNkZrq2W4axITwnbPTBzwuKEjlp85aRiZBKhbi+h3ka3KEwG1xOazmtz7GFRnmKu1rRdUdu6cOG3y4fFScrVZQXODVg++WDyLfp5Lj0B07D4pTE+0O3FGM2Xznn6XAl/mSATnekawk3w3zUyVJkq2WoCs5k1yrZFSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663139; c=relaxed/simple;
	bh=/reyIWrnc/s8U/muKotzHJXIvzUNgSoN9UxgvBBFV4g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PIl86btaxlomtje0YdUyzSFL8pvCauVhYkQtWlOt6us/J/iWu9h/GYaDyaj4/j5KwNPkYMGPVvgui0ufJ0KWXAS+omIZ4XQoswK++BwiadSDQAj1yd4xYvdeXCN2G3fvDlcbn7TjhGOwZV1pZO0pZSZT0LPXHmwQIMy/b7VxEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=t4Ty4Pxl; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706663128; bh=h/FOpSUNaj0QAhpqX2cYRguVmxQYM03WkzpdCI4Fd8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t4Ty4Pxl1ogme6lQASXp+Y/JBCacz1nVoVZtPTSZkXogbs2MKX3I7Y1rgFzxyPJLY
	 UJW6+eU9D8e1rMmR0ETiYVEtxXr9kox1Pm3ZIVLNnXRFBokJOlqGDbB2zT5J4GIh/o
	 A7hyTXMwq9HgqOFferV2BIctf6i2lNPfMPQET7VA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 10D96450; Wed, 31 Jan 2024 09:04:13 +0800
X-QQ-mid: xmsmtpt1706663053tie8efjic
Message-ID: <tencent_BCCCBAE7D686E812D8067B09826EF6EEC506@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aO645nJ9CGVH2jDx57WBcUcFsCu47V3F3i6dv7dUoNtZvnI9ELU
	 Fy9X9kO+qNmse4wEX5M7lMjrbyzmwZQoTqcwTc3GhCQRbi5ZwB+RxuXLhMCHTWFA8hDV0fJzzzZO
	 l18U+2WuPKCugqZai0IzaafVZM8/MhDTtcAaudMTmgorlnjGjD0OLjmO6YQTsENnSlUPzJ2OIqjk
	 qFJ/IDZLoGvYMlsvYBx+Mm1LcAaaWY29G+pf5NA7xgR3Bi/FeWjfCe+tPpk+ueem4xMAtOaS+sNI
	 grC5iNFZwx+yCOYAMgE0nGLNvxx9x5dtDmiEBoz0mwo6UkR3R/WU5VSYVr8ZGeC0bAjKGvOYZ4TT
	 FA4nN11RtXfjqzpdHvb7onfNEbPJLPQ0YlYT0ODIBnYw9NZydupUOYj2snfE+W7FwMy5Wf4lgaDM
	 d+t+68PpkuJ9PJK4i+OIqpO8X5RXh1w/JdvXkaDlQF+6S4bWWSKnYfxRjz8mV8HX7B7bWaMt0tzj
	 BXG9vQOAeaJmYjlvRCR7iKVVnp+xg/lle2c5drAwudSqlkcfJ9FZFBe46ROnfIGUf1BUVEmjP/2j
	 EAdYtrkCTRbypeIbEmqYgeT0RpsaZ4kG2HPRLOBvQq7wwx9VVO/GfN+YNG2BCS4j65jiOcgWDam3
	 ZDQu/dV6uSYH1iWKqrKwgTuJhkhl/LzjEWxJYoksUnuocgCEhJuJIRTBE+c+xXaxzd0DkbPaEypy
	 bjzHw9bJ9bhnjqZ+PCcLPM9UNSsUEnAmy0KU+2mjaOUeRCIJwPvYUqwCzb6ONcS5yjtFkd0z6L6+
	 AYnkz373OGG+jF/TQY9guhyponjeKu3NLHDyd3hZic4PcnRAC7VXmxEOvK98JRwHbAZPkuMDrh4j
	 2u3GQL38t8lKrYhLSWgRa3wYsrmmJS5X57Vgi9/5Emcli/RgdGOJ3LhvoTzw7bpg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 09:04:14 +0800
X-OQ-MSGID: <20240131010413.264977-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
References: <0000000000002b1fc7060fca3adf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in blk_trace_remove

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..5eecdf9b8570 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -330,6 +330,13 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	kfree(bt);
 }
 
+static void blk_trace_free_rcu(struct blk_trace *bt)
+{
+	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
+	kfree(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -377,12 +384,32 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt) {
+		blk_trace_free_rcu(bt);
+	}
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
-	blk_trace_free(q, bt);
+	relay_close(bt->rchan);
+	/*
+	 * If 'bt->dir' is not set, then both 'dropped' and 'msg' are created
+	 * under 'q->debugfs_dir', thus lookup and remove them.
+	 */
+	if (!bt->dir) {
+		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
+		debugfs_lookup_and_remove("msg", q->debugfs_dir);
+	} else {
+		debugfs_remove(bt->dir);
+	}
 	put_probe_ref();
+	call_rcu(&bt->rcu, blk_trace_rcu_free);
 }
 
 static int __blk_trace_remove(struct request_queue *q)
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..5f927328b7e6 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -26,6 +26,7 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	struct rcu_head rcu;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);


