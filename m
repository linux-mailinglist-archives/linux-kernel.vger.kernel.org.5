Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2A7AECBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjIZM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjIZM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:26:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD08EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXuuHvR71U136BtmRNbMZI07+t8jzsF7F6uqQUbWBwzQOlCkbpQEDgTX6rIdIp5oo0eNCXy3gIPJ4UpORomJcPLypB2O/YXmGd/aEbpQKml1GzljGaGrPQorLYFA4YX+9EsuU341a2bkdR6FfDSYvymA05jXHmgabAL7Sr+qyBbb3M3DlKUGz3gGNkWPIX2QtvMAwhHkQzxK3mv4AWAJEw6tXZa2nD9x2zksWbDPUniMXynOJXqhK4k79O1+LvKc3A2rFYWKCQwt6n04afVXD+UwJAM3WUazWuo06Xdt/4YJVjBBrRznOI5IArWPeUdaAJgf66U0XEM82vHXBZ104Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d++A4egwGTvB34vCxpqM6Z5+oT8CfWZOpGVUirwaxiI=;
 b=GMpoELMysMXad5RB+narD0AviiyZzGEzURQD+mnjUoZQXbEszQ4lm0QHRivxBm4KE43L/IQXOxScPN5ELwZOX04VlstYymoMt7V0/e8s0hmJUgevbepR80lGGvswZzQZiKgDu+a5dk52ZYgo9tQWmPM3tnNXsXf/zej7QfPItwYclw58GWXkwX2amq8jOIfIU5tLyZUGuo02PmMD0hs6xBOIWu5XXdMiXHKWQtIeaYZ+/AoDW+wqZUKlPX1bwaG9bo+AuKebZk6oJpbuNoj33lklykYDCWVsxi8vAspUmFsuEe1bYifGRXklGfSU38G0ZoKMovyUPsJ7v0i5IUrRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d++A4egwGTvB34vCxpqM6Z5+oT8CfWZOpGVUirwaxiI=;
 b=eQrp7vOA/vYJhDrbjIbQMZJxgFWkgLcgaF3tyUVFQyjB4c+57+yV1mlYwMAofUEl7PMnBgCxhgmq/DZprpGJGD/ae+nuLKCDpwxHcyJPODowAkDFjKZIKbGWRR7Rlg7XdQR8kUXV1BVLgHXbZCpAqm6UhmPurMTLwIicl62CrEPeZMhQkdGtuphxAK/lRwBvZnIWJ2PPzUcG423mfrDtlrMo9LyHQxXc7613Hz+adOu/Tu+sJFN1m87eRIcUFRmbstFACDy8Cvcf/xAypqrkMXAu6gXsPeFEGPrn9JTP5f8WramXw5LFXYerY4CrTIx9VhQ1GOtvpWhl5MU/9wJ7gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 12:26:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 12:26:00 +0000
Date:   Tue, 26 Sep 2023 09:25:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20230926122558.GN13733@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRKW6uDR/+eXYMzl@lpieralisi>
X-ClientProxiedBy: BL1PR13CA0254.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ced7b40-67d8-4908-2bdc-08dbbe8bbdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIc72Cw8lFkHCyMgkzC18Rigmx70bf3SYMeYsBmAnvDlSQzETrhsLSCA0vFVrsKHWUdbupXZGJO6ZK8jRg5ENQKtIYfEKu5K4S0Su3M5IdsYFwpALhRSJlBcUE83hOm3XwnDF/KVE9NmrvjeaSCY5B316eDchNbpcHEN6lHRjRGqno9uA5UcdiplyRELbnQ4js5BFRnlICpdAcdgXviZq5H5RsGQzhHWfFNu/ckb5Dytllh7WOWkO6PAeq4Z/zqlq6FDVM4OZel/IJHuS4TH+A4SCHXTk7/bXQRAucnU4RZsKLyCXEuKNYbkG5VnGduetmYWcuqx2x05EIoOvTFdepXitvBYeDTnwfFHFGgRh/Wguivhc4doz6r28LGzy9ihfP7Gnav3QxY7lRh8TsA667JboanlNgmT/VEXy+wvdxzlYV1W5BYW4O59WrPjnSb2a/SyK+edHz8DBoFD1KL4OKs7i3Hdft+QhQZJ47v7g7ijD/A8uvdCr2SyTqdkWPjL29Jkr/GmXA8ftjrOkEgyZE0JrWAV4A/MwHr8BxSK5TcTBM0QUMJyuXZORupdjT7y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(86362001)(2616005)(1076003)(26005)(41300700001)(6506007)(6486002)(6512007)(36756003)(38100700002)(33656002)(316002)(8936002)(6916009)(8676002)(4326008)(66556008)(66476007)(5660300002)(66946007)(4744005)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuUjYZ57BW4oUykHMzWZaVNwWM7+Q81WXrCsXkC6lh0WbAnR229GGp/bCDtc?=
 =?us-ascii?Q?IepAYsIyhruhPvwZVDsECbrbJIgMYT2KHIZzz2Nv2/hzGuRXIUNEfi8+VHm1?=
 =?us-ascii?Q?2tAtpG19FoRRFdjDk4pEz2PnHgjQ8ocdYRuhtwoq7RysR5LQ6oWtkO7kb4ur?=
 =?us-ascii?Q?YI694H7nnqQN9Ku4+HYm3t/7ZuHuTlGDKy5w4kgfiVk87+ufPJpi38bFmW1R?=
 =?us-ascii?Q?BdogKKQ/lKreAJw9dvrNuW1TAtaa6j5l4OtVcVHgpZz5ONjP3hXiZUkeYLtx?=
 =?us-ascii?Q?OrMYz6PK3lPhwqHZYJyB4oCcoHKbSonV0bgYykauV+PBtALG0raVarwvWfZN?=
 =?us-ascii?Q?PNHNWLgQSeWe7kNMgcrN7hbKXe6A/X4SOlKWuvOqB6nP6v6I3RujB7TGsGe3?=
 =?us-ascii?Q?evHzmq6T+ooj7PhEgGwNHbzNWsgkCAlgdZsOaAZae1rn1OomLd/JHee+psAb?=
 =?us-ascii?Q?NHotnF0MjfgNXWnlTBUNYtLX+bO1QDcuD6q4eAj/bSzTHMta6OQ8ygiGdArb?=
 =?us-ascii?Q?04G0A2UVa0Fr6+j4aGoLU0/Dd3o/AD5RQ5TG2D7UJ8AbGU2hGT2IpZRjPufV?=
 =?us-ascii?Q?koeCoRHEXaH8yU2pE9mEDFIEmLRL5ioXJ7YGdf4ZESKGZEnfQbdDrO+XF68k?=
 =?us-ascii?Q?D5jISXY/c8QBRRxy5p05mu27RbWmyv2NDfpvbbk9P6s13+u26zSlRUagS+bf?=
 =?us-ascii?Q?b11JYrYVTX9rb4ExvXw/KJGtWav8fcuid1JqxPs4oVxWzXIBM2nfigp4BNXt?=
 =?us-ascii?Q?t1glKUA+AdXYYp1BWqVHbdv/8V0sIh4ScA9pYXFE+EKN4gmsD0cRihTpu4BM?=
 =?us-ascii?Q?xOS+/XufV6G4PNTmiF3ZKOQmGYe7khb2lu9kKuHss9jg/3ABpjAmI9qTQ/Kn?=
 =?us-ascii?Q?1jJIUpCbvft9ARdmNDD5r09AXzH/V3KDOna6J7JxMpTatIvtFIjeUNbgzaRl?=
 =?us-ascii?Q?nbd9DAgCstn7ySm6LXeR/lUWGYfSuJEYOzkJHFRbWJONfZzoDlFCiwOTx1zg?=
 =?us-ascii?Q?G9+mn1mFBi3v4Ib2HhLmNwxVMBBygzSbvGHIkx87845KUtfTt9WM6m0YD77i?=
 =?us-ascii?Q?xh6F3alE+GEDEcX+zwEN4n5bqRFXMXuZMvSRRuHfygGEYyZOS3hd4JyMVTlu?=
 =?us-ascii?Q?DyRDoTOERQz4WCSpRdji9BST4dRcSkL3OLR5tJRsCjrVkOEPAorJJaGapYi/?=
 =?us-ascii?Q?Z14qNkBMd2KVtsNyy9i9+9R7lYCBNugJKSTOf2QW2QMJulQBdNzPWOz0ZuTT?=
 =?us-ascii?Q?ysOlYKykPSyjOc0pOxMnXS/7coLtSSXc/wLc5Rttj7BrFp//UoLyxFA+ctTZ?=
 =?us-ascii?Q?+htiXJ/bMqYJeSdu32NykxOG6SriVvX0NdqmjxKQit3gvHTjkRIogt1kRhcv?=
 =?us-ascii?Q?VCEL8cbtZcEeo1co1SMvNSE/kOr8XEh6u1mrbFcmQp21eRg5Vlt9DNZ05mUN?=
 =?us-ascii?Q?2GADle6QrvkMuZmjwTySDLCjcAmP2HuudPDuL/0uo9LmINyww1Tk7VxPiPIm?=
 =?us-ascii?Q?ALhosSHn1oZqTy3AeDwodlXvB4t2haK+RRRQxJqA8+1MVBi1z3NIN/WKViPZ?=
 =?us-ascii?Q?+ZWvdeMbTlF1RRe9o05Hi0UJTSc0Fu15BNAw3ns2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ced7b40-67d8-4908-2bdc-08dbbe8bbdfb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 12:26:00.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmKE7IJpPeXovpPJ2IXoyO3tT6bxts2vavccPXVFyzFEPbECiSBbYlZBLHsDyAUE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:31:38AM +0200, Lorenzo Pieralisi wrote:
> On Wed, Sep 13, 2023 at 03:54:54PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 13, 2023 at 05:26:01PM +0200, Lorenzo Pieralisi wrote:
> 
> [...]
> 
> > > I can write up the commit log and post it if I manage to summarize
> > > it any better - more important the review on the code (that was already
> > > provided), I will try to write something up asap.
> > 
> > Thank you!
> > 
> > Jason
> 
> FWIW, I have come up with the commit log below - please review and
> scrutinize/change it as deemed fit - it is not necessarily clearer
> than this one and it definitely requires MarcZ/Catalin/Will attention
> before it can be considered:

I have no issue with this language.

Thanks,
Jason
