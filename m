Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94897F4DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbjKVRAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjKVRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:00:05 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255621A4;
        Wed, 22 Nov 2023 09:00:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3q+ZwUTut7ohF5l/yAFunUpOxgCO1CVVoO/51BnPzeeETaVx6oEnkgrFahqUlgo6r7i6tKRFqWrffCBgJXM/eZgXqKqeBr9kle8Vz0MYrYvPHdsDuFwjngv8kyxCV/gRRbYm7Os8eis3gq+j4z3FjKDFVMKe6sXiIGWaGvIYfCgN0XorrtA9ZzcB+V3K16ULr3D9Z6VjtAp/K8YeUSUfROdJJ/eiFLhu9iRG/2yVMj1eZhYXJ2qLJy2ykiMa2wOC5LcynFcn5ToJyvPmirW2moomYa8EFaA4pheuVWcmYTH20JNNt9Y5Nk3tomJqfX4w3RlxyWuTez0YPl7ppP29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUw6tKfDlPb18z0VHI1Txzt14Y0sPQdkNz0a5hSVmeg=;
 b=LsGyYv1ZhpPjUISLvdTT/yDzyeRtyMOxskrn4mxpu3auZWcyntQzpUN73MyOEiGnCXcoGKW3E49A7SNTxyesXvMRSq6SOQiS9gQyojUB+EdQLuHQTkfrBfg5yFAePQM+M2DdJOEGWCP9qEplYSDP7BMT9+2SgNHfsvJQhGgsHVRjexVgtPC2X6P3OMNiuIk+juG0j96l0hzcFiiNntKl3zxfTPVfFasOPjKVZXpKzTC5zJHFevTVlaA2qDwgqtbLnn69on5XJQwA5H8cWwwl4eBHsG/baDS5IHtSxkXnLcsL435fdCD0OaFt1cnbZtkN1CBOp2DQlQfhk/Mb2rzezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUw6tKfDlPb18z0VHI1Txzt14Y0sPQdkNz0a5hSVmeg=;
 b=mJ58GoWHmAs6Dkpp74ULo0zg7To6IFcqd3xuPCIBsjERoemMN9rQ4CKrMDboCHZg0V+gXCI6bnseImzvHTJXB5ANPro1fdCj/AAwVUgmD29J/T++g0Wt20OfK3e6gXhDSfTQAbg7r/rnvxMkdjRx2I+X8/GTaUzFgcf7QU7R2IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by AM0PR04MB6866.eurprd04.prod.outlook.com (2603:10a6:208:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Wed, 22 Nov
 2023 16:59:59 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::4dc0:8e9a:cf2b:137%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 16:59:59 +0000
Date:   Wed, 22 Nov 2023 18:59:55 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
Message-ID: <20231122165955.tujcadked5bgqjet@skbuf>
References: <20231120115839.74ee5492@kernel.org>
 <20231120211759.j5uvijsrgt2jqtwx@skbuf>
 <20231120133737.70dde657@kernel.org>
 <20231120220549.cvsz2ni3wj7mcukh@skbuf>
 <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org>
 <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf>
 <20231122143618.cqyb45po7bon2xzg@skbuf>
 <20231122085459.1601141e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122085459.1601141e@kernel.org>
X-ClientProxiedBy: AM0PR10CA0111.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::28) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|AM0PR04MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f2134d-f698-451c-54b9-08dbeb7c7640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfvVjSdPxydT9Co3LL85Iyar/qeRkrBn/La0vNGJHx5/1bUFy+pfIOhfuCkWrYyI3fl0CS/lfaImOH+GnGABaLDiAcqGAE3QfWRzgH/o/nQhiUYunM0bOhlN6IgiEhUhvq+4l0TBA0ONbFeTXvy02rjp893RJA8dlheIchjy6uRZfJZP5IU02p5/UYU1OgvLlmIB/Ym1p19Kzx+f3xLRQXE0WJDcBnAHB2+44iy6fttUDFZVZw0UMA/zBVvn6IamRbd/Ieel1YS8KoYE0uoYIRza+OPjz14UzCg38WmvgErSOcf71dvcnuI9lmfTtn9d1DcUDmy8NdYcmJm9GF3QkJ1yQNHj43PvvWw8Zw5gqfWvwjyUfCQbLnCoIaMMdDqmXQ78XIEFUfOQrm72ozPk2PJb+X1lJLcNtNgNgRGqzaC8Zb3H0MHqZArNHTJqxIP8aKHMoCB31G+dmXTTROQ0CSHrGDz2dqy9OHzjPp4ngjtGkRc3daA6mXkzlhnnpUVYM6S/BgiOmaTKVtbhYXDciPQtZ2lDJYCVvNJtJlovxcvtZDbh+L187Ba26AS3RWv7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4326008)(41300700001)(5660300002)(7416002)(44832011)(86362001)(2906002)(33716001)(6512007)(38100700002)(9686003)(6506007)(1076003)(83380400001)(6486002)(6666004)(478600001)(26005)(8676002)(8936002)(316002)(54906003)(66476007)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vgdeN2UK86kWuyf7vuAEbhou/D3IDHAx6hU2ZQ1ZcVi/ZF681ih5nomO4FJ?=
 =?us-ascii?Q?V/k5fFzC+p9WVUQYnUSCWriW9HvGqskCKznAh4r9Uet1QPBnXo0QDV5he8Y8?=
 =?us-ascii?Q?5mTb5py9xVRobK/+UgmBaJRwWEiFQtLcG6MctNz8vEJFQaznjmfH5BMvY+Bk?=
 =?us-ascii?Q?PliIezPz7gyAkmMP+TFtm+YeBAhPOoydgQRyE840jFwRK2zwpnivJ60KH8Yh?=
 =?us-ascii?Q?S/UG0bciVfJ6+SQ4tNy2tkWHhfSK0dmYebmqnrKDDYetwf4hSiKzVCjQg7pn?=
 =?us-ascii?Q?Q1nW1flq8F17I2OlEdWAS4MdETTe3yHmAob6ebGvSjVaYlINh4yEOMv/sOSx?=
 =?us-ascii?Q?nqW2SkvF/OwlTFHrxnPx7Kp8H2xzd2942iHGL6Vy5plF1ttYyxnUJ85giwUJ?=
 =?us-ascii?Q?qCuF/O+olJTqRJQOkts4y1/6O1vsmlrrKA97yjG/3MOJn1erSzdoSuuOhurI?=
 =?us-ascii?Q?naGinb8uuXe3W/lPZXNx2URrRYWc1wUQXv7L70QWKYQFGtWaKNuOiPK/AosG?=
 =?us-ascii?Q?Hn5XRf1KGe584VgVMQarkwcm6pHDyT6p1TFP6D1NH/b8GVNiLSlTERb3hl1g?=
 =?us-ascii?Q?66MeU9Q/eX8KiO9M+I4Pn+ElK+H4BHMK7f6An9BX2Ymw0ibW/TfbaeR00yAw?=
 =?us-ascii?Q?ad0Foyy/ksfnZzR40ddMlavcrGXUS5Qp8DrcYIdA+6KZBbJBposiy9c3/f6U?=
 =?us-ascii?Q?ET2WvHfcCdbvWBZyR9qhvMfgsG0887OM0Q4A74PwYjKweK95KTWwddrGqbcT?=
 =?us-ascii?Q?oFVIAAeOemuv91EhOOXLsoVZDzJjgmgfR4QZSVGb2l5mob3xafw9ZWHESHih?=
 =?us-ascii?Q?5v0So1wJ+we0rkt2l0Fkyp9SLzOkp8IDJi2/dMEE5aJhqCujkiFlL5i/uLsq?=
 =?us-ascii?Q?eSz2sX+2oiSuENwJXZI7eI3cxLvUA8BJgZLqNpWpStq9Voq1HPnFKdlYtxHa?=
 =?us-ascii?Q?BY3tCBcs+bFsf8OY16JgXlFVh4Uchg91OnTviGMQ7osaU5R8QZSrqxiCs7id?=
 =?us-ascii?Q?93xOUMAe4Dibva4ekJhmKFoUGKWBGZOvRGHdgnx8fXODzMvNnfw2U8pI1OLZ?=
 =?us-ascii?Q?0j2wILyu+iqpOJ5mgknI+ozGoKa9/U87V/5aRBnBLf9nTPs9nH9ixcmzByuT?=
 =?us-ascii?Q?vtZ8C7J9d2UT0/hiXSDD3U6Z/frCKhNQJDvslfYy353jCY4tdcoO9zCwq7eX?=
 =?us-ascii?Q?ByI1JCtr+5G1ubOwymHaKqikIKJnZKah07yzAamgaGTTPQEVlktP7/b3s0eM?=
 =?us-ascii?Q?K9iXtsMVmLKyK/5ieUr61Mi4UaYgvzdl2M4FpWdIcaVadd4SBu9UsM0Ghn2t?=
 =?us-ascii?Q?XDdy+7fiOCgCf4U2wcRlOKwGXYi1rPogSPZsfjbVDC2OlUcb3kg9mgkLbJr0?=
 =?us-ascii?Q?lqyNwSc9F7iSNRudpvl9JjOZfUgNNjTKJvyKI+OBNesH9jt5g9rlUrDhNuDq?=
 =?us-ascii?Q?rC4IbJ8knT7J074iI0F6Gs2MeHkWkuuf3HA4Ewalt6mqBo0vJfMwjmad4Rhk?=
 =?us-ascii?Q?L1nuKiFCutYCNMSz/JBow0bUxCD4kcmvUXhDf7BsO2ZDfUiBK3MoZCUudeeF?=
 =?us-ascii?Q?068UQjDGS0Hoehe7uGyHwechn2PClVr6lNYgiGIxena0HtczvfD0NlVZlFZ6?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f2134d-f698-451c-54b9-08dbeb7c7640
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 16:59:59.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahUjPPpln3PPI3/5/Oi1lJZNHwT1x4XG3VVDxHv/Vo/y6vPol0HqOTVkMoksojHeteAp+GIj/MrRcuq0DXZWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 08:54:59AM -0800, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 16:36:18 +0200 Vladimir Oltean wrote:
> > @Jakub, for your long-term "MAC timestamps for PTP, DMA for everything else".
> > How do you see this? I guess we need some sort of priority function in
> > the UAPI between hwtstamp providers.
> > 
> > And even with that, I think the enums that we currently have for filters
> > are not specific enough. The most we could expose is:
> > 
> >                       MAC provider                      DMA provider
> > 
> > hwtstamp_rx_filters   HWTSTAMP_FILTER_PTP_V2_EVENT      HWTSTAMP_FILTER_ALL
> > tx_type               HWTSTAMP_TX_ON                    HWTSTAMP_TX_ON
> > 
> > but it isn't clear: for PTP, does the DMA provider give you an RX
> > timestamp too?
> 
> If we phrase it as "precise / approximate" rather than "MAC / DMA" - it
> seems fairly intuitive to give the best timestamp available for a given
> packet, no?

I wouldn't be so sure. The alternative interpretation "for PTP, give me
timestamps from both sources" also sounds reasonable for the distant
future where that will be possible (with proper cmsg identification).
But I don't see how to distinguish the two - the filters, expressed in
these terms, would be the same.

> > What about a TX timestamp?
> 
> I was thinking - socket flag to make packets for a given socket request
> precise timestamps.

So the ptp4l source code would have to be modified to still work with
the same precision as before? I'm not seeing this through.
