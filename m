Return-Path: <linux-kernel+bounces-61199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3508850ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A9281120
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDDEAEA;
	Mon, 12 Feb 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sqx4XHsu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20158F4E3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726338; cv=fail; b=kPoiPIUP9CWvRPZ57fQGGeFiYsp1tTZJb5mpFbxOx/YlADAawd5kYTH1ebm/QFmLwpztuxOFWO/vtRtRX7n14bDXMMSmqdnFDqT2lRAbDreWggFMMFJmHMspT02MVCUm2QIQH8/JeQriPgvPlFeSvkIus1C/052wLjZh7nzWUVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726338; c=relaxed/simple;
	bh=rvQ68VwqfgBIZNZsuQnkZVgmnpj6asLg3GDDYEZXInQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cof7YsBeBCZuOkllXDd5PxpNLJ4IjA8xV6dfGz91gMsoxy2Fxvh/sHrwABDxZaikp9gShyBIUfmzxoaC5gp9J0N/Nfp9ZMSXUS6xscRrTvwoKxqx6iJ66drp801lM9r/4v1Cwo7Ds0WlIluu09VKjNuJOd03SOXjZ+5qPqYaJRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sqx4XHsu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707726337; x=1739262337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rvQ68VwqfgBIZNZsuQnkZVgmnpj6asLg3GDDYEZXInQ=;
  b=Sqx4XHsuveXbluTLtuiSvAdLtVy5W8E0oT/7/mW1ax7PctuHcXC3IaG2
   nYkXC8IBua2ZDrFu6oV0EoBycA0xcu6409Z+w99Y+6mNePVg6LT1bVD+L
   EBIPlJHbv2gxROL1XC6W02kb9IMIzYmUd+b/CEziNCJ4gwp6aI5splST0
   gagg1OmJJHlQogEprniu2JwXNstvbAjnZYUGPiCKYevBZKnFI/d7W1fiI
   FtxwaJY7VuMcbR8DQYa0TsnCPzZkE8+bbiUUo9BPfe6eG4ChWQCTmV3P7
   GosJpuLg6jdorPDWWAQ39YT5vKH29EVh6Px7IEQTd1wXVj4m4pKc3YNxf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1826061"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1826061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911419687"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="911419687"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 00:25:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 00:25:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 00:25:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 00:25:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 00:25:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDtb0cxfgRfrod561bQVIIFB8fcrZYH7WlKhizC4qMJLds0zLjG1R4T3J7dJEJdsvubMEVAC/azaaEsNDHR7TpyRRwltcXGrUx0ASOQWpIWnaLhJsxW38an0nnqA9xOpomQAXwPBwAJUz8ChPCPv+491x0eNaI4klak1aZp9aSHJZ3di1OGI5eYzgoIHf7ij54RI9nT9962XZNgeBpofU0IqA0hCgQB6tIE+0NzBfeKHIIg5Kxw7vgFeSK4dAfjrstIioOKnqlH3QJ9Fl/KTrf0owh48VTTAeqdrxa4fB4SYzMY5hDwF9iRh1LZgv8MJT6kEa+3oMvSFyL3u3Hvo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvQ68VwqfgBIZNZsuQnkZVgmnpj6asLg3GDDYEZXInQ=;
 b=MwJQobHcKieplSe748lq3/IgQDhgFYeUIZl3I6XvE/wedZQEHdiBauYmVbIvnEc/MVraeE59T7fOMptrmzzrfCztxjr1eZhnfhxZMQwCyuR7x89tueX0A7cS3+e2r+eE7Sha1nXHZY5J/rXqIx9LqvHCxNcIC/QOIAXQwwy/c6E932keO6we5ptnpV5D0R8PIUE5w8TFohPZcRYtbDjrYTSj16l+Zb8tq9j6Ztl321d1rVBqgLS7KU1fs8sJEyxZ0DTKiXM58NOhjvKbdsJId2W4OFqupcVm/XOYNWr4hBMF882JQGrhnQd248MB1JregcHLmH32CSuZr+/IUDhl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CH3PR11MB7722.namprd11.prod.outlook.com (2603:10b6:610:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 08:25:33 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 08:25:33 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
CC: Theodore Ts'o <tytso@mit.edu>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, Sean
 Christopherson <seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AIAACBOAgAC3UwCAAN1RgIAA2w+AgACNaYCAATcDgIAKEC6AgAPvveA=
Date: Mon, 12 Feb 2024 08:25:33 +0000
Message-ID: <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu> <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
In-Reply-To: <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CH3PR11MB7722:EE_
x-ms-office365-filtering-correlation-id: 22d586b1-746b-426e-cdc7-08dc2ba42e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aq7EiavbYtBwWgXXpNN1RMh7ZM4MhBcEHuZPf850DPAxPdaIM2ZJOkgejZUhvk8A5DKKgRiYFHKSslqLj3UgDwfKmKeA52uvfWSarfogFAVdd1V9owcJ2rvANh23Heeb6KI0nvQc9r9hNXUkb5uFV+X/LlZZ+NPCrXMgrdCAlOyE5mSigN2ApaaPeH6Y8Cp7p6I7jHSl/ytfC8uS88FfikfEiJLwXxh4hE9a7xjO86OcikqLGLSTNP9b3QndZO7pqRD3INp5euZlVMeIjy76mNvKI7fHx0bsRjlwKhQPWs9Dd1zsDiPllbzW2JYTc5Lwjabn7obdnHkxLmzU0pqGphdctUI4OfRalHLxgnQ2n1JOYitynlnRXedd5G3EYv3vX2Gu1wjddCV+EBtH8Ua5yZwhwqnOjtSomK3RbpbcSLR+kdQaTnHdJB3JrozzED0TioE2VAHtZTozsPsT5mcsQ2b3D3i6syCR2ErGlkP/V9j4uyGObZ6ajkLOUmng5Q1PGxPtOTNEfr0q78r/SKLI3E0B3HoW7vhmBL6fCkvrS5cOJWRrNv53dNREeYAekWWF52x+0O0u3ohrQO+29d7YZGO1rBjAMKXbTt98lkeDwl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230473577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(8676002)(76116006)(66446008)(66946007)(52536014)(66556008)(7416002)(4326008)(66476007)(64756008)(2906002)(5660300002)(122000001)(26005)(83380400001)(478600001)(9686003)(7696005)(53546011)(110136005)(6506007)(54906003)(966005)(316002)(82960400001)(38100700002)(71200400001)(41300700001)(55016003)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2RqRG1KdlhaN2EvM0pod01GUHh6ajRxMWo1em1xSkppWWQyY1JWRGFhRjRh?=
 =?utf-8?B?OWRCaTdzZVJ2RjY0MkhoQUxDb1ExbHpvOWowRVNYL3g4Rk5tSDE4OU5CZlFF?=
 =?utf-8?B?UzdPUUJseGQ3c0w2ejFHSzg0Vk9Wd2c4cUdSZWdWWnlrZzgxeGpSZ3hYVjdZ?=
 =?utf-8?B?aVI0VHo4YUZyWHFnU2lYUUEzVGwzQ2l2dG9lTGtnT0dTZEZUd21Eb2EybGhQ?=
 =?utf-8?B?bm1pWFJ2ZG1wYXZHK1FxNWJockFwQ0kxdVZ6dXBWb0szQjZGdkg2OWlWb1NC?=
 =?utf-8?B?U3FQeFMzY1k3S0Y0ZWhEWE9tdnh4alAzMlhPeXMwU2xHSWs4Z3FPTVNDcFFS?=
 =?utf-8?B?QnhQb0hHZlUvaVQrM0dINTlIdTArWHFBajlZMFR5TmpiL3ZCdDl2VEdPUjdS?=
 =?utf-8?B?UnNEWXdQc3hzOU05U2QyUFlySVpSQ2tmVzBDMjV4WVhLSEFST2Y5RmswRVJB?=
 =?utf-8?B?ZGd1N1g1SGtMeTdJVk96VXNBWVBGeU1MMlBrckZMSUg4dWhoSEZkRlpBWlZO?=
 =?utf-8?B?bnVIVkw4WG9oUnZVU1kwVUNad1czUjVlNnBIMHR0MkgxQ2VmZmpJcXh5QmYy?=
 =?utf-8?B?NDBpZngyWVdiY25DSldkT2E2c1RLbDdRZzZGbHpHQkgxY3IrY3JLaTRESVZE?=
 =?utf-8?B?cDJTQ0lTYlpaS2xXL00vODkrQ3pkRUVwTGg1SldWUmVtK21aZTV2TVVEY1NK?=
 =?utf-8?B?ZjRQNzkyZERxbjdnK21KNHRUNjllckxjN3FRSlJyOU5yTnBIbjh2VUU3RFU4?=
 =?utf-8?B?SU5GdFNGVVp4a0JQaHhNMFY4WUlDWldvT1F2eGZGYlJTN3BlMTcwdS9PZ2tZ?=
 =?utf-8?B?MGpOTTQzQ2pqTkt1Y1UzbmpndmUxejZtWTlEMXh0WXJ3YUtWN1pHN04rQVpG?=
 =?utf-8?B?REVCczdoMkdZRjdiOTZXOW81MHFSb2s2WldNbkM3YjdwRkhJNk8rcTR0bW42?=
 =?utf-8?B?Si80WEc3UmVuWjJ2TnFCV093T1Y4QVJwQTN0RENRS0Y2Si96NUV6cFRpbXhI?=
 =?utf-8?B?dWtWTk9MQ3pzTEZkV1JZbGRwY2ZIdi9OR0x5amdycENOY0VxN0RVY2duRHFQ?=
 =?utf-8?B?cld3bC84ZW5JK0pmUkJOS2RWUm1MajgyWXA3QldUSmgxVkNYditTOWp0QnVJ?=
 =?utf-8?B?Z1dOODJpbTg4ZmRma3Z2emQrY05vcFA5U3ZzUmxvdW1zZG8zUlFCUi9rSlZX?=
 =?utf-8?B?UVZSUnNFQW5mV3RuUlREOElMZ1hQbWY5R0toaWJZR0Z1L09QK05tSjQ0L0hX?=
 =?utf-8?B?VEdUWUVtSElnUitsaWNlWVFDTU5VVVNXTHMwUTBhMEVERSttK3l3UzRVYWJs?=
 =?utf-8?B?bGF6bFZwejFKWW1HSU9LajJvbGlRTUVteFVTY3ZiWHRZTHE3UmZ2dXlLVUVY?=
 =?utf-8?B?eFExMjQ1VUpSUGJ6aG05VDVabVAyeWVlSER4ZlZzOXlGTVQwYmorT1dzZ3Ur?=
 =?utf-8?B?SjFOejBaR3NFc2ZFVTNBaDRmbmEwWVVzUlpRU3BVZWhDSDRoTzhUdjhUbHBK?=
 =?utf-8?B?YUJyQ3JMbVUwc1FEeHpxaHo4S0l6WW03Tmh5ZkJTUDJxODVDY2QzU1IrVVMr?=
 =?utf-8?B?ZnJhOEFCeXZraXhZVXhWVVlhVjBUSi9rUVE2alNXbmFkbExrN0tNU01rdURx?=
 =?utf-8?B?M0JkcFFrUCswSmk5Y0JhRElROEhDU3YxTDlmTkJ1NWg4N3Y1S25SdExRdGFW?=
 =?utf-8?B?aEdNRitwKzB6MWxsV2xqaHhWaFVuV2ZBZHVkbVl3NG5ZOE1rMUE5UXRFSEtS?=
 =?utf-8?B?RHZZcytCbTE5TFp6N1VVZERxNkh4UkM1RStZR3hhcGRwNGQ1RXV6SklMVDBi?=
 =?utf-8?B?Y0ZEdmt1RUtEeVlzTFFhNEYzY2pBLy8wUEdiZDlPaHVFT1BpcFQreFg5VTgx?=
 =?utf-8?B?TC9tYzlzWUZpZFI4czBkUnd1aFkydzRXN3RySTF3TU1CSVhzWC9UM0V3bTdi?=
 =?utf-8?B?N2dNNlR6YzNFaHM5YTRKeERDTkpJRnkweThENm5FcUNhcis5SC9jbG9IWktO?=
 =?utf-8?B?Z1hReldXODZFZjBEbEN4VXI3bnoxRUp0Vm1KQmlkMXJ0Y0VTa2ZwT3BQdE1I?=
 =?utf-8?B?V1dxUVRUMFcvdXBiNjZzc1VXYUtwbmwvdFR1dkJOcVk5ZkIxU2VIMU5zYXRi?=
 =?utf-8?Q?41CHtRvEyV9Dw1LDFqD/ziw+7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d586b1-746b-426e-cdc7-08dc2ba42e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 08:25:33.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8ZbsFSBXbpacpSAesueQ1JSRp6tyhtF2hZ2kfehsmEb22muz+3KrDDaxKNguY5Jfd7w53XkZtjxI+wNBGaAzgPX5TxjSguckC8GhqOTO/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7722
X-OriginatorOrg: intel.com

PiBIaSBLaXJpbGwsDQo+IA0KPiBPbiBTYXQsIEZlYiAzLCAyMDI0IGF0IDExOjEy4oCvQU0gSmFz
b24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IHdyb3RlOg0KPiA+IFllYSwgYWN0dWFs
bHksIEkgaGFkIGEgcHJldHR5IHNpbWlsYXIgaWRlYSBmb3Igc29tZXRoaW5nIGxpa2UgdGhhdA0K
PiA+IHRoYXQncyB2ZXJ5IG5vbi1pbnZhc2l2ZSwgd2hlcmUgbm9uZSBvZiB0aGlzIGV2ZW4gdG91
Y2hlcyB0aGUgUkRSQU5EDQo+ID4gY29yZSBjb2RlLCBtdWNoIGxlc3MgcmFuZG9tLmMuIFNwZWNp
ZmljYWxseSwgd2UgY29uc2lkZXIgImFkZGluZyBzb21lDQo+ID4gZXh0cmEgUkRSQU5EIHRvIHRo
ZSBwb29sIiBsaWtlIGFueSBvdGhlciBkcml2ZXIgdGhhdCB3YW50cyB0byBhZGQgc29tZQ0KPiA+
IG9mIGl0cyBvd24gc2VlZHMgdG8gdGhlIHBvb2wsIHdpdGggYWRkX2RldmljZV9yYW5kb21uZXNz
KCksIGEgY2FsbCB0aGF0DQo+ID4gbGl2ZXMgaW4gdmFyaW91cyBkcml2ZXIgY29kZSwgZG9lc24n
dCBpbmZsdWVuY2UgYW55IGVudHJvcHkgcmVhZGluZXNzDQo+ID4gYXNwZWN0cyBvZiByYW5kb20u
YywgYW5kIGNhbiBzYWZlbHkgYmUgc3ByaW5rbGVkIGluIGFueSBkZXZpY2Ugb3INCj4gPiBwbGF0
Zm9ybSBkcml2ZXIuDQo+ID4NCj4gPiBTcGVjaWZpY2FsbHkgd2hhdCBJJ20gdGhpbmtpbmcgYWJv
dXQgaXMgc29tZXRoaW5nIGxpa2U6DQo+ID4NCj4gPiB2b2lkIGNvY29fbWFpbl9ib290dGltZV9p
bml0X2Z1bmN0aW9uX3NvbWV3aGVyZV9kZWVwX2luX2FyY2hfY29kZSh2b2lkKQ0KPiA+IHsNCj4g
PiAgIC8vIFsuLi5dDQo+ID4gICAvLyBicmluZyB1cCBwcmltYXJ5IENvQ28gbnV0cw0KPiA+ICAg
Ly8gWy4uLl0NCj4gPg0KPiA+ICAgLyogQ29DbyByZXF1aXJlcyBhbiBleHBsaWNpdCBSRFJBTkQg
c2VlZCwgYmVjYXVzZSB0aGUgaG9zdCBjYW4gbWFrZSB0aGUNCj4gPiAgICAqIHJlc3Qgb2YgdGhl
IHN5c3RlbSBkZXRlcm1pbmlzdGljLg0KPiA+ICAgICovDQo+ID4gICB1bnNpZ25lZCBsb25nIHNl
ZWRbMzIgLyBzaXplb2YobG9uZyldOw0KPiA+ICAgc2l6ZV90IGksIGxvbmdzOw0KPiA+ICAgZm9y
IChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc2VlZCk7IGkgKz0gbG9uZ3MpIHsNCj4gPiAgICAgbG9u
Z3MgPSBhcmNoX2dldF9yYW5kb21fbG9uZ3MoJnNlZWRbaV0sIEFSUkFZX1NJWkUoc2VlZCkgLSBp
KTsNCj4gPiAgICAgLyogSWYgUkRSQU5EIGlzIGJlaW5nIERvUydkLCBwYW5pYywgYmVjYXVzZSB3
ZSBjYW4ndCBlbnN1cmUNCj4gPiAgICAgICogY29uZmlkZW50aWFsaXR5Lg0KPiA+ICAgICAgKi8N
Cj4gPiAgICAgQlVHX09OKCFsb25ncyk7DQo+ID4gICB9DQo+ID4gICBhZGRfZGV2aWNlX3JhbmRv
bW5lc3Moc2VlZCwgc2l6ZW9mKHNlZWQpKTsNCj4gPiAgIG1lbXplcm9fZXhwbGljaXQoc2VlZCwg
c2l6ZW9mKHNlZWQpKTsNCj4gPg0KPiA+ICAgLy8gWy4uLl0NCj4gPiAgIC8vIGRvIG90aGVyIENv
Q28gdGhpbmdzDQo+ID4gICAvLyBbLi4uXQ0KPiA+IH0NCj4gPg0KPiA+IEkgd291bGQgaGF2ZSBu
byBvYmplY3Rpb24gdG8gdGhlIENvQ28gcGVvcGxlIGFkZGluZyBzb21ldGhpbmcgbGlrZSB0aGlz
DQo+ID4gYW5kIHdvdWxkIGdpdmUgaXQgbXkgQWNrLCBidXQgbW9yZSBpbXBvcnRhbnRseSwgbXkg
QWNrIGZvciB0aGF0IGRvZXNuJ3QNCj4gPiBldmVuIG1hdHRlciwgYmVjYXVzZSBhZGRfZGV2aWNl
X3JhbmRvbW5lc3MoKSBpcyBwcmV0dHkgaW5ub2N1b3VzLg0KPiA+DQo+ID4gU28gS2lyaWxsLCBp
ZiBub2JvZHkgZWxzZSBoZXJlIG9iamVjdHMgdG8gdGhhdCBhcHByb2FjaCwgYW5kIHlvdSB3YW50
IHRvDQo+ID4gaW1wbGVtZW50IGl0IGluIHNvbWUgc3VwZXIgbWluaW1hbCB3YXkgbGlrZSB0aGF0
LCB0aGF0IHdvdWxkIGJlIGZpbmUNCj4gPiB3aXRoIG1lLiBPciBtYXliZSB3ZSB3YW50IHRvIHdh
aXQgZm9yIHRoYXQgaW50ZXJuYWwgaW5xdWlyeSBhdCBJbnRlbCB0bw0KPiA+IHJldHVybiBzb21l
IGFuc3dlcnMgZmlyc3QuIEJ1dCBlaXRoZXIgd2F5LCB0aGlzIG1pZ2h0IGJlIGFuIGVhc3kNCj4g
PiBhcHByb2FjaCB0aGF0IGRvZXNuJ3QgYWRkIHRvbyBtdWNoIGNvbXBsZXhpdHkuDQo+IA0KPiBJ
IHdlbnQgYWhlYWQgYW5kIGltcGxlbWVudGVkIHRoaXMganVzdCB0byBoYXZlIHNvbWV0aGluZyBj
b25jcmV0ZSBvdXQgdGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDIw
OTE2NDk0Ni40MTY0MDUyLTEtSmFzb25AengyYzQuY29tLw0KPiANCj4gSSBwcm9iYWJseSBzY3Jl
d2VkIHVwIHNvbWUgeDg2IHBsYXRmb3JtIGNvbnZlbnRpb25zL2RldGFpbHMsIGJ1dA0KPiB0aGF0
J3MgdGhlIGdlbmVyYWwgaWRlYSBJIGhhZCBpbiBtaW5kLg0KPiANCg0KVGhhbmsgeW91IEphc29u
IQ0KSSB3YW50IHRvIGJyaW5nIGFub3RoZXIgcG90ZW50aWFsIGlkZWEgaGVyZSBmb3IgYSBkaXNj
dXNzaW9uLCB3aGljaCBQZXRlciBBbnZpbg0KcHJvcG9zZWQgaW4gb3VyIGludGVybmFsIGRpc2N1
c3Npb25zLCBhbmQgSSBsaWtlIGl0IGNvbmNlcHR1YWxseSBiZXR0ZXINCnRoYW4gYW55IG9wdGlv
bnMgd2UgZGlzY3Vzc2VkIHNvIGZhciBzaW5jZSBpdCBpcyBtdWNoIG1vcmUgZ2VuZXJpYy4gDQoN
CldoYXQgaWYgd2UgaW5zdGVhZCBvZiBkb2luZyBzb21lIHNwZWNpYWwgdHJlYXRtZW50IG9uIHJk
cmFuZC9zZWVkLCB3ZQ0KdHJ5IHRvIGZpeCB0aGUgdW5kZXJuZWF0aCBwcm9ibGVtIG9mIExpbnV4
IFJORyBub3Qgc3VwcG9ydGluZyBDb0NvIHRocmVhdA0KbW9kZWwuIExpbnV4IFJORyBoYXMgYWxt
b3N0IHNldCBpbiBzdG9uZSBkZWZpbml0aW9uIG9mIHdoYXQgc291cmNlcyBjb250cmlidXRlDQpl
bnRyb3B5IGFuZCB3aGF0IGRvbuKAmXQgKHdpdGggc29tZSBhZGRpdGlvbmFsIGZsZXhpYmlsaXR5
IHdpdGggZmxhZ3MgbGlrZSB0cnVzdF9jcHUpLg0KVGhpcyB3b3JrcyB3ZWxsIGZvciB0aGUgY3Vy
cmVudCBmaXhlZCB0aHJlYXQgbW9kZWwsIGJ1dCBkb2VzbuKAmXQgd29yayBmb3INCkNvQ28gYmVj
YXVzZSBzb21lIHNvdXJjZXMgYXJlIHN1ZGRlbmx5IG5vdCB0cnVzdGVkIGFueW1vcmUgdG8gY29u
dHJpYnV0ZQ0KZW50cm9weS4gSG93ZXZlciwgc29tZSBhcmUgc3RpbGwgdHJ1c3RlZCBhbmQgdGhh
dCBpcyBub3QganVzdCByZHJhbmQvcmRzZWVkLA0KYnV0IHdlIHdvdWxkIGFsc28gdHJ1c3QgYWRk
X2h3Z2VuZXJhdG9yX3JhbmRvbW5lc3MgKGdpdmVuIHRoYXQgd2UgdXNlDQpURUUgSU8gZGV2aWNl
IGhlcmUgb3IgaGF2ZSBhIHdheSB0byBnZXQgdGhpcyBpbnB1dCBzZWN1cmVseSkuIFNvLCBldmVu
IGluDQp0aGVvcmV0aWNhbCBzY2VuYXJpbyB0aGF0IGJvdGggcmRyYW5kL3Jkc2VlZCBpcyBicm9r
ZW4gKGxldCdzIHNheSBIVyBmYWlsdXJlKSwNCmEgTGludXggUk5HIGNhbiBhY3R1YWxseSBib290
IHNlY3VyZWx5IGluIHRoZSBndWVzdCBpZiB3ZSBoYXZlIGVub3VnaA0KZW50cm9weSBmcm9tIGFk
ZF9od2dlbmVyYXRvcl9yYW5kb21uZXNzLg0KDQpTbyB0aGUgY2hhbmdlIHdvdWxkIGJlIGFyb3Vu
ZCBhZGRpbmcgdGhlIG5vdGlvbiBvZiBjb25kaXRpb25hbCBlbnRyb3B5DQpjb3VudGluZyAod2Ug
d2lsbCBhbHdheXMgdGFrZSBpbnB1dCBhcyB3ZSBkbyBub3cgYmVjYXVzZSBpdCB3b250IGh1cnQp
LA0Kd2hpY2ggd291bGQgYXV0b21hdGljYWxseSBnaXZlIHVzIGEgY29ycmVjdCBiZWhhdmlvciBp
biBfY3JlZGl0X2luaXRfYml0cygpDQpmb3IgaW5pdGlhbCBzZWVkaW5nIG9mIGNybmcuIEFsc28g
d2UgbmVlZCB0byBoYXZlIGEgZ2VuZXJpYyB3YXkgdG8gc3RvcCB0aGUNCmJvb3QgaWYgdGhlIGVu
dHJvcHkgaXMgbm90IGluY3JlYXNpbmcgKGZvciBhbnkgcmVhc29ucykgYW5kIHByZXZlbnQgYm9v
dGluZw0Kd2l0aCBpbnNlY3VyZWx5IHNlZWRlZCBjcm5nLiANCg0KSSBkbyB1bmRlcnN0YW5kIHRo
YXQgdGhpcyBpcyBnb2luZyB0byBiZSBtdWNoIGJpZ2dlciBjaGFuZ2UgdGhhbiBhbnl0aGluZyB3
ZQ0KYXJlIGRpc2N1c3Npbmcgc28gZmFyLCBidXQgY29uY2VwdHVhbGx5IGl0IHNvdW5kcyByaWdo
dCB0byBiZSBhYmxlIHRvIGhhdmUgYSBzYXkNCndoYXQgc291cmNlcyBvZiBlbnRyb3B5IG9uZSB0
cnVzdHMgaW4gcnVudGltZSAocHJvYmFibHkgYXBwbGljYWJsZSBiZXlvbmQNCkNvQ28gaW4gdGhl
IGZ1dHVyZSBhbHNvKSBhbmQgd2hhdCBpcyB0aGUgYWN0aW9uIHdoZW4gd2UgY2Fubm90IGNvbGxl
Y3QgdGhlDQplbnRyb3B5IGZyb20gdGhlc2Ugc291cmNlcy4gDQoNCldoYXQgZG9lcyBldmVyeW9u
ZSB0aGluaz8gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hLg0KDQoNCg0KDQo=

