Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6E80A3E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573766AbjLHMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:52:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882311C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:52:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH7WlHGrHVSuCxyfUyWJUoQaZo41VEfqemlcXJPI5RKg6hiKuEKIeotwZ02eOq/0r5oLxKZJPP5yrjb5pkTpX20C8mMCG1MCg/YWaMk6GxBUlxK3Y+6tEjdWKCRYTJg+1Jt2SOl+oj9QWHMQtH+1tTRabwrCxjAFzjGZsyguTaJvfjNh8lTEYr4lnPp3usc9Ebf6+CA0RfmR1dQ3xSATQBokmzOSW+xOW6ZtH0ay/S0GaLbytLKutno1Ced0KheW2+xcd0CjyIQzr4lkN3wgZmlSd0nSSByw6RKtlzvn97tyeNVKpIn0TJjCKd7rxa5pR4xInEqilvPDrSYSdafb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OgG/WfjLhLBw6tD7Jdpnxex9z9UjmgI3dvCwGd6Yao=;
 b=F+YruqnqBxxKYIIq/lY+gXTuJNWDFD4ir53PkHMba3zAqxdv9fybfn+svBfctVQo9DwE8u8M96sFBYWvEWMZZduDfq+gmsghcMuzqBaxhGNkuZbewlIdoQ5UoZsZcsSRQAM858QWBkPZwa1HyTZ4bTEseJOZ+Sb/LIJKFaRvL7jR49M+Hkrd/5uqsUHz573cn7SoQSNAPh6OzRc4d8PTv5fx5zUkWNSDd8foWBwnPgLQ0KdfKy1ntRe0aHsM6eFqFqwobBS316+nfmUC1u8LRCbsCO/PIgVVdKLcsJejYaX5glb85yaB/bni/d7ROglbEPzSUnaXBTmzW+aAcoQUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OgG/WfjLhLBw6tD7Jdpnxex9z9UjmgI3dvCwGd6Yao=;
 b=jxa3MYTQhwd6MoKvt1sGkHom8qQny5FsmqsWGZpuIsx1n/07P8v8snapZibvXcMm8qFnbaDJlhg+rpSl+TpRef/yXM60sy9yULvRG/7tFvlyA5fpv/nFR4cTMeAqtGpZ7duxQ8TM79tNBMvZQt7urAWa0NkhBD+xAzVndSrXmZbe/i1l50Li5sfrCH/P+/HQTzYi7aC4EI0b5ERklO98LQ16bHgpD76CS4FknJ3wc//OCD54RIp0f8F0SaNUuc4yfL7ma5DrpegZtfF5C4VypoXT4KxcMqi+dZVpdApw17/+up7BrrD/0ujmnzCqEJWdWODFqNrusI7/Vn9psNkwFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 12:52:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.038; Fri, 8 Dec 2023
 12:52:29 +0000
Date:   Fri, 8 Dec 2023 08:52:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aron Silverton <aron.silverton@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231208125227.GO2692119@nvidia.com>
References: <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <20231207092329.3ec04dca@kernel.org>
 <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
 <2023120857-calculus-concerned-cef0@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120857-calculus-concerned-cef0@gregkh>
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ee2b8b-472f-4dbb-f01b-08dbf7ec892f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmmqrXvVSVULCsDYzLu2ckpVKMKsr+mnL3fRlM9esaKhAmHLEqEZ/cveYZfyzV3xYolBXSzF93U0lyHzG5QqYgGx6NLrbxc9ssaX3Y/fqA5ePeT0Ip6qPsDsVJG5Gx5V8zlGt7wqYzL52UP9eueUHEGrKG0OYkYqanXElnvAJjJzy4i3yFQMULcrAPzfeoFTt7ylDYADOrPXAWgOr8vT+SX30hP7+xBUDPdojC2bCu4B2XHtQeuFRhb7t9KE1at4fJQCdosP1xK8CZ5p9+ePah9Meg1NeZP3bF840zPWPtBVlKpK7bvcBLwrKNAwWPwEjdURY5SFMi2+4WU1NdA/T3cVjFx1fSWVB3Pd/J6es937tV5wkw81DMRL6h2xuo5+WHWxQqRGezkvl6g1mssb+EoZlS725SMp7nSRqbxM43kIyxPlhFLeLOrc1/fzDV8527XgI+0RO/xDTTY3BbyU7Sa2RFREOB4ZHkuvFub8cSz+cEsb58A3be063aNmtHITpsSjU8NE9wmBamH9DiYqx68djPksyO6ypy9usFKM8RjfwLUk0Qnl2g7wBljL4OQtGfzEMIO38SBb7jpY1kxxPFIcHk2a1d8DCzz6TaVyHw6F4p38xR37lWltB4I5WRBsIxqOiSPt2i0gCB2s2A/H6qaAOan3ax7ldlhk0H3d/oA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(1076003)(6512007)(26005)(2616005)(107886003)(33656002)(6506007)(478600001)(6486002)(316002)(6916009)(66476007)(66556008)(66946007)(54906003)(38100700002)(8936002)(8676002)(86362001)(36756003)(4326008)(5660300002)(2906002)(41300700001)(42413004)(32563001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LvJjzjA381o9DdNnXcmiO8GHrj9+c6yA7dYu0B/1nMTP3nVBZTrR1Q9dFVEN?=
 =?us-ascii?Q?kangAuUuxAdrkz05NHJQwD1Tl/YWjxLoQjwDw9X46ec1zJ9L6mJkkmuoKoXe?=
 =?us-ascii?Q?u3PQhnp5nzMgl+u9IoMU92Ef+ewoz3T6IIzMDIOq+5XEWjvWr/h9h+Ofg3y3?=
 =?us-ascii?Q?h4bQewwvjdnkJHV/w7Izqvsm8tGIZsMN26O3I+u4YGgUH4valrH8KzVHrJPz?=
 =?us-ascii?Q?c7e4Ap8TYAXIj2cbEHnYJ0gqT0ks5CgtBTEb0dOhqqNqW0Ib9xOJwSAawK3X?=
 =?us-ascii?Q?L5CTLhwjytIjYNHT8MTAegI8cpqSMliMH+fjAWBryMvn5zEqMh309Q8fA8h7?=
 =?us-ascii?Q?VQc+sg9V0dMUNTGyrrnaVOTDeF1tFq97uZFeT9Vtua05PCJZUD/EOzWqHsN8?=
 =?us-ascii?Q?tj3EhX66gGoSWqb7jS7URu3QTOUzB1W+GFb3wfKwbOmjF0yQKpvq1lp99L3L?=
 =?us-ascii?Q?ZDUjVtn4y+W2cwsxm5zs3Ys28CJEU70Hm389ww4lMbRC+j7hcf5ieTQ7EFzo?=
 =?us-ascii?Q?jVtCioV+Z0kEmxkUBtFZhumJivRsM/FmDeRDGObt/btJVA+RlwjjyQusUxiC?=
 =?us-ascii?Q?9tO822ZYiT9xnik1A5C3KI5AuHZ6OR20ehHAGYjPZDyFFzCJ7OHU1dre/GFG?=
 =?us-ascii?Q?U1ddPD+l6a+2f1tr4xw1YiKbOI16j0VnutzOU4LffxSImoYS0Tffbnnf1lWd?=
 =?us-ascii?Q?xYx8RdRsCUJt3wwVjBMqKxBqjbX/F4n1BNWwoqx6VotfDNO+NdeF8CEIBxaR?=
 =?us-ascii?Q?j9vrY2nNlGZyNE2yM9cJ894GjR25T27OGlFwIh31GEGV/sAohaOb8K5VYR6P?=
 =?us-ascii?Q?nQjH0O+bnXjIzwrzMm9CGT8c+xDetxtwP8NiMVIFaOIVBqPSf2kTt97pL0KS?=
 =?us-ascii?Q?+P7itPjOnFGLMg5SpIhioHnZo9EnyTfcSa7GBWEJ9jtAoSugVSG9gihsJBvH?=
 =?us-ascii?Q?EqT3M6xt1cMuGyACdHQ2SSj29tIq21AtIWhYBiW6ykRMmIh9gDjVntpa6Tx0?=
 =?us-ascii?Q?CB33pCFb+z6lpfM4t4XzUoEni+ZnsCDipp5RC+4spw4RR6suQ88axdVYfhy3?=
 =?us-ascii?Q?VCl1nwksbR0TmMLzhSG60Yb8Q6I5oP1tHHI/RxRKenOz2lYbxxqs50E7C5QR?=
 =?us-ascii?Q?5xVnv5HUMTHhv/EZf7isJrTQe5wRXP3Zsi42KxKnDek6T1I8zrg8FsXKneO2?=
 =?us-ascii?Q?g6uw2smQbHb9V7aWx9zxSeEKlBYahGksamrCE9QaNrbTpyzVkVt1eIZWoWlC?=
 =?us-ascii?Q?YLZ5w4ZSnvpuzobygRWqSjDo/fcE53fVpnAicV1O59Wd1D947X8q4G5f3/33?=
 =?us-ascii?Q?AsCAioOo4Okg9DmThq0z24d8Qo8PjjjvhDi9eXhhuulUTDETo1TObqvHWf0Q?=
 =?us-ascii?Q?UkN8ddJNJRgsBdOZicVPyGZ4xY7glZwe2D/KeXJakB4H6epTXVLKmPBxPzYG?=
 =?us-ascii?Q?C8gFTRVs66HFbmAw2e7Au46qW/sIpCV7+D+wvbeFJVrDNzDamZTnvKf13WNc?=
 =?us-ascii?Q?frDKL0lz55ZNbc0/l6XP048HkcoK4t6KQk68KJ5AwD2i1rUdL0aaSGLQmoFn?=
 =?us-ascii?Q?DhCW/yr3OMPR1WSThyPt88/60Sdk36z5xnsXWX7g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ee2b8b-472f-4dbb-f01b-08dbf7ec892f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 12:52:29.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyO7wup2XYe/zFpHlApyU/sd26boc4ExyINYEP2fl9w7Vmo2GWyvYLCQx1cUIkuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 06:27:14AM +0100, Greg Kroah-Hartman wrote:

> When they do that, they break the reason why the distro/vendor decided
> to prevent access to debugfs in the first place, making the whole system
> insecure again!

Maybe others have, be we did not!

In fact Saeed addresses this explicitly in the cover letter:

 Historically a userspace program was used that accessed the PCI register
 and config space directly through /sys/bus/pci/.../XXX and could operate
 these debugging interfaces in parallel with the running driver.
 This approach is incompatible with secure boot and kernel lockdown so this
 driver provides a secure and restricted interface to that.

We did a lot of work here to build an interface that is compatible
with the security principles of lockdown. This work is embodied by the
new FW bit MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES which causes the FW to
run these RPCs in a security context that is compatible with lockdown.

The overall philosophical architecture is similar to the NVMe vendor
command channel which is also a way to deliver opaque RPCs to a device
FW and is considered lockdown compatible.

This series is not some insecure attempt to bypass lockdown like you
may have seen in Android. mlx5 is the driver for the most popular high
speed NIC in the world. Our customers take security seriously, and we
take security seriously.

Jason
