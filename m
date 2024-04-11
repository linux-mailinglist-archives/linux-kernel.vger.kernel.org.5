Return-Path: <linux-kernel+bounces-140078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FD8A0B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1961B25197
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AB140366;
	Thu, 11 Apr 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ddn5vdWN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBD13D8BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824185; cv=none; b=OeVj+VQ1ox+1mCYxE4qZMXvBjwFOW9I/+3aM0SxwUTG3jR4pC/Tt+d9wbEwOZL1yrfbnAjS1Rw+AWoTRtitDv2K+roaKxg25wXJYYt/G7zCBeHxG+gE/vBvR2bWzw6W8v0MmHoP5b9lQ3JbJQIGB0MFssrveV9CWpFv7iOU8Ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824185; c=relaxed/simple;
	bh=jUEd61ZFpptZ5KtCvlfoBSHaTCEbZsxcbpzfL6Ny9wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1XhJL41YBZi4A0IahUXMkmI8nezQgXz0CkutmyZbd7N+QA12WLMlRiD/WQ+yFj/g9Rzs2X7iQW0xgq7YwHvZsu3kQNyW8BvzpCYsGbnbLCUUuMZmhamfymXi/tpg4ud8pSx16AGyQ+QmJXPBdP8wHpIwJrCkYbrAJOx8ncaQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ddn5vdWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712824182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kr8yZ/39CaZL7/MdJLoFtWvQBJY7UICTTRAwrtIhMhU=;
	b=Ddn5vdWN/BIrrK4j1jCNjsDRblFE2sW7kw0ZVTjqbQOJ3DdzxqTi/n6PQ2yO0lJz0bd1g9
	3FX6vKMGxlK1t+mnXnTvv+dz/ShIhwyKV1Hbv998945OIWRAj+Kq1jsnTsEUiHN2NFxMiM
	3uKvuwfZUdDnn6ekOHDs6MDYeS7kfGo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-wqpviNcsP9WoCwYguS2NVw-1; Thu, 11 Apr 2024 04:29:39 -0400
X-MC-Unique: wqpviNcsP9WoCwYguS2NVw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7e7b784d6b2so697742241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824179; x=1713428979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr8yZ/39CaZL7/MdJLoFtWvQBJY7UICTTRAwrtIhMhU=;
        b=BcINQ/fyvymWBxlowc7ki0G4eXH4JHYaYS2Jc1Wu+qXNXF1ju9o4XOOgmofk5nRsj4
         ewG+vLMfo/IxndARzOIRSwTC1Aun+n08HZOQ4WpOxLT2RZ6ICDMG3452ETEqQsHJsq3n
         otfHCFRF6uw6eXAMoaEjU6CLyJa+FTHLVMBjztIpE7npoM6dvwgV2OG4jqpTa54PiRfh
         VutqZX8HEE+Ono15VuGh+7DzNvkIsw//MYV1Q6C8M0zlZTj1XKlEIzvoJeA6QMeIEigc
         X1/bC6XSK8mYxFYMR1Z25qlWc2u5/RELauZKEAJmjLPbNPz5iRhoZdJiWC0PaA7upha0
         pMwg==
X-Forwarded-Encrypted: i=1; AJvYcCVfZcinEtgzxhNYnJ8X8sSBB8SOkiAWgGIrtae2KPe6xvPYR3t4+HmoVB50QayHYHYA/abWqGxJBsQwnK7WCpUO0dEkE6ZJLTom4/LX
X-Gm-Message-State: AOJu0YzdIUrYnVcN5kF26vJ9U9eJRuFVFUVf0FunEPrMApNc1wjDlqGR
	nhPVjIZ+BL3Q63TM5ElM+Bfqgzuml9TzpUw4z0efz4WDjyeP9RSLhdntybONgc0Pfnzbpg+u5mQ
	Jt+jQ5h/IYrDmkojtc2pKgf6liMFXuYYs/PJRXmDi1dbzwnd+RbpnVZE9dBF6Yw==
X-Received: by 2002:a05:6102:3594:b0:47a:3a6d:4d4d with SMTP id h20-20020a056102359400b0047a3a6d4d4dmr533852vsu.10.1712824179103;
        Thu, 11 Apr 2024 01:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5GnC0mBUTHupeuCkWYsDJWKGEPm++wTV8jzZf8vaD4JQ9NdRD7MvBPp53DY/6Bg4JWsv9Ng==
X-Received: by 2002:a05:6102:3594:b0:47a:3a6d:4d4d with SMTP id h20-20020a056102359400b0047a3a6d4d4dmr533810vsu.10.1712824177361;
        Thu, 11 Apr 2024 01:29:37 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id f16-20020ac86ed0000000b004348d54a873sm632760qtv.57.2024.04.11.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:29:36 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] bcachefs: fix typo in reference to BCACHEFS_DEBUG
Date: Thu, 11 Apr 2024 10:29:31 +0200
Message-ID: <20240411082931.56362-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ec9cc18fc2e6 ("bcachefs: Add checks for invalid snapshot IDs")
intends to check the sanity of a snapshot and panic when
BCACHEFS_DEBUG is set, but that conditional has a typo.

Fix the typo to refer to the actual existing Kconfig symbol.

This was found with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 fs/bcachefs/snapshot.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/snapshot.h b/fs/bcachefs/snapshot.h
index b7d2fed37c4f..3fdb41b33d2d 100644
--- a/fs/bcachefs/snapshot.h
+++ b/fs/bcachefs/snapshot.h
@@ -77,7 +77,7 @@ static inline u32 __bch2_snapshot_parent(struct bch_fs *c, u32 id)
 		return 0;
 
 	u32 parent = s->parent;
-	if (IS_ENABLED(CONFIG_BCACHEFS_DEBU) &&
+	if (IS_ENABLED(CONFIG_BCACHEFS_DEBUG) &&
 	    parent &&
 	    s->depth != snapshot_t(c, parent)->depth + 1)
 		panic("id %u depth=%u parent %u depth=%u\n",
-- 
2.44.0


