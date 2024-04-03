Return-Path: <linux-kernel+bounces-128964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A637D89625A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4136AB24A01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48617BA9;
	Wed,  3 Apr 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="x/ztT7nc"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2136.outbound.protection.outlook.com [40.107.95.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFE14F70;
	Wed,  3 Apr 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110496; cv=fail; b=TkB+gfA6V8CTz/nZRNdP7WBrbEYX8Flaj8OwC29nWKi6xya5O0YTutK7lUc0PHZwnuFqQ5uthnffR0N34ihwWFhQT3Xvwl+zkwBO9GN21BfjekfJGhXDqFAvvqXbaKwORoQyyEMd5edPYYN7EsLuUa2GAQUzj2AFkmjefhjhxrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110496; c=relaxed/simple;
	bh=Ak4Ekmj/D4eJqs4Lx0wNgfb5ckI4WamYeMnTL3cHiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pyhisdKMC7JpIkyYf43Dj827bL4CgslaWeYFvlKpHtOXsUBODEuFb3BNWVrzQofEDgVYlx1qUDSdoeVhrVoM/qCRD+4/YF9VWn7z57zwcb7MPR+P4axonKq61T3GEewuG6+wGfNMbFcg8tvM2NvV2T8DFLAcNmAZ1lX1LSZZIAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=x/ztT7nc; arc=fail smtp.client-ip=40.107.95.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYV1WzMqnAZJQ26eZeZlFaUyZxXrmVdMEIlxEeZ291JLNzGTLOuk4dQFNO6Vnum9KwMI5UgwTY3dAqJgI7qA2F/oRbrpgDZi98cyXCxjiGPSmAYFklRKKxyGa87lxYVfh1BjH45Moclexkn4uj/QD7ECkweFxWVAmuqn6BhOZGcF8iJLy1q0K7xMA59FwdGNcUk6rXHGy0W0xZBwq9EHzC2JkSKqmeXMjhgooqmKYHLkMIEsQo0ZUicc40FHhP+YnZ/9TGOJa8RXBvfoojKco+S70RipQP154gNujEhVod+R+aRxS84+6dT+Vy3VIe22OLoVvKwqDc+D+01fTo47iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6QGGbIPqJ25UJ8Ur5uE1YP06DfU0IfL+w3RuYYiuTI=;
 b=Ee3yFFRahABQmnVQwXzx4F9oSJ67b6jHwrHmEbcSoYPd4IpdRUmaYQgxL52eJKAVjLDY7NuKpo0/EZiBCxwgSUL1NJK9RSKEdVoEuI/u3NTjCQ4V7lsiY4u0yhOPvdNHFj2i/S6rl2kDJ3xe2nLL66jH8U5hDsFAdwSxBUeIzfR35vj2f2+HKAz2x1MA+4zZOj40hIk3f+UR0No3GAwmPzqzlaEypdxh0WsCpLiJ5MG3Bzs5tQ49D2g0f2jTGwTE4OPzj0NOVtm42dcxRqIikdogfOpkFcLccMb/XDVoe2VpSMMmdFIxG4JQBvbsqx8DTzxDrDgSlPt3ea3/rydWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6QGGbIPqJ25UJ8Ur5uE1YP06DfU0IfL+w3RuYYiuTI=;
 b=x/ztT7nc7C3vvXE6JRdyP021d9eLV4JfZ8r7wU1Zl5ZSZEavN3+J8yHtb9hS0MOfD41twgHj5lz0Z+PPpVTZYNfuEoTASSNDlkqGzSZuIthK1hATPGu3gc0Wd0AtU8SOJDfJqYgMvvc7LqrTkfQ4HtmXjsmLVIp7zPohj+AZHLU=
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by BN0PR10MB4885.namprd10.prod.outlook.com (2603:10b6:408:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 02:14:50 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 02:14:49 +0000
Date: Tue, 2 Apr 2024 21:14:46 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Mark Brown <broonie@kernel.org>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.8 SPI Chip Select Regression
Message-ID: <Zgy7llSklu7iU2Om@euler>
References: <Zgx5glZznSCheksj@euler>
 <467644bf-85d0-429a-bd11-7155b1cb5fbc@sirena.org.uk>
Content-Type: multipart/mixed; boundary="mAZxeMGDyO/Wl3xc"
Content-Disposition: inline
In-Reply-To: <467644bf-85d0-429a-bd11-7155b1cb5fbc@sirena.org.uk>
X-ClientProxiedBy: MN2PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:208:15e::14) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|BN0PR10MB4885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Jy65dIXEqc1aMRM+KDNv+6BRkzEHND7HQsLTQylSt1lQecgzxFU+n+OXbyU7qdnpsEymRVeY3PRrLUYMyr53dGpY6nJx2gko1b30DUU31+DPTEt8vL77Ze5pJ6Fazr+0bKsvbrpLIV0CB+9TkwlYRPSAOPme2DTIbxjp5ryTRRJMPoZfNdFOzqJj7dg0DcBNzq7boZoHW7l+h1YgxahcjClGySoJeCcutjXqpXJZF96BKjo1Bg5P+29nZto5BHmtUruE8Is/Osuq+UKOvDQw2GKLOEGuMBwXJfWcGkn+tMOHf0lgJQ36tAmBESexs6AGRuAICr4eZ9GZVQ2vim33YIBnW9RHMOAkFJk+VUw78g46x36ab/LeHzHNS6rKVpWbs6GJsFaqX02AjgVTxl1qPFfILxPhst2IFZM1q4P2q+K7c7RyEkZge9VkFRzuIZ41ucskE6IXfnjsnkwCx+0p+zkZU3mD2XzykkvEijnOSafbOcRz/d1wV4KkTZTYGewpePEp4tBaqc5fT8MvaSkaAN9/iSL5phy4r6DhFxZg9WufGlATo4aubv1jC04T7hIW738PDbdJk6rOKmnhUuIQYYCLyZKaGsP1YTNhj+MzGPdf5mB3LAG35SAwRr7ZbhBu+eW2wGaVmW7ZoNRlWjmrEJ1/a0QcXGHg/vzL+dOe98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bla7ehzHplBNzSLhgDXMwss3SmPULpx+L/nzG41kNgm4s8zoPCdd7lAV1ynb?=
 =?us-ascii?Q?TcNyL73iarV8H3Dtj1qDFsIJAC7qVErKKsygr4UBgHUhWMsCcghNipJUYxdv?=
 =?us-ascii?Q?qkhkKPPuMlDHDwLz4xfGvGVnuwjtEEpz9jNZyA4aSj2Zkjri/1a74AMR5AFq?=
 =?us-ascii?Q?82u2+1nomLUdz2AmKW0UYtaAz4mxTxE69bWc3TVd0dUMZdw3ll4ZijIsvz0Y?=
 =?us-ascii?Q?uvP56tDxodBPrPI8afZ+ujZ2y/2/1qQmhfUePjHKhWB1Nh3Mk/cUEMQqZtvq?=
 =?us-ascii?Q?vfEZlNZrGxvTI2FOtMXSknw5z8XbuSXS2yNlvsh7Bej0kMCKE+s0kiZNGLOK?=
 =?us-ascii?Q?qIHfOgyYo7fujSDfEenCnOEFLpA9ZDFHo+bBUAiF7mThM+BdmA5xhmJ1Jphc?=
 =?us-ascii?Q?K4P6mN3iFLHiRXZ2kwd6jPqdzlJ2Oed8HpF/v5lXWnibjpnaprtq8OXR7pPB?=
 =?us-ascii?Q?9RVIZt9MrCiDKfZCnMU6vYu0SUCsAw4nfOrKsy1M3rdkiheEWlzRrQk/WKCG?=
 =?us-ascii?Q?24BR3eQCxxXZXIP2yyuIojl+xElXLI9ILUt2F4TsTVrescmZi3/WF5+LUK2/?=
 =?us-ascii?Q?x4jgrFPfwg+apm+Z4/kEFnbJquVaGF+ZdXhacCUJrT5MMbbJknHQG20ziN/j?=
 =?us-ascii?Q?cb4oThkhIbw0lQGqu6FN4cad78s9L8IY7RbB1zbOuU8qlJ5YbKjbPYjmLhqj?=
 =?us-ascii?Q?XRkSQuSmM9raQXaLmDYPTBA7xAIYqwBPH0tgYh09AIY78dT6WLbUu9cqgxez?=
 =?us-ascii?Q?wb+jySPGw1fHyKht1HXtzSH8QiJms0AWPuK2Z13InCGi/PvCU+vCZBC9VnX+?=
 =?us-ascii?Q?jL2Z+8xMhXEOQr9bd8xGAjS8e02HDZX6tUU+8ssuiP6Sd1Afp0iJCEwXFi95?=
 =?us-ascii?Q?3ePPbhmsCCJCWkRO4KaXv6BCBYXZ8ZbO6ezdPB97IRA/dy+geXQYN+YLp5qf?=
 =?us-ascii?Q?9fxLpcNh8D+WOFiAVrsSgK6fDHSLfaJBzxKsS3Hs66cPtgIOZD8A/4QM1lPV?=
 =?us-ascii?Q?u2GoR87NSPxyT73FptcjX7A8x1UKkHF3QnjKDKxKYuLDCQHyZDksOM4Vprmt?=
 =?us-ascii?Q?fOwBHsTYoV3YCQb8/Fd+g9ajIq89y69S6VGGqEx5cL+lntY5Pnzf4hOCDsVf?=
 =?us-ascii?Q?AhqArMXPuz/jl7upwtYXs1kn+1pgNprn8MvbWOGrDWtq8DKa2e6zBQdT/MNL?=
 =?us-ascii?Q?lO6hDua9R+WFur+b5RKld/pQ+OSSsnfBvSau9scUG2a/RukEEKRX03gdCkgg?=
 =?us-ascii?Q?274RuVuPcCkLofSNi4sqVTvwJRgXYUv4KP+gguFzslyg8ax9B8JfIeqysdAs?=
 =?us-ascii?Q?tM53yAweGDLmQ78SRZ4MeXVAAsEMk18kf01f95gsZwxCtBRyWy5Fbt7LKaHP?=
 =?us-ascii?Q?INGfX77v3AP2XqRrRU8YyRfkR/gA9Dkifuunjh+rghK6FP2lf0L51PjfKqwW?=
 =?us-ascii?Q?chq6hraTXmqW6UyHPhluxKGCGU3q4vFpIoqCOuSA8sMISEgXB/Stdvskabdv?=
 =?us-ascii?Q?r6GoA4PdfLPJOshOdh1rvP4rMayofbWdxDyKFvGXJ4/HicvjW6oM+h2BEOU9?=
 =?us-ascii?Q?lWWem/4dcNoAWtFcYrX/vgj+wuKppi2wodp9BsZo16DLmo4CFLt4bKqeeua0?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf45c0e7-9c2b-4db6-4ddc-08dc5383d72a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 02:14:49.7424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1hXui1Y2jHq/YsUWMWTdHC4GccZXd1BBAM6KAVPy7eQETZ2wsExPzKwDxbbHXSAWkw2j7sHwKxbJaCqLcpkm0aEN1eYrEN/gASl9zrn5Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4885

--mAZxeMGDyO/Wl3xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

Thanks for the quick response.

On Wed, Apr 03, 2024 at 12:52:44AM +0100, Mark Brown wrote:
> On Tue, Apr 02, 2024 at 04:32:50PM -0500, Colin Foster wrote:
> > Hi Amit,
> 
> Amit, please respond to these issues - you never replied to the mails
> about the other regressions this introduced either...
> 
> > [    3.459990] omap2_mcspi 48030000.spi: chipselect 0 already in use
> > [    3.466135] spi_master spi0: spi_device register error /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
> > [    3.477495] spi_master spi0: Failed to create SPI device for /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
> 
> > Is this a known issue? Is there anything I either might need to do to a
> > device tree, or something you might suggest to help troubleshoot this?
> 
> This is not known, and given that you say there's only one chip select
> in use on the system seems clearly bogus.  There were some regressions
> with trying to use more than the hard coded maximum number of chip
> selects but they have a different error pattern.  It's late so I'll not
> look properly right now but...
> 
> Do you know what chip select 0 is - if you add a WARN_ON() to
> spi_set_chipselect() it should show a prior call to the function,

Log is below. There aren't any other SPI devices, so I'm not really sure
what is the issue just yet. It is also using the built-in chip select,
not a GPIO.

> or is
> it some logic bug that somehow is not manifesting on other systems that
> use chip select 0?  Though looking quickly there has been some factoring
> out since that commit was merged...  just to confirm, did you bisect to
> find the problematic commit? 

I bisected, and just confirmed again that the previous commit,
f05e2f61fe88: ("ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select")
does boot as expected.

I noticed the issue on 6.9-rc2, then jumped back to 6.8, then 6.7.
Bisected between 6.7 and 6.8.

> If you could show the DT for your setup
> that'd help, especially if this is a GPIO chip select.

It should be attached. It is really nothing more than the beaglebone
black with this SPI addition. The only things out-of-tree are some VLAN
and MTU tweaks I had to make for my DSA networking setup to work.




The boot log with WARN_ON(true) at spi_set_chipselect, as well as
dump_stack() before both "chipselect %d already in use" messages.


Linux version 6.7.0-rc1-00003-g4d8ff6b0991d-dirty (colin@euler) (arm-unknown-linux-gnueabi-gcc (crosstool-NG 1.25.0) 11.2.0, GNU ld (crosstool-NG 1.25.0) 2.38) #1375 SMP PREEMPT Tue Apr  2 20:36:28 CDT 2024

8<

at24 0-0050: using lookup tables for GPIO lookup
at24 0-0050: No GPIO consumer wp found
at24 0-0050: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
omap_i2c 44e0b000.i2c: bus 0 rev0.11 at 400 kHz
------------[ cut here ]------------
WARNING: CPU: 0 PID: 25 at include/linux/spi/spi.h:299 of_register_spi_device+0x218/0x5f0
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u2:2 Not tainted 6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x168/0x1f4
 warn_slowpath_fmt from of_register_spi_device+0x218/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 25 at include/linux/spi/spi.h:299 of_register_spi_device+0x218/0x5f0
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x168/0x1f4
 warn_slowpath_fmt from of_register_spi_device+0x218/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 25 at include/linux/spi/spi.h:299 of_register_spi_device+0x218/0x5f0
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x168/0x1f4
 warn_slowpath_fmt from of_register_spi_device+0x218/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 25 at include/linux/spi/spi.h:299 of_register_spi_device+0x218/0x5f0
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x168/0x1f4
 warn_slowpath_fmt from of_register_spi_device+0x218/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 25 at include/linux/spi/spi.h:299 of_register_spi_device+0x2c0/0x5f0
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x168/0x1f4
 warn_slowpath_fmt from of_register_spi_device+0x2c0/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 25 at include/linux/spi/spi.h:299 of_register_spi_device+0x2c0/0x5f0
Modules linked in:
CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __warn+0x88/0x160
 __warn from warn_slowpath_fmt+0x168/0x1f4
 warn_slowpath_fmt from of_register_spi_device+0x2c0/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
---[ end trace 0000000000000000 ]---
idx = 0, nw_idx = 1, cs = 0
CPU: 0 PID: 25 Comm: kworker/u2:2 Tainted: G        W          6.7.0-rc1-00003-g4d8ff6b0991d-dirty #1375
Hardware name: Generic AM33XX (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
Backtrace: 
 dump_backtrace from show_stack+0x20/0x24
 show_stack from dump_stack_lvl+0x60/0x78
 dump_stack_lvl from dump_stack+0x18/0x1c
 dump_stack from __spi_add_device+0x190/0x224
 __spi_add_device from spi_add_device+0x50/0x64
 spi_add_device from of_register_spi_device+0x430/0x5f0
 of_register_spi_device from spi_register_controller+0x3b0/0x6b8
 spi_register_controller from devm_spi_register_controller+0x54/0x94
 devm_spi_register_controller from omap2_mcspi_probe+0x4c4/0x584
 omap2_mcspi_probe from platform_probe+0x6c/0xcc
 platform_probe from really_probe+0xd8/0x2e8
 really_probe from __driver_probe_device+0x98/0x1b0
 __driver_probe_device from driver_probe_device+0x40/0x114
 driver_probe_device from __device_attach_driver+0xa4/0x10c
 __device_attach_driver from bus_for_each_drv+0x94/0xec
 bus_for_each_drv from __device_attach+0xbc/0x1e0
 __device_attach from device_initial_probe+0x1c/0x20
 device_initial_probe from bus_probe_device+0x98/0x9c
 bus_probe_device from deferred_probe_work_func+0x88/0xb4
 deferred_probe_work_func from process_one_work+0x170/0x43c
 process_one_work from worker_thread+0x2c4/0x4ec
 worker_thread from kthread+0x114/0x148
 kthread from ret_from_fork+0x14/0x28
Exception stack(0xe006dfb0 to 0xe006dff8)
dfa0:                                     00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c037c070 r4:c21d6140
omap2_mcspi 48030000.spi: chipselect 0 already in use
spi_master spi0: spi_device register error /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
spi_master spi0: Failed to create SPI device for /ocp/interconnect@48000000/segment@0/target-module@30000/spi@0/soc@0
sdhci-omap 48060000.mmc: using DT '/ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0' for 'cd' GPIO lookup
of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/ocp/interconnect@48000000/segment@0/target-module@60000/mmc@0[0]' - status (0)

--mAZxeMGDyO/Wl3xc
Content-Type: audio/vnd.dts
Content-Disposition: attachment; filename="am335x-boneblack-vsc7512.dts"
Content-Transfer-Encoding: quoted-printable

// SPDX-License-Identifier: GPL-2.0-only=0A=
/*=0A=
 * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/=
=0A=
 */=0A=
/dts-v1/;=0A=
=0A=
#include <dt-bindings/phy/phy-ocelot-serdes.h>=0A=
#include "am33xx.dtsi"=0A=
#include "am335x-bone-common.dtsi"=0A=
#include "am335x-boneblack-common.dtsi"=0A=
=0A=
/ {=0A=
	model =3D "TI AM335x BeagleBone Black";=0A=
	compatible =3D "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";=0A=
=0A=
	// 125 MHz clock on dev board=0A=
	ocelot_clock: ocelot-clock {=0A=
		compatible =3D "fixed-clock";=0A=
		#clock-cells =3D <0>;=0A=
		clock-frequency =3D <125000000>;=0A=
	};=0A=
=0A=
	vscleds {=0A=
		compatible =3D "gpio-leds";=0A=
		vscled0 {=0A=
			label =3D "port0led";=0A=
			gpios =3D <&sgpio_out1 0 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:00:link";=0A=
		};=0A=
		vscled01 {=0A=
			label =3D "port0led1";=0A=
			gpios =3D <&sgpio_out1 0 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:00:1Gbps";=0A=
		};=0A=
		vscled10 {=0A=
			label =3D "port1led";=0A=
			gpios =3D <&sgpio_out1 1 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:01:link";=0A=
		};=0A=
		vscled11 {=0A=
			label =3D "port1led1";=0A=
			gpios =3D <&sgpio_out1 1 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:01:1Gbps";=0A=
		};=0A=
		vscled20 {=0A=
			label =3D "port2led";=0A=
			gpios =3D <&sgpio_out1 2 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:02:link";=0A=
		};=0A=
		vscled21 {=0A=
			label =3D "port2led1";=0A=
			gpios =3D <&sgpio_out1 2 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:02:1Gbps";=0A=
		};=0A=
		vscled30 {=0A=
			label =3D "port3led";=0A=
			gpios =3D <&sgpio_out1 3 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:03:link";=0A=
		};=0A=
		vscled31 {=0A=
			label =3D "port3led1";=0A=
			gpios =3D <&sgpio_out1 3 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim0.2.auto-mii:03:1Gbps";=0A=
		};=0A=
		vscled40 {=0A=
			label =3D "port4led";=0A=
			gpios =3D <&sgpio_out1 4 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:04:link";=0A=
		};=0A=
		vscled41 {=0A=
			label =3D "port4led1";=0A=
			gpios =3D <&sgpio_out1 4 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:04:1Gbps";=0A=
		};=0A=
		vscled50 {=0A=
			label =3D "port5led";=0A=
			gpios =3D <&sgpio_out1 5 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:05:link";=0A=
		};=0A=
		vscled51 {=0A=
			label =3D "port5led1";=0A=
			gpios =3D <&sgpio_out1 5 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:05:1Gbps";=0A=
		};=0A=
		vscled60 {=0A=
			label =3D "port6led";=0A=
			gpios =3D <&sgpio_out1 6 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:06:link";=0A=
		};=0A=
		vscled61 {=0A=
			label =3D "port6led1";=0A=
			gpios =3D <&sgpio_out1 6 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:06:1Gbps";=0A=
		};=0A=
		vscled70 {=0A=
			label =3D "port7led";=0A=
			gpios =3D <&sgpio_out1 7 0 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:07:link";=0A=
		};=0A=
		vscled71 {=0A=
			label =3D "port7led1";=0A=
			gpios =3D <&sgpio_out1 7 1 GPIO_ACTIVE_LOW>;=0A=
			default-state =3D "off";=0A=
			linux,default-trigger =3D "ocelot-miim1.3.auto-mii:07:1Gbps";=0A=
		};=0A=
	};=0A=
};=0A=
=0A=
&cpu0_opp_table {=0A=
	/*=0A=
	 * All PG 2.0 silicon may not support 1GHz but some of the early=0A=
	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed=0A=
	 * to support 1GHz OPP so enable it for PG 2.0 on this board.=0A=
	 */=0A=
	oppnitro-1000000000 {=0A=
		opp-supported-hw =3D <0x06 0x0100>;=0A=
	};=0A=
};=0A=
=0A=
&gpio0 {=0A=
	gpio-line-names =3D=0A=
		"[mdio_data]",=0A=
		"[mdio_clk]",=0A=
		"P9_22 [spi0_sclk]",=0A=
		"P9_21 [spi0_d0]",=0A=
		"P9_18 [spi0_d1]",=0A=
		"P9_17 [spi0_cs0]",=0A=
		"[mmc0_cd]",=0A=
		"P8_42A [ecappwm0]",=0A=
		"P8_35 [lcd d12]",=0A=
		"P8_33 [lcd d13]",=0A=
		"P8_31 [lcd d14]",=0A=
		"P8_32 [lcd d15]",=0A=
		"P9_20 [i2c2_sda]",=0A=
		"P9_19 [i2c2_scl]",=0A=
		"P9_26 [uart1_rxd]",=0A=
		"P9_24 [uart1_txd]",=0A=
		"[rmii1_txd3]",=0A=
		"[rmii1_txd2]",=0A=
		"[usb0_drvvbus]",=0A=
		"[hdmi cec]",=0A=
		"P9_41B",=0A=
		"[rmii1_txd1]",=0A=
		"P8_19 [ehrpwm2a]",=0A=
		"P8_13 [ehrpwm2b]",=0A=
		"NC",=0A=
		"NC",=0A=
		"P8_14",=0A=
		"P8_17",=0A=
		"[rmii1_txd0]",=0A=
		"[rmii1_refclk]",=0A=
		"P9_11 [uart4_rxd]",=0A=
		"P9_13 [uart4_txd]";=0A=
};=0A=
=0A=
&gpio1 {=0A=
	gpio-line-names =3D=0A=
		"P8_25 [mmc1_dat0]",=0A=
		"[mmc1_dat1]",=0A=
		"P8_5 [mmc1_dat2]",=0A=
		"P8_6 [mmc1_dat3]",=0A=
		"P8_23 [mmc1_dat4]",=0A=
		"P8_22 [mmc1_dat5]",=0A=
		"P8_3 [mmc1_dat6]",=0A=
		"P8_4 [mmc1_dat7]",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"P8_12",=0A=
		"P8_11",=0A=
		"P8_16",=0A=
		"P8_15",=0A=
		"P9_15A",=0A=
		"P9_23",=0A=
		"P9_14 [ehrpwm1a]",=0A=
		"P9_16 [ehrpwm1b]",=0A=
		"[emmc rst]",=0A=
		"[usr0 led]",=0A=
		"[usr1 led]",=0A=
		"[usr2 led]",=0A=
		"[usr3 led]",=0A=
		"[hdmi irq]",=0A=
		"[usb vbus oc]",=0A=
		"[hdmi audio]",=0A=
		"P9_12",=0A=
		"P8_26",=0A=
		"P8_21 [emmc]",=0A=
		"P8_20 [emmc]";=0A=
};=0A=
=0A=
&gpio2 {=0A=
	gpio-line-names =3D=0A=
		"P9_15B",=0A=
		"P8_18",=0A=
		"P8_7",=0A=
		"P8_8",=0A=
		"P8_10",=0A=
		"P8_9",=0A=
		"P8_45 [hdmi]",=0A=
		"P8_46 [hdmi]",=0A=
		"P8_43 [hdmi]",=0A=
		"P8_44 [hdmi]",=0A=
		"P8_41 [hdmi]",=0A=
		"P8_42 [hdmi]",=0A=
		"P8_39 [hdmi]",=0A=
		"P8_40 [hdmi]",=0A=
		"P8_37 [hdmi]",=0A=
		"P8_38 [hdmi]",=0A=
		"P8_36 [hdmi]",=0A=
		"P8_34 [hdmi]",=0A=
		"[rmii1_rxd3]",=0A=
		"[rmii1_rxd2]",=0A=
		"[rmii1_rxd1]",=0A=
		"[rmii1_rxd0]",=0A=
		"P8_27 [hdmi]",=0A=
		"P8_29 [hdmi]",=0A=
		"P8_28 [hdmi]",=0A=
		"P8_30 [hdmi]",=0A=
		"[mmc0_dat3]",=0A=
		"[mmc0_dat2]",=0A=
		"[mmc0_dat1]",=0A=
		"[mmc0_dat0]",=0A=
		"[mmc0_clk]",=0A=
		"[mmc0_cmd]";=0A=
};=0A=
=0A=
&gpio3 {=0A=
	gpio-line-names =3D=0A=
		"[mii col]",=0A=
		"[mii crs]",=0A=
		"[mii rx err]",=0A=
		"[mii tx en]",=0A=
		"[mii rx dv]",=0A=
		"[i2c0 sda]",=0A=
		"[i2c0 scl]",=0A=
		"[jtag emu0]",=0A=
		"[jtag emu1]",=0A=
		"[mii tx clk]",=0A=
		"[mii rx clk]",=0A=
		"NC",=0A=
		"NC",=0A=
		"[usb vbus en]",=0A=
		"P9_31 [spi1_sclk]",=0A=
		"P9_29 [spi1_d0]",=0A=
		"P9_30 [spi1_d1]",=0A=
		"P9_28 [spi1_cs0]",=0A=
		"P9_42B [ecappwm0]",=0A=
		"P9_27",=0A=
		"P9_41A",=0A=
		"P9_25",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC",=0A=
		"NC";=0A=
};=0A=
=0A=
&spi0 {=0A=
	#address-cells =3D <1>;=0A=
	#size-cells =3D <0>;=0A=
	status =3D "okay";=0A=
=0A=
	soc@0 {=0A=
		compatible =3D "mscc,vsc7512";=0A=
		spi-max-frequency =3D <2500000>;=0A=
		reg =3D <0 0>;=0A=
		#address-cells =3D <1>;=0A=
		#size-cells =3D <1>;=0A=
=0A=
		ethernet-switch@71010000 {=0A=
			compatible =3D "mscc,vsc7512-switch";=0A=
			reg =3D <0x71010000 0x00010000>,=0A=
			      <0x71030000 0x00010000>,=0A=
			      <0x71080000 0x00000100>,=0A=
			      <0x710e0000 0x00010000>,=0A=
			      <0x711e0000 0x00000100>,=0A=
			      <0x711f0000 0x00000100>,=0A=
			      <0x71200000 0x00000100>,=0A=
			      <0x71210000 0x00000100>,=0A=
			      <0x71220000 0x00000100>,=0A=
			      <0x71230000 0x00000100>,=0A=
			      <0x71240000 0x00000100>,=0A=
			      <0x71250000 0x00000100>,=0A=
			      <0x71260000 0x00000100>,=0A=
			      <0x71270000 0x00000100>,=0A=
			      <0x71280000 0x00000100>,=0A=
			      <0x71800000 0x00080000>,=0A=
			      <0x71880000 0x00010000>,=0A=
			      <0x71040000 0x00010000>,=0A=
			      <0x71050000 0x00010000>,=0A=
			      <0x71060000 0x00010000>;=0A=
			reg-names =3D "sys", "rew", "qs", "ptp", "port0", "port1",=0A=
				    "port2", "port3", "port4", "port5", "port6",=0A=
				    "port7", "port8", "port9", "port10", "qsys",=0A=
				    "ana", "s0", "s1", "s2";=0A=
			interrupts =3D <18 21 16>;=0A=
			interrupt_names =3D "ptp_rdy", "xtr", "fdma";=0A=
=0A=
			ports {=0A=
				#address-cells =3D <1>;=0A=
				#size-cells =3D <0>;=0A=
=0A=
				port@0 {=0A=
					reg =3D <0>;=0A=
					status =3D "okay";=0A=
					ethernet =3D <&mac_sw>;=0A=
					phy-handle =3D <&sw_phy0>;=0A=
					phy-mode =3D "internal";=0A=
				};=0A=
=0A=
				port@1 {=0A=
					reg =3D <1>;=0A=
					label =3D "swp1";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy1>;=0A=
					phy-mode =3D "internal";=0A=
				};=0A=
=0A=
				port@2 {=0A=
					reg =3D <2>;=0A=
					label =3D "swp2";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy2>;=0A=
					phy-mode =3D "internal";=0A=
				};=0A=
=0A=
				port@3 {=0A=
					reg =3D <3>;=0A=
					label =3D "swp3";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy3>;=0A=
					phy-mode =3D "internal";=0A=
				};=0A=
=0A=
				port@4 {=0A=
					reg =3D <4>;=0A=
					label =3D "swp4";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy4>;=0A=
					phy-mode =3D "qsgmii";=0A=
					phys =3D <&serdes 4 SERDES6G(0)>;=0A=
				};=0A=
=0A=
				port@5 {=0A=
					reg =3D <5>;=0A=
					label =3D "swp5";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy5>;=0A=
					phy-mode =3D "qsgmii";=0A=
					phys =3D <&serdes 5 SERDES6G(0)>;=0A=
				};=0A=
=0A=
				port@6 {=0A=
					reg =3D <6>;=0A=
					label =3D "swp6";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy6>;=0A=
					phy-mode =3D "qsgmii";=0A=
					phys =3D <&serdes 6 SERDES6G(0)>;=0A=
				};=0A=
=0A=
				port@7 {=0A=
					reg =3D <7>;=0A=
					label =3D "swp7";=0A=
					status =3D "okay";=0A=
					phy-handle =3D <&sw_phy7>;=0A=
					phy-mode =3D "qsgmii";=0A=
					phys =3D <&serdes 7 SERDES6G(0)>;=0A=
				};=0A=
			};=0A=
		};=0A=
=0A=
		mdio@7107009c {=0A=
			compatible =3D "mscc,ocelot-miim";=0A=
			#address-cells =3D <1>;=0A=
			#size-cells =3D <0>;=0A=
			reg =3D <0x7107009c 0x24>;=0A=
=0A=
			sw_phy0: ethernet-phy@0 {=0A=
				reg =3D <0x0>;=0A=
			};=0A=
=0A=
			sw_phy1: ethernet-phy@1 {=0A=
				reg =3D <0x1>;=0A=
			};=0A=
=0A=
			sw_phy2: ethernet-phy@2 {=0A=
				reg =3D <0x2>;=0A=
			};=0A=
=0A=
			sw_phy3: ethernet-phy@3 {=0A=
				reg =3D <0x3>;=0A=
			};=0A=
		};=0A=
=0A=
		mdio@710700c0 {=0A=
			compatible =3D "mscc,ocelot-miim";=0A=
			pinctrl-names =3D "default";=0A=
			pinctrl-0 =3D <&miim1>;=0A=
			#address-cells =3D <1>;=0A=
			#size-cells =3D <0>;=0A=
			reg =3D <0x710700c0 0x24>;=0A=
=0A=
			sw_phy4: ethernet-phy@4 {=0A=
				reg =3D <0x4>;=0A=
			};=0A=
=0A=
			sw_phy5: ethernet-phy@5 {=0A=
				reg =3D <0x5>;=0A=
			};=0A=
=0A=
			sw_phy6: ethernet-phy@6 {=0A=
				reg =3D <0x6>;=0A=
			};=0A=
=0A=
			sw_phy7: ethernet-phy@7 {=0A=
				reg =3D <0x7>;=0A=
			};=0A=
		};=0A=
=0A=
		gpio: pinctrl@71070034 {=0A=
			compatible =3D "mscc,ocelot-pinctrl";=0A=
			gpio-controller;=0A=
			#gpio-cells =3D <2>;=0A=
			gpio-ranges =3D <&gpio 0 0 22>;=0A=
			reg =3D <0x71070034 0x6c>;=0A=
=0A=
			led_shift_reg_pins: led-shift-reg-pins {=0A=
				pins =3D "GPIO_0", "GPIO_1", "GPIO_2", "GPIO_3";=0A=
				function =3D "sg0";=0A=
			};=0A=
=0A=
			miim1: miim1 {=0A=
				pins =3D "GPIO_14", "GPIO_15";=0A=
				function =3D "miim";=0A=
			};=0A=
		};=0A=
=0A=
		gpio@710700f8 {=0A=
			compatible =3D "mscc,ocelot-sgpio";=0A=
			#address-cells =3D <1>;=0A=
			#size-cells =3D <0>;=0A=
			bus-frequency=3D<12500000>;=0A=
			clocks =3D <&ocelot_clock>;=0A=
			microchip,sgpio-port-ranges =3D <0 15>;=0A=
			pinctrl-names =3D "default";=0A=
			pinctrl-0 =3D <&led_shift_reg_pins>;=0A=
			reg =3D <0x710700f8 0x100>;=0A=
=0A=
			sgpio_in0: gpio@0 {=0A=
				compatible =3D "microchip,sparx5-sgpio-bank";=0A=
				reg =3D <0>;=0A=
				gpio-controller;=0A=
				#gpio-cells =3D <3>;=0A=
				ngpios =3D <64>;=0A=
			};=0A=
=0A=
			sgpio_out1: gpio@1 {=0A=
				compatible =3D "microchip,sparx5-sgpio-bank";=0A=
				reg =3D <1>;=0A=
				gpio-controller;=0A=
				#gpio-cells =3D <3>;=0A=
				ngpios =3D <64>;=0A=
			};=0A=
		};=0A=
=0A=
		serdes: serdes {=0A=
			compatible =3D "mscc,vsc7514-serdes";=0A=
			#phy-cells =3D <2>;=0A=
		};=0A=
	};=0A=
};=0A=

--mAZxeMGDyO/Wl3xc--

