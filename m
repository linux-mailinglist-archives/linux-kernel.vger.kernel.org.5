Return-Path: <linux-kernel+bounces-158510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E928B217A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33582863B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0C12BF2B;
	Thu, 25 Apr 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMcWQxVA"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95371BF40;
	Thu, 25 Apr 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047506; cv=fail; b=Wgdglb1rHGO+UxUO1DVgggu7gW+mVKdF/0N50ZJMdCifgCVWDEnSoxK3MGzYcbQXfnfimsdiOCX95FVqT1Kns5sprpg7TcJonB6T3Faevs/v40jLAl7aVr1KOMO4dSUtL9lVd6coDlYBW0E7qeIz5RPYCAoL3bmHWlTjiRJ+F+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047506; c=relaxed/simple;
	bh=Vyegn/YzQs0aPpR1g2oyUy2MCtk4/mSJbouEVgpOHCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qqVwYhyVCCc6rqwTDl0L2+n7VWa2JgJQbIRfNexmKH8xe0zDc87ruCd9YZY+kUBK/2GuDqGAmN/9aISKLN+yV0N2KZh9gl5/FSMnqfsv4xE5fTAxTwFZRUt+jvv365pMeCE7MGf1aJnTb3O4pgKvBIWbjKB2wKST9UeUv4o2jac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMcWQxVA; arc=fail smtp.client-ip=40.107.14.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWjbjo3a7KS8EwukEnvEGhImKpNZ8zlN47gsHIHvzlIxKkHizUP8hHia+h73FxyKT95bfUBxUg3/rnuexfdTPNTf8YOIzpfoFuAhuNv15PGB7GJfnvgVAubaVaEmnYEWFKam8BLwTNRiMayct4wBSFdLazdfg6yJw7R7Qk+qK7+jd5CXaR6cuYeAxvIwprfEYWma5oW/Vmcq0TvgC78+7DiA1F1dnE1/CU+4ASxLgbLSgvguXDKpzDsbEPJ0siZ9rCcOlXAt/bKTNvfwd7bdyadxkFl8l6E3egQP35e0W4mkv2vZQcsASnsvQUhaKfScMUZygaw+XclayVN7LVTU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqVJdH6YVk2udrKyZzNWD4LX4T+lYRIIb4iI+OKokow=;
 b=f2ZIv4k3aMetnC6lyKH9sQuNQGxaHcLzqoGUTAFjfQNISK8P61OcduOJz2CWWIaaNpFyUUGZ0yPunOQScBdC0tm6dKNddWqrRrlVGqrSvv7zkD+1sHCTWeD/4Em56ygDuCnCk55MZ7QFiBIZYnrYY403Sudbp2wO5VPaao1Fu2jAIjmpiSmbv7ZQ8bGuyEr7SH8JUqqTfsUanf37fdzqpyc6n1IK0dC5zeFHvbz1ndysQ/x1Zw1YbFOLr62GiX7wk3mwtfIBRWHEzb3jnqE1ml57h1UvPqcfSjw7JqwZ7czAmQQrw1i07m7ybOeLSyCYSFmF8e0PBhPK9li+av21GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqVJdH6YVk2udrKyZzNWD4LX4T+lYRIIb4iI+OKokow=;
 b=XMcWQxVA1oSRbezOeWK5Hk029YId2cHtz8sMepUBVb49KWYQfpOcy3va3q1fo6Tp/hwkrKWS0clj+KRiz+QD7twyC4HcNlMOTqzOMGoWj4rrt8dPG4Ho2MojdDLe4guaD1jmyogGeUffw3AXYo8vusx7vapyRwcZoOgjiHGmGc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DUZPR04MB9870.eurprd04.prod.outlook.com (2603:10a6:10:4d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:18:22 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::533f:2ce5:aa5:4449]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::533f:2ce5:aa5:4449%3]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 12:18:21 +0000
Date: Thu, 25 Apr 2024 15:18:17 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
	linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <20240425121817.r34tpatcs7qqe4oi@skbuf>
References: <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
 <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
 <20240118012714.gzgmfwzb6tuuyofs@skbuf>
 <e311f2c9-f396-41ae-b78b-7bf8efafe066@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e311f2c9-f396-41ae-b78b-7bf8efafe066@ti.com>
X-ClientProxiedBy: AS4P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::11) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DUZPR04MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: 97baadfd-0e58-49a0-6efe-08dc6521cc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDrf0x2P4u2CkPsyJBY5qTkOLQGPkGjfFRmctn40ONpjDpKNZhKMNSjQlOpp?=
 =?us-ascii?Q?nYu2+ljpJSe807wTFm08yVNBKJdW3OLEgmYqAd982TkeB4o/as8/6+/jKCzd?=
 =?us-ascii?Q?9VgO+LyJL5xoRtJc484FlzUk4SEgWYBEzRdvC8fx+f+bpssISA+TuJWxEUjC?=
 =?us-ascii?Q?zZIk20O87OHdpb5VKEKRG1jaYK3y+fCGldFFn6oMADpgXEqb6H6cwpov9OZz?=
 =?us-ascii?Q?buGQWUEYtE/9og32HenO4EM6toL+iAIx+FFAZWuW4p43OWPWulIQYPYJQJDa?=
 =?us-ascii?Q?av4eKNNMERAAxldi96xZZVzb5gU3QyUgn4QbssppZ86s/Tbg6cfAeaUKjlmD?=
 =?us-ascii?Q?FwPiGLjqbLuFr7OH9uagTIZkUEOOC/lp5O84OINpvdiYnpTG4zXvNXZN4CNf?=
 =?us-ascii?Q?CE66037qLZuq20Rs7FB3UnAAEp4CkFBnSgfzeh6h1ojyy93xkDNyeFTWiqJg?=
 =?us-ascii?Q?Lh+zdoSLBzgR7GZZyydZBaSct1sFcZkr5XVYz3A+E4pBL9FdyMh7+tThGOof?=
 =?us-ascii?Q?g3WRrnnnnRYKLHRjQyqmpaQLcHJ+T5tuZRV6z5TPRGcrqtFJ2GIotvW+qwea?=
 =?us-ascii?Q?1BRfvYtmWJ+RH/NKXrwlpaeiDc5RMPNWF4WK896j64avXYmZ/5c7D1uerP03?=
 =?us-ascii?Q?jtOHDVUXiOta9ofxZPt4YyaRl0n3ptHW/WNFRZ5ITovofEgVoJcgmAZiVym/?=
 =?us-ascii?Q?Hc1YSHDG1E2R03LIGSJtIlHuHoxBY0dBS6XnRVtVrJICuAWkK8qrOqyaYObA?=
 =?us-ascii?Q?FRrwlas6rGCKm9bhyfgsicgk5t1BAWwIaYfRx5kX2F16Ap2UvceDj3WKJubb?=
 =?us-ascii?Q?pSdErkvWJEgBw5yooh7+lAIsH2vD5z7t/5SYZmIWbuRGfYji3PBDyTp9rJpH?=
 =?us-ascii?Q?dhDDuhPzOULB2+SG2h8WwtWBXXPhVBqbvTz93bM+A0qtqO70+EdLlu/Q9F92?=
 =?us-ascii?Q?STwC+3Pp6a0ylSzynSDK4bXTWvMqAtfXdYVns1uc4qHIG0prCZu02JnRkdh1?=
 =?us-ascii?Q?fTvyJ0ix2uEJtd3/Nz3TENpZzzYC9t0ooYeT+Ln6Ivzkk/o3quj6nYVMbCZK?=
 =?us-ascii?Q?wxytdIPtuR9SkRW3e9fVd9JWIAcU12LWgklwW81Q9Pg58+cPkh02blSpfvrb?=
 =?us-ascii?Q?CKPIdWjE26F87SVH/omWCnYE1EiHbp+tkg1CVMOG3hJar3PgfSDUJoyd6jNl?=
 =?us-ascii?Q?rRrBvawvgH+a6F5py0TSt4/P265+JYCIm7g5sanzRQzvsYUSOz6Pj4kpFIyM?=
 =?us-ascii?Q?WKiq/tyHLZ7H1GY3ttbuOtsMsd/OSiY4ofyDdm4+yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AusDq/2wohfyMrAay3Kkx2Wwt0i2xbDGyCI7YgU3bbfH/pS3SG+KfiatK5V?=
 =?us-ascii?Q?oxGNUgtj064MA2+LG9rfWl9D4nK/LHBlcmF7WuSAPYKVo4qbLb9951j8FzPr?=
 =?us-ascii?Q?WqacSOCzELC0FMPaw1rsBTynPCrUTPNRUxLOnLUwGI9mggD0gSmyRvlo4u7x?=
 =?us-ascii?Q?r6fANoyBPn/EX5jxGZsUZswJFq789dsf5rQk0ClV5TsupUcf2STFeTgxTw5G?=
 =?us-ascii?Q?7c4sfnpCbw7NEK2PAQlqs2CVzEUWlQSgkR1BFGc7khEm5G9bWH/3R1a5/4kD?=
 =?us-ascii?Q?IFUSNzn0mv5icYOJP3kycnGDrUlHE09IFugAeYSHEpaqjOLQ6daf75LX52YZ?=
 =?us-ascii?Q?ZVUJ5zz8rr2od4ZIKtnqBMkSbYjWBOdmlGspuq9JLm7v782oMP4sYYFiazxy?=
 =?us-ascii?Q?n1RT2Rk51sLgAAs68t+/pYNBMCmasjWZGKKvpYoN9gcqSCxWz5ofDH89rzj3?=
 =?us-ascii?Q?whlfR3IHaUIu/jKzXKKAmy8bMLw+GyHassdXYhHPXhou/vubthN1U71kcvwL?=
 =?us-ascii?Q?9MQcMIOc2Q7U+QXzZR12um8WiuTq/eMdm1AxnBu610FjKxPCY53tcdXpY/PU?=
 =?us-ascii?Q?lml4odBooSi6muKMSpUCtH7NvglvFZZrvOLbpNYWF24I2QPsg2kH2MM7tymP?=
 =?us-ascii?Q?hb9G92+hWS24gusxZjo0vWVZqxD/FJGqtQ9SmAtUyTZAVzlFNhxHosVI2ukP?=
 =?us-ascii?Q?+I+GyOAjfPHq++eext2u4gIBWJ2upwmnlhq2WWYH+8kTgS3n04oXtZgC/5tj?=
 =?us-ascii?Q?2rIwoPiLYhqVACxDdPjqKyO5i0iBHVrlKK78VUDSqyrvr98RY5RgXCxQCDqF?=
 =?us-ascii?Q?oEfrTCTNeM4li4pow1rGaUPe3MjgWbqBSWTMSpEIMbdwVqCLHhLiWsAeem0x?=
 =?us-ascii?Q?b4vr0UtZdEytL3r6vAarR5cVJfO+iWBkkWcDQuTi4rlwn/Q/KqLoplQUlglJ?=
 =?us-ascii?Q?B6vS+bw77Tw52qp8gDoM5m+DrSTDRbaGlhQ+zsRpFvDhKc2tL7BZn/NWZu23?=
 =?us-ascii?Q?wcW9Ak7/hn66ZYW3a8oZyBhznncBqoZueZCHWbWedA899SNhqInlR6P8m3YY?=
 =?us-ascii?Q?z6yx8L9jm4C51F5+gw6i0klXUcP4hwjjjE+dITJmIoTSC9ZEgMphfKt78IiN?=
 =?us-ascii?Q?b/10U4r1XQxkHzBznuOtamYfQcs731aXNZoAR4lXfRYvWyJOkJL2pG0KACEn?=
 =?us-ascii?Q?mE10DgEh1Kdpc/4250l87jcmf30jSvDpVx2SWus+dwpwtNV79cs5DCWf4Gd1?=
 =?us-ascii?Q?0/EP04XbdeadoIIXffNg1wciWmQPxfRWeuesPyiS28res8dqNnzuEYt2GpFR?=
 =?us-ascii?Q?AhiNE0VJF9+JCKU7PuxobHeze7mqwihro0MmyLs7e/R9oZnhUoNwoX6/w8Lh?=
 =?us-ascii?Q?9hYHIbJ1t7y8N9j516jcUQ//36iwfWrzYDoy22vIOQ2JOTQxERWVGDw8/r5R?=
 =?us-ascii?Q?Y0gKb5Yif9NiBZXrQTLL3676jHxJJGfr0w6LFY710a5hDcXBgqUpPXY+B0H3?=
 =?us-ascii?Q?kLi57XG+BTDd2ReNm4gZY4xnxZNt3GHZIvYBMqyXWk9TzUy7DaBzfGKHP8WP?=
 =?us-ascii?Q?LQUqPlFiZzx5q/vZs+tz2g5OE4MyBLaP8KpWWvnAG5FnmaFNlibasE/554HW?=
 =?us-ascii?Q?oN/9+7PWIFAUxZON9C4VWHE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97baadfd-0e58-49a0-6efe-08dc6521cc38
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:18:21.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbksYjLBGFVxqo/czDPshU9R8601i/r12ztXsnON+/FGe0Zkz1OGrpwi7GA9on3WgUeAwX0bdV7RKnkdQWqfhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9870

On Thu, Apr 25, 2024 at 05:27:03PM +0530, MD Danish Anwar wrote:
> On 18/01/24 6:57 am, Vladimir Oltean wrote:
> > On Mon, Jan 15, 2024 at 12:24:12PM +0530, MD Danish Anwar wrote:
> >>> I believe the intention is for this code to be run before any taprio
> >>> offload is added, correct? But it is possible for the user to add an
> >>
> >> Yes, the intention here is to run this code before any taprio offload is
> >> added.
> > 
> > Then it is misplaced?
> > 
> 
> Where should I move it then? Perhaps to end of prueth_probe()?
> If this is moved to prueth_probe() then it will mean it's always called.
> If user adds an offloaded Qdisc even while the netdev has not yet been
> brought up, it will not result into any error

Sorry, I just do not have the free time to dig up an email thread from January.
My feedback was that the network stack expects that a tc qdisc can be
programmed even while the netdev is down, and it is expected that the
offload survives even an up-down cycle, link speed changes, etc. Please
use your best judgement on how to accomplish that in the next version.

> >>>> +
> >>>> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
> >>>
> >>> Details? Doesn't this make the phase alignment of the schedule diverge
> >>> from what the user expects?
> >>
> >> 4ns is needed to compensate for IEP wraparound time. IEP is the clock
> >> used by ICSSG driver. IEP tick is 4ns and we adjust this 4ns whenever
> >> calculating cycle_time. You may refer to [1] for details on IEP driver.
> > 
> > What is understood by "IEP wraparound time"? Its time wraps around what?
> 
> IEP clock runs at 250 MHz, 1 tick of IEP clock = NSEC_PER_SEC /
> iep->refclk_freq i.e. 1000000000 / 250000000 = 4ns.
> 
> Thus 1 tick of IEP clock is 4ns.
> 
> > It wraps around exactly once every taprio cycle of each port and that's
> > why the cycle-time is compensated, or how does that work?
> > 
> 
> Yes, it wraps around exactly once every taprio cycle and to compensate
> for that we adjust 4ns. Instead of hardcoding I will use a varaible here.
> 
> It is a hardware errata but it is not public yet.

Please leave the relevant details for the compensation workaround in a
comment, even if you do not have a number for the erratum. Many eyes
will be on this code when engineers try to synchronize the port using
PTP and measure the timestamps of scheduled traffic, to compare them
with the expectation.

