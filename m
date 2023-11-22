Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248947F4FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjKVSeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjKVSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:34:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577A197;
        Wed, 22 Nov 2023 10:34:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaDepRrKSatkbP7lGe4wvxw6H4f80OZDj8AvU/U2unDujwuHIbmk+YTKPoIDIzAKGlNPeqwYzPnirEYlGXRTS41QIO/J2OH02PZVZARsLY7XuZMtsMrfQ9vSnE2Shwz1pcXR7yQ3CbVcQ9Hu5xtHOtGXo5T/vf4CIWBzZRiC9nl4TpOC2T33hUY5PBMXziG0vqiTue21TVaeya5NDEJNU40X0DBUS1mcpXnIXpQOgyDUJjf8kAew6ohBy9ea03Se6rcBLlNtXnBVSC/ogAfeIZbsk+5zXcm1BWcdd9wIa8KZ6Xa9pg9baTHhDBB3WTkaXTkvhJC9wI41Y2BQiQ9BWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIZBvDm17URAfqmu/ONCPQMqb+iziDA8Zn42KXNlYaQ=;
 b=WbHlGN2/RGP8cZA53/1R3ckHhOQDmUARuFkDV3ic6TPSj1D2Hc0+furb2FJwzquaRFklH32/KhknKN84HON0HbdcJ0jfi+TNzOGLEWWH7aWSFNylY8ufdcxjFAO6FjvgJMALxk+Xd6UuDQOtxTMm72ChCQLshZqt1gtEw3tbG4Z6dfbTmMXKo9X0cMT1u2kmN7hE1ULQS6QWpegxiyj5gqAkUVd6zHRifRMCvgZgVFfYlYZISGoXr73dfkf4lWf7zI1XrSsd+O2dDW7rklyyEY6SiPz8eUNCfw9rctfIotbu03zmU8W3DhLipzLtIYsQaBmzHHVzXfQYJYfcttoLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIZBvDm17URAfqmu/ONCPQMqb+iziDA8Zn42KXNlYaQ=;
 b=NchDOCD6RFEH/FtzHFh+gWmh8BjVjBDP2TdFgfDjHoc2vm7DjJdnXpasuNLvIRQXVT6CDl4xIcEpmV9i+m7+YVZ8Z0dpyVwjSskEyWHru9fmKIVXCYZRH4UvOo8bZYWVUYv6u9XVqVa4addWE/F/niQwDaMqkl/+OT+01saN8EmYKDjbE+xYOFWkl1T0IkBDpRpTbUS8gnU76sf/tqvbDR6iHMht/3J4IJwXzZ4WqnA2bd70jHax04NRmD2WvMG5bYczUzY8YgxX09muwiyhIGH+6SvcuYn5m+BhI382gWzK9UTwkuBaEENr0W3AcPk9LCuAsL8jTX6TYrCjI37vfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 18:34:06 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::44b4:6f7e:da62:fad4]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::44b4:6f7e:da62:fad4%3]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 18:34:06 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v4 1/1] ptp: clockmatrix: support 32-bit
 address space
References: <MW5PR03MB693280FDB441C89906BE044BA0B1A@MW5PR03MB6932.namprd03.prod.outlook.com>
Date:   Wed, 22 Nov 2023 10:33:50 -0800
In-Reply-To: <MW5PR03MB693280FDB441C89906BE044BA0B1A@MW5PR03MB6932.namprd03.prod.outlook.com>
        (Min Li's message of "Wed, 15 Nov 2023 10:10:53 -0500")
Message-ID: <87r0khocxd.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8aff1c-dc1f-4268-db93-08dbeb899ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xhvu32TEbF+kBmkHQKp5UMpRNtNz7OCqhH5FXihs0uaC0ejJWaqop3QBxCzvmEKyvMxM+y2Ckznt35ncpzOENRGKRMJYZ+7pANtMgTmqw2V0mxonLAv7KfxVN9yvb8Q/C2LkraQiBc2S0M5cdB0aUBB5dB/8u4ICdTqfa4krUmRvyRD0kXa6pByYDyVi3mHaxqCtgBcLXrnjVkcIv/MoFfDXd+qf3O91CWHkuO8bCB0DHvkbgNL2GkB7yAYyz/XDWPxRC+4jOukpy7Z2RczL/XbyGPr3DLB6MR7iExP0hMM9Rq5wx9/hsLuBVPOo/Km14YYqTs/Idtd+4qKwgaLwmvzP4hq3ZjyXDL2VisXUi8jDINGZ7sLHbhQGeqFrpIJZ+hbJOoN3JHQyri3eMVhGb0HHrf6OO66H3Xe+AHolVzfqHbjwSUZqJFWvyHkXvg1CRDXxbuyydB8e1FndPduOzP4qH3ITcUFlpq8f+SOKOUhv6Sful0auyfPfeAk/FJzP6o9gH/hWp6w51B/t8qXzJTnN6Qe9TYwPyg5q+S4SPSBkmDGtUEMMnmTZBnENIVdY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(6666004)(4326008)(6506007)(86362001)(5660300002)(8936002)(45080400002)(2906002)(26005)(66476007)(66556008)(38100700002)(66946007)(36756003)(478600001)(83380400001)(6512007)(6486002)(41300700001)(316002)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUjhsiYmLOYaMVpo8mBOJyqNJT/4hNLdFrrFT4ifi4YAVtMQ/jBj6vTIwuO1?=
 =?us-ascii?Q?mDJyB34Hl+5JBd7t15p5IpxH18JNyf2rIgKvIoU7r+Nadk5X/Lribsx6b/Vn?=
 =?us-ascii?Q?zKI5jwWK5Q8kbGBGXryZGRALi6uqI9jeUENyQSxsV5e/Y9LBfLd8UYuclBpE?=
 =?us-ascii?Q?j0PXTQjMNkbgKoIj/KCI3rgi3yrkrDvdF8UYngXEvEZQuJ6BPQOxgA3UOptz?=
 =?us-ascii?Q?BYuxMHKNIVSWXCvRE8GS1ZEb1QkCx79/06V1X8JzHcKTsYggkLk0alyraZfd?=
 =?us-ascii?Q?bAW7QG/2qw4BlMrRjlUUJD3fL4jtF1p/9fhoR2q3AakKzaz+ro0bqtpcGN3m?=
 =?us-ascii?Q?TS2jnhUMoNV+E+v6HCb2azvnxqUR5RsC4y0GHQTH2nP+M69WHcu/mc3Bw469?=
 =?us-ascii?Q?2Uf0J+6UwNScK9xm9kF3puCji/oRzo3+WTWAQKTGDbhcCX177dDk2YMaL9Iw?=
 =?us-ascii?Q?wOjkEiJDwWxIvHcMNXJByDwGwP02r4vjbQA/KKob3c41r87pxDIIUCTG5R7s?=
 =?us-ascii?Q?OIi1z1Zs+uM64ppXSnjRw0HHBwJiXnIHxlvHyzO9+BB+C2QFgjLujPjkJNbd?=
 =?us-ascii?Q?YKBwZQHIqKklE/8Fi5EpgbUovU79pnb64EW4DedsuWe/f71CX5hzjbPXUIOZ?=
 =?us-ascii?Q?QyGXn/i9UxMg+iWoJNRkdbOAGkOuzMWmDc2HJHzudufMasOgtfIcddxthIp1?=
 =?us-ascii?Q?qZFnmm/SISKP82Nz3m8cje9wrkxwlcjsaS6rDbFFHJaA9zgKR64iRq9qelP/?=
 =?us-ascii?Q?qYIgTTu/rLLCp5hXRtTIfOowHa1rvjM7Swi9IHs0IDdhppIy1MBA8Z0daB7w?=
 =?us-ascii?Q?HiSFl6ENFEHfc0WmXdnBANEt6aWaALPQmSpWZl5XpOgCQN582bJosaRSGkVQ?=
 =?us-ascii?Q?v+65PwKmOWQegv8gjTR+oiGXic7TOwMp+KVr0rBX7b2KW2JpE8NBMpZYFt/d?=
 =?us-ascii?Q?qkhVKiltlecnzX9pk3+JGnkocnpSHN20FksFquqHQzWFzv6MAdgpz1LNe0YH?=
 =?us-ascii?Q?6OptSdySPaBL+hr3R66Zi4tQWYUkx1oyHOaKTbazIPAut9VzpA3PlLFR8T1T?=
 =?us-ascii?Q?4LnHRqi+rhWGgi8blo7XE2zUSCIXE5odu8V2Atm1oCmU2jfPQ6Dcd/VKpMTp?=
 =?us-ascii?Q?yWqSSV+QC5Es6uDHfZ9fWU3WILYRoGKXn7QSdmjMeX1zRYON11udwntSCwSC?=
 =?us-ascii?Q?h8SZMJ4zPUPA87VrrckJUCLIV4siW+hDiEETkfYXQcOG7SPBnTGn8eauVEWF?=
 =?us-ascii?Q?TXnu/P341ki3rX//50Yx36fz1OpsZhEIT2cg9Owc0jkAwDyR98OwW7QJeq6Z?=
 =?us-ascii?Q?BBie0abVWIPEacFSZhbJp2F2i2/f5M/c4dMdF+CKUftwsZ9+3YxPFDp6dCk5?=
 =?us-ascii?Q?8z9fTkkbrseaq5Dz/68PqWDYIqoULWgDgAeRuPrxeWDy+2HUEultZP6vmaFk?=
 =?us-ascii?Q?m7yKU3zJON1BVUPJRPTqQo9M9R+xOcHoJTs7o5rfKBmhpaqRSmlKrLc4Y8y+?=
 =?us-ascii?Q?OT/utx41DPvTcs0ZkYNcgPIGG2FOfifTP60PRh4BSh++mXt7iYMkseB8rZVE?=
 =?us-ascii?Q?uxjTr1+U+KZEoq67L7p4VWY+OmJd45Pc5IFWsMMulKlhiHMos8YWXcjyOlXC?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8aff1c-dc1f-4268-db93-08dbeb899ba1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 18:34:06.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGPqNjcSDwVxE5VrJUlKdFfOO/cSYViipk0gBoyHzhDuWSFFApWRP0QHBc2uAA1rda5Xx6oJ8k1PCRuqUXlGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov, 2023 10:10:53 -0500 Min Li <lnimi@hotmail.com> wrote:
> From: Min Li <min.li.xe@renesas.com>
>
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
>
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
> - Apply SCSR_ADDR to scrach register in idtcm_load_firmware advised by Simon
> - Apply u32 to base in idtcm_output_enable advised by Simon
> - Correct sync_ctrl0/1 parameter position for idtcm_write advised by Simon
>
>  drivers/ptp/ptp_clockmatrix.c    |  71 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  32 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 331 insertions(+), 314 deletions(-)
>
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..1d5da77502e6 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c

<snip>

> @@ -1705,7 +1720,7 @@ static s32 idtcm_getmaxphase(struct ptp_clock_info *ptp __always_unused)
>  }
>  
>  /*
> - * Internal function for implementing support for write phase offset
> + * Maximum absolute value for write phase offset in picoseconds

This documentation comment is wrong (this is meant for
idtcm_getmaxphase). I think you might be generating patches without
rebasing on the latest net-next tree?

>   *
>   * @channel:  channel
>   * @delta_ns: delta in nanoseconds
> @@ -1717,6 +1732,7 @@ static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  	u8 i;
>  	u8 buf[4] = {0};
>  	s32 phase_50ps;
> +	s64 offset_ps;
>  
>  	if (channel->mode != PTP_PLL_MODE_WRITE_PHASE) {
>  		err = channel->configure_write_phase(channel);
> @@ -1724,7 +1740,8 @@ static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  			return err;
>  	}
>  
> -	phase_50ps = div_s64((s64)delta_ns * 1000, 50);
> +	offset_ps = (s64)delta_ns * 1000;
> +	phase_50ps = div_s64(offset_ps, 50);

Sorry, I am not sure what this change has to do with 32-bit address
space support. Seems like this was introduced due to not rebasing
properly on top of latest changes?

>  
>  	for (i = 0; i < 4; i++) {
>  		buf[i] = phase_50ps & 0xff;

<snip>

--
Thanks,

Rahul Rameshbabu
