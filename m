Return-Path: <linux-kernel+bounces-1803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86AE81545A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9491C2419E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125C18EC7;
	Fri, 15 Dec 2023 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyrpPgR+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482F45BF1;
	Fri, 15 Dec 2023 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702681909; x=1734217909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7DXrBcV8Wj/1FT4OafDuCaJm9bWcVRAAPzWLJ2lqBgQ=;
  b=OyrpPgR+5TAQmkqTacE7TX+e8NTQBG8Ih1IaRfuGz6RPusIibMRYW/0a
   e/Q83nBJ2BS7K0OCjkRZ/Y8t4/ipAmDX/6smOWl37LZlVLddhOiye2UoE
   ekXMNLmQfHdJp3/XCZa2yFa5BAIG7sV5SVa9oTyInYR3+1xZAVNmXwJLO
   zvNrhpBObjZ+P63LEwQoZNxG8WbAJU1P+/6Pwn4f7Ul8yiOsoeVxBk59K
   mktGPUbyKr3yuEezEewKoKnJnqKFURsfn6G5GSzXE/+hct5KgwCi+AhGa
   +c8yy08i/QkaQsNy+fHWYLbK8LEUQGETin6VoBwpKJ1aUHxqxNZvPed+1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375492440"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="375492440"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="16447582"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 15:11:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 15:11:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 15:11:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 15:11:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BedvZFxlT65HAozZmFyg5laq2eXs85fqIDdslMkquP97ODChG5xopWald9kOZ6vrfi2d/+Uz3DstPsLqCra6JTP72hUf/YUau4KhpvL6ti7r35UDVTddZqGhnOrY5xIGvv0cnqyS8iP79MOLs6+4saUXBfIRPqMQMCSL8k80AMAvyQA13DLuhuBtfj6XygCVQ4d5ZC34M2M3viw7U8tTMF04Y9Abd2K9OTFXPDA4ywzDReH25+0lDXuZw/cl83u6ZJtYnGaNeqkFMXbHu0NF+vY2zo87f/a45sJKEbspeyLVK3s0kwWseSqmou6NOYjk1DQIeyZF7ML8xvv/r9EoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHb5su03aT+Cf/0wal073ZSoTsxqSiEpKo5j+fQLM58=;
 b=VHsrP6fHuFYoToZC+s/Hs+rtAhFK5kJq3hzqop17fwcSBy18ys9gT4v2unAadKIlBMcC4OeUhe8IR4wKAfO35CDwlv6gjSThPkALMSRcM6f9p/Z9E6Vj+dhwbUN6YmL5svxmbjjsbBflQ1/+y1VBGv8zf8w3GCXHbn+wsyCkbR7Hay+5jTTsLl8EeV0Kqt2L0em3gs9LK4Hb2locrs+CgBluXyqU/2fhSOcsdEsMAi9hK848UtIJ5n6sEuXTZgod+nEgG0boWuThZcCsho7vzSeJI90xwU6yC8yerkpz5DpY9ibTF4OHaCA8U3C/4gt6OH+nM8ZfMyD1Skya6ZNrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 23:11:46 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 23:11:46 +0000
Message-ID: <314eedc5-c27e-4e63-b74a-7b06f64fdd86@intel.com>
Date: Sat, 16 Dec 2023 04:41:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: x86/mce: Is mce_is_memory_error() incorrect for Intel?
To: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20231206013846.1859347-1-sohil.mehta@intel.com>
 <4ce89a5e-96f8-4939-b86e-f65c16f4bd4e@intel.com>
 <SJ1PR11MB60831E048B544C83E845D907FC8DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB60831E048B544C83E845D907FC8DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0248.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::19) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb13998-7b17-4ba2-8c19-08dbfdc3354c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaT037zkYGtRi7w1ECtOXUiHXZD2M/DsgxeMGgIFxQDPJn3u6Y8fuywaXh+fXJf1oWn0rOwVLK3dshdtc3Ei6XZj4ZbkNp05wquWFkC57aiiaDfErjOnAjhOyWps/3oqLUUQeSnG/8XakLrtx0uHaXwPrmp4AIVVfohn08AMRYzfQN6uidUCxWcNxBpWsFlTwfZ1NT3k2Nze469BI8K9lBHv3jrn62LD8UArwMngS8d7FuwB5i/YLhPixWjnJbca9VY4t8NdFJWqrJfUY4M93RFD5+lb9jhspLDCczAGZKMco3NV9WrmxzpwMRWOh4vFNzCtUy68HexD0MI0VNLeBSplI7Z1P1oq6oisI6o4GbsD6Iy8GzTWyFGLn9ldnyNt/sHEGSARj0BXYZc/EU+SGA9JrVp353W9fGlbQK2FGeWvtqat7sMQu7y/PgqUWV7eYMUqzXtJJ/0lRZPUddliVvN9NyZcr3+0F+sCcJjLNZhP3d8kDlPI0k8BIcornUUKzgVRFnuVmEtSFYxRZHwE2Op0tdrrYNMI6EMwQmObpfR4U0XnJaDrz1oC42sNxU2aEwU+FRSO7BCdEekfXs/f0GvbIwo8AAHkjTHFk74oe1LR2DjF5AECsMBaC5yIK5YYUxjvL4dHp0qo+NCKU7LXrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(7416002)(5660300002)(2616005)(110136005)(66946007)(66556008)(66476007)(54906003)(31686004)(478600001)(6486002)(38100700002)(44832011)(8936002)(8676002)(4326008)(31696002)(86362001)(6506007)(82960400001)(6666004)(41300700001)(6512007)(83380400001)(316002)(26005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDQyb1BrcXZDWjhzUVJkcmtFS2EyMlRlZ3hBRHJqeTVFWmJGZGtFSCtZT0ZK?=
 =?utf-8?B?Znk1Wm0xdlFBWTB0aWhOdWlEbFNrZHUxdUZ2Q2ZTays4U29UMEdtd2Rkbk95?=
 =?utf-8?B?SHlrSWlSM3FSaG1sRGxTbHNGQXM5WWJUWGZVQUxPVE9LcnBYZTF0Y2ZwY0Jm?=
 =?utf-8?B?UG1ScVd0NVBYQ3FCaUtQTUc4RXVJdnVUTEpSRDJ2ZVlLRTZkMDhsOGVwYkI0?=
 =?utf-8?B?ZENtR0MwSGpRUUk3aTlKbGVpNTFBZWVnM0dkeEd2ZmQ4Z1NONUlFbU9Eajk2?=
 =?utf-8?B?UXl2c0tZODZpOEd1dlR6OG9kNTY5NWRBc3NCT2lEWERDVHQ5b0xxcjVpYzBG?=
 =?utf-8?B?Tms3SmRac25ZcTEzMXd3ZUdrQlJOd3o4YWNobUpweHNzVXk3L3FUZWQzS2xi?=
 =?utf-8?B?UGJkTUZKdVhDVW1aUUVMRG51VlNjTWVyb1pYcWJSK054ZEFwcWpJTjE0ejll?=
 =?utf-8?B?djNZV290bVJEQ1doTy91cVJvUjNpbGNjL2FLZVlBaUdLeHFLMk1mWkJYQm41?=
 =?utf-8?B?SnhaZE1raWV5ZE1HY2lIQS95TDd1TGUwNnBmTGJ4YWp0cERRU0JCY2NSeFhV?=
 =?utf-8?B?NEtHTnJIN3RLdStaMktHNjJrV0Y4M0Rzd0tyVHRnVi9lWVAzMmpncE1pdWpl?=
 =?utf-8?B?c0s2cW1rVE40di9yS3AwSklJTzNwKzVNR05STFAwU0NoWmFvd3RGbGU1Z1lO?=
 =?utf-8?B?a1dFMFFOdzBteVE0YVdacHYrRzU2QWdDdDhmR3BHaU1UVUd4RDMzMEpWNEUy?=
 =?utf-8?B?NzBtOThxM2dVcHhzZmVxS21sQ3ArbGlGWUgvMDAwbnRJUmN1c3RRaFc1YnVu?=
 =?utf-8?B?bmU3b1lPRmFCWmlkd0xwcGRwM1BzQW9GSnlwRDBXU3VsNTVtRHNxU2o3TjRH?=
 =?utf-8?B?akZvLzhOcnhoVUx4UHNHVytVSUphSStlMXZXcW5EV0R3cWU3MDJtL1c5QkEy?=
 =?utf-8?B?UloyQlh6T0hYaEwrZDVLL3lPLzJ3cHlRS3FoVkhkZ082ZUtSalhrUkdZdjRy?=
 =?utf-8?B?R1JCZk1vendFWVppTE5IMjlzMzhIY1FSN1cvVWJJVit0dnhqZWN4SkhPaGtO?=
 =?utf-8?B?Sm1rM2VTVzRZY01OZjdlcnFiS1NxUjVhT3ZlVkFQRStYTGFhbm41bnI1dWJD?=
 =?utf-8?B?QVliUGxtMnlaUlNjQjY0bCsvOFFKWk4zM1dQZEg3TnpQK3FCV0hsWVZFS3Fs?=
 =?utf-8?B?Y1dzUDJFNHVSNFAyMldBclZaSFkrYWZONTh5Z3l0OExnNVNBRlpwT0NUK0gy?=
 =?utf-8?B?VUhJM0J0aEszRytFMnkxWFd5bm9xTU1TaTBQYVRpVXNwUHA4NDJGeUZNcGV5?=
 =?utf-8?B?N3Y4aWtidEtJdm1UNVFxcXFaTHZtTGowTFlzcVNkakg0SmhmallObzhWaFhC?=
 =?utf-8?B?R05XaHVTS2x4bmdmRmZYQTBQazFCdW1FZDQ0YU9RamhKaUhwejNXbnBrQjlS?=
 =?utf-8?B?bkd4L0tMaGlCdTNyL1U4RnVSMTMyeUFMcXMzQWFiak10WDlubWExKzYzeFls?=
 =?utf-8?B?ZlpKbXB5ZWMvTTlYTXVxVkRWOTY1WnZ5WkhaSGp4eVQ0MFpLdUlSYVlOVUpw?=
 =?utf-8?B?RnNYbEQrNnZRdmlpTkVyYUNxOWp2YUZsb0FmN1pkY0NxSm1xSWNveVZ2emhH?=
 =?utf-8?B?NU5PYU9OYW5nbUw2R3FkMTdxZzlmT2hUaU85OHFLMjV5aDZNYmxmZStTZmRI?=
 =?utf-8?B?V3hlb0hremN0ZCtLMlVBU0F2NnppdkEremVaSFFieVNOT0VCeWZydGdqM2Z3?=
 =?utf-8?B?Vjg2ZmdvQVROYllCcm9UaGpVTm9CNVBCU2tFSGtUdjBDM2hmUWNlNVE2aFNo?=
 =?utf-8?B?TzEyV2ZPdGxaN29Id3p2S3ZNV2xkVEVqYmx1OHZzVE5McVZDckl1N1NiWDVa?=
 =?utf-8?B?L2R0d21Ua200c05peWluZmhLYiswaG0yYXI1bElPbm1yYWRWUWhqUy9hYXdR?=
 =?utf-8?B?aFpOYVNabGJGdlk5a1BPQ2dpb0lWUTh0dzQxS0RkNERKd2J0Nzh2YnNEMXV5?=
 =?utf-8?B?bGtPa09qaktQZzA2SjR4a0N2Zlgwd0tNZXhLNGJwYnl6TjZvUVJRai9kZHBv?=
 =?utf-8?B?Q0tKcEsySG9ockkzUzg5K01Wamh2bVZMMWlYWHpoN3RESzdzYWRZbTZJelVF?=
 =?utf-8?Q?9wwT9q9DJ0EJX1ruIPY43/qse?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb13998-7b17-4ba2-8c19-08dbfdc3354c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 23:11:46.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pl+mLC2ymPujf9Qz4Bll4DBplPZYmk/vn6H4U1y8y1Msxmiul5KulN5pufPhScuK9cpGvnajMMb7JhvUDq5jYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com

Thanks Tony for the explanation. It is very helpful.

>> Type                          Form
>> ----                          ----
>> Generic Cache Hierarchy       000F 0000 0000 11LL
>> TLB Errors                    000F 0000 0001 TTLL
>> Memory Controller Errors      000F 0000 1MMM CCCC
>> Cache Hierarchy Errors                000F 0001 RRRR TTLL
>> Extended Memory Errors                000F 0010 1MMM CCCC
>> Bus and Interconnect Errors   000F 1PPT RRRR IILL
>>
>> I am not sure what are the practical implications of getting
>> mce_is_memory_error() wrong. (This issue is completely theoretical right
>> now.) Any insights?
> 
> This function is used to check whether an address is OS addressable memory
> (i.e. for a page that could be taken offline). That doesn't apply to the caching
> use case (the only way to "offline" such a page would be to offline each of the
> slow memory pages that it might be used for).
> 

Makes sense. I am assuming these Extended Memory Errors will not be used
anymore (even for CXL.mem type configs) and we don't need to include
them in the mce_is_memory_error() check? I'll update the comment
accordingly.

> I'm not quite sure why bit 8 (cache hierarchy error) was added into this check,
> It would seem to have the same issues as extended memory.
> 

From a little bit of digging it seems the check for "cache hierarchy
errors" was always there. Commit fa92c5869426 ("x86, mce: Support memory
error recovery for both UCNA and Deferred error in machine_check_poll")
introduced the original checks but maybe the intention at that time was
different? I see that the CEC stuff was added later so maybe the
original memory related failures were handled differently?

Now, should we remove the cache error related check from
mce_is_memory_error()?

