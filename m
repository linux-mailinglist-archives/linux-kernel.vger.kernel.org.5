Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD979F3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjIMV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:27:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D041724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so241927b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694640448; x=1695245248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kiTus1GQ2wpWYv2hiScbkUesx/S4YRwA/TTSZ+SSL4=;
        b=irWRL3Dhte1i12EFMTqrguyLoUPSaGHc1URlmZ4ILg/6UhpBKDkn1uiORA47RurTRr
         HbBMckPJCQ5HWE/fi2DItGu3CzIZSEn3F8xSRYyCi8EQiOTULT3US9aI+JgA/0EibUsS
         irsjZ7ugWpzAT8M00n9Egc6hiYVBG6ygIQe1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640448; x=1695245248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kiTus1GQ2wpWYv2hiScbkUesx/S4YRwA/TTSZ+SSL4=;
        b=T0E5D/dtZ2hsvgH6kX/qyRB17Z0DjVz6evDpwh4o5S4VxCFevgyRJYCCMRdIOrDfNU
         Jqg+I0AabV6oPtsB5yiZfsogBBYZQitiPI43pwS1Kqpk4CW56QsMWqPr3evuxROp9S6H
         foafImwsWWg+xlN9Wwe13rOj/JpIWdMIth9hAMS1Afxs5goRzn0Ta44C3tMtbixFWs1x
         pXOhKhnKDzxlhsuZV25JvjOPDFbZpvLNBcAmjwJNdhQjl74USLDA9MCRfUxEXDPyXpJw
         INDoEqOWoltQtYpcd/sgoYukou9PT7xu/52t3OZqmkMb1wTY99XMVyDG+BynubLE2atB
         7qkA==
X-Gm-Message-State: AOJu0Yy7AtTG4OZjSFKJrUsdPVgqgZyy9FBrER0UfcljYimSnpDMfXdZ
        1AoeKQio3VC8HaC70s0AAJiLWw==
X-Google-Smtp-Source: AGHT+IHkCpRGY5eNNzziS4Z0x0tJxKnxzcDaYv5kyCx0kSSKkvJ4n+5d/Sy4MX6b0nbFhT8NwHTsbg==
X-Received: by 2002:a05:6a20:561a:b0:147:d861:50e4 with SMTP id ir26-20020a056a20561a00b00147d86150e4mr3072141pzc.33.1694640448396;
        Wed, 13 Sep 2023 14:27:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:ae97:c6dc:1d98:494f])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090ad80a00b0025bdc3454c6sm1923976pjv.8.2023.09.13.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:27:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v4 2/4] platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()
Date:   Wed, 13 Sep 2023 14:27:20 -0700
Message-ID: <20230913212723.3055315-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230913212723.3055315-1-swboyd@chromium.org>
References: <20230913212723.3055315-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for the completion in ipc_wait_for_interrupt() to timeout,
simply because the interrupt was delayed in being processed. A timeout
in itself is not an error. This driver should check the status register
upon a timeout to ensure that scheduling or interrupt processing delays
don't affect the outcome of the IPC return value.

 CPU0                                                   SCU
 ----                                                   ---
 ipc_wait_for_interrupt()
  wait_for_completion_timeout(&scu->cmd_complete)
  [TIMEOUT]                                             status[IPC_STATUS_BUSY]=0

Fix this problem by reading the status bit in all cases, regardless of
the timeout. If the completion times out, we'll assume the problem was
that the IPC_STATUS_BUSY bit was still set, but if the status bit is
cleared in the meantime we know that we hit some scheduling delay and we
should just check the error bit.

Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Fixes: ed12f295bfd5 ("ipc: Added support for IPC interrupt mode")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 4c774ee8bb1b..299c15312acb 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -248,10 +248,12 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
 
-	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
-		return -ETIMEDOUT;
+	wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT);
 
 	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY)
+		return -ETIMEDOUT;
+
 	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
-- 
https://chromeos.dev

