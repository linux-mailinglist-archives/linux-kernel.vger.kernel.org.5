Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58407995A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbjIIBhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241109AbjIIBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:37:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9771F1FE0;
        Fri,  8 Sep 2023 18:37:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB9C43397;
        Sat,  9 Sep 2023 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220001;
        bh=3RWhBxeMW1KWgo56HHaCLEJE6KAVsH444LGWPznP/kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hfp14pM+kJVW4Eux0VBpInblBBlUvuwekKO8RSO/2iruqJhgGM/V3/+0yR3y/bNPI
         2pOwnYRDE5p8pFVFvnZJ0NYs0p5CX+Jbqxhsx3KScdF5eTFcVmUSvNpFFftNDLzCm8
         IjAS/deGW8AwV2EH9bXzr9i2L5/NmHF8XAVhIkpxyp9xfOpkDSOT/18SuMzVx+i/g3
         CPal/3Nl7QJqzJnEZe3aWSF3f38lEQf2khnxAqv9SnBOGZnH8PLrdV0ApB+LNK5DET
         spuOue5w/izjxQEvWFl8Hzl91XX/uk6NpcnktzREJLQJOLPdm88zIeoi9OyRtFn6aQ
         tliK/3exumkxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.10 10/16] usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc
Date:   Fri,  8 Sep 2023 20:39:35 -0400
Message-Id: <20230909003941.3580631-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003941.3580631-1-sashal@kernel.org>
References: <20230909003941.3580631-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fa66449b39075..f3388c720e0fa 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1950,6 +1950,8 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
 		struct qe_ep *target_ep = &udc->eps[pipe];
 		u16 usep;
 
-- 
2.40.1

