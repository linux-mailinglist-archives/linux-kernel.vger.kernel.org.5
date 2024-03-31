Return-Path: <linux-kernel+bounces-126286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CC8934C9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA461C24265
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB914BF81;
	Sun, 31 Mar 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w1vDLVkx"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45014AD3E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903525; cv=pass; b=tTeA8vzR22oB9wkoNMag374tyj1SkwHWpn36Oax65YN0/X6PEKwQ0GunJo0CgkoQ040KJceg5yMqTQZ7X2COCtZt0ckXpmb4Oi70JfddQxLVezxuA8ZSjSEsSaBcS+dV+O/T+FeBww4jtNASb2sdUUTAZmK2bXlwbiOnDx5VzJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903525; c=relaxed/simple;
	bh=9eBbvZxCuf2y6AL53hiH3nHsymnKizW4Jkjv7RF8q0M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcF3JXKLf4EnVyXSGQDOdn4HSAzicjHnqZOs95DofSeMxrCDynJMyQikVoC4/qPMfGrSvrtmecU46BxZ/PKIgt/hEikzguAoBfkmbS4lZeg2NqWAS7Ay9ewHUTjPEz1x1HXE4gg0kJFm/F9C7+Ba69Hq2ct5iCzAcaW6zOkvIIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=fail smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w1vDLVkx; arc=none smtp.client-ip=203.205.221.242; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=qq.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 86E4F2084A;
	Sun, 31 Mar 2024 18:45:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UmNMqG1TKdYe; Sun, 31 Mar 2024 18:45:20 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A5003208DE;
	Sun, 31 Mar 2024 18:45:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A5003208DE
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 98082800061;
	Sun, 31 Mar 2024 18:45:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:45:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:26 +0000
X-sender: <linux-kernel+bounces-125911-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoA1mcFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKACwAAADnigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 17123
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125911-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 23E512025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="w1vDLVkx"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711843732; cv=none; b=fOnAryDRPPSEbcENGIxJzAZcZIazwem/S4mnuG3PEq49b0AopgSR3g65LaM+I/vd2sDDFRRsPipCz84KqTFGVIBypB0nODGZGcVtLQr1jefbmof3TUKwHP6c6VXqQ0EaKopsmy2jbeUBkorUtx02nx1FG48radsF78tE3nwJ+54=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711843732; c=relaxed/simple;
	bh=9eBbvZxCuf2y6AL53hiH3nHsymnKizW4Jkjv7RF8q0M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dmnMCf6Oes15d0QZK5sXenSja9LCp5siF4rENCcWQgiOaxgf3+A1R1FUJ8T3lkgngbNpv8VhD01o38eSpxh8csq151h8cDxASTwRLrb/Xgj1QmRIx3LeJ9o4vhndioFj8yTJN/Fo5z38xNvztR0sNxXPWjAH10rFfNT1WyoA25o=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=w1vDLVkx; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711843727; bh=XvFjpZ5QUg1ownH8/RT/owX81trRjmiD8nBR8MTc9Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w1vDLVkxoqBmgnvxg77WX9SoqAoBdk27X1mabovdrhnuSjBT3sJaxW2XuK984KSy1
	 /EbrNgFvFYjsNtYjXQqZUOyKcT2YH37JPVK13hGZtBnpK81Ju1QnnoS34mnTF9UBAk
	 /p1aIoZRVwiK6fZj28+WOSDDg8B7TdrJdxkY4VKo=
X-QQ-mid: xmsmtpt1711843725tx0pik7ok
Message-ID: <tencent_CD333C9E9E1B544B651B4D250FBAE5BB1208@qq.com>
X-QQ-XMAILINFO: M7n9VusxZAlPxmkls+7Z+QwpxKdQ6+UsCc7U7260TQiLV+CJLmfSX8u/R8a7Nt
	 GGuOuhNwT2vb6MqWP8rXrzEPUNGvR71ZfkUgn6/qjzHTtLINkfwTCG3bMe9OsXAQ9uP/q7ZiZG3P
	 PqVilKDDqqIiFb+wxNnruW525JKS03Saw5Qwr4QOe0uWDUnlRKXw3q9VbDcUUMxUIv3flYe1dOrr
	 5rtFqjq5ZvAQ948oXE204VpyqNZXewYViN+Z3SYmh4RpRQnlQiU3uLlPjnXtP0vjSJYu4HFBoBQa
	 93RLZuAJrso1cDVNrLLF0rFdwgjFVFxJ0nhK4k+k3cKQ64J0WvMxIVPfOtuSL80eh/2I0TKu5K+j
	 ojdfBiBkbQ11TrSJZHycdv6KONIooIKfHj2N3ePbuFRBSGoSxBoHU/Lc1GG+4SKOzNComzEkSQA+
	 uiYPYUYZLws6CmGuZtTnSmQqLpwqK2QS4QvfJ9w035CA3dNXCdRY5y9p/Gv/RxnzNHAU+HKkWdIr
	 sWEB/DwwRhIm2x1WRcrEcqEkr9BDMqkYR1m07JUL6N3xSbypkPJLNrNHkhqzEXxZIG/6ODeygGah
	 JScTdQaq1mND2xvk1goV4nxkKVaN1Mn/sh4VG22K3LUnEEGjWNHb2PS1fUzlvqoMMtPobkPSht5J
	 TIfjdb/RuqaVKgi4YfTQQR9V23vQeGqV0wWVJ/M05DNclCnFkbmbT9y25TyfUbENf4l8KSBg765n
	 5hD9ehLND5Lhe4tCwunr+1NtChY+aQmYjycF6Buma9HDSuLAkoGGU0oWBr17Gat+s4JAiw+FP+/J
	 KLphmg+aAdEFDq8sMuMTxlPo8s8/l7JnDsbJ3KRok7ahGmPQPxpv5E6WuuUjzUBb6mcP3XbQDWEZ
	 Plxpns4TCgoU4+1b2SMy9g3SYRwX2vu4ddeezkPRFZS1RjJTRoRnaecFIpubFbua5S62FJE7xJRQ
	 mqxuIiE3TkKU1ypya7i5WNGqDZ6yuN
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c824290332add8067111@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in lmLogClose (3)
Date: Sun, 31 Mar 2024 08:08:46 +0800
X-OQ-MSGID: <20240331000845.633596-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000041ac86061400b95d@google.com>
References: <00000000000041ac86061400b95d@google.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

please test hung in lmLogClose

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 10934f9a11be..56d336a49985 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -197,6 +197,7 @@ struct jfs_sb_info {
 	kgid_t		gid;		/* gid to override on-disk gid */
 	uint		umask;		/* umask to override on-disk umask */
 	uint		minblks_trim;	/* minimum blocks, for online trim */
+	struct mutex    simutex;
 };
 
 /* jfs_sb_info commit_state */
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 73389c68e251..b5609a7618e5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -155,7 +155,6 @@ do {						\
  */
 static LIST_HEAD(jfs_external_logs);
 static struct jfs_log *dummy_log;
-static DEFINE_MUTEX(jfs_log_mutex);
 
 /*
  * forward references
@@ -1068,19 +1067,19 @@ int lmLogOpen(struct super_block *sb)
 	if (sbi->mntflag & JFS_INLINELOG)
 		return open_inline_log(sb);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
 		if (file_bdev(log->bdev_file)->bd_dev == sbi->logdev) {
 			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
-				mutex_unlock(&jfs_log_mutex);
+				mutex_unlock(&sbi->simutex);
 				return -EINVAL;
 			}
 			/*
 			 * add file system to log active file system list
 			 */
 			if ((rc = lmLogFileSystem(log, sbi, 1))) {
-				mutex_unlock(&jfs_log_mutex);
+				mutex_unlock(&sbi->simutex);
 				return rc;
 			}
 			goto journal_found;
@@ -1088,7 +1087,7 @@ int lmLogOpen(struct super_block *sb)
 	}
 
 	if (!(log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL))) {
-		mutex_unlock(&jfs_log_mutex);
+		mutex_unlock(&sbi->simutex);
 		return -ENOMEM;
 	}
 	INIT_LIST_HEAD(&log->sb_list);
@@ -1130,7 +1129,7 @@ int lmLogOpen(struct super_block *sb)
 	sbi->log = log;
 	LOG_UNLOCK(log);
 
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	return 0;
 
 	/*
@@ -1144,7 +1143,7 @@ int lmLogOpen(struct super_block *sb)
 	fput(bdev_file);
 
       free:		/* free log descriptor */
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	kfree(log);
 
 	jfs_warn("lmLogOpen: exit(%d)", rc);
@@ -1187,12 +1186,13 @@ static int open_inline_log(struct super_block *sb)
 static int open_dummy_log(struct super_block *sb)
 {
 	int rc;
+	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	if (!dummy_log) {
 		dummy_log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL);
 		if (!dummy_log) {
-			mutex_unlock(&jfs_log_mutex);
+			mutex_unlock(&sbi->simutex);
 			return -ENOMEM;
 		}
 		INIT_LIST_HEAD(&dummy_log->sb_list);
@@ -1205,7 +1205,7 @@ static int open_dummy_log(struct super_block *sb)
 		if (rc) {
 			kfree(dummy_log);
 			dummy_log = NULL;
-			mutex_unlock(&jfs_log_mutex);
+			mutex_unlock(&sbi->simutex);
 			return rc;
 		}
 	}
@@ -1214,7 +1214,7 @@ static int open_dummy_log(struct super_block *sb)
 	list_add(&JFS_SBI(sb)->log_list, &dummy_log->sb_list);
 	JFS_SBI(sb)->log = dummy_log;
 	LOG_UNLOCK(dummy_log);
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 
 	return 0;
 }
@@ -1441,7 +1441,7 @@ int lmLogClose(struct super_block *sb)
 
 	jfs_info("lmLogClose: log:0x%p", log);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	LOG_LOCK(log);
 	list_del(&sbi->log_list);
 	LOG_UNLOCK(log);
@@ -1490,7 +1490,7 @@ int lmLogClose(struct super_block *sb)
 	kfree(log);
 
       out:
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	jfs_info("lmLogClose: exit(%d)", rc);
 	return rc;
 }
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index e1be21ca5d6e..23628ca3990c 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -504,6 +504,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->uid = INVALID_UID;
 	sbi->gid = INVALID_GID;
 	sbi->umask = -1;
+	mutex_init(&sbi->simutex);
 
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;



