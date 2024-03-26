Return-Path: <linux-kernel+bounces-118825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7F88BFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230B41C385D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98D525E;
	Tue, 26 Mar 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij2Y1uI4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDF803
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449933; cv=fail; b=FLXbzAg6cX2sUInYohfQnQjeR/W+iwuMWG2KSQFCoF8Ul9OhCoHya2FgL7gYw5fU4GNq/4aWnxpfS3O3KJR8sBfZFB/SeSL0QL08os/qAHq39MxuhELMp7zfyrIwn77jcY2yoGQ76RM0jpJP8zYOtmQV+a04cssr4JzMU/1snMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449933; c=relaxed/simple;
	bh=gS7dI5NSKZZVzjhe/ruxVk/S+7evUmSImVEF8mIDizY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=osLbV9yKrLRFJECLj7p1c2vl8Um8xrhrYi62+/6VypwZ2KlXgYqk+SbiqTj0KDY8GREjQSaTpSeAAYLbQcZBnJLOh6M6MXF6m6BxcswszNJgaCFpo9Wm6dpz/IZD8Ng1PiNzfppSwlqKcvLABTttVGI2qeZs0f3KEn/yG9zaLDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij2Y1uI4; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449931; x=1742985931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gS7dI5NSKZZVzjhe/ruxVk/S+7evUmSImVEF8mIDizY=;
  b=ij2Y1uI4A6r/rB+1KybjRTJwm9KOCLp2GrKJnwSnxCLKa3SLBZbUCMqo
   IP138AHjyofiRX0zUpbAQG8F0ZZBKuiBLZuUGmcTRrce0RsoyUPMM+yyy
   JSjq73oXgr/I0i/DGNixwLJvEEL17SCK4cyZ58YIH/0Y7eaDYdAsppPsh
   mowdd1wRpkhlpA5gRfe2PjoOJl+zNYB7iI41I9veVs2/vj3GU2tQ1BNio
   IsnHQY+3s/GmWrM+WMfsisYkonkGz2EmafeLCwLvTJSIYGswPGUZQGTZe
   RubgOKHkEMV5yXpCG53N/rQTlpBhn+ERW2UJzB3uiRvySYazUsNGxzhc2
   g==;
X-CSE-ConnectionGUID: NLror3M7Re+Bcul5GK0hoA==
X-CSE-MsgGUID: lCdfZnswSjCAHSE0caW7yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17922942"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17922942"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="46941367"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:45:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:45:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:45:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:45:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb//b08iS84XUFV5M0RY2CwCjD0Z6uYAUzhxNAnMgY6kbyzpbSsx4HzsZZUHe32sw5u5sFnATLrIzEo1YVxj1BcC4UX+04tLA7dgdHn7GsOaprVvkFZ7t6o3fKEULHNf5dv0RvT2sSvKJwp8Y+VtGZeZ8eCx5rQDTQtyaXX88IV3RlKkzv5/KdlkP/jrU3k+W2T3sWGPdoHT89qx+pntyA9r57RS3QeeUjTVyOrOMcDvCMvkrXGh8xiupah3GDfWa6ayErpZ35pFH7eH0n7jDu8MK3dl+XqnzQuXsz0Q1Txo5RxT7q53Gz2R+ekdV113nZJvm3HN6JwEP96JYbZyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS7dI5NSKZZVzjhe/ruxVk/S+7evUmSImVEF8mIDizY=;
 b=L/Um++lAyxaY7qRcChnNbeU94hv0ey4fVduKqZureaJmwZwPPEwaXDt5x56oUkJry0wMCLQtof3XvkqfVcZ7njhqz+myVlywTk7+eFJa4ZW3qDbXEFiSYNJw9uS0ZXWFexy8cI6GY/dvr5CN6fa/XbnClDywR+PBTsgJbkK2nmmY8mrEVr272UdJG1YicQUqWPCe95EMvOFgUNEw/M89qxt2pXO7iqc8KTkKe+m0z4mn1CCbRzDX/SRhnqjhViTy9g+DCHg5Ga1PHiWoYzOdzA+V9uP7W4olgTjuaWOi6ccZJQBADomgy+2kd7LBpTrFD8DhTUMvbBPyJneTcKj2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:45:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:45:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/4] x86/tdx: Introduce tdg_vm_wr()
Thread-Topic: [PATCHv2 1/4] x86/tdx: Introduce tdg_vm_wr()
Thread-Index: AQHafsJHLyH6qmAybEmrAEfUvuNIw7FJ1+UA
Date: Tue, 26 Mar 2024 10:45:27 +0000
Message-ID: <bbae9c7e47e1d3dc2353d87d25186a5834a17cd3.camel@intel.com>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
	 <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325104607.2653307-2-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6440:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDMgZ4ZzlduFQ5Geigx70ZxP8lirmVnPulg+YdSCojywdHyXuQ5i5XV46s07NRXlsKmavpIzMXLiEWiZCC3SI7apTsBqcJz+NBvpWAUa4yaonaOZM5a0a3+4VGUaAYO3JQ8leD7vjaPCR5i6bBlnw0g7v0kXfTEhBQg4riGA2RCr9JWIL4WFw35WlXV9LQMFzjczCS+UoiDpivJ3jJewRm84vrlJ1iQ8GToZI16jtZGJ9OiAVe3bkl+A8FmbgJZDM/NyB8WWl3hbQ2jODnegzWKgCdItpBk1mZBTsd/lOJNY+xnTHAwrqUDEmXLgSGIUAszYBEYWqomb/fX0dr/4W5A7YqcNobsG28rutk+vz7802qhFRKKeI9RW8ZnpDKu9NvfNr3Arwp9YncT8lz9w0bJpf7LwO2q6b4jQZF7KUZAjqR2zpNc1w/hzH9RMr2Dcz7w0eBWtBtQmFw7yLq7fIImuPhpBZmOV3ao6fTfthwFRnb3W9rQlC3LuIg56eKwFXZRJD7redb5I3NmiSLHc//YdT+ckpjP5dlP6CUIMedb5fzWDS3V50F+DcYLuzxMVlWpisAMuL4H/C6aE5tYSexd5lEqBH2KximnluvstCpZjl2UDpkzBN5xm872ZmQvt7jrm/Cmwi4QXVVr+uTetnME+JHBSGLJmoRPQlbfzz1I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXZkYVE3VUtBSFF3MzBHOVBQaFNubHREZVJIek1lcUVrSklDaURSWGpzNi9p?=
 =?utf-8?B?WWJCMXpDaldyckVkSE1XOGdhVnFUK3dNMURGS2RCWGcyTE8rK1Y5QVRSS2dR?=
 =?utf-8?B?d1U3TzNMUkRnN1NwR3RSU1d4SUROQ2ZUNXcyZ1d1Sk1leXpLd3FndytqVlJ0?=
 =?utf-8?B?WXFtb1NqNjlITmhCRDQ0Zy9oMklXWTZaUW1xMDhJUFhpY0pyakJDbkpTRS9O?=
 =?utf-8?B?WnBJNTlDMFhjVk1ZZHB1YUlvVkJsUjEwUnRrY09McmVpTEFsUFBlaHRROWM0?=
 =?utf-8?B?NDI4NkdpYWJzbTZYeFUzWXliZUFSeUxtNVh1QzZBNS9UTkRHeDBWN0NnUTFs?=
 =?utf-8?B?SDB6by9BcWlVUGxvRTVwR0ZVRDc5cVVPMXhSUnlCYi9na1h5SFVUZFVtN2hj?=
 =?utf-8?B?akhLZmJhSjd0NyswMUNxQk9weStLdkdNTmtrVkV5YjlUdVdYZ1RWTGJLTWRX?=
 =?utf-8?B?VEJsMTJmd3hwV216QTczeElzKzUxTU92VHBSWkdFaGVsbFdRUGI5blVnWUdW?=
 =?utf-8?B?V05RbzdLUmtpWHJlNHAxeEV2TFRML1p2Zmt6eFZzQkhxaEo3dGFIb2lpZUtX?=
 =?utf-8?B?VVFISnNDU0grMTdlRlVrTm14TmdlbHNCYzVmYlV0OFFPdEtWTTlLWDZ5emlV?=
 =?utf-8?B?cUIzWWV6Y3BVM0ZEUzhKelpZMHBqUVhDZHRlbU1ka3lCb1JCMWk0WllKblNl?=
 =?utf-8?B?N2t5eG8xNS94YlA2R1E3WFBSTExoVHNPaS9mZy80bUNadzc5UldwZ2tIbEpD?=
 =?utf-8?B?NldXcnBBemlpZUJ6UkFNSlozZU5SMVp1UEZyWllzWU1ZYU1YRS9aY01xZllO?=
 =?utf-8?B?clo5UlduUFE1MUIxSjVmeXRucWNTV1ZEbFB3RDJpc2RUYnB0QjZoQlpQTWJj?=
 =?utf-8?B?ZEdnRmZFdmF6eUwwOVVBS09IS2xGVzZ1K0dmMFBxVHFSN1RaY0VWVGdPcUc3?=
 =?utf-8?B?dURYb1p5ZTIycTRpc0dXUVNSYmJ3T0FDRUNjeE84T05kZGR2akZ5by8vYWFy?=
 =?utf-8?B?azEvYmx0WFNpVEdnQ1YrVmtZNzMrcEdYTVJSczJHcjdDeGtFazJnQ3NlaU1w?=
 =?utf-8?B?ZkNpNGJ2YmlxVmJPV3lFMkd0c2ptQzljVWVERHIzaG1kUU1FK21VaFBtalRU?=
 =?utf-8?B?SDVBcXRKeVUwdlJEaERlNnFnRUJtNkordnpSeHhmRmFRQy9TNUdGa2hKTWN1?=
 =?utf-8?B?RnpDbytUTVpZNWVPNW1ERkxqR2dFd3ZoUU5Ea1g3REg5cVlZZjFiaWxUZ0dr?=
 =?utf-8?B?U0FKdzRVbVlEZkp6VUo3RGg0SWRyV1FtVFF5Y0xBRkZxc21YN1daaFlBT2li?=
 =?utf-8?B?aVI1ektXTnpXeVUxZjVyOGZWWVN2cHhtQy9yaHlyNFdvRVRveDVZUjZnZDdV?=
 =?utf-8?B?cERXZk5FVzZ3Tnh5UWNTaElDaE1UTWwyN3F6RzQ0M05yMU5WZWJzM0lZSFZD?=
 =?utf-8?B?NTQvbitPeE5TbHh5MStwcEpPYlI4RGJHbysxMHVaNElqYlN1eXJ2cEd2REFn?=
 =?utf-8?B?YU9pSG9STmswMy9BeEh0bzlxODhuZUJlTk8xSDU2Tm9xUkxRdlZwM1RhVDZL?=
 =?utf-8?B?V25ObC9JOXU1dm4ySGw4RUs3SFBBTlJ5Mk5tZU9WSUZSazRkcG1IWmx1akZh?=
 =?utf-8?B?aXFHanp4VFArZ2VHcWFyQzFLVGI3LzRyT0w4T002YnVKSDNPOVhRUnJCYXps?=
 =?utf-8?B?UXVUOVJoN1NmWTBGZlRVSzN0ZWFDSU9saW5ZSlNZaStrMVJpNU5BVy81dlJL?=
 =?utf-8?B?TEZReGJPcUczbC9rRDBJa052bjZTVWpsWFdhOG8rSDBPaWUvTnN4c21rV0hi?=
 =?utf-8?B?dTBnWnZtblZNQUFSUTdLQTRnMERoUnUwZk4rRC8zNXI2SzdPMjREMGpuemd3?=
 =?utf-8?B?T1k2dE9lZy9DMEIrb2M5bEtIMzdVN3FPSzNGdmw0dGgzdVlqS1hqMXVBMUY3?=
 =?utf-8?B?K3dBSkhlYVE4VVd3M21tUm1saDV3dmhtSHlSS1IwZXVNRG5mS1F4MC9jZDNu?=
 =?utf-8?B?ZUU0VHpxMXlBcEh6cUFpSnRER0dyekszVkEyMUF3ell6MTRMM2NLeE8wUFdr?=
 =?utf-8?B?YlVPZ0xuWkFjSlFnaE5ldDk1SU9SSVhzN3BZRzQ4YkMzdjkwWUJUbXNjcHlP?=
 =?utf-8?B?OCtDUlBMeEdVWTk2RTBUTzA5VHhRQXlmcUpkeFpWVmtib3hvUnFjNHFIMHd4?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35A5BE541FED20498986725A9B1D21C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833d8e9d-58ef-4a1b-9152-08dc4d81d980
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:45:27.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EL1eOBCAAH7D94JQqBO9dbKTIB1LMkM6hvfSx1zVkbeNybefZndtsulvMOp7u9r3d9TWCs8HvY+FSrtpbZFBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjQ2ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEFkZCBhIGhlbHBlciBmdW5jdGlvbiB0byB3cml0ZSB0byBhIFRELXNjb3BlIG1ldGFk
YXRhIGZpZWxkIGFuZCB1c2UgaXQNCj4gdG8gc2V0IE5PVElGWV9FTkFCTEVTLg0KPiANCj4gVGhl
IGhlbHBlciBmdW5jdGlvbiB3aWxsIGJlIHBhaXJlZCB3aXRoIHRkZ192bV9yZCgpIGFuZCB3aWxs
IGJlIHVzZWQgdG8NCj4gbWFuaXB1bGF0ZSBvdGhlciBtZXRhZGF0YSBmaWVsZHMsIG5vdCBqdXN0
IE5PVElGWV9FTkFCTEVTLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92
IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiANCg0KUmV2aWV3ZWQtYnk6IEth
aSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==

