Return-Path: <linux-kernel+bounces-156262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0388B0069
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752B02846F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40D413D619;
	Wed, 24 Apr 2024 04:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/IqKU2E"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B61F5E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931923; cv=none; b=LViAUccK4ipqWkEe7IEmoU3Jkc9/wd9cbYEntgD9gBILl4/39mTH5QDjMn3emndWfI6xNpmjjNKLRoe6kwPR0tiRb514atZhsZCMOVnR7DpAkbYphcjf36eO8R5MjvpYegeZ0h7vjSS+ZVCjY/ylpQs/3QUfVWOn6U4kj85HYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931923; c=relaxed/simple;
	bh=TFk+4CuM9qr+sqBlFgXN87+/aW9ACBx9YBy5o4jDJMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k2P7mbGPtLoIakTlVZqZ9sHYjKxFxk98jPAPvMPUUjFnqtlwoFVYoCGjWlg6jbSbmp9vwQ0TmiSfbPIbpA3TxfqQ1o/WxKvX+Nl/OC1dJTfoIB5zZ0gBOGDhqmKb7PuXNw+PB6FKrW8KVRLa0DXNEP45Gg0bHkv38qqtM4Ggg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/IqKU2E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2bbc2048eso54000305ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713931921; x=1714536721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbqVX03PgVSGxgym6fer3RwCnE/0Mz6fvg/05wiIMmw=;
        b=D/IqKU2EC/76EIbjWd69X9UoVSh8RFuBLOEneihzhnToV+/rRPJuyAODGI1EXbOmPx
         7WJldu87zK6pnVCTir2YLKwCbuWsJ8EAHx2zSsRjp9+Wu7aJNnq8lPI6Fjd3B4Oa7HiI
         HKV9o/6XxzyPYsmExstMfISbw9CoTNQ0MGRoiAyLcPoxjpcGJN5urDWmGvm82wyhmIhm
         AUIuNF531Pi1GAN+0NK1sR4jQLjjFrmMbrQvsb82e4BqU+8PcQFWunkOD37KHHaR0E+w
         EmAxCMmppF4DeoemisZTEJMHFcyfDqDd+buSZCN3gW6C6oNlEovRe2tK0SbZrsQqDEOi
         zjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713931921; x=1714536721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbqVX03PgVSGxgym6fer3RwCnE/0Mz6fvg/05wiIMmw=;
        b=Yq6dwPP95NgEGYSzYd54ZkT0yRryIiy7jP6P1rhPZaq9DxgMBqg1rV0B/Ldu7hA/w3
         D7aX7WFYoV1P28VBGVPgSCD12z3UlqG0du8bBkmVicLGPT9Mm1UAVu4kp5dhOpJiIMaV
         3BvFYobS3rUcUcRp7PsS83G4MgqBxwQ3hlHbsZlbQ2MYha4cKB4c1Unx6B72x+H2Q5BR
         dmCNOKCNgOmC8S+tF/mTXqFnxIT05fHPjwM8SJNADRtYMSXzsxVcJEERaLOLrPTc6UFA
         h06Rc5sqH0lo3zd3DXPjQPM0ALbkOxi8KJI7evByjqh/lKXDOK4cQ8RvUWkhRo+td9/O
         Wgog==
X-Gm-Message-State: AOJu0Yx4mrBTrTw0n0fOJJcw5HMq/JWhqU4CaejsjGSgcvIvyF028Bie
	IOmNKHNnjHMphbkHfsz/89o54B8tXYSK1GUgwKgPgVDbVvIijcXyXRSOK/Cvwqg=
X-Google-Smtp-Source: AGHT+IH4WHgEPX5RtECxFycAH3IjEpbma8KVO0ltzVBsLTIfH2pdtA2PAt03go6Doqm54JmadzE/hw==
X-Received: by 2002:a17:902:6bcb:b0:1e4:b1a2:b40c with SMTP id m11-20020a1709026bcb00b001e4b1a2b40cmr1212372plt.42.1713931920900;
        Tue, 23 Apr 2024 21:12:00 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id kg8-20020a170903060800b001ea699b79cbsm338892plb.213.2024.04.23.21.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 21:12:00 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
Date: Wed, 24 Apr 2024 13:11:56 +0900
Message-Id: <20240424041156.45729-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000866ea0616cb082c@google.com>
References: <0000000000000866ea0616cb082c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test array-index-out-of-bounds in diFree

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

---
 fs/jfs/jfs_imap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..977751b30489 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -881,6 +881,11 @@ int diFree(struct inode *ip)
 	 */
 	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb));
 
+	if(agno >= MAXAG){
+		jfs_error(ip->i_sb, "invalid array index (agno >= MAXAG), agno = %d\n", agno);
+		return -ENOMEM;
+	}
+
 	/* Lock the AG specific inode map information
 	 */
 	AG_LOCK(imap, agno);
-- 
2.34.1

