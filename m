Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AD17BED7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378816AbjJIVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378790AbjJIVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:42:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9C127;
        Mon,  9 Oct 2023 14:42:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D458AC433C7;
        Mon,  9 Oct 2023 21:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696887728;
        bh=kq7cApyaT7hqQOO78PhiQUyzEI02824CzKv278QATpY=;
        h=Date:From:To:Cc:Subject:From;
        b=LhxZG3fGzzNxCc8RPo3e5Apt/vaJKOUso5HbDl0esgi/4BcjGd46MWi6EjUemPJM0
         eC3Yo/QQtFvvtIshkn3s5CzSQveQ1RLlh+VJpdtrnMhz1+dhL2I0IKkaueyS2krcvZ
         UtdFf9SjO5lWp5TdS5Gorhp/lJjHWhFmHn8fGkxrpYnMk2s6hLkgG2Hn58bh3ZSN6v
         k1pAj8vT1qSI1jn2cXNdhOLb7XBnKUAgVf1E9D7N63CgW/1h+ISrufFpCghZkCbfDZ
         Le1a/d7Fa1uvsVA4+TXZEKboWAEBshbN91oiFmrkUD3myeRkg5ulbbNJ/pW/q/EJxH
         5FBDRwAxf+zig==
Date:   Mon, 9 Oct 2023 15:42:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: brcmfmac: fweh: Add __counted_by for struct
 brcmf_fweh_queue_item and use struct_size()
Message-ID: <ZSRzrIe0345eymk2@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Also, relocate `event->datalen = datalen;` to before calling
`memcpy(event->data, data, datalen);`, so that the __counted_by
annotation has effect, and flex-array member `data` can be properly
bounds-checked at run-time.

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index dac7eb77799b..68960ae98987 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -33,7 +33,7 @@ struct brcmf_fweh_queue_item {
 	u8 ifaddr[ETH_ALEN];
 	struct brcmf_event_msg_be emsg;
 	u32 datalen;
-	u8 data[];
+	u8 data[] __counted_by(datalen);
 };
 
 /*
@@ -418,17 +418,17 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 	    datalen + sizeof(*event_packet) > packet_len)
 		return;
 
-	event = kzalloc(sizeof(*event) + datalen, gfp);
+	event = kzalloc(struct_size(event, data, datalen), gfp);
 	if (!event)
 		return;
 
+	event->datalen = datalen;
 	event->code = code;
 	event->ifidx = event_packet->msg.ifidx;
 
 	/* use memcpy to get aligned event message */
 	memcpy(&event->emsg, &event_packet->msg, sizeof(event->emsg));
 	memcpy(event->data, data, datalen);
-	event->datalen = datalen;
 	memcpy(event->ifaddr, event_packet->eth.h_dest, ETH_ALEN);
 
 	brcmf_fweh_queue_event(fweh, event);
-- 
2.34.1

