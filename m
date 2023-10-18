Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364D7CE89F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJRUSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:18:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5F112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYg9zLgiUdRdP9MvzJOLGrKq8YilQCDgJVYW5vwBWWojLufAbJFKRJZEbdwtAqtluOnCscYS7sePBMwWUc23U6FRrVLQzJdirQSu/umksw520/0ZHbcRhIdEdTbyMSvlQn3Wz4lO/Xp6g2v/oYpbhp9nZ7IBAhsDyYz1afo7BCvebu687i44cnjyIJF2abcnT8Lw36j/WIMhyq3klUx4mmIppZRmM7mId7LGQYg3oZNfZ1TvGgt2tWrKjm5QKKUSqktUex+YckqEc1/jlltYzZ692TLC62lStW7xZ6RCwp6XL2f/mwmJS7GDvSq2wLq2eF7Fc3rcV4NGEuXp1DNHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ2Jl+fl9VN73p3RJsWj1LAmmN8loqE4eoH0waDHuA0=;
 b=UF5ehK26Qz0/Jsnzfszu95ifPg2wINfoFDgZpvXVf0F6JbVK+mzrcY3z0EaBihsdAUFgztlivr2t9ZHhUUHS5IQfEGNWPASDxfNcQ3zliqBOZHjttzACQcdkS6YTLaFHhRk8/tYmyEaa2kUhcfq3Gn83I4H/5yJLcgeSrIoe/xk7xWM8jovgbXbs1h4RBpFiYA/KeWNQYmdQNqyNpY+3axfdIREytyGnH66IQD3aiH54qHcMvxWyTLB57IoUklyXwhwF6yaQXbL+8LFPiqvpX8ixrg+Uz0p8ycaVbtn1gkihSKMwIrMZZKW6TWgisU0fTzY+K06W73RvL7dRxLiEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ2Jl+fl9VN73p3RJsWj1LAmmN8loqE4eoH0waDHuA0=;
 b=R0A7BkDEG101vX/KLtoxKkr11PAMEPC2GI4QdAV2JGi+kX5vEh1wsgE3eYI16EjdD/d9hxfOa9yb9rPUeOA7zGlwnAIeXSCDpgKPfCr6rps9MbssifV6G5yorydrfZ0pN7I/0NzW8yQc8rXy6/54fo/xl+KPCVyw3r9ywPTU5xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB6978.eurprd04.prod.outlook.com (2603:10a6:208:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 20:18:25 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:18:25 +0000
Date:   Wed, 18 Oct 2023 16:18:18 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH 4/5] i3c: master: svc return actual transfer data len
Message-ID: <ZTA9ir2zlFs7tC5D@lizhi-Precision-Tower-5810>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-5-Frank.Li@nxp.com>
 <af35a533-2126-4a61-a6cd-31ed1e615f2b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af35a533-2126-4a61-a6cd-31ed1e615f2b@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7eac22-d6ee-4ea1-f428-08dbd0176232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8Vp9apbNPiNLbgWVTnk5HmQJFcvF4AQtNWPWG6hvURgRQ50ue1bKD3TxKUTcuX6lETjd4xgtNKEQugYF3fouwlEB8ScMDrgSWWgerIU2ESqz3JT7smM49rFCKFXF0MKxXDKO9h38yhS2d54xHXlzqfsiL1z9gPqo4gMcEOdPiZBy6dtz726KzA0vDeJbJASKlRA92V91WfJiGoMe39sqShWvunPZsEAHwNFrcC4k9lUuvXxsPu8Nq0XR4YNM/IT2Inqtghu6Hy+xVPvLA1gYm4amP4rVMis1YrT1AQe/urb5XsRs4OhxbInYDxsNbEuvCR+N88HDr+ffe0IYWnPWj7SRba2ic+Q0O4LyGJ0cvjQMg4uMMbVqac7JKera96LBKoGS4OQCvPHVmMs7IF5PwN/d2b+y8GhIme/czkJohNNWCcVNPF9sF8wPvLvz9jsbem8m9QI7vg3N0hlCgn7qLH4UkMgT/bHVV4atObPxi2mRy5mHfC0xf7WoqDJKIPuuneGjNjSM2e5GuczP7enf0JAW3QL77qsaM0/qdJBcVAzgDQ8bomBj55u81MJgTyQGSGVidSnziaRywmREbklOeOh1XrXpQt+3TigKuT5apPvYoyeoepcgSL+2KI/amDw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38350700005)(33716001)(52116002)(2906002)(86362001)(8676002)(8936002)(5660300002)(53546011)(38100700002)(26005)(4326008)(6512007)(316002)(6916009)(6506007)(478600001)(6486002)(9686003)(6666004)(66556008)(66946007)(41300700001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGNdrQpt3OwTvKwLLTTmIPo4K5zV7wRNQ3Fu7XCPip7C8OwIk4x1xD6KQlFp?=
 =?us-ascii?Q?j40zmvfSQ/sYMM1WGTLbq9cskw5k8Cs2/6Tv+UXXQ0aRgIDqnyMnbQFMk62i?=
 =?us-ascii?Q?XH2+gcqrY7HF36ZqhKbhzUdG8MB3vJFvOmlVcbwqkHjttifXRsUAt2/intc1?=
 =?us-ascii?Q?gtzYATofWwTPZtcflIYE2N7PcsHqjQd5Ps2gmYftoKW0KuTG61/QncMyrNKx?=
 =?us-ascii?Q?FLcgr55WiWmvNJCuVXqYqkPPT5/8TccNHHI/QgIawIijqaTkg7X8uaHyrVe6?=
 =?us-ascii?Q?NvkMBDDWEAJZpdEMd3zglxdwArdE/kzFnlRepBvURM8dIHZ9Z13A+PcL8zWa?=
 =?us-ascii?Q?b1dnrkwbq7ihfRKZfsOHnMF+/CcY1scVEsZAH9NILMfZT0L262cWlX/T1PWh?=
 =?us-ascii?Q?174OmCXjb3FxuqfuAhcoRmos6ym+Zd72nFH0St35AnoB/D/4dmUsaooGbP5X?=
 =?us-ascii?Q?Oajx7u+X2siMMTaZwK7WiqztlP0MeIUDDcMuKVrHWsSvG3oXsBuORVj2z/Ju?=
 =?us-ascii?Q?Pp52gt5/PM/ZvWc5Z5El0BR0m/G12O9reOQFUVzIXUyGYoc9I/L+8E2Oj7IH?=
 =?us-ascii?Q?SiylEjeODhnZ6eNicXgf3xvvBL6JEbKYF+qc9C/XH028/gEzriHd8V59IjBU?=
 =?us-ascii?Q?F8T23Y2tzEbbVNNHyUhNp3pszrjQ/Am68rc1YLrQVT5W7tS/qgfhkE5XWW7B?=
 =?us-ascii?Q?X1gUC7jlzPjba1RBEkJf4mKm7pIMtNudtrPE5oIBnpuQe5JTJfZUWg7Hjy6v?=
 =?us-ascii?Q?nTZzyxHiBPJNcbY8wBojvg5vuLl9y7deJLMhPYjYUkMCz6E4LcSlM608H20K?=
 =?us-ascii?Q?7LxMV5Or7S91k3Kg50YrYaU1kzUK3a5coEWOKwCamkRDTpRxhLaaHc/ioRPz?=
 =?us-ascii?Q?JOA0Ga/uoxVWDVRxxy6XhI+mdeYz81Kf2zQDMID5oLFE8WGlEdCBJqgMl7LD?=
 =?us-ascii?Q?CwIMAS2/7bdxQuqIrimSxv5pkrEBDdp0tLLBzy9RRUQKZXMkPZi3IBsk8qP3?=
 =?us-ascii?Q?4HzAr4NEPYSBLotdzx+ybaf5LhDHmsg87BNEcVZinaBsh+HzUfRXmXf47okO?=
 =?us-ascii?Q?CY7M37U/r+YByqpSDVzsBG8f90uPleU7o3bAyM3nWrsxJVB6c3xIVRKdOFmX?=
 =?us-ascii?Q?gHlIyMQb3N6Ph4uJmt59aTK68drVt9gtGJzwaofI41lLHFuGmLM4F/E6Wmdg?=
 =?us-ascii?Q?UFYCpOrz0kvT7pFVIZk00RR01SC2+RjxETgZ4TIK8DrfKbhZ5rTTAeG7L5fB?=
 =?us-ascii?Q?dVRUEWcwbqlUtTZDtBvOimponxEo7NxcSjdJsp/HdzuRizOY9i7vQQb25jEJ?=
 =?us-ascii?Q?9VXM3cByuu+Z6Txvn4zjzYHT6VDqID0AyJymsQ21gNz4UweAjiTDIZrTOtXD?=
 =?us-ascii?Q?Kqo77SvUwpENTYsBghfFPiw6u0/ezJMpErvqikBwHdMLeHyYjwr8WpuY0GcJ?=
 =?us-ascii?Q?EJEG9RM7ZAwrKEhuea1qnhEA8j+D0qpUJx3uzjpYLM7hrK7VE+m0fEHs9k5g?=
 =?us-ascii?Q?LQ3SSkTW1XLnHP/4UJl2cT/lewmZA2c0nbbL25cRgohoEB4GCHBV3u+Mm7NO?=
 =?us-ascii?Q?c+Fj7jSJEn/euozFtkA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7eac22-d6ee-4ea1-f428-08dbd0176232
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:18:25.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+QK0DYw1F8N7p9zEQU0+7sCCkqZNnb4hi3uav4Iw+9oH1vz5LJ5zimARmyh1QLi3VquEmn8lLE8RXC6PELsBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:33:34AM +0300, Jarkko Nikula wrote:
> Hi
> 
> On 10/16/23 18:46, Frank Li wrote:
> > I3C allow devices early terminate data transfer. So set "actual" to
> > indicate how much data get by i3c_priv_xfer.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >   drivers/i3c/master/svc-i3c-master.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index 3570b709cf60..444825aafa6f 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -138,6 +138,7 @@ struct svc_i3c_cmd {
> >   	const void *out;
> >   	unsigned int len;
> >   	unsigned int actual_len;
> > +	struct i3c_priv_xfer *xfer;
> >   	bool continued;
> >   };
> I'm thinking would it make sense to combine this and previous patch by
> removing the read_len/actual_len variable from this structure and use the
> added one (by the patch 2/5) from "struct i3c_priv_xfer" directly?

Some I2C transfer and CCC use svc_i3c_cmd, in such case xfer is NULL. Keep
len/actual_len is more simple.

Frank 
