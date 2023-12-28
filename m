Return-Path: <linux-kernel+bounces-12331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B981F37F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833D71F23241
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE25A3D;
	Thu, 28 Dec 2023 00:54:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8F637
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3601028d487so21990555ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703724866; x=1704329666;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKLFOiI4wYR5/Ovo2OggF3WlQj4fabfVZztadkiIBMk=;
        b=DEUtF6SEJANNfwYYPYAfhbNO+JgaIAQTyukFSjUPHCFQthCvAOb+AyX4HcWiQu1anJ
         5xYSAPz+LETgGNZxqajHQcOkfWZzEqpuk1SoWiyxTqWqfI+whUnazoM7/HoIsELvWNe/
         G/LA5lL9UKbQNnulY3sq8BA/gqAZDr5HGEjYC2DDW1fkSG/qkTo8ptZrOy7idueK2CpI
         eF9fNWzjQBJBfCF9Fnp5jSalD1PTmSSSfwxoPB5HaJEZF3vFpTJtTQgKpvR8BU79GNB8
         ttqYiAq91NOBg9Jj4Nfc8PZrHGOsgG2Yo3cJpRDgCv4S8SGvALB0LePpdu2hWzGTzrDA
         p0aA==
X-Gm-Message-State: AOJu0YyzfKzDurYDbU/VvN9nYBy8FHyI8UnVwXp9e9T1awYT43aT8IOp
	lU3z90gFVUmocyle6YlEtrnXtMSHy4G0koXEwd8EuC/gNMQDASU=
X-Google-Smtp-Source: AGHT+IEwPnWUUi/xM9jZtchC/u0TIesipEQYzrzf+CkQjcobhlHAg4cO55XaJM0ZaycDyUI+PvQ0U8uXcDH1kdj3N+AEu/3z8wOk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bad:b0:360:e6b:bc4a with SMTP id
 n13-20020a056e021bad00b003600e6bbc4amr393764ili.2.1703724866590; Wed, 27 Dec
 2023 16:54:26 -0800 (PST)
Date: Wed, 27 Dec 2023 16:54:26 -0800
In-Reply-To: <00000000000091a123060d7c18fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077e036060d875b9b@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
From: syzbot <syzbot+50d8672fea106e5387bb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [hfs?] KMSAN: uninit-value in hfsplus_cat_case_cmp_key
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..33eb7e5a08b3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -57,7 +57,7 @@ static int hfsplus_system_read_inode(struct inode *inode)
 
 struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 {
-	struct hfs_find_data fd;
+	struct hfs_find_data fd = {};
 	struct inode *inode;
 	int err;
 

