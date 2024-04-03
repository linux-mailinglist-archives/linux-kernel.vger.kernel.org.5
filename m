Return-Path: <linux-kernel+bounces-130462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F4389787C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2A289230
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03B1552FC;
	Wed,  3 Apr 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcwLt8oY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E46153BCE;
	Wed,  3 Apr 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169902; cv=fail; b=QdAbRFdxJYBgopW95CI/N3MHSYcogXsQtMKGy8uBXVX70XpyzIK02kwioUZkonzPP9Es1lhr/EaV5J9S9cBYf+yZ2F70412JVyQAo/30jj2C1j9KcSOwoTOYUAXFV/zLKY7PmCjDE9hYsOurWhoTFOUVc5D4btHjCrz0Qrkn5dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169902; c=relaxed/simple;
	bh=nDDC0V739hXezIBksPEt6eMVyQErVLN3GT+PRWfogA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i74avr1AOZjxzCcAXu7A/xJumcHABl5ewuO+yJnxYowZiCwblGIxw/iwKQ5I79nT8MadIinXcHMCJ+qIEhVCi9LQZhMw07FlFMRLluG0YxlkTtk/Xa26P8QOkWrz8qqbLtmY5XcIsboyIft9A685gqkxoUH4kLdOm82kfEuaJbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcwLt8oY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712169900; x=1743705900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nDDC0V739hXezIBksPEt6eMVyQErVLN3GT+PRWfogA8=;
  b=ZcwLt8oYvrRC5Xt7Y7aCfMPMnM4POnYaz+L487LRjlaU3oM9z+Uwb6K1
   MFKerTmJpQDVSCpvz7mqUy0GT2zCFZEoOACYUlsgbjsc6G5Nq4snXrwOK
   nsOE5GSKcO4ADkUAXs26eOZ+t1H0n4BNkTqXenhwVOxSzqVu+NG1J6ePi
   U92QWbSznv9GqYG/LDSrk2IMNi5wwteSmehuuYsK4LusRmEI0r6LGstrY
   ZcN+/s9JuSOB6q9gOyNmJW72U1mVjE9vl44Z0whYdfVjapi2aLBV4vJL2
   /OG/JjR3QVp4QKOoem+jCrPjdmN5BTaOlrKAKiZdnB1XtniayBSd3ooC0
   w==;
X-CSE-ConnectionGUID: 101XAqpkSRqw/G5qJYeatw==
X-CSE-MsgGUID: rqnDSc4RRW2l9RrkMJeOtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7268124"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7268124"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:44:57 -0700
X-CSE-ConnectionGUID: FmBoWR9bTKaxA3wxe1IpSQ==
X-CSE-MsgGUID: If9r+fzSTE+HPGBXb/O0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23179644"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 11:44:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 11:44:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 11:44:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVQarfY/9D4Kop1u0zUJ7QzTmyEt1BQZtbtWl3VMNleezl6qxnw0plXBxMzdoTLYsP4pRRXkBbSb4VDZA35QDiSOCz+HeRSZDwT9f5eSW2QtPwv9wsOThzfsq1BlBn3R8+P5Y75vL6T+EO3cIZttYwmpUBcV+1WSU5sqrzbXVsaNzsaswou+EC2A7CIlG0sKjN3O9xqXEM0q4dGdF0eArK11xHdS7p36ytCp4D8i3kVV0UeXwU6ZFJX3TE5aFiBOq7VxqS143k+ERX5fgIZyBrofJEbKRBMb/cid5ME2A3oyv6ECPp0GK9UyHHWzpHF/MGXNqrB99smfpVGa0lAB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m82PTRNONNWewn0grskgW7toRMOsJIv4XO8V8LaEbvE=;
 b=M1rjxFEfJQTzjYwt6XPzRktbbGMC/6NDlOdpvLQOBl/UqKLzz7VSfpwEVesYt23XZ9t7dziGAwzIQU4Q56u9mNgvQt0nq4NmmP+/k/C4LfSORyv6Ggo7n5cbA8AooBBCCPzr0KIjZ/EZ3UcnphKm6WV5553ZNK+H4jeIM0eEHNi62ovyVX2n9GGdlYkzAg7bok03bbtnQNMx+Sfg2r/BxY3Xnu7RA/jRE0ZTcul5y2dIwB5IX/qEvsHXXKMZbQ4+S8m8Cpz1N2N5yjmAML3bBq58ZEsCv2Vgkhf3dgcJbcC17QYkYWLB15KDpXOw+8Yxiec5rfs9l3cPTJxDB/T2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 18:44:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 18:44:52 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Zaki, Ahmed"
	<ahmed.zaki@intel.com>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "gal@nvidia.com"
	<gal@nvidia.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, "justinstitt@google.com" <justinstitt@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "leon@kernel.org"
	<leon@kernel.org>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "saeed@kernel.org" <saeed@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [PATCH net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Thread-Topic: [PATCH net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Thread-Index: AQHahT/KhBQgJ7xfRU6OkjwNf3vRTbFVz/4AgAAxKACAAOIfoA==
Date: Wed, 3 Apr 2024 18:44:52 +0000
Message-ID: <CO1PR11MB508917567D84B711C2BD5821D63D2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
 <20240402205223.137565-2-rrameshbabu@nvidia.com>
 <20240402191842.66decfd3@kernel.org> <87r0fn2e2b.fsf@nvidia.com>
In-Reply-To: <87r0fn2e2b.fsf@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6299:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MIcGAi3ozvzpOdy/xyaS23qTk7H+/DNV2wtzXkqx0722DuVi0OKLFH0fqXCEBkeEGz4mPyW2tXYjDfTl0FhzLLBBCXORSZZ3rf89xxiShhnnThAgrQLqs9/j2NnOeEvdZ5W+7+GYkYmif5pQ2GNE+pLRirUxq35xi0SsSQk/BOgxurDU0tTdSITAtmnkAlPbhQJnqXwqO89BbduLBuINMOGbQPTgYtfkePanpjmErIEQaftWJoCoQXcGR7fuViqplke/in+Czd+0R/Df2dN5mSASXYVYNUmhbYdgHJU7L3osFTAf1BfQrRb+pub7/g6MHpSQOGxryChtDsW3Q/4DDrhOPYLfx/pSF+UwvH/CT2wd9EJB0XXKqOManANMMH8ZmFe3xbilF/lrMs8HgcCB/Qxs3RByzFScFBvPsOPWZbEN+0mxKlHHH0vs5szWnWdJ4fEOq6YBP+xNEHqyRid21akEZyepUncAJsi/gdm9Mxnv/Mih1lbRAmm/3/VL79wuRsYa5XxWvhsgW4hmVuXLFVkH9AfzWvY1pV6E6wAdKnW994UcRxINPmjiFYQX5a47f/RtcUzGp1gE7TOgUSvZsJICqqNXBwiqGvDfG+hkCo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ZkybWUXwr5BgjPLu0Pc1ZagWoW3gqH1hGyfVvwxnmemP8bvhZa0NOUe0ZI4?=
 =?us-ascii?Q?w+u/ebMko2aqlabWQ4XRKiBlkrB8LFhaHyY7qAfh7pcHcOrgG7DBvp2kQ+6i?=
 =?us-ascii?Q?I2wZsAvghoMHnPCh4D60hYe/UyPO32UHW3v/ab86m4YYdOfnrIyzkpm4FzAx?=
 =?us-ascii?Q?l6lfVZ4U1n10yA3Y1kIEE2LaALSIfzeGPQ9M9MAvmCCdDAon9gHdSDCYqhQA?=
 =?us-ascii?Q?IfTzcj+VsNqb1HCcUj8Epz56XUlnTMEdr6YeFecPwL/wPJNL+IUFj9z8JjMl?=
 =?us-ascii?Q?msG8+l+uwhH5pw6aSaBss8103Dg6aiBH0C9RPM8uGxzMhjJb4sIqBi23Oaf2?=
 =?us-ascii?Q?TIKCAWSXfsH0nCgFG8EZn5KRqUBerTpl3iZUYJWW2ryIPRGYwK5rH+Oc2DME?=
 =?us-ascii?Q?V1pVXftGcGP8Pyu8/pF3OrZDhpqZodU1zjcpvdCNLMVu7wDWUY8NNyec/sRC?=
 =?us-ascii?Q?eNg1bmC9jNiTckAE1XKoriZSt4jc/AwpNVqHSJHV6mdrY47BCeSuHVtbjHpU?=
 =?us-ascii?Q?Z4ISpNxqzJF79tvM2H4NaIKNAAQtexdE9dAqxjAQT7mdtNroNRjCe/0FzKrR?=
 =?us-ascii?Q?OmzlB7InzTnRZb+ZAUIcy6bmlnN7PkWmUluo72EFHil4dvcHSNDWdN8Roi2G?=
 =?us-ascii?Q?0mIgUIXA6+g25jStvW+0QxPK3tDaN9tw8sjEmLQHAf7AF6ibLfUfhgCe1NWW?=
 =?us-ascii?Q?VOp6BngZ7xWYGIsgu72aPOKkQmZa/hnxXWoOSbRWKXlrzb4dnpHkkVOg24pk?=
 =?us-ascii?Q?LBOGeTwQ5SP4TIKj+h+Il9qAOlqtVm4XCxmAs6iGQ+xPR7m83+IlfF6HCVEX?=
 =?us-ascii?Q?XkMOKjwlglOD44ZV/9L+dzG0bSH2jHRrNJ61h5VKl4Is67IeNxtMESgWaeKN?=
 =?us-ascii?Q?JIhBNMwFSDBw3aPIdleU70k7H/EyugOo73nXvlR3b+ur4mMcolqDTro2pY4v?=
 =?us-ascii?Q?lVhsmU/rB2iO//vlIrOXZO4yushYcdRJm8yQ/HcjZOxN19gBOedQP72+PEgf?=
 =?us-ascii?Q?3HeQ98ykqp9tpASh/V+DCD+Lr8QEKF80/Gvy53zCY/GmASALWEZ65iRO3g9s?=
 =?us-ascii?Q?wJcKcjv/s81OvQr6AzhzYiO4c7HijA1M0ABm+ST3JdRiNIswDaim3ZNQdzhr?=
 =?us-ascii?Q?Fkf/U878msTXfoFV+4x2RDgdrm7sEOCZ/T8ldlcUxWJe2Ax5ej2E8MEUyOPO?=
 =?us-ascii?Q?DVqhMWxMJxyaD8bQQnKMQTcaR/9egAom6m1lB7oYd4BQpPdesw/OazVZbwL2?=
 =?us-ascii?Q?tiklSwGC/RKA8xkK+lAKn+SeOXP+zu4F8P3GEtKflb56wIZ8Mt3qqLOL77iy?=
 =?us-ascii?Q?jIQqjd5jW7fvF9Ao/lbG9KZe0SlFJ63y7LssjUOZucZftXOouuPfX/Degekv?=
 =?us-ascii?Q?E0DZOlWp71HWu2xzJWhLUB2D5iSgejcCKwDo0360Oh+HUdgwA18VKw6rI0Zm?=
 =?us-ascii?Q?fh8O6sw7mBqoCKHS0n0kcq9UJxjr8S1Ob5Fsrkv3YjOl1vdf3kGKp6ZXtOan?=
 =?us-ascii?Q?VXVhhRjLQPzm8iI93L4nVPuceIemNLr6zdm9z69I0cPQEV0F1ZjJO4kjFX3F?=
 =?us-ascii?Q?ZjHCMHOEW9I9LYT91prD/koOT78TbmU3dNa5xtGR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d14f5dd-69dd-4d88-c176-08dc540e261d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 18:44:52.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gs7vyWffv/H+1o8Krd02eY4B8zqhk4wHa2s2C+9E/CQgKulPPN6dWYR/uJT/ztrnc7MSWJj7gt3sWVXLSLgIRhY1cGPmR07Dy4ZWRzWeL0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Sent: Tuesday, April 2, 2024 10:15 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org; Zaki, Ahmed <ahmed.zaki@intel.com>; Lobakin, Aleksan=
der
> <aleksander.lobakin@intel.com>; alexandre.torgue@foss.st.com;
> andrew@lunn.ch; cjubran@nvidia.com; corbet@lwn.net; davem@davemloft.net;
> dtatulea@nvidia.com; edumazet@google.com; gal@nvidia.com;
> hkallweit1@gmail.com; Keller, Jacob E <jacob.e.keller@intel.com>;
> jiri@resnulli.us; joabreu@synopsys.com; justinstitt@google.com;
> kory.maincent@bootlin.com; leon@kernel.org; liuhangbin@gmail.com;
> maxime.chevallier@bootlin.com; pabeni@redhat.com; Greenwalt, Paul
> <paul.greenwalt@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
com>;
> rdunlap@infradead.org; richardcochran@gmail.com; saeed@kernel.org;
> tariqt@nvidia.com; vadim.fedorenko@linux.dev; vladimir.oltean@nxp.com;
> Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: Re: [PATCH net-next v1 1/6] ethtool: add interface to read Tx ha=
rdware
> timestamping statistics
>=20
> On Tue, 02 Apr, 2024 19:18:42 -0700 Jakub Kicinski <kuba@kernel.org> wrot=
e:
> > On Tue,  2 Apr 2024 13:52:01 -0700 Rahul Rameshbabu wrote:
> >> +/**
> >> + * struct ethtool_ts_stats - HW timestamping statistics
> >> + * @tx_stats: struct group for TX HW timestamping
> >> + *	@pkts: Number of packets successfully timestamped by the hardware.
> >> + *	@lost: Number of hardware timestamping requests where the
> timestamping
> >> + *		information from the hardware never arrived for submission with
> >> + *		the skb.
> >> + *	@err: Number of arbitrary timestamp generation error events that t=
he
> >> + *		hardware encountered, exclusive of @lost statistics. Cases such
> >> + *		as resource exhaustion, unavailability, firmware errors, and
> >> + *		detected illogical timestamp values not submitted with the skb
> >> + *		are inclusive to this counter.
> >> + */
> >> +struct ethtool_ts_stats {
> >> +	struct_group(tx_stats,
> >
> > Doesn't seem like the group should be documented:
> >
> > include/linux/ethtool.h:503: warning: Excess struct member 'tx_stats'
> description in 'ethtool_ts_stats'
>=20
> Was looking into why our internal verification did not catch this. We
> run W=3D1 with clang, but looks like the warning does not get triggered
> unless explicitly run with scripts/kernel-doc.
>=20
>   https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to=
-
> format-kernel-doc-comments
>=20
> I have debugged using strace that the way the kernel doc checking works
> when W=3D1 is set is that the matching source file that is being compiled
> is passed to scripts/kernel-doc, so include files are missed from the
> doc check. I think this is worth adding to the kernel documentation.
>=20

It would be great if the W=3D1 setup could figure out the include files and=
 send those to kernel-doc too, but I'm not sure if this is possible and if =
so how difficult it would be to implement it. A lot of headers produce warn=
ings because a lot fewer people manually run kernel-doc on the entire sourc=
e.

> Anyway, I will send out a v2 with this fixed but wait for potentially
> more feedback on v1.
>=20
> --
> Thanks,
>=20
> Rahul Rameshbabu

