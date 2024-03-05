Return-Path: <linux-kernel+bounces-91655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D158714BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00E42849E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D893FE47;
	Tue,  5 Mar 2024 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7TqWdXT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90A1E4A2;
	Tue,  5 Mar 2024 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612935; cv=fail; b=WoFqLagFGky3lgZo8rS2YePe3xg83vhfUpcrnTg499bQRdus/SWGXN7Sj8z3i7ZGw0uElJUFfXTnwHJCyM4AgG+o9BQWoVrZrHa21V7PK5eNAiwKFFu+84Ya40FMlzRbFJjsBxkfroqAhci606Pnzon9l/MvIz5BQBcCZeRp3t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612935; c=relaxed/simple;
	bh=DSTw2lNkbBbCiziqDxrP8Lf2gtzcya8nXDMA70/l5Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzGksMUNqTUZWKztwN5JczR/1hL1JILKctMZOFomMqQptki0zeaZP4EXLXSc033AQ8oXw/+vCPNNoPCUenXJ1tq+agtAv88oZqsGROeJVT2/M+c2EcvOQz9r9UrYx+cHpjdoMLSRu9F8QkCf8Nh6J/d9aUsRBLiaDc8J2PlKZus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7TqWdXT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709612934; x=1741148934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DSTw2lNkbBbCiziqDxrP8Lf2gtzcya8nXDMA70/l5Co=;
  b=G7TqWdXTSqTBWlKYxR2seiPvy73x5fSZEZqdvFh9cxOtRx3GfvQn8t5W
   qPYQoX8uixyBOMafk8T+0qHTZuT8MSN9hZion0upfayD39YEMJgP9ej3x
   ONmKYOlZWeRfXzczUh4FYUx+VDCUXyLd31d3kxSG6hMec03mIk8kG8YUG
   KbnEB8iwoJU3iU7iAaa/6cZfRQULPQ+nCpASS7PFXSPzB9oK4ULTo/sgb
   AP4GjWi3+I+UK2sOm+XAKJOtjCzMpIkRVN4Kd/enZM/if5twky8WRpz8D
   S1V2hUqWnuDJh/qKAryD+GXsZyht4h49uBYq20NN5JpyAnARthXNf1Lgq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="29565266"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="29565266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9340854"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 20:28:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 20:28:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 20:28:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 20:28:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc0tljasxGjg7MyCBTClZeciwGN9ehiYxf9Kf/GDVB/BYPPtu4TubyN252FyEJMr9Wr5VozHRroBO7jlhb+kq5SQPjrMQr9PMoAypg7B7F3J+PlmQysIQtMe3I1t3je9b122YwjiUGbYTrtO/MAXF2oiddGq7i1GFgFRu2/4+Niz16ESqx+HkygnPoT2V2S/qerkKIbg3ZIUKgXiX7Wue7E8CXFrEiuQcUBXrC9+CX4RfXXEL0aKGbVlUChAgmOINbC0eCaignN/AOMdE+Igs4JjWLXihUHcXTCUN+/uJIzIPHoUOSTeSnnoyrQvp5g54mNkWkV3rDyUMyn80T8GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSTw2lNkbBbCiziqDxrP8Lf2gtzcya8nXDMA70/l5Co=;
 b=E6cWyQiuk+XMaBng8yORRqc8Pu2c7NOStqtxYnljuMLze2tz/FKu+HsLyYDpA1q3/xv2G7EkTqbUKe6pyQABPphDx8JArMRJvnyhg9+N7zAyFnX4vuAIEpaXAok5T9cC4sC/oWX1JbBEEf3A6QyObjgO/0uGJR0yaw992ZfNiD8MiSb56DVLdkoATGSqite2RFfpnWZu8axtCft1jrsO489sfu6QfQCtHYip8To9xFI3KB89xLlvQ1Z7rMB+EbEjK9oHFCr7X+hc5dKEqxdACERJyUb7NmsplJXwrsezzkTMbeD3A3uvuceSVpIQm7iCJttTvqjYa+omIExNpa6/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB8456.namprd11.prod.outlook.com (2603:10b6:510:2fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 04:28:48 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 04:28:48 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Takeru Hayasaka <hayatake396@gmail.com>
CC: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
Thread-Index: AQHaXVfYPrQaFDDbUU2tyu9IZKEtzLEjR9cwgAVbwwCAAAsMMA==
Date: Tue, 5 Mar 2024 04:28:48 +0000
Message-ID: <CYYPR11MB84290126F884C2AB4F9AA5FBBD222@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240212020403.1639030-1-hayatake396@gmail.com>
 <CYYPR11MB8429FCD568EE2AF90AEE2CABBD5E2@CYYPR11MB8429.namprd11.prod.outlook.com>
 <CADFiAc++edOb7-O6yCUgpAaonZ1sQdkrwwH8432D=e40g1CwoQ@mail.gmail.com>
In-Reply-To: <CADFiAc++edOb7-O6yCUgpAaonZ1sQdkrwwH8432D=e40g1CwoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB8456:EE_
x-ms-office365-filtering-correlation-id: 65fbb380-4404-4675-3a2a-08dc3cccc0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L96b2rFef1Ta5iIuTCrwXq+sjDVFVEY0z+lIB1la82KS1Q3+yoqnLTwswYdQ/1dXQP1PUT3qaacCB8dSRJV3I+jQZeYrA3zdbZqo97wHwroCp78eVn6VzpEFv4e5k2DKKbVakJP40xEiDzWB7RTYTUPHBlqRxjnu9603yWCRaYiVbxHqwKWxEFiFFSdWYGrRqGPoLqGMgyyfstkrcLs5sbaLZeMu6g5QyzkJKMPnmQREv1OkS6MM0gRYrUfMkzq8PtDsumPOVIVakuOmL2mfuVeoMpsNfggtRf2F437m4Ke+LDlAbgkcMDYaiSGy0kJovQDXYAY1yQoYOjvmcHNVGS3376l3jTjOkIjGU4yHkaF88IRFqhagcsIKmkBdjZM9NIyrbUJ6inlF+iYF81gP7uTuZkOIM65EOz1z6VE/SDrEJklxzeH3D/OHJ0iVG2poX0aD/+IhQTFbuI8s8ptWCUWege4VDJsq38BGCeqe0b77OxAxeg/dSnVXAgwAhfNGwtt/kpwwPZzfvXLIhJjVLF5wgrPQ8GUWS/fF2fWvwOpgzKaOu5yUiPOBLhBxmNvrl+QeLlu7NVasshvAe3xj/W81K/nhaqQWG6Qa9IVfScEPEOURaNsA6kPjRx8uEN6/bp/W8qWG7ozXGDbEQpplUj9DRBjtPllTR+J6cfSVMw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGlpd2ZjbkliQnpMQno5SktRWXJOamsybUdQajZ6OTdlelN2Y0E1c0tFeS9W?=
 =?utf-8?B?aG90bjlOQmhQekZBOXp3OGFpOWMzcGNLd2NFbHdVU2cwUDhtMlZSK2VNcG40?=
 =?utf-8?B?WjJxb3hiVVpKMWlCVi9kSkxhVHdubWNMaHR5bWFpYVd1Q1J4c2ZWUm04NEJP?=
 =?utf-8?B?dDZMT3RLeXFSQUZ3UVgrMnhOelRheXVsb3Byc1p6MUJmWE5QTkpqUjFYcG1w?=
 =?utf-8?B?ZElERE5KWmNtMXVGMU9veklzMTFTdlo0SXd1elphV3V6VHNLNkJWNHJmNmJB?=
 =?utf-8?B?Rm9YV1h5NkF5ZXpBWnVabTFSWHhxNXpWYldub1MzVTRqS3FzeE5mbk1MSFdS?=
 =?utf-8?B?YW03cHVraGxzQVFmYkYwQU5ieW9sWTJPQXRaK2YzWGZPZHRzdkFFQjVzYXZS?=
 =?utf-8?B?cmtlZGdKYVNCMzBxQ0dxbG5uY0JjRlJVZ1ozcXpKNTRvVW5JM1Q4bCtLalcz?=
 =?utf-8?B?YzFOR25Pc0pKWU1pSHVxUklnK3p0M2hzS09Qc1N3cEtRRlpBdVJnRCtSSVFz?=
 =?utf-8?B?bjZvUlpqeHQ5TEF6cmxUKzdkajI5YkdieEdrb0hra2NGN25NNXJRc1ZXeVE1?=
 =?utf-8?B?SkIrL2NIRTVsY3pIODJ5RU5QcGRuMHF0eE5nSFBObmNFM1ZsVTR5TzYxQmRW?=
 =?utf-8?B?Q0U0QW41c2o1RnEyUTF5UU03V2xJVEJUTGVjbFl0eTFJK2J0UTRHbk1EZ3hw?=
 =?utf-8?B?NjVnY0Zya0F5M3BxdlYyVVZQeCtwTGlwZHltZEtoWGZKeEF1clBwNk90Qkpw?=
 =?utf-8?B?NlhWaTZ6WSt0N2tLNzdxWTBHbXk2N1FEY09IM1gwemJRdk1WL0FGMmZkaXc2?=
 =?utf-8?B?VVpEZzRzVlgyQlc5Z0VqK1ZZUlpwM2VQa2ZyWWlXNjFGU0JOZkVuZnpKb1pP?=
 =?utf-8?B?RHhlV1NzUzh4UFJ0ZXViLytsWlBHZWZiNEZlRFpGL21vTEdLNndzRFFyNEsw?=
 =?utf-8?B?ekhrZDVtRXFpOHAyblQrNlNZd0ZKTHJyMnRwdGpZaEw4SC9ibzVHNFdZUmZm?=
 =?utf-8?B?TlZMWHRuWGZXRHVMOStuWDdWK3VRZ1ROY1VIblo5bVJRZXZmbHdYeDh5azFn?=
 =?utf-8?B?TzBMQ2V4QmJLVFNCRDBNajB3bXhBT2toSzlCSnVWeC96cGVrWkRBWEd4WEQy?=
 =?utf-8?B?QWIrd25jeE0vY3k2NUJBSjBGWUhJSnV4UktLY0hHbjFjRTBTdk1FMTVrRGlS?=
 =?utf-8?B?dWNaaVM5SVNpTmpxeUk2OFZxRGQzc2s5aGc5SXhsRzYxYTNFc3RnU0Y1WTUx?=
 =?utf-8?B?anNQekZoUUltVjNkdnN4LzVBZ2E4Ly9aSnh2QlYyMkdQZTRCZVNtemcyTjd4?=
 =?utf-8?B?VDdybTgwSVA1QzdxdlRLd1NKYUtSMVAzem8zWGplK0JTd1FJb25sZ3JnMnpL?=
 =?utf-8?B?T1Zoa2Nva2lzSEpzQlJYdk0xRXZ4dHdlSlZNRzRnVEVLNWtxU1UrVXNhbjk1?=
 =?utf-8?B?NUZBWjB5L253UlVDS1p3bFpLQ0J1cWJtSVNpK1JDOHRjd2VjWnEvdFVVUHo5?=
 =?utf-8?B?YXl5dEptUzRMMENIbFhXVVJQZDFhV2V5UGR6WnlxZzhtTVNIeWZjNXNUTUF0?=
 =?utf-8?B?b1dtM1hXcWRlWnRnUmQxKzhTWGs3K0dyZEdrVzByb2FjV0FtdEhiQVZRZGpk?=
 =?utf-8?B?UlZsWUVzbzB2RmpGUytnbFVHdVZONUxUL0NiUzJvblo4MFlkOVJRRXZGN0lI?=
 =?utf-8?B?SXRQd1NYaTF4NUswSXI2SU9JOGxoaTRXejIzaHNGSWE2UE5iZVFuVThPM1hs?=
 =?utf-8?B?Y3BRWnRPK0FIc0xTMS9iR3lCL1plY0tFc1ZlT21nandNN2VVY25ieEFvd2ZN?=
 =?utf-8?B?aXpIY0p6UWxvd01TazQyMjFXZnI3K0poWm5UVjAzZll4TFAwaUF4SU90SWYz?=
 =?utf-8?B?Mk1yUUlQUWh6NStEVVBjZWpwTFBCc1dlYmE4dG1nWTRwRmxnRmMxcXZMRC9j?=
 =?utf-8?B?dDVIQVdTTHFzbFdYamVNRFAzYVhQK3orWFBKRVFGZlNwVFhueVA5RjBRZXVr?=
 =?utf-8?B?cVBzd2g5eWlYTUdxK05PWXlTbTFTR25rOWY1aFhXQnpNT1F4RFU3ZE1XZGgw?=
 =?utf-8?B?cjZvMWFIU2pFQkRHN25BbGpzOXJVNGRVSTExQnZsN1RBL2w1RThFUjlINWEx?=
 =?utf-8?B?T3FXdXNqUkRLZE9uTVNyUVlpRGI4S3hDMzUvODFqVmRHblZhOUhzTFlnU0sw?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fbb380-4404-4675-3a2a-08dc3cccc0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 04:28:48.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oj+IsVOSBkSQ85vaWHiuja02syVP49yHGGph4H1Q+n4R78XLb1ZJwokEvLt8RGT5LPDisc7ANpanxOeW9/tIHMxLjAWKbxFJgbZkTkQizgaFqY51DkyBXoPE4DRWffVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8456
X-OriginatorOrg: intel.com

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRha2VydSBIYXlhc2FrYSA8aGF5
YXRha2UzOTZAZ21haWwuY29tPiANCj4gU2VudDogVHVlc2RheSwgTWFyY2ggNSwgMjAyNCA5OjEy
IEFNDQo+IFRvOiBQdWNoYSwgSGltYXNla2hhclggUmVkZHkgPGhpbWFzZWtoYXJ4LnJlZGR5LnB1
Y2hhQGludGVsLmNvbT4NCj4gQ2M6IEJyYW5kZWJ1cmcsIEplc3NlIDxqZXNzZS5icmFuZGVidXJn
QGludGVsLmNvbT47IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNv
bT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldCA8
ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBs
d24ubmV0PjsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgdmxhZGltaXIub2x0ZWFuQG54cC5j
b207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxhZm9yZ2VAZ251bW9ua3Mub3JnOyBN
YXJjaW4gU3p5Y2lrIDxtYXJjaW4uc3p5Y2lrQGxpbnV4LmludGVsLmNvbT47IGludGVsLXdpcmVk
LWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBtYWlsaG9sLnZp
bmNlbnRAd2FuYWRvby5mcg0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENI
IG5ldC1uZXh0IHY4IDEvMl0gZXRodG9vbDogQWRkIEdUUCBSU1MgaGFzaCBvcHRpb25zIHRvIGV0
aHRvb2wuaA0KPg0KPiBIaSBIaW1hc2VraGFyIFJlZGR5LXNhbg0KPg0KPiA+IEZ1bmN0aW9uYWxp
dHkgd2lzZSBpdHMgd29ya2luZyBmaW5lLiBCdXQgdGhlIGV0aHRvb2wgcGFydCAodGFiIGNvbXBs
ZXRlIGRvZXNuJ3Qgc2hvdyBHVFApDQo+DQo+IEkgZm9yZ290IHRvIGFkZCB0aGUgdGFiIGNvbXBs
ZXRpb24gZmVhdHVyZSEgVGhhbmsgeW91IGZvciB0aGUgZ29vZA0KPiBwb2ludHMuIEkndmUgYWRk
ZWQgaXQgYWdhaW4gaW4gdGhpcyB2ZXJzaW9uJ3MgcGF0Y2guDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI0MDMwNTAzMzU1NS41MjQ3NDEtMS1oYXlhdGFrZTM5NkBnbWFpbC5jb20v
DQo+DQo+IFRha2VydQ0KPg0KDQpBZnRlciBhZGRlZCB0aGUgYWJvdmUgdjQgcGF0Y2ggYWJsZSB0
byB0byBzZWUgdGFiIGNvbXBsZXRpb24gZm9yIGZsb3ctdHlwZSBidXQgbm90IHJ4LWZsb3ctaGFz
aC4gUGxlYXNlIGZpbmQgYmVsb3cgbG9ncy4NCg0KIyBldGh0b29sIC1OIGV0aDQgcngtZmxvdy1o
YXNoDQphaDQgICAgYWg2ICAgIGVzcDQgICBlc3A2ICAgZXRoZXIgIHNjdHA0ICBzY3RwNiAgdGNw
NCAgIHRjcDYgICB1ZHA0ICAgdWRwNg0KIyBldGh0b29sIC1OIGV0aDQgcngtZmxvdy1oYXNoDQph
aDQgICAgYWg2ICAgIGVzcDQgICBlc3A2ICAgZXRoZXIgIHNjdHA0ICBzY3RwNiAgdGNwNCAgIHRj
cDYgICB1ZHA0ICAgdWRwNg0KIyBldGh0b29sIC1OIGV0aDQgZmxvdy10eXBlDQphaDQgICAgIGVz
cDQgICAgZXRoZXIgICBndHBjNHQgIGd0cGM2dCAgZ3RwdTRkICBndHB1NHUgIGd0cHU2ZCAgZ3Rw
dTZ1ICBpcDYgICAgIHNjdHA2ICAgdGNwNiAgICB1ZHA2DQphaDYgICAgIGVzcDYgICAgZ3RwYzQg
ICBndHBjNiAgIGd0cHU0ICAgZ3RwdTRlICBndHB1NiAgIGd0cHU2ZSAgaXA0ICAgICBzY3RwNCAg
IHRjcDQgICAgdWRwNA0KDQo=

