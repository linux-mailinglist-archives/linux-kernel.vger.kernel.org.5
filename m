Return-Path: <linux-kernel+bounces-103636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 237FB87C23C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C913B22896
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172B74BFD;
	Thu, 14 Mar 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F66nx3EO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23974BE0;
	Thu, 14 Mar 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438619; cv=fail; b=GM5T8Ub3ctwivtJVSOEp2rl2t3/VQ6TlZtZkp/QqNph/ltOAv4TUcIFTm4ZCAMVg73S5XSwbI8y+sqSK04c4vqoQLB0FlKQY+2DPZcbhGWo04cFMj3OPEfYFE92vTTD18svN05MwZZWOO3fRFnekXgX7Dsgrcxd+1HSRX9j7IDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438619; c=relaxed/simple;
	bh=ad4tuo55fxbhUBJFWvfULseTsWrxwiyNsZHJZua87VE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lYJZGwcgLO0eJOIopf7l5P4iRI5KyZ6VtXoE/BEp7m6RXQK6qtbJ5kfc8utsHTYOP1odFhzcWv5SG32qrnb1ruLHy6DucjqgT7UEHb5TBaDg52cm6SI45gG0Vl+4+yk2Ib0LcuPFR4+ulM8ncUBndCbp6aZfbgNEB8NtFnsUlls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F66nx3EO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710438618; x=1741974618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ad4tuo55fxbhUBJFWvfULseTsWrxwiyNsZHJZua87VE=;
  b=F66nx3EOibBMeNqT8ZiAbVIh3DbrWNco9h8/MFBC3+wBEW1D7LZey+ze
   zkdSL5R2NbtNhL+CBG2/yWZ3vCGk8YMqtdBScnyLGs6I4RBT/W9c6hn+F
   F+i4VHncABraO55CRrMe4iW85T8XgNixpuYkTqh7Wx0NqLgtRRDY6Pn3l
   zlPcCuG78oGHxRPWHIs+3Z+1b6F3VJ5/6kVW4IBfs7WKCU5ZYXuUgQ8+t
   Wb3nZ2gyfcno5oYRqzjhOVBHiaLbUaokkjFpSkfF+kKp/KkUsDEwrgnV9
   DG6O3AxMXafpXy57iMsTcIhse/8FhxXsb4LuM+ArbSrfC9ruks55bTH0P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16676390"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16676390"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 10:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="35496767"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 10:50:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:50:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:50:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 10:50:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 10:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxT5FVfDkdZsJ+njewJXAfDredesEUM1f0YJW8Gyuma/60Y+qF814ahTq6UW399W1/6r8L7OjH35VyoZLr2zaSZHl9pEWRQlKUDksNBKJJT7W+Haw3aUJmclKgRMAyPQMxHadmdgU8nuFz+KLkMcU8NRx3CtccMlTCIMx892KG2K5W6qLDReri2YKS0yFrEITyxK3krZ5tZ9hfDiJq3o1320qLilaaox+iaaCuUrEjlDZycjRHoI3TNUy6SNNA+qiSKLREY3Jy95f9u2lr42+h3LM9QZsqLwwm2OQUoLUzIluKVWv66L+HXUQ/jL5OoxR0DDvvZpqZv9xbHH68A8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s7USlX5PmbGv+2P5Pz5ggDEBqlblYiWbjEVQHsUaCw=;
 b=njlrFEJgtoK27Jz5xl8rEbILP/hi466Io3A3IevStHczcpCR2VXOqloO2ecnu0JhJbXoxcr/c6oLKSRVoo5xHgul8vC7sd9rQ5H6cqtIWbw+BBOq+pnCKojTwuY85bIuickJsgJCL5+waYOJY2ZO4hqb6fAREipzxvdma8shXrarWyOYVo5RVFutS/mH+EJ8DDWwY5OX4iK586y9thbpwaUoK9+hoMH7XJ7/zFQI9f8uQo3QU99BfSkNWZmG7oq1tZwZsqJb/FVsD8iVs9TqNhDiJQ/Xl4hfzvUGE7YrJ+T+9wMngaG1FLQvWPR+cdGChZxqazWytlDNNclWnQu7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 17:50:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 17:50:10 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
CC: "Zaki, Ahmed" <ahmed.zaki@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
	<davem@davemloft.net>, "dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "gal@nvidia.com"
	<gal@nvidia.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, "justinstitt@google.com" <justinstitt@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "leon@kernel.org"
	<leon@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "saeed@kernel.org" <saeed@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Thread-Topic: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Thread-Index: AQHacf4WBtsLQqAxuESeM9XGdjpqArE0zQ4AgAGbY4CAAAQtgIAAAqmAgAAN34CAAQ7JQA==
Date: Thu, 14 Mar 2024 17:50:10 +0000
Message-ID: <CO1PR11MB50896031737DD807D071C34BD6292@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-2-rrameshbabu@nvidia.com>
	<20240312165346.14ec1941@kernel.org>	<87le6lbqsa.fsf@nvidia.com>
	<20240313174107.68ca4ff1@kernel.org>	<87h6h9bpm1.fsf@nvidia.com>
 <20240313184017.794a2044@kernel.org>
In-Reply-To: <20240313184017.794a2044@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH7PR11MB6980:EE_
x-ms-office365-filtering-correlation-id: 8b9f904f-2f72-44f4-84d8-08dc444f3164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DgwjX8r/uZQmVhEXQJiuElltiKVtdaooq8jlNKccOjD1xNSTE4oPJG3WhE+AggVqNEllN/YTNDZ8pFT5ekrmGbGlbqOJetglejrIJNJaRhsvSewi++J74J4kz8EvcNM5f04KMmMRBe/Tj78h6aRDUuhngyWWcBu7vG0eWJ5PQ/mnFUs6JRhvePiLAf4DH1VxOwcKEJJ7HFqjEXKHDvVvFwOHEFOLWRKx56blMV7uwAxvNKeUe51WUG3jH5VtblIjlS1mphoPfyd/KtLEPaDMWiD7fLJjmSF6gPXubrbxGWK6H+E7TkCWjtkWuCRXcisxhBFMThO20G25YuyqXxzw8RxpPVl0yPxFOJneDfzpvdIVfzGVqLXlVwyxNaBmSgcQ8E2U+8yTt6UHaDoEbCOA7nsJWtkWUhagHMuqpQ6CDU9RJ0bcmJJkwDLCK6cJANS3qW/35aS/ov08KGRua0/aOHrJ+F8ayXX9pYZPrPbc17xYoqRuTBQytEkAKPTSmnVECTaDsqtSAA3fOQvw6mdNJN5K+E7M9QLuH7wfganuJ/PFNKhD7Hx17FyZUhKga/kX7KLqMDelzikQUa8CQ857kwS+pyqHUsNLOS+hOqHESB3u/0dFOm8M47G7EF22+1etD9DfgVwqY0sg2m/IO8Ey7qA6NW8tTpPmtUGnUJeIwzVDi5H0kqDCHNqqq0jnouVURBxg8hsa3tCv4E/RHSr1ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HrF9+XAgVEkf0f+4OtcDTtASar+oIpn5Ysf6VICPG+cbEUMtHPsoJ3knI9S3?=
 =?us-ascii?Q?r2oajb2vpdo0m/wA7tvpq3YOs1B0Plu51nNAfLohZw1BIjel+8RsM/dVWmaz?=
 =?us-ascii?Q?pY2m6RBfnZQRqA6KP9EmQ5vretTyN2n8pV7JZIso7M60OeZkhPqVuqI4XD/o?=
 =?us-ascii?Q?funKsjNtvGmySdbDmZfrxaB0GW9ROMO+NDgXJMkYTcc9KyxELm3I01Jiw8pQ?=
 =?us-ascii?Q?sbu8kzcPe0CmPE0AN9oafgFAqaIvThcbAVLbZ9l6JzuRvqF/sGwwec/9/8Oz?=
 =?us-ascii?Q?5HAF/+oREH66GcCW/zlIRYsMGEVh8E9FzBVr0VAsFc5WyxjTUkkMeISA20yE?=
 =?us-ascii?Q?YuRtWlyp8ceyERI5Ma9oQKBBQBXJGToGnryj9BT+IlT+DsETB954uqgVT21e?=
 =?us-ascii?Q?R2+rfMnRVanoDH06+yEy40t/BybwKn2mfDOQQvPq5lKHJczOI+/vxuLyGwgd?=
 =?us-ascii?Q?KgcTyjcsTl7CBCYynp5cVz+SsAnTD2BafemnGlIzcB4YTh4BLq51wGYWi9Cs?=
 =?us-ascii?Q?0Bt8cWC6OF05CRc6A3gKRXC+Xq7EDPjNoV9fmT7PA75PdVv2oooMkqpYuQFx?=
 =?us-ascii?Q?YJ8vqWwLMFMM5a7zO5GwduWjU8m0xY+W+B+1wI169YMU4Iz2PzaBj9vhLw0i?=
 =?us-ascii?Q?uEG+ad15vzs2D288IEWyLiO3eWW03sNNxFb+yxxuZDqad+ldQfAhPfNv6t8e?=
 =?us-ascii?Q?I7phCh8G0TVsS6GuxkQc2wR3ltimWAQ1LIBjO+P0pfBkKDMEnlukZH0fh9V6?=
 =?us-ascii?Q?WTY6SE+pARm3TJu0t/+eFYDKPHBon9hjeSlpRELGE1qed6L8Rtm3iKzrxzTI?=
 =?us-ascii?Q?QsWFu5MTJZ3i7YzL80n++AdeeZlg6BfLD3sC7wwI7HySAwz4dkWRHtCQa+Bk?=
 =?us-ascii?Q?dSXA6esX24wij2NUkhsiS1aaSEEZSDkY8SYnuXIVy57kniLCoQ1xtbQoBEzR?=
 =?us-ascii?Q?npR665oRc0SQVxNIb/vYnarugD5BilxCeQyU0lHcS8+ythYG53Or8KfwP2T7?=
 =?us-ascii?Q?J0+Ny3v4yyeNXY9mVYsYywMi9GTza+3FQDp+oEnKeZ6dgTtBV4P0nZT+d50x?=
 =?us-ascii?Q?Xlpf9zkgh535Ork7DQGr2WmtcQm6QZJ5OhnSTat3ETITnUG3wtkJq9yyQTU+?=
 =?us-ascii?Q?ihlrt6iEIITwOSDiA7HK7Gplk8AAJWtMRM4U0lRsbnllNCmyKV37s2QdpxZZ?=
 =?us-ascii?Q?NZpEIk00XUqWKoCgs0W2DRrNdbFGKtSZkqwxfHJKmS7QqHO5N5hrF5I76MTZ?=
 =?us-ascii?Q?cZkCwaYu9i/6yag/7oFzKbptlLOSDDPpbpcjP8Di2mXAm6XVBlaV4qW5HOBK?=
 =?us-ascii?Q?6pjkUTFh9SJr7HrgsxwYNCa0W3Cr5k63hzRuDyRRk7E6QalvaG4vnL6fn4PU?=
 =?us-ascii?Q?2By7eV/k3KOasMyn79zGTNGMMsgJ4RMnV5G7P7JanUqZYL8m4mpnYGXmwOzo?=
 =?us-ascii?Q?ZJpnvCIariVyUBcHb9/2ahDjZxHhn/8K4YOozJj0bp+FqcbiJRlqyNhUzccQ?=
 =?us-ascii?Q?jULjRgFrEN7n9aLy9OWNjgG59ChkRTyupuxw1pDfc/UXIMa6vU/4adQUOIcA?=
 =?us-ascii?Q?6Fl6TMl6JptnbNedotfEWe5o0BQeLGZ/5SVWKWkl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9f904f-2f72-44f4-84d8-08dc444f3164
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 17:50:10.1211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08nB/pgxQEjiK18Qxvuag09rMGHwCFmpeEuGayLt8QQ/LcfPpUVYcDMHKgWBqZxq7IP2mm87Sk/tka6RmhSSKe14tznoQgJ8hXExwbuAQyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, March 13, 2024 6:40 PM
> To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Cc: Zaki, Ahmed <ahmed.zaki@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; alexandre.torgue@foss.st.com;
> andrew@lunn.ch; corbet@lwn.net; davem@davemloft.net; dtatulea@nvidia.com;
> edumazet@google.com; gal@nvidia.com; hkallweit1@gmail.com; Keller, Jacob =
E
> <jacob.e.keller@intel.com>; jiri@resnulli.us; joabreu@synopsys.com;
> justinstitt@google.com; kory.maincent@bootlin.com; leon@kernel.org; linux=
-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; liuhangbin@gmail.com;
> maxime.chevallier@bootlin.com; netdev@vger.kernel.org; pabeni@redhat.com;
> Greenwalt, Paul <paul.greenwalt@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; rdunlap@infradead.org;
> richardcochran@gmail.com; saeed@kernel.org; tariqt@nvidia.com;
> vadim.fedorenko@linux.dev; vladimir.oltean@nxp.com; Drewek, Wojciech
> <wojciech.drewek@intel.com>
> Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardwar=
e
> timestamping statistics
>=20
> On Wed, 13 Mar 2024 17:50:39 -0700 Rahul Rameshbabu wrote:
> > > Should we give some guidance to drivers which "ignore" time stamping
> > > requests if they used up all the "slots"? Even if just temporary unti=
l
> > > they are fixed? Maybe we can add after all the fields something like:
> > >
> > >   For drivers which ignore further timestamping requests when there a=
re
> > >   too many in flight, the ignored requests are currently not counted =
by
> > >   any of the statistics.
> >
> > I was actually thinking it would be better to merge them into the error
> > counter temporarily. Reason being is that in the case Intel notices tha=
t
> > their slots are full, they just drop traffic from my understanding
> > today. If the error counters increment in that situation, it helps with
> > the debug to a degree. EBUSY is an error in general.
>=20
> That works, too, let's recommend it (FWIW no preference whether
> in the entry for @err or somewhere separately in the kdoc).

We don't drop traffic, we send the packets just fine.. We just never report=
 a timestamp for them, since we don't program the hardware to capture that =
timestamp.

