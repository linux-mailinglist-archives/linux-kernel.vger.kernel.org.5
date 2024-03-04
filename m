Return-Path: <linux-kernel+bounces-90154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AC86FB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053961C20D77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F13168A8;
	Mon,  4 Mar 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LD8hC23x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189F53A6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538633; cv=fail; b=AmOqJ6SfM9/1+FpkY3Vyo+zImjbqGk5mSVJb0dBoYHcJcEq4qxfUbk2whXmyUp07AyQEAlM6HghSw2DhAkl3jSiff35Gc7MdUr82QYl++48ymuhyAaY1zvZXrwJLDVWc2e/Uyb5HeJYB19vrn6j4AGtFZJW9RhEexaq0HGItXfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538633; c=relaxed/simple;
	bh=KYwMFFMsOOvWfQF41bCPx0kWCi/o5YQMSbXa1c57pkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bRqGAGGXVlHnxUm9xKiPTyb8cYysWHOVB8MlJp83/stmeukOdMGGFRZ8sSAU1zXguDvIjpwF+0eHqjcYHmbEjnCtw0MCZUyjf+tyulxWhlcBkV55cgPqfnHZnR/XKrNMT4Sw9QPKd8RtNF9Cgm0la6IiMrczlCdFQ9q3qEurfRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LD8hC23x; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709538632; x=1741074632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KYwMFFMsOOvWfQF41bCPx0kWCi/o5YQMSbXa1c57pkw=;
  b=LD8hC23xx506paSVOWkxH/EFrIRP9x9/57+gXiZQfqJMfbysVRhDeHU3
   Ru0eb5tNddO65JOU8GpkZ3xxuhpoTuEubowFgb7gGwFRonQw5NOK001UL
   SioG5i3oTnbna9Wqm2RTU4RXkCT36gq2nP+jVDQPsBfRloyMrphKY1z0m
   0ZkdvXfSm2kEgWmptfw1hEkrOiegL+n5qELe45EajTCNt+2rlIW3VXaRe
   KvA/VUoBAWwV3abR8QnNW3eCGfKldnX71VrNyO3Ttym3iXTMUMWtplu/I
   bohKHYcZYn6MkHSa0W1abNHIf3T8kXKRBmGsx4Sl+mscHWG84WXVQJ5BK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3865730"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3865730"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:50:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9343865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 23:50:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 23:50:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 23:50:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 23:50:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D72C7MYkd6xCeF3cYKkT2xQP0uRnNdxQKRwjBBtEvX68s1ppqUDSIzHghiEUPENSBW58x9eJfjtbKOjoeCR2pLmfOswolMvf+4dOyjC+8Rz6V9aTU4UGyk6j1cNoPTH0M9QvDShLdDwV4ARMKxglqvbQYcvGPqnyM9/Y19/vExI0pEYxfK8tnxYE4aXvSHhxTG7OMox1EfF0+QMsO9Rf+Znq5Rqiq2wC/Nea1rSySs/sHUzQ2lkXspFUebDx+JNJWrmDhaDzD/zaUCUuifrEwMQBB8iC5FEw/dSgIAVftdrLAoaqm4sokjQWosTGPtElwScqVIVPIGmxLYkAarnIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYwMFFMsOOvWfQF41bCPx0kWCi/o5YQMSbXa1c57pkw=;
 b=NuAbi5vBTj17otpoUzSbKlIGOxEGpWv5QbKqA0oceiqVe3JxA0NApHFc8Pkujp9iicWn+ygt3fKTxJ1PoKQcGxbDPlC19HJdngtd6FupfAEjsveAAz2qtKj04dNloIlFNRB6WF9mUDxkzsOAKShqKPNHs8jNKMcAhhrOsdXQujAdM7RH8tt3AR9nPuCa9dtLrPMAMFZHU8XH57u5PNZJLIYNFBSp8jx8zqDQmtOqH7JTv/MBID6Cq/hBFDKwoMUahjyXCgr8Zqruz5oastgzrTRKjYI8rLTNEq5BctqpZnBib42oYzaI75iAwcTjOiaSrrPAL+I0fNc4YhvrUuSeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 07:50:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 07:50:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iommu/vt-d: Remove scalable mode context entry setup
 from attach_dev
Thread-Topic: [PATCH 2/3] iommu/vt-d: Remove scalable mode context entry setup
 from attach_dev
Thread-Index: AQHaavVEl9UHM76s8kKJlNKjOb7ZN7EnOzhA
Date: Mon, 4 Mar 2024 07:50:25 +0000
Message-ID: <BN9PR11MB527635862A973775734BA6978C232@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240229094804.121610-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: 8210fa9b-52cd-4bde-7e49-08dc3c1fc0eb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3mWzZ6mxxGyl+fs5RmYNASt7nFxkQtgCaflyUmCR6WIExUZSF4z0c6kti2G1XHloPoMsS8IeH29twBzZ0eljvSFKKc3PTIwva1Yp3RVv+GfTmPSg+8KgVHT9meyjM7c5pKQx/eZrN52/QmSIf5kIli2n/RkQIaQddtaxXjsA160OEwCU06o91pDJCS4yS9MWl9rhs3/nG8lGZvQdtSfvCnl0WZHh7yLwx9+eO5F8ke/UlNT+eB9fEzI8B5ttCf1XqLC+o94l3cG6uFYHjQDo5FpbYF/ZiiU2bGBLXODXTaHmoB/Wj61iB7gkFa/0UFCvqDQkkdhwwNA/Kor3dKWH1U8mmDeeaYmMTQnZDbBWtMVUptOnuh+KTcS7dkg87qineGnMRNhdmbztatEPnFOQgertkQmgF54fPlw4wIsXExippYi+XFdOJipZNvHQaxX39YULmCLQxqBRqbbgKPL/xurnoGq5d79eqcxKntpoySX92zVPxGOFsL6xbGxLgQFnYN4U5eu8lkgSzfIRqkBJPZQWhYO/kxljxvAROcV3bR7o7xwztl1qB0UdLy0/fXjCfdwb/2pUTOOOWMf0HvOGcGRp3mZ9DRg5JW/7KDgjE7lGFgC74sFktCHIQXrz8QbvhLtw5RTXBtoG6MXa354zwDdZF8V2vEyCehxohfheaoS58WlgehX5cT/tsmDmyt0UWMt9UkfUM+NSexDkwNG9byjzd4fhTbJ4ZUpaCnJ1i0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vYwT66PEnWdWLVT/n/sz7KBRup/JLE2lPu9CIWP+X+UTah7kupDmh4Yt1m/5?=
 =?us-ascii?Q?O9Uz/ZyGvOL410vh4e9J3gIJuCVmeJ9UdX8QJDQi1cT7OXYzUg22if4yqyUA?=
 =?us-ascii?Q?S5rGSncN8mT7qky9cHrCurnXjTtf30L6xsM+FdVryYblvZ1tScrgAuVPLz2l?=
 =?us-ascii?Q?C5JlWDWj8SWpIKXCy1JTeXvp5a1fr2hGL8ralQwsg6D9ZYKckB4JyuI3wiQy?=
 =?us-ascii?Q?3xZSpvPiVz2LReOhufn3lLvTrgOCL1KR4UhATOszM8Xj/L0Rk6gaxnofmXtx?=
 =?us-ascii?Q?BFH7FZ/i3uRq/0Eprf37aAIyeuN6UWhl1fJqybX04VftnPSBpTYbAjBmXv0t?=
 =?us-ascii?Q?3lyeOzJ0fsQ3zG3hdB1CurRI1tWp1FwIEeSFKiIoV/Q37zUAzLIrH6ysOQan?=
 =?us-ascii?Q?8OL6jB3uq4MCqa2995//4/P7qhrxmQHt43o/NK15dJKy00NQwesrSBcH0AmX?=
 =?us-ascii?Q?y+IBOt3Z7uzIWKWsA42R4wYrU5MHANf2L2khRBNTX6FX0/s6PDT0Jo7G0EX9?=
 =?us-ascii?Q?OZHeYe0h1uUw8zQGkDICFBu8X056nPRBdDyFmdkhYV3LHolm4uf+byRA6BL3?=
 =?us-ascii?Q?kLYmqxbU8vHzSIUzJU6oZ7q3TxpAesYZkymrgr9dxPSigHtia9/KLLjZghfI?=
 =?us-ascii?Q?PaFz3JTC0w5Ijc8GF+ITKxC/eM+ePKczFgmatpYnRrxLYqTSQtfi6hpoMdeF?=
 =?us-ascii?Q?qfks/40PDcQ4B9R7USknfptIRE9epPDZt58RhiMgMae41KLnXJqbvi8XE9NT?=
 =?us-ascii?Q?QTwatDU4Bc6EtYfgXcjQTeWVGR9BBdui8BfahahVWIRhgdERZNr9mOi4Wdfr?=
 =?us-ascii?Q?Up5xffBMzc2hzBgZaKqWjwhOXma218L5MX67hnElDzjCi86u9aoFZQV6dNom?=
 =?us-ascii?Q?ZwjirYiyu2JcMB34OX0HOHMcshSWFSXbNZfZ5ZBhMdxXt0NNpY7PoH8sV5yU?=
 =?us-ascii?Q?Vu/GM5ZBnw0zTaIgvTawY5oWK8iAy335EC2JYFvJtYxoJpuiJsOpAVHsFu7w?=
 =?us-ascii?Q?LTRWeWCN2he9Ueb18HmIzzhss8pGWgiVtBos/ppiQgOmSyOfrkl9RTevAmz1?=
 =?us-ascii?Q?5zhYgU0xnilA34t4PBGJqMe2IloHjQRgBRKAjOxDp4F2QKHzGjCahipTGkCK?=
 =?us-ascii?Q?/U6Z+bGs7oGKkblI3lthI0XPVv0s1e8ZOGkDN0xlW54vhB+HwkwFP8+0sXI+?=
 =?us-ascii?Q?L7S6Qdu9uvl7oGGXnu8jMp3v8PWNaf1t0GOgjgWbgvDaLU45z4KoNfZQICIM?=
 =?us-ascii?Q?ZjZfVCtHbcYLJB921G8+F6SAjBWULTA1KUDF8I4iN3lIqKVSvqp6Ltm3OYdf?=
 =?us-ascii?Q?QaFEoOZQWydk6bifXmoCBLU73u7qHt4BlZzdGXyQJFO7l67p+Iy51213EDVQ?=
 =?us-ascii?Q?IzmaEYHune8s6WR3qpJ8FlYeN6A+bAIylKmjSwHCSDQoQ1PNNqSOa6lMj/4a?=
 =?us-ascii?Q?klYUKq0ZkN2G2UVedtct1twYb8O7NkH2oI/b7AzqcjLXmBvo7kAAmgOlI2cM?=
 =?us-ascii?Q?kXGFul6pY5oTrk+ikp1u4GhoJNSjdcVGXrBuq5HoTHPXVL6rIfPRKHKUIEwn?=
 =?us-ascii?Q?EOStcwy5gTXwLF0QvzS1535186kWCaeFDVhQc2tT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8210fa9b-52cd-4bde-7e49-08dc3c1fc0eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:50:25.7855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kd+bujYJIpaP7ogEOFYLtm5lAu7DPFJAqDEj12rRUwtT8ARD552SEMePCxWk1XeiKsONWjix7ikWDDjXEli5nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, February 29, 2024 5:48 PM
>=20
> The scalable mode context entry is now setup in the probe_device path,
> eliminating the need to configure it in the attach_dev path. Removes the
> redundant code from the attach_dev path to avoid dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

