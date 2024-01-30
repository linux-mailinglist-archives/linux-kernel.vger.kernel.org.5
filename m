Return-Path: <linux-kernel+bounces-45473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1408C843134
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C271F2548A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97CB7F484;
	Tue, 30 Jan 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foONcu8W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B87D3FA;
	Tue, 30 Jan 2024 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657190; cv=fail; b=gyW+E76gUqk35fZAQHHyuAIDa0t+wzB8mvzkBEyfBnFauiKlVXCvvogJmI4ySP1H8SOS2sw/H1DZ9wvhGETvmllwrgxvmkF2NtCAH5+3/4g9jDCpaU6XelCiewElu30A7hOPEYYEnsJ7udc6Uus62+0NXPV4jVWucq0GJVSbZM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657190; c=relaxed/simple;
	bh=+0YDW5tWWwXoj9DcVpU5e2Ol5vbgpVqjqpIMsjr4g0g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rZQSzThbWELcFKxM8W40RL/ctiMdbTHP1AvexAdKdoP3/LC8OnpD4igBScDsIlWWVYy+th4gQB3TkbUzRPDikyrLSDGYOB15kttS1vLiV5sC3kqOTm03XpTngyX4HJAqzDPnQyDaK9eZQFSH7FhRHNTnujbHg2tphOWzvFHaiIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foONcu8W; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706657187; x=1738193187;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=+0YDW5tWWwXoj9DcVpU5e2Ol5vbgpVqjqpIMsjr4g0g=;
  b=foONcu8W6MHU4wxQucaI/BP4PpM0u+8YefuCYTjMdJr8iHoWxnFy8lpS
   GHzMBNInj5BlAuMiEAF/Fl4F/yivKUh5qzOpd/Ttg3irsFtDeV5o1O7rO
   Ix0u77BeMRtDrwwRRVf6PTE+7TYnIdKx/Pc3VI3HNyXzMhmdMPegvfPQz
   nlrYcdJcUk1yscANfUB8qlUbgFtufzGi94FQGArZGPmYU0sQpCSFOHaCK
   SWK5fXNZrtUgHNPsx6ZOXq6PT0SB+79gFImmTocAvctlSEr6nFT55XVXC
   UKpDyKu6YOIHR+7yWQTuo2r4H1jHuTjmlYli/ACSn0sZ9Ivxx5te/xQRL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16820206"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16820206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:26:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858622504"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="858622504"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 15:26:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 15:26:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 15:26:23 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 15:26:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdjB5hh5FcUqvwrb37VC0oC6Hu+XFtEx0/LCBCn5Sno+gmF4OOWlR723Pe32aes7In4HAw0VjV98hKe/YEM7vkTfONk1H2KIeiYoPUbZ8JYfipF7NQ3WtUSOPDBe09dxy0Nb0YGWSv7Mn4wZBi8Kw9kgMFpum1ZBtLrq05WNc76Kf47/MnJMd7AWUa8ytYZ7VZs7BligZiHJj6vtk9AaSWqQ7Xl5mc8VVnHgbE1sNGuwFQGR/ZUTezFUgvoGKqtDm3L/98D80qDtIhGg2KWZf67zR3036GzQ7VsGzAcfREpk2n1nB+/25iMlFTdzMNerBTdEQXVWwBe+0VCU6mO6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz2WgYhNo7ELWgSK8s0LJ+rWOb/YCzzJLRCMB4tHrUU=;
 b=S18HtFiqAXrFujn0lpzPw2MmZ87oNt3RY5LttLRGEGBGCJfCKxAV16xGUsm0EaF0pnYgQNNDZ318kRZKlwUyioqzQWX1ohj3lfX0tBcg0o8W+CRN7J2KLi2UGhanTE0X596O8KcxCwtN4QjBZHQZGIFdvkzi2R2+aVLAsnd+QcR1/zLEfYl9eEsX9vuHKYshgRhHbmq5j9Oa72oKT/KYxDc8c8Tm9vp38gYwdIJ1HCgZKe1Bd6lq7QAbEuMGwP3z0xt7HkfQVWepn1+6ZPkvUF7dHb6SbYnZOMPlaIsNoeFFI2dcwiEIqgjzTCvCoGkoUljNdWy6RUCqyDTw0BKKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 23:26:19 +0000
Received: from LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9]) by LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 23:26:19 +0000
From: "Corona, Ernesto" <ernesto.corona@intel.com>
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: "Corona, Ernesto" <ernesto.corona@intel.com>, "'oleksandrs@mellanox.com'"
	<oleksandrs@mellanox.com>, "'jiri@nvidia.com'" <jiri@nvidia.com>, "Castro,
 Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'"
	<omar.eduardo.castro@linux.intel.com>, "'pombredanne@nexb.com'"
	<pombredanne@nexb.com>, "'gregkh@linuxfoundation.org'"
	<gregkh@linuxfoundation.org>, "'arnd@arndb.de'" <arnd@arndb.de>,
	"'bbrezillon@kernel.org'" <bbrezillon@kernel.org>, "'rdunlap@infradead.org'"
	<rdunlap@infradead.org>, "'johan@kernel.org'" <johan@kernel.org>,
	"'axboe@kernel.dk'" <axboe@kernel.dk>, "'joel@jms.id.au'" <joel@jms.id.au>,
	"'palmer@sifive.com'" <palmer@sifive.com>, "'keescook@chromium.org'"
	<keescook@chromium.org>, "'vilhelm.gray@gmail.com'" <vilhelm.gray@gmail.com>,
	"'federico.vaga@cern.ch'" <federico.vaga@cern.ch>,
	"'Jonathan.Cameron@huawei.com'" <Jonathan.Cameron@huawei.com>, "Luck, Tony"
	<tony.luck@intel.com>, "'christian.gromm@microchip.com'"
	<christian.gromm@microchip.com>, "'linus.walleij@linaro.org'"
	<linus.walleij@linaro.org>, "'zzyiwei@google.com'" <zzyiwei@google.com>,
	"'rubini@gnudd.com'" <rubini@gnudd.com>, "'viresh.kumar@linaro.org'"
	<viresh.kumar@linaro.org>, "'mika.westerberg@linux.intel.com'"
	<mika.westerberg@linux.intel.com>, "Filary, Steven A"
	<steven.a.filary@intel.com>, "'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'amithash@fb.com'" <amithash@fb.com>, "'patrickw3@fb.com'"
	<patrickw3@fb.com>, "Chen, Luke" <luke_chen@aspeedtech.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	"'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: [PATCH 30 1/7] Add JTAG core driver
Thread-Topic: [PATCH 30 1/7] Add JTAG core driver
Thread-Index: AdpTwn19iWWLMIbtQG6Zmu4WwU9j2Q==
Date: Tue, 30 Jan 2024 23:26:19 +0000
Message-ID: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8463:EE_|DM6PR11MB4689:EE_
x-ms-office365-filtering-correlation-id: 469d0202-faac-4821-a05a-08dc21eadcea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdR7Ll7dkak77E7tZ71bSh3rSC0MNjRTcfyxxVPi50kb+LIXR5Sy9NNbgm0LM6JIguTQt9EDoYiQyEYgi1OnH7qlsSwUe//hf4AJclUVt9C299SDciG5+7xTL3b6cxl9v6JVIWVDMTmMZYHPEZdbhv7kQomLoyzNfOTQE9nFVfRCz3FT3Cq8QWVYc1jubAED2JtC1jisbTkOgGBaY/M3m3UawTV4m/BSfrTlPqmNMUaEuiNXAL8sJzxey4dBnAH77MjEWZrZq9U6GXnW1N++7NTIL25bDCjpdjhCkMJymjdwlcrhHVKUdRPcDEkTuFrVF9MRa/1soNJgWi4HbNBaTOYFHMq95oXDxV/SM6312VzAlsQ9RAWK7r1CZySgqTNfK6lAdMEmBj1NyVTfvKUiaF/miuAQSKWh/EPgfyTiDgHZbSEyUMzXLY5yJ8d8LjDCeEQx54pgeZ7dIrWrpYEJeaQ9Gtj0WG9SnhSbKdBYLTiGtakXjBHFSBz/ZjxqjJdIVsJ9E9YFUaSRfKD3rxcjatU5mVP5E80mtVNmAiF2R4jglSZ/K3Qo4OwKbzB4+g/i7TOVh42XnwyONynGN7CdDiIDgEuhzYGbnSQrxCbUTTopP4K2GHtr5I4rxI+DzfG3uc+K1lFf7ziQAQ+HEPmCB4LRcgSKHovPogxB02zhD+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(55016003)(83380400001)(110136005)(66446008)(86362001)(33656002)(82960400001)(41300700001)(38070700009)(316002)(26005)(30864003)(122000001)(38100700002)(9686003)(2906002)(6506007)(54906003)(64756008)(7696005)(478600001)(76116006)(71200400001)(66946007)(66556008)(5660300002)(66476007)(4326008)(8936002)(8676002)(52536014)(7416002)(7406005)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1iC8MlA1lD+kn4g/YXDFmbJXoqt9dGwt5MjSTqHta67PnQllupQLpAbLsds?=
 =?us-ascii?Q?LdFAdppJu9ia3v25lvKtskuoxMEc01szfecfoQsGcUFA4drEuJY14INVGq9N?=
 =?us-ascii?Q?SHSeB64rJkjJ3EGHovkNanBE4bfP4azdbC8Wcs8+4g5cfaGFCgWoahD62KUE?=
 =?us-ascii?Q?L+2GKYqz+zlcos8wXLkBX4wUF8aKZyBpQipEiriVy7jWztpeNwF4v9K+FsNX?=
 =?us-ascii?Q?eKjgVKst4FXIK4EwQFGLvZFcp5q4Kt8nzZ7oJ4S/n14/H73MXGsfz6ZuFUz8?=
 =?us-ascii?Q?RQGRMqtAbp2b4n9bwoIcz7nxFojHIPNzmyr1mL2jxDwzt6ok8dIQ2AecA1EF?=
 =?us-ascii?Q?aTB6/cEsXSNlmY4rjn14xkAd8YpA9vtCTvfhhTUJPC15UdVmBp6DZ1kOE0sh?=
 =?us-ascii?Q?h3lhv/6ja5xZZdO3LCiG2MLPfssp76UAskT2KQ0YmY+Pw8tJCSR3VLyRUdaT?=
 =?us-ascii?Q?WfcWiYBl8OoCJQ0dtX7s6h6oOb5hum4lCddPi+U6jeesTRO3rNSnNMOjnsZz?=
 =?us-ascii?Q?w3cMWfRCPsyfFUPHYDNIaaj/6VKwNYPRc6jiq8ezWTg+oOj9NyIvm3G+X2Im?=
 =?us-ascii?Q?xK4keY1PPbUwCZfT9jzXJgxvSkZypDceYOvW84EeBXbUMYHAxkMzXdO9USjK?=
 =?us-ascii?Q?2ocJaNnV7o5Vyl3Gd5p2dCBZsbXBkmP7uh4lpd35th4lxbXEiezCTmktxgj4?=
 =?us-ascii?Q?pRW7e/8pO3SD1yvk3ljrkwOk/Qc9WE2R6n+wKJSjmesoZbWGQZKz2uiyTa4D?=
 =?us-ascii?Q?UiVQ6xDrixpG9FVtReJ2eQ4mblxBZxhbrJ5S5xovPMsgn4ytWuAQGgyVDjKQ?=
 =?us-ascii?Q?jx+WWzaERuNWV8YAadCzsCGwVpe4RZgMKo32hkl2BK2yB3qbPAFat/sYJzFd?=
 =?us-ascii?Q?4C0x4BiGQTEnn547FF5J1Fe1jUFo5WHzz10SefWZ1sGVxkbos8d44o2k+FUy?=
 =?us-ascii?Q?oyFP8uOIS6xWFZzyzkN/fbuOwszckg73ktvBGki/EZ9wBCgRqdKZ4xSjv4PF?=
 =?us-ascii?Q?gu5dTKWdQZE/wNziD+j5W2u1ZfPVUC5vW049yN5G98yGNxM/L5F0r+HKej9p?=
 =?us-ascii?Q?nVkgQ/1yLGnpNygE+6T7/VHweNMgO56mH2akZfyestfC+UjR7lgwyBbVlQIP?=
 =?us-ascii?Q?hAfkvNXIsjMiYlO5vkLtN5N0GaJrA0+MTyT8cR50PZEGTW2AX4fYs/DzuuF4?=
 =?us-ascii?Q?Lelz5Uxh/wan1RkGp5/0wwjvJUXq6TDo7W7SlUkfMT4Ijv5dbgdiI6A7N6W1?=
 =?us-ascii?Q?bmuLg634KewfFy8vy80O42d4M9E3YGhCfReFa8VZ50pBM+paPKdWlpRKJg/U?=
 =?us-ascii?Q?YzSWDUOAMVkiQk9BYg6mebFLMMM+uvvGvTZblWGq1oAh++qDSdLqQX+A7Adu?=
 =?us-ascii?Q?41LZdFUeCz822PPe964U5cNlbqfpzMmmQ4vumSUXrw+6Owv9oARo7TdsxisP?=
 =?us-ascii?Q?Qbn7PcGvbVRg3sAwSnOtqiG+8TySjgRdhYcIg8jf83Z/rM61uFsDogxfa0Gr?=
 =?us-ascii?Q?SBEdYdVuR31pTgw9W3hB1ZUK9/BcshhtIoGojHlzdboySobUJwNMGGwicak+?=
 =?us-ascii?Q?74AZs1QKXk6Ul4Rgkjo01Fsy29NO78jSyMc47DNB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469d0202-faac-4821-a05a-08dc21eadcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 23:26:19.2044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGL5YDiqc0VyXfmMIJo1AWokjVdCxT3wyHugAYxUrt8zA4nS+X7AVBrujsUaevB/1H5PpxDPqOoWsGPb8mfLDxqISst5XWspxN9f9X517QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
X-OriginatorOrg: intel.com

JTAG class driver provide infrastructure to support hardware/software JTAG =
platform drivers. It provide user layer API interface for flashing and debu=
gging external devices which equipped with JTAG interface using standard tr=
ansactions.

Driver exposes set of IOCTL to user space for:
- XFER:
  SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
  SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
- GIOCSTATUS read the current TAPC state of the JTAG controller
- SIOCSTATE Forces the JTAG TAPC to go into a particular state.
- SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
- IOCBITBANG for low level control of JTAG signals.

Driver core provides set of internal APIs for allocation and
registration:
- jtag_register;
- jtag_unregister;
- jtag_alloc;
- jtag_free;

Platform driver on registration with jtag-core creates the next
entry in dev folder:
/dev/jtagX

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Federico Vaga <federico.vaga@cern.ch>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Yiwei Zhang <zzyiwei@google.com>
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>
---

v29->v30
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Add pre and post padding support for JTAG transfers.
- Add padding bit configuration definition.
- Use C99 flexible arrays.
- Add debug messages for JTAG core driver IOCTL operations.
- Add support for JTAG_SIOCTRST(Set TRST pin for JTAG).
- Update Ioctl number to 0xB9 due conflicts.

v28->v29
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Expand bitbang function to accept multiples bitbang operations within
  a single JTAG_IOCBITBANG call. It will receive a buffer with TDI and
  TMS values and it is expected that driver fills TDO fields with its
  corresponding output value for every transaction.
- Always setup JTAG controller to master mode but disable JTAG output
  when the driver is not in use to allow other HW to own the JTAG
  bus. Remove SCU register accesses. This register controls the JTAG
  controller mode (main/subordinate).
- Fix static analysis issues
- Add support for multichain. Set tap state and xfer operations now
  include two tap state arguments: current state and end state.

v27->v28
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Replace JTAG_IOCRUNTEST with JTAG_SIOCSTATE adding support for all
  TAPC end states in SW mode using a lookup table to navigate across
  states.
- Add support for simultaneous READ/WRITE transfers
  (JTAG_READ_WRITE_XFER).
- Support for switching JTAG controller mode between slave and master
  mode.
- Setup JTAG controller mode to master only when the driver is opened,
  letting
  other HW to own the JTAG bus when it isn't in use.
- Include JTAG bit bang IOCTL for low level JTAG control usage
  (JTAG_IOCBITBANG).

v24->v25
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- set values to enums in jtag.h

v23->v24
Notifications from kbuild test robot <lkp@intel.com>
- Add include types.h header to jtag.h
- remove unecessary jtag_release

v22->v23
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- remove restriction of allocated JTAG devs-
- add validation fo idle values
- remove unnecessary blank line
- change retcode for xfer
- remove unecessary jtag_release callback
- remove unecessary  defined fron jtag.h
- align in one line define JTAG_IOCRUNTEST

v21->v22
Comments pointed by Andy Shevchenko <andy.shevchenko@gmail.com>
- Fix 0x0f -> 0x0F in ioctl-number.txt
- Add description to #define MAX_JTAG_NAME_LEN
- Remove unnecessary entry *dev from struct jtag
- Remove redundant parens
- Described mandatory callbacks and removed unnecessary
- Set JTAG_MAX_XFER_DATA_LEN to power of 2
- rework driver alloc/register to devm_ variant
- increasing line length up to 84 in order to improve readability.

Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- fix spell in ABI doccumentation

v20->v21
    Comments pointed by Randy Dunlap <rdunlap@infradead.org>
    - Fix JTAG dirver help in Kconfig

v19->v20
Comments pointed by Randy Dunlap <rdunlap@infradead.org>
- Fix JTAG dirver help in Kconfig

Notifications from kbuild test robot <lkp@intel.com>
- fix incompatible type casts

v18->v19
Comments pointed by Julia Cartwright <juliac@eso.teric.us>
- Fix memory leak on jtag_alloc exit

v17->v18
Comments pointed by Julia Cartwright <juliac@eso.teric.us>
- Change to return -EOPNOTSUPP in case of error in JTAG_GIOCFREQ
- Add ops callbacks check to jtag_alloc
- Add err check for copy_to_user
- Move the kfree() above the if (err) in JTAG_IOCXFER
- remove unnecessary check for error after put_user
- add padding to struct jtag_xfer

v16->v17
Comments pointed by Julia Cartwright <juliac@eso.teric.us>
- Fix memory allocation on jtag alloc
- Move out unnecessary form lock on jtag open
- Rework jtag register behavior

v15->v16
Comments pointed by Florian Fainelli <f.fainelli@gmail.com>
- move check jtag->ops->* in ioctl before get_user()
- change error type -EINVAL --> -EBUSY on open already opened jtag
- remove unnecessary ARCH_DMA_MINALIGN flag from kzalloc
- remove define ARCH_DMA_MINALIGN

v14->v15
v13->v14
Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
- Change style of head block comment from /**/ to //

v12->v13
Comments pointed by Philippe Ombredanne <pombredanne@nexb.com>
- Change jtag.c licence type to
  SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  and reorder line with license in description

v11->v12
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- Change jtag.h licence type to
  SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  and reorder line with license in description

Comments pointed by Chip Bilbrey <chip@bilbrey.org>
- Remove Apeed reference from uapi jtag.h header
- Remove access mode from xfer and idle transactions
- Add new ioctl JTAG_SIOCMODE for set hw mode
- Add single open per device blocking

v10->v11
Notifications from kbuild test robot <lkp@intel.com>
- Add include types.h header to jtag.h
- fix incompatible type of xfer callback
- remove rdundant class defination
- Fix return order in case of xfer error

V9->v10
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- remove unnecessary alignment for pirv data
- move jtag_copy_to_user and jtag_copy_from_user code just to ioctl
- move int jtag_run_test_idle_op and jtag_xfer_op code
  just to ioctl
- change return error codes to more applicable
- add missing error checks
- fix error check order in ioctl
- remove unnecessary blank lines
- add param validation to ioctl
- remove compat_ioctl
- remove only one open per JTAG port blocking.
  User will care about this.
- Fix idr memory leak on jtag_exit
- change cdev device type to misc

V8->v9
Comments pointed by Arnd Bergmann <arnd@arndb.de>
- use get_user() instead of __get_user().
- change jtag->open type from int to atomic_t
- remove spinlock on jtg_open
- remove mutex on jtag_register
- add unregister_chrdev_region on jtag_init err
- add unregister_chrdev_region on jtag_exit
- remove unnecessary pointer casts
- add *data parameter to xfer function prototype

v7->v8
Comments pointed by Moritz Fischer <moritz.fischer@ettus.com>
- Fix misspelling s/friver/driver

v6->v7
Notifications from kbuild test robot <lkp@intel.com>
- Remove include asm/types.h from jtag.h
- Add include <linux/types.h> to jtag.c

v5->v6
v4->v5

v3->v4
Comments pointed by Arnd Bergmann <arnd@arndb.de>
- change transaction pointer tdio type  to __u64
- change internal status type from enum to __u32
- reorder jtag_xfer members to avoid the implied padding
- add __packed attribute to jtag_xfer and jtag_run_test_idle

v2->v3
Notifications from kbuild test robot <lkp@intel.com>
- Change include path to <linux/types.h> in jtag.h

v1->v2
Comments pointed by Greg KH <gregkh@linuxfoundation.org>
- Change license type from GPLv2/BSD to GPLv2
- Change type of variables which crossed user/kernel to __type
- Remove "default n" from Kconfig

Comments pointed by Andrew Lunn <andrew@lunn.ch>
- Change list_add_tail in jtag_unregister to list_del

Comments pointed by Neil Armstrong <narmstrong@baylibre.com>
- Add SPDX-License-Identifier instead of license text

Comments pointed by Arnd Bergmann <arnd@arndb.de>
- Change __copy_to_user to memdup_user
- Change __put_user to put_user
- Change type of variables to __type for compatible 32 and 64-bit
  systems
- Add check for maximum xfer data size
- Change lookup data mechanism to get jtag data from inode
- Add .compat_ioctl to file ops
- Add mem alignment for jtag priv data

Comments pointed by Tobias Klauser <tklauser@distanz.ch>
- Change function names to avoid match with variable types
- Fix description for jtag_ru_test_idle in uapi jtag.h
- Fix misprints IDEL/IDLE, trough/through
---
 drivers/Kconfig           |   2 +
 drivers/Makefile          |   1 +
 drivers/jtag/Kconfig      |  17 ++
 drivers/jtag/Makefile     |   1 +
 drivers/jtag/jtag.c       | 387 ++++++++++++++++++++++++++++++++++++++
 include/linux/jtag.h      |  49 +++++
 include/uapi/linux/jtag.h | 378 +++++++++++++++++++++++++++++++++++++
 7 files changed, 835 insertions(+)
 create mode 100644 drivers/jtag/Kconfig
 create mode 100644 drivers/jtag/Makefile
 create mode 100644 drivers/jtag/jtag.c
 create mode 100644 include/linux/jtag.h
 create mode 100644 include/uapi/linux/jtag.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc62..c13e0a575a69 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -245,4 +245,6 @@ source "drivers/cdx/Kconfig"
=20
 source "drivers/dpll/Kconfig"
=20
+source "drivers/jtag/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 37fd6ce3bd7f..cb0e4a719cef 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -198,3 +198,4 @@ obj-$(CONFIG_CDX_BUS)		+=3D cdx/
 obj-$(CONFIG_DPLL)		+=3D dpll/
=20
 obj-$(CONFIG_S390)		+=3D s390/
+obj-$(CONFIG_JTAG_ASPEED)	+=3D jtag/
diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
new file mode 100644
index 000000000000..47771fcd3c5b
--- /dev/null
+++ b/drivers/jtag/Kconfig
@@ -0,0 +1,17 @@
+menuconfig JTAG
+	tristate "JTAG support"
+	help
+	  This provides basic core functionality support for JTAG class devices.
+	  Hardware that is equipped with a JTAG microcontroller can be
+	  supported by using this driver's interfaces.
+	  This driver exposes a set of IOCTLs to the user space for
+	  the following commands:
+	    SDR: Performs an IEEE 1149.1 Data Register scan
+	    SIR: Performs an IEEE 1149.1 Instruction Register scan.
+	    RUNTEST: Forces the IEEE 1149.1 bus to a run state for a specified
+	    number of clocks or a specified time period.
+
+	  If you want this support, you should say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called jtag.
diff --git a/drivers/jtag/Makefile b/drivers/jtag/Makefile
new file mode 100644
index 000000000000..af374939a9e6
--- /dev/null
+++ b/drivers/jtag/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_JTAG)		+=3D jtag.o
diff --git a/drivers/jtag/jtag.c b/drivers/jtag/jtag.c
new file mode 100644
index 000000000000..070ca77ca8a6
--- /dev/null
+++ b/drivers/jtag/jtag.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2018 Mellanox Technologies. All rights reserved.
+// Copyright (c) 2018 Oleksandr Shamray <oleksandrs@mellanox.com>
+// Copyright (c) 2019 Intel Corporation
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/jtag.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <linux/spinlock.h>
+#include <uapi/linux/jtag.h>
+
+static char *end_status_str[] =3D { "tlr",   "idle",   "selDR", "capDR", "=
sDR",
+				  "ex1DR", "pDR",    "ex2DR", "updDR", "selIR",
+				  "capIR", "sIR",    "ex1IR", "pIR",   "ex2IR",
+				  "updIR", "current" };
+
+struct jtag {
+	struct miscdevice miscdev;
+	const struct jtag_ops *ops;
+	int id;
+	unsigned long *priv;
+};
+
+static DEFINE_IDA(jtag_ida);
+
+void *jtag_priv(struct jtag *jtag)
+{
+	return jtag->priv;
+}
+EXPORT_SYMBOL_GPL(jtag_priv);
+
+static long jtag_ioctl(struct file *file, unsigned int cmd, unsigned long =
arg)
+{
+	struct jtag *jtag =3D file->private_data;
+	struct jtag_tap_state tapstate;
+	struct jtag_xfer xfer;
+	struct bitbang_packet bitbang;
+	struct tck_bitbang *bitbang_data;
+	struct jtag_mode mode;
+	u8 *xfer_data;
+	u32 data_size;
+	u32 value;
+	u32 active;
+	int err;
+
+	if (!arg)
+		return -EINVAL;
+
+	switch (cmd) {
+	case JTAG_GIOCFREQ:
+		if (!jtag->ops->freq_get)
+			return -EOPNOTSUPP;
+
+		err =3D jtag->ops->freq_get(jtag, &value);
+		if (err)
+			break;
+		dev_dbg(jtag->miscdev.parent, "JTAG_GIOCFREQ: freq get =3D %d",
+			value);
+
+		if (put_user(value, (__u32 __user *)arg))
+			err =3D -EFAULT;
+		break;
+
+	case JTAG_SIOCFREQ:
+		if (!jtag->ops->freq_set)
+			return -EOPNOTSUPP;
+
+		if (get_user(value, (__u32 __user *)arg))
+			return -EFAULT;
+		if (value =3D=3D 0)
+			return -EINVAL;
+
+		err =3D jtag->ops->freq_set(jtag, value);
+		dev_dbg(jtag->miscdev.parent, "JTAG_SIOCFREQ: freq set =3D %d",
+			value);
+		break;
+
+	case JTAG_SIOCSTATE:
+		if (copy_from_user(&tapstate, (const void __user *)arg,
+				   sizeof(struct jtag_tap_state)))
+			return -EFAULT;
+
+		if (tapstate.from > JTAG_STATE_CURRENT)
+			return -EINVAL;
+
+		if (tapstate.endstate > JTAG_STATE_CURRENT)
+			return -EINVAL;
+
+		if (tapstate.reset > JTAG_FORCE_RESET)
+			return -EINVAL;
+
+		dev_dbg(jtag->miscdev.parent,
+			"JTAG_SIOCSTATE: status set from %s to %s reset %d tck %d",
+			end_status_str[tapstate.from],
+			end_status_str[tapstate.endstate], tapstate.reset,
+			tapstate.tck);
+
+		err =3D jtag->ops->status_set(jtag, &tapstate);
+		break;
+
+	case JTAG_IOCXFER:
+	{
+		u8 ubit_mask =3D GENMASK(7, 0);
+		u8 remaining_bits =3D 0x0;
+		union pad_config padding;
+
+		if (copy_from_user(&xfer, (const void __user *)arg,
+				   sizeof(struct jtag_xfer)))
+			return -EFAULT;
+
+		if (xfer.length >=3D JTAG_MAX_XFER_DATA_LEN)
+			return -EINVAL;
+
+		if (xfer.type > JTAG_SDR_XFER)
+			return -EINVAL;
+
+		if (xfer.direction > JTAG_READ_WRITE_XFER)
+			return -EINVAL;
+
+		if (xfer.from > JTAG_STATE_CURRENT)
+			return -EINVAL;
+
+		if (xfer.endstate > JTAG_STATE_CURRENT)
+			return -EINVAL;
+
+		data_size =3D DIV_ROUND_UP(xfer.length, BITS_PER_BYTE);
+		xfer_data =3D memdup_user(u64_to_user_ptr(xfer.tdio), data_size);
+
+		/* Save unused remaining bits in this transfer */
+		if ((xfer.length % BITS_PER_BYTE)) {
+			ubit_mask =3D GENMASK((xfer.length % BITS_PER_BYTE) - 1,
+					    0);
+			remaining_bits =3D xfer_data[data_size - 1] & ~ubit_mask;
+		}
+
+		if (IS_ERR(xfer_data))
+			return -EFAULT;
+		padding.int_value =3D xfer.padding;
+		dev_dbg(jtag->miscdev.parent,
+			"JTAG_IOCXFER: type: %s direction: %d, END : %s, padding: (value: %d) p=
re_pad: %d post_pad: %d, len: %d\n",
+			xfer.type ? "DR" : "IR", xfer.direction,
+			end_status_str[xfer.endstate], padding.pad_data,
+			padding.pre_pad_number, padding.post_pad_number,
+			xfer.length);
+
+		print_hex_dump_debug("I:", DUMP_PREFIX_NONE, 16, 1, xfer_data,
+				     data_size, false);
+
+		err =3D jtag->ops->xfer(jtag, &xfer, xfer_data);
+		if (err) {
+			kfree(xfer_data);
+			return err;
+		}
+
+		print_hex_dump_debug("O:", DUMP_PREFIX_NONE, 16, 1, xfer_data,
+				     data_size, false);
+
+		/* Restore unused remaining bits in this transfer */
+		xfer_data[data_size - 1] =3D (xfer_data[data_size - 1]
+					    & ubit_mask) | remaining_bits;
+
+		err =3D copy_to_user(u64_to_user_ptr(xfer.tdio),
+				   (void *)xfer_data, data_size);
+		kfree(xfer_data);
+		if (err)
+			return -EFAULT;
+
+		if (copy_to_user((void __user *)arg, (void *)&xfer,
+				 sizeof(struct jtag_xfer)))
+			return -EFAULT;
+		break;
+	}
+
+	case JTAG_GIOCSTATUS:
+		err =3D jtag->ops->status_get(jtag, &value);
+		if (err)
+			break;
+		dev_dbg(jtag->miscdev.parent, "JTAG_GIOCSTATUS: status get %s",
+			end_status_str[value]);
+
+		err =3D put_user(value, (__u32 __user *)arg);
+		break;
+	case JTAG_IOCBITBANG:
+		if (copy_from_user(&bitbang, (const void __user *)arg,
+				   sizeof(struct bitbang_packet)))
+			return -EFAULT;
+
+		if (bitbang.length >=3D JTAG_MAX_XFER_DATA_LEN)
+			return -EINVAL;
+
+		data_size =3D bitbang.length * sizeof(struct tck_bitbang);
+		bitbang_data =3D memdup_user((void __user *)bitbang.data,
+					   data_size);
+		if (IS_ERR(bitbang_data))
+			return -EFAULT;
+
+		err =3D jtag->ops->bitbang(jtag, &bitbang, bitbang_data);
+		if (err) {
+			kfree(bitbang_data);
+			return err;
+		}
+		err =3D copy_to_user((void __user *)bitbang.data,
+				   (void *)bitbang_data, data_size);
+		kfree(bitbang_data);
+		if (err)
+			return -EFAULT;
+		break;
+	case JTAG_SIOCMODE:
+		if (!jtag->ops->mode_set)
+			return -EOPNOTSUPP;
+
+		if (copy_from_user(&mode, (const void __user *)arg,
+				   sizeof(struct jtag_mode)))
+			return -EFAULT;
+
+		dev_dbg(jtag->miscdev.parent,
+			"JTAG_SIOCMODE: mode set feature %d mode %d",
+			mode.feature, mode.mode);
+		err =3D jtag->ops->mode_set(jtag, &mode);
+		break;
+	case JTAG_SIOCTRST:
+		if (!jtag->ops->trst_set)
+			return -EOPNOTSUPP;
+
+		if (get_user(active, (__u32 __user *)arg))
+			return -EFAULT;
+
+		dev_dbg(jtag->miscdev.parent,
+			"JTAG_SIOCTRST: active %d", active);
+
+		err =3D jtag->ops->trst_set(jtag, active);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return err;
+}
+
+static int jtag_open(struct inode *inode, struct file *file)
+{
+	struct jtag *jtag =3D container_of(file->private_data,
+					 struct jtag,
+					 miscdev);
+
+	file->private_data =3D jtag;
+	if (jtag->ops->enable(jtag))
+		return -EBUSY;
+	return nonseekable_open(inode, file);
+}
+
+static int jtag_release(struct inode *inode, struct file *file)
+{
+	struct jtag *jtag =3D file->private_data;
+
+	if (jtag->ops->disable(jtag))
+		return -EBUSY;
+	return 0;
+}
+
+static const struct file_operations jtag_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D jtag_open,
+	.llseek		=3D noop_llseek,
+	.unlocked_ioctl	=3D jtag_ioctl,
+	.release	=3D jtag_release,
+};
+
+struct jtag *jtag_alloc(struct device *host, size_t priv_size,
+			const struct jtag_ops *ops)
+{
+	struct jtag *jtag;
+
+	if (!host)
+		return NULL;
+
+	if (!ops)
+		return NULL;
+
+	if (!ops->status_set || !ops->status_get || !ops->xfer)
+		return NULL;
+
+	jtag =3D kzalloc(sizeof(*jtag), GFP_KERNEL);
+	if (!jtag)
+		return NULL;
+	jtag->priv =3D kzalloc(priv_size, GFP_KERNEL);
+	if (!jtag->priv)
+		return NULL;
+
+	jtag->ops =3D ops;
+	jtag->miscdev.parent =3D host;
+
+	return jtag;
+}
+EXPORT_SYMBOL_GPL(jtag_alloc);
+
+void jtag_free(struct jtag *jtag)
+{
+	kfree(jtag);
+}
+EXPORT_SYMBOL_GPL(jtag_free);
+
+static int jtag_register(struct jtag *jtag)
+{
+	struct device *dev =3D jtag->miscdev.parent;
+	int err;
+	int id;
+
+	if (!dev)
+		return -ENODEV;
+
+	id =3D ida_simple_get(&jtag_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	jtag->id =3D id;
+
+	jtag->miscdev.fops =3D  &jtag_fops;
+	jtag->miscdev.minor =3D MISC_DYNAMIC_MINOR;
+	jtag->miscdev.name =3D kasprintf(GFP_KERNEL, "jtag%d", id);
+	if (!jtag->miscdev.name) {
+		err =3D -ENOMEM;
+		goto err_jtag_alloc;
+	}
+
+	err =3D misc_register(&jtag->miscdev);
+	if (err) {
+		dev_err(jtag->miscdev.parent, "Unable to register device\n");
+		goto err_jtag_name;
+	}
+	return 0;
+
+err_jtag_name:
+	kfree(jtag->miscdev.name);
+err_jtag_alloc:
+	ida_simple_remove(&jtag_ida, id);
+	return err;
+}
+
+static void jtag_unregister(struct jtag *jtag)
+{
+	misc_deregister(&jtag->miscdev);
+	kfree(jtag->miscdev.name);
+	ida_simple_remove(&jtag_ida, jtag->id);
+}
+
+static void devm_jtag_unregister(struct device *dev, void *res)
+{
+	jtag_unregister(*(struct jtag **)res);
+}
+
+int devm_jtag_register(struct device *dev, struct jtag *jtag)
+{
+	struct jtag **ptr;
+	int ret;
+
+	ptr =3D devres_alloc(devm_jtag_unregister, sizeof(struct jtag *),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret =3D jtag_register(jtag);
+	if (!ret) {
+		*ptr =3D jtag;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_jtag_register);
+
+static void __exit jtag_exit(void)
+{
+	ida_destroy(&jtag_ida);
+}
+
+module_exit(jtag_exit);
+
+MODULE_AUTHOR("Oleksandr Shamray <oleksandrs@mellanox.com>");
+MODULE_DESCRIPTION("Generic jtag support");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/jtag.h b/include/linux/jtag.h
new file mode 100644
index 000000000000..87396ee21df9
--- /dev/null
+++ b/include/linux/jtag.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018 Mellanox Technologies. All rights reserved. */
+/* Copyright (c) 2018 Oleksandr Shamray <oleksandrs@mellanox.com> */
+/* Copyright (c) 2019 Intel Corporation */
+
+#ifndef __LINUX_JTAG_H
+#define __LINUX_JTAG_H
+
+#include <linux/types.h>
+#include <uapi/linux/jtag.h>
+
+#define JTAG_MAX_XFER_DATA_LEN (0xFFFFFFFF)
+
+struct jtag;
+/**
+ * struct jtag_ops - callbacks for JTAG control functions:
+ *
+ * @freq_get: get frequency function. Filled by dev driver
+ * @freq_set: set frequency function. Filled by dev driver
+ * @status_get: get JTAG TAPC state function. Mandatory, Filled by dev dri=
ver
+ * @status_set: set JTAG TAPC state function. Mandatory, Filled by dev dri=
ver
+ * @xfer: send JTAG xfer function. Mandatory func. Filled by dev driver
+ * @mode_set: set specific work mode for JTAG. Filled by dev driver
+ * @trst_set: set TRST pin active(pull low) for JTAG. Filled by dev driver
+ * @bitbang: set low level bitbang operations. Filled by dev driver
+ * @enable: enables JTAG interface in controller mode. Filled by dev drive=
r
+ * @disable: disables JTAG interface controller mode. Filled by dev driver
+ */
+struct jtag_ops {
+	int (*freq_get)(struct jtag *jtag, u32 *freq);
+	int (*freq_set)(struct jtag *jtag, u32 freq);
+	int (*status_get)(struct jtag *jtag, u32 *state);
+	int (*status_set)(struct jtag *jtag, struct jtag_tap_state *endst);
+	int (*xfer)(struct jtag *jtag, struct jtag_xfer *xfer, u8 *xfer_data);
+	int (*mode_set)(struct jtag *jtag, struct jtag_mode *jtag_mode);
+	int (*trst_set)(struct jtag *jtag, u32 active);
+	int (*bitbang)(struct jtag *jtag, struct bitbang_packet *bitbang,
+		       struct tck_bitbang *bitbang_data);
+	int (*enable)(struct jtag *jtag);
+	int (*disable)(struct jtag *jtag);
+};
+
+void *jtag_priv(struct jtag *jtag);
+int devm_jtag_register(struct device *dev, struct jtag *jtag);
+struct jtag *jtag_alloc(struct device *host, size_t priv_size,
+			const struct jtag_ops *ops);
+void jtag_free(struct jtag *jtag);
+
+#endif /* __LINUX_JTAG_H */
diff --git a/include/uapi/linux/jtag.h b/include/uapi/linux/jtag.h
new file mode 100644
index 000000000000..3dd0c51284f1
--- /dev/null
+++ b/include/uapi/linux/jtag.h
@@ -0,0 +1,378 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018 Mellanox Technologies. All rights reserved. */
+/* Copyright (c) 2018 Oleksandr Shamray <oleksandrs@mellanox.com> */
+/* Copyright (c) 2019 Intel Corporation */
+
+#ifndef __UAPI_LINUX_JTAG_H
+#define __UAPI_LINUX_JTAG_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * JTAG_XFER_MODE: JTAG transfer mode. Used to set JTAG controller transfe=
r mode
+ * This is bitmask for feature param in jtag_mode for ioctl JTAG_SIOCMODE
+ */
+#define  JTAG_XFER_MODE 0
+/*
+ * JTAG_CONTROL_MODE: JTAG controller mode. Used to set JTAG controller mo=
de
+ * This is bitmask for feature param in jtag_mode for ioctl JTAG_SIOCMODE
+ */
+#define  JTAG_CONTROL_MODE 1
+/*
+ * JTAG_TCK_CYCLE_DELAY_COUNT: JTAG delay counter for aspeed_jtag_tck_cycl=
e. Used
+ * set the number of jtag_tck_cycle delays repetitions.
+ * This is bitmask for feature param in jtag_mode for ioctl JTAG_SIOCMODE
+ */
+#define  JTAG_TCK_CYCLE_DELAY_COUNT 2
+/*
+ * JTAG_CONTROLLER_OUTPUT_DISABLE: JTAG controller mode output disable, it=
 is
+ * used to enable other devices to own the JTAG bus.
+ * This is bitmask for mode param in jtag_mode for ioctl JTAG_SIOCMODE
+ */
+#define  JTAG_CONTROLLER_OUTPUT_DISABLE 0
+/*
+ * JTAG_CONTROLLER_MODE: JTAG controller mode. Used to set JTAG controller=
 in
+ * host mode.
+ * This is bitmask for mode param in jtag_mode for ioctl JTAG_SIOCMODE
+ */
+#define  JTAG_CONTROLLER_MODE 1
+/*
+ * JTAG_XFER_HW_MODE: JTAG hardware mode. Used to set HW drived or bitbang
+ * mode. This is bitmask for mode param in jtag_mode for ioctl JTAG_SIOCMO=
DE
+ */
+#define  JTAG_XFER_HW_MODE 1
+/*
+ * JTAG_XFER_SW_MODE: JTAG software mode. Used to set SW drived or bitbang
+ * mode. This is bitmask for mode param in jtag_mode for ioctl JTAG_SIOCMO=
DE
+ */
+#define  JTAG_XFER_SW_MODE 0
+
+/**
+ * enum jtag_tapstate:
+ *
+ * @JTAG_STATE_TLRESET: JTAG state machine Test Logic Reset state
+ * @JTAG_STATE_IDLE: JTAG state machine IDLE state
+ * @JTAG_STATE_SELECTDR: JTAG state machine SELECT_DR state
+ * @JTAG_STATE_CAPTUREDR: JTAG state machine CAPTURE_DR state
+ * @JTAG_STATE_SHIFTDR: JTAG state machine SHIFT_DR state
+ * @JTAG_STATE_EXIT1DR: JTAG state machine EXIT-1 DR state
+ * @JTAG_STATE_PAUSEDR: JTAG state machine PAUSE_DR state
+ * @JTAG_STATE_EXIT2DR: JTAG state machine EXIT-2 DR state
+ * @JTAG_STATE_UPDATEDR: JTAG state machine UPDATE DR state
+ * @JTAG_STATE_SELECTIR: JTAG state machine SELECT_IR state
+ * @JTAG_STATE_CAPTUREIR: JTAG state machine CAPTURE_IR state
+ * @JTAG_STATE_SHIFTIR: JTAG state machine SHIFT_IR state
+ * @JTAG_STATE_EXIT1IR: JTAG state machine EXIT-1 IR state
+ * @JTAG_STATE_PAUSEIR: JTAG state machine PAUSE_IR state
+ * @JTAG_STATE_EXIT2IR: JTAG state machine EXIT-2 IR state
+ * @JTAG_STATE_UPDATEIR: JTAG state machine UPDATE IR state
+ * @JTAG_STATE_CURRENT: JTAG current state, saved by driver
+ */
+enum jtag_tapstate {
+	JTAG_STATE_TLRESET,
+	JTAG_STATE_IDLE,
+	JTAG_STATE_SELECTDR,
+	JTAG_STATE_CAPTUREDR,
+	JTAG_STATE_SHIFTDR,
+	JTAG_STATE_EXIT1DR,
+	JTAG_STATE_PAUSEDR,
+	JTAG_STATE_EXIT2DR,
+	JTAG_STATE_UPDATEDR,
+	JTAG_STATE_SELECTIR,
+	JTAG_STATE_CAPTUREIR,
+	JTAG_STATE_SHIFTIR,
+	JTAG_STATE_EXIT1IR,
+	JTAG_STATE_PAUSEIR,
+	JTAG_STATE_EXIT2IR,
+	JTAG_STATE_UPDATEIR,
+	JTAG_STATE_CURRENT
+};
+
+/**
+ * enum jtag_reset:
+ *
+ * @JTAG_NO_RESET: JTAG run TAP from current state
+ * @JTAG_FORCE_RESET: JTAG force TAP to reset state
+ */
+enum jtag_reset {
+	JTAG_NO_RESET =3D 0,
+	JTAG_FORCE_RESET =3D 1,
+};
+
+/**
+ * enum jtag_xfer_type:
+ *
+ * @JTAG_SIR_XFER: SIR transfer
+ * @JTAG_SDR_XFER: SDR transfer
+ */
+enum jtag_xfer_type {
+	JTAG_SIR_XFER =3D 0,
+	JTAG_SDR_XFER =3D 1,
+};
+
+/**
+ * enum jtag_xfer_direction:
+ *
+ * @JTAG_READ_XFER: read transfer
+ * @JTAG_WRITE_XFER: write transfer
+ * @JTAG_READ_WRITE_XFER: read & write transfer
+ */
+enum jtag_xfer_direction {
+	JTAG_READ_XFER =3D 1,
+	JTAG_WRITE_XFER =3D 2,
+	JTAG_READ_WRITE_XFER =3D 3,
+};
+
+/**
+ * struct jtag_tap_state - forces JTAG state machine to go into a TAPC
+ * state
+ *
+ * @reset: 0 - run IDLE/PAUSE from current state
+ *         1 - go through TEST_LOGIC/RESET state before  IDLE/PAUSE
+ * @from: initital jtag state
+ * @endstate: jtag end state
+ * @tck: clock counter
+ *
+ * Structure provide interface to JTAG device for JTAG set state execution=
.
+ */
+struct jtag_tap_state {
+	__u8	reset;
+	__u8	from;
+	__u8	endstate;
+	__u32	tck;
+};
+
+/**
+ * union pad_config - Padding Configuration:
+ *
+ * @type: transfer type
+ * @pre_pad_number: Number of prepadding bits bit[11:0]
+ * @post_pad_number: Number of prepadding bits bit[23:12]
+ * @pad_data : Bit value to be used by pre and post padding bit[24]
+ * @int_value: unsigned int packed padding configuration value bit[32:0]
+ *
+ * Structure provide pre and post padding configuration in a single __u32
+ */
+union pad_config {
+	struct {
+		__u32 pre_pad_number	: 12;
+		__u32 post_pad_number	: 12;
+		__u32 pad_data		: 1;
+		__u32 rsvd		: 7;
+	};
+	__u32 int_value;
+};
+
+/**
+ * struct jtag_xfer - jtag xfer:
+ *
+ * @type: transfer type
+ * @direction: xfer direction
+ * @from: xfer current state
+ * @endstate: xfer end state
+ * @padding: xfer padding
+ * @length: xfer bits length
+ * @tdio : xfer data array
+ *
+ * Structure provide interface to JTAG device for JTAG SDR/SIR xfer execut=
ion.
+ */
+struct jtag_xfer {
+	__u8	type;
+	__u8	direction;
+	__u8	from;
+	__u8	endstate;
+	__u32	padding;
+	__u32	length;
+	__u64	tdio;
+};
+
+/**
+ * struct bitbang_packet - jtag bitbang array packet:
+ *
+ * @data:   JTAG Bitbang struct array pointer(input/output)
+ * @length: array size (input)
+ *
+ * Structure provide interface to JTAG device for JTAG bitbang bundle exec=
ution
+ */
+struct bitbang_packet {
+	struct tck_bitbang *data;
+	__u32	length;
+} __attribute__((__packed__));
+
+/**
+ * struct jtag_bitbang - jtag bitbang:
+ *
+ * @tms: JTAG TMS
+ * @tdi: JTAG TDI (input)
+ * @tdo: JTAG TDO (output)
+ *
+ * Structure provide interface to JTAG device for JTAG bitbang execution.
+ */
+struct tck_bitbang {
+	__u8	tms;
+	__u8	tdi;
+	__u8	tdo;
+} __attribute__((__packed__));
+
+/**
+ * struct jtag_mode - jtag mode:
+ *
+ * @feature: 0 - JTAG feature setting selector for JTAG controller HW/SW
+ *           1 - JTAG feature setting selector for controller bus mode
+ *               output (enable / disable).
+ * @mode:    (0 - SW / 1 - HW) for JTAG_XFER_MODE feature(0)
+ *           (0 - output disable / 1 - output enable) for JTAG_CONTROL_MOD=
E
+ *                                                    feature(1)
+ *
+ * Structure provide configuration modes to JTAG device.
+ */
+struct jtag_mode {
+	__u32	feature;
+	__u32	mode;
+};
+
+/* ioctl interface */
+#define __JTAG_IOCTL_MAGIC	0xb9
+
+#define JTAG_SIOCSTATE	_IOW(__JTAG_IOCTL_MAGIC, 0, struct jtag_tap_state)
+#define JTAG_SIOCFREQ	_IOW(__JTAG_IOCTL_MAGIC, 1, unsigned int)
+#define JTAG_GIOCFREQ	_IOR(__JTAG_IOCTL_MAGIC, 2, unsigned int)
+#define JTAG_IOCXFER	_IOWR(__JTAG_IOCTL_MAGIC, 3, struct jtag_xfer)
+#define JTAG_GIOCSTATUS _IOWR(__JTAG_IOCTL_MAGIC, 4, enum jtag_tapstate)
+#define JTAG_SIOCMODE	_IOW(__JTAG_IOCTL_MAGIC, 5, unsigned int)
+#define JTAG_IOCBITBANG	_IOW(__JTAG_IOCTL_MAGIC, 6, unsigned int)
+#define JTAG_SIOCTRST	_IOW(__JTAG_IOCTL_MAGIC, 7, unsigned int)
+
+/**
+ * struct tms_cycle - This structure represents a tms cycle state.
+ *
+ * @tmsbits: is the bitwise representation of the needed tms transitions t=
o
+ *           move from one state to another.
+ * @count:   number of jumps needed to move to the needed state.
+ *
+ */
+struct tms_cycle {
+	unsigned char tmsbits;
+	unsigned char count;
+};
+
+/*
+ * This is the complete set TMS cycles for going from any TAP state to any
+ * other TAP state, following a "shortest path" rule.
+ */
+static const struct tms_cycle _tms_cycle_lookup[][16] =3D {
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* TLR  */{{0x00, 0}, {0x00, 1}, {0x02, 2}, {0x02, 3}, {0x02, 4}, {0x0a, 4=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x0a, 5}, {0x2a, 6}, {0x1a, 5}, {0x06, 3}, {0x06, 4}, {0x06, 5},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x16, 5}, {0x16, 6}, {0x56, 7}, {0x36, 6} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* RTI  */{{0x07, 3}, {0x00, 0}, {0x01, 1}, {0x01, 2}, {0x01, 3}, {0x05, 3=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x05, 4}, {0x15, 5}, {0x0d, 4}, {0x03, 2}, {0x03, 3}, {0x03, 4},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x0b, 4}, {0x0b, 5}, {0x2b, 6}, {0x1b, 5} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* SelDR*/{{0x03, 2}, {0x03, 3}, {0x00, 0}, {0x00, 1}, {0x00, 2}, {0x02, 2=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x02, 3}, {0x0a, 4}, {0x06, 3}, {0x01, 1}, {0x01, 2}, {0x01, 3},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x05, 3}, {0x05, 4}, {0x15, 5}, {0x0d, 4} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* CapDR*/{{0x1f, 5}, {0x03, 3}, {0x07, 3}, {0x00, 0}, {0x00, 1}, {0x01, 1=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x01, 2}, {0x05, 3}, {0x03, 2}, {0x0f, 4}, {0x0f, 5}, {0x0f, 6},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x2f, 6}, {0x2f, 7}, {0xaf, 8}, {0x6f, 7} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* SDR  */{{0x1f, 5}, {0x03, 3}, {0x07, 3}, {0x07, 4}, {0x00, 0}, {0x01, 1=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x01, 2}, {0x05, 3}, {0x03, 2}, {0x0f, 4}, {0x0f, 5}, {0x0f, 6},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x2f, 6}, {0x2f, 7}, {0xaf, 8}, {0x6f, 7} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* Ex1DR*/{{0x0f, 4}, {0x01, 2}, {0x03, 2}, {0x03, 3}, {0x02, 3}, {0x00, 0=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x00, 1}, {0x02, 2}, {0x01, 1}, {0x07, 3}, {0x07, 4}, {0x07, 5},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x17, 5}, {0x17, 6}, {0x57, 7}, {0x37, 6} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* PDR  */{{0x1f, 5}, {0x03, 3}, {0x07, 3}, {0x07, 4}, {0x01, 2}, {0x05, 3=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x00, 0}, {0x01, 1}, {0x03, 2}, {0x0f, 4}, {0x0f, 5}, {0x0f, 6},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x2f, 6}, {0x2f, 7}, {0xaf, 8}, {0x6f, 7} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* Ex2DR*/{{0x0f, 4}, {0x01, 2}, {0x03, 2}, {0x03, 3}, {0x00, 1}, {0x02, 2=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x02, 3}, {0x00, 0}, {0x01, 1}, {0x07, 3}, {0x07, 4}, {0x07, 5},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x17, 5}, {0x17, 6}, {0x57, 7}, {0x37, 6} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* UpdDR*/{{0x07, 3}, {0x00, 1}, {0x01, 1}, {0x01, 2}, {0x01, 3}, {0x05, 3=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x05, 4}, {0x15, 5}, {0x00, 0}, {0x03, 2}, {0x03, 3}, {0x03, 4},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x0b, 4}, {0x0b, 5}, {0x2b, 6}, {0x1b, 5} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* SelIR*/{{0x01, 1}, {0x01, 2}, {0x05, 3}, {0x05, 4}, {0x05, 5}, {0x15, 5=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x15, 6}, {0x55, 7}, {0x35, 6}, {0x00, 0}, {0x00, 1}, {0x00, 2},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x02, 2}, {0x02, 3}, {0x0a, 4}, {0x06, 3} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* CapIR*/{{0x1f, 5}, {0x03, 3}, {0x07, 3}, {0x07, 4}, {0x07, 5}, {0x17, 5=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x17, 6}, {0x57, 7}, {0x37, 6}, {0x0f, 4}, {0x00, 0}, {0x00, 1},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x01, 1}, {0x01, 2}, {0x05, 3}, {0x03, 2} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* SIR  */{{0x1f, 5}, {0x03, 3}, {0x07, 3}, {0x07, 4}, {0x07, 5}, {0x17, 5=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x17, 6}, {0x57, 7}, {0x37, 6}, {0x0f, 4}, {0x0f, 5}, {0x00, 0},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x01, 1}, {0x01, 2}, {0x05, 3}, {0x03, 2} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* Ex1IR*/{{0x0f, 4}, {0x01, 2}, {0x03, 2}, {0x03, 3}, {0x03, 4}, {0x0b, 4=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x0b, 5}, {0x2b, 6}, {0x1b, 5}, {0x07, 3}, {0x07, 4}, {0x02, 3},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x00, 0}, {0x00, 1}, {0x02, 2}, {0x01, 1} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* PIR  */{{0x1f, 5}, {0x03, 3}, {0x07, 3}, {0x07, 4}, {0x07, 5}, {0x17, 5=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x17, 6}, {0x57, 7}, {0x37, 6}, {0x0f, 4}, {0x0f, 5}, {0x01, 2},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x05, 3}, {0x00, 0}, {0x01, 1}, {0x03, 2} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* Ex2IR*/{{0x0f, 4}, {0x01, 2}, {0x03, 2}, {0x03, 3}, {0x03, 4}, {0x0b, 4=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x0b, 5}, {0x2b, 6}, {0x1b, 5}, {0x07, 3}, {0x07, 4}, {0x00, 1},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x02, 2}, {0x02, 3}, {0x00, 0}, {0x01, 1} },
+
+/*	    TLR        RTI        SelDR      CapDR      SDR        Ex1DR*/
+/* UpdIR*/{{0x07, 3}, {0x00, 1}, {0x01, 1}, {0x01, 2}, {0x01, 3}, {0x05, 3=
},
+/*	    PDR        Ex2DR      UpdDR      SelIR      CapIR      SIR*/
+	    {0x05, 4}, {0x15, 5}, {0x0d, 4}, {0x03, 2}, {0x03, 3}, {0x03, 4},
+/*	    Ex1IR      PIR        Ex2IR      UpdIR*/
+	    {0x0b, 4}, {0x0b, 5}, {0x2b, 6}, {0x00, 0} },
+};
+
+#endif /* __UAPI_LINUX_JTAG_H */
--=20
2.25.1

