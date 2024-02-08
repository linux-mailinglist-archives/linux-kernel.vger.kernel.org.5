Return-Path: <linux-kernel+bounces-57325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A484D706
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8252B229BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5B364A9;
	Thu,  8 Feb 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9sVfPBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81636102;
	Thu,  8 Feb 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351312; cv=none; b=Qvz8t7EtJCE93gEQKT1WgWH8UidqvDAhgbpricQFyq1/GCbe850NVH4zmgymfCUN5VljUPvLKL4m3tWsdSnXrKtkMvAhwiDmY1MhcB+VRTSui0uvu40/PJ6Jub9YipB7jzS+7FGtKrXUgtZg2ND1FQ5dY8h9bYJXGuM2zzNYHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351312; c=relaxed/simple;
	bh=gv2syl8soBeiqh7QJH+tsCZ+2ZB+BManKyNhoDBSrmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITEKk77LToqWkJz+q8YW5XMrkODDrFtHAEPRPNhCZgGUOng1eIiiX+rdfQhhOTZWVhkaimz0fzk7EuuA+oe4a8BDYp+IvCxCvuysUV50sxjN1Kly+nmABblE/7W0Y2DrmwNkgT6+dGuRUoH7NN95A6mCSqoAG4rju0MZxMw8x3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9sVfPBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D7C433C7;
	Thu,  8 Feb 2024 00:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351311;
	bh=gv2syl8soBeiqh7QJH+tsCZ+2ZB+BManKyNhoDBSrmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C9sVfPBsK3DQBpnrNPYihu45yaQ81e7XZRipzRtD7VWptiVbTgYsSZYOn8fSSFpYK
	 XOUPKsEzfCNErrVYHBrIst/SYtSOTM/fv1baIOcbcFqhYHqt89CoJpvzH1ZufEQz8P
	 W0r2zqTCNKUVMmMYmJkDLvLwimY2uDWtWPCnNRj7b51/01b6rAfby4mJD4s9Zazvuc
	 vKuMypNK+BTifT3EstIIm9T6D11G37CmCwTwj9KFKE6Daanf+S33YSderN4HUy3is5
	 YECM2wca5BYpWJuEL7DvQ2Gip/Zu3E9yo7l9pW0/qRkSVeT5haqxbh5exSyoC6D/3x
	 P+LxX6xXZ7Fig==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:15:00 -0700
Subject: [PATCH 08/11] s390/boot: vmlinux.lds.S: Handle ELF required
 sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-8-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gv2syl8soBeiqh7QJH+tsCZ+2ZB+BManKyNhoDBSrmQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZDnmX6rx77twx2bHR/euFdJz7dvvG57MUb93/Hv5J
 LVnwjw/O0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBETrYx/M8V+JHtUdp8esey
 wv8vUxTvM/5peZxfo9O07pySkrKwx09Ghv/qN15oah/qPR7SybG8hyf9wI55vo5Wew7dX3N1Zee
 XX2wA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there is a warning around the '.comment'
section for each file in arch/s390/boot

  s390-linux-ld: warning: orphan section `.comment' from `arch/s390/boot/als.o' being placed in section `.comment'
  s390-linux-ld: warning: orphan section `.comment' from `arch/s390/boot/startup.o' being placed in section `.comment'
  s390-linux-ld: warning: orphan section `.comment' from `arch/s390/boot/physmem_info.o' being placed in section `.comment'

include/asm-generic/vmlinux.lds.h has a macro for required ELF sections
not related to debugging named ELF_DETAILS, use it to clear up the
warnings.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/boot/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 83af17bfe630..2bef450e84e9 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -123,6 +123,7 @@ SECTIONS
 	_end = .;
 
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	/*
 	 * Sections that should stay zero sized, which is safer to

-- 
2.43.0


