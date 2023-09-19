Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563F67A5DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjISJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjISJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:28:33 -0400
X-Greylist: delayed 237 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 02:28:24 PDT
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA3F2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:28:24 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id B3EDF102395;
        Tue, 19 Sep 2023 12:24:23 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id AEC1D101775;
        Tue, 19 Sep 2023 12:23:47 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 38J9NkLq017473;
        Tue, 19 Sep 2023 12:23:47 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] staging: rtl8712: fix buffer overflow in r8712_xmitframe_complete()
Date:   Tue, 19 Sep 2023 12:23:18 +0300
Message-Id: <20230919092318.14837-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230919 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of pxmitframe->attrib.priority in r8712_issue_addbareq_cmd(),
which dump_xframe() calls, is used to calculate the index for accessing 
an array of size 16. The value of pxmitframe->attrib.priority can be 
greater than 15, because the r8712_update_attrib() function can write 
a value up to 31 to attrib.priority, and r8712_xmitframe_complete() 
checks that pxmitframe->attrib.priority is less than 16 before 
calling r8712_xmitframe_coalesce().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/staging/rtl8712/rtl8712_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 4cb01f590673..8a39a3c8cfcb 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -669,7 +669,7 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 			 */
 			r8712_xmit_complete(padapter, pxmitframe);
 		}
-		if (res == _SUCCESS)
+		if (res == _SUCCESS && pxmitframe->attrib.priority <= 15)
 			dump_xframe(padapter, pxmitframe);
 		else
 			r8712_free_xmitframe_ex(pxmitpriv, pxmitframe);
-- 
2.30.2

