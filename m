Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43355799493
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjIIAkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbjIIAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C5F2719;
        Fri,  8 Sep 2023 17:38:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEBEC116B1;
        Sat,  9 Sep 2023 00:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219923;
        bh=B5o/qp2zORkq9M9rsXTWIo4K7yN4DH5plfGCf8hNBxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=madNvtyKK8hRDgK7lx3AGjGqqJtnD9Y/bgofENJVfeAvwI9sFRKkDIqur/dspqOzZ
         3I4z3NSlAwVhDNTgjEJGBltP/5zmQ5R44f6aO1muoh7jFkaYJL7dW9yQTwtwBk+rUK
         X5yKCudEbnWtS2lbCW37y2xOvHRLLAnQ0AA5y5kAjLwdp1uoZ5m8DbeMCfMztoKxQm
         MIReCSbVqoZpklYZRlqy8wLKLmzvhmcGFrYMsqfKB6elzH8B0ixp4wBLOkdhDK71+F
         vs4TfrB+8UMKP81ztVI9MkvYQq4WY4kyDAjvVgJq6PUswVdLaXpyYrAXA3gDF1zHKt
         bF3BJqVmDklhw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 13/24] usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc
Date:   Fri,  8 Sep 2023 20:38:05 -0400
Message-Id: <20230909003818.3580081-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit ce9daa2efc0872a9a68ea51dc8000df05893ef2e ]

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
Link: https://lore.kernel.org/r/20230628081511.186850-1-make_ruc2021@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/fsl_qe_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 3b1cc8fa30c83..f4e5cbd193b7b 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1959,6 +1959,8 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
 		struct qe_ep *target_ep = &udc->eps[pipe];
 		u16 usep;
 
-- 
2.40.1

