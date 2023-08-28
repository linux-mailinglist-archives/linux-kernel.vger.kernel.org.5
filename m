Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C915178B2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjH1ON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjH1ONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:13:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C558BE7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3GVfg1iBa6q9o5ovsL4fNbejJ9xejBXSplzvohsT+Jftuy2UUCHMYjFY157oS8e7XgseJpZSKZG6LCLxCV6DhiBeED7MVM58I+JAszu5A7CgHMXfOdBnHh2k8vFH/N82hcO+yT0zxD6KNaw9odpr7Elno2NMBLEdwS3N9Rq5HxRyOgydh5khAplRUT0w7x1xvHblL2bdW4GHAbnPNageBN4sxB5W52IrfyWTS0+btEOlXdB4ucW1qTGwdkL2THRoNMeUSEL67hIeAZKUbIAcCMqlhaMTt+GmkJp2ctC7DSuhbAgOSo+mgMWMqS6Litp8KuIGsxfN264O73zbcapcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dS7WNqI2OCfbJvt0IGGfSSATortIpeq2JOydzuUv1Y=;
 b=h9aUuiT01begeMvNJCg7oNlRp4XlkDWw1UpPQCyR3ebcA97BPNZOZyrgrxs/+jJ/Pj+aV2PffvO0NhSwVVHQVQZnnKWjauhZ5b1Q1mfm12tJFq94c7LF85GiCpgJckPSbl6EzNBSJA8tEBaYXItG+1eOv6YZRO1g5KqdCb4mwoM93VzlrF+wRtI33wAeGA7xyB1WefA7kU3k2PzJSJHdeS8hVkpOVVVa8IE0ifpDpkv4qmD/31nbkJl0yQita4qyw2JYugt+nFnJWAqLhRboGqYOnRBYCXcTCiEOobLTCzudYPFIm0jdQWMu2iL66oiNrj2t36w/7/frb0Ep2bJjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dS7WNqI2OCfbJvt0IGGfSSATortIpeq2JOydzuUv1Y=;
 b=KJM48ahw7baHmr2ycGzDethZM0rez4plYvsPYsJu8gE/7fa82gjUwY9lzsevCgeOyifVI9UUTJhChz30L9JJ3vf4Rrg4wNikrhTQwlAQX+P+gFdw88z7tOkPPSnU4tT11qr02EFReD7lW9kQppxoiOBRTrhebL2a6o1MfdF0xghVGrN3O8pSAlw5K831Eywr6VXyucdrF0T9FwF4H4kdhk+dCFD0K0slNQ3IEtWUqyKyyXoB9gTs6mDwqWm1+o9M9pLPB3r/d/+f5cAnkKe8C0REoydMYFweITl0vd47Dj1IFzHCs+sPDQXIKDNYA8A4VksPnXWxxwPBG56hPMHNzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 14:13:24 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 14:13:23 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 6/8] mm: migrate: use a folio in
 add_page_for_migration()
Date:   Mon, 28 Aug 2023 10:13:22 -0400
X-Mailer: MailMate (1.14r5971)
Message-ID: <7B76C9EA-80CC-48BE-8B52-35868A97BE2A@nvidia.com>
In-Reply-To: <20230821115624.158759-7-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-7-wangkefeng.wang@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_51DCFA7D-1A33-4BF6-B6BB-2BAC855E7D05_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b407708-e25a-434c-a73b-08dba7d0f096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zv7OMvvOLZgybB4axQYIzkI00xD3uJLryTOh6c74Hd4yEnmMi8abLtGiHzkWBcTCbjFQ5kpj3hMox6y6nnLw90lKCRcXstJpX8va4apR6Xp3EFpLvnf/kUdQKA5xiDP2UDO3TUCQhlE4GVCxswh2MdkF1xLfGnraicjSqqnR84eQOekzBC0dLMy3yd2nbsd83yghjx08zbjvg8NoUQmabSchCa0MbohZYtw+bKt4HWjj5POc+5WErKfnHUkLC+2g656Y6oOWdM4Ot7zwvJq3XAx8QvovmGdFJaqMFKEI/98zPblaBvhffqcr6RO+mChb/PDNGEJqmweDkH1D6gXE+jjCy/KpEE7GJ4T08KOQqbPsr46ged1x1v/lwihyKvYiYoMT1DOiNO0NZaj6Zr89WIcqsS9ed2G8RUoCxT7aahOdgaqsGl/5pN4/QvQuvp2noocyuBLwqR0wP1qXbKXN8pra/7dCAZTsiK1AGOmAvIt0jH9Q+riB8Wv+ofAv3qasI3SSTaUpRLaD//LGI7WKzEpIYRvZpmx4Ma1RzQR2AEdbhyVOnp+FevKbjIclJhs9RngIibqmKFh9cluBJeLDeFdpWtUvKB3ild5XaGolWqa77QENYHN8kcsjXc2L9y6g7NIIxQAiaHnqn3ZxUOWk+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(38100700002)(86362001)(83380400001)(478600001)(2616005)(26005)(6512007)(53546011)(6486002)(6506007)(66946007)(36756003)(66476007)(54906003)(6916009)(2906002)(33656002)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2LEcFN3ptrzyayn3SFhU02p6nnOqtHd0Nt/bvimhXdaJNkEIFfgsWYzH4mzG?=
 =?us-ascii?Q?ZokKCF44ynigegWTuwum/DKhDK+CY0qNLn0uOhMtrtlMhxCGbL4Ffnc4JlYf?=
 =?us-ascii?Q?ffk4pv9MhlSCTCCiU3pHFTJiEqPMU+q5dTJRKL0M/flo/RbfNO7dM6S5eeE0?=
 =?us-ascii?Q?7Rd9Irn7JUv70ud99yhSt2Ojg7ZSBAV5lI9+PQz7aZmvwz+JfziTRmz+HvIU?=
 =?us-ascii?Q?ZvBVWh+iOBiMVcdXQ0ko+oCQ0xQRlgrEZgHe/QiG3gs524PAj6T3lpZet+be?=
 =?us-ascii?Q?goheY7EJWSb/qo1SGasG+5DC9a1Gy3iyeu0BsJsmOQ41RiJr2TGIp7aCrwJd?=
 =?us-ascii?Q?+rzUjF3/RozXUbRkQcRaVOA2ozrpjhzsSojjd68emC36Ef3O7eluuGlPnjD0?=
 =?us-ascii?Q?5oCr+IEG/MLnxhVFZ2CBQJhVjt0pPUpBawPDu1PS2V/+jkjjIQaB7jvuLDJA?=
 =?us-ascii?Q?v2v2Ba1LAPa3I+IpuvEylZt8wKLZF7tPJIJCwZuyruxRrGotwXA7t2kfmJWd?=
 =?us-ascii?Q?TycUqb/I7GP2CvQJwyKDl6cHdBXt3LvRB7jo51hhvKmQYyl/Y34kIpcEyWMh?=
 =?us-ascii?Q?8jQNK+FgiMNyXGtTNhqyIrVIIbWsR6ePdyKepNzqoorfDkkGVM24SZX8zJXl?=
 =?us-ascii?Q?dVdfVMLDS9JS9TcdATEuTf8UV7UccBV950Tmsrt+WwbJ79z1RPVFW2wSYSku?=
 =?us-ascii?Q?u3jvZD/J+b9bGKC1M6+tcANqOtPzqPXdYxF6pKNrKF/1bWbZ4418F00nTcYE?=
 =?us-ascii?Q?Ej0tQDJczReqtdie3XxZfQepCVrhLHp2MGvgqiTpjmAY7E2QBMxAdO/ycM9X?=
 =?us-ascii?Q?swijbBKYLgVf6hUOpYfxsMnp1o2J/ZgE6QmbYB9ikqgV1F4uKnjkwbqfXh1O?=
 =?us-ascii?Q?TfEjYFZXV+vcmIcbiyloqUkGv+LqR9pCHufDUWuELMamnLy3FfXWKqgJPFeU?=
 =?us-ascii?Q?Bg8s/bsF3s51DrL3I3+YxSkVifAqtScxf9zO8+xyBFr686dsPGWafdx70mZc?=
 =?us-ascii?Q?t90qDiz5ouA4ENdh6vU4Rbv3m8gFF7pNV7mRGS1rUjzBF/zv4395u+YGaBAy?=
 =?us-ascii?Q?FCv+xhBnpw/mkcVq4mBTtT2gmSBkxdodDwgPdw+r9C7OYhLdK2NWY4S6qjC9?=
 =?us-ascii?Q?mAxBJbL0LP19SxkKsb22jT5vnusFRsNmZobMo4ngieSCJ4OQvuQFs96gqmPW?=
 =?us-ascii?Q?Upmi7O1EAbYID5Go2gfZ1QNSJZth7Y5HhmN0+Vd9Ir/WvpQ//H87FzAp6oAj?=
 =?us-ascii?Q?2grgLngHIhYjfeAsmHkzS1QCIqi3+WN4rIgnaxas6f7DHQ/W1M1NVJy58PBb?=
 =?us-ascii?Q?IPGCHFxBguleFpBkbATdC3T3cuEqeaUKnf62ESj1ZGzEbvGR7xfao/qossdi?=
 =?us-ascii?Q?V4RlAuvl5mOypis+mCpyosd2jeusVO0CNUQGw6WIKIprinPZWi9tLwQ9kqqk?=
 =?us-ascii?Q?ywI4fmq6m0dcym6JE9o9Bqn9eyszqWk5M5FVqj3DprVNfXOyCiQJ6GYqXq+Z?=
 =?us-ascii?Q?T80Uvy6D7ZPIIJFppnhjXLJ74LTSx9VsC49S9BBfbV31FnqQsZlaIkCym/Gm?=
 =?us-ascii?Q?UtChyYeYKsD1FLVAQ/Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b407708-e25a-434c-a73b-08dba7d0f096
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:13:23.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM6kK0LiA5khpE9d+tnG1DriPrFBmA4ra7vSYe0w82rsmeoV4uBNp2l61yDwcTqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_51DCFA7D-1A33-4BF6-B6BB-2BAC855E7D05_=
Content-Type: text/plain

On 21 Aug 2023, at 7:56, Kefeng Wang wrote:

> Use a folio in add_page_for_migration() to save compound_head() calls.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_51DCFA7D-1A33-4BF6-B6BB-2BAC855E7D05_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTsq4IPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUP9EP/2u8tWq5JI1og65DuqkfEj9siVAaxQZxYm6j
qQtAA8NEixdeBJxqtx9tztNnbqMHYkTM3Ac8Lu7dJLlwqMOiGw81cHQzALyAJarV
3bXpOwWxE64vQtgMRYD5vFHq78qKQ3gRNLBIqAYZ/la5koXu8dYXkHW8ryTLYyh+
8YELpabGyf5SZCLVi1D+xm7KkPXyzvacJP3jyAS/KelEbv4HuioeRy8imvzuWsec
L8xFwYK+eAHO0hNfgohvuS9ZuRXAVgnhgnBs2BIsuAG12Unq4VJEH4XAhN4rQD8w
if4tL4P6b189yfeaat+CHlCZjp9s0W2WyGhqw83BZxBoc/VpbP/yGjBtl6NuFqFF
05dcWk9mdGu9GnP59+6XTE9NgGCVmDGKqMKhaVVDr4ndX+WhxPMZnRIaR8rFv8Xg
1C+kx4E/XPRJ84YcCdLMKwkXwovmXc0VyhUOe+IOOrWHCAd9V6xsp6+ewOZUUfk1
oQJ6k1tzt99QJAKUP6p+xjHIBhJnjCfjJYIaAwzi88QHBLrQfp2IJwUPa11hflCz
YJvNn0z9J9vF0cBBSPvpphh0P+8FJZwlCgIVDEEOhj8DhXYLVIkyYQX6jc7buUw7
7iNvcGHvs9TKMhwpvbFhQqbRe8NqD/PPjoZj+JwuEO7Xzllx7VWywJ9P5FFm8kHr
9oW3pXXL
=sx2E
-----END PGP SIGNATURE-----

--=_MailMate_51DCFA7D-1A33-4BF6-B6BB-2BAC855E7D05_=--
