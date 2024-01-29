Return-Path: <linux-kernel+bounces-43255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEE841179
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F08B217D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560D3F9EF;
	Mon, 29 Jan 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vkjmQazW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25F676C9C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551239; cv=none; b=DnaxM4RJ11vzNkcHkYEqSIMoBCD4Yt3Q09mrN+m2+Q5mlzR9WVmjx4M/x1W7YT4EVecHY7eazdjKfP6X0kyeD+OtoOMibghIi7WS9U6ei8E9li2kkUXJAsVZKwwYVTZoQJ6Ymfsc6evXiEQbGTKl0aI9eV4nPLvnNwjKwVR6nNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551239; c=relaxed/simple;
	bh=8dnqni1i0A26L48rcT03UdEc1rRuCmcmNOl+uBBBp6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prJ9ckkuoKpNWsZ3ca8fQcm/usGQ3pE+GNQyfHxbpfgW9cC+nb6bWRKsfnVyUG/EiY3PWaDwkmDXGaslE5z3Un8Pu26DMDesLLFJ7Fnv4BqZykC+zv3x4XwINxAnMfigyhMtWyJwvk+gAORbtpb0hSwydt6/RQ+6rM+FdqHYXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vkjmQazW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F1BD83F184
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706551234;
	bh=8ZF26zqFi961N4xCf2xSg7p646IkBT56MWEZW1L3RH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=vkjmQazWWUJYggLxKHbM+XdlRtX0ednAjiEoklZTYzFafamXJyWDxaDOe02oAjnQV
	 8+MoGv3k1lWSbl+RlANJxx/LRhXbFgAgNIOsEwMmHGzIQoNxTlCoE8vC2GKmPcOASX
	 79JFKCn4IFyZ4RGMtE+orKlNusdno04NBVWEDUL9ZsGEGnZTzw3AzgYpjgqwM9UJGR
	 uNKg+krc11Q3U3Yj5yqb9oIzDZ6y+smwhgi4oq62Sdf734mcExiyKX6iDsgDM56sww
	 eJbNPC11gONMgLWTxRJqcnlDOtr4tzA8DPhOjbdBN3CJQmY6MYUOfEOafGBuUXQE+c
	 ksg0Qm3vtcRrw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a34a22e09ccso84729566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551233; x=1707156033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZF26zqFi961N4xCf2xSg7p646IkBT56MWEZW1L3RH8=;
        b=ljDRHF3z0veJ+ajZxEZspQhF55E4GEwb8sUXoBPMbnJj9W18aLs6xSeiiaRddywEx/
         MNRmO+r8cFOo8OEV7GayN69Rxax9W7gFLCybFx5jrL4qA4VvSF/1UPgTr4f6Ua7VnRDN
         NvvdFMUDuXGm8+6IoHcUZEw4ISCT3maWdWwfS8nIDIlRdtgsu4CTyhB1A4UCRTAxsmMi
         ZnXYgZR32mEJULmnZTmlUB9cpznOzstne87Gjzklbd6mWlMUCSTJhB8k15ZChqI1DolO
         bS51Q+IHIMMT9THAHRZInkfhkw3mqPEZLeJEcHcwXPkqD2x4eyhKSxD/ZBuDUrULkFaY
         vunQ==
X-Gm-Message-State: AOJu0YzhIKPyz3xWTvcg/3JYCUok5UEjo6ycvzlXyYQgGqsn+MEIOu8z
	LFTfrgYT0DN8EXbRYItDio9WZP5QBRwK/lhukS3cOpGofTYhGEpiltHQeC1u+yAHloBW8oPksa5
	yj82p+h2PhvQOb1gJmkmmnAyj6yLOHU+TPV5qZRzVCm/WsK54mYeWtQz9jQdrLGJ7jcrZDie01Z
	tpjQ==
X-Received: by 2002:a17:906:560e:b0:a35:3ce3:c48c with SMTP id f14-20020a170906560e00b00a353ce3c48cmr4621184ejq.23.1706551233350;
        Mon, 29 Jan 2024 10:00:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6WK2Tup3/s17NUfjas7PhWpttkvWLK15SZRHVDXcx0AkLhE1oarw2KV1uiJddN93c+MQByw==
X-Received: by 2002:a17:906:560e:b0:a35:3ce3:c48c with SMTP id f14-20020a170906560e00b00a353ce3c48cmr4621173ejq.23.1706551233104;
        Mon, 29 Jan 2024 10:00:33 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a2fb9c0337esm4147500ejc.112.2024.01.29.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:32 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ntfs3: use file_mnt_idmap helper
Date: Mon, 29 Jan 2024 19:00:23 +0100
Message-Id: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use file_mnt_idmap() as we do that across the tree.

No functional impact.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: <ntfs3@lists.linux.dev>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ee3093be5170..144aa80cca43 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -419,7 +419,7 @@ static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	 * fnd contains tree's path to insert to.
 	 * If fnd is not NULL then dir is locked.
 	 */
-	inode = ntfs_create_inode(mnt_idmap(file->f_path.mnt), dir, dentry, uni,
+	inode = ntfs_create_inode(file_mnt_idmap(file), dir, dentry, uni,
 				  mode, 0, NULL, 0, fnd);
 	err = IS_ERR(inode) ? PTR_ERR(inode) :
 			      finish_open(file, dentry, ntfs_file_open);
-- 
2.34.1


