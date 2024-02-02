Return-Path: <linux-kernel+bounces-50530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD4847A48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A428FB246BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1115E5DF;
	Fri,  2 Feb 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bzTNJxwO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0C15E5CF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904775; cv=fail; b=DV38zBEriANQMH/uZrCotRPPu/Jg6sFpxxFAoNfoozgrkHueoVlrki99uI30KS1Tvg5HBP3NxMJVtxX9EYlvbcliVAhc9BYsN+tZU5oEjiqGCYwvayC3cCMCBx4+7zyjFxMBrUq/eEbrSzy0C3a9ZTIQTrrjULHVbQhulO9ULXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904775; c=relaxed/simple;
	bh=m4vTY8OnJq9HnLzswoo+g44pL+ztj7N2Wk3/MG7Besc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nevJN4XjDIJm93flHAeg04AB7JmcG3gK5h2HAVJjJBKoMGPto9NfRXOnsZS+8lkxSBPZifv3BkVW0XAUStGjFNbuXYrrKBYcP0pB5YpwFHKCo6RXRKERdOk5Po9xsC6Zf5SqHMHFWg5QA3bf+cF9fYh9UedgHLtS5+AynfkTUjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bzTNJxwO; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldp0W/ZBcGd/3tc7rng2+SQCVTv50GXmdFuQ1Bnek7grmFYgFzlcHQT2bqDuzBwmJtfZVtlUeSBfyhvuxc/F3sL0lRJQjQg46dkfnEc7Sr0kJLKCjDMPtq1y0k0rFn1eF1Ul06rOaVs2uxMM/HAzA3VcEg5B+rKQqRnBjQRqQi+ljFKZaD57R7NSdqlqRx0WYIwlEtr1Va2RpbYAKjAiDIEOkL+7VpqDIjdHGAuk8nbmylbCwTzZYXMu5nsBkQiFzcA8QV0/J6ByGUXrWTlM/LKBliuABpc/fKwQfX1E+XwlVp6uFKUO3cJYUsEJ1IWyuPkC2p/Hso6e2MSmzKnNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4vTY8OnJq9HnLzswoo+g44pL+ztj7N2Wk3/MG7Besc=;
 b=nxq5vPvQ5S9f6y2MDkSCjdSJ0YQHLogzs1xSow8UFuRKii69+mJSfKnp8WM37polwR4ddkUMFQ/puzbmGKSNDL6Z5Q5zOAzmWPy2zj2ob0fkClg0FztGXgyMO8PiDJYFNKZKr+J8nKnoD0pIPobCbf34qO7kPZmEKxDn+ZY5UpE2w8kc62tYWqM4+99VithxwqylSo3q8kWmJDRr2XSgFzeIA+UDRNd1tlTuHP+HnLwu/b5yGbpIj7pTWemZ36Un50mex4O2s1hM3JHzm+zLlpZsEm4JyklOr3eA7hmOvXWih2j3xct0bDOR7vsQGzvr+m6XT1+H9xyTelLBzcJMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4vTY8OnJq9HnLzswoo+g44pL+ztj7N2Wk3/MG7Besc=;
 b=bzTNJxwO6WU38StGdy8CFMQcsyv7UhXkwyEc+DtLAAV3CbHwA71d3V+t9qZ0AS5r0NrLu5NUVdvAJxIPYKS9w9bCHWdW6/aXPjxuGAbEFz/htDNcytVtTJVC7nZUU0PfsOtHZISIM88Aimdx/fVwN4sGVlX29nvE8Nv5mJ0bNXVXS+0k0syKO4FraG8hgZ2axF+NYnbgjG/kQcXItuFERxbvLoRzeiqClVWOWXD9YfW0UvxZ2HsHihAuHJg69JaClePoFAuWSwXECVetMP4vYdbMfb4X0bV7KLK/cC3mKfHtMp3uOQc2shqRhEyP/nUucKCHA9BhQgFHBGjxcQIqrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Fri, 2 Feb 2024 20:12:48 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%4]) with mapi id 15.20.7270.012; Fri, 2 Feb 2024
 20:12:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 0/3] Enable >0 order folio memory compaction
Date: Fri, 02 Feb 2024 15:12:43 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <1D834490-9D3B-481F-BD7E-8EC1AF31EB84@nvidia.com>
In-Reply-To: <Zb1Ity8GND1Sm2Y7@bombadil.infradead.org>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <Zb1Ity8GND1Sm2Y7@bombadil.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_2CD4040C-4328-46F2-8148-AAA4634D6B3D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5903e84e-05fc-42b4-50b8-08dc242b5349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RdeKMrRqPFoLA45jC7fhNlbLlAR0kqpiF9kM985jlCCaMDQ0ezYIjpWKakEWJCfws+kD3LFcbgQ5ypgizI4meeUvasAl43vacu1u6F3jrTVT0Q7q39A3HIiwWKa53AzUG5KlC5b1Y2eknQS6KxQP2IRNs+q2H6RHNZpt6E8juVchopzwmpz7UEslNGWCCg+0fb5iFpvOa0uXkgDP3X5qiU+2yXEyfgNeoctpDKSxDToVUoCOyUna+yT1Ti2FByn6vBzEObHzWr+CKzjaxqT+hSQV0mh1bJfqqlgsecfP0BMr66WfO8NDVTsHYVSf1DxMmupNZJogMmcTLBKuxfRh1nfzfk+Wk6I0ihV9t2HhJxMSZpsmHttRYKqmFQhHnx423BEcHMUp4QTImp/TKaXslHNqudfUmbMXEtNNyYZjpUUX0gnfZ+vYVp+yR14dgrtByUKw+QqM5s6oGyVS1uVX6vzXaL9soRopSXi7CQrov5hisf6CpnCa6rNqHjUBFMDunEV05oja9372fW1lhWEiMPiS1fJooNu++5T1zGMSTDuswkdDjwBeV46TVzANVoUjRx+NvudmZKCQEHvIUlJVHY/cQuRIzwT4ZT8pt2P3ZSwA0UEhwOtFMyhBLqAbunhcbmlM7dt74tYl2eyUrppxzQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8936002)(4326008)(2616005)(6512007)(26005)(6486002)(966005)(41300700001)(478600001)(6916009)(8676002)(36756003)(316002)(33656002)(7416002)(2906002)(54906003)(86362001)(5660300002)(66476007)(66556008)(66946007)(6666004)(235185007)(6506007)(53546011)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIapzBeEzcL1aKLSV0fIZCCUKXbdnrASKwKyrjG0nfhegP7WGV6KEkpGE+JO?=
 =?us-ascii?Q?OgXz7jGfInAbDgA/j2IUYFEFgu6reY5C9ooc884wJTXld7spD9u9ecbQX/Qh?=
 =?us-ascii?Q?zb/ZoEXDAAycmOMdbTCnXWnhj71S0ClrAuyHsDeLUthU/kvPdqjBwsxDmTWF?=
 =?us-ascii?Q?jETSBlgxXPHKfdeADvfgSJq/m2PzY/Z5cSBQmTf5VqW5qdA7iqApIQA8PDZY?=
 =?us-ascii?Q?JIGEBCoQeWWaojjcqIiHB0dAu+xpAt093BaB0lGqJ4dUYI53JPUR2LxXSSja?=
 =?us-ascii?Q?I5vLuEwkw/obw3n9LtOHhNOwVDscdvTe4hgJOZD1j+VMIoKa5giZojP1LsyP?=
 =?us-ascii?Q?9Rhda+5qCUuxl0ibqu/OkbTPvt/l3jQ3DGOVh8A8X+BL5N9JU58cFnw2bEaP?=
 =?us-ascii?Q?pf7mSPZMJNvehb94XiAX6mMNKnjiGfsDLPmfw1ATEF6Sid9RP/Ussp87s5nk?=
 =?us-ascii?Q?0tl5piSqbnGJIL4oABlRm9Lmu+f8AKesxjxEbXQ+RMq/M2vVa4wuOIdQaI/c?=
 =?us-ascii?Q?lmtnMJ+mElPlkz0kGTjVIzgoWh4jE2sTQq6fwWNr6qrjLb86H7ewG/no1W7a?=
 =?us-ascii?Q?GIofdyswAplncPwBEMCVzCQel37NJ4DGhJiNS/XiwYdAKNBCtBJIGWDZu1pj?=
 =?us-ascii?Q?uoAe/QErnx58GEivJMx3q0mTJYM7l7HXkBki+Xee1Nv1hnnR20oQ6pP1EDXh?=
 =?us-ascii?Q?b2g81tiLVbZVBjJJItxW5CdSd26yzmjpk3C/+CzkkBeie4fcsOJDIzPeMaMe?=
 =?us-ascii?Q?QH9eKndZNq4LoJTkjdb6bYexf4TNGOuMHCQpNlbjF+ftYaNU8xbDs4JYhc7x?=
 =?us-ascii?Q?kUMZi/xHcI9XlLHvfjpM0T2j168Ab2YK69xPqyecXIS3CxfbLC8ZmaJGfvdI?=
 =?us-ascii?Q?4z3HRkMTmwlfdXaofRBJNXa82a9SdPf9QBsB5sEIs51kS0aUx7KXMuTzru1U?=
 =?us-ascii?Q?AFAv4mPuOSROIzzTXSFDDVNG/2S9Huq6ovxEaqFbOiJMet4QJpA6AKMvoQOI?=
 =?us-ascii?Q?vgXXx8/STCmQ6yY3O8GQp8CtPWx2W7jVVJOqdxqxtJoCKZJxsnIsCNFK8GHD?=
 =?us-ascii?Q?O7jmlXZO/nBG8ZODXa7zVMOCsFyTMpu/96mWU3n1/K1NQoVo1H+APcxDK1Ka?=
 =?us-ascii?Q?N/DwmWM3Jj9PNObZP9OhhEBU6yLtOUSOWv3AxRL8JxTfPPYuntouUx3dsCGK?=
 =?us-ascii?Q?sYE6VRNnpKts+4cOHRnzn/PzvKV8IDz16epezBuoEYsKC/TK4zqCieCkzsyw?=
 =?us-ascii?Q?nk3cpQ370APPZoPk5Ko7EGlFyiBj2Jk/hn1MQj3nnM1MV5F8k+scZgMwIYIa?=
 =?us-ascii?Q?t7I+uyFcqYmiGkS2Un0vQdLz+DL7sRP6RhAfVDEkZuvnC3JjKVu8z0mKan+G?=
 =?us-ascii?Q?3BygJHfH9+kAye/3hDyH5Gq3q3aoYSDD9kSaxTLZRLlUqzoDeWcwMcCHWWkS?=
 =?us-ascii?Q?1wr5WgIbn7i5v+d+seoen+i1pK0Um4Qpf1rz754RCKCW3unpN42qJSgoLw/Z?=
 =?us-ascii?Q?qRv2Ev/CEAoVkDBSwVkuakL5arrrLddH+0tHKuzrCYwdJjqUBn35MMerdbQc?=
 =?us-ascii?Q?NFaC/hhpGHPfTmsof8c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5903e84e-05fc-42b4-50b8-08dc242b5349
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 20:12:48.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkkVx7Gu60kc+m9R3Ly6j115B9Q1VvG+V7XmacqZZjIHZeCf44PaIvGKoOEEL0JG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

--=_MailMate_2CD4040C-4328-46F2-8148-AAA4634D6B3D_=
Content-Type: text/plain

On 2 Feb 2024, at 14:55, Luis Chamberlain wrote:

> On Fri, Feb 02, 2024 at 11:15:51AM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset enables >0 order folio memory compaction, which is one of
>> the prerequisitions for large folio support[1].
>>
>> [1] https://lore.kernel.org/linux-mm/20230912162815.440749-1-zi.yan@sent.com/
>
> This URL started being referenced to your patch series instead of the
> rationale as to why this is important, and that is that compaction today
> skips pages with order > 0 and that this is already a problem for the
> page cache. The correct URL which you had in your *first* cover letter
> is:
>
> https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/

You are right. Thank you for correcting it.

--
Best Regards,
Yan, Zi

--=_MailMate_2CD4040C-4328-46F2-8148-AAA4634D6B3D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmW9TLsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUNzMP/1TPblHwb5B+uKxkkTcg9i+yQQ7wZ+7OEjRX
IG5SBkkAKMnbCJd1YaVtRrBUAYELLmaLZ1amCZaeMdY7pptLBez4k7BoTUnvZuF7
ijRxNsqBRBYqACSmoWpRbUbQg6765egXkSmlIMR+EUOtDVjJV/a9jupFWM03Mj0q
FnkLR/UK89HWXr8iLobGTBmyqjfjwxRuQ9Tv3p8JLM5haKUemsaDGkabSf95dN4P
iipFKIw80QHv884zsm21/6Hsj2UOjILLXvhQSnpfL2cmZQmDC8jUH7eQY5EEc5c+
gNwGmuMCnbKp+DgHoBcV1BLPbrghQ/wsNatC1kqDSAuK1eX9/p2D4yrd+/e2c+ZX
gZUwsh4PsOof0A8EEbUZXKhYz2BkLESwFkt3W2AIQVmdBRBu9Qw60ZLFo8F6lpe+
kHoD/oKCK+wgWSBcz3ZrfaWztdGUCmkV7pSV1O5jYTwj9f3DMhUQf0dGlxnnAS0f
47at22z/UYSzJ8rcVFP3NpUn/4z/invVHX4dK/Z/eoVcFoxe6tADP6seAsuSklqy
ZO2/+Nh8cei54VlcZI3to21Iv0GpJNNCf3lhBeRzcT9VfVNL4W7LnMxPUIlWSCtm
zj4W//Rz25ZZasQNjvLu24kHy+pObWY3opPk4SSvDnmLf8yny/0YYErY+C1h0RbU
7vTjVsp/
=Po+C
-----END PGP SIGNATURE-----

--=_MailMate_2CD4040C-4328-46F2-8148-AAA4634D6B3D_=--

