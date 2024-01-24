Return-Path: <linux-kernel+bounces-37502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DB83B0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9582A1F25C41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10D12AAC0;
	Wed, 24 Jan 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+pVhii7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78AB12A171;
	Wed, 24 Jan 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120485; cv=fail; b=kie0/AY5fV2Y1j2C/e2NXz8MJmadcpziaHMhJE5m52CwhDDdIp/pteusyESDezxqR4HrbcU7Pzau3YjmWq34Zlm9yb8V0oo7lbAmtjIPWPHKMAvk+kXMdNN8+SwMLT7Bx0anZyjeKaW2JPFiEnsD59li/WhKOXWdYWZIM70YJvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120485; c=relaxed/simple;
	bh=HkRiYT3vI3KOsUGDPdqcGO2vgfNDJfygkyLJCeaNfSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tls05q9YaZV1K5IZe3wHJG+VciZlAhAnYQNty8vn1YWUBBiz7FtxyuKkoABhGXfqFwgTehFsUsJf4iRbGya4KcK5ZG0k+eFdh+uM9uZeiPBL0TJsx7ty6jyLhx2J+mQY8i5QHIumdbgW9ljLrGDL9GopOgpdatM273CDYJnQIFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+pVhii7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706120484; x=1737656484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HkRiYT3vI3KOsUGDPdqcGO2vgfNDJfygkyLJCeaNfSk=;
  b=k+pVhii7/dpWtfrasL5GXmSEVUJNxov/Wd1lYjH5s8F8aNOSFDFaHUg5
   +Z4a1RqXQ1mk1GVK+gz9MT4z05y2SAKZmQsxXkCrxz8uwrDKDQVvjXRcO
   iZlB28BosVf7ysKqKH4hVEP0EhjucYLraYlg9fKwa0h6gTYRY1SoO0fKl
   Bzz4z/U8XdyhGmKTWhafTLKi/qIIaAENz2pQwvxQIv8emwgNtIzZnJaoI
   sS5C+ep0+p13KvyHHUGPWqmmmB8h5MhlUs/dqKQeRe1LlP85AYM/0PxrK
   amJZozBxCoOdCId0dV7AtdOERUIYd4mf33zoyYsVqfy9NPg78G8gZLuwo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15461423"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15461423"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 10:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117704550"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117704550"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 10:21:22 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 10:21:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 10:21:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 10:21:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwYt8eC1uvZ0aglyKar7tgA7OhBjvtycWV7gSrNEZ38t4iQ/X4yChSRjiZerPT2tkv+/nCwNA/+BcHbrNgSLmGzzXRKKKiw2pFcTQjZ4LL/NbJDJgvo2F8UH7YRnTn8g6IFxFro8N6fKT53jbG5S2xYlOdhoGXSLIpwGoM4IJqvtoaJkKlUfVQ7aIEoL0mphtE2hGhkrkh3EUz8pPjaLMWzHTys989dC5iJU4w5tw6BgpVd4WMIkfWZNlV08lA3Xy3N/enzT5Iuu74+uzp40zVG9iGZBAPd81RA7C6+aDGu+3ra516Zc4XatzbPc0FevOqYVM88/DE6OQZn7BqPjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkRiYT3vI3KOsUGDPdqcGO2vgfNDJfygkyLJCeaNfSk=;
 b=CFHQ1bL0LJOhH1QhldJPIa6zucsGkkoW5SpV6lky+DWr/kmggzloQYGJxM5+b+8Fcu23YD8rQUtJvYi7PFfU6YbaYis9hquc0n1oSAhfggXNfUb5xJmPef+9iXTsaDzGuhgDyLW9CxBx8sDbUYzCGGf4RZSZaXjqJu0AEFyoV3q6ajwLhUHJlzfRFTBqAmQY9BF0SpQkWv7WMcHpvyGoH4ka+SZr+/lwdqw/OQyZk2mCFr9fN1pPwzK0HE5ezFpi6iWK4r011led3WogDpDFfuBzrwvoJQaLjbQMdnmZixbLdf8egyXq18o+D3iKYIZ4kuaOCx5sszLIO/mJ/HDZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 18:21:18 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e28a:f124:d986:c1d0]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e28a:f124:d986:c1d0%4]) with mapi id 15.20.7202.027; Wed, 24 Jan 2024
 18:21:18 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "zohar@linux.ibm.com" <zohar@linux.ibm.com>, "paul@paul-moore.com"
	<paul@paul-moore.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "yaelt@google.com"
	<yaelt@google.com>, "serge@hallyn.com" <serge@hallyn.com>,
	"nichen@iscas.ac.cn" <nichen@iscas.ac.cn>, "sumit.garg@linaro.org"
	<sumit.garg@linaro.org>, "jmorris@namei.org" <jmorris@namei.org>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
Thread-Topic: [PATCH] KEYS: encrypted: Add check for strsep
Thread-Index: AQHaTojqvjVIX7LD8kG9OsZOaef/FbDpRyyA
Date: Wed, 24 Jan 2024 18:21:18 +0000
Message-ID: <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
In-Reply-To: <20231108073627.1063464-1-nichen@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CH3PR11MB8344:EE_
x-ms-office365-filtering-correlation-id: 8546bf3d-0386-4905-25b6-08dc1d094283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bxgsQd75CHlMxkBEFpYoHCKOXvBBTUBDKx5Rnh6DCmg8taQ5MpyeC/AH+EFFAW5+kzblZ0V3A8u2EuNJqtyo29ZDGANm+QE3b88oF6uvApYQWLtnYktC7RdpI8SLf5qg2wo6z+kRyz6+dIm0SfHO83N7NUlT8JREaqveoduMfpL+Yg/ZAE1Qq6WkJ8cReoixkURb/fMw8uijW1JWPZZGn62xbYdfhKCBY1Sa29pixctJQB11WnRt4tYxZQggDPpl8zOhZnEMjzOg2+p5qfnAW5oQIeH3IJBeLu25XwtDK0WhcSCB4ePYBOIJZiF7V9R8YTik+jbplP/VnrQPJEA6ZDVuID5RGfFyotnMlPh3FvAFnxwI5Y41/2skiVNNNT9xisET8ETRkeezRuO/Aqq7u/8Lcpud9P+BMzVJpnPFmFChSG6JJj/pjH/0BjIRj16YkWj269MMh6oo7ote9dQ2di61wSlkx1rrtvShv0INa2gMm7bPUy5tFFYKNv3UnsKdSHPD10KOWG6MKAPahNL2B++6ylVIRPVcI3xc5GfkEpqkGtR6kC4DPg0Vfny5aOvaPqqdhShFolKnFY37cLnirKuqavmmq+6PX7xNH1GAYdnI22HK+p08Rj9EG0cnSxOQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(110136005)(2616005)(66446008)(76116006)(66476007)(64756008)(316002)(54906003)(66556008)(66946007)(8676002)(8936002)(83380400001)(4326008)(5660300002)(6512007)(7416002)(2906002)(38100700002)(122000001)(6486002)(41300700001)(71200400001)(82960400001)(86362001)(478600001)(6506007)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3AzR1hNeGVuTkxDSDgvdk5oK01qaFRsQWp4bFRnV0J5SWM5cjFEa2FsR3M2?=
 =?utf-8?B?WTdEeHd0azhFb08rYzdIeVQzaCtSUmxscWZqV1lYVmpkd2dnMC9Za29OaThh?=
 =?utf-8?B?L2QwQTlZY3JNVysyVHNIb1dtVGxhL0ZlVGphb2pZRksyMzFaalM0ZDYvVHE0?=
 =?utf-8?B?clR1YkNSVmxiSkkyWDI4QVZJNWx0N0JzRUppZEdXaVAvUjIzN1k4UWVlbWZa?=
 =?utf-8?B?MFdqVEhvS3ZOMWxka2hheGNNVHBpdTlzTHM5OE5HOE5PMFExZHRFZmRFYW9F?=
 =?utf-8?B?WHcycC8vSXFvL0U5RkdvdXplUzFlVVljSk9IZGxCNW16V1VmU0ZGeTF5NmtI?=
 =?utf-8?B?TWdhK2dDWWliZUxSNk9nSFNYYjFFWGVpdUhFWWNpNWs3R0xOaEdpS245L2g4?=
 =?utf-8?B?b3o5ZXJOOXZrNisxNHBhbUZnSzhQZjd5TldMYkoyNnUxV0x6Z3JaaktpUmE5?=
 =?utf-8?B?aFlwTlkrRk5NS1dKc3pyT2xjTWZEa2RFcnFieWxkNUJGRHhlL1Q2cnEvT1I3?=
 =?utf-8?B?YTRZU2xFRmZTSlhkU3FmcE1sZTFEa0tMeUM1QTA1YXJ0ZFA4dTE1dFRnTjNH?=
 =?utf-8?B?RSs3aDNsYWZEeFA4RkEwNlczSVE3ZDN0NkRJQXdSbHJZZmJWcXdHL2ZNZkEy?=
 =?utf-8?B?M2p0N3YwRjVyUkVoR2dkdkJWMzduUldrNDJUYWd0UHd3eEZtUHZWaE43NnBT?=
 =?utf-8?B?SWkrVGNTckdZU0Fsc0VGTmJOWkg2OHR1cTZ6b2V5elFZRzI0Y1FXelh6dEs0?=
 =?utf-8?B?aFFwVTFmZzcybEs0cU9qZTZLTzFmdzVSREt0bVVrNUhPMFQ2aVEwQ3AyZXNo?=
 =?utf-8?B?ZUIxdlg3YWtQTVdZM21NQzd0a2lCeVlXdmQ2NXlrblVxV3hVa3NqczY5MWJI?=
 =?utf-8?B?Z0FlRE9PQmw1VlBVcjNDZ2RJRVYzZFhFK215VUpGNWwxbTNrbXRsQ0I2THlB?=
 =?utf-8?B?ZlRoZ3o4aHJFWWgvL2MyNVNGZVFFR0REMmNOY0FxVThxWnZzMml0amRnWUdi?=
 =?utf-8?B?LysxYitCaUtKR20ySktHRlpieDdabzkxVldYY1pOaWpyc0FoL2RaK1pKMjVP?=
 =?utf-8?B?WExRRURHczlYYjc4U0lqdHp1UzVOTUpneU5PV1BqU3g5VGdERU95Rk9Jakx2?=
 =?utf-8?B?eGpocU5RemRBVEJnbmpRYjZXRUthYjVJbSt6MjRVRjlxb1pYWEJIeUJ2UVRj?=
 =?utf-8?B?UytHeTdwMmcyaWpnVzZuVmFWOVJpQUZXS3FNNzJHTytRYWMyaUN6bFNreEMr?=
 =?utf-8?B?cit4Y2hUWEdSRlZValY1YW94eER3TzBlQ1kyTkdRVXJzN1JwTHMxVGZJVFg0?=
 =?utf-8?B?NWFFcmt0QVV2VVNCY0UySVo2Q3V0eXZ0cmF0QWV5ZnkxTEp5TnNlYUgwNEZ3?=
 =?utf-8?B?VVBpWHNZMDNTVDN1eWZhSzN4OU9LTDJWdnBIa2phYndPUDY5T1RsY2JuOVlZ?=
 =?utf-8?B?Ykp5NW5hbDYzc3pwK21ISFFlazhvUnFPTy9pWFNCMUE2U1lMbzBTYnhJemNi?=
 =?utf-8?B?SnRmR0FRM0Zrem5Xb2FxSHNrMHJmbWdxd1o4ZU1VMFdKN1loQzdrcDNSVVBP?=
 =?utf-8?B?eUpBYTdmNFMydVgyeU55NHZURjJVcTN5S2xyQ2o0dThVOUlpd2JBRjRhOVh3?=
 =?utf-8?B?RE5tRm5rWjBqV2QyRThGM0Z5Y01UUTlOZkZDZkNXMSttZEoyTTlkUGVUQi9V?=
 =?utf-8?B?QnpLeTM4RVFCM0J6SFRNc3Jna0dNb3pGaHlmQ1pQUlJwdmsxZkJVNjJ3eWJC?=
 =?utf-8?B?Zm56L2lZeWMvd2ZOVEN3VUdCcG8vWkxSVkxyNU1MSGNQbWFnUk1FUGFtQkNz?=
 =?utf-8?B?NlpGR3ZQNXE4TnBVc1JhdTM5dnB2R0FDZzE0U01zM3BDNEFCcGFNRE0yU0ph?=
 =?utf-8?B?ZGdVWkxKZmRXd0ZWRS9NcjRKalJHTm9VUFdSckRjSTZXTUYyL0tvd1BBMWdJ?=
 =?utf-8?B?M2tJSW9wTWtRcXBtRTRLcW41QlhnV25aTzJHUXlOVVc1ZDJ6UXp0L01QVk9P?=
 =?utf-8?B?RmVtMGgyaWZidDhRYzFVN2tQZlAzVzVTMXVvQXJDeU51T2RqTE5NWmV6VzN4?=
 =?utf-8?B?UUlUenEzL2NoOVh6Z1JsdnNDZkQzZVhrZkwrZzhIOVhUb0xSM1BWaFhkRzM2?=
 =?utf-8?B?V1RVYll5dmVxTTY2aGF1S2YzRFlKY1J1dVhWVGE2YklYaTkvSEZIMUkzZnRQ?=
 =?utf-8?Q?00vMRe50eVZzMSYYr1cg8BU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71A7C149AAE3A24895F16BFCA72BAF85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8546bf3d-0386-4905-25b6-08dc1d094283
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 18:21:18.7462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvwLEV8Qh7ocgVNniA08fxHc+0F0JHFXWNk+OTHUPSpHaZzamRYtElgOdvw0a4woGA1P+XWU4NXzK22hcpw1MiOk5+WSfttovrSSC5fL3OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDIzLTExLTA4IGF0IDA3OjM2ICswMDAwLCBDaGVuIE5pIHdyb3RlOg0KPiBBZGQg
Y2hlY2sgZm9yIHN0cnNlcCgpIGluIG9yZGVyIHRvIHRyYW5zZmVyIHRoZSBlcnJvci4NCj4gDQo+
IEZpeGVzOiBjZDNiYzA0NGFmNDggKCJLRVlTOiBlbmNyeXB0ZWQ6IEluc3RhbnRpYXRlIGtleSB3
aXRoIHVzZXItDQo+IHByb3ZpZGVkIGRlY3J5cHRlZCBkYXRhIikNCj4gU2lnbmVkLW9mZi1ieTog
Q2hlbiBOaSA8bmljaGVuQGlzY2FzLmFjLmNuPg0KPiAtLS0NCj4gwqBzZWN1cml0eS9rZXlzL2Vu
Y3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jIHwgNCArKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tleXMvZW5jcnlwdGVk
LWtleXMvZW5jcnlwdGVkLmMNCj4gYi9zZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5
cHRlZC5jDQo+IGluZGV4IDhhZjIxMzYwNjlkMi4uNzZmNTVkZDEzY2I4IDEwMDY0NA0KPiAtLS0g
YS9zZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jDQo+ICsrKyBiL3NlY3Vy
aXR5L2tleXMvZW5jcnlwdGVkLWtleXMvZW5jcnlwdGVkLmMNCj4gQEAgLTIzNyw2ICsyMzcsMTAg
QEAgc3RhdGljIGludCBkYXRhYmxvYl9wYXJzZShjaGFyICpkYXRhYmxvYiwgY29uc3QNCj4gY2hh
ciAqKmZvcm1hdCwNCj4gwqAJCQlicmVhazsNCj4gwqAJCX0NCj4gwqAJCSpkZWNyeXB0ZWRfZGF0
YSA9IHN0cnNlcCgmZGF0YWJsb2IsICIgXHQiKTsNCj4gKwkJaWYgKCEqZGVjcnlwdGVkX2RhdGEp
IHsNCj4gKwkJCXByX2luZm8oImVuY3J5cHRlZF9rZXk6IGRlY3J5cHRlZF9kYXRhIGlzDQo+IG1p
c3NpbmdcbiIpOw0KPiArCQkJYnJlYWs7DQo+ICsJCX0NCg0KSGVsbG8sDQoNClRoaXMgcGF0Y2gg
c2VlbXMgdG8gYnJlYWsga2V5cmluZyB1c2FnZSBpbiBDWEwgYW5kIE5WRElNTSwgd2l0aCB0aGUN
CiJkZWNyeXB0ZWRfZGF0YSBpcyBtaXNzaW5nIiBlcnJvciBwYXRoIGJlaW5nIGhpdC4gUmV2ZXJ0
aW5nIHRoaXMgY29tbWl0DQpmaXhlcyB0aGUgdGVzdHMuIEknbSBub3Qgc3VyZSBpZiB0aGVyZSBh
cmUgdmFsaWQgc2NlbmFyaW9zIHdoZXJlIHRoaXMgaXMNCmV4cGVjdGVkIHRvIGJlIGVtcHR5Pw0K
DQpIZXJlJ3MgYW4gc3RyYWNlIHNuaXBwZXQgb2Ygd2hlcmUgdGhlIGVycm9yIG9jY3VyczoNCg0K
ICAga2V5Y3RsKEtFWUNUTF9TRUFSQ0gsIEtFWV9TUEVDX1VTRVJfS0VZUklORywgInVzZXIiLCAi
bnZkaW1tLW1hc3RlciIsIDApID0gNzYzMDA3ODUNCiAgIG9wZW5hdChBVF9GRENXRCwgIi9zeXMv
ZGV2aWNlcy9wbGF0Zm9ybS9jeGxfYWNwaS4wL3Jvb3QwL252ZGltbS1icmlkZ2UwL25kYnVzMC9u
bWVtMC9zdGF0ZSIsIE9fUkRPTkxZfE9fQ0xPRVhFQykgPSAzDQogICByZWFkKDMsICJpZGxlXG4i
LCAxMDI0KSAgICAgICAgICAgICAgICAgPSA1DQogICBjbG9zZSgzKSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSAwDQogICBrZXljdGwoS0VZQ1RMX1NFQVJDSCwgS0VZX1NQRUNfVVNF
Ul9LRVlSSU5HLCAiZW5jcnlwdGVkIiwgIm52ZGltbTowIiwgMCkgPSAtMSBFTk9LRVkgKFJlcXVp
cmVkIGtleSBub3QgYXZhaWxhYmxlKQ0KICAgdW5hbWUoe3N5c25hbWU9IkxpbnV4Iiwgbm9kZW5h
bWU9ImZlZG9yYSIsIC4uLn0pID0gMA0KICAgbmV3ZnN0YXRhdChBVF9GRENXRCwgIi9ldGMvbmRj
dGwva2V5cy9udmRpbW1fMF9mZWRvcmEuYmxvYiIsIDB4N2ZmZjIzZmJjMjEwLCAwKSA9IC0xIEVO
T0VOVCAoTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkNCiAgIGFkZF9rZXkoImVuY3J5cHRlZCIs
ICJudmRpbW06MCIsICJuZXcgZW5jMzIgdXNlcjpudmRpbW0tbWFzdGVyIDMyIiwgMzEsIEtFWV9T
UEVDX1VTRVJfS0VZUklORykgPSAtMSBFSU5WQUwgKEludmFsaWQgYXJndW1lbnQpDQogICANCg==

