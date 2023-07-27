Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990A0765B88
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjG0Snp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjG0Snk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:43:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2952D4B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeSAoL9cJhRyz2TenZTGvTVQXzN8kcLiF4U8YpMFII2yudVkWgEReUeSG7wxFhCM/RUryGpfVGb4VrcK2OV3Kcs1blC5MQt0o4b2H/NboC9ykZ5GDMgUMQ2tz7ajLzoRv1L4/V8+q8Dh3Cyvx0+71bc9xYuCRVsx/Vn5fAsePIBsCYHLQEtkg0zVXXwA1ibnp82a/dlnvFBqyX56AjZzeL2f+Z3MRDl49bxdDZhgGXhjAe3+svkU/6SWNSG7X1dRpOWyiPN6i4Q0E7MbWZ6vOqoG8dZx8DXY44Ov2z3lHdfGtqMIlG2pwdxjGTvIimnuDaLmrWT39lY039EAU+cyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz0lyRWWjcALL8xJxuxev7Vi9TsuqExixjIzm192U/Q=;
 b=YdI3puR+NwSMiiRhl3be9s1JY5RuKWOLQe9osF7e/oxrGPmJNjm7oARepEEdf1Umyl36TnDbCucQIEDeobCnfXgFUxBPm8l1kZ0QySg1D90GKN9N4RFQTkUHYNfx8Fd8oNcOSJuDin+YGGc3ILxAiVIrL8oYXDZJHKS5a4Y6aPdumaRuYz/YfUHoVGSrjhd9dUUrbHbe5gR3Dn9cszA1V6Svsw+iklsrB/szdpyfrnMR9EblK1kPBrQdbBnjwqD3RtyNbzqk+JD5RGomNRP6Xd5BIvhd4EcSNU//FyMHqXko77Nq1bbeg1H1djkZBjBrX21r8/bR6l9kspEn/SN5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz0lyRWWjcALL8xJxuxev7Vi9TsuqExixjIzm192U/Q=;
 b=Ocpxo80TvgEtvZSe7XuwgZoMfMISg+4KnLND9bw6CMcUqjqjo+9DH3GPjj0tb7Q1GOankTdh4Br6P8zHBM6K6a+wXO4d1Cp3UMAem2TYNNY9XuDjVeirile7tmiCnTjnCKz3AXs+4rKxTZTK2GMuFx5Au96xcjsRdZKaidFoMXve093Nx3SMGOJV7jcnsW81Qd7NgA0UCcdHx3PqKsD2sJ9Y+kWPUkPSTPSOBjrN8ExIdWuzwhUooxgp5kItL1EZS6gEXgv3XzEFbITM49VFpne6XkA2ZJ6sqJJVNQZZoUk/DBo+3ov8ibdc1NXNCyRd78NAFBRHcp+q7fklC2T/5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:43:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 18:43:35 +0000
Date:   Thu, 27 Jul 2023 15:43:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/7] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZMK60wm3BBk038r7@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-8-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727182647.4106140-8-mshavit@google.com>
X-ClientProxiedBy: BYAPR08CA0067.namprd08.prod.outlook.com
 (2603:10b6:a03:117::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a82527-e42d-425c-a4ef-08db8ed1627e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcRuUVRdGR1SW2VfShZR5+TeN/9CybWjIdseVa8knHTRnz4bI0dKhiDONDN1QdZOHkczXwJGVIufzA9XDZZBLqUqg8sHFBNZ63sciJa3okDtG+qvbghBJb3cCiR1C8JDtQfVX57HDngkCYZpMMorZjowvHI4RsDrVxVVSJwiqU8WljonQFGefows11SCYpkjQSk19NVFXtLDn1lqPUk3lCHb9mcB5OFTlkM9uTYr8T7VDiZVb6sD38BC+FAIxwXFth9GQJ0dTUmd6otEKJ8Kfs9OxwVNQ6lrHZ2KqaXeu3B8J7obrNY3mDU/n/Yxxpe8ZBGjccJqbv3/DF/YiiDYjVW0jCWJ7aOFop1Br/d6rIbGFfQ/1fOB4dJFSPn2Re1MHJx9SFGKJa7EhbDjTekliEGu+j0DbIv26hG1AcTXk+QsAdySaCZciSs9EsZiizuSBvvUyOoAH02T+D7q8x8hhnovNPykPYiqPgWmQXhul+JKCmgB63IQfp+ngT7gwxqNHhSK6CApq6pEsRD7eVxehDbf2KGZ6tH7jKy1bDZWjEq5WT+C0athULgKRLElWSK4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(26005)(6506007)(54906003)(478600001)(186003)(6512007)(6486002)(6666004)(66556008)(4326008)(66476007)(6916009)(2616005)(38100700002)(66946007)(4744005)(5660300002)(41300700001)(316002)(2906002)(8676002)(8936002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdN6L6ZvNfGLoTTFTHz27KxGEsxJVeWrHaBtLEIVaCeke8S+kB4XqNpWhEg8?=
 =?us-ascii?Q?9l3AHuQeu+PlkJhrmFYmE4IhYhoaEUIlKvgIRa3pcC39508qFixDIHWfAQcq?=
 =?us-ascii?Q?xx2da/jlPxAkcpif/6W6/Bd/blRVevocz/j0ODPs1PS39Ixlh2wt9BXHkI1+?=
 =?us-ascii?Q?jJcCGx2QDPZvKZj0fuHIKz3tWbAISLO3hTD8NTpPc5Jn2yX1IPcfaBwxYXQY?=
 =?us-ascii?Q?dAf77bhI19/ii+ORSfuZ4dG4eK+5Osa8z3rWCqE+GQX8x82UrGNBBDVMBoRr?=
 =?us-ascii?Q?WbwDDVSAkQQ0g5TwK5d5kKTbnmf9Wnzym5xK057Ueo18WR9hXafjNnvcIq3g?=
 =?us-ascii?Q?fmHwoiunA0NDmPw7qr4gIl5rQQukwnqD+YD8h6QduRRcVUSjY+kgCA8Lx2zO?=
 =?us-ascii?Q?Uhb/WvwKfDMcZv1c7eGaU94ZcxjRwJLv+SeBp+hXGR7/xrsEUtNtb6iIPXeI?=
 =?us-ascii?Q?ebRvXebOOlA4h1Q19/LFL0CDwop9UUBJLe2y+Lx9MSAJkMqdW7Wuvlxq2G0L?=
 =?us-ascii?Q?TSa88ve5MwtPEa4Eq2f6zwI1cPjduMeW9apJfg194wS6MSUxRPS59P2F2yqd?=
 =?us-ascii?Q?n2tgDn8RuiXNG7Fdu/ndsv1YQy5amRVA8QVL4GN8Xz32QO8D4foCQrENUD6S?=
 =?us-ascii?Q?bqbazoXx58JiMgXfRb3UeyafploVSWqUQs0Inqqk4bpU8mA/pYKWY21MSmi1?=
 =?us-ascii?Q?F5g20IYYLab/PxafWyCxnN5bnCChTkA4o25eGoiJhMQGXZGT3T/d9pAv2pqu?=
 =?us-ascii?Q?4O+jwGWUd9UwDJkSP8JAn5vo9TS6vak4kKYlE7ZyJ4ojNlDMKcta5DJyARnN?=
 =?us-ascii?Q?xhB6dN1WFhkolCE965eKgime5g35q0uZm1nJNsU2+n0jOXCNIPKr26hNcocy?=
 =?us-ascii?Q?gIDulCidozUVIuhRnikE2L2dzVsT9aovurpEvtEZz5NUtQkdl6ageTW+bRDN?=
 =?us-ascii?Q?CTXLCrtiF2+KcZGKeQnRX1IVf7mTHikgrGxFJRO/fklmdR1Se7/9Klfw9Bg8?=
 =?us-ascii?Q?RkOQ68rOHodenSzilzZAqYZfP6dxaHC70bJ9Xt/M/Kv4SStEHRLnkAJiW07c?=
 =?us-ascii?Q?BBwFEysqt/RlKbM28ZyMIhuvu2BQoTDq6ckxgYe1LwHHjdMx0E71nraE1iLB?=
 =?us-ascii?Q?PkMeSjEyr7tsml1CKZQY8j3yq3RphOnsBhdOoievjznynoVVaJjzTcVeqEcK?=
 =?us-ascii?Q?2gRpMcIIpeaQKygMg3epWZFjaEE2hoEs3oxTpFGXKfsIczgdjo71/S0+DeMM?=
 =?us-ascii?Q?JBEtbibLk33IJnGqu59NP7sdr6Wl3bGVot6hYjzC4nlkomR69kWw5RZZ9AyA?=
 =?us-ascii?Q?ApHQgpTirkjWK/+T3M6uyf2oMcoEVNfIBey7NYjHr8tKejRL9tj4DL27wgZr?=
 =?us-ascii?Q?+Wae5c8tv0hvnur29g6mYM+0SXtF79cBwPSTdbARtS1ErGjIjW9FoQgCboJD?=
 =?us-ascii?Q?wB2hQqMmkiHGdhiV1i8moIF2+yZbJPQ/t7kbHmY07ZXYekqHF8A/kD7A2qrp?=
 =?us-ascii?Q?pH9OFjxd8JNyis4qY/XhyUgVzRZjHJrls68Qw8o5gaNqQ+W+cU7/ZNJJBSCC?=
 =?us-ascii?Q?dGmLUrsTAm+nlUqUjjIXPO5gTl1COqGGq1dnujZw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a82527-e42d-425c-a4ef-08db8ed1627e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:43:35.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaiQHwQAOUQ2uwUxh+o1vtCZtFNuxBbs4r12Ji7DqgJBdhQkLO6s8wcBxVAHd71s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:26:23AM +0800, Michael Shavit wrote:
> Each master is now allocated a CD table at probe time,

Currently it is allocated during arm_smmu_domain_finalise_s1(), so it
isn't allocated at probe time.

I think the right place to put the allocation is during the attach op,
the first time we need a CD table then go and allocate it. If we can't
then domain attach fails with -ENOMEM.

Then you can put the free in a detach op once the CD table becomes
empty and it behaves much like it already does.

Jason
