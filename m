Return-Path: <linux-kernel+bounces-122004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AAB88F091
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B385B21150
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AD153561;
	Wed, 27 Mar 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/CAjhKJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4341760;
	Wed, 27 Mar 2024 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573267; cv=fail; b=MrSZDsJ8nfvikeixz+fnyAym6Q2ZEOxSxgoDZFq9Q4oggdIqsDYOCeasexqRTKxwW+AEeyhU22oyzfmcESPn8rT0YlwLgqOhOMmwip0iQ7GBL0QKwESEWzVlaXU7wMzwRlyV5WJLygkI7pXugG7KlXvFG6qRq/nYliZ6wDcEEDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573267; c=relaxed/simple;
	bh=YdFH7/Oyyje5RR9yIitGB4mH965GSEeYtJsXc9WBxD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRzKBBHlElghMNeM0uA6ypC6CwL/6lPrGPq0cEW7Y1WfnTw9l70Sb+WAJzLqGwFrOw+TBIDtx6LlPhurUqpsTe3VaXCGc6wpoGUoXbgZ9raw3JUTmuH4CxkiPdDdVbwSaiyvd2UxqWdQvUZ78dvfLeruaBuWByrOqkn+X3HWJSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/CAjhKJ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711573263; x=1743109263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YdFH7/Oyyje5RR9yIitGB4mH965GSEeYtJsXc9WBxD8=;
  b=e/CAjhKJ3X0s+gIX5ChmlqNprW6sJ+DmopcjtxdcqIdwFMH+nwyAhf/y
   32Gg+zL2IngSC3idi3NI6ngasQ0my88QnwDUGe0eXfXhTLPQaWcWtRZte
   TG0zSJzEccUx1VA9DK8UDI1Gpi9xgFNH60sW4sfNmW+yDbYXXfATxKyeW
   SKA/ykTucm3NX1bE8wRUISaXTeFrBdXQkIGWafm2ae+nEBj6hUlDQXBN+
   4uNFdiC4N2r0i8n4quAIvycpxDt+cqjsaMV48KDmAKeaFiXYAmGUPfoVS
   dgluv5xLV7rXpIUc42kRpr2NYWVHPwxEXGqpTmNn5qLogqjG9/C4h9mVh
   Q==;
X-CSE-ConnectionGUID: 9AeDS5TKTgeGBpOXM2mLeg==
X-CSE-MsgGUID: n/vCXFfsR2ex7SucaiWXuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24196266"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="24196266"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 14:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21077260"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 14:01:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 14:01:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 14:01:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 14:01:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 14:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fToqY1gXLW8K9/VEZ01rGYnvNAaphPSFy+Gtw3owUaBiypacumloeJXvxysiSS65q3FVQCQXDbFAln3M0f9J0y5GvNcJ7aG0bGWIuGh6pcmnFiGas4emDsDnMHQzWX8Ur4ef2ptnJr3c3lZoba6OZxqt+pwDFIc3N9ou42JQ/x0DWOoiSZVw+RRRdynD290p6sGgUK2/LpTXT3UR+pD/Ah0YqAnXHcydBAZCpqfveTZqcxCFjtW4kc6uot3zJfyB/KEzUSo8S812GWQ3YP1Fhy14C1ag344sPenYEbJ6/ywqtH1IdKqj0WeWRsaOAI5iDjFvMqiFOYNS7FzeGfm1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdFH7/Oyyje5RR9yIitGB4mH965GSEeYtJsXc9WBxD8=;
 b=CpPPKKrfvD47LSWjAEpIoEScOLVsZvMM4cM/S5gMbzNHUrqyPlGZyclsIBxdnd4JB6SIiCXLW9jjlPHT2QuOr/HMyowC73xzSIbV/Ldbmf8yWpiIYE+h5OruPCEZClyxKscD8fxgPiYisZNNdQYQkhRFvQZKuXuPEMi4Z+sQ9Kfx44UsUvDfqR8XSh1R3Fe5uTkJ2W8SQeWvlVlUMyYkQ62sPxuHy1GxR4TLKMht7cKCdVcX3PEbVlIdTL7y8enuk9dlhANrMjH/4jSpVdC7bBIEj5HMaUoZqD17iaBErIQWJtJFTO49avtjw0lNHM8bsXgMiTLRKELt2DyOqoUV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 21:00:57 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 21:00:57 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "avadnaik@amd.com"
	<avadnaik@amd.com>
Subject: RE: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Thread-Topic: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Thread-Index: AQHagIkwKgCz5xvk40aUpUIZKbkhBrFMEm4A
Date: Wed, 27 Mar 2024 21:00:57 +0000
Message-ID: <SJ1PR11MB608336E97400C0F06D3F90D6FC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
In-Reply-To: <20240327205435.3667588-3-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7853:EE_
x-ms-office365-filtering-correlation-id: db57510e-58fe-4708-f854-08dc4ea0ffde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9WgoBePh4/3iq8m2Gl2zAM9LJGSj0QVBgF+QkkaOVyaHohCQUdJjHH7pGTY88fLstHk2w5SQwJj97mwdD+7KS4YyIBRFC5JKz7tJ9Uhw5BhwSyqZf/3nAAQLaHz0uBYbsaaRFNLvp1FWc6eaERKU6Ve9wc8ip7O72TcDyFYPhaDIERjUPbrB8I7PK5B+/xxcFRRyGKIeIDBd+q8pGQOAEhQHAjxoNAWEpa5Gr/Ysop/IxLSWRYMa49Vjv0o9OGRcIhUofG+HQCS6MIB1XT4I5pP1MzERRnozSgWDOkpiHc2/YXji5g8V61gj2IMYx+Wd1JdbHaWNsjbbeJbGy7DDt+fu6MZZBrgJRS6nVk/FtR2MfWhdpnNHC8LWAO77orXhi1Suua6dXm+G02Mxzm4VeJ24opOjmqZSjKxSVBEH3A9No1rT6IiATvPDleJlqZBX7n3Lhb31rQv2YHX05GEkKQCJj+t8Gg0hrq3Xmx2MKrpofhAy+AKcxI3+LOE25a6RctepPjEcMPcfffWEY1iN1rtpLNd4cgeuPt89YL3SxhzWWWuo2K7RvuAlwlUqey1s48aH+wso0d7scxVyQVJbzO7P16omi+MZfCDgQ6ArRWR/y6Er32qeD1L5trcdSo6+S05poexQgztUzvN+GFeeWbGvwV8mkROKIRsvnBpreiQMscptk8w3icRO6IISDdPWMxi4BUXA5FddwRFSQzSQLyXjfHSNovSKoYxL3xDETF4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ePB2Hrb2HQFCBGAG/WWbGrk6fcy/J4Ogrip0fmMeJn0yMxit8LV9fz3UG5RX?=
 =?us-ascii?Q?ExMVrs9gsIkAaHJRfLqdetsYPfWl2PPASO0ENI8j6wcGukqUDJVj5twLm7tq?=
 =?us-ascii?Q?6jotErhbkAUuBjfyrd2pSB27pous1lfwRLESe7PhKR2c1UZOyIYnaXjrHSJn?=
 =?us-ascii?Q?+CqUb3GnlbdqKR/qVKfCj5UAIufyG5tRzozKgSILkEDSQEYoELsCE4Qut7xs?=
 =?us-ascii?Q?NFO/ou2XVgj0cI1Yl9TFWHYmMsNmF9HrM83nJ8GuaptnaVs27L2oD9eTmaqY?=
 =?us-ascii?Q?4uA1wnMTC6t2mSmb6KUrC7iUqLLgCdxF7NfgL6AF/KliTZLQTJl04jJWCq8l?=
 =?us-ascii?Q?4B2Z8njQZDpDRGdt3janRjm4CukGn+t24+0v/oCxv+3FJwWAA1rOydu9kOFp?=
 =?us-ascii?Q?tRZaowc/ZTV/EstQyHKurRC2285i/+koFGQ5YUcZl0ILv0CKy/TUGTYoKmU3?=
 =?us-ascii?Q?gNkUkFJLFkuUNkyN0hiXsVnAUriFQ6WISCpwWkmioqHqTiRhnFzPf6GgCOTO?=
 =?us-ascii?Q?fXErgivraZoD+VrYqopgwHFYMKee9GYivGzOScQa0TPDmrmmD1N20aEYMD0H?=
 =?us-ascii?Q?0kSCesFyqj2U4FpeU1t7kNFNw/YlGtaTFh++xJZ+qnHXqLtvN5vyV/t+0VoP?=
 =?us-ascii?Q?2AZPJPIAt7MC7AfC/TC6LoKU5Xbnyrm/dpenXf7BVhz/YiQ3e3pLZaEScXaU?=
 =?us-ascii?Q?CY2RQGZoLv0LCo6ePRaQj7w2P8knmzBAw82vlSOypCZKvdILDvj9St3OATwR?=
 =?us-ascii?Q?D2U2J94pzcHsy5pEyespjkzdPS5xa+iSh/3GqDjnI2yhKAlwVmw2d7vus3NI?=
 =?us-ascii?Q?16todxHjY6KA4MIqAaUjRIWOsrrx3pg+H0YnNIWt4N67pWGxMXWxU+oRsfGE?=
 =?us-ascii?Q?ALo3wTappnvweYJH3p9zELatwIBO0q4hflulquZNwRb9ssH9unk+spYggWbA?=
 =?us-ascii?Q?AollObdzHsdu1PnevktP9Cn72O6QqB8ZbhzWd7JZDNJpRc72ikEZPJpHOiJJ?=
 =?us-ascii?Q?C0twWNR2CmoCX6ddKt2bwrgS8aMtb/WhXTftdh2OwooBPtgB+a4E9kRv/dYD?=
 =?us-ascii?Q?FpljXsitGthJIqF3licVzd48p18EMcEKyFwYtejJDulpv96My8VHbqraj2qP?=
 =?us-ascii?Q?yfLCjdwB9egt0Iysyz0asgFFCF4flzCskbM5uA6qbikZ6hBNyVe4YWRWw5bT?=
 =?us-ascii?Q?9ws0bAAhdQY67HTvZJzJVbsLQxNRKQXniR8FANqQUDjorYMuhFxD2tljBd3w?=
 =?us-ascii?Q?a3iRtn2xinoweIOj5nGCkptyG3ThZ6StfD15YoeaAGTRD0FxiiO+Ej/je8uQ?=
 =?us-ascii?Q?vDZrq5/ymxwmi9XmxjiE49QXhgzO3dVUO+a2JwPpVEa6M2ee7P56wAY/ELxT?=
 =?us-ascii?Q?Upxh1B9BHhACVc6AeW8Sou3DEWvrFn2WaYE4e3LzO4YN2gK//B5PVRmNAbkm?=
 =?us-ascii?Q?vE6IWJ5W9Q08AFFH5G1Cd+0xPtFneqIRqiW3fhDN8oUPE4xMBLZg2RDm7v41?=
 =?us-ascii?Q?yJ5ex6HFifrH1Ux8jijVAbqjWeVhtgadTGba29J73F+iyhvFqu1tuS9BYfmW?=
 =?us-ascii?Q?10VGtP5bIf1CshqBi6qc2Mb6AFdXVBCAPbOmR6+3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db57510e-58fe-4708-f854-08dc4ea0ffde
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 21:00:57.4109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSZp9VZ4f4eCw+mK//Oz6oNxL/arB6jy6DVbgGzu4vtIu09mcR3zAe8/5Zd76S529Lk7t7GGNdPsutXLsbN8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com

> Export microcode version through the tracepoint to prevent ambiguity over
> the active version on the system when the MCE was received.
>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Tony Luck <tony.luck@intel.com>

