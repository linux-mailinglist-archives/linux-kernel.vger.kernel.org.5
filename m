Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4B791A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjIDPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjIDPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:19:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1FCC3;
        Mon,  4 Sep 2023 08:19:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfXPB6rhsz6K6lZ;
        Mon,  4 Sep 2023 23:19:42 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 16:19:46 +0100
Date:   Mon, 4 Sep 2023 16:19:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Fix CEL logic for poison and security
 commands
Message-ID: <20230904161946.000050b8@Huawei.com>
In-Reply-To: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
References: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023 14:42:58 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The following debug output was observed while testing CXL
> 
> cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver
> 
> opcode 0x4300 (Get Poison) is supported by the driver and the mock
> device supports it.  The logic should be checking that the opcode is
> both not poison and not security.
> 
> Fix the logic to allow poison and security commands.
> 
> Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Makes sense.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..b315bdab9197 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -716,8 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd && (!cxl_is_poison_command(opcode) ||
> -			     !cxl_is_security_command(opcode))) {
> +		if (!cmd && !cxl_is_poison_command(opcode) &&
> +		    !cxl_is_security_command(opcode)) {
>  			dev_dbg(dev,
>  				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
> 
> ---
> base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
> change-id: 20230903-cxl-cel-fix-9da269bf0f21
> 
> Best regards,

