Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6247644C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjG0EMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG0EME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:12:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5D26B8;
        Wed, 26 Jul 2023 21:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYSqLvjGfFMqL82dDVNSlyWuBO/CVfBd0ljDF8V94IThaxY/GyPVWnMfBf9hKnVHus3Zj1qrZvXaKENqQLHsEj5ugpzvvIVno3JTId8jRNSdd+azNizNtBmhWjff+V6jZjHg6jSmKqejc76UzzyXNJl/d3XxLaYR2MXCJiqePone5ZaHMzIVdfoO+2cpsu0qFmW1vG7oRf+mH6yNuMoi9rGP9OFT1JCcDQytW37xZ9yUjn2UiucDnqYlzDghNouC1dqwRl2Yev+Wx5C6sPPgTPkiSb6WqsZ4DI5kmnnDLIYQyGfh+240yUiSGS4tR/s5rrFGW6jwGFYI/iICiNRSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEQ77uhBaL+YTKV3Z+JV2Bm9YrDpllp5LpZaRWLXMc4=;
 b=L7KBtSZn5A4JpqLpeCx836PPz1ZbfsGBvnMCHl13oGi0L2kr18Tq5khsaV51vRfotsnO3VSCKfPf6DL+Fd4egenTK5f1ApinDxSXMZDsi92MbwH1ZEJVcSwt9QTZ2cDoa2qF0iwOlFZOVeaG9xFWYPyYDAckI2thGD86oo9bAfSPgjw1cXLpmVZHYlB6q0jSqjBn2PELmUynsgmFO9YxH2rRTOQdVcnAsJ/RPz6qN9oUtSNffqJolpPVln+NWK1w6loNEH39nQgWz22LyOyasa8z1Xfi6m4mWdjpIKl9x42txeFKbPz3/6NdRFoOM9wnSQifP7suQmiMLJUM03zNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEQ77uhBaL+YTKV3Z+JV2Bm9YrDpllp5LpZaRWLXMc4=;
 b=ftO7ATWus6RQdHv/RaalioTarxjhoUYhgBXwh0cVoAEqTKs3pu9s9LHV63MbK5+ODomMNwPtCBMZJhJhRSqJE4Dvl37vA9+1ynkReci6xAPkypRFqRrqUF0xaHRUIQMg8Kxa2vijflJeFBpSQrL15lngCOqklqDpVQMiEX2hjPaS2kDsHS6CjBOQdN662GnBwlE/54EL0hZd4VJmSw4n+W4EIsEidfMvBYTY03ueO5CrXzkHyZe0elSHHM2Wj8QJsm+y8R2NZuy8HAoH1pJf/ua9uWm8fbTqw0gmnl+Ts8LIee+VPGrWt7vOm4VZ7+8tM36yn1Ez7sg10/KOMpT6dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 04:11:59 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 04:11:59 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-2-ying.huang@intel.com>
 <87r0owzqdc.fsf@nvdebian.thelocal>
 <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87sf9cxupz.fsf@nvdebian.thelocal>
 <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87351axbk6.fsf@nvdebian.thelocal>
 <87edkuvw6m.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
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
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND 1/4] memory tiering: add abstract distance
 calculation algorithms management
Date:   Thu, 27 Jul 2023 14:07:31 +1000
In-reply-to: <87edkuvw6m.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87y1j2vvqw.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0066.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dba2a8-9742-4aea-3719-08db8e579f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLKQuL9+RdOlQGAfahQW4CZ9oAvqbWc2EpHzyQ94fmGGToieokLIEqkmsYZm/Wovj34XB9pMQzraDG0eGYd8uj1HgwItsc9h1+u++oFLRJ3A2az1YaB7StRWVKDA+WCDmicBHJdODhLEBv+8+I952rBmAJR/NwhNQXLmULzo55pqz5gwlOXHYh9UU/FjsCjsc/0fnY1c9LvH4nqaBB1fM4bwhrDXeA6/L+yFCrX2faUb6eViwANZ//Z+Pk/MZvuKcGkToe6cTkkxPjtQItE9/eg8hYRQqzccz5pHPooGdCLxt0rBgT4UlwbFJmVs3rV3G3QzlfR5NznHCvxBK/zitVEcsfdRH74aqsotfmxf3pKePNyVHoF/3zNXMgYB1BttvFSG0SNXMa7GoVml6l6vBZz6bpCVmlisrITX75gI49+FUfH6tJIP7SzOA0/LlyCrsBb3zIJPX9r+VwR7ozwuiexyLCYD+jSqGOO99kQ4C5WbewHnSaKP2+hg2/1p6+EYkmG5lLAS97VUlL4fYvmjec/hU9vMq4wDAwBtEWxU9gJerItMbMnBdcqnHP9wztSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(83380400001)(86362001)(66946007)(38100700002)(5660300002)(7416002)(8676002)(6916009)(316002)(4326008)(41300700001)(66476007)(66556008)(8936002)(6486002)(6512007)(9686003)(6666004)(6506007)(186003)(26005)(54906003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtyrVEDybE/wSUWVwAnQRwdURNwDSiblxqQjwgxJPyuzvlhBZEPY6DJc6cpo?=
 =?us-ascii?Q?R9spJcJl2xG5IAUEPQYZvBNjW9IWciPlL5l8d8Oz4flf3SNbFKsIiP+8Elek?=
 =?us-ascii?Q?ll+22FvHqTptH2ftIJQNrWyiLKI2jSn7pqribEKpB6gk2cJpfJyQpQ+u88ja?=
 =?us-ascii?Q?EbYYaY8Hlu6z39CsH3XlRdDnnt36R9Cegtu9ijWR2iF53mQFOF/+PBaQPZ18?=
 =?us-ascii?Q?iWRpndmSS8a8wGRwwtdvcTKDR3nXq93Xxm+dC91FqQUeBAbrGWie8FOkMKQ5?=
 =?us-ascii?Q?5NPC6LXZVjFyMS71ehYvCcAEvNWGkgO+bN7N3mBcsTbMFzCmM0gkCdkUe1CY?=
 =?us-ascii?Q?+84QfSFlOe74QlsMhP4PDs23VnPv7HkEqbffFUBlYIS7imUl2UBvUHc+O3DU?=
 =?us-ascii?Q?/qEZC8gtJqI4Acm4hgoWKX1kl0BjGF1giBGXYbTImnrDAFQZzp/Ttx97iRRl?=
 =?us-ascii?Q?zgBnk8q0Zh5X4JjnXXtXkJRqkRSI5RerhKSJk5XlkGkQL5ZHNVkZJzm59aEX?=
 =?us-ascii?Q?XEMnOzRaNpvEkWM0V9qp8dzPhbtSEjgQFjah4GvtU6upoFCUQx+EKxxImJyT?=
 =?us-ascii?Q?iuSiXcfEcmLapzXEorS7/rMe6raFWzpP6iwdcxp936CSnXK/DTeC5o2HoXD4?=
 =?us-ascii?Q?m8uFN9k55OgpDHJF62M4PyZ5FsAAIV1ikA5VhrcllJLxfWPIwDRXLxmKcXIC?=
 =?us-ascii?Q?50njuy5EW7K7O9eem2Z7zymqWh79rvZyr8v2ZE2elv+gLw/ZlIjRoE+jTR5+?=
 =?us-ascii?Q?iTyABpqEsVtIC0FryPZutT4/B0ZU+LHAkMfRKINeOVXWi3Me7T/J9bwUufKL?=
 =?us-ascii?Q?egpsuNLDhh4ai+CQhd0p06uIWGeBesELggC9Dr/ZU3rNFS23IOFg8P4n+qcn?=
 =?us-ascii?Q?vqfru+/8ci4agqvHVQPXYI8z9/3nK1+hwqBtyytp0pJto7SLS2hvlo3fybMG?=
 =?us-ascii?Q?vyu+4fM5ODzqwcVJqAnfnXZn1LSkuHeK0Nd42FS9LDb2YxnhvHWLrrJ2jV9z?=
 =?us-ascii?Q?AfpbyTZJnPBUCjdFstbvi6xZRvfcU/Na+wB3V9xdiz1DqCBuukfT04YldFRf?=
 =?us-ascii?Q?U7/FS3/ufKxmxGPSIAArqWvJB5jw0Kq6KBQL+w5Z7d2R3bW4p5CZXDMSBBJg?=
 =?us-ascii?Q?y9S3pjzh/VpJl1B+eJXY/9W+1GXg2PSSb6z4clnQfW8Nx4+ePtPvm+ui4Z21?=
 =?us-ascii?Q?jjRO71RM4wBk3qLZDRCmCb/aV6MhHO6hozKEB04XC4p/UdMJ4lMqwN9vChh9?=
 =?us-ascii?Q?ZW2PljNvQP3nWqw6q1MvpEgtfd4rMh17lSMNSlUQkziY1hSzq5F8JGKZBlu2?=
 =?us-ascii?Q?WgdLw1USqbkRm9Qs+mOVFb/pbZIybVVGTYMPkwpLygafAZGSkuaOZ2BULMhp?=
 =?us-ascii?Q?XmdGBtZ56+xJH/UVQH+zMhO0NTfrXZSFBJnGLu3TeDjBC2O6Yb8VF3F5J/pR?=
 =?us-ascii?Q?8iwMBJRAZbzORcX5BjEDSnY6vFIu3+jL7resFT572MIxiGlfNjVhohjK6YAr?=
 =?us-ascii?Q?77SbPavSUoi2FZfpr5YBoPAj4tDMWK6E+0Dke7reGHQz9gJeldEaZo7wpLXj?=
 =?us-ascii?Q?lzi8BrWFyNyr/Cyi7FJGUtoHBzMGs+JUGu7Ehj3f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dba2a8-9742-4aea-3719-08db8e579f59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 04:11:59.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26dK2KfaGzVruxfHAkug2P55BwBX+kmvJAjyvLfheKN6iFKdQZjoQ2Pp9fYipa9B2fIkkfPaaksJUkz6D9mbzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>>>> And, I don't think that we are forced to use the general notifier
>>>>> chain interface in all memory device drivers.  If the memory device
>>>>> driver has better understanding of the memory device, it can use other
>>>>> way to determine abstract distance.  For example, a CXL memory device
>>>>> driver can identify abstract distance by itself.  While other memory
>>>>> device drivers can use the general notifier chain interface at the
>>>>> same time.
>>>>
>>>> Whilst I think personally I would find that flexibility useful I am
>>>> concerned it means every driver will just end up divining it's own
>>>> distance rather than ensuring data in HMAT/CDAT/etc. is correct. That
>>>> would kind of defeat the purpose of it all then.
>>>
>>> But we have no way to enforce that too.
>>
>> Enforce that HMAT/CDAT/etc. is correct? Agree we can't enforce it, but
>> we can influence it. If drivers can easily ignore the notifier chain and
>> do their own thing that's what will happen.
>
> IMHO, both enforce HMAT/CDAT/etc is correct and enforce drivers to use
> general interface we provided.  Anyway, we should try to make HMAT/CDAT
> works well, so drivers want to use them :-)

Exactly :-)

>>>>> While other memory device drivers can use the general notifier chain
>>>>> interface at the same time.
>>
>> How would that work in practice though? The abstract distance as far as
>> I can tell doesn't have any meaning other than establishing preferences
>> for memory demotion order. Therefore all calculations are relative to
>> the rest of the calculations on the system. So if a driver does it's own
>> thing how does it choose a sensible distance? IHMO the value here is in
>> coordinating all that through a standard interface, whether that is HMAT
>> or something else.
>
> Only if different algorithms follow the same basic principle.  For
> example, the abstract distance of default DRAM nodes are fixed
> (MEMTIER_ADISTANCE_DRAM).  The abstract distance of the memory device is
> in linear direct proportion to the memory latency and inversely
> proportional to the memory bandwidth.  Use the memory latency and
> bandwidth of default DRAM nodes as base.
>
> HMAT and CDAT report the raw memory latency and bandwidth.  If there are
> some other methods to report the raw memory latency and bandwidth, we
> can use them too.

Argh! So we could address my concerns by having drivers feed
latency/bandwidth numbers into a standard calculation algorithm right?
Ie. Rather than having drivers calculate abstract distance themselves we
have the notifier chains return the raw performance data from which the
abstract distance is derived.
