Return-Path: <linux-kernel+bounces-150040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C128A997B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E245281E78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288915F410;
	Thu, 18 Apr 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OH4tm4jQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348615F404;
	Thu, 18 Apr 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441992; cv=fail; b=XSA/VzxFsCIQJj4yz4ioxG1KLLuPzaV8Bcbpwitten+m87EBJIfai+/6Z7tb968vYqglHZhXYBhWfHwTzSKdyQ4dsUFcmPP+8vViHUaE+pVh2bA9+eaH7hkY3E0nlljKgV0vOae7uO43MJwc+BtvB3ZNqbbyq8EMwZYhtinG7iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441992; c=relaxed/simple;
	bh=6kvGBmulQHFrOAATB020hgT1+LFfWmlNaDN6/0cBIro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6yvqWNvBgOTydsDFUK1V8Njv6U7HH28ORAi4B6w+DOl/jlUwkwn81H/dp2QCK2nOkuUZrMEk2GGbQI12Bxs8cwTbngwaMmaVK2sJvkuRuRWZ6zSco8jsX2GW33oo5t2MqOoIOLrD9PVfhyhQQuB99I8LbiNcXIjogS7Ug0mCXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OH4tm4jQ; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/BFWaAzG9WuZf4pf8FEFuXrwexzHBZuBcnsFNmwxtBviWZfYS7vruy999LBvyNJtphCjgTDHYF2T/CdRW6BXrV1BNoZ6rgvOH95M8eDsZybJDEPU9yGCZtAC/tXFxsUCexbEfEKVcuHLQ0AQkwz2RoMn5tNMso5TJphkkD7qtYAiGBCH+FF1fsxHqM27GoQceDNVZ0ncyF73PviASiH+Cy8vFj8T+AL0wDab1Rr8OvjBWSFQBnDTrWFMAhY32E8Gp4ImqgcDV21UkpeFFdvJR5gtVapYdjT+t3SJ7/hw8jSJu2aOJzjkCR+BYDEZ/JlUz/gGQRcFik00DyIQmK01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kvGBmulQHFrOAATB020hgT1+LFfWmlNaDN6/0cBIro=;
 b=OqcmihcXlxJ30vBMNWF63yQyxOqp+tsAzsbdPQqTpeL2Ez0XZKBaex26ArkbgCV/BA5ddHpezjwlxq7U7R/v5T4VysxaWgpPfGBan2057BurtbeT8eaELhyzt5zmt6ODfwHpb6m/tPfQqRo/4oZI0DqOmwBp2seT71Rb+S0mZOTwNlG5BAv/kCMV7ahSYxfA5abb4Aqdb45mkdig2ik2BIBvYc4paYODFEKeyBudhO+Oq3icTq0r+xXfP5kJPOyqtEB7pDwEgoPOapcxGHMi+aTqWqqnD+Lk+1aOs14JsbamAgg+mI/wOrktS6JLo8GNrVCnOFXs8Wrk5lgGlRpb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kvGBmulQHFrOAATB020hgT1+LFfWmlNaDN6/0cBIro=;
 b=OH4tm4jQUclpLsfGA2qGYpSRqlRoktNhGs+L8wipCpA5Z2F7ihk9m2gQrpUrvYTA33R+GRXShuW09K1cxc7begkc4PP4wTtp1ODP3aUgbPm+DclZZT5cjV8tIl4z4kTMcuL46BY/YNC0UrI4pWE13m3yI2CuHUF0mRY3xUk4epbluslFwpnJRAvi5NjS/lvHE5kTwsvS1ejcQ3S2Jq8R9sDD9fph/C09ZaY8tqSZJLuAbx/WikKsPhp8W8bYqoVARgIsEDMmPZnHm1XffgiMazD83TbN5/CVj7wT5zXFpDkUOgiKEoYVSyMXlmedjKjNueBxmEVCVoKMliDPVVqTFg==
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 12:06:23 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::5404:f658:2d07:451f]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::5404:f658:2d07:451f%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 12:06:23 +0000
From: Shravan Ramani <shravankr@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>,
	David Thompson <davthompson@nvidia.com>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
Thread-Topic: [PATCH v1 2/3] platform/mellanox: mlxbf-pmc: Add support for
 64-bit counters and cycle count
Thread-Index: AQHakJktkEiBSozD4E+AQxbCdqj0ObFsclCAgAFyTeU=
Date: Thu, 18 Apr 2024 12:06:22 +0000
Message-ID:
 <DM4PR12MB513613B05FB14A933AB7304DC00E2@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <cover.1713334019.git.shravankr@nvidia.com>
 <aec3aaa44a5738940b2511726177976336a6c72d.1713334019.git.shravankr@nvidia.com>
 <e77f01b4-f314-6822-8533-95f37a42cd4f@linux.intel.com>
In-Reply-To: <e77f01b4-f314-6822-8533-95f37a42cd4f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: 3c1a988b-4c44-4c7a-8f63-08dc5f9ff71c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 33yQvW3+kAZgT+i7cXmKKOi+LTu2+tPSVQdsrsUL3bDuPjMs7GlQVAf4ViLhIcIfOpuyu6yoIoe3nBQK2QlEgi7bjYRFf8Txp8QdE61F3Mc1VXeds/xCToZLz6YW1sISD8gBGehYkmFdnW3cuxLB7Sgqo6GU3+labWSDGvSUTamZQSGNREYqHOQaC45EVAINqPYP3T8vvihtogWgiRrwZ0sDwtd3RFz5OfWfcqVveulGZjzoCtMzCy5tz0ycqDGdKk3bwwMEKTwv82D/L2f/DJylulK5vg2saA9tIo1gtVsinW22LXG2BZa7SjnmA1/mxnznyEn8WjP7rNQHh7MuYdKnhVeRLy6ZsC0q0YfXny91d8JEs1gq/f93FzpHLU0g8D9VdUD9QkkSAJguoA54yWa1Wp8NWTKTU6JPSJeNxCKUXoe9Uk5LHRrj4gEVGCgK4HuRjXQUJkY/q/eSG30xNkM30XNjJUb3IEkYFxV2NNNlbSYJx/ylMLDLwiSvvY6Uf/cFHWkcNnyctSXNQNRXNl7jk/5nF3wHOKPwHONEpjR8DyBBa1KA5j2kxlUvOaxw5rGDAVUKljazKztefSMzBB319pag+ZlXqhBqj6h/oULDWl+KeUSpfklvB2Svs0G+mymnCKEhaojf4PPvMz2udJjlSMG+Bg1WI3xv3k7GcPBTZgdlj2J3DFplpbqRT4QSoQ3fgcwKig1tqU2htDY1UOtFx4d93H4S3L4wOEKWn7o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sBueUcV8wrvvcSKHQ/L7dL8APHCaTpaSXMpkGU2z04d0UvklJZ7j+JDphG?=
 =?iso-8859-1?Q?6DdbsDXXwu86gyBVdNuQGO+ks7/9FZQ2GJmwdpUavVwHdOMb8A5Kf3bQU9?=
 =?iso-8859-1?Q?YvFA9oPAuq0c1YA/4cIh6PqsqfrUoYQQURmZgr8KrRHzw4oGSd4ufCfajC?=
 =?iso-8859-1?Q?k31H7Upk674Y56hyXc4rhXquJY19Lhb6Gx97ZoQnJAFUCGyChUfY7XZcyn?=
 =?iso-8859-1?Q?4XTzlrv6F9rquC2hjC27TRkLbXvItFQiLJoPO21p56gJ6RyjGbCJCpckZZ?=
 =?iso-8859-1?Q?eyUfVtk78dDkZn658UASOMw+upKp1A72VlPPcdirouZ6k87dbR2VHWdvGG?=
 =?iso-8859-1?Q?mb2NBzXZUUOSfJ3V+RoIse+ccCKCsd4vhyGrvvcZ4gnn9Su8RXoyUaCH+n?=
 =?iso-8859-1?Q?6P3EmSJyUX2sq67CwcWi2sdMg2ZQ87TfyIkCjgkyCfMC0XxwEw/sX6G5JR?=
 =?iso-8859-1?Q?ptNX7nTznIPMaY5pdtBYTDgv5RSNOi/JANM9DvZ3uSHghE1/2tvfttBECH?=
 =?iso-8859-1?Q?G726HXj8Ff9P0TXJQhAAn3hUG0pz21EmX2b1R+e+LLcD13cajo/dpH5VpZ?=
 =?iso-8859-1?Q?ZGRc5Wq1lXFCUKmR93QMHmDUaw41OEcCQ8DBGqNCsuib5yta/brn95jJaz?=
 =?iso-8859-1?Q?72oSCx1UQTAVQ61FSRtRx7UrL9Rny5uWkjYveR0LdnbeXBkAiBGFANJN1b?=
 =?iso-8859-1?Q?lUfp04lG2ITRzh5HsBBVlpifDe5bDeVE/cHDpUNikuiPiNmuhUGMB+Mfwa?=
 =?iso-8859-1?Q?WtYiVNDYd/gZATJa5mzzg01DQdBWos0H988ZJX/5qujD/3f/ebuXDcAtsE?=
 =?iso-8859-1?Q?ZnHlDAyHFUnH1xkn5LdTIrFjb6uC7hd59XL5yl6p0VMFdVA3lD0JZFDyiP?=
 =?iso-8859-1?Q?G6yOhX4c9QYwRVGqxyF8KJRHEh9NZD0IsW4Ze74ZWSq6ASEXWXJ7fx7Dx/?=
 =?iso-8859-1?Q?0Js3hCkq53K1C8GB8oK3FYw3pZ/bZbqnoLTpZF8e2EVGIVsRnwhrNXEduW?=
 =?iso-8859-1?Q?SLfVrIQf1pPMQpmeyya1/qeMe5ALM/FasfVeWvRj4PAR8vLVJOUOFWGNPw?=
 =?iso-8859-1?Q?TQHixn5kBh5xJp7cUDsUdvjbOq2HYvpheLG4e1N66iJXAJVUGWtXo7g9gz?=
 =?iso-8859-1?Q?g+mbyEiYt1RD3ZV1GktLlaoqpCEiyxRUrKl4RWik4Pf1TFvX+eu88LEqVU?=
 =?iso-8859-1?Q?9VUhtcF8f9o6BXjrvLqQskrDuUjfFqaDw0CgnrQnlyjJB6bCMtaFZygtp6?=
 =?iso-8859-1?Q?rHIjq2Aw3houUNV34IZyrxoSYQHHUB1LsWtlJYOEelzD4hgCcNg8grbIOQ?=
 =?iso-8859-1?Q?pCdnfZH3kuXQwgMymro9DYrovTL80lrbvAGMCAKFJb+LhoM6P9eU12gjeH?=
 =?iso-8859-1?Q?tFI3mNuSY6vPlJ5rDJmBtknGX0jxhX4J5nkYQHJz2vmsZVGhyxaz8tbIC8?=
 =?iso-8859-1?Q?+jtrLrZ1QxpK1Lmsv9Q7K2tAwor9S/dgUP11RMRQLzcSzyQPQX755R8Fl/?=
 =?iso-8859-1?Q?YlOd0nwg6uc7XKY3bWntU66q1UO+kkCgz/ch5q1Txl8S3ihoywQgMZd7r7?=
 =?iso-8859-1?Q?dee6O8fJjyKHgEc8714CMv+fsFs4zj2WiDow8ZYlQAp5y++z/0WCtqOSr2?=
 =?iso-8859-1?Q?AM8zFlojM0KYc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1a988b-4c44-4c7a-8f63-08dc5f9ff71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 12:06:22.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJJgfziixLWVPMFs3MSbS4hAfT4wZem1d0KO2h2w5rSA+wjvW9DRnh2PId2j4RL//+eCq3BIf1clmkXSAX4jKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

> On Wed, 17 Apr 2024, Shravan Kumar Ramani wrote:=0A=
> =0A=
> > Add support for programming any counter to monitor the cycle count.=0A=
> > Since counting of cycles using 32-bit ocunters would result in frequent=
=0A=
> > wraparounds, add the ability to combine 2 adjacent 32-bit counters to=
=0A=
> > form 1 64-bit counter.=0A=
> > Both these features are supported by BlueField-3 PMC hardware, hence=0A=
> > the required bit-fields are exposed by the driver via sysfs to allow=0A=
> > the user to configure as needed.=0A=
> >=0A=
> > Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>=0A=
> > Reviewed-by: David Thompson <davthompson@nvidia.com>=0A=
> > Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>=0A=
> > ---=0A=
> =0A=
> > @@ -1799,6 +1902,37 @@ static int mlxbf_pmc_init_perftype_counter(struc=
t device *dev, unsigned int blk_=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr =3D NULL;=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=0A=
> >=A0=0A=
> > +=A0=A0=A0=A0 if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_CRSPAC=
E) {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Couple adjacent odd and even=
 32-bit counters to form 64-bit counters=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * using "use_odd_counter" sysf=
s which has one bit per even counter.=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr =3D &pmc->block[blk_num].att=
r_use_odd_counter;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.attr.mode =3D 0644=
;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.show =3D mlxbf_pmc=
_use_odd_counter_show;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.store =3D mlxbf_pm=
c_use_odd_counter_store;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->nr =3D blk_num;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.attr.name =3D devm=
_kasprintf(dev, GFP_KERNEL,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 "use_odd_counter");=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!attr->dev_attr.attr.name)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -E=
NOMEM;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pmc->block[blk_num].block_attr[++=
i] =3D &attr->dev_attr.attr;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr =3D NULL;=0A=
> > +=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Program crspace counters to co=
unt clock cycles using "count_clock" sysfs */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr =3D &pmc->block[blk_num].att=
r_count_clock;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.attr.mode =3D 0644=
;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.show =3D mlxbf_pmc=
_count_clock_show;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.store =3D mlxbf_pm=
c_count_clock_store;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->nr =3D blk_num;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr->dev_attr.attr.name =3D devm=
_kasprintf(dev, GFP_KERNEL,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 "count_clock");=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!attr->dev_attr.attr.name)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -E=
NOMEM;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pmc->block[blk_num].block_attr[++=
i] =3D &attr->dev_attr.attr;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 attr =3D NULL;=0A=
> > +=A0=A0=A0=A0 }=0A=
> =0A=
> Hi,=0A=
> =0A=
> What was the reason why this driver could not use .dev_groups to setup=0A=
> sysfs (filtering can be done with .is_visible)?=0A=
> =0A=
=0A=
The current approach was suggested during the initial submission of the dri=
ver and the same has=0A=
been followed since. Do you mean to add a is_visible routine for each of th=
e sysfs types like=0A=
count_clock, use_odd_counter, etc and check the conditions for their inclus=
ion in this routine?=0A=
=0A=
Thanks,=0A=
Shravan=0A=
=0A=

