Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D1A7D9AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbjJ0OPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbjJ0OPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:15:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F0B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:15:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so1499810276.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698416143; x=1699020943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6Wogm78zGHr7c0TI3PksAkvURXKXnXYdkqP8SNCZYk=;
        b=DfqnykrRRsemYMpSbbBPoLlsSnhvYQLsPalSNTBYfXatcydc7SsP0B8iKlkaRZjpM2
         WgOPFQRfXGF5SRuk27LEGPXqp20WLysPBolURJTovfK20snG8LCT7QvMQG6DG7LqiNJX
         Ltg2Ti72MGXnwSCGaTITjDffo6o1luHWFhtXKKB1GE/Sur9XJBSTiSbvtglQMJFAeBDD
         FpC9e/WbthpwMwlWPTVjrCQyrS/SWp0vbg+MUyjirmHoexvNpYSOfbdV6IRQi+KXWgYB
         Fu90ff2UbYTSJtF0Av0JgnkRC7TFetTWqTfa5UVF52dqX0Nwfs4HrimnvZQ11cQBj91V
         jUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416143; x=1699020943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6Wogm78zGHr7c0TI3PksAkvURXKXnXYdkqP8SNCZYk=;
        b=l9Vjk7G142xAVOj4fpjrFEChFG52NqVnDTqFiprvXiKGOVK87b/Mb2GCPrRhSoGCA0
         3fG5b5N8XC2zmxjrcgSVWS3bOEdtXIeEw3fES6h6AtyJhSx84gG4I05nCYN1S6WOP2Yd
         ryRJdYBX4oFPHJzrRz17ASJUXiDu07yE+WFfLG1Owu4EhVQsu7xHZNHXYmcf6tXZVk2+
         CV/LWT+j5xOny7lulMJBhjJ8A9HgEGX8FBelHOWm6Q6Ia+zHsbNgPEf3SW2iga8wTdzG
         9zrP2NrK1NuaR7BEz68fA+XioeMH7Qw17ywwqcBxfBYe2wsnteErfvRBsGRKAc3cKL6H
         b2wg==
X-Gm-Message-State: AOJu0YySGvKG2+r+49D0ayaEi6zQufCeBYY/UsEeHYR2VvHaKPIh2xo7
        JDwadX79xEa7q797hPWW6nKCbuXFR9zKpiXAnxgj
X-Google-Smtp-Source: AGHT+IGiBegNQMjPo+jvPjsDZNLTWLXmCuAd+U3t/Sn0ndd2lrZtgBb1WDoAF/L8yK4wq+W14D6hcyRzXdR+nc65ltAp
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:aa07:0:b0:da0:c584:defe with
 SMTP id s7-20020a25aa07000000b00da0c584defemr44118ybi.13.1698416142832; Fri,
 27 Oct 2023 07:15:42 -0700 (PDT)
Date:   Fri, 27 Oct 2023 19:45:34 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027141534.3723781-1-vamshigajjela@google.com>
Subject: [PATCH v4 3/3] serial: core: Update uart_poll_timeout() function to
 return unsigned long
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
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

The function uart_fifo_timeout() returns an unsigned long value, which
is the number of jiffies. Therefore, change the variable timeout in the
function uart_poll_timeout() from int to unsigned long.
Change the return type of the function uart_poll_timeout() from int to
unsigned long to be consistent with the type of timeout values.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
---
v4:
- author name in capitals to lowercase
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
2.42.0.820.g83a721a137-goog

