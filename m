Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F177EB0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjKNNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjKNNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:19:43 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09381AD;
        Tue, 14 Nov 2023 05:19:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 681CE40008;
        Tue, 14 Nov 2023 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699967976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1adG2pCQdrlIqa/Ui8p/cDDYSt28mMMCweJGLBFYJWU=;
        b=VSPco1j3fCKFQr9M4kS7BykKzTCBU6+7sD8kLLTUxRhvhfYNx8NB9umErCXmVrPtObkB77
        NvtckRZ7dMv8RGrfc0fmuqrccD1IVswYv172CB8napmAyV13fAIrjtD/KrEE7gvudAC0X1
        t9eQDEawlOlxd7T1nLynndlR9p6oe/mZOPsdd+9XvS6csa2KjfgJhrfir5P6+tzht2Q5iC
        jfGBP4+ib1SaDqwz/ZK4UtWs/8w+/nh9T9yLlPX2PIkD7V6oG2AcTWoHxF41dNBLCl4fzy
        jxNm9AyEJ1JFtaH7CvVGcK8GwzWktp0vbcH6wIRFpp0FyRnIYZIdXtHsawGVvQ==
Date:   Tue, 14 Nov 2023 14:19:34 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/vsprintf: Fix %pfwf when current node refcount
 == 0
Message-ID: <20231114141934.1b0d44e2@bootlin.com>
In-Reply-To: <ZVNyT6qTw6mpy6BY@smile.fi.intel.com>
References: <20231114110456.273844-1-herve.codina@bootlin.com>
        <ZVNyT6qTw6mpy6BY@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 15:12:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Nov 14, 2023 at 12:04:56PM +0100, Herve Codina wrote:
> > A refcount issue can appeared in __fwnode_link_del() due to the
> > pr_debug() call:  
> 
> >   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
> >   Call Trace:
> >   <TASK>
> >   ? refcount_warn_saturate+0xe5/0x110
> >   ? __warn+0x81/0x130
> >   ? refcount_warn_saturate+0xe5/0x110
> >   ? report_bug+0x191/0x1c0
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? prb_read_valid+0x1b/0x30
> >   ? handle_bug+0x3c/0x80
> >   ? exc_invalid_op+0x17/0x70
> >   ? asm_exc_invalid_op+0x1a/0x20
> >   ? refcount_warn_saturate+0xe5/0x110
> >   kobject_get+0x68/0x70
> >   of_node_get+0x1e/0x30
> >   of_fwnode_get+0x28/0x40
> >   fwnode_full_name_string+0x34/0x90
> >   fwnode_string+0xdb/0x140
> >   vsnprintf+0x17b/0x630
> >   va_format.isra.0+0x71/0x130
> >   vsnprintf+0x17b/0x630
> >   vprintk_store+0x162/0x4d0
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? try_to_wake_up+0x9c/0x620
> >   ? rwsem_mark_wake+0x1b2/0x310
> >   vprintk_emit+0xe4/0x2b0
> >   _printk+0x5c/0x80
> >   __dynamic_pr_debug+0x131/0x160
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   __fwnode_link_del+0x25/0xa0
> >   fwnode_links_purge+0x39/0xb0
> >   of_node_release+0xd9/0x180
> >   kobject_put+0x7b/0x190
> >   ...  
> 
> Please, do not put so many unrelated lines of backtrace in the commit message.
> Leave only the important ones (the Submitting Patches document suggests some
> like ~3-5 lines only).

Ok, I will remove some of them.

Best regards,
Hervé
