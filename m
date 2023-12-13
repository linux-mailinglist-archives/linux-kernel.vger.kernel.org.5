Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB48119D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379160AbjLMQnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjLMQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:43:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF99181
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C16C433C9;
        Wed, 13 Dec 2023 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485791;
        bh=wYZoxRzv7f2lUWGVcUrdQYjqojzH2JSBWrtkL9KlpB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OikvGNj6sd0jUETMSWlDSLI5ZF/U+uXbQ8cVDaFNlkARUf5qtCOPFz/y3XWqThSt8
         cEuyEzZacvtERUMB5wriCrNSxDOFQtiDQjRRTxmdNqT4jo0SCEsVbcIY82OKRdZhoH
         HM3VYJzdSXnumn5UpTJomk69ro5yyp6jl7AOUaWDuuP+JqilQ2Ux4CVJ6q9s2iGbFC
         Mztob5uy85eoJrWtcOrBgI8hOAMk+iahwGDNv38hzfGSXFeILsO2PIfr1PGFEoWQ6o
         8k9KL+WzlfxAxmaxUjYswgOY4eP+iOTNwsQj6Sn+XvHB0Id3BUw94U00TfCDWIDGN6
         DcKnJuEBEW5tQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/12] usb: host: max3421-hcd: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:36 +0000
Message-ID: <20231213164246.1021885-8-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213164246.1021885-1-lee@kernel.org>
References: <20231213164246.1021885-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Cristian Birsan <cristian.birsan@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/host/max3421-hcd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index d152d72de1269..9fe4f48b18980 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1158,12 +1158,12 @@ dump_eps(struct usb_hcd *hcd)
 		end = dp + sizeof(ubuf);
 		*dp = '\0';
 		list_for_each_entry(urb, &ep->urb_list, urb_list) {
-			ret = snprintf(dp, end - dp, " %p(%d.%s %d/%d)", urb,
-				       usb_pipetype(urb->pipe),
-				       usb_urb_dir_in(urb) ? "IN" : "OUT",
-				       urb->actual_length,
-				       urb->transfer_buffer_length);
-			if (ret < 0 || ret >= end - dp)
+			ret = scnprintf(dp, end - dp, " %p(%d.%s %d/%d)", urb,
+					usb_pipetype(urb->pipe),
+					usb_urb_dir_in(urb) ? "IN" : "OUT",
+					urb->actual_length,
+					urb->transfer_buffer_length);
+			if (ret == end - dp - 1)
 				break;	/* error or buffer full */
 			dp += ret;
 		}
@@ -1255,9 +1255,9 @@ max3421_handle_irqs(struct usb_hcd *hcd)
 			end = sbuf + sizeof(sbuf);
 			*dp = '\0';
 			for (i = 0; i < 16; ++i) {
-				int ret = snprintf(dp, end - dp, " %lu",
-						   max3421_hcd->err_stat[i]);
-				if (ret < 0 || ret >= end - dp)
+				int ret = scnprintf(dp, end - dp, " %lu",
+						    max3421_hcd->err_stat[i]);
+				if (ret == end - dp - 1)
 					break;	/* error or buffer full */
 				dp += ret;
 			}
-- 
2.43.0.472.g3155946c3a-goog

