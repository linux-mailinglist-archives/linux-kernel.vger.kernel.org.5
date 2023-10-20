Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C281A7D13CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjJTQP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJTQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:15:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C6114;
        Fri, 20 Oct 2023 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=I4hMGAn3CCXbvIhFniLsRuw1X84vM7LzNgk6oVf6hDo=; b=g6XL6KrLFvXCVI21u1A5KeupFv
        +QFnHNBtXPSX2WGx/qzbR8hAv15UjjS3G7GeUcRbT6Gzod96JethLXROgfY3uc2SU169IvhiZdRGh
        PQGKjDFv0/nWu/OIs7h5I+YdQjcKmWPq6iD07vRG6QQQEc9KMRwcxd9MEFfDm+JhqgzS/494qQBHg
        cmRRbbr+caoCft14R2moMfBDrzAlzzoBVVkfYfN3hN7MnKJVzuTCxV7GKaf92411iUcMwW41EdBZu
        LzyJ/6kNrv4xSgCoDDiOqDloTvQ2En//Zuw6p8kbzieBn/ZS50xuBKNEiKD53bPkfqRtyRa8Wwy2S
        MoYvVmXQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qts9u-00E44C-84; Fri, 20 Oct 2023 16:15:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qts9s-001UOZ-13;
        Fri, 20 Oct 2023 17:15:32 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dawei Li <set_pte_at@outlook.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Paul Durrant <paul@xen.org>
Subject: [PATCH v2 2/3] hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
Date:   Fri, 20 Oct 2023 17:15:28 +0100
Message-Id: <20231020161529.355083-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020161529.355083-1-dwmw2@infradead.org>
References: <20231020161529.355083-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

The xen_hvc_init() function should always register the frontend driver,
even when there's no primary console — as there may be secondary consoles.
(Qemu can always add secondary consoles, but only the toolstack can add
the primary because it's special.)

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/hvc/hvc_xen.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index f24e285b6441..4a768b504263 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -588,7 +588,7 @@ static int __init xen_hvc_init(void)
 		ops = &dom0_hvc_ops;
 		r = xen_initial_domain_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 		info = vtermno_to_xencons(HVC_COOKIE);
 	} else {
 		ops = &domU_hvc_ops;
@@ -597,7 +597,7 @@ static int __init xen_hvc_init(void)
 		else
 			r = xen_pv_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 
 		info = vtermno_to_xencons(HVC_COOKIE);
 		info->irq = bind_evtchn_to_irq_lateeoi(info->evtchn);
@@ -622,6 +622,7 @@ static int __init xen_hvc_init(void)
 	}
 
 	r = 0;
+ register_fe:
 #ifdef CONFIG_HVC_XEN_FRONTEND
 	r = xenbus_register_frontend(&xencons_driver);
 #endif
-- 
2.40.1

