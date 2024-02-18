Return-Path: <linux-kernel+bounces-70133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B668593D2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58364B21526
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC132EDD;
	Sun, 18 Feb 2024 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4YFLzlN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA36EBB
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708219418; cv=fail; b=seDFWG9BC/4Vmvlqo6ZHC+cAl+lifSMPivGl5Dv7HTRCoeC9B9a3R5LWZEoRHPIc7p7y0SVNd2TrznnJA0NcHPKcXuobycBhfuiR2ta4PhHkYlIR0LAbT+QLBYiEoThumLlmH4wAUKQyZ80g9emA7885cw5GzuhSf17K4HslUt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708219418; c=relaxed/simple;
	bh=2hQVySRjMZHlQmfnMebwOF4lFbPzNyxl4WIwjA/RY0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aOMx76R40Xx8mj+Z62LzlhvoI/Fx9hVLkCfkRKbr/+JvjNKlRCPNsTftIHno/hwxs/93noccE67UaXYIwQlGvKjodtjj7YglMgC0wYnecG/TZLMOYHsQzlFPyZ8K3hP1XD2GSvzeaduuo+64T+eOFn0pTXM+CPpl4OLUiPaWeqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4YFLzlN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708219415; x=1739755415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2hQVySRjMZHlQmfnMebwOF4lFbPzNyxl4WIwjA/RY0A=;
  b=C4YFLzlNC+rXy0mEhTr0B8NI7Qt4DAYpDFsNMy4MI0CbBbJ8KI05p3qo
   vLmrybIuUseC9Bbd2uO7tYkH1LbrCbcgzRfnrOuOVFob5L8x+alnfVYTI
   Ne0IChlMbdwplnzSjovGqBs4hQ9t7xAsbZouEf7I+TwxaHthgzs++XX8W
   psrSzer0N3LtAQVLqZ3nfuG9sNu2AfUmOdr9lJfN+/PtZEcwtdGQIiHay
   VSJYBNyXrZ4eaH8iGKx6gq/1ri90iHlnwymjkvEbz3+UcU5ke9xLc3ZU9
   fmtCPpKHPXqD7RZv6yz4HJTeOZZIq99vvSpzCWRhjfFDs8MEuL/06+mMQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="5281955"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="5281955"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 17:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="35211104"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2024 17:23:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 17:23:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 17:23:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 17 Feb 2024 17:23:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 17 Feb 2024 17:23:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCJDN1fN48TfDbYjL7eMHWIGsl/AqR8lJVf9N+HxL6FgQuK/e81WDHqL0nbECEfeK4tEzEW1zrsSIy+IHI+z+R5b57tbWh4wIKWvQREqc83OO1NSa3Cg9LITPhAkR4v8CgtPJdMRyzy7yvrbHGy30qRlHJqHMIy0GCGgodzDM5sd4QGsSgAKo2wzr4FE3ZmkdacYMdF1NBkUoIstnUKmB7LxnTsPw2WjAsMPy8XoHmQZIZ7iGcislnz8m+bNh6IafIyhF3JWE26DGbqj6WgIDSEL/PmmsPQ9WpNollC+9xHhr2XFteMPhe6NXqPPqEz7SeXgWJHzNOfmkHaltPLB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYyR/T7lnAObrPChaS2JBYqx374udQPHTAnseP2PyfQ=;
 b=Jj1SW5691YOMXOSuB326WOp0O2EBsIO8ICyLE/2PrQG1cLLMmMs4tsJlvUdMw4TI4ItLdi4FpDo2DJVF1KjIuFnly1I8VGxAw1F8FOn9iTtbAjjI3bbW9bP7g4WrWrB4ernh61Z4ha4Vrhd7uxh5iF7/arrlfrjkupgIWdZnyCpz1zo+cAG/mklIs1OCSVSHIhBopPWRjc+RtMZsE7wdDqoYpDe0kH5HyiIYOKuTzxpE5tvbOfyAEMxpfc7UsMqX6a/0jfWoPsyjoeV3KpddJWg6hHE7jbTu+f5etiJwi4V6lHvAoFvOaFbnqYIeMNXrSnhayP3mOEpqtv7L4FfKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by MN2PR11MB4727.namprd11.prod.outlook.com (2603:10b6:208:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Sun, 18 Feb
 2024 01:23:31 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd%6]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 01:23:31 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] mei: vsc: Call wake_up() and event handler in a
 workqueue
Thread-Topic: [PATCH 1/3] mei: vsc: Call wake_up() and event handler in a
 workqueue
Thread-Index: AQHaXZha9/Lhx161gUKUqkYDIUauW7EPVLgA
Date: Sun, 18 Feb 2024 01:23:30 +0000
Message-ID: <MW5PR11MB5787CBE779AE23D84847EBB48D522@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
 <20240212094618.344921-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20240212094618.344921-2-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|MN2PR11MB4727:EE_
x-ms-office365-filtering-correlation-id: d7d440de-7681-42d1-f529-08dc30203799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbChltwEAGFBZKd4vGFPGP+K4tlfZmng+AZonSUy40d+MeSCr8VY9hf2/XX4eRqfGWQSVpRLyNrWVK5joMeRY2b/4+ThB8CEb0h6uOFzarufucpswSNLUaAbPYZT265oFoWDzbGAnvMVL0d6ybi8HIS7zRvPg6YS13CatTEkce4MKQZ6eQ4POaPC10ihxLivI5hwgvaTPzghrjKMTHi5VhI62Y558CNaIEe0zn0Z0A39el5ehcp3KbxI0DXJP4PIgvtlintDrSbilCguS9gQBW/jPLBCvbvfwJKBpl3l9FUeqW8+85N9V3Dgh4HJllnB2zhr29qfIpCMH6U/fmOlyk33Gt63DqpJ/sWBJ0fkiotDvia26qFPmuEMe28V5JTiapBiqLN4UbHB8lTKA7ceJssCO6BoS95/sGF/qkmh3OjdG/UgKOUJODeooVEMro6uPH7/PNBp1j1s4pvK3YS+AtQnHZfEj3XxyXRpJcJXvAtAxaZvzJMeOmntmgE1l9l5+9hpQ7QiSTqPHkKaeqoSpTV0O7scN20P48ztMfg0buSIUJgySAuCd6B5/cx5QUpZohK4rmhQfo1RpDLE9YhItrWWZrBWDMgH0NWGxm0okbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66946007)(6916009)(64756008)(66556008)(66446008)(66476007)(8936002)(4326008)(52536014)(76116006)(8676002)(2906002)(83380400001)(33656002)(122000001)(82960400001)(86362001)(26005)(38100700002)(38070700009)(5660300002)(71200400001)(966005)(6506007)(54906003)(316002)(41300700001)(478600001)(7696005)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ALHk+IB2zqVwffu/Lh4BGococN0wBci305AclzCZcCgBdUk1dLNXGXUkW8HX?=
 =?us-ascii?Q?HdpVZ0O/l2iPt5Xzh9dczuCFPsTy93a81tVcXYRPK8S9hHifTpQTpwPflkWx?=
 =?us-ascii?Q?7vpvBmWK0bllbtp1X6QdksgrHbFD0lWFKkwU4mrQoDEv5z1nt/CCEoab5V5m?=
 =?us-ascii?Q?zg04O9aer41n2t84L9vJfEHADpJzaT9H+iYAIC3sQnj/NIOvqNwI3t6hk9Rv?=
 =?us-ascii?Q?hzE0a/ZIHtEmOiFK42Fy9v+Nv+LO5BE5boQ9516LVJnUuT95WtGpeuBo12Iw?=
 =?us-ascii?Q?vnUlQsjXzHAryFrLzzaAV6m/ZKvd9d0m/6fllVmNB/luJbJU9GLgHT12WFLU?=
 =?us-ascii?Q?FRWI0ibvI/nQZaY8ZR2S4dR0iguFU9NhCmd4ocg/APITuONbEo3p5X4N/kk+?=
 =?us-ascii?Q?q6T+Jv5j70yzjU87W4wmS2D2oFK16eowqeXaHZfnnAAtXrXt0Vq1SGLv2Q5k?=
 =?us-ascii?Q?r/elu1220lAHMNdUvWsrejQZjnJ345OU/0yeuunu/t7vcQ8UVJ3EwIK4qiVI?=
 =?us-ascii?Q?FB6jYdQsUOpLR9Kd6kqKAevDrP3Q2KYF6jOLhAzG+hiRUvwXOVPAy9i+Mskq?=
 =?us-ascii?Q?G07silp1LfBHYHGFdIRrjW7/e6KrzSFCXkluUGFMCn/LPJ1A7ceIeK4SDEVi?=
 =?us-ascii?Q?Afn2M6fo++swsYx1CJJR5njk9bQxKh79X0Wy46kaZlf9RWK5fi7DmVYIdOaR?=
 =?us-ascii?Q?1yFg3vtDUxuocKqM6zO9FApycQm4mlr1K7RtmfEaLB83WBjwiW2ys+HiE0vb?=
 =?us-ascii?Q?UsBlRSucrxxV9zYyg/BCXwxLyeJquZuiOL9AQkwTwLAnQds0XD1w9FFS2WpV?=
 =?us-ascii?Q?rh3OdeI/WFgOS+v2FiXOtUnsQlu13jHh7K6DAwj9xAkH05fC5Hyl83nOxjjd?=
 =?us-ascii?Q?cKeQSwE3+E4XKaPz1QYM5lOqXTaz6vs7NHuTzV8bMXlRTN0dEAJHgiDyXEiz?=
 =?us-ascii?Q?j+eA+binFv1W8GQjKBSVyQTgHNV9Rb3KXRMF0Z+2wevhrJhM6fQbLmzvNvIa?=
 =?us-ascii?Q?nH0yoehPP6SLOVwNajuQBAe3beF26N5tgZCytn+r50uuTBhcGN2C5dCM17TO?=
 =?us-ascii?Q?A6XTXGIo/Mmshu9VdgaRQjdD+eshltDekA69crIXPa8z8G/5WFd6EQVeHPib?=
 =?us-ascii?Q?cHZL2C9Lr0sJUwuVA91VRDwcA1KFeYWaIWYJnzUColUjwUb1sMMH3NkSlmZp?=
 =?us-ascii?Q?eF6fVqErxuquX4jKZW3EVeekMiKE7pb/oeMCyifIoztdOKx+uf8vIpb26zBY?=
 =?us-ascii?Q?WYAsYT6KJRZaR8AS3jseolE1BFPTq0He0LViegMF3QhF1Zgmy68jjvaUhPis?=
 =?us-ascii?Q?eoDlST5715A1NI4m78ZynrZfmYfhglAY4LHA7YojDsI3CI23RjiuUcpYrDBF?=
 =?us-ascii?Q?Y3kBnFcrkiCrUiVp5L1vLr2Z+w5kdrXqgxxoj4kwJ2R10fEIgfLbK44Ww/Lv?=
 =?us-ascii?Q?AzYgh8dSre7chGh9H8ITILlk7M43IFXHtDXEI2VA5Enr6NFj7MXnszATWM9r?=
 =?us-ascii?Q?bIlpCZRfULB0bUQPazSchPA4Ff0VvhVJR5IwqKCvKUl5+hzXlbQYOVSKXdgs?=
 =?us-ascii?Q?SZxz8xmYz+xf61G2MIZZh6P0fdP0NIv+ogIegCol?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d440de-7681-42d1-f529-08dc30203799
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 01:23:30.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxUuU31WT8wVyT8pjfvpWj7TEZ2xElRYEtqr2d6gK95+CxVaeAwQFSDo/3qqnygesQ0jLtUvD+qm/NBvze8MYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4727
X-OriginatorOrg: intel.com

Hi Sakari,

Thanks, and sorry for the late response because I'm in vacation this week.

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> The event handler, in this case that of mei_vsc_event_cb() of platform-vs=
c.c,
> is called from a threaded interrupt handler in uninterruptible context.

But why this thread is uninterruptible?

https://github.com/torvalds/linux/blob/master/kernel/irq/manage.c#L1294

https://lwn.net/Articles/302043/

BR,
Wentong
> However there are multiple places where the handler may sleep. This patch
> creates a per-device workqueue and calls
> wake_up() and the event callback from queued work where sleeping is
> allowed.
>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/misc/mei/vsc-tp.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> 6f4a4be6ccb5..264ece72f0bf 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -72,6 +72,8 @@ struct vsc_tp {
>  	atomic_t assert_cnt;
>  	wait_queue_head_t xfer_wait;
>=20
> +	struct workqueue_struct *event_workqueue;
> +	struct work_struct event_work;
>  	vsc_tp_event_cb_t event_notify;
>  	void *event_notify_context;
>=20
> @@ -416,19 +418,19 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
>=20
>  	atomic_inc(&tp->assert_cnt);
>=20
> -	wake_up(&tp->xfer_wait);
> +	queue_work(tp->event_workqueue, &tp->event_work);
>=20
> -	return IRQ_WAKE_THREAD;
> +	return IRQ_HANDLED;
>  }
>=20
> -static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
> +static void vsc_tp_event_work(struct work_struct *work)
>  {
> -	struct vsc_tp *tp =3D data;
> +	struct vsc_tp *tp =3D container_of(work, struct vsc_tp, event_work);;
> +
> +	wake_up(&tp->xfer_wait);
>=20
>  	if (tp->event_notify)
>  		tp->event_notify(tp->event_notify_context);
> -
> -	return IRQ_HANDLED;
>  }
>=20
>  static int vsc_tp_match_any(struct acpi_device *adev, void *data) @@ -
> 481,13 +483,18 @@ static int vsc_tp_probe(struct spi_device *spi)
>  	init_waitqueue_head(&tp->xfer_wait);
>  	tp->spi =3D spi;
>=20
> +	tp->event_workqueue =3D
> create_singlethread_workqueue(dev_name(dev));
> +	if (!tp->event_workqueue)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&tp->event_work, vsc_tp_event_work);
> +
>  	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
> -	ret =3D devm_request_threaded_irq(dev, spi->irq, vsc_tp_isr,
> -					vsc_tp_thread_isr,
> -					IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT,
> -					dev_name(dev), tp);
> +	ret =3D devm_request_irq(dev, spi->irq, vsc_tp_isr,
> +			       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			       dev_name(dev), tp);
>  	if (ret)
> -		return ret;
> +		goto err_destroy_workqueue;
>=20
>  	mutex_init(&tp->mutex);
>=20
> @@ -516,6 +523,10 @@ static int vsc_tp_probe(struct spi_device *spi)
>=20
>  	return 0;
>=20
> +err_destroy_workqueue:
> +	destroy_workqueue(tp->event_workqueue);
> +	kfree(tp->event_workqueue);
> +
>  err_destroy_lock:
>  	mutex_destroy(&tp->mutex);
>=20
> @@ -528,6 +539,8 @@ static void vsc_tp_remove(struct spi_device *spi)
>=20
>  	platform_device_unregister(tp->pdev);
>=20
> +	destroy_workqueue(tp->event_workqueue);
> +	kfree(tp->event_workqueue);
>  	mutex_destroy(&tp->mutex);
>  }
>=20
> --
> 2.39.2


