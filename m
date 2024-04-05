Return-Path: <linux-kernel+bounces-132899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E50899BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DCD1C2233D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770616C689;
	Fri,  5 Apr 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRxJqKiK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2110.outbound.protection.outlook.com [40.107.223.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D16132B;
	Fri,  5 Apr 2024 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316067; cv=fail; b=Y2ztEpEN0m7tfhTJG8K8KCdlMYptkoXv7DiYwWMlHJcUHNbVdJH7tL7xb55v2Y8JKXlkosQOvdMlxi0FLpNWqP7CK+9PAHuKjQoegAWMHAbPE2zn+G7Qa8HuDpJ3GukISmzuNAE5Mh1r2PjpLdou/wuBuqrkyl4FK91H+1a7enk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316067; c=relaxed/simple;
	bh=yW8YE/CZ4q2Zr/Qw+w08Y5ateG0LommnC5Zgd6uZpYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K87DUKX0Egjbpr9QpaeTxVPw9J1wA5P6aOI18kA4VVLC1dmhLn0dyN0n29ioi2jsNii0yOPS3TE2d+u4EK/oLjHK+0NXo7ayTH4LqyCy8XPoTkYQDlhJb1d4NqwAqkK8vyL6mEb3tjF6Lqleihc2pLLdq4HeCnyZ2d6V9CzzKcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRxJqKiK; arc=fail smtp.client-ip=40.107.223.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ93xoCnPJTyGzNxhjVKdGxGU04UEpu5rUs6OWnWwS92vuuKjWD4nha7jBvtCE3dIlfX/uVkKl4yAEskfV0I865G+hw6Y2VaK0kPY/DRecfqXIuO8/qk5qE4tGN08rzqEImCgUwbmQl5+L4Nf91btBNzMZ0pg6fCtx4v3bURY72umWRT03//oCMbgpWnZ/NJmzjUp1XkM0KymsWNT+VKj3Vbl+Tg/QilcbqaNQa02cW5QiZ0FNXR1UoKt3P4b1OkIaltV59jV66Hc4iRdURpWBGiTyXUEABxJ1N3H5ZKqT91q4eho/cLPHkz4ujmrlC6RdV7bA4bJ/N4Nr35uIC+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1S3VXHwVlfW+auHgPF8kqI8g3gk7l+GKUuqhBJ8G9E=;
 b=SAzYeGMC9cSCzJAcTO3AMzKfgGq0Uld0JSN2ro7pFfuWZdloNwCooi6QwOz02qdMxBT6enKFsQH5dIOaZFJT2/i2SBO0Lx2yvJlguQyN94xFSNcJxzG0eq8fyy5kvXwu0mq35KtRdenwzs3+gPlCDGVWBstlUwsf4n7O6RtMLNuL3R4lWxKxuZiPexBG9aA5GZ11RpTNYZcT9Bv1RqEID3xeD0hH4Hg+/95JjChNzF/VduiVgS8AH6McfCl1Ded7kg7FtdvaMj0cEpaBlzJDtb4z2hxqen+bdqV55mWmj+5A1RfnCxql3jLB6ypzQswWqO0z6kAL0tH5jN8ISnn8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1S3VXHwVlfW+auHgPF8kqI8g3gk7l+GKUuqhBJ8G9E=;
 b=kRxJqKiKJdp8Z+bBGA1mKJa0Gys4nj+MmcElcEr/XExq3GqawchYpTPOu4qfzJ5nrJIf2TWtZfw+Dsl7DWpAF8i/zCMboZoz3M4o6E1LRi1ixdYNZkwwbsu5wuIyKacuV8JDOgQHcvseyHdW9+7sgyemlm1FEMmvNRnZBr0F6DO8A/mTiDilCUFp21QbBmcKb+y4ydjNTki9mrt6r0t0QaJUMauhqLxyqgsYIvJqlkicUzgQMRSve931x0+kcPPi5Ti3LRbUiOykO1R2SxRRxIIwyXXuB8RVAzvEoL13Ipgeb2WzCP/GDlLP0u9J3XHfVQrtXrLnyt7Lrark8FpJjg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 11:21:02 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 11:21:01 +0000
Date: Fri, 5 Apr 2024 08:21:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240405112100.GC5383@nvidia.com>
References: <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <20240404183305.GM1723999@nvidia.com>
 <1bb526d4-31ac-b25d-e494-ef5adbaef7ac@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb526d4-31ac-b25d-e494-ef5adbaef7ac@gmail.com>
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB6326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXmOmmzmbV5Cg067xAOvLJSzuvnSRgeT2lf93gJFqeAOt8MzrrEa3SJgYuFJ/SHjRmvq1nCIiiwYvxUldcAJU0D5QZcKndZw0V+t27lx/VbbynQkJBXbMX7Tsvx5aoR5R/zLrIu8b+pz8vn0EQJuyalpALG0ddDiUVCI2TvndWbNh/PizU4UVyie2sz39EHPT7gJqBVYVc08km8+kzktimnCMPSJ1xYt/4SFfirsPD8i1bMH1/Rl3ES5VHwJzl9mcmdQcqXMnEuojJXIj86e1EqhC84Z/pdNpZhNCpB7afffq8Zcr9EBmWZRDALkXVfNBfJK4TQ2ob8JoY0u/nHYb6K16JRzltK6Z3oZCAtTCbTj7LR+hTzchetNH1UrvGiGBTA3YZ+VoqcCIkxO0nUVwgjp2w2UET0UtOedxwo1IQwzCMdN8c5/RVW7rLz69a/HVszScRXJLyulasB6Vtb3YbNE4ROWUj2pzl23MIGEcKhwUU97f/P4GNBVJq462ykfFON3X8cktnZOfceiTAIDh7p3dkdJfEyUbWBqvTFeHd+3i9iAOtfUcvO30kJvJ8kZUoMuHtJv5OohDschyJuGen2dcgt6G74OlVdZi0TCjCcBaKMblIzRiJmIPLZsJaRfQZo0Ll83SVQKTCJuuYuAM5lAqRHc6n6a68W8d2hNTJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TjW37yaJ0LMtZYR6GfRlYlNhuU4KjGGZzigd0TOfJ43/m43J6HdzGcUu0C8d?=
 =?us-ascii?Q?scaFdn74TdX+tbUDSzvo1YkoOaHF6dHpK/TNO1yPBxphfoLink5xgDO6Ry78?=
 =?us-ascii?Q?bXIBrX5UIbs2YW7js2t7nu300uwubhIF4Fiw9rBXMBOrBMoOBGMUViam5S5r?=
 =?us-ascii?Q?5R9/EDghuYBiVK7Nifx/SORoTdibrCGfB5Uhr26018t/wC8i7GKi5VL2PiM/?=
 =?us-ascii?Q?os77wKuxnx5fDDCAsngMlYGs4UJNZYx2qhJh7mKRNF0bbTh3SZRmWSmjfJUg?=
 =?us-ascii?Q?8pZz6TdiHHjbf6EIROYkRRoOWejMzU0ybJY37KGYTsO/FB6ftE6jKN8PGkkh?=
 =?us-ascii?Q?4Kr3UFZD4zl3+RM6IPWNgwg9ArY+rDPUKPfgYkxVz37ype47iD53RpcDyXDO?=
 =?us-ascii?Q?X1VKhhO251o8IxsyUEAGOAiBlG6m5VCNZvLjeUAcpQWosMsqkHKKmIPLfw5J?=
 =?us-ascii?Q?dXexRhyn1fYNO7igLc8jvlTX3IsSSEJGMvhgp6M1sbGth0+u32J6rb95C/lB?=
 =?us-ascii?Q?x/rnC9Wbm80OJiDtA3s2z0UiVKiSSdPI6l2DXQUevcRY41rQRFGeUu3fC6hy?=
 =?us-ascii?Q?ehTc/16FfqJ80gPhSPm4RBy6iv2AQwUYdSBIFTLQgR8jxKQpJW000VsDwW3K?=
 =?us-ascii?Q?VKcooIIKcYQrjPrX3EpdEretVJUb74148yNkMn/MWho12kVAfA362IFMZLTa?=
 =?us-ascii?Q?SKAU2kVk/vrLKY89qAneJew5fdaZ4xyRI4zblIiOKOVXPiepMDxhqBhXlngY?=
 =?us-ascii?Q?FmzD5u/WvtbsbWvkuIgSpxo/03QKT6nzZ+4+WoRTTCjBNgYjJk4G+Kh4JmmY?=
 =?us-ascii?Q?2RqiQZJkiCvaPNSqRTMw/xS1+OEFjslJjrPthG1XIWGrmhc20jLug7nsFkMY?=
 =?us-ascii?Q?1U2jRmZXezwsSIyYevTVSPKo4RRqOLKGeCQ3H972uR3uJc9hUPEqmqSYxAzv?=
 =?us-ascii?Q?um8EqLTNdSOP8+zCpn9gBtQnOmXDaO0DbQLgl7GuYoEglVpOK8QmDKxtTlnW?=
 =?us-ascii?Q?ohF9Oiy0YyV77qfFgkiD3KgVkopzl41kFIAXO9YByuAlkPP9SzwB/Mq4VI1V?=
 =?us-ascii?Q?Uo9fCjpdMsp+TfIfc2h9uoSxFbd02/yNwz78mcKjv2U08xunqZek7wofwGOR?=
 =?us-ascii?Q?22UfllV4zNsx/+Uip+uy4i1a8OT87+/sfqSzbkiVy2H03llvKMFFoJlP5S+e?=
 =?us-ascii?Q?DX36sdOKcc0aKTjwvwQqFaP75R88rI/13Vm2ebKoPBOO7eSPWfqkmQzJUKha?=
 =?us-ascii?Q?I2YFo5wViCnBTLbcpolJqdshi1ZJ5slSQi4+x39T9UXVXjlYZNVbSjiXYwrn?=
 =?us-ascii?Q?CcOHqYYiE50nk2WyFKAUzDZM9VQ/TDbkT9osLNXWVn1z1a3iGaAMYN7cMypO?=
 =?us-ascii?Q?ze8MkaMrNZshKSlvjebdDKoHpbDjZN8yQvyuME0FAz0INGJTMl0xLI1FJTJ4?=
 =?us-ascii?Q?sKefKGNF73as7Neo2cyKYJxo4Q5zPbuiEo7MqPXmwP56mm2RThhzoqJYLlhw?=
 =?us-ascii?Q?GdBTxyM0kJeDPFqsvJ3V4mKSctUc+LUlkQPA6ojCJT1+eqoKyORowbe69+OJ?=
 =?us-ascii?Q?L3C4oZ0bMVpZpr/Wosw/CpFlKteDN6LyI9gU4ZMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3755c69f-14bf-4ea2-98f0-08dc556279a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 11:21:01.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HnlcdCu3IfSbRfgilZq8SKWvf6abH8W9QjehwXdAGkqH3RaQ5xthU6hYjI5gUz/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

On Thu, Apr 04, 2024 at 08:31:24PM +0100, Edward Cree wrote:
> > of in the factory looses the "implied engineering benefits of open
> > source".
> 
> You're looking at the wrong point on the causal graph.
> Whether you apply the hacks in the factory or at runtime, their hacky
>  design is what prevents them from having the benefits of open source
>  (because those benefits consist of a development process that weeds
>  out hacks and bad design).

Oh please. They are not hacks, you are inventing this idea entirely
out of thin air based on your own lack of detailed knowledge or
personal aesthetic preferences.

> > Overreach. The job of the kernel maintainer is to review the driver
> > software, not the device design.
> 
> Really? [1]

Yep. TOEs are supported in the RDMA stack.

The only thing the kernel community decided was that a TOE cannot be
accessed using the socket API, the HW is still supported.

> But strangely, there are people out there who trust the upstream process
>  to ensure quality/security/etc. more than they trust vendors and their
>  "oh don't worry, the device will enforce security scopes on these raw
>  commands from userspace" magic firmware blobs.

Upstream Linux community has already decided trusting firwmare is
acceptable. I gave many examples in the fwctl document if you'd care
to understand it.

And of course we get the usual garbage solution "oh just fork linux"
which *completely misses the point* of what Linux really is or what
the community is fundamentally seeking to achieve.

> What you are asking for here is a special exemption to all those
>  requirements and security measures because "just trust me bro".

Actually no, fwctl is following accepted kernel design principles with
many prior examples.

Jason

