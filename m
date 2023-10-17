Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB77CC61B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjJQOp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjJQOpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:45:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572CBA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgVdW0bh8J/xDirMsTcAJG4tcJ5nehSdX/mygfW59ZEFG+oTPMEn0HlZdBn+WUZHGZwdyMrx/0vaO0ixbIFgsjRQKV3uuTy8wjBdSRA1uZWmuge7P4qInYfJ5rkqU+XGy9313l70Lf9+sjXZThuVg7Kgn8/ehYFSrNjG8fD5na9yudRYNVH5QpvC/ImJJ9oArG90x4j7yPAvspHgrvg+wGtzrgQ9KmcsjFHMoScZHwoqEjdSg/LHyspzzof06AbV0UF02vuOv6zxn1Ys5nN/cxSOluBlX3AgZZ3rQsbkXWPGqptTCQOxmvEzBNub+Uy9PhFKhlcTRpz+fb1bmu4A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPf5pEmwysBeUII9ydWPD8bHPHFBDv9RRxnkkVqeTJg=;
 b=XJK9xLVM7GWs0cgjntxJVSbV9hozA2G10edsSMpVfr+qesnQcTpE2DhxsgZ09LAdlXnldAm7xiNoXlOzBk51xs843X+UYllaDgkn9ExPoJARKJEJ6iWtWF2R9bG/1YNTPPL6o5KgU1r1raLTHiE7vUAQmyUNOkftJ6Bt/k7JXwADY0hvOTZ2TxBY6cC7ukYD9W0TbhmHj4donC5drdC2z9hf7p3X7qrO99P+OhrQ0Ur4w9GchsyRqmspl5KKv5UNyFVx2JusBjin3gazfzoCqNwoMYNlw5t1+vnIKujCjGtjO9daTuCLoEkUKIHQ5fmqlfvIdD9t4T8TrqwdVJbgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPf5pEmwysBeUII9ydWPD8bHPHFBDv9RRxnkkVqeTJg=;
 b=lJL3l/2at4hPBfvaOf1AHsf+h1XuqURnsEhiJ3lcUGl4NPPyT9YuHqUdGMLAJtiBoTGzXshpiSbToF5UNhYWMzJltO5pAVh2FNfGaeL8pIcGpkBwAQ+shC8IYnkF6nEoxKIWzQlH6BX811ZnNWXfIy49VDYJY+w+27rhKqko2O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 14:45:20 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 14:45:20 +0000
Date:   Tue, 17 Oct 2023 10:45:14 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 6/6] i3c: master: svc: fix random hot join failure since
 timeout error
Message-ID: <ZS6d+mANtuhoAcuX@lizhi-Precision-Tower-5810>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
 <20231016153232.2851095-7-Frank.Li@nxp.com>
 <20231017163335.16770af2@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017163335.16770af2@xps-13>
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b80cd-e53f-4c3d-5170-08dbcf1faf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRpbrGGsov52htAgP4O3ZTOWUgcgNVM+OCBAzqLGRpq2pstUKmmCjGpKrbhQ8HPt07wyJmQBtHWGvv5yT0+I1ZkAd7hX1NWI0/f9l5Lj6njgE2K2NZsd9pgdQz+4efsSfZy+nKDzf2cZhTOhfHWX+/GeK/aOJFec3DO5jSaTOQ3zOv2NCwHqnurKoC6q8DQG5q4fDDlhk0wWPp7K6qWSSaJ/KNjKTrrdZbnroDNJve96PTU3bG0jV6EHuH/3V0VT9rzD3aKiF201DKVDUqMxaj38G8PiKcWjMs8nnc2tW+tA5fgV5F51QSxu62vpsKpo7T09gUWx0ciJX5xk4zkOVYQEyUfO5TeFfdF7cHP8GGk9/SiItlfbkME7egdo/d6fWi17GNRMRlv6HV9Ulfe0CHqVivmPX+jGy/axd5d/5pwTENBoa1hLYtDWhUOsFbeS9Qbxf0rRNAtXmyzK+Kiju3c8ESUiSjZWYX//ATJFonHWgpg7mdD5sozS2R5lONEYNNaV51GOU+qxKy2Lc2A/bjKmGpAzTdVNC6SXobHVO6xvPQdOf5upw4gmjBN+nr0Q85vsDSktQFojQxkzegcT44kTXLhrhav2Gtv3UnFzsvjORR0Y6svNTPECiikKzlMomVzb88ycbLTo7TwohuLWGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6486002)(478600001)(6916009)(66476007)(316002)(66946007)(66556008)(66574015)(52116002)(26005)(6506007)(2906002)(6512007)(9686003)(8936002)(33716001)(4326008)(8676002)(5660300002)(41300700001)(86362001)(38350700005)(38100700002)(83380400001)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRza0NnbU9LSUVFMDJLdSt2R29KRWRVOTlnTk80ODNpTEFsNXRNeXovRVVQ?=
 =?utf-8?B?RmRBWkxSUndxTms2UjUrUHdEWTF3QnNUa3hWaVJkOFdEQnFaeVZDWnEwblUy?=
 =?utf-8?B?a0JLQjBsK3F4OEN3UlZ5SlBhSml5VjNsWDQxSDhDVk0vK3RUOTlJc1JWL1BB?=
 =?utf-8?B?Z0dWM0NLZjFhSWRSajFzbmJVTkdQeGlUWmtGV0daU1VYQWdTVHNadi9VUzll?=
 =?utf-8?B?U2VwbVlYZ3oyQU8xbzBTbEs2ZmltdWdFOXY5MUE5aGlYUTkwNjdFQmJ1cTJx?=
 =?utf-8?B?WCtzSlRlQXgybmpxR2pMN2hLeXY0RkR4ZjhEeDRqMEdIMWUvVVpyU0x5ZDNJ?=
 =?utf-8?B?b0VzU3NNLzlBdUpBTThqN0ZRNTNjODk2N1JUaXAvS2pOVnJPREN5LzVnYjhV?=
 =?utf-8?B?RUlpUS8vK25GWTZVT2hLK2ZjTVJ4MWpNM29PUFNaSTdKQitCM2MwdXRLa05N?=
 =?utf-8?B?RE8zNGhmdXdVRzJYRURhZ1Rtb1hrTWpGbTM4Z013THlGaUR6R0lIS09qRHM1?=
 =?utf-8?B?Y3RnWThnSnpSYWo5WXNSWWJuV0dMQTZSN296V0dPUzA1RGlNUzJyeXV3bkZ5?=
 =?utf-8?B?bFVJL25IUVpRcElCWlFDTGRSMUI2UTd0ODM0WWxHdDNiRkY4RTBpT09pdkwy?=
 =?utf-8?B?RFhjdTJxVXZJblFlaFgrbHJhdXBndXpwWERKSDVBZjZ4cXI1NzRrUlV3VUtI?=
 =?utf-8?B?L2JROFhPZzEweGtaZE1JT0NaVUQxL0pkWmo2UDJ5SWJScE5WVm9PL0ZwbVR5?=
 =?utf-8?B?VlVMZXhCUk8zd2duUTlobkk4bzNpOEs1MzF3ZC83VjVsOXFEZDlrdW1jV0tt?=
 =?utf-8?B?bitZK1E3YmlYcjA5azkxVytpTUFoV0xDK3RCNGFXQVNvL2lHenE5UHZEemFp?=
 =?utf-8?B?cWxLUmdpRWNaSjVFTGJJdnRVL282dW4vRks2UlVPcFg2QU03RUt6WTdSK0VV?=
 =?utf-8?B?QzJRa3M2N3BKUlU0M2pGa3ByZVc1QUhDUmtVYjlzWkxuT2dpekU2Q0d3eUxJ?=
 =?utf-8?B?eS9tWVlsMnByN2pZZVJCTGcxRFBOcW5TNkFwdmVDdWxyakdiYVBaK1JmVHUw?=
 =?utf-8?B?VXZmclp5QWQrTnA0MkQwbVIxOGdDWnBxbnh2U3E4NzQ3ZXN2RDBCZjVNL0or?=
 =?utf-8?B?T3MzSmN1Ukp3R3JIZGtnOUdnVG81WHNEbmhSaWx6M0pxME9iaUlnUG16YXpk?=
 =?utf-8?B?YUNxZXBuRHZGY2NYNXUrNEU1MTU2YkowcVVCK0YvWjlMcTF1TmVVY3AxdHpV?=
 =?utf-8?B?ZmhUamZyeWJqdTR4UVh2ZHZWMUlwc3JWWTZUdHA5NlNFSUxlMSttaW85L09B?=
 =?utf-8?B?QVEwUzRlVWFaOFlybGZZR3VpL2RVREIwZ0taTlVVcUxmTjc0bnh0c2Q5UnJQ?=
 =?utf-8?B?Umh3LzVPQ0p2UnEvN2Nhblh5dVIvQ2xaSUQ4TmJhMUl2bWhoeVR1OWJDaFpk?=
 =?utf-8?B?RzNaVDh5bHAvZVFScUgweDZxZTRlNG1YcVRTaVRPUFBycGxPeXFtRjdCY2lv?=
 =?utf-8?B?TTk3UHQ2dmN3L29hQ1I0cE4wc1llZ1lMWElsQzNKWTg0UVV2dWE4ZW45VFZC?=
 =?utf-8?B?LzBHVDY2d3lhdGh5MVVZK01xLzhJSkozVmdUNnFjdFVUS1o1aGRnakZNL3o3?=
 =?utf-8?B?MjZpazA2VXFzK2hMYnlUWVBwak1qVjlGQXg2S1VLMEpoMzJUMXBHWlpwS1VC?=
 =?utf-8?B?OEUyYmxNM2I1NGtNNkVFWno0aThhTk8zd1JBdUwzSzdiWW42VHphcHJrdUtU?=
 =?utf-8?B?UzBPSW9TMTAyYkhyNUdvV3dxanVhYWdvbE02TmkxMm9wdFhZdm1kem01Y2Qy?=
 =?utf-8?B?MDNtaXFmSGtTUU15SG5lZDRTQmVDbEVxVm9qOC9iTkY1SEJBK2dySmxteTJU?=
 =?utf-8?B?YUE3eGxsMTRzOVpRL2MzdTlzQWFIYk9vallwbUMwc1UrVzNyV0RzNlllWlk3?=
 =?utf-8?B?ZjQ3UVBySlBTTVVCeC9lbnp5WTV0YlA4UWxIM01pd2wzZjZGZ1dDL1MzczNL?=
 =?utf-8?B?Mi83OWxocTVOdU8rOWRWOEVHYUZTUmYyMStjQ1dURFFWSFZKQUZoeFk4bDJD?=
 =?utf-8?B?RGRiNWxJM0NlcTEzRzVwbTBPUlllQWFzMEFlM0pzRHYyLzVVblZmay80UmpP?=
 =?utf-8?Q?QXihsfdRN+8i0txdVwqYbv5PQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b80cd-e53f-4c3d-5170-08dbcf1faf77
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:45:19.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvdDKIBJCwI4tGQmKCjsBDQUtD7qOma2BQn/8JjvszwwKF/cNCiHu89pymJlDkURS4yhTkr5mf0Zbwik32KJ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:33:35PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:32:32 -0400:
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
> >   The maximum stall period is 10 KHz or 100 μs.
> > 
> > This is a just warning. System irq thread schedule latency is possible
> 
> 							can be bigger
> > bigger than 100us. Just omit this waring.
> 
> I'm not sure this is the correct approach. It's a real issue but there
> is not much we can do about it. Perhaps dev_err is too high, but I
> would not entirely drop this message. Maybe a comment and turning the
> message into a dbg printk would be more appropriate?

The key is not message. It return true, means IBI/HJ thread will not run.

Frank

> 
> > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index 5bca369d6912..18bc277edc8a 100644
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
> > @@ -225,6 +226,11 @@ static bool svc_i3c_master_error(struct svc_i3c_master *master)
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
