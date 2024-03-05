Return-Path: <linux-kernel+bounces-92544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA0B8721ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF83CB2509B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E02126F09;
	Tue,  5 Mar 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6gtzsu4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107601F95E;
	Tue,  5 Mar 2024 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650176; cv=fail; b=XTTLQfwwOe+hjne2A8ghGJsrobRsQ93VQvTAdYnPPkyRKtoeddNoD6pMAPkeHYP3s+Dm9J7ybNwac8vfclxNga7VVyfuMBemi7Dx6fnqDeO7qTtqz7Lt+ERROMEvO4VmNuAYxZtXMhiDjxeZyB3yEhUiPB8LfuyPSe/diajzpTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650176; c=relaxed/simple;
	bh=oIJOY1j1Z50IS15L7tSyAkGIaua3Dx0kfTEB6+UV4gY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gTR1I3G0zGgZWS/WnnGhnNAL6XoFdFcnRWKItRzVaoXuzNck/iaUtqr4yTsZ1x7SnZIBEDcuVr+vZu0AyoqDVBG1XH89+Id6krUeC6xe46GKCt3SRgHn+RPxqEp+amPfVVi9LTNQLYoUdduk58lezBqKt0pcOWRpwyhK0o6ShBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6gtzsu4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709650174; x=1741186174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oIJOY1j1Z50IS15L7tSyAkGIaua3Dx0kfTEB6+UV4gY=;
  b=A6gtzsu48SDMO3RLdyXWekB5QzoS14H5myqXsbg3DVr+8Mb+7VCp2iHi
   N/XWsibQKfcYcVrzI7XQKi7nIat0yNIvPe2kOmFlkOX47hyJV3nF4BZZe
   +rBpsy2Pqivbl5JE8k+N0jaHBknpRDoZ/BtrY9CDo7mDOG3v68+YZ23VM
   NF4vEaedvQ/5Qq20NOPosUJac85YcnR7PXpmRLhYTosS8VCrdwml82G6d
   I2kZAlitN4LiNbmB06cUx5z6KzKsjO4DTaHWdmGbHLa7pWoSif4KfcWIg
   szy/eCsSKaAKOdcptYDwRABJcYehD/Bzki3345cwkryCsC0g5qIoqcfIW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4369298"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4369298"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9977539"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 06:49:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:49:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:49:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 06:49:31 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 06:49:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIP/nabqEKCsxpPJ3Euf7cJJ+OyeB6kO5YRYt1M9Oqe8nQGuzXOPhX53sY+g48e+UIbNAXF+WC4m7UH2hIynW5p7LnGTJGH8MMc/pbIGGmA6JT7+wee1kNL1TTZ/5ZbXf8jcpI0z2yU00jWL4eGLzF6Fhb+6lRHm0QmwTL4epqzQ8jGiIf1s6BTV1HQoOsc464DWJLhwXDpd0rpixNB2j8/lmpZKUTqWClxCGdWotyl3OahxuU+YJuOeZri2adSEVfGrjxDS0XGQJATl/AIP1RhASvkTCS9RrgVwV0eGVW/RtnVYwFmIFfgMslMW6nbsJk9sjQevSUgJyJmjeqlZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIJOY1j1Z50IS15L7tSyAkGIaua3Dx0kfTEB6+UV4gY=;
 b=bMVqGUVA8d6qDmCUV41tlTAfTMQ5RXuF/aR5ctABp7m65KnvjKrche4kC/f+WoTZxxvAGnounGWhISqD4mLa8sIof/G9gbsGqHeLxCzYhTMamARd39JuaGu4EEGd8y7MHkiWzBXZJyVXaVQXjRvMpSqZ3sOmZv284J/IQxgwgxT4cy5+sviY/RqEp9ifqgOBIxirCVSJuCUE2CBeqRCVKVhX/i7E0GBR6ajZGomF0KbHgcmsFeZbktrUG9TLe1PUPduwtS9GEvrjOmfACY6B9gAnai4HjTpLyTsSLTVDlgErSm0DHF/w5wr6NroZOEjVtRim7SnVGNEe6JissVOBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 14:49:28 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:49:28 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Takeru Hayasaka <hayatake396@gmail.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"laforge@gnumonks.org" <laforge@gnumonks.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mailhol.vincent@wanadoo.fr"
	<mailhol.vincent@wanadoo.fr>
Subject: RE: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
Thread-Topic: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
Thread-Index: AQHaXVfYPrQaFDDbUU2tyu9IZKEtzLEpXUTQ
Date: Tue, 5 Mar 2024 14:49:28 +0000
Message-ID: <CYYPR11MB8429DCD5AD7C3E8ECFD635D3BD222@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240212020403.1639030-1-hayatake396@gmail.com>
In-Reply-To: <20240212020403.1639030-1-hayatake396@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8700:EE_
x-ms-office365-filtering-correlation-id: 437703e2-9a64-4f93-299b-08dc3d237556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8UeXuxVHjv9nuNs+W1deSx8KbIeGw7s1X/ok5/IbkQq6PUEXAfsFMSV8G3IpG+HDTqj5KzF+aI4OQwzsJ7KYTLUssfydGKkODUr/644OxC2alwC2h3M6mH4cqqgUDjr4aO+zvglJnfef2PjDRx4iUiHh2Sk9QwMPdb69heRAxteXL0pFribxQin6bEoiRt5kWgSz2myUChc+ewPK3IhGy7Iv1KOgqd1kKTEm15pVEEJU5gJkX6bcpfyi4NUnWcr1EOfrpvcZwQZkQE/9F0BxHPAtHboowDexqJ79ZEtG4hWStKvOhG8wBZpPVJ67AeOQw5Kdbe0ObSFixfyFk4jjOSTv2O/x5QYgWQybGRuIijzNdgqYk9woSFEC5IUPWxyDqJmNb8fiBbdHww/3L4CvkoNy+2+lPjngDxPKdsiy8uG7/4ych/ebNRMWBhkXJoFWgR27eFMnYmD15nTxZroUEoRevdyGuXQqb8xGz7Cdy6tKKCZT8viNpAsgEmnfMXTiVnR+HSb6byWZuuMU/qBAlwPnf0d7OvlH4n3YpNjIJp8bdIbhZVJKCQUPl9sOZiP3JZQ10hRbou5L0bV75eR8CrKirnp78Ojq+8yfTXuUoFMIAtRDQlV7sj3bWD8JiBjBE+cuxlYD2ucc6jkMzZXAz4jkR13PSwD/heEZJF3WSF3lhZYyPF9nbQr18gUpkUZPGVcykMIBy7r8K9h5Va5OK4NHY+WdcOp5rEOCHLp7dI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1dGSCuztApm0IOxlteXjbdeM51l52BFHfXNsOTlhFnrHtWT/Qlaopv8pjjn5?=
 =?us-ascii?Q?s0LVDQfFMKjZxpmOs1Y5c2L/UlG3knV9Mwz2YFHXbYp+0jl7it7B72AlMXNX?=
 =?us-ascii?Q?GgTeO1WMA0D0vqDZg4DEp3wDi8iLD9Np+0WQGjKea+HcATMNGy9DeQW9FAQW?=
 =?us-ascii?Q?aoFZN0kEh9ulGnERfydZ2tbrXeAnaY300sPsoLCPTce6C7h1e0Tz+FKPnUdn?=
 =?us-ascii?Q?747vF19esvzJVnOoZSDlZp5/fmX+NOeINZ6lsDJkfWa5++NpA09PQnIfLU0v?=
 =?us-ascii?Q?ouC9OuNb1usS+p6dumTlAiRxtJlDDVjepv2qw6g9UfQJNImdsObMWirynudr?=
 =?us-ascii?Q?Mo6mRKUPK6oEr+yTPsjuLv/tKVAAHxIrgf6j4l6n2O6p+yOzWwRhKgWog4Jv?=
 =?us-ascii?Q?hQMBimZa/yqbi2coTi129bOEJIQRu2cJ5avEnjJFdYKYtqCWz5gucC4jFT6Q?=
 =?us-ascii?Q?g1smueBwmYh+7julPpxrDRmDhGPbuG51iFHaMjL9Xk8jkYJMh6x5bbMyaAzu?=
 =?us-ascii?Q?4ecScrOXLTAeC82Mt8lvJFmgr5gSAXH71omXyjCtpnMECxYBwV+7DwuKaNze?=
 =?us-ascii?Q?mw35UeV0ux01Ifr8mGsep2Z8lJ0rCZmS4wJAhiL/447A5JymD2yY+0scVSxp?=
 =?us-ascii?Q?Xpw5dbpVXJrsdXc4P19wDbCNFXhV3fdEldbNDKnaR6XReiFKXsHfYUf8VKaE?=
 =?us-ascii?Q?qTihsFWYdbXQRPrUAVMlpAZE8/b3K7UalHHX3KR+eICPZUWfO5RkHbAUtc6/?=
 =?us-ascii?Q?PKKsPsvZXa8IhcBOy9M5p4/wwG7Wd/8pQvKOw8Omx3BW0yOEyibq8iAE4L5U?=
 =?us-ascii?Q?prXdTqHLtv8QSo7seR9LcV+9GNcc+L8z2jryKHvzqXAKJc34C01yQee8Xvs9?=
 =?us-ascii?Q?D+1mmjdrevZUb6awVo3dx5DIILoZ/aNtVZ3e9aQ096OrAk2NJqnD9T9wojpP?=
 =?us-ascii?Q?FuMRNbD9zLKeXog+eUJ7Est1VeXYkjR3YD3dYRIgqFR45ta+BWVSPUVb85za?=
 =?us-ascii?Q?4r9RVOD4se+s6iRBI0Ab32zOuNT879xII8YjnPrR4IKoO2fS8ChyaLugpaeD?=
 =?us-ascii?Q?dWc8/LU/Nc7KzJWyRtYpm2EbuLDmMb9OcyLtCDX4ti8qcqjcjX7TZembuSI+?=
 =?us-ascii?Q?HqXkXtZfdOjT2D8xR1U8syXBdwlNnWDRcuVcq81eEA2qTPa8fiT0Z04HMwLC?=
 =?us-ascii?Q?eGB1mgYm1Q3+v19ztqsxgM9RBpi498M1O4iwA4BVcU21voMvh5+5G8lYYudf?=
 =?us-ascii?Q?L00EA9KiRnhLOXmVAydm481P7Ldvmjwt6krhZDyiXkgLyPYRNt6Mr4VUI1kg?=
 =?us-ascii?Q?Dxp07uvQKUxNFPtq6ROp8cE0Cmkp3RbEYAOys08wQpytmG01sLIUqyBZQN3e?=
 =?us-ascii?Q?OfyGTjjZfx8iQZsSy5MY0pjDdGQ+F8VX7K1ykj+WFpF3Tz6IiREtxVXILBtT?=
 =?us-ascii?Q?Zxo+nrCMvHo4CYioNVv3FLGMODX5kFSVZCaL3GNoAWgaPmg6pEeiCJYqJgpf?=
 =?us-ascii?Q?UkORHYScsQJm6ix1GBnq0DTIyQkFaPXoK7Vv6Fd5+Eqc23Po5v4UYJLFjpDX?=
 =?us-ascii?Q?RGJx0+vPF9NNBJHzJWyCzBmBfVIyJ4G/dsxY4ouk5XYFoAFHLxNGp5CtFu3B?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437703e2-9a64-4f93-299b-08dc3d237556
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 14:49:28.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsYJJdEG/tOvP7RmnruYFMBqiItIi+kj16fHKxdMzx0Iewvnmr1ojE8Q5g9dMfbFf9/cREBbVUH3nZZAj8SURKBrpwv3punBRoysCC1MqQYLPMS6Nj5s2AtFUwLu3OhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8700
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
akeru Hayasaka
> Sent: Monday, February 12, 2024 7:34 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>; Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org; vladimir.oltean@nxp.com; linux-kernel@vger=
kernel.org; laforge@gnumonks.org; Marcin Szycik <marcin.szycik@linux.intel=
com>; intel-wired-lan@lists.osuosl.org; Takeru Hayasaka <hayatake396@gmail=
com>; netdev@vger.kernel.org; mailhol.vincent@wanadoo.fr
> Subject: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS h=
ash options to ethtool.h
>
> This is a patch that enables RSS functionality for GTP packets using etht=
ool.
>
> A user can include TEID and make RSS work for GTP-U over IPv4 by doing th=
e
> following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
>
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
>
> gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format d=
oes
> not include a TEID.
> gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format tha=
t
> includes a TEID.
> gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extend=
ed
> header includes Uplink, applicable to both IPv4 and IPv6.
> gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downl=
ink,
> for both IPv4 and IPv6.
>
> GTP generates a flow that includes an ID called TEID to identify the tunn=
el.
> This tunnel is created for each UE (User Equipment).By performing RSS bas=
ed on
> this flow, it is possible to apply RSS for each communication unit from t=
he UE.
> Without this, RSS would only be effective within the range of IP addresse=
s. For
> instance, the PGW can only perform RSS within the IP range of the SGW.
> Problematic from a load distribution perspective, especially if there's a=
 bias
> in the terminals connected to a particular base station.This case can be
> solved by using this patch.
>
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2->v3: Based on Harald-san's review, I added documentation and comments =
to
> ethtool.h and ice.rst.
> v3->v4: Based on Marcin-san's review, I added the missing code for GTPC a=
nd
> GTPC_TEID, and revised the documentation and comments.
> v4->v5: Based on Marcin-san's review, I fixed rename and wrong code regar=
ding
> GTPC
> v5->v6: Based on Marcin-san's review, Undoing the addition of unnecessary
> blank lines.Minor fixes.
> v6->v7 Based on Jakub-san's review, Split the patch.
> v7->v8: There are no code changes. I've resent the patch, including Marci=
n-san's
> patch, because PatchWork did not interpret the patch correctly.Simon-san =
told
> me. Thanks.
> include/uapi/linux/ethtool.h | 48 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


