Return-Path: <linux-kernel+bounces-115547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01F8895A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F578B364BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C682F24A878;
	Mon, 25 Mar 2024 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbBmmgWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28791EFE28;
	Sun, 24 Mar 2024 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321048; cv=none; b=nC86LOKB2CZpIB36J4XfwQO+2LhIIGzZHh5OyAcpMU9crfHJ9hPBbFCF9jBAiulL8VZPk3VUQhZ1MU6M+uV4bGcJnehKym8Lht7axohH3OR2fLJxCA3oMbQ3u+OCQU7vXe8gOtD4BQuMt17MG0WwvLSBcEwXZuhvIZX72ti45NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321048; c=relaxed/simple;
	bh=A+Xsytz4MnzIXKoWB28lM3p54mT0uJ1kwuAxvS4h74I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+jTcGbJF/z5xsk0iBoSwV8tjgU5EC3Y/Oq/VCqgVtvf9MpphwCk3q/Jj5oAZVnh7cicObV94NxKFk/b/gigNB7JPBZDgdaiZ1kLjX6aGgWD5jS3Wv9ZdR6FVVDopx1GrikUBWOBxAuzSsy7avDgTWwOxWcUyFO6s37KpB2yIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbBmmgWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9DC433F1;
	Sun, 24 Mar 2024 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321048;
	bh=A+Xsytz4MnzIXKoWB28lM3p54mT0uJ1kwuAxvS4h74I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbBmmgWzXxpkZIpfoXja7RoH0LyRXEBUI7YFXb8/faXu873KF2nK53UHzUtTHhRnY
	 OPa/8R0RTl0dNLJf7dYtb3pwfl6TYKC0ey1AI4eXcqwyNws9R+i7NjZ8qSzZ9DilWf
	 F28G1aWcxn0Sy5mpJUpXVsga+iFtZNlCA5A2tjsO0lQ2CMk7J/RLk0lhqwnqu+KGaC
	 T1JoDn+U4ma1SiZp3RQugiVTrbbl6Di+mrVHnvwkmheT6/KZD91HGocuilK1yVBxmF
	 ZkjpYi+AUIqeyS/THntaiIV1UDU+vEZFMWCThA2icEaKewHWhvJKpI1aua8vE9p28m
	 pozqSZMGvi31w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Helge Deller <deller@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 611/713] bcachefs: Fix build on parisc by avoiding __multi3()
Date: Sun, 24 Mar 2024 18:45:37 -0400
Message-ID: <20240324224720.1345309-612-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@kernel.org>

commit eba38cc7578bef94865341c73608bdf49193a51d upstream.

The gcc compiler on paric does support the __int128 type, although the
architecture does not have native 128-bit support.

The effect is, that the bcachefs u128_square() function will pull in the
libgcc __multi3() helper, which breaks the kernel build when bcachefs is
built as module since this function isn't currently exported in
arch/parisc/kernel/parisc_ksyms.c.
The build failure can be seen in the latest debian kernel build at:
https://buildd.debian.org/status/fetch.php?pkg=linux&arch=hppa&ver=6.7.1-1%7Eexp1&stamp=1706132569&raw=0

We prefer to not export that symbol, so fall back to the optional 64-bit
implementation provided by bcachefs and thus avoid usage of __multi3().

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/bcachefs/mean_and_variance.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/mean_and_variance.h b/fs/bcachefs/mean_and_variance.h
index 647505010b397..056e797383fb5 100644
--- a/fs/bcachefs/mean_and_variance.h
+++ b/fs/bcachefs/mean_and_variance.h
@@ -14,7 +14,7 @@
  * type
  */
 
-#ifdef __SIZEOF_INT128__
+#if defined(__SIZEOF_INT128__) && defined(__KERNEL__) && !defined(CONFIG_PARISC)
 
 typedef struct {
 	unsigned __int128 v;
-- 
2.43.0


