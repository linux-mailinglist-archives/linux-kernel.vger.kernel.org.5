Return-Path: <linux-kernel+bounces-56013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97684C4EE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFC3B213B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E391CD33;
	Wed,  7 Feb 2024 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d3QQPNv9"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9D1CD19;
	Wed,  7 Feb 2024 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286932; cv=fail; b=VlH/xpPnGG8T+HAiAD5jZT2w4lVCsQjavDgdJ2uoFuqb+Bki0TinImlnmYopgya5k1RV1eQoiC0zu08vOeizpZYqyJtwmreBPXYfV4PTVEulCMObRrlAvuxusKL7xrO7VkzMEmRMZIXLzNdBiPaNbblI7ZcUFQbhciOmjVix0nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286932; c=relaxed/simple;
	bh=iAy6TtIRBnYJlcFlQO7guEcqkup9tIFeg6TWl1TXd80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DyMSlOTfpJP3Kb61A4kettVz5QAKY1bMJTH/wlJ+ef8d1FEOlLKSf0VpY1Nsvc5rz5CyqxjAjlQVcyniqLVFhGnjud8VabZQwQ8qZ9KHHxLMhMBwCg/AqNpPrIK5cfj30Wa+HELmvydMsIfdp9tBASd3XOlm2GtlZnOojGhWn5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d3QQPNv9; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxWkkAe/Pk8CJCczE3cIt2D4hjQjMt+CIMX62YSLuiEvdynRCE5/Go/si9I/cS5MAJXuaCcH5UvUHbh6BOuqX1f/RxDqskeFfWoVep9AUmKqGeU/MAMh2Q6QBrEgjCK73YMT7ngXbgxaq98mN9+Y2AlYRTetsnCMwPU4XmElryjXBewJH9HOs0ITvswAhrAtWK+yn/VvMqG979e5zjaVZZzyMT17A1sAi8rWbZYswbu2uuDyxTrQzWqIPWwAc6U+NbcNH+CR/J99p7W9qVBcEqr/1nqpI4WOrgKz3nniqqPMAlpxNGQEsh0q19OuBwTfp0X2lwDby6H9ij9ZnOCq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybCoASounzaKYhkywEtsNhjhRRvY1m6pkIggofSd07Y=;
 b=jGBZCwaOZhPRdE62rlGv/YP8vMDYhhwKu3GOEHtrZWskyspAIYGnSlSTCMR6EDcELihxwkrvhv8nwGBsXdDkAPBJx4vDJhX0sdsA1N2ZIshFqmMEu8/DLKAWxC9ETms2t5Fki9pqFyE+ceNNgvVDc4rMJ1rg+3ImDHidwIMM6Xj13Rgw/arepVODWjJ8GDOyh2gDzJZuWie9OCvvE/hnaOL1IQoKu8BPKqCcQ9/XFYsONOVVEziva/xfUTucuFAAgN1ckmkJvUaHW4u9srhi3+PMD3P3uhHyBzbWOb2EaGi/fxl9+bOEr9Fmi9jpBGmJ4dOfWj+g53Dp54OkGmjRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybCoASounzaKYhkywEtsNhjhRRvY1m6pkIggofSd07Y=;
 b=d3QQPNv90CDxQMmN4dAKFInIkAGfgQ4uQ7fKL55bbkvr7HCDN+RLNDBi9kDh4RH+oOd0KkRi+iarj5WDNBDPRQsF8vhCJH3s7Q+NQL16AgRQMtxfY2VxlYlL/puI/WRa+vlHahvCh1sp8Ge3nCJdmG/pD/wKfBC/oCPBOcVLyYw=
Received: from PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 06:22:06 +0000
Received: from PAXPR04MB8301.eurprd04.prod.outlook.com
 ([fe80::dd05:bfab:725e:6896]) by PAXPR04MB8301.eurprd04.prod.outlook.com
 ([fe80::dd05:bfab:725e:6896%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 06:22:06 +0000
From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Giovanni Cabiddu
	<giovanni.cabiddu@intel.com>
CC: Eric Biggers <ebiggers@kernel.org>, "agk@redhat.com" <agk@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qat-linux@intel.com" <qat-linux@intel.com>, "heinzm@redhat.com"
	<heinzm@redhat.com>, Horia Geanta <horia.geanta@nxp.com>, Varun Sethi
	<V.Sethi@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain
	<gaurav.jain@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>, Iuliana
 Prodan <iuliana.prodan@nxp.com>, Fiona Trahe <fiona.trahe@intel.com>
Subject: RE: [PATCH 1/3] dm integrity: do not filter algos with
 CRYPTO_ALG_ALLOCATES_MEMORY
Thread-Topic: [PATCH 1/3] dm integrity: do not filter algos with
 CRYPTO_ALG_ALLOCATES_MEMORY
Thread-Index: AQHZr19tPftu/4qhUE+Xly9w5Fkd4K+rmzCAgAAMzQCAABCvgIFUBGJw
Date: Wed, 7 Feb 2024 06:22:06 +0000
Message-ID:
 <PAXPR04MB8301C112A114A6AC5A19D69B8E452@PAXPR04MB8301.eurprd04.prod.outlook.com>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
 <20230705164009.58351-2-giovanni.cabiddu@intel.com>
 <20230705201205.GA866@sol.localdomain>
 <ZKXZUl4VgZkMbOL0@gcabiddu-mobl1.ger.corp.intel.com>
 <ZKXnUeueV6ncaJM6@gondor.apana.org.au>
In-Reply-To: <ZKXnUeueV6ncaJM6@gondor.apana.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8301:EE_|GV1PR04MB9085:EE_
x-ms-office365-filtering-correlation-id: e621d39b-c0c4-41e9-3a87-08dc27a51ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lP8+zf+w2s8h7HLdMaBw9cqPpPbTBxw13rUADlGfzKbtaEKExrt3jShHYQfmDkZsv4ByMK2mAf4YHWslc+rVNL+42zMAh4K5l6MsdIKrFjx+F1ciXmv91wkxh5c+zdIMOqQAa1DVHkeYXKRryyOA8iyW28nLs62LWaWF0re+9LZJgboN+uJQXHP+ZSvz8hRyWmE/Uxb/VHvfPmXgf8S741EI5w8ZUH/xD+pD70b2bvr0R4Q6j+U+4nNzfK0mdV4KeFH3HDOE4oWpD9L/DBvvoNCAaUBOazlmMQWUnOU8OQ6rqf3OGh5pFCW8SM5bypa7uiYSD+3S9HjGaIGXHi9TLp/pK1GfCXVdjpfd1SWOQsfrYGUHkSB/Gc19RAjsGGmxNnpREVxPcvGp2XGq3JR0r/n8kiObXJJQadvl6glVf4LjE0xRAe919dia11v62hDbyyQI6L0U/CMMQXJ0PnIm4KcXRLHPZQVVRGNMNmR8+aDFvJMqm5+mk/esnM6oPh8xMR/ZEJ5AoikXsoL6sfRYLSRdoeU7eLu1v9kgv3TM+CpNZSAu6YIxbwC5tbiPIlh8Skj2zmaa8BNPUvn3cIYCHH4PSui1YMrJzQDDHVk9j4g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8301.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(8936002)(8676002)(4326008)(38070700009)(52536014)(44832011)(9686003)(83380400001)(7696005)(6506007)(33656002)(55236004)(53546011)(86362001)(26005)(66446008)(316002)(64756008)(110136005)(76116006)(66946007)(66556008)(66476007)(54906003)(45080400002)(478600001)(71200400001)(966005)(2906002)(5660300002)(7416002)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o/G171hVFS0SHxAetPNPg0gKsVVMh6zs+JE3ZyzkyamJDMDd5w8o5KS/xkfh?=
 =?us-ascii?Q?auyyFjRYzv1jMhg1fu6k5dN6ArrpncliYDUlmLf5O3bDj7Xcm7sIMqX2EMcQ?=
 =?us-ascii?Q?yg/UGaKFu88U0N3X8JqSHVrAgQZvPjsXZoXQqwikeI2ZjMVFhXK+2uS1ciZx?=
 =?us-ascii?Q?YHkWHv9Eyng1My4dvSssEzHMURJDmprCAZaW63GWZPdRHjyLRp7q2AbVtO4b?=
 =?us-ascii?Q?mu5ibvrZyBt6jS7GEtpxP8W/9qNVG1m8p8faK1TNP4mHoPQ4Szx/Awo8V00Y?=
 =?us-ascii?Q?3FsTmaXbyJ9M/RPd0Q9vWmJvYQLKOfCyMl1etK1lBpNjGrwPBmKdVxdNH0aE?=
 =?us-ascii?Q?+5N06DW/tJR11As5AWc79v0GMUGlRmrqUnHw9qBK7oZAoz/ZSt9rr8nAv1Ru?=
 =?us-ascii?Q?KRJ8KbkW+3SKPcXi+IuxItsiHZIUjxRJGF6996QdUGI9m+Aq/xpApY8+gP0Y?=
 =?us-ascii?Q?7SLIf/7hHaPU5fUrdbUwxDHZNW93qP2r13+d+91qnFq4BAz0g2oUhbNhdJ6L?=
 =?us-ascii?Q?WRBc5jsCZU5jeMeY+oel0pSj4EJzUFSR12Se+aPmtcz8guBjhYRLh/gZdaC4?=
 =?us-ascii?Q?pNxY3DeVEs7qwy8IimtNlb2Dz9bkT2o4i7l6kQXTlV4YpQxk1ZG/fYym0Tkw?=
 =?us-ascii?Q?krAL4sYR95yzKDCZZNaVs9Hqo8Wc55HUCzjS6LRyPizN6YhuwuoMJFmMIEl4?=
 =?us-ascii?Q?rdwr3kUhMHV4+1d8lgA65Z5O9Vh2aGFjgtjEo9POCk0YhJGoxJGHxP234IIy?=
 =?us-ascii?Q?2wGmaLPTh5aScAAD1ca83HjPMUxp4rbcQ2kunpR/pwPcbGfHIjUjHNIsE84m?=
 =?us-ascii?Q?ajz8EzA7eXugfBAHO+u6NFQis2k/Z9CAlvpoJyxQQXBCoGA3yAqPsMYjjr4W?=
 =?us-ascii?Q?VqrouiAtw+P9cKSKbtlEf5ov9tjWU1+SBzED47BPRj8JRIJARDTuGU9eTUbj?=
 =?us-ascii?Q?/mbyfY+X4XVJO8zzxsw/3eAmmGR5SyqFTgXoJ+FcaTyfQwHqhM44Vnsdhsw7?=
 =?us-ascii?Q?4XhZTkeyPXkQkP4rO7D26Hv+uQhi3VtxnwTEt7ISxxfaRaUc5p0ykJW8M1df?=
 =?us-ascii?Q?RKKrV0yQQDeQI3KrrchP8NJipYd+u69v8/X04Z/emwDaKXWlycpBv5KTf7LH?=
 =?us-ascii?Q?o+2OmsDJwvmv7FFfcLO+mgieO/Ad4Vn7fXMKxtexqtyVubM8wB6qVCEPW3B6?=
 =?us-ascii?Q?zbXaL5mcO+KudzQOVU7Zy4TSnk9yp4Qf0AX3PHwFmRw1LpiDETamwfWbPnWU?=
 =?us-ascii?Q?xtlTPxkqQfAoB8cEWeL92RfNcccSbGSHrVTanQACPsqT/NpWO4kLEgj9hYDC?=
 =?us-ascii?Q?APqiniIyKZUwsU3zMxPiwWlEV3m3/+ws9E+5W3TZyQ7MTpttqcFzDUU4ebbu?=
 =?us-ascii?Q?/gEPd9mccBid5W2HTJNpgxfS4YQHR4ubHzGcbxnVXlY/oYbplIiGH0sYEC3n?=
 =?us-ascii?Q?9PZfk+8vDEntYxc93F+KMJ8peXs/tEdzSWBuoQLi0wZaIN9SbSA4N2Q/1iiC?=
 =?us-ascii?Q?2h76TcxjAxlhp6SgX04C/Df+HFtQGItAe9vZK/F0kqBeBl2KKNFU8b5wSnEI?=
 =?us-ascii?Q?0ncUGH4CBxa4py7WFX9GZBEIbSRpO07mwM/ZZOSAcyVxr0t4Bjvucs2Y6tdp?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8301.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e621d39b-c0c4-41e9-3a87-08dc27a51ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 06:22:06.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmsvcoR+xbJH1ORwpY0WyWiJ5ztjxQBUcCg1evgudeT0++VrId8t1ybcAx66I42RvX2RZoumEnKf1jgUsbUaHtFP0HeEFsAv0VRAjXHPgKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085

Hi Herbert,

What are your plans for this change?

Thanks,
Meenakshi

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Thursday, July 6, 2023 3:28 AM
> To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Eric Biggers <ebiggers@kernel.org>; agk@redhat.com; snitzer@kernel.or=
g;
> linux-crypto@vger.kernel.org; dm-devel@redhat.com; linux-
> kernel@vger.kernel.org; qat-linux@intel.com; heinzm@redhat.com; Meenakshi
> Aggarwal <meenakshi.aggarwal@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> davem@davemloft.net; Iuliana Prodan <iuliana.prodan@nxp.com>; Fiona Trahe
> <fiona.trahe@intel.com>
> Subject: Re: [PATCH 1/3] dm integrity: do not filter algos with
> CRYPTO_ALG_ALLOCATES_MEMORY
>
> On Wed, Jul 05, 2023 at 09:57:54PM +0100, Giovanni Cabiddu wrote:
> >
> > Then we are then back to square one. We need to check how many entries
> > are present in the scatterlists encrypted by crypt_journal() before
> > adjusting the meaning of !CRYPTO_ALG_ALLOCATES_MEMORY.
>
> Indeed.  I missed the fact that it was preallocating memory with GFP_KERN=
EL.
>
> So perhaps the answer is to adjust our API to allow the drivers to pre-al=
locate
> memory.  I'll look into this.
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.ap/
> ana.org.au%2F~herbert%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.co
> m%7C59d63c0b42d5423abb1108db7da2e431%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C638241910806938399%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&sdata=3DvdLCyhQOSTEhIK1%2FkAO7Z%2Fu6ejrLbRHwM88N
> DmsqaP0%3D&reserved=3D0
> PGP Key:
> http://gondor.ap/
> ana.org.au%2F~herbert%2Fpubkey.txt&data=3D05%7C01%7Cmeenakshi.aggarwal
> %40nxp.com%7C59d63c0b42d5423abb1108db7da2e431%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638241910806938399%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DeAkggsD8FaJzb9OO2p1bcaPYs8xt47Eav
> UdVVssGM7o%3D&reserved=3D0

