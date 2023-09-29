Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4491C7B3762
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjI2P7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2P7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:59:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBE139
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:59:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5B3C433C8;
        Fri, 29 Sep 2023 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696003169;
        bh=MnZquLPkDBkjKHQwlCsmfD9plASD37pKQYphc5bm4a0=;
        h=Date:From:To:Cc:Subject:From;
        b=Ji33FVLvtjef5TpdrXCXT+tOfwK7X6QqaDW/sSTW4uncDJ0ZD9QBIZRmOUQKsgWmN
         QAMCATmVFijx8Ajh0KRMVLs4/Ie2iez01r2ZQyzhpaJR+MveEuei8hv1I1+AA1xmW3
         4PH/aAAdF0p2YDAtLRE8dOPiriMcOvZcelN0alOaurtwQY6DGn94/ko5B/BINekQ74
         IfRn7eWnesujGiT4JQEJYxfMUmcCRe8TLku3hCbeiZvI/IFBpvXE7FdC6PNebn/cwN
         eOpJTyQLqnuKMSDxcxYEvvGb6KYot/hn7gOtIDSNOP8ZDBbsQUVchp6GoohIeN39cX
         QDXFd3aOUztUg==
Date:   Fri, 29 Sep 2023 17:59:22 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ALSA: 6fire: Fix undefined behavior bug in struct
 comm_runtime
Message-ID: <ZRb0WiViajjqcyKT@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`struct urb` is a flexible structure, which means that it contains a
flexible-array member at the bottom. This could potentially lead to an
overwrite of the objects following `receiver` in `struct comm_runtime`,
among them some function pointers.

Fix this by placing the declaration of object `receiver` at the end of
`struct comm_runtime`.

Fixes: ddb6b5a96437 ("ALSA: 6fire: fix DMA issues with URB transfer_buffer usage")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/usb/6fire/comm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/6fire/comm.h b/sound/usb/6fire/comm.h
index 2447d7ecf179..ee81572a4eec 100644
--- a/sound/usb/6fire/comm.h
+++ b/sound/usb/6fire/comm.h
@@ -19,7 +19,6 @@ enum /* settings for comm */
 struct comm_runtime {
 	struct sfire_chip *chip;
 
-	struct urb receiver;
 	u8 *receiver_buffer;
 
 	u8 serial; /* urb serial */
@@ -30,6 +29,7 @@ struct comm_runtime {
 	int (*write8)(struct comm_runtime *rt, u8 request, u8 reg, u8 value);
 	int (*write16)(struct comm_runtime *rt, u8 request, u8 reg,
 			u8 vh, u8 vl);
+	struct urb receiver;
 };
 
 int usb6fire_comm_init(struct sfire_chip *chip);
-- 
2.34.1

