Return-Path: <linux-kernel+bounces-147753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C557C8A789A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC55282F25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4B13A885;
	Tue, 16 Apr 2024 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUlXY7VX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F136EB44
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310304; cv=fail; b=nr9cHvx82vgDvxfPxH1PRIYmlflLz7osHErqSEOmZ7fVKuAem9fMcG3OawKpxcAxLHzbr3jpSV9Wh9Io7SWrxaiymePd5FsmxPT+nnJ6xqN9FohCoW7W5XrDX+nQoz8RK3BQI1SEXri/xoAtr+K6+XWJLCRJGGV8pRAUI34JpiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310304; c=relaxed/simple;
	bh=1ed1nfgp3/kwNzjvGTAVT4w558ST5GWFJ9SwJYEjSow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bonZzYfncOA5Gm/GwtxTsVtex/Zq4IccwZPIQjiI+2TN3VK4SKJeQxbIH4ruz9StnqsF5lI5qnrWRMSGeM6ttZlZMbWnQung9KBD9g/J0CpJ+prErJhD2FidXs/dHqto4W2YpjvUU6M7lHaijrY1ol2o2PECpIKwwscbd333EN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUlXY7VX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713310303; x=1744846303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ed1nfgp3/kwNzjvGTAVT4w558ST5GWFJ9SwJYEjSow=;
  b=PUlXY7VX4m5EkV/9SpQNytnBzsJxsdB5od7miOb8mW/GvVi6erRNpxId
   ujKOB7TZ81RJA89I0KZkf3KpL8EfBS9OuqJFfTIeOziZXg28iCajOlkAs
   rlw5nL5wRMQ0QvewaaAqIpSKfcOWgOR0kYZRGTNMJoEzNPzF2MB0YkylE
   /mb61gIyKO1tO4S1tXP/GtuaM0TnqvZPVwKp7+OER3MEDjo/WklnZBiOR
   CFkAjtNAQtJC7EOSOWAEsKJ4o42OYQ/o+jKc17g/jZyrcZxPTqc0E9Vc/
   9pPd1F6tErnest52yrs9xPuz2G6/vixt4s+3y6Za/CA4Z/Y+P0Pa7CfTO
   w==;
X-CSE-ConnectionGUID: eCV8+JFvSBGBgDA169AJ7w==
X-CSE-MsgGUID: fWU1G85nQUGf+2xehYXgFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26294975"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26294975"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:31:42 -0700
X-CSE-ConnectionGUID: Eybf7bmTSmqSusZGG1Licg==
X-CSE-MsgGUID: Nfydh6VRTb6xs08u6uBByQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27215693"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:31:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:31:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:31:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:31:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyM5hinDYMTeoE9/YF50rvyPs78mXRhmN0KLlyGEd0H8RHiQ/sZxCJIPHQe4AN+Q/+hNKvidYoOsYQ2sBbZMg/keyCobZjtnheLWzJS4+GzC0uOGEDgLeXcf54i8QZEA5zt/vg5LxritZsLP78YPIUL1OgaJrcFgwFRq/eoehmnVKfQH6SqmmsauKrL0ynTrkFEIcYdihDDCmzAiY8+vaqW07KIWJIFzh7kcSO89L9Y5fa5RcSvZmxMNErZ1xL8V1R4DCzrnB77S+kxpJGJabHjRYE1UBGqveT1EfCaZztdaAy2kgb2uL7+6AWGocdyH5JYxHYybDNp3RjSDsSZsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+uMZjWhxVgZAwIs8XHo3dlOqTitarF7aaUfKTKhV8I=;
 b=lkKob/SXxzp2DQTCNbXV+kmIWlB3wSFXV2vE/qjYPqUbvF494ZioWqOVswmmVwg0FGBoApZo3AhgrgdKPLQAqxXvMkd0yj3pEQtz3tDuwyBLANMW7nlZnAUSP1nkNmfaG0QXsOqu8aSGWmdzIwI/GeY47jK93jDbCWnSbPlsD3SN8DtMnnxiI4ftlyS2eeRdro/zhVO0HNQTeLs+O4zl4iP35D2G6hBhlOAvgT/LA0d6/6rDAdwtX3SDV3yyrV8Nci3vPuJQByBgvLgFuTAgFayv/ZjD5qHLk3zcHj4+twTAgQ55U7/s1FbDiE5kkI2b6KQOtGdcoHGbxx83tPMLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 16 Apr
 2024 23:31:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 23:31:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v3 00/74] New Intel CPUID families
Thread-Topic: [PATCH v3 00/74] New Intel CPUID families
Thread-Index: AQHakEPYDJtnOWnZBUeOV6oVyxrfKLFri3nQ
Date: Tue, 16 Apr 2024 23:31:34 +0000
Message-ID: <SJ1PR11MB608387ABBF42840E518B8C78FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB8061:EE_
x-ms-office365-filtering-correlation-id: 0e4d9e44-c163-4980-41bd-08dc5e6d5a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOrTpWN7v5lArGnwLP3HND04uh9GR64PLAM30on2EYUJSRCRjjKTXLF3Vf7uzDkBkoOwOhym8Poky9cOGc2pBZuFzh8okKsj6aKuPl++kLv95bhNNCE6UUuRnxxEVLKh+XvQdMD8vwj1d31THMJNqQSOplYVk2dB3cQI9FdERXnawCbvyYG6OY0vI4dEZZBFfesTxJakURa7iKcd317/QSxh3jAx0yMVG0lfcvN+fSs6JRdhbGCeuqQhGbTDbk2EOcLTmr2pQavgS18oCPh+q9O2uHPG5LZ9zvk07lEnlZGzHVuWcu147MueiDT0W1Y3ULLcLpUY8vMCl2jOWeGnooPSnecneXi+n7X6kFQqAc7aXdAVj1n7nh18VsIcMgOoInbyZx7+CmN+sStFH+xR+lWZlwy7DBFYdHlEjzTxGx50AfoihG4x8KM5aBTqaFBYOqpYgpvr3qro1rphAX0xfzt4pslxnal5mzjdumlU3+66RvBjx1EKK7NhW/qyvrXCoXt95XlHPv3eIl0yuAlflJs0zDcJl85gSuu79ANqPyfev3koOSXDyG9vQ+EbCNJcCN6QzP6bJK3Gmr3duac0fk/6+tuJL8gn/zVBR8lM7cCSiEQ8NShCB9U28DRVlDnjQqR69X7VNwG3KB36eXs8e/upPEBD9VtxmU1GSh/ILX/wDlpAFmScfcVUHjFaqm4HIG1Qqpb2JAYZXHgjOyyzHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bTQbbYaARNvyiyiNdgoTgKl6lHreHJwvg+PhNHMaEgqp/Tv0gUA5lMimXvpp?=
 =?us-ascii?Q?ze3BSqIfU91aA0IHll94PRkx6J/kHCBVmrABo5PsZLSVbCAZA+ka/vnaGzS5?=
 =?us-ascii?Q?f46GE87qBV4rIhkxcWsD63OWxW93CC+GZvX+i+uGQ5zpAGW2sO0s8nSWu+3p?=
 =?us-ascii?Q?ElQ257ot8Db0LUpVd8LcW3J/vvyndw3zje4TYLScnEMvpUMlupHjc435PLxi?=
 =?us-ascii?Q?Zy/6GMBHI2TALrtFpmuXEN0rzrOIynlsFJzCAyhf84A11EUqEfBH7y85Lxhm?=
 =?us-ascii?Q?f5iPdDBK3lNQOMdRCVLzE4pVpRjwax4FjC3yARdaZOuB5OX02e+/5ow1gxJR?=
 =?us-ascii?Q?e8r5k86OIRUbY86eBPM87/q+LF5DnMZ2yJm+frcH1kLu6Ya6d5o2Z3HIiRKl?=
 =?us-ascii?Q?5lA7uNaukq0gdpYxQl4EK0gOEWG4nEx8XiunXCA1ll7XYM7ArUsKcjU/er7F?=
 =?us-ascii?Q?R2K2BnhLlAQVQitr5A98jq0qPI3eCF6QSMbYRasRlQZ6qKtjlHPaNak/vWib?=
 =?us-ascii?Q?2I2PplzXyahczdN1e0qHX1mA1iuKqqHKm76sb/3T5cXM9949OL5QDEMObYFg?=
 =?us-ascii?Q?AZ6gpmMfYmIdFqjjxyQ02yb5I9rrQpe0N/yaKfXYytcuQu/774s5snvELtyl?=
 =?us-ascii?Q?034CgnUY90hu8IxQOq7vq44lE8CeMRceqKc3RtJQIwDqtTWz3EEc7HcofL2w?=
 =?us-ascii?Q?GEOjhupg78mXSCxtUFZKRifNRext76vY+44/JEft6SM5Qlh0Alt3Rw5Je3pG?=
 =?us-ascii?Q?7nrR1mEDYwocaKTdQz6WVh3RVh4oXsy5/oFGyF9u7+QtwjtU7COrim1doMCK?=
 =?us-ascii?Q?Iz+uWvyRNgX9kGqI4V6ZJFNqw4mackFnYJs+zyL5XSMh1GvFcoVjEjOL6CMy?=
 =?us-ascii?Q?deZrFJK8KxvKPhG2mlLwfi2Wb3EVRGHvXEEpcRv3d+KlgZY3FoUK6a+RHbot?=
 =?us-ascii?Q?C2NZW01RfXUwuCdD544FBCfetfKEACxvWWKt2zbR42ngjMsTj4wjM0Ac9oiF?=
 =?us-ascii?Q?dztEnGNlfSS4Jwzm1sTD3hxUGbPi8oLi8Ta3dSmLks4U9nea4jLPzNeZJ9jb?=
 =?us-ascii?Q?dhea4aCX+d4c7LhtC65aHW3+4K+rEuev5Pe5xYUKwF/4GCS5WrHjCVUgEfR3?=
 =?us-ascii?Q?VqMj13QSmKof5SmP3QZcOm3+xOLtduBugkobp7BOPEtEKI/Dxiah2n66LEtj?=
 =?us-ascii?Q?us9CZ0+uH6PbHnSqmxyUnkRlt78rJxcBrGAILVajgMGMcdE2YLrYhuAqygLw?=
 =?us-ascii?Q?Jt4Jj1zWRJYL3m5RHtVdMON2u0LA2Rb0mxrbYRhkijcc0+6laBB7RGjSWChg?=
 =?us-ascii?Q?MfkT24xhNcj236Td6HOaX+1m6nFJUxoYvhFA6hdImSsNYxM9faVUM1XJR2kH?=
 =?us-ascii?Q?2CS6y/xKOuiaDeypmQ8e5uiw1kcg/+8PBn1f99pJOUhvByAgGVdyohW5+JKg?=
 =?us-ascii?Q?lKVd+dJGVypekF36XtB/a55F8ynNpgXupao0XASaGQ+8aiQgd63s83xRG3ZK?=
 =?us-ascii?Q?ZRMSLQ+mNF3rzypFksdMBvYY5PkUFI51GabsvDRvYbispA9qIx5Yt9tmCWBJ?=
 =?us-ascii?Q?Egw+Nq6jfifne32YD2prk3tb84ATO5WCERd+pgwE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4d9e44-c163-4980-41bd-08dc5e6d5a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:31:34.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNA11idY1HDv9JqlwLtfA2DZS8rrwPUvmAKg0CtMhmFJUDJVvB9DdBve9g52eQ6gTwMmJGsWhmLi+8I7gIsi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-OriginatorOrg: intel.com

> Patches on tip/master as of April 16th.

Ful series also available from GIT at:

	git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git new_families

-Tony

