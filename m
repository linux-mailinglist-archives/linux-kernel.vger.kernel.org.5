Return-Path: <linux-kernel+bounces-128474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18296895B51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC67FB29C0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0715AAC8;
	Tue,  2 Apr 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah7+ujC5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F460264;
	Tue,  2 Apr 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080834; cv=none; b=OXTJp8PAWi/lGcWcWhtfTTEBbo2+UX0giF7sqdqbF6E+hFO5wClnMDlDKBux2vkeXD0FZ6NAltzy015CsnjpHPlVbnPp+jiC3FQ7KUtdq+/fZjB9ZiXY0OU8v2y09+4/DqJO3voSt+qxVIu03Q+AN0nX+P+RU54J3cjro0uhCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080834; c=relaxed/simple;
	bh=8GF0ENkY5ZCtjpuTg3KDVuBsWEOU9hvUOtz5sSYs9Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e3o5wckCUsIGQlyiTK95kjizZzfVMY0tMi3aDF5EH0xk2lx8EOX2vj7ZnU/08nezBkAbrE6KByhFFKTwCqHPaOkGboRRwGC8G2KVCDmiHTDxBWSjOKcQJ1f5on98PFeMA6s0P4dGXq9QqZn4mOkcOiYO/nLKnuO3WHDvbnusg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah7+ujC5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515b3077d09so5981541e87.1;
        Tue, 02 Apr 2024 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080831; x=1712685631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kC/tyAjbAbIar7KEkkctKB5iNjP6k0DBswYBrdTUsao=;
        b=Ah7+ujC5bCRxuLyyGhtcDl/YzY/4P/pnMM5rl1Ah5k6k8LAurhKnxMCKDpbh1chmzm
         /g7sjEbWHCMV3Mw+UlfWRtlvwXZh2WILpKwPyvFdmS7niS6hM+MSwLgtVMv3bdRQpmva
         dgkxeHTQmpCIov3oWxWuOHv0D4iP9B4ZjJb0rt4z81E2Hi60qDbfGVEBOwwmWZa7NVPI
         /ywfgpquXQzXAoa6NYJUj1rvpGthNYCkTMpHpqIjZNaB3ECPnCUqIE8VcFUjNWU/e8uG
         0GswWL7jxTD+1F3axruXcHnCSmQuFi65z8S02ebnBYL4R8qpVk3591TOxRKWy4fQzQtR
         BS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080831; x=1712685631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kC/tyAjbAbIar7KEkkctKB5iNjP6k0DBswYBrdTUsao=;
        b=XUt6r8azPXfaEREfHulnr+d/aFfQVkCJjhmOUL7FloqThoC1sljrcnWJ6J4++GgNzi
         4z9trBuOdL4KSvIz80cq9ybT1q5AbyJmaqe6e4XksSQF8kQ4OBvCa7QPUVDjCmRqhyog
         HjA39VY4RuyAEUUvXGz6M+H7dqU4RAT6QcroxOI32Swn0dDpKrcEi/CTin7z8XBdbacS
         KKD9YO5ka2+Bi63TCCL1j+lcETh1l6HPj4JLLoKiUxcDQ0M1PBDkv18q4iZMdDLy0Gs2
         a50eHGJ+W9nti7z/a04dH6zAZbAq6venq/PxPq7UaMzOxagZ1SnnMgmBO171FKetSiP6
         SeiA==
X-Forwarded-Encrypted: i=1; AJvYcCWKymqffDCk/M+4xbByJEufHo+xzlj313B3mzG5kUgLe3I55wGlA31WQmob/1IlQwSizGFqz3+cvmkS0hF+88r3s/P3VK9pcK4xsVQ=
X-Gm-Message-State: AOJu0YyomJLoX5D0g7C1u7/O7ntU/ZfMwzeh9mQZHEPa2COibCt8fKka
	ZjJ0OJx1v3n3U8hIEZY4w5aDkHpGoE7b+AM2jnAYQjFJWJVU86BZ609mzMwEkkU=
X-Google-Smtp-Source: AGHT+IE65VnKYRUjD3G723qbU/8f4Hcu6bMWxVdbVDmX8hUENYaEwIQi2cwWVGzzlC1SZ7CQ+WID1w==
X-Received: by 2002:a05:6512:36c2:b0:513:a833:cda2 with SMTP id e2-20020a05651236c200b00513a833cda2mr8663470lfs.53.1712080831146;
        Tue, 02 Apr 2024 11:00:31 -0700 (PDT)
Received: from localhost.localdomain ([178.90.83.102])
        by smtp.googlemail.com with ESMTPSA id f1-20020a056512360100b00515be976594sm1792217lfs.178.2024.04.02.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 11:00:30 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: konishi.ryusuke@gmail.com,
	linux-nilfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	snovitoll@gmail.com
Subject: [PATCH] fs/nilfs2: prevent int overflow in btree binary search
Date: Tue,  2 Apr 2024 23:00:26 +0500
Message-Id: <20240402180026.2469459-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should prevent int overflow if low + high > INT_MAX in big btree with
nchildren in nilfs_btree_node_lookup() binary search.

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 fs/nilfs2/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 65659fa03..39ee4fe11 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -300,7 +300,7 @@ static int nilfs_btree_node_lookup(const struct nilfs_btree_node *node,
 	index = 0;
 	s = 0;
 	while (low <= high) {
-		index = (low + high) / 2;
+		index = low + (high - low) / 2;
 		nkey = nilfs_btree_node_get_key(node, index);
 		if (nkey == key) {
 			s = 0;
-- 
2.34.1


