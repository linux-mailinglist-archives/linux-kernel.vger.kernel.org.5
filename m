Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D277CD8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjJRKIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:08:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0495
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiHCh2oAvjB1gczPiyyD+/0RcShPOJgi9F3ll5p6vK5JRNALVFyXToPsYbn9OuhRyTTJzSUVs7SKqtBStChpxih3qyW5sDkVSGfQW0uX0z8y9hAWXBi4TcuKtKCNbYQJdZc8RLvUhu1rgkbpWnUguHdT96/3CcfxLQVAx9v7aU+2dGIfGTcbzmpPQ5RDfxngYmuTpDTvLRPipzy9/JvUThysM96ww66TFopm9yKsk46OIQ5CrRbZpDJRQ27Whf8DIrigEe0o0YEaJj213Ecm3C5Xet4yvUkzppTHA3JJGCX3NezD7O/XyQLa7eNrqPehlgwWGa81iNv/c1xB5KWiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nLqxGQmr44qy4wnqYbo+MekYZwZTqkS6LQc1DQwLOw=;
 b=NUDFA/0AUmIKwSW6ynpwHIIBImcOvAHvpLZNyiDRRdewzLnXmK+zUE7eNFd0g37hGnqXfAWrTKmH3pUujKt496ebCW1k3bLGEJwRecK7Wwni1QZUbi5T3r0ifARJV8At07pB9tkP6030SJDWlfIpdbbKs9p94kS3l65fEdkAUkjmuXj2PycK5kucTFzxychoh0OQrVO0aivjLywf8MUuftHdOgDiwaQJdeBcPOIzyIma1EcCkO0ErGW3xwZCwgi8DgrvYoOInQ0I++/Pyy5lfcSDX3hsem+9lFqqQ3Kb7BZiP6LCRPzyr6c+5a+RH473Pq0XtExj+h7rDqI9kEc+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arndb.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nLqxGQmr44qy4wnqYbo+MekYZwZTqkS6LQc1DQwLOw=;
 b=F7qIvsJYK2oyEJtn2eVd6v7rLnihYSnn1N/LMbmckL/b9B39oSkFcASD+ejExUNmuTrBXJxy0s/c5HeRqOutJD6VNTzDPAn2pu5og1gw4FdfX3qLqT46vh/RFXuUKMffQX2/bfPWZ3uQCbp7Hsu24vmEJZE/526wNGUY53nFtdWkouSkh+1iYHoWdPYAXmSoL/+o2PFGcdD+UpQravyNvOT6DTk+A55zGIohrnBbon0vIcjxcPjqW/hgsax1xZZ+8P0ra8NkG/0DFeubfFN+HybPxlQGycj0pcCgxjz/gWYKpEhGGgFrQzIlTXdmTJuS7dGMXdADKN7aaRq5Ef8H/A==
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 10:08:38 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5b) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Wed, 18 Oct 2023 10:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.22 via Frontend Transport; Wed, 18 Oct 2023 10:08:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 03:08:27 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 18 Oct
 2023 03:08:26 -0700
Date:   Wed, 18 Oct 2023 13:08:23 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <20231018100823.GH5392@unreal>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-4-saeed@kernel.org>
 <6fb88a6a-dd66-4368-8da9-596f384fe5bc@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6fb88a6a-dd66-4368-8da9-596f384fe5bc@app.fastmail.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 06876105-a76a-4ea6-d93d-08dbcfc23225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27AikSXXPZ5Sg2JA7FSJ4r4GgalrkcDBUEa49C0vDCCi92eWIVSq6twpC/Oq/7t9Qwodw060ZprDYHkKMgx2cuLvknAZljEb5d5uzRYTqm8MNmZyip3+8O7hKoCy8M/fGJR07Dpg4khjF52OkL4W5+67hYarcfweJJ/RvO9um4xOJbt2bpJyQwbm0zamjbe3aVNA67JJ9E2/N75qa5ghrs7qq/U5VxcTrUIBPWDxATIT3g/bYyMc0dFQBFbY7PPhHayqQJ6O+Lylc+m9HcFnD5SEgw1Nku/SlJdP0IzQ+26a9FYo84ZY30H8/loziPD38WI5J0JgNCDlvNf6MKbQNEXI1dZfJACYkL/+p/yRrbIFrv4Fk33CwbESv6RYHPKFHq3AmZpRXrTsBO9RVAqnEBFZH4Ea4dGt7vW710B6dGjLUZpJCtDYUYtfSEc2eraweFHR9Y8F51D974AMam4sUjBJAi3PRxdOsbBZRD3DbDWpH2TofPiemAflHOx8QIUiD1g45lZvhWeS/JfoBsK0XYf0H93FLXZ98MZtbnj0neT1fvGBzFTLtuw/prXgVXNSm8XC8kkxa4sP7z+O3Guoj0DzJyQYPKZh1c90REx+/MfLyuK6CiNEl1/yftvWmxZBHCCFr/hIIDk3hKQ4uaLwfumiomZL/Us9d2o2wlanfHRzBjDYcy3UyaEzfABXNY03yunKvNy0bem/DkEagrd5slatfl6jtOkJXLD6ef35tccs9AeLeMXi8TmD8P0nLnTZccZk4+lEnL2dn8lLsF2fQA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(16526019)(33716001)(426003)(336012)(6666004)(107886003)(9686003)(478600001)(47076005)(36860700001)(70586007)(6916009)(70206006)(316002)(54906003)(26005)(83380400001)(1076003)(41300700001)(5660300002)(7636003)(356005)(82740400003)(4326008)(40460700003)(8676002)(8936002)(33656002)(2906002)(40480700001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 10:08:37.3597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06876105-a76a-4ea6-d93d-08dbcfc23225
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:02:00AM +0200, Arnd Bergmann wrote:
> On Wed, Oct 18, 2023, at 10:19, Saeed Mahameed wrote:
> 
> > Implement INFO ioctl to return the allocated UID and the capability flags
> > and some other useful device information such as the underlying ConnectX
> > device.
> 
> I'm commenting on the ABI here, ignoring everything for the moment.
> 
> >  static const struct file_operations mlx5ctl_fops = {
> >  	.owner = THIS_MODULE,
> >  	.open = mlx5ctl_open,
> >  	.release = mlx5ctl_release,
> > +	.unlocked_ioctl = mlx5ctl_ioctl,
> >  };
> 
> There should be a .compat_ioctl entry as well, to allow 32-bit
> tasks to use the same interface.

Even for new code as well?

Both kernel and userspace code is new, not released yet.

>  
> >  static int mlx5ctl_probe(struct auxiliary_device *adev,
> > diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
> > new file mode 100644
> > index 000000000000..81d89cd285fc
> > --- /dev/null
> > +++ b/include/uapi/misc/mlx5ctl.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB WITH Linux-syscall-note */
> > +/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> > +
> > +#ifndef __MLX5CTL_IOCTL_H__
> > +#define __MLX5CTL_IOCTL_H__
> > +
> > +struct mlx5ctl_info {
> > +	__aligned_u64 flags;
> > +	__u32 size;
> > +	__u8 devname[64]; /* underlaying ConnectX device */
> > +	__u16 uctx_uid; /* current process allocated UCTX UID */
> 
> I don't know what a UCTX UID is, but if this is related to
> uid_t, it has to be 32 bit wide.

UCTX UID is mlx5 hardware index, it is not uid_t.

> 
> > +	__u16 reserved1;
> > +	__u32 uctx_cap; /* current process effective UCTX cap */
> > +	__u32 dev_uctx_cap; /* device's UCTX capabilities */
> > +	__u32 ucap; /* process user capability */
> > +	__u32 reserved2[4];
> > +};
> 
> If I'm counting right, this structure has a size of
> 108 bytes but an alignment of 8 bytes, so you end up with
> a 4-byte hole at the end, which introduces a risk of
> leaking kernel data. Maybe give it an extra reserved word?

I think that he needs to delete __u32 reserved2[4]; completely.

Thanks

> 
>      Arnd
