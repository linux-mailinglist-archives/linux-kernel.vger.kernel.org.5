Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335775B873
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGTUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGTUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:02:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2462118;
        Thu, 20 Jul 2023 13:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKb7eCn/rxgbYmq3DO3PcCltqZh/eiRLvChvNZMSx9l5fjIOB4gKvxxPGsmU2wL9EKLLo8FvsKIBO88gfqx/2hJ58fE24rTWjjQ8xtVxZShlaAKWxcYHFTm5kVfoBDSurYmWjMNGqXifGi2WQLpQwQVBhXs9nUW/gRoGz5OO6CHmdwI05+SHlAK5Dx1BoJ+L2YjNhg9wq/YBFMbFVudVKANQJ3P8uUh4gZrWjKcdlTK+0hL06lzv/EavDCguKlANWE2He6/w2aLxK8l+NNa/GZJaJ7C8VNvpWJ3u4XAOyjs0LeROoQmhDE5WzhsqBvRwYKSxyVE+PF+zbOr23UH0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ith3U+yU60y77RokBK497Aj+Dc7BoxNp6bgWuVzD+oM=;
 b=Xa00q+GFkr0WSifQmCX5qoGyakqhxJ9Ha4C6KPYPrOOaTjzs8sptFpv69JCKTo2iGVCnk3lsfoyyYt6lHtrL2BG/KJE/Cb7dwzx7furCaL3viQw4e4qI62MKfuVOhxqRX2txUxJrVWBQJvwL+lBPJDZaRhWeVP+JENtZGtmy1pBei6Y+vldv5O9Cwt6XTnKnxnO+auRwT9n2bWlGwAWOEIm37hic8Zq31razyzb25F+CRiQW/OfCyrJxhz7nKB8AuVFHgnfK2bOG0uRNgcnm4+QRYC4p0lKHgEM0EAOfNzlcVHLnp6c5aaEWw6Uc3789JUaHC0ZD8lvXktOseqiSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ith3U+yU60y77RokBK497Aj+Dc7BoxNp6bgWuVzD+oM=;
 b=BJZZjbxZx/3PJjjdoa42V32IWIuJ2dJaN9ODRLMMsPUdI1Jo8QAcCsb3zGNZ5m4ohxacyKLrdhW+ONgzYejLzbQXqsKZRSn//zbMR/MfMOKWIzXuHhpRVirKuW5pyjBnnSba9cts9UzUS52PHWKhWUxpQnaZttDAVgOvO3jAcLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BL3PR10MB6065.namprd10.prod.outlook.com
 (2603:10b6:208:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 20:02:10 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::5ff7:e83d:39df:dacb%3]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 20:02:10 +0000
Date:   Thu, 20 Jul 2023 14:02:06 -0600
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
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
Message-ID: <ZLmSvkizdykGGpv6@MSI.localdomain>
References: <20230712022250.2319557-1-colin.foster@in-advantage.com>
 <20230712022250.2319557-2-colin.foster@in-advantage.com>
 <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYXeGq2LnD+bpAXm82Aa-Czob8afQSfjfMFweBLhdr9uw@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: daa96efc-e09b-45d6-e1c5-08db895c33eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwU8N3cT4N/JLCPUR5H+UmokRhsJ4O0B0ci5elfTEdvbakUv6uIDA8G52k9e/gAocoLPEAEAzZCK+f6s9rX1kRx/thy7NZuacKFObEMYc2ph9xnDEROVGQxTC2RtjmJowtwhoD/TSEAJefHMdXCkAwCPNHTjFLOdGaa1VMMFRimZVVm0Om0TlzsKnxxVv2YUifHfPpaRezZ/y5wyU2UHMrDqgWDaXamnEmx58VUQLe+gUU3z4aePSYbKTcpjPMU/hrhUki7slNeZb+SOHyNLqFTo/3YW7te9CusZ7r+ljQaRPZgtk5+KSQ3JGdVo2i4r0ewhp4ebZ3y6dYGFF7dk5u+qNsDBIxZBszplnoookFwuUc27Jglj9GNRMvy7NUmlnzKpi27tZ5ItqWdY/ho0iNRGluWL4fceBa/IaBYY/b3HfCLOKhkB8Fwj+t/XDXAuBkQwec2HJCAtdkbcDq6GYmFFDymjRI/RgLQexPDmTLFdnrZp14FodwU3vLrv731Oi2ZlCetx3saOJsHnas/0NLtZP45d6xMNVdJ0X6GFRmskI6wBE83PbuDRHt/3aCAy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39830400003)(136003)(396003)(376002)(451199021)(54906003)(6486002)(478600001)(6666004)(6512007)(186003)(6506007)(9686003)(44832011)(6916009)(53546011)(2906002)(26005)(86362001)(4326008)(41300700001)(7416002)(8936002)(8676002)(316002)(66556008)(38100700002)(66946007)(66476007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTA0NTd0aDZPMzZRbEdsa2xQWXphUkFuVElhb0lKY2JUaWdXQzJKb2NJT0d0?=
 =?utf-8?B?ZU1FLzdBQ1l4M1ArTkVWZ204QW51aU9udVdKOXV0Tnd4eU5ieUlQeVdjSDAz?=
 =?utf-8?B?cUVvejU0QnN4bkpaU1NueHJDUTNxakpkRmpmcjNFUHlGeFk0MVhYMWtXVUdL?=
 =?utf-8?B?VHp4bUxXMzRPOTE4RTZyUGI5RjVEL3hoZVRuc2JHbU1iK3VjenY2WTRyK3JI?=
 =?utf-8?B?ZjJmV1pLdHF5MGFFU1VrQTZVTi9hdmFITGN2SjVvb3M3ZXdXUXdhMWZKR1Jj?=
 =?utf-8?B?SDhuRCtCOEZic25UczMwYWcrMDRtYmE1THh5b3pjSGtYM3UyOElkSHNOMDNB?=
 =?utf-8?B?b3BWZzVDS0Qwb0tBODI5cXZ6QWFWVkVnWHhBaGhTMWROdWdWc1JPMFN6R1Nv?=
 =?utf-8?B?QXJYTWQ1Y2FQdkUwZGlPSzFGdTlPNEFSZzRXS1RZL1pHRWcwcElncFk3amJF?=
 =?utf-8?B?ei9uekVUa1NMMEloOU1kU0hPeDhQTi9QQll2SGQ0Q3RYZjdzNmlpUWtGMkhD?=
 =?utf-8?B?ZksxTTJhTEJ3cnRPODdqUTZuZUhRYzQvVzZ6RlRVMVJZVGJZQ3pBemgyckdj?=
 =?utf-8?B?ZDIvbzhqSkw5VUtkbG1sTS9yZzlxK01VcEhNYWhkWXVDQXB6aTZqN3NCbEp3?=
 =?utf-8?B?OHJ2UUlUdHI5SmpKRFRxQ0w3Qm5mRHlBWTBwcTFYN3BhdVRKS0lmakZrL0dK?=
 =?utf-8?B?VDFzSEx4RW9uU1RtVzRCMkNpU0pLeVQxenNCaFlZZzRnRWVCRE45WVVmQkQy?=
 =?utf-8?B?amo0Ui9IQmNTTmJ5WmR0RWVKOGpWVWx2b0NzZ0I4K1JtR2kzS0RJLzBFSjdu?=
 =?utf-8?B?NXE4aUZwWXFoWmdlbngyVW9ad2w5Q0ZpRjN1TkVxT3hUbDBWZWxZRFpkWFFR?=
 =?utf-8?B?WWZoME5BeHBqT1hQVTQrNGVteDlvZ0ZNT0dpcFBTeHVjems4MUhmS2JJSmly?=
 =?utf-8?B?QWFacDZ5Z3N2YUxxNkxIUnllZitsMHBETU10MGhtMEU3SXpodm9CNUt2Q2Yv?=
 =?utf-8?B?SjVaR1VKSXpjekJpVTZ2ZElBTi9MWDVLL3RvZ0pkeEJHU1BCcG9LekEwQWwy?=
 =?utf-8?B?MjhsZHRLMG5QeGdMVFNwUTlWQW1Bb1doZFZmU0lYOTNSdkJ6bGlMWkNyOHFu?=
 =?utf-8?B?czVlR09KTTJEb1duQytySnU3RnZhSU5QTVFPYlRpTk8rS0lxa2kyd3IzNklQ?=
 =?utf-8?B?a3ZoYWFHZWtHeFV3N0JuQ05CZ01wdFdKSEFRalJtRmEzaW9WK1QvZi8xc0JE?=
 =?utf-8?B?OVBNcXNjWE83dnU0Zk1zZHdHN0xqOHIvMXNycUVjY0VTRW9ZTm44ZDBSdWRo?=
 =?utf-8?B?R0lvMWlqaWhFeDJtUzZCcTgyOHhFMjVCWGJKdUN4SjY0S3JXR3BGeFJ5QmhK?=
 =?utf-8?B?ZzhpNTJDak5rU3dxT1lxNTdvQTBUMzh5cjBScWRSOWJOeFNFaW5mLzlDWUsv?=
 =?utf-8?B?c2l6SEdRbklMdFNsbU9QRTlBZWtVdUYwTDJCYnBGeFJsUG1VWE1EWWkzUXN5?=
 =?utf-8?B?VlN6ZWIrRUFiNmZtMDhiR2hrRkNDZ2UxK2RNc08vdHNrd0lQN3pULzlNR3Qw?=
 =?utf-8?B?dkRnbnc1eXJHa1VtaUY2SDVuSlNqOVFoK2VhUnJXVE51U1hzLzh6MUltaC9X?=
 =?utf-8?B?SzBCbVNSeWtjUTRsUFd1aFZGbk9ZbU1VN3JYMXVSUWZ5V0lOSERMWXdnM1Fv?=
 =?utf-8?B?MjhxVWVESFBoMXBnSU1LOHhodklzd01YWXdZenpzVU9DVWQ0OEZuT2wxZmxR?=
 =?utf-8?B?dTc3NkREcFh2RStlamk2Q1VicG10cnpWU0VvODFnVUJzNGRFcmdBMEV2U1Ny?=
 =?utf-8?B?NGQ4b2VnM1l6R3B4dGk0RkpLR1p0Ny93eWl0blRKWDA0NWVQTkN6azRiRXNZ?=
 =?utf-8?B?TWt1TGg1MWVHMW9TbVE2UUVrVFdOWVg1blphK3JPYVljYXh0VGM4d2o1NFow?=
 =?utf-8?B?VUxyWlk2cTZDcWhvTTQwa2xlb0JENFliZ1NBeWMrOHM1VUowbjNKanp4NzRT?=
 =?utf-8?B?MzVCNUwzb3NZR2VTdGd1YU95TG81VkxVQVlJcFg2OENOdnJyV3p4SWdpY3Bq?=
 =?utf-8?B?Mk5TcDR6N1I0aVpnTWFPcW9vdnpOM0ZQSmNvRUV3MjFKV0s2Mm1UakwyT2x1?=
 =?utf-8?B?cFdtMmRmR1ozM2p5R21RZ2IrcHJjczVIOFhaRTJuKzRSL3dyK3pzaFRsSlNx?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa96efc-e09b-45d6-e1c5-08db895c33eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:02:10.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n77pLPw5SYEaFCPt/kbtcwV34pHlGo9AOPF/+uYUVwo+WaI7QSljSliy1+DT/yJ+abAwLhnhWicsQvRu7uAaugmOWKoxiAojUM5mjthGx/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:25:32PM +0200, Linus Walleij wrote:
> On Wed, Jul 12, 2023 at 4:23 AM Colin Foster
> <colin.foster@in-advantage.com> wrote:
> 
> > Add additional functions - two blink and two activity, for each SGPIO
> > output.
> >
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> 
> Could Lars or Horatiu review this patch? You guys know the driver
> best.

Agreed. Please don't merge this without their approval and hopefully
testing.

I did demote this patch I've been dragging around since 2021 to RFC
status because I'm more interested in making sure it will fit in with
the work on hardware-offloaded network activity LED work that's being
done. I took Andrew's response to the cover letter as an suggestion to
hold off for a little while longer. I can be patient.

Also, this RFC was two-fold. I don't want to duplicate efforts, and I
know this pinctrl driver was written with this functionality in mind. If
someone out there has a hankering to get those LEDs blinking and they
don't want to wait around for me, feel free to use this as a starting
point. I might not get around to the whole netdev trigger thing for
quite some time!


Colin Foster
