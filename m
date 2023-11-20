Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0337F1543
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjKTOGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjKTOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:06:11 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE745D56
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhUzj2zVhyVzXMBHv8jYdWMAeHWkLaICgKEiDLcOlqNMAkZ7p/kJo0WcO02eUt5RKPNEbSyv0BSLSloxaoTm0qjYBnwJsuKFE7Ujc/oXOgNgiA108mlDuVOc+CTmqaQRhPa9t2qdK4UeRXXTv2iNsXdBQTRlEh6G/JyEHBNWkr6p0vn6s1JLYdq/CMvsVF/zbziTSwy5yiGTnXf4iuoUMAlrXpj1qdHiHp1tYzkK+6VncgQ9MuyS5z6KwAC021zeY7uiUN7KI45/uO/WmErwcsNCmvgMcANkpORw/QadJworOLxXfmIe7yTh77hbM9qjfSXd5Fd3B4YFgvxqbgFCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzBJi0Tl+PtlEKNWnmWnQaDCecgWCE4/SnyIftmZKhI=;
 b=G4I04sl7l7TaDbw3XxEek9A5xSy7gmWkngyx1VfVbU34uHEdxY4NkIB53Mz16LROrxNjcnbnNwWEnPY4rR7Zq8MxP800cA22rE1ehZKkER0/T0tOp/UByCowTJcutaZPA54ATuOYnEJpPFa+TylbkBrclCyxWm6t6eJ1Apu3bQDobWAS4tbmnfXg5pAu6zQkCBbSFNYGkqdEYKzOEsRtjkiRo2AOdM9ZqoxQOgcYdJhFKjax8gYuiyzusk/RWO+oxoJZaDlP9sQvvu9Tq8UH0rScolO6YSBbQPJ8cYlkMAwJh2gSIcnmDUO0dzgx/vizJqOZelvvCyT6Wn3LgSXd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzBJi0Tl+PtlEKNWnmWnQaDCecgWCE4/SnyIftmZKhI=;
 b=a0nvIwN1cNIc8xz7TIzUX+L6MsCd0Kcgzxgqueac9VDh2aoLAgaTg26a85iM7x47LG9rOuVXnRSQZSkaNDEfI9n9X4RjRlwaEfQRuTKKKbI2mgmqVSVUl7kp0E36KISBFT2s4T0rW/fJHS5RtNzizeHiVRJvu1YxN//NpHQ3ANNBygjSWrsiQXgeA0VP9ErrK7+8SUhGfj8PGH8wnPMfLhjV5yxPQ9Z75rmxGCDJq1XXeIkDfQAnd5CeZOR9eTdtNXl12oZ3rHfoH32rbyu20i8VVZ2ZPCLgItTZ7f6ult5Qh14fsHwA/RylDka933yhihhEruqFOFQQg5pHER4jGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.27; Mon, 20 Nov 2023 14:06:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 14:06:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 1/4] mm/compaction: enable compacting >0 order folios.
Date:   Mon, 20 Nov 2023 09:05:59 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <300AECEE-2B86-4124-8571-E74E97988C50@nvidia.com>
In-Reply-To: <f2111ca6-4be7-4125-af3f-ffab47378bf1@linux.alibaba.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-2-zi.yan@sent.com>
 <f2111ca6-4be7-4125-af3f-ffab47378bf1@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_9D869630-A5F2-4105-89F7-20631DE21D43_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: c9715b2e-7937-44ab-8283-08dbe9d1d3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7ILcM9DmAKx9b84OapYiy0/NDL0VIv4g+JFDxk0i71CEVrO/tXbDv19BJtSF17T9FWFMu7FQIEx47hXH46CWxjL3990FyMEC9tAflYLTk0jhrKI7NTS24MpVGY5tuMb3cPdO9+vNap6MABACnZY479d2L8CtjH4LDkv/M74gUVqf6EUrbVlBBIAQ90aaJYWe9AWCy/4zjdFpRf46LRYyyIwDAhgIVPjI6+PVAvcCqkWikLHJbviNLDB3ww+oXALMJExwNLM77vdbepIkQ3lMSxgK3UhQ4ht2OgIkdznC2b/CXbVPca8o7yGpQ/pUzTVPPenjJ/9WPhQDLdcyRvK1O+hRaqSkKgh2So1bvf+TMjqnP1tQyxkm+e/Y5sol8Z8pUABeS3jBEru1SLulvnN1PNYfrF7EPc35H0NE77kV7WJtYtEfd+Up5vR7+pRkKu+yW4i7OWyPNoKJSMXVuOkheRAeVYPm5dcwo2HIIV+4wkb+YV2vmpmrSW9Upj/QNXVErD8dcBZYgWnVG6OIOwOUB33oUXArPmS+XOOQSt6LffuhbL95MJSb2zTm/CTX+XtYvVw/U4+9dSMP5CPqFCILags3o5rKPERcDVgw38QzzKlCVmEGD41n79plSeLKqjo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(26005)(2616005)(36756003)(86362001)(54906003)(5660300002)(235185007)(66476007)(66556008)(66946007)(316002)(6916009)(8676002)(4326008)(8936002)(7416002)(6506007)(41300700001)(6512007)(6486002)(478600001)(33656002)(83380400001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XLsrDgAjNPx1B1cZvFPnbOXgxCi9yqCeBOLWw8HBEwXiKD5hdAbr2CSFPx2F?=
 =?us-ascii?Q?cAZI5ALN2+csUqM8JQx8W3umJmTRiIcfm6/jXeIBrIiHYXNhQ1Fvlze+e4Qz?=
 =?us-ascii?Q?J9iTmk8SrRblDryjcGbS23AfXJhdBWzAph9u/0np1vmMQK2pURJHR9wV8Ghw?=
 =?us-ascii?Q?AvTnPvmb4P2BPS9E06BRpWugM12fKiILlTnZ0EMv9GjSzTrQ8IsaImQLonOC?=
 =?us-ascii?Q?uW9EaG4KBr+H3XHoye9uwP2SyGHKpD/dcwQ0mitVRLXRXIJg4LWho3ZtYSwh?=
 =?us-ascii?Q?WoHGJjf6AAFZFh74LsCRH/iL2n+CaT/iXBhKIn5o9TOQsI7dfWpUQquwwl78?=
 =?us-ascii?Q?51mctHKtydIcv2ftlLMlocju5J40KIdU7ehoHN1iJhVcef2nFN+E7EBlNPwR?=
 =?us-ascii?Q?EPnSFPo+1WgcJG+in1dg+yEKhYbWpt4vMh4baJ34ELPbh7fQilsUj6qp82P2?=
 =?us-ascii?Q?wUWyFInv28oQSCO8HOMTDTjza4kHY2XnGdFXywoCYq8XJEDiH8mVY3L6z+u4?=
 =?us-ascii?Q?1SwEnW0B5nJTnMmMwAxFXOqvEkaYMgrRSpLcFZDCr9x5XXEOVfiKUl4kdGX9?=
 =?us-ascii?Q?VFRx2wj+r3/onuevP3HYcXVN7YdfPA+6cWODlSCthC8wj2hp/LgViVlOdo9G?=
 =?us-ascii?Q?3A89SDiuMVgB6m6vDk9ebdtslUiLd2Sso1Z291bEWJRikLxxZmnFKjAMuBm5?=
 =?us-ascii?Q?WnzDJroIj/LNRsalsUsJD9sT9ZYfhNRM9P4mgYlAktBAuR4WaB3BkgNxcWts?=
 =?us-ascii?Q?Eaj1BZYxdUiQfJetsVWutwzyFQmITbV/+vDxq1WnAiEefGkgTeiBalC64hf+?=
 =?us-ascii?Q?e9hF5hWF+01fuYVSwGl+CF9uf0LrXsPHdTDBbE8eYDA1y9Z2QrajcoKUXA4q?=
 =?us-ascii?Q?04OKtmzxX4n5WXZhB9/cHWB2qTB0uaBz1oHCk/itZ2vn4lP8yYXJ6J6oJPJx?=
 =?us-ascii?Q?XPpqXE2evavczxXvFofpYPNfRYHG9GSYLj3MTMh10EjMlKyZzfuF1rsfXHJF?=
 =?us-ascii?Q?7exdcSI+uqKSN094ShK//99mluJFEIXI/UMgp4kS5oJysZjrdGRWh6OZusLS?=
 =?us-ascii?Q?wLa8ihvhh40+rnssjO03BGEhoOS9qvH1T3ojN5D/3qzlO3wyd+HFQ8BBNDcT?=
 =?us-ascii?Q?aCBU0dXrd8Pbw9otwdwFwNeb5tPVOim2qqXEhk5aIJelffR11CbvRFuzyJGI?=
 =?us-ascii?Q?0PDZMk/L5aMvlf3jsYH130ImikW51sTlGCWnTIa/yuPPbMt+aN6VtSAn1il1?=
 =?us-ascii?Q?dLrLGdEFHlEDBe9Rn0VnpOUuzGeqRuiwICnm16VGWYu0MwICMwqnh5UYWkvv?=
 =?us-ascii?Q?0a5uhG84W+kYMSqKyqW/wsfU1sLTea2091E5+eLhuTBkmuSeF5ZJkrrr6q4p?=
 =?us-ascii?Q?wdVCipRjJINKh9/giUwAJNlhVeUxc3XYPJ6BRsGMJNDq28IY0yjLHGiSY1n3?=
 =?us-ascii?Q?M7By2aAcu92Cnkm+FNk53ojCL3wV3diBYa0Ra9GUsOQRlg26j2B1dsJCV4ZR?=
 =?us-ascii?Q?SV8JdtK5qlORadUJLTTWtwjZV/ST81qupXiBx2IvMp4DP7vg3PG1St+Xmj2B?=
 =?us-ascii?Q?CnLCZVIv1E+Ypb7Pfh4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9715b2e-7937-44ab-8283-08dbe9d1d3de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:06:01.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe5hx1yvZiqEpKYLpiFjAtVqX0EXnMsoiOlfi5QMWhi24rE4N3NkLC1pakN1fatI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9D869630-A5F2-4105-89F7-20631DE21D43_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>> @@ -1144,17 +1166,18 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>   					goto isolate_abort;
>>   				}
>>   			}
>> +		}
>>  -			/*
>> -			 * folio become large since the non-locked check,
>> -			 * and it's on LRU.
>> -			 */
>> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
>> -				low_pfn +=3D folio_nr_pages(folio) - 1;
>> -				nr_scanned +=3D folio_nr_pages(folio) - 1;
>> -				folio_set_lru(folio);
>> -				goto isolate_fail_put;
>> -			}
>> +		/*
>> +		 * Check LRU folio order under the lock
>> +		 */
>> +		if (unlikely(skip_isolation_on_order(folio_order(folio),
>> +						     cc->order) &&
>> +			     !cc->alloc_contig)) {
>> +			low_pfn +=3D folio_nr_pages(folio) - 1;
>> +			nr_scanned +=3D folio_nr_pages(folio) - 1;
>> +			folio_set_lru(folio);
>> +			goto isolate_fail_put;
>>   		}
>
> Why was this part moved out of the 'if (lruvec !=3D locked)' block? If =
we hold the lru lock, then we do not need to check again, right?

Probably I messed this up during rebase. Thank you for pointing this out.=

Will fix it in the next version.

--
Best Regards,
Yan, Zi

--=_MailMate_9D869630-A5F2-4105-89F7-20631DE21D43_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmVbZ8cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUlVAQAIuX29TF/X30FxrAuTCtXBdv5V5VaUW6WpbI
/isXd5guHRFYCCAK1LOwoJI1ClarvQ3tM8mClfzSx1vzkvjp0V+T+SATuWWnNZTD
6iHovlyjp/wHGkHT4Llwi50b+Nf4P2W/HHlmQGGZrwAm9nvVDrlUIps/AHYx1kf4
bkSxYQj521o4Y2zK5vjVaGBhI3EteK4dPFdN+s1arnqDnJoaVqghMRbAF0fSnDQm
7Wv5Cbj2Le/pzsSDRu3phzLqoDq2fOdyRmU6UE+rrpYCgIoOEkI/HBErlAs+WyGu
QUk2ceSjeD37Vkeg3KoRW2ETZSIxIc7fN2X1laiFaY6/w2AlRXgUO+kxQR3FUKCc
AxasHGvqcnArOUoVkZCcLRkZJo3koIER2K8ln4oUNPKVu+UA+gu3CZS4Genq1WtR
mM5HBtTIVgpeE7jEcEfkFvxqZufL/fcOdngZdNCuFmH7cO/mOoGXNbw2TXkk6r/8
k3SZ3bZIRX8Mdrg1D2SarGD7hMjYUaRZ3uMEcBJkW5jSY3ES1h/7fv+EiObnwuog
NucEyoFr3Yyyb7bIG80pl7S0au2reP0RIYL1E9QHH6GmBudNneZYwMz9D+YfZrMO
Si6EmlvI+kLuffuv5VpznFS0SdVx6nVRmVK896D66vYoMEmXZyzAgkAE0xiwOsYs
dTKbjHWz
=grbg
-----END PGP SIGNATURE-----

--=_MailMate_9D869630-A5F2-4105-89F7-20631DE21D43_=--
