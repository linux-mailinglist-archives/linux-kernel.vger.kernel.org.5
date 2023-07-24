Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55C575FDEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGXRjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGXRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:39:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5236C0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf/j4f43aZpjWQvVOxJ5YCPgl1z6DkF2VcINiCeWpGj4BqHTS/s2iHtW092OE6tviPB1LL91CTLx0V0A+fipfTmk+uo8weT+AdmejjBKDqprx7ZskBFs8c9PfYgpzp70Mg9RcRtWrUZkYMWN2D7OYgYXYVmr529hvV+WeFawEy7jp1vXtftG97M6cZPDJIsDiAX0TGYiI+b5mJw8JJ8TxFaA5+qmFXYC+M+37y9pZWBLX0RB5RGy7TkEPUXvQZqmOa/R+hErXdGKoJzlenPppJBs18HsFiK0Ml+WyoYkIB/qAAXR/LqL2JUK5SJPNsCgj6pTqdFwZuyfFrc4XZd2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWjvOl64SF1y/GVV8bzSRCiDwNV8URS1jJ3OEqUXX58=;
 b=dTyi/KlCDQ8FNAf3sRFC3sirpf6RAlViq9Tpw56whof9icwIS+oG/xQrk56Sh14CO6pdeADuFS89WB2rXQzbismnBTGgEJGFevjDDTXnzkDVyvqFRQNzqOy4SVINDGrebQgCV/lvZA9wRRgNWBFUREt6ZG7zZ/BVgQyftlG/R0IOTG/nr5aCOGNBRQp7ktb50btw3FQKhEnM9LHcqvyoADDq2ZeLICWEZZHplRveEros2kJyCdv/21wuFyjwbEEKL9w4JA0VmLsz3zrlQa1ES3FWYnlUhcGFamjHpdlpi9B7NGSEJSTNOGcb7YQUUfjW7femZ4DZPxmO1QlKnb+MnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWjvOl64SF1y/GVV8bzSRCiDwNV8URS1jJ3OEqUXX58=;
 b=S/ICQCR8Lmuj9qeeYRO59Br/1udeUN/gA+d3iZO40gm7mrP5PWmLhug/PDyN1h+6tlGQLf2ykEq4ilk8OoydsAESF/rDSDoKcEagTR445NcetXHnhiosyGRUy8m+B4uNoqq6Vx2wDjFzX/07p1Lhm3fQE4F53p+3bvHI1w/lFynkRjVA+XkWtNkUNRgYQjgNFvDusOjzGU97tH4SSGz7QgD/JK316QaCX9QrYvbxA6IGwYq4LM0AR1dJQguSYuWkRAfLC5vi0HDtqdyWlfiQxZVd4zBRc1wkn3HqIwv7vkkjpAsG1UVr8H8rzfInoXdsYV9si9v738POGgCkhQDLug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Mon, 24 Jul
 2023 17:39:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:39:50 +0000
Date:   Mon, 24 Jul 2023 14:39:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: Call dma_cleanup() on the test_remove path
Message-ID: <ZL63Y8z9x2ZBDXQl@nvidia.com>
References: <0-v1-8fd93768dbcf+19b-really_probe_dma_cleanup_jgg@nvidia.com>
 <ce997cca-32c2-fc04-b84c-b97e6ccea4ca@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce997cca-32c2-fc04-b84c-b97e6ccea4ca@huawei.com>
X-ClientProxiedBy: BLAPR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:208:32f::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: c91dd39a-a5a3-4487-3b1e-08db8c6cfa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9HkJO1oSr1+KHDYjsqMPMgjux94AW65brD5GycBl/g6qF6pJxvXyjj/x8eJp2bnLbNdNrcmrSk9H8n0qy/Rgwt6BpW5Jteuq3nGo7XX/Mbvb2vPQjHSRajwQRkclrjFiqQqkN9H628fFeFntfOMoDxSBXufXa8i0xLyt/pQL+9vxhlgCItWaUpaU7D/k9uTaAPZoj3TvEBx+JNk2h90w/uX/A4ig+vcHhgpZw0McB361v0H5TawY5dgh/zT32A8Qsc++H4HQn3coGS2DDnKJTYlIfzK0Gh+EuSAa4AJE9lHWniaQLjbSuVnT2BD9ozFE6wtabU0QFmsVD7uPyBh8ZF9ZMNOoyfSXdrCFDBfVhTSedJ2fC8lDySlH3wT+NRhUWAPpHgyoyptT9rCF615IVPk66wsWmXZktC43pCBNof7RnRgk8EvUXUG2VFQNQLc9qL4gFIVe1Bko+QAbhRJms4LH5RSTy8rnJxm223GfCBTyfvVPRm4g5/bR2/+s1lTUJxco29F8cGvWxRXkokr+xDVc9XHr8TgeNZb8g6tkvAYoSjIDL+sz4hicsfCTzMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(66476007)(186003)(6666004)(6512007)(316002)(66946007)(4326008)(66556008)(26005)(6486002)(41300700001)(6506007)(5660300002)(54906003)(8676002)(8936002)(6862004)(478600001)(2616005)(2906002)(38100700002)(36756003)(86362001)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJcJJhgCkqlljFGgnkZh5TvZGNGEmXfkXoynGyWs+WrUFzb/5dy0bh8QEYyQ?=
 =?us-ascii?Q?+TL20lsgh1baP15M7QDwCHbj8TziQwABzVVP6ndim8WXzShWce1IY426ve9h?=
 =?us-ascii?Q?BuIJuW3ABBEKa+hCjKSQoflzRsWgGU9geIwsPsIfUlFKLJxeA/UNuS6GXOd5?=
 =?us-ascii?Q?wjsjlBZv3/YXqpuCIG0pSqr+Adzo2L00WfDRzX8k5CIh1fGVEfTzoaEFY54r?=
 =?us-ascii?Q?vP7rG90JbC/mYIQdK9YC8IPcuiwKowxc3x2FMTjmOGfdXgQQhvAse+bFGveI?=
 =?us-ascii?Q?QCt2aIGGUpjIsmHWgqAvi6IkqjYfZ5ZZ19gLPD7N3gjW4GFDiwr6z2R6Adva?=
 =?us-ascii?Q?uroD8wCJLuWmyTMZa9fMlmXI/AQrQbulMSx4ZqZH48ToSpjKNwrqKRoXi6zq?=
 =?us-ascii?Q?cMn2NVlIOzBrT6p42EMP/nnQ0fzP/cNdsT+p17nCpzsTkQCXcLfOfGfwnbmR?=
 =?us-ascii?Q?6BIjck1h7W8qyX4Bqn11QeaSG5FLpwsmllDfa8qo0w4nbTCpt8pQXMv4IhcB?=
 =?us-ascii?Q?l3UiT8GtXAkBYpoSgnO2JbHJOAFpFyojgCSlqPod/YG5CI2nmxlzko//NKkm?=
 =?us-ascii?Q?hhFJoCqaLtqLcZ3sckDcFt7PR3wMOXhJBftL25gOiFoMiZVrJLf2qSflF1Jo?=
 =?us-ascii?Q?p5647lnebbnnSk//lyZ/YCvqHnJRN5bO/kVmoBnZ390xR7JsoM84DH2rxi4k?=
 =?us-ascii?Q?jgv2T1U0syhhyJQwqW7XIxYC9PVjJAVa4AE/+JPR6SYHqBzvyhqMyiSSm6VV?=
 =?us-ascii?Q?IXUvolDnVR+1es5U4iGThibQX1dm9dX9fWBqGCMKO5WS41vGi0F/LRRdK67h?=
 =?us-ascii?Q?PNP+HyCCNHun7jG21Uq10LZgUNp6txLBpq8pkkBQ6a9czim2dGUA78wGCjC9?=
 =?us-ascii?Q?4XitwpJMchUD3x9EPL1H/qb1buG6u7Qe3H+Vl8leUSNU0re4sPHSiJ/48rWm?=
 =?us-ascii?Q?8oqMxRHhBA7YLBZFExLaaTEAbXUuMnbZcURQc0Z9EMx2nOw7m6nStj2D4AEU?=
 =?us-ascii?Q?ziWC+sRmhtLVtYi4bQzF8jKMoVYQyuHZLY0EaaWNgUgHP30lbvqHhbGXZcul?=
 =?us-ascii?Q?i8e+a0oJSaVjnBrc3gxfDSoUnCBAfrp398M6OOuApPJLCK3KWfm0L7zyrcZU?=
 =?us-ascii?Q?NXzHf6662rpC7a0zKH4uP+5JE91ccwUCAtlUSeaOiG7vVmo6mFeP57ntskhD?=
 =?us-ascii?Q?PMue9fGnjjunNSb4CZxUdtHW9c0AJkj3eI2ulbCHzvjJ+by/jU6lWCuLZnmT?=
 =?us-ascii?Q?iSSuNFYAvUNPEBexj6H1bqFokYkI7FvMQCsGih/63YelThHB/hODd5MVqYCJ?=
 =?us-ascii?Q?1Zp6NYakAkrR5ywgbWlU2M3NFhwzRRc3Au72KCmbCYv2AxAB2/GLAht28dKs?=
 =?us-ascii?Q?alTbc4JyMTPrnVOHKPVIciEJnDH5CwnFrg94mixnxYBula7G3CcV/0EFBOBk?=
 =?us-ascii?Q?KAjo1it276c6zq/yb7Lb5gNU/MaV0oGf5R8+KZw2yj71fWv93G5UwThZKLTy?=
 =?us-ascii?Q?GCqIWOm2EBpCsWOX1ylw5ZG6EVlVNypYmEoekCLNJN5mljGzWdMhH08UWSr5?=
 =?us-ascii?Q?tfQcKcfbu302s7E8u3EZTzG7ELJEdCrwbKzyvmIG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91dd39a-a5a3-4487-3b1e-08db8c6cfa72
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:39:49.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJeVSj5QUbN0y7TxApajk9pYb5VP6RWjXSIFc07BfWRi89hYb8dhL5Zytf3TLMC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:56:09AM +0800, Zenghui Yu wrote:
> +Cc: LKML

Oh, I accidentally missed that, I will repost this, thanks

Jason
