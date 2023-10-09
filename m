Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F5E7BED66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378710AbjJIVa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378542AbjJIVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:30:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D4592;
        Mon,  9 Oct 2023 14:30:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D10C433C7;
        Mon,  9 Oct 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696887021;
        bh=hKpw9LZwyKaVS0FWXHmJymdA4SjptOQOm2bWj75OgPs=;
        h=Date:From:To:Cc:Subject:From;
        b=rT1qhpFpqRiVqgpTZwUGexp2A+nUsN2ViOQjRqnwpV0V0OEDPncJ7UNSgaYVBGHsH
         qKxM3kOH+f9qJrEyWZPcguD95u3rmDjaCIF5AVOLgk5fP2yAOEmMMJtYd77KoXZrFw
         Wq6qTfZatu8Mlf81/v9INrgEXKTDHDPi5aCI+OO2PEAo9gx3ZRj1LmHA3FEQ4cIP+N
         YwNrvNLakxwSDssvtvd2pvR/7MhoZLyFiiR95n8xwK6qH/kqt1oL05VW5cl6ROxs9x
         fIomWW8LKuLgLPRQpFao87ba4zFOX2cCBX/2F8Q35XWeJEhC05ayqb8/jR9GpH/LE2
         BSFrwwIN8Vd5g==
Date:   Mon, 9 Oct 2023 15:30:17 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] soc: qcom: apr: Add __counted_by for struct apr_rx_buf
 and use struct_size()
Message-ID: <ZSRw6RNi3Crhd32H@work>
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

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/soc/qcom/apr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 30f81d6d9d9d..1f8b315576a4 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -41,7 +41,7 @@ struct packet_router {
 struct apr_rx_buf {
 	struct list_head node;
 	int len;
-	uint8_t buf[];
+	uint8_t buf[] __counted_by(len);
 };
 
 /**
@@ -171,7 +171,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 		return -EINVAL;
 	}
 
-	abuf = kzalloc(sizeof(*abuf) + len, GFP_ATOMIC);
+	abuf = kzalloc(struct_size(abuf, buf, len), GFP_ATOMIC);
 	if (!abuf)
 		return -ENOMEM;
 
-- 
2.34.1

