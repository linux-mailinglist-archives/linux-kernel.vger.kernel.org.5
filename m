Return-Path: <linux-kernel+bounces-13849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F34821375
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A661F21B1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988D1FB0;
	Mon,  1 Jan 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2fsRXPL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F746A2;
	Mon,  1 Jan 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704103594; x=1735639594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0DFzVDaq3+xuYI1QDhcO+BMXXnn0e9yy89GUXigXAw=;
  b=b2fsRXPL7PjoxzXewAGAOb+OxeFuNRmcyvdxAnPC9X1lleGaIPrAtHcI
   CKILYFOa4rNuuhwQmcfUr5wgA2RjgS5Tw3qGtxAXOuSrQ+fjL8u7K/MCW
   ZXk7EIzBkV8tA+D6pkrVWs5jLnZbKL5XC7QbwoTAE9wi9t6abKpFHDxUx
   zvp3SP0FC8iFbUNEK4TUkDMBkr7GFgQJTsiM9v/Z82rfy+sJ29d94oKDx
   V+0XpWpjxb0kpvnciIHGUB/TTgdaZt7mtezjmuPsrQxYFmw7zmcuzSCff
   lQPKZldF9yex1kv7fX26s+3iGqa/vt5WGE/2Y1m9eDoeb197spVmStvCq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="10395517"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="10395517"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 02:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="779390784"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="779390784"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2024 02:06:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 02:06:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 02:06:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 02:06:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQG2oTiI7zZ5UeuAY0GksEc5STTrkOo1USvqmLCFRMMhsWqRILAWqzYVtiYnkrOKcppPGLNySWqZaSoAv2RpY0iYgl9cierLUY+dXk7TFHp4Tu1MSz66r/x4mu8I+Gn6PZh98C0qRhywBGbZekptlqxeypxtg3Km8EQitPRydKLkFQxYW6ycP+PbnggldDWV8SowT251Tcyo5EXAWYzIuivtzfmHHGqHhbSw5iSCtzryUbpm285ttNFKeeR4g3FpyRxv8H/k3kE3ECnSxHf0xMJMqWI0pVymzq7jMuKh3Jsus11JKByhoNKpJh0t/a1e2GqyVVwBDA7BHPu5auRfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtaEyCOQEmriZz2GgmN5jIh44/JxFOoBPUNUlJVnjA4=;
 b=DZG8DBjrA8YmkqtjTonQA0qcj+03T8J5kJEczA6J2J5F/SqnR9beLm/Ve5yRo5+hL8WPyGhZDPnMgyp57nCYSDzft0PHZVMw5KBaU5jY1ONrcGElYSosQCZqhlfkDjiiB8C0V7pZRNLV/vWlPrTRhk1CPDz3TaNZGFub2IfpxyY26st71wx2qW/8doQCr5l0uMevjNj63h/Vyhx4fq5S+/vn1HQFVFeq84V6cFy4OobPMl37QQUaQUlFNOPoS8BkIIHF2z5vvRfD0jaKfSAXhSIs04sI/wCz2MqyBMxbPqWzc9n3J/C+xY2qMLVAkd/IJ2qHWsOUH0E5+JRxLo0qcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 10:06:28 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::159c:7c99:e99e:a3b0]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::159c:7c99:e99e:a3b0%7]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 10:06:28 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Ke Xiao <xiaoke@sangfor.com.cn>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "Sokolowski, Jan" <jan.sokolowski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Ding, Hui" <dinghui@sangfor.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"zhangrui182@huawei.com" <zhangrui182@huawei.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"horms@kernel.org" <horms@kernel.org>, "zhudi2@huawei.com"
	<zhudi2@huawei.com>, "shannon.nelson@amd.com" <shannon.nelson@amd.com>
Subject: RE: [Intel-wired-lan] [net PATCH v2] i40e: fix use-after-free in
 i40e_aqc_add_filters()
Thread-Topic: [Intel-wired-lan] [net PATCH v2] i40e: fix use-after-free in
 i40e_aqc_add_filters()
Thread-Index: AQHaMc2F6YCwV6CYMkWIY3eM15pXvrDEz1wA
Date: Mon, 1 Jan 2024 10:06:28 +0000
Message-ID: <CYYPR11MB842957267FD31A099482DE96BD62A@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20231218070850.15870-1-xiaoke@sangfor.com.cn>
In-Reply-To: <20231218070850.15870-1-xiaoke@sangfor.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB4965:EE_
x-ms-office365-filtering-correlation-id: 5a738c48-5889-4dd4-5d70-08dc0ab1520d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIHD+Rw6862MZ1f600xWp2d/9xbcm0jh4KHM4OfKKsxmgC9m9CcIWGLiGTEt1c5Uqoo7oenJyihjyB9uQZqGEzehGp8SeMu4R98g/rIdUMDt0y59Itp7YNJRcEBAvZiLG9drExEz5d9tEEXrmUqlx9g+iKE0o3MolgSu10sds3/7KqHXbvHh45c3BYY5Vnto6jNQ5Yo/b+74HzN40vsqFKQLDWdoB0fr/vx6nbDdwmy5JSOqER9d+V4S9R3W4gfQwfPDzZKqG+TZfyCWURm+ZXCgZZrbovdNcLuvwSOv1eYkM3GXRPHgxwktvZXM25V8PqmAEGRQQNo3IoM/Vt+HRPCHIq+n+03d/uyGhbjUlqWGI4Ps2b2xnHQLj60z+wNG/1+N6Swz6v4VoFDMt2+WbbRPtkYmhBLa2WIJtMug7do1FEUtz5wGNQpY5CmSSOctUnn41frEPIF0+qYjRF9kXg1FooSFUHp2jrmLHtUMhwQjIVV6LRV/egL3j/a439ppgjxDb3m6a3aPZA/zJm95FFRRaADbVL+ccWx/OqF8kK5w43JLWXcCcNnV+hh/54xm+7FfQ3X8jToG5HJN6e+oUc1fxUgq1RcmNGL48hikEeUQxCphPmOdUmC5FrykwsvO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(9686003)(53546011)(26005)(5660300002)(8676002)(52536014)(4326008)(41300700001)(8936002)(7416002)(2906002)(478600001)(71200400001)(6506007)(7696005)(122000001)(316002)(54906003)(64756008)(66446008)(66946007)(66556008)(66476007)(76116006)(110136005)(33656002)(38070700009)(86362001)(82960400001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jR0v9ba41y+dt8tvYtaeyYur1Q1gqDvWarkC7Rh/+zIMVrC4GxUG2Huf5dHy?=
 =?us-ascii?Q?TcxowGARYdXAHpa7lgRFu3wF4vhC4gP1U5zmvHuILPtCdQJ8w1zwvCLEI79n?=
 =?us-ascii?Q?7EaDJRgqIkTYfne7E5/g+116hSpjfqqEs0JjUBW7fKs/aExaMtk8sv6q0qbI?=
 =?us-ascii?Q?2z8BcyvwUABMcBfiMspjLjaQlK2uv9EleLm7QSBsHC6N8evF6Kkp6KS1tM41?=
 =?us-ascii?Q?FJ34xL4XTnGq/IL+gS+cjV4O1mX5ktrgwGZBoUIzEBNp4zJxRDWTVMnY8Jh9?=
 =?us-ascii?Q?ApGUW+Wk346l/yZ5HN7ErQAQckLVygp33kU4aif1C1w34m0Al/f2v4vM8hZN?=
 =?us-ascii?Q?xds8i00WqeGcnOycFZfJH6RUVUL3beed/PG+vpQuTHoy43AFrOi9JSPAKUmG?=
 =?us-ascii?Q?5sAXGjqkBP6VtnK6OEFpy5QoekdItyob6/koqLQIN9/wpxIlHvZ8oceIXDTB?=
 =?us-ascii?Q?f5rVfA7BnxfWFV+IfhkVd1x+Ho884hzmRbuSQ9dH9iMIt8OpoFafelyTJb7Z?=
 =?us-ascii?Q?K8iP/MogjegYAnco3JakkH+Ddket0XLc+x5eUmloxyiTx7ljg1llom4FJ/X7?=
 =?us-ascii?Q?Yd9kcC0vLuF70hBMzwBy5Fa7s1R5CsNI3sfjTvQyHSXbY8dozH06AbPRSFBA?=
 =?us-ascii?Q?Fe2MiUE2PcPh1S+V6yqJhPd05t6U2jYiiwv+q35Oet/2mYQ6Xph4uqqQLymf?=
 =?us-ascii?Q?5yyjRZ32yPHDWtZfvE99eMUR8PQK2wAwS8sVOJ7bpO1etvjyJ0XI6mN4DT+E?=
 =?us-ascii?Q?e0UXFAwg0HuMJR4GComkmM1p31qX3XTcOZP0Ef6HkAkeXnZ9IhsK5LHqhDjV?=
 =?us-ascii?Q?NWXojPlDth301iAjihrzRoHZaJ72WK+Tdeut0UHTwGUxQHaHiLCDVsklIb40?=
 =?us-ascii?Q?dGqqbKNNdoPYrORqklveyk5V9Th/D2eLudTDEIcCYhKnNqlue1bgAfxuVXXs?=
 =?us-ascii?Q?0HzQn7lTxcLDVELMQM1P91gFFdwrF9nNdpTiE7QINcKb41pN6zcrYAGTx7s+?=
 =?us-ascii?Q?Pe1mYBgUkJd5LV8i730xlfFBCYGJGjwsTKMxZX1syMbdj/UBCzQEnVM+UUBe?=
 =?us-ascii?Q?fEBp5JaD6Uli3wO1E808tMl0jSwVFv5HKOWgsu2QyVz6BEk8YWfngv7QL9w/?=
 =?us-ascii?Q?dJe3SZO5QhkGSZ+IfA9SIJGckLgDTm6dtLatJr5IIV7GNo6HlKLwoycsG+zn?=
 =?us-ascii?Q?kISe7b7DLghhBowF3SoPDH0BopsWjpYqlSSvYZ2HFC96l0VJxKad8/PnCnBn?=
 =?us-ascii?Q?fW1n/jCP5mzfr42fdhNphdkILXAIh5ck/7YdDnGis7Th01UdvaszTlpt9w7t?=
 =?us-ascii?Q?2yXtUmUNWOME0ZUWy93g3TEOP4x/e/UJfJmg8OFl4ahBi2shnbxv52jTcspL?=
 =?us-ascii?Q?ikY/EtpnPTC8CCWeld1HX6x+SvnDWpNp9+50DAvDHDnLoeEjUor6F6Lnn5hg?=
 =?us-ascii?Q?fZBh5GlnUuHxqDDvGwKhiPWph06b9jI1nnMd2p0zvHJppDkz2nK3v69boekU?=
 =?us-ascii?Q?UGctmXhAkXwVWIjpwYkXmWDckXjFWbPu+M3beeNGILfh/uAGfufTL6G5EWE0?=
 =?us-ascii?Q?8hPkfuXci6pWwkVugkB17iqeRIyHMSyNfScdCx1TJw6jbjgPcEAhC3HrBkZI?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a738c48-5889-4dd4-5d70-08dc0ab1520d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2024 10:06:28.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHbIDIVsosNX5YIXYJDjZqtsxUcu9SF2tx8xMgpXXOvoEufStaLHYwE7swm82yNR7rtXSxTHmfOg5WyRBQn83sUqkKhQ5ZNUwtSma1UVBbnIaEij6PlCRN/HjmPZLR/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
e Xiao
> Sent: Monday, December 18, 2023 12:39 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com; kuba@k=
ernel.org; pabeni@redhat.com
> Cc: Sokolowski, Jan <jan.sokolowski@intel.com>; netdev@vger.kernel.org; D=
ing, Hui <dinghui@sangfor.com.cn>; linux-kernel@vger.kernel.org; zhangrui18=
2@huawei.com; intel-wired-lan@lists.osuosl.org; horms@kernel.org; zhudi2@hu=
awei.com; Ke Xiao <xiaoke@sangfor.com.cn>; shannon.nelson@amd.com
> Subject: [Intel-wired-lan] [net PATCH v2] i40e: fix use-after-free in i40=
e_aqc_add_filters()
>
> Commit 3116f59c12bd ("i40e: fix use-after-free in
> i40e_sync_filters_subtask()") avoided use-after-free issues,
> by increasing refcount during update the VSI filter list to
> the HW. However, it missed the unicast situation.
>
> When deleting an unicast FDB entry, the i40e driver will release
> the mac_filter, and i40e_service_task will concurrently request
> firmware to add the mac_filter, which will lead to the following
> use-after-free issue.
>
> Fix again for both netdev->uc and netdev->mc.
>
> BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
> Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379
>
> CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
> Workqueue: i40e i40e_service_task [i40e]
> Call Trace:
>  dump_stack+0x71/0xab
>  print_address_description+0x6b/0x290
>  kasan_report+0x14a/0x2b0
>  i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
>  i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
>  i40e_service_task+0x1397/0x2bb0 [i40e]
>  process_one_work+0x56a/0x11f0
>  worker_thread+0x8f/0xf40
>  kthread+0x2a0/0x390
>  ret_from_fork+0x1f/0x40
>
> Allocated by task 21948:
>  kasan_kmalloc+0xa6/0xd0
>  kmem_cache_alloc_trace+0xdb/0x1c0
>  i40e_add_filter+0x11e/0x520 [i40e]
>  i40e_addr_sync+0x37/0x60 [i40e]
>  __hw_addr_sync_dev+0x1f5/0x2f0
>  i40e_set_rx_mode+0x61/0x1e0 [i40e]
>  dev_uc_add_excl+0x137/0x190
>  i40e_ndo_fdb_add+0x161/0x260 [i40e]
>  rtnl_fdb_add+0x567/0x950
>  rtnetlink_rcv_msg+0x5db/0x880
>  netlink_rcv_skb+0x254/0x380
>  netlink_unicast+0x454/0x610
>  netlink_sendmsg+0x747/0xb00
>  sock_sendmsg+0xe2/0x120
>  __sys_sendto+0x1ae/0x290
>  __x64_sys_sendto+0xdd/0x1b0
>  do_syscall_64+0xa0/0x370
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> Freed by task 21948:
>  __kasan_slab_free+0x137/0x190
>  kfree+0x8b/0x1b0
>  __i40e_del_filter+0x116/0x1e0 [i40e]
>  i40e_del_mac_filter+0x16c/0x300 [i40e]
>  i40e_addr_unsync+0x134/0x1b0 [i40e]
>  __hw_addr_sync_dev+0xff/0x2f0
>  i40e_set_rx_mode+0x61/0x1e0 [i40e]
>  dev_uc_del+0x77/0x90
>  rtnl_fdb_del+0x6a5/0x860
>  rtnetlink_rcv_msg+0x5db/0x880
>  netlink_rcv_skb+0x254/0x380
>  netlink_unicast+0x454/0x610
>  netlink_sendmsg+0x747/0xb00
>  sock_sendmsg+0xe2/0x120
>  __sys_sendto+0x1ae/0x290
>  __x64_sys_sendto+0xdd/0x1b0
>  do_syscall_64+0xa0/0x370
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subta=
sk()")
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Cc: Di Zhu <zhudi2@huawei.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
> - Order local variable declarations in Reverse Christmas Tree (RCT)
>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


