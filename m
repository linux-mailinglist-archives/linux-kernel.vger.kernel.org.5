Return-Path: <linux-kernel+bounces-123080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609988901DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917391C2CBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874A54BCB;
	Thu, 28 Mar 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liAm5gps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A62130E45;
	Thu, 28 Mar 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636320; cv=none; b=D+dT1TUN4HfcfLaedb4L3Hm0NXxqJkZyC69qaF01gV1/JaMi+Pd1abMZDe5qy7tlK+cfKxLQmxDLkaWwMXLYWQ9FmHKTgE7V1MdpZ5j547Ty1aC5tTKeeQlS0zyJ277jJIBjWolGkifOaRsHKgmGrS/m1h32dB07BrH5WVeidm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636320; c=relaxed/simple;
	bh=bQir+LnXysAhPZ396iMcqboZJXRv11Qwf6prsi0Igo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNOUi/TzKrMCQ7w9BMx05VwdgguSWHpqbnUPnrbRFB5DhPvXLiR3oAjwrku8qvYw88DxxoqF4xbBdhHDZhGx4w4yCn6bjOkNTsETH4G7oLgVx4epKzEA98f1g2D5a1Qp0eL4u7jP7iiV2ZT2eg4D3fS5MpZTq/8mpbGyPh7Ggl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liAm5gps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A30DC433F1;
	Thu, 28 Mar 2024 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636320;
	bh=bQir+LnXysAhPZ396iMcqboZJXRv11Qwf6prsi0Igo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liAm5gpsUU3TfhVsQ0ds/wY4LTN/URRYHe8wfWIMPMwve7nP8Tx0ppkFakNHWeFoG
	 G9zUo7Xb9xSrzVNuWGM6AmS9LJ2h7SA/YK890UR7pm3ZCL3iHJ5ytr2vILOXZc6Pvy
	 IvTi01GNrvQjFvVdEa+BmDvmrxSqIPitR/WoSyv5ZC9JVGWvwDMm8EhrwbnA+2esr4
	 8l0MIBo6tv0tvEFirVLddDTLvk+QRRamCltTRizGF5UEIXY7QpWF4mIpjgP2DEun7P
	 zHwDYRs3rRoeSuUOXdxp4i5a2hYw29lh/0tbRmGPW4DyLFW/PfoBf8fsaSzyZRi+S7
	 jHCOTMtOeo9kQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	linux-nilfs@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 6/9] nilfs2: fix out-of-range warning
Date: Thu, 28 Mar 2024 15:30:44 +0100
Message-Id: <20240328143051.1069575-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-14 points out that v_size is always smaller than a 64KB
page size if that is configured by the CPU architecture:

fs/nilfs2/ioctl.c:63:19: error: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (argv->v_size > PAGE_SIZE)
            ~~~~~~~~~~~~ ^ ~~~~~~~~~

This is ok, so just shut up that warning with a cast.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nilfs2/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index f1a01c191cf5..8be471ce4f19 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 	if (argv->v_nmembs == 0)
 		return 0;
 
-	if (argv->v_size > PAGE_SIZE)
+	if ((size_t)argv->v_size > PAGE_SIZE)
 		return -EINVAL;
 
 	/*
-- 
2.39.2


