Return-Path: <linux-kernel+bounces-127378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72722894A76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4601C21D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67AF25575;
	Tue,  2 Apr 2024 04:27:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4F22EF5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032035; cv=none; b=uyg+T+k15jabUbn0ME9JcWNT/oea1li5NjER/OzX4qbo1Q0dYt6Z5bXdpGXYRTYB8mhCH3ZDmNL2ke6FZHWClQI1oQZAU+feOETkYbednLN1fYUv9zJvM2TmVxfM2Hz4qw4BcMIvAADEmh8M4mAFxamHZ35ZwbLqdq2CV8Pwix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032035; c=relaxed/simple;
	bh=lSW13NGJJXxClBAaIkWczcBn6Ms9t17pAJm4tiVM1OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZQPZ7B2CLsov4cqNrb7qPD9/ATkJgFi6n0XFGlh0wV0RrzqS2yD0LZV6AxrV5mNmhC2ncM88jbpjIsAyNlL1yGnetaj1LOUzl+lU6MTHf/QsyClu5Xax06RPniqHRrfDdZrznsrKeYZNp5u/H53FG0vH4JgiVvpmuRBtmmMSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD38C433C7;
	Tue,  2 Apr 2024 04:27:14 +0000 (UTC)
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>
Subject: [PATCH 7/8] parisc: add missing export of __cmpxchg_u8()
Date: Tue,  2 Apr 2024 00:28:34 -0400
Message-Id: <20240402042835.11815-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402042835.11815-1-viro@zeniv.linux.org.uk>
References: <20240402041138.GF538574@ZenIV>
 <20240402042835.11815-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__cmpxchg_u8() had been added (initially) for the sake of
drivers/phy/ti/phy-tusb1210.c; the thing is, that drivers is
modular, so we need an export

Fixes: b344d6a83d01 "parisc: add support for cmpxchg on u8 pointers"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/kernel/parisc_ksyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 6f0c92e8149d..dcf61cbd3147 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -22,6 +22,7 @@ EXPORT_SYMBOL(memset);
 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
+EXPORT_SYMBOL(__cmpxchg_u8);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
-- 
2.39.2


