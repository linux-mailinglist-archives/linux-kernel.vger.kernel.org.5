Return-Path: <linux-kernel+bounces-167355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E08BA864
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E731C218FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F4F14BFA8;
	Fri,  3 May 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6NVTqlq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5D14A601;
	Fri,  3 May 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723934; cv=none; b=Yyqv9dKJiGMTLo597ojc5SuljuCv2QZvbJKCMJ21lf6tg4TQIWKme9Iac3dE95wWC39P39k6VhHBDLtpSoS8P+Srwb4Wc7QAuVVLYjibekleAr7MespIMreSwoZP+HvWAYLV/Pj9WI3eVlZskrNSYrSZaFPViUUCvhvmRyhhWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723934; c=relaxed/simple;
	bh=mTSk7YYhmMKdfzF2clXT16BxSh0x0FLjxox0p1i+UIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZAFkvoVw4HluYXXFPkp5gZ8ehOh8NR9y1s3axmgCT30gfojVM+TiTt8/Mbx3wC75aNNoe/oNgMyVzBFFioBLVLtGnugV+YAeapoePTOcx93+S2u6DIhzFC7z/TuknTvd3xgFQ03Fl3ssROokTE7YGvLY66/zQ8umW9/i5m3Do4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6NVTqlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31537C4AF1B;
	Fri,  3 May 2024 08:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723934;
	bh=mTSk7YYhmMKdfzF2clXT16BxSh0x0FLjxox0p1i+UIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t6NVTqlqh+4NQTPVmVPdmu1TzJYgo7+5n7Of2gH8W3yll1AHQzL8c+Rx8E214ROSr
	 uqHtR8ztWWLIyOJR+xqWRXooEyVY9asKfRoYGa/7uk9hVvFl03XS64Pzy4UaqJOW9V
	 y42db/Rxo/KaMKnxebaw71kKUQyWau5mFJZ5POhw8JcATm66QKGUbW7E0/Jfil3YU7
	 aw29hy+xadXDjWGN9uEgESozlPSBdXPoS1h5FTvUtA4g2tTsZFS/uqSynbwWH4MA9A
	 yYJHuenUSCE1fmKc5dB5floIjuBGYCltrFuxC+MOae61oi9bKwbaoc50LxHuIggb+5
	 YNxW/bC+MoRiA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] alpha: add clone3() support
Date: Fri,  3 May 2024 10:11:14 +0200
Message-Id: <20240503081125.67990-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Since clone3() needs the full register state saved for copying into
the child, it needs the same kind of wrapper as fork(), vfork() and
clone().  Exact same wrapper works, actually...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/entry.S              | 1 +
 arch/alpha/kernel/syscalls/syscall.tbl | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index eb51f93a70c8..dd26062d75b3 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -811,6 +811,7 @@ alpha_\name:
 fork_like fork
 fork_like vfork
 fork_like clone
+fork_like clone3
 
 .macro	sigreturn_like name
 	.align	4
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8ff110826ce2..26cce7e7f70b 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -474,7 +474,7 @@
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
-# 545 reserved for clone3
+545	common	clone3				alpha_clone3
 546	common	close_range			sys_close_range
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
-- 
2.39.2


