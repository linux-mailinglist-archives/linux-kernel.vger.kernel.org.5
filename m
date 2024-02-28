Return-Path: <linux-kernel+bounces-85143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678DC86B113
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BC8287FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159491552E8;
	Wed, 28 Feb 2024 14:00:24 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3F2D04A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128823; cv=none; b=RWhCsJdl1MYmHTFM7MxoAjw1xjx1VoLLXzmjQueXkeZplXBw8a6xM6vhU/8jB4Z6W0499mN7UWI5/+3XjoHpPX2dITRtbXEAJ7wbUUBcuh/asY2+AY4hgLtvsAzIS4W+Yhg8F8c4QdgVIaLSMGKbaDGZi/PQCVvG3hzbQMZNn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128823; c=relaxed/simple;
	bh=OptXvw4/U98wPjo3qpndC/2qRbg6m70hWO/2XjYxTbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IfHXHt5o0xntDkBHOj811yxnVAE/3zsJRvlOSIR8Y1A1AoP2Wxao3Mr9NOow9GEJP9oTayVDGKTHol8SA6z6/o20kFR3/LMuAXz78ETgxeyVR3nIDv7P5oBx+pvgqwJW3zZJys89mqVNBmqDYxu0MD6W7jZT/bi7Iyd2Oif+j0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:48c4:26a9:d9ec:22cb])
	by andre.telenet-ops.be with bizsmtp
	id se072B0064gWvPH01e07Yl; Wed, 28 Feb 2024 15:00:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTV-001tZA-DK;
	Wed, 28 Feb 2024 15:00:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTe-006hl6-RM;
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
Subject: [PATCH 0/4] printk_index: Fix false positives
Date: Wed, 28 Feb 2024 15:00:01 +0100
Message-Id: <cover.1709127473.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

When printk-indexing is enabled, each printk() invocation emits a
pi_entry structure, containing the format string and other information
related to its location in the kernel sources.  This is even true when
the printk() is protected by an always-false check, as is typically the
case for debug messages: while the actual code to print the message is
optimized out by the compiler, the pi_entry structure is still emitted.
Hence when debugging is disabled, this leads to the inclusion in the
index of lots of printk formats that cannot be emitted by the current
kernel.

This series fixes that for the common debug helpers under include/.
It reduces the size of an arm64 defconfig kernel with
CONFIG_PRINTK_INDEX=y by ca. 1.5 MiB, or 28% of the overhead of
enabling CONFIG_PRINTK_INDEX=y.

Notes:
  - netdev_(v)dbg() and netif_(v)dbg() are not affected, as
    net{dev,if}_printk() do not implement printk-indexing, except
    for the single global internal instance of __netdev_printk().
  - This series fixes only debug code in global header files under
    include/.  There are more cases to fix in subsystem-specific header
    files and in sources files.

Thanks for your comments!

Geert Uytterhoeven (4):
  printk: Let no_printk() use _printk()
  dev_printk: Add and use dev_no_printk()
  dyndbg: Use *no_printk() helpers
  ceph: Use no_printk() helper

 include/linux/ceph/ceph_debug.h | 18 +++++++-----------
 include/linux/dev_printk.h      | 25 +++++++++++++------------
 include/linux/dynamic_debug.h   |  4 ++--
 include/linux/printk.h          |  2 +-
 4 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

