Return-Path: <linux-kernel+bounces-74665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E785D772
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D79282D04
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195F47F5C;
	Wed, 21 Feb 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7mO9GIX"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA03C493;
	Wed, 21 Feb 2024 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516328; cv=none; b=soktZvOPEg4bmlcL2VMxxv2R1qvQvfzsgx82Z+YaBtgzzFKgAOUfSGkdnj33/25nsl06Gm63quq0f567IDiPXwhTQb+M/Ec2qij6DJ9BkJ6Wp5vql5PQ91YCJN2ZZ9en4LcBN623MfqJxQbYW2lT2iD4u18Z148TyIKvCkd+1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516328; c=relaxed/simple;
	bh=eFsdIkXaJEgfpS4THYxhHiEbCRqYhMwSm+DSEtwMlcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TOvh0wCeuPlpSLWuR2q5vR+vYmXt/wkM4uRzFBlJUTZM5Evhhd+N3sgSC5ZBCb4bH4kEIoWGG8i2v+WN/IF3pfonR7EoUdM6T/zVLBJI3gqrVRlAhQD2dl+6kevg6rmYxD+l0wDzAMQeM3dIp+2WRkF4U+3D4wWYEpaJy8kVqX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7mO9GIX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so7343591fa.0;
        Wed, 21 Feb 2024 03:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708516325; x=1709121125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bDsddkEN+lUWqN5ZaY3+6CrL7Csh45NI5ac4HlpkYc=;
        b=W7mO9GIXtalsQYIs1/rtW6RdChYPVOpYHQBXlbraEHCswtMtckx81Tr1Z1clKh/cO9
         NinwgkoJ/IMVFziDI+WVwjEdicdeGTBsQwv8+HRmWxCEjoCuqOiWGgbu7wACph5YoyqJ
         wJlufNh1h4hgIF9S6tqRHz/AO7+d3sZi22qCEVSJPFQom2KLch3vn8iRv4ux/CHXJfvd
         rMEreDhVERbB3A2gbB6QKeocO08d2ybPc2NPkWcwuJQZn+a8PaqnXVnbZBr4a+Lz6QOu
         motmz3jS5nWyM6is0lwqBYfevVoY/01HRx9Qd3hsRSBDL5zdij+jXdaWMEN15jXc33u/
         RUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708516325; x=1709121125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bDsddkEN+lUWqN5ZaY3+6CrL7Csh45NI5ac4HlpkYc=;
        b=m32VNTqxASUPVg03GG4QzGwXIXPxBctpT6QlCZKClqJ2Q5OCxUxeh3ksCQSk2wBM7N
         aB0HUQGqSfhK/+4TJeJ19iMMfJUSib0igeaRiIwrnSREE69WqfJhdoyIGF3E7cOZV3Qd
         7pQqUW8DBYD4mGALyN7naxYEeQWR5cO1rsYH+7ATsci/PM+UV14BJyQZpL4ZkrtqVULA
         J2dbp3UjJDqUR4F6ia/IHJFcu4coELecjvwzdfHTdlCbSojuHw9vRm9VxtnUT3NbexEA
         Rl+aoFhB/4UWCzAfnbxFx4m7Of3+KZ5e4NxQ8I77PNqs4pdWD0UPquLH5YDP81TuRM8V
         KpDA==
X-Forwarded-Encrypted: i=1; AJvYcCUweIHa2eFNAoE5WMZ0d6ezA7BZHz24MNKjBms34XoSzOculLvfVP2nPuJkYyM5YYd5xut9KEQhB8aPI7zWLDpOQd9v6Oqy7jzdeDTjJUhep1R/xiYbxB0Y4aQd5kTnKtQH+w6xuX7lTgw6a60=
X-Gm-Message-State: AOJu0Yy4uNUxlocPIu5UCv6gtai1vKAkEUiF5jzwAuX6RHEdyA4LTSph
	Xei8EofhnITMcvCDHLqARlXfgoOr6YWoEqK1EICxxPip21wr4kYQ
X-Google-Smtp-Source: AGHT+IHbxPEAHBugkO77qtNz65rcRno7FBkmRRP+NS11t1bJ2Ne90xn10OlFbQkCxqoQBNq39OysSQ==
X-Received: by 2002:a2e:be28:0:b0:2d2:2cb4:f817 with SMTP id z40-20020a2ebe28000000b002d22cb4f817mr9080866ljq.44.1708516325144;
        Wed, 21 Feb 2024 03:52:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bt27-20020a056000081b00b0033d1b653e4csm17353085wrb.54.2024.02.21.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:52:04 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	linux-bcachefs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] bcachefs: remove redundant assignment to variable ret
Date: Wed, 21 Feb 2024 11:52:03 +0000
Message-Id: <20240221115203.3413554-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable ret is being assigned a value that is never read, it is
being re-assigned a couple of statements later on. The assignment
is redundant and can be removed.

Cleans up clang scan build warning:
fs/bcachefs/super-io.c:806:2: warning: Value stored to 'ret' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/super-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 110dcb0337ce..c6d590404425 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -804,7 +804,6 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
 		goto err;
 	}
 
-	ret = 0;
 	sb->have_layout = true;
 
 	ret = bch2_sb_validate(sb, &err, READ);
-- 
2.39.2


