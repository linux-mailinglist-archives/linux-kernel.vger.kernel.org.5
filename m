Return-Path: <linux-kernel+bounces-45484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87FC84314E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB51E1C22656
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A17993B;
	Tue, 30 Jan 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHG67/mb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C6279947;
	Tue, 30 Jan 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657562; cv=fail; b=RWODtl2lpGZ9YKS6xyqc3YPlJT6IBmg3pgJH890vZY3LUHSS8xcUMeco+pueBgiyCQntMPfS/jR9l2ZaTjS+4d9qHq3nWiKIFv2hp9UGvjlfTnPskSN6REWpMarbuOvPPSSuccxeEYJZ2NeiutJMvgdPuZv+0kLnOnBZJOY50Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657562; c=relaxed/simple;
	bh=NMKPfCUK4umpWLQVPtyEvnyqQ0d//SgklXJl4boXqME=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U63QlsIqVpVzK4hkn4cdiF7L7QTf+Db2YukJkOEoE5Oa9Ke0AKN1cRuSSLEHyLVbd2zCm26pr+XIpDPyvQ3y3bgBlk1pkQxQFcutHoKTgIIGZCoYjNhvfQ2SfTZXWNoo+GUrs+Vc8L8t23N3srMjKCJDXtzmTNnqBRAqjmJIvC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHG67/mb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706657560; x=1738193560;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=NMKPfCUK4umpWLQVPtyEvnyqQ0d//SgklXJl4boXqME=;
  b=PHG67/mbSeK5sgTJ7xqmPTRNDH84KVsVVE4H9RFsY7tYxVriVugsVnN4
   iSVhyz+8JgaDN5u+eyCcMmQSIu0CthSi6G20DDPTFeljqtfgQekmIyX1A
   unpYWMhEGlJyuNOnmK7mGUeIFeVFcLkR4mSuv9W4QgS+q0cf2VC1a1ZaG
   jo567M6y+ympretIbsbfePes4dQn2JXeMevVmPcZIslTwytaRRjiT4T3e
   rmtRnNlQjbspFofgToHmeG9sTDq4eKaTJPsvMv7RQEpTqPU2li31ho0Jn
   g12Qn6z6JSYY3V+IcRdH7WBY/st/o5OsmAuq4zmGtNQo8snE9LadO208Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24912640"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="24912640"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822363647"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="822363647"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 15:32:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 15:32:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 15:32:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 15:32:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbCeTWJAw1hUFtSC929AnyKBHVawmAiAoEJ8d9o6K7YNkweWS5FjJcZ12DjEdpFnZr8cxdkYyE1Uk38V/+H0ewpBAgfxvPmbzpytM9B3paOtKSUTiiZyTOt6InyW6ZFz7ZrYdfUnmGxWHxVyDgWirkG61XggdP1MuISVxipUDaPuA7mdRgIHNmWVUf8FXcv8jcMnFONYkIUAPH5dByTwh9d51AWK2i+RqY810H6XZI/ZWgJd74DYFb/m8xiIHdO/YBNmSC+YsDSW6/6in48H+pLqwQHbID5Q9T3FdLlEiOYyiigYBMgvcClLOukRh7U/XDQjxCjk1m0SQbFFyHmQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfUbqC5raVfhPqimW9w97Xz1EYpe6qDBVMjRY9NkmZs=;
 b=HK8tb0M9QGrv3TQzWID/Q++cW+qoFIAAvDg26Q73nwTQ+cdaLE3y7nSz0zByfObFNvn8y6fGEysm5vp9rkpiP3/qnOStK2JVo+HFsOXm/Bv5wWIMykFUtTG+eSfT6mI7NgPjbcEMJRgaork3zrMI8KrR/pVEZyhqo3EVVc3u7ZVKDV/d2kpnLhWleksBXRvzGUcskEMlrW/fqr8jw+n67gwQrpetd6FuiuuPRJnef09QsgQWtypR1LHOmMmU8AxmJFp1b1JcCisUUUdHqd9GqNPXf1nurUJnicvMsekoBWoPJ9LEa8mf3as5Fix/J+M8bLjg9aga8mCoWeHPv7B/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 23:32:14 +0000
Received: from LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9]) by LV8PR11MB8463.namprd11.prod.outlook.com
 ([fe80::5262:6eb1:2787:8cb9%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 23:32:14 +0000
From: "Corona, Ernesto" <ernesto.corona@intel.com>
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
CC: "Corona, Ernesto" <ernesto.corona@intel.com>, "'oleksandrs@mellanox.com'"
	<oleksandrs@mellanox.com>, "Castro, Omar Eduardo"
	<omar.eduardo.castro@intel.com>, "'omar.eduardo.castro@linux.intel.com'"
	<omar.eduardo.castro@linux.intel.com>, "'pombredanne@nexb.com'"
	<pombredanne@nexb.com>, "'corbet@lwn.net'" <corbet@lwn.net>,
	"'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
	"'gustavo.pimentel@synopsys.com'" <gustavo.pimentel@synopsys.com>,
	"'lorenzo.pieralisi@arm.com'" <lorenzo.pieralisi@arm.com>, "'kishon@ti.com'"
	<kishon@ti.com>, "'darrick.wong@oracle.com'" <darrick.wong@oracle.com>,
	"'bryantly@linux.vnet.ibm.com'" <bryantly@linux.vnet.ibm.com>,
	"'sandeen@redhat.com'" <sandeen@redhat.com>, "'rdunlap@infradead.org'"
	<rdunlap@infradead.org>, "'kusumi.tomohiro@gmail.com'"
	<kusumi.tomohiro@gmail.com>, "'arnd@arndb.de'" <arnd@arndb.de>,
	"'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
	"'alexandre.belloni@bootlin.com'" <alexandre.belloni@bootlin.com>,
	"'tytso@mit.edu'" <tytso@mit.edu>, "'ebiggers@google.com'"
	<ebiggers@google.com>, "Filary, Steven A" <steven.a.filary@intel.com>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>, "'vadimp@mellanox.com'"
	<vadimp@mellanox.com>, "'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>, "Chen, Luke"
	<luke_chen@aspeedtech.com>, "'billy_tsai@aspeedtech.com'"
	<billy_tsai@aspeedtech.com>, "'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: [PATCH 30 5/7] Add JTAG core driver ioctl number
Thread-Topic: [PATCH 30 5/7] Add JTAG core driver ioctl number
Thread-Index: AdpTyGmrWVJf1WgfQiS4fB+rHp9BOA==
Date: Tue, 30 Jan 2024 23:32:14 +0000
Message-ID: <LV8PR11MB84634960758E20E781DB638F8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8463:EE_|DM6PR11MB4689:EE_
x-ms-office365-filtering-correlation-id: b4a8da0b-2ae0-4299-0e0f-08dc21ebb0d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/7vStlmCeLMI4DlpFu/mglba4i2HxafpCOtan21pZmiQM8wlJDIdZBa3L/nymjp+MKLfx8KcA6QKz92/EKgt9Nt9G7PcGg0rI4+F7mLPT33OkJ9i4u/DCEtTnDfagFjgiw84/vzcLkbsPrasormQl3nMhaCm3DanreUs1AIi1YLr5+RXhO0PDtBCO4l4S0IHAnBvfc1B6cabFqMaFCnSyoXZlF2kW1KnaTslsptNb4TymkNy3HzMMXHplwi4ocWTN6g89ve3wAMV0K4lqemau8+qbyeNbGtgDUzuoiUqbM5yg1Ft3zN5oho+mD2WBmnhS3PsICfzz++FZ/y47ix0d+umQiEr8fYeTofqaSvCI6LiltKs8rxqQj1AMhggzBoF5SVjUwXSkh1I2FMtFlq1gTHNiFaqGWONLILN37R+6AZ8lSjiQ4OrvXO3sUHrsP93O3eMgLwgKNay27fj9bPl1XTLiPKG6wIFhjtvcnYAsFDNl2Q5Sggj9jb3/8wCTyfctGpeAlKkeRuBdlGrKijmDrTIgPakYq6ggzFxFP1Jzx0lPzszNYKCS60h5U5Bsou1e56yrCYfYL6AvyWhBP6IEWa9OF176v5XCVXRzxhPE1OwXSOjEw83DOaA2ZlpfmHX7A6qApjJVU/A8ApYb8ZXjK71lrP3ygQOH5U+tX9dRA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8463.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(9686003)(38100700002)(26005)(122000001)(8676002)(52536014)(8936002)(4326008)(7416002)(478600001)(76116006)(7696005)(64756008)(54906003)(6506007)(2906002)(5660300002)(66556008)(66476007)(71200400001)(66946007)(66446008)(110136005)(41300700001)(316002)(38070700009)(82960400001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DscssCOTBGhT90NVVK9UgG8difEsXrMZ4ltvZHiZmuRfwDuo/pehtUCOC8rS?=
 =?us-ascii?Q?vvfhOwmLuddGxFb15tB8evwPW6oAjt8ImgQARfdjrOm9Y3cDJJzsJZvW8r6o?=
 =?us-ascii?Q?ahUyHAonbjGMZEXMWfupk2aStJXK1qwU4Rqn1iBMgthfX0bhHzx6w/KcItic?=
 =?us-ascii?Q?ai6I0FSg1YkStU6AiuyUNyJcoiTsZurm1e2CMDLVSkN4D89sdITrRZ1Gjh0I?=
 =?us-ascii?Q?DJNCITYrxpAU9X49TXnjQEFX8KeDXfK3BaGMaPwou8fBwVpkZfWfmjaiv2Ln?=
 =?us-ascii?Q?Wa8Zfy17clqKO6kogkN7DqefB1sFtqcPD4wKsfBAt8zuUkmJ9QZPxc+mxr87?=
 =?us-ascii?Q?n4VFN1CqMs/OGdTUJvkcwYiXxx+bhgbRndLKPwi7ru1sR/Cq/jxszxTMoYFb?=
 =?us-ascii?Q?fsjOEi9pUnyEgH219pTC3E++Pr9gjtFdO3Owx+QbPMiXwj6IOhH8c3x5zVMT?=
 =?us-ascii?Q?m9jKqtF0xOhJwmWhWHu1q/CmaucMbmtzZoBk9XmzLHkzVejZeHEql7aOrZqA?=
 =?us-ascii?Q?73WWcjtiSWUaaPe4d3aByqPPG6d2GnZYWWxXkh6T5BIWGSXK9E/R+hblrZWx?=
 =?us-ascii?Q?ND0SgbovkXx6cURREkdhKEbAbn82cwmfIS1r+zk/85qaDUnPOGByqUGC26eB?=
 =?us-ascii?Q?AToczVyiSYCuBImXpnWZqNYh91xqTK5Y1vng9qaic1OG88J9kCFYhKG4fUlo?=
 =?us-ascii?Q?znSu4VsF+ldWLt63dS1Lw5ZvphkVT4OR1iv7eH9e8Kp6Stnra+Gh1+1l2k0o?=
 =?us-ascii?Q?h/Pt9m2/Ywn2gMwH6Yna9IYHrp5m5u9KkKwNt3bToFOkDQH4AAjhqRYooT7/?=
 =?us-ascii?Q?pCzA57hlZGg5U4AMNkv1aQnzBVeUedNfPQBVcRlNmL5Y3aR7fVjo9siBlQAi?=
 =?us-ascii?Q?pB/1vzAK356YYHbCY29frPMJTfMRoBPRViK5oF9iSVtM5vRV9zOsFdaCa4kq?=
 =?us-ascii?Q?BG2xJYj4E8bf0rsnHCxobN2gzrbL3FsFr1iLZGWhX60KxJ5QmfcB1pi7c/kn?=
 =?us-ascii?Q?wal3CsIuUQjyC09pA70HxHshsoTcv+nqmLul+0GCucot/Wf0iVGlRtTiSQWg?=
 =?us-ascii?Q?usiDZfJTBt8R6cDhNcAnoiMF2ZEQPB33ATx+VXPLnzMwt5baOg8EGwA6NFki?=
 =?us-ascii?Q?51VtApOLHPG2kNieGuTnGL+blxth3i0UE5sdOzp8Vs7da/rV9YozB8uktmHh?=
 =?us-ascii?Q?4UJ/bbexEPmAR656kmmIrDVOTlMFl2fCT873gBr9pc3MoVvvYXUUHmpOgG+V?=
 =?us-ascii?Q?mmPvIsVRywXtp2BkrHRSyGDSkx91MVAERDLwEO38z9RIXrg8j489ux9xqEXr?=
 =?us-ascii?Q?XuF/QxDNlghRgh0fCNkU35l3JODLUHkE3/uhv5+5brPtIUf965fXo4ioVZLL?=
 =?us-ascii?Q?62FmpV2qZiA1uu0ZmHlB8sIkCJrwa0zQEqhVbQqZ6SRNIDKBAkfYU8AkgQUv?=
 =?us-ascii?Q?SozfLtJ5SSeZGOwCnlyTuEXjQG2XWvTEZ7A7YZgJ2Ruzo8rj7CDswOH9kVBu?=
 =?us-ascii?Q?v3h2CKVh9pEYHLD+dkr8x9b+5mHkCTvv0zpxOTbx1zfYD0cxQz5hvcPXJMte?=
 =?us-ascii?Q?cywO15H09MIVWwKEwz28ZdxB07ZL+Gsjr+GM5lcV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a8da0b-2ae0-4299-0e0f-08dc21ebb0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 23:32:14.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJbdmHyF4CssK4af2H+hc1qdBiPw7NZxm7hGH2mTfxIad0cbHap6TgMCcGnmrAR3/0PfFv9gJolXFLFgS3HUVctGc2Nbn7Ry/4Ic8JkZmzA=
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

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Cc: Eric Sandeen <sandeen@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>

v29->v30
Update Ioctl number to 0xB9 due conflicts.
Change email contact.

v28->v29
Move ioctl number to userspace-api/ioctl/ioctl-number.rst
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documenta=
tion/userspace-api/ioctl/ioctl-number.rst
index 457e16f06e04..cf602aa3a853 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -358,6 +358,8 @@ Code  Seq#    Include File                             =
              Comments
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mail=
to:linux-remoteproc@vger.kernel.org>
 0xB7  all    uapi/linux/nsfs.h                                       <mail=
to:Andrei Vagin <avagin@openvz.org>>
+0xB9  00-0F  linux/jtag.h                                            JTAG =
driver
+                                                                     <mail=
to:ernesto.corona@intel.com>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
--=20
2.25.1

