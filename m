Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D237FFE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377097AbjK3WAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377087AbjK3WAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:00:10 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AA310FC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:00:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNSLkU+EYw0SmaAUDcqqqZ75nHtHqAXl0Hx3036ZuXA8KStF9Ergj/y0sxTyV1+UGDsHPYxfhdaZAieXtNXkbt6Pzn7YoLI6n8/y38oB0BfGxj4NrJ5gTlteOsYeVCLbdkPCJT04T4OsCV8cg/OUMS2lXBuDG6jH0yqKJRDKjRobubZ8NnIqoz3do2/4jDVkBMs+KqoLml00CsBeeVIylEdq9LUc/GXjgMHV8nRQXJYdb8qf7yTJ8GNjU073D/FOoYasi/V6Dj6z0DI4wG86z3xFZYYFMTUfmmTrIYFyl0AmbrnWNmq7RfLFcqssDcWQ6hCTykOISgT2Zg//5cl7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbB7fLVU7Rh4unQt2fXNYoK5SNQ0WRIoM6f1/wDA+pI=;
 b=b1IEe0a/HUSni2Tr90XHgm/NiX9LfvwhNOOUnRyrpzi6ozkzdgWQQ2hUrbcGs91R6kA13rVd2vqa+YGbl9Eh2aTpfomoGzqPFq1Un6vmrAis2BGW57alKsDYsUmj1e17WIXe4JjaTbgoFAEHF4csRPKGWGB5JckzgcnGrpc+eFveEecH4QyVo3SWE6tJer7QGwwXVnvfvhQ/AvtpEeF66rxrbRRK1O+MVsMYEv2sxiUrYzfcnAyGXL+sqPwpZTVB0+EFGACdkyejlHj2TjcQgENuP+y+yy70/v3o5NVdjE2/OyAvVDvQUmXkLpjNw6gTTf20zMnsxLAeftMu68s6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbB7fLVU7Rh4unQt2fXNYoK5SNQ0WRIoM6f1/wDA+pI=;
 b=B0ycI+ZM9HCwBTVXvBlnQxESMntS7oNrzabHNowvg8xuTj/o/BA7gcDTPVxAfhfU+HWpaKhlPsXyfZBgIVFkv2cDEYS3uivrCq/A6/pi0sauUe4+LFd+9Pgg2Uv7WiyXnVVdvStYvbceD99H6qV3n6lQvoBMo1MQYjx1btFXocc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9392.eurprd04.prod.outlook.com (2603:10a6:102:2ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:00:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:00:12 +0000
Date:   Thu, 30 Nov 2023 17:00:05 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 6/6] i3c: add API i3c_dev_gettstatus_format1() to get
 target device statusy
Message-ID: <ZWkF5TTkMcdUVTaP@lizhi-Precision-Tower-5810>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
 <20231129221225.387952-7-Frank.Li@nxp.com>
 <20231130111959.11afd8a8@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130111959.11afd8a8@xps-13>
X-ClientProxiedBy: BYAPR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:a03:40::47) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: cf00c2db-5b2a-48b3-aa7a-08dbf1efba41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMFXG3WddDFOozE3M7VuCCguSo2pZWEwphooq132tKpe6CiBVTY4z/U9PIarfM+q+1KsW7vaAlaycJV6p/5zVuIrDFyYO+0axOWFy9rl22JJyIvT7DHH+f6DgGSiE1V2PCDXlRykmJeUaGdO8Q3u4+ufk3iHQYyxlrIyCwnLw4Zsju/Ous1c4vwpF41JlrAgNnJfMuoiGeeSBIEHURRQ5qAuIwRuaZJMECsioLIhUJTCaUi+wpC3pPnZbaDVKhMzfvOxim/p/82CmWTvJXToQ6Qr3IfJ5e+GBnOmWuSAxBHePK5g0Edh7A8qkQIaimRntiKdoEYraDoK1Vr2HyrmO5W8o8FieN2NKVwf7WS9ExXBIT2M0P1dLx3Yfn5kQ4Ksw21tvZp3DHbG4bg81VJ+fWASSToUMv0e20+A6ypcbKG5wSOmwQLPtXRgpjvm5Mt3LrEXqtuSn2N1CIhrwWOq+KZ+pEIWVT7jhf41WQiHEjYYKb3ordwglxUyaFqRNFDairIg2mlfEDxYNSpxEu+p8AeME+5OUJmLx00DPoDb/h7LWUtWwvQqmZNKD0rFuIrUKrQPM7AUzUVtApLKe//OWBxutbCCLT4CHmJCEQR6YY24oS/NUfZyqsosEozEx7tt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(86362001)(2906002)(38100700002)(83380400001)(26005)(66574015)(8676002)(316002)(6506007)(52116002)(6512007)(9686003)(4326008)(66476007)(6916009)(66946007)(8936002)(66556008)(38350700005)(41300700001)(6486002)(6666004)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qfQe9mzy8JQEHAzb8h5aTwZPumbn9okilKaKIcEoSxMkKTg4y0I/dgFhSt?=
 =?iso-8859-1?Q?abrU7AOoJBpqiZsakaP+Od695t14ebtmUQFRQZcVG+fYBCd4NfETK0G6uX?=
 =?iso-8859-1?Q?cNbXHLw8yUMhd/YXu5rvKpnV19T3/8715RwwWXHOS/g6IzslgQHKnSMFSM?=
 =?iso-8859-1?Q?p2y1/Whv3s360qNLCmBQC8fshCU288NBqz91I8iAym40Mr2efIhm6OKZ6k?=
 =?iso-8859-1?Q?XupwhQUpZXe2AGLgvYRD1PcUYHMXBCI0bEknHVb8LD+5GLsuvFSYq4/3kc?=
 =?iso-8859-1?Q?gBo2I+DnldQ7jdbfEqBpuNC7VOJ/2RbxTyt4nYbQrh7gCUm6Kx0wi8PVLn?=
 =?iso-8859-1?Q?TcPemy4AvIO55/njXZq+wsnAQgj/Ylkm5yEQLupny6unKO1KTYSxQuPOQT?=
 =?iso-8859-1?Q?ZhT1AykCvBjAy+94PTQ0kwEM3HqpE/6spyz5fEJSQz289yzz0c+EC+pIJ6?=
 =?iso-8859-1?Q?wWNpbsmMoAkErlZicmucZwx95m+AWpWYMS8ibM8sf0ip5+OexqMo/jAHw4?=
 =?iso-8859-1?Q?5QxC8VGBzjJbbQVaA3JNYYh3P5FFJIYOTDdPKuVmw5RKKzeF3iMy2Cl+zM?=
 =?iso-8859-1?Q?M3VxWZBFD4+0wr8Ctng6F65XyHKtpD1aJ1vA2xeghM1o7KaJ/kAmMcMtDj?=
 =?iso-8859-1?Q?zPk3qqa298c0H6BmvTvtIHOrL6aXuOb7/qt+ajDTsC8U/67+mjX0Oei3oZ?=
 =?iso-8859-1?Q?0XpZRkGSqX95wYhlYmKirqJSyQGYzj7V5SuBmp33fpUZEVLLUFoknSYxy3?=
 =?iso-8859-1?Q?GmyXDvdqc30VxTwmJieh3QbvlxQSpLJ4P2OSjYbRtP3xozZ3sJthUBgOoa?=
 =?iso-8859-1?Q?9VlOl9CEYLXW828tAlJMJAMDPnZPfI9NWkVxnCVjaaU9O+lNcVftRU8n2z?=
 =?iso-8859-1?Q?M/Kp7501bQin+WOuQuEbkyKw9QgruPNAg3cIG4eBpSjnnL0sis5lgDTnIx?=
 =?iso-8859-1?Q?N3//9fjkA+0qNOthNVBHw1e8QHIUtRn5mQp3IUGurd5FnYHQP3sLkRwcq5?=
 =?iso-8859-1?Q?eZRBvj6cP/CCOmksAJ3urzQw3j9HwWcUpTSFPSFjRg36vGfBd223by+gi7?=
 =?iso-8859-1?Q?t/RdshrkYkMPb5gbwzCbiiS3x3G1VEEgMcUMbkdl/vpe2Vtww5ppjOl27z?=
 =?iso-8859-1?Q?rU7U7LfYpMNs0c82DUr+C1wpC5qgec8Lrpup2jJ+JsirydOvcPCmNsLAzR?=
 =?iso-8859-1?Q?nVEcC3G8ehk/U5P0Xh1sgnBw9qp0V33F+H0e60NijfJyvFnf85WjJm36Eu?=
 =?iso-8859-1?Q?W/YtB2jZzbbIm3hNHV7aW7Cvj+5SeLaYbTCCVti6P26ZMZBfVnnF3S8bKA?=
 =?iso-8859-1?Q?0DK9sjlMrgOGAZFjoHe7aRHrp8TkWEtnY3fRaLrIjj1vrHR8JizpPq6bTD?=
 =?iso-8859-1?Q?k6MbykIx+kijko1NvHyitlkVTakD/AULpp1MRTfuWh+BHNus2EzPSDlJZ3?=
 =?iso-8859-1?Q?2oI1+SlvEQTOlhmgboYhfJXIpBHicBep7LlHh6pYYfWzFWKI/FfK8b+niK?=
 =?iso-8859-1?Q?g/inhrjzj1jYVLWPvxldWCyRNsnEmXKCXypppwBy4/tUVd/2zxXw5Me1PJ?=
 =?iso-8859-1?Q?FXY981hyS24hXCW8ixKF/OV8xHlmGgs5yildzdlXRpOaDpYnVbD03XwQbr?=
 =?iso-8859-1?Q?tt1TvxARsNaqM4qwP+10VFPHeYeF4Ohym7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf00c2db-5b2a-48b3-aa7a-08dbf1efba41
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:00:12.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWhLRqf0jPyBCS8vdXpu/R5Nna+VJKpuRAZKD+Tkri73t1Xsjx51lw9MDVF7vn0eZM21Ik2PIth39h/jZY00Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9392
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:19:59AM +0100, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:25 -0500:
> 
> > I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
> > Get request for one I3C Target Device to return its current status.
> > 
> > Add API to fetch it with format1.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
> >  drivers/i3c/internals.h    |  1 +
> >  drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
> >  include/linux/i3c/device.h |  1 +
> >  4 files changed, 52 insertions(+)
> > 
> > diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> > index 1a6a8703dbc3a..aa26cf50ab9c6 100644
> > --- a/drivers/i3c/device.c
> > +++ b/drivers/i3c/device.c
> > @@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
> >  
> > +/**
> > + * i3c_device_getstatus_format1() - Get device status with format 1.
> > + * @dev: device for which you want to get status.
> > + * @status: I3C status format 1
> > + *
> > + * Return: 0 in case of success, a negative error core otherwise.
> > + */
> > +int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
> 
> I'm not a big fan of the opposition between "i3c_device" and "i3c_dev".
> Could we clarify the prefixes?
> 
> > +{
> > +	int ret = -EINVAL;
> 
> Init not useful

No, if dev->desc is NULL, ret will be random value without init.

Frank

> 
> > +
> > +	if (!status)
> > +		return -EINVAL;
> > +
> > +	i3c_bus_normaluse_lock(dev->bus);
> > +	if (dev->desc)
> > +		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
> > +
> > +	i3c_bus_normaluse_unlock(dev->bus);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
> 
> There is no user yet. Maybe this needs to be done in another series?
> Same below.
> 
> ...
> 
> > +int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
> 
> ...
> 
> Thanks,
> Miquèl
