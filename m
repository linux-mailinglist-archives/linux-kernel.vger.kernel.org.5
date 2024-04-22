Return-Path: <linux-kernel+bounces-152742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F568AC3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CFD1C21710
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88917C74;
	Mon, 22 Apr 2024 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJyO/qPc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681A1759F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763757; cv=none; b=aPBlUs+5TkI1rowa1qkUQHz9I3k2c+PL1Vzfq9mS+AMsxhOGakoNRF2v6qwAwcnQZO7ABudx8UqVzXCpNLQmRrJ3WmikXGU2ds98iY6Ze0NiXs2ULLglyIO3+MXmGFUykxhsO/uS408P2DlIyt+eQbNi+l8so6Nx4cyJCkJao24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763757; c=relaxed/simple;
	bh=EwDdO4kB9vWvKwQkeYBCAasu5jo1yUApQuYX6K8AqXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suOv02a4/sIcNjsdr8kSLLFfcU0B1uspNVVi5CMTbtyZ4F3VmgaaoijlZtck5ey1YMdpHT+l9l801lzuLvOGkos/7SZE4bNOHAgl9Ux4vtZCXDzF+MTtEpSCMcrwHY7+iluqJPcuEQD4/WL/oBrexEI/l1FOb0BsKaZcNm8xLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJyO/qPc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso13860105ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713763756; x=1714368556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lCcvnvW4HdfgLRjxzQ/0ww9evUz6B8kyBKHmeRff18=;
        b=CJyO/qPchRp6hNcE8zDM1Sf3gQaTKYToP66HHJs0L7IZnOnTLzzohHslCKDRHazOal
         1GQVeYYz7rAa2MXRGQsGUKHvDoocVJbZSUbzcCKwumNZ7jvsvgnWBjbdVEXGUCY0eaKt
         IYOewNQ4nTbinF8W8u2DIkM/rOfe8SBkibR+hPHT9Y9L8x/q0ERVu/oN9ohq563a6/m9
         PtaxFtchiiIM1zN8Kj/WyyziYo6H5+prbP/wM/Ji8OtMREcCZqws3vffIQ3yAaqcGFb3
         yBoClDBi0qSMKRKg6dzysOR2zOWAabAInxu8VuVSpzxg87zeov9NSQfDtzXihzvnzl6b
         t1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763756; x=1714368556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lCcvnvW4HdfgLRjxzQ/0ww9evUz6B8kyBKHmeRff18=;
        b=bI3Av8ssEaKYGm7gHBz7Yp/UoERm3vNwcdVO/cCgDBvmy2Q8mL7Vo2l6lTJ33RHNUB
         5KFVZ4q4VGzmjZEK9DQX/PdLmeif6ZGlj4a+a1ju2PHAR+eTsa2ogNmWDu0Gf978DxZd
         GbOYpl8HZLOHQHgloXtUdb/pOvpG2GTZNbiZJrH/fncXdgAHidiaqTwoWOHJ9md3ih51
         uMK7Zl5idjr/Xh7JZXfdPfyr39STdd6fuT12v5hAoFeajKFJzK0hWgDjkgB/c4sN1GN/
         aTonhpHi3dKi2MXakU55pyezbG521oMMJAIin9klhNpuw8rB8u3W31ZQg9I9e0kzcZMu
         JXGQ==
X-Gm-Message-State: AOJu0YzGXAgOehD5wNGywt34VrMF4mhmOJyBhb+7T856iYsuF4ncFZ4M
	7iYo4fot1DNX/j4xz44x19lwyl1Ss95q0PpcInNCUshUJ5A1Hu2c73TU39jM
X-Google-Smtp-Source: AGHT+IE/4Au3tzuIcjVwZugiKvSs7rSx9oy6YNPxkSe1y/E2WQaarJqUZQqEJF3ErHsw9u/dIQzE2g==
X-Received: by 2002:a17:902:f80e:b0:1e3:c4c2:efa9 with SMTP id ix14-20020a170902f80e00b001e3c4c2efa9mr7174365plb.31.1713763755706;
        Sun, 21 Apr 2024 22:29:15 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id mi8-20020a170902fcc800b001e294f2f30dsm7183411plb.93.2024.04.21.22.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 22:29:15 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jffs2?] [nilfs?] KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
Date: Mon, 22 Apr 2024 14:29:11 +0900
Message-Id: <20240422052911.140041-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000032adb00615568aee@google.com>
References: <00000000000032adb00615568aee@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-use-after-free Read in jffs2_garbage_collect_pass

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/jffs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index aede1be4dc0c..49bf8e11c11c 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -348,6 +348,7 @@ static void jffs2_kill_sb(struct super_block *sb)
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
+	memset(&c, 0, sizeof(struct jffs2_sb_info));
 }
 
 static struct file_system_type jffs2_fs_type = {
-- 
2.34.1

