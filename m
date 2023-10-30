Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18037DBDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJ3QVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3QVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:21:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332A1E4;
        Mon, 30 Oct 2023 09:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNtg1qMhyX+vN6KwxK+aQF51aYMI2ev2pSeY6XWLmuEHLj9/vfbUXTifYtHvOcmpDNzrwR3QikKMomdW540JC3J2SbzeKFxnICu6en9+8zr0W87xN+zYNGRQ5V/6it7v0sdS+mYWUBk5mOBFrDqNXFyYdTmjUOIhy7w8sTHm+ahObb3e6lPuzLTZSjyAf6q4mTZxlaNK+5FtWCZoWwoJA7So3BUED2i9s/tjPiZWwABMaty/zf/ut9KxXdFabvjfbX/lXQtbLnRgZIE6u9XtCDPvsvcXAXfo0vIxiGn6vUXssNuUPIlF1cemV4d16KXUeWY3mH6/pyAuiuTVKTQV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y38L2EqdgHsvE0BDZos2jnfFi+3YkHIIo43lCl4t9oQ=;
 b=I/18GMFLLTus9x9dJ7XfeizQHHUTvMSeEBSLYPbjjQEDb3MmWyy56HGd2RMeQap9fAPJbnfNkaIlSpSSb8MwguNFd/9JiIVRFfXdE3hif52o7FkBTkpo+z8in2Gf8inrnV5R3Gh+GLzx9ZukSk00UZcGAjMkmCKmBlhOTz39bO52QrxEoUs+StXR1m/fFM1uPiNnKSvmq6woogFvjjtnI4ezQKvL0CXc81pSlNDGhOovDvNGDtY9t+SMRAaTB3sv0QqQshTsDt6LE9TPZUU077d0PLvGYyDPAPkwg0BDZ5MTdj2C5p/ffeFNv1elq27PnAlUOKXhmCfJnlxLJYTbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y38L2EqdgHsvE0BDZos2jnfFi+3YkHIIo43lCl4t9oQ=;
 b=QDebjEHSewECZjMeiN0gAYIVLPik9qrJJD+He/0WDSHdzOHe1MIvmk9zZW70uaUifOgNiHBS2EDv4lLWOamr4bT1iwnNl52D4JRK1dIUaRuuGq2SWA1okBofUhDkzNPBwSsugykmVY0xl0GORlfpkMMFP6mCJyl3IsHNWKtVt3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 16:21:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 30 Oct 2023
 16:21:40 +0000
Date:   Mon, 30 Oct 2023 12:21:32 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: cdns3 uvc first ISO parkage lost problem
Message-ID: <ZT/XkhOvbucxA90V@lizhi-Precision-Tower-5810>
References: <ZTvhEl+JcnhJXcrl@lizhi-Precision-Tower-5810>
 <BYAPR07MB5381F7224612F0C0793B6B29DDA1A@BYAPR07MB5381.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB5381F7224612F0C0793B6B29DDA1A@BYAPR07MB5381.namprd07.prod.outlook.com>
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 136ef04d-367a-4d88-e823-08dbd9644c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEM/r1YRgvh/YLqJsfgjDwvhRY3Q1I0A+Jlct4XVkAmJb6m6XeeBsh9kHpVDHPVzSfaleaChbJmHUOaOnJcpPhqNVSmeiZPrpwV5n3l8TXUs5pUUzuTJeRI+OMNOfT74ZC7wnzkgbCKL4W3WYu4bBkaOK3yXToCLtvugjDjMxqoxL4ZRIv0Bds2XYdWiX8FbZFoZquknyXg5681klTfVQWW7g1KATCaSPD+MLM9TNdPqonJAbbvc/WV9wMnrBhmOs84korR+Ez1Vdy2L2Q7PtypA+rqOhiP2jdoKYcf3QqDvUEibHi0HeTG0kbmlw76Ikk/Ce6DV8xs2cwtAwb1XnoB2bxfXW27xU9WtnhzzN6R4+vVW+HVoyb1/QP4H+5yh05pwubY5WfuHJTQFU8QWp7+O5BoLRiXjdJzLpHRf7XF6WJw1QPyK5HQBi4cizFWE847U4Orlly+jbuv0uVchmz9oRvZtm6PlA+Fn2QytM04wz8KpK7eCI1XHNoROJ4KZUDS7rihw3UxAEErb0sT0+lunOkUiYrQgFFEASlJgXrizwNNUWr2FQnoPSYO+zNcFVcQnycngjJ0+bA4QCPku8JBn8NnoYw6RCm1VmMOvOn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(41300700001)(2906002)(5660300002)(86362001)(26005)(33716001)(38100700002)(6512007)(6506007)(9686003)(6666004)(52116002)(6486002)(478600001)(966005)(54906003)(8676002)(66946007)(66476007)(8936002)(66556008)(4326008)(316002)(6916009)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nd4S6CYL1HvWIxTPyT6EtaB78aidWHGxhICfAdeMcKzGPRyD60MRJDjUACnR?=
 =?us-ascii?Q?N5FysTDARewOd+WoULLE1JVuBo/JM4f+94bxhjXfUOdWb1noCRXJODGTJykk?=
 =?us-ascii?Q?t1UNZahYqvkkq5r3PiABf8+dOxQo/DUhAxdx+ITmzkZVRqQfhA2jOhkrbyvZ?=
 =?us-ascii?Q?I/uFm8PErzwRfUJWozR551PsA9xrvgM7shqbu5lJSq+1gIyhFvxj9y90t3e3?=
 =?us-ascii?Q?3NfvrfgMD8BL5lmkuVUhsEcXpELCqHwWOrC2yJ2nM7nG1u139ettNi/lJHb6?=
 =?us-ascii?Q?EeZOqlsKqT2K3Q+lhpLuv9XN8IdxObjLk/JNMQqq9xM8eAwNbnSy057vdIGF?=
 =?us-ascii?Q?/a8IHnnu1Lya9RZ29hMLaZSJDXk4f0MofrUuP/AAFHnl84fSm2WcyVrRE6Gc?=
 =?us-ascii?Q?Tab7ZVAcysnfMEhVOTUFEroISDYHzC1In4iT2Rx2AGZ4NOygDHz5+6d7cySr?=
 =?us-ascii?Q?zsSEequSeWEutOjulXBFuw8gpXaM6oYJtnKJx43xKcxZeON9HzNuMtAaeZSS?=
 =?us-ascii?Q?UcyTgxVMdMnnbsjpiUafbMNpEusmXeC9LWWk4ACQGWzyiK2YIw49eWkEJuU4?=
 =?us-ascii?Q?/blHTL7Nxe/kiXGrCIERBGSt3zlPCTpgwsXXnl9+xxUTGofW8C0l5gWdXyrL?=
 =?us-ascii?Q?zVwVKXqerkE9Iet9yi9eF61Ofjel2m9VHkVD+R/MFa/BRPvodfFySRN2/cXr?=
 =?us-ascii?Q?H0PRIJlWp3Z2pd+bbR8LuxRMV3tsRRqFHwymM+Yaqx+ROn3gYanskUqpcp9E?=
 =?us-ascii?Q?F4vz4chz8sj3KgDrMploJOex3u6Nwn3tvAQtypciL55lJH8os8Fxb97XZWem?=
 =?us-ascii?Q?DF1gFzxNoO6QRIhmdVaiftxVdMZ13CFJ0uG9cyMTy0cGgOpz7sggtvhoB4st?=
 =?us-ascii?Q?MtJ+b/AcNoAY+Wdr8VT0SRB1Jx+FK4Sen4jsp4wJjoJn75MnDqogAjanZdRe?=
 =?us-ascii?Q?HmXVBV4eAjGfqlQWfMESb7+iwPdD0jzbNgAP0jClVgLnxYFp+GZDSxsZ5q1b?=
 =?us-ascii?Q?ewAzz25ZydQERmIUf1f3MbUYOGua262MHIZJHUYdWIJCfiKKS0T+hlYLtPax?=
 =?us-ascii?Q?6mRnI2oAYDWivNJLS7sMg/WT2phDVo737G0HeEZw5tY9w91MxFRMNfdW7imU?=
 =?us-ascii?Q?zF92a2kZPm9OAlRKQkXDxzNxU9h/o82hYNaf52HiaWDscdqpivupMfdDtpKF?=
 =?us-ascii?Q?uYMuILM3oVLd6UoLvFFRyU28M2q14IfHeSGQDGhRrG+lTw0zjDxJWwnXdLoU?=
 =?us-ascii?Q?vI3sGoZwV89AKntBgYyXKf9moJGOGeQq06GhvS+CMtfzTpKxu2sljwwRmCu4?=
 =?us-ascii?Q?Y/Gqp5cyph334uwq2U8cP6EF9Y5xrlH0rmDUoA9g81Z66dD61s6OyrnX+Gsm?=
 =?us-ascii?Q?iQ8ezFHBd0rtIasjDzZ0JK6sGUMr+XNSuzy0kYKRRZLzZDKmWKNfrrRC0g9g?=
 =?us-ascii?Q?4KTcarOLo2IUtftpkoFjFBnQYWJ3F/QyqJRxHxTbCNDwWlcZe8HclUeqHEPM?=
 =?us-ascii?Q?M4z+jB3HHfua3+7vMfamiPjHrBGLOjHtxGkUBDC/DZEj9UyOTYhsFMRpNKsm?=
 =?us-ascii?Q?+vhRTmOHkyIOWZejbxU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136ef04d-367a-4d88-e823-08dbd9644c4f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:21:40.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAaioME1vfQL5GTPICAabnvp3evdCDZZEQCxCOL+uhnz2bZzMAkjQ5wByCKENF8fn1o2X2kL08ATfuTIrGRo7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:34:48AM +0000, Pawel Laszczak wrote:
> 
> >
> >hi Pawel Laszczak
> >
> >Recently, I met the problem when use uvc. UVC report jpg header error.
> >
> >Basic reproduce steps.
> >Gadget side:
> >1 -
> >	https://urldefense.com/v3/__https://gist.github.com/kbingham/c39c
> >4cc7c20882a104c08df5206e2f9f?permalink_comment_id=3270713__;!!EHscm
> >S1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAGXUAPYyPXDL
> >FasSqYt16xq0RGT0Ff-cP4A$
> >	uvc-gadget.sh start
> >2 -
> >	https://urldefense.com/v3/__https://git.ideasonboard.org/uvc-
> >gadget.git__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9z
> >eMkjAGXUAPYyPXDLFasSqYt16xq0RGT1ogOdRQA$
> >	uvc-gadget -i test.jpg
> >
> >
> >Host side:
> >	https://urldefense.com/v3/__https://github.com/thekvs/uvccapture2
> >__;!!EHscmS1ygiU1lA!H1h8GlLnbS6vqklXm_2qGyinP638O62Kk2eLB9zeMkjAGX
> >UAPYyPXDLFasSqYt16xq0RGT1MNlKiXA$
> >	uvccapture2 --device /dev/video0  --resolution 640x360 --count 1 --
> >result 8qxp.jpeg
> >
> >	It will report jpeg header error.
> >
> >
> >After debugs, I found two problem.
> >
> >Problem 1, sg is enabled. so uvc driver will use sg. each package include two
> >trb,  trb0 is 8bytes header, trb1 is 1016bytes. total 1024.
> >
> >num_trb here is wrong.
> >it should be
> >	num_trb = priv_ep->interval * request->num_mapped_sgs.
> >
> >because priv_ep->interval is 1, I just simple set to request->num_mapped_sg
> >as below patch. USB analyer show one whole 1024 ISO package sent out as
> >expectation although document said only support one TD when use ISO
> >(Maybe my doc is too old).
> 
> Support for sg  in uvc has been added after upstreaming this driver, so the driver
> needs some improvement. 
> 
> Calculating of num_trb probably will more complicated change.
> 
> You can see how it is implemented in 
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c#L412.
> 
> CDNS2 is different controller and support only HS but has borrowed the DMA part from CDNS3.
> It was upsteamed after adding sg to UVC.
> 
> Regarding TD, it is true that controller can support only one TD per  SOF but this TD can contain many TRBs

Okay, great. I can work a patch if I can resolve problem 2.

> 
> >
> >diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-
> >gadget.c
> >index 69a44bd7e5d02..8cc99a885883f 100644
> >--- a/drivers/usb/cdns3/cdns3-gadget.c
> >+++ b/drivers/usb/cdns3/cdns3-gadget.c
> >@@ -1125,10 +1125,7 @@ static int cdns3_ep_run_transfer(struct
> >cdns3_endpoint *priv_ep,
> >        struct scatterlist *s = NULL;
> >        bool sg_supported = !!(request->num_mapped_sgs);
> >
> >-       if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
> >-               num_trb = priv_ep->interval;
> >-       else
> >-               num_trb = sg_supported ? request->num_mapped_sgs : 1;
> >+       num_trb = sg_supported ? request->num_mapped_sgs : 1;
> >
> >        if (num_trb > priv_ep->free_trbs) {
> >                priv_ep->flags |= EP_RING_FULL;
> >
> >
> >*** Problem 2 ***
> >
> >According to doc and my observation, looks like hardware fetch data into FIFO
> >when get SOF, then transfer data when get IN token. Each SOF will increase
> >TRB regardless it is ready or not.
> 
> Yes, but this fetched data will be sent in next  ITP. 
> 
> >
> >When gadget complete equeue ISO data, so SOF will increase TRB regardless if
> >there are IN token.
> >
> >   SOF       SOF       SOF     SOF  IN    SOF ....
> >      TRB0      TRB1      TRB2      TRB3  ...
> >
> >
> >Host may start get data at some time after gadget queue data.
> >
> >So TRB0..2 data will be lost.
> >
> >If it is audio data, it should be okay. But for uvc, it is jpeg header, so host side
> >report error.
> >
> >I checked dwc gadget driver, which start equeue ISO data only get NYET.
> >
> >I check cdns spec, there are ISOERR. But it is never happen. According to
> >document, ISOERR should issue when IN token and FIFO no data.
> >
> 
> Current CDNS3 driver has disabled ISOERR. Did you enable it?

Yes, I enabled all IRQ.

+       if (priv_ep->type == USB_ENDPOINT_XFER_ISOC && priv_ep->dir) {
+               priv_ep->flags |= EP_QUIRK_ISO_IN_NOST;
+               reg |= 0xFFFF;
+       }

Supposed ISOERR should happen even DMA is disabled. 
But I also tried enable DMA, and using lenght 0 TRB and link to loop.

Still no ISOERR happen. I can see TRBADDR changed, but still no ISOERR 


 irq/447-5b13000-200     [000] d..1.    78.662729: cdns3_epx_irq: IRQ for ep2in: 00000804 IOC , ep_traddr: c0086018 ep_last_sid: 00000000 use_streams: 0                                           
										 ^^^^^^^
 irq/447-5b13000-200     [000] d..1.    78.662851: cdns3_epx_irq: IRQ for ep2in: 00000804 IOC , ep_traddr: c008600c ep_last_sid: 00000000 use_streams: 0                                                           
 irq/447-5b13000-200     [000] d..1.    78.662975: cdns3_epx_irq: IRQ for ep2in: 00000804 IOC , ep_traddr: c0086018 ep_last_sid: 00000000 use_streams: 0 

STS is 0x804, only IOC set. 

Frank

> 
> >I tried below method
> >	1.  Delay queue TRB, but no ISOERR.
> >	2.  queue a lenght 0 TRB,but no ISOERR
> >
> >My question is how to delay queue TRB to ISO IN token really happen to avoid
> >lost JPEG header.
> >
> >Frank
> >
> >
> >
> >
> >
> 
