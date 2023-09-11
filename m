Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109279BAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbjIKVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbjIKURU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:17:20 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B5185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAdZcFdqNc3GaH/NHSlLrr68ffQM8avHWm/1ZjQ1JbSx6L+zL/FoZ6wscwFsxSbiGQbfM7crevHaANfb9audkolHPQ63QzMXPxVJWMDY8ASDQOZHBk1MBKylj2lWhaVZ5A1Zx198ilsdlFK6pAccmRT1ZYSygvdPZJ51jvIIMklJ9K0O9kN158d6n7NlMVBu2j3VVHpuvcLhhaXDm7261y89ZbWAywEWH+xqMeFe1Ddb90D+73oUzUMwyDO4DGJqKtOMdFx934TJPnAtBBHJRfcjQwBaWw/ubke7c1roEFAkTDFRxzKIMxa0Dy/qp7fnYfyBMOj0+1p97iWvVOojmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPds4un1s6yYP9SFrN/o7bVjt1U2jCe4r3MS2ixxAYE=;
 b=GPOX1KSndozg6gVpG5vFc5GoEtSsScniJGfdTucP0V2Mhyfw2NdExOTV68UNEQl4rzGcKvY6Y5/bEzuKH3IUNQNW9ja/7rwXjVk+kWpm2+AjtY5Nffe2+VVPcE0NDLE7d9jF7ElIT/K+qBZvzM/bxakoAfjvaDf6l1w931mIS/BjNugRSjs+3Oh5rwwhec1MLQ3S9/nPldBudpZzsKJVJ3UZrGYCx3XVBK14qyMO304GOxXzMDxkt5PWJ8BqalI+GyGTx9JqlGCtsglcOJWMh76yla1lHsXIHYItu3WB3XuULCWVVqBs+qEvVWOofueFNhNoYusreVGjolMUIZ6Kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPds4un1s6yYP9SFrN/o7bVjt1U2jCe4r3MS2ixxAYE=;
 b=UWsZ2mYOvJJcXgSkbLArgiOYeptlmy57elNcv0fbnEU3+XSOUrhf4rxw+BUZYNVKlaLSJeZfuDBVsxJTsObI1auXC1DXZDwDp4MgyGJusWiyGmIaJSNx5znXyQceZZ7hIXpW5r55/ePSI9m5iRAiP7yZb8P5yqtlesypy0RTh593T62ZHCRS3MHRnoUaoby18jAHthmOe+QooMPD+0tUI+7m3gtWbXVMjizFhY1fhKkQqNPJHx3fdohesHWdiw3QobGmZhMLSu/dTTSasOePJwbWnlB7gRTlpit09gqtJ8Yh03ivPhb5yLFnu44EbR/3DqUzYJobzT1xm/ckUyXdqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Mon, 11 Sep 2023 20:17:11 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Mon, 11 Sep 2023
 20:17:11 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: page_alloc: move free pages when converting block
 during isolation
Date:   Mon, 11 Sep 2023 16:17:07 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <23206152-6E36-453B-B118-6BBAA913441B@nvidia.com>
In-Reply-To: <20230911195023.247694-4-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-4-hannes@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_2327DF2A-780D-4F4B-9EBA-B3A830832D54_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7522c143-8b57-4c51-d0dd-08dbb30414d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtMXN9y6zu3SwJ6umH6nVTHmD7tGwRL2kj87mHONJVIHWK1YOlM5/K3rfwnwDyVPCHP07M5MQ2rkYTsQdx7Pr3eA/vUz8z89n5pFcnqtvXncOdUMjXxvLPnUIghV1foITfF9uHJ+xQ5Ucn5REDY6Cbwzq+JwQvPYw1ig05i81Yoc/YUlXSTLelfYi+AmUNuHutNsMszMz5MMg8VB28cXVOgLV0Mzlnjsmkr1iaH1d3m1EHnMtxa84/gzOD8eRrrXmJ1WlUOsFyyCe3TLJAHPD1KNjSutkkIAj4sufUdVjMBdHw41XwGHA5ygUQfHsmTYunpRgNAGo6r44TqZPbQJr6ypFbuionV9RiMP8nZzOTp7UD2+o9IcifXrIUjcVdbQej3aiomfT+5LPEyd7Agk2GqyxXJEXB+2z+0cdZumMLWeGnwwoEsLBRGxtPYehz92xc6JRrV8c42u8YSh/DJwCjFGLrHMu4WQpP6d/LfLCapNcJ3YcES2yL4tCI3tify+SceN3q3aI4Adycw0LR5CLPfprVZUQne+AnxrukxGBfs8lqQJsv3UIUHTzOL5HSUzZvc5vu304L3q89OL15CYp5mv6eNWu6Zr6CdRmLJFl7yNeJ6xNIGnwM47ZLRJf2md
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(36756003)(2906002)(235185007)(33656002)(86362001)(38100700002)(8676002)(8936002)(4326008)(83380400001)(5660300002)(26005)(41300700001)(6512007)(6486002)(6666004)(2616005)(53546011)(6506007)(478600001)(66476007)(66946007)(6916009)(66556008)(54906003)(316002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iKltVih9iSJr2uO1LEX7gvSwE5qjkA4/98hb3PyCglxQ2ygZisBVQ9YesKDt?=
 =?us-ascii?Q?28Ld5OuXw84/O7JN4Uo9i3LbhWDbt1za+qGNP2VZMyO6RHWoiZH4h7sjhirY?=
 =?us-ascii?Q?wzFEv8G1/s/W+wvmoYVTTNVSg7+AlZVfKxps9ijU3oPURZqUtzpy5vP/TFlt?=
 =?us-ascii?Q?QCKvU+FJwbX5HMx0G/mAopVa/vE2bhikKqDOWvbHsvDlltGo2mrFDkDy63Kn?=
 =?us-ascii?Q?wNyRmBktUf9bGimojpF2wbJi/mAW//Rt5ZCklN7Gtn68jirjt0X1Qk0xdV0F?=
 =?us-ascii?Q?XGlT2Sp9FJmawh+NXdGa2cWcPOpwgwHHLCDatrACPlePT+sTiHnKDnyDJkoZ?=
 =?us-ascii?Q?972VTqX2W42KG1qWGsbN4Pa6lQD8migGZu3AzvmNEG8bqMGYxRiUm2xpkc0/?=
 =?us-ascii?Q?5KnsGMIUHY5NQjFVgRk0NL0YqM9+4Hj3CHC5Ai+dDvlIDhJjKTwdbMlXV1JY?=
 =?us-ascii?Q?GczcB4cIY9RZFAZAknMuIYUOllKlDnodH+wWIf5M/d2Zeju2ULKSA4sHV2Hm?=
 =?us-ascii?Q?DRaOGyR/Ftj2Z2FNaDb+p8P8W4FXAndxRAz1pSg0ggrW6dPo7phJuE9zAGuX?=
 =?us-ascii?Q?qcm6Kkg+Gm59Vb+K4LjoAMcJRghYGD2zbjf9o8Bl6u2L8mBOWaQSgEh+4CgX?=
 =?us-ascii?Q?/Ss16IyQPUOKj2Qf5GFhoyka0hOvOI5VTjf/6Rs/z++cH+Jpm/T75w0qrWSB?=
 =?us-ascii?Q?2BWOpUfUafZlwcwmLfPwXyJTLzRRnJzJzhj3GZr7XBJhUlrxO10sYmYj9Dqs?=
 =?us-ascii?Q?onYMgY2kFafzxo0mAwA/S+so/AUpmuPWUYUd+aLA8iErvGrp+cral+wQePc8?=
 =?us-ascii?Q?+8S9Drk8J23OFeoZktwzW5/SiCvLh9BUiIXApCtUgTeYp+bSGeFZX+o7t0jx?=
 =?us-ascii?Q?isg1V5OCIr/igeQyeHJ5pD9QMjwuB0ZNS0aCO+UI+OSktm8YPoctS1dryQ+o?=
 =?us-ascii?Q?t4oX3k8niTCJNEKjiYzjZQFUKX5WU9lckE2BgqZh391ZEJeSMhAH47v8Ff4t?=
 =?us-ascii?Q?EKQS+clTJddVq+1/0wgZeKY2xUc3rl7CIDETxsNOvmujpAHTz12F1prc7QHe?=
 =?us-ascii?Q?Z0IwKFrKej9EJQ+/N7cNvOmzHywPUOl2KANsKvcpFR2vNsribeiGnzLk5XPU?=
 =?us-ascii?Q?JooSMbr9uf/nv8jMOdLI0KEKHjlTzea5Jl6nvurPJaik9KeqaqRK3QdVTrYR?=
 =?us-ascii?Q?EjVJSTtjJ4qGmsTztlGD/+BAyow//zE9Ex0DXZ6PX34+Z2WpXwFqJ1FNHc/X?=
 =?us-ascii?Q?Nqm1BQGEc42qBDg+pL8KQEES072hHHv3A+gGA7dTxdW27m50AZ6+yBfvK389?=
 =?us-ascii?Q?DDag/5Xq5lKYTQRIXJ/rH70Mx0ZgUHniCUcb6niV29Gb30j4PQ3E5BWhVQ0k?=
 =?us-ascii?Q?6kqQu+n4XI037WyNvw7PivhnfSiHhk63BpAXQj82A+nFF26gPZ2gp6iiB6Vx?=
 =?us-ascii?Q?X41UB93Ll5KPiB8TbVPWZk+iJJ/9ijRRyCFiBzvOYKWuAXXLWZ99f6vpB3a6?=
 =?us-ascii?Q?VXGdLYBpuI3umL+/GtZp4DuD/g+CCDiTo2ImHaoSRJo0qqW+TK/OpViB+aib?=
 =?us-ascii?Q?zghGgeqxDPKUDQMTwi1RmrEtvn2pGg6SkX14ymCS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7522c143-8b57-4c51-d0dd-08dbb30414d5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:17:11.4997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUUOShr564apO6Kbvcku2h4L7xTgR3kxLvZhgneaGT4sT7ma0OhiCkrrRVK8y2bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2327DF2A-780D-4F4B-9EBA-B3A830832D54_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Sep 2023, at 15:41, Johannes Weiner wrote:

> When claiming a block during compaction isolation, move any remaining
> free pages to the correct freelists as well, instead of stranding them
> on the wrong list. Otherwise, this encourages incompatible page mixing
> down the line, and thus long-term fragmentation.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3db405414174..f6f658c3d394 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2548,9 +2548,12 @@ int __isolate_free_page(struct page *page, unsig=
ned int order)
>  			 * Only change normal pageblocks (i.e., they can merge
>  			 * with others)
>  			 */
> -			if (migratetype_is_mergeable(mt))
> +			if (migratetype_is_mergeable(mt)) {
>  				set_pageblock_migratetype(page,
>  							  MIGRATE_MOVABLE);
> +				move_freepages_block(zone, page,
> +						     MIGRATE_MOVABLE, NULL);
> +			}
>  		}
>  	}
>
> -- =

> 2.42.0

Is this needed? And is this correct?

__isolate_free_page() removes the free page from a free list, but the add=
ed
move_freepages_block() puts the page back to another free list, making
__isolate_free_page() not do its work. OK. the for loop is going through
the pages within the pageblock, so move_freepages_block() should be used
on the rest of the pages on the pageblock.

So to make this correct, the easies change might be move
del_page_from_free_list(page, zone, order) below this code chunk.

--
Best Regards,
Yan, Zi

--=_MailMate_2327DF2A-780D-4F4B-9EBA-B3A830832D54_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT/dcMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUWQkP/34PUmAzI0yvixQLzTbaIXJf24QZU5/yfiI6
jHvqKs+b0GJi0Ro49SM4vWNTIYt9HHlvg9uMaHqj7pezPUB3xEVgPFlwopm/Bo2o
AmFHy39oS5PxB/AYeCZLQJeRK31aD0lP+XGoarm1eF9p7aQ8lnO9d8sLUQIKjtOE
lbzblXCY2TteK1UWW1sJqblvO6dA0VD7zaKP65qt5j08szT746RhxbRWrvjqFPGi
79FF3rWbnkb99FSAb97BZrzWsN4aTee3K0dEO6ynfldVCIw/4YZ7ZRjoLQoDPpdP
QyAaHH3BFeMw0UNWpbQi4ixqNQg8IMOlkivAAbMjsYbj28o0uHOag/OcfmOT7LpW
fXePio78Y6S2Xvoi4GolyVse9Kv8eNALl3L3WIm7KvY+ykZ5u+onr+fgjRaNaT4z
NDTesU16yFEQx26qlYEDVb10ZGUmRNuL7qGxsjOR9Hs5/lLQsH3JP30gWeKe4RjD
T+xue0//xx3NNo6AFPmUgTW9+/phhlmrQ1CpFxBTjda52dQz9l5xLCZt4w5s3GgS
j7TPagAk1cyyMGib5xmeDsMDsIb3DvXZgCF5uvP5UPXeA2wZYTYu1N/hkQ07IuEg
U17nqNhcqhgvVmy83i7VAuCnKURZtv1Zrc27u06CXqtnfxPtSxe7pEYOQcWX9Hiv
kxoyIwpt
=BfLy
-----END PGP SIGNATURE-----

--=_MailMate_2327DF2A-780D-4F4B-9EBA-B3A830832D54_=--
