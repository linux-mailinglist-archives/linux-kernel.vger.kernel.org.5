Return-Path: <linux-kernel+bounces-253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED7D813E54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25747280D88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D896C6F8;
	Thu, 14 Dec 2023 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdkxChM7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F186C6DC;
	Thu, 14 Dec 2023 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702596978; x=1734132978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Rphud09FMftYRwwvObViSpJqeofEZrbMtoNlvPqX5E=;
  b=IdkxChM7EXPegFdeGuFgSGLFmLYtcMuazEKqP/5bNih9MM7l58PGKz/p
   3Znqsj6+YSaNSjbAjEcnbbCEd0UhJfyzKIdx8qvorK0mwPGNPfW+2moAg
   BCRxp0nWMwdfCmxl/1g3vaYGLn6fEoh6zsXN/s5MABwaQex4KKLU9Ilnw
   zBCZs4kq9jwUPrcXsv6MZjwmfgKVEgc7LfFnLg0p3yHLgrZ9A+yRsDyfr
   u1t9EkSI1S7zhh6VTWOistJC9rt3gUbNJGBKHPq1PNtJ2YTme+pkV6yJT
   yPU5zM7c90m/kzNU6BVRJlfTN+yCIR57AJUmGnwFq8EqcR2zQOArvAVId
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461667486"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="461667486"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105911479"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="1105911479"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 15:36:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 15:36:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 15:36:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 15:36:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTwrVLdIziPsanzkI900YA+IEjKpVRARzGxQtHF3hOwJBy5IGyEgdPn9N6oi9zJqKFocG9Ul7kYeJutdmVCesUzNZQ9P3qFE4KKwBZqMllWjX74FCA8OJxoqhA98lW61+OsSkEnMwJ59MIpL5aHovO/uwLPtm6YRxKAckmM8YO8U23ZMntcdGe6VtD643fTya/OB1XIDVGjeglBsVb6VkaPV5/q/+OjCjDCKi7u8igJVryuDqnDWmMDI76kGclH8kRU7GCRdkPV598+C2BhnDkjwVWHZCbXoXqCTZ6Qz+DGOXlv8m1MxAo2QaAQRsJ3sIxqOHeyDYz0k+uC6CwOIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EtkJ4vTKo6x5RK8rYezCJNO6qcdMEA4Wnlh7ygmbLg=;
 b=KruCoCOcnbd/uoCvM8I0YTgOBzdFuztdfKOY0JquJ5DsMNEtSKOVHczD9h8SoSkt2Og2rPy/PaQp8gtZCJSHA0fnbPuLt6qz3+HDLurJxxkoi2iYbaMnP4KDXFtq4nE82tVndIRsvan5+AgTUg1gF/AeT0tqigTtIw2CMI5i2iKvELu8gHnVSMX3ke5/aMTMjcCGkLswgYAEv+aG9RApmVwLIlB/ZmyeChVzoObiH777iE5RM8iuMxoZUcnf3DTI3Heb1zk09CyJFmGl3DVNV1Zx8r8E3TlRDTaw72TBBx5hxWupkC+BbfFoCVWZfjzioTu65CqccLNKzoMzYuReQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 23:36:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7068.038; Thu, 14 Dec 2023
 23:36:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"leoyang.li@nxp.com" <leoyang.li@nxp.com>, "luoshengwei@huawei.com"
	<luoshengwei@huawei.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RESEND v3 1/1] RAS: Report ARM processor information to
 userspace
Thread-Topic: [PATCH RESEND v3 1/1] RAS: Report ARM processor information to
 userspace
Thread-Index: AQHaLuSgz1v/s4k9/k+lw9lC4B057LCpbbIA
Date: Thu, 14 Dec 2023 23:36:12 +0000
Message-ID: <SJ1PR11MB60835CC6392CF269E296B82DFC8CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231214232330.306526-1-danielf@os.amperecomputing.com>
 <20231214232330.306526-2-danielf@os.amperecomputing.com>
In-Reply-To: <20231214232330.306526-2-danielf@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5036:EE_
x-ms-office365-filtering-correlation-id: 5735c1f9-778f-4571-ebe5-08dbfcfd7570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBLyAz9zPuz/SykD9c57JM3Yoa0yRjTstfYgJGMaixjlHLuCL2bGVXg0S0c6Acj90Aq/tSjWNNKwFxgnJu69YtxnOVWSzd4l/ez+ZuhS8W4gGv35rpPPbCB7VFiHFttxnBcvWtcZAG1VPHKnhOlRobOpyD3aQB9GaTo/1BsTQSvYNHlWKJXgew5w5uvl/JQRxh2Pi6AsOw2h+1XwW1GZxaJRKl5uuz6//n0wmzeKF3YoM46BmlXAMP5AbnRs1bthDSSvwUctJKZTiwtLdnPNNfGDGKhKVKd8tF+bP5FSqebSHwmNtTprk33hn0jIPSJdZHaoCVSRtuMw8UKgd6jwIJasvpXRTMLoff15MpYre3bDrntomsAHUTJekJf3skjGK5SaXRCGWRPz+SB18iN6mYY7yYHzUjvCa9xJx8UmkwcuCxlQOoV1D/1z5umxm/LeUMDK2TD0X41EyIRguoEBTSrgR6RYay0yL0jDi3gV3EnXvRFWqRij/Qr6PIzNJVfbnqBj4Kv2AkbxRWwG1YC5yBxfWA0dXGbRosBsbBMiaKb17akRGjEWKMfwp//farV4BhB51YuK//x9oQi4R0+hd3Caj5+fK/ZZKaNnFgsc2HZhjAwURaaye2ml4YrZydiB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(52536014)(8936002)(2906002)(4744005)(7416002)(5660300002)(38100700002)(83380400001)(33656002)(122000001)(86362001)(82960400001)(26005)(316002)(71200400001)(4326008)(66556008)(66446008)(64756008)(54906003)(110136005)(66946007)(66476007)(76116006)(921008)(41300700001)(8676002)(38070700009)(9686003)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r3GK27EUfVkqqgbcBx0AuErt5JyCpTIaj5WbWP4NWl6QzBu89MwdWjGRQXK4?=
 =?us-ascii?Q?aMOJcgBtqiRlrlVuXF+vruUrvwI45BVdmMCkt5KP+jBokaKDXtOZQs4VgrE8?=
 =?us-ascii?Q?NfFy8NlzoQ6Ft4HhE9jjh2AsV7NWu51RwA/c35euX6tpn8qrUcC6l+qXUBus?=
 =?us-ascii?Q?xkkjjLIyNdyzpDNA69l6UCmaaOEcIlR5vn77LKpKRr38xZ5VQ8OFNkKzAGeE?=
 =?us-ascii?Q?m2TEEQtx02KGwyXmg7johhmPkPQ5PDuzPnVJEsStYXwNWcJjLKv5EbkMs/gG?=
 =?us-ascii?Q?qw4zkYX+DAAOnH5bEKxyP75tYUElhrFYcQIc0zUo37cWgsJU4h61ZeB8vdwT?=
 =?us-ascii?Q?xCp9VLF0U4jY4ToZMADUZ5CBLb//GdF9Pt7vUVtcudcFUUZReFoDv2zMSkZu?=
 =?us-ascii?Q?y+xoAxh7X8HIMCfYwNHjM2iapyVHnOPErXyBoV44x86lUrNEIz30yaFBVYF+?=
 =?us-ascii?Q?DdrjUn8eWtBwBXG/+p/Y1EExKj7jpy8c2T19CiaNIrUQEhCWcMBRX67XdEsl?=
 =?us-ascii?Q?nukJZUBILz+ISZt4iCHnlro84L1VROqxu1qybqS/0BHuTz3DUt0NRTN0IR7O?=
 =?us-ascii?Q?X/P8jHBtRubt4L/u5PtJYWIC1JEls4RoHN1GlL1w5t3jaXFIJoiggeUiiSdn?=
 =?us-ascii?Q?2W9EdkZA5c1KrupUuok0nf0IAi6gyrkEBkC6vZYSDqb/Xqy7THyp2+Bo3TKz?=
 =?us-ascii?Q?CZpiGab0hV9LS6snrIZTaVoThVLq27gRQ8JRQG07pZfK1rRthsOYS2AeMW1y?=
 =?us-ascii?Q?GaC71reyUwMa6mxjcCYOGv+elSaFAv/KWAk6K/khdZvEcbBnDW9WQCFjPXtz?=
 =?us-ascii?Q?y6MzcgcKr5PMBfV90rB/N27LjNns5Ioe0hySiJfcJGO5AZfyR6puMzGIxeht?=
 =?us-ascii?Q?vtRfZ2Lh+6oPhEdemktFHG3ETvQZji2DDqpjAJe5yf7m+15NVjCxAF33ZVqV?=
 =?us-ascii?Q?XoVij5vuY1BsBcO3U8/ou4E7R7YUtcWKADiDyx5yHuwUL5o31xWvB8vj+aC2?=
 =?us-ascii?Q?aWrBKXlYdT6wzNfFHSE02FoaM+nryOgD/Z50cVXon0m7N86LI0XpuPPaVvNF?=
 =?us-ascii?Q?iKGhjaw3krZ9UReGFYZmw6Su7aYHyvPWtbRfOxTZBAC8S5ohpErRXMYDiCo/?=
 =?us-ascii?Q?JRiJlNyrRKvaLBBAFRQIa49nA5nOfDXZyAyhyTbWuXVNg6BoBEk5B/Ml/LuJ?=
 =?us-ascii?Q?O/B6re7sJlnYOCfH+YPG0tlcOAYvFPcou6agwsAwbNsi9AZqPsRrneNthhKs?=
 =?us-ascii?Q?g7Fof6a5A2YhupxxNlk6Jzj1BvBCQcgxV0Guf/ylMHHVLrxaAYQD3OLhHbzH?=
 =?us-ascii?Q?FJ2E3iT8ra0XPFV0+6W5vb/ODqphEY8wPsdjpbZ7F2ktRSb+XFqMhgjNXCZO?=
 =?us-ascii?Q?dzKoiBEGHGdYNkrKuowgoXVD2xEvKaZTsAGgLj8SghuRqQMI+jZsYOcT4/8i?=
 =?us-ascii?Q?ukhfVsUDe53hLqMTozDv0eoOAu927I8a8jpnEOQvaTMElGg02bemELlXTyjv?=
 =?us-ascii?Q?StWS33r8n1/DZEpJTJvetCgGCB6c2gVJyvoOSQDtSlREV533htPVE4/m0YEy?=
 =?us-ascii?Q?pATIIng+ZeLhrpaw2GA7Hbr4aUoVTKO/cAG/sioP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5735c1f9-778f-4571-ebe5-08dbfcfd7570
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 23:36:12.9963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tL3zYXzmA2wtJn3c4s6r1AVZukxh/jDcwx9N2jWcRnrderRlzHDEZA9IZc09jrJmz4nhncmowKXX2oEgtJhe2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com

>  drivers/acpi/apei/ghes.c |  3 +--
>  drivers/ras/ras.c        | 46 ++++++++++++++++++++++++++++++++++++--
>  include/linux/ras.h      | 15 +++++++++++--
>  include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 101 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index 95540ea8dd9d..2a7f424d59b9 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -21,9 +21,51 @@ void log_non_standard_event(const guid_t *sec_type, co=
nst guid_t *fru_id,
>       trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len)=
;
>  }
>
> -void log_arm_hw_error(struct cper_sec_proc_arm *err)
> +void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
>  {

What GIT tree is this patch based on? I don't see this log_arm_hw_error()
function in drivers/ras/ras.c upstream, or in intel-next.

Should ARM specific code like this be in a file with "arm" in its name? Or =
at least
be inside some #ifdef CONFIG_ARM.

-Tony

