Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8F7C95DC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjJNSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 14:13:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654BBCC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:13:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a39444700so3606813276.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697307219; x=1697912019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rKyrhxaGZv0nPLnMXbvJXkiVEGuU/Lq6wP9rgM/Alfg=;
        b=u/yYNOojuWmJosMmEwVDzzax7C8pIpjeMNn6ObQ2JFgunKX5fe3pJvQUIhHaq3wXfx
         muDTEoWT32bmlJ0SmlSdQjj4DayGooJQ6F1X/SZv0NLDdmcbCb1lyRWbVsEyOz1RWE1Z
         /5e83rH3pztsq+OrAwowSsXxvfydaRQOUAKDex/lwj2iwlzODSKDhM1myiOOlt0XTzBt
         gR/qxsCJCPcbObAYBnc3ECzKuxca/dwcoUcoOENHJOoXOSZtHhsKaGZIDVFX0alEXYx5
         3FI5Omjd7jEhF/5ukmATWtr67wQgkI/sd3bcLNm+C5xKMwdcqcA5lAodoPOYzxswrBKL
         ASCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697307219; x=1697912019;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKyrhxaGZv0nPLnMXbvJXkiVEGuU/Lq6wP9rgM/Alfg=;
        b=WfrchimKrQJVw12wIye9Fl2jphOSTMQAezY8PM19vDI7pusHai6lwP/TSHAfCW3sUq
         VL9Wv1FzymaAc1aYT7BMbvgXJzDOpMRj55V1E3YKnW53hi7v6Myn2UlqdjERADGwChIT
         8hoT4pFhw9UlTQrWfMt9y4EodGSa2ZbzkzNzCB6aYrYN5c7Bx90aI7OHrFQxyr+P9qgK
         g5hRoZa4YFrWwK6qPc3+EP0f3R/z5rRtfN0/AwaJBPWChbK95MYC52dF+hOXOX+MkvvZ
         nY/M1xVU3hIZNIatOgkUx+nrmig9TlNXP7HxxJGarS7pqDraUmPip9z1wNGrU+TFsn5z
         clrg==
X-Gm-Message-State: AOJu0Yw9c3uY4wu3naunuP8l2FlDCQ90nyac7ukMjkOqwbyIulvbsScy
        vvuhNfQce76FBpFvwNLiamggrr2KP2Vjt6rMMRJJ
X-Google-Smtp-Source: AGHT+IH0MJExwfauji0fzv9X3e2ja5LOFD5TgaDDRwSxh/LV1XA12gw16CrCrlDxSl0RHLgxPKVAr43tr6sACN2TaXH5
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:d748:0:b0:d89:cd65:c2b0 with
 SMTP id o69-20020a25d748000000b00d89cd65c2b0mr95600ybg.6.1697307219523; Sat,
 14 Oct 2023 11:13:39 -0700 (PDT)
Date:   Sat, 14 Oct 2023 23:43:33 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014181333.2579530-1-vamshigajjela@google.com>
Subject: [PATCH v2 1/3] serial: core: Potential overflow of frame_time
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

uart_update_timeout() sets a u64 value to an unsigned int frame_time.
While it can be cast to u32 before assignment, there's a specific case
where frame_time is cast to u64. Since frame_time consistently
participates in u64 arithmetic, its data type is converted to u64 to
eliminate the need for explicit casting.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v2:
- use DIV64_U64_ROUND_UP with frame_time

 drivers/tty/serial/8250/8250_port.c | 2 +-
 include/linux/serial_core.h         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 141627370aab..d1bf794498c4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
 			 * rather than after it is fully sent.
 			 * Roughly estimate 1 extra bit here with / 7.
 			 */
-			stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);
+			stop_delay = p->port.frame_time + DIV64_U64_ROUND_UP(p->port.frame_time, 7);
 		}
 
 		__stop_tx_rs485(p, stop_delay);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..b128513b009a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -558,7 +558,7 @@ struct uart_port {
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
-	unsigned int		frame_time;		/* frame timing in ns */
+	unsigned long		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
 	const struct uart_ops	*ops;
 	unsigned int		custom_divisor;
@@ -764,7 +764,7 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
  */
 static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 {
-	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
+	u64 fifo_timeout = READ_ONCE(port->frame_time) * port->fifosize;
 
 	/* Add .02 seconds of slop */
 	fifo_timeout += 20 * NSEC_PER_MSEC;
-- 
2.42.0.655.g421f12c284-goog

