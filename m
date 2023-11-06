Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494857E2E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjKFVHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A3A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:34 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CxVp08tt1OIa0s48HQ/tV2mA7uFrK13yA3t6gp6F8Fc=;
        b=jX771zxVFdlvVT+BMuix58PggzwWZyGU9AIk+3z4/LqF/wPMLqLYEbiU1DOrt9xuBXxC6f
        z8fYDP2sz69xCP4lJqziAhnOMwByPKVqGAjWRXER2jgvP+KtRtr7v6zC+j1e6+mbphvnUC
        D7JWChOti4SIsRSGa2sRt7v+2EZ0eAHPLDM04PRpRqxCHFBs4cAnKwcj8f06/1Zrj7aZG8
        uV0qZ+Z+VjiB4fx09ReeigXF58dQ34aAQyyCeELWWvI6iWx4k5kOjwQ+Ack+UMJycWBgs/
        wG4k657yyHeJEj+yKzlzwq6MESIPjgY2RlIeBxcFcFssqRq3ltuvE5VilkfvCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CxVp08tt1OIa0s48HQ/tV2mA7uFrK13yA3t6gp6F8Fc=;
        b=E4vluTwmVBlSkyUSiU/AeV5YY09slGF2UYdYAxjL6d3xdgCqg03VFul74xmexa+Q/G7mfs
        VRdeJvuxHmY9nECg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH printk v2 0/9] fix console flushing
Date:   Mon,  6 Nov 2023 22:13:21 +0106
Message-Id: <20231106210730.115192-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing various flushing scenarios, I stumbled on a
couple issues that cause console flushing to fail. While
discussing the v1 [0] series, a couple more issues arose.
This series addresses all the issues:

1. The prb_next_seq() optimization caused inconsistent return
   values. Fix prb_next_seq() to the originally intended
   behavior but keep an optimization.

2. pr_flush() might not wait until the most recently stored
   printk() message if non-finalized records precede it. Fix
   pr_flush() to wait for all records to print that are at
   least reserved at the time of the call.

3. In panic, the panic messages will not print if non-finalized
   records precede them. Add a special condition so that
   readers on the panic CPU can drop non-finalized records.

4. It is possible (and easy to reproduce) a scenario where the
   console on the panic CPU hands over to a waiter of a stopped
   CPU. Do not use the handover feature in panic.

5. If messages are being dropped during panic, non-panic CPUs
   are silenced. But by then it is already too late and most
   likely the panic messages have been dropped. Change the
   non-panic CPU silencing logic to restrict non-panic CPUs
   from flooding the ringbuffer.

This series also performing some minor cleanups to remove open
coded checks about the panic context and improve documentation
language regarding data-less records.

Because of multiple refactoring done in recent history, it
would be helpful to provide the LTS maintainers with the proper
backported patches. I am happy to do this.

The changes since v1:

- Rename NO_LPOS to EMPTY_LINE_LPOS.

- Add and cleanup documentation to clarify language regarding
  data-less records and special lpos values.

- Implement a new prb_next_seq() optimization to preserve the
  intended behavior. This is essentially my rfc [1] with
  memory barriers added and based on an alternate implemenation
  suggested by pmladek [2].

- Introduce new prb_next_reserve_seq() function to return the
  sequence number after @head_id.

- Use prb_next_reserve_seq() instead of prb_next_seq() for
  pr_flush().

- Implement dropping non-finalized records in panic within
  _prb_read_valid() instead of printk_get_next_message(). This
  also makes use of the new prb_next_reserve_seq().

- Use the alternate implementation from pmladek [3] to avoid
  the handover feature in panic.

- Implement a new strategy to avoid dropping panic messages
  when non-panic CPUs are flooding the ringbuffer.

John Ogness

[0] https://lore.kernel.org/lkml/20231013204340.1112036-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20231019132545.1190490-1-john.ogness@linutronix.de
[2] https://lore.kernel.org/lkml/ZTkxOJbDLPy12n41@alley
[3] https://lore.kernel.org/lkml/ZS-r3QnpKzm7UVip@alley

John Ogness (8):
  printk: ringbuffer: Do not skip non-finalized records with
    prb_next_seq()
  printk: ringbuffer: Clarify special lpos values
  printk: For @suppress_panic_printk check for other CPU in panic
  printk: Add this_cpu_in_panic()
  printk: ringbuffer: Cleanup reader terminology
  printk: Wait for all reserved records with pr_flush()
  printk: Skip non-finalized records in panic
  printk: Avoid non-panic CPUs flooding ringbuffer

Petr Mladek (1):
  printk: Disable passing console lock owner completely during panic()

 kernel/printk/internal.h          |   1 +
 kernel/printk/printk.c            | 108 ++++++----
 kernel/printk/printk_ringbuffer.c | 343 +++++++++++++++++++++++++-----
 kernel/printk/printk_ringbuffer.h |  21 +-
 4 files changed, 382 insertions(+), 91 deletions(-)


base-commit: b4908d68609b57ad1ba4b80bd72c4d2260387e31
-- 
2.39.2

