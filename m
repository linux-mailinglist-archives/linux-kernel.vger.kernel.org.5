Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369CA7F181E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjKTQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjKTQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:04:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA8FAA;
        Mon, 20 Nov 2023 08:04:22 -0800 (PST)
Date:   Mon, 20 Nov 2023 17:04:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700496260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WKqQzIeywO1hvfth+6ySQhF90L42690B/kfCAgju+Qo=;
        b=Do/BxZ/Ebo1X8cURC/HOwj5jIcgVK+XKrKrdLMfS3Ezg5c6+qeqWoYgYe2h1wZhoYQoc7L
        u8aUUztug8VL8XL+LW4mbjThOeYTH8YwNH5aVAEK4lPhwaiDpY4v5yvszs9B1zFFR/Fpqj
        iyHmWOhSJOUalw55puOUYPQbPuR8PZJV7jxA8D7aik4g3pZnzKrnRquWLIE5ztvmFZJA4b
        zwgSL8xM4qIsgPgwT0d+ssLjpddHjrKmXNJor8HTqowGO/SPtl8f7vcqQPFnFi+xQMXwWv
        GvmD5oSWcJIIiOqBrj6ZfgWIW9PgsQcj+dwg/nwizuK+LNy5I8y2c3kHhevusw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700496260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WKqQzIeywO1hvfth+6ySQhF90L42690B/kfCAgju+Qo=;
        b=fLyuNXhQfxpQJWDwzYgKxOKbOIjlNTW5WS6o3ofneeGaTwMEk4KOCtGNwqc8J81pctPox7
        wvO9HNGv8a0R2GDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rt15
Message-ID: <20231120160419.1LtOExjP@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rt15 patch set. 

Changes since v6.6-rt14:

  - The printk update in v6.6-rt13 led to boot failures on 32bit
    platforms. This has been reported by Francesco Dolcini and the
    kernel test robot.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rt14-rt15.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rt15

The RT patch against v6.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rt15.tar.xz

Sebastian

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index a949d02fbd174..2b2a85222d19d 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1477,7 +1477,7 @@ static inline u64 __ulseq_to_u64seq(u32 ulseq)
 	 * sequence. It needs to be expanded to 64bit. Get the first sequence
 	 * number from the ringbuffer and fold it.
 	 */
-	seq = rb_first_seq - ((u32)rb_first_seq - ulseq);
+	seq = rb_first_seq - ((s32)((u32)rb_first_seq - ulseq));
 
 	return seq;
 }
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
