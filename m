Return-Path: <linux-kernel+bounces-3135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935418167D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7011C22345
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF145101C9;
	Mon, 18 Dec 2023 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZU0tHAP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5AF9D1;
	Mon, 18 Dec 2023 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702887069; x=1734423069;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=07C7Uojy2bVd3mSEpHpfZHkfhVlL/xeNXskzNYPNOMg=;
  b=lZU0tHAP78l82izePB0jxk6BgCB9kB/glqoWdPjMVQYWCssfeFUK2URP
   sT9KISqM68qb/rFUSvvdVvZRgAZi8DOir/tCQvTb5qNE+y0sGivW4mqk/
   NZBce0PsuKNBBnvtq8iXMjR42Tm9J0XC3jsLA+3ipOHO3dtI207UdzXE0
   tWOkb/dw/H83TMYQaWUTvIN+St6/gom2oCKbIcCQuHfdlvyhK2Y6dl+E6
   MmDxQGFWLYnj9q8Wi7ExLcQABce7jVo+fRAj+wSn7tO8gloRLLbJi+0uR
   vl0XoPXjrXi2sPHlKfILQQLrsS1LHLVLO5N1eU3C7hm9y1xNMlRYnCg5b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="17028401"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="17028401"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 00:11:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893729385"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893729385"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 00:11:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 00:11:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 00:11:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 00:11:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 00:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnI/cEPeCCoKa0ycIbAOTtc0TvdJ2/lGZAac1MuGRlb5bcVNlX7X7uZEm+6mpAGbhlOXmiGe1KwCVVhDFRfYDC/Sj6LZK7mb1xWrY5mu6SJ/7IaFxnxbNvZlEyMk4Z7RH5RA3OAGmAYkx9qjhSxJKEyaNEm8+a/oNwym3yYnNvYH4OINURrtlTyT79gAR/63C2C1MOYkoNRmKL2bgMa3jzA8w/dKWU+QXHbn77Hle+9rrfyqJ4fEpvLp1CnmZ/FnZeTOv6fJ4LBVQdAZxWFX98wMIaQajdxXEjO5xtTAeIt++upFYwhzUJzDNV4CAd1QGLbC9Datyt36sk5MaO48rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zpS7E3owYhWpN1ouF696BD+L6QNMImNiaHatXebI/g=;
 b=XVb1pw2vUX0XjDYA7wvSoO+0YLUkb4XlE+JdYW8t75oobP4D2clGHqWOox5n/IuvXebihLdGIEXZMOnP/vOH3JOt2UIlSyAB8b59/T/9RXyCrcC6btQ5Lf1VP2L+7rShUX+fCxN0mV/XoBxOlabdvPe73LZu57j/X8bNCIvfHBrgRl5yIFXOHQPMrr+PZCXwXHs/NijkApNp6N7wbTEsOVOYpqFKKH6yMT7RTjMI1QuUCBom3QFFjMnqPdgyRm7DT59VCSsO80LsiKOuxpaPuBgPljjHI/Atx5Fcb8RRpR5lJWycOHX22JDWgTBeRiD+BYbFkjDT84aEtCxTee+CSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB4990.namprd11.prod.outlook.com (2603:10b6:a03:2d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 08:11:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 08:11:03 +0000
Date: Mon, 18 Dec 2023 16:10:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, <thomas.petazzoni@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, Herve Codina
	<herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, Piergiorgio Beruto
	<piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <202312181512.79005cd3-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe7e05c-52e1-4080-2652-08dbffa0e03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q25aCqfg/X6Cf182j9AUGPG7U+ArYvFFiT1qm+MGt5QjOV3pOZkYlJky+oMeWmfIS1hubzDkJtNV7W5qd6CWn3OikLi9jfRWqcJcjbhH9vLTE/1C2NMFcRvssgJ7c8gv4RFjg15je6xv3wBAeOxjW1j5idfHzte9hjKl9qUiYTiU3emgbOyUDFA2TQlOH4wteqLPPNMuoskFgjLf3h/lo0p6B5eGvP7I64qXCpa9ECgN2YuXPITNfiu7l4ZJKP//X4kllVae7y4Q8nw1zEJpoL06oROrj/RPvk4416mTD5FdbgfEXlGgLlDdA6+OJAoC8YIspRTyylSsWvahL3Fqi83t80x3JZ3+6n3qFc8F20G8dZtBs7qryz4INb6uhwclKkJ9QJLhhIacT5Z0kHuwsCOIUFt6IXKBDnMtH+o3pBV9zsRM2BTLjtqfenuOr2Ay/vwQwCu6HU+gJDEQ9ciqx3UsnKuO50VieGWtBfAerELP1y/8h72H3J7oEPkCFQbkw5Z4K2gOf7UJ8d2323dMkySxjnHX1SJSVKShgs8S8UyVIHLXHzaf5g+h9MayksUBTBXj6UhJVRtFYDn40334AGEjBgE19xANyC6TGPIkfZHkVesLO9yopiCp8bqoNjoztMELJ9SGzi9pGXN4QQNqTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(26005)(2616005)(107886003)(6666004)(6512007)(6506007)(83380400001)(45080400002)(5660300002)(41300700001)(966005)(2906002)(7416002)(478600001)(54906003)(316002)(4326008)(8676002)(8936002)(66946007)(66556008)(66476007)(6486002)(6916009)(82960400001)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V3LjMyxCYhaJCl2dIIXL3r3QkTZQo2SDk0ZgQpJACcF/ca4IAW5ZtvdJ2HPF?=
 =?us-ascii?Q?6bH/J70uySRxN4Bp+kgVV8hSYKkLCjFxKEZtjY4GhniWvvUHeVI9jR1J3Qe1?=
 =?us-ascii?Q?vHITP//UMDekwqm6A0+lu9H4dJrrGIYeZvm5WZ6nipWCjD4TdKh7zGF3jjZm?=
 =?us-ascii?Q?Wl4HtZWWMKvZqJvGu6YY9+vaXUnFkgNEEMbu/FpVbCaz8QIUf2+/q1kswfDJ?=
 =?us-ascii?Q?38lyLs5tVkTqAOlptYnL/JmbumwIMFegdxd9ogfcegUmskFijIfPKbGwjOBv?=
 =?us-ascii?Q?uHT21LXK1gp0AzxrSIEMR8sfimWPSOzQtRwLd8f0P5puJLwRrGVHWjQuCVlT?=
 =?us-ascii?Q?reBdfpVzj9dspnZQvyaGykjMgSiS52+1jhv40MqnsnmsU36SP0MM84GL66Nh?=
 =?us-ascii?Q?QzX6nrdVOPVp3EYl6cbLZ0rdytBPuuClLSKsAP16fWBnoywE+DSBo2zRFlac?=
 =?us-ascii?Q?MjqduIDYgolYEj/7c2e70TZvDWh+Yjzj98Z/maK5/EpNqQCETvIwbIP1ZpTu?=
 =?us-ascii?Q?Z6qDm1BoZFR7OtzQ8tpf9aOHU5pEHM72jwJCAKZmfyMY/6gJl8UOtAAOHU3p?=
 =?us-ascii?Q?jFCqqhYX0DtCuoq/6HNR2QV4/OeQSN6XCdyhpZs1D5kk5FtRcF8VDbTH9XMT?=
 =?us-ascii?Q?LGWW72CW6gU2b1y/N2QV+8iWeqpnTDrBgMZzptwSuJQGX/44n2N6d7pQMKIN?=
 =?us-ascii?Q?5xsq4vA9uaqIEEuhPkGaFKA3FYFQEQLYNqA2MfkRz/U/JCE5cbEHdiZH0QT6?=
 =?us-ascii?Q?KIAKf2HZHYlI7b6pHB2U+bv3nZ87mtQZoXyFoKAWKaQeRjtuxJA6R0+VivkQ?=
 =?us-ascii?Q?1VWemQke82MsMCxhxO89E/a2swFTEkHMb0Zq6bL59UqSZyiGdRiZh+RaMdHX?=
 =?us-ascii?Q?KEqp6RSxj0CDbt1wrO7+uFGHl7XAC64NkO/f6ppali7fZToq9RGAcjT0TMzA?=
 =?us-ascii?Q?A/YDVskFh8GhV8PLsuMZK2HNH4+Kg64qwwI8xt5UhNFcYRlOADQN6b4Sgedn?=
 =?us-ascii?Q?NMtKyWMH/0lbRMRjjbzDFmW/tx5q7nHK8TB7NCl4gF50XVao+0MWUAt5dzp5?=
 =?us-ascii?Q?kTY2xe53fvaVYPxarnssaw1FvHG9Tfpb3+DmdJWorYkW/nfmdCbFKG9Fu3UP?=
 =?us-ascii?Q?EB/GhLvLv8wE1uoGdY/zxk2Bx1ajbTmKCvsmDidkbxlIa2gO4TSWLWKrS2Cl?=
 =?us-ascii?Q?718HwehtxttKdnkpnaH0EG47M4FlVxsvFIWUcZwIzZPbMdbCz7wY2VkA3C0I?=
 =?us-ascii?Q?Jx69WBfo4XPvWD15ZIvbzbsRVIJN2xfzfCii9oIAQH8T7kHPcM91z5m5bk3R?=
 =?us-ascii?Q?X0SF0LTp6No57tCJjrTmxIv8PwV6aCltxhEZXS+Q5sWBw9koZvd8Gta1jt1i?=
 =?us-ascii?Q?wkQdaakSN39HfizTJ1wdAP5qeUwgLV+bqbTW1s41Io7Bsdcdvyy57K4hDVgx?=
 =?us-ascii?Q?S4YozIywIg1yQtiiPv+wKUJsfqKWGYlfTRUPTr+NN/UJcLQwOah03ZSO9ySr?=
 =?us-ascii?Q?ZV5fmUrWjzbVFvy+CzjH81dJgPFAEk31lq3AF8qxAXU/6GjPGpXGstAz7RfI?=
 =?us-ascii?Q?ZQAChrlscanZVVB/ceOjXU5N5SZZfYJGpxEh5Ki6lnplsj8RuF5nEIdNwXGs?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe7e05c-52e1-4080-2652-08dbffa0e03b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 08:11:02.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lw3tXvdbQdSI9VUY5nMUwon/C/KAWGiCoscfKL/TC07NzWHmomSLf5WLT1QSNgmycblxu90d+3XfG2reab1GLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4990
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "assertion_failed" on:

commit: 78b410e5a385c625b85bdfec9acdee79b20f4907 ("[PATCH net-next v4 01/13] net: phy: Introduce ethernet link topology representation")
url: https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-Introduce-ethernet-link-topology-representation/20231216-012641
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git e91db1614abae0cca248040c78b2c25f8dd97872
patch link: https://lore.kernel.org/all/20231215171237.1152563-2-maxime.chevallier@bootlin.com/
patch subject: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link topology representation

in testcase: boot

compiler: gcc-9
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------+------------+------------+
|                                                                              | e91db1614a | 78b410e5a3 |
+------------------------------------------------------------------------------+------------+------------+
| assertion_failed                                                             | 0          | 8          |
| WARNING:at_drivers/net/phy/phy_link_topology.c:#phy_link_topo_add_phy        | 0          | 8          |
| EIP:phy_link_topo_add_phy                                                    | 0          | 8          |
+------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312181512.79005cd3-oliver.sang@intel.com


[   48.548859][   T36] ------------[ cut here ]------------
[   48.550106][   T36] RTNL: assertion failed at drivers/net/phy/phy_link_topology.c (35)
[ 48.552023][ T36] WARNING: CPU: 1 PID: 36 at drivers/net/phy/phy_link_topology.c:35 phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:35 (discriminator 3)) 
[   48.554496][   T36] Modules linked in:
[   48.555406][   T36] CPU: 1 PID: 36 Comm: kworker/u4:1 Not tainted 6.7.0-rc5-01059-g78b410e5a385 #1 4e624fcd33c509a5c53c7f4349cb3dc9014b8795
[   48.558523][   T36] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   48.560890][   T36] Workqueue: events_unbound deferred_probe_work_func
[ 48.562460][ T36] EIP: phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:35 (discriminator 3)) 
[ 48.563694][ T36] Code: 26 00 00 00 00 80 3d 39 c7 19 d6 00 0f 85 f0 fe ff ff 6a 23 68 18 3d 99 d5 68 b0 96 88 d5 c6 05 39 c7 19 d6 01 e8 13 1a 3e ff <0f> 0b 83 c4 0c e9 ce fe ff ff bb f4 ff ff ff e9 fe fe ff ff cc cc
All code
========
   0:	26 00 00             	add    %al,%es:(%rax)
   3:	00 00                	add    %al,(%rax)
   5:	80 3d 39 c7 19 d6 00 	cmpb   $0x0,-0x29e638c7(%rip)        # 0xffffffffd619c745
   c:	0f 85 f0 fe ff ff    	jne    0xffffffffffffff02
  12:	6a 23                	pushq  $0x23
  14:	68 18 3d 99 d5       	pushq  $0xffffffffd5993d18
  19:	68 b0 96 88 d5       	pushq  $0xffffffffd58896b0
  1e:	c6 05 39 c7 19 d6 01 	movb   $0x1,-0x29e638c7(%rip)        # 0xffffffffd619c75e
  25:	e8 13 1a 3e ff       	callq  0xffffffffff3e1a3d
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	83 c4 0c             	add    $0xc,%esp
  2f:	e9 ce fe ff ff       	jmpq   0xffffffffffffff02
  34:	bb f4 ff ff ff       	mov    $0xfffffff4,%ebx
  39:	e9 fe fe ff ff       	jmpq   0xffffffffffffff3c
  3e:	cc                   	int3   
  3f:	cc                   	int3   

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	83 c4 0c             	add    $0xc,%esp
   5:	e9 ce fe ff ff       	jmpq   0xfffffffffffffed8
   a:	bb f4 ff ff ff       	mov    $0xfffffff4,%ebx
   f:	e9 fe fe ff ff       	jmpq   0xffffffffffffff12
  14:	cc                   	int3   
  15:	cc                   	int3   
[   48.568132][   T36] EAX: 00000042 EBX: edf5a000 ECX: 00000000 EDX: d5eb634c
[   48.569726][   T36] ESI: c38c96b8 EDI: 00000000 EBP: c0cf7d0c ESP: c0cf7cf0
[   48.571374][   T36] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
[   48.573237][   T36] CR0: 80050033 CR2: b7d88778 CR3: 16543000 CR4: 00040690
[   48.574846][   T36] Call Trace:
[ 48.575546][ T36] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 48.576634][ T36] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:35 (discriminator 3)) 
[ 48.577915][ T36] ? __warn (kernel/panic.c:677) 
[ 48.578810][ T36] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:35 (discriminator 3)) 
[ 48.580194][ T36] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 48.581234][ T36] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 48.582213][ T36] ? handle_bug (arch/x86/kernel/traps.c:216) 
[ 48.583120][ T36] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 48.584185][ T36] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 48.585295][ T36] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 48.586339][ T36] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:35 (discriminator 3)) 
[ 48.587595][ T36] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 48.588689][ T36] ? phy_link_topo_add_phy (drivers/net/phy/phy_link_topology.c:35 (discriminator 3)) 
[ 48.589870][ T36] phy_attach_direct (drivers/net/phy/phy_device.c:1504) 
[ 48.590857][ T36] phylink_connect_phy (drivers/net/phy/phylink.c:1958) 
[ 48.591949][ T36] dsa_user_create (net/dsa/user.c:2495 net/dsa/user.c:2530 net/dsa/user.c:2668) 
[ 48.592985][ T36] dsa_port_setup (net/dsa/dsa.c:524) 
[ 48.593974][ T36] dsa_tree_setup (net/dsa/dsa.c:764 net/dsa/dsa.c:893) 
[ 48.595049][ T36] dsa_register_switch (net/dsa/dsa.c:1530 net/dsa/dsa.c:1544) 
[ 48.596350][ T36] dsa_loop_drv_probe (drivers/net/dsa/dsa_loop.c:344) 
[ 48.597483][ T36] mdio_probe (drivers/net/phy/mdio_device.c:165) 
[ 48.598357][ T36] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 48.599353][ T36] __driver_probe_device (drivers/base/dd.c:800) 
[ 48.600558][ T36] driver_probe_device (drivers/base/dd.c:830) 
[ 48.601690][ T36] __device_attach_driver (drivers/base/dd.c:959) 
[ 48.602883][ T36] bus_for_each_drv (drivers/base/bus.c:457) 
[ 48.604077][ T36] __device_attach (drivers/base/dd.c:1030) 
[ 48.605140][ T36] ? driver_probe_device (drivers/base/dd.c:922) 
[ 48.606221][ T36] device_initial_probe (drivers/base/dd.c:1080) 
[ 48.607390][ T36] bus_probe_device (drivers/base/bus.c:532) 
[ 48.608551][ T36] deferred_probe_work_func (drivers/base/dd.c:124) 
[ 48.609781][ T36] process_one_work (include/linux/jump_label.h:207 include/linux/jump_label.h:207 include/trace/events/workqueue.h:108 kernel/workqueue.c:2632) 
[ 48.611053][ T36] process_scheduled_works (kernel/workqueue.c:2694) 
[ 48.612380][ T36] worker_thread (kernel/workqueue.c:2781) 
[ 48.613437][ T36] kthread (kernel/kthread.c:388) 
[ 48.614365][ T36] ? rescuer_thread (kernel/workqueue.c:2727) 
[ 48.616138][ T36] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 48.617344][ T36] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 48.618342][ T36] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 48.619647][ T36] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 48.620892][ T36] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[   48.622004][   T36] irq event stamp: 35465
[ 48.622981][ T36] hardirqs last enabled at (35473): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 48.625036][ T36] hardirqs last disabled at (35482): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038) 
[ 48.626997][ T36] softirqs last enabled at (35420): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 48.628965][ T36] softirqs last disabled at (35415): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[   48.631005][   T36] ---[ end trace 0000000000000000 ]---
[   48.632508][   T36] dsa-loop fixed-0:1f lan1 (uninitialized): PHY [dsa-0.0:00] driver [Generic PHY] (irq=POLL)
[   48.637526][   T36] dsa-loop fixed-0:1f lan2 (uninitialized): PHY [dsa-0.0:01] driver [Generic PHY] (irq=POLL)
[   48.654535][   T36] dsa-loop fixed-0:1f lan3 (uninitialized): PHY [dsa-0.0:02] driver [Generic PHY] (irq=POLL)
[   48.659100][   T36] dsa-loop fixed-0:1f lan4 (uninitialized): PHY [dsa-0.0:03] driver [Generic PHY] (irq=POLL)
[   48.663920][   T36] DSA: tree 0 setup
[   48.664854][   T36] dsa-loop fixed-0:1f: DSA mockup driver: 0x1f



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231218/202312181512.79005cd3-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


