Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D97E45C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjKGQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjKGQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:17:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72077D9D;
        Tue,  7 Nov 2023 07:52:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI/zdfn5n3iuj9UFZDDG32n3fLhenkLvOAMMfB1MyENdKp49urjafbpadTmAYDFvMWKaShq+euLnPqEuTXSuIsPaWVCC2B6T6DVcRbUqswERcQMQesGhLWwJ0E6b5NqcvHB8FwjYMOrE7JaVwajxLZsdijEH3HWqDW+twmuxHTEAIkvMr4HIheZuRMeLx/bkY9fIMPRYmTjyW4cO0g/lXkdbpPz4sHp+rPM5+nu0+k5ZTQOLw8dgBCVHHoHBNUsVu2rX35ADpASpXDia7zI9uTujHVxHKesDChxi6NTiDAE0E0jiTY27Bl86jGWNFR0+rftSVuDyBMNoY2dn4OZWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhYwZ8jwa9geR8J0bx9YAhLiAHa00k08L8T78p7QvJU=;
 b=jA/D2ezesiAvjftwwu91d71Nrv/yfpwfuQyfGUdHvJE+5Rt65aLAIBiuwCcrznX/KkbWwOVVhfT/5JmjoQF7kwYw/UK/k5cLFg/ATt5JjG6VrOi4f5XEur2gL2ffa2sVyaTSCeNiP0GctU8/Yw8b3lDSNtJKj4QKLyk+eilYAKAfAl/Mj71/9Fvjy38DEbX1wiEpnpNxyTkSBl93gfGemG1S8vZWIOhJWfDLtXIE6mjx9TQi+BSMkD6KSqADD7tVUxeQmw6TY9PjDFwgRkuwK1TBpNiKT3dm0VyTGLsYb0COir6S6Fow8fqmMzVSD12xWuJwp5CaJEeXZc3JEC4GLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhYwZ8jwa9geR8J0bx9YAhLiAHa00k08L8T78p7QvJU=;
 b=Cz8cvUPv2HzmNl4zsBbNPPNudZCNrkjkydSR8i70VBJwiKi60JO4JF05EdZCLjS5orRoOQzue627ZMqBHOwayU/E6izwdZc3doOB50EXs/TtX61NOboNFtSJ80aEM21xbUtgIjY2RDurCj0zg74QZQqaPpNbQRaxGYQO+Bv7ZaYGOU1toAGSOGVSSdtP9HDBJUMzS5n0aY06iOus4JvFjYOL5MhvZiDC3TghUq59Uxo0PMC5aSkad1kXRlD5GN+MPa20XQ5AwP/YSWJuOXIxFjZqXV77JueKFTGK8ZXn5Xs+2lG3jwcfbw0IQiT74U6uiv/ha5PB8x4mEdUSDKc81Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 15:52:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 15:52:18 +0000
Date:   Tue, 7 Nov 2023 11:52:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107155217.GQ4488@nvidia.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
 <20231107092551-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107092551-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a10398-ebd3-46d4-25eb-08dbdfa98592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z/RoTZuMAWY24k/0l272DGo0merdSu+x/DrxToC06Iem/EVKZDP0X353gsAET9SbWs09U1IVl5vdkyxOzY01jtyUeO94Z7llCHMRnfDuUuLblTALWcZKChTO91haC6T3vUDv5U3NR/tYqpJKZKgPjmUf4cJQVOAWlQx8qjl2t7/nZ7wYqZiXyjZ1XMFshKbHb/smlQTQVYpyz601BIe2od8dxReSXQAtgLBVTSOL4GJwHIDl6ZlOaKYPUqh3zMwVk5TEwq/bsV329y/GW9peg4cevLKaZe9TP7XSRxBoFNUjUB1xvTNMNbxgeM3iatvsj6KjOWoqJshza1MZsAKvdbi8Kbv5Oruh0Eitd3BbjN1WcLW9eV66HNyUhkQlXu/1up4zAN3iIbXt8ujU1VBPxqDuVDBEVJVsF6i8Q6nS3zkzh/XPI3G2OSMnbgIfBpxGRhS/jnuhDbpSZAXjvn6LhirWYEIWmQaU8QcwQQNtY/t9SMaEFfl3X/FKRAq6PzIds5yOC8F7n31sdNZE+CaSV7bB2ILElaz7Y0BM3V8F8s+bVkYBtaFq3QsVxzjK8ht
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(38100700002)(4744005)(4326008)(41300700001)(33656002)(83380400001)(5660300002)(86362001)(8936002)(8676002)(6512007)(1076003)(2616005)(6506007)(316002)(6916009)(66556008)(66946007)(66476007)(26005)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/8a+qsApVN4cpmfiTcl+EKGF/YPwwn9+U73gVbT3i0Xb1Qsgsvv02/ECOEb?=
 =?us-ascii?Q?9ee5dB7EnbhZzdMlpSDoEqtm+FgmuJSJUKTeC8qCbMDLh/MMZvCsML/t7Gp8?=
 =?us-ascii?Q?2pU0o14K0I4WXDN/zhhNffEH+5CJFQnR7HSKttDKec5c07Tu4U7SwZDes7k5?=
 =?us-ascii?Q?PQbFeiiCUJaOG7+AJTTS6clRXgdszd/n2l/PtwRUjh25EAubQf5byTGKq+O2?=
 =?us-ascii?Q?XpEt//DnGfx2ur+sZp8bN2P4e5xpMALvQxOAlv7oWbnkXH6lbYHOX9c6yfb4?=
 =?us-ascii?Q?0cqCXgNq6hh1P8HvGgvdwINYrFu8VUgCyQm+5mGNxTWmYElPojsFAPjX8sO7?=
 =?us-ascii?Q?iD8aXJDPpiiWz0BN4SIlFdrFcTyDcv32rozzKTuc40Pr40CLwpSKRQetRKIu?=
 =?us-ascii?Q?EMmS0G0Z7JNOfh0F3kZnNbR6T7gN9vqOPC8E/BXfSPbLgaBv8swif+Nh98L0?=
 =?us-ascii?Q?JSoKesi0raN3SjTHe45OppT+OBjPCuju0Y1YpglyzDCzL4gc7RRi2Cc9sEMf?=
 =?us-ascii?Q?bfe6nT3Dr4aQxnzK3zjYXW6iqBxITiigTGa+swooq885R1/CBLvs44nRUC5m?=
 =?us-ascii?Q?1y1YZBUjEFjavgg18dX14Udg3DM3/qf295XYiLY27Cj30sHEkKG+xlXmKSKc?=
 =?us-ascii?Q?NdDL8qgWsSfmoVojuhkm9u4d6HYmNoBXH/JjHC4Gfeh1vUh/HGqmrfXma9r+?=
 =?us-ascii?Q?cmhuq5VeBiyZgcl/AgvBpHqspsqoXsv8kfgodavb3dFMmq41XXlYmRbfGFF0?=
 =?us-ascii?Q?Qg0tdCnUmR16F47itNxHssrGukdeoHu6bZ+Cdf1AMa2oAkWPUra1D7cMmp8Q?=
 =?us-ascii?Q?IhBVVu46qF2VB6MmR9MJ0k2INawTzFh37HYmz/r2rAwvsVjNXZdpCpx+/zEj?=
 =?us-ascii?Q?UyXa1XKSy4IVcAQ/lbYLHHSn0ho3DbfEaDSs4Uwh3yL76w4SyyPXkmkC04aR?=
 =?us-ascii?Q?Q2c7j9ybSsHxtxoqfPWgSFDaElq7ZEfN1NwzOA/CvYpZDb/xEmyC3Jt9OYuj?=
 =?us-ascii?Q?NR6iRznF/KZSwYD95aFjYwHNqLRW7+UD/TeDQ1CYxsnFldVcBMVPdHjT6VQI?=
 =?us-ascii?Q?C+ZX3t3Nj3jnAq4i7aMSAV89RUpeXHrJB8tUaxz195xl32wB+QjD0D4eTou8?=
 =?us-ascii?Q?H5kA0si4bydFR7zVXeqxXm15rkO1/cgUixm7Y65a0HW1oinlYm5h9lS7/v/2?=
 =?us-ascii?Q?eaAgVSGd04FhfWabFaoEQwwEKaZHfGwmBaTrYo/KbLh+I6EOr1jyZz0oUvpX?=
 =?us-ascii?Q?Dot2NH+39ZjVkLmVd/PPI650TAgfPClsOLoBM5MmTpIZ6tSdU6ZgvwNWcbe0?=
 =?us-ascii?Q?aslXgAl3P50IcgCN9q3L1/7VZ3tnap9J8eshQR6S7gfbU4CdyyLygidE9jze?=
 =?us-ascii?Q?xJeI6NziW/oX3OGMJ13caN6mc6Bog75L3nlPMHi0bfdPnCBsuxynLcQPRe9k?=
 =?us-ascii?Q?0dWKM6pFQnQueF//p5OJLyKF108xjIGt/idDJokFlBcVuimV5Ox4MBPlZfZo?=
 =?us-ascii?Q?gGHvEso3Sw9DiDI3/3vgObyRXhRKQyjkH0eMI9dKn2LMc7fuRfHksacu5MhQ?=
 =?us-ascii?Q?vHRwfK7jqk9+fx8YIU6uXYTl58DMP34WizoB7dBk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a10398-ebd3-46d4-25eb-08dbdfa98592
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:52:18.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITH9EMYJ7AG77IlWwXzs+u/Td4iy/mfsfDWk2RdQAs6WBP5Dp6Lbn0lfV/LfPyyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:30:21AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> > Big company's should take the responsibility to train and provide
> > skill development for their own staff.
> 
> That would result in a beautiful cathedral of a patch. I know this is
> how some companies work. We are doing more of a bazaar thing here,
> though. In a bunch of subsystems it seems that you don't get the
> necessary skills until you have been publically shouted at by
> maintainers - better to start early ;). Not a nice environment for
> novices, for sure.

In my view the "shouting from maintainers" is harmful to the people
buidling skills and it is an unkind thing to dump employees into that
kind of situation.

They should have help to establish the basic level of competence where
they may do the wrong thing, but all the process and presentation of
the wrong thing is top notch. You get a much better reception.

Jason
