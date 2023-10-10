Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2947C008C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjJJPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJJPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:43:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27881A7;
        Tue, 10 Oct 2023 08:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd4rdKErUUrh+WIwWmLWIBLo29b8YfNO0r3dnmcT2+iEH9fJ3usxZYTL1DErB9dTaSj5Gthjl/ODeAdXZptfyXArzTlOfIRtBGdwg1G9FWLa/BpjNpnhdyPnM9owWyXrH+DwtPnoaPZ6TjdT2aj0j+KXIYpcXXWfB5RCHaK4t4Iod4I8Ds1oxMcIYj7Rc7aRH+cDB0Ecc98MGWAfyeWn0kxCHl7A+Qzh12L97cFno/KuyA2jAqzIZWtrjU4FzvJzkF3I5O6EsHLRSctE4QTqDvPaIB02nVKPIaAE4HqeF/Zc4A4zVCuP7U5eHw4b0xXKlhrf4FC+4NIFPKtogft+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llrvbkD5X7depUvj5pUtPAmOIrGpABrz+hhVJmnh4FA=;
 b=Sg5D9dscCPx3P7K9chpfLbRg5vINFzJUWZ6OPD5HfnWpKFhMpNzy2miDpn2546lndhneMsy/IcDCFEC4q6AWchEMONEX6T2oZYGXiArBvCAwdlAJahDjC7XgVOhielUyhuLk8sF15wKDrCTHeYDsm+qwc6A8pb+UGO8l8/Hf7HbLY0eTD8XX6B2v/9nLWJ9LsYIOzmpJfd3Z969xSIw3pJ6EktbN0iyRSdWzbTF+zF4VQE+oHd3CidvDoKBO35Hk0IdsKptcz22QX/z+s7htc54xC7hCBusfKVm3AlkBSqt42fzTe5oVqNwMjTtMAn54gdlrCEx9VM+19bHyJ7ihfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llrvbkD5X7depUvj5pUtPAmOIrGpABrz+hhVJmnh4FA=;
 b=EO6SmuI8vQOPQMrFp6q0jbgqZuvWog5vCbjt6gOlb7qOoJ5gP4LSfAAAzVpTt/SJyqBTiNwAY6y50uw9RV7IXgAiUTOyL7qc5m+Jg4UJxvbAhXJ/S7BB38HBnL9NURztR5pAfCR24AMi2vlv100QeSzeNfvEfkjY0Nq8KjkoaGxReeEZCv8flPrxcyb2xy8jcU0by+Cn7mVTb+d2qgm4nVGKVs6FduZ6G6owOJ8j8iAKAyf9PWF5W3ckgKGPP7wOtuXZyMOSgO7hOpyv57mHuSLSs0zQVkjdaYoa/8Tpvx5gXapGo956bJt24kdVgUMwaKKPVcJdbIgH1CCv4EuQUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Tue, 10 Oct
 2023 15:42:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:42:58 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Date:   Tue, 10 Oct 2023 11:42:56 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <F8298EF2-D6DD-42E9-AF2A-01C33510CE6A@nvidia.com>
In-Reply-To: <20231010164739.236d916d@canb.auug.org.au>
References: <20231010164739.236d916d@canb.auug.org.au>
Content-Type: multipart/signed;
 boundary="=_MailMate_4D2F4DE0-45E7-4735-A0A7-83D19E40C502_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0269.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: d8055a67-222a-4ece-0deb-08dbc9a793dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3II9ThA+WQq7NZN6AT+CMHWTy8OtVPhyU2zxlXXZcEvW8Wz+i6Afk1fQbO9kAYc2Cduhrk8f34byhejWvumNJIfvVofv7gbi4ADo8b8+1j5SowUuPRUnyAI45zwGj4k158MOowmt86VxXdBi1gqdVl4Z265XPfHa3yLH8wOdqn1BasDe6vvV/7mpQoCsy2TfYUFcdeZvmWsHFSlbAgrNpyUa22BRti93pMwIUOJjLhe43XJFoQT66F3ZQAuzpVV3I2CNMm9B1aW9FbImPI+/0GZZHAqhdvLHODmn8A25ivIbNhyDOrUBtHTJ3o1ki8kdwDuLZituMPAUGcveh+53qnyXyWB5FnY9d03BP/imm0Xig3+RoYWHpMFgfXDElyq222/CLPjlLkXz5pHRiSEnzXkgEkM9/K0NOBlm/yUZE/UZg+JzZA1pEk6Md7BH113yS0v/GXiqNK8IPe5vA2GcIqk0e4OxAmf6xfJfX7EjFtfAgZNe3LAt59kOfW99u3hvYvHAatfdu955OUO/5Vl2Cm4i2Ia7aE9AhrtBSt09Sx9tXfQ1x07YDvOYxR1MSQ00ixG8BPY/kDn2xHxAIW6W8TII+ckKui93dEPL9VPt7qgg1ERr3lOuqYhN1XeCluV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(53546011)(2616005)(478600001)(6486002)(26005)(2906002)(5660300002)(235185007)(66556008)(54906003)(66476007)(66946007)(4326008)(8676002)(8936002)(6916009)(316002)(41300700001)(36756003)(6506007)(86362001)(38100700002)(33656002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QFSju86DsYK5aWiYpeRIGOGTuW6TLBGfTx8JEegHQ/xmoxEdELAnHAMT1BMw?=
 =?us-ascii?Q?d3Yp+Le/SmqmXGQsxnG8lizBes00VXFkYv56i9HIVed6sqs3FyFWI5Il822N?=
 =?us-ascii?Q?YX7HoRj6xWF2VA3INe2veilMEtWeeCkli1tCxmfG1gulnZlT5JPiUO1ydMDI?=
 =?us-ascii?Q?wem8pCzzTjiPezNi+A8f9Y+BGdny1+aqwcQ8ZzsHwSdpy67iFLvA4ErBJnAD?=
 =?us-ascii?Q?21c4HbJxdnTUq+6vJK/lPfY4ECW0KT4uL8s7tbHNVLu970Uh2k65Yj9sLlAH?=
 =?us-ascii?Q?ujj6lgjo8Dnm8C/te+FLX2arPqDi7nNrqZOtu+/6TpjM5RnQgq2fnqF8BrWx?=
 =?us-ascii?Q?yN4jqeywkRLnczTRpaM0ti5AY2hIiQ3U9ylOqi4vu4ce10FX1Po+3WRwaSAt?=
 =?us-ascii?Q?b0zXU+MsPhxzbFA/8+s3nXVe2z9XUxcfG78wrhRYFhEPgZS6XBS/Y7ARw2NY?=
 =?us-ascii?Q?VjmzChHKMC+oB1iX5K04JNtR5pkp3ygxzUddjSPo0TxmJOwHCGBGfKLQqIji?=
 =?us-ascii?Q?EaqSNxu9H1lX5HvM8utcsFinCxsu60xLsni9Lk4q4gQkuDQfQRuvUKeWkKM6?=
 =?us-ascii?Q?Ep81BWvuW4TXHVbHrXxZz5Mu36duykCEjH/7oYtpSWbIKT6/KIgnfTBo2m4p?=
 =?us-ascii?Q?iFm57rrXJI6pSBMUnBlXqOyKHU1KqauizeAeGUeXwISjq2sUpv+GDP8+JQJJ?=
 =?us-ascii?Q?1qolH3ChZ6PRJvND6Yi8IOg21+igjLQSTTjH5HpMFmOyYZ7c75pEhKVoxMF+?=
 =?us-ascii?Q?EPVHmIzUtYYRYRJm0Z+Xc1fgLmyi8eHgPp2NdtGYkCsCvHm6R/xcP0RTFMbU?=
 =?us-ascii?Q?VuFF7RBKHb0GOei59Vs6hTXe6NaxX5r7ACC0tKSc7OYm0s0pivzAZU9FzLF0?=
 =?us-ascii?Q?MTICiOVmlxeVHiPMBm1xEMVgS+ioBd8DmLGFektQejF8hw4omnngWBNr3BL5?=
 =?us-ascii?Q?0FqGgUqq4udghtI0bw60UKqSblia/bOCv7SD1Wzscr32C4gZ1hRldR3IuD+z?=
 =?us-ascii?Q?XLAbkpEgQVor0yKpP3lTLS3I1bsZZ1Yfil8aT7oL85sIo8cwuNAhes3mr6i3?=
 =?us-ascii?Q?ywW3dqmHp9QC4P5lnQscj76JZ1AOJ5NoSpvI3ZMqCrM3kCjxnPe/2PemDsjj?=
 =?us-ascii?Q?khien/tCxsM9vwiegnjcBXBfWd4qdUEPoIut+VlR3Ekz9l2dflR8sLAHe5zd?=
 =?us-ascii?Q?GVv9gZelpzOfi2Sscgn9RW7lXETurhDc4hx8q65e5aKUYDrV0M5HeaQbeKQA?=
 =?us-ascii?Q?5pFHbm83RSg5GZYMo7mJZlilNm1KVe7DHyxiM4gFAnoeGrzLjfbMNnIb+7ND?=
 =?us-ascii?Q?wST5SoXICKnKD94p71cH7piHxh2Hgl8a7JkkY+nsWg9cDCyazUMAeL59/lA1?=
 =?us-ascii?Q?w4dHfGesoA2lnsS5ckPIfWfO0PGnBeo61nlbNwe9jk3qGV1s/yh7n491bx8b?=
 =?us-ascii?Q?QYQ8FPndci2YZoqhC/QeU79MHapDS2sXzXlKqkFGx2iauEuE13wfHXz2ThAR?=
 =?us-ascii?Q?a7tH5zWFP6WliZghzpkuc74HDbIlZuA6fmmsuMe4ZL5+08x+nvwTpnFcl0rW?=
 =?us-ascii?Q?MFDL0LONgXFpSkIIcjY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8055a67-222a-4ece-0deb-08dbc9a793dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:42:58.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZRGVw0GYUusxlfp4Ohdlco5xgB4eBNTQAGxdM9PCMKFJoOdyNMvJLAIH3jKAlEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4D2F4DE0-45E7-4735-A0A7-83D19E40C502_=
Content-Type: text/plain

On 10 Oct 2023, at 1:47, Stephen Rothwell wrote:

> Hi all,
>
> In commit
>
>   2a936ebfab06 ("mm/migrate: correct nr_failed in migrate_pages_sync()")
>
> Fixes tag
>
>   Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously fi=
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
>
> Please do not split Fixes tags over more than one line.

I have "transferEncoding=quoted-printable" set in my gitconfig, so git send-email
splits long lines by itself. Something wrong with that? In the email body,
it has "Content-Transfer-Encoding: quoted-printable" too.

--
Best Regards,
Yan, Zi

--=_MailMate_4D2F4DE0-45E7-4735-A0A7-83D19E40C502_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUlcQAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUtBgP/2dPhokGlIHzNMTDdGcdCLOgmvu0jM9ABZOF
9KmRlZn3o6FZULPQdqsn1EWOgSNs0LNTKmd3dhN0xn5VQHOpqgpZC1OyAuAbnXOd
HDF/6E5hUM0hYMEPiTzCrAWrslfQcPKKjCkEHx6hKeUXR42f5zYCGUnDJElMBrLK
3Uw3aq3rgTwRO/gPiqbuV3D0aEOyzk9lAmw9kJol7k7lMUnfhnTanHCKAQeebmI0
vJJPD4K/sMiLpdfzkOWbxJC2KyEPUjXCB08NrRimx4864ow01g5NMiWuwSujpsHc
l4SnEPig4YdkfEyQNCpyYdYam5hZ9YZk7d6UIyH/wyR75fxT9V5Be1YMVKP8jcSa
+7KD55WS5HBuulP/hdf2tRRudvcbdRbAgYuk4j7cAd9e6TO2akubdAvtic4cArU/
0qjplgMQrZ6Cr1VtoPbItNYAJB/5k4OHfxqIWCVUEMrTadKC++qzusmmUj2+jhr/
vPJCRA2LrORm35U4GH16gfvEgex34dsb6ZY0i58+nZ9inLAfraD4eZhV1pft/Mpq
Gw1UYvbNrecIw4UTL5zCHaSpQDZ13wO/euGt8OlWq3dUpiSLuMgUPi8CQCfdY2mS
lWkAcWxR2GokmnUD3XAi5uMmiFORJ6zMIFhxHwgfNbGJbJjaSytNEBGUWdDQmAnk
x5NQpQMc
=V7bf
-----END PGP SIGNATURE-----

--=_MailMate_4D2F4DE0-45E7-4735-A0A7-83D19E40C502_=--
