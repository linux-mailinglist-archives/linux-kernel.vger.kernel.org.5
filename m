Return-Path: <linux-kernel+bounces-57748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C284DCF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E311F2673D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4DE6BB4F;
	Thu,  8 Feb 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGf3VaCN"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F36BB2F;
	Thu,  8 Feb 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384626; cv=none; b=U3bEeecU97PrpEY8gTFhPj7cNDGWHYI8MzJTXdQvHwcut638eflnVQAJLOJr2C6L46yCQ2w8UsvXLMRsiE2HNeDMl61ybnFa7umhvppuKQ8IWJLGNEIU+WeiUogOOGxWs93RnDkzUolTu+Zdj5o07g7qwLgXSWDBCLZGKAU2KKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384626; c=relaxed/simple;
	bh=BsuNr2wFRiqg7Q6CcRh1Y6ZuSkW7Duy0dfvM1Fr5JHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGikHE6LPy6RBw6KXcFhwUjMur2IjsY4KhuFBLtJhX8csY6l+t9XTFWxiLENriWBKz5HnKnJj4aQH1ycuYWCLqkxPMpA3/7OQAgzzKTn1GZ9W4GAihy7dxzY9B1ncQdcuETTowRiu763vjt4grrV9HtEt55ANpds/tCJIoZCjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGf3VaCN; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59cf4872e1dso646130eaf.1;
        Thu, 08 Feb 2024 01:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707384624; x=1707989424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsvJHYcs+h3JDFjBbpRPK2hAfd5iS8YGtIvMyf/vT6A=;
        b=VGf3VaCNss0iVVhCUMdbTGduA3C7c6l+ssd67/EgzXh+778gRSWp2niyhb4hrT32p0
         Asq8B4KNna2rJoBJK2tnIGsYEn8JMzXLx0d39sFbXlmhn6dWw6cBZCWgxbeP1ByPvJOI
         7ynmPqVp8ypVeGLgZl0fls34gcuDB8mQRpYCo/CEZridrQ/zXC4vDwZ3JmnznbTQqeEY
         GKV4VDX5qTv2AYFR5QjH73UJKAsMElmtd2vDL9ZlCvL5iz3hNu4s9RA4dr7PHFWl7605
         fPtzwcZoATJYfKAMmmWYn0Eix+y8/Sbh3Z+D6mS9iH8I9esCGmJW5r1AZGvL4hNW1O2k
         oINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384624; x=1707989424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsvJHYcs+h3JDFjBbpRPK2hAfd5iS8YGtIvMyf/vT6A=;
        b=Ipv2XYoAKzwcNoOpdWMAYlcHA8TXOTud4DejyU4IK+HIF56e0AR3UeB4r+qMfY7jc0
         3zW89ppIC7VdJjbRrv/sY9kFB9EZNQ2kFa1QJ3uwoSui7Tu4X6gP4jM0+EIioAB56OoN
         x/yHJKyJ6FyfRzo/ddkivguvKIOIy5ALbqXNaEE8w1n1otDsc335XNrj+ye1RWCbfkW/
         nF0niwBRH4hvLJ4U8Ds50JI2fJ6aiDfNveKUJVXX0/uZf5jTf5lTgb5Enw9sd47uRW0h
         N0Ls7z1Cw7qMpYepM1SqbRZQUJRtSJmkgSkqvtikBju/HunR7yNX3ugUmZ7pB7PlYgdl
         JhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj3dRf5CkbrvQr1woeuawZfaiHYWVGlVnSL7CiXGRmP4TA3s1w/ufb2i8KiVCfnWgQtyF63uJLJQaTjJ+lORtulvZ0Np64GcmPo4qJ
X-Gm-Message-State: AOJu0YxslUTqnDHesNu1+3FHsiwyd6jIywgZetwkc4uJpfrheJWZ7Mut
	AsXMCceMCJeqhzzL0gUuVPTgCuFkCyAW7GTQN8+KM2zrrF5xgLkAOOdXQ+uf
X-Google-Smtp-Source: AGHT+IHs//tQP76kYjYVEbhOiaNgpCzPHJjRNIfqmpE1/l2iMUgLwEHjA4sNpOOI27nRwXdb1BOzSw==
X-Received: by 2002:a05:6358:2241:b0:178:72b5:cf41 with SMTP id i1-20020a056358224100b0017872b5cf41mr6045085rwc.7.1707384623404;
        Thu, 08 Feb 2024 01:30:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnDm6QIxRCfQHDlEv/mp9oVKM2WeAYoYvqhEp0GJpXvzP67BfWEygA57mFgGsAbYXbQG16Xpb8BJJ3qH67bj52XUDu2Qx5biKDtw12
Received: from carrot.. (i60-34-120-122.s42.a014.ap.plala.or.jp. [60.34.120.122])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b006e05cb7fd1fsm3189690pfo.164.2024.02.08.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:30:21 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs <linux-nilfs@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: MAINTAINERS: drop unreachable project mirror site
Date: Thu,  8 Feb 2024 18:30:18 +0900
Message-Id: <20240208093018.6334-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hosting site where the nilfs project had a mirror site continues
to be in trouble, so we have decided not to use that site.  This will
reflect it in the MAINTAINERS file.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..d3202a7c3c83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15431,7 +15431,6 @@ M:	Ryusuke Konishi <konishi.ryusuke@gmail.com>
 L:	linux-nilfs@vger.kernel.org
 S:	Supported
 W:	https://nilfs.sourceforge.io/
-W:	https://nilfs.osdn.jp/
 T:	git https://github.com/konis/nilfs2.git
 F:	Documentation/filesystems/nilfs2.rst
 F:	fs/nilfs2/
-- 
2.34.1


