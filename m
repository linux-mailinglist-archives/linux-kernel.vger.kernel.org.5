Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542479422C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbjIFRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjIFRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:46:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E56BD;
        Wed,  6 Sep 2023 10:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsIY5aYx6I5vbQMsqveQHnYhhKVdyepytrdHMOmWHmhR26SFNZPl4l7RSlVGExdx4bJ95ZX74Gjw2AQJwg69C23e6mLlsCxT7ud90KG9yf6U2CrCN8tw4M+sN0r6lHlWMuE0ntGcNmRIeMhy5/cGZ7tHkP9qzQw0Xxfj+dg3qWw3YWLfCy0BrUe4NFmKoQb7F9tKnMTqG1ZPUWEC5oSRnTRQVDfGoqO9yut3SxITt24mGXZ+HOL2OK77AUk/LxLOdKpS/A8MLTMH2QRqSUGO7xou0UB2b1BFaoE1s4JGtsXtQGu7FGX7YOhp8uxKsqMOQilGVNVwZFZLXGK9+ga8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezs3NtbA83xZyejgN+FDpevcuPOqvPEOXIrxBZjSMyM=;
 b=f6jrIIOn7+8iwA/rkYUwLHALefWeCUlhhdSLPZ55piwW2pfUQc6+vG8pLRSTqXb/bEhKHIuieKZ7mM/CQQTeFT/Szo5wDR4IK5rL6whUug7PcXBN6AVeG537ZgbOCgjU94EJekaax1eBT2En3E5pEXWrkAlv6wvmSPBYXPyTy8dPh4jXbrcz9Bky4Rb3vz3gSsA+CR8hdtEUBpX5bSz8NkoJ3JME33NezDogJoArP31J+t/4Le3cc1luzIUF93PWhxQ/59kvXkrErmZDxxnjHPA6wwYOkqOpOUqubNfUpAc7Nf7V9k+6i0254UWEymzBZ50l5NKlgJ/+TpX/AhyJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezs3NtbA83xZyejgN+FDpevcuPOqvPEOXIrxBZjSMyM=;
 b=ipcMWV54ugcEzNaYl+gW8mkkERxcWIfVij0SnYzM35mP+ksOCamgTbpDr0eb7ERycVc4NJi3jDpMoSxCPKPpjOgg362LjgY5KSRqJ2nqhDGy1rAYfZDKCSFtJEwyurl7VZFs/5vP6EVbBikB5IT7nE0Oap7aZkyAOhGS3sV6TyFJ+8Hv8rbKUTkjuNedv2lJ4+i/3pwCA12RsxtAmp2z1fQn1UYWaWXrCINKp0sU4/MqD1icK7f/pPXRNPAOXmurOqpLXOGlai8Fyqx0aFeehdW/+aNTagCCrSDSyCfi1gw+Yr2ReGqBOPYf3GQOqAdYFdYSQq8/1u5wAAQj/YLGcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 17:46:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%6]) with mapi id 15.20.6745.020; Wed, 6 Sep 2023
 17:46:43 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>,
        stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 3/5] mm/memory_hotplug: use nth_page() in place of
 direct struct page manipulation.
Date:   Wed, 06 Sep 2023 13:46:41 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <0B2678F2-9072-4C82-B233-11D74246FA8B@nvidia.com>
In-Reply-To: <20230906150309.114360-4-zi.yan@sent.com>
References: <20230906150309.114360-1-zi.yan@sent.com>
 <20230906150309.114360-4-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_747CE04C-1464-4207-BE8E-40EE01453762_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: f16af328-08ca-4d67-f414-08dbaf013bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqMKxbACYymENn8An87GYT4G0i3ajzf297HtpRv5lO0Phq2hxLwWOjO906G2q67TwnYWe798arbi0plTjGNVVliKpum57IIU2D7SNi3OzyoeH52YIUtT8rQpKiBa5g+5gqkUMjHyiPPFj0dh5QQ3VGD+t/eCwhhiCNXW51NYQuOmMMK9qvgWEsPqfaxSdpobNqdWe3Twg/RRjXvggxHi9G9pVjzuComF0HCqpzEPMwi4+UaHjs5CZDfC6lCSvbiL17e9ExqewGmF3UDWvV964z9muNqXLyehxY3NEBYcFiHTlmB/v1PZYsklvN0SXVCHlrbPlFS+n9bSw043c1nabrxZzLCIcrr7uJIRA1YmnE0fHN+fFRDfrWtWT+3F389CTUkKZYbeu6WSs1QPk/W8shQiafXu4riQKz4huCvDNUvFk+dwjKjSJLDJBAGMLMSq/qFFz6MT8BooOVz6Ds2a/EgsLWIJYQOA+FcIjTnIudffNvejBDhA6/UYorLM6wI5SBT7GnN6Gz96eNPeGtYn31mP3bpKne1upRDjLN19+BumMoAzc+yVa7UCs5Wv0hMW21zozGPY/3srDgLsTLRK1OiY7urNG1DWPAL/nTJawKKSM6Dtc5VWcI2Tp1smC1S+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(1800799009)(451199024)(186009)(8936002)(5660300002)(66556008)(2906002)(54906003)(36756003)(66476007)(66946007)(316002)(4326008)(8676002)(66899024)(235185007)(7416002)(41300700001)(6506007)(6486002)(53546011)(6512007)(26005)(38100700002)(478600001)(2616005)(83380400001)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wcvaJugLNgM2hqAtdwF90e0SuLyU+Oxz6X2PPkKw/QYqaNmUGFSf8Xz6lsoB?=
 =?us-ascii?Q?+KhW7IFyEEPFgfutHQGqMws2cVvRzzkbfH0xlFsZLAjWEeg4cR3ckWXhPUpP?=
 =?us-ascii?Q?ufWCL+u70atlljIavFcXPIKDOrhAv2PBVwhxPVqFJ0kHbU8zrWiBQ78NCEeN?=
 =?us-ascii?Q?LBppX+HXp31UAdrA7CF5sZfJcjVKb6BoDEchVFRLc9NQTyRlG070Q8vPoQ8f?=
 =?us-ascii?Q?OVakXrjlt3g5s77h2qu7Jm8LeVYRazwHYkgcSCLi2sfJt8eXkJOqalWJu1k4?=
 =?us-ascii?Q?5G8yVLGLAAGOd5hy4JrwCwjFuKosIKgrDEsafungqhMe0RkwbofeJuRg2j/s?=
 =?us-ascii?Q?HCa49ABrAUn9qOySzQi3oUSxgHJnLbMx+9fLvn/5dL8Nme0p3mxC6vq/71fS?=
 =?us-ascii?Q?S2SwMyI3roOE0IYbyEcPxRpaGzlZGwqfgw4fDCJ2bO3CoyOI5qbpRFsXydDw?=
 =?us-ascii?Q?fgXCmAg+xBp/VRjtNXm7Llo4hIgKTpBMe+tlaltA5F+4MHfLqjRGgteJi7gn?=
 =?us-ascii?Q?1OlufUPmPxhs+d17aZp9ZrrEFhtWU75urzJely+Hc2wl7w89y1Q5fEuWa9Nq?=
 =?us-ascii?Q?VBoyk8jySL+z+wVfa0UgtaWlSKAU/Mrpu3SX2LEUt5V9/Dd+osyrH6JPKBcB?=
 =?us-ascii?Q?doWnZOa8fE3d5jlOnmsM/o4WPSCdIhUxrimobe+n/HXB2BWa6b51b5a8xMUM?=
 =?us-ascii?Q?SkUAa8pW86VC5z+BjepSddEc4MJxk6wv9HzU5MdbM1JksMshKf6TJmrodDzT?=
 =?us-ascii?Q?IxNut/f9xzAwfLpYe/VX2zyKQ/jge7c04Vw5KtS6k9++lGMJZl2vtu9Ix8x0?=
 =?us-ascii?Q?Fh7ElNx+Yo5guPvZBpbRZq19X6JpiR/nczxqLdePg9LC12Z8OfFST9c70pT0?=
 =?us-ascii?Q?k0y/AIEuP4zYJ4GDgPWUuHRHNur5vusv93fyfBxy78L9eGY0cvTDkwBvDDuq?=
 =?us-ascii?Q?1eCIh9tdcnvnl5Nt/p3gIq3He1dldvNjXs4QaUHQzD8z5przRrYaIcvww7Mv?=
 =?us-ascii?Q?OgjDe1KdN3A1CLsCL735siDurtlJZtYv7fbEp9mZMMN3YCvaRSlIgiPwprKU?=
 =?us-ascii?Q?f1z9c1qhlCVnoeifHp2wvF3xR2ZxHVkm+sR6GaQuMQ3Lyhb3VNU4fdPTrFsu?=
 =?us-ascii?Q?VPOats27I2v2jDqagG49+VsKIJFpOWAgsouLkt5zH95QxT04zZrm5eNCiOZO?=
 =?us-ascii?Q?OvmwVhOfGVcgEFeWhqAQ5tQWyzVld/NcYCts2WzQY3Nb1oLkaxkc0uWzuKyb?=
 =?us-ascii?Q?in7hpVzYX3XjFz59QwHmb2Fdx+WfMoy0OnlkU0IBOJMUyxSOspnFjJ1Wp4Xc?=
 =?us-ascii?Q?XKQ8VM84Wr5ns0cl4AnZ+r1jsmVjVfYV7nalO9L37NrGiNyiMsZGoVHIGgDQ?=
 =?us-ascii?Q?KM99506H6K15tDKD9SDAwA7uyRKsBNKZ7Ri/9ZJ3KI5FQcK/xMEvcYkCKAwr?=
 =?us-ascii?Q?3CEnTq3vWpTageL1s5sPL7zQSdFlEFvqZObyT6Go9Cc4xe6NOl/lm1zdhalR?=
 =?us-ascii?Q?UG4et37r2mfwzqkJOLmTmUb77H3tfJbftYZ6nGobuLDrEZoVe3ZiLdmOoqdW?=
 =?us-ascii?Q?CFXAHCthWuztVXifR02URnBdyQceNRUsbes+yVbp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16af328-08ca-4d67-f414-08dbaf013bb9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 17:46:43.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fufoNRBthIlNQ1b2NUov0GCHn08eaHmwSgs5QUyJ8dBidPZvYIzlHAdwAAbSRCpw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_747CE04C-1464-4207-BE8E-40EE01453762_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Sep 2023, at 11:03, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> When dealing with hugetlb pages, manipulating struct page pointers
> directly can get to wrong struct page, since struct page is not guarant=
eed
> to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle=

> it properly.
>
> Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for g=
igantic hugepages")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1b03f4ec6fd2..3b301c4023ff 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long start=
, unsigned long end,
>  		 */
>  		if (HPageMigratable(head))
>  			goto found;
> -		skip =3D compound_nr(head) - (page - head);
> +		skip =3D compound_nr(head) - (pfn - page_to_pfn(head));
>  		pfn +=3D skip - 1;
>  	}
>  	return -ENOENT;
> -- =

> 2.40.1

Fixed the subject and commit message:

From: Zi Yan <ziy@nvidia.com>
Date: Wed, 6 Sep 2023 10:51:21 -0400
Subject: [PATCH v2 3/5] mm/memory_hotplug: use pfn calculation in place o=
f direct struct page manipulation.

When dealing with hugetlb pages, manipulating struct page pointers
directly can get to wrong struct page, since struct page is not guarantee=
d
to be contiguous on SPARSEMEM without VMEMMAP. Use pfn calculation to
handle it properly.

Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for gig=
antic hugepages")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1b03f4ec6fd2..3b301c4023ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long start, =
unsigned long end,
                 */
                if (HPageMigratable(head))
                        goto found;
-               skip =3D compound_nr(head) - (page - head);
+               skip =3D compound_nr(head) - (pfn - page_to_pfn(head));
                pfn +=3D skip - 1;
        }
        return -ENOENT;
--
2.40.1


--
Best Regards,
Yan, Zi

--=_MailMate_747CE04C-1464-4207-BE8E-40EE01453762_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT4uwEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUvfQP/Rm+QRZzWyU48cnq6fBWYZcGY0a5rQPOUJIr
plXKffv6x0jVwk4IWsnNiRaHObmn7PADVWOBqlU4mX+W7z/CGo6niaMNCJYgUXyV
cygfRJ8eOjOpAM+8K908EfX1nm9oPqnQCwjNkKY+XLZb1/0njCU8rDwY0Wy/pUEU
FIyX3nxxTvWWi+7h+Ew1AHT5mX+QNVC0rfTiUzfAjKH4BXxJUNe14Y1xss5H2VcO
4RK1z1vLStD+hL6nDuBz7Ocahzcv55177a/Ewe8Ds/pcEpnP2xDBwpGqgDkX20Gy
nfp0hLtWr54uki+Kma/4Ij5dLNISsofrjJ2UUmGGBYmrypttDlIlECuknuE2skEz
1ubcQ9kq0rRCEbOZRuQU91Qt7fGo8/PgnVhVrVo0S179W16VSHIwZMTJqQBbwuQv
ojP8zkv2JlIeRaQzsaZX/k8Jaaczu/n0fy//JSVLVqP8DCoEdCv4x4J4Rv6mzaFA
4A8nhIaECb1kg1xpqwJMLhniNgfa7Q+SoIsTIN6S+zVoJTUy8YSNXLtrf7mDMa7U
C0rmq5ECH98m41o8IPuHbepZbjfF6Icux+wXHsVB2U9CwlNVww2FjD287I8etTTz
YkyX+7CoRttz/uQ/3nblpr0+1OQJS7jI5FXBRIdCnSLgcQ5Udm1akmjVZNPYgl3e
oXusm6K2
=jBK5
-----END PGP SIGNATURE-----

--=_MailMate_747CE04C-1464-4207-BE8E-40EE01453762_=--
