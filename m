Return-Path: <linux-kernel+bounces-49366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3162846937
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7F21F24DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA56179AE;
	Fri,  2 Feb 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPywmAG7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284617996
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858755; cv=fail; b=CPnoSnPHVmjr97jddIX4PgjPOlzHRONPWn0EnM3gGNGNnvlhje6ukpqBE4n09+1vqrhpP0RMdgMKGkNTnWdZ6n9vOc1sSS8RX9F0hnHE9oetkWGRyAIOzkdoQ+lYe/IkeLzVHk4PdF2vT/3/Pv4a9PeM4Q88+DOJdbcFjG2xCeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858755; c=relaxed/simple;
	bh=Sc3A4PQjhllBDJpLtx4tdCb7VCSbOcZ8shzDciabs10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7TOc5BA9wtj4RIQ2p0Sg2nN+k145K40sJpBS307sDpiJDBX4POjgrt4KMtRI4NL/gMBLNhRcC/f9tsRCwCCU3/aQcJNsZVPhg7ZAPdfL9b//k1C5v4yKqFUBqG0x4FiRVc2Q/iS0d5o908i1+igCojYMPMAGvHJCPeis7Zj8So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPywmAG7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706858753; x=1738394753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sc3A4PQjhllBDJpLtx4tdCb7VCSbOcZ8shzDciabs10=;
  b=HPywmAG7iODokTba+z1oSbHRkXv0U86FTrCzp4zaBVO1C2DEbYDpu+cw
   Tu9d950v71Ps6aa+QknfvQ+rLDcbONx5XcX6OfIgRqJD7wUKqc2S7EEdl
   S4skh/YpWoPC0cL1jvFfAT2XkjT/gynZYShONEn9/3LsNk3m8XD7RESnD
   7hFtWodiHSVihoWvHtHxGPn+eiaJ95j/+savrNq0NrDyQ8oVCQ/LTcgX4
   aI5lttldlN3rK/Qq5yhzTSawbbNiD+Q3IgjRaKjXUvIHi4s8gXUKVFyne
   NT5cdlveIinbdcoKyAoyPHK+1Ir+ZjhUejIfvACkY8HuhE9LMXBWDJu+c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17477216"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="17477216"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 23:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="37421614"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 23:25:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 23:25:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 23:25:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 23:25:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 23:25:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faAh3YTiQ23HTmbmEGYMCF0OAzJEwaf0JzEFlf9Op2ycs+Fv+N0xhHCXhqvMVhJnins1kNhC/HpFOKlLMOYXM+lAcTEVc7SvGiC8AvEqWl173JfVnMFEJakShDIaefl2+w3uJcI0tT3n+eGktSFok9mF3CVr8Pfv0sqMiroV2i02zf9BlNUOJgTISkUpj6WupMB0i8kdr8GWvUpJvECIq+CRCucikQWRRxAEM5ldi0b43ZlQ2zbnOYN7qfyB7dCNjIqiHBW2l6xz2iTgns3NGeY3IfI2t0t/bUR5EskH7CQ0YdeGAJ/cbvcPAr1tdYmP5kdkoLaEGjzPvEArR81daQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc3A4PQjhllBDJpLtx4tdCb7VCSbOcZ8shzDciabs10=;
 b=SE1XE4iZi7eMHTfiN7g+9vBud7+bAayXZzlZPhr87TUN36JzlP+SMRc91Q1y3VPT8Q/tKXB6VISuDJNQHVL7Tjtmbx0Kov/wEBwcsEFxwjHmD+8E+juWv5l0CH5GF1bJDmmFcV6x3N2K5cHSYxMulmNU3/0JnV2nAlXtaZ+PbC2B2sfHK9/4cmjz5fa1xsECclZtvHowG4FXH3gl/ypP5oNjaOMqI/qAqDlmrGgamOR9UFbUPySUaF1QlF4BHSK0N0g7fe4F8nFLKTgHyoz0ZznH/rzpCJXL79Jy4bTFdzVHeFBgeUOBJEefPWX8cfvBV3TU0l4Uguq6TYVp1tybdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 07:25:43 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:25:43 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	Dave Hansen <dave.hansen@linux.intel.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org"
	<x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AIAACBOAgAC3UwCAAN1RgIAA2w+A
Date: Fri, 2 Feb 2024 07:25:42 +0000
Message-ID: <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
In-Reply-To: <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|BN9PR11MB5306:EE_
x-ms-office365-filtering-correlation-id: 9b283cad-881e-4f5e-31d3-08dc23c02a46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaESdrf6BwM9R/D6jYfOK/PeX1YhKEqni/X476pC3KIS5IdJGuCsQzFHnahnqDmZnT5lz84E9nxmhg8/ymhBtwqSTBhehUzpyD8VBGnjDGCu/kLznP3VAq6Lda1r44ICek+6nngFZepg3R28hZ9BCJHo4I4qWjWbwiA534cZQp1/7D41/Za+ydNQEGKx2hfVxdhz8gjjBsvvo2+QTkBGpemqimnbq9ybPRfIsaPfaFrQIjPZMqLUgCMK4EgApjFPkNEQoaBe1SKmrrxptjWGMVrPzRdNcyVeAJ+obZOLJcu0/7viTaa+VzknqUseDG1yNE1r+1FbFttqJvSzPz1o2zob77PFR9WNB8fmtUOvmXk+Q4d0rv6APFtN3onNMJwUTP/pCnkOs8NKUdS7QOHB73M5qcu3bgd1Qxq19WYPGfouy7XIturmu1oFGJwHgjgvVlVp9RiG/ht5DUSm8Ki9YuBhbtW2CWmqsA526AjayVdhSxKHwTVgAfpAnQXlZOIAZM8QhpIce5Vj800UJu45gRVZzLLIghPYLFxx7hU9IyKnrgb4vDNqKRqNyjoMC5J/0CMugFcT5RXvWG7/BlBqpAFb9yE8hpm2dQ9kM+S6IVsOfFbJozvDV+FHT5oKCeKY7z/Fp53OENZmV/1N7UocZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230373577357003)(230473577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(7696005)(6506007)(966005)(76116006)(66476007)(7416002)(26005)(5660300002)(9686003)(83380400001)(66446008)(66946007)(2906002)(4326008)(478600001)(54906003)(8676002)(8936002)(66899024)(316002)(52536014)(64756008)(71200400001)(38100700002)(53546011)(110136005)(66556008)(122000001)(86362001)(82960400001)(33656002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2dVbTB5bXJkSmZrL2dvUytrNmZOZzdjL3hQNFRCNUdNMFRJTkJBaUpPZzEx?=
 =?utf-8?B?UXFWVFM5cGdBZDBiMmFjaDVuRDdsVUZSWDNnY0F3Q2VVSFhGZGV4d2R5QWZU?=
 =?utf-8?B?WDYvTzcwdHhGZjJnWTJlLzJkNnpQb0grLzVKUmNXSnAvMVl1MWVEM2JxNi93?=
 =?utf-8?B?Q1NaSGtia1hNRnNNZWxJMHdrdCsvUHBJNjlTcHBvSlp5WW1BcnEwMjl5R05H?=
 =?utf-8?B?eG9Lem5RcTFETGthVjJqbXo5aVNuQ25BYnFUZXg2eFYwb0NMSERIK01hNVd2?=
 =?utf-8?B?NFlHMEY0dkxlVjMycU14RUhiWXYwVGFWQ3JBajhCekVQRmtIVkkwRUhHVEkz?=
 =?utf-8?B?NGUwKytkRDdrZXVyVEcrS2V3OU45VG52a2NZV01ocnRxMkxlOUwxeFJsdTVh?=
 =?utf-8?B?RlFyYXdzanNTM05HeUZHV043MHpXSkI1N0UrYVJpTzE5cWNYR2YyNGZCc1lK?=
 =?utf-8?B?VHVWRnJIVFhaR2xLdEFjbjFQc1NLYmhOWUhZbEJzK0x2MGZMRDJEOXhWM0o5?=
 =?utf-8?B?VDllYlhXQm15RS9YN1dBdU1odnd6WGM1TkxjK0cvZ21qeVMwSE91aUlYelJW?=
 =?utf-8?B?ZzVMRGxoTWZuOWtvY09TRlRUSFVVemNjbW9Db3g5cWFkNTBqWDQzQjVjRDNC?=
 =?utf-8?B?QnA4dzJPaDlrRHRZdDFpVm5WeXlpOUF6aFJoWkwzNU1NK09VUVhFRGl4MTV3?=
 =?utf-8?B?VHJnMzZFaHJZdEQrV1lIMmpBWktsZmJ3YUNtSVZES1YwSno3VEh5MW5iV096?=
 =?utf-8?B?YkVYYTRlbEhnMzRLQktVZVEyOEdiWk9PczBtb3VBaUJReDJLcVVBL3c0aHp2?=
 =?utf-8?B?YUVUOFZqMS9UbThaMFBqS21OQVMwN1dtcy9XZ3RLNWNsVW5tNlVjQjRYYmIx?=
 =?utf-8?B?bkxSVmQ3ZG5GbjNUN3QvaGZLcGN5ZUUvQ05DTk1qZHYxc0h6SEVrQzd0Z0tT?=
 =?utf-8?B?TWVsbVhyV0F3WFJway9NYys5akNXcXVIUGlyY3RKUUZqY0oxWmJ1WEZHaTNE?=
 =?utf-8?B?azNqc0lGMUthS1dqSU1pallZRjBsdmxua3RPNUNUYkU2MTZzM2tIM2pXNHdV?=
 =?utf-8?B?YTB3OS80dDRLUm1hZGhZZFdPdTljaVZQZmMrQjNhd0hBbWdyaTVvVktHUEdO?=
 =?utf-8?B?U3VkQmhPcWdNWTN6bUNORVB2dUU2bERXOEZMU1BhODh0Zlplc3FtdjVVcUFr?=
 =?utf-8?B?ckQyazdBTzNLRi9JZ1pEc2dJVjNBQVMxQmYzWjBWNTFrb1hIUTgvVEFqdDUz?=
 =?utf-8?B?NGt0ZUhGZWc0YkhoemRFZ2JudnIzbzJPenNobkxMdklxZVF5TnNHck5TS09w?=
 =?utf-8?B?K1pOeDRqd3lMWjUwQ2M3cVloQTVOK0N3c0RGZWpjcVNPZ25yc1l5MW42U2hB?=
 =?utf-8?B?UnNHcTdZSVVBcEx3S0xnc0FhakJVNE8vYlQ0cllndW5weUkrNzVrelNBSjJI?=
 =?utf-8?B?WERyVXczSGh2MUdnVXBUNVVsYzZNMTBDYy9HQ0V3TndPQjFDbHg1SU9URXdp?=
 =?utf-8?B?enF2ZExQY0R4YmxRSXZpSVhUeDZXN0JuYWNZNmhoSFNsdnVBSDZ4YVVSZjhu?=
 =?utf-8?B?a2FEOGY3R044VS96SWphRjdwZHlXeXBWUTdxWTdVR1pHSTdYVDlzWjRwTUpD?=
 =?utf-8?B?ZXBHTlJqNUNkRzhxQzZNTGVrYmJ6bDdiZjg1bEJlYzF2ZzhhWTlvVFg4UVhz?=
 =?utf-8?B?U2RyTEJoMldtTHJQOTJJUFlTWE1vaE0xR0UvUFU2R1NwR05jMUdQa3BZTUFC?=
 =?utf-8?B?OFE3MENualhnamJZTUREUnRDSy9ranZSazIwWW1nKzRIUTNoRmNqMXJqOGF4?=
 =?utf-8?B?ME5MWXl1MXM4dzI3RHFoTVdFSmJML09sQUd1VVhmakFEdmNqTWhIQXlrNE1B?=
 =?utf-8?B?MnVNU05FbVQweHUwZkcyZG5kWnFWVnZkS05CRGV6M3hPT0RzaW1ueU1YTWxr?=
 =?utf-8?B?dFRDSkhoTDZNOXEvREJJajk5VDgxOWFaVWo4NFNkM0tJazZ2UEdHZDZqckta?=
 =?utf-8?B?U3lucnlqVWZScG1IUFFvRGx2UlRHcjZSUXNERFQrRXJzREwxTnM4azAzVXZX?=
 =?utf-8?B?WmdCSncwYk5qc0tKVHVJejlsUFA4bjlxeXVnd004Q3NlaGd4UGJ6dEtiUHhH?=
 =?utf-8?Q?gr/Q3vayO5k4d0lA/6aUd3YSF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b283cad-881e-4f5e-31d3-08dc23c02a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 07:25:42.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOY3cwjS8PGdY2aguv6YrEYMW3RSiFXNRN+1/8sOuojphihCfTvdgpm01meOoFZzpojHmPsXDN4/zqMg0JMcpyRRiEKeDhMA8idjNJT+FhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-OriginatorOrg: intel.com

DQo+IEhpIFRlZCwgRWxlbmEsIERhdmUsDQo+IA0KPiBPbiBUaHUsIEZlYiAxLCAyMDI0IGF0IDU6
NTfigK9BTSBUaGVvZG9yZSBUcydvIDx0eXRzb0BtaXQuZWR1PiB3cm90ZToNCj4gPg0KPiA+IE9u
IFdlZCwgSmFuIDMxLCAyMDI0IGF0IDA3OjAxOjAxUE0gKzAxMDAsIEphc29uIEEuIERvbmVuZmVs
ZCB3cm90ZToNCj4gPiA+IFNvIGlmIHRoaXMgaXMgd2hhdCB3ZSdyZSBjb25nZWFsaW5nIGFyb3Vu
ZCwgSSBndWVzcyB3ZSBjYW46DQo+ID4gPg0KPiA+ID4gMCkgTGVhdmUgUkRTRUVEIGFsb25lIGFu
ZCBmb2N1cyBvbiBSRFJBTkQuDQo+ID4gPiAxKSBBZGQgYFdBUk5fT05fT05DRShpbl9lYXJseV9i
b290KTtgIHRvIHRoZSBmYWlsdXJlIHBhdGggb2YgUkRSQU5EDQo+ID4gPiAoYW5kIHNpbXBseSBo
b3BlIHRoaXMgZG9lc24ndCBnZXQgZXhwbG9pdGVkIGZvciBndWVzdC1ndWVzdCBib290IERvUyku
DQo+ID4gPiAyKSBMb29wIGZvcmV2ZXIgaW4gUkRSQU5EIG9uIENvQ28gVk1zLCBwb3N0LWJvb3Qs
IHdpdGggdGhlIGNvbW1lbnRzDQo+ID4gPiBhbmQgdmFyaWFibGUgbmFtaW5nIG1ha2luZyBpdCBj
bGVhciB0aGF0IHRoaXMgaXMgYSBoYXJkd2FyZSBidWcNCj4gPiA+IHdvcmthcm91bmQsIG5vdCBh
ICJmZWF0dXJlIiBhZGRlZCBmb3IgImV4dHJhIHNlY3VyaXR5Ii4NCj4gPiA+IDMpIENvbXBsYWlu
IGxvdWRseSB0byBJbnRlbCBhbmQgZ2V0IHRoZW0gdG8gZml4IHRoZSBoYXJkd2FyZS4NCj4gPiA+
DQo+ID4gPiBUaG91Z2gsIGEgbGFyZ2UgcGFydCBvZiBtZSB3b3VsZCByZWFsbHkgbGlrZSB0byBz
a2lwIHRoYXQgc3RlcCAoMiksDQo+ID4gPiBmaXJzdCBiZWNhdXNlIGl0J3MgYSBwcmV0dHkgZ3Jv
c3MgYmFuZGFpZCB0aGF0IGFkZHMgbG90cyBvZg0KPiA+ID4gY29tcGxleGl0eSwgYW5kIHNlY29u
ZCBiZWNhdXNlIGl0J2xsIG1ha2UgKDMpIGxlc3MgcG9pZ25hbnQNCj4gPg0KPiA+IElmIHdlIG5l
ZWQgdG8gbG9vcCBtb3JlIHRoYW4sIHNheSwgMTAgc2Vjb25kcyBpbiBhIENvQ28gVk0sIEknZCBq
dXN0DQo+ID4gcGFuaWMgd2l0aCBhIHJlcGVhdGVkIFJEUkFORCBmYWlsdXJlIG1lc3NhZ2UuICBU
aGlzIG1ha2VzIHRoZSBwb2ludCBvZg0KPiA+ICgzKSB0aGF0IG11Y2ggcG9pbnRlZCwgYW5kIGl0
J3MgYmV0dGVyIHRoYW4gaGF2aW5nIGEgQ29DbyBWTQ0KPiA+IG15c3RlcmlvdXNseSBoYW5nIGlu
IHRoZSBmYWNlIG9mIGEgRE9TIGF0dGFjay4NCj4gDQo+IFllYSwgdHJ1ZS4gUHJvYmxlbSBpcyB0
aGF0IGluIHRoZW9yeSwgdXNlcnNwYWNlIGNhbiBEb1MgdGhlIGtlcm5lbCdzDQo+IHVzZSBvZiBS
RFJBTkQuIE9mIGNvdXJzZSBpbiBwcmFjdGljZSwgYSB1c2Vyc3BhY2UgcHJvY2VzcyBwcmVlbXB0
aW5nIGENCj4ga3RocmVhZCBmb3IgPjEwIHNlY29uZHMgaXMgcHJvYmFibHkgYSBsYXJnZXIgcHJv
YmxlbS4NCj4gDQo+IEFueXdheSwgSSB3YW50IHRvIGxheSBvdXQgdGhlIHZhcmlvdXMgcG90ZW50
aWFsIHNvbHV0aW9ucyBkaXNjdXNzZWQuDQo+IEFzIHRoZXkgYWxsIGhhdmUgc29tZSBkcmF3YmFj
aywgaXQncyB3b3J0aCBlbnVtZXJhdGluZyB0aGVtLg0KPiANCj4gPT0NCj4gDQo+IFNvbHV0aW9u
IEEpIFdBUk5fT05fT05DRShpc19lYXJseV9ib290KS9CVUdfT04oaXNfZWFybHlfYm9vdCkgaW4g
dGhlDQo+IFJEUkFORCBmYWlsdXJlIHBhdGggKD4gMTAgcmV0cmllcykuDQo+IA0KPiBUaGUgYmln
Z2VzdCBhZHZhbnRhZ2UgaGVyZSBpcyB0aGF0IHRoaXMgaXMgc3VwZXIgc2ltcGxlIGFuZCBpc24n
dA0KPiBDb0NvLXNwZWNpZmljLiBUaGUgcHJlbWlzZSBpcyB0aGF0IGlmIFJEUkFORCBmYWlscyAx
MCB0aW1lcyBpbiBhIHJvdw0KPiBiZWZvcmUgdXNlcnNwYWNlIGhhcyBzdGFydGVkLCBpdCdzIG1v
c3QgZGVmaW5pdGVseSBhIGhhcmR3YXJlIHByb2JsZW0uDQo+IFN5c3RlbXMtd2lzZSwgdGhlIGRy
YXdiYWNrIGlzIHRoYXQsIGluIGEgVk0sIGl0IGFsdGVybmF0aXZlbHkgbWlnaHQgYmUNCj4gYSBn
dWVzdC1ndWVzdCBEb1MgYXR0YWNrIG9uIFJEUkFORCwgb3IgaW4gdGhlIENvQ28gY2FzZSwgYSBo
b3N0LWd1ZXN0DQo+IERvUyBhdHRhY2sgKHdoaWNoIGlzIHByZXN1bWFibHkgZWFzaWVyIGJlY2F1
c2UgdGhlIGhvc3QgY29udHJvbHMNCj4gc2NoZWR1bGluZykuIEluIHRoZSBDb0NvIGNhc2UsIG5v
dCBib290aW5nIGlzIGJldHRlciB0aGFuIGxvc2luZw0KPiBjb25maWRlbnRpYWxpdHkuIEluIHRo
ZSBub24tQ29DbyBjYXNlLCB0aGF0IHNlZW1zIGxpa2UgdGhlb3JldGljYWxseSBhDQo+IERvUyB3
ZSBtaWdodCBub3Qgd2FudC4gUk5HLXdpc2UsIHRoZSBkcmF3YmFjayBpcyB0aGF0IHRoaXMgZG9l
c24ndA0KPiBoZWxwIGRlYWwgd2l0aCBzZWN1cmUgcmVzZWVkaW5nIGxhdGVyIGluIHRpbWUsIHdo
aWNoIGlzIGEgUk5HIHByb3BlcnR5DQo+IHRoYXQgd2Ugb3RoZXJ3aXNlIGVuam95Lg0KPiANCj4g
U29sdXRpb24gQikgQlVHX09OKGlzX2Vhcmx5X2Jvb3QgJiYgaXNfY29jb19zeXN0ZW0pIGluIHRo
ZSBSRFJBTkQNCj4gZmFpbHVyZSBwYXRoICg+IDEwIHJldHJpZXMpLg0KPiANCj4gVGhpcyBpcyBz
bGlnaHRseSBsZXNzIHNpbXBsZSB0aGFuIEEsIGJlY2F1c2Ugd2UgaGF2ZSB0byBwbHVtYg0KPiBD
b0NvLWRldGVjdGlvbiB0aHJvdWdoIHRvIHRoZSBSRFJBTkQgaGVscGVyLiBbU2lkZSBub3RlOiBJ
IGZlZWwNCj4gcmlkaWN1bG91cyB0eXBpbmcgJ0NvQ28nLl0gU3lzdGVtcy13aXNlLCBJIGRvbid0
IHNlZSBkcmF3YmFja3MuDQo+IFJORy13aXNlLCB0aGUgZHJhd2JhY2sgaXMgdGhhdCB0aGlzIGRv
ZXNuJ3QgaGVscCBkZWFsIHdpdGggc2VjdXJlDQo+IHJlc2VlZGluZyBsYXRlciBpbiB0aW1lLCB3
aGljaCBpcyBhIFJORyBwcm9wZXJ0eSB0aGF0IHdlIG90aGVyd2lzZQ0KPiBlbmpveS4NCj4gDQo+
IFNvbHV0aW9uIEMpIFdBUk5fT05DRSgpL0JVRygpIGluIHRoZSBSRFJBTkQgZmFpbHVyZSBwYXRo
ICg+IDEwIHJldHJpZXMpLg0KPiANCj4gVGhlIGFkdmFudGFnZSBoZXJlIGlzIGFsc28gc2ltcGxp
Y2l0eSwgYW5kIHRoZSBmYWN0IHRoYXQgaXQgImVuc3VyZXMiDQo+IHdlJ2xsIGJlIGFibGUgdG8g
c2VjdXJlbHkgcmVzZWVkIGxhdGVyIG9uLiBTeXN0ZW1zLXdpc2UsIHRoZSBkcmF3YmFjaw0KPiBp
cyB0aGF0IHVzZXJzcGFjZSBjYW4gaW4gdGhlb3J5IERvUyB0aGUga2VybmVsJ3MgUkRSQU5EIGFu
ZCBjYXVzZSBhDQo+IGNyYXNoLg0KPiANCj4gU29sdXRpb24gRCkgQlVHX09OKGlzX2NvY29fc3lz
dGVtKSBpbiB0aGUgUkRSQU5EIGZhaWx1cmUgcGF0aCAoPiAxMCByZXRyaWVzKS4NCj4gDQo+IFRo
aXMgaXMgc2xpZ2h0bHkgbGVzcyBzaW1wbGUgdGhhbiBBLCBiZWNhdXNlIHdlIGhhdmUgdG8gcGx1
bWINCj4gQ29Dby1kZXRlY3Rpb24gdGhyb3VnaCB0byB0aGUgUkRSQU5EIGhlbHBlciwgYnV0IGl0
ICJlbnN1cmVzIiB3ZSdsbCBiZQ0KPiBhYmxlIHRvIHNlY3VyZWx5IHJlc2VlZCBsYXRlciBvbi4g
U3lzdGVtcy13aXNlLCB0aGUgZHJhd2JhY2sgaXMgdGhhdA0KPiB1c2Vyc3BhY2UgY2FuIGluIHRo
ZW9yeSBEb1MgdGhlIGtlcm5lbCdzIFJEUkFORCBhbmQgY2F1c2UgYSBjcmFzaC4NCj4gDQo+IFNv
bHV0aW9uIEUpIEJVRygpIGluIGEgbmV3IHRpbWUtYmFzZWQgUkRSQU5EIGZhaWx1cmUgcGF0aCBv
biBDb0NvDQo+IHN5c3RlbXMgKD4gMTAgc2Vjb25kcykuDQo+IA0KPiBUaGlzIGFkZHMgYSBsb3Qg
b2YgY29tcGxleGl0eSwgYW5kIHdlJ2QgbmVlZCBzb21lIGFsdGVybmF0aXZlIGNvZGUNCj4gcGF0
aCBmb3IgQ29DbyB3aXRoIGFuIGluZmluaXRlIGxvb3AgdGhhdCBicmVha3Mgb24gYSBqaWZmaWVz
DQo+IGNvbXBhcmlzb24uIEJ1dCBpdCBhdCBsZWFzdCBtYWtlcyBpdCBoYXJkZXIgZm9yIHVzZXJz
cGFjZSB0byBEb1MgdGhlDQo+IGtlcm5lbCdzIHVzZSBvZiBSRFJBTkQsIGJlY2F1c2UgaXQgc2Vl
bXMgaGFyZCBmb3IgYSB1c2VyIHRocmVhZCB0bw0KPiBwcmVlbXB0IGEga3RocmVhZCBmb3IgdGhh
dCBsb25nLCB0aG91Z2ggbWF5YmUgc29tZWJvZHkgaGFzIHNvbWUgbmFzdHkNCj4gc2NoZWR1bGVy
IHRyaWNrcyBoZXJlIHRoYXQgd291bGQgYnJlYWsgdGhhdCBob3BlLg0KPiANCj4gU29sdXRpb24g
RikgTG9vcCBmb3JldmVyIGluIFJEUkFORCBvbiBDb0NvIHN5c3RlbXMuDQo+IA0KPiBUaGlzIG1h
a2VzIGRlYnVnZ2luZyBoYXJkZXIgYmVjYXVzZSBvZiBsb2NrdXBzICh0aG91Z2ggSSBzdXBwb3Nl
IHdlDQo+IGNvdWxkIFdBUk4gYWZ0ZXIgc29tZSBhbW91bnQgb2YgdGltZSksIGJ1dCBhdCBsZWFz
dCBpdCdzIHNvbWV3aGF0DQo+ICJzb3VuZCIuDQo+IA0KPiA9PQ0KDQpUaGlzIGlzIGEgZ3JlYXQg
c3VtbWFyeSBvZiBvcHRpb25zLCB0aGFuayB5b3UgSmFzb24hDQpNeSBwcm9wb3NhbCB3b3VsZCBi
ZSB0byB3YWl0IG9uIHJlc3VsdCBvZiBvdXIgaW50ZXJuYWwgaW52ZXN0aWdhdGlvbiANCmJlZm9y
ZSBwcm9jZWVkaW5nIHRvIGNob29zZSB0aGUgYXBwcm9hY2guIA0KDQo+IA0KPiBJIGFtIGN1cnJl
bnRseSBsZWFuaW5nIHRvd2FyZCAoQikgYXMgYmVpbmcgdGhlIGxpZ2h0ZXN0IHRvdWNoIHRoYXQg
aGFzDQo+IHRoZSBsZWFzdCBwb3RlbnRpYWwgdG8gYnJlYWsgYW55dGhpbmcuIChGKSBpcyBhbHNv
IHRlbXB0aW5nIGJlY2F1c2UgaXQNCj4gZG9lc24ndCBoYXZlIHRoZSBSTkctZHJhd2JhY2suIFRo
ZSBvdGhlcnMgc2VlbSBjb21wbGV4IG9yIGluY29tcGxldGUNCj4gb3Igb3RoZXJ3aXNlIGFubm95
aW5nIHNvbWVob3cuDQo+IA0KPiBUaGVyZSBpcyBhbHNvICJTb2x1dGlvbiBHIiAtLSBkbyBub3Ro
aW5nIGFuZCByYWlzZSBhIGZ1c3MgYW5kIGxldA0KPiBzZWN1cml0eSByZXNlYXJjaGVycyBnbyB0
byB0b3duIGFuZCBob3BlIEludGVsIGdldHMgdGhlaXIgYWN0DQo+IHRvZ2V0aGVyLiBHaXZlbiB0
aGF0IHRoZSBDb0NvIHRoaW5nIHNlZW1zIGtpbmQgb2YNCj4gaW1hZ2luYXJ5L2FzcGlyYXRpb25h
bCBhbnl3YXkgYXQgdGhpcyBwb2ludCwgSSdtIHZlcnkgYXR0cmFjdGVkIGJ5DQo+IHRoaXMuIEkg
ZG9uJ3QgbWVhbiB0byBzYXkgdGhhdCBJIGludGVuZCB0byBtb3VudCBhIGxhcmdlIGFyZ3VtZW50
IHRoYXQNCj4gd2UgKnNob3VsZCogZG8gbm90aGluZywgYnV0IGl0J3MganVzdCBzb3J0IG9mIHNp
dHRpbmcgdGhlcmUgaW4gdGhlDQo+IGJhY2sgb2YgbXkgbWluZCBhcyBhbiBhcHBlYWxpbmcgcG9z
c2liaWxpdHkuDQo+IA0KPiBBbHNvLCBJIHdhbnRlZCB0byBlbnVtZXJhdGUgY3VycmVudGx5IG9w
ZW4gcXVlc3Rpb25zOg0KPiANCj4gPT0NCj4gDQo+IFF1ZXN0aW9uIGkpIEp1c3QgaG93IGRldGVy
bWluaXN0aWMgY2FuIHRoZXNlIENvQ28gVk1zIGJlPyBFbGVuYQ0KPiBwb2ludGVkIHRvIHNvbWUg
VERYIGNvZGUgcmVnYXJkaW5nIFJEVFNDIHRoYXQgc2VlbWVkIGZhaXJseSBkYW1uaW5nLA0KPiBi
dXQgSSBhbHNvIHdvbmRlciB3aGF0IGdvdGNoYXMgYSBtb3RpdmF0ZWQgcmVzZWFyY2hlciBtaWdo
dCBydW4gaW50bw0KPiBhbmQgaG93IHRob3NlIGNvdWxkIGhlbHAgdXMgKG9yIG5vdCkuDQoNClRo
aXMgd291bGQgYmUgZ3JlYXQgaW1vIHRvIGhhdmUgYSBkaXNjdXNzaW9uIG9uLiBJIGRvbuKAmXQg
dGhpbmsgdGhlIGludGVybmFsDQpkZXNpZ24gb3IgaW1wbGVtZW50YXRpb24gb2YgVERYIG1vZHVs
ZSBpcyBjb21wbGljYXRlZCB0byBzY2FyZQ0KYW55b25lIG9mZi4gU28gSSB0aGluayBpdCB3b3Vs
ZCBiZSBhIHF1ZXN0aW9uIG9uIGhvdyBwcmFjdGljYWwgd291bGQNCmJlIGZvciBWTU0gdG8gbWFr
ZSBzdWNoIGFuIGF0dGFjayBvbiBndWVzdCBrZXJuZWw/IEEgbG90IG9mIHRpbWVzIHN1Y2gNCnRo
aW5ncyBhcmUgYWJvdXQgcHJlY2lzaW9uLCByZWxpYWJpbGl0eSBhbmQgYW4gYWJpbGl0eSB0byBm
aWx0ZXIgb3V0IHRoZSBub2lzZS4gIA0KU28gcXVlc3Rpb25zIGxpa2UgaG93IHByZWNpc2VseSAq
aW4gcHJhY3RpY2UqIGNhbiBWTU0gbWVhc3VyZSBndWVzdCdzDQp2aXJ0dWFsIFRTQyBhbmQgb3Ro
ZXIgcGFyYW1ldGVycyB0aGF0IGFyZSB1c2VkIGFzIGVudHJvcHkgaW5wdXRzPw0KDQpCdXQgb3Zl
cmFsbCBib3RoIGluIGNyeXB0byBhbmQgc2VjdXJpdHksIHdlIGRvbuKAmXQgbGlrZSB0byBiZSB0
b28gbmVhciB0aGUNCnNlY3VyaXR5IGJvdW5kcywgYmVjYXVzZSB3ZSBhbHdheXMgYXNzdW1lIG91
ciB1bmRlcnN0YW5kaW5nIG1pZ2h0IGJlDQppbmNvbXBsZXRlLCBzbyBwdXR0aW5nIGEgcmVhc29u
YWJsZSBhbmQgY2xlYXIgY291bnRlcm1lYXN1cmUgaXMgdXN1YWxseSB0aGUNCmJldHRlciBhcHBy
b2FjaC4gDQoNCj4gDQo+IFF1ZXN0aW9uIGlpKSBKdXN0IGhvdyBEb1MtYWJsZSBpcyBSRFJBTkQ/
IEZyb20gaG9zdCB0byBndWVzdCwgd2hlcmUNCj4gdGhlIGhvc3QgY29udHJvbHMgc2NoZWR1bGlu
ZywgdGhhdCBzZWVtcyBlYXNpZXIsIGJ1dCBob3cgbXVjaCBzbywgYW5kDQo+IHdoYXQncyB0aGUg
Z3JhbnVsYXJpdHkgb2YgdGhlc2Ugb3BlcmF0aW9ucywgYW5kIGNvdWxkIHJldHJpZXMgc3RpbGwN
Cj4gaGVscCwgb3Igbm90IGF0IGFsbD8gV2hhdCBhYm91dCBmcm9tIGd1ZXN0IHRvIGd1ZXN0LCB3
aGVyZSB0aGUNCj4gc2NoZWR1bGluZyBpcyBvdXQgb2YgY29udHJvbDsgaW4gdGhhdCBjYXNlIGlz
IHRoZXJlIGEgdmFsdWUgb2YgTiBmb3INCj4gd2hpY2ggTiByZXRyaWVzIG1ha2VzIGl0IGFjdHVh
bGx5IGltcG9zc2libGUgdG8gRG9TPyBXaGF0IGFib3V0IGZyb20NCj4gdXNlcnNwYWNlIHRvIGtl
cm5lbHNwYWNlOyBnb29kIHZhbHVlIG9mIE4/DQoNCkFsbCB2YWxpZCBxdWVzdGlvbnMgdGhhdCBJ
IGFtIGFsc28gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhlIGFuc3dlcnMuIA0KDQpCZXN0IFJlZ2Fy
ZHMsDQpFbGVuYS4NCg0KPiANCj4gUXVlc3Rpb24gaWlpKSBIb3cgbGlrZWx5IGlzIEludGVsIHRv
IGFjdHVhbGx5IGZpeCB0aGlzIGluIGENCj4gc2F0aXNmYWN0b3J5IHdheSAoc2VlICJzcGVjaWZ5
aW5nIHRoaXMgaXMgYW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24iIGluDQo+IFsxXSk/IEFuZCBpZiB0
aGV5IHdvdWxkLCB3aGF0IHdvdWxkIHRoZSB0aW1lbGluZSBldmVuIGJlPw0KPiANCj4gPT0NCj4g
DQo+IEFueXdheSwgdGhhdCdzIGFib3V0IHdoZXJlIEknbSBhdC4gSSBmaWd1cmUgSSdsbCB3YWl0
IHRvIHNlZSBpZiB0aGUNCj4gaW50ZXJuYWwgaW5xdWlyeSB3aXRoaW4gSW50ZWwgeWllbGRzIGFu
eXRoaW5nIGludGVyZXN0aW5nLCBhbmQgdGhlbg0KPiBtYXliZSB3ZSBjYW4gbW92ZSBmb3J3YXJk
IHdpdGggc29sdXRpb25zIChCKSBvciAoRikgb3IgKEcpIG9yIGENCj4gZGlmZmVyZW50IFJvYWxk
IERhaGwgbm92ZWwgaW5zdGVhZC4NCj4gDQo+IEphc29uDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL0NBSG1NRTlwczZXNXNuUXJZZU5WTUZnZmhNS0ZLY2lreT0tDQo+IFV4
eEdGYkF4X1JyeFNIb0FAbWFpbC5nbWFpbC5jb20vDQo=

