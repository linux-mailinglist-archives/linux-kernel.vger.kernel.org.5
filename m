Return-Path: <linux-kernel+bounces-10003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FA081CE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D5C1F24B05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B02C1BB;
	Fri, 22 Dec 2023 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHWbi4a7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6F2C1A0;
	Fri, 22 Dec 2023 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703270712; x=1734806712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GuULqmd5XTsmplC5Ex/gyX5fEWOCJei/JNaCuV69v4o=;
  b=dHWbi4a7bdUfmRaL7hQu7QCXlVVKEiso81k7Qwb74N20AVvh0PuloA8s
   w5UbOxi0r5o/HJ/mI/3lORSXI9qEH7Bqhndq6X/A2WRgmmiIg2Rfi3hsL
   9VWpZNmewhk1Ar0OubUpP9A0F/2Phx1D9l9JPOdXY3l+ABpVBVA6G+vX+
   Zb/jxckobnzOY4On68yKLzkPizm0ros46W0FbrvpM4Bhf450QLwi6bWW8
   2glPXUqdNY3uXHAatqw17Tes9LVoDJ4RPFXMZDX4my+eVgBsAMXflID/c
   zg8bqoFj92fFltM6MTSyzDR8yPpBTx8olOAfewHZzdenxzvddar8g4qNX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395887000"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395887000"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="777112426"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="777112426"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 10:45:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 10:45:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 10:45:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 10:45:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 10:45:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6CgpMCKqdLHP56zNBTSuHiaYewyoP9PvheO1lEKxaqGpCq0XgsL1l3Onsvgw/VOjLu17snXVbQqD9Rh8VpKZnHU0D/TCBWEuGcwkAuxcEpB0C61T+O6arMTD+vFHQx6CP9P1GTl+wT6ZVcboNmQkzc11Oploh2ckpAN93LB+R48EIC3R2COb/IP81Ze/lkgoTJXXFGnhFqGqxpLfmVHKGWPw2K5ThlhP2AoacGEGLc9Te1X9h6+P3Mrbw5jAzZIzU874I61FH3K1a4QlyjpL5hb0L+apwmiTmAVS/LKsUcrODkD0pl7sAO5zvEpBwzrwXKa+D3/jgrh6s1JrZ7HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj6j4ZHtoq5ot8f/XHUV8skvVJy2JAGZpyNDDHTLt2A=;
 b=jL7XY+lPA6IBMLvLRoCoz13woFKQE7laYOsxfj6XjHi1CPfXZzsRB8aDnKa1f+OONvy16Q10r1Hd1CD/ez8eW2tYqu/UJh8V4u9D6yqal4LhhAn4sTVwkhsW+JbrXSD1bSLOu5XONPVV44KtmqHp0S2xteWrhV5nx7Cv3UWRVG6GaDXQ4dlpK06cjo5UcsvYgq9syKnqdUt2ih68F9vYq5UlBIuIzp1g1xWbid5yaRGI3oOYzR/fQ1DnqOQVbsqPPprejoYKRkEspETB+0wl+I0uNROYPKQLKNmVnJfZt31tVGL8SKKPmSsnmPOtFsnuWkd0JjZS91kUDO3Boqgc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 18:45:07 +0000
Received: from CY8PR11MB7195.namprd11.prod.outlook.com
 ([fe80::6e9a:e84e:338b:751b]) by CY8PR11MB7195.namprd11.prod.outlook.com
 ([fe80::6e9a:e84e:338b:751b%7]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 18:45:07 +0000
From: "Register, Scott" <scott.register@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Eric Dumazet <edumazet@google.com>, "Kubiak,
 Michal" <michal.kubiak@intel.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix corrupted frames
 and skb leaks in singleq mode
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix corrupted frames
 and skb leaks in singleq mode
Thread-Index: AQHaLC5PZQq0fbfFDE2hLm0GJTRZsbC1sm8g
Date: Fri, 22 Dec 2023 18:45:06 +0000
Message-ID: <CY8PR11MB7195FEFA59AF60D8054C04C99794A@CY8PR11MB7195.namprd11.prod.outlook.com>
References: <20231211123144.3759488-1-aleksander.lobakin@intel.com>
In-Reply-To: <20231211123144.3759488-1-aleksander.lobakin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7195:EE_|SJ2PR11MB8401:EE_
x-ms-office365-filtering-correlation-id: 213712d9-528e-4b03-17be-08dc031e1e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NlkeSlZCoytoVHmKN3lq1ONC30kjZ3Bu2RKh842yyKoMpXH7r/ZaE550o5xIwbjzKJp7cAl02cksLIxP7ybfsY+/x3ORyjU+AyYJv/+kll5u7+xYM9I8/9sCXL/tLOXbZ1Soc34Nw1JUuz4n4C5fgqgW4NukMdwiq4DtvVAI6gTC345bH+ha8uK6BBWpK6Xzrt2kyEKu4hwSAC3UGmjKRweX4YWLt3+Agh27jsCfMDE5MioQOmw/OOyRgpC9UNG7FdgKgUrbhzNFCNxi/ANBxw3Uh/BpGJEg2xOpmxu8Nt4HS1hrLISfzO2BEZ5pkAQzXh5bzBrRnEPj/tlOCsTnPghIW9Yzabvgm7KEyNfmyV1Lzyx9AYN74RfjKl40F7r4gfR6u8/Pw8/ayetaluVfql4Dro0auD7fvIHDB4nI+skdjO8+UOV5Q1512uTSpkCoz5J2qVmafhhdNato2iYChCwBaiRsBjBEwp4AvWNziDdLvX6HMaAQvXnjG8T1MkhAzskbZoubMNLHqCH8FXc4dwMddhszPHz438b2WpTiROIjJZI4ka6wAVT2HSghlf/yb06I4hjT56GEt69yZbo5Gu6b7O/Y05qt+ldPKBcLJsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(55016003)(478600001)(9686003)(4326008)(122000001)(966005)(52536014)(38100700002)(53546011)(5660300002)(54906003)(316002)(110136005)(66946007)(66556008)(66446008)(8676002)(66476007)(8936002)(76116006)(64756008)(83380400001)(7696005)(41300700001)(71200400001)(6506007)(33656002)(86362001)(82960400001)(38070700009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jl9HC/FIPdur3GnyhQtl+3vUegmtPsIm9f/FByPjf7gCYtn+BIOBLhGZCeVl?=
 =?us-ascii?Q?CCYuuQcamzYSUkZw37W+MPE6NDNPgLgN7JRuZIsLZuwmAxIeQ927a3w+kihh?=
 =?us-ascii?Q?Fsq4+C6Xd6E+tgrvJ81pQlrwne0hwJwsh7JAUnI4mzo+tAkivVz3MvQw4k3S?=
 =?us-ascii?Q?0sdPVAY4gS9djHqr41tUBYRLDhQrJhfgqYhb8Ze8t0zpjQgFQoF51hoYPyzf?=
 =?us-ascii?Q?mvpI8CfWejEIw8eVBIZsKoqYv4qYqFc9+dlKXfbxIdg9Q9cpQBl+rcWMMC49?=
 =?us-ascii?Q?osU8ys6MzwjvczGkwDRZThlmeY825gsnf82xw0niYY+1kx/po5+p4B9R5uCz?=
 =?us-ascii?Q?WUn6ynFZQCXcK12rMHepmDpjWWx9UkXc4RTModcbmrygbb82XWHvg80AP0HF?=
 =?us-ascii?Q?TAvTlKbXNVtay74JN+Z59JkUDBH06LbP12vC5pa8JNjkYhzPa5VP879hODy3?=
 =?us-ascii?Q?9ts/LSb37LN5y8SqN65jwpoyaHMEMSBxEpVC/BThLSLqxRBZPGvQJulWn8sA?=
 =?us-ascii?Q?kqPY7Fx4xGnHcpgH15aqOY1/Nd3m0ikKWc/bC2XoG12fcygAHskG9rPCd9Up?=
 =?us-ascii?Q?IhF2gpOBy9MwBRQsU/fInKdY3MKk9ov5Wuz9t5iBgu11s1z5IlL91hOpP0RH?=
 =?us-ascii?Q?+UrZtV9LOuJIannbBo6A/y1oDjJL3FtSZkluR1phOqVnCgix37iiok8G94p5?=
 =?us-ascii?Q?pBHDxxW/4IwTxKruASo3g91zDWBTqnXt1EMNArGZDH28yIwTmKyjHXtXMHwV?=
 =?us-ascii?Q?GFU6GbOBGmTZ0enS6BK/p0gxvZ+J9OHP3UgY9yJtQ1PSt/rqhiM0l/WpSWZq?=
 =?us-ascii?Q?Terre8/dyMD+v3j14u7hi2EzBVhbfC8/85wbW9ct5RjRA9cJsDUwDEbn43B+?=
 =?us-ascii?Q?VMx7QrW60PcEGdqh+w+mQrNvanqssfGiJCARUZDcxEi63/sPaSMQolZp2+QL?=
 =?us-ascii?Q?6P4++XUfLXy/I1BRK4KClo+AHYiyIn1PwD+LuIZyGUmbMFUESQBS99uBCI4o?=
 =?us-ascii?Q?j0IFzgf6DwPoDfubKG8B7AcKG4u9bLvD5gtOs4lGZgsLzN1NseOi22iZ5mVu?=
 =?us-ascii?Q?e4Ha0+TyXn9a4nPOn855bF9fc7IPZvEEof9NGMyXeCjl3wQvniCz/OKIZNQx?=
 =?us-ascii?Q?siwxk/14DDte0M04dBEU5cjIoZNQqtke7Fd75uZKCVEFF8yUWRLqVc8sUC11?=
 =?us-ascii?Q?GXCpAxDRnZ0gQssoOyuzp5FlkYsU3AHqYxcM2VLnYJEcYq0uAMTPmWaN+zkU?=
 =?us-ascii?Q?ZPg6jUrIvunu4wwheR1SKHwykMcDAsZxZrXMSPXSwAjecRosB481hHpH4nHz?=
 =?us-ascii?Q?2X7qVare+/fu0fBk7cx0VP2TReyCVHwMne2U5YKHLaA/bBxqmq3xoyhNMpgb?=
 =?us-ascii?Q?gUsr60D5GyREKh9OjW8Kao/XT4G3ZgmOUWPf62JkgdbOhch8EtXK3JTYxZvZ?=
 =?us-ascii?Q?Gx0qYGtastq8zRcRBOHpZv3y7dEsJltLnaQgZG3GtjVWeIFs6aip2rZg0ltv?=
 =?us-ascii?Q?V0LX0C3TGBml6pRONcI2xVMxUGPt9Fo2di2+V7qH6QMwgDCUv4nZXPNYjr4Z?=
 =?us-ascii?Q?5P0KXR2+ONcnHUUu4YmSaBdM0h4qUGWI7t6LnjlRueqCcHSr3Ti6v3mJ5KEL?=
 =?us-ascii?Q?agmE3teCLkTp1zp+t3dE+oCaHaadhb0CaVXDu2teqrIq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213712d9-528e-4b03-17be-08dc031e1e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 18:45:06.9297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtOTBpF+rQb0mdLtDQp64U8CUlNr9piqG/wM6sNu5CREpPzJTnE+Wid10sI5I1ilSLY9DLm6AV77ZNgy0727qgHeni604SWli3bnwuFCBMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: Monday, December 11, 2023 4:32 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Kitszel, Przemysl=
aw
> <przemyslaw.kitszel@intel.com>; linux-kernel@vger.kernel.org; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Eric Dumazet
> <edumazet@google.com>; Kubiak, Michal <michal.kubiak@intel.com>;
> Simon Horman <horms@kernel.org>; netdev@vger.kernel.org; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] idpf: fix corrupted frames =
and
> skb leaks in singleq mode
>=20
> idpf_ring::skb serves only for keeping an incomplete frame between
> several NAPI Rx polling cycles, as one cycle may end up before
> processing the end of packet descriptor. The pointer is taken from
> the ring onto the stack before entering the loop and gets written
> there after the loop exits. When inside the loop, only the onstack
> pointer is used.
> For some reason, the logics is broken in the singleq mode, where the
> pointer is taken from the ring each iteration. This means that if a
> frame got fragmented into several descriptors, each fragment will have
> its own skb, but only the last one will be passed up the stack
> (containing garbage), leaving the rest leaked.
> Then, on ifdown, rxq::skb is being freed only in the splitq mode, while
> it can point to a valid skb in singleq as well. This can lead to a yet
> another skb leak.
> Just don't touch the ring skb field inside the polling loop, letting
> the onstack skb pointer work as expected: build a new skb if it's the
> first frame descriptor and attach a frag otherwise. On ifdown, free
> rxq::skb unconditionally if the pointer is non-NULL.
>=20
> Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> Tony, please add it to dev-queue instead of the first revision.
>=20
> From v1[0]:
> * fix the related skb leak on ifdown;
> * fix subject prefix;
> * pick Reviewed-bys.
>=20
> [0] https://lore.kernel.org/all/20231201143821.1091005-1-
> aleksander.lobakin@intel.com
> ---
>  drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 1 -
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Tested-by: Scott Register <scott.register@intel.com>

