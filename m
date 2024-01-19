Return-Path: <linux-kernel+bounces-31223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5C832AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C030B223A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC3B537E1;
	Fri, 19 Jan 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXtKgAcE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661104F1FA;
	Fri, 19 Jan 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672213; cv=fail; b=Uoi53DNNymYZ5JplmolkEIeGl2R9FhR/s6tgL7QeU14i5jCnZsIOHMh5eHIdKlIkMdrQeH/RWgUclbgOAJ8RGu5HX7mKZaued4nCxJi5LK7WMynPoz7uKSfpU4GEeOhjymq9eSsZcxx2WzOd+SsUV2gzYGRTZ5iWr2h3dfJKqso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672213; c=relaxed/simple;
	bh=ISWqc5ayC/eZ8WXSpQyA5FrPtnqaVKPwwrHRcMU/Rc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AtlItObbruufE4NY9fJoBEFux4WQi66aWwYAB37tfq83fSA1M6sBVoG+SRTwIR1rERPXZ9EVfHiYjOnVVaILF0HipdMgMj4Yg6dYQL9Z8317utY8TvEYzEavjrlvE1bnyffmY9ZpdNa/QjqjXy4AekT+rtm/RsDEn4poS5a5SUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXtKgAcE; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705672212; x=1737208212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ISWqc5ayC/eZ8WXSpQyA5FrPtnqaVKPwwrHRcMU/Rc0=;
  b=lXtKgAcEOVpU/DfSdzbPxxlkNXvzXVWyxXJGWc74dMcw/jyWcDGh6Kp+
   nutk7bt0JL1WyvGKOzLB+1FPazo1ekr87XZmSHr38iZznN/4vjDxEY1bW
   pQNrXDoFzq+vb6fHaQzzUl3KhIhDYMK4ZHs9Jr30337EtmDLhCzAqqxnb
   sNvfKAPtd4o5WVbDeAM7i5rANkLeeYeqE0tE0aa9iTyCRpT2mY9dJ+Y18
   fVEVbslWvtRarxJb665oQ7o/Q4r2HCb/yMd7hQt3CU1KH4Aw7flXACoYt
   +Y9htECnXxMxslzjc+e9Ijw4frquIBG1eRbyL7QtbMhvsTl0W1DuZ12S+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="431920648"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="431920648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="661412"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 05:49:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 05:49:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 05:49:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 05:49:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di8/7+sad9M9zo6W1xoEEfVY/KnBlOFXmG143KorYEYI1NlMemg+nE9JXR3Zf2UyCCsYFEZwActH5C2fN0MmajE4obXzJry0exohYaYZRniqUm0UhghHo388Yl71lcpGmLfkMnJ+duL2uqKXpddDNNVRNGzcFW1EW9nAmWxUugFgIEQUpVP9fY+t2t2u7aco4u0K/9g4oHdHoAktC7qfL9Qw18PxpfYj3swDpLPCwAZ4MG0bidMPI5t6vFto8Rhs7y2u42WGNfUaCU8MNQ9miKw9SoeozNeGTdJGnIXIs1ZZao7tERF5+f8nF257B/a26Pr/QPKdHMI5GyrXz7ualg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISWqc5ayC/eZ8WXSpQyA5FrPtnqaVKPwwrHRcMU/Rc0=;
 b=m4VmMwK6F6r9EgXzZ+xS9Y5nY7vB6aeYjqMLEl7AuuAjlL0bPNAgP3UJUO2cMQzxGB3OHUbOuBvni65Jfk5/KJiWH8u1k5JeXsQD+cNucJym7Jn0SAiH47auduAKeV6fnWf8meXNOIbgmWV/vGA65DagZnovYuHLM/R5HmoBCyuvqT25Kx+OuefnUrK8JX0VITJuEVuhHk5iGi87V7404DDHb25OP/VQa8bdx5he1IYKA4wYaWJ218iMsUlFwymC0EEjUaYqub2/HeX1s7PNZ7uF6jrqXpo/IAtgPCif8sBS9ZQGkeAPN3WdbOTTp4kr7jytAQCHXj34gzmHQcblrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Fri, 19 Jan 2024 13:49:50 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 13:49:50 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "Olech, Milena"
	<milena.olech@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>
Subject: RE: [PATCH net v5 1/4] dpll: fix broken error path in
 dpll_pin_alloc(..)
Thread-Topic: [PATCH net v5 1/4] dpll: fix broken error path in
 dpll_pin_alloc(..)
Thread-Index: AQHaSf748epim8CE60++RWv7qtxZMLDfcBCAgAG4mOA=
Date: Fri, 19 Jan 2024 13:49:50 +0000
Message-ID: <DM6PR11MB4657B82403BC6B08A4FB26629B702@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
 <20240118110719.567117-2-arkadiusz.kubalewski@intel.com>
 <ZakMUbC9xLzjkZwF@nanopsycho>
In-Reply-To: <ZakMUbC9xLzjkZwF@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: fa6827c6-6695-4347-910d-08dc18f581b3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0S0Xa1x9P2HndRVtUIoPNAXMwhPRgKXuUqohQHiKvi1/qBpA3+YdtobsrkzYjgPW22CrPfSjJAIdUDAAWc/T0PAd97HfWiZUj4L6EO/B/R6in+EPhOpnFKLOggTLmzu/qJdD1dpHJY4phxijMIQdIgf2l9KqwLLFYSdkz17FG8G0WhsH5LJklJDh3Z6F9JIo3VKhu75rpJXDIh0GxNFB8SEP/p3jAylPZ4Id4BREVcuUgHzRgwyawAUUqvBPUSF1W7d5uCrh5c9TXGO3AiiYm1XVbiuW64iLYEcohicjyIhoXKP1xvMjhDuPcJglpY0Dwppe+O75+0Lry53+LyPb4p7ApKzcB6ozw6/+UjzE3fVFIDLM0tYlvQ6EgiqN08uk9NWsicST1U/d63iomkZbuSZD9I2Z2C9FbuGd2p1/NfMPzMxVXTJJ2A+8APN7yLsWeJC5M1Fvlf4YdiaGWxtmPNlhA95nchjfiXCWQ1X064esUyPRtaA91N4sgEqrq+umUtf4hRQnFSBUI5TVe5gHquTOtPnD6CdgHxqWOAZo8LL2GD5MV9o9XwFe0A8CxbePWfXPY3jc+cOIla5tHUZMGMGzAuU7NPhAR9DC3+6MRjv5ygNfKKh212YVg8aUU8eW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(55016003)(76116006)(478600001)(9686003)(64756008)(316002)(54906003)(6916009)(66446008)(71200400001)(52536014)(8936002)(6506007)(8676002)(7696005)(4744005)(66476007)(86362001)(2906002)(122000001)(82960400001)(41300700001)(38070700009)(33656002)(38100700002)(26005)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Epp2FLoaHR+NOEGmeEkJBorAjjUt5vYBUJ+9yj5DOLRdfWqn+kZfJnhh0ej?=
 =?us-ascii?Q?Zr6zeytijz5hWuJGgyvCKQI9jIOMKmz+vrKjStz/Wb50bQJJn6LPm7aWEf9t?=
 =?us-ascii?Q?gQy+tB2l2lmMAJsM1ShtQLznuBlfcx3DrX2KCuhgTHZHWhgDWHG1WfvJlp+r?=
 =?us-ascii?Q?nXNws12jY3zzC6TjWJznxYEx5N25Hf0DD9OfIK2NCnr/YRBEjSQ16Iks2asP?=
 =?us-ascii?Q?lcn17q+6dY8WpdPtbTtCRLPctFiffuEj3LIywuidHmBa7DlSIPxzupffvYJn?=
 =?us-ascii?Q?SKesd2BRR3kaTdAbRMYtjpSTTyO6xCvRjdoZH5b9f2J1ct90+rSySMIsOhUF?=
 =?us-ascii?Q?nrqT8wLi256RwK32Y90g7zmfliQsU+J6Woxd3sE1GpZ1wQx6lWHcQSWEe39K?=
 =?us-ascii?Q?lgeyBO2OrMzjikvUHxoz6eZIe6Y0n6/QaPkkcwoDCQLUCLV6rhAjf6uNJgLX?=
 =?us-ascii?Q?wI4sVpTsfZhaIxTz9GJ0G0Czide7h3HIdTlod7qroFVQWxFAAHLvTTKuqrA6?=
 =?us-ascii?Q?1Jte+sMNtJ3E8M8/pUuoWWs1QbYPwSVpNzFWma2tE2/MlEj1Yu93YgZ6JPrU?=
 =?us-ascii?Q?XrcrX1BwNua7mZPmqF4rrI2b9vkWG2yQD55KJrvph0fmsiHwHQf36Fl6SlfD?=
 =?us-ascii?Q?doXMfjP08ncQnU9sd5/W7mwAIico8Askral3na66XJC+KcOYki0fv15n0LcK?=
 =?us-ascii?Q?WLsCBYm74VaIM+yj6iQgDxFeX0IXGvMM+ELglVfmFkAkxE24XrjMKx3SJuCH?=
 =?us-ascii?Q?1GtbgymQwk8s9mBPD2kRceT6ChRixvoehP6/MrHnUuz6tNg70d4EEMIKFq45?=
 =?us-ascii?Q?SMru3iv6SQ/9E/wPm0pNVVCYZKI155juU0rgDhCQsUNdMnCzRNm/zn5+lhEK?=
 =?us-ascii?Q?SMBRKTXJYOdrOBwkmX8abFKRMwGuq1kHePeo7SVYZG3WBjD1FAF4KQrJ1iZq?=
 =?us-ascii?Q?GqkToKj9+snVMCUhaBrH4t/FAC51xYZwqqqctAjQPlsjQ4NfKo3XmsnihCsd?=
 =?us-ascii?Q?e/DDaU3h5NrReKHGJaMUJxHgiVSowAqevRRqwabfzMLQe9+iVHLLW+sk15GR?=
 =?us-ascii?Q?eMzt5YvM6X4Y0ZplRR11Wnr0BZaUujf3GvCSP7kG5mFna81PxvKLD4qUIdub?=
 =?us-ascii?Q?/2ENOzqyRn6JEjtFiPmeusjXOyFAI+LPqJDiaaA9osgQDkdlaUk93Nic0GIf?=
 =?us-ascii?Q?l58v6nKDOWUDHFYUrvUDKZ9ufpTsqNvZqkaTGjv5LAOPJTAeZPmDkUljEBcU?=
 =?us-ascii?Q?67vFYtBEM3rLn5NY61y8Q4F8+t48iR1PQrT3VLKscS4v+g+Ze5IPBSchnuXh?=
 =?us-ascii?Q?5iJdXvHDHaJsDpGfWrNUj1l3nuSxblwDe52lBd+prPWfRlbt2cIX5neZwL2I?=
 =?us-ascii?Q?+T5EoKBieVCRT+1mVcomOVAAGlEfhppGeyyomjP8ZEs+JSEkSyDep7pzn1M0?=
 =?us-ascii?Q?KpguosVXPZW30FT8KjcuuavzdpT56QSBqkfjkGpg00SMJ+YSWzEpVRfyjtuZ?=
 =?us-ascii?Q?ZnrpbS0sZ0G0A8u+4AiGzXGTwaxhwTgJCFxelNvsV240b37vR3uE7thb4xGN?=
 =?us-ascii?Q?VifmOxHwh07FMBH5r/C63alZLYHUPP4LlR0rVpugNCKCVt8It1A4jpcQaGm4?=
 =?us-ascii?Q?TA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6827c6-6695-4347-910d-08dc18f581b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 13:49:50.1601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwNxVUKq/OtKaEOcAxswmOxB9gb7gd717rXGvt6Tnl9rqxaW254a80/nADniVeYpNlrmJT+jH1xXbp2FIhC7HmX0/WqBHHWX5LMn88qitSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, January 18, 2024 12:33 PM
>
>Thu, Jan 18, 2024 at 12:07:16PM CET, arkadiusz.kubalewski@intel.com wrote:
>>If pin type is not expected, or dpll_pin_prop_dup(..) failed to
>>allocate memory, the unwind error path shall not destroy pin's xarrays,
>>which were not yet initialized.
>>Add new goto label and use it to fix broken error path.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thank you!
Arkadiusz

