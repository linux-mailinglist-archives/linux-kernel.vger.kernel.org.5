Return-Path: <linux-kernel+bounces-98079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4398774CA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F93B20BAF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50F21374;
	Sun, 10 Mar 2024 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGi104JA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A85A3D;
	Sun, 10 Mar 2024 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710034435; cv=fail; b=RedkCuQa9BQy2pyn/REg4RP/1+HqqhcB5wN/h/VeTNBrO8ZwrScjBL5ZGDG25cpTyBY3QPlNJ/+p7EqSPpHec5Ta5x/GyF9HDXwyDRArZUVmcsW7sM+Lsu812eCwrf/CE4qjxTA2R0JUtYUSrPYc6lMd6T15J5y6LKY9WFv39i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710034435; c=relaxed/simple;
	bh=rJ9AR/XFxY2Yl9aHWMlsxH4+xiMnT1LRfHbqKtgtbcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SWHRXvtY0Wcu9X6Bv/gvRKTnsSYOQmEaVgUeYR0GsvU0pWRD7dZPggitb2KLh2M3jWxHmUeLFII5iZlz5x7iZBTSy+DSBrE84Yq0sUM9NIEH3pPR9TFyhHxP5C6mE7CB7iW0g1MUBIpAuQpMKjt0nYlx6npaMIC4zL65VO930ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGi104JA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710034433; x=1741570433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJ9AR/XFxY2Yl9aHWMlsxH4+xiMnT1LRfHbqKtgtbcQ=;
  b=hGi104JA7Rp2PtN2d9f+Z2FPmbfBhK2U9FZdPVKTxi7muhCo3gXTy98m
   DemGlRZVY2EHeSgReIsj7/71HfQV2KQ3pwjbWB/Voc5WRCWlXl+2DMWAh
   oBefS7p20K1dtuEyapFDS24Dvspx7yrd1HWo/YpXjRCCRE7lWIoogXLcY
   hjD+LDvx0OlgwN+2dsnwZeAVW0VhOVenBZwwEn+tHaeWz8uhsoZ/i1Mf7
   2CzfeZzOGFCEqvEfxV1jjC4PaDbWurzP9xB6746a+vy7LPJDNJJeFzySH
   hRbrnhGcYgz7Y2KTYiqIJX0ealZyTr3bU09nUcsv284Kh0bW1yflGs0en
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="8546730"
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="8546730"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 17:33:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,113,1708416000"; 
   d="scan'208";a="10873080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Mar 2024 17:33:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Mar 2024 17:33:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 9 Mar 2024 17:33:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 17:33:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0TjwswZkr8LRSXciEf/M+KJXeI/W9xhb/uhU2ZfewAMpjG6q9hcZicuCVQsStSyX/WRdVrr0EfjK0hAZpSJN1f+Wc+FaxsYNR5dZYSurN7N8Zs08TP40wk5GZgCON8YvQs4xFhGcuMFHohlm4zJ3RmDCJky9Yy31Y07YopjR0UfBQeUx5S/VV0iggczQDSuHGWS9jSIYXjtRUpOHAnzThr0xVZmufErbNAJGAvZnEX9lY4DUufpKW+MDoOT9xCNnj6mU+OnUgvNUtdjtZj6nryEcFU3OSTjp1PbZyJxZ5gsTOw7ONndLP/D44PxRWAh+zBZHJQDvbKfzUCSy67OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk0L6TSFUUjUkIxXfLmf7oQXwjRxY1921NRUnUKsHoE=;
 b=Tj9op34FmXGnLU9a0bP7NQzU0HIqg4JKWCoqlpg0l2VT3bHJwuuTEYV8a4SxIzr+MDc9+WWBkroG2Bl/Qp9fmy+ORHvhBRBIZl7oqIBG7TLyLrXBAFbqR+K8y8MAAEnqA46PfGcmDnO4zZDBVKedRnGCrCkOqKRG4SYXpODFNFH/BUJxvIWC5WAD/huu8olpBT5VrbTGXHybV5pmlf9vwQ1lOLMnwO587FO1MCfzBV8qDcyNEE2d6JKyPy7uTlWiYsEidMhiy7EUfLQQmfjoV3Ah3itNgTH0/Cvy6IML+hixjbP/yyXbiO1vLEqwd8Wz6CW8fM0L0/H84vpyP80Xyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12)
 by SN7PR11MB6558.namprd11.prod.outlook.com (2603:10b6:806:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Sun, 10 Mar
 2024 01:33:49 +0000
Received: from PH0PR11MB5808.namprd11.prod.outlook.com
 ([fe80::53e1:ca40:13ff:a23a]) by PH0PR11MB5808.namprd11.prod.outlook.com
 ([fe80::53e1:ca40:13ff:a23a%7]) with mapi id 15.20.7386.006; Sun, 10 Mar 2024
 01:33:49 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Thread-Topic: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Thread-Index: AQHaam3EvCzE5l33CkGR0g/9d0yezrEgGjAAgADQ1wCAAAJ5gIAAnU4AgA0EQNCAAKILAIAAdXAw
Date: Sun, 10 Mar 2024 01:33:49 +0000
Message-ID: <PH0PR11MB580859671B2F9EFAD471F76C8D252@PH0PR11MB5808.namprd11.prod.outlook.com>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
 <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
 <MW5PR11MB5787E3A96C8EFF3C9F8BC8908D272@MW5PR11MB5787.namprd11.prod.outlook.com>
 <ZewpyJ3d7gx3dSvA@shine.dominikbrodowski.net>
In-Reply-To: <ZewpyJ3d7gx3dSvA@shine.dominikbrodowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5808:EE_|SN7PR11MB6558:EE_
x-ms-office365-filtering-correlation-id: 2199f93c-dd80-4b51-1818-08dc40a22314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpDtd6XvawzMlbG4nJi8Wk/MGFZDlDdy1bu9WcjqBvMNsCGUo6LkwBerxYBmbJadwZsS++zkw4VACaBee4FaQMmjvMLfu9gP9NTSx/t9jOs9CAYTHb2U4TWP+4ROtEvgEhfkZGGBJDqGrYyd+DyjZo/t9/6gZluTDSVy2lo3B5C6F8LnGWNEwvPtrQJ/KFlUnEOUX6h/S4IsT6uoB3DLvxkiZmUWmBo7ez2SW3wXG/qleWzWz1cdUxG3bwRfSh0yDl3lVpdMqsMp18zteByO1Y8Oz6h+456rIjlS+hmpC034hBm7VDyImKe92jqOT6tEDMJYhZxXTl6F2R03xGyDwaY6A/LnJXLLSqTEQwF/MAj0SfNuwNpzPQxZ0jtvmdd4ZSHx59VP52N1lfTsj/TBApppnZoKtQj2SjzNEpvKHlYXM9ed8LvA4iWNZvLVHnDgxfsOj2hOZTRLiUAVCFpwlpZweXc5UeHiPd0IcW70t2OLNC2cY1/ieaQe8hXZ5ktJubqmKTtcrJ/QJ84rqDN3HRWllotn90duJOmQoxptpxHkdfjkVrO/1p2Nw5YwWNfmtOAn7ijzXqqt141p5/nhVHOu5jdFcWwA3RljPBKZ9ta/0Y7YNMKR7rsRx4I2ABzSMch3s4oT4ue4hQZ+C0SDpmigrExqhyW60qo8DM8EaEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5808.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3eJAqjes1QlsWansRMIbMaRI5n4SNBb4EjmKFKBr0cXS6xovuz75ch0uOGYR?=
 =?us-ascii?Q?yWL1dKentNh9WD1idsmIz/pacTXAbvc8HSDGLzsgAgz52CS5tuhYqQSAjSQX?=
 =?us-ascii?Q?o9U4Wxchr7avJeyZtunUhAU6UlGx1i5g4Pk27OXb5E6LG4i7nVEZ+sqOgVIv?=
 =?us-ascii?Q?zHpwkhlTOEKxUhEIqsGJaYwsJashKPBHynCfQKLy0sOGbMTMaa8f1phHVj1d?=
 =?us-ascii?Q?t4AR4M1L7fqE5odCFMOGx1UVXo3WWlGR1DchOJMPSkdI4ngxRMDwiyZlzFjf?=
 =?us-ascii?Q?YqZfd6hOiIT2rNZi41pl6FzIbI/f0DVGJDs32LXA6DHNvr+uK8iFA3roR1N6?=
 =?us-ascii?Q?GWVuxPv6gYYoaSWBUSE8M+2DSDf3RETqBYwaFXsdabpopIZOTFd/TsCpUEjq?=
 =?us-ascii?Q?DpyLZX4eNSyXh+1FwfA0/DYtBvEi79KBDzHlBg8uhJ3xras5JIppXGrX1Bwz?=
 =?us-ascii?Q?20cbzJfAs5CBVUr4k43qVbbzROGPbcE5V+qyVtD4V9+tiWyHEvpZ8DVA+IMU?=
 =?us-ascii?Q?VkDKspGqm0miP1KzrJGqyLvEr9gyXV4SpBEn5iOnMIaepPfhKi/ABWEUZKZq?=
 =?us-ascii?Q?93nQOHrf94HGLgElV4dH9d1TxPch3Xi/5TgxEgh4GZjTL+a/cN3EBSfKG1U3?=
 =?us-ascii?Q?uiaU2JTK/rHsSH4DgEtwGBAHzO6eKbmdjAvScFXuKr4trBZgtrG0E2iFZJKh?=
 =?us-ascii?Q?4b9Ncfp4/+GbgyId6N5eBMWmQ88uj/UOSGe5hWMyOZ5JzybXvqKkYZh4Jaoz?=
 =?us-ascii?Q?ixEVDQqKxJN3pZPkWyaaafZxLU3AyKWM6U77ZHDf4FVQX46YCbOqx0CsTQJV?=
 =?us-ascii?Q?kVOTfGqRkg1gD/EeGbf5N2fZDl6kyWUlVOfiEGg7hg/uitjEM/KLWXzHDoAs?=
 =?us-ascii?Q?1CFTa1KLgfZ+ZMpJ1U8OCSTJOfI0X6t8NZ0VzBLRCzQGZqMRu/VITyqdVdgy?=
 =?us-ascii?Q?Qm8aiFjY17BtWV2Dzpme4uhd3iCfphVw+gWGNRA0A466XL+2ORiuicjeWb1H?=
 =?us-ascii?Q?3roMk4ZqHdnZq8GE/1cWycsFonxCwa863WvkZjwlJYawDwT+GysYsAyZ5Dcf?=
 =?us-ascii?Q?eswYSUs5Ehh6xdvzz93gpuvhRwjoHPgqV35cHCpLq5weiwKypiCj3XQKoz+J?=
 =?us-ascii?Q?Yh+065m9Y93umz2aENL6PRyO2ze5cHwgGwnf/Wk+mtcHXhgcFY4YmziPhvj7?=
 =?us-ascii?Q?teIjhFDbXhGS24x20qJOI+s8JlxFT2v4VXEJlKZtWteU3e2dMhtr1Vunl1Ez?=
 =?us-ascii?Q?QvTZhIPQDL7ecjsHNl3IPPv05WiSksk3RY5XNabS+ZHzUamTuyBCaVytiy3r?=
 =?us-ascii?Q?tJZaVmUqzN8gNex7tzIGdzGzUJ/ToPcl7pOOvgwd4YS/WB7A9gYvDq7LkWVV?=
 =?us-ascii?Q?5CTCq1Pj0YAZsuVLg7WxnxYGocvqxikbY+YcmI4Rp3R3tNYaePYlIrROjIWV?=
 =?us-ascii?Q?zdz4y4aw1lb0Qnxre2dtP1ee9M/4LIyFQM7kgoLmpW3dI5Iwminh7zbakfvu?=
 =?us-ascii?Q?+rqBNt3r5AVPiExDbyg6DWQyeszmHqVMj+EtyknAbHUHRNzX6lTH7dasI41I?=
 =?us-ascii?Q?uIJAh5jPOmNMvcoMAUTsVYZUHwi3Y/E6GLyyem5Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5808.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2199f93c-dd80-4b51-1818-08dc40a22314
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2024 01:33:49.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cL3e+VdiNNP2XISCkjqVb1Uv1P4EmwXIcMCf1WWNeR1iWi2SkiUaxe6ZGP7IIepSltQNr1raL1/AfkC4/NDYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6558
X-OriginatorOrg: intel.com

> From: Dominik Brodowski <linux@dominikbrodowski.net>
>=20
> Hi Wetong,
>=20
> Am Fri, Mar 08, 2024 at 11:45:44PM +0000 schrieb Wu, Wentong:
> > Did you try master branch (v6.8) without IPU6 driver? There should be
> > problems with the IPU6 driver you use as below:
> >
> > > intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> > > intel-ipu6 0000:00:05.0: Connected 1 cameras
> >
> > If not, could you please help try it on your side?
>=20
> Branch master from https://git.linuxtv.org/sailus/media_tree.git/ causes =
a
> WARNING during boot; some extracts from dmesg:

Thanks for your help, I think this has been fix by below patch:
<URL: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/misc/mei/vsc-tp.c?id=3Db8b19acfafdeacbedd4e2795cb18c81c4d8bb6=
cc>

how about the suspend and resume scenario with media_tree master
branch (which doesn't merge IPU6 driver) plus this patch?
I will test it as well next Monday I get to office.

BR,
Wentong
>=20
> mei_me 0000:00:16.0: enabling device (0000 -> 0002) mei_hdcp 0000:00:16.0=
-
> b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops
> i915_hdcp_ops) mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-
> 1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
> intel_vsc intel_vsc: silicon stepping version is 0:2 ------------[ cut he=
re ]------------
> do not call blocking ops when !TASK_RUNNING; state=3D2 set at
> [<000000001b97ea26>] prepare_to_wait_event+0x54/0x1a0
> WARNING: CPU: 5 PID: 124 at kernel/sched/core.c:10099
> __might_sleep+0x59/0x60 Modules linked in:
> CPU: 5 PID: 124 Comm: kworker/u24:2 Tainted: G                T  6.8.0-rc=
2+ #2
> Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.1.3 05/11/2022
> Workqueue: events_unbound deferred_probe_work_func
> RIP: 0010:__might_sleep+0x59/0x60
> Code: ee 48 89 df 5b 31 d2 5d e9 24 fd ff ff 48 8b 90 60 15 00 00 48 c7 c=
7 a8
> 3e aa 84 c6 05 6f b3 47 03 01 48 89 d1 e8 b7 6c fb ff <0f> 0b eb d1 0f 1f=
 00 90
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffbd3ec1287a98 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffff84a07d0f RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000ea5 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> R13: ffffa224892a3028 R14: ffffa22494ac1028 R15: 00000000c1287b00
> FS:  0000000000000000(0000) GS:ffffa22bef680000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557ffdf03148 CR3: 00000002b645c000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __might_sleep+0x59/0x60
>  ? __warn+0x80/0x170
>  ? __might_sleep+0x59/0x60
>  ? report_bug+0x182/0x1b0
>  ? handle_bug+0x40/0x80
>  ? exc_invalid_op+0x17/0x80
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __might_sleep+0x59/0x60
>  ? __might_sleep+0x59/0x60
>  gpiod_get_value_cansleep+0x19/0x60
>  vsc_tp_xfer+0x177/0x570
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  mei_vsc_write+0xe5/0x1d0
>  mei_hbm_cl_flow_control_req+0x84/0xd0
>  mei_cl_read_start+0x23b/0x330
>  mei_cldev_register_rx_cb+0xf5/0x140
>  mei_ace_probe+0x11f/0x390
>  ? kernfs_add_one+0x146/0x180
>  ? really_probe+0x166/0x300
>  really_probe+0x166/0x300
>  ? __pfx___device_attach_driver+0x10/0x10
>  __driver_probe_device+0x6e/0x120
>  driver_probe_device+0x1a/0x90
>  __device_attach_driver+0x8e/0xd0
>  bus_for_each_drv+0x90/0xf0
>  __device_attach+0xac/0x1a0
>  ? process_one_work+0x19c/0x500
>  bus_probe_device+0x93/0xb0
>  ? process_one_work+0x19c/0x500
>  deferred_probe_work_func+0x96/0xd0
>  process_one_work+0x205/0x500
>  worker_thread+0x1dc/0x3e0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xea/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> irq event stamp: 1166879
> hardirqs last  enabled at (1166885): [<ffffffff81cb6348>]
> console_unlock+0x118/0x170 hardirqs last disabled at (1166890):
> [<ffffffff81cb632d>] console_unlock+0xfd/0x170 softirqs last  enabled at
> (1166640): [<ffffffff81c1333e>] irq_exit_rcu+0x7e/0xa0 softirqs last disa=
bled
> at (1166635): [<ffffffff81c1333e>] irq_exit_rcu+0x7e/0xa0 ---[ end trace
> 0000000000000000 ]--- mei intel_vsc-5db76cf6-0a68-4ed6-9b78-
> 0361635e2447: deferred probe pending: (reason unknown) mei intel_vsc-
> 92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason
> unknown)
>=20
>=20
> Best,
> 	Dominik

