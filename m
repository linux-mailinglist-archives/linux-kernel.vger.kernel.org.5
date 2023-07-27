Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFAB76448B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjG0DpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjG0DpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:45:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD237270F;
        Wed, 26 Jul 2023 20:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZlz+tm7i9OQU9FxUC20WoSiCLsN5FnOiD8DsKbbuFh3Pjpo5xSaio/hIUStuZZRSkwei1yXnfx9qJp+ErXNqSxAnce47sO+PLBZhty5DlyP0U8Nlxq71i3h/mJK8lIZEqWyN2Y6F55JzDmDu9MxNbJkr4ubtDa2+qtWn9k1A2fKlg69FFb8YO0Z6vZ1BJzlq+9kzkWTU8R+091vKSEM4TzllXsQCT0m+3+DIzQiZRLrCx1WA2KMrT6ylK82A8jx+/nyqaYjbK5UVZ7eWsZV1m8NIFQEjWDao+Vd5Ospgl/MDgBKbkq43dnheSf1D7AjI9/TBEKzQOQ5aBJs++rThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNX/A9rIuO5fyFEJsdkooAlfON5Gpli576KIOx+/2/Q=;
 b=LYFSpaj36RtlAiTQN7BAjroXAfJY8CrxeA37hUSRrACPiE0csTDiZueqlUINX8hbLZnKlaOjagX/gc/W6JOve7NoK2hDztnluwNJSwvtq+EcKY4P8zcD5VjxLR7OAeq2cuSEoXRJ2NZqTCetlrH6v/TVQct2JOTmfU9kZpILI+fwTP6u0PWr/hWd4/XokRloHDKBeX17PVQF4MdxzGmiDO2NGr0zCfoFkq2jqYPJyJ619diuk99zxWOh5DG9Q4kTqlaLSwZFk901WOt+DcOPOP8eptsHpxCDSNo2o4GfyXFdzmh5kP07pIUYzAsgv6eD2m/mh32tH1hrZEqyihfmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNX/A9rIuO5fyFEJsdkooAlfON5Gpli576KIOx+/2/Q=;
 b=kVcDfJ+9Q1SIiJtZNTk5AMvin7FZNLAzEMfhOzmYly4mlg/WFgZ/Cwem40WzTrKyl1pHx4/3HzRsvFWhkWpaz8NkNw4Rg9go7qhWJsSeHfBdn78dplue81XHi/GAUmr6AOlLUap/mCEN0IKisLtpOqvkWIwLfINQ7RjWkFhBc0oYqzpZoGYjA0RAYncnSY/L7Rc1vwG/GrHOavq/6sVd2//HL2mDN1CJ0GLisfE3zwkMCxwOkcV2l5GpW8U7GInRp7qLr0WcpfSn+XLsKsqMA/97u1YCNjT7wpONKeRBu3tLRZyUZxdSrSDOcMrpfvVXEgLIz0JavBCPRDRfETyuCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 27 Jul
 2023 03:45:04 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 03:45:03 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-2-ying.huang@intel.com>
 <87r0owzqdc.fsf@nvdebian.thelocal>
 <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87sf9cxupz.fsf@nvdebian.thelocal>
 <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
Date:   Thu, 27 Jul 2023 13:42:15 +1000
In-reply-to: <878rb3xh2x.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87351axbk6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:1:15::34) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: f807bd33-a63c-4c4a-6527-08db8e53dc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6g9lx/odSfY6Qidpx2oyYL7BrJ5d3bTniFa5drH4Y1Ve3QcFCty30hvEt6SkWO+YKTKzVb4Qmj8vEim1a8yO8Znz8rqVc7Aq7TY9yZWQvGhBr1TYFSvyLy0IU+QeMWMBsAPdwbW3Btgk2R2rpDPX6yngJ+jmrxTEaEn9Di457+QgMUhqWDHxkYh53eAI6qI4gdE0Rs/ReOgElTbuXfYIbyYk5+YdDqfA1G+OjTrPkhRBEfXuKFZekNIkpB26QTKdp0YPpnOFx4CT5Y3sKexeJt7vOXxBpUKQDMP5W02+TBVRDRP+oVykrfSz6eIKtfdv5LFVebWLyeBvtbzZwYTN/LXVPLqLtGr+OWxYtQnS8HhFDw1bhUbPv1yH6+tkMW4SBa2rs33VM1prf6/NBc5Nexqzgt6JMH7oL5YDz0an53oFBW5Z1hszaXgKOFhnG50PPu4EDu0HI9q9nlbADVoBH5yN0MTnz5nnhhFTNv3YAMAK3jc4Qfx8n1FwxFYjkD+J7nhJoRf1hquFTh+SxezxSctg7/toA8xlctMbBIXTOT0uyjk2JZBgKgioq2bX9IS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(5660300002)(38100700002)(66556008)(83380400001)(8936002)(9686003)(7416002)(8676002)(6916009)(6486002)(316002)(478600001)(66946007)(41300700001)(54906003)(6666004)(6506007)(4326008)(26005)(186003)(2906002)(66476007)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xpDh6mKPCHPqauXQ8uVlb3A3RAOaod2KaP5DsOpCGaMbRrIixctj4cY1g6c?=
 =?us-ascii?Q?/BDZqWtqjwsz8ASV1kAdo6lnvuBotTR9Hc1VlB78Fhu+RZmjvKuMauU7hTnj?=
 =?us-ascii?Q?FTk7ieYWnYN1Cy2Jfuywk/9WA9EkuYPTAysttA709b02z1+XJcH0FDGYiOlb?=
 =?us-ascii?Q?VZ94TimJsRXnL3KNu+pEqREHiZQ5UlJMx2knAX0DRypcfeNRYzN/0tdwbWTi?=
 =?us-ascii?Q?B9MZTMFHH/HFcWZnt3WNC9CkNU+qIGDnIzBgVAOh9Jx3qiL5rzh+sQ9L2d8z?=
 =?us-ascii?Q?9sSTvn1QVjoICP8fUc69c9wEL7/3QwIBflFT/qSMQQ5h5iIwaaDlfheFZaqm?=
 =?us-ascii?Q?WGbkKtIXiaYKkQiuvR8XXv+Q4cSNRvmk5JccT+PL20K+8Dn48JvEs/XhTzX+?=
 =?us-ascii?Q?QgLbkaOzrAo/pxhhH2KPwWxfB+QZh5tDzv3mEtOWGZiSlMrl+aziDCvs/AGa?=
 =?us-ascii?Q?EIRt+wfCHfPYvBGgtc5R0896DSE2Q26lE5Ozed6Dh1LEwWh4XoNDorccbz44?=
 =?us-ascii?Q?Vp1IP7WVsYfAX9aZBUSYdNvclc5W/zIfkanr85+2n3OIr515ulHf+roia/jE?=
 =?us-ascii?Q?4sGdUDkBuRRVnQuLOLXaC7zWZ0oyMDPl1eSoGjIlSqpGrQ7Pte+QJa6vHWHp?=
 =?us-ascii?Q?FO+VEfdO1Q+c/Qzjjd6IP/rojNJTttg5rm/UxmzvV7hBZJ8kTD5/akdMvVsl?=
 =?us-ascii?Q?+S7P+zGgtL0du/++uUqShdRlCKFaeCAWsFkQTK9LTdXNVcXkPVg3xy0Drlui?=
 =?us-ascii?Q?pzwCDdTofcuFCJF6BsNev9dfqSqLBwpib/AqjxYr5FK0zkT1x8KMOJIzC0DF?=
 =?us-ascii?Q?jxfWBGORInLF7/iccuMcMizcLTsxgfWMjCMqDSSKnUNmZzk4l/qsLCd0Q6Yv?=
 =?us-ascii?Q?DplzDakhMAcJIO8E1k1g2bw0OeH6j6rl+IC8pLG7exmbyQGX0T/kiPe23S5m?=
 =?us-ascii?Q?YAA39R0Dlk015noR+7Je8n3esMaNhsqbbAcFTjd7N9asulhtuZuPnsx0lfvY?=
 =?us-ascii?Q?CldKENHdFWOnPkG72umu993+Md/X7TPHUoXtlsLO0OKOnrRw+FxKubKuI+aq?=
 =?us-ascii?Q?BfI6zlhMQlryOARWP9wqk+b5FrkowiJjFzi3wC6n3xy4M2gF90oKxNWvQY2z?=
 =?us-ascii?Q?/dItk1JdBoKKBYVQLD+tL8mbYCSRhxnAqtpJHgOOgKB2oucEnqShwuLSTD5i?=
 =?us-ascii?Q?EZ6TzNVoetH4yTxHyeLLdQJ0M4PeMUgRgcQ6BImPk2QK8396T4HcpCaWYcbp?=
 =?us-ascii?Q?91SgsXqxxjZ/uwj/Dl81XyukL6ghueA03EnpEKtA6HfipldsiEB6NMvCtgNd?=
 =?us-ascii?Q?FWKLQPAVzppJb7bcdQSDPlfi4sAHpjbdp8B4ANTP4I7szG9GW5Tp/s5vtoBn?=
 =?us-ascii?Q?WW+1I34suIcg13gH1jI5lkewJAojhzr66bGooOdmjUv5brWvtoGGJMTByjrF?=
 =?us-ascii?Q?W45Dyv9GR8Lfo4NtphW+oNiQj3WI0FTHohtibZkz/wT6mhVmC443qwVqdXJp?=
 =?us-ascii?Q?4ebobsLrOgfjkhqWMoPeMw5Cs/feKP74oZ8N52Mpuk5/SpsPZgSkx/qyL3e3?=
 =?us-ascii?Q?oHByVaLIHCXmjaOcNgVgTS9BKZEeKzWkgzlNlLNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f807bd33-a63c-4c4a-6527-08db8e53dc44
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:45:03.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3OBLFhEfs10b8EeheWxo9TH8l1SQtVimSu8g5UroeZzgZhAVI1LlFzFcg6svMOAPpk5NFBjYIm2J8O+Trj2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

>>> The other way (suggested by this series) is to make dax/kmem call a
>>> notifier chain, then CXL CDAT or ACPI HMAT can identify the type of
>>> device and calculate the distance if the type is correct for them.  I
>>> don't think that it's good to make dax/kem to know every possible
>>> types of memory devices.
>>
>> Do we expect there to be lots of different types of memory devices
>> sharing a common dax/kmem driver though? Must admit I'm coming from a
>> GPU background where we'd expect each type of device to have it's own
>> driver anyway so wasn't expecting different types of memory devices to
>> be handled by the same driver.
>
> Now, dax/kmem.c is used for
>
> - PMEM (Optane DCPMM, or AEP)
> - CXL.mem
> - HBM (attached to CPU)

Thanks a lot for the background! I will admit to having a faily narrow
focus here.

>>> And, I don't think that we are forced to use the general notifier
>>> chain interface in all memory device drivers.  If the memory device
>>> driver has better understanding of the memory device, it can use other
>>> way to determine abstract distance.  For example, a CXL memory device
>>> driver can identify abstract distance by itself.  While other memory
>>> device drivers can use the general notifier chain interface at the
>>> same time.
>>
>> Whilst I think personally I would find that flexibility useful I am
>> concerned it means every driver will just end up divining it's own
>> distance rather than ensuring data in HMAT/CDAT/etc. is correct. That
>> would kind of defeat the purpose of it all then.
>
> But we have no way to enforce that too.

Enforce that HMAT/CDAT/etc. is correct? Agree we can't enforce it, but
we can influence it. If drivers can easily ignore the notifier chain and
do their own thing that's what will happen.

>>> While other memory device drivers can use the general notifier chain
>>> interface at the same time.

How would that work in practice though? The abstract distance as far as
I can tell doesn't have any meaning other than establishing preferences
for memory demotion order. Therefore all calculations are relative to
the rest of the calculations on the system. So if a driver does it's own
thing how does it choose a sensible distance? IHMO the value here is in
coordinating all that through a standard interface, whether that is HMAT
or something else.

 - Alistair
