Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4590275FF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGXSzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGXSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:55:47 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95910D1;
        Mon, 24 Jul 2023 11:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjNKjPSk81ifqb1he0zoJKMp7tb/pWg9fyCwsIyIq0PtI8zDNIU0410gZ5ZNELzcCqON9JWzr7BNSohkaQXVU9YciuA0NN85HBv2uRRgYsMPiyl4DnSkdgsnOM74HgOXu/CnVZ84J4DMm29WPR/8ldA3XKG+wwwg19UeVf/SKDB7vYtjwTBR3iXE5rb4PnfQ1DTJgD8RWSOih441xlx1t5g/dv5PsgkFUoWgulBpu1C4sWV6NV38R3TdfhGR8GgrZO9rNApl0xZWw33oJRK+1AvW7ar2enANNOPnJu3vSSYx0+qBeU2CWaP42+L+sxKf2r5ROSZwhveaGwJ8fXn8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqIuzsm8OgVejBsNc1kOsUPF099qJxjnwhqEEQbut+E=;
 b=TNZ4w5qRZoEKIcq96Rm3QbJIXdPO+Z11lZMgvLvQPq40QAVESPOvqzSUN26e0dZrb/f31XcW5CZzlu8aNMrMDDsfahm1GKN5jj/Sm3AHM4t3VgCoWHYpprWT6RV3hh1KesjbO2WSb2P/nTVKlroSiCbrnkspXySvmzvSQgyDPileRlkDD4WYvunAM3SpDL7eRiwboHW3kirvR5ep2v4TJ8gk4a2KNVxR29h4a1r25oZTf7VOrUcSsV/UU8vd4t+eIgvVSGa3fB2z3wd+neL2XlG9urUDPNcC9tB8dG4IgqXwNV/5hkvD+3H8rgHMX9oCibtY3wAm7Y+FBRJTAls1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqIuzsm8OgVejBsNc1kOsUPF099qJxjnwhqEEQbut+E=;
 b=mktZBEE/GaojuCNRsj86eatfvUSWRP9U7+1LF4IJlt9SJFXEilIWIg9XmFnK2YOC6PcRCeSScEoLDLPpVnEa6eC1zagTWnQuRtdqKLzQlRTsY0g2R6CiflE3JPDddMVRPkdmuwm+PTGJuIOhtznD0D2RT4S2V87YnFF2LNSUxRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SA1PR10MB6616.namprd10.prod.outlook.com
 (2603:10b6:806:2b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 18:55:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:55:43 +0000
Date:   Mon, 24 Jul 2023 11:55:35 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [RFC RESEND v1 pinctrl-next 1/1] pinctrl: microchip-sgpio: add
 activity and blink functionality
Message-ID: <ZL7JJ2nLA27Z/VnR@colin-ia-desktop>
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <20230712022250.2319557-2-colin.foster@in-advantage.com>
 <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
 <ZLmSvkizdykGGpv6@MSI.localdomain>
 <20230724065957.a72yejua7us5e2s3@soft-dev3-1>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724065957.a72yejua7us5e2s3@soft-dev3-1>
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|SA1PR10MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d74178-7ad5-4b4b-4366-08db8c77944e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9qEC+VduR71bbGMl2B2ZhJ5Zq+RpovGSBuW+e8ZfCVVoT51C6r7Sh9KDY5KvtTaADo+p0rgtvkgiITT1hK7N52z66TsGq4TXrf59141TNcTQgLzn+HDtW1uH2cZN3qzgVdYMgm4SCy87udgs9MYHCq0KtantFgSI7C4jjEp0ClwrTZRL+PNnmzywXn6Bac/dUTvYjEKd2GjgnkUt7bFJOJhm1lZ+N7V2r9JmtHIYwxbCtE0YJcRGplA5n+hqZ0Vd7KTStzMNknk2WhoBzi0PRr4DCK8ms/AXN/xEtMtxqJQ9jFLPcuuQn+gpT+Gin85KO4cCzSSzChKkvMaMeuhZBBb31h8r7JAYDCYRh+pzUbs0sWd80khR65Aq7GCBuZeNiYan6fGW0nev+6je2ev36wpTUYS3k3Lh9NbCs860UkfCJ9Gp81wr7ovo4fMwh5jUhC8QUGGZY5zeKdf0xlbpqBpJwiW8AvK/jzA3R54r5pxP2IrpLpuy7znF2l4TdR0Fkgi9LEBxyyTs36tyd1GIqVf3L0sh9WK33Jy9REUO8iCAQpoq1L/Mu4TEn3L2APk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39830400003)(396003)(346002)(136003)(366004)(451199021)(6512007)(9686003)(6486002)(6666004)(54906003)(478600001)(186003)(53546011)(6506007)(26005)(33716001)(44832011)(2906002)(41300700001)(8936002)(6916009)(66556008)(4326008)(7416002)(316002)(5660300002)(8676002)(66476007)(66946007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hYY0VLV0hYTXN0QVJIcmswbUV3K29KZFBxanJVOVFKTWd6RStUZ1VZZFl2?=
 =?utf-8?B?L3EyUUpDL2ZOMHJXNVBxLzByT0M1c3M1Y1p4TkhTVGFNTUQ3N0ozMVlKR3hh?=
 =?utf-8?B?WFpZOEg0ajk3NW55dVpZT1ZTVlIzU0hVSytyQ2NGbnZHeEFSM002VDZyYWwy?=
 =?utf-8?B?WFprYjBVSk1XL0h5YnZDY0VqYmxIbHJncWcweW13SDZFRkFYbHF1OXNycFJL?=
 =?utf-8?B?Y0FsaWhHKzRlU0EvbWJnVVRseWNpbzl6c2ZUNE9wMXFNVUFaTWJNbW8xNVJl?=
 =?utf-8?B?VG9oMW9hS29Tak10amhpeGRHSmJGYzVuSFNRbVNNM1FyMTdYRmVLR0o5NURt?=
 =?utf-8?B?Y1F0Y3I1bVMwUWhTRVA1czZFc25McWlsaldLYWhKcDA2SUhiUXBkVUFQR3FR?=
 =?utf-8?B?Yjl4REFXbHljaTd1TnJrSk4vWGluVFIxY2I4VjVLVUI4bWhsMVVmOEZOVm9a?=
 =?utf-8?B?SElEVURSbzF1bHFSUGpXN1hJR1pPa2c1MS96V1ZhWEQxSUNpQzRaL090ZlNW?=
 =?utf-8?B?TzlKRXNlSVpueUpqYmhsYks0RDhNQVlZU1lvZTFLM2RtY2R1cW9CRHEwRWFF?=
 =?utf-8?B?bkVkZTVXZlk5U250MDl2TlRkLzNiY0Z1d0w1QlVyV294YWpvSkg0MCtFWXJK?=
 =?utf-8?B?ajVnQ1ptbmMvYVQ2T3Mxby91NXBsZGcrUVg1dENSM1FJVHNlaFJwRnpCMkth?=
 =?utf-8?B?ZVhBemZtQll3WkFrVk5ybyt4dTNlU01XWGFCSldkMlRWQWxSY1hnWXRKajVl?=
 =?utf-8?B?ejhLRldZd3l6SkhnV0cwbmZsakgwTUd4Y3VUVjAwMzNLTDlLRnIzTUMwTFFH?=
 =?utf-8?B?ZmFBdW5KZU84R0s4VFlVR3hNcU9pQzVoL29mVVF0SEZCYnJhNzJ0R2ovR0o2?=
 =?utf-8?B?b3dqSzdaOUU3UERXQ1hkOVI0cUx3ckNoZ3VDaElpT3lPQjVFVVVSc2JzY0FF?=
 =?utf-8?B?djRjSWViQUltdFVJbGxzWDFiWFNPK1ZEN1BiUjVXaHV4WXZJZnEwN3E2UkU0?=
 =?utf-8?B?Qy80a29oNlBhaHk5WUpZaTRIenlzamhQMTBaZC9iTmxrMWwzaFdhSnBuQjRq?=
 =?utf-8?B?Uk9VSjVGR29DdHRqcDYxZ3M1dHJxV2MwQk5aenBPYzQ3dnRkNkM4SFpRNEdk?=
 =?utf-8?B?cERQY3d5cXVDcHAzYmJWT0dtdUpTYkN2eVFjd2dkRWVHelNTOERGMTg3dHVm?=
 =?utf-8?B?M1AxcGNMZTYwQmxkUjRyajdBaGM3WUtsZk1lblovbWl4RDd0TkFMbzFabTFN?=
 =?utf-8?B?WWVuMFg5cVR2MTk0UktMam8xclBwY2pYd3VVV3AxWjhIMHNiS0J3NDlEa1Rv?=
 =?utf-8?B?RlZscnBrWVpnRUt3anUzdG1OandhclNlWnYxNU9Ebng5WWcyVmdNMVRBL1BN?=
 =?utf-8?B?Y095RXhDNmpRUEtsbWxLVFJIUklERnVsZ0U0anA3Yi9aUjQ3dFovVktzSUd5?=
 =?utf-8?B?UDJCb2JlWmZNbzJNelZjak1LZ01vQlFLdENtOGlkYW1MUEN5THhsdW9QeWtU?=
 =?utf-8?B?dEFqenNteDhnYW5FcUdCdDE1SjB1QkI0VWtoSTVBTFF2VlJpZ3QvamhSMmV4?=
 =?utf-8?B?S1kxZWVXSXQxVUJaeDk1R0hVTzhZdFN1cHUzQy80Rm85dlFwQzdRWXRFL216?=
 =?utf-8?B?cFozY3RZWnozdCt6Tm5WVjlzbWQrMEZBbW5OQ244QUhGenJ6cVlzVHB4M3I4?=
 =?utf-8?B?a29xM3NqVmpxdWJUOG9ZaXRiczE1dEljZUhnRlhWQ1VBbEtvV2l0TTNVN2t0?=
 =?utf-8?B?dTcycWlyRUxPN0U2VHI4cGJKYkRGRVdxc29pUk10UnZxbG8rSXBhSkZkRVg2?=
 =?utf-8?B?NE5aS3lEemx2bzlZUlBYZGl1MDNieENjbW1jUWVQSFQ1RnVKTUp1TmxGYzZD?=
 =?utf-8?B?eURDZ0dzWnhMYWFydXdKOVJGUUNFZGZ5VTlOTFVNZk5WdHdYcXY5MEEzclNt?=
 =?utf-8?B?WXpBYjk1TWhkdnVBV0RpbGc0RjQrV3BSUXdNbGdqM25TR3A1aWlNekNJMUxO?=
 =?utf-8?B?dW1yZ2NJUVFOR3dZSnpXcHRhdlRwaHZBZVBFdDBFKzhFdXZUSVZ1NXdsSGwr?=
 =?utf-8?B?a1A0REtUUVJCcGZoQlRRTlhES05KSUFZcUVWVklZMHJMYm9ZSitMbFhId0ZQ?=
 =?utf-8?B?VE0rR0liR3N3QzZCamlxWUd0WVdYcVBvSEVua1VIUWR3RGIrTXFGL2xjaWtq?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d74178-7ad5-4b4b-4366-08db8c77944e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:55:43.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9JLDFjWrbmnxT3VqsCEzPkEUv9aNuLs7NYpTrJKydHcRzJHumTdaDwhyCO+5b+XH63HYZxX7rDfA5N8dYyVhW1PcvjBl7zTEOY2BwUJdws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6616
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horaitu,

On Mon, Jul 24, 2023 at 08:59:57AM +0200, Horatiu Vultur wrote:
> The 07/20/2023 14:02, Colin Foster wrote:
> 
> Hi,
> 
> > 
> > On Thu, Jul 20, 2023 at 09:25:32PM +0200, Linus Walleij wrote:
> > > On Wed, Jul 12, 2023 at 4:23 AM Colin Foster
> > > <colin.foster@in-advantage.com> wrote:
> > >
> > > > Add additional functions - two blink and two activity, for each SGPIO
> > > > output.
> > > >
> > > > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > >
> > > Could Lars or Horatiu review this patch? You guys know the driver
> > > best.
> > 
> > Agreed. Please don't merge this without their approval and hopefully
> > testing.
> > 
> 
> I have tried to apply the patch to test it, but unfortunately it doesn't
> apply.
> I have looked through the changes and they seem OK.

Is there a tree I should test these patches against? I don't have any
active development going on so I've been hopping along the latest RCs
instead of keeping up with net-next, gpio-next, or otherwise...

Anyway, thanks for taking a look!
