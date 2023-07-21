Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB575BD32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGUEVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGUEU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:20:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F31BC1;
        Thu, 20 Jul 2023 21:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcE+FE4tAtY7xKpFvWb+oM/2yY7MrDkluSDMkUIY/CcsCKJW71bEOiCSE9m005gtT/tLNWgO1nnozJgzitOQEKTcEvds7z9Wz+GBXI1MuKUB3b+dcpv1IE4jLM/1AbotOF35Pk3WEBqBOxwjaVckYJPyQE7KE4qA3wLS7LoTxIJ79RxF/2GmUCrsLkGyT3XoobXeC39KrGSp4t8kn/TwkENKpdQeRLyNEB/KOGBk0cEUCzt4fXOVQfLyWsI9IkKXzHcJ+9F63tNO0GRE68sFTiD5EnatQqX/uZZrCL8MQXcWQDG+hGIecJCJXo8jfLlXA51lxKGhoZDkZ6smSHZI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHSk+8/5VDxACQACFIBwnym//sdN5kA75aCShXzhdKw=;
 b=Hltw1+gohUeIw3ui4u08hWAynRJlAzboYgp+MHKK1I8KtJ+3KEDotf0loaTUd76Z4gl5qnfyUExeQF+jMyq5R3YtuUdDKxXNuq0vI6fZl8SXL3W3kFJLTDl0s2Jj3n44NSOGcsPFZJOCjW5CCR6a45ASN0U6ESGFVLM+XkOWcn1VPz8MFkmuugWY5aQGgJMHSAFJAKHe0CSfbd6Y2Pk9fqL0DidmZ20fgP4EkH8tdi4xMBPsVVv0pSmo+/YCKFfY+RJlJvam0oo+lVude17+fEGVwj5iXK951UzUUB2tW/XIz6EXtZdx4stAdaafQ3J+wZhDCnXAH8WdkmTptTKbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHSk+8/5VDxACQACFIBwnym//sdN5kA75aCShXzhdKw=;
 b=gVf1fRLK/KpF9G5xlzVCu/SCnfTgQfnNEvCe1Z3gpTnUVBvGUOIJ/w4cPKZA/q5P8ZakjLpO5akkSeZiL0f7OX99rJ8F/3j0rRKENFog2luQ+ID0dbHbFBUYAJ//mvw26sr5f1Eow7exodQgaZdw37x31ZGYD1RZplqpn6dcdl8JQ6luvbAlpKVJxWriiEsbkVskNRnlCd3Y6eRVSAFFCrtrCc4cr9BlbXHsKruQjP03qnIxNM4MhbeKFBp+DyfxcqUWyFuMVvNjtK6OfSAns2a2YuW54Q3DW5sBvcjZHgBUJD5MG/wpUo4Ubz4LgZ2LiunOrb2wiFvSS8cSRc4plg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 04:20:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cd5e:7e33:c2c9:fb74]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::cd5e:7e33:c2c9:fb74%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 04:20:49 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 0/4] memory tiering: calculate abstract distance
 based on ACPI HMAT
Date:   Fri, 21 Jul 2023 14:15:31 +1000
In-reply-to: <20230721012932.190742-1-ying.huang@intel.com>
Message-ID: <875y6dj3ok.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::12) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: ee03a8cb-b6d9-4da1-abba-08db89a1dcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkdBEG/bcymZu1lxrRj6Xq1kvu2znwPJyfrvd60+ARehyzFhte5I6zu4Rbva8oQSZUvxRe3IK+O2zEEI7xean57lkulI7v/+KRZgv9pb6UM4TpdGwdeo6eBPOmG1rqvrpM8tCeWbEVXJqNqUW4dY3nB2UAg7zisf/xFV7c7uqQtMVyv56fL10+8Md9/lDNPwwCce8PhXMN4yn3aU2puB7/HWkfDQS0MbWW38dMOFi97NU/fpwV+aFkipRVYBUmM4MaQRdHPd7X5wmeBBmYEgrFIF853PYFUrPRfiydWHBBPQhs2aLc4Hj+u9YduSMZtbUJMCteh14que3xx2maIuA7LP2BYBTef79jwAN9Nbr1Nte9CMHheZvmNW5ItQ2lhq81e61eIhotwJJrqzk50F0qqGmrkIlxxzIWXaBRuoXjlfOnjLH/VgHWly3JycaVvHjSx/nB/CYhqlmlLTFcWFdEXq70DUSYywX+iOXUBY7xzoTxtxcBAYo3s6QaUuI/ArCpPi84rYZ1SOW+dcbmzDEkhScXipuA8R0cvO/6bI/yX6rnMqCncNGW5xATRHXnIO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(2906002)(86362001)(38100700002)(4326008)(6916009)(316002)(66946007)(66476007)(66556008)(26005)(186003)(6506007)(41300700001)(478600001)(9686003)(6666004)(6486002)(54906003)(6512007)(7416002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qu9W/T3YJL2rsshrfUjaX8VtiIb0ZSXlf3ZyKXnzFdBTTAIB0HbbZh3SKSRm?=
 =?us-ascii?Q?PlRa3pkrCLWCA/7Va6IhCNgzEKciXozxBC5/Lj/KEX+FRZ03CiLDzciKummG?=
 =?us-ascii?Q?1gCW4IJFH5LvKiVhiECKZfUczcgvuulVDm12JV2WK+n5TaWBWlP740wIPnSq?=
 =?us-ascii?Q?j//APa1XVag5/KNIxKzHNHkQmsbP9ivdjfDo3ALWo+ThjPTsjHcHUZNbcpmL?=
 =?us-ascii?Q?Sa1YsaLhgxWXzYfQ2sOUxsVDnYhwIcbAOn/uWt1mSBoPYM7ePOp6tyySuvwi?=
 =?us-ascii?Q?zL8HdUPpipf77GA9JWwbm+q8tABOGxaos2eVgiw49doJDHB4svzu9L09zNhM?=
 =?us-ascii?Q?EHIsPSBD/o7forf1USIa4juGSihYJZcl5QhkMo+8ePlfXLfmECB7bI4sRdO5?=
 =?us-ascii?Q?rh4Dl9W0eOp1q/UWT0q5u7k1MBMFAxOlpUFvt4wGML91ytACuIRLuV9YbTxl?=
 =?us-ascii?Q?nH5bIKJsV4xCxRwdmvLxwXSu9Iclp+VRARRZjtXhEsIIg/Ybm7133aQJE6wO?=
 =?us-ascii?Q?YG7ZjkXuXUDtOUIZUitXqypfmSfD+Bd5+WCA3WTly99wR0tAkSqVd2yGZ8Q+?=
 =?us-ascii?Q?wgU8RjZTbX+PQesJJsyo5wOL9kY1WLSYU9PpPYXh3CSu6nibJhCoyOyR6Kd1?=
 =?us-ascii?Q?3Up9WD9rjVWF4h6EFhfIjYppaDCyAzN8Epq+qUm908fJ6dGMQ1h0h/4HcuQf?=
 =?us-ascii?Q?Xf1lJsEt0WVM2LNfIhiGwRdkqPxd28lks9N24rAqQKMrqCSAHD0aomZecAio?=
 =?us-ascii?Q?dYXab/3XRdUNp2EwrPfsz5jeyPDegdIpJ0N5JoKtyPc3fRmsICm30R0HrOpm?=
 =?us-ascii?Q?lyc8ubBxafkG7gyENWL6xKpHbdcrObXjEUdBYc1a5noBFYMMBd68c5N+RNBF?=
 =?us-ascii?Q?x3eTKfGeG+tE3hmDAcnvzGvt9ZwGNcUF0a71uJWDbSkXXEaeXz2dtVbDWa0H?=
 =?us-ascii?Q?6k/vNw2JKjPDYW2w6cqSp4bqMc+rEI7J6z6SM7tbumILGGdqs/Liezp1BLrE?=
 =?us-ascii?Q?hoGFsArdoINd0uaXL0uxsaGD+gtlH5ZBMOayEthhlhTZpG0lZxNgMsTqGAtf?=
 =?us-ascii?Q?bmoRzobV2vgh5/pj5QTe0tJbYxvcUeOpL92xUNmJx05qnMAvGMvMbMnLxJIU?=
 =?us-ascii?Q?5sTh8CqB7vQmLjeyResWri1ECwZZfs/RMRTUwSItS38Q6qTREDTaiqX5Sk+K?=
 =?us-ascii?Q?flewlaoK1NODqhyr4bpc7m0o1+ghnbXbqPN171LTIS8zUzGVSX16BW7ad2yQ?=
 =?us-ascii?Q?Ko32VUQRcnvn068NrMb5ICLNxUtuJ4lqK+UdGaFfS9RrtA605XvxlmQCoKRY?=
 =?us-ascii?Q?KEj5CtyFdz1Q/InHndGJWKJbAImg1AAwZLLm+q6EbLi60dnSUMDN+2On92cV?=
 =?us-ascii?Q?C45m9MT6HVSq9Tim1LxyWuPtPQOgf4YvvnXJmh1CxOmLYxE467o6x/JjkhJz?=
 =?us-ascii?Q?RXHqmbFzEeHbQO8TVR1KzeHn9dfk6aieH02UgsjEemtX/6W5b2Pvtdq+ezA0?=
 =?us-ascii?Q?5QbHYFL9Ko2GzgixAM7xKpUalXcAVTkpo0TFTZE6GZoKY0EceheYybTGnnXP?=
 =?us-ascii?Q?DtTLFfjN0F3ZLk61oByv6eM0o04+cZqpaH67N05l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee03a8cb-b6d9-4da1-abba-08db89a1dcf0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 04:20:49.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3YHg2iTc1PgvcB7Eyr+bK4n9IE0zxSF/tXPcdBkLLlaZBesIc/Ivg/bd5irJ2ztUUTVv+rvRK39U5GkGZ6Hmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for this Huang, I had been hoping to take a look at it this week
but have run out of time. I'm keen to do some testing with it as well.

Hopefully next week...

Huang Ying <ying.huang@intel.com> writes:

> We have the explicit memory tiers framework to manage systems with
> multiple types of memory, e.g., DRAM in DIMM slots and CXL memory
> devices.  Where, same kind of memory devices will be grouped into
> memory types, then put into memory tiers.  To describe the performance
> of a memory type, abstract distance is defined.  Which is in direct
> proportion to the memory latency and inversely proportional to the
> memory bandwidth.  To keep the code as simple as possible, fixed
> abstract distance is used in dax/kmem to describe slow memory such as
> Optane DCPMM.
>
> To support more memory types, in this series, we added the abstract
> distance calculation algorithm management mechanism, provided a
> algorithm implementation based on ACPI HMAT, and used the general
> abstract distance calculation interface in dax/kmem driver.  So,
> dax/kmem can support HBM (high bandwidth memory) in addition to the
> original Optane DCPMM.
>
> Changelog:
>
> V1 (from RFC):
>
> - Added some comments per Aneesh's comments, Thanks!
>
> Best Regards,
> Huang, Ying

