Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E4799515
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbjIIApJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346177AbjIIAoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:44:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DFB49C9;
        Fri,  8 Sep 2023 17:41:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAECC4163C;
        Sat,  9 Sep 2023 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220095;
        bh=fO5jknWwk5d+c0RRG2Vfmd54Jgt7spM0896LZiu1+2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOnXCVQj4dkKv1xPSeEVMGVpc1wGq4bu/UyBYSbygbxVDy9WSyNHCWQwqalUv6T2o
         V8uBYGqUmaGnSw/pWTVT10pRZtZx8qmkw31Wtn5ZUnH82DzoQ2DI8rPjPjEeHnpp6d
         j5+BDlWoEsSXdSsqVxmDnIYN0XUHxITI1MKdsWz51QufH+ImUSih3nLl5EYXMgDYeG
         2lKtVE6QayMLfsFcPmOXQzn3Ke7eKosEJXSnFXhucFdgFmiKjQQXMczFJAbPKtXeln
         HiA2TdFl0dNbD4oEtZcorWIJw00liidzZTrx5M4dkWVcdccsKltgGd5Emz5cvEhtNe
         J6REzRrLwY1ug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ma Ke <make_ruc2021@163.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 09/12] usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc
Date:   Fri,  8 Sep 2023 20:41:12 -0400
Message-Id: <20230909004115.3581195-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004115.3581195-1-sashal@kernel.org>
References: <20230909004115.3581195-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
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
index a3e72d690eef9..962e3ea4dc147 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1954,6 +1954,8 @@ static void ch9getstatus(struct qe_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		int pipe = index & USB_ENDPOINT_NUMBER_MASK;
+		if (pipe >= USB_MAX_ENDPOINTS)
+			goto stall;
 		struct qe_ep *target_ep = &udc->eps[pipe];
 		u16 usep;
 
-- 
2.40.1

