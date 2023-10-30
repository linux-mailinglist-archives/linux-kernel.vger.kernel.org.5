Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9F7DBDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJ3QVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3QVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:21:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2100.outbound.protection.outlook.com [40.107.244.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2657C2;
        Mon, 30 Oct 2023 09:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNtg0Yl8Hz1G0dYGxunmlZWu3fFmqmcrw24zcAEs8qtN0x9MdFNNvPS8rgzz+ed7Ke0d4ewNk2URe4sM9szl5YVpEf9JVVXJM9gG47mTdPXV4PHzNZgQk9vrzSVGQW8gBtbrKiguTjFfGphvQKQH76IBhR+4bUvRR2wIIglh/RPWeLi1LFKDeti8XrnSaEORJuQ/OCcNnRzKk7BptyuL88gQBaRvL/gflyYMb/r6e1LoOG5SaaQhUmPRGXvlf5m3RpYek7JSBDtE3f9aZ1C/ON9mBXYxx3TPON8O2CiyP3lsYb9zfrmqVhLfb0xST6W6rEiqoY6eNVK8sDuk6rMCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHST0a99aEpiCs2qSrEQ8Her7o0qDNow3ACUNKwsJXY=;
 b=D8oYWGD9CYkAWTGqnQar3Rk8iWX7vMTXS5LCSoS2IFsoIWJ+Kxjx8nKqsxiEAgIzoPzieUaEUcVVvm7qaYZWHu2IK7/hwNY+LMOFHRy4mohAvtncwV+y7aDuZw1uxDh8t+JOnkSIwhtDv21zsK+io758tsqyTJ1kstUpdM3KWhipmtDZIKJus55s+7IkpVGMHwr3AydiuFQ1O3RU2OIX/fyzyaPO043bHozB5VvZ6s9erp8CAiu7ni1kxwqUHWJ1LtEfdZ3P71oymkZBmHVIr5+AxSrtc82x3xCSExKe2PJEsy4z1GzgX/ZUv3YXl4IM4CTI/HnM6GtP5sGLknuGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHST0a99aEpiCs2qSrEQ8Her7o0qDNow3ACUNKwsJXY=;
 b=W5Zq/iSn/doHmzzegm5d389w9MM3fHEPns//XHguWtb6I9iJAutLeKHqtSxx8DRunePXNSjT1Ag7I8TB7OgqcZkK9oAoWqeMaPYY3x7meIMRXXGeKj8rwkvZvryZn4yfDo8LEfOc8Z/2eR04H2oEV2j6YgSlFmX1WydD4KpVUUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6795.prod.exchangelabs.com (2603:10b6:510:91::18) by
 DM8PR01MB7109.prod.exchangelabs.com (2603:10b6:8:a::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Mon, 30 Oct 2023 16:21:11 +0000
Received: from PH0PR01MB6795.prod.exchangelabs.com
 ([fe80::9da1:e537:76d7:8a52]) by PH0PR01MB6795.prod.exchangelabs.com
 ([fe80::9da1:e537:76d7:8a52%5]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 16:21:11 +0000
Date:   Mon, 30 Oct 2023 09:21:10 -0700
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Message-ID: <ZT/X9viGhNc9NoCY@Fedora>
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net>
 <ZSpbfXzFeaoUJRZ3@Fedora>
 <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
 <20231029161056.GB5887@www.linux-watchdog.org>
 <750ec6f7-f075-4075-ba9d-eb67f69239ec@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750ec6f7-f075-4075-ba9d-eb67f69239ec@roeck-us.net>
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To PH0PR01MB6795.prod.exchangelabs.com
 (2603:10b6:510:91::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6795:EE_|DM8PR01MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b732ea-7e08-4047-4fa2-08dbd9643b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMbqwOA5lxd4stY3fmogyJHnwiLbdE3W7SWmugbLGTSVOt1Dp0v48HbZL26TwY53VUFwsvJOFtHFP2dfIC+dpSqZUc3DD1Jliw6BKwSZWUQGbAIxckJmO/EMcYg6lRodXwd3Zw7fmfl+b9b4W1J2YW2sMz1TwXXixsbjMaDy3j/8PeLOJNT2TYMC30JvWx0jFTA3BHUy4ayMfx9nDDaBfzjlXOr6FSs7yeWFPD5R4uz78ohQe3eRIRimNYRE4hKTT9Dug+XshT52AqXk7IE+VPRa5MYIg/5ZuQBoi7Q/aJGdK55EeswwMiFtAjk2/IcHFUC2B8cSRY+bHr2oVS/13XveojQNiMxZYig7NzptjBFT6AU3ZpH7tx8LGqFOZft0PuNWAJnPbIn+j8SVCo1FGiJs4tVQDmfxv/+9h6Ir5Ym3KjsFv+fDn7QLpI4UOE+C8YkvuPRJNGOMTb/6ygtjK5OqyUCeLsSu53IIWCl2WUw9y5e0pOy3x+gCT9I0P9dj5b1o4eX+oMtAwvbzdVK3DFRUtL2M/X3AxuAl6AU3pfxXCISKV4A9SPfw5BKV0NMhHtT7JizWk/hipT3k83gEs8JpUOA77umBHGttrUthyEs7Z14WZanN1ZjbihnKht32
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6795.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39850400004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38350700005)(26005)(33716001)(66899024)(41300700001)(2906002)(86362001)(38100700002)(5660300002)(4326008)(8936002)(8676002)(66556008)(478600001)(6916009)(83380400001)(66476007)(6506007)(54906003)(66946007)(316002)(52116002)(9686003)(6486002)(6512007)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdJ1mqxcYW5LN4DpttrLz6bLFAHGSF3hLTVJtk68t7gnT1cuU2bdk0nTFHQI?=
 =?us-ascii?Q?7KnKv3B74FUFL+pDGSn9C3dpWIMrzBcro9InHjMssetJ99JTfdHa1gLWNkTR?=
 =?us-ascii?Q?V45JfckY0Y8CBLIwOiv54jHYmm2YOoFKEwdWhreL7bEc4n1uCONXPeZXaoI8?=
 =?us-ascii?Q?V3DfWbnbafkoESxoFExgPeyeeDBwjjaH0gLlmlHx/kgSz0j4AFyeE6fKTqRR?=
 =?us-ascii?Q?hkePh1XoE2BBiOjZgez4aEBCe0rDYL6GqCNpmub4nAlwGJkXvK76fvDCPVKz?=
 =?us-ascii?Q?A97WNFkI+VO3u+tqCMnKLPUcHtWYuVcbCgHGxU8NJZPeskSIMJIJ67y6c8dS?=
 =?us-ascii?Q?oyIV6osRjdMZT+ngo+0TGFu3wTYCcuu7czdi6AndJQatA74LwWO3VT3nm2/W?=
 =?us-ascii?Q?5QMb9MqZb6Dho1eneUiMzF8VZR/1CJRqR8ybfDXfM8+NmHj7rWZ4qaBv4FxS?=
 =?us-ascii?Q?5kywZMvC3wIInzUtPzeYxs/V+w1hvvtn3NfTZZeR8IWJesqxkj7aqo+cVTAP?=
 =?us-ascii?Q?dSFMPOuWMXcgFUVxJAwocTtmrTIR9gRBb+3HFtYdv5079XKyvKLM7XK14Zl1?=
 =?us-ascii?Q?JIeKK/53xs/TjySFpUbQVvOsHRrNpdptUilVmzt/9KhqZio30+FzFGwtDdRK?=
 =?us-ascii?Q?8qLsspbaQ2pEM4vWd0l2sM3E3viPlM7ebk/CGwEFmvy9BNQX8OI6lvpCAKIk?=
 =?us-ascii?Q?/49K9D5aAcs18FS6UOtPrGnfFwLUbeCbuIuJ9DznR6Wq6YeoIbBy891L4Efz?=
 =?us-ascii?Q?6VpXQyD2VOP6pQTnk4cy+TzRIKW2sfvcpXfP06zfRsbKO0s3l7IaL+U7+Xcn?=
 =?us-ascii?Q?MKfSQGmKDeg8ovO88IqJebdzXyVJKA6PKv5woPNUsIAhfPc2c0X8a0GKlqJq?=
 =?us-ascii?Q?c16PCZbDnIs1TBDhHaz2UIgxq/x5Lq0iJd03H63e1UgcKYufCiacCsI1JEMK?=
 =?us-ascii?Q?ipi4Bmzs1HYellIOSeTY9Fez1cvzObCmrKFZ8plG68mr9EA/UV5qRcPSebUc?=
 =?us-ascii?Q?N0e22fnNeOSjSOvIFzJJ5dxuu9AzvHLxmFxOMyjTy0ntuZBTp7K1149QhA71?=
 =?us-ascii?Q?yskPiFhWYLYUyQI/F/DjY5/EdenRTsj/rIKI037tO6lkWoYxKIyWREDJBvHZ?=
 =?us-ascii?Q?WG48r54Cs74HR3kqMHricURhK45KZjbuu++9SA7Wy2Jn5n+Mj8bd9f9aDJMv?=
 =?us-ascii?Q?jTLK4rHqoUKiWwY2Zo0dSe9++q3G2UaREXdOcbFcrZGqHUesZRGdaVWTrGJJ?=
 =?us-ascii?Q?ir/ABt3sUN2KLoE6SShXlwILhehFWrlxEFv6nR17H6hd3mXUFPHImIhddlKD?=
 =?us-ascii?Q?s70ut2yeo1M2bwt+Tn0hm5T6g/KgG+xF6QpE6uX7NHh8DsHzRIo1f6RmpzjZ?=
 =?us-ascii?Q?7i0UVz6g5jg7y49Ds+PDmp/zmLLPFixE746VkjT7fEQMU4kUmCVcBtzVNNYY?=
 =?us-ascii?Q?3FByGg0fSb+qIdkURINI/QYiVUYYGYROJssFtmkWWyGkunzG6JL6VCnpOzRO?=
 =?us-ascii?Q?8WNU2h5audJn2Rkb+E+l7k16aOQWOffqHsMYuC3AknM72O5aRe6fPEN6yPW3?=
 =?us-ascii?Q?5crAsw+z9RnISGYVInvbZBfAtb3RHkOgY+p57Ov9vbrYvXpW95mONm6gv3Qg?=
 =?us-ascii?Q?+hWkBrOC7Gox7ebbl3iTZrY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b732ea-7e08-4047-4fa2-08dbd9643b1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6795.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:21:11.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEgAjK+LOMEvgrCIvePaRzmHv/8RLystE+1GDoMxVdQqVgjUajLlMSRA/x3fQeaS//LpgE5rBiGBkn8OwSm4rp8yOLYXMziheAwaWjwS9DDOus4MfNo0NAoUAByLo0jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 10:00:54AM -0700, Guenter Roeck wrote:
> On 10/29/23 09:10, Wim Van Sebroeck wrote:
> > Hi Guenter,
> > 
> > > On 10/14/23 02:12, Darren Hart wrote:
> > > > On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
> > > > > On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
> > > > > > Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > > > > > introduced new timer math for watchdog revision 1 with the 48 bit offset
> > > > > > register.
> > > > > > 
> > > > > > The gwdt->clk and timeout are u32, but the argument being calculated is
> > > > > > u64. Without a cast, the compiler performs u32 operations, truncating
> > > > > > intermediate steps, resulting in incorrect values.
> > > > > > 
> > > > > > A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
> > > > > > timeout of 600s writes 3647256576 to the one shot watchdog instead of
> > > > > > 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
> > > > > > 
> > > > > > Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
> > > > > > the order of operations explicit with parenthesis.
> > > > > > 
> > > > > > Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> > > > > > Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> > > > > > Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> > > > > > Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> > > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > > Cc: linux-watchdog@vger.kernel.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > > > Cc: <stable@vger.kernel.org> # 5.14.x
> > > > > 
> > > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > 
> > > > Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
> > > > you already picked it up? Anything more needed from me?
> > > > 
> > > > Thanks,
> > > > 
> > > 
> > > Sorry, I am suffering from what I can only describe as a severe case of
> > > maintainer/reviewer PTSD, and I have yet to find a way of dealing with that.
> > 
> > I can imagine what it is like. And I do know that if you wouldn't have been there,
> > that I would have allready stopped being a maintainer. So I hope you can find the
> > right cooping mechanisms. I also had to work non-stop the last 4 to 5 weeks and it was hell.
> > So I wish you all the best.
> > 
> > PS: picking up all patches that have your review-by tag on it as we speack.
> > 
> 
> Thanks,
> Guenter

Thanks for the support Wim and Guenter. Appreciate the work you do and the
pressures of maintainership.

-- 
Darren Hart
Ampere Computing / Linux Enabling
