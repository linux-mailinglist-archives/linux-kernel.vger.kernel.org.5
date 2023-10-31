Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282A57DD3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJaRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjJaRCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:02:44 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C34183
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZbNFKUCNvN7UywkgQFgOEyBdk5Ykv9D6ke62xcxUeHsPiY4ZVD3w03uYAGiNmwVckOd3scHX9svAH+mlZabVTJDH+/fxGpCwQtkm3CSLIDhaF1MS/Xm00zwCYYGFW4aHxTgz8xgdwthNBlLeXu/AxYWXfT2VLZJAyHEI6NuQNLB2EbDfqpES5cfhkxPYZ/cTzOxBqqUeTpWQf5s+zd8nsKB2y/jXdHkv+6KLUwbE5nyo4u1YGkhLJd5e1b3dfCmDwvW3DE19iXt3tS3zWxT+7TAtx+cWoFrDs/bFVqsD5xbyqHunmh1N1QfTj4YnveKcr7gGKV2TIMzsBk7GWhIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFgf2S8ET76HACcqHN0EKVE7QG+sXKNnVNdN2ze0pRM=;
 b=bHvcQzJxe680qoCO5ibKyb+Nn8QZM2vXHKDkNwK9bb+OMyVX1PKbWas3ULc4xyWVqOuKiQU3Ps12DSmcCtx2ka1qqsHJJWmj55zJ5BtgIgNs2/1zDBCaOttdaJR/qVQYOU3dTnEPi6JrQwl16gp13bJbW5QZAnb/3lGRXU9N9esvMDaAsProVKvKfvUEeKexegzzEPlaQ7Fv8QGyb97wRHIoyiB4lsMZumOQAHcO92GeuT0Ip0M+Y0GIObuQ74pdO8CG/ELwYPNusv544O0V99hTsQjDWUP8hVX7Jb955I36m83eorYAMLDtWZboXZGvPVoBx7V8vjymws8fUL/5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFgf2S8ET76HACcqHN0EKVE7QG+sXKNnVNdN2ze0pRM=;
 b=aCJ9c8fRvdBOVhdUjA7XDE7AmNPzU5rCUaMHbD6lVfmzDwn3qI1l9BXIF1/nqniu4PZR9LmKUvu+Tw/9Sfk7OhlJje18yADRzi0AbSMqfeXFMpVunnr3l0Rz5CBNEojUBI57N+HkdXsaiBdrRzvryyDcpo5FHgloeAEFXpCDHT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by LV3PR17MB7214.namprd17.prod.outlook.com (2603:10b6:408:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 17:02:38 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.015; Tue, 31 Oct 2023
 17:02:38 +0000
Date:   Tue, 31 Oct 2023 00:34:29 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        naoya.horiguchi@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Message-ID: <ZUCD1dsbrFjdZgVv@memverge.com>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org>
 <ZUA/IzTMokFsXS5Y@memverge.com>
 <ZUDFSEvpxxoGWmdG@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUDFSEvpxxoGWmdG@casper.infradead.org>
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|LV3PR17MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 910f2cf3-d8d4-4957-e1ce-08dbda332fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65oHS9RaCaQTB7gMRCA0Fj0REtLsY2Q002/f+NP/cDSgIKkDy/uQ7ZoxcAYwC0HlFbh+WcekUmLOElHFLnzu5qXQgIF7P9HMOzY+UdEuXzuymunifXY6Q/DqLOo9YM4XgSriE7joASvdrmBZv7y/n99cxDXOj3RkbXmQnygZaFBDqCtFOQAn6sc2ZI1cYO6c4U24+Xtb+KyXCHCTajq3lvu97nLop4S5Z6s4sSGc9HYGkRJeR7trPZhgzGa4KdNAneqwxFJ/QJVfiId1mmOELTQ7UhU/lRkYSKtwZ64hiN4B73abHIjcoPTtEScMu0Y6FsoY9CvhTpS0eJY53FixqJ6+vyj+dCRyCDc3PttmVfM1uwE6Cxz5GnTKOeBkrMZxC4h1dVtSe6JW4fBydTFrjwaS9g8h37pJ238JWWCuQpL8wlwMQjkUD/NWdWYw884Toj4cWLcIQnSbSgI5LBwXR2ryQ99ITmkho4Cau4povqWSFa5LKUFTm5ft/FPSyOrNqZEsOc6LabkP1nqpo8uLeO+kpUx5Axwq7hxl4aaB6FpqvYBK3jwBxZf8/xKb1+LluK/vPGudwEieYCRlG61dkHAK+cIxbhmmdHfw0V486AFjFCr06a6SZP30fVvf7yB0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39840400004)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(26005)(83380400001)(6506007)(6666004)(2616005)(6512007)(38100700002)(86362001)(66476007)(66946007)(66556008)(6916009)(36756003)(316002)(6486002)(478600001)(5660300002)(2906002)(8936002)(8676002)(4326008)(41300700001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1PxBFa28dKcznTdDYEIgYn+WFC2QMp26ZmsPp58n9ZPphc8xM5XVaoeOP4M?=
 =?us-ascii?Q?1qImVrPszwRKJ6t2wk8UuFuPLnZZghGSTBd1GxEfvdGA09I9K3A9YhX+JciG?=
 =?us-ascii?Q?gUlGc8T9VITGI19Boas7F/PyazR7lNY5QooVvWelhGFOiK3RMLjfoK5QDz84?=
 =?us-ascii?Q?Cr2zgNQacfRkNCt0olg3HpdMz6RgcR7BNjVN0S+luIZL6/Eo/K4WYRy8KTxe?=
 =?us-ascii?Q?Ne79jVA6xpFgHQog+A4LHjrwyUIKCQ0VfulSH5dU7tzpNxRx3DDDMspy0w8v?=
 =?us-ascii?Q?B2wkccfqsVt1bFw9CR3+zJXPgLgRZlo012DgOxq6Dq9PX0vyUBipaaFiif+F?=
 =?us-ascii?Q?CKgBwmNZ1pipj0aRZ924krYOh97aInaUep0h5r9lBuGSj8TKMTHGX064v3SL?=
 =?us-ascii?Q?/MSAjlGSw4PreaUus6s39wb6eYB3/oFdE5Nh8E83J96GMpEszIGvBekSJ323?=
 =?us-ascii?Q?H9C5GyJRFIh8TG/ARDlG7suNz9EWV9kbGbOFNBAtFgAUt5MVOkcWf3pdhVml?=
 =?us-ascii?Q?2rLbg8KQzJ7e7Z1oq1fcG5//wj3V7pdGtUs5kp1wJdo9XdOv3UVeCy4cobtp?=
 =?us-ascii?Q?dgDdTGK53TRz5g9PeBcLbvzZ8f41IrA1mGUCbVu+y9jmR52uyfubDbU2kHK2?=
 =?us-ascii?Q?fkfPK280SITbbl9eYuucgGRgU+synu+NCsbKXsxFUntTckXmxT8Cm9uMg+Ev?=
 =?us-ascii?Q?dUQ+ACTlSRWdU01c5m1/TYgyjsSh0kdAnv/LJB9HKvu7DxDc6W+d/mOqwdQC?=
 =?us-ascii?Q?bPcxPal11ZtH8N7yi1CPOqiV/R3l39dSuB2A7Xbm15im8o20YUsZ8b4//Ok6?=
 =?us-ascii?Q?rOrCJ7Z1HrZNiP3qu8OSYwcxQtsmO1RT+bfUxUeD03POKlB622YVcQxfa91i?=
 =?us-ascii?Q?87BsqKVekbNxCFKZFJtBE7diuA24RCHV3iwoZyCCS0ZHzh6ZLWRJ9wCl7OXh?=
 =?us-ascii?Q?QVlH6+qx+fy7+KYBYCJgQ1ciN8wyIpxB6FUl71ySL9WKBWkof7aFH+7oVtY4?=
 =?us-ascii?Q?1mkbtwav2+stOvR+irvPPE7grt8v61xp/PwQilSGElu0RsN71xKJ+uBtYMbJ?=
 =?us-ascii?Q?uoICRdXaN8MT6w5jPcFesh834mkecPaHoRGv7QVWnFjN20jlqmnYpwZkGPFW?=
 =?us-ascii?Q?HRMhieW+T5Dk1Ir5asN9uwgi/PzX88tPIpJxAueICTdKFUXzYNPWFwp8XY81?=
 =?us-ascii?Q?swpsctZ21PBLmNuzC2xIzxvw1BwOYOupihHO2E3lpSuZita1cYhsT/jG334F?=
 =?us-ascii?Q?dXDXSrbqVX/eCCJryJ+SrJbqyrBMK7TjwdU+q2JGG9EAuZmmUuQJjWtRA4Mh?=
 =?us-ascii?Q?ZVJcG90DaJXs/wMm0PBNpYpbt9LTddFfjQ/pHfAx9fHhywbWY8GR7sFeY+f2?=
 =?us-ascii?Q?dEUGQBV93mAs36MsefWtsmfUSk/Sq73E61C51dlfmy7ZaCubOh8jPMf1WWOY?=
 =?us-ascii?Q?aJ6XEi8HEqYLv2jY4ZJk5VdZhFT7zmKTPV4grAAMMZg0YSX8E2fV+c8b+fo3?=
 =?us-ascii?Q?5ZMWx086/u9XfUX5Ybw9IpbTGW2ZIisXEi4s2kEOMXG8SD7S2a2IT6duqzut?=
 =?us-ascii?Q?Dr5smo/DFZ20gR9UF+1gRm7U/DYbOgwqjspMmGK0EMkay1wWiI/YfrSpsAGY?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f2cf3-d8d4-4957-e1ce-08dbda332fca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:02:38.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zVY5LF7w3ZO8uEyLwnDxn/FXVVeGuP5oXLUtGNHgSLkNzvESAWRz4pLzZej9pUZaxjDYSvoihNv70fB+WbPDrvxZErJE5JOzO2WaYEOxEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR17MB7214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:13:44AM +0000, Matthew Wilcox wrote:
> On Mon, Oct 30, 2023 at 07:41:23PM -0400, Gregory Price wrote:
> > On Mon, Oct 30, 2023 at 11:22:18PM +0000, Matthew Wilcox wrote:
> > > On Mon, Oct 30, 2023 at 02:00:05PM -0400, Gregory Price wrote:
> > > > kpageflags reads page-flags directly from the page, even when the
> > > > respective flag is only updated on the headpage of a folio.
> > > > 
> > > > Update bitchecks to use PAGEFLAG() interfaces to check folio for the
> > > > referenced, dirty, lru, active, and unevictable bits.
> > > 
> > > But uptodate, writeback and reclaim (amongst others) are also defined
> > > only on the head page.
> > > 
> > 
> > Ah yes i was only looking at the things defined w/ PAGEFLAG defines in
> > page-flags.h. I'll give it full once over can collect them all, my bad.
> > 
> > (also i forgot to update my commit message)
> > 
> > Quick question here since i have your attention: any recommendation on
> > what to do for ONLY_HEAD flags?  If the provided page is not the head,
> > should the flag report 0... or whatever the head says?
> 
> Thinking about it some more, really almost all flags are per-folio, not
> per-page.  The only exceptions are HWPoison and AnonExclusive.  So
> probably the right way to do this is to make k = folio->flags, and
> then just change a few places rather than changing all the places that
> test 'k'.

Funny enough that's what i originally did but was confident it was
correct so walked it back.  I'll take another crack at it.

~Gregory
