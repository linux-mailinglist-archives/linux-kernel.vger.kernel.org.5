Return-Path: <linux-kernel+bounces-100963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F887A025
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7920F1C214CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C682633;
	Wed, 13 Mar 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DruguEct"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB68182;
	Wed, 13 Mar 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289677; cv=fail; b=iKptadaCNjjgjXblZHCcLRr8SE+zkchMtFq6I2vIXRdFFka6Lc1E99Yq6s2gpVPSYyZLWFbUZ7+zMVIQf35Kq4b43SqinxnIZ4MqnXEfcE2sigQuVSWwnWmuaWU0U9pY2MAqEN9/YoWQTs150S7NDj6ZsbgT/HtcG9JwJGJkgo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289677; c=relaxed/simple;
	bh=UYcTHPYX56h8wOw5XzKB0Nzm46bC1AhZpzkfYniK+/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UtRA3k+g0sILKyGF8I91QYR4buZb1+mKapKHVj7yg+Jmrzt9+R1pjvUs0mO9vvSpIuYK3pxet+DCcfoAH6yKyBrZoNZ6m7GBdbgtV2enq0eHyvlPcVRitDpvAQiBwb1M87ZZC3g1WKNEHgTlQ9944aNWqbPSJ09CX5jmmCgnzUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DruguEct; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710289676; x=1741825676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UYcTHPYX56h8wOw5XzKB0Nzm46bC1AhZpzkfYniK+/Y=;
  b=DruguEctot+/YmvQmEccPsGfXzgFYpkQaCPOHR3IdO9AEyCp0TsOfWM3
   uR4tFKygsysoxJrNI0c1AMNYspMTdsc2K44ioxGXcALq6A2nuW7K4lGX3
   hq+U5H/ZG253rUhVw0JTb486i5r5THaeuizD1/lUC+tG6mNu+wHHXY/o9
   IPHjY6heNxO611HV/IvEXR/9K46uelmt7BPA/49lHg8CqPZEq0nUjwWCo
   f2Uo35xfQY/epcfQXuvFIMeq3L70GbZuBM9dgin27gr+bZ7JYYJbfQOAs
   eLwlEUZnabxdAgB9V1bJAVmCTPG4jGkx+L70TWuP3QGoKHZo2U+gkVB3X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4881174"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4881174"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16366760"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 17:27:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 17:27:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 17:27:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 17:27:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 17:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADASYZ5yJtiG0aLqpF4+FTqSesbnBx1oagcy2J3MlTbtiOcM5y7yAPVvEHGwnOGFUPSPnY40PtkuO/i1rlQDEAnqKiinajEVOEpbMYTsYu7o3/BKwLtFpfPGvL4OHypwb5MaX38xNHkIv7jDzJKqURIQORESO30Wp1hDohjqJGkA8YarXdaHAFxXx4C9LJkSWZ+Bo/PZDPmjTKwtRvNoi4jgffsKrhhPvHtZSJXBnzXN8mbg41qMKOSmAN5ZHxxTM+yWPYCzqzH2hGCObmhkxcrWdqdxWPSxit0Lh7jMqiapkWNw0BYXoJSvVYhBbLMPMeyLVfAJGtnPOJkWU6bdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPZXS2FobF5+VA6bbqdJ02Ysuy86Ry/SZEJotxkniXU=;
 b=kKJuci/PSDozQxAppGMamufELBfP6D4H3t5c+xCKWr2kUzUil8HRdr5E4ao496D8i/7CcKxLt8HE2dNRPMsKPwLzc2kDmwB35m/jwC0c7HPsDCiaXMJVbYUhTcbwrFlIjRn6GHNROeFf8AZV4ZAFpGL88Ifps207WQlRK0lZAjn8iB2y8MgVv2UGUVfgeWkMBT2jX2TwQWEl6kykchGkpk7754asrDH3Cvq2FZsyg1N2PLGyRQRPQ9cIjeTX5T2yi6tiIGmjp3e4H+bKI393C+YqeZHtBGwQtN1KP/l6xO9MJLbakU4/LPQHMx0UMK+CI4w73E8hpPgo3NJt1tpdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Wed, 13 Mar
 2024 00:27:45 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 00:27:45 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Andi Kleen <ak@linux.intel.com>
CC: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor,
 Perry" <perry.taylor@intel.com>, "Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v4 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
Thread-Topic: [RFC PATCH v4 1/6] perf stat: Parse and find tpebs events when
 parsing metrics to prepare for perf record sampling
Thread-Index: AQHadNf1fqMifoMxgk2kK+XRspdLP7E0yK6KgAAH8dA=
Date: Wed, 13 Mar 2024 00:27:45 +0000
Message-ID: <CO6PR11MB56356C8B9E938EBF39524C1EEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240312234921.812685-1-weilin.wang@intel.com>
	<20240312234921.812685-2-weilin.wang@intel.com>
 <87plvzm28x.fsf@linux.intel.com>
In-Reply-To: <87plvzm28x.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CYXPR11MB8755:EE_
x-ms-office365-filtering-correlation-id: a1b11d9a-71dc-4c2a-0e90-08dc42f4679d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZ1mwM8bSHgkeQDlz1NVfGyRiEOpKrXH8y37wAxz+tVF1+Fe2VC/8QsFiSOne+Rq3uTF0K8ojkq/qBVhWQjBz2+Kqk/SfEAbH0r6FlVWAKIh1jt9mZHfqi1crMbg5BFQ4y7J3Bkq1DuZ9Ctw6eBGiODqBUxUH7gMrlOjFkWPzTTmdF0ZsSlLqSFuLTAQFOB+3czFCHGYB7Jop8Rd9Q7qEo3lRNZMkmMlq9Y2/50pKJcIy/rjgdPVFJ3AUR9LHdWgtQL6zlQm+RH4WHnL0EPic1kIerROwx/QR0B/0FrarU2VeiPzTLwb1ghHEITceU/GR8XkfTNZn9avejoBsZnJdBVycVtlSF5cdxmi/yytsQ0YLxNHlucWNKucN4zFyDtXnVeBfLlDRQT1L4+DaLz3+wJQDKvdeJsqrtd1gqeFDG++lMGgxxZtaacQxydosPPXkCnAmV/M4xDzqrM3T13rX8Fd0aFmjbu9iW3jaw/Er6fBmYhDsGsAxUkMlIdaPg+eK3KhNIgtPjjtPSeEWDQMC8A3EjtoStlMJWD3y3e5VKqo3JTFO6QasGVvIakCV0V/v3LSwNzj6h123U/OpnSL/aSt4lJt68+eh5tAWRPGPOCoyjgNHwm2j1NHBvGRkc9dGFBB6bnsCF+9o8dfIoAU0AtHLj8CsYGUrx9U+Bw8jwYE0lL9wfj84BwSAFbxUT+Hsmv3LwulBA6bQrGf1QBjxEUELb4qXBqAzMiCXEPayxw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wKcLdxArGFheKWMdaODuo6kBds69RfdaE7rzwhyW6it84Wloqf76HjJoYKZ?=
 =?us-ascii?Q?uU97pwcWpX60Nu0p3atTlJAGFCPS0pgk5rnA0PC71hUjGWGHh67tipyB5SQ7?=
 =?us-ascii?Q?djzccGjT/CU5Tyj9O2CFK5ToCyezzE54nX65kuip/VFfqVJRgipWgDBijY2I?=
 =?us-ascii?Q?bfg0L1D2a/RCs8A0GTCHaQEAdvNez+6dukXhVaLWFBjdXjN+fPVFp4+NXZQR?=
 =?us-ascii?Q?ozaE1nrLa3xqfWYs+J/XHxDjad+aT87nsUTJ9K1JX8STmGrQWv7Mrfz9qf3w?=
 =?us-ascii?Q?sZ4uqcPmYuvOtm0aUtf1QYE97Y76KqQMbA0QA2FFwUYAm0UpcgGAdAzCMZW5?=
 =?us-ascii?Q?6T94m4j3x43Ko/WSroCMpe0rZZXExEjRPSMJM/NHvvP+gcrIGMknV0J0O4vT?=
 =?us-ascii?Q?LWwOQqwiDMH4eZNqc+2VNAazVWOKwDHuhGt0wkOH4EWSqNtYnu7TbdREV4xC?=
 =?us-ascii?Q?YOcXp3ouFmX8QBdMXD7vaWrjKOdTUmoGUHsUTLLwAcd/E6CTrekqQFj8JSXF?=
 =?us-ascii?Q?Bd9zT3wvueOhxmcUEq/CvW2/5B1Erqb4Vh36iZVm1hmbW3IIJLNvh8Fo7Fs2?=
 =?us-ascii?Q?GUNC4V+YW/ZiI9ez2IYK5LI3LH2iMYBZOOxZGBJIaxFcaHuwLHcaJdLlQ+hw?=
 =?us-ascii?Q?iFb+G+lMHI8oCibmCYY3C3du/XqxGp4SG9dk7qxLPAdJWAcJscWI7DOt/yLT?=
 =?us-ascii?Q?b4+AXt+StmR993GlAYp6YJdIzict12BWpffRXnLidqRvIlhWSMVN1yXDUnnr?=
 =?us-ascii?Q?2xVMhAMxMBbDbq/HXyosnrH+a5z5iJV1zi6rBDE9WKR8i0H/StF+e0GSWaT4?=
 =?us-ascii?Q?iLRABwLZobMlrKPQaGePzSDl1pe8SP9pgY88zbYlHGNcwmKSPmaqixSQ31Gw?=
 =?us-ascii?Q?Rteh0gdZJ9e2E4ktJaROjbwozS6XORpgGN26R0vBAE+yiypbe+fxUCeLmDwH?=
 =?us-ascii?Q?cuVf26/KSuIQbmdQUL6cECK42fgmRZOI0Pkvs8d4f4M25PtmLUoirX1ikAwd?=
 =?us-ascii?Q?IVSsO58nPTvebYJT/Vbje+gVXZZRLmwe9DDyAcg6qEVS6FaoagMd4OuVNHwV?=
 =?us-ascii?Q?S0KXzinzAhnU35BXiA5AUlWxP+E1d0rOhF+e8hh+TW0P5pBLcoqAjfBLPJMo?=
 =?us-ascii?Q?ahAbe0SyM+uYFlxYUN/UU5bmkRrperw/tUFf361Y8oYTxJo4ZRbZEwpj37EI?=
 =?us-ascii?Q?YLGBcmhF2PdHi6VnE4/yPQgnNc0Ulxv1eqE3UgeW/VMk1RZurS0l4oTeLBHt?=
 =?us-ascii?Q?MVmy3z7wB/zncokB7+pcZoNSA/eCWF/CJ/O8X6FLDoIiFoDCiEe3XsGL65GA?=
 =?us-ascii?Q?Yt9mPxc49SymmjdSnUgAzRasgLYDTQOO0B6A3fNvZpfeabLm70Q232Lf9k3+?=
 =?us-ascii?Q?9zt+NHB0mNJ9vJZPBQLoBP2WVuKIkEb2W/W2RRplC4hRO31GcaLWv9bZ5V/2?=
 =?us-ascii?Q?Pg94QXBNgpWUds6eEM6Zcmr2AcxbxrQU9b/eKnvFdK6Ja94LnBH86aE6UcqR?=
 =?us-ascii?Q?i/NGTZ96oqDd+3gnQYoatATPPtGOGR+gS5s5zHGoLCdAW/avVRzEt9JCtaXE?=
 =?us-ascii?Q?qcGghGmXvK+ORis9sVvMs39aFjht4E1SQRVCvUsW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b11d9a-71dc-4c2a-0e90-08dc42f4679d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 00:27:45.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rtr28u3SP18UG5sqT+yFY3n21Saf6Qh7ObjX1EOEd6ysF3pjUJNQ40XuqOrg8VjJrT8QlrO6sXFWJTT6TqKY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andi Kleen <ak@linux.intel.com>
> Sent: Tuesday, March 12, 2024 4:58 PM
> To: Wang, Weilin <weilin.wang@intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Liang
> <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt, Sama=
ntha
> <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> Subject: Re: [RFC PATCH v4 1/6] perf stat: Parse and find tpebs events wh=
en
> parsing metrics to prepare for perf record sampling
>=20
> weilin.wang@intel.com writes:
> > +
> > +			new_event->tpebs_name =3D strdup(id);
> > +			*p =3D '\0';
> > +			name =3D malloc(strlen(id) + 2);
> > +			if (!name)
> > +				return -ENOMEM;
> > +
> > +			at =3D strchr(id, '@');
> > +			if (at !=3D NULL) {
> > +				*at =3D '/';
> > +				at =3D strchr(id, '@');
> > +				*at =3D '/';
> > +				strcpy(name, id);
> > +				strcat(name, "p");
> > +			} else {
> > +				strcpy(name, id);
> > +				strcat(name, ":p");
>=20
>=20
> This seems like a buffer overflow because :p is 3 bytes including 0,
> but you only allocate + 2.
> You should really use safe string primitives, then you would have
> noticed the truncation.
>=20

I will double check and update this part.

Thanks,
Weilin

> -Andi

