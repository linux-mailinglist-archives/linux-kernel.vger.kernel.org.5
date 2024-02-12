Return-Path: <linux-kernel+bounces-62379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DACD851F70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046FFB2198F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283434C63F;
	Mon, 12 Feb 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brieuVgn"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528444C634;
	Mon, 12 Feb 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772737; cv=fail; b=F9vGtVKxUX5UMED3XVn1b/LSvrfCfklqYHHYhno69Ux80LWJSgIZCceFV7ziF1mCTi+xbF3AqPCLdoTS9/iMhvopHxFNpYO6X9Am6P/yMzYfwVwPh915CLyHRC83cc9G2saqp74iRX/zZmNK0WYRMcA8QQDPcO4QdaFc63nSVTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772737; c=relaxed/simple;
	bh=xrUMt4MTwxLPae/t09XHrZDmTZqp8uCOKVR3iG+PC5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k+WA4C7s5uXju/zQVL+pCXa9v7KFlHvlksVbp7izNlnm7UbwB0/Ks59r4fbl0CxXjonHSP+vW+Phj3YJIf+CiR/bBoJJm7YsXryzriKcJnY3AomdGewvzhlP5dFs2g3qIApwAGuj8I6JYjCbaNRhBp3Iqo4bRdMCR2OXUqrvr9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brieuVgn; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772735; x=1739308735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrUMt4MTwxLPae/t09XHrZDmTZqp8uCOKVR3iG+PC5A=;
  b=brieuVgnImu+25mMOm8qzkeLe/xmFRA2fm/BdGRfwtXe5ODBC+jHXrwA
   +BU4leGu4zw0pfiTkJ126vMKcFTNq2yNTCcQ4rXzbOzNaDGL+gGU54G0J
   MkROKIkezyv0eOywQQjQeSKQ/WW44SeoaxwDeej2y//SfOYlYN6oRI7f/
   BDj2ZkSE+Xqmz9qKwiMhnqT7yN420IFLGfw4w6PKSq1AemlAfKSleEkys
   isI8NFKBR/VTZrkMQTRQz801JtKvCS3qfRP3848Tjbda4K8FQ74ChjkTA
   IoJwhp+s46aRTuQUN4xC1r25aVoMyy0lg4hEqkGHMgwl8KkDeyXAbzPsZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396201111"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="396201111"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="3040791"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 13:18:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 13:18:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 13:18:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 13:18:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 13:18:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9k7sMdXgC3TGL73O1fd09IYpgGASt4RAgA0nlI6EC06t5uRoRuK8juue1A90JbWvFmvXslbX8GjKr8bqQEk7YpnYrCZmPzbUVrZIqf7jtYvJlfZUEkET56q6zfw9DPsC9KshaL9qyF71hy4QUDVQvXrD7e/p/BMhXHXnG5nAr/c0zuKicoLSY/Bf7KjSc60JeJdV/2qVwRboEXrBPrJoPWMk1eusAF6rVUCz9PECVx/Lg5KSSVLo/s8KF+YGCzv1Z2gMGRChTPno3kxfv10hwlfUEirII66+/BphiHZQfqoAdhpgNj5d2JEyUJRyH2eEH+n+IZNBV96oLtcf6nUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrUMt4MTwxLPae/t09XHrZDmTZqp8uCOKVR3iG+PC5A=;
 b=a1NXZldrTqnX0nSmdIUgxPnGSFOIBuih+R5rlpEJcv00WDbOtxkKpf3qmx134Jcx6gTNEix1oYi0fuPyVhrT6T1rUXghk+WP8cqVkFDmgRCIfbB3qjMJLxxFgYJOVd3m+ZMsTnHEt5nGH1T4bp9Y9Uffy8DJHC8Og4kXdJq4B8ma8JVXxWa2blEwXteDReDzjRJgEGuW1GEi4jFYJ3+qzWM/7HSoRSeRE1eeZHw7oXpq6t2wih+zMjirzu9SrZ5TSI7Qxekm9GavEzhX+JNx55yRDdebuRJqOkKXFHC6CviXWuKJuYmJyBn8TaOs11fbZoaoZmLUsWlLpoBCteC0yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO6PR11MB5633.namprd11.prod.outlook.com (2603:10b6:303:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 21:18:52 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 21:18:52 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAhC1AIAAAfPggAANwwCAAACQYIAABwgAgAAJWQCAAAj40A==
Date: Mon, 12 Feb 2024 21:18:51 +0000
Message-ID: <SJ1PR11MB608319A906F5DB0AB18C1913FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
 <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
In-Reply-To: <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO6PR11MB5633:EE_
x-ms-office365-filtering-correlation-id: a3beb5c2-c007-4282-9b9c-08dc2c10362a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d3OWVN1il9hAjz85rk8AiXMCrxl71bhQAN8jB/SldSx9dMMhcA668kzgCehpaa9mXgnlWU6H/vc58m1GCxg1LaQGDWY+TNlqVpnHPjc4HMANBlC4/fRtGHbvvLm60hvu8Tk7an/j1LW6hfn2KB9yzMrR8cVXTY+7x+BsKKAhg+cSTVrY3hd/nr8g6LBEWnVDjMeTWmhJzthJSOX1CeIOEyBiPdd2Kq/CoX7t+mbKRYmdU60LvqsJhJDMF9eBalxKubIIPznYMAD8RTWUlDw8ZlJ40cMW41USqcCtMewHhoMQf8Gc/xk8/Uq4VP8X1BJEZwx2vsh9yy9V2MmVAumiOFPMC0P2a0tADXoaWCFpsuusaj5iGMd5uH/QDo8mcmY67EX48pAJwKHD84oj0A8dtkbCQBU6Zt47DaJ90VieoXzoed3wQBt4h9ni0q/DpN8u2sJsh/YydbweAG0mJQRDFHI4ZSdR9f99tDiSv5gBqSXe3QFrcCKFswUZ+dEcdxjyyO4WYhyA/XQtnsgZvkOw8lCpLeC1JUgsPwFT2OHvy/Pl0nR7OcLp0AOCzSW4xMwKRrN+uxn2yfHH1v1+Bwb/jkAO6955rKToWBT/hx9YW0Bc8uzk5qZsq8r0P6qe2u2a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4744005)(2906002)(55016003)(41300700001)(26005)(478600001)(38070700009)(4326008)(71200400001)(54906003)(5660300002)(9686003)(110136005)(7696005)(64756008)(8676002)(8936002)(52536014)(66556008)(66946007)(66446008)(66476007)(76116006)(83380400001)(33656002)(86362001)(316002)(6506007)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X5bK74WbQETFpRZoHyCDBMJKBBDRlfMNOOjbAqodQK+C/ylnOd92ngmFt7sU?=
 =?us-ascii?Q?LRPka5XYPqfvzyTytO6hEM1ipHjTn7hBRiAlQ/8U20VDFoYTNTR3pdjWBtMn?=
 =?us-ascii?Q?MPymNRdgB8ZH3c1UaxRFjL/tVKxn0WR9H8CO5ThAaXW5FKYbpQCfyCADK/Dk?=
 =?us-ascii?Q?kn8bhRVeegwQhwIJAY3+sY7DM18nfNwxvbMWvlTpJG5zAMfc9uPXQryU7be3?=
 =?us-ascii?Q?lP+Ud5/knj2FLpxMGYO5pZ7st1NjhLIqi9/VYX0M1mVG+G70OoXFKHVWj7dL?=
 =?us-ascii?Q?TMf3ddxT9okjWz7IcSXIa2aN4FD1qCdTJ1TshL4TUyNI0dMv3DX7wtn9UUsZ?=
 =?us-ascii?Q?Da/2OBemlz7UDgQaEUGMhfkTx7/CQjR481DIhOtMOJSNH7XV89EVdjDuLFsq?=
 =?us-ascii?Q?s1q02c7fyj7DBPMawiLNsuEolUgE7atdysLLWwVUKttAaTRuDUnkzNdaiCk1?=
 =?us-ascii?Q?PbvCGZ5HA0Q8AWg7krZkzet/mK0aU6ffISPzzi4nPWMXce1X7kJGplNcdvh3?=
 =?us-ascii?Q?86Zbr/Ms0XFaDd9vL0/pWitX9WK8VR2lIDNG5LAebxu7/trprZbkXMaUU2Yj?=
 =?us-ascii?Q?GhMRQ96peego3IcAhwyKhnROfNMXLUdI89nGem6ffy90ChcyE1LTJwQ+VbZM?=
 =?us-ascii?Q?PZAj8DKVW+6e8WV0SvWSyWLkgWxpLDvUPOKKZS7H00oYco9QX4R+OPGuJGsO?=
 =?us-ascii?Q?DTSWBXAYhE5rn4NV5rb1hzTzghLlDVZIwZTGTvOACBrL7Qqt5CRA66Saz+wF?=
 =?us-ascii?Q?Cd6jxRuId5DQ21np0ISUqY+nMAxHbxnUdQ+gnScaGJhVfkSEUpF0JFAeDo+a?=
 =?us-ascii?Q?v4enFJMSiihEnwKn9ZjCc6egwO7BeS50FFtaurTPOfy0MmPffmmS3TZtk4TB?=
 =?us-ascii?Q?Dtz5v1gZLfKTDXpTDBtEgmjQLPtzM4U0U/0R1cZywGGQ1jwg5orxIoxh41gG?=
 =?us-ascii?Q?IfUbdmIxbK1MQGqCgnKHz2pEQCHM2bxBWnXnePPmBAdbPjrYO+ZQgVqbIK78?=
 =?us-ascii?Q?xqmkdfYvaYGLv5SZ8L+GS8xIAVhdNgYgcU1ulTxoEqeBHJ8Iz9gZQ1QCV5sd?=
 =?us-ascii?Q?WNGEbnpYwYHzvMG04jfEl65GX4v/XrL+dHQDy5oKwlFmJgKpC3cYnmXCSYRq?=
 =?us-ascii?Q?mccFvZ8WY9Zbz5eDeX8/ZxkBdf3R7pEfvcJ4hPTVPCg53bLyv5KSsayFZTc5?=
 =?us-ascii?Q?/jJUApMSRc+begNS1j1Q5vaTZ1MEhNPMUVCXn+lui+ERTFiQ6R/M3TPLzJ0V?=
 =?us-ascii?Q?byhOuoHABc1mRlqSXUhYSE5W9F12RpPZvRNGFd8a5NZ/IHyNQlGg29cFFjPy?=
 =?us-ascii?Q?i8BNcRucbjDF0K3xN/swMJzfqRMicRt3F5bfvaOMRfGOXrcecXJezt/CT0HP?=
 =?us-ascii?Q?Czk0yDLItVESHFdsSTlx660Dt9L0r4mrhf/ywuaAHypSwPz16LPBppo8loTh?=
 =?us-ascii?Q?LB/jMnDkoAFBwp4i+cM9QF18hiGOlJA0b0XUeIfUECkw+2wEYviq4AudZnPo?=
 =?us-ascii?Q?P5FzBQKzjSN4J2GTaC7/Mc870Uaz+ELjF/D8qdrSAnAf+1QzUT0BbyQGGGyC?=
 =?us-ascii?Q?sUdBm8ZQDuSYSpwSDYsLk1+V/Qz5bziV/QgSkvOQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3beb5c2-c007-4282-9b9c-08dc2c10362a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 21:18:51.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0pmq4EoT/Vs9GQ1Zr+LhpWhT1mfdhTiAtFF88Sb/5q6ERgnoRaHgnulUKTWk5sWNKsMbpW7pUejfxkCT1h6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5633
X-OriginatorOrg: intel.com

>> and this is exactly what we're doing - adding new memory.
>
> Is the #MC adding new memory, or is the interrupted context adding new
> memory?

The interrupted context is adding the memory.

>> So, until we're absolutely sure that it is ok to interrupt a context
>> holding a spinlock with a #MC which is non-maskable, I don't think we
>> wanna do this.
>
> If it is the #MC adding new memory, agreed.

Not what is happening.

> If the #MC is simply traversing the list, and the interrupted context
> was in the midst of adding a new element, this should be no worse than
> some other CPU traversing the list while this CPU is in the midst of
> adding a new element.
>
> Or am I missing a turn in here somewhere?

Not missing anything. I believe you've answered the question.

-Tony

