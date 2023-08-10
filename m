Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2D7775F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjHJKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHJKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659C10DA;
        Thu, 10 Aug 2023 03:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE1D6580F;
        Thu, 10 Aug 2023 10:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9572BC433C7;
        Thu, 10 Aug 2023 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691663944;
        bh=dtMhaLdCEBf8LyDEChVuL94sp23JhfU16F+5lzQnbJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjBdC+oZiqPod2lHLaj/kELB0xCrFiTTiBsEm8ho0n4F6TCHb7TyvPjz2ORb8Pdop
         COsIiqW98YQcnTbKaeEjrtgPMUzTzERTPIgDISWDikITpY8V+vM3Yew03odqPWsu5Y
         7z3VIdTaWXWzx+XQXZjWsgiMrfzuSkQMn0pu5yMQ/8Ca86xDAOSZV+y1h3kk6YVrPj
         BOtk49zshQ++ODJ8/ypTvKOS4dc06NIb2hhiSzfF7zoI8yNPacUNxI8z9B4FG2mhuA
         OYzEEmzxpHpRUWtDpKTK1T8PyLf7FEZY9SUP/ahStoG/sbOqmFclybG3eTgTDoHz7U
         4nmP5REqdPhog==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 34-and-three-quarters/36] tty: gdm724x: simplify gdm_tty_write()
Date:   Thu, 10 Aug 2023 12:39:00 +0200
Message-ID: <20230810103900.19353-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ba8becf4-786a-4923-92f7-b4ec3038295f@kadam.mountain>
References: <ba8becf4-786a-4923-92f7-b4ec3038295f@kadam.mountain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

len and remain can never be negative in gdm_tty_write(). So remove such
a check and move the check of remaining bytes to the loop condition.
This way, the preceding 'if' is now superfluous too. Fix all that and
make the code cleaner.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/gdm724x/gdm_tty.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index cbaaa8fa7474..67d9bf41e836 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -158,10 +158,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 	if (!gdm_tty_ready(gdm))
 		return -ENODEV;
 
-	if (!len)
-		return 0;
-
-	while (1) {
+	while (remain) {
 		size_t sending_len = min(MUX_TX_MAX_SIZE, remain);
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
@@ -171,8 +168,6 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 					gdm);
 		sent_len += sending_len;
 		remain -= sending_len;
-		if (remain <= 0)
-			break;
 	}
 
 	return len;
-- 
2.41.0

