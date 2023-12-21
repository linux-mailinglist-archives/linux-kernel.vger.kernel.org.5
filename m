Return-Path: <linux-kernel+bounces-7950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364581AF98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3542A1C218D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1424B3A;
	Thu, 21 Dec 2023 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TK12sFm4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA81775B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703144251; x=1734680251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1tenrxPh5H+PfwvkT2Lthn4SEfWVg4aqiPGuKz+Aobo=;
  b=TK12sFm4K8ysYPCKnyzPhB+68BkoSCPLoTZK6zBlVd+0rvA+vR+BAPpe
   LA2RgFdaX8Z8jJrkTeqqvPe5xdlrvRpoo8Z+6kWx43WfyMBNvYBdhqehb
   2V2K+O8JbjKWM9OaWiKWP8akKwc+wsZaUQ6Y2zMYQxvXaxSbFOS35Z0Gg
   JZpz6fwkghuKipAuhy8X9XSCDwawbYyrBy0RJLCn9zNa2vM/MJzHywy12
   2vtaHCZmBYYN1BvUeYh4JyuB87/Dg6jyt8IqaAnWiiHysmVRCQQ0vR7cc
   oUfteGv6mcQeQ2LKcDGloYCVMdYOaqwPmtpnXgCr5n3Kyufe6K2p1SLmw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="394825681"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="394825681"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 23:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="769867879"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="769867879"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 23:37:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 23:37:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 23:37:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 23:37:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 23:37:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGOZjl+gFNqveG29lyUSsblR028E8ILO3qhnLUq+rapoQ6/7ePv2MDdkZ30cw7KieEDT3TblR7lwsXR4/AC7vNAOcyn11+npvSNtwynVj2wz4eViPkL2xF95ablg2PrexwU/Xtg/VcbJMaaRY6orrO1rEQP8S/XVNaZtmmOCVlfx/HRh3KuBqpVBWCzhNAfysyPmpRfa5OhMQBhC0p+/+MVLovkKj0J79JI6CPcgctxVPWe84opAhgbGsvo/6ntSkIBfcNQrXLQTVR/Yp2WIm5umg4Kzv98payE6L19woZ5ib5GfeMveiSNZouKEFwUF48Q+yAAF0/aB5SxYZ8J2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVIyDT9PuZqiCr4dQpCcJoUokXjt1L0eZ/Lt9BFf6xo=;
 b=YJKYeLpdFPKc+8vqRbCRrFpEKQEDVi+ZEMuZQhIO9EtXL8i2sjYZILxzZjYT37H3wFolcM1MlorgVbzhaBNr7v6MSpDJTDdaTzNxraD+/QK5YHmkq4OBCFYuoNDkleA5Bni+GTY925aok0rbyYJ1KVBZgsd0KPFLXUzYUtGZF+fILannUwyPIMMglFjsuw0DLCQBstZ3B6HSaif0tuFv3pBrSikqGnWuD3AytlwzslHJj73WfYfMZEBwOpy8l/84MZaIwvb/d45wFVcXKa/kUywkVSrxp7isJp1UKWrqb3oD7kjCAzLvloUhHqF9DiLOYa519dCfz5zGKl+Mgv/0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 BL1PR11MB5416.namprd11.prod.outlook.com (2603:10b6:208:319::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 07:37:22 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::da85:3d5:65fd:4a21]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::da85:3d5:65fd:4a21%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 07:37:22 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Song Shuai <songshuaishuai@tinylab.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "andy.chiu@sifive.com"
	<andy.chiu@sifive.com>, "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"guoren@kernel.org" <guoren@kernel.org>, "bjorn@rivosinc.com"
	<bjorn@rivosinc.com>, "heiko@sntech.de" <heiko@sntech.de>,
	"ruinland.tsai@sifive.com" <ruinland.tsai@sifive.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: vector: Check SR_SD before saving vstate
Thread-Topic: [PATCH] riscv: vector: Check SR_SD before saving vstate
Thread-Index: AQHaM9xUk1Gku3WWt0+1VAEzObUeIbCzVYuA
Date: Thu, 21 Dec 2023 07:37:22 +0000
Message-ID: <DM8PR11MB5751B02E235561D402D4C608B895A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231221070449.1809020-1-songshuaishuai@tinylab.org>
In-Reply-To: <20231221070449.1809020-1-songshuaishuai@tinylab.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|BL1PR11MB5416:EE_
x-ms-office365-filtering-correlation-id: eef68ef4-d4c5-467d-18b4-08dc01f7ab44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTdoL/9DeN7QHitz5b7/h7DRK4jcSYzG15vsTJtpmIy28lNFFDIi2KzkGBFuhPyy6oY396UZ4Zjk/p74ePXmPyOeftzuyiJ8FGduMYBLzbzZ4ySe4BQoU6dQzr390Rla0uK2HJuSjFHv9JVvMpLLw7zZ5XbF6sYfrJ9mZCavCBnwE2bNZByqPxKIUHc+JEWwfrzBVf2DHVBxU7DMvksfO2Yy1vfrDdsVuRDs8IhM057pdKKntKey4JzZh6OMdV+hQa9zXFhOq0yiQuFGah6IcC4dvx56FqvbmaE7Vb1WLqEdbIbQo+9IRRN/nCYFKJIUORF55TkRERfikt1f82B/qJKF6/kuFj/34m5Qf9Kwdr6T+x9+fes7w/RjIuIltWTyT8s337LYfdVDUm/4sgXqrAu+ePP1Fq/LUtTsI6q2tdKuClpggPHUlBqkSqCe+5qlmYOFIGxxbZ8ZehP1224IjL68napT9qEnMNoCxx819V6d+oSjZVqr7zge2zbkDtKxzjolrosJnSjxMbp4wH5IADYXBBtRQu+zR/2rYenav1xv0b9gWlaB+Z0HLhYTkVIB+ZzyfY0luJxCNRURVnxxNgZaxeNanJZpkkAMtjOYJi3C4RXh2lidrg5kWIZVWah4JcdrXo6pbTNH482y4b7r+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(9686003)(71200400001)(6506007)(7696005)(53546011)(122000001)(83380400001)(4326008)(7416002)(52536014)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(5660300002)(110136005)(76116006)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(82960400001)(86362001)(33656002)(38100700002)(38070700009)(921008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?O+sdWBd1ZBdpa2EI3wu2LqL2lCjFkcvSPTx5zSpLrrAp/ffS9O1YTkdc?=
 =?Windows-1252?Q?Pq7jds4yezQ8hAhk7I3wFIL1Ij1MV6NX7cNhZmvoEeiF0zg/VJdOAL+K?=
 =?Windows-1252?Q?iXNCVTXMfYGORxHdvjdDUO9kMfn/jkQ8bJ3XpGxODmuYql5hgE3VtTeu?=
 =?Windows-1252?Q?7dtLQnr03GoRK6StSHIasTieYhLORq1Su81GhaIYFh1OqW9eZ2inJKds?=
 =?Windows-1252?Q?S7rxOLAizPS8OyLqGmuAgN+YYDSWwd6GrBD18LRvl0pzBPbl/kAifCFO?=
 =?Windows-1252?Q?rHebTXfgYN1x5/qr7iB+2zbNnkLvditqxHqXMlC2pbSgHeGFY3jvUXcp?=
 =?Windows-1252?Q?bD47N9bancLMCiTSzcTFrljNZRpkiWuJ4L1ycK/PepiN3pQlkEPi77Z7?=
 =?Windows-1252?Q?Hieirx0c3R22mrq0aQ3ti2G6uWFbCM9b4ppEzfk6HbAlbxWjJzLdnyfE?=
 =?Windows-1252?Q?avZsjNPo49yNx40qt2qOJaCWaiSVGIEQHgHHTBrrsnLF+OfPNTDY93Om?=
 =?Windows-1252?Q?1aUOoH2HOrYSyLq8/ldeQ59EHwB/WTatVytmjdqthOPhitVMqbtw0cbN?=
 =?Windows-1252?Q?WA3DAr5lPU/c7rLJVSWlwOUY6LGnu6Q6R0ZsebrepDfGY712QelI7Cpt?=
 =?Windows-1252?Q?QeJm11vTeblibN0/TJY7O1PoQocnA7Vp6CveI2LVIlJlqzPAeoz1DPvg?=
 =?Windows-1252?Q?o0uZroks6g7NORsKb8hxURjV2dK0f+ulg+tb5q2VIoyU2YuH09imcdfR?=
 =?Windows-1252?Q?g34gy9zxwHdgUvUyuQDRYhn4LlB1k9UXZdoPLIZCmMewsyWs0+R9ERxz?=
 =?Windows-1252?Q?ic/vOswCq04k/v/E4ab1yPCj3VTQW//SMosi+b7Sy63C+1fuoDtR/7U+?=
 =?Windows-1252?Q?/GFyT01v++v0DiHcnPXOZQ39yL5Gf/b0PQV+Z7uVqrCxRsDkDxtgnehu?=
 =?Windows-1252?Q?P/ZRXOo1t7M1b/JcdKeauVG2NabB8NXk1hKKSPCKHL1fC/l2cySYna8F?=
 =?Windows-1252?Q?w3UUQ3TA+96jrfnv1TQ9md9Ko2QrAisLPZ+PEjoGQWOfxrvMTfD0u415?=
 =?Windows-1252?Q?1XOsbA8SWWZvPJupFqgUTkXOmv/s4jwCm0UEA4v3qpwGtmG5rWcU9Xjd?=
 =?Windows-1252?Q?EH/LSDuilmyFqe2PmIIDoh7Rn0aCydEftbqCQpcfIBLb+pGyZfsRNY70?=
 =?Windows-1252?Q?SrYJuD0YsK4sbgFpxrBi/oV9Q+LW1Y7kV0kZ4NAwXewQ9Lj4v4Gykcjo?=
 =?Windows-1252?Q?j7ndmfaUEr0fQNVQKcWM2cd89RJCJjRLH9XGMOS7k554oq7F5H7d8S5f?=
 =?Windows-1252?Q?YOf61rgj22z+R66JOiqKTZMBGdpGvS6Hp8G647E/Q1O/CPIz9cjtsbkl?=
 =?Windows-1252?Q?NBBetKN9zSJYouHb63iHcDHx2opms5kAl9CyzKwpAQSUoGCoKLVIM7ag?=
 =?Windows-1252?Q?4fCP7zUiqmNXQsOtNX2h+hvqzfx1IIIUTv735Cc7F2ebFH+rCK2ow5HW?=
 =?Windows-1252?Q?IA3mdM6sPTrTKtWYnx+Ureq9AU08vJWkvBzeck7L/tnX5vxyFiXB81xV?=
 =?Windows-1252?Q?ll0XOGA2nz7NUtqjHcqUqTQRgovp5FOElbjLpOnRbGXqiBuXGhxMim51?=
 =?Windows-1252?Q?6J9wlyqKUgSCTfGYq2rvvqc+uz9hrDujQ0NqFrqQs3KXbUsTfJvoHoqk?=
 =?Windows-1252?Q?wn+kjrrtvzWM9ur2W/8HoQ6ixFWQxZtZ?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef68ef4-d4c5-467d-18b4-08dc01f7ab44
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 07:37:22.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dy7Zmvf4lsGGrgJz5AcaQulHTM36cqJZTOIKtBK0pl1/Tenz/Sq31Q8i7mQzUJ4SsWq56quaXKA3JuMm7o98LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5416
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Song Shuai <songshuaishuai@tinylab.org>
> Sent: Thursday, December 21, 2023 3:05 PM
> To: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; andy.chiu@sifive.com; greentime.hu@sifive.com;
> conor.dooley@microchip.com; guoren@kernel.org;
> songshuaishuai@tinylab.org; bjorn@rivosinc.com; Wang, Xiao W
> <xiao.w.wang@intel.com>; heiko@sntech.de; ruinland.tsai@sifive.com
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] riscv: vector: Check SR_SD before saving vstate
>=20
> The SD bit summarizes the dirty states of FS, VS, or XS fields,
> providing a "fast check" before saving fstate or vstate.
>=20
> Let __switch_to_vector() check SD bit as __switch_to_fpu() does.

It looks a duplication of status check since the __switch_to_*() internally=
 will check the ext specific status bit.
Can we just remove SR_SD check for the fpu() case?

BRs,
Xiao

>=20
> Fixes: 3a2df6323def ("riscv: Add task switch support for vector")
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/include/asm/vector.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vec=
tor.h
> index 87aaef656257..d30fa56f67c6 100644
> --- a/arch/riscv/include/asm/vector.h
> +++ b/arch/riscv/include/asm/vector.h
> @@ -190,7 +190,8 @@ static inline void __switch_to_vector(struct
> task_struct *prev,
>  	struct pt_regs *regs;
>=20
>  	regs =3D task_pt_regs(prev);
> -	riscv_v_vstate_save(prev, regs);
> +	if (unlikely(regs->status & SR_SD))
> +		riscv_v_vstate_save(prev, regs);
>  	riscv_v_vstate_restore(next, task_pt_regs(next));
>  }
>=20
> --
> 2.20.1


