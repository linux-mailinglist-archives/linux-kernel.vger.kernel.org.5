Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1976EECB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjHCP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjHCP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:57:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4A3A93;
        Thu,  3 Aug 2023 08:57:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373FvBxe079735;
        Thu, 3 Aug 2023 10:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691078231;
        bh=zbceunG6HLkq7CegqrVypMKkS+qXgl2Bk5f+wlEXjo0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZeGlA5Mgo8Byyq1cbaJXcdV3u5p1qbjlvnt33CF2OttRsnjvRkHk3NFNYAzlmRA6g
         psZx3tUMbjDhprs8jWoigM5eFXVRwUVLKP1jGb9n9iphv4xlN/+7WyryCjldFMDF1q
         gi5Y6xNxqWzyCtjSMeETGD1T9S8ru9oRKjna/4J0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373FvBi5111377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:57:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:57:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:57:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373FvATh008664;
        Thu, 3 Aug 2023 10:57:11 -0500
Date:   Thu, 3 Aug 2023 21:27:10 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH V6 3/4] firmware: ti_sci: Allocate memory for Low Power
 Modes
Message-ID: <20230803155710.fivxx7hufuravcdr@dhruva>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-4-d-gole@ti.com>
 <7c12b109-d6b9-f0d4-cada-28140a33da21@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c12b109-d6b9-f0d4-cada-28140a33da21@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03, 2023 at 10:23:47 -0500, Andrew Davis wrote:
> On 8/3/23 1:42 AM, Dhruva Gole wrote:
> > From: Dave Gerlach <d-gerlach@ti.com>
> > 
> > A region of memory in DDR must be used during Deep Sleep for saving
> > of some system context when using the ti_sci firmware. From DM's point
> > of view, this can be any contiguous region in the DDR, so can allocate
> > 512KB of DMA reserved memory in probe(), instead of another carveout.
> > 
> > Also send a TISCI_MSG_QUERY_FW_CAPS message to the firmware during
> > probe to determine if any low power modes are supported and if
> > ti_sci_init_suspend should be called based on the response received.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> > Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> > Tested-by: Roger Quadros <rogerq@kernel.org>
> > [d-gole@ti.com: Use dma_alloc_attrs instead of dma_alloc_coherent]
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >   drivers/firmware/ti_sci.c | 42 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> > 
[..snip..]
> >   static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
> >   	.default_host_id = 2,
> > @@ -3661,6 +3690,15 @@ static int ti_sci_probe(struct platform_device *pdev)
> >   		}
> >   	}
> > +	/*
> > +	 * Check if the firmware supports any optional low power modes
> > +	 * and initialize them if present. Old revisions of TIFS (< 08.04)
> > +	 * will NACK the request.
> > +	 */
> > +	ret = ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
> > +	if (!ret && (info->fw_caps & MSG_MASK_CAPS_LPM))
> > +		ti_sci_init_suspend(pdev, info);
> > +
> >   	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
> >   		 info->handle.version.abi_major, info->handle.version.abi_minor,
> >   		 info->handle.version.firmware_revision,
> > @@ -3708,6 +3746,10 @@ static int ti_sci_remove(struct platform_device *pdev)
> >   		mbox_free_channel(info->chan_rx);
> >   	}
> > +	if (info->ctx_mem_buf)
> > +		dma_free_coherent(info->dev, LPM_CTX_MEM_SIZE,
> 
> You allocated with dma_alloc_attrs() you should free with dma_free_attrs().

Good catch, will fix this in next revision

> 
> Andrew
> 
> > +				  info->ctx_mem_buf,
> > +				  info->ctx_mem_addr);
> >   	return ret;
> >   }

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
