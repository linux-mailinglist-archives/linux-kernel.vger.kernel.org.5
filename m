Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9117E5E68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKHTMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjKHTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:12:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE7210A;
        Wed,  8 Nov 2023 11:12:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWeGP6l9jV06wXLb5MpnG7faDmpxveQT3deR7fRwzLalUsfDmagpT7bWdodWv989XvninKsN5iudcNcKEDzK+g/o+TDIv9hqR4eo5XQWBTfBCkOoCcFOqcWh2MTEzfqQVgITYYMY6Yh7QrbJ56FWOw313xg0672f2fDYuHhSgAnvfWPZxp1FviFSZC44AJ4qlSs1Snj8Vthu3LO52KZuyBxBMZQJ7K/OA/kegqU+G8ctATwj6HT9YspoVLOD38bIhSdxevBYpnp/ANk9x4FEvLY/3730Ko4g7ebsbr1+KHY1gomaeGBWz6Z+fPsbluAt575oRgZXekHnMkUrRU/1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G2+oYyCrmyKx8YSRJ7888LYSoUdK6xHvFt8JkngbPQ=;
 b=QMQTrkOuRM+sGKO20HG+b7wQUzdH5rKyZ1n2EnbfMrgtpIp/ZNEgtH00TLtqMqovuAf3IpOT6tBJnsz7s5HP94qgADhH9ypHucufyZhCjqUOBd84HsGm/a/IgrLECiUjrSw/oz4ro7JB1iYPhJwIQuw4jNX4NyzgBkwfyysJQeJqHepgUhWFo6hN0s6AgorJ0xcTh5mhbp0BNFC/Nak6kYYzLUdcshf+thSlICq1EJ81DaiLye1NQUwlNx58E5ygz705tpYbVJiJsBpA1BA1OcMufD+imDnMotSKY4yrq90UN9ln3Ub/ZuRF/UzQh4zzDdKuDzkICPPuyTVYuQeL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G2+oYyCrmyKx8YSRJ7888LYSoUdK6xHvFt8JkngbPQ=;
 b=HrKmRDlV3XJJHF3E8wqHHaw4KraqOJkhvbem1vhN2rBwpENDwCzi4q0XKELXtw0YBZaqQWCQmHTMlIww8TwMGqtI8gTzODgzb9ORMXFJSWtfG2JvXfGSaYMiTwSMPrrxfI5tQI7nB8mJWc3dpJASKUAgl3EnoEiqZ3HI5Y9THuq7Ft8CA7sxcXYMFvk8EmpkgBAudc+BUBDpTD+y6ZMj3TlQdjYEnrpkKXxfl/3RdRNqxayH7MT9LXjSs9VftYuCn/gKEnW2mpBj176RdMUVQRjI3mCIqcaZHpgQb+dGvOD7iqtauOvkqkpXXkQ1rSAXhrqR/VEVup1kr1cWgwtGfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Wed, 8 Nov
 2023 19:12:04 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 19:12:03 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next 1/1] ptp: clockmatrix: support 32-bit address
 space
References: <MW5PR03MB6932FF68AEEF51E83EDDB89CA0A8A@MW5PR03MB6932.namprd03.prod.outlook.com>
Date:   Wed, 08 Nov 2023 11:11:56 -0800
In-Reply-To: <MW5PR03MB6932FF68AEEF51E83EDDB89CA0A8A@MW5PR03MB6932.namprd03.prod.outlook.com>
        (Min Li's message of "Wed, 8 Nov 2023 13:28:30 -0500")
Message-ID: <87r0l0f4ar.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a5c1df-a04b-461f-b6f1-08dbe08e97a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QWF/OwKcwziGYnD/XG9ZHalD7Y7MGGETQ8G6uAuPh1uGbbVEpA+F+VZPO/BokJpcAlBX9/JpAcIXIdrQoOcSp6wBsanu7FqckfGLQIve6JPmh4DneDbyXpaNb9MUuEFEvn8tKh1OhMuSUNQ8Gqfi8CbKsVVKbgcWJTaSsTIFyALLtpbNcptU0globo2cHaj/ZnDmoK/cJwTjYjx7M8Iah6sLVtpP9f4R8FWhPI5BsbWoLuHexjjKFEKIVo8/3YA3fe7mgVG0AOSOUevUeCBPjiaG4IrbgWWPZ1TV10lK5AhvD5cK1VmqTP7cpklXqLP5Jh/VqrGYGLGVKznlApdhFhIPSNPKao2uYDIVlv55TX2For77QKPkds2etukq8AaOIQ/OQnBQNIPvi8D9J73SyUt3Qh1Ejs88M1aL56Rl3oY/Bkmlh1V2CptFpVpPg8b4Pf3cNRrWwMXaqGjarJKL+4ZWQvj4ACXiw2NEUA90+D63lVG+EUudYopXLSKkITe5xskzXmOaC/HVwneOz0jeb9mkG/ClgQ+FyFIvuboPT0V4ED+ZHj8eItVE/hGjf00AfyPT2FPGbA3loOL3QNrA9nnMPkktlLh0xf5sey6BnR+WFVEy8zCrFTfznuZnY7cP6dMIgnELQrLe2gVujFOVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(6512007)(2906002)(316002)(26005)(66476007)(6916009)(6486002)(966005)(66946007)(66556008)(4326008)(5660300002)(478600001)(83380400001)(8676002)(8936002)(41300700001)(86362001)(38100700002)(45080400002)(6506007)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ti3oi3JSz7+7ui77MI4Ofo8HKIZVzdvrjhu2aCoCy+9q/VQUyNNxp6+S/mdh?=
 =?us-ascii?Q?f+08yuDH0zHzmz9gXWo8+riLVmh63pDushfssSuY8mFV6CwUUtF3Bom6KVBF?=
 =?us-ascii?Q?hth7QNgRiSm853RXpY0wmFhyi+LFFZU7j7y626XCC263wMqk2vxHheUf/W1b?=
 =?us-ascii?Q?DJtPkNvYLNIsdjrnQps9/r0h/OdQ4qL8tSIHrJ/dTvpdFgT9KPMgGKFhUa+/?=
 =?us-ascii?Q?34QDOnKHmqkZ+Z0IQRbWK4ePqmg7N6BvDAd7Ps0aQvbSt4JCDZsCJy/qk07O?=
 =?us-ascii?Q?dQw18acygOZviXGmLijxbdndM0XgRs0Pme3Ek4eaLgm/hDBHCA5NPPQHf5Te?=
 =?us-ascii?Q?q3dTg4Flw3S3owHvDUD5TZR/z+bui16c2w8Wb4ajMnBzaXvA5mavlOa//6q1?=
 =?us-ascii?Q?8BYNfxl8TyfTK/we7dsrp+87mf7AG9huvK+1g2tTAMCWFZ+VR5wspWJB2OZM?=
 =?us-ascii?Q?cIaRzyGtsVfOwMKo51r/qtZhlkXkSOzt5uZAEGq4lDUYZXaSZUQPZF21colT?=
 =?us-ascii?Q?IEzyk+9OiWchCrh8n5bUXT6n2v3MM/fk+z5JFmqItFjRWxVrO2GkXNYk6Vly?=
 =?us-ascii?Q?MiBL/+hcDltAhdXwrrzPr7wMvXHpzmGR72E2huQCzHShbGAMq/btMwLl2hXl?=
 =?us-ascii?Q?yRw55CcFJrGBf+QH38334uYq2cBFVoP/Bpn7cb3ScOCa3Be/TqCy5AmrxJNh?=
 =?us-ascii?Q?M8LtoztyDScEm3X/c26zsNonfnv30JQhgKr81l94TYIgeyepuMfNWGML/qpA?=
 =?us-ascii?Q?2WTTxYtzfLxoCGfqfzdAsgYu6JF9L3bY7oBt1bRTP1lSp9azYz3PGwacGpE5?=
 =?us-ascii?Q?7FGiYHyH9Q23CzpvgbkhHpELPZBBXAvxqnqwsFJQgVwTXA/zVzirRyQOKC5b?=
 =?us-ascii?Q?853Ym4cTcf9H8j9PZYDjUsEFZb+3ZyJBySXX/NL67m08gbxvIlmQLgpfay28?=
 =?us-ascii?Q?kxSbR6OzaaMqifHDA1Dr9Ln9OpPy6axN2yPImQL/8bLUePZbPjAZa9/oYoqV?=
 =?us-ascii?Q?Zqg7OxwwB9f5ba/Gu2WWLtSvPo382TevgS//D6/iHi+ivmAxPpE0m2BzVBgf?=
 =?us-ascii?Q?ZR7M6NiDWm2SQt9OKSO2NbyRVR+Z+UlKMiaDVNt8B+a7Q0AFGrU9g7Y4yWQw?=
 =?us-ascii?Q?iR6yisjO/eqtSqMFiR4KjyEGszR2jpGoMwNG040PA8l51b/joLtaY2hIdhvL?=
 =?us-ascii?Q?xlom0SpqpHUIDzVLJJjTHKXkf+7AM+jq4zvnmbC62tsnBoST6WMBVNdt0zzZ?=
 =?us-ascii?Q?df/sT6hdhjkpLOHCPlBraS8rEa9P2ckxh1flqhwGe7BEs8SouKctYF2Ni8C/?=
 =?us-ascii?Q?ZrOuKCKyWpn9QlPKrGoyv/fC8u/YH0cndQU/24rgQ8vtHAifExUpb5r+Debf?=
 =?us-ascii?Q?oOq7Fxcp4lzCmCPIZKp5aNT5Dec5tW+JFSEFtWkiNGD5fuIj7tjgjcZORgu/?=
 =?us-ascii?Q?Zc4ogoIprtNWyl9N6FQ9Y6yph7TYr/cSnO6v0zH1oXoNuw2JuYFAzSzsGea9?=
 =?us-ascii?Q?sYKEEo2AjP15aABbIvnnQteX3q95nyexdyAWPqna7i3bdkGNMOyo0c3wzTNu?=
 =?us-ascii?Q?gAxkbD4pzbuveRoTLss+xxZw5uKiPWpVs1cKDlxODFU2oBC+D1EXeqBYBx13?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a5c1df-a04b-461f-b6f1-08dbe08e97a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:12:03.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5qWq9g5KiS2IofDPqZZjWihAFbyuTvLFvdJHlDav5FtyrHVn8U85QSdCUgE1Gp2V/GX5fMUn08gfuGRSUeFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov, 2023 13:28:30 -0500 Min Li <lnimi@hotmail.com> wrote:
> From: Min Li <min.li.xe@renesas.com>
>
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
>
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/ptp_clockmatrix.c    |  72 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  33 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 340 insertions(+), 307 deletions(-)
>
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..875841892842 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c

<snip>

> @@ -1705,10 +1720,14 @@ static s32 idtcm_getmaxphase(struct ptp_clock_info *ptp __always_unused)
>  }
>  
>  /*
> - * Internal function for implementing support for write phase offset
> + * Maximum absolute value for write phase offset in picoseconds

This logic should be part of getmaxphase rather than adjphase. Due to
the existing implementation of getmaxphase in this driver, the checks
added to the driver in this patch are no longer applicable or reachable
based on the value of MAX_ABS_WRITE_PHASE_PICOSECONDS.

  https://lore.kernel.org/netdev/20230612211500.309075-8-rrameshbabu@nvidia.com/

>   *
>   * @channel:  channel
>   * @delta_ns: delta in nanoseconds
> + *
> + * Destination signed register is 32-bit register in resolution of 50ps
> + *
> + * 0x7fffffff * 50 =  2147483647 * 50 = 107374182350
>   */
>  static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  {
> @@ -1717,6 +1736,7 @@ static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  	u8 i;
>  	u8 buf[4] = {0};
>  	s32 phase_50ps;
> +	s64 offset_ps;
>  
>  	if (channel->mode != PTP_PLL_MODE_WRITE_PHASE) {
>  		err = channel->configure_write_phase(channel);
> @@ -1724,7 +1744,19 @@ static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  			return err;
>  	}
>  
> -	phase_50ps = div_s64((s64)delta_ns * 1000, 50);
> +	offset_ps = (s64)delta_ns * 1000;
> +
> +	/*
> +	 * Check for 32-bit signed max * 50:
> +	 *
> +	 * 0x7fffffff * 50 =  2147483647 * 50 = 107374182350
> +	 */
> +	if (offset_ps > MAX_ABS_WRITE_PHASE_PICOSECONDS)
> +		offset_ps = MAX_ABS_WRITE_PHASE_PICOSECONDS;
> +	else if (offset_ps < -MAX_ABS_WRITE_PHASE_PICOSECONDS)
> +		offset_ps = -MAX_ABS_WRITE_PHASE_PICOSECONDS;
> +
> +	phase_50ps = div_s64(offset_ps, 50);

This logic is unreachable because of idtcm_getmaxphase. Please remove
this hunk. The point of getmaxphase is to standardize the behavior of
what happens when a user passes an adjustment value not supported by a
device rather than letting device drivers define different behaviors for
handling this case.

  https://lore.kernel.org/netdev/20230612211500.309075-6-rrameshbabu@nvidia.com/

>  
>  	for (i = 0; i < 4; i++) {
>  		buf[i] = phase_50ps & 0xff;
> diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
> index 7c17c4f7f573..a0aa88c8a4ab 100644
> --- a/drivers/ptp/ptp_clockmatrix.h
> +++ b/drivers/ptp/ptp_clockmatrix.h
> @@ -19,6 +19,7 @@
>  #define MAX_REF_CLK	(16)
>  
>  #define MAX_ABS_WRITE_PHASE_NANOSECONDS (107374182L)
> +#define MAX_ABS_WRITE_PHASE_PICOSECONDS (107374182350LL)

This macro is not needed due to reasons previously mentioned.

<snip>

--
Thanks,

Rahul Rameshbabu
