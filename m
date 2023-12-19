Return-Path: <linux-kernel+bounces-5946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B38191D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE69282165
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D83A262;
	Tue, 19 Dec 2023 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jALOKudR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11339AEF;
	Tue, 19 Dec 2023 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703019575; x=1734555575;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=e7BtUS9MQYDzayUC9zq6TJYgMHBtNGBcKx77WT7eifA=;
  b=jALOKudRg2wxEE5R0nQOGqNvDc4llOdDsgysi2qBY4WZWMZeW1oP3MMs
   A27egnHCzYVj+rdE7nX4dt56juCx/Gu4IQjeTOWRjnOmbZ5D/P9gQB7js
   /Z2CE03cs1NBcAWyNos5bzgH/Bxc3Hwxr5d8roFY2viBSI9tJjNMh6bYy
   X9Su6bBQoCygaKnTDEofoaAQXqPqXQLyC2t5HaMNnqyRZ3C6Pjsvj8NY5
   Sqio40gfYdOvF2fqWyHt0MbP44bfqytOSTkn3q7swnxJhXZNijKpNQ/hq
   dRpdo4nNqgnfJsNALJ8u7lgyy5WQRhW/jHymCf6svra41Hiu7REqbiI++
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380701506"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380701506"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 12:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1107490313"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="1107490313"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 12:59:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 12:59:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 12:59:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 12:59:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXxrhV0zacoXE0lVuFIMiExih+pSAA1kD/L6kUMY4ocFeNtjWazwjPueD9s1GRXzFnyP7i5u9l1PY4db8lOXvNCsISA6VmU8Lm2TBo3o6cn5fW6goOSApNKF4OcvVe2a9khVjM+HoYSGoFxLf/CWWxq7w8Um5A4XOyzOFulvvKskk5FsHQjLXK2eMDro05X0Dyg3qSn27zBSKaSKLEpDQGJ3Vtr0ARt4K/wFjFJBf80td5sJLt7lPoulHHE0elymuIpsGYkEhZqUoJRomOv+Ag0Duir0TENQhGfjF5It1hBC0Ccu3sT8M3EhrsZgh0dQgoyU89E6E27yviWQeMEcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7BtUS9MQYDzayUC9zq6TJYgMHBtNGBcKx77WT7eifA=;
 b=nJZGCVEEBQWhoIvKTu1qFnglMvV6pUIHYNmFOmkr5704oFRifmMAZ5nwULcEyuOSu2CxD7GtisO4nR4qIs6Rs76+Pi7Ra6Sruo8/k6hDlwDGpeLjXUDm6aONqXDgu3UqfSMSj5tGS5aWOfJli1RAKKbyT9Zjeh3IKAwo9WQj3wxa4kV9xtJZj5m2RNcLlH5B8uldeg96woareuN8c/4rKYxLHe8UTuBsB94ClbzbHY95Jnv2bpI7wBSIC7mubew5t1BMNeXD9DhZAzJ4U8/f/6aJZCEEGSjHWw5QBJiypqI+jH7DEsN72PjzKjxP/3tPiF0LbwwrRP8fLsCb5ZZ0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 20:59:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 20:59:31 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Suman Ghosh <sumang@marvell.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sgoutham@marvell.com" <sgoutham@marvell.com>, "sbhatta@marvell.com"
	<sbhatta@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
	"gakula@marvell.com" <gakula@marvell.com>, "hkelam@marvell.com"
	<hkelam@marvell.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net PATCH v2] octeontx2-af: Fix marking couple of structure as
 __packed
Thread-Topic: [net PATCH v2] octeontx2-af: Fix marking couple of structure as
 __packed
Thread-Index: AQHaMod55ycMQrS+3k+xTcDT8rHZkbCxF2GA
Date: Tue, 19 Dec 2023 20:59:31 +0000
Message-ID: <CO1PR11MB508955C19602967B0284D262D697A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20231219142633.321507-1-sumang@marvell.com>
In-Reply-To: <20231219142633.321507-1-sumang@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: ed0a8548-9078-4cc5-8367-08dc00d565d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rj9bl46CO8A0AX+EVdiRGxnuZtA6I+P5NoMf4Ssbd9kpUnesAPGr3rs+3AXUsCI9uimtvAKwNXX4ia+Oh2YFP3buFomlCN0QDOhYehkDIXy49vv9T+ix9W8qaprVpurvdDMJZvdU+nUcF3hpEhXtzRVEyDNYVFAEnF1UF2KgM5viSYSvAAtu4Y6ZxA5WbVfr0T7K03gqdotlQWZJ4XXoWQqAvBfWVH4+5YWzvEszaAEmvCSCl8zVNcBf6SXvQ+GjEo/O43KgW5xRPKMnfvWlHZPB5NP9sPcrLyffWAIrCPavyWPYbUFbyDHVSuf5ZnXYRXxLwiHt6JUydTJFtQ+gLvjuBNAOEkxTl0doz66K3lIuCCWngW64TSprjQbJU4yC4NSSGKPRG9QbMMxsRu3naQmtEEGj31WAh+1t8HB8kqeG9X5Q1Wty8sCcKg3/ftdRIhtq99CkNLFHX3b/fqVvy/syctKNZadcJkInL7LCSsRwGOZ5bG/U8zaLU/QgCYtfgwV2GjSoOGBHVckwx2dHMlw4L/4bbTZ+CdztdfojnGPZBr0vXYwsLbw6erApj5T/Ightd41uFStTC0nHC0zURtgHeBpuXtlQtjTDVzT8U3q29sYe4HLOJHtDBM9I2B0WciL19mFLaQE31DOmIqBfRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(110136005)(66946007)(66556008)(55016003)(83380400001)(66446008)(316002)(76116006)(66476007)(53546011)(64756008)(38100700002)(478600001)(26005)(8676002)(52536014)(8936002)(6506007)(7696005)(71200400001)(9686003)(7416002)(5660300002)(2906002)(4744005)(33656002)(86362001)(122000001)(82960400001)(38070700009)(41300700001)(921008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfssd7wvsHCOk/n2qTWSekofw+NktyhZfAsIuS/VE16gFdlRSTcUdhYHoN4e?=
 =?us-ascii?Q?PCHRV3i3yP1vkn6Ud5Zhtis1NjvyGkq0Bz2OtsqTzl1kaial6Wu5WoZmUowv?=
 =?us-ascii?Q?srF9pWncnQQDvyJt8GRJdxQfLFyd0fhqpRksE4YeiZgZKGpXoATHHPanD2M+?=
 =?us-ascii?Q?8CJunL/wjkZcK/kiw1ycitm7qZnAZifl+osMwpxl49SZmGZLWrudrsWs4W4t?=
 =?us-ascii?Q?B29ncsQSSSjPEwap0/cM/Fm0T2WvM6elAOvfs9aMNU0Ii+e40M3xeNrXuLoj?=
 =?us-ascii?Q?4CCUQPNmtD+DNf+5muKG37emX7IrN4cBcPaFwMRtH4XZPdb8vTlVbZSKJ1fU?=
 =?us-ascii?Q?eCqRAIy5pG3FyxXiStZmSLtBKGNpkrSsOFa0sR3KdsstSCA5WChqYL+8f1lS?=
 =?us-ascii?Q?pKyhzMGRdPllBB05/N2lrSeI3C5FiL4b4mbxaftlHkp1WAMsWgx2UixDsAiW?=
 =?us-ascii?Q?+ZkwKXeRh/5UIQCJch5jGT6YWphO5bgDdw9GSNEuC9PLJKo/XEnzZliL8bR2?=
 =?us-ascii?Q?cFBsVQ638cy5oP8hOFeSdr3GVEf11vVpX9VlmaFXow+xYfsqEMwa+IcxXUlf?=
 =?us-ascii?Q?rvOjbx2VhgqhWFzZJz/tKXtz1BEF0lT/mgjrOONSQNQJLHFEvgkKsn7XgmPM?=
 =?us-ascii?Q?1wSX3YotoxmJTEtwTNsxDZxwZrfwFjVFFVp0AFA8Y7TIeeijMWutwPeqK9r5?=
 =?us-ascii?Q?vOlKeeFeWF0h0nuMFJd1J6gJ6OoTNtDl84pwYJ+aTrD6JPaQtagOs5CSKZuc?=
 =?us-ascii?Q?AZQ7sFCj5HN3eef9jPnrJoCBFYuIbhEJiAFqvsBQFUSLtifF3u9AM0wS8UUz?=
 =?us-ascii?Q?bHdkypc1MwTHIj3l3FCszZQGwG6Urhzip1EcbtCJFgx4jblOGaEe9YpiQzSQ?=
 =?us-ascii?Q?hQWn3/Ok63JY9iRu7Hu7YLr1D2PesA1mb1ORjOLNfrKZV6HZcVNolby7IbEY?=
 =?us-ascii?Q?Drf5LmPAp80I4xQj10SmC7DhN9WXjUffH3sOCxZJfD8DAnSYMfsOVrRa4mz2?=
 =?us-ascii?Q?AL9GJraFWfjwykI7jWxdNL8qD8snzpL7SHgXqWZJQ9wdtispPJWrxsdR91KM?=
 =?us-ascii?Q?o6maVkoYWA/Txa47iRV9EZGjSwSgWmAnrSdkSrrXvaGMAnuf/DxS7A/sUrfv?=
 =?us-ascii?Q?MKBo4r9aFr9FR6AtGnd1gP8eejUiqITUH/7YoZKBgCkP7XJ97BlM6ZTYKd7d?=
 =?us-ascii?Q?CqHw594/fqbPcPw0aNXxMsUUKF4s5OnJhOBkGoL49ug5GDZJQN4cn2cmoxVF?=
 =?us-ascii?Q?7LtLuDooH+bb92YlxTXt/0/001Mbh4PGL1Tlgf7z9IPZS2WPi9xU9//wMRNt?=
 =?us-ascii?Q?RRyad3kHtjy9eblqTJaguFEAcjOsSfFHThWXuCGGLPYKYphFP+1hOZ/iO57r?=
 =?us-ascii?Q?tHf/h4dMBCRhEcteWDZ9pRPA2g4eKyGzxkiqr+S6AlrlZLvjox44wEacXTLD?=
 =?us-ascii?Q?efxMuEJ7z+lM0utEcb1Gf60+FNUN+CO4BRmEZWXV5R/hRXJ6GbP1MxJCHksq?=
 =?us-ascii?Q?5C7XZtO5IiCDsQYhtCQxGRlyl2mmCNBPCaZ3/UhOimyxTL3gk24YJc89MJxR?=
 =?us-ascii?Q?iHOtvesT8P7tGybUmkTjdRgktK20OlzSPHoPsg7M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0a8548-9078-4cc5-8367-08dc00d565d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 20:59:31.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjxCMcB+3gPUvW0wzTj438v8Br9W6lKeN1ZbJCqkgeowZ2ASYHLTP9dhpVpsR1gzmQQ97RGF1eQ1+Yhf1o8ke/g/6sJB+kH2eNEe5SfAB38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Suman Ghosh <sumang@marvell.com>
> Sent: Tuesday, December 19, 2023 6:27 AM
> To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; sgoutham@marvell.com; sbhatta@marvell.com;
> jerinj@marvell.com; gakula@marvell.com; hkelam@marvell.com;
> lcherian@marvell.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.or=
g
> Cc: Suman Ghosh <sumang@marvell.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: [net PATCH v2] octeontx2-af: Fix marking couple of structure as =
__packed
>=20
> Couple of structures was not marked as __packed. This patch
> fixes the same and mark them as __packed.
>=20
> Fixes: 42006910b5ea ("octeontx2-af: cleanup KPU config data")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Yep, thanks for improving the commit message.

-Jake

