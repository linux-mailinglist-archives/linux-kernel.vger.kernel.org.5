Return-Path: <linux-kernel+bounces-39543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DC83D290
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572BD1F24D03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C688F54;
	Fri, 26 Jan 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZ/hhWkc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39B1C17;
	Fri, 26 Jan 2024 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236431; cv=fail; b=YDf8duf+V4pFCAuhRUZ9gK62yRfrlZn+kNAzOvHybmDJEFia08/iu04EKDX2O/hxvy706wraxKcf/dQegA4dBd7q1iAV59jgGr3KEFSDrTPiv1bKp6OKwc93GHxjygdF76PBHHAAH7XKduQ1Pz7+p1Z+RreI13s98begsewri+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236431; c=relaxed/simple;
	bh=cskwLDZFXKEBF12Z4X9t0BpfGI/lsn9r8WKbTZzcgIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBpBIuxQol7PNmxzjqKEyczxqkoQc8YD6sNOPZmj8t7tRp9DXeLzHn3euUjVxhWRFBE+BwKauBBdoQtwnsUM/DqpbUXcaxfFPFXoW5CeGC0We4yhK6ccTPSylPQ5MfG/CIjs+jcc5OniTN8az+JYp3kg3HByxBm9pUSkToLugtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZ/hhWkc; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706236430; x=1737772430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cskwLDZFXKEBF12Z4X9t0BpfGI/lsn9r8WKbTZzcgIs=;
  b=iZ/hhWkcmvogK+B0qoDxjFidqCFzFmh3PacO4/TqDYuAMd6G5899Gxa+
   wT2PmHrSeeQWJgbVejRCksU7GiAAFmPmbq8R13y00lQ2sVmRsX/TYpRQu
   c77/NcbLnq9p/0X6JabHOh4utIiQWzFu1x1jWsc/uCKKsSWukNfLoInMB
   jj+JJchzkfprYpfaBtSe6Z7phfGPF++zWAELAw+Mlty1QjIuM9aneic6M
   /PiqektP0yJwa3AdPK14GjMOkFuFK8n7qk40Ba3TAqkAlDz/i/MTY/o+j
   N6ejCihP0vuYJDGUxj5GiOiMiGYShTK2RuFy3a9rUNDpKcLqTC5O6yUY2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9754443"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9754443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 18:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="786976502"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="786976502"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 18:33:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 18:33:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 18:33:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 18:33:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxR7Dczn76dm96M25mgqoTlzx+WK7FM12ZqeM7yK5KS4F0jW8Kr47vxtl2Ux5g53hlJza/Kic7vnJyoIQvChaCye86PCVd5RGJX4Ugjoao8L/QrQiIeorSSK0xTAS5awLbfyKAjbwQduu+cpHEQyIh+aD+uVRSID5n9f4xxCqtJqiRiErbhHtvf09CL75asZ7hVQM6f3USuK7KG5yI48b4mSyNCqH5pYOGlLKu/yuvai/y7jpKLqwjzzpqom20gKDyFMti1J8U0DmyJC7tUQ/6Mf3hEF7PaOUSBveQ+r1XaAMMgIqreHClLECtUqJrwWOKkaa6mkPd+GF4itJYdnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cskwLDZFXKEBF12Z4X9t0BpfGI/lsn9r8WKbTZzcgIs=;
 b=agCHdZm3Assg1RSuXxFhOcXWqHmy0KdylwN8Y0YDyE8kLxvdY8JSEUUoAa2NcPzLiwLEyaqfNvyGKIFxdj7CTO2bHeczwcdRVEkopLAbESZKMWXyuQb4m08b+AOuOXTcr7N0wOg8VUc58ERJf7Ap8LoQBO54s6+zsoH/PEEYRfj2qx0+qMzc2PNf5xHEk9CLNSBtkxVZFKDtNpzCeYqJx9ufks1tcAuZnaEjotdD5c1J6rgymOdKpX+SDXCG8JLhBkgSLt+894XhHg0pPBKcrCVqAcT0rPCIP0B/kpZKXoxuig2AEPd2le8Kph5CJ4r3iOqYYAWKFiMqR3R18n1V7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Fri, 26 Jan
 2024 02:33:44 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::3d32:2de7:4924:4f2f%5]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 02:33:44 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: John Ogness <john.ogness@linutronix.de>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Li, Hao3" <hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>, "Gao,
 Jianfeng" <jianfeng.gao@intel.com>, "linux-rt-users@vger.kernel.org"
	<linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH 2/2] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Topic: [PATCH 2/2] printk: nbcon: check uart port is nbcon or not in
 nbcon_release
Thread-Index: AQHaTb7bx9lc/bq9QEex0jEUkq3YtrDovAmAgAKgL4A=
Date: Fri, 26 Jan 2024 02:33:43 +0000
Message-ID: <BN9PR11MB537055DCB7D1053DE44C447AEC792@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-3-junxiao.chang@intel.com>
 <87il3j9hpo.fsf@jogness.linutronix.de>
In-Reply-To: <87il3j9hpo.fsf@jogness.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|SN7PR11MB6752:EE_
x-ms-office365-filtering-correlation-id: 1ba761cb-f439-41a9-de0f-08dc1e173740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDC7wgp2F5sLccXuG0u2Qw51VHcoQQEy3KNYrBl3gLr+/6kFS4i9mybkeE0JdnhswpVuDBPKpAkI5/Iby+THkZ9tKborak8DPpBEiJbeSROJdVYWz0Zoc2TwMZe2XevXiXj5xSea/xFRh8BDMNw1TxGKrYSuATzsCdKYkWppKUTsepB1Z5Hfk7pgX5kEiKd1dCHgC1pbWO8xyLRrmWzZema8Fk+t8FQTqvR/wrY9wAlPOmNuXVbVIORwEb3MAYusjQftALJmsgMYC1GWsQHBz25oKMMQ46ULFpx8e4smeLfwCza+QzvLgQitWWou+9PLcWiqExls/Kuim+9eTAHMvXPG/vJNixlJN5qnNHZoJs8eOy//5MzjvS42vSnX3alLdJlA1+Fl5SHSZ/BeuXsOoF9YEVuUHfDs93jBvxl3gcfZ5L52c2+sck1MZcn8yXF5QAfoNpK1RqZk6YoA9tfsmAn3xlUlLUMRbSp8CwmgWDo+aSLgoqQitZME86r13d1zPQS1MnUbi0oHVbVlOD+PP4UwPoaUSlzqmpcR7a4/yYhjb7xpPrhqQGs76zE/X3X2Gfww+FP3dNFGMEVdoyUJjfCwjfhkAxAk/khwjMyeW4UYoU0KQPvvN3AR+oKXr8SL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(86362001)(71200400001)(9686003)(7696005)(33656002)(26005)(6506007)(38100700002)(82960400001)(38070700009)(122000001)(41300700001)(478600001)(66476007)(2906002)(66446008)(83380400001)(4326008)(52536014)(316002)(8676002)(66556008)(110136005)(66946007)(64756008)(76116006)(5660300002)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQb6GAj87JiLUsrOwFTSdKBK+oFcaPW+Ap3V5tQNGDod3VZM085FXEtp7huU?=
 =?us-ascii?Q?XTViiUFyWzZGynSDVtfykuThZR/2VkVFDLJIPAEphOE4YRdFVqAKyy4fV5kV?=
 =?us-ascii?Q?VJv1ETcDtVQ6m4sVOVgjOsgW/fdv5LrR6kaE6kbeb93pWoah7CY4/I+owSbK?=
 =?us-ascii?Q?coQyuhtjx0GdBGhvGhdgqTCxCp+jQ5Md8bSEDhWou4tVn14DYxYst5LLfKSu?=
 =?us-ascii?Q?+XfKC9aMaGIJ7OpwN1vdWWlqJT0hM0ThR4wQHlyIUqflVcHVR3cjvkoSnfjY?=
 =?us-ascii?Q?Uvz+t8jyXUyX7dnj6S8+ipEIrvblovTn7QJhmnqsFUrSv7w5+Ggk1SQ41akF?=
 =?us-ascii?Q?HZag62WIpm4KrgW1bopHVeaA2kwo+WOVk5uEsn3rsQOTZlZTd8kPPe08WAPj?=
 =?us-ascii?Q?z5BszOeHeRMGGL0fpGVguE5ODrSVYsKyOrpTTrZCe6al0lbBLC4zLwq2fkeB?=
 =?us-ascii?Q?kFfJ1SxeZKycfpi5npMOD+mGA1lxq1Kkcxk2wj8ijLenQRs0TfaL2egte/Np?=
 =?us-ascii?Q?1ybovSNjHayp+OYdjyppWFlnLS+k6KP5luVxjn2XFIJbUM0chH4dHD/N7LS5?=
 =?us-ascii?Q?e7HPqroi5PZ3kq+pDuuEQGGdp6whATzpvDPnoNifrJ13mYVS8SVczeGJSWLN?=
 =?us-ascii?Q?pcaapIUMM8Dx1sE1961k/+ajFQMdCNdrmO6qqdY5aTJwrz1pqAnzdWVKwvMh?=
 =?us-ascii?Q?7cWd2o4bo1dsnvtOWedtk19s586wrjHPQ35Jv9aMm403BmAE61mKmveG4kWO?=
 =?us-ascii?Q?5j6E7GEm7Lc4XuIxi1fVsc9IRPmc5mXtbruaRimK/N+JD/wO4lWOODunY6Hd?=
 =?us-ascii?Q?FJYBO0XOS54eZt7HKIyaofq6BZueO4wkJxxqwN7Qbh1bVfl/lr5e0u0wvSbe?=
 =?us-ascii?Q?T/4HVl3wVAXTN0BBqxnycKr+GgJv3KRI4PglaFeduIZJKgGnYcAh8pHsMDoD?=
 =?us-ascii?Q?EKeeDvPE+84t+avym44sri+2Xoicsg/7LT6Q5rxLfpiWoLmlC95Ue9pX6KEA?=
 =?us-ascii?Q?wERcII5AWKhlkuNGDFxya2XygKA+oMQfWYmiW4TniNKwbuIPCNM2ZKLcws4V?=
 =?us-ascii?Q?yIqsNpDa0SCA6lZpIFY1Btv94ZE1cv9U1q1vQF3ZBGSidvu60m0iBLyCF7Wj?=
 =?us-ascii?Q?TgCnrLf6feIPd5i6EPDMxFa969UlefKv2ZyPgvmD473BvsHui+BHNlCafDin?=
 =?us-ascii?Q?/+eqi6sq5ROyd/6g3n3Y26wALfkfE9RMBoQzokYNqrgeiCyDZ1xfjIX3Agpz?=
 =?us-ascii?Q?mYXOZLsCrTQ4npl5u/Us5GyI6Xb40d2gtsZBK8M4Y+kqjX2XsgNXzaAd1fSd?=
 =?us-ascii?Q?6oXCvxHm1u544s/EccGEFyErW71NhjwVYUkelIn8/a+Ytalv9rMSN8aEl5t1?=
 =?us-ascii?Q?ETzu/7Evpq7T5yMfsdIsWWm/Byh52bIoxczGC7GLoMWWbRqdRN2eeEPyJDy6?=
 =?us-ascii?Q?ki67QJc2rEkQmnraoNKgZZcZTtOk95B7JGjRi1nQYHrqnL+unq+b7BuUfaHi?=
 =?us-ascii?Q?1FFOwVGNST3ZioZkib9HZnEcF9XcTBFiiobqMLsS+wUC7OQN6QgwJQETtawd?=
 =?us-ascii?Q?DngX/Vs154F5fc1t2NPFG0Df1rDP17YomYfeu8jX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba761cb-f439-41a9-de0f-08dc1e173740
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 02:33:43.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ro15ibRLYT5tWcMdMdTfpNAGcBXDXpgX+MPiIleaVcakjM3xZKa+EThtRyceFg3kMDHAWOc/aqNspkpL7SdB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com


> The release needs to undo what acquire did. Why should it have its own ch=
ecks that would cause it to _not_ undo what acquire did?
>

I agree with you that release needs to be undo what acquire did. The proble=
m is sometimes it might do release while it didn't acquire. In nbcon_acquir=
e, it checks current uart_port is nbcon or not. If it is not nbcon, it retu=
rns without locking anything. So in nbcon_release, it should have this chec=
king as well. If current uart_port is not nbcon, it should not do any lock =
release, this is reason I added this checking in nbcon_release.

For example, there are two uart port ttyS0 and ttyS4, ttyS0 is console and =
nbcon. ttyS4 is not console or nbcon. When ttyS4 uart port is shutdown, it =
firstly calls nbcon_acquire, then calls nbcon_release in "serial8250_do_shu=
tdown". During nbcon_acquire, it locks nothing because current uart is not =
nbcon(There is uart_is_nbcon checking in nbcon_acquire). When it calls nbco=
n_release, it should not release anything either because it is not nbcon - =
it doesn't lock anything in nbcon_acquire. But with current code logic, it =
will release nbcon lock which should not be released.

Regards,
Junxiao

