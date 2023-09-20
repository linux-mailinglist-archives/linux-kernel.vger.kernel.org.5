Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D17A700D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjITBiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITBiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:38:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C06B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 18:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhOn+5hoq+2FiGiY6UF4orDKkfYbyb/j5uftJLU6OgiwJPk94WT8fOLg14rchvYjdaAzFPb30WpjC68+k6o6XjuDL5yqge7/D/MGLb0m4bCa5oQrYRnrh/VrA42YNeaAnoxBBfd4WGVsvUANWE0OY6EJpuRfaZumBT+GunECkA9QyZxhf36Y8pJIbzXSfP/lgrGo/KATJzgmp7I5eU0wiCYkE7bO7u0PgnN3Y1IcS5JaaMlStdo1Sk1VImJwyFGW3Lw23CvVRrJ/Jj3MTROI3nPhXo0zpVI6nPH794Zbq9gTzO8IzXVyIPsvdCdgQ2Ma3prjQT9TRhB3Tyi4oZM9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PX2PdfmP6ZzJq4/Q9NMcNTcADBIRF5S76C+FI3Wi7g=;
 b=kEylmWwUKCxcU+FuTPDLsCqtGMu/0N8nwr50y0P6aPzjfv80su1bT+1QYYF0vJj2ktLz7XaRAtRbTb1GRY1UbpWSAagMr59hlbvuZM0qaSJMvQolt8pfSGwjaL6SB0dJZhfvfeWRKnF/Cv9m+378h1Rzitg/viwU8DSFPvO/r09V6OSfXhNuia710E6voUnUG/jBRvtLp2zZTyfLlmgh95dcOSou4a5AXVJsVSoO2IVC5mx0XFmxE256B6Fe8TQ0zjfrRKaLp0G9ZRmJ+EROzt0lD6LvYHIE0Q903bg23a8Wrsk8lAEAU8dzEIlHEb0G19VsVUweUv/+QsN3hypVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PX2PdfmP6ZzJq4/Q9NMcNTcADBIRF5S76C+FI3Wi7g=;
 b=VgnNjVWyNGVSlMZS4sXMG5QEgsNpqCZjdwNSt0V+D3xZwhPCzNU/s9eAnVSl+oZeab916Oi4LSXZS7KjGmaDeaNUPVeyiswh19Gk1HhxX2S7pinAsZt+ELDVGQDs9LV2P+lvlhuzpROwPuS2ifVWO1oqd0H2flGTm2IBEmbv/d5yptvGmtlcpOE5XyGjokZuc9orjjm3wofmb7ohxAeTCFPx+LCAdWe+DXMUsO/aM5eShiNB8GBNGUaK7wjAPZ7VkkwDIL9TcAnZoFSx6LDx2iPA2wski7I353cQEJc3HWNmcaiv7WL7l4+vLUkRqv2MAnB9VRpb2mVOE7DKkYrqFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Wed, 20 Sep 2023 01:38:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 01:38:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Tue, 19 Sep 2023 21:38:01 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
In-Reply-To: <20230920003239.GD112714@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
Content-Type: multipart/signed;
 boundary="=_MailMate_77C232E9-D467-4FF8-8827-BCD44AE3F94D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:c0::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2101ab98-ff92-497a-46fa-08dbb97a3b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgC+pdQG21MwahN3JAtUoDEKO+f5fr/ZgXkwQ53C/cKd5Ol6AZRxbXD02ZL+99C1VAPmAU6unxGAaCXbfkNZ0XDddQ9/IMzRdsADqlU5DaeVLNt3IKXwRveaNPDbWiet+E4jUZpR4NSzYPCeyRUnH2kDXy9jBoMtnFmJLWhtmwQeew1lGMq9F2xLNUcSPYCz0aEvDct+b6FunZH0EeuEyrpaxDZWP4+Z/wfggc6msuwC7cjNzFj4KMrrAn/krk3bzomBjqAzwtE85f6lnupp5dHqhP+x00M0F1oBo1qxy98pHjyHBig39mO2q8+qAWPZazXgRDemAU1ldP3ptET5T8nxL3S4EKudgqZiLKNZMNDC03Cx6KmJgNnR8znU3Sme1uf7ucNNUxvZ1GpgWh6xIgEwctIjahEVLyVyAprPdgCFxrjL8G7F6jdpE4cXjXKH3o/ViqBruW8+h5Mev8r5KatE6pzABrVaTmfB7xJUuQCqPHfDmRScdJMKCeUsWyUsx0+/lj8eTrZxrovMMhm65vGpT/3qt1PFm3VgdTS473fkJLzqCD7YS3UWKrvG3sUyBA7FZPHk16ViKfR4CaVHau5m9EXkwE5sygqULIJmH7lh7DhJpdTADXF7VQhjMVW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(1800799009)(186009)(451199024)(86362001)(478600001)(6506007)(6486002)(53546011)(6666004)(36756003)(38100700002)(33656002)(2906002)(26005)(45080400002)(83380400001)(8676002)(5660300002)(8936002)(235185007)(2616005)(4326008)(41300700001)(54906003)(66946007)(316002)(6512007)(66556008)(6916009)(66476007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xVWzL7wltBVFNdhVTl4K6RgEqiYvQlKDtaXugUtiS2rXJHN7SzI5dPyCbXKN?=
 =?us-ascii?Q?gDov0xCDlKKAHG8PcEm4mxGyWD4IsrBy4jsF0tG4gNa4uXFWmo6fPWXbELdV?=
 =?us-ascii?Q?iYotJ48giYcBoNO005rV7yQr1ioxThIRSXee/+ih/zN/OelDN0dNaHnUelnP?=
 =?us-ascii?Q?mmhAigd/PFklzhGv2lCFO38w2dsh3dxTa0ZZWLnj4xWjfs94igHkFJ9Gqjvg?=
 =?us-ascii?Q?5i9bwhoyL9gzoVyqL0iGtwFsF3bq3Esymr2AG8YaG1RdYkNzspNR88U45rbu?=
 =?us-ascii?Q?qeEXACOMZPs52x0wvTDhMsIwuun0oXkrflr9JlWDirl7nqSDP03GK9JUa/HV?=
 =?us-ascii?Q?dbyBOCVYJ9ez3pbIjcnXGTBzz2WjKZwayG0IkZwgPWltUTnWQjsIj2VcWfVR?=
 =?us-ascii?Q?Ph8dvhpwevLCCi75OH1lZc9aES1oG+cMbkuTdNs0UPuKf4S2sPXMo13dJWoY?=
 =?us-ascii?Q?dV0l84+ncedMPzR1FwAYEyB6HvncJVxbXyPosnMBXW8RDUDvUKOG7odemOzS?=
 =?us-ascii?Q?y62z1p2TqGzsspAQgkbT33WhH5yTGL5Yrd55EtVT3Bq929kA08xeBP0dzhc8?=
 =?us-ascii?Q?b2tFdEO5VDfIqVqG1h/CT8bVG8622eBDciUiA4x5DAxzfB1ix8PolP223EKP?=
 =?us-ascii?Q?SuHjfpFuc8AqonEDKEGDb94wk6P6JR1fotRvC2Vn4j0uTHl+AguKqXAzu6Tp?=
 =?us-ascii?Q?Y360SzTrM2EuYwZSlsUGmTVZyj7jfD1ZxnGF8/rU421DGYThieIW/LWjHTeU?=
 =?us-ascii?Q?8X6ZISsUBkLbvfoNvW6CThwlkQTtcoT2AJKVQKoMXFz2NA2fU+PwyLc+Bjm9?=
 =?us-ascii?Q?SaTOmBmBKATHkZJIhbME0FaLO10791EL0GI2o0pPQvT5dweEAN+bD033C3E5?=
 =?us-ascii?Q?c6tIzRUQBoips0yty/nDRZku+7XLP17+jVz4gW/9KK5DC6Fx0iXq4ICBhtRD?=
 =?us-ascii?Q?C8Lp4b9E0qX9nb7eZiJqChC3ufodoRg4pqQPBAmzEdfqmSPAtT2ZbKs8S61w?=
 =?us-ascii?Q?h8eiVfkr8Cs90UCXZ95xU+KlH1sSgiJYypJhjv7hpzvldCrQyRM2DYFjNP4n?=
 =?us-ascii?Q?d2VmW7DHz/3Cw/w5P2F3AgHakrbP55YaHrDUjiAo5TRPphBFT3gSqVUgnHpB?=
 =?us-ascii?Q?k5+RLcKsARS9Qtx7JDXtLcW9fUhF/xggEAK1ABztGUiyVOFn3NSA4dgIUZxN?=
 =?us-ascii?Q?RTUUmvHiSMGW+PqvQtUExb4C1zBCf/7kTvrB3XTkyNgVilKO+JgPTKMc3WHc?=
 =?us-ascii?Q?DofgfqjP66qPgaWDHpf0ECmvai3WD5qYrIO2Yzy/PiKo6lW1Hcvi0/lfyAvf?=
 =?us-ascii?Q?usz8NpmEKS9fj2WoJp95Ijd1RsKxIy0f0pcJId+ACvVcFKdA8vcNfuzMcygt?=
 =?us-ascii?Q?Y6ct95r1F+J28JehgC7/nnIGeCuJrQfqyxvv/UiTZ4DVTUif3hnUr1PbL9Br?=
 =?us-ascii?Q?KjtBGtZIaWKYMq8c0PgTMLKQ16VHrJJ2ea6ddDadoYGCmkCavH36eJOJK4YP?=
 =?us-ascii?Q?6udcklYmd6vEUNeB9q1Bomn7A5NKrbFKg2VQFF2hb8T5/GRTrXsswtqIXE8q?=
 =?us-ascii?Q?862Nuy2ws1tZwya/HBg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2101ab98-ff92-497a-46fa-08dbb97a3b81
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 01:38:03.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjFe1a0/jgUYF63CH7dxhA7l7z6PULDwYAzurP21RXi9xtR3s/0DCpLiVSmGGZx3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_77C232E9-D467-4FF8-8827-BCD44AE3F94D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Sep 2023, at 20:32, Mike Kravetz wrote:

> On 09/19/23 16:57, Zi Yan wrote:
>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>
>>> On 09/19/23 02:49, Johannes Weiner wrote:
>>>> On Mon, Sep 18, 2023 at 10:40:37AM -0700, Mike Kravetz wrote:
>>>>> On 09/18/23 10:52, Johannes Weiner wrote:
>>>>>> On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
>>>>>>> On 9/16/23 21:57, Mike Kravetz wrote:
>>>>>>>> On 09/15/23 10:16, Johannes Weiner wrote:
>>>>>>>>> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
>>>
>>> Sorry for causing the confusion!
>>>
>>> When I originally saw the warnings pop up, I was running the above sc=
ript
>>> as well as another that only allocated order 9 hugetlb pages:
>>>
>>> while true; do
>>> 	echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>> 	echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>> done
>>>
>>> The warnings were actually triggered by allocations in this second sc=
ript.
>>>
>>> However, when reporting the warnings I wanted to include the simplest=

>>> way to recreate.  And, I noticed that that second script running in
>>> parallel was not required.  Again, sorry for the confusion!  Here is =
a
>>> warning triggered via the alloc_contig_range path only running the on=
e
>>> script.
>>>
>>> [  107.275821] ------------[ cut here ]------------
>>> [  107.277001] page type is 0, passed migratetype is 1 (nr=3D512)
>>> [  107.278379] WARNING: CPU: 1 PID: 886 at mm/page_alloc.c:699 del_pa=
ge_from_free_list+0x137/0x170
>>> [  107.280514] Modules linked in: rfkill ip6table_filter ip6_tables s=
unrpc snd_hda_codec_generic joydev 9p snd_hda_intel netfs snd_intel_dspcf=
g snd_hda_codec snd_hwdep 9pnet_virtio snd_hda_core snd_seq snd_seq_devic=
e 9pnet virtio_balloon snd_pcm snd_timer snd soundcore virtio_net net_fai=
lover failover virtio_console virtio_blk crct10dif_pclmul crc32_pclmul cr=
c32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_leg=
acy_dev virtio_pci_modern_dev virtio_ring fuse
>>> [  107.291033] CPU: 1 PID: 886 Comm: bash Not tainted 6.6.0-rc2-next-=
20230919-dirty #35
>>> [  107.293000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS 1.16.2-1.fc37 04/01/2014
>>> [  107.295187] RIP: 0010:del_page_from_free_list+0x137/0x170
>>> [  107.296618] Code: c6 05 20 9b 35 01 01 e8 b7 fb ff ff 44 89 f1 44 =
89 e2 48 c7 c7 d8 ab 22 82 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 e9 99 d=
f ff <0f> 0b e9 03 ff ff ff 48 c7 c6 10 ac 22 82 48 89 df e8 f3 e0 fc ff
>>> [  107.301236] RSP: 0018:ffffc90003ba7a70 EFLAGS: 00010086
>>> [  107.302535] RAX: 0000000000000000 RBX: ffffea0007ff8000 RCX: 00000=
00000000000
>>> [  107.304467] RDX: 0000000000000004 RSI: ffffffff8224e9de RDI: 00000=
000ffffffff
>>> [  107.306289] RBP: 00000000001ffe00 R08: 0000000000009ffb R09: 00000=
000ffffdfff
>>> [  107.308135] R10: 00000000ffffdfff R11: ffffffff824660e0 R12: 00000=
00000000001
>>> [  107.309956] R13: ffff88827fffcd80 R14: 0000000000000009 R15: 00000=
000001ffc00
>>> [  107.311839] FS:  00007fabb8cba740(0000) GS:ffff888277d00000(0000) =
knlGS:0000000000000000
>>> [  107.314695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  107.316159] CR2: 00007f41ba01acf0 CR3: 0000000282ed4006 CR4: 00000=
00000370ee0
>>> [  107.317971] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
>>> [  107.319783] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
>>> [  107.321575] Call Trace:
>>> [  107.322314]  <TASK>
>>> [  107.323002]  ? del_page_from_free_list+0x137/0x170
>>> [  107.324380]  ? __warn+0x7d/0x130
>>> [  107.325341]  ? del_page_from_free_list+0x137/0x170
>>> [  107.326627]  ? report_bug+0x18d/0x1c0
>>> [  107.327632]  ? prb_read_valid+0x17/0x20
>>> [  107.328711]  ? handle_bug+0x41/0x70
>>> [  107.329685]  ? exc_invalid_op+0x13/0x60
>>> [  107.330787]  ? asm_exc_invalid_op+0x16/0x20
>>> [  107.331937]  ? del_page_from_free_list+0x137/0x170
>>> [  107.333189]  __free_one_page+0x2ab/0x6f0
>>> [  107.334375]  free_pcppages_bulk+0x169/0x210
>>> [  107.335575]  drain_pages_zone+0x3f/0x50
>>> [  107.336691]  __drain_all_pages+0xe2/0x1e0
>>> [  107.337843]  alloc_contig_range+0x143/0x280
>>> [  107.339026]  alloc_contig_pages+0x210/0x270
>>> [  107.340200]  alloc_fresh_hugetlb_folio+0xa6/0x270
>>> [  107.341529]  alloc_pool_huge_page+0x7d/0x100
>>> [  107.342745]  set_max_huge_pages+0x162/0x340
>>> [  107.345059]  nr_hugepages_store_common+0x91/0xf0
>>> [  107.346329]  kernfs_fop_write_iter+0x108/0x1f0
>>> [  107.347547]  vfs_write+0x207/0x400
>>> [  107.348543]  ksys_write+0x63/0xe0
>>> [  107.349511]  do_syscall_64+0x37/0x90
>>> [  107.350543]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>> [  107.351940] RIP: 0033:0x7fabb8daee87
>>> [  107.352819] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 =
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>> [  107.356373] RSP: 002b:00007ffc02737478 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
>>> [  107.358103] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007=
fabb8daee87
>>> [  107.359695] RDX: 0000000000000002 RSI: 000055fe584a1620 RDI: 00000=
00000000001
>>> [  107.361258] RBP: 000055fe584a1620 R08: 000000000000000a R09: 00007=
fabb8e460c0
>>> [  107.362842] R10: 00007fabb8e45fc0 R11: 0000000000000246 R12: 00000=
00000000002
>>> [  107.364385] R13: 00007fabb8e82520 R14: 0000000000000002 R15: 00007=
fabb8e82720
>>> [  107.365968]  </TASK>
>>> [  107.366534] ---[ end trace 0000000000000000 ]---
>>> [  121.542474] ------------[ cut here ]------------
>>>
>>> Perhaps that is another piece of information in that the warning can =
be
>>> triggered via both allocation paths.
>>>
>>> To be perfectly clear, here is what I did today:
>>> - built next-20230919.  It does not contain your series
>>>   	I could not recreate the issue.
>>> - Added your series and the patch to remove
>>>   VM_BUG_ON_PAGE(is_migrate_isolate(mt), page) from free_pcppages_bul=
k
>>> 	I could recreate the issue while running only the one script.
>>> 	The warning above is from that run.
>>> - Added this suggested patch from Zi
>>> 	diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> 	index 1400e674ab86..77a4aea31a7f 100644
>>> 	--- a/mm/page_alloc.c
>>> 	+++ b/mm/page_alloc.c
>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct =
zone *zone, struct page *page,
>>>  		end =3D pageblock_end_pfn(pfn) - 1;
>>>
>>>  		/* Do not cross zone boundaries */
>>> 	+#if 0
>>>  		if (!zone_spans_pfn(zone, start))
>>> 			start =3D zone->zone_start_pfn;
>>> 	+#else
>>> 	+	if (!zone_spans_pfn(zone, start))
>>> 	+		start =3D pfn;
>>> 	+#endif
>>> 	 	if (!zone_spans_pfn(zone, end))
>>> 	 		return false;
>>> 	I can still trigger warnings.
>>
>> OK. One thing to note is that the page type in the warning changed fro=
m
>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.=

>>
>
> Just to be really clear,
> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.=

> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range ca=
ll
>   path WITHOUT your change.
>
> I am guessing the difference here has more to do with the allocation pa=
th?
>
> I went back and reran focusing on the specific migrate type.
> Without your patch, and coming from the alloc_contig_range call path,
> I got two warnings of 'page type is 0, passed migratetype is 1' as abov=
e.
> With your patch I got one 'page type is 0, passed migratetype is 1'
> warning and one 'page type is 1, passed migratetype is 0' warning.
>
> I could be wrong, but I do not think your patch changes things.

Got it. Thanks for the clarification.
>
>>>
>>> One idea about recreating the issue is that it may have to do with si=
ze
>>> of my VM (16G) and the requested allocation sizes 4G.  However, I tri=
ed
>>> to really stress the allocations by increasing the number of hugetlb
>>> pages requested and that did not help.  I also noticed that I only se=
em
>>> to get two warnings and then they stop, even if I continue to run the=

>>> script.
>>>
>>> Zi asked about my config, so it is attached.
>>
>> With your config, I still have no luck reproducing the issue. I will k=
eep
>> trying. Thanks.
>>
>
> Perhaps try running both scripts in parallel?

Yes. It seems to do the trick.

> Adjust the number of hugetlb pages allocated to equal 25% of memory?

I am able to reproduce it with the script below:

while true; do
 echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&
 echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&
 wait
 echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
 echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
done

I will look into the issue.

--
Best Regards,
Yan, Zi

--=_MailMate_77C232E9-D467-4FF8-8827-BCD44AE3F94D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUKTPkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMWoP/Rxn59JjaBHOWx4F5b3/XsdA1eOqKGyXH2lO
LNka9FopzNGntjbkGjc0m4b7RQ2vQll2HrodyvN0wTtQPhxOQwH0sedXow3c6itV
ujfeN/nVe9u7yrBlmjL2CHuuZ6Tq9Zc8FkwiHaIsDalP5hu6Kc24ubIJAPDVVXM4
9jnOhWVar/6xsv5bqKu2VqeqzvKupGZ1lK8LBL4QY8E4GSj0jzD9Uxwybn+lMupG
LByEeNoI99PrryBeCUCfGqXEijcRckKAKjv+hkob3wxfDMxuFhjUN1V2PXMDEdfE
b3I2zXL+30FQqZim4/2pkERBjSnxndZksVWGgy854j54ZwM+0T8rB7+LE25zxjIC
Q+VfOLMf2q996rEf6DBhrgpfIdUHY0BD2ZPFEpPCgb4P7KEzQwiDOMr5LGfxVETH
DkLexcevT2wOlIi1utRPUfOsMy+5ThlypzJDQ94H57OipywtUxVaJm5AJAnR1GEp
xeIDNdMnp9hDYyzK/xAZZSJ0KKyerC1iDmI027uwuEXS/PWBRnR7A8hlaoCscglf
x9IJkfVWB7CkK/rEF17xq1z5fF2Id25Mz34mK/cvpagqCxxVtnjvt8ngPK9QVggC
GIAz32LYJUE9702SVfw8ogvDPV1KdicHu5INA99SrVU0EU67tsc1dbwIZgxDbwtR
Qx3o0BEZ
=sDXL
-----END PGP SIGNATURE-----

--=_MailMate_77C232E9-D467-4FF8-8827-BCD44AE3F94D_=--
