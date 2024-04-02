Return-Path: <linux-kernel+bounces-127785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197698950F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9010287A97
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719EA64CE9;
	Tue,  2 Apr 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mMFzxVgl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C860EC3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055159; cv=none; b=b5ezapt/oNNel8N4CmEqpmlBYcjBbB8xYc8ToQrm9lAKb+G7vFckhZLgPGe16gBMMwYicY7RmN/pU3gI0L/BhwBH+wM7+6z18WllcKyL7aXsPFLdHGZK+Xcl9GJrsvvdc8t804NZo7Nog/CiElSNHUoDEM3qHT0TTp7LCAAI/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055159; c=relaxed/simple;
	bh=FxRmJZ9KL9xpBpm4pOBuIBWeWydQ+wxCpl14xHng60Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XILOihbCJVz1CxQ8oDACI5k6Uoi6Xv9TsSE1VFcCLJS5OFP/oUVRRiGjOgMkLbXPeBu7fwUyt8oOoRs77kBtQyzerT3VJJUeeBbD2BZjFjEVZ8YbTGf7Huv8oWyFIH6TwCHOzYFmYUF7dxbejG7HG2ngHYcSJZqgpTTD98S/z1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mMFzxVgl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so5843847a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712055156; x=1712659956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTP+C6xMYT5Qm5c+52geS7X5NPkIi5DsshiYl5+1cnQ=;
        b=mMFzxVglnO1eGpcECFfrzGp0UvKcvtdECusQp0QDQ1n/FgfiGjSl4CSngVUEFKW2qD
         uoj0mJulw+/++cz2u0Dm+jR7S/mEIKkfqKpN0qskd02mTLGarFtdv44+w3qbXIady89W
         NGmUik6LdAVEEA04XnybbmSy3PrJjwIgk9fsPFM5mOQycaG5CQ/mV1js5TA3csNz5cdQ
         QcrtmZB4158iP76umfgb4JWn0TBaEzFN99/Uw0mE3Lt4jFIo8rFZQvX9d0GFYghNZabr
         WKID1aEl39obIzPKjGBG5al6H/cmEIUrVcL+8OwyskHaghxWIsxQK6MfAo3Wc9/0pOh0
         wrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055156; x=1712659956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTP+C6xMYT5Qm5c+52geS7X5NPkIi5DsshiYl5+1cnQ=;
        b=qpOZlTsmoFY7400ua5qyyEFWa6LQjnDgRqT4N61oqvdj3FaIAGnhu4uMoaEfAy8WnV
         a/3n+tuxl1Y5lwX76lFl9cRFml2kZg6FxFJfCsrBfWDa5P5bFvbwZEqrbbIDgXYxq6hs
         fpy8hpLO4tglNroO3BNQGO4c8VNbGX2twEbGuOIK6I0zpGM155GB8JMVYr31y5g/tYef
         eamNRen6UFfYXVVpsSyvu0wlNSCBmYp6pLQNokNGDeQN9z9o/qtSsMPjxioFKN6ICz7d
         jYf1unHcMNeeIbgZnOulnf9s1jjpeGq32HBsDtUk9PYesB4iJRMRKC7D98WX5oLUVBQa
         QbxA==
X-Forwarded-Encrypted: i=1; AJvYcCX0iFzhKd5LsMes4HvD9S3Dzo3ZNPfBjkB1OacAh0drcKtdblQtndOMM+pvVnngKwy1iGONB8pwdpkznY0nqXgkjS1xzPUq2jjkq7Ui
X-Gm-Message-State: AOJu0Yy+i+LrfN0BcJ5IWHqzsjmSwg1j3+IYURvBmtCgJXcrF/tXgm+0
	WIoQvoCPjcipDRGLokOH7ij2QzpQ1uqBQjqCQOiVTgntcihr4DqL2u2bFV3/P4c=
X-Google-Smtp-Source: AGHT+IEPB4lf+7AgxzD2ZzI90EcqqarZcmw7DFa1Hl54/l1ZvwyGEvz/POzaHyV9FGreF9kuK/Z3OA==
X-Received: by 2002:a17:907:7e9a:b0:a47:4ae0:3bb9 with SMTP id qb26-20020a1709077e9a00b00a474ae03bb9mr9289912ejc.23.1712055156147;
        Tue, 02 Apr 2024 03:52:36 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a4739efd7cesm6435520ejb.60.2024.04.02.03.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:52:35 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] jbd2: Use str_plural() to fix Coccinelle warning
Date: Tue,  2 Apr 2024 12:51:58 +0200
Message-ID: <20240402105157.254389-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(dropped)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/jbd2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..af930c3d0d97 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/crc32.h>
 #include <linux/blkdev.h>
+#include <linux/string_choices.h>
 #endif
 
 /*
@@ -374,7 +375,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 			be32_to_cpu(journal->j_superblock->s_sequence);
 		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
-			  dropped, (dropped == 1) ? "" : "s");
+			  dropped, str_plural(dropped));
 #endif
 		journal->j_transaction_sequence = ++info.end_transaction;
 		journal->j_head = info.head_block;
-- 
2.44.0


