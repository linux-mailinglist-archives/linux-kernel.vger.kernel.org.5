Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A8807A06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442905AbjLFVDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379623AbjLFVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:03:01 -0500
Received: from a48-177.smtp-out.amazonses.com (a48-177.smtp-out.amazonses.com [54.240.48.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36291D5B;
        Wed,  6 Dec 2023 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1701896586;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
        bh=OCAlzX7SebA+j0HU4Sd7LjmJRCytQLzLNtjNPcYsg/M=;
        b=h/r7fKGwNyRQXQ/klZ0/fqeYYMmBzNl5n9mnuZL1ohKmcjySR0APw9WYzIRomCgm
        cvK++RoQJxfhIzH3u5eT+IMw3D3IcDf84JdaUMG1U5q2uDDALvgmvaDg6CPBYoT2gHK
        vQgc9fH23NGP5DuMD8LdntCcGHHIsnmCQCfF/XdI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1701896586;
        h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
        bh=OCAlzX7SebA+j0HU4Sd7LjmJRCytQLzLNtjNPcYsg/M=;
        b=UgfsXt6Or2ojBf76Wxu+AjMwJLnevzWfnydHUHZV10RKwXRG8xZFAeT4f98ghuOO
        sZTChlvoCdJCkD9gWYrcZTnPHXFOZDoWVK1ey3FRvSdybHdgln6I4R5CAh8qfYanjMN
        GinrcGELwDU5KWuy10CRatFMrr5sUHnJOc04snqc=
Subject: [PATCH RFC 4/4] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel build
 parameter
From:   =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To:     =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>,
        =?UTF-8?Q?John_Groves?= <jgroves@micron.com>,
        =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
Cc:     =?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>,
        =?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>,
        =?UTF-8?Q?nvdimm=40lists=2E?= =?UTF-8?Q?linux=2Edev?= 
        <nvdimm@lists.linux.dev>,
        =?UTF-8?Q?linux-cxl=40v?= =?UTF-8?Q?ger=2Ekernel=2Eorg?= 
        <linux-cxl@vger.kernel.org>,
        =?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= 
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= 
        <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?John_Groves?= <john@groves.net>
Date:   Wed, 6 Dec 2023 21:03:06 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20231206210252.52107-1-john@jagalactic.com>
References: <20231206210252.52107-1-john@jagalactic.com> 
 <20231206210252.52107-5-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaKIeW9Nsmb4x1TnOasHllAnJBRAAAASpN
Thread-Topic: [PATCH RFC 4/4] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel
 build parameter
X-Wm-Sent-Timestamp: 1701896584
X-Original-Mailer: git-send-email 2.39.3 (Apple Git-145)
Message-ID: <0100018c40f105c7-7e0d722c-4602-4956-8c3a-52f693e97e7c-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.12.06-54.240.48.177
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Groves <john@groves.net>

Add CONFIG_DEV_DAXIOMAP kernel build parameter
---
 drivers/dax/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a88744244149..b1ebcc77120b 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,10 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_IOMAP
+       depends on DEV_DAX && DAX
+       def_bool y
+       help
+         Support iomap mapping of devdax devices (for FS-DAX file
+         systems that reside on character /dev/dax devices)
 endif
-- 
2.40.1

