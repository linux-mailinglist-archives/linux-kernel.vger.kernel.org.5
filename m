Return-Path: <linux-kernel+bounces-57319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E597F84D6F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236C41C21F34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6918E25;
	Thu,  8 Feb 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA8+DiPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7611737;
	Thu,  8 Feb 2024 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351307; cv=none; b=VG8WUEPxPj3Ap++ObRmK8kP8vEan+2KiapcKryBDqeMXeziSz9y2g6zzG6J+qui9XLskqpeglg+MLxJnEJRTiXASz7xo/wcGinlW4/gZJ0M4dCgu9lI74lHXRtP4wYZEjfb+DboeqjuV4KfJLNQOQbNiv9iO0bVATAqErGanZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351307; c=relaxed/simple;
	bh=6nAKdBNVuZF6DFmdTWgdfLbT5YqqyFnTFc0PCtVc7no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aed9/sqDfBgUxNqUMQu1eNthBg7QpVKb28aFREA9vOFZ7hMajPWC03lAqhnw4ltuN+t1C7RFfXRKeK4hsbS1onjwIQk7FVo3lpcF0pIKbVN1Vc+HCsXKzvkydCcTCRlpiFD8coG2olNYgQv1u0LztQWcp9LMqVo8BTpoy/IiWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA8+DiPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF00C43390;
	Thu,  8 Feb 2024 00:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351306;
	bh=6nAKdBNVuZF6DFmdTWgdfLbT5YqqyFnTFc0PCtVc7no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hA8+DiPeT/iFERysdie6DstYmrI9RLIi4uno7/7MHM7nN4UbKGNJKnQO+dZZC/880
	 DHYZUF3G99zPgvKkQH3fHozWRfeG4D4DsdsRX1CIAUoWcPIb/9oa1S0XaJsU6UI7rA
	 Gs8JiXKB59Q2L9f8YYV+skGAnOHpscgIV1UwEPgAa7srpgzVx0/V37whlcFpyuuFUP
	 EjSJNuv9KTBhNowf4mWyqt91yyCNhVzGZW1Gwig13XbxDkaENe+pA7tbdPDjfKOp7k
	 cqJIu3nqW8tLY+QO5+Y/hcjIiofSq6ctuFfJVFxyUJ8CdWzZBpMuS66cdvOdKY0v8M
	 FIqFC9JeY1i6g==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 07 Feb 2024 17:14:54 -0700
Subject: [PATCH 02/11] s390: vmlinux.lds.S: Handle '.data.rel' sections
 explicitly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-s390-lld-and-orphan-warn-v1-2-8a665b3346ab@kernel.org>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, maskray@google.com, 
 ndesaulniers@google.com, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1553; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6nAKdBNVuZF6DFmdTWgdfLbT5YqqyFnTFc0PCtVc7no=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKlHZNlZeKPWHj3bsmm32I7tbALmN07censyX3bNjiXbD
 3+7/upVbUcpC4MYF4OsmCJL9WPV44aGc84y3jg1CWYOKxPIEAYuTgGYyHx3RoajEy4uKhV5rt6X
 nc/pb7THm9GsQzKjtjb6RqCM69SpP48z/C/cZPA3rjlmv4m4jvvj6LfSRlvj5u1u+3PGoXutawJ
 DBzcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are a lot of warnings around
'.data.rel' sections:

  s390-linux-ld: warning: orphan section `.data.rel' from `kernel/sched/build_utility.o' being placed in section `.data.rel'
  s390-linux-ld: warning: orphan section `.data.rel.local' from `kernel/sched/build_utility.o' being placed in section `.data.rel.local'
  s390-linux-ld: warning: orphan section `.data.rel.ro' from `kernel/sched/build_utility.o' being placed in section `.data.rel.ro'
  s390-linux-ld: warning: orphan section `.data.rel.ro.local' from `kernel/sched/build_utility.o' being placed in section `.data.rel.ro.local'

Describe these in vmlinux.lds.S so there is no more warning and the
sections are placed consistently between linkers.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/s390/kernel/vmlinux.lds.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index e32ef446f451..d231a3faf981 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -59,6 +59,9 @@ SECTIONS
 	} :text = 0x0700
 
 	RO_DATA(PAGE_SIZE)
+	.data.rel.ro : {
+		*(.data.rel.ro .data.rel.ro.*)
+	}
 
 	. = ALIGN(PAGE_SIZE);
 	_sdata = .;		/* Start of data section */
@@ -73,6 +76,9 @@ SECTIONS
 	__end_ro_after_init = .;
 
 	RW_DATA(0x100, PAGE_SIZE, THREAD_SIZE)
+	.data.rel : {
+		*(.data.rel*)
+	}
 	BOOT_DATA_PRESERVED
 
 	. = ALIGN(8);

-- 
2.43.0


