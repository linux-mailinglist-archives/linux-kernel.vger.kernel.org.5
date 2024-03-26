Return-Path: <linux-kernel+bounces-119416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BB88C865
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE5E1C6482D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5513C9A7;
	Tue, 26 Mar 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpOxoHPK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542262574B;
	Tue, 26 Mar 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468963; cv=fail; b=o7A52MJbG5pb/E48WDPIYMAJfZj/uRMda0bP37ulzOpnzV5GjZNK5DMB8vMWNUhHntpJN14JlMsE6tlqQlxc4AFl7ML5a/DSn/hCcfWSVWA0esmyM1i5ZV8Obt+V6NbOwET/Rxy5g6GxfRK6PdC6nG+YmDY1pWxBR0VR8wZ5IKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468963; c=relaxed/simple;
	bh=/2mgMQaJfwNFUhuYtUqQIAjPU3T5zPILwM8XmCyQvYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3HoaftMaX3iPwoPaQLxEO09Z4gCOej7QprZXgmRXCFBxhiiDkyr87uzEfVXevIMnz58dnAjW2ZZu3JWIX06GyVL8Dq8A1FDHcVP2sy7FCPnb58axySliDcKqWZNJi7Ov68mow2qWlAefO3fjRp/q4u7D8hrtYFUc5KNhqID2Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpOxoHPK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711468961; x=1743004961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/2mgMQaJfwNFUhuYtUqQIAjPU3T5zPILwM8XmCyQvYM=;
  b=DpOxoHPKmAOU4GGk3V2HgwraZvmDkPVF/QlWr5lTm4RVrXkCaV18lvuI
   LLKm1eIJzqcG/Ht9r9CjlVVYkEuHLlOalc6gd71D//n8vbQUauxi+zyPF
   qtnrrzTghhee2suoeyZB1DY0Qg6jL29Wl1sXYTV5yzH+MnNoabHocg7Lw
   XONybnVubbTs5uVLumEE8U+4+J8U3jTwVNPPqV/X8K4mXWBqj1AicuH9C
   l8JfLIq9zwyZGmsTUj/MLT+1iGDOyCBInIcDwBXPaE1KCvS/5aBOgiRlS
   aF+q/DPEoPEwMlO/hu34je3nnyKapAJQJ/eufGdQK2WDokbLDG97PLTb9
   A==;
X-CSE-ConnectionGUID: O+4qRj3STs+NLYbB2wE7XA==
X-CSE-MsgGUID: vmgVabqCR0q5k33+a6Y+FA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="31970090"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="31970090"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="39099580"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 09:02:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 09:02:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 09:02:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 09:02:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 09:02:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT0KYlgWpuB07tjkZL7lSsYb8XVc9T2Pj3kbYZyPzQIgNQ3Be79vi/fBXdY1m8lJikUYXO6MXHqyfIC8u+g4bdGWp0GpfI2EHDypjDgn8TPkWj4pWOaPkZRBsFuWcBuO/m/bhwQovdROLL1B5HhKBkjreTnH0oOpM+wAmbSU1f8qxKURVavbCbqN2XFWg6ji/TKWqhAL1TJ4nFuOvMDDbn5lEHVq8EiZDuv1seyMmek4s1nKvRvt9aJ/mz60kZQsDFjvQSqhYcsdCPpo+ZFaJG9FJWDbGi6vIr5CHoAFlepPZleMx/+cFfKzIRU2fgGX841JHwQ5UK4bf2O2QDIKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtQlaNXMJEwJ1Xh99/aCL9bPmpcq1pCx/mV5SgpYZHs=;
 b=Dykq0OdXf6nF7fo4fg35JOrhgez6pFR/x/8vW0x3BzIDO2QHK2NvV8g9iG/mfNOo0hFXoe03FbdUo/1D/2o3EXCrObts3LJ+SjXwO1F0wZ6n29Vx2jxrtsx8GeTOchY8lW8xyrdDn3JXoOvcKTUtIoKIxqzsCOmrzTaT6s+xPeNUX5iNm78SrdV78uSiSBfqSvTEWQmjuKWqacVn3QDU4IAbrQbSbR2bjG000oU91ACkFy8xu4ElL0p6ZLzNRlxzcRV4ALHAjsDY7O3joLS8h3r2QDzvBAhVl6duKvRjF0rwonMwmFSLHPkGqZP3yYDoxBxDBOw/RVNhkkvQeZARWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 16:02:25 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 16:02:22 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/7] i40e: Change argument of
 several client notification functions
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/7] i40e: Change argument of
 several client notification functions
Thread-Index: AQHaeUEAGqYb6uMHzU69Qc7Ah6Pn97FKOxnA
Date: Tue, 26 Mar 2024 16:02:22 +0000
Message-ID: <SJ0PR11MB5866F87F079606B968A60EFCE5352@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
 <20240318143058.287014-3-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-3-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CY8PR11MB7948:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CxPECePTIuAyS0p02BBVAwjVT63Sly0G0C9mV32FyZmtFNiX0a3l7I+mwV/jRrvO8qAq+WdHQfW26K8BQgItrMPPB+3AIcKrHNH/Py00YbdWPdGRKdTT5FXZTRXYe7vVKRnXjWkx/Vvwm2roF0Y/zLjDhea97xi/HvYVsOsghEXbH3+QPMaA40JEwkpVTpUqdxNSZNB6WHbSckq7VUnnIi8jHznwj9BsRMY98t/Vgkrv73SXzWp137o3F13bA8TP5EZro4IkKtyknqZRs/RnzuypneAWt9PIqgkix4w5X/pcKhn1SVBx1tKdVI5zOKPAPVObR6TgWlltGfdcVW2nu9tgfNM/DrGN8RFmeOdNX2fm+4N7kD4JJWS1MS0wFlOO9JRgBm3lmqL3k8KDl1FwOj4Jt0M1jBGlq1AffIzaqOk3Fn57pCm4RjlNKVkVEs3lRlzy50v9Uu31q3coA5zZspdEpbTBKq3DVJerz7RjXnb58VksFQkVSEZwTRAILu7VQwhPkAcWiRUZWJcDuniFQRZGnW/vx4AIcVCMHIBLhLKLvLkeVzlZMJUIYmImqbjYbcSED9xJe5fU1stEUhacHUNGWlaCs+aB5A5v7q2orGw9aRxGjmnfqjVVZge/TZAnEXpCmrAEMp11PLcd62tVc7B57JAJItlzok+vWfZfkoI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TWOkk/a0JzmrS1B/JZMjjcQiUVCjUfPtByeWmordvr4OzOe6v0DajReSTOiQ?=
 =?us-ascii?Q?vZEgi0rOcs7Jtq/qnLeLS1SOXSoLLJUH+IDudXnwqGlG7mMBgvPay+78b4DK?=
 =?us-ascii?Q?gvbKEiaHgFRAXFE1fWbDwFNyE8ss6DkNCZhwxTkoBvN4zpB8jKzM88M8pmL3?=
 =?us-ascii?Q?0d+CIElwXUA6lqvgbDgxPKJt+OtThgILWy5FNP8FKVRlMAXqfMx5KqacBIf4?=
 =?us-ascii?Q?FLUImLRqi0nPnqQuT+O5bIgT35mY3pGXoA3+ERfFjlHlgibCtxTAdKenoM+Y?=
 =?us-ascii?Q?rDwXD5AXbWVKJ8awqu/bhKssO4HUFN8TkVn1nx17YS5/UJsWfvQ2n7PspiS2?=
 =?us-ascii?Q?Lcsp1SujuB6FBdGnX3Y50jpA+5pbl4Xw/RoHXSFKfF7eWHiyEobKV3J1Ffnb?=
 =?us-ascii?Q?igOzq2NDGJw6hSXMKT1+09sD+Ozdyhs8yOpK+1THea6uX10LsW2yDvVY+R6n?=
 =?us-ascii?Q?QNHY+q0kXXsD78a9eRBGWe8KuGjsuiw34yfeZlvYxkGEDp+dviZgGI7lIv1m?=
 =?us-ascii?Q?GEAM7RsL0vBRsFy8l4cAlrMi4Oceb+b6LJOM5pQkGjJH/NNMETFBZ7/1omXE?=
 =?us-ascii?Q?4f5EYUJK/P+EOJ55zKgHBOg/1oUEiD1ck/k8vZoiokSslCcD7rOulEzddIhP?=
 =?us-ascii?Q?XmiCKw035+dqv7SP3tYSmx46/x2Zg6gXSMOrV2EkO/SbL9IIxatUyYCVuITS?=
 =?us-ascii?Q?6TwRe/zJpLCaQjWsYvP7XLig9UZB81QfWIQkvkDV7KT4xathY/xoe4RZs7kb?=
 =?us-ascii?Q?r0VYVsN4iiK545xQpAHLqroJrl3LW6mt71NniEJ7jIyjjCMCr30uv0zUEcfs?=
 =?us-ascii?Q?X88sPlaKEGQRroElXybzEJypbudLifw7tKSznDVp/fEkrLDkussWKyvSZoem?=
 =?us-ascii?Q?lqE5/rthlTTd+QEKvyVRPVhULOfSvbry6JLKmwbWzSXSKWqvCm8xsYpK7Pba?=
 =?us-ascii?Q?as1blRzAD6V1WWWA7YHapENpv62JN70AFZHjIOFKBLMOKApFplQVSRd8jatA?=
 =?us-ascii?Q?OoNjC9YX9PRTJNeyb62SY52oDvjK4gImc3Sr16RKpIKIG/hbHGiEp13mCp1T?=
 =?us-ascii?Q?ohlmvyGSqN/2jzGv2PJyPRGl3B4vUgHpfpYS5xOwtFMa+odtq84kxXGLDv+L?=
 =?us-ascii?Q?HKAjmLRMi7QcOP7Sr7YIMyFeyvR8zgLREh6kXZLxPr6tIUTl1IhOdkrEzTED?=
 =?us-ascii?Q?0d4DDoAfKjxfPWy1CAq/G8Lm6ILi1uLv8qrm+zeYlsmGDQbat1RQaQcLHfi+?=
 =?us-ascii?Q?reyVAM7XnBi3gSspAMD5HsXNK+nMVWhpDeQo6EbBnQUNlcN10mXgZZsCvahg?=
 =?us-ascii?Q?0/GOpaDqRUaFD1l7J7uZXhEFh7o4yvwm9xl2XB+NBKJh1hIfpqwSHEV2xsEl?=
 =?us-ascii?Q?1CUzsOiv1ogjoTQ4akI+GR4Jzd86jcN64Wn2uY/R3Yak6kJdz0p3SDX7DS75?=
 =?us-ascii?Q?SkzMgnjVEpLgiDAei77IPd4m1yBCCgcWZsxt+GYim2gisPNlBr1Xj+qAFiGY?=
 =?us-ascii?Q?+X5yD/DZF3vSZHqdgrteTvjiI5GaQhAEy72yYju7DAMxJslxWetTTwEqgH7f?=
 =?us-ascii?Q?cpMrAnHPvZLDmSlhFtygNV3WtjOdBAKD/++Jo6s/zhbV4lImWSqDus53t8YX?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603eb049-7d27-4d05-3815-08dc4dae1f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 16:02:22.4067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KN2seefv3YVf3Znr71vPs5Q30KFAWUXl9DGTNNvbimrEWwD9oBwf9PELldizwbHjgOJCZHL2YrAatXCd81Tr+jSHdr8ec6j6hAWVlRXgKyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> Behalf Of Ivan Vecera
> Sent: Monday, March 18, 2024 3:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open
> list <linux-kernel@vger.kernel.org>; Eric Dumazet
> <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/7] i40e: Change
> argument of several client notification functions
>=20
Can you rename the title of the commit change -> refactor?
To make it obvious that there is no functionality change, just refactor?


> Commit 0ef2d5afb12d ("i40e: KISS the client interface") simplified
> the client interface so in practice it supports only one client per
> i40e netdev. But we have still 2 notification functions that uses
> as parameter a pointer to VSI of netdevice associated with the
> client. After the mentioned commit only possible and used VSI is
> the main (LAN) VSI.
> So change these functions so they are called with PF pointer
> argument and the associated VSI (LAN) is taken inside them.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 20 +++++++++------
> ----
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 12 +++++------
>  3 files changed, 17 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 5248e78f7849..0792c7324527 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1236,8 +1236,8 @@ static inline void i40e_dbg_exit(void) {}
> int i40e_lan_add_device(struct i40e_pf *pf);  int
> i40e_lan_del_device(struct i40e_pf *pf);  void
> i40e_client_subtask(struct i40e_pf *pf); -void
> i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi); -void
> i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool
> reset);
> +void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf);
> void
> +i40e_notify_client_of_netdev_close(struct i40e_pf *pf, bool
> reset);
>  void i40e_notify_client_of_vf_enable(struct i40e_pf *pf, u32
> num_vfs);  void i40e_notify_client_of_vf_reset(struct i40e_pf *pf,
> u32 vf_id);  void i40e_client_update_msix_info(struct i40e_pf *pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index b32071ee84af..93e52138826e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -101,25 +101,26 @@ i40e_notify_client_of_vf_msg(struct i40e_vsi
> *vsi, u32 vf_id, u8 *msg, u16 len)
>=20
>  /**
>   * i40e_notify_client_of_l2_param_changes - call the client notify
> callback
> - * @vsi: the VSI with l2 param changes
> + * @pf: PF device pointer
>   *
> - * If there is a client to this VSI, call the client
> + * If there is a client, call its callback
>   **/
> -void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi)
> +void i40e_notify_client_of_l2_param_changes(struct i40e_pf *pf)
>  {
> -	struct i40e_pf *pf =3D vsi->back;
>  	struct i40e_client_instance *cdev =3D pf->cinst;
> +	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
>  	struct i40e_params params;
>=20
>  	if (!cdev || !cdev->client)
>  		return;
>  	if (!cdev->client->ops || !cdev->client->ops-
> >l2_param_change) {
> -		dev_dbg(&vsi->back->pdev->dev,
> +		dev_dbg(&pf->pdev->dev,
>  			"Cannot locate client instance l2_param_change
> routine\n");
>  		return;
>  	}
>  	if (!test_bit(__I40E_CLIENT_INSTANCE_OPENED, &cdev->state)) {
> -		dev_dbg(&vsi->back->pdev->dev, "Client is not open,
> abort l2 param change\n");
> +		dev_dbg(&pf->pdev->dev,
> +			"Client is not open, abort l2 param change\n");
>  		return;
>  	}
>  	memset(&params, 0, sizeof(params));
> @@ -157,20 +158,19 @@ static void i40e_client_release_qvlist(struct
> i40e_info *ldev)
>=20
>  /**
>   * i40e_notify_client_of_netdev_close - call the client close
> callback
> - * @vsi: the VSI with netdev closed
> + * @pf: PF device pointer
>   * @reset: true when close called due to a reset pending
>   *
>   * If there is a client to this netdev, call the client with close
>   **/
> -void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool
> reset)
> +void i40e_notify_client_of_netdev_close(struct i40e_pf *pf, bool
> reset)
>  {
> -	struct i40e_pf *pf =3D vsi->back;
>  	struct i40e_client_instance *cdev =3D pf->cinst;
>=20
>  	if (!cdev || !cdev->client)
>  		return;
>  	if (!cdev->client->ops || !cdev->client->ops->close) {
> -		dev_dbg(&vsi->back->pdev->dev,
> +		dev_dbg(&pf->pdev->dev,
>  			"Cannot locate client instance close routine\n");
>  		return;
>  	}
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 2f1604ae78c7..7fed7fb69d4e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11283,14 +11283,12 @@ static void i40e_service_task(struct
> work_struct *work)
>  		i40e_fdir_reinit_subtask(pf);
>  		if (test_and_clear_bit(__I40E_CLIENT_RESET, pf->state))
> {
>  			/* Client subtask will reopen next time through.
> */
> -			i40e_notify_client_of_netdev_close(pf->vsi[pf-
> >lan_vsi],
> -							   true);
> +			i40e_notify_client_of_netdev_close(pf, true);
>  		} else {
>  			i40e_client_subtask(pf);
>  			if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
>  					       pf->state))
> -				i40e_notify_client_of_l2_param_changes(
> -								pf->vsi[pf-
> >lan_vsi]);
> +				i40e_notify_client_of_l2_param_changes(pf);
>  		}
>  		i40e_sync_filters_subtask(pf);
>  	} else {
> @@ -16228,7 +16226,7 @@ static void i40e_remove(struct pci_dev
> *pdev)
>  	/* Client close must be called explicitly here because the
> timer
>  	 * has been stopped.
>  	 */
> -	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi],
> false);
> +	i40e_notify_client_of_netdev_close(pf, false);
>=20
>  	i40e_fdir_teardown(pf);
>=20
> @@ -16487,7 +16485,7 @@ static void i40e_shutdown(struct pci_dev
> *pdev)
>  	/* Client close must be called explicitly here because the
> timer
>  	 * has been stopped.
>  	 */
> -	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi],
> false);
> +	i40e_notify_client_of_netdev_close(pf, false);
>=20
>  	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps)
> &&
>  	    pf->wol_en)
> @@ -16541,7 +16539,7 @@ static int i40e_suspend(struct device *dev)
>  	/* Client close must be called explicitly here because the
> timer
>  	 * has been stopped.
>  	 */
> -	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi],
> false);
> +	i40e_notify_client_of_netdev_close(pf, false);
>=20
>  	if (test_bit(I40E_HW_CAP_WOL_MC_MAGIC_PKT_WAKE, pf->hw.caps)
> &&
>  	    pf->wol_en)
> --
> 2.43.0


