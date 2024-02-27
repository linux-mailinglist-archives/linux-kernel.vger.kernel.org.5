Return-Path: <linux-kernel+bounces-83394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550438697F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B41C21558
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1704145322;
	Tue, 27 Feb 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUUWKb+E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCB1448FE;
	Tue, 27 Feb 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044006; cv=fail; b=RVVgzdQTFPaIbs5LcL1DqiIYGNa6ofWIM/bcMgLwmi7BIhMsW0L9py9wJloG0SVd8t+fDL19yZhEa9u4vrpIR30nBBXOHVOu/8IXu47RXFtkhkh7rd2cbwgEzcZOE+xw5kXN/s5AMb7YXAOUrRCXadVbHk5Y/6RkMG/ypPg7j64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044006; c=relaxed/simple;
	bh=KWsIGl2sOTmczt/5T3bAlBzrXopiOEO2hCNioO3Hurs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bluZ01Qdgk1M6ID4iYQtI/jw/cwtabepWLZf74wn1XN+7YbH5Dq3X+lWnPsAVIkWtHW9yLmu0IMQX/QwBVwIt7PI3yY+zIh06BacItNr9LZprrJvNSZxQm+YbYayUegjEHxIkhCOqsY69YH6vAkwZcTMYCH3OPf6f+xJNA5XC7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUUWKb+E; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709044004; x=1740580004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KWsIGl2sOTmczt/5T3bAlBzrXopiOEO2hCNioO3Hurs=;
  b=kUUWKb+EjXfkmJlVnY98JW7t5Y1rYYn14TM8lfMM7s2LV+It6BjV/o3V
   9OkodytdpkT+D21BlNdvAZrUEnC78TWKlBlSHrYIKFszy2C+dqAYLW4X+
   4BXspSCto0dSFpTVBm1J7rMpcL/VAGlP90wJOryO6FLeD5XH1ilUX9SHw
   9xB1HKl9gRIhdiKl10WcfptXWsEirjfQ3IXJiU0i4KSD4P97K8ef/tEag
   FDV8EwvWwdx6VMwbhkSS4+8oYAH0fye0qCf9Qk8yR2IarYzEXtiF1I2QP
   g5WPy4jQgnOaoX9dP8zdNJOYkRbTUdIona2OUm30IqkRIikM6OzPO4rq7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13935400"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="13935400"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7409585"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 06:26:43 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:26:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:26:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:26:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 06:26:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfr42tHJFnhYidfpvPLgkWKLnjb8U/cIHPACRrJXIBCisvUVJopRRzHDrayLKHvhSGHFgr80eRJId+At4Vgn2CukNqpRB0MXy75KrcXtkKtQC74xGudn010OhbvCsfOTvGnVrE/brsTXVO8KvhhVVxjnKceZVPyFs4+9VT/66+Q4SKr68YSpHzdlfluktNWZ8mF5TOKCC9FDLM0MAPzkzbnpj+Fa840wi6rlCdGOZI8oVG71/p2BH9NC7nPcQYg0XtObc0YILGtuFbCEVo1AzfX/94CkYNyuw1FVoQWUWbTj20JzGJDAxHnW//QoAfdd0zvS3ShM+xtcIHeSr+xYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWsIGl2sOTmczt/5T3bAlBzrXopiOEO2hCNioO3Hurs=;
 b=Ee3o89iKN21KU1nwPSlmQ8wisZQOQrFwhdXotrRLf29xjqaGG91s3kSPCYYs4tAyN3+JVvg095Ah0HDS93HMEvC6CG3Y/ZFlSHQpDzCmqehtnO9+do3YmST/NCI5v1Qi1uJio0c3pZHVGTZOc8CtYQdaqJk2G4xxdDpBxKHeK/JxZG2wSbAmOLPqSt7m+2wAXWexkh5+GiKhg9ibHKsr0vjlyQiHLvKAmBV58S79+/E5TxiTj6oyCIUg+qPN0Xkio71GhsjnSi7RHt/nEb74tyQmcN9FvRIT11IOAe9m/HfEDkyAjB8yicwIT0QDI3i93ooAFdJD+EtgJ7x7y4eMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4836.namprd11.prod.outlook.com (2603:10b6:303:9d::22)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.23; Tue, 27 Feb
 2024 14:26:39 +0000
Received: from CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::bcf0:a82d:548f:5f20]) by CO1PR11MB4836.namprd11.prod.outlook.com
 ([fe80::bcf0:a82d:548f:5f20%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 14:26:39 +0000
From: "Luse, Paul E" <paul.e.luse@intel.com>
To: Xiao Ni <xni@redhat.com>
CC: Yu Kuai <yukuai1@huaweicloud.com>, Paul E Luse
	<paul.e.luse@linux.intel.com>, "song@kernel.org" <song@kernel.org>,
	"neilb@suse.com" <neilb@suse.com>, "shli@fb.com" <shli@fb.com>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in
 read_balance()
Thread-Topic: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in
 read_balance()
Thread-Index: AQHaZWXI0q1c6kB7eEG2DHtDQMyMrLEdfTCAgAAD+oCAACSdgIAAoVQA
Date: Tue, 27 Feb 2024 14:26:39 +0000
Message-ID: <813BAD45-4484-4B1E-BCD0-40C159DA62BA@intel.com>
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-4-yukuai1@huaweicloud.com>
 <CALTww28PJPdqRkSEarwATG5GmkuMmEtT0La5s-9c9r5UPy4siA@mail.gmail.com>
 <6114e6f5-87a6-216e-027d-cbb0a7e8e429@huaweicloud.com>
 <CALTww2_iPFJiX17ORbN2+ssdYWVk0=M4pCgJDoWh_-jJPn0bRA@mail.gmail.com>
In-Reply-To: <CALTww2_iPFJiX17ORbN2+ssdYWVk0=M4pCgJDoWh_-jJPn0bRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.400.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4836:EE_|SA2PR11MB5132:EE_
x-ms-office365-filtering-correlation-id: 1c260ba8-3380-49e4-f148-08dc37a01c78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jcdp/X8YRvqyMVejemlrD0BWpr8C0opbihvzcY8gZoc/++bOnR5MaOTxmQ+Iv8lmear7b3D2s13dhGrzFQb72cvcSBYiBbhlWBnqWuF893x5d/zCWVUNLF6N9WB1Xu2qWpddg4lDLVz/7HedOczP3cYVdDRvReqW2EfiMdh7O7uSo9sex7Y7WSUxjsOaUc/VXmOCiYFSZi7gpyJLkrGCqhUwS/ePCeWhXccMCxhhTLn7CMwNZPnf0GBM3O5gz6SpcTBoMf944Ckg37JIgi/ie049dIgHA6ZdvpyHKpTCtv80ufV3hItxLTTRkD4T77SuEgfxJmbpB3ELP4XCPw+fGtpgSR6T5nl5kYk9zikgzlmJsvgRL8aC8HQOSIipU0ubfDx3LDGr0nuWRldnaFfH0PqpGdO4YqWU4nJpBsz9HHrcyyot4H8hivy5hD8jKqBzS55pu1mShGuM1Do322HUzbWbUWE5BaD6iqXJ83Ef7oB2QD0d43UCCmUFSo5niFaqhRFLPMZ9k93eJwQAN+tt+pV08pLXMPs3lR4P7ik2lt84BnS5dR03u41Vnqax+FXzzGrPzmE098mpXbp7mjTp1Pb2vIib4rU8i6f1Mi+yX3JTBEnX9S64yxLPLAiauoFQQnbU2N+jiYJ1Ha2kqDJ31LRSkOqC7doYBUPx2bmDWlMy+WHuio9VEgjaOAsHgMkrRMaUIrL4V+OVcBl71byI/TzWIGR+eB6GE4awu3MHPcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzBSQ2NYdDFET2UySnppRDREV2hwc1JCalNTajY1MDFnY3BSUnpZWnFJdVNn?=
 =?utf-8?B?akczZUZhQlE5V2tZclJNY2ZNa21PT2RmcnloSkl4VGtudUNSY2gvdHdDTkIx?=
 =?utf-8?B?SEh1aTFwdGFUSU96RmRRZ1FNbjg0RGgvdXNCOSs2bXE5TU94T1RTcWtCUkRR?=
 =?utf-8?B?aXdXbnN1Y2VlSUpGRWFaMjg4N21HN3BENE9UT21lWWxndzZkZWVvUVNVcXZa?=
 =?utf-8?B?ZWJ0dVVXdjZDb2NvL243cEhFZzRpa3p1SVgwOWZxNU10OGtBREdNK3FUUUNr?=
 =?utf-8?B?bUdSVm1yU2ZkRTVhU2xhYXZlRURoZHNUVHFnQUdJT3REenk1eCttKzhzcHh3?=
 =?utf-8?B?RWFnWVMyWVNndzdPNFhSMUtNN3lLRFh0Y0hlT1VYTkpwRG5MN0RUcEI1WjUz?=
 =?utf-8?B?dUhlS3FvcmdHaFBMMVp2cWxPeGNvZ01MajJ6Z01NcVQvY0hNSloyTTRVZ3lE?=
 =?utf-8?B?SEVjY0k4T1JqTE9Bb29xVGZUSmlGV053K3pKaGptTFRFak9sUXlDaW5FQ2xV?=
 =?utf-8?B?QXVFVHZOSE1DQnNXd0ZIaWZGbjZwOHZKdEdLcStTN3liZi9hSzRJWWF5bG9v?=
 =?utf-8?B?YkhRWmFkM1V0THd2clljWlJnOEVVaVFlK21WU3pQSW9ScXZwM1MrTDBZN1JQ?=
 =?utf-8?B?MWJ0b1V2WjNmUDM2UE1FQjI2NHZzZ3hHQTd4QWtzSjJsMG5KUE9lb2VzQWY3?=
 =?utf-8?B?bkViaVV5VUo5VkdDekRaRmVMOHgzM2V5RnV5NlV1cnJwbWFUVWJqNURTSjdR?=
 =?utf-8?B?TjQyMkJRVldQN3lKUlZXcFEveEVHNWUwMHJWZFVDdEY1elRVK3ZJdHFkVlFx?=
 =?utf-8?B?LzU4T1VFRldEeElLR0dyazRFTFVpOSt3ZGNZaTlHTUlZaUlMTWxOczRUUDhU?=
 =?utf-8?B?L2JSaWRrbW81UGhIeTBNSExVd1k4MkIreTkvM2hVTlpHTDdRZjQ0K1U4eTNh?=
 =?utf-8?B?TFR0R01DUzN0enBVZThPUjQ0MDBEZUJDUXhGRUNHZEFxcmlqcE9xaUtBbHda?=
 =?utf-8?B?MDJPa0dJZHhlbGI4eWwrYUx0WjFIYUdRa1JTbmcxSUkyU1lGRkVuYkF2MmxN?=
 =?utf-8?B?ZERIVGIrOHlUTVRhN0R3REFkM2Z3a2NVUjgwQytCNWtqMEIzV3VRYUJnVVFT?=
 =?utf-8?B?QmtiOG5obWY2UEtjZStzdVlKNEJSZ1lBYUhzREF3WUQwUXVLKzlXQTRlWSt5?=
 =?utf-8?B?Q24wYTBmZGJYN0tJRktlaVc5WlFMQ25aSHNMeGM2U3pHTXFmdHNUMWgzdjJD?=
 =?utf-8?B?a2FtM2tzVEdHQ29ReVVHaGtHbTU4ZEl4eHFyeWs4YkJsZ1Q2Rm8wOFlIaTV5?=
 =?utf-8?B?bE9WTmdCK2pDZHdWZFhya29LYWhIYkdWdEZvTjNDWUt0ckJQa3htN0ZWNzFy?=
 =?utf-8?B?d21zNmkwanNQTmFFWi9zaG1mR2M4QVBNSWtYNUNsRzZiMjdVcU1La2llWThB?=
 =?utf-8?B?RkhISUNnTDlzNDhFQlZjVStqQ3RyWmhhTlVtUHRtWmNXZEU3QVloSTBDT0ln?=
 =?utf-8?B?UHZ4TE9uemJwWVRaTXFsNnZ4anN2NTdBTnRIdmJFK2hFQkxYalhzMmE2aHd5?=
 =?utf-8?B?RW5tTjJmVnpyZTFicW5QTENTV2JHYXhKTjUwSHZsekNDQ3hQNThSU0wrOGlw?=
 =?utf-8?B?K1E5aWNzVDJiUmtqemxKdzVvMUR4K1YzK2FUYmo4VWJpRjI3SmlXL0JONUJa?=
 =?utf-8?B?T2pqZ1FGRlFLQXU3RElWTWdnTktSRW9zWHV3RWtxbU1rSzZWeUNqd1F4Qkl6?=
 =?utf-8?B?N250N0NOTWcxOXZvYWpubFQrUm5kbTVFRGFUdDk4Z00wTGNzM2h4cjJIaHJa?=
 =?utf-8?B?b2Z3UDBkNGdEUXpHcXV3b2wxVUFJanQ0ek1rUTdqaDFNOE1QeEk3UUxVc3Uy?=
 =?utf-8?B?b2VPWWVqcnhhVkhwcnpIZ1FjNUxnYzhuQm5lWkQ1TEwxa053RlFDT2wzNHdh?=
 =?utf-8?B?ekNTOElDVHBUQUZ4MlNTVzdPNkRwTTBtWEp3aXRWeVJLV2Rnem5sR0wxSHlJ?=
 =?utf-8?B?N0FOMEV2aDlvTVpPNC9tUjJRMXIrd2Z3SktVR3hkUk1ob0FaZ3pxMU4yWWN6?=
 =?utf-8?B?ZXFQb0JBS1lEeVNZaHZwK1JteHF4NUJKeVRxWGtDZ3R2Rkt2MElKZ0VMQXBR?=
 =?utf-8?B?RktBUmk1WERaMzhGQmFrUUpEMkgrMTVFT3FjVStKbElUQkZVU1ZHY2srNERP?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C9040A1EC5A8C4691476B2ADEA4504B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c260ba8-3380-49e4-f148-08dc37a01c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 14:26:39.1253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0swPYnhBH+HbFF5OObjl19Imnp4gkZuaVpBm2aJO0SkeI2dnw7NlOb1w4E8BL2nFYbCoayafpMnYRrTPoq83mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

DQoNCj4gT24gRmViIDI2LCAyMDI0LCBhdCA5OjQ54oCvUE0sIFhpYW8gTmkgPHhuaUByZWRoYXQu
Y29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRmViIDI3LCAyMDI0IGF0IDEwOjM44oCvQU0gWXUg
S3VhaSA8eXVrdWFpMUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPj4gDQo+PiBIaSwNCj4+IA0K
Pj4g5ZyoIDIwMjQvMDIvMjcgMTA6MjMsIFhpYW8gTmkg5YaZ6YGTOg0KPj4+IE9uIFRodSwgRmVi
IDIyLCAyMDI0IGF0IDQ6MDTigK9QTSBZdSBLdWFpIDx5dWt1YWkxQGh1YXdlaWNsb3VkLmNvbT4g
d3JvdGU6DQo+Pj4+IA0KPj4+PiBGcm9tOiBZdSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+DQo+
Pj4+IA0KPj4+PiBDb21taXQgMTJjZWU1YThhMjllICgibWQvcmFpZDE6IHByZXZlbnQgbWVyZ2lu
ZyB0b28gbGFyZ2UgcmVxdWVzdCIpIGFkZA0KPj4+PiB0aGUgY2FzZSBjaG9vc2UgbmV4dCBpZGxl
IGluIHJlYWRfYmFsYW5jZSgpOg0KPj4+PiANCj4+Pj4gcmVhZF9iYWxhbmNlOg0KPj4+PiAgZm9y
X2VhY2hfcmRldg0KPj4+PiAgIGlmKG5leHRfc2VxX3NlY3QgPT0gdGhpc19zZWN0b3IgfHwgZGlz
ayA9PSAwKQ0KPj4+PiAgIC0+IHNlcXVlbnRpYWwgcmVhZHMNCj4+Pj4gICAgYmVzdF9kaXNrID0g
ZGlzazsNCj4+Pj4gICAgaWYgKC4uLikNCj4+Pj4gICAgIGNob29zZV9uZXh0X2lkbGUgPSAxDQo+
Pj4+ICAgICBjb250aW51ZTsNCj4+Pj4gDQo+Pj4+ICBmb3JfZWFjaF9yZGV2DQo+Pj4+ICAtPiBp
dGVyYXRlIG5leHQgcmRldg0KPj4+PiAgIGlmIChwZW5kaW5nID09IDApDQo+Pj4+ICAgIGJlc3Rf
ZGlzayA9IGRpc2s7DQo+Pj4+ICAgIC0+IGNob29zZSB0aGUgbmV4dCBpZGxlIGRpc2sNCj4+Pj4g
ICAgYnJlYWs7DQo+Pj4+IA0KPj4+PiAgIGlmIChjaG9vc2VfbmV4dF9pZGxlKQ0KPj4+PiAgICAt
PiBrZWVwIHVzaW5nIHRoaXMgcmRldiBpZiB0aGVyZSBhcmUgbm8gb3RoZXIgaWRsZSBkaXNrDQo+
Pj4+ICAgIGNvbnRpbmUNCj4+Pj4gDQo+Pj4+IEhvd2V2ZXIsIGNvbW1pdCAyZTUyZDQ0OWJjZWMg
KCJtZC9yYWlkMTogYWRkIGZhaWxmYXN0IGhhbmRsaW5nIGZvciByZWFkcy4iKQ0KPj4+PiByZW1v
dmUgdGhlIGNvZGU6DQo+Pj4+IA0KPj4+PiAtICAgICAgICAgICAgICAgLyogSWYgZGV2aWNlIGlz
IGlkbGUsIHVzZSBpdCAqLw0KPj4+PiAtICAgICAgICAgICAgICAgaWYgKHBlbmRpbmcgPT0gMCkg
ew0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBiZXN0X2Rpc2sgPSBkaXNrOw0KPj4+PiAt
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+Pj4gLSAgICAgICAgICAgICAgIH0NCj4+
Pj4gDQo+Pj4+IEhlbmNlIGNob29zZSBuZXh0IGlkbGUgd2lsbCBuZXZlciB3b3JrIG5vdywgZml4
IHRoaXMgcHJvYmxlbSBieQ0KPj4+PiBmb2xsb3dpbmc6DQo+Pj4+IA0KPj4+PiAxKSBkb24ndCBz
ZXQgYmVzdF9kaXNrIGluIHRoaXMgY2FzZSwgcmVhZF9iYWxhbmNlKCkgd2lsbCBjaG9vc2UgdGhl
IGJlc3QNCj4+Pj4gICAgZGlzayBhZnRlciBpdGVyYXRpbmcgYWxsIHRoZSBkaXNrczsNCj4+Pj4g
MikgYWRkICdwZW5kaW5nJyBzbyB0aGF0IG90aGVyIGlkbGUgZGlzayB3aWxsIGJlIGNob3NlbjsN
Cj4+Pj4gMykgc2V0ICdkaXN0JyB0byAwIHNvIHRoYXQgaWYgdGhlcmUgaXMgbm8gb3RoZXIgaWRs
ZSBkaXNrLCBhbmQgYWxsIGRpc2tzDQo+Pj4+ICAgIGFyZSByb3RhdGlvbmFsLCB0aGlzIGRpc2sg
d2lsbCBzdGlsbCBiZSBjaG9zZW47DQo+Pj4+IA0KPj4+PiBGaXhlczogMmU1MmQ0NDliY2VjICgi
bWQvcmFpZDE6IGFkZCBmYWlsZmFzdCBoYW5kbGluZyBmb3IgcmVhZHMuIikNCj4+Pj4gQ28tZGV2
ZWxvcGVkLWJ5OiBQYXVsIEx1c2UgPHBhdWwuZS5sdXNlQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogUGF1bCBMdXNlIDxwYXVsLmUubHVzZUBsaW51eC5pbnRlbC5jb20+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFl1IEt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4NCj4+Pj4gLS0t
DQo+Pj4+ICBkcml2ZXJzL21kL3JhaWQxLmMgfCAyMSArKysrKysrKysrKystLS0tLS0tLS0NCj4+
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPj4+
PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvcmFpZDEuYyBiL2RyaXZlcnMvbWQvcmFp
ZDEuYw0KPj4+PiBpbmRleCBjNjBlYTU4YWU4YzUuLmQwYmM2N2U2ZDA2OCAxMDA2NDQNCj4+Pj4g
LS0tIGEvZHJpdmVycy9tZC9yYWlkMS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvbWQvcmFpZDEuYw0K
Pj4+PiBAQCAtNjA0LDcgKzYwNCw2IEBAIHN0YXRpYyBpbnQgcmVhZF9iYWxhbmNlKHN0cnVjdCBy
MWNvbmYgKmNvbmYsIHN0cnVjdCByMWJpbyAqcjFfYmlvLCBpbnQgKm1heF9zZWN0DQo+Pj4+ICAg
ICAgICAgdW5zaWduZWQgaW50IG1pbl9wZW5kaW5nOw0KPj4+PiAgICAgICAgIHN0cnVjdCBtZF9y
ZGV2ICpyZGV2Ow0KPj4+PiAgICAgICAgIGludCBjaG9vc2VfZmlyc3Q7DQo+Pj4+IC0gICAgICAg
aW50IGNob29zZV9uZXh0X2lkbGU7DQo+Pj4+IA0KPj4+PiAgICAgICAgIC8qDQo+Pj4+ICAgICAg
ICAgICogQ2hlY2sgaWYgd2UgY2FuIGJhbGFuY2UuIFdlIGNhbiBiYWxhbmNlIG9uIHRoZSB3aG9s
ZQ0KPj4+PiBAQCAtNjE5LDcgKzYxOCw2IEBAIHN0YXRpYyBpbnQgcmVhZF9iYWxhbmNlKHN0cnVj
dCByMWNvbmYgKmNvbmYsIHN0cnVjdCByMWJpbyAqcjFfYmlvLCBpbnQgKm1heF9zZWN0DQo+Pj4+
ICAgICAgICAgYmVzdF9wZW5kaW5nX2Rpc2sgPSAtMTsNCj4+Pj4gICAgICAgICBtaW5fcGVuZGlu
ZyA9IFVJTlRfTUFYOw0KPj4+PiAgICAgICAgIGJlc3RfZ29vZF9zZWN0b3JzID0gMDsNCj4+Pj4g
LSAgICAgICBjaG9vc2VfbmV4dF9pZGxlID0gMDsNCj4+Pj4gICAgICAgICBjbGVhcl9iaXQoUjFC
SU9fRmFpbEZhc3QsICZyMV9iaW8tPnN0YXRlKTsNCj4+Pj4gDQo+Pj4+ICAgICAgICAgaWYgKChj
b25mLT5tZGRldi0+cmVjb3ZlcnlfY3AgPCB0aGlzX3NlY3RvciArIHNlY3RvcnMpIHx8DQo+Pj4+
IEBAIC03MTIsNyArNzEwLDYgQEAgc3RhdGljIGludCByZWFkX2JhbGFuY2Uoc3RydWN0IHIxY29u
ZiAqY29uZiwgc3RydWN0IHIxYmlvICpyMV9iaW8sIGludCAqbWF4X3NlY3QNCj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgaW50IG9wdF9pb3NpemUgPSBiZGV2X2lvX29wdChyZGV2LT5iZGV2
KSA+PiA5Ow0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcmFpZDFfaW5mbyAq
bWlycm9yID0gJmNvbmYtPm1pcnJvcnNbZGlza107DQo+Pj4+IA0KPj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgICBiZXN0X2Rpc2sgPSBkaXNrOw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAvKg0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBJZiBidWZmZXJlZCBzZXF1ZW50
aWFsIElPIHNpemUgZXhjZWVkcyBvcHRpbWFsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIGlvc2l6ZSwgY2hlY2sgaWYgdGhlcmUgaXMgaWRsZSBkaXNrLiBJZiB5ZXMsIGNob29zZQ0K
Pj4+PiBAQCAtNzMxLDE1ICs3MjgsMjEgQEAgc3RhdGljIGludCByZWFkX2JhbGFuY2Uoc3RydWN0
IHIxY29uZiAqY29uZiwgc3RydWN0IHIxYmlvICpyMV9iaW8sIGludCAqbWF4X3NlY3QNCj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pcnJvci0+bmV4dF9zZXFfc2VjdCA+IG9wdF9p
b3NpemUgJiYNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pcnJvci0+bmV4dF9z
ZXFfc2VjdCAtIG9wdF9pb3NpemUgPj0NCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG1pcnJvci0+c2VxX3N0YXJ0KSB7DQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY2hvb3NlX25leHRfaWRsZSA9IDE7DQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyoN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBBZGQgJ3BlbmRpbmcnIHRv
IGF2b2lkIGNob29zaW5nIHRoaXMgZGlzayBpZg0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqIHRoZXJlIGlzIG90aGVyIGlkbGUgZGlzay4NCj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiBTZXQgJ2Rpc3QnIHRvIDAsIHNvIHRoYXQgaWYgdGhlcmUg
aXMgbm8gb3RoZXINCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBpZGxl
IGRpc2sgYW5kIGFsbCBkaXNrcyBhcmUgcm90YXRpb25hbCwgdGhpcw0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIGRpc2sgd2lsbCBzdGlsbCBiZSBjaG9zZW4uDQo+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+Pj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGVuZGluZysrOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRpc3QgPSAwOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ug
ew0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJlc3RfZGlzayA9IGRpc2s7
DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7
DQo+Pj4+ICAgICAgICAgICAgICAgICB9DQo+Pj4gDQo+Pj4gSGkgS3VhaQ0KPj4+IA0KPj4+IEkg
bm90aWNlZCBzb21ldGhpbmcuIEluIHBhdGNoIDEyY2VlNWE4YTI5ZSwgaXQgc2V0cyBiZXN0X2Rp
c2sgaWYgaXQncw0KPj4+IGEgc2VxdWVudGlhbCByZWFkLiBJZiB0aGVyZSBhcmUgbm8gb3RoZXIg
aWRsZSBkaXNrcywgaXQgd2lsbCByZWFkIGZyb20NCj4+PiB0aGUgc2VxdWVudGlhbCBkaXNrLiBX
aXRoIHRoaXMgcGF0Y2gsIGl0IHJlYWRzIGZyb20gdGhlDQo+Pj4gYmVzdF9wZW5kaW5nX2Rpc2sg
ZXZlbiBtaW5fcGVuZGluZyBpcyBub3QgMC4gSXQgbG9va3MgbGlrZSBhIHdyb25nDQo+Pj4gYmVo
YXZpb3VyPw0KPj4gDQo+PiBZZXMsIG5pY2UgY2F0Y2gsIEkgZGlkbid0IG5vdGljZSB0aGlzIHll
dC4uLiBTbyB0aGVyZSBpcyBhIGhpZGRlbg0KPj4gbG9naWNhbCwgc2VxdWVudGlhbCBJTyBwcmlv
cml0eSBpcyBoaWdoZXIgdGhhbiBtaW5pbWFsICdwZW5kaW5nJw0KPj4gc2VsZWN0aW9uLCBpdCdz
IG9ubHkgbGVzcyB0aGFuICdjaG9vc2VfbmV4dF9pZGxlJyB3aGVyZSBpZGxlIGRpc2sNCj4+IGV4
aXN0Lg0KPiANCj4gWWVzLg0KPiANCj4gDQo+PiANCj4+IExvb2tzIGxpa2UgaWYgd2Ugd2FudCB0
byBrZWVwIHRoaXMgYmVoYXZpb3VyLCB3ZSBjYW4gYWRkIGEgJ3NlcXVlbnRpYWwNCj4+IGRpc2sn
Og0KPj4gDQo+PiBpZiAoaXNfc2VxdWVudGlhbCgpKQ0KPj4gIGlmICghc2hvdWxkX2Nob29zZV9u
ZXh0KCkpDQo+PiAgIHJldHVybiBkaXNrOw0KPj4gIGN0bC5zZXF1ZW50aWFsX2Rpc2sgPSBkaXNr
Ow0KPj4gDQo+PiAuLi4NCj4+IA0KPj4gaWYgKGN0bC5taW5fcGVuZGluZyAhPSAwICYmIGN0bC5z
ZXF1ZW50aWFsX2Rpc2sgIT0gLTEpDQo+PiAgcmV0dXJuIGN0bC5zZXF1ZW50aWFsX2Rpc2s7DQo+
IA0KPiBBZ3JlZSB3aXRoIHRoaXMsIHRoYW5rcyA6KQ0KPiANCj4gQmVzdCBSZWdhcmRzDQo+IFhp
YW8NCg0KWXVwLCBhZ3JlZSBhcyB3ZWxsLiAgVGhpcyB3aWxsIGhlbHAgZm9yIHN1cmUgd2l0aCB0
aGUgZm9sbG93dXAgdG8gdGhpcyBzZXJpZXMgZm9yIHNlcSByZWFkIGltcHJvdmVtZW50cyA6KSAN
Cg0KPj4gDQo+PiBUaGFua3MsDQo+PiBLdWFpDQo+PiANCj4+PiANCj4+PiBCZXN0IFJlZ2FyZHMN
Cj4+PiBYaWFvDQo+Pj4+IA0KPj4+PiAtICAgICAgICAgICAgICAgaWYgKGNob29zZV9uZXh0X2lk
bGUpDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+PiAtDQo+Pj4+
ICAgICAgICAgICAgICAgICBpZiAobWluX3BlbmRpbmcgPiBwZW5kaW5nKSB7DQo+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG1pbl9wZW5kaW5nID0gcGVuZGluZzsNCj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgYmVzdF9wZW5kaW5nX2Rpc2sgPSBkaXNrOw0KPj4+PiAtLQ0KPj4+PiAy
LjM5LjINCj4+Pj4gDQo+Pj4+IA0KPj4+IA0KPj4+IC4NCj4+PiANCj4+IA0KPiANCj4gDQoNCg==

