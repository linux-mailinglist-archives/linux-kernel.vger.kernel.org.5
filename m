Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52B7B370B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjI2PmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2PmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:42:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A8B4;
        Fri, 29 Sep 2023 08:42:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69593C433C7;
        Fri, 29 Sep 2023 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696002136;
        bh=Zl9IzDfJ74tSHG7Bo3AkrSgoNzTjNILJUvTaD+C2hpM=;
        h=Date:From:To:Cc:Subject:From;
        b=qyDMdW5b+k9YsTcDHVa6jtbOihi/nlM/xncg5bZPJCRQEuUEtK6jXE+OoW58OSQKD
         ZgwbxqXxdZAEhgaBpWo1c6XxZXkhcZxQDzvkVFpR2DU9DUyFLlUaKG82/Y8YTNd8xi
         O0d0hVUy/uqd4PbDUTXeIbpEcm8etsmdMnXgFmi3YG/Rq2A8LhFPDcVj5uCKaLcWOc
         ohsuJ5/hPAQT39aQW/NCjmO153g/RPL8acTQLExpvutAuJQEAvtDUH8TEmcY4LJcTv
         rMg8SZZn5zoIF+WcA/LUJT8UlLl173AXx+XZ1ysj4XwrpKtIvsUSoTcTAcC9B13QIb
         /KAO3+pqJztOQ==
Date:   Fri, 29 Sep 2023 17:42:11 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: usb: siano: Fix undefined behavior bug in
 struct smsusb_urb_t
Message-ID: <ZRbwU8Qnx28gpbuO@work>
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
overwrite of the object `wq` at run-time with the contents of `urb`.

Fix this by placing object `urb` at the end of `struct smsusb_urb_t`.

Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/usb/siano/smsusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 9d9e14c858e6..2c048f8e8371 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -40,10 +40,10 @@ struct smsusb_urb_t {
 	struct smscore_buffer_t *cb;
 	struct smsusb_device_t *dev;
 
-	struct urb urb;
-
 	/* For the bottom half */
 	struct work_struct wq;
+
+	struct urb urb;
 };
 
 struct smsusb_device_t {
-- 
2.34.1

