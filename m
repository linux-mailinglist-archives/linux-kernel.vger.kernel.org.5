Return-Path: <linux-kernel+bounces-37682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD0783B3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E30E1F23159
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0041350FF;
	Wed, 24 Jan 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeMt1coA"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6573912BE96;
	Wed, 24 Jan 2024 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706130656; cv=fail; b=ZN8dFuC+YCnSsB/l9Jk7BmJ32zisAFrquzqa4bEuum23m2+MMuALJYH0qlxmi2U42EMezcqHkBVIH7yEWN4Dc0qvgld3NoaRO5hm9YfI4sLbXY292kcJIU45WfxBH1Wl7dB9XbyOS9hhHiB2+CfA787qlOLwIpU+/fdxWKZSwX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706130656; c=relaxed/simple;
	bh=RmCphI4qXN+MxkkC6mLtgwxpqxF7bZgGqDDS+8RpS3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkPzo3MYfoE4agxtCuM6XmAON1hOs6hTXRyHf4PsX5Aw+zxQGSw7HwN9eMMfkB1y+yRh4nPb9PTS5w0Ph0N910WEVa9Qsk/1BA6vw3drA+8YCB3ry5G6y9IUGhmycr8nC8LW4eK1QLsh/WO86g0AgxNMAxSax5taqyftFD7M+YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeMt1coA; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706130654; x=1737666654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RmCphI4qXN+MxkkC6mLtgwxpqxF7bZgGqDDS+8RpS3U=;
  b=eeMt1coAA5ew8+cu2X0UknZc1+ItdF13xnAez/5q/nQYJ0S3N/16UiYi
   3FcDCDw4tV6LR5+zOt522rZxPc39FN4LsgErl3POv+Y0N6/FpZz0WBwTE
   Tjnyz7CwVoG0goFkNMTYReD08c745R33XavvISHjQAgjXKmlixAAaTSgt
   vhwCpRPwZCObf+gz0GCPlKuHOrokXXvWO84teKdm3NIFcwPVXnYgmH+Vf
   10XaljMfNBt58Eh4XGogj5c5DSe3L+Gk7KwUTuKWh68KJKMIJiE10bi8G
   xeXXJwcg+CRfp+OSPlBv46CufLMEoli30bVdKXyS3Dx8NVY7Kv677Asw6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401625624"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401625624"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929800645"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929800645"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 13:10:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:10:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 13:10:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 13:10:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z06P59GORCx5H9Fm5gkor5KCJhcLqVJgIjIfHUN1H2JSpRocmnUJBCbGMXPuJkcDH4BNZ56xy0rFkLl5PloIM6bHEK5aSO5JylBcEymyCYkIxBzTmbB7H1isMTised5aRTtR1CtIcTenGKiYqrGUcGRAKS0ra9BExDeL1W2XOUvnL3Ue8SS2KFtivplSJHjrJ8deV23S70e9UYbfMyEkBu3Xs45yc2bgsZf6bI/07J6ksV1i6WRefG9ucT/axAOcULrpVj7523y7kvWjV1dL2lL6rA9FxPB3rpKnNr1mfX+kSPpwKAIUBEKyVNtqiz2fjo2TLKaFh+aXPNXiwzQHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmCphI4qXN+MxkkC6mLtgwxpqxF7bZgGqDDS+8RpS3U=;
 b=bem0OWssq2noh9FT1ZWCYt+cZF5Q9puGBXRGtry2FkG7NA+XqpjgvZ1NYeXeCQMaRu3HQED4xITlJ6jzlE5AjeyjpxM8GH9b2JZqaqIHtfgrt6rultN8XLXA0nydkwcmRLXSxjyw3lB3yXkOCQm99DODVkMUFjtU63mEkK8QP4xJyw+LclUXcSbAwYemz5NuTlRQYoLuHoktMo5Uox0GNefrD0ebxcWrNKe8QfqvedDtF0hyRbZU7mSv9+Kx2hZqHWhrPHFh6scA9Oh4LEz31lZB3jRN9yYiFh9JaCqHT6robI7+5ZQHv6rJiRU/26NuDi19D+84aX2r7CB4nHgCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 21:10:49 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e28a:f124:d986:c1d0]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e28a:f124:d986:c1d0%4]) with mapi id 15.20.7202.027; Wed, 24 Jan 2024
 21:10:49 +0000
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
Thread-Index: AQHaTojqvjVIX7LD8kG9OsZOaef/FbDpRyyAgAAPCQCAAA9dgIAACHCAgAAIhYA=
Date: Wed, 24 Jan 2024 21:10:49 +0000
Message-ID: <50c2fa781e3266ee8151afdef5a8659d63ca952e.camel@intel.com>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
	 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
	 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
	 <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
	 <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
In-Reply-To: <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CO6PR11MB5618:EE_
x-ms-office365-filtering-correlation-id: 918d114f-c3c5-48a9-4099-08dc1d20f07b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ex2+PjQJ8+HjmKumq9fYn1PP3obMG2fO1w1cK7XSJNWKAvRKhukDYT7aRyEQyGpP8bDMx1UiLxmdCxITFCWEAcDqpXoO5SJMoh+da2wwVUzzz40epmKoeO9r8gcm3TtcRfPJ0nHDaeiaD+wBydAs04VHcc+hGaoX4IP5eY+4Ys0LpCZgAat/z5e/23ABXNEKr8rC8bP53ucxduls6BsJxKWFvz6Z4t+IZVolaiTkGnW08L3aqvO8gHXkdrXBgsuqSiS+B6Fw48GjTcAy92s8iQWXs2DGbeWM3JYZC4o9J12x/hwVi7seV1dWNi4L+NpqLieHTGzypet9Dvy9VuyuQ6qDpzCNjWYfUV34eANOV2HznFTcXIpx30QXD/HTfUHJsiYwcJAM5Po5ld11upk5iVZwMnFoZGrAkpi6KGRskKqowqkjtvHlsGchngHZmHQSFJqTOyvGl5Fq0DWZYBDb8vUcU7EO49DT5a9w8XVPD08kTJAWlcoMH5IdQ28hdm1upOQspbEg7gQELYFydpxnLVRsFyWvHBfNNajqX7Mz829Ns4+2dGFJx4as4gzM21aLz2xMBzXIZGcf4tVlF+kYnYzqq+xpTcOzZxUTJM1aO3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(110136005)(5660300002)(7416002)(4744005)(2906002)(54906003)(66556008)(66476007)(64756008)(66446008)(4326008)(316002)(66946007)(41300700001)(76116006)(8676002)(8936002)(38070700009)(478600001)(82960400001)(38100700002)(36756003)(86362001)(71200400001)(122000001)(2616005)(83380400001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEE0d0V5RUdCMzFabjFVVkI0MmVtRWs1bGFQUkxCUkp6SnY0SmhCMUc1YzNl?=
 =?utf-8?B?MER5QjJsMzk3ZWk1Z21yUXZheUJsVlN6SVM2K0hGZ3NrTFNWVFBuZm9NV01M?=
 =?utf-8?B?aFhCb250K1hvM0FRRWJFSkdGb1NnSlFEdnlldkdzM0U2UUg4L3I3RFZRbE9V?=
 =?utf-8?B?Mndjb0IwQUVlZk9DdnQrb0t2NktVOW01WUNpenVPYXNPeFZjTnRybXJ6UDRM?=
 =?utf-8?B?cmZ5d2VkdUdPNlpETGJBUnFrem1pcTcwK3N3L1lreXlmL1doUXlXOVNYMUJy?=
 =?utf-8?B?R2E3Wm1uc3E2RlhPRE8wc052R095Ulh1WHFYS0c4SVZpeG95ay9rQUNsUTJG?=
 =?utf-8?B?b2NLU2g0TWcwa1V0UHB0aXE5V3ZtSGFXTzRYTHBlcjhXR09QNmEybXhyWXlU?=
 =?utf-8?B?Z3RnYjJKTFF3YU9SRHRBUVNyZXRWSERrckc2Z3l0M2NGMjBlQjF4WVVPdEZa?=
 =?utf-8?B?NjlYWm5hWVl2L3Zidm1SZENjNE9BTnF3ZWVLVGszb21hVjkwbzNLd2ZneVFa?=
 =?utf-8?B?d3NZOHBWVWVpREx4cjlGZzFZcG1oTzRxdEdMTzVYRk12UWpkRTAzRHhnS0pr?=
 =?utf-8?B?d2M4eVp6bUxXZDdmNEJLckFOZ0VRanJzbUd1YTlpbkJlNDJYbjhXWkdtd0lJ?=
 =?utf-8?B?eSs0RnhxMitaZ3VwdlVpOXZNcytRcVNneHc4WDR2Rm1QSE0yYXkrZVhCLzlq?=
 =?utf-8?B?cys5SGNZcWg4NGRPamlraWdaNUJSU0tFSE5aYkdRQWZHMUxGSFJTYkdUZmhh?=
 =?utf-8?B?ViswcFM5UVNZYjRSSGJIVTJJUzM0TElteWZqTEs1NGNPNG9uTklvTUROTWtU?=
 =?utf-8?B?c1BIT3F5cXdoMEdTN2N2SXdoN0RtQk4wV29GL3dCMlRQRFY2ejdDc3RwU0VK?=
 =?utf-8?B?Tmc5Q215TkthMVF5MnhyU0thcngvTXM5NjJGMG5RUFFBbnlyd1ZpYmpwYmJp?=
 =?utf-8?B?ZDlhSWdVSXdxVVdzRWVaMjVpZGtwOEpEcUN1QWczV0pGUjZkQ0J2Zm1BcHU1?=
 =?utf-8?B?WDR4bkk1b3BRbDY0MHk3MXZLemFWV3JVbmhrWHR3bXBsZmdSbUZTVEE5MExs?=
 =?utf-8?B?Sm43TEs4SndrYnpnYytNZXVtdjQxSUlIV0QrTGI3bFpPMmJ3THRuZEQ3cDZE?=
 =?utf-8?B?Ujdta1ZvcGNGWVBTaVBMOEFCTU94Q3dna3pIMmU0L0FXYXVRRkh4cmJ6NGts?=
 =?utf-8?B?a0RTT1ZucFNTZnJYdDlZUVBsNk45WXkwcEJSS0pXcmxVS2hKdnl1NElzazJi?=
 =?utf-8?B?RTU1MkplY0FaR2xudmVkQXBGMGZ6YkZJeVphbFZZUTNZYWp2RVRKU1Q2a1ZZ?=
 =?utf-8?B?Q3d3NUx5RU1LckR2NnpCNkVtclFDYnlVcGNTTUFZaDFhNEtPckROTldURWlr?=
 =?utf-8?B?YThaU1lTOUszU3FsNllhbit2TGhLUE5MMDJwZ0Q3ZlkwUUNsZmRvUjVzdXV3?=
 =?utf-8?B?SFZENEdxYWp6NGlHMFR1QVIxdy9xQUt2elRyT1lqVlpTam1UeGpETk5DOXNK?=
 =?utf-8?B?RS96V3hKZ2VqZXhJZml1LytLTzh0anAvYlRPTFQ3R1ZSQ29sazhydk9STTJj?=
 =?utf-8?B?VVZVaVUrSUh4L0k5WisrZ1YvQnNqdTBUakYrR1ZoV1dYS1kxZWRJM3ZvRmNR?=
 =?utf-8?B?UlAxVGFoQ2IrZGNWdVN3V1VvRkRCUUwvWkcvRXo5MXRmT0c3WDNObmFrNmYy?=
 =?utf-8?B?ZkU0YXcxNll0UGFnOGxzbEpIMGlkUzMySVhzaERwNjhhcUNRVWtQcUp4N3Zh?=
 =?utf-8?B?MHVjUWpCODhzWHFLYWZYazFORHF0OVhpS3JtUkt5YS9LQXJNSC8xcWZKbkdN?=
 =?utf-8?B?L0o3L3lvYTFlRzVoSms5VERtenYyRFZWVkp5ekFXaEdWZnlzc2ZXQ1d2Wlll?=
 =?utf-8?B?SUhJNDBTc1hYS2FmVTNUYjQxcFRMakFIZnJybHVJeWdLTFZtdkR1QnFwcHMr?=
 =?utf-8?B?UEVFcWtzZ1N1ckR4cStDZGh2YTRQWGVaaWl6Ly8zRHA0Tk85Wlpabi9sKy9y?=
 =?utf-8?B?Q2JiVkpWODAxTHBnZFE0alVYRVhSdnhsL1lwYVBmY1A0b1VjWnByMUhlSjRh?=
 =?utf-8?B?T0Vhd3NpblE2VU1EMVFkeVhGWURIR2l1N3FRZXI3eDdWTGxtcFBPMm1RUWxx?=
 =?utf-8?B?dDl3UnZHSmw1MWJaWWtNN1NnZXRGeUNNVkt1YmxXYTU0ck95anA3TlN2aHlr?=
 =?utf-8?Q?hIEmyccVs0suMptUdPMv10c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6D5239E089CDD4EA8D78E10C7D3B4DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918d114f-c3c5-48a9-4099-08dc1d20f07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 21:10:49.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CLs8zAATRF/8V7reZSLpOPMtYNxib1RXxvwuTuOqXXNlIJQKPiYap2dsvzeX8R8p8OCMkS+qq4zk8yPm6MS28cv98ndKMiYWWHzjCU/17k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5618
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDE1OjQwIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjQtMDEtMjQgYXQgMjA6MTAgKzAwMDAsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToN
Cj4gPiA+IA0KPiA+IEFoLCB0aGFua3MgZm9yIGNvbmZpcm1pbmchIFdvdWxkIHlvdSBsaWtlIG1l
IHRvIHNlbmQgYSByZXZlcnQgcGF0Y2ggb3INCj4gPiB3aWxsIHlvdSBkbyBpdD8NCj4gDQo+IFJl
dmVydCAiS0VZUzogZW5jcnlwdGVkOiBBZGQgY2hlY2sgZm9yIHN0cnNlcCINCj4gwqDCoMKgIA0K
PiBUaGlzIHJldmVydHMgY29tbWl0IGI0YWYwOTZiNWRmNWRkMTMxYWI3OTZjNzljZWRjNzA2OWQ4
ZjQ4ODIuDQo+IMKgwqDCoCANCj4gTmV3IGVuY3J5cHRlZCBrZXlzIGFyZSBjcmVhdGVkIGVpdGhl
ciBmcm9tIGtlcm5lbC1nZW5lcmF0ZWQgcmFuZG9tDQo+IG51bWJlcnMgb3IgdXNlci1wcm92aWRl
ZCBkZWNyeXB0ZWQgZGF0YS7CoCBSZXZlcnQgdGhlIGNoYW5nZSByZXF1aXJpbmcNCj4gdXNlci1w
cm92aWRlZCBkZWNyeXB0ZWQgZGF0YS4NCj4gDQo+IA0KPiBDYW4gSSBhZGQgeW91ciBSZXBvcnRl
ZC1ieT8NCg0KWWVzIHRoYXQgd29ya3MsIFRoYW5rIHlvdS4NCg0KDQo=

