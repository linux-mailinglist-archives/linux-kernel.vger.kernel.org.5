Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1177D8405
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbjJZN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjJZN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:56:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660FBD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:56:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af592fed43so1755507b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698328596; x=1698933396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y4G5FMWajl/F1bjn3WpqChw5dodQuAFRVzNXYVASYSI=;
        b=VSvoXAH7++daBy6NrFerw+gKsLPPwo4kNGmhNln4C8ky04h4BmcIle4+KWNx8AQdIf
         hBLz1LeVcbS1VLBX5vVbdLi25u7Fx6T/OSlcN1bl5/L00aHKSF5ESFc1ATOELpoGuhe+
         McR7wwtprYfW11apDvQTZ9qpiN1xN+P46mG0DyWgd+RW6v/sIB9gF+RjMqALrAXoEy5W
         tnwyPgMS3NY59S0EtdDML7KJb9t50Z+cyt305PU5JSaudP1Pn0JDk7IRGzHzgyTlT+ad
         iCTFBfCaApAc18NMLKC/4odM0L0ichbOSVInb6XU3X5flqbp8xr1WnwlfZw9gn0gPHQh
         Gvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328596; x=1698933396;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4G5FMWajl/F1bjn3WpqChw5dodQuAFRVzNXYVASYSI=;
        b=RiuTRuo8XZuNY3pK6oyM0z29CoVwrS8iENdASC7+NYh8rMUGuF9a/a9a+XfF8uqtXQ
         TD1MnAhHvBnBrRPDTUIZZJt9U9fa/nOm+Mr8VeI0h0fMljFS1rQ5ER0QwkWF+YP+0Opv
         jlT1EJNplXGMXfDf/1IZ7fTSGbEolMipivDtq0mH3QLv0UdDcMc5vmKQFqtbq+yN1iZV
         hRK2RAhJUvQHuXBmk5lfXxJulXtY890weHCrgTifyqIrNyX2yAiRLB6rbQiiK+P4SPqf
         Vqv8n1KKUXw5q8XKox0AZxrM8p4xC6mQJPxbh7Oe9gLiOxMusjdkMKOS3kYRqtbqjy3E
         rwEA==
X-Gm-Message-State: AOJu0Yz4+8t4o8XnuzTdW47wx4aTjcp+pR8o16nOyB+7c8ZB1903NUzS
        iEgbKdovYlaQ4OAthDfY3BtVWp4BZWxQPq+LnWmE
X-Google-Smtp-Source: AGHT+IFllLZZWFPHJxYpVLdypnKl5L3mAqv6xeGBFsLONOqGPVp2InTyca0HrFY4WjdMtw+6+LgnjkhlVrQ5/7vYr3qb
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:48c9:0:b0:5a7:db29:40e3 with
 SMTP id v192-20020a8148c9000000b005a7db2940e3mr420178ywa.7.1698328595848;
 Thu, 26 Oct 2023 06:56:35 -0700 (PDT)
Date:   Thu, 26 Oct 2023 19:26:28 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026135628.2800617-1-vamshigajjela@google.com>
Subject: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function to
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

The function uart_fifo_timeout() returns an unsigned long value, which
is the number of jiffies. Therefore, change the variable timeout in the
function uart_poll_timeout() from int to unsigned long.
Change the return type of the function uart_poll_timeout() from int to
unsigned long to be consistent with the type of timeout values.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v3:
- updated description
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

