Return-Path: <linux-kernel+bounces-46222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9503843C85
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2000B2C987
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101F2762EB;
	Wed, 31 Jan 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Sy2okhQh"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BF6EB62
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696524; cv=none; b=pBuAw8i7L6sofX0bUERspwVobLEAAXmUfb9BmfJESOpCXmnm2OnFC19AJ2eEDFZXPdju0jY2WE6ehXOni4AboWlT5ipElKBV7YQOCbTC8SWRwIhzlx8ppXTIYXowS1CdoOZCEXrihDAwDVburCNky337ubjGa3iiXf/FcaGGg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696524; c=relaxed/simple;
	bh=IQJR9u2rNKDpt6G+jJ53eyh2w8ADSqCJU5PuAAAXG1o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JEMHhDcBvayl34loVHiGO8hZJwYMKAao2neEa6FfQdQA8QN2zhyxQvFrVZaCOcZ2m1CXsJ6RwbxJv7gVL87JI9VQhsbJV9ausuE97NCj/gEHRU00KaVy+BUBV6b6aE888qQTxq3LwQHN8OoEYfYEwlt8xwoqWFBFnLI6Nm9aH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Sy2okhQh; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706696518; bh=FZTLuzXLAQaVeDF3PgltHoTihh7oZGiR3nlsk5D/9SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sy2okhQhfwRjmSwidCsB9HEP+7/yWmAI8tLlm0DsL5V8uZy+PCuP/zDkNOrW5bb4o
	 urC6GB4rjdfmH3pMXXmldknGHAiY8fzLq1uwWE4NZ+YTY0gG/HwS5w0XdG/vurzFBu
	 dxOGW5tdccthCSqBf8CGscXVrfRn0NlgOM4ZTgn8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 36FA1441; Wed, 31 Jan 2024 18:13:47 +0800
X-QQ-mid: xmsmtpt1706696027tp6rmpcp8
Message-ID: <tencent_E65689B9AEDBAEC48C92A7D306C0D2EE4606@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NotdNI22+XGZPnNfUgGUiybdWJ8Eo2uGqD1sAOzjS+K3zrl/MabL
	 epBHkLl59UKb809tdsgtCjG3f5+BG6MfUutWfga2YsYw+WUuhPUnZeLSXWA/JPRsWcN6ztcZQ4hY
	 mygHz2YtFLxNzkFaooc27HJM4ZTMtXaHgxa6SUWskrpww65vWE9S7kFOLJyvJLdxMD2s3QAaDrt9
	 y5H79TPOKJ5nA//K5A0b2l+0wN3VeOwSUOLN6UOKnay+XMUPKhSdSR1hj2uXumc+JVnqOgI9yJKn
	 SiKMLKhEPEGvaaWQIlk37AW7mvkY6L28yGs4TSm6sUwktXVw11UDXUrc6KTGrV0bd52x3a3OERqA
	 xA5MvsYR44Tzzchh6l7NFryMvPJdDQ9w7NZKjMLp/IchHVT7drtipkgfW1g4J9OH0FqMpM3W/e7J
	 AFDXrSdRXggl+z+V6dtldhsdmEujZcMMKmgeXe+T7Vz0zftdVipZlil78aPOX9KliHJezxbMZrA8
	 cEjWVvSLelR5zDtznR/Kn5b8aQrr8jXX8I2GJ00yRzpBceS9IcGucKGr6F8xbEudidhUCvuhXd6M
	 NMedN4uGW2ntUTadODyTtRRq3RQXTMq6GZPqCnJ3Ra5i/h/5jxoN2IbYnggftNRGWhC9wRlVWUj+
	 cldxN3hS5TL9p1PERGDVqOkKdBejo0NmUiHuNEELOYFRFcr737GDlOqosuofTfFXD2FnwebQJkSv
	 Ryx+pVJGoA0nNp+TALRO27g3OsNRFoOltdptw64OcsDZgPsWxdv8fBDQZQRZhKRB8bbSPsF7cODD
	 SNw4XDpbeUDXazeBYzoaVcYehqU0JMT8WTXYddGS4kFsZv5CWumSkFSgzN5F+5dzIjVMM2eA2Pik
	 KLKc+pnG6r/hfZ1h32VaA+Q6SwMIOur6XT6dl+8J1g5miwwXYPTmgNangcmKVkAo/a3ZrTShyvuh
	 ucvKgoQ7cJ+/u1mrIVHdswBEoDGnhCIghaJfY2XNNOEBQuT+xmvRKEusdhTK6VjVyDfmZuL0ype2
	 jm0U0erWAiIsr7a0mOYpiBb83mhNQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
Date: Wed, 31 Jan 2024 18:13:48 +0800
X-OQ-MSGID: <20240131101347.1111131-2-eadavis@qq.com>
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
index d5d94510afd3..1af3c8aa78a3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,7 +311,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
-static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
+static void blk_trace_free_top(struct request_queue *q, struct blk_trace *bt)
 {
 	relay_close(bt->rchan);
 
@@ -325,11 +325,21 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	} else {
 		debugfs_remove(bt->dir);
 	}
+}
+
+static void blk_trace_free_bt(struct blk_trace *bt)
+{
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
 }
 
+static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
+{
+	blk_trace_free_top(q, bt);
+	blk_trace_free_bt(bt);
+}
+
 static void get_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -377,12 +387,23 @@ static int blk_trace_stop(struct blk_trace *bt)
 	return 0;
 }
 
+static void blk_trace_rcu_free(struct rcu_head *rcu)
+{
+	struct blk_trace *bt;
+
+	bt = container_of(rcu, struct blk_trace, rcu);
+	if (bt)
+		blk_trace_free_bt(bt);
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	blk_trace_stop(bt);
-	synchronize_rcu();
-	blk_trace_free(q, bt);
+	mutex_unlock(&q->debugfs_mutex);
+	blk_trace_free_top(q, bt);
 	put_probe_ref();
+	call_rcu(&bt->rcu, blk_trace_rcu_free);
+	mutex_lock(&q->debugfs_mutex);
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


