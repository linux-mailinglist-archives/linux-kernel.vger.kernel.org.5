Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607D7D6F71
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbjJYO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbjJYO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:26:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629810E3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:26:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab7badadeso6090564276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698243978; x=1698848778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6GAV3+HGX/GSuMk9leWi7r46JVl0NQ2JAhtg14sSj10=;
        b=uC+OcpNuVUcrcaigHU4roLYmXYrONduaPE/A7YesAErqV8JX5eb0ddpAcKj9dsjS1n
         GINsk4UipHmNxmY+sMyLDSaH9HyejG0y9twMSOEjYMvaiit3XahrrhNEYSpZ8QKB57w3
         0OK7seifXAJs0qZER7QoKNHxNcQnHDehniyiQQRHBw5ZdCa0j2vSQvBFwMuWmmhVcOLl
         G7pmjPB74kd1e/OEyPC0TI1trHSM86Wpy6WOMa2ePGQ50++rdieGSk+mu6YXPcY7hwmU
         RjC5urbynxAi3AabwmmQz7CLCxmMtZXRilvVAF3iPpcVx/Q9fPinWbfKhK3EnpnGi2cW
         6xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243978; x=1698848778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GAV3+HGX/GSuMk9leWi7r46JVl0NQ2JAhtg14sSj10=;
        b=u+Uf5YnXSqp7E/Soixe92vXheAkRxeQ76Ddo00H3tbmxMKsY96CHadSBaJQElQoExT
         IPmmaIo4okAO5TbxFVncJwcRBpE6iPVLABcZl5duanPimEJgaqS6vG0C9K7CY+dfZGbY
         72IIo8IOrynB4YyBU9XxsAha7TCEwvmpjKmDfRRiMfU2vMpmN7JRRNdZqw1LCO/7mDTy
         mi2hWwPLssvQcPUcwIRYqgycickpP6S13UQ7e6JeVPj0lR8b6l/uKsqFHA+5nVUo3ps9
         bimaPNZ2CVjzCepS/64s+uEXQE7dDEhRCRSnbTah9E0+5ro+6MS0QL46N54psSzkkYpZ
         0LDw==
X-Gm-Message-State: AOJu0YzS00nIjaPXGFH+o/E4NxwOO5kK86flTwZMwZnULRvBb/smvIVC
        POg21/aCqppAvxUrNiFi75b+jtl6EaWGTEqkDTWv
X-Google-Smtp-Source: AGHT+IE8qkvhuHEwCdG/rkr7SGSR29nrcqu5lQD4EekiOS30hAPsOqt/pFLDJJUCH+3QM6yXxRXicgLxuBeYUP5/b+hv
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:211:0:b0:d9a:c3a2:48a3 with SMTP
 id 17-20020a250211000000b00d9ac3a248a3mr285649ybc.6.1698243978033; Wed, 25
 Oct 2023 07:26:18 -0700 (PDT)
Date:   Wed, 25 Oct 2023 19:56:09 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025142609.2869769-1-vamshigajjela@google.com>
Subject: [PATCH v2 3/3] serial: core: Update uart_poll_timeout() function to
 return unsigned long
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

The function uart_fifo_timeout() returns an unsigned long value, which is
the number of jiffies. Therefore, the function uart_poll_timeout() has been
modified to use an unsigned long type for timeout values instead of an int
and to avoid truncation.
The return type of the function uart_poll_timeout() has also been changed
from int to unsigned long to be consistent with the type of timeout values.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v2:
- unsigned long instead of unsigned int
- added () after function name in short log
- updated description
 include/linux/serial_core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..6916a1d7e477 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -773,9 +773,9 @@ static inline unsigned long uart_fifo_timeout(struct uart_port *port)
 }
 
 /* Base timer interval for polling */
-static inline int uart_poll_timeout(struct uart_port *port)
+static inline unsigned long uart_poll_timeout(struct uart_port *port)
 {
-	int timeout = uart_fifo_timeout(port);
+	unsigned long timeout = uart_fifo_timeout(port);
 
 	return timeout > 6 ? (timeout / 2 - 2) : 1;
 }
-- 
2.42.0.758.gaed0368e0e-goog

