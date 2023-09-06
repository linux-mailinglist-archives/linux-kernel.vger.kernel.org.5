Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0479421B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbjIFRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbjIFRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:39:31 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4786199F;
        Wed,  6 Sep 2023 10:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4cD4JcWQuwRShCcPmTx510gt27Nuzvbn0VY2KFqeoC64eXdqw9b/NZJsujq/8zdCMWFtjEPYqxBC+gIvhnol1olUsWjbMf4LAwHJ7T6Nop4m0+LhaLQhYU4BCw2Myv1Ilo0s4KWbOuIgJzic6BhdlI4cTEiyJIX2Lrk2ABTzT2horHz6s5vaJvAgjmF7detg769srvXL038mSYo6wy+b3IiRmdrxaIiDSp0zGH3wv6hWfihn+Z871fwMXngjwSwppmv/UU1xFYaWBIjo7dsncECLXYanx5LnSApWc2DkOpdE3iTX9xXrajopdeCgeMF352PmseSek0pz5XZWyKo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsLJ8JDS8kp9CuCdBBbBhLWt9wIkia4b0Ciu25aUqi8=;
 b=AeIrBWJThxLWEsRGHdCX4F6w1qHTt9vb7b5BaRe1H6TXPlEl1K7+GDG9AcyM+1hR0W1aWxgEVQncSjKp6HRdaW5efh/FWjGHTOZExTO9Z3gIG2+BmwXUy80oDga4kQmYSFVVNCndNIhgr3STjq5bIuAqUJMFNfv21JoexLLU2h5zDclDOWwrwT7fo9zkRDFeqIaA3x1zRDZwS0jKUaTvhUiJYSJ9vwJ78zljnGtinUC7ikGWmrCfec6aXZ4Nl/b9K+i62GrZrLr3vkmQKPchxOa7+8ycvD6qpL8fl3FisISUpjJMK1Q88kZtxTJEiSReKsjgdiBop3JfGGRtdhk5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsLJ8JDS8kp9CuCdBBbBhLWt9wIkia4b0Ciu25aUqi8=;
 b=cFJeTb/x78bJYkipC8ds+SVlAsR5n83KQ4GgR8e417dUqVkVTNOawfsoaGHrvcMADWAqQAD2cWJTBmpQaEUtAUAHJPlinUK8bJvXafpukgZjHv9oBUBddllFsfcgEguy1JICzANi5VBadKnhfKC0Vfd9yrKeAJoACOLQljSs+22wOdd+3q5ol3/g8kACWnmiMPOgWqngHzc148qWExP00MpC3WolpqEdHW/6zZptF7ydFGJS2vUI8YapidOTBx8fZIt6SpTEhrVk+41aqUZJcoR/NS3NuinxDFdeEHkDCJECS3yEW+C8mT0um+Faa+eBZ/pxnObCqIsfJKUZi+Gg1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 17:39:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%6]) with mapi id 15.20.6745.020; Wed, 6 Sep 2023
 17:39:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>,
        stable@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 3/5] mm/memory_hotplug: use nth_page() in place of
 direct struct page manipulation.
Date:   Wed, 06 Sep 2023 13:39:23 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <C9420CC4-0EEF-4B7D-8B60-3434079137A2@nvidia.com>
In-Reply-To: <6dfbc043-c969-f78d-1e56-5434026246ea@redhat.com>
References: <20230906150309.114360-1-zi.yan@sent.com>
 <20230906150309.114360-4-zi.yan@sent.com>
 <6dfbc043-c969-f78d-1e56-5434026246ea@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E4CFAC3C-2139-4160-8BBD-3BE0BA237AC8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:32b::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1741ef-5f73-4192-19f2-08dbaf0036ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dh2g41Dqb3Qm7BGpV1jdd3JP4mBEKasRC1CLNOiCdtEAb2k9jq6UhFJ7Sqgm6QUX2t/nbx6hxybRMxKao/9CJqNutLAWu5Dh1nlQqmqylyA9+PiRw89YG12hfDNu9ySQ+cqa16yeQgcSdUCm5OPXhoHa6MM8eydNQEYJtJ6TYedD8AEANiCMN0cgcjRz9aQZEK30EhpA04FKvIJgvT0LZ0B7Vsnrl9awlRJjqqOgtwCCaIajXKEbhONuq3An9k2kSKFG5inoh0rR8h6ZTRt3HVFQ6g4rvvs/mB6dzYvUTpvycijgFtsiZ9BYAVCyOM34AAZgpm2iSRGSRVHtkkMFpjauBPmBniVM8pszZ5xqfgloNCyQGBBZnlDc4/dA5qUjztyuYehDoAUnNa87LlnKUO+5r7OgcUwUtwH5UBBLdeNoa5z8w0JPC4MNmZvkijX4iRLB5UumVoIhZRkbSUgXBAz9NiV7cnv1VSczf42/TaVy/HcrFwD/4o5hK7BR1+Laq/G2vfDAB+m/GrfZ5psa1asB4QZIrj/VaSZsg3EsIVGyYClFX7kVHTSgU7E7TiEvGYIu1t+bzo4tIB50UypLoT2teiPIE/c3UrmKVHZ0R17njFRdmZx685u1u8ONXkc/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(6512007)(2616005)(83380400001)(26005)(6486002)(4326008)(6506007)(53546011)(5660300002)(8936002)(8676002)(38100700002)(478600001)(33656002)(235185007)(54906003)(66899024)(7416002)(86362001)(41300700001)(36756003)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fbcGY6H8LC0cXrjznPLSi0dAYRkImpxMV16eiRElZuFyfIJVXlAR17YEYHdO?=
 =?us-ascii?Q?hJMUKm41MxUAf/1zxybXsJzogG7oaz/PS2MzsH7o8zwLa1znKtKXdRFRb+ND?=
 =?us-ascii?Q?qDZ+zLX40pvveQOI4gSjhktrZ393twR4mS/qEROGAJ957QlWjtCzU9Pxof5B?=
 =?us-ascii?Q?ZxlPWck0+6v4hF909z9gFLiOysrFvLyHQOQsyPsofMItomRskw9978v6QeWR?=
 =?us-ascii?Q?kTUNYVjtJCLoGSb5XgoNBA4SGIJhbocekVJgC5qAi8YvnI3+Xdar6w1Ox7bd?=
 =?us-ascii?Q?jSmfaxzHtLWzeNJXVP0JitDDkbegMpqpmyKJQCvmdXA1snZ1rDlWZ9MPvfTY?=
 =?us-ascii?Q?ZDdYj4xQ1RvKRRDIm7NdbF44UTghWa70Sflh/hMML+o3nfhMu6Jv6I0gUlrA?=
 =?us-ascii?Q?ERCBcXHQYuSWAZpYhzeMy1bRF1bYQzDfRCbc8Rr7AfmvFQW+yY3mG+KWnhHP?=
 =?us-ascii?Q?dzULFtQB5clsTjNzVIJo3z309wD1End2RVnQgvhn5jDrGxQbDHrdiZ6AWu+k?=
 =?us-ascii?Q?Iu6GGWUTuAgr7rcByWW5zRtUwjpTJNWveUiAhQSUg7TVoY+IDFzOP+v5L/hH?=
 =?us-ascii?Q?eoc1nPDPXYB74++SffzpAgEt9UrytUYAUJGvlralaBs9louJxeOur3QHM1OY?=
 =?us-ascii?Q?4ovSWNy5fgBIQfrkU/0WJCy9/9w/kJDUGp/NMRVZ+S/pHASYpNVyyta/j1mu?=
 =?us-ascii?Q?wjuUthsAYc7Uqs4Gql8HDa/ypqzGKFiRVAF6cWsRWneJMtKWRGlertfKcZUW?=
 =?us-ascii?Q?+2wqyHWv22emlSLsd5kbnCkp06sn0nOFITnPn3QAMDAcWtReL8unmYt4dcFv?=
 =?us-ascii?Q?RBYfBQQEeGMKHPI4Idrntm62yiaKiMNXJwCxAMhvLvwkUa8QR6y4xmN5zeG4?=
 =?us-ascii?Q?6bDOGLWkGEELMW1OMduaucMRzam1Ah/HvphRX+jxYGlvWSCLIK4o8WD6+SAY?=
 =?us-ascii?Q?1WHCEgdFmWAlp2j5QW0e94UTcCwQBZD9dJq6SVfkHgFNlsVQkRMDgzGYS2sU?=
 =?us-ascii?Q?3qo+e0H/TX3g22QEt4pxwT2iVXppN7/CdU11FS8D8RiwpUeTGd1+V9M5Qoib?=
 =?us-ascii?Q?+7z4E4n1SDpos2fa1EF+JcBnoFfSakoKKg2H12j5AOEHFivAWW+2TktuX/kV?=
 =?us-ascii?Q?qwKZaO4JL94KW3pwHC43hKmdsaHw6ODsDt/R9j6BoEgsmOA011BI0xdp4AEX?=
 =?us-ascii?Q?CL3Dbcdj5wdm0ZioAIKhEBmK3Ehrb56feY4bvcWtrBlitc4mQNNsIxplfgwt?=
 =?us-ascii?Q?ffyhTUsqnIVl22OtKHUjnEGowVPt1pEqI3fCDE41NvMH/xeDf8TvZGjdYQIF?=
 =?us-ascii?Q?l7m0NOd+bC4RLli/8ohm+YJI1mkpmukVWms8wbhyMajb+NJh15qm8eGcFKk6?=
 =?us-ascii?Q?PaphQe/RiM1focCn/Lx/B9qLbuz8KSkYMARKci3szyNxQfkQ0ZxMeV93DDax?=
 =?us-ascii?Q?PJXHD9KKfZ253PmWroBH3JmqQOXNtJQ/8CMndgAqgCmr2ueBKYvI3Nbj7l7k?=
 =?us-ascii?Q?J35eYj+xQWbOK2uw7CQom0zTUE4jzoniKUNYy42C1hQtX9oa85ySc7j0kT3y?=
 =?us-ascii?Q?SG/p0N8mM1Xi25PNAlA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1741ef-5f73-4192-19f2-08dbaf0036ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 17:39:25.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY/Ui6YhwdkJSKeb/toxNBK4//d1ZhFiS1p4TicCG7+HJOJS7YEyrgxwag56QZN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E4CFAC3C-2139-4160-8BBD-3BE0BA237AC8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Sep 2023, at 13:17, David Hildenbrand wrote:

> On 06.09.23 17:03, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>
> Subject talks about "nth_page()" but that's not what this patch does.
>
>>
>> When dealing with hugetlb pages, manipulating struct page pointers
>> directly can get to wrong struct page, since struct page is not guaran=
teed
>> to be contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handl=
e
>> it properly.
>
> ^ dito
>
>>
>> Fixes: eeb0efd071d8 ("mm,memory_hotplug: fix scan_movable_pages() for =
gigantic hugepages")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   mm/memory_hotplug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 1b03f4ec6fd2..3b301c4023ff 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1689,7 +1689,7 @@ static int scan_movable_pages(unsigned long star=
t, unsigned long end,
>>   		 */
>>   		if (HPageMigratable(head))
>>   			goto found;
>> -		skip =3D compound_nr(head) - (page - head);
>> +		skip =3D compound_nr(head) - (pfn - page_to_pfn(head));
>>   		pfn +=3D skip - 1;
>>   	}
>>   	return -ENOENT;
>
> I suspect systems without VMEMMAP also don't usually support gigantic p=
ages AND hotunplug :)
>
> With the subject+description fixed
>
> Acked-by: David Hildenbrand <david@redhat.com>

Sure. Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_E4CFAC3C-2139-4160-8BBD-3BE0BA237AC8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT4uUsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUdQcP/16W4/zA91pnNA5SwwygTsznkZhDhePLU0zV
o/HQImbjUNdpCdSeK42ijkuWcqyyz7o07q0beQxmgbiolup8eFTa3nWlf8fwvW3c
biLgEJ7Xj1BI9JXAJgAVJxjkdDjURfopXS7X3g6SObvie/ogF0Ist5hmoyazLUPU
8EoPXRE3yKoVwSwlR9wZi3HdcsXVj9IXm4ertwLF/nmQljaMN1dtpLLymh4sSGZj
Oo0jMA8YkD6BDKxEHoHsJsA2978A7H1ADtwDhVabyVuqAl0R7i38/VkyFw9Zl74D
NGRzA6TuLIJbSogdtTxHD7F2KQQ4RUmAlUUXtIjeQYQ6uYaDdwzl7hasTkSr7cOq
b70Fi/2u7Axh8vLxArzCy0iy36i9VrITDCC26rfLhwEAnA0tACh0pwDa3zdT/SoN
wfYq4dDtCiDDQD3e/tfb9mlFhyL0wNesBx7LqRAe7TcS0a1VWuZwS07Ps1uEsPOw
5+0xTj5JIvsAyEqYwNTv2s4IHw3X6Ofd033Az7odj0VcL6CWDvaOwKhH5szF37Fs
7zmrsb5Pf4ThkMAE5L71/btM7JOn5OXTDZN28XCbrtYFXK06+txPaM7FfrIvdU19
ztJ4v4qjiuOYzGqOzMQrUOGUDXJbTZnBycMC0ywZ6eYv0YOwbjZRv+rJlMbud3z9
UJgAI1u/
=EmGG
-----END PGP SIGNATURE-----

--=_MailMate_E4CFAC3C-2139-4160-8BBD-3BE0BA237AC8_=--
