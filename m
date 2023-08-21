Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486E783443
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHUU3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHUU3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:29:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF4129
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTmYqsUqOwR9K7+WnvHirowffV6J6GcJblpXYZj/mrcw93EsvmHNdu/hEh+8wX+0W9v0R4th6et356FjpvRvXish45G8ZUflKvQvOFw0Sk7/cerEH36XAaEuyRlYiaLWysfNwsiDg4oddiOFgjHGJzVBP8uKV8bLHKRu75ql072JUvry9dqkODW5peVMcauAaAVCiKJGJLljQP/tC0khnpBBGVRavUNTPAos61WBW0M5+pyft7bVfzCpSdOZIbV586St8Ffn82/ca6AJdPG/06svo8dq6FXWAtAXfucY5TWKekGBMPz3XoIH0eM5CoDtCv9uxxPpDaBSjNC+TwxYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITbVn/9FjLzFSf6x6+rOC6hfJjvv5xzVwLdGnqdGRAk=;
 b=UipNgdCT/TF85WzJh+ZVPHn3emVnjZTTN7mZQp6zwnZhTmnZ74xTv5TMJFwlWL8FM9LVyLLjd0ETJla6T9KLvsiFCSpuy1kPcLBto4mOEu6/tNyrTXHLt9M0ewDSDk9AiBtX7FjymBxJsMV40zWYRGX8nCHafpOrcXf9c/8l0rtPtUDlaoGYN2f6Rurfh4RjS0D/mvIAJV0r1hf/ciPEoO3IHBXd7sxCWIGQZrdIndLfnJLTS549mQCXOX+eEiTNWoe+yr8ZNUoZkp9jhkB08G8CwSRqcX+oTAs5BMsz6W4Qy8wKgZbxsM8LcZ2YwK1V7dGbad+NnImlsRNnpA/J7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITbVn/9FjLzFSf6x6+rOC6hfJjvv5xzVwLdGnqdGRAk=;
 b=ZtCAS5UtdUOoVLFkc3EZBa2DsJf/Lo+OsAp+dRaCwdVM9j9+PGH79ml8MWYg8/BAzBf5rBRU6CbtRHEmDBNkqzO/wUEts0DHDN7qr/H3ZaAJlfVgIbZdPnV6U7NDXVt4VVYRvHMRjEueC4w44h0OptehNq9UwEmcckIfaKSzYZYCwujcVq4FFdKMW7M4TZmand3/qqMg+qQT0CowklhnY+eXgLEOVu61+OUv4ePUyaBWgzHmOQZ5DEt1fjR6j40GgLfhe7rK8HiUyuWoCIRmsY+q6zQBZJRwll4/MFKldDmOLEgs97bKdzEHlm3A2OM0zN3CZa93uGe8RfxlsY1d2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:29:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:29:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: page_alloc: use get_pfnblock_migratetype where
 pfn available
Date:   Mon, 21 Aug 2023 16:29:36 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <4DE7DCEA-796E-463A-8EF1-FB441BAEDD96@nvidia.com>
In-Reply-To: <20230821183733.106619-2-hannes@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
 <20230821183733.106619-2-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_AD35D7C6-9C31-4B9D-9888-08BCD2281518_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abf7219-6659-4302-d2ee-08dba28557a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnKV3xxZv4ikfDN5bUOR+PCvFUK6//ooLIQEmKG1lhAEVkLWM1vTsuwiN7SvIidOWLgWYRYo7EOp60KOV2TOqx/sokglXPYUVF1bEpqVRMEgx5a2FIs2aB7f5/zLeD1fIMEeoctUAdCTu6SKYXSOutlwf3UzwgpvWMzuK98w3gpivft2oEHAm4zBNtInxoDv9n0YBdfwD4DbLMJPlbELm/EhtUfnik+3fqOoYC0satvvvbigxy5me/Hl+aAaegT3h2onhU4fwaf4mgAWb49olj+XeVoyPKM41MBnvdw/k+HwSoHBy/Zks+vEin0/MsImgJJqvAd/01cM7KGll1CB7HQ9bPDlZ2GHOcdzDzvAYPV7OM2cFFvOoXgzoNVOS+vcqnkX+VvGJ6R8NYmFo0EXaSagw2wGO1GQ2Irqq0p8DRRT/MAL36XNarG29S1qTlbbTENk6OV0/b0MpHRFl/KGDQvIBYA/fkwQ53addrRZaRaSgQkIfx6b+LQevh6+A5WehsadOD6DrHQuDk7meXb5XJNe6+q41TZD9c+3tsL80RAoktkNfxJnSCm8H49kz1de3NshSCBi4FuztL3E1CCcNoUBD2mFNmDG73O/wJbBn2C08YMglKINpEUyD3HUUzMn8smoLe0EH+olLFN2odFA/69Q/LZxrkG692vS5RZnfoIsbysC7JZEi6KisiXrJRrg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(53546011)(6486002)(38100700002)(6506007)(5660300002)(33656002)(26005)(86362001)(235185007)(8676002)(8936002)(2616005)(4326008)(66946007)(316002)(6512007)(6916009)(54906003)(66556008)(66476007)(966005)(478600001)(6666004)(41300700001)(36756003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DCcdrd7ABTvH+kubyxzLt3OcKdstUIf9Xcmt9Zq8paQVAJTN+eL6OibLoaA1?=
 =?us-ascii?Q?ykQ6K5FipNnMXN7scXq1hDDYvuSlpcu1Lu68wY4yrDVLGc4cS2Dd+U3gZy80?=
 =?us-ascii?Q?D1cISYrcUZAlU473F1eHxJvwltupzSx+ZwINpYoesmJnmWph4sNlUA+Qcc5G?=
 =?us-ascii?Q?yjSrld83O5WCUCsldiNcqGa1QVQuZuJ7haVomWPFQjJB/l8Xw3Vl0M7rEMfr?=
 =?us-ascii?Q?JEpajKg9dxCF+ITrAtzLnPvz52fBr3CbzLhkmIjbw7d8jDvM/dKNG4y+xbnf?=
 =?us-ascii?Q?f8ReJ7Rt1w4NOzMV/JBmRtcExc+d7FKXZtq5WMi2+pc2w9kGYCqB1Uq44UhD?=
 =?us-ascii?Q?tsaXNrdcMrfZFWSEEkV9WPlOxdYj0x5tQx1AjuwhxRBw87SxhqKkHLVfGxrv?=
 =?us-ascii?Q?W+Krr9O6mcJGt88km0l2Zr6zQ8AblphGgs6gWz67nV1P5f+YsB1Fjig10hm5?=
 =?us-ascii?Q?VflmO75wgcOKqdVWG1rlIiVsBqadLqDprQj5VF6ivb74ZTz9UtM1/rvOmoFi?=
 =?us-ascii?Q?zhrsN92Vm36TtBgVK4CI17BFnl+N4KxWV4oSWJdCyAxZlN6AKm9dKo2+El5E?=
 =?us-ascii?Q?HIOwEthctOOVC45k7Z7/0iVVKP1CINZDbd6VWzZByUTBalqFGZDFKoxBTgXA?=
 =?us-ascii?Q?bCDdlLnIoSFeYv4q4MZ/hJOl5Fn6nkaPQIJMHLnP9domFS1mXR9xd2ABvpL4?=
 =?us-ascii?Q?zokN+otctmyE70xByLg8p5OR+qRjDHBhd18Vv9Lj2IQ/XFf8bPIOMKEwhvvI?=
 =?us-ascii?Q?ONu4ofQU4tSJ2CAo1G0oTw1bxH3REdjgCbHt9NLC/QzZiy4WflYS41avnc//?=
 =?us-ascii?Q?1cWnUQL438k1WAMjB9FcmHqeH9GC3WeACxKGI4oEJ8aJUsHY7en8UKP1NFeb?=
 =?us-ascii?Q?pkBIXjxfkgOiTAHQVsXjRu5FbMWM3iKN1jsISQRrDHlVlzhrxWXcOflVcdBT?=
 =?us-ascii?Q?w4LkIUBaULsvYI62DJlZlslY/8MAxsoNgeCeyslYun1xHHNZh84Jo7gBiDSr?=
 =?us-ascii?Q?2+g7n2M2UrpSiCCP7cuoa36afivVpuYSVKD7bTOSeWDeYTMr3R+0C8YCXFfV?=
 =?us-ascii?Q?aHK8SwGB4Ns9gkdnXZ3b0VjsC4T8rTQiekCFiFUVlZd7VI8t80WgNuqRqUp8?=
 =?us-ascii?Q?7JuAhLp2AIjv9AtNxL8a333aWj9oab9H/LTBtxBVEatIYYaTXek1W6ktcIRI?=
 =?us-ascii?Q?tXbtVfJwri0lOGxtd52i3JG5xi8BWRt52CRnYVdz51Ap99tvpoebAYD88MoO?=
 =?us-ascii?Q?zKM1YEWprvo2RyFniSNHhlUl4TyJr3TZP062CCGSA0x7c+uHvUGrVCOcQeMh?=
 =?us-ascii?Q?Digt+pNPwrosILz0F2ZO4hSmzWeQF+3o70rrPR9cPleUmUQylXObTilICgFi?=
 =?us-ascii?Q?Ls98mL9TIhDM/mrdi2hgim58OIo/380DUAxA9ujwYTWGBlAT2Oqx9TqbJRsp?=
 =?us-ascii?Q?WGzRGYqYpLwWelqdgCpLHMCCmimZzIppr3ezlOclC1tn2yYlzn4uA++xPghp?=
 =?us-ascii?Q?ARiJwncfZdDU+ljtL5hzlbNsAk1yBYL8uszWF5frhNxeYygcPXVrpVz5/Wm/?=
 =?us-ascii?Q?eU+Vfg0POpRf9CsQKDbma+Y/Rvthj5fKLOWphIWA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abf7219-6659-4302-d2ee-08dba28557a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:29:38.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGIwxxOFHZs47UtOOJNdQA6aVKlHQVvx+Tnk47MlYbu4uHRDlNZgF9kCdi66YbaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AD35D7C6-9C31-4B9D-9888-08BCD2281518_=
Content-Type: text/plain

On 21 Aug 2023, at 14:33, Johannes Weiner wrote:

> Save a pfn_to_page() lookup when the pfn is right there already.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Just notice that it is already done in:
https://lkml.kernel.org/r/20230811115945.3423894-3-shikemeng@huaweicloud.com

--
Best Regards,
Yan, Zi

--=_MailMate_AD35D7C6-9C31-4B9D-9888-08BCD2281518_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTjyTEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTPAQAI215oWpLCf6VpGGZy3XeU0nv+O3wYvgVitx
jNl1J31HEQHCKKrfiT75Gird7rT5BlveIxtY/6znkOaWX1viUj7gA9Bg3ndcGpPs
mfesUzf2V88xDegI75neI0frrSNR/hzmMwWys4oUnr54273zD130PIlaNrCKJ/7Z
NhTanDiby54XNPo48D2pY6F2UBW+DOWEASHXEgsETwCuGCbxOigVL5wIHn0yX4lN
Ns+InkISGZFIjfeaofaEtIeGEY7sF/bYJ90J95XcEG1+XEFHz4+NzIiVAFnuqxWV
6Nvr234s6oRYMi0q6YND2wU1Mp3UUWZw/Koyvab42FPyvtJXVhJM9W8ua4OHhCS4
952/qxaxd0a6cGA6Dgq7TtnIzfQgv1LZpNsUD2FsHWIbAvVbMfN8acorarQHRhho
qTKhsx5fMImdUCpdC4GgXDQOH/z2tYCW8G/7mHtrbRAK22UeH48Ka1NB76imv9iD
P0TGDzVV5/ifD2QjYNYuXVuLmai+ZI0yijl77XAkdkE9PNd+7lWmNYO9Fx2ekeVo
q019xonzVeqyHDdhTYg52lbqBVjc/RrIntCI2tBV4MYllD0X4LZvGUfonFTUB2H2
qUse14eKTGGaSriVl0ofAHVLwSts2uGzHoqDTCDD5362UHp2FG6gDUA7BilrRlXp
ref+Pkjh
=89un
-----END PGP SIGNATURE-----

--=_MailMate_AD35D7C6-9C31-4B9D-9888-08BCD2281518_=--
