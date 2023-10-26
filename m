Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A597D87BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjJZRnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJZRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:43:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B590;
        Thu, 26 Oct 2023 10:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndg1C7yG5dnrqYJ0f4tN1TdL0xO8ywl2zI9VwegP7C19dmTHKKRkxRyLBV8ii31YwNrDjxPs2MI1SbrIkgVGZyGbFCg1BDyi5hjtpK+2RYTSX8fNdVmwry4Dc4IItvR/PbDjoJO9eDAaP8U+wD0UJymOWvJNxcYAbsyXhrw8varLUDCEjfODOBxKWnCwbmeMMFVAzTuq+LPsN9M5/jfEc6mS5baJigm/1ggbdYoODYBBqeTeXvX2H6zalrD9muBS41kIyvVHrFLKYLU4imOdmzscLZNJpNcS3oifPQpcyeKOdLbnUPfqQfdbEDOTt2YMP4iLiCfgJJ+Ed31wkHjocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/THWklT+fPIR5nd89Ul1wo6gmCDIC7GU2c2afx5BkI=;
 b=G98+gki9tLyvhXABVPVcAdmX5MmmLuPro3300M4ltlOsa6YAIEt0QPAM2lK3+tGEbN2oF5z+KY57aUQUG5QaywjpdkHNw2+z5xA6SK+UnHO4Wr+djLU1q3PqzFfOHy5nC8+AoNZWnwPnrW1e+Amyfl8DTzsW6x+VdSdy5qKWANUtHsYfp32RV4wcWohRFpyb5hvaTIESxfr2TIJP89cStiRX5njqxXsJKpPCyWYFPd8IydeCknyfAyz6xslVUqa1OewmZRiRLeBgk/HfYyJg1hhqYUGK3q2qnvAI6dfBlvIGbbsZOdHv4Dcgsj3lO/uFN/FfuxG3zNRu7+eKPn3n4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/THWklT+fPIR5nd89Ul1wo6gmCDIC7GU2c2afx5BkI=;
 b=ZAvaJNQ4kn7wsvKueF6VPScPlZS5+AYs2xGN0a4d9JbJdSOmqH3x8UzjJvjL8qWYE2/KpHlqWO3SK0q2PFcdY39kdlyn7GMy6M+zakijnL1LzLgqeCCyjlKDjcGnAdy8ugss9jRDdE6TVGcNrH7IzjWcUjf+6eO80+zBs4nWfRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6795.prod.exchangelabs.com (2603:10b6:510:91::18) by
 SJ0PR01MB6462.prod.exchangelabs.com (2603:10b6:a03:29f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.29; Thu, 26 Oct 2023 17:43:38 +0000
Received: from PH0PR01MB6795.prod.exchangelabs.com
 ([fe80::9da1:e537:76d7:8a52]) by PH0PR01MB6795.prod.exchangelabs.com
 ([fe80::9da1:e537:76d7:8a52%5]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 17:43:38 +0000
Date:   Thu, 26 Oct 2023 10:17:52 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Message-ID: <ZTqfQJiEMRD0Xc9S@Fedora>
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
 <ZSpbfXzFeaoUJRZ3@Fedora>
 <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
X-ClientProxiedBy: CH0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:610:cd::6) To PH0PR01MB6795.prod.exchangelabs.com
 (2603:10b6:510:91::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6795:EE_|SJ0PR01MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: c42e0860-c29a-4b34-8cba-08dbd64b1561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WGu2PbyMtd5z3ttwE9JDPYYUXJU4WkNckfjlr1aUFKcyYxZ6We2bOiwDwqtla/hQ8zCPscFMnzwsBF3H63VU9PJOkaEhMK9ZNcuVjEGWnA+t5x0llXHzmbx7Rf+EU0rRHsinQ7VlHTwKxiV8guAozaRiX6g8g7Zxi/2IOZI7KCPlRmN9AM4QGyfGrhHQNuKkMndIwRXoFLnlnjojkSyHI6oryKRrR33gSg0ViBKdNqgpDMuDIMwENvGdU00fn1+ee2bP+/l5uNxsMhU5oZnC4XrTmozvKYaV45tTOCpTP2mi40X5m216ztz3Ons5C5PpfwP/5Toe8iJ7AcaPHIbqPMzQorM8rbumSe5j4YuzIP0v+ZG7DVF5TvqES3ps07bqNtgFDglNC60IKRM5s8REnuhS735F5SyLmABKuEo0VEiDejDhWglGqZEWt8/2AVdA9Y+QRqWOyaxcBONg/boTZq1xeKlVMNgoHb2ukXE3xCtYe+jfWPCPTXsd6zwOVyxLLONUAB/N94ARuoz91oLUSQURJBbw3XcnxcAi+F1lCNak8xpKj6bj590rihALal4PsRYfZXP9B5XKZF9j8U958NO5xe4ONc5KncB9eljn1QV3jqE/3nw96j9jR+Mb5pm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6795.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(366004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(33716001)(26005)(66899024)(38100700002)(2906002)(41300700001)(5660300002)(86362001)(4326008)(316002)(8936002)(8676002)(38350700005)(478600001)(6506007)(66946007)(9686003)(66476007)(66556008)(6916009)(54906003)(83380400001)(53546011)(6486002)(52116002)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7DiB6cPTr+lbmBaLcXfykX2DZaCRbg3zmc2mMiUvygO0m+Z9JIvqh2GijFhX?=
 =?us-ascii?Q?ZwJ4L4B668be4uS6TSVlTZ4Dp9IONDcF3f9OOKKzDlnW9rZGPaC6fEYCScgH?=
 =?us-ascii?Q?zxSUdLeIYFs+PuQeC7letsYHN+G40rH4K/xelp3UZhzBoUT4ixyKMpVbPmyR?=
 =?us-ascii?Q?nPW2wIH/pYTZEpvRtY8IHXO6hF7aWHakL/zcCb51W9yIgmzZ6UfsWZ/VLaiw?=
 =?us-ascii?Q?u1utkaN9rY/seXFsvXimUlOOt2OKgkvtQfGUMa+MXbaDyjhzyJGSvsBY0ntk?=
 =?us-ascii?Q?fErqHNMY5utZP2+WwdpYYYTZ+7/30ycMfMYc9leMXpNVzi9geY/8mRfiZDaA?=
 =?us-ascii?Q?svZKagvQAKsRq0oU05e8mesSfVaxybU3bHijYbyHDVqSb8mAlpuFq2Zk0r+d?=
 =?us-ascii?Q?zC8LDwSUh/r4W4LQbWa57W6c62C6B6EjGSYgVq+x/r9AWd+k6Fxw5owMOsjK?=
 =?us-ascii?Q?dyi0zCbk5yIZYywsNSmqklwc+mE7RjBXOykNCZpPEp/S8oW/Anotl7JGhZjG?=
 =?us-ascii?Q?quZaZF/SNmg8WeITNDjL2YRHJWW8eVWhnKnfETzcleBHPLm4bTTKti+dAbwx?=
 =?us-ascii?Q?zs9258VLu+pg98y6HkQkitx/SscnQ6/gUVSEws6ZztE8PKlBW4J5lxRSVD9b?=
 =?us-ascii?Q?k1rU9cB9BmaAT0Bp0zoFT1yzV6TI1QvMyKzXh4NyYVFeVNyoJLkSFIIaO3f/?=
 =?us-ascii?Q?uXaMdtp904ckJ6MUfiCEQABDK8UwzwksP3VYAX9D7Mp488uSWDX7s1WZbQR5?=
 =?us-ascii?Q?VqYfb60/17ddaNpKj5M2bZtXx149nUcidG0Q0kUZbIr5k9FdZ132yUkhZcq0?=
 =?us-ascii?Q?uqgCir2eHEmBEjrb0/qBGHxMnQslvkH3UC5qat7GWQryWpe//qgbtfDDIn1E?=
 =?us-ascii?Q?HO9Mw/4zCUe3uXQ2LNYjVGbcmvLv98WvRmfx/4sZc/Ve02WVFbYuGy445L1j?=
 =?us-ascii?Q?Khtjvi1fMnpJ6eVcSf7c0ucdx5HgxoC4ztg94EIvDU+0nk7p0cPKQ9Kq11cQ?=
 =?us-ascii?Q?L5YHtVIt8nT0hWRwx209NiAHTa71vUwOI1h1LZP4r31cDsE7nAv8Lsgc3jR9?=
 =?us-ascii?Q?bF4wnvvK2xsJKok2WSm69pizHBrzLvzZg2RYb6UD7Zqh8ET6m0bnWVq2Yy+l?=
 =?us-ascii?Q?Om5lbJVvOjxyhdTDxNDU+jjdmyTrztJ05Pl7oGid7mbJF5wniuBdQMiR10L4?=
 =?us-ascii?Q?NAZPqofjg2DUH5rBcvTWGd3J9gOSdnyMcZhiKxy9KYKtsZr/uH6tOaRH0a3J?=
 =?us-ascii?Q?FQHj3yrXWusbtEMMjeNbBySRjJIdW8ske/pOxZ89pHoEmXDYRp51ZhEzi7BI?=
 =?us-ascii?Q?atjqxQ5C2abgd9qZAhFuTkAxuERBPxRln/IizqKdPWeYYdJ1heDzrbDhy+yR?=
 =?us-ascii?Q?clxtt1Ef2bEmOa0sXsTdcwgBfBnfs/ltEJ4NcbOdgBTu7sOyxZMAZalk1/HX?=
 =?us-ascii?Q?VRTZRytKTPdcVD+HiEBXNNa5nVlJNY3hB3Mq0NwT8sk5qjNn82CJ+rd1c+ZH?=
 =?us-ascii?Q?rQ5MIlj3V7RGKDDN1T5A1KL2C4hjNoPT9cv0xIy7aOpGOEUy4sw5fksRx6IC?=
 =?us-ascii?Q?dA4A1Jc9u0HHRO1aCcEdwXMiDpH/g2thBgIyEU4/8Uq1/hMVD9+gPNNj7VEk?=
 =?us-ascii?Q?0cWRdk0xB7jIvrfOgFRYJFY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42e0860-c29a-4b34-8cba-08dbd64b1561
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6795.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:43:38.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgbOBQetg3Eh490i58pr2IplIlhbWcjw5LCaKI6xS0DFXHQIt/F6nfti8xMYwZ4e+tUcj6DtOAYfoMnqUjnPbmeBFLkkoEHoYOlvJN+Y9z9TIbZvzSMuAemlXoWMYDls
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6462
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 09:58:26AM -0700, Guenter Roeck wrote:
> On 10/14/23 02:12, Darren Hart wrote:
> > On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
> > > On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
> > > > Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > > > introduced new timer math for watchdog revision 1 with the 48 bit offset
> > > > register.
> > > > 
> > > > The gwdt->clk and timeout are u32, but the argument being calculated is
> > > > u64. Without a cast, the compiler performs u32 operations, truncating
> > > > intermediate steps, resulting in incorrect values.
> > > > 
> > > > A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
> > > > timeout of 600s writes 3647256576 to the one shot watchdog instead of
> > > > 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
> > > > 
> > > > Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
> > > > the order of operations explicit with parenthesis.
> > > > 
> > > > Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > > > Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > > > Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> > > > Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > Cc: linux-watchdog@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: <stable@vger.kernel.org> # 5.14.x
> > > 
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
> > you already picked it up? Anything more needed from me?
> > 
> > Thanks,
> > 
> 
> Sorry, I am suffering from what I can only describe as a severe case of
> maintainer/reviewer PTSD, and I have yet to find a way of dealing with that.
> 

I'm sorry to hear it Guenter, it can be a thankless slog of a treadmill
sometimes. I found having a co-maintainer a huge help to even out the human
factors while maintaining the x86 platform drivers (in the before times).

In the short term, should I ask if one of the Arm maintainers would be willing
to pick this patch up?

Thanks,

-- 
Darren Hart
Ampere Computing / Linux Enabling
