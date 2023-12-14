Return-Path: <linux-kernel+bounces-255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12016813E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FAB1C21F36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E0D6C6FF;
	Thu, 14 Dec 2023 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4zMLgnB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6376C6CC;
	Thu, 14 Dec 2023 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702597141; x=1734133141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=29IaCz9ZchpYFzcltR/VW98lVxxGxk7hyyJknbptWIU=;
  b=l4zMLgnBbd9wLQgg3zakpc5anOc+Y+CbdOfrz/edJBP8Kc+8cx1IIyI6
   oafbyyXwWCH9DpCwiE8V5UA00n53yMDu20fIsDVMzSoQe1mK9PdaplDj4
   XYJH6gKGC+snIXt6MX86N58/5DnbjYTWDmD4ulb86+8Q0H8x5nFxr2y81
   1Ow4Ai5ihG7UlSczb9e9two13gQLvbrcUH0nu3iWb9W1oEoozRT6hclYt
   zVXS84WM/XKLvjzSVG5AIxbD9vOVodBwD20pgnLo/FI3kwVqAu6FU+5y0
   dmfcCdDfgWXHmhlP4lqcSFjYSFFYIO8rQEHss5iwyCxKyy+jYyyvb/qrj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461667931"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="461667931"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:38:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105911740"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="1105911740"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 15:38:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 15:38:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 15:38:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 15:38:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 15:38:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rza693sXgFeOh/BRqi0xHd8vOhKeKJqNhyi0ypYglJYlhxgT8yYNw94gSH+gt0eN3+l+stjEBy4Z3wrCsSeaVgMOg+b/wwma57/cDFb0yDzoA/3asiXPWfJ6YrWYhEPCuqx+AQV+zJuBXFX2dlinmhpLemgZhMetBz9u25+DogsIMMR0M1e/iknySIPqsn9KwYH5FhcMxHoWvNW8GgQL8/60neAEg6kVx4gczoPtGb9H1lMqV8TzH3SADdsuRt1D5326wVq5fxWTXL+Ge2GMz34w3pXILhjjbsW9IZZeJLvl5gci7xhAehHLvuYMnfLCpLqVJi+kNZ8GkP2vfiMjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29IaCz9ZchpYFzcltR/VW98lVxxGxk7hyyJknbptWIU=;
 b=ElklXEv2uK9X3DM/iioqUMYvaL4UvU7s9DKI0/Lvv0Ow556xF6xG2BOK2g1OSo5Hw10PWlt8xRBoeVf0xs6gCOsO2WRsQ2RAfTJjC+5hMz8LG4mzIMQh4khxY8O6b5bADRyuDsznUbL6dvVJHuYkTuK5+KYIf1Lq0GfqUoy99NFR4DJlbRzmuYjdqkzNahfm02bY+ICU9uhqdeuokttedXrCQEtLs9xfdBN27j7NoLXCJDQAa10oToEy0Rd2nByh8c4410+sHiQ44AqhxQwcsHkDRx9COvAfn5EnLVYyYUViGZYZyiLUi9/RfCa9Bnaw3ml4lMvp25zLUIz/q1t9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 23:38:54 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7068.038; Thu, 14 Dec 2023
 23:38:54 +0000
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
Thread-Index: AQHaLuSgz1v/s4k9/k+lw9lC4B057LCpbbIAgAABRyA=
Date: Thu, 14 Dec 2023 23:38:54 +0000
Message-ID: <SJ1PR11MB6083B5E20BC27786F26FA745FC8CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231214232330.306526-1-danielf@os.amperecomputing.com>
 <20231214232330.306526-2-danielf@os.amperecomputing.com>
 <SJ1PR11MB60835CC6392CF269E296B82DFC8CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835CC6392CF269E296B82DFC8CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5036:EE_
x-ms-office365-filtering-correlation-id: de218ac3-4504-4011-42cf-08dbfcfdd59c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d8GWhwBqrlpLMcnaSawBCVb9HfeU4eWQu6IcbImQqrRTRmRImmgfy39Y8g3gFunZ3UR3xDEmGUxpPuebXk8m3J6PnEbxA5Rgt+7VvS8bZeHLqY/205gcHJBLOjW8Z+Jv08GEoedC+SBuKej0izxDCM38v4eVeNQKgEMa5sf6XNBY6CbL1U4gkyPAocQ8z0MbGVaZt2AiyAGhqHoCS6LRw5gUTiwM2XIUmg/Q1i50JiBUw3XSjMHJsU3JKHvhhBdtTBf/zOfuse/tCrQmw1QdRjzsP8cUAC0DYlWnvxL0KGcYFL/lC/pgIYEl4jvTRhGRfpUohbVo9B2SngIkQzS7K5ufbes4pAtty8Ww7OD5SBSk0nj1gt3WfYPYNoJ5iKf+1jxYS6m7Akq9xaZejQ6tXea3GpowJie70LDc1oFBgRSrlAbF2Be3S46Itdrdqy5L32tDS/Q+2ws2ob7aFqpv43zzUP0NqmSD+oYDT0aWeME+IORNIbrWguADG6CfSUcnzo3ng9w4hJWhJEcZx3UEmBer+pvxs9wzSJdDhvYyj9+xNt4dEhRUobHQS5/pXUq6gnfTw3CD47a0RWKiPpa1QyDLE02nLojCVqgYaTfYZMdmIDumVaNyPxGgO54HLM4KRKss/2Td8BSD79TQXGb8bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(52536014)(8936002)(2906002)(4744005)(7416002)(5660300002)(38100700002)(33656002)(122000001)(86362001)(82960400001)(26005)(316002)(2940100002)(71200400001)(4326008)(66556008)(66446008)(64756008)(54906003)(110136005)(66946007)(66476007)(76116006)(921008)(41300700001)(8676002)(38070700009)(9686003)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3f+e/RECJiL+P8HRAbasPq2PUJ9tt7U1cLcx8QRlCqe+pzcHWjzYCrIZOT7y?=
 =?us-ascii?Q?x49+pVPQr2w+1z0ON4tApzapQQYziRAHAh7ZcWBjRMcHzqfuN//dhx9zgbKp?=
 =?us-ascii?Q?V9NByCM34fGy7/Y8Szd3veeLFqwJtlDP8ZMzSoX/WI0ce0P86GISA01vrBjR?=
 =?us-ascii?Q?pWmdj+658OQEvj99wEKoaCkrl52l1IvaTMNMmTbPCGeT12t/irVMhi7almKV?=
 =?us-ascii?Q?QGhNIHMXFfubCtoS6GT8DcXFd4oYF/ot8Eo+QxZyIkcy04jqNTutpaqtiNCJ?=
 =?us-ascii?Q?9yJAGpcc9hN+POWI93p2IyeRDLXihzSe16wHuXCGqt1yAgzXEwFMKdcQWkHw?=
 =?us-ascii?Q?hThIjfURMP2YmyR8LxbEG0g6GSqNVttRCVBC2GsKX1JMcFdk9As5HlSCGW0M?=
 =?us-ascii?Q?M/RFWwj876yK2SIAWrhxKU09lqalmuReBb5Gl9tn4UmRvai43x8aMjvdOH1d?=
 =?us-ascii?Q?jbu0etjPtiQIPzoUTkHcqtw1BO2gQgiubBaeMdsn3faJknbOE+Go8ofReqcT?=
 =?us-ascii?Q?5UeeZZUfYvzzuL5+zderlX0PdP/rg8/nm+i8cwmW4HXRtmCezQQEsjl+qa73?=
 =?us-ascii?Q?TBw2xwTQEFIUMtBlMNedMA/J4UhBq0lX32fapWv+2S1XMK5ZLgmXKjobUQNY?=
 =?us-ascii?Q?hvc/s2dEVMpOOCwOflqZtSamTBvFZ9U2z23gRO7VVtbsp3j+61AwNd/G7X/K?=
 =?us-ascii?Q?5ZDcR+hfFWKbibRVUwwvLIaGvE+j+w13wUq/2C+b8ni+ITFZUxPjYMj4nVyC?=
 =?us-ascii?Q?vRJFfuRlxtL3koxdCjS3NpB2XS/mUSgpQ0ozP3B6w9N0pwAqqC81S3G+6DXX?=
 =?us-ascii?Q?SRarJq6sJUG8MiVy6A/wn2EW9spYC2SXFVtR9Qvz7ZsvPTCPTvExzBuyLM7d?=
 =?us-ascii?Q?UAemnp6zpRO4zhckt2TPA78ZvMoQul7S9sqM2ck+RQPsCMpmmRt9SWbKamQW?=
 =?us-ascii?Q?lKrT3wXH2LXslvQba2AOlPUBEcSOPdAzWIq01oSIHFGxvmX3/IcqpmJXUIzp?=
 =?us-ascii?Q?a49/Gu90LA36nXSiZikupTIDhjk6G0zhlHRi6q4hB+AcOP1jF3Amp+6Me9Zo?=
 =?us-ascii?Q?4Ueyo57vg0Nj74AsdAygt0qOnIlKBnLTbir2QC2oS3ciwWqDIjNvo0Q00OLD?=
 =?us-ascii?Q?678hK/86JMmhhFsv2AJpkKddRH0l7I8r+y4Og4sNNLYuBs3Qe5kzixOfrqTv?=
 =?us-ascii?Q?o5E0qsaWaw1P8uhcCEJ3pjldq7g3Nq0/WJ8Q0FDc+X5a99LutZwMJnXnO2P/?=
 =?us-ascii?Q?RfNAfoGr+z3NIx14OJWPYeR8WchS7r5pQKQmWoVzyAdBQoZSaC1hC64n1a4d?=
 =?us-ascii?Q?urIj7ruLhWlYiwA5SynuhpZu0qXcDoggZ7IvLb63kQtZRE9TAGDu1P+Okxqu?=
 =?us-ascii?Q?92YfmqykDSdDEaggkSjpPVwbt8YLlkjlNr7YLyf4y+LgMY0MNJUQHB567pjB?=
 =?us-ascii?Q?64TO73aKnBEq4evnYyglfTRl8UXT/ECvl7mktji/3rclPyG+ulv56dQsus6N?=
 =?us-ascii?Q?UvwZ7AT0ntHGbQWmHm0oiedPphBtXhYp94hJveZpFlrcN0UGN8/QDTYoW1XO?=
 =?us-ascii?Q?uHFDmd4YLTzpcCmkVIN/IyhyH5ypX52pNbT2av5N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de218ac3-4504-4011-42cf-08dbfcfdd59c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 23:38:54.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjdqRHBHRARwZfzZB3GdB5TbNt41Y4C1yAA7+bfra4vaWCx73DR32o/OF8pe8SU1o/tcj8aGzP/YrZajrynpyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com

> What GIT tree is this patch based on? I don't see this log_arm_hw_error()
> function in drivers/ras/ras.c upstream, or in intel-next.

Thirty seconds after hitting SEND, I see I was looking at the wrong GIT tre=
e. This
code is based on upstream. Ooops.

> Should ARM specific code like this be in a file with "arm" in its name? O=
r at least
> be inside some #ifdef CONFIG_ARM.

But I stand by this part.

-Tony

