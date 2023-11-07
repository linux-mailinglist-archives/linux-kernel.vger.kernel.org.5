Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F37E438E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbjKGPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbjKGPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:34:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241E95
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:34:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsuAlM8pjPJvZ0GyPq/7rWC4Zy6P9oAFvAyaQvPatu6g8X/qgA9xugZykEnRX62QRMZ2jvKwQVFxEcHhW35+GXnrXGausAyPsbGpyhmQT63LJuYrtro7bJLi3pWPMlrObv+gR+9nDpybNKJG7S5Z1ZxbPcVk1UbJrGMLl2weD85JWhSxOKUwZRVIGWHVkg4xqr98UY8Fr+L2nda12haZfKwyUyJ0kjlScA43nPlYiVv8NRPNmQuOb8LTAdBztXjh4oXAlMGTicnJIj1WdV+UrSj2h4HyevaeV+OdGpL7LBA1r8aRE29/r4C64UY+uUh1L19zEGDZ1/8rp039sSCwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tCxEzamrMrIUv4GcfiOOlbPvyOgpDL7gIciakCDqSg=;
 b=W9+6eHw0odVqtmKZAHyBwvZXJLRLO06riHduk+waRpC/GljGhYW6fBBxi8CS0217MTbRFrjleBc3Mx1oEtfYZK+KROB1pq2w9VWzfzhHV7cMDo1QeLHnXbeflwc1WIu2LcIZd2kTBUTe+zTSNlPAZnhdpP99CulJ3kpYgaZOQjCwQgEkDRANVigoYW6iggjXJR5VrpexcR9Q0W48dPpxL+ByPIjlQRw27RzYCPiFh35N1mtA1PNAbg4hKdCxhORRJcFslR4++SmkhKEzxfuuD1l3QDFA1WnoldAF3+Jt/3PVRBhHcH6D8uzSAlMvS8tvVKEbm6A90Nrr/Uo+jaXFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tCxEzamrMrIUv4GcfiOOlbPvyOgpDL7gIciakCDqSg=;
 b=B168JVdHkEkQGuFcF9nCTkggJ0SbjDGY8fmxjvPyU9VxgxduNJ+DFvOlVpWlQjITT2BV2jnymPzZWcayILbLT4Pq5fOzzw7L2eiDrocya++YlauMPE1og9HLSek6U9OmSA4dV7W1KLbRaXILyJGvjSBumpab1+Ro9e/IVb0iiDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA0PR17MB4267.namprd17.prod.outlook.com (2603:10b6:806:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Tue, 7 Nov
 2023 15:34:43 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Tue, 7 Nov 2023
 15:34:43 +0000
Date:   Tue, 7 Nov 2023 10:34:34 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
        naoya.horiguchi@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kpageflags: respect folio head-page flag placement
Message-ID: <ZUpZCsR1rmIau8wv@memverge.com>
References: <20231030180005.2046-1-gregory.price@memverge.com>
 <ZUA6qq6zXuc0fqOE@casper.infradead.org>
 <ZUA/IzTMokFsXS5Y@memverge.com>
 <ZUDFSEvpxxoGWmdG@casper.infradead.org>
 <ZUCD1dsbrFjdZgVv@memverge.com>
 <bc332eb1-fe00-416d-b915-b2957d7b25b9@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc332eb1-fe00-416d-b915-b2957d7b25b9@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA0PR17MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f8ca6a-2e27-45c0-c6e1-08dbdfa7100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xkx+2yJqb1zxoQb5bScz45MeL7yFFtkeisSCCxtxLNl+APOJ0Cbh86xqIWCwB9070vOwzC27SBV67ya51V5tYrFFHrZ5pGOe4hqagq8l/20pM6/zGFQgkjr96EJGGw6FNMsGxl1/Z0g6YjwXseqIkD+Xdfbn1Uf6r9soeA3PvLBkB6tZpZebx6f21gBDGdb+G7QBTXdumYZZb2fv4Pkv8sTPJXKc2HI7U/KJ8dqlwkpXpPh6d2oy7ApEoAG7JwhQJ5e56C+eI+UY2zAVZne5+laAFEsspli48zKOvE9irf49liQA4VndlZExFpdMZeWL8p4Mco3NJquR2S4by1C7sF+mJzfaSanApEUqcsyg+0rx7S7SVP4OA7ovUIGYze0DCD8YIH1dkkMddVX4pyKTH6g0iZ+SXj3yC+yamza/YeX3lOG7dpN34HZ/Lz0gLP1Z17zLwziJKdF5AwLBkFHvPkABunUspVYMUhgS8jJMbrsGGZ1SNaHd7X74HAL2OTTxn7LUWAoBxhU1a9al56Yaiwg2vq1s2aFD+TW54OIEA7uNxQdK4m4s8EBZ5bZrgwkYcRG5t3j4onA7b5uEjvQuWSLUvSTUUErcN8kbk7nSE3NU3VIQjJZ2cKsPEgQWkNxV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(396003)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(53546011)(6506007)(6512007)(2616005)(478600001)(6486002)(966005)(6666004)(83380400001)(316002)(26005)(2906002)(44832011)(5660300002)(41300700001)(66946007)(66556008)(66476007)(54906003)(4326008)(8676002)(6916009)(8936002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhKBf5PVGUsvSAtdHwacjRCNtOJqQ99BV/JxvdQVQ4CIZPCnxeBeVUist55E?=
 =?us-ascii?Q?FaGOxTg+QvNEz94af6fea/tq29jvz6xRcozO9RMFoyLvLa0l4fhSEAuIbbUt?=
 =?us-ascii?Q?gdvenYtocI17pM4bVrWFNwVkvheled6bBhZQL/1UZH8phHJBXQOx9hQzpzz/?=
 =?us-ascii?Q?A9AS6XhzNnRNiF32TvZeYfvSmy9zK4Di8QKHPTswppqPoprdsvIqZ+JssMI0?=
 =?us-ascii?Q?fEITHftKVT6Tdor5Vn4zxpth70YECn+nJ4WNYmkEhroMYBKEheSXGB2Vc7Ay?=
 =?us-ascii?Q?S+JfEPh9e85UNVrwdijf1ep6xG1g/ALnErmLAevp+EH6iwBaMFoqQHj0c64R?=
 =?us-ascii?Q?v7G8IXCy1Qqh4QvoTPkDnBckzZgq9+zwIuuDkZJwd24nSFF5m6feUSkY+1I2?=
 =?us-ascii?Q?yfVL4c8reHCenaMkqN+kIivIa5M5gwzK9u+/j3GVH7WDqkJJATy6SQ2oNCi6?=
 =?us-ascii?Q?miHvEXMJ+KiOOeC8D+J+iTtKp/Ic6LAz2oRCxI/K1j1RghVWUdvxdqO+VrX7?=
 =?us-ascii?Q?DaTa8wCB0ZYFNkxMPAW+XDr3TaNeCdcDXRTSfLylQV2gJEw7Li+NeEZ3Wp2x?=
 =?us-ascii?Q?mCH9SPofID97Q9ar4R+HTimTZIjXm3YiCDRHDCsOdzPeP6/5RsB2HxUTZA9l?=
 =?us-ascii?Q?qtIiQUZKNT2i7rSyhQdU8jgpU7KDhIPm7jfxhklynI4t8kTbTrzyLfSfJqtF?=
 =?us-ascii?Q?Su0fLhUuvICc/tG8agXXolZBS08cOyweBfwTaP+tNkeNEFXIG1auQ2fcAAQM?=
 =?us-ascii?Q?iL9fX8Yz3g+eP3AtlNZM/31nYGoxG9PzKbga7AipkvZTxikGg7W1mTbjQNQf?=
 =?us-ascii?Q?XdiDh9USwgBU3ibZlgFAjg6W8UiIrC1/e5BrtXoGKoLlyeR/TB3fpTKb+Meq?=
 =?us-ascii?Q?aIrsISceDc7o4uoFx9A0uQyN/+rbEr/+gYvAPlmCZYz+ciQ5lYVlsmY3j2ab?=
 =?us-ascii?Q?s2BBGKGK4Ae6mxS8JBQwMmKMbifeKvK3olIJo6GjFEy7+CwruhYVTTItWrXX?=
 =?us-ascii?Q?eIE0QNw1g2QdJR476azIXq96ZZS9DyeG4MWDw4wFYx2ToBErVK+mseK3pzwn?=
 =?us-ascii?Q?mMmheRe3IFeiiDpjGDFscutgW/8ZSc4MW7r9sPh3vrMkMMdDaUkk90DOx1fL?=
 =?us-ascii?Q?uS3P8o9ZOcYjoDGr9GSQT4EGeRvkmLbTNgU+IKhmOl1AtRCLtCvvL2phvGk+?=
 =?us-ascii?Q?ik0qrNx0e9gi1DD0xA0DYZPVjXOg/WnmRfgj3mDuED69jyBa18BGbaVL/IKh?=
 =?us-ascii?Q?V4FK7OXSK5/xQbvi7dR72uYAn9PvTzabAgG3pIXK18CaSOcNc8YmFm9ygx05?=
 =?us-ascii?Q?5DUeZGZUbm7NApccK0pH5GTVy+TpBvePH6Q8z4b7MRWtbMRL7vLJloGozZdE?=
 =?us-ascii?Q?Iho1hTPVT/pqIhBHcTHs2cnPnweOyXj5AueYJqz537k7lhubpu1oXi945RKE?=
 =?us-ascii?Q?JDzlWdc9dV0bICHr5VNgAT36nNL83MPr2yvCfBVofBw1xW9zMzup6Vu4sjg4?=
 =?us-ascii?Q?eyvxUZ4c15UDgm1wPlFfPjy/GOstuDWYUpCEMHB2Tg/MsrAQkxxDGuI1hTkn?=
 =?us-ascii?Q?gJsN81dcr24IpyiIuzJnsMR2ValnOp8rHsoXkhcA7x8MOEauI8LrgB+alqm6?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8ca6a-2e27-45c0-c6e1-08dbdfa7100a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:34:42.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pzBD2+63x4Foj3Ibi8fZ8AvfjQSdkpAEXu50I7t+ePUa0Z5yu7mN583eya8UN5zrKr454DVSuIiTg9IpN8onxEimDFECxch6r0UhBlqgkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR17MB4267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:03:53AM +0800, Kefeng Wang wrote:
> 
> 
> On 2023/10/31 12:34, Gregory Price wrote:
> > On Tue, Oct 31, 2023 at 09:13:44AM +0000, Matthew Wilcox wrote:
> > > On Mon, Oct 30, 2023 at 07:41:23PM -0400, Gregory Price wrote:
> > > > On Mon, Oct 30, 2023 at 11:22:18PM +0000, Matthew Wilcox wrote:
> > > > > On Mon, Oct 30, 2023 at 02:00:05PM -0400, Gregory Price wrote:
> > > > > > kpageflags reads page-flags directly from the page, even when the
> > > > > > respective flag is only updated on the headpage of a folio.
> > > > > > 
> > > > > > Update bitchecks to use PAGEFLAG() interfaces to check folio for the
> > > > > > referenced, dirty, lru, active, and unevictable bits.
> > > > > 
> > > > > But uptodate, writeback and reclaim (amongst others) are also defined
> > > > > only on the head page.
> > > > > 
> > > > 
> > > > Ah yes i was only looking at the things defined w/ PAGEFLAG defines in
> > > > page-flags.h. I'll give it full once over can collect them all, my bad.
> > > > 
> > > > (also i forgot to update my commit message)
> > > > 
> > > > Quick question here since i have your attention: any recommendation on
> > > > what to do for ONLY_HEAD flags?  If the provided page is not the head,
> > > > should the flag report 0... or whatever the head says?
> > > 
> > > Thinking about it some more, really almost all flags are per-folio, not
> > > per-page.  The only exceptions are HWPoison and AnonExclusive.  So
> > > probably the right way to do this is to make k = folio->flags, and
> > > then just change a few places rather than changing all the places that
> > > test 'k'.
> > 
> > Funny enough that's what i originally did but was confident it was
> > correct so walked it back.  I'll take another crack at it.
> 
> Hi Gregory, any update?
> I changed stable_page_flags[1] when try to remove page idle wrapper,
> Matthew pointed it will conflict with this, I could redo my patch
> based on your new version:)
> 
> [1]https://lore.kernel.org/linux-mm/20231103072906.2000381-5-wangkefeng.wang@huawei.com/
> 
> Thanks.

looks like we were noticing the same thing.  I haven't done any further
work, got caught up in another project.

Matthew last pointed out:

"probably the right way to do this is to make k = folio->flags, and then
just change a few places rather than changing all the places that test
'k'."

https://lore.kernel.org/linux-mm/ZUDFSEvpxxoGWmdG@casper.infradead.org/

I took a quick look, and the only thing I'm not confident about is that
some flags are stored in the head page, and some are stored on the
second page.

/* Which page is the flag stored in */
#define FOLIO_PF_ANY            0
#define FOLIO_PF_HEAD           0
#define FOLIO_PF_ONLY_HEAD      0
#define FOLIO_PF_NO_TAIL        0
#define FOLIO_PF_NO_COMPOUND    0
#define FOLIO_PF_SECOND         1

There's only a handful, so yeah the best way is probably to go ahead and
swap k = page->flags for k = *folio_flags(folio, 0) and then handle the
couple of outliars.

~Gregory
