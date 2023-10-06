Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC37BB2F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjJFIWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJFIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:22:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118FEA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:22:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 03345210DB;
        Fri,  6 Oct 2023 08:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696580522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iZ5AXY/iSp6d7wOgYZVKff+q84bButyby83sf6JatSs=;
        b=Pv0DKj5sGoRI6RO2qotcGL2p6IWVp0d6yGUpXMLLN56qKiS1Nql+W/uk9q9cBxLYZdb6Fv
        0Fpz9cwjo1rWYuykovanKI1hFob8t5wMOyh80yg2px7ehNmz/2SBWVloIhLi6fj3NyyAg2
        3+Po2oNpwJ/DB5taR2pNDHBWhBNCYEE=
Received: from alley.nue2.suse.org (pmladek.udp.ovpn1.nue.suse.de [10.163.31.190])
        by relay2.suse.de (Postfix) with ESMTP id 417DD2C142;
        Fri,  6 Oct 2023 08:22:01 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Todd Brandt <todd.e.brandt@intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/2] printk: Reduce unnecessary wait times by pr_flush()
Date:   Fri,  6 Oct 2023 10:21:49 +0200
Message-Id: <20231006082151.6969-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of the patch
https://lore.kernel.org/r/20230929113233.863824-1-john.ogness@linutronix.de

Changes since v1:

  + Split reduction of the pooling time into separate patch.
  + Use jiffies to count the real sleeping time.

Note that my original POC counted jiffies spent in the entire cycle.
It would count also the time spent by console_lock() and by flushing
the legacy consoles in console_unlock().

The current version counts only the time spent by msleep(1) aka
the pooling interval.


John Ogness (1):
  printk: flush consoles before checking progress

Petr Mladek (1):
  printk: Reduce pr_flush() pooling time

 kernel/printk/printk.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

-- 
2.35.3

