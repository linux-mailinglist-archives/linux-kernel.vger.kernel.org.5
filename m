Return-Path: <linux-kernel+bounces-47952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C3D845520
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E02848DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE4815B961;
	Thu,  1 Feb 2024 10:20:41 +0000 (UTC)
Received: from gepdcl09.sg.gdce.sony.com.sg (unknown [121.100.38.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603AD4DA1D;
	Thu,  1 Feb 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.100.38.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782841; cv=none; b=uQPep8RJlPq0VKjUXYK1GvPZjT657cXvv7mkQ+GHY2KhABgfRvO31Dw3crvWXuHEQ0dLjpKx1lyFRgml6lKjdkMwnaNaSUY+dXDCdoFwdPMSmbp/brbiAUsGFG4FxIP6xzpyFzzVMczGLgf7Mnz4QQP8uDXjA/17ua9Ra+sp2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782841; c=relaxed/simple;
	bh=pYr5nSckZllMvDyVy8SYcl+YX0JIp0Bb40dbMDbdlLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AkBE7XAYpA8ZCR1LvD133gR4+sd/BFBWpBNyB4lvJoZIv7hPWICt7pMY806zXKfVVaHAeQsCN3xWYUIxz0xt/6/NH413YM3zIzUAF8MEzqTnmUocY7e+gpzAI19+xqRvUjhrycfzVbM4Cac5yQcqaJ3sSoU0qZ5b1nNPuv5isTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=121.100.38.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 411AJ2we009066;
	Thu, 1 Feb 2024 18:20:07 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 411AIUEB008473;
	Thu, 1 Feb 2024 18:18:30 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 9BD1820C1C49; Thu,  1 Feb 2024 15:46:57 +0530 (IST)
Date: Thu, 1 Feb 2024 15:46:57 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pmladek@suse.com
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v4 0/2] Add support to dump printk buffer to console via sysrq
Message-ID: <cover.1706772349.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch series enables one to dump the messages in printk ring
buffer unless all CPUs are locked up. This is useful to view the
kernel messages when terminal is unresponsive to enter commands
like dmesg and syslog services are also disabled, especially on
embedded targets. Although debug features like kdb/kgdb already
allow this, these debug configs should be enabled which is often
not the case.

Till the last version, kmsg_dump* interface was being used to
retrieve the messages in printk buffer before dumping them to
consoles. However, John Ogness pointed out the issue with
kmsg_dump* interface that it doesn't work well with extended
consoles. He suggested a new method to reuse the code in
console_flush_on_panic() but without disabling scheduling.

In the first commit, code under CONSOLE_REPLAY_ALL mode in
console_flush_on_panic() is taken out to a helper function
console_rewind_all() to set the console sequence numbder to
oldest record in the printk buffer. And the new function to
dump the buffer called dump_printk_buffer() calls this function
after taking the console lock and then releases the lock which
flushes out the contents of printk buffer to console.

In the second commit, code is added to call dump_printk_buffer()
function when sysrq+D is pressed. As the function may sleep,
it cannot be called from interrupt context. A work is queued
in the system unbound workqueue to call the function when
the key is pressed.

Links to previous discussion:
- https://lore.kernel.org/all/cover.1705331453.git.sreenath.vijayan@sony.com/T/#t
- https://lore.kernel.org/linux-serial/20231221133953.1507021-1-sreenath.vijayan@sony.com/

Changelog:
V3 -> V4:
- refactored code in console_flush_on_panic() under CONSOLE_REPLAY_ALL mode
- added helper function console_rewind_all()
- used console_rewind_all() instead of ksmg_dump*() in dump_printk_buffer()

V2 -> V3:
- split the implementation into two commits
- added function in printk.c to dump printk buffer to consoles
- added Suggested-by tag
- removed code to dump printk buffer from sysrq.c and called
new function

V1 -> V2:
- modified kernel ring buffer to printk ring buffer
- allocated buf dynamically to prevent stack frame size warnings
- used buf of size 2048 to match PRINTK_MESSAGE_MAX and added comment

-- Sreenath

Sreenath Vijayan (2):
  printk: Add function to dump printk buffer directly to consoles
  tty/sysrq: Dump printk ring buffer messages via sysrq

 Documentation/admin-guide/sysrq.rst |  2 +
 drivers/tty/sysrq.c                 | 20 +++++++++-
 include/linux/printk.h              |  4 ++
 kernel/printk/printk.c              | 61 +++++++++++++++++------------
 4 files changed, 62 insertions(+), 25 deletions(-)

-- 
2.43.0


