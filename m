Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEBE751D08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjGMJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjGMJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:19:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2099.outbound.protection.outlook.com [40.107.243.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD7ACF;
        Thu, 13 Jul 2023 02:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gst5QrXycBa9p6OwyT7W6ijxGjSYiYiDIUAcmu49phB/jAD+Ify9e/+TmY0V6bAA16J/VzqLNganq7+DqMu6+JhfhUC/OS4r5t+PWUaAMGtNu1RdFjhbYnd1wypLbwFFNxsuxbQf/dIFAA9JyKPiRJj35kk9K66I6Hg/21blcXkp8OgHdqqeTeR0DDcD7ML912Q4XFUnar97oWbZ/3jWqSVCvFMPI4BbcY/FZInQ8R56jRDwJYOnkV2GgNcVRntgNiy5SkG6wVEaHm+QzZQcidVF9ya/DGhNEl1EZgL1N4kRJeLHiSwg7bdAt2rkeEJIr4zFhkyg7209/oJTbCX0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ABSFvyN50d6fx+O1/mL4J9ISvwgs73zDgtK25NvyII=;
 b=QX2Gzf3Zv6wj3K4LIXW/UhjsKqT+wtX+op3mmuMYXin4ASgjBx1y+EOX/SZ8yLOmD4suWGD/Gh6YVSBY/2kRw0DKqc7oRvCvKlFHjJHZaNreqYqPbc/nzOy4pKRNNNjw6ELmks+veLmk6PK3uTJpOKEcpGi3hY9II3I52OSZmHYWa97O/6WJVWX515NskoFfIwkwnNnt/e3aHagc03afaXSZgjG1DiFoUSPmoegrFhoo0l9E8zgTbNUMkvZr8qJPLNhnrblIk490qFUmbRnqt9Ub2waJrqYHQCiTOr+h7YHqx+iXtWrStBMPPHm4oQ8laJoILj+53SildREp/zO1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ABSFvyN50d6fx+O1/mL4J9ISvwgs73zDgtK25NvyII=;
 b=e3IZSpJOgA2vIReFBWQ0W/FlniwhwRIX5nrPfOQYly0AWaenNfi66wSkChQqBBt2zNLFMtaHq86m1koJOpa//8pL+8e1nl5s1MYgxGOU7UtC/yU64CQFgG6PdmJWTslUIidSl4b1AS3aSHAltOQE/xS8pRxeeOT+z+4a+J3MJfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA3PR13MB6323.namprd13.prod.outlook.com (2603:10b6:806:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 09:19:43 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:19:42 +0000
Date:   Thu, 13 Jul 2023 10:19:35 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/11] net: phy: add support for C45-over-C22
 transfers
Message-ID: <ZK/Bp5xIwzooTAYu@corigine.com>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-8-9eb37edf7be0@kernel.org>
 <ZK+8M+FxJxY7UIyt@corigine.com>
 <1bef1179238e09cdfce281cc2428ba56@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bef1179238e09cdfce281cc2428ba56@kernel.org>
X-ClientProxiedBy: LO4P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::6) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA3PR13MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b8670c-7443-429f-c2ee-08db83824ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkfJpRGTRuIxEfkaKVghSoUwBoS5H9bGbfsgUKlgCQC5IOWClnYEopz3xSA1EhvaOu/vayLYPPfDfh0cuhsr3RdQJH9l96GHAhgyXTSQrobKROQHQojEi+J5q0ZYySpttzao67Ott+PuiTuYD4+oCiyZxMCUB4Rgra0WacT6ywiPXGU93SlOoMvIJiMFHx1VDqel+qj3i2oQxwTmA4YQZO3ReC4nTUv4aVWu5Akk20t73Kj60LxFhO22gCjEcNNA9Vt5CgVdJXr3prnab1nK6gXGEn+MwbOsVy/xu373vardr/ti3LgiZnytjnhKdKufjlvwsaniNUkilExO/Rqnw85sgZ/FryYxQ/B6j9l3T1rp5jK9GWvSoulIBlp6CSnIvqYgq5IFxUvfCDJAuUneDezcMpH0+QzJAla2NLRRJTOiVj/4F/cagMSbFuuFz6610kuum/BriGS111mOKPmc0wn3P3BS23NVl8UUyZO+jNMbarrih2THx76xBHYy8VH5Jg/hKmgHN6O6ZkKoAC9tE6oF2BmM8n8zzkH0Tos48Ov/eyVbGPJAC/3JOMWeqOCgrpFoW6WXZjSoeUoNZ+54bZPysR0TfUjzyQcAzQp8zjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39840400004)(396003)(451199021)(478600001)(6666004)(6486002)(54906003)(6506007)(186003)(26005)(6512007)(2906002)(41300700001)(66946007)(66476007)(66556008)(6916009)(316002)(5660300002)(8936002)(44832011)(7416002)(4326008)(38100700002)(8676002)(4744005)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jLuPrLHI5OH+p1RENinXgp3vrLIlOMnHo5Fanps6GLq2XNRPg4JgdXkXLPxR?=
 =?us-ascii?Q?61T24fv5j/DrO74tWd68CH2ecRX90imjKkEU7V2kiUN1QupUJOdF4T0bY8c0?=
 =?us-ascii?Q?9acHG3aCAqgVsnzFil1EkndImUm+QDD1U3habo6j7b3PmJnVEHUlK3BVDCTC?=
 =?us-ascii?Q?dPK/4TbZUAlUo++XU/6d5XSvNpHKrwht7iPL+n4TPTXxsSSAkBMfqcdwv7lE?=
 =?us-ascii?Q?hLZk4k20wWWzFJZ9gxSW7qRctfC6UTH2aLdJBvIBIVEPL07lfO9mzOrUgFH/?=
 =?us-ascii?Q?SfHpIEkDvSLh5+F9x5qplH1T9d9KLvQ6Xk3M7Yd/unWCAncCgrX7QB+OiHeG?=
 =?us-ascii?Q?sT91M4EKYGUGSjxbEVJOoYHUSERjqND1GN9e2QomJ8UNCFxkDsout06EFB9j?=
 =?us-ascii?Q?vaE9pSK7erRP9T+fPinTX41a11Jl25XRMup97O9TMu2dwoyp4aemXMNqgIXH?=
 =?us-ascii?Q?mU8uSpM3TneEDhc+jKvSmOhA9az9s8nUikefS6nqxIo/AnHyDkU2yeQ14eCy?=
 =?us-ascii?Q?/qkBFZaGwYkQsQyy8CjOL6JznMldo2YjV9PqwFuFY0oS+DbKpYTd7OaUWCnX?=
 =?us-ascii?Q?XF56H/9SmpwE2gIRIifGRljmP8kIK0TLvuPwX0R0ft7Z+kiYZFS1JCIwlQ7P?=
 =?us-ascii?Q?aDO8h8lf6B3gU+obzUsiM3Xbnj5qhP5tBd17YTK6UBxAmQQwH/nx2NeGgGJt?=
 =?us-ascii?Q?vOmwZuGXQsMskEhirv6kN7fwzCAVPZBPNwyp8J86hBw67uiPoefPhBeHoaG8?=
 =?us-ascii?Q?+0u0ILSlfshjQNTySq3y2ALZmRKcgSa0beFc1y7rmXhLm9ouTa8yY/NHj5JR?=
 =?us-ascii?Q?ChEZ0VqoQdhbdiXduRe545+hMdN3rU0qC7lrjpExTNXBJOuufPZa/D5rJzpX?=
 =?us-ascii?Q?flrhY+50gjHyULnNVlzvLny0QJb41s+fNi10PjPIh8CcY7BX/vNQvm8YY5n6?=
 =?us-ascii?Q?PAaO4FpEjr2YsPZ+IgelJsKtFj3QMJ9zQAUrb4MUmDlRazeN2I1RpTYvgAks?=
 =?us-ascii?Q?1/HSibXkbTeolMZW0oHy2BqDuwngrzPLU2UN4clUQ9Z1wcBIW8wU0dbmqYfF?=
 =?us-ascii?Q?Bx1oTBHkIiHt2xxwNR238E6Q+nD66681oqcDrbXsZZspcKLlIY98F4R+Ju/i?=
 =?us-ascii?Q?LDFEzfAbhopZ4zROsU0HvU08kXOXOt/r3KhgQQ25VevmjiP/jp4QbprWnWtI?=
 =?us-ascii?Q?sLj0AezsQTMC97hIPVdgmM58lfEeb2LYTexF2EXdCF7nXc1m/dDQYDvoxNux?=
 =?us-ascii?Q?n4beJNGYiHEBpNLWC0AnV9L7KoqFbnN0uQWPeVrqQf4DI4IW0L3c2FVJiIR7?=
 =?us-ascii?Q?fYs23L/Uw/GunwmdCff1/3NhqA2yGTPzGI0CSryaDMR8vXMYwF4M4dHdhiDY?=
 =?us-ascii?Q?VdlAQ9/kMchJxRet6+hU9ALEimEpIRXDUDBcVJr1wRAqnE/nIbSfCe1pjViM?=
 =?us-ascii?Q?XVaJ86dH1TahCBANxfr9uOgo1isutCeDmJm+Rku7K/tL8qeGAk6KOV9SNTyk?=
 =?us-ascii?Q?zztVxq1KDBnD6OcXf//96o0SZtfTyZCnorQWdQzTHEZL5rEd8LIsioGSZHef?=
 =?us-ascii?Q?79QmaL5//aAPj7fuYE6kP/kdRQ2shrmJ8sCsVCThAexFJJlQkMafFBuCuQfN?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b8670c-7443-429f-c2ee-08db83824ad5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:19:42.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSa7NSNj4TB5fRdSUhN+6grm8wsHHae1IXwogZfUPJPDiFJui+d9gOLrRkFRwyVDWVMJuEs4jjvgVmtsNc6r+hegR1ah6/XnxieIg4F2vGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR13MB6323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:00:07AM +0200, Michael Walle wrote:
> Hi Simon,
> 
> Am 2023-07-13 10:56, schrieb Simon Horman:
> > On Wed, Jul 12, 2023 at 05:07:08PM +0200, Michael Walle wrote:
> > 
> > ...
> > 
> > > @@ -780,6 +782,7 @@ static int get_phy_c45_devs_in_pkg(struct
> > > mii_bus *bus, int addr, int dev_addr,
> > >   * the "devices in package" is invalid.
> > >   */
> > >  static int get_phy_c45_ids(struct mii_bus *bus, int addr,
> > > +			   enum phy_access_mode mode,
> > 
> > Please add the new mode parameter to the kernel doc for this function,
> > which is in the lines preceding this hunk.
> 
> Ahh. Sorry. You've already mentioned that last time :/
> 
> Also true for get_phy_c45_devs_in_pkg().

Thanks, I missed that one today.
