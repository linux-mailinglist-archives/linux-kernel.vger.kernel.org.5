Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF37F1337
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjKTM1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjKTM1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:27:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A67CF;
        Mon, 20 Nov 2023 04:27:11 -0800 (PST)
Date:   Mon, 20 Nov 2023 13:27:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700483229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/cY+RY1YVzUDclWx9uz/wxDq9v1nRedydgbaA0a/ho=;
        b=gj6AAFabnVDtefjVpmr8sMORavTzGOAyvFroEo76uWKxkVTEXHU3sFpS4LeU4maHO0wtMU
        2l6Q4NIH82RPa/adyoo0LRPkNaQFJPBlevscq4jshfjiEgwZ2OuqHVAeZHCiup4ejjfdc4
        m7ha8nx8flgy7sB6xhuCJTBvsGUHtbfrHjrwXFwOQCcVXfWCl7i9tIScwhRuNzNO4JkD4e
        j1W5YYtTaY5kqcf0ZCeVitvLWs2sCJkcxDufy0tQlHDa8egv8+dJrqJIByw+ErUjf3+SCs
        ufb2i648ndxdr3mF6MAraAgXrEa6Yo7VSc773QLxd+NcUZBjN9WnZBgbRrpjlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700483229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/cY+RY1YVzUDclWx9uz/wxDq9v1nRedydgbaA0a/ho=;
        b=y3wd1+sSGCWCkx4wzVN+jtlDteO0Nv5rh4YeArH5GW93aoZtBT8o/XyevipOY79aNyLzLA
        ihI/+K0hvveWH3Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        francesco.dolcini@toradex.com
Subject: Re: [ANNOUNCE] v6.6-rt13
Message-ID: <20231120122708.UxA5Wf4b@linutronix.de>
References: <20231108152329.NDcgOQAF@linutronix.de>
 <ZVJ0B9HYLTsLxxXw@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVJ0B9HYLTsLxxXw@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-13 20:07:51 [+0100], Francesco Dolcini wrote:
> Hello Sebastian, hello John
Hi,

> During our weekly CI tests of rt-devel branch we noticed that commit
> 78f4b59c6faa ("printk: Update the printk series.") breaks booting on
> multiple NXP i.MX platforms (arm and arm64), likely related to
> drivers/tty/serial/imx.c.
> 
> We are not planning any additional investigation at the moment and
> we have no debug outputs to share, just wanted to give you a head-up.

Thank you for the report.
As it turns out, the new bits never saw the lights of a 32bit machine.
The following hunk should fix it:

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index a949d02fbd174..b6a8306bfda89 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1477,7 +1477,10 @@ static inline u64 __ulseq_to_u64seq(u32 ulseq)
 	 * sequence. It needs to be expanded to 64bit. Get the first sequence
 	 * number from the ringbuffer and fold it.
 	 */
-	seq = rb_first_seq - ((u32)rb_first_seq - ulseq);
+	if (rb_first_seq == 0)
+		seq = ulseq;
+	else
+		seq = rb_first_seq - ((u32)rb_first_seq - ulseq);
 
 	return seq;
 }


> Francesco

Sebastian
