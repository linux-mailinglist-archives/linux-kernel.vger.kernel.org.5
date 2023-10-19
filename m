Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40857CFEF6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346423AbjJSQBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbjJSQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:01:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E947CB6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+dtBHFxOLKFbOskoTf18h8M8mdBJ4qB78TGCG7ther9H5uGmveEf0ZVcyDGtTc7R+5MIP6QBV4QyWyQ9Ygt0m03xhBVK/6F0GhzqCi2uVdgi2gRNWHUBuUgwPNHaCW15Z7h6aX870R1/m/kbHOyMhKkKwzUYU43v/6lOPC18zmwfVatlRCt2GVymmtTgxmD++FiO8dzV4AcfByYjQoIMxYyYC1GgTtcaEGuLDX4YxPtmIL0YJLexcX+ZFlZw5o/eTo0T9cTQWkVBksy+sOxlHYzkwwtatalsnc1O4ZwlAo7g6z79kPoLnsUjmb8klKHZWFgkPvMI2uk0yVgSrraTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef20vx/xzF3ZtStL9OC5hUR5doZvNKPMPA7oCEe2DwU=;
 b=Sumi62oTs7zCmcBOzAwZ5OqfrdIo3yqU5CF4BVcvN/YAS0zH8MBvjc/twekjfyZGkiVht1l6lmaqNH/JWDdJTJydbKpFZ/kFzMD72sPwAmowvV8cJBTdJj8bNBDGMlrzCFUrMbcD9ggWq7xcIoCwyDGr4USfosqYBprHP+THTWoft9XPohAD5XW11iqmNCet0Lx99om+6rkneknuZtWCX111t+4esxg2qgz8NJ2spbRsES49IudtxIEMsCwnLP/TYEuJiEMgOdYi5WXhCBS1aemUEOy8iTswjWLemdJXoLd3a0TFG+b0I6lb+l+v7BB9CevyGyvUMi2nrGGZnPI3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef20vx/xzF3ZtStL9OC5hUR5doZvNKPMPA7oCEe2DwU=;
 b=dDgSBUG5drebRK1OFCYGDeOeSwj6pfNBpcHS2b4j3+SwEfnEA6OfEEswEikLNi+l2pRIJfjP+7KA7Jys+Z5ErDnW3AJOj/uuDVY/SNlsiYixjANXoMOSqcVBdJd6EQGwc3qbFJtvYTnW0akzWd7Pnli6r/qbxkFSoFDRGizHIqZMNopNIiRbGBnyiLoEMBw63zZPx5ZQaYgpnKlekAFVK0X0/KbNnJe1Y7PWH9KT+gOgg05VXpoHvTNTvGXsfzvSawNzLibiV2UwnRCpkcAiQJWlfN8PQsNiRRTHzh7OscnJMN/tW5N6EahAqvzvIiIM5d+uzpsFIPsPhYMDzQPbNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 19 Oct
 2023 16:01:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 16:01:48 +0000
Date:   Thu, 19 Oct 2023 13:01:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <20231019160145.GS3952@nvidia.com>
References: <20231019082451.785aa123@kernel.org>
 <2023101923-tried-provable-72e7@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101923-tried-provable-72e7@gregkh>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: f993f39b-c0b4-47d4-cce2-08dbd0bcb375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmJQ08hgKJ57Bu50WExAL2I3vKnHD8HA6lroI5i9f0F/6WUYNLzO5tAp6hqBpm75ZlZuYDo90XrllEwfkmf2SM5bmEJjy/L0A8Mg5XHIIzWKuHGsBguGsLYCqSaRaD4lNvSnA3X5GrjMiGPFdwVeFe92XJn+t6i5/Mdr43t81xLVTJ9jSJQBzzfeqvvQAiwP4zgbYnpYeXSM2zRR+U8w/jxKiJxdm1jEP7v1KMG0zdnhwBgckS9v+MWUX0z1G7vdllWGH4Lo3unAVUdDiggLHKnvb4dY//lN95D71OYPJK7cmyKF++DwJW0N3C231nBL2jK1qRmZNdod6+gZX67o2n7IZ9wVIj8RyayFVfzV7Kx4J1oK5G0IfK5uFxjYConuFU1jsxaFeGsa98WkLfqGY3rJu9b2gfgakbpKSFmRPfCEgh/yRcKSVT9soCXfyXY0fMGy97QWID4iG3ciJFDSjK2QiVTkvL1Uh6BuQrElZJOXBgGnynFmw7oqpeOrGF5+TBkO8hwL7w/YpL/GyHToOtlF9/Xg4TDfQKJrqZaa2U0so+YHCdPf4otb07BveQrY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(1076003)(2616005)(6512007)(38100700002)(316002)(6916009)(66946007)(66556008)(54906003)(66476007)(6506007)(478600001)(6666004)(6486002)(83380400001)(33656002)(36756003)(41300700001)(8936002)(4326008)(8676002)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pThtCiUzZEHaJ5b3mivmJ1zK8UJn8ueEGvPU3vg9MzTBYHSbzaouSOinlbuZ?=
 =?us-ascii?Q?Tc3W2gIMjDOzJGHW4blRKFxp8difY/GTiefzvnuERhr8WNQ3eVyQolWhAY3R?=
 =?us-ascii?Q?QwOHTbbiPYKcEqKmHIcf0p2W2VmKVMOVVO3C06p/PGjgvuf/E+nu9+DmxV4Q?=
 =?us-ascii?Q?5Tyfj09MoqlFZcwYTFgmoixiMLDtZUj0SeHazIBcQ77TLwdVJlfxoh68CS48?=
 =?us-ascii?Q?GCPbgTDRNmvJN/ZcVVTWI2E8wxgZn+cGOCh90IHy5w89tlcPb9oZ0k3Hj6tQ?=
 =?us-ascii?Q?YrEPqPummGFxYAfdastDQyKGy/0hriMwtovS0Nl3rluttc+60mF+LkRI3gNO?=
 =?us-ascii?Q?LDWF9ZomQz4QMJeQTUwdrz9vDs0KT//wtrM62SkoktX39bV+uCZRf2vPh5bJ?=
 =?us-ascii?Q?SUD67MWGeoKKBGurOymf2cYv9AU7yjJl8oBpf2WRObyLemKIxZSVE+G3i2bD?=
 =?us-ascii?Q?hY6ZGwhJWQE0/YIG886vFnOz3RaLOPKzbGsB4DOxOg0fpLtrqSSIs943xw5L?=
 =?us-ascii?Q?2oR54/sReTVGDPi4zU8oczNDWJzTQePDX1CKixCRkq4z85VEBa8SDJh3wd7V?=
 =?us-ascii?Q?cvFItjeS3UNlWo5jrn2dBk1I35l88r7VNqUWhW23sMVBrscnbG9PH9ttJ3//?=
 =?us-ascii?Q?Lo6y4XKWPKGq3s0TOUmeooAJ7GPI8OJVgVWtjP8vrYgKGwLl5UXoCwJbrZvl?=
 =?us-ascii?Q?SaEv68K4IicBlrxHTW70iZAknTRDvhCfQFc2FlicCQCfPubANRlcq1M7rKBm?=
 =?us-ascii?Q?XnOBnOUrb683L32aG1zgZ66jmIey0cntsKzeMDYL9Lcsvw+m1q0MzL7KbwTD?=
 =?us-ascii?Q?ZqW3bIFjDQtGb1OSohGw50vCKS8dAIFjLrNJKwdqk0x+06nQhFFMrbb14m2S?=
 =?us-ascii?Q?E5j57IofgN1Lyz8HkZRww24FA0wxhtOVtRCPXBlg7VHtQ561HcIKxrRFGiOh?=
 =?us-ascii?Q?1m/8Vc2QS5gKSpf5eYT1G9a4L8wmhJ92Yu54WYOOGUNOQbMBousrQcmrjlqF?=
 =?us-ascii?Q?YH6/CRAu6BuORUY7JLb9bJ0XnCOp7ntn4+hDwLToKJZRfBy/DcoDD/fiAJVe?=
 =?us-ascii?Q?qoYY7Dkcx/6cpLlTY2g+sT/rY/TUKbQ7jic49mF8K5ZyCDYPJ07rcQfSqFxp?=
 =?us-ascii?Q?YF0QLgTJFJpdfnp0nzBsqFHxrbGsfXizDD6YJQbHIPlONRKE6ELMH2tuPCTz?=
 =?us-ascii?Q?xUSP+SG3Tx16UbNrp7adoR2vhS5SpvKoPDbAI0IFz95IPBNcWsMAWO9LYU+y?=
 =?us-ascii?Q?ul+p47l9BmZ/d1Bg5NWUUlKu5nbTMa1oCkqDYvaAObewDauTUSl4kjHzs3Px?=
 =?us-ascii?Q?Tj0TxDBQoYDmBfCVXbCXl38WIa5txdJwP/y2rk6UglzHVQ/gGfQG85LKHKrG?=
 =?us-ascii?Q?pKCLSTT/br7EXctVdCdqcXNLHQHeWk9Pu3qWWBx00hS2/d77yZs0yuoh5Y8W?=
 =?us-ascii?Q?bqe+HwhE9iGIMWRgUupCabC7lz11LrSrWjgyWHYyjKYrc1fde/tUZkg/4FqP?=
 =?us-ascii?Q?bqOeoppBpnkGa6AGNZ+MCF0Roov9t4elB9fdoSMIEtAV/IYaKXn2XPCfGHCi?=
 =?us-ascii?Q?hQxITeqQ+h+wO7KQWKijZqMmwlzLJjn5Eh9kQZOE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f993f39b-c0b4-47d4-cce2-08dbd0bcb375
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 16:01:48.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8gMEmKw9SjveG9SQZkabh4i6ihK/wmBeV7iz+TCCNdYkSyiizrCM+bp+0BJRZdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:36:04PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 08:24:51AM -0700, Jakub Kicinski wrote:
> > > The ConnectX HW family supported by the mlx5 drivers uses an architecture
> > > where a FW component executes "mailbox RPCs" issued by the driver to make
> > > changes to the device. This results in a complex debugging environment
> > > where the FW component has information and complex low level state that
> > > needs to be accessed to userspace for debugging purposes.
> > 
> > You're being very dishonest towards Greg by not telling him that this
> > is a networking device, and the networking maintainers explicitly nacked
> > this backdoor. 

Do you have a lore link?

> Well, in this case, no way in hell will I be taking this.  If this is a
> networking device, it needs to go through the normal networking driver
> review process, thanks for the heads up.

It is not just a networking device. mlx5 is a giant and complex
multi-subsystem piece of hardware.

This is shared debugging and configuration interface to the device FW
that interacts across all of the different subsystems the driver
supports.

Looking at Saeed's tool capability on his github it is significantly,
but not exclusively supporting RDMA (ie drivers/infiniband), with some
features for the mlx5 VFIO drivers, mlx5 VDPA and a bunch of lowlevel
PCI stuff too.

Calling it a "networking device" in the sense of "it is owned only be
netdev" is not accurate.

We think misc is an appropriate place to put something like this,
there are many other misc drivers that are sort of similar APIs to
access embedded FW to manage and debug it.

Jason
