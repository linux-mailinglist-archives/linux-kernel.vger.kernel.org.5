Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6C7AD97D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjIYNuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjIYNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:50:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB31E8;
        Mon, 25 Sep 2023 06:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgl2/kpa83cl3g1Ipg+oJ/GnFJYmPXPjQPn11VqCKtt4NrILkVy3r4NvbHGJpj6HT9tzh6K7S0zpNOmKrJO+KSE5uv7aOSaqBczS0/ZHlb5IdIs53lF1XxmunCgw+HllISjU+EjAsta7CWnOimPonNhfcMmchu32stlk/2N9v6baBDHWC+t+aYxFtL2LPN2qUadt/3m349Kw5ZhoCmVpf80Pn+Gy/hhec6tPJfpRgPEcvilUCAJEET2nEyppsA10sB5eGXjifI7NOfa/qjctUZKsZQ2Io0aWUo716V5iMynW8/BN4NgJNWyzJ3Ng9vVAKxl7ADbcXLQe1wIOcq3k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW13iBp9iuVmDId0J230kW9CPNnXZCVintRCii8s6QI=;
 b=Wp2uRt0l6hnR3deM5xVs2uHXFmJHibzjj0fPF0EO9uC7fDl2dpdK8XWUeKR/xZ9wIznSX8p/T3PLiMp5IZ4m5cQKmP2OquKjluDhTyvUxsp2SALY0RjHqA2oOVwN9kJdNS7lABZIjKNqA9UprLczvZ2jzVJUpMnxPAN4ns2hZFgNbMheyUcdtypzKl1v5arIT7b4FF1+WrvcW2HyorRMBPxb5+zFR8imCvaBkmcahAoWL2Mh753a/seGp7TkBWghmHtx11dZ2Z8fmc3zccxA31NyJlYSmecR+2d29Efl09EoctZ6lmYlw5cpLuR85Wx/CIwfN+ujulVAALbl361TIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW13iBp9iuVmDId0J230kW9CPNnXZCVintRCii8s6QI=;
 b=UBtB7jkouVCsNd2Eh5Z/or6kFDDPVwJ/bfytptAF7sK4PPxVlkuM7B7WzZiTmabzDAnQFDxxEMe7Z3VvB7LPzE7VyhzhLXRHTqhDREHy/fH+xxe2NkNVUtYJDhw2AZJlr7V+synsaY2AQfNUeIxzNsgDEzEH9NwOjxbO2MDbFhmKmiyGBE+cUd3jI7Y5VjzN4n8S2Sqowt48KHPp8B3F0kGqtG6qlSDAqXPspPw3sfz1aa8GnfTlmI+WwIiw9srxgw2fVBXgzDEC7RWu8X/tfVZEG7Osh6r64GY4KyAiQdT5gMETN+3qlIf5Rv4pIbNTd/UKq5HqwC7tB/ClV4P6wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 13:50:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:50:00 +0000
Date:   Mon, 25 Sep 2023 10:49:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 3/7] vhost: Add 3 new uapi to support iommufd
Message-ID: <20230925134959.GD13733@nvidia.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20230923170540.1447301-4-lulu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923170540.1447301-4-lulu@redhat.com>
X-ClientProxiedBy: BLAPR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:208:32e::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b29616-598c-4826-c9ee-08dbbdce4fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEr9k3bHcfzunK3WxIAKhfgzWq3R6NMtNyyfsA45Usq+jN/Mr9fcXho2tKauOU7bwqeZUK6nFZkm1r4PQ4zr/im0vuJltIyUk/QTP5hZKsVBG81QkUePMYnbMIVuSsC71fuMehlPGdNBsHHuM+fzwObooBYcC+hCJ25hrSjFljmPQfCOExHKYwg5wBXn+Z6KMNY5v4ZJryJb2OOYEUU7zXbtlaIm9pHBGItyA8mZy8E5r+JZuzxu2fIGF1PfTsPI7bhwgdLFdGdpqLciJpPoZg56wh9VszUH8iPcKpKFCNeENJDQL/30lAyaTeGLgFrSV8dFN/eMJYsoKWigpHGotjQhbHl+XRZpVg0XIXY5AaI+u+juc8CFFmfjnc0a+Q2UguJbOIOSTVhzvJxpLnih74kWQE1zbnFolltLpnI6/b84xiDNkebwS03CYuc5P/oyu/cxTBHQ9RaUybJt+Yz9KYxJPTmnNQe0ciqnvEPTI9VXhDn9oWz1DbrixDgjONIH8SasrXqKVdD/iXXCL/nIJXPXyrVXXPo2QZfShKknf8OIhMNSot3xT4jvEy9otGhJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(4326008)(83380400001)(478600001)(8936002)(6506007)(6486002)(6512007)(66556008)(26005)(66946007)(316002)(66476007)(1076003)(8676002)(6916009)(5660300002)(2906002)(33656002)(86362001)(36756003)(2616005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8XWuXiPv1mdyxw1oQ3+83Z19AzyJ9CKb2ClOl9TyEhPB2RAjGjBBWPvOuK7?=
 =?us-ascii?Q?co00X4QtPyp/1i3wJTO2NGA4tbJuTcutfj5whTynnpvUZwjv81re30VFpIIH?=
 =?us-ascii?Q?/YPsia3Y8gwIil236bbD2H2AxpyLak0DtB54QcOukI3wH2CpZZHWo3l12Zf6?=
 =?us-ascii?Q?9Qdyzl5qNK1v+Rk80Cu0vFfgT7NQ9NgV/xbMAPC/E8v1qMzRxWrpstAtfL1z?=
 =?us-ascii?Q?Zcvkh51J2FVvpu27w9KIz6vXX8WE8lv2wSLD6r5eKB/7VkE/jrwe0xMd7NY0?=
 =?us-ascii?Q?VxaFPRza6ifmu7AZI9k9N6LUou6Ymz8ygG00FeHD918KxK67Or+QzXXhRKB1?=
 =?us-ascii?Q?0AzCajOZG7+SFnl+Wz5Jw+xeREKIir5z1b1SxMLiwTVUYJHPHCuYfK2/X3Cc?=
 =?us-ascii?Q?1Yekso2q418rB/bsG8kUNxjNFSGlfZiqDU1XoPY41934qd/ub02mM2Bo/dnO?=
 =?us-ascii?Q?9AmVtd7zum4oyNOWlqAgZfVk39v/ekndS7wPMMF3A3YKeUDf3Vz5x8ngS+/S?=
 =?us-ascii?Q?/1jPVgrp4btRjYi7wHKl230u0dhV2qH8QN7qJcfsH4DSttmZMSoNXHUfFFUp?=
 =?us-ascii?Q?3MYrbcHRXhpmQslIQCHq+XTv18h1zR+pebaIpLD/L3u3wMjo3Yet2u8egUfz?=
 =?us-ascii?Q?TVcJsxc/JlRsJ5or/hnQrPyy0aMFI17cgFXWxjHaknwyDb0gd01Vq/JrfJQw?=
 =?us-ascii?Q?1m3gdy17zKjAM3BFGP41XGQ4Qck+/TtjBNJJNZ+2kB5f6hIuaawNvt3Pq3uj?=
 =?us-ascii?Q?NZOELJIF+PqReclhDC8brCbnkS3otcS3V9+R1SGZgoUP28yEBaOi9r2L6fag?=
 =?us-ascii?Q?wiQmTk0s09DaXBc5rIZ9+htXKaeCWrs/y+5fzF8r7dYGxtF6HBfc+5DQZj/j?=
 =?us-ascii?Q?sVMsM2vu9+DXK0RPjvniHBuwTjk7QcPOQB3z38/daPrczZwcWA0cPoM0gk8M?=
 =?us-ascii?Q?92dMOIyH+c42lmA9STHT+osUY/sfI2oz9J7o48JU3o9leJGB3aF9SzGD1d9J?=
 =?us-ascii?Q?taSrUd4Tj2sN67ImxrsCMaPyboh5AzNRx2huXQzJeSaS/p4QkfqgXNfC1Cbg?=
 =?us-ascii?Q?Zo69recyLhYtU1p0LMrac6VfiwG/15NyRmgL/ESEYCjz3irk3ujA1u3nINZN?=
 =?us-ascii?Q?Eo4wIxyyr8b5j02dT2Ei7Q6eh3s8mv6tAnnskxR2X90eqkV1BOf99IkxwSkA?=
 =?us-ascii?Q?QkHnf6dRFXLsIXYm0knz1jS67NFg5OIR+NTSMvW/QMfkhy05MhxkFOHAzQjk?=
 =?us-ascii?Q?CKfhw3odsu7TqdNsoXrQ3Uh7Zsj1MEfmW46+fzJm4+HG2eWWKrzrfNwloqOp?=
 =?us-ascii?Q?4O9xA0wufN4cgv3y3u9VN3N5Mt71siMcSjqrfab3VlRc0UnESgGiKSfHucSU?=
 =?us-ascii?Q?QNO0OVTSq7c9l+OI6EMLZ9WDxNA5eydFVQyrISwz1sOKp2PIDQKBvz0SkaM1?=
 =?us-ascii?Q?NmMbISuktaG+7kSGIuXd3q7nWPoartlIUvJ+HFzwuRyvQP4NMse/ziD1WEx/?=
 =?us-ascii?Q?5Wf5MzahXh+oF84nI2U/wNpYFXudu4PTX7ZKzGSnAI0AixTRLfTn1PPsx7Kx?=
 =?us-ascii?Q?M5XWS5gIwgnaGSNqyObqBE9Ts5p25mBuSUZuhx1D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b29616-598c-4826-c9ee-08dbbdce4fca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:50:00.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUoz4gqEliZN8QzWczvakNx3kD5c46JYvMparTkBg9QTCro6RIKgapih7UoG3qLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 01:05:36AM +0800, Cindy Lu wrote:

> +/* vhost vdpa set iommufd
> + * Input parameters:
> + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> + * @group_id: identifier of the group that a virtqueue belongs to
> + * @ioas_id: IOAS identifier returned from ioctl(IOMMU_IOAS_ALLOC)
> + * Output parameters:
> + * @out_dev_id: device identifier
> + * @out_hwpt_id: hardware IO pagetable identifier
> + */
> +struct vhost_vdpa_set_iommufd {
> +	__s32 iommufd;
> +	__u32 group_id;
> +	__u32 ioas_id;
> +	__u32 out_dev_id;
> +	__u32 out_hwpt_id;
> +};
> +
> +#define VHOST_VDPA_SET_IOMMU_FD \
> +	_IOW(VHOST_VIRTIO, 0x7e, struct vhost_vdpa_set_iommufd)
> +
> +/*
> + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> + *
> + * Attach a vdpa device to an iommufd address space specified by IOAS
> + * id.
> + *
> + * Available only after a device has been bound to iommufd via
> + * VHOST_VDPA_SET_IOMMU_FD
> + *
> + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> + *
> + * @argsz:	user filled size of this data.
> + * @flags:	must be 0.
> + * @ioas_id:	Input the target id which can represent an ioas
> + *		allocated via iommufd subsystem.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vdpa_device_attach_iommufd_as {
> +	__u32 argsz;
> +	__u32 flags;
> +	__u32 ioas_id;
> +};

I don't know this at all, but it seems really weird that the API
taking in the iommfd is more specific (eg includes the group_id) than
the API taking in the ioas.

I'd expect that you have one iommfd setup per virtio FD.

And the various virtio queues would be able to be linked to their own
IOAS.

I'm not sure multiple iommufd's per virito FD is worthwhile.

Jason
