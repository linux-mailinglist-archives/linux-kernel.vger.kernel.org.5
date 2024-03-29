Return-Path: <linux-kernel+bounces-124589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C538891A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2AC2864F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561E157E64;
	Fri, 29 Mar 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLggrX5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A3130AC8;
	Fri, 29 Mar 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715477; cv=none; b=K8tVv/86EIJ0pxRAZFrAXcU1k1I57QhWqOuhSx3qfeWqMbJAKwTEAmxkEUcqX3OkXAlnhrCyz8mpLWG+tTTXEZ58NYOXoiN0W4swNpWSZlzmufI0or1zHE2jSKc08hxuu3zqsmWShqiTgcT1zx/NQnbxn+gS0B3WsGHwIG1A4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715477; c=relaxed/simple;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRnALQQ5gomqSHJj0qbOa6BYHP8tiIXN/F4cqB2Qg54k/z2rPJJmNFGgRRBDRBiMXhOs8xz9J5ztT5N5836yswn2IzF4i9c985yWoQnyXNK96kRsXZf7cqw7p69/+SwMeEGRwNRuGJ/IpJv2Sx6ehpM+r6VZoskIrh4PB8amuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLggrX5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459A8C433C7;
	Fri, 29 Mar 2024 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715477;
	bh=9/XAL1SYI5dLknafqQdBszisijdv3UzkDC/FsG7+PU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLggrX5GN7653gXp6LsedXOk95S+Rx9ZAYuHtgpfK/sbmNixkLSdugeLRWTI3IdEl
	 rw/oXHn1SUqWQzSkTHqnH3eHgSGYJo8+h7EEc1K4xFZ+ziB+QuyQe3xDNXhv5bjGSw
	 QvRcFavryZlG0JJVafReMO8VUkIT6jyazXpm45HEOWuqAF9y0GCPkn9gXMVHCt15Ju
	 EqHCiWskIsICDtCWEickEXlsDIQSiKcjbivBJetXTPGnd+tnxgnd93pHMDdr04d5J3
	 U1Pk+xe7WBn/+D6IuxgeNnVle4rH2YLk2WelMIrfuYOKIuXkp8+TQkB0yLQ4Z6EwAv
	 wXB2g5O2dgFBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	andreas@gaisler.com,
	masahiroy@kernel.org,
	guoren@kernel.org,
	rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 38/52] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 29 Mar 2024 08:29:08 -0400
Message-ID: <20240329122956.3083859-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]

The UBSAN instrumentation cannot work in the vDSO since it is executing
in userspace, so disable it in the Makefile. Fixes the build failures
such as:

arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 77d7b9032158c..cb046b9d1eddc 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 VDSO64-$(CONFIG_SPARC64)	:= y
 VDSOCOMPAT-$(CONFIG_COMPAT)	:= y
-- 
2.43.0


