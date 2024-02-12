Return-Path: <linux-kernel+bounces-62012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8679851A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6A8B24033
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AA3D994;
	Mon, 12 Feb 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ER+eeoCX"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2E3D969;
	Mon, 12 Feb 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756775; cv=fail; b=D7U+Tcq/hmazMFp4f8Pr0lhsXtfISRsiWSLmmhBkaWkLwmMataouwCKcEJFk7Qj9m4d5cj0knuxw+WvDSjAb/4D//SevZKSfyK4RoiGoO0OoJkRYs0eI6A+Yb6CqcB9PSgoS29Bj5DBQ8VvaKxHA1nBgYRdYpQJTr1L6K8x9ky0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756775; c=relaxed/simple;
	bh=wIlqSmcs9ffa/NDsHBWyNHfU5D34O5syqWpyNuVIe8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lz3hQRJ0WQhoKbB+BzwqwoQ2yXCWHLTNRptnWZZmuQ+gWBCfoxxvUgBvh6U3HjfcQdLWAZ5FKJpsMXfrj2vSDP7PXwm3YEV3JWcNg0EmpA98FUdGVOvmZM8/CPF+DqV0/Lc0q+0kvGDpTdo3koMDQigWxG/tHMTPCAfhp7mxEbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ER+eeoCX; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707756773; x=1739292773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wIlqSmcs9ffa/NDsHBWyNHfU5D34O5syqWpyNuVIe8A=;
  b=ER+eeoCXoyTAYAIilwhgVkqIzX+/naVf1pRnP+CtXKtxOPz2LulD2nDZ
   TDjEIwlzN6i4dArJ9G8kn/I7mc9zCQvXi1zgf2tmxJ7ajEoiZHcN6zxF4
   TDWblLcDlpg3+i3h7T6nkHtz4sGqaFOZ9gIcb64LsXCL8p0a2UgRRGoYU
   dEPWP5iB+YVDOwkg0HZopNhzHLiH4InHAD5jWKw3IULlq0Lx6A4GdgmXZ
   dDWP2nHaScbwQ5zsdTmFUzDvDcgcWQX141Ut6Gqwoi2KOWSK5sIJRTcMK
   YR9FsVw9uSowK1WIuRqLSRgDGktDN0o4HnInXZ5X/e9U6gnhtXRASpzIk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396174771"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="396174771"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="2638930"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 08:52:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 08:52:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 08:52:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 08:52:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnzDdCBPj1aCoN6cyq+dG7PLgNpdvqMLkOpcnWgQ3p75B3XhglbLQZU9bxbWSIpL+A+V1gQibh0fID6tkPTBHhXmBdIViPqfVOkuV9zh3wHckhczYn3VU0oNZblLLsOLwd7ixjSFh2W7LIWf30gH/sMZDnxXg5WKZu4vQQepEETOUo3BByDISmIOU/Wzlz+Rf5WvXgOJqdntXZOHcOoSO8zn6LTNuper8K5yjMd/0LBxmGdtm4JaES2bsb9rAKq2olyvgjvH8I4tjfwp683/eezkuaBe6YM9c7JTMpjLTqr0ez9gEJzgIKSM3+cK8Uyti04mXwB88Uem2eliyTP1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIlqSmcs9ffa/NDsHBWyNHfU5D34O5syqWpyNuVIe8A=;
 b=Ni8wr/fnKIs0CnJ67i2/TYDMfuE4DRDLRMgcm3TCEdmI8mM/yfZs5Vk2oXatdTM+PLxKXdsnduQTGfVpOgBsbrXH47TckMIlHSpG6v4bBVn0L8yg9VPqx95GCnPBbO2NITccmEaO8k649tmg0EZ5mBO6nuupgbkp2xvhaLarU7IAeWWKGEn/5uAli2dtu3wRskVc4pssktb48Mcj+8HcPj+5SCP1Wvkn7OdriWjETk6EZBW+B9fAv4aei/McmqubE/e6oYOXQgLz7mxECuNnSjTWjBN5sHX63Ug1pfbICPjeQAt1cwYPStVXJZBpEFx6SLRq6OwHY9pmuz3dZXyQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Mon, 12 Feb
 2024 16:52:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 16:52:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Topic: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Index: AQHaU8qTZyE779HfV0Os6ryGu61IgLECMYcAgABGHaKAAB4egIAAAUhggAAMp4CAABNrkIAAEZaAgAQ1S2A=
Date: Mon, 12 Feb 2024 16:52:49 +0000
Message-ID: <SJ1PR11MB608378D1304224D9E8A9016FFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
 <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
 <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
 <SJ1PR11MB6083D539920A888F93902954FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <59944211-d34a-4ba3-a1de-095822c0b3f0@intel.com>
 <SJ1PR11MB60834D4876A8147286FB2284FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <70a433e1-eed1-4056-89de-92c614b45a0f@intel.com>
In-Reply-To: <70a433e1-eed1-4056-89de-92c614b45a0f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB8109:EE_
x-ms-office365-filtering-correlation-id: 1e8853f1-ceda-4df3-c78f-08dc2beb0bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82hvshpkMAaJExD8D7eYeQZdWanAlZK5GkGIPwhAJt1yIIqgUgBXpizt/bgzPjN+je8Ztuq7nyXyc/AkXX+1N2O+M8cTkUzSRWSwQb4jXjblxI8Ouknw60AIfwuSCDzxi8LaHxIiQ7uR99wiAIcCpAXo1tHBuc167bwOBTIsscbfOL4Hm4049GsLyZshZJBg84XWBp53N/oG5ctvWd2RzTIFsEMqkIOxE5Hx2T8QAcbw6NUhmQV7tvlWjIcn8B5ZVo8b38uvC3pTen/DN4qIusfZY2C9unswwYE8W6lAFmTVRFtgSlWvRzqQpM5rfqs07gKx8sCCy5vLI5mj/7SchL0PeVai/r6zujCnlYG//NO5gYE/9vIB3GlpIe4b68QQUEPRRYsED3MaJQHIMBBlCF5cZbVz5AlX0c3XIWGZ4yeihUz4tGnNY6SjeDRQVQia62C2ENEGvD1jL5w2rnj70MUHEx7vxpxjeuLg5deyr/AZbr5jfWEiTgRMELjVXgkosuTJzWLR63bvK/7LZQaXyshrQOUsNQM89c9b8Y9kLRJIPftUYGNXfD5jRt6OQ4zxaVpL5brYOJyNad4Q8DnurrEAgsMmgZv3gD6gfqIl1TZ6Y29JAHCmm0DabLTnphjR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(2906002)(7416002)(41300700001)(478600001)(64756008)(38070700009)(5660300002)(6506007)(66556008)(71200400001)(52536014)(8936002)(66476007)(8676002)(66446008)(4326008)(66946007)(26005)(33656002)(76116006)(122000001)(66899024)(316002)(9686003)(7696005)(54906003)(110136005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STF5NUhmUFV1cHR0cExueDVBaHZjaCtKZGJzUUd3enlIUWhIYktFWmxtWlkw?=
 =?utf-8?B?Q1RyM1ZsckRIQ1dOekpkeVlzZGI4dDFrQlB5dklKYkdyNWdqVjJDRzdObnFI?=
 =?utf-8?B?eWYxdHdOZEVoUC90SmtCNklMb2t4aCtyU0tSdTgwVkF4b2RVNHpTejM3ckJQ?=
 =?utf-8?B?SWR2RU82aCtoMTUwNGdjTlBISzhESUIvNjdqK1psWDh3SjBoa000a3BkV3Zi?=
 =?utf-8?B?NGxicVM3VmZCK256RE5iMnRlUm1LQWtoWUx4L21UY2lITHhubFlwcUdLbHFF?=
 =?utf-8?B?K0xkdytYcnZWeGVqRUdURXhDSjdTUUFZcUxZUmdxYlA3QzJOWVRFb3VUdnV2?=
 =?utf-8?B?c2Q5L3NCZndXQWlGTzJPSVVoUTNWVUZZQkY4RkhEU2lXd3haKzQ3ZTVEclRW?=
 =?utf-8?B?c2d0d2NrcGdpZHk3ZVpVbG1md2lIc3N5dTFSNEdwQldhWVBsOE9EczdQVzV4?=
 =?utf-8?B?a2UwbW9FYmlQZm5wZ0F0WDFwY0h3blY3RnBDOXZJK2RpcUNwcnhVWWdXQzFj?=
 =?utf-8?B?Vk94Z2tYemhMREdOUkRzNFZjdmwxMjBpdTBZNjQ4cEFVZVhLM0QvNy8vbm9C?=
 =?utf-8?B?QTQ2ZjBBcHBUeEdwMnlsaURtMHF3dlU2bFBZSGYxOW9sdCtNcjlWbkZSUWlE?=
 =?utf-8?B?cVdmQW03RzdXWUM4dDgyZEVnSDcreitBRXpieEkycWlmRytrL1pBUEJFYjRC?=
 =?utf-8?B?M0VCMkQ4QlJSV0lsTmNsOXBJNFJDTEYrTVJPTmV5dHl1bFdZcnUySW5XTiti?=
 =?utf-8?B?cUNRMXcrYWk5OGxQcmU5L0RvWlRGRmlyU01FeEdlNXM0b3NRQ0RtOWJjUkZO?=
 =?utf-8?B?c2dQVkpwRVVxVXVvUXA4QlVSVlhQVEFYWXRRRm5WSUYxUDFTQzlldnlvNm05?=
 =?utf-8?B?Z0cyejM0TG4vRGUzTmFwUWsxcTFXUTNnWENHSjhEWlNLbitoempoMm54L1h2?=
 =?utf-8?B?L2JZbmxjN1drMzh4a3NISnR3SWJKR3RPVmFiTGU4Rk9WaktmdUZUYld0alZa?=
 =?utf-8?B?NjhJUzRpTUdwWDk3Qi9JbWl1ak9jRzEwOHZNUnpJUzlQT0p5Z0JIVXBHSUJz?=
 =?utf-8?B?ZC9ScmRpMVFoK2h0bkczUGRuZjZ5aytKZWZhbGhjUW93bVNVSTJFN3U4dE0z?=
 =?utf-8?B?VUxBQjQ3MUpKcVFjQm1KWG5qeEk5Vi93ZEdGNEtWSllhUUg3UHpQbGFWWHVB?=
 =?utf-8?B?V0llRytmVHlsMGVENkVZc3c0VSs3RXlwRGhJalYvZXMyK3Z3eFpNemxkUTNu?=
 =?utf-8?B?TUF3aFNTTUNpK2FaajV3VWVaMjJMb2Z0WGFjYXBZeG8rYUJDTytxN09rdVp1?=
 =?utf-8?B?aWRwWUdjcEl0bnlvZWZJMk1HR2pFS2UxbWt0MXkxUlhkL1I1YU5jZENTTWha?=
 =?utf-8?B?Q3JGc2pxU2kzMG5jRVNHam5mQllDbDhFaVhqdHFyTlF2Q0FubGl4WXQwckpl?=
 =?utf-8?B?L254SXJtb0R6MGtFWWJvSGxKRWRqbWpITWZNTlp4SERCR1l0Zjd2YzJraG9B?=
 =?utf-8?B?SXh6RXZXMVRST3NSYWJ5emZtWnpFanhGTDAvTW56MlNxOFFPWklJa25uS0Zi?=
 =?utf-8?B?bDBxdG54TVVneEtYNE56dUl2L2pwbEpBYVBWT0cxdzVWZ3VaeTdHNTJQYWNZ?=
 =?utf-8?B?Z01OT2dOSmhhTFk3Y0FIaWNDNStLNTQ5SnVMTTlycmMwNGpZWnFITS9hNS9y?=
 =?utf-8?B?VU5iOWg2YkZkakxxaS91MkJ5RnJ2OW1EVjkyRVg4OUFKeFBZMXZBZFc2cnRB?=
 =?utf-8?B?WGZZbGlHQjlQQjNNczVwSWdiV083MDlxUmtXTDBsRFUwYkVSSHJnSC93dlNX?=
 =?utf-8?B?UDVIQklEUGlucm9Ba0QwbHE5bm1NWHA1UzE1TWlqV09FS0IwS0FFVWtXOGRv?=
 =?utf-8?B?dytvWnlmMk1NRWI1WHlXRTNJVkRTdTRORFJyOTNaQktjdzFvOXlhQ0JmOG9s?=
 =?utf-8?B?eU85elNPSEd5NCs0WG82WEFvQ2NwRXcwcXdidW5PZEdVSXNBS0Z5OVFpQy80?=
 =?utf-8?B?cFhGRHNyN3htTFdjOWo1YUcwRU9EMHorSTE2UGZVMXI5VHpWYmRNVWxuVFUw?=
 =?utf-8?B?YXlOOXNQZG1uNUl5OFJWK1hlYTdrbm80OGQrVGJvajhyZWE4NDdpam0wSjdC?=
 =?utf-8?Q?wn5sQ4p4uK8UPp8iU3HJA3Qyh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8853f1-ceda-4df3-c78f-08dc2beb0bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 16:52:49.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UOJJ2zLki9p/b36oseuzSWTkVk1bAcM2yf6Q7LKEpuAZq2ykDtpBDY6blDRXQenEKXZILw/xAHjDnVwR18NUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com

PiA+PiBJIGFjdHVhbGx5IGhhZCBzcGVjaWZpYyBwb2ludHMgdGhhdCB0aGlzIHJlc3BvbnNlIGFs
c28gaWdub3Jlcy4NCj4gPj4gTGV0IG1lIHJlcGVhdCBhbmQgaGlnaGxpZ2h0IHRoZSBzYW1lIHBv
aW50czoNCj4gPj4NCj4gPj4gMSkgWW91IGNsYWltIHRoYXQgdGhpcyBzZXJpZXMgInJlbW92ZXMg
dGhlIG5lZWQgZm9yIHNlcGFyYXRlIGRvbWFpbg0KPiA+PiAgICBsaXN0cyIgLi4uIGJ1dCB0aGVu
IHRoaXMgc2VyaWVzIGRvZXMganVzdCB0aGF0IChjcmVhdGUgYSBzZXBhcmF0ZQ0KPiA+PiAgICBk
b21haW4gbGlzdCksIGJ1dCBpbiBhbiBvYmZ1c2NhdGVkIHdheSAoZHVwbGljYXRlIHRoZSByZXNv
dXJjZSB0bw0KPiA+PiAgICBoYXZlIHRoZSBtb25pdG9yaW5nIGRvbWFpbiBsaXN0IGluIHRoZXJl
KS4NCj4gPg0KPiA+IFRoYXQgd2FzIHBvb3JseSB3b3JkZWQgb24gbXkgcGFydC4gSSBzaG91bGQg
aGF2ZSBzYWlkICJyZW1vdmVzIHRoZQ0KPiA+IG5lZWQgZm9yIHNlcGFyYXRlIGRvbWFpbiBsaXN0
cyB3aXRoaW4gYSBzaW5nbGUgcmR0X3Jlc291cmNlIi4NCj4gPg0KPiA+IEFkZGluZyBhbiBleHRy
YSBkb21haW4gbGlzdCB0byBhIHJlc291cmNlIG1heSBiZSB0aGUgc3RhcnQgb2YgYSBzbGlwcGVy
eQ0KPiA+IHNsb3BlLiBXaGF0IGlmIHRoZXJlIGlzIHNvbWUgYWRkaXRpb25hbCAiTDMiLWxpa2Ug
cmVzY3RybCBvcGVyYXRpb24gdGhhdA0KPiA+IGFjdHMgYXQgdGhlIHNvY2tldCBsZXZlbCAoSW50
ZWwgaGFzIG1hZGUgcHJvZHVjdHMgd2l0aCBtdWx0aXBsZSBMMw0KPiA+IGluc3RhbmNlcyBwZXIg
c29ja2V0IGJlZm9yZSkuIFdvdWxkIHlvdSBiZSBPSyBhZGQgYSB0aGlyZCBkb21haW4NCj4gPiBs
aXN0IHRvIGV2ZXJ5IHN0cnVjdCByZHRfcmVzb3VyY2UgdG8gaGFuZGxlIHRoaXM/IE9yIHdvdWxk
IGl0IGJlIHNpbXBsZXINCj4gPiB0byBqdXN0IGFkZCBhIG5ldyByZHRfcmVzb3VyY2Ugc3RydWN0
dXJlIHdpdGggc29ja2V0IHNjb3BlZCBkb21haW5zPw0KPg0KPiBUaGlzIHNob3VsZCBub3QgYmUg
YWJvdXQgd2hhdCBpcyBzaW1wbGVzdCB0byBwYXRjaCBpbnRvIGN1cnJlbnQgcmVzY3RybC4NCg0K
SSB3YW50ZWQgdG8gb2ZmZXIgdGhpcyBpbiBjYXNlIEJvcmlzIGFsc28gdGhvdWdodCB0aGF0IHRo
ZSBwcmV2aW91cyB2ZXJzaW9uDQp3YXMgdG9vIG11Y2ggY2h1cm4gdG8gc3VwcG9ydCBhbiBvYnNj
dXJlIEludGVsLW9ubHkgKHNvIGZhcikgZmVhdHVyZS4NCg0KQnV0IGlmIHlvdSBhcmUgZ29pbmcg
dG8gTmFjayB0aGlzIG5ldyB2ZXJzaW9uIG9uIHRoZSBncm91bmRzIHRoYXQgaXQgbXVkZGllcw0K
dGhlIHdhdGVyIGFib3V0IHVzYWdlIG9mIHRoZSByZHRfZG9tYWluIHN0cnVjdHVyZSwgdGhlbiBJ
IHdpbGwgYWJhbmRvbiBpdC4NCg0KPiBUaGVyZSBpcyBubyBuZWVkIHRvIHN1cHBvcnQgYSBuZXcg
ZG9tYWluIGxpc3QgZm9yIGEgbmV3IHNjb3BlLiBUaGUgZG9tYWluDQo+IGxpc3RzIHN1cHBvcnQg
dGhlIGZ1bmN0aW9uYWxpdHk6IGNvbnRyb2wgb3IgbW9uaXRvcmluZy4gSWYgY29udHJvbCBoYXMN
Cj4gc29ja2V0IHNjb3BlIHRoZSBleGlzdGluZyBpbXBsZW1lbnRhdGlvbiBzdXBwb3J0cyB0aGF0
Lg0KPiBJZiB0aGVyZSBpcyBhbm90aGVyIG9wZXJhdGlvbiBzdXBwb3J0ZWQgYnkgYSByZXNvdXJj
ZSBhcGFydCBmcm9tDQo+IGNvbnRyb2wgb3IgbW9uaXRvcmluZyB0aGVuIHdlIGNhbiBjb25zaWRl
ciBob3cgdG8gc3VwcG9ydCBpdCB3aGVuDQo+IHdlIGtub3cgd2hhdCBpdCBpcy4gVGhhdCB3b3Vs
ZCBhbHNvIGJlIGEgZ3JlYXQgcG9pbnQgdG8gZGVjaWRlIGlmDQo+IHRoZSBzYW1lIGRhdGEgc3Ry
dWN0dXJlIHNob3VsZCBqdXN0IGdyb3cgdG8gc3VwcG9ydCBhbiBvcGVyYXRpb24gdGhhdA0KPiBu
b3QgYWxsIHJlc291cmNlcyBtYXkgc3VwcG9ydC4gVGhhdCBtYXkgZGVwZW5kIG9uIHRoZSBhbW91
bnQgb2YgZGF0YQ0KPiBuZWVkZWQgdG8gc3VwcG9ydCB0aGlzIGh5cG90aGV0aWNhbCBvcGVyYXRp
b24uDQo+DQo+ID4NCj4gPj4gMikgWW91IGNsYWltIHRoaXMgc2VyaWVzICJyZWR1Y2VzIGFtb3Vu
dCBvZiBjb2RlIGNodXJuIiwgYnV0IHRoaXMgaXMNCj4gPj4gICAgYmVjYXVzZSB0aGlzIHNlcmll
cyBrZWVwcyB1c2luZyB0aGUgc2FtZSBvcmlnaW5hbCBkYXRhIHN0cnVjdHVyZXMNCj4gPj4gICAg
Zm9yIHNlcGFyYXRlIG1vbml0b3JpbmcgYW5kIGNvbnRyb2wgdXNhZ2VzLiBUaGUgcHJldmlvdXMg
c2VyaWVzIG1hZGUNCj4gPj4gICAgYW4gZWZmb3J0IHRvIHNlcGFyYXRlIHRoZSBzdHJ1Y3R1cmVz
IGZvciB0aGUgZGlmZmVyZW50IHVzYWdlcw0KPiA+PiAgICBidXQgdGhpcyBzZXJpZXMgZG9lcyBu
b3QuIFdoYXQgbWFrZXMgaXQgb2sgaW4gdGhpcyBzZXJpZXMgdG8NCj4gPj4gICAgdXNlIHRoZSBz
YW1lIGRhdGEgc3RydWN0dXJlcyBmb3IgZGlmZmVyZW50IHVzYWdlcz8NCj4gPg0KPiA+IExlZ2Fj
eSByZXNjdHJsIGhhcyBiZWVuIHVzaW5nIHRoZSBzYW1lIHJkdF9kb21haW4gc3RydWN0dXJlIGZv
ciBib3RoDQo+ID4gdXNhZ2VzIHNpbmNlIHRoZSBkYXduIG9mIHRpbWUuIFNvIGl0IGhhcyBiZWVu
IE9LIHVwIHVudGlsIG5vdy4NCj4NCj4gVGhpcyBpcyBub3QgdGhlIHNhbWUuDQo+DQo+IExlZ2Fj
eSByZXNjdHJsIHVzZXMgdGhlIHNhbWUgZGF0YSBzdHJ1Y3R1cmUgaW4gdGhlIHNhbWUgbGlzdCBm
b3IgYm90aCBjb250cm9sDQo+IGFuZCBtb25pdG9yaW5nIHVzYWdlcyBzbyBpdCBpcyBmaW5lIHRv
IGhhdmUgYm90aCBtb25pdG9yaW5nIGFuZCBjb250cm9sIGRhdGENCj4gaW4gdGhlIGRhdGEgc3Ry
dWN0dXJlLg0KPg0KPiBXaGF0IHlvdSBhcmUgZG9pbmcgaW4gYm90aCBzb2x1dGlvbnMgaXMgdG8g
cGxhY2UgdGhlIHNhbWUgZGF0YSBzdHJ1Y3R1cmUNCj4gaW4gc2VwYXJhdGUgbGlzdHMgZm9yIGNv
bnRyb2wgYW5kIG1vbml0b3JpbmcgdXNhZ2VzLiBJbiB0aGUgb25lIGxpc3Qgb25seSB0aGUNCj4g
Y29udHJvbCBkYXRhIGlzIHVzZWQsIG9uIHRoZSBvdGhlciBvbmx5IHRoZSBtb25pdG9yaW5nIGRh
dGEgaXMgdXNlZC4NCj4NCj4gPj4gQWRkaXRpb25hbGx5Og0KPiA+Pg0KPiA+PiBSZWdhcmRpbmcg
IlZhc3QgYW1vdW50cyBvZiB0aGF0IGp1c3QgYWRkZWQgIl9tb24iIG9yICJfY3RybCIgdG8gc3Ry
dWN0dXJlDQo+ID4+IG9yIHZhcmlhYmxlIG5hbWVzLiIgLi4uIHRoYXQgaXMgYmVjYXVzZSB0aGUg
c3RydWN0dXJlcyBhcmUgYWN0dWFsbHkgc3BsaXQsDQo+ID4+IG5vPyBJdCBpcyBub3QganVzdCBy
ZW5hbWluZyBmb3IgdW5uZWNlc3NhcnkgY2h1cm4uDQo+ID4NCj4gPiBQZXJoYXBzIG5vdCAidW5u
ZWNlc3NhcnkiIGNodXJuLiBCdXQgY2VydGFpbmx5IGEgbG90IG9mIGNvZGUgY2hhbmdlIGZvcg0K
PiA+IHdoYXQgSSBwZXJjZWl2ZSBhcyB2ZXJ5IGxpdHRsZSByZWFsIGdhaW4uDQo+DQo+IG9rLiBU
aGVyZSBtYXkgYmUgbGl0dGxlIGdhaW4gd3J0IHNhdmluZyBzcGFjZS4gT25lIGNvbXBsaWNhdGlv
biB3aXRoDQo+IHRoaXMgc2luZ2xlIGRhdGEgc3RydWN0dXJlIGlzIHRoYXQgaXRzIGNvbnRlbnQg
bWF5IG9ubHkgYmUgZGVjaWRlZCBiYXNlZA0KPiBvbiB3aGljaCBsaXN0IGl0IGlzIHBhcnQgb2Yu
IEl0IHNob3VsZCBiZSBvYnZpb3VzIHRvIGRldmVsb3BlcnMgd2hlbg0KPiB3aGljaCBtZW1iZXJz
IGFyZSB2YWxpZC4gUGVyaGFwcyB0aGlzIGNhbiBiZSBhZGRyZXNzZWQgd2l0aCBjbGVhcg0KPiBk
b2N1bWVudGF0aW9uIG9mIHRoZSBkYXRhIHN0cnVjdHVyZXMuDQo+DQo+ID4NCj4gPj4gV2hhdCBp
cyB0aGUgYmVuZWZpdCBvZiBrZWVwaW5nIHRoZSBkYXRhIHN0cnVjdHVyZXMgdG8gYmUgc2hhcmVk
DQo+ID4+IGJldHdlZW4gbW9uaXRvciBhbmQgY29udHJvbCB1c2FnZXM/DQo+ID4NCj4gPiBCZW5l
Zml0IGlzIG5vIGNvZGUgY2hhbmdlcy4gQ29zdCBpcyBjb250aW51aW5nIHRvIHdhc3RlIG1lbW9y
eSB3aXRoDQo+ID4gc3RydWN0dXJlcyB0aGF0IGFyZSBzbGlnaHRseSBiaWdnZXIgdGhhbiB0aGV5
IG5lZWQgdG8gYmUuDQo+ID4NCj4gPj4gSWYgdGhlcmUgaXMgYSBiZW5lZml0IHRvIGtlZXBpbmcg
dGhlc2UgZGF0YSBzdHJ1Y3R1cmVzLCB3aHkgbm90IGp1c3QNCj4gPj4gYWRkcmVzcyB0aGlzIGFz
cGVjdCBpbiBwcmV2aW91cyBzb2x1dGlvbj8NCj4gPg0KPiA+IFRoZSBwcmV2aW91cyBzb2x1dGlv
biBldm9sdmVkIHRvIHNwbGl0dGluZyB0aGVzZSBzdHJ1Y3R1cmVzLiBCdXQgdGhpcw0KPiA+IGhh
cHBlbmVkIGluY3JlbWVudGFsbHkgKHJlbWVtYmVyIHRoYXQgYXQgYW4gZWFybHkgc3RhZ2UgdGhl
IG1vbml0b3INCj4gPiBzdHJ1Y3R1cmVzIGFsbCBnb3QgdGhlICJfbW9uIiBhZGRpdGlvbiB0byB0
aGVpciBuYW1lcywgYnV0IHRoZSBjb250cm9sDQo+ID4gc3RydWN0dXJlcyBrZXB0IHRoZSBvcmln
aW5hbCBuYW1lcykuIE9ubHkgd2hlbiBJIGdvdCB0byB0aGUgZW5kIG9mIHRoaXMNCj4gPiBwcm9j
ZXNzIGRpZCBJIGxvb2sgYXQgdGhlIG1hZ25pdHVkZSBvZiB0aGUgY2hhbmdlLg0KPg0KPiBOb3Qg
YW5zd2VyaW5nIG15IHF1ZXN0aW9uLg0KDQpJJ20gbm90IGV4YWN0bHkgc3VyZSB3aGF0ICJhc3Bl
Y3QiIHlvdSB0aG91Z2h0IGNvdWxkIGJlIGFkZHJlc3NlZCBpbiB0aGUNCnByZXZpb3VzIHNlcmll
cy4gQnV0IHRoZSBwb2ludCBpcyBtb290IG5vdy4gVGhpcyBkaXZlcnNpb24gZnJvbSB0aGUNCnNl
cmllcyBoYXMgY29tZSB0byBhIGRlYWQgZW5kLCBhbmQgSSBob3BlIHRoYXQgQm9yaXMgd2lsbCBs
b29rIGF0IHYxNA0KKGVpdGhlciBiZWZvcmUgdGhlIG5leHQgZ3JvdXAgb2YgQVJNIHBhdGNoZXMs
IG9yIGFmdGVyKS4NCg0KLVRvbnkNCg==

