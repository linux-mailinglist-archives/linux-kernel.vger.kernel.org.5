Return-Path: <linux-kernel+bounces-31224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3907832AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F95B2411D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C01537EE;
	Fri, 19 Jan 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkOyiE3E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367952F70;
	Fri, 19 Jan 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672235; cv=fail; b=pDSK5Elu3I2WFGqvgCQbovH2FJfLBTw22TGuvP7D7bjsbW/ucZIxmEkMozIA0WMYX+JKZUyWonsg/xE2Fncwxmejw/2Wi7iAI8iAukZgbuMNkYdocwgkFTVOT0oCI0tu3+X1MueB9G/8RFxQDlrHQ5pWL4KXXKI0p2kfekGFEDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672235; c=relaxed/simple;
	bh=xbETyNCIml7ouwkQyumlhRJeh56Sm0Sq217GPknd7Qs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HP9aJKvyeRsEmTzbh7GC8sz39m/S+GSM8tLrnzzOwr/bEep1dWV554gSFoMFP4QJWlUcLLwteqU0tBWUBaBDbxOvN1PydpD57qlAxUPpViDWt+hCjz/O8ymRtIx3QEZ2ZiZilQ27uFVSoMZ9bPmeQN7f3CEP+WRDzGtb2QC5Hj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkOyiE3E; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705672235; x=1737208235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xbETyNCIml7ouwkQyumlhRJeh56Sm0Sq217GPknd7Qs=;
  b=NkOyiE3EWiN2KiE6ZAJAHnQAzbd9jSBZoaKQ+Uu2XNAoMo5CvCNaQTbB
   zwkZk2iLuRyh33d1/S5FddCrqsZplyHEChZrETTRyggaBH7Okj7z2WxgN
   EGk4nZtgKdRxqAzr7P2ZDBQqhH7MT4glVeidVGM88smZU89CQ/UfT7N5N
   T/cvNgMoRDrk/WzrbBpQmE3lmr11C+uXcfwwLNefoSQSU3tPkpGyU2+NC
   C9cUtMyB2Y1aazZ2tj2tv1z2NUKDeA1/fXAj4aRBdmk/PKic2K9VZD9cv
   Vw/KTztSl4Q85tCPJMv5DQgdw2vQ9L/cq/2W9KVA1nfZKkKBv1Sd73ERX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="632604"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="632604"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="594496"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 05:49:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 05:49:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 05:49:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 05:49:29 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 05:49:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8/4ooEIZHstRfg4nzgq03UJR/RttNnG3sqDqQOZRIip2pl4qP5tpq2JgVGNKmr4g/5yBwoPJkp/fAbg2eVTNvkfXPIlrk5NiYRxcUoZW6IhFqlFTGFBdysRe8XfCD6v5HixATocPNJouv+n64OXv6Rsb3p1YDiDPbC2wpUxDwJ/l9r+wlplvsvfmS23f0H/nfzjnpPtHzIbUa85jjpTQgTCWzzlBq1wYiUSW/xgu+5CYjkV1p/KgSNgUL8XzRX4hxuC8PWdrHN7IPv0JRKUFY10Pg5vFYIanK9WOOzOiBIPjoinxa2LPAlHncT0nli1nYbFWLaqrJN3P9Lqd3JfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7CgvjabiEnPpNX6WbTd3DgVC64ogS5j6494iirPyK4=;
 b=HB8xyLPJ3OLG4xymI63nz8Tm9XsNzCWg2Mn43p1kAy/exXpkNWRqoIxNbYSMQcYdK09j0eoIBXFvtp910h4akKd5iVEnfjRXbVP9CkKeKRqplvECv4HMQjc5mFTPAObE4vEiIstcnRR1v45AeaYOG1Tkk5RxQPC+LfQ+C96rf17QC4nVDyLRNamGXde1qIFhJOWGwWVOu+d64YwC21GeMjMN26uthIxSQP84ZEvZVdezDP7S/1oKkHe5crjCtCoJ4WK/9NgoxLn37HLUu9pSWYvafkBj7IwXPSFbANNHSU388s0fIWtI8L0MDQ5dHZo3cs70LlHeo36aBultlNSi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Fri, 19 Jan 2024 13:49:25 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 13:49:25 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "Olech, Milena"
	<milena.olech@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>, "Glaza,
 Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net v5 2/4] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net v5 2/4] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaSf75qBXfF/1/2kO2cnQNglylbbDfc0oAgAG0xVA=
Date: Fri, 19 Jan 2024 13:49:25 +0000
Message-ID: <DM6PR11MB4657D3968F97531F08BF4F959B702@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
 <20240118110719.567117-3-arkadiusz.kubalewski@intel.com>
 <ZakPBmakH8BTv8Cz@nanopsycho>
In-Reply-To: <ZakPBmakH8BTv8Cz@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: bf8a32b1-2da5-4e01-ae58-08dc18f57322
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EV+wGDPmiWTsxb+Y/oN68suw487PBxdeSVkdUKgQS1nOB1nXBH27fx5V8f7I0mwm4w25QpETRw2X9LssfvNcAhXGyV+/8o00GZr+O7+UcLtB0+OFvhv6jUb7OPt0jT/DV7XW4ZyKEH2eAopZdtqUW6p+xE8JcKhJgq1c2TDAblNTNVaN5zL/Acvu+bC9oPzhdRMOIx0oZffICLRMtQmh6saz9tKCIJald1SiD4RF2V3N1Y0zfhf8GPofOZ1mTkMh382ouVWE58xM8jlUYRWUMYwhhh2Nb6xx61W5xeXKZrnodPJukmh1DTwp6jxNd61xw95zrY2JZrR6U+gFBD5i3yodI9LAfbVzpmPM6+UVuU9l6YY/MtFQdNntMz56JABly8FajWGWesdKiSC4S7QfUw7iEOqwdHVH5SIx4BQjB5hOjUTQxtYZkSvzMtUvTqPQ5WJ8Esms3qjdDKTncG9eYRyTLhA+yhOfAY+cqgf4pCqXqLeiuF7bsSFmVg7q30WHz97ZcP+lcVyWQYBDfRQmpjZrzh364BQM+1/2RtWzV2xKsFpAcBD6mbw6rL2ycU4TXukdXkofBDjcmK3tX6yqyA8NgzvPjoPfl41VEDfX2TFo5hEXHIW5OOJmcPbWoJFr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(55016003)(76116006)(478600001)(9686003)(64756008)(316002)(54906003)(6916009)(66446008)(71200400001)(52536014)(8936002)(6506007)(8676002)(7696005)(66476007)(86362001)(2906002)(122000001)(83380400001)(82960400001)(41300700001)(38070700009)(33656002)(38100700002)(26005)(4326008)(5660300002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/PGIhtvnA6HJs0eTJU9d1miEozpmSDEw/QJZJIKohtc/2/AgOTRX9TZHM2BC?=
 =?us-ascii?Q?i2CF9Q1bJwKIPIfg+ZRunzqdQJy2ShU1VJvGOhUhbOWIqKQEyn1PV51dWiCB?=
 =?us-ascii?Q?b5BQtuQFtC1R7pAdgAMNQpNGJ12/AbcJlPSC7Xhx7mOm6kq+1gSAEhGDA218?=
 =?us-ascii?Q?1cXgYkkk5BjYhSes4A8Z10VdsHdjMGRJSheihor0O1xf2cmX3n1UzMKSNM2z?=
 =?us-ascii?Q?KiJ/tOqODBXGc2bZmXqZEn6lFQnX/AMEn87DOl0GEZLQ6oEbWZkv6mPyzl3E?=
 =?us-ascii?Q?r1xnxvQ8G3FfcozVoLxE7165j3ZAvVeHTZRMQe8O5PRUzu46qlj3rEtJhbvb?=
 =?us-ascii?Q?n9q/jEu8xsTwQ4yoiBZl6c06uXxdgGIoQ+9UWhYBuCt+H64g3VEpTCm7FzvN?=
 =?us-ascii?Q?DGQLhgY0GkyZmLAsElv1D2fz8wumbTkwapawG7R9JC7tdMgXN/GrRfkx8ivi?=
 =?us-ascii?Q?CcKzbfmdkotcELb4KEEjkDxRaafwQT2wkT29vLF9BZxDM7KPgEYJx47q3KYZ?=
 =?us-ascii?Q?ezqfPtEZ4rOxJJEb02FvQ6hpTg4+3HA7R0BC87lx9PSGenzVtaBVUbXdmjsu?=
 =?us-ascii?Q?KPQP7xYRs2kPUE8sUOy3cOtVnmbn0IBo7f1BdIzgY3B1FVqmLie+jWtcxl43?=
 =?us-ascii?Q?LD8n4c9517J6b78wqT4kvpzBBcZ9EgMGmp7FKnK04wLlJ86dLVmMU5ehN3Q3?=
 =?us-ascii?Q?L8D9NjMV1MXUbq/9eXlYi0LHC0lvsWhVOf38bSIazwX2DwY/JQ8aOiWMl+bI?=
 =?us-ascii?Q?rM2qYHuQYcEdoSptJo+KTL9/lQH3iHwztE17qaJuWkUWWHnbhWDV7eMlDotF?=
 =?us-ascii?Q?F+52eHXuiF2w1Y6lH5/jlZH4yTPWhcTtWsHSbiZTNAgyZO7CMOxRjR9cOfJw?=
 =?us-ascii?Q?LVBj2j8aqsW3iFMEHlBoM8um+7EAv5ikZiRCyL7iuT7ZZR4GdqfsOwaYNLne?=
 =?us-ascii?Q?6SJbs+MIxQXHq2bygy4P6ktlwSbo50cVLpRyG5asrIiVVO/aHe9Cycram0V/?=
 =?us-ascii?Q?3ZqezbLV7SM+N+VD6jEoXck9zVKCaLtz4/gppnCxx39sXMMsRCR/C2U9we/i?=
 =?us-ascii?Q?XuwcuiG5VtZfhPLdei6cY6q5dkDrkG5TdhCZaOL3HhIpAbyUSf/yfIfAhehn?=
 =?us-ascii?Q?Rx9eZ6G2Pyg+1B5mfDPtNaNY57MRUAfa6kFAnGffzYPV9Cj5ZPNrYk87OSmw?=
 =?us-ascii?Q?P3C3Fd9WH3klaum0kwqIKERiyEW9Hf+SAXoESQbEYhqk4dXmkRLOKWu11U8+?=
 =?us-ascii?Q?3TtYc2B4AcHUiy7eHq/NoP5HmshzaR5cRj9k8WZnsnayipV/8RpXNRH4JJYZ?=
 =?us-ascii?Q?psICyFOMEAo7bKkPUcpZswwMzyV034Dw2pAUX/kge8E5nr0+KYeSUJPvApHF?=
 =?us-ascii?Q?7icziUfnQ1KeOloj0eWJeeklDqqWCqnDXR9fObWN9Q0TwCNdISqYwEKE5jwW?=
 =?us-ascii?Q?/iphWTh3QBv4upDExxAjpq1xhCHxAyXb8/BZqt0lomIDxLaHQ12V/IjEj04+?=
 =?us-ascii?Q?djbhgrgOr94q0ZMbD1ErSeBOp3qWtT4Cl+J4xfh900isPXXG9IKDghDIkjTW?=
 =?us-ascii?Q?9SKsZ0T8veD3OPKHJJ2UXfqow0os6w93SxDyl/xU8jwdDHeDqa/po7r7mX3S?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8a32b1-2da5-4e01-ae58-08dc18f57322
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 13:49:25.7029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXR3EASVd55mYgUkIvD8VLgwxdlD7iF61ZdzilD870KqvpiRSJVzbiL6VkoJjxvci6PIOAVuo2Dprbq7uXW2VnacgUA6hq6F9HfDfjMmtiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 18, 2024 12:44 PM
>
>Thu, Jan 18, 2024 at 12:07:17PM CET, arkadiusz.kubalewski@intel.com wrote:
>
>[...]
>
>>@@ -443,7 +490,9 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 		ret =3D -EINVAL;
>> 		goto err_pin_prop;
>> 	}
>>-	pin->prop =3D prop;
>>+	ret =3D dpll_pin_prop_dup(prop, &pin->prop);
>>+	if (ret)
>>+		goto err_pin_prop;
>> 	refcount_set(&pin->refcount, 1);
>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>
>You are missing dpll_pin_prop_free() call on error path. It should go
>right above "err_pin_prop:" line.
>
>Haste makes waste..


True, fixed in v6.

>
>pw-bot: cr
>
>
>
>>@@ -515,6 +564,7 @@ void dpll_pin_put(struct dpll_pin *pin)
>> 		xa_destroy(&pin->dpll_refs);
>> 		xa_destroy(&pin->parent_refs);
>> 		xa_erase(&dpll_pin_xa, pin->id);
>>+		dpll_pin_prop_free(&pin->prop);
>
>To be symmetric with dpll_pin_alloc() order, xa_erase() should be called
>first here and xa_destroys() in different order. But that is a material
>for net-next.

Makes sense.

Thank you!
Arkadiusz

>
>
>
>> 		kfree(pin);
>> 	}
>> 	mutex_unlock(&dpll_lock);
>
>[...]

