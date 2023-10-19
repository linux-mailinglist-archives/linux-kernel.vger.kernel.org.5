Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB327CFE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbjJSPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjJSPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:39:56 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDC2121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItL7/vkZbU/LBV5N7pHI0ew9Vy9ERXd6KDup8X3Run5Ign4tY1guKSsUJM70TJzqybWZf6BTikjvbiTv+6aR69VK96fd59SLlbO9Vs1Hpq487yCa66MZpJ6AcnpvxgXTu3lFSvF10vntlAfvRbTuurho/Ji1gJRqiPAR4aWHQqriAFxoezTqjVmYehZy0keQ8TaZk04+7V/VrW74h0DjFtdb6zCMZ3tzelcZSTzFhBWS+bII3QMMNZPyqLfppeoEZ7wGcYxIc+jvU80hnvmu8GoXuKnE2W7xD5yircqtFXlV3N1Ut50q4ECAtOKf5LqAQJO357AXl9h0qmbo+jQvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSmT55J/U0Cc3T5W7bpRh6gVDScINUp0DW/nzVpCVlU=;
 b=EphP0aRRMmp2lPVnwLzoWhdsteSYJCdJ4HgfYYZjcShps7dRwoSwatZ0IqCGWS3PMoiLJzk3rxAHu8c+OevOWNH6VaHReqqz2kKHCPdt3RXWTYf0TBj9GSLNtGCF0hIJKwcc5KLo/a1e1hsQbmSq2fjLHmS2gKrQq5cdMGyJFmBAe7M4oAAwq9sp7sZS5uAIykosVoEYnl56BRxOpLCrLwq1LNHzMfOtNYhqiG852B2dtuydYJDicuvuPlqu9ReOz9ppqgjCapSay85RaEp0Hctvus+AwIw7j3NAeJOSJ+NJTo0NdTUuDmLe3XFd2L6LcCbJBtwKdktOA0ZqN4augQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSmT55J/U0Cc3T5W7bpRh6gVDScINUp0DW/nzVpCVlU=;
 b=P1mrmTpSbbx0Z/yoZSRg5/XcTUytAsr6CtjoQ4VDtqoowlua8T9qntj/eBJ9S4d8sHA82iyNyZ1EoAczypYOrbi9FHDun2bDgkf36V729NhaEmSVYc0brrqoQLbBjGQTS5ce/I/qZDSpEAhxepFHnnW3iY9pXW+pMzxdc1kPh/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 15:39:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 15:39:50 +0000
Date:   Thu, 19 Oct 2023 11:39:42 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
 <20231018155926.3305476-7-Frank.Li@nxp.com>
 <20231019084452.11fd0645@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019084452.11fd0645@xps-13>
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VE1PR04MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: eb32f40e-9900-4510-5083-08dbd0b9a1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gstARcAsWZ8gC0ogodJuHlbbP3QCsylMFPGGAB4eXbjaqZtkya3TtqYNgELZPkFCD8jnQgHNAjXZjlS8w7IB9w76yNFxniImURMNerIOyudg+fmedBQ6ZLzT82ovc0B7HCjilBj5+g4AtnpfO5DmGvo22SbMdlNwf0EyGwDZbGbWXY3EjrTqQ1cUqKyWVx35aFDg+pctxyegbUHZP1i5X1M40m+Tsu0uO8LUeaM/HNJ1/73UdMm59D5GvmzGuUL4MiR0Y24bh5M6ujofi9uQQL3D2xXHH0KfWokZIq3nsg87hj5gG8cZ5WwOIAiIaKdu9gxfE3KBc0tvN5WoGNsWv3IsoNjrQ29w8yXeEK4Jc6WhtsgeTWylhRibNTBJan0Ks17dz2gQPzROPqtgA5wfhe2luBI3ZryiOjP2HTFc1Y4xYj9OJiXYyHUw2fGl2tV6ZRYUEi2CRAP/mQKqw2ANmH6EEHRLjBehEgm35qOX++08fYCgCEIJuQhIiiGuvU5Wipu4Mo/qaUQiiJTCpbq5vkmPLQUS8LhYuYxDVNjGHOWJpqUWoBXss5dLhrlugg1jEnZ0zCfhw4Iu/rqHIHP7o88aZffcKqLBwVWh60ELlYIClaTP68tK8pYY1jJ3tyyB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(38100700002)(38350700005)(316002)(9686003)(33716001)(6512007)(86362001)(6916009)(66476007)(41300700001)(5660300002)(2906002)(66556008)(66946007)(8936002)(478600001)(8676002)(4326008)(52116002)(6666004)(6506007)(6486002)(66574015)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXU1V09DbWllQzQ5eWxFelpVMVF2NVlLTUZwUGhsNktkTHByaXpGZ3lyTGNT?=
 =?utf-8?B?dUo3SzhXeEZhbWl1ZmFqZUp3RE5iWnFJalRsbk1SdGtraGpHdk8rUzZpZzdo?=
 =?utf-8?B?L0Zkem1xK2ErWkVubGxqY1dQK3B6c3o3Z29wa1d5MDVmV0FQemNZL2hJNG81?=
 =?utf-8?B?NnkxNWlINllNU2RTeElEUFFlWWVCUUJCTFJVWmk0aGd5UXIzcmo2VWNYTy8r?=
 =?utf-8?B?T01neHlENUdHWVdkOExuR0xHRGV4eWdxTzdhcklKcHpUR3hWY0p6ZWJNcUto?=
 =?utf-8?B?YUp2QXI4NmhIS3lWMlVrMDZxdC9NTE0wRWNBejF6dGZ0eHBaZVFabzVQVUx2?=
 =?utf-8?B?aXRXN3ozSVl2Z0NGK0lVeVhmOTBWUXZnQ1pMcVYwblNVTGJTSms5RFltdnNI?=
 =?utf-8?B?RTBBM3ljL0hXMi85M2k1MmRhSCtQR1JWYTBrSzJmWnJwRlBjLzh2WEVvNUtn?=
 =?utf-8?B?UlBiTG1UUnRPUnBOTUpaMFJOOHRvbm9ERGN2aU1UaHRHSUFDL3RjREhzdkR2?=
 =?utf-8?B?MEpWejBYRHRaZ2Q1Tk8wNW01dHE5N1p6MTMvSmxTSXI4QlhQdUdvNGdQZ1FT?=
 =?utf-8?B?dllNYUVObFJOVThyaUJPOFI5ZDhQbHhFbXppSEpFRldxTkNsRXV0TE51NTB0?=
 =?utf-8?B?SFhtdmRFMk85eno5NlRXWGR2Yy8xMmpieGJqdEowWFBHMVphMnB0ODFDOFlT?=
 =?utf-8?B?TFZxRTNCbTRuR0N0OFhINFJPamVldVZwYzgxSjRvUm5WSU53a1gvQWNXcVda?=
 =?utf-8?B?RmxVOVE3QWVQNkFCd1lmeVY4eTd0d3BjK3ZOR2FrbjR1anVQcDVhK2tFZSsx?=
 =?utf-8?B?SE4zWnNHTEhnOTFHUWM4K3JQMjZBbjRIbFAza0cvVkZuVGtTa1VLN1Q3SERK?=
 =?utf-8?B?b3MwZlZ1eFB4MjFEWVVuWUFIZFpVMXBRWmlUY056YUwxSEpTb2dKSEgrSStD?=
 =?utf-8?B?T2JaRXNTY0Uwc01vSVRQa21KajA4QzRacEh3RGNoNmp2bWNUZEZldTluMkt3?=
 =?utf-8?B?Q1JBWEg1SjZMV3gvUFF6aGg3ZWpQWGRWUzduY1BnUWJSSFhaZjBNN0lzUHB1?=
 =?utf-8?B?c0pxNUgzOHp0Q3RYaTRlSGQ4Vkp0Tk5oMlNpVmZoVmFNZ2pKUE96eFVpR0lP?=
 =?utf-8?B?VXY4aFdZOENyVUxQSm8yL0JGR2czZTZqMGhCK0dIbmhJVTE5b3hXTWZXTUxa?=
 =?utf-8?B?UzRtTksvcjgza3IxeUFUQnBuU1FvTU91a1BKSXBuUVZCUlNITVQxVlVNV1RE?=
 =?utf-8?B?SWRKZjgrTlFuMjhIR2tRRWZnb3QxZE5zQjhCL0grelJ1WStIMDkzdTB6Y3N1?=
 =?utf-8?B?amxZRmlYWlJmQ0hiemYxZmUrTldpRGx6NmRYTkIxZDFycFlWbm1BU2RVRHpC?=
 =?utf-8?B?Z01YMURuYW80MjZpNlNpTUJaZkgvR1hGYVMydlc1czh1dmpDL1ZZeVZZYW9m?=
 =?utf-8?B?SDV4SnRXQmFVODM5MjkwQ0JNaWtQTUh0Yk5lVEJuRjVGNU14bllNWVY0QWxJ?=
 =?utf-8?B?NUFWejI5MWwvRk1PNFNyeFVUeXhMZkNpT1ZOUmVMenRNUjhrUzNvdHJ0aVI0?=
 =?utf-8?B?MU1VcG9pTVNXWWdIaXBzSnNMaUhkc1VzUWhOUi9sRnd6UnJPMXl0ZWtxZmY2?=
 =?utf-8?B?RWZ2WWdOOEIvMnBTb1lZWW9aT05MeXZQT09BSmxPSU1rOGhMMUZXNUxaYTVo?=
 =?utf-8?B?T1J4eUNzeVdWVU16MEZqeDRjcjRSbkNNbEd1azBVM1BNUVlZbXdDVnFyWExm?=
 =?utf-8?B?SStFd01Od1BDTkVZSzZkUEYzVUJTVC9DTHBLVTArSnNxOGQ1cElHbkpYSjVn?=
 =?utf-8?B?RC8zZktTZGE3c3Fza1VXS0grQ0lLamkwZUtwajlwVXlrN3BnUGtvOFEwSU5C?=
 =?utf-8?B?aGQyVHJ5alVtck80Wm1kZGY1TUkzN3Q1ZFdTaXlEUnowK0pGbzlSY3JtTTMv?=
 =?utf-8?B?aFNVSm1ETGNLYTIzVk5MR3E1TTU0QWg0TGRTRGFFRzgzTGJGY051MDJNN1pk?=
 =?utf-8?B?N3N3eFZzS1ZBWlN3V2w5SzFFRXVyMGhQNklSU21LSUlBL2JaTTZyR1J3djF4?=
 =?utf-8?B?YU1XWU9RRnU3bjdQZ1RVR25lNWcxY0NRbEJxSFlMV3hVYng3UlVLNjNsT2Jn?=
 =?utf-8?Q?4HQo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb32f40e-9900-4510-5083-08dbd0b9a1c6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 15:39:50.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqxGGvVPz3xzpY2HH9CmJkifZQFc0+iKNazBd1RdGiSgnCoDfncayfbAxGK/ujQonM0BKKETu2d309q+BaV4dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> 
> > master side report:
> >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > 
> > BIT 20: TIMEOUT error
> >   The module has stalled too long in a frame. This happens when:
> >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > middle of a message,
> >   - No STOP was issued and between messages,
> >   - IBI manual is used and no decision was made.
> 
> I am still not convinced this should be ignored in all cases.
> 
> Case 1 is a problem because the hardware failed somehow.

But so far, no action to handle this case in current code.

In svc_i3c_master_xfer() have not check this flags. also have not enable
ERRWARN irq.

If we met this case, we can add new functions/argument to handle this.
Then we can real debug the code and recover bus.

Without this patch, simplest add some debug message before issue
SVC_I3C_MCTRL_REQUEST_AUTO_IBI, TIMEOUT will be set.

And svc_i3c_master_error() was only called by svc_i3c_master_ibi_work().
So I can think only case 3 happen in svc_i3c_master_ibi_work().

Frank

> Case 2 is fine I guess.
> Case 3 is not possible in Linux, this will not be supported.
> 
> >   The maximum stall period is 10 KHz or 100 μs.
> 
> s/10 KHz//
> 
> > 
> > This is a just warning. System irq thread schedule latency is possible
> > bigger than 100us. Just omit this waring.
> 
> This can be considered as being just a warning as the system IRQ
> latency can easily be greater than 100us.
> 
> > 
> > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v2
> >     -none
> > 
> >  drivers/i3c/master/svc-i3c-master.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index 1a57fdebaa26d..fedb31e0076c4 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -93,6 +93,7 @@
> >  #define SVC_I3C_MINTMASKED   0x098
> >  #define SVC_I3C_MERRWARN     0x09C
> >  #define   SVC_I3C_MERRWARN_NACK BIT(2)
> > +#define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
> >  #define SVC_I3C_MDMACTRL     0x0A0
> >  #define SVC_I3C_MDATACTRL    0x0AC
> >  #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
> > @@ -226,6 +227,11 @@ static bool svc_i3c_master_error(struct svc_i3c_master *master)
> >  	if (SVC_I3C_MSTATUS_ERRWARN(mstatus)) {
> >  		merrwarn = readl(master->regs + SVC_I3C_MERRWARN);
> >  		writel(merrwarn, master->regs + SVC_I3C_MERRWARN);
> > +
> > +		/* ignore timeout error */
> > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > +			return false;
> > +
> >  		dev_err(master->dev,
> >  			"Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> >  			mstatus, merrwarn);
> 
> 
> Thanks,
> Miquèl
