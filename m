Return-Path: <linux-kernel+bounces-36178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E2839D12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9746728F880
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622353E2A;
	Tue, 23 Jan 2024 23:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIqHGHuK"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7495576B;
	Tue, 23 Jan 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051541; cv=fail; b=ZDm+t2Vi/LDzQXJoW3eoIbOXiSJpqzRuPE8LPxH9l9WHN8rW/RxR2t//qRMymXAES7seLjDGqkLw0qRaOWVlS/r9Lh0vvkqmxYftKqShkA4YkhyaYQt1bM1gyGpVG+0KcwRteV3BrbehsUlMesbCU3QBVnkS31Z752Oi7b6BVUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051541; c=relaxed/simple;
	bh=hoyj8FsuLc7PFBOkML7aiCh5OmQ0828dG1gHuegGwxI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlO+y6hKlX2IwWncZGIzn7aUnD+cureZYl9Lzmqp+Zi/WxhOy3IFeOzb+kIT08xDGqgK8nwbzaDOutcEhm3ZRUI+W4sp7yYRSKLuWGdfB7V2lzvROfh6Ab1tOqDwAa5EpVCQY6ZzGje7ea4DeEKHA+Pd8kMEAi05KmGzk9xnyRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIqHGHuK; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBjC3guV/pKapbDQ+iT4/TQm9VcOb77qh+ztUSeejz7/otHfoqjQ1zex7Cg0NnbzqGYOyw5FW+EFWNaBjtEa5Lp6+e7BcvgcGAFaeFZflzwQFpibQ5Jgj2Gx9eO6eooVHupiAi+lPEYzUiJHgs4f9o74WaYvXYvDWqRboTOV66XTXM38Hv/JTW61indwSHz3nctpVuh+0+xeCSiFH+BSW0lPiUstN0tJnujQSEUpiy4rQSCn3EBhbwQF7YNnOBLASHMom6ueK4n0j8dD6j9nO9ApK8olYjDXGPnHj+SJQqTy8CerT077oGCZ8/UW75Rhd5pITI+HKOeSlVVhdd3YCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbIAgR04LwKx1phnuHExE5CdhzlBSDmxM+Fwivjr+YE=;
 b=VuDHshRMXQV9n+28WsynLNC37MA2WszQs7AjMxVyW1N+Al/KFED1RV4nE1upy4jy8ofkB2nZtBE7ouUNk0JRN1Qmq9oF14s9UcxW/IsxcKFM5fyCPvzi6UFDq3VfwAFAAhoFG539qoa4/2RPBWhRQRqlDRRMnmEKAU1jzzOK77nFhWj2G/frE9eCIosNzdw4KIFMBtFoQWi7AqdAdu9gPJDfZrBiSRMXK6veEeNmNO9nNk0BF3VJIH+Ki3ceDwEhLduqQsSz7MJLrVb44Lgc7YFA6O31b9/He0izbG4loeb4EnluAZgCuNGjcdVtOXxxkpx6JPU+PW3C5ysm+p75ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbIAgR04LwKx1phnuHExE5CdhzlBSDmxM+Fwivjr+YE=;
 b=GIqHGHuK5Z0DUmQXK0MJHado1MLEbHYHAw2HTjNRha9fmg5kxAEvGc4NLUF1epIgwWcGr1ArQWASp70DvNMlCWDTtFORy8GbwAi3N/HwUuAojLcflbfh1uPU+bEI7ydjxfAakmZHSrTaEnDgsniNE8U6KBIOE1IU2/lddaNoC1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 23:12:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:12:16 +0000
Date: Tue, 23 Jan 2024 18:12:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v3 0/8] I3C target mode support
Message-ID: <ZbBHyJALhEn8UU9R@lizhi-Precision-Tower-5810>
References: <20240123212549.3858137-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123212549.3858137-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 372f0072-7b46-40fb-514d-08dc1c68bd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n7hA9t+WCs74SrpqII5/tFqwQUcJYaylNRX902WnwMWi4jaLfghrpt7cHFTkaX4KpxQ2Vb9gIR5MY1cLaLgU5w3CeKK0Y0I5vSRx4u1J/6dPeEgHdM1Gwv8VGO/b2SGLixk4jpxF0XYM+8xfp00piWXhob3TpxPj1Dwe1ABDhVV7wx/eo2/mw5dXxFOsPssMh2eGyQaEDBr5UzaQj85CE7TDnV8ct5GyDdcS92YgjmwEmYG54bXyG6gZP7JnxBKHWFSGCkSbKvqHP51qtjefJPktqm5xJIiwFa4pTEDaQdVIZbTwFJkYZKy3dtqTzrYdji8jMsVJsU9Ezvacd6ulmaw540lYSbCgZqeipJsXaUavczfgq/QefUmcWpjYVd4/jXg5DkF7TCmX82a7UyyrfBxWyr/ehmKjSH66k+cWKgiF916OC9/VnLsa2p1FjkqO29y/N/2/9+SHsZfyiTW9QrLWDbtlqc2YYrG/YHrXPmfUH0rqolW4yXBTdkcuwSkEmxYIhLSUpN1HOsJ2Ti+//yhpCs3zKOYvGuJzyU3R0N78j8b9otHOLtJSoDkGemoEpWabcS/p9p4HYg5kDDnlsJaREA6te/GKZrIn1Axkq52qIBgT1gdsDtQBbc4CNJPF/jOy0EPSEuvieBWwT1+BwZg6EHldQLJ7i81YzJoY/gU7VpgkBcjWilI+lltwLaEO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(86362001)(921011)(41300700001)(38350700005)(38100700002)(9686003)(6512007)(26005)(6506007)(33716001)(66946007)(2906002)(52116002)(6486002)(316002)(66476007)(66556008)(6666004)(478600001)(5660300002)(7416002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9CVwKs2SgfLL2/kInS+FHo+C45ESM++IT8AtiX2sAPzO2ceJDyfUJbxNMih?=
 =?us-ascii?Q?NhDLLUV3pvjfL3/gMDDKzHab/uaJspHgk4QN/fvPqLQuVPEwf9jTRSrejUh4?=
 =?us-ascii?Q?76pJu/rYGyl2tiXTDekRd0fZMYwAORiuuQUCFYikg9IpjPFKo7PBzSd/E+9W?=
 =?us-ascii?Q?B8Jh2xkP9abi/enmFUt0ABSyzjNDUMh+NZTR6lEbm1q7Z0XUMNZaTDSBLuOL?=
 =?us-ascii?Q?d17S0pZGTiXPY9eRSD1ibJT6b7ocEh72hFvsVZWElM72yeJfEp+GtjosUfX1?=
 =?us-ascii?Q?VKETXHePvLj2nLpYN1EG/nybEZzMhDlW7FiTfriaJ6xD0xeQ/PGWC5yyaZ9Z?=
 =?us-ascii?Q?WP1OoHIG8qBkiP6mFHnc3jWbro5mme6gLUlp75S5uPKf2bV7VWdZFcJnv+/Q?=
 =?us-ascii?Q?SN93yQ1KWrVe+h93/UY1Kyw97Qo5Vo2q7yVq1JZh1UnntL2xy/NLaVZtBd+2?=
 =?us-ascii?Q?T9Fuf+O1r97wb64hibi4Rw+OOOnpAWy3/k+GmlHk17fYFo4ar2Tgc8WUCx93?=
 =?us-ascii?Q?2+mDZBIpWN5LyIXCYVyJKONYwXDDmsgMKk0Ots4YYjdkcCc01btZd5tWG6qb?=
 =?us-ascii?Q?D+s3f7uV52xLS1nUwO5l5LIjYVrIYiVYq+5A7LbGVSGgm26eTD+NIz7FNdUa?=
 =?us-ascii?Q?8BBXsbyQZcFbFBVFyVSjkii34y5alUkJ09aZNcAZqP/hOQIX4EKG+YO1wOq2?=
 =?us-ascii?Q?z2VdaB4FOBYEzCDWDp8O4ySNsBrYcY+V2cOzP3zIJDOJoKWig5YA6w0lDBgu?=
 =?us-ascii?Q?XnP2za+Sz9z7wiYYbVzRzOAyGGCFL538FbgPwJZ0H+73sTueztKmsakevuIH?=
 =?us-ascii?Q?2SkbXfy9jSVfuvwmC0TsMXQzTgR8fmTzZMNYymX6pZGdR23wau3R/4INHwD4?=
 =?us-ascii?Q?Vj7jfAvEivNdrc7RXY1BAkvtGhD7iExDdubddJq12FHs8To5HheOHdMWQP+I?=
 =?us-ascii?Q?GElX06CzCI/wd2Z3iNjTfgTRWzLxMP8jSGVC6NCtqfmYZYGn0uP844qTcoo4?=
 =?us-ascii?Q?wELO6eTU8Q+BKvr9pC79/gDVQ2mSj/xkRRf3SktemfmvUg/+FH3SIswNsttc?=
 =?us-ascii?Q?NgSYs1PszSbhqlMaBQ6osqoQDCBcxjFifK57DJoLORVnYbcgkcfcD0ABscxe?=
 =?us-ascii?Q?2mLkg065sMvsPU9UKN2nKVq2ch/OiC99nv2oI5FjCKMS/lhzfTx5p3UqqtV4?=
 =?us-ascii?Q?kYLlK4WTkPbnKycNPNURINMNzkjy6SY+X/PascPkhopYuDTVMobKaVPTnhVL?=
 =?us-ascii?Q?7tIfE4OVXiowWWsOnomrQ6Pnhb4yY76pnU1B4o4urlxuNx0OdZA/+KQ8v554?=
 =?us-ascii?Q?fidSs7cMbHzLfGxAFTT5gQ2Xa6dSWAJ06SVnmb7zif3BuH0d/IEJZlWZovB1?=
 =?us-ascii?Q?YjyQ/PP8A0IVWSGUC++uQtxsRZ3Gl5p0T2MZrELxlrlWAiTHIQQc1seIrsnO?=
 =?us-ascii?Q?kW0RuVUIhQFnhprhX5jCy5pi1YdrVc4iB4wnedJyCwQbQDcgnrOfylnFCglQ?=
 =?us-ascii?Q?NPw2yjoKKEbpktCT/az1J+RNkmR+c77FdQeroXhSopZDi8194fOMaLTlQWVJ?=
 =?us-ascii?Q?N5ENeFagvq6J4sKOpv4Eb/SEsFy88LCHv0BB0Bff?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372f0072-7b46-40fb-514d-08dc1c68bd62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:12:16.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gO2yM4w3i2lFNS7TN6/HKvdDEDyIDKBIQQFU0IZyb9VhGQ8CPViG81yzX8zjMhlmuJIsve9j3geEehnJAm5xzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

On Tue, Jan 23, 2024 at 04:25:41PM -0500, Frank Li wrote:
> This  patch introduces support for I3C target mode, which is referenced

Please forget v3 and check v4.

Frank

> with a PCIe Endpoint system. It also establishes a configuration framework
> (configfs) for the I3C target controller driver and the I3C target function
> driver
> 
> Typic usage as
> 
> The user can configure the i3c-target-tty device using configfs entry. In
> order to change the vendorid, the following commands can be used
> 
>         # echo 0x011b > functions/tty/func1/vendor_id
>         # echo 0x1000 > functions/tty/func1/part_id
>         # echo 0x6 > functions/tty/t/bcr
> 
> Binding i3c-target-tty Device to target Controller
> ------------------------------------------------
> 
> In order for the target function device to be useful, it has to be bound to
> a I3C target controller driver. Use the configfs to bind the function
> device to one of the controller driver present in the system::
> 
>         # ln -s functions/pci_epf_test/func1 controllers/44330000.i3c-target/
> 
> Host side:
>         cat /dev/ttyI3C0
> Taret side:
>         echo abc >/dev/ttyI3C0
> 
> Chagne from v2 to v3
> - using 'mode' distingiush master and target.
> - move svc-i3c-target.c to under master,
> - built together with svc-i3c-master.c
> 
> Change from v1 to v2
> - change "slave" to "target"
> - include master side tty patch
> - fixed dtbcheck problem
> - fixed kerne-doc check warning
> 
> Some review comment may be lost since it is quite long time since v1. Now
> master side dependent patches already in linux-next. So sent target side
> patches with tty support again.
> 
> No sure why an additional "\r\n" appended.
> 
> Frank Li (8):
>   i3c: add target mode support
>   dt-bindings: i3c: svc: add proptery mode
>   Documentation: i3c: Add I3C target mode controller and function
>   i3c: svc: Add svc-i3c-main.c and svc-i3c.h
>   i3c: target: add svc target controller support
>   i3c: target: func: add tty driver
>   i3c: add API i3c_dev_gettstatus_format1() to get target device status
>   tty: i3c: add TTY over I3C master support
> 
>  .../bindings/i3c/silvaco,i3c-master.yaml      |  11 +-
>  Documentation/driver-api/i3c/index.rst        |   1 +
>  .../driver-api/i3c/target/i3c-target-cfs.rst  | 109 +++
>  .../driver-api/i3c/target/i3c-target.rst      | 189 +++++
>  .../driver-api/i3c/target/i3c-tty-howto.rst   | 109 +++
>  Documentation/driver-api/i3c/target/index.rst |  13 +
>  drivers/i3c/Kconfig                           |  31 +-
>  drivers/i3c/Makefile                          |   3 +
>  drivers/i3c/device.c                          |  24 +
>  drivers/i3c/func/Kconfig                      |   9 +
>  drivers/i3c/func/Makefile                     |   3 +
>  drivers/i3c/func/tty.c                        | 475 +++++++++++
>  drivers/i3c/i3c-cfs.c                         | 389 +++++++++
>  drivers/i3c/internals.h                       |   1 +
>  drivers/i3c/master.c                          |  26 +
>  drivers/i3c/master/Makefile                   |   3 +-
>  drivers/i3c/master/svc-i3c-main.c             |  79 ++
>  drivers/i3c/master/svc-i3c-master.c           |  34 +-
>  drivers/i3c/master/svc-i3c-target.c           | 776 ++++++++++++++++++
>  drivers/i3c/master/svc-i3c.h                  |  14 +
>  drivers/i3c/target.c                          | 453 ++++++++++
>  drivers/tty/Kconfig                           |  13 +
>  drivers/tty/Makefile                          |   1 +
>  drivers/tty/i3c_tty.c                         | 426 ++++++++++
>  include/linux/i3c/device.h                    |   1 +
>  include/linux/i3c/target.h                    | 527 ++++++++++++
>  26 files changed, 3689 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/driver-api/i3c/target/i3c-target-cfs.rst
>  create mode 100644 Documentation/driver-api/i3c/target/i3c-target.rst
>  create mode 100644 Documentation/driver-api/i3c/target/i3c-tty-howto.rst
>  create mode 100644 Documentation/driver-api/i3c/target/index.rst
>  create mode 100644 drivers/i3c/func/Kconfig
>  create mode 100644 drivers/i3c/func/Makefile
>  create mode 100644 drivers/i3c/func/tty.c
>  create mode 100644 drivers/i3c/i3c-cfs.c
>  create mode 100644 drivers/i3c/master/svc-i3c-main.c
>  create mode 100644 drivers/i3c/master/svc-i3c-target.c
>  create mode 100644 drivers/i3c/master/svc-i3c.h
>  create mode 100644 drivers/i3c/target.c
>  create mode 100644 drivers/tty/i3c_tty.c
>  create mode 100644 include/linux/i3c/target.h
> 
> -- 
> 2.34.1
> 

