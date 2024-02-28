Return-Path: <linux-kernel+bounces-85145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FED86B115
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D08D1F220EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA615696C;
	Wed, 28 Feb 2024 14:00:24 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E215098D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128823; cv=none; b=IWdj8EvukAT6UQhVQnQ1eY4MG4TLOByf2JScXvLj8gxiIN9LbnmPEuCg/qkPnfbMp2LmJxIGS88YRerLOEnaZE8iGg8boL2iKDKgu3CN9h+LvE0KYb3J1/w5lKbUy14qdVW4677OOf5Zwk94HScFnQM/1Yi3YwhG0phEtHJWtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128823; c=relaxed/simple;
	bh=G6EOV4ZQQfHL4BuKa3yWbKTAxpwYG330vI+JSSZwK9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kf28Haelumbg+BwDNBpt039IlotigW7PMejILbpSEYZGReGSczFWH+ZkHI96SlBvOU4WX5u8ZehXaTDVkBwG5A6TCk7Y5BvN/55T1ge17aYscSnF9ZDDPdl55vSHEYflIkjS3zzJLFb5cDzVkmuj9JEyLLYmUMW4Z7Czi2LYpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:48c4:26a9:d9ec:22cb])
	by laurent.telenet-ops.be with bizsmtp
	id se072B0034gWvPH01e07CA; Wed, 28 Feb 2024 15:00:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTV-001tZ9-DK;
	Wed, 28 Feb 2024 15:00:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTe-006hl9-S8;
	Wed, 28 Feb 2024 15:00:06 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Chris Down <chris@chrisdown.name>,
	Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jessica Yu <jeyu@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] printk: Let no_printk() use _printk()
Date: Wed, 28 Feb 2024 15:00:02 +0100
Message-Id: <56cf92edccffea970e1f40a075334dd6cf5bb2a4.1709127473.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709127473.git.geert+renesas@glider.be>
References: <cover.1709127473.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printk-indexing is enabled, each printk() invocation emits a
pi_entry structure, containing the format string and other information
related to its location in the kernel sources.  This is even true for
no_printk(): while the actual code to print the message is optimized out
by the compiler due to the always-false check, the pi_entry structure is
still emitted.

As the main purpose of no_printk() is to provide a helper to maintain
printf()-style format checking when debugging is disabled, this leads to
the inclusion in the index of lots of printk formats that cannot be
emitted by the current kernel.

Fix this by switching no_printk() from printk() to _printk().

This reduces the size of an arm64 defconfig kernel with
CONFIG_PRINTK_INDEX=y by 576 KiB.

Fixes: 337015573718b161 ("printk: Userspace format indexing support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/printk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1ed2ec..e4878bb58f663370 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -126,7 +126,7 @@ struct va_format {
 #define no_printk(fmt, ...)				\
 ({							\
 	if (0)						\
-		printk(fmt, ##__VA_ARGS__);		\
+		_printk(fmt, ##__VA_ARGS__);		\
 	0;						\
 })
 
-- 
2.34.1


