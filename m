Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B623677CBFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjHOLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbjHOLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:46:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE865199F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcjfBMdUEVVjpMbr8UwyNApesAQMsyuPgbgF87ab25gwB+3YHph9TCa1FvhIU8IWYzOgQXPbRt5LzVpPQQU5a+GINM+yiEklueatu0a0s3qc7EycPcIdlmxsHGaADE5YhY+g+MFhEnS8qkohdUQ19lrN7tdzRXfkCVkdIE86mr+Qv2JY0UKVfjEKzLpGp23An8VTJ/39YrsCiiG6CpO6ixjHUf930eyR3LZjgfqT00+mHErZVa1lnOanx4WhuN4WjTdrH4AqifVVwR8Gb/7E7N5oVlEbKMIMxaNybY0tcRODRKUpLTNjU+n5xLFDCAQylfinCcD2/PV6u4N/fWVHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HJOoDC7KLpV0rY6a5TbSruHmdqMK40/rnfENF8Ka4U=;
 b=eKhLBW/IxP0G2pZT/8UE49xtwLXdDTofpPfTHf2nJEb46DXjxHNnQ9KrViFMkt2fHofWjqOtTjFfcl5fEBw1gBemsWP3yiIrl9lD0wzKpdVzN30WvL35w1903D06UgNFRUjv48JyTeo5R10nGZEIPXabSUDsO9SfmS2Q4r9hMN94hgcRbLw1PQ42GRe5C9IqnolAUTqrgP8iKv8RdIj5P6rgb3W8rT4Yi9DT7ss7ZRHaJaWv8nLNQImtbLOZxa2uHO69bxzRG/6SuU0KQFnTw4LUau19mqrt5kVzU2/1kvFHBcxVICRVEWKPyFvF5IL7I3oEtwXn7dCCmKUVrh0qSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HJOoDC7KLpV0rY6a5TbSruHmdqMK40/rnfENF8Ka4U=;
 b=Ari2NC19F8s3MLRJ9uBjjrT2VFWjZEVVEYxB/BiEmM2zv7wUILEO79SGMkjrSawSsj/K+76lSqetxO9YiczAsrFbvZjYBNyOyqxVjaq6fkIREAy5PbNHsRMDHhW9GImvUlRqT65hURh2MIg3nxHm/G5g2LpAJdRPmGxSQv4RA31jE+0ZuU6IKV1D7fw0SY0MOgC/zYHOeDqUWQdqXRK1dSHnlli7PU95ZxLnAvJlftVvhqIaRYCbjD96tau/sfpAVr/QC4DyrxKAq30h3kDx9bB6Tc6RqaWDR+UYW5n7cpfTINMN1vd80qLcrCXWeWrPv+NRyzq9LALK10gs1WwpRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 11:46:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 11:46:25 +0000
Date:   Tue, 15 Aug 2023 08:31:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?5a2j5p2w?= <jijie.ji@linux.alibaba.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>,
        "kaijieguo@linux.alibaba.com" <kaijieguo@linux.alibaba.com>,
        "daishengdong@yeah.net" <daishengdong@yeah.net>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Message-ID: <ZNth+6SE3lHu+uce@nvidia.com>
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
 <4b356a28-5637-d492-9540-d7f5e6c617ec@linux.intel.com>
 <BN9PR11MB527619D76C1ACFA5B85E2DEB8C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <BN9PR11MB5276D897431C7E1399EFFF338C14A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ae72631d-31a4-eba0-b2f3-de4cf6c7d067@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae72631d-31a4-eba0-b2f3-de4cf6c7d067@linux.alibaba.com>
X-ClientProxiedBy: YQZPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6bcb98-4f78-4c44-6d87-08db9d8540f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONJyw72fttb0ZCqLZEGfwwagtZ9q7Dmn7vMWlFgb97RbzsjijUqKXm0yFf3utiz6ufKrEtM8IuqkGL3akEs4qwK+v51Vjo9D2VNBeHcGHSLJHb+zHVf+SSWr/D5bEepBqPCHhM1nrzNwAQmzPN5l7aL3oeGpvvx8DlHU/1DMb+FyBMBAJyuqyDc/N2n6WYCDryxjV9JtnnQIto8q+lWhNd+Dg+pBUUfGtW0mpfJX8L1SLm5muyFwX5tuqcjJXoBnnOsltzLBDPCaqElE97M8o4YDOX2dEMx/s3CFGYeuoaLdJhz8MrEXh5Puxo6YkSCy5QW9EFMVCvf9oW77O2KJSRNZj62oO+R8SJkQEXPkUgzlyQ5FVphyH/TZwcpKNxyfP2tLOg7/7y23gyTcem2KsJUL1CwBPWsWTz7AS48n+u0iST8TCX96rDPC4joMafWJFK9AMv/N4I4CoToukR6Dxga76vI/d0LDZf5wD1SoCiL5O0g+kmXKYQmVekYrPZlPFv1Erwndxk5GgGFMQ1LklxdHqHYiEuDppAt8kQy7yISVpBgx8CehaIvIM3onhQMf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(376002)(346002)(366004)(136003)(39860400002)(396003)(1800799009)(186009)(451199023)(36756003)(54906003)(4744005)(66476007)(66946007)(6916009)(41300700001)(4326008)(86362001)(66556008)(6512007)(6486002)(8676002)(8936002)(26005)(6506007)(6666004)(5660300002)(7416002)(2616005)(2906002)(478600001)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGw1SnlJeUpPczNGTU5SV2dWQkI1Z0F4L3E4YU5yb0k3Z25MUGpxZXo3Skxk?=
 =?utf-8?B?V1ZaQnJGOTkxVFc1SEt5d3RnU2c0bTdYajRTRkZzRFdBWGdxSWdVRThESmJt?=
 =?utf-8?B?cG54NTZ2WG5MeVdXRGt4NS9Nb3ljbDFYd29PRnZoeEJkWkdJdWg2R2RJNXVp?=
 =?utf-8?B?Z3cyM0xjb2VFRWxnMHQwelBrTUxoV2JiZ2FxTGEwczR3SUFrTkxERFh5aUh6?=
 =?utf-8?B?M3RPSEs3bXowYUxSUDdrUkxmaU9MVzE4RExsMGNpZEdjVDJrVnFwMVRmeE1q?=
 =?utf-8?B?MWlDbitGUnVUWlhzNTlTc3ViSXJrME9HeGVMWFErR3NJc3paOTJOY25iQ01H?=
 =?utf-8?B?bllwbkhOZjF6T0xSU3VEQ09LdSthNXk3UGZuZlQ2TUhIeldjb3FGdllYNGtT?=
 =?utf-8?B?aUVzRjNtTkJFTGVrOEsvOVFzN1lrdVR2VHdDa2pNVlJ3TjJTNHpXSDdDTzJG?=
 =?utf-8?B?bmgxSTBmNjhCQmlhNE45Y2d1Q3Exa3Q5cFU5RmNxazRRTGhMV2NrR3VsM2FK?=
 =?utf-8?B?d3lkV01LVHB4b0Z4c2g5WFhRbEZqSHR5ZU0vbzBHd0lwbVF0NHVvZUtmMVFk?=
 =?utf-8?B?TGtJWVBtbTdyY1c0VkszZkZaLy80bmJnc1lnRk5JSFhWbkpiSytxZzNIOWRB?=
 =?utf-8?B?NG9FMWdvMS85LzJscjNnOE0vdkNqSW42WUZKZ1RSQkk3WFhPUGV4MWM5bXRH?=
 =?utf-8?B?TDdPZGw3NlNFNHg2WVFjVGtlUjRvRkhNT3BRY1pwaGhGOTJqanFpMEczaDVW?=
 =?utf-8?B?dzg2ZmpFSUVBMjF1M0N0Z0luazVDVWtCbTB2R3N6blVjblF1aVlBc1MyY01q?=
 =?utf-8?B?dkZPdjBEWVFNVk9yU2w5Ly9aUURndGFHb0xQMzM5NG5QL25lRjNWU1hySEpW?=
 =?utf-8?B?MXl6OUx5d3FyYjlUUzVaRlA1RHRUUHVrZnJHb0FPOVdiaGh0L1lSdTFnbXgr?=
 =?utf-8?B?ejQ0UCtNcDlldHRhMEgrTS84TTdmeThvcVN4SUlsU1pMRGZCSVErVXgvMW1W?=
 =?utf-8?B?ZDljaGZ1RU9IUEk1dVVKdHRzKyt5R2ZBN25wVjVaNFg1ZWFJSFNCbk95OE5M?=
 =?utf-8?B?THVUQ25WeWRtdithdy85RTVOckpBZWJpT1FmeXREWm8vb29vcEpFOFEyTGFk?=
 =?utf-8?B?NVNSUGFrdlFvSEx4aUExbzBlNmNxL2UyZ2I4OFNOZkxtQm5IOEhiaVFmTVk2?=
 =?utf-8?B?dkZuN21QL1BYZGxBNG1ZbmdNUUJ1TVVjRmVoSVR3U3VFOVBjQmQrb3VjNjcy?=
 =?utf-8?B?Rkd3UDE5Y1BIanRiclJQVWx4ZFBMajliUVhSSUUrTEpuMGZlWTBKK3pvK2l2?=
 =?utf-8?B?VVlMLzlYb2ZmNk10NWZyQkRqWGhtM21ySS8zb3pFZjBTcnNMbUFxWTh0OVJP?=
 =?utf-8?B?SXRUVzZhaDZGL1hmN3M3RmIrcWZNY1BjSDhBdDNsVDFTTnNaZk1WbHc4Szg1?=
 =?utf-8?B?RTVub2NFc0NrbkFaUlI3L0JoZWtVVUxhQzdoSHBKV1dSM01nU1QzeFAxOHpH?=
 =?utf-8?B?TURDeTFCSmZ5VExtdENuNDJ2K2dsbzRrSCs3a0EzUjAzMWpmNldyQ2Y3VUp4?=
 =?utf-8?B?RVZjbDlXNDhsdDZXVHhQWm1rMDFUcWlmSGVYa0oxM0hrQ0tkakdFd0l4aU9h?=
 =?utf-8?B?WUEzMUk2Y1pLa0NrNlFwSkRIUUE0dTJzVUNhUks2Y2xxejRnekREWEF3U1E0?=
 =?utf-8?B?dUg4R2t2YWpUTmVJMlg1a3JpaUgycHVRR2dUcVNjRDJRZUM1YUsxVFA0NjhC?=
 =?utf-8?B?ckJJeUkxcnZQT3J4c05pVlBicmR3UVpiZ3FvUGJiUGhvMWNsRVVOSTRHVFVa?=
 =?utf-8?B?ZGthaCsvUVVhZHBUdVlLNSs4WUpLSldmeWxORlN2TGlLZ0I1Zk1BMk9uK1F3?=
 =?utf-8?B?K3NsRVJDRnU1MFBiVDRUdFl0VVRoVExSWjJYS2NQZFk2YW1IWTBHV3FGbHE5?=
 =?utf-8?B?a3VaQUFIUkw5T1VuQW85c096d2dsOEtvVVVKZXovVmlLeHRzQ1VlZjc3bDB6?=
 =?utf-8?B?b21aeW9pcWZpRU90SjdiQjBiMXpCdStwaUhpVW0xRHU4L2x4dVpYekpNcjlk?=
 =?utf-8?B?QTRhNURNTVRaVG1NY3pYNUhpVmtJemxBWi9GUHJIUmZDcEVxMWFmcXJSLzdj?=
 =?utf-8?Q?CdIAWTdGwV48Maad3a3b7b3+1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6bcb98-4f78-4c44-6d87-08db9d8540f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:46:25.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmCPIi3liBj2dXlPc0LIN6XoziqzcO4E0S24x/XFJqhBfK9qQAaT2DBo+wruA0kk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:41:24PM +0800, 季杰 wrote:

> We do not incorporate iommufd in our cloud infrastructure, and use classic
> vfio and iommu driver. Cloud vendor like Aliyun may use its own IOPF handler
> software, so we want this patch to be a generic fix in iommu layer, suitable
> for both iommufd and vendor-specific software.

There will not be support for any advanced features in legacy
vfio. All new things will be in iommufd only.

Jason
