Return-Path: <linux-kernel+bounces-63044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDF8529D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E909E1F21F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712E17589;
	Tue, 13 Feb 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OO8RtHcx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA111721
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809321; cv=fail; b=hqz98O775A+Oyd7MjC9rYoT+L+hz7OjU1DjbXFtDHV6mL1oJoYKRDNpFwV/hqiC1KxE5tAM7Mfg7Aa7xt0juQcULmwXkR3JzPO7Fac4JSrYXkLqwSglveBaBdyvZ1rQBkJFw9b95VFH3rGkdj0iGXumuTjyhDqgs2+lYPmTPrqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809321; c=relaxed/simple;
	bh=18fyrGoL45ThSh05J9zXPhvzeqvUw43Pb31i3KkXXPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJ8hDi0G6c3djQorDQkIOZuiUK0m5m7/585zi2ZwBzBHCi6FqkQiH6JA/ohsZ/mOu2g3L83NHfcbKE8i046gYd1XpxpcC54wp4y6HBIs21/XwedYGiDp6qSA/O95qJAeCgJW/8ifxrO6saQVbxEPGTJiav7l08CtkCRNhCCdTvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OO8RtHcx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809320; x=1739345320;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=18fyrGoL45ThSh05J9zXPhvzeqvUw43Pb31i3KkXXPM=;
  b=OO8RtHcxVmP0n/+PtlYBK5WY82br3Gn7/umDJMR39Ah+TIpzlop9Aaj1
   OhCdv6jkCVHvcyUNh+Vz3z9h0UhXbwG7USF2UKcNMXOQM7SHMjOT5KlCV
   19kDL8UPVXO4u0R78qkjgvzvPZfPHgpeqUOmCksgNQ7CZfD411EFxwnpt
   St3LtBxEykPqnEgmF6Zg5l9+RsTMBD3I8+ZGsB5T25mpeTjpShrqwowuR
   1Ki1wDWQQS80D5z0AlRTxFt4Q4arHkbkJf4238JFaQTAI/ms3gQJebotQ
   xUW5o9GSGyJEq0Nw3LZiwWZIg9sKJ9svL/KtJhHSh4gv1/ANycAxbH8qg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27248461"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27248461"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7386577"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 23:28:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 23:28:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 23:28:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 23:28:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL/TzKmVgIjPfTv/Y0YGR4211vft/cp4lSYu1VC/Lc/GgPI0qivNvZes7xkw1UHKWeAeoQwUgiM+1ghZC8qPBTsZzch7DO3Njx2jrQCKp4423bASpqkGVrVnvhN6Cm2gpJwXHUdMsRHcvZ/xBUQbI9BgZhXwnuEYDdbDdak+4GyFt/q9adEkTySgG/1F5QxtVnKZIrKd4mqR1uRHPNGOq3s/IYY1/9QQwxarNn5Jpc9W6SqIEzqyDjKp3e9AmFFggvQ67TQgAsmzHHldMERKAfB81HV2E1ziML0IaWd6CnLkC+59s+3EhAjoOd5xOMLZ8ormrAES+1lC6ftSioPY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaZqBadf4zh35VfejFuR9AyCpa93edRZN3d7ulAT/EU=;
 b=VpoeAaTeBMGVtSVZ7paxrjzHj72ahXHsbvM0BBQwRkIJfrKcz/XHDQ3nN/Y8oDV9dZB0tUthIZZ9znZVPegXqWsBpvGyO0U1yRz786qXEhlm/wwAWCIwP+c4Bvi3E2q3tu9UbIgXkLiCfgBSn8RpdWtugr0nEI7j/qRgnd7MKahjGy7JeQuk3gaF+mq9XsbM//sw2599UFr3DbqnU0JI/zQDnOKlVWBR33gk748C06gd8oGNwRkNFcPyFeEwH2Iebx0nLZ8TUrS/4FzlLGiYmKJnWunZZwlKvG3Wf6vINvtWNCpaiC/DDX/JQlnM/iUnEOUtvzXQ6RIZIC2h79SuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 07:28:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 07:28:35 +0000
Date: Mon, 12 Feb 2024 23:28:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Theodore Ts'o <tytso@mit.edu>, "Reshetova, Elena"
	<elena.reshetova@intel.com>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240212163236.GA444708@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212163236.GA444708@mit.edu>
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: abc801a7-b70a-4b64-435f-08dc2c656344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDffQx3xUeaQAGbKjMsWsZW7kK8eQs37w4QGTCVj/HaQFpVW3LPzIu0eZazsCSFJAGKrQ1LXSA6dc1E1tIz4fZ6xMlrWNckfpO5PaWH0xo1hPA5xhzLN7cc9efjb9PRFLSlZtlYFs8K0g7wV9wxGrgqdaitSQYv5yeMNODbQ85CUaDuxMgab8FeI52Q4uBfXxxN1+LsG6efXA5IB1jI+/H1EpaNdzE4qB6dJ3eFQO6Hpz+r4ImXoNEGPLmbf60xTN+nKb2bibE1Jw/g84Vcq8YXhEtZX7lWB1w3a2vQNZctPpDn05mhJlXGxhyvoPZ9nPkEqKQ5A/qbGps4xPj2USZd8cPHVjMDNb7W2ARNqacw1UFYDKRovZJ/X8tzzpIghtluiJsDqP85nhpaGFyvoUgbRhqQ78KLHC7IjZRdl8FSSWqODtAPIH/eOjA0KVxR6/uD/D9AcwExrqG5DaCvzs9ogZKhLMLg9YEgEaDsEtSgxZr8WZbJJchJ9zdHVXlmjrut1hlj5cohSMikKy4wRKjYNqd3lpA80st9A94kGoyJMvAV7Qnf+VY1kNt0WXUEM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(7416002)(41300700001)(478600001)(83380400001)(6506007)(6512007)(8936002)(6486002)(6636002)(4326008)(8676002)(5660300002)(66556008)(66476007)(66946007)(26005)(54906003)(110136005)(6666004)(9686003)(316002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlydXdqUFNnV1o0WUYyQUxReXNyTStwWkRoSkdUcEtXc1ZsVi9XMzBJQ04w?=
 =?utf-8?B?MW1xUGdBbkYyM0N3aG1EanI2alFTeWlBdnY1ckJwTHBEeGtQRVZDbm1MNndD?=
 =?utf-8?B?WDhCb2hiVDhnb1FLOHZjUW4wWHhFS25jTFFMaW1hUGpKQ0JmUlNIM3VqTnVQ?=
 =?utf-8?B?U3poMlhKOGtMb3ZKMXNBZjR5SlY3NGJIOUhtNGpkbVlQVmtOb0dDOFVrdExV?=
 =?utf-8?B?MFZLTWp6S2R6aEsrejdCV0pucnhncm1mdllCYjIrZGQ5T2Z1cFhFM0YxdkRr?=
 =?utf-8?B?emNFeXBaTG5KRkk5SFNNVWhHMGI2ODdaSXdTckVZWm5xS1NwQXZROWgzRXM2?=
 =?utf-8?B?RVhZWkJDUHpVaDU2b3pQaVpoUmpVMHdBeXNxRFBRV1czQnFFdjhzOVVSbkxV?=
 =?utf-8?B?OEJOKzVJOTJTdXdFb3lKVDZtMUFlTFhMV3R2SFdKU1NXL055NWl0MGpTczM2?=
 =?utf-8?B?eGwyK0FYb3l6OFhUUnRQTHJibEFDNHVETFVRY0tJbjBZalNKYytSZlN5S3c3?=
 =?utf-8?B?c0hZbzFkZzNNS3pKWHZteWMvdkNmalV4RmNtSGd2MW16cVZkaEUrK1E1MjFI?=
 =?utf-8?B?ZDBmV3VOa1FEc1pNYjNWZHZhRXNKeU4wNi93WVBUSExsalBPS2JoSXQ5dHFT?=
 =?utf-8?B?MmpSMVFjT1JIcDExeUhYYnpHT2NaVXN5a21XMnpYdTQyQVBvTDdiOHVxSEZ6?=
 =?utf-8?B?azFWVlFDSG9oa3I4SkJPTlBaY3p2SkJuUW82bUlIVzAwcTd2SGg3WXIzc2p3?=
 =?utf-8?B?R0ZVWnBGb1NvQjdnb1h4cjJodXNONXgwTmE2aFA2L1Z1c0dDTG9lM1VvOGJW?=
 =?utf-8?B?N25mb1BQZlJnQ0FhQ2RiNFUxd0JHcXNPa2VwMEdlUUpqVGF3SE03ajdaYVNJ?=
 =?utf-8?B?ZFVtMGVoY3BlNjk0dFF3clRvYm9XN0dvUmpxRklEMHhBMDgwOFJIbzV1MzRF?=
 =?utf-8?B?K050SXRlOHFZemlEV0I0RzJvWjN1OVY0aDVoVUVCOGl5b3VDcjRJUVRyM2hy?=
 =?utf-8?B?UUZ1emdNMlhUR3p1cXptTUtaaEVKZzhyVkVJMTN1UU9nZUNSbDViUlEyWUh5?=
 =?utf-8?B?RWJTaXJSZjdMcVlIYjlqYS9GNWh6K2dnSFpjdS9JaWRRZTU1NTUwVzVpVEpS?=
 =?utf-8?B?WVYvNFhZV3oyOVcyOFZrTkdPZDljOEhCbldibThjVFdiQnM0VitzaVIwZ3gy?=
 =?utf-8?B?OEUzOERWVDFkNmg1eWxnLzJnWWdiK0ZldkQyRVFzWmIyOEQ0L1BXL3dSd3Ax?=
 =?utf-8?B?NC85VVEyTjdGUUt4c1hZSjlQWEwzSkM4eVRIeDY3L1lMQmUzRzNiVmpOYmd6?=
 =?utf-8?B?Ri9MQXMwbHA3TGp6Qis2cFlxTHN0Z09ld3hJMXovc2Z3S2Y0ckF3RVFFc0di?=
 =?utf-8?B?Z0J3OU5sL3FxcktXeTQyZTJhVm5QRTNMMkNJL0J4NDM4VGZ3dCtncFIvYVNt?=
 =?utf-8?B?c2lDUDVXZUtteElubGMzQlRid25BVGc2aFY1NjR1T0xjbWVLY0NBVjJ2Wkgr?=
 =?utf-8?B?aU53VjhPZmIrZDdmTy83ZzlmWlFIeWd0OE9wUU50RVEyVlNoWVhOM3pPdTFF?=
 =?utf-8?B?MWduMHJlRUZPek9KdUpLV2s3MlpHb2NlTGowc1lMQm5iUERiQ1Z0d05PdnRT?=
 =?utf-8?B?alFjWFBOMlhSWUh3b2pWak1qZDZFRVVwUzZRVTdZblQwZ2JxSkEwdC9VOXF4?=
 =?utf-8?B?dlBSTTcxdUxSNEpFekY2MkJxbFUzc2hneWlhcTRXRFhOWTNLYmdZdUFpcG9T?=
 =?utf-8?B?OFRBODZHQkVOd0pmZ284ZTd0c3NpcXZScjd5NnJGeENpT1A4V0pLK21PakNF?=
 =?utf-8?B?ZUxWZytYNWFPbzRTY0RTWTJvdms2VEVHUW5MSVozbDhkNG1XbTA4VURuUFZR?=
 =?utf-8?B?OTR3T00vVkdKUTV3QVZSNm1XbWE5NTc1N1RELzVtM2gxcjh5S0JNdXlVc1JH?=
 =?utf-8?B?R1I2bEJGcXFuZy9zd01uRGZHa0JINUx2TlNkYmh0dzl2YS9oZ2lKZzJ6SnV5?=
 =?utf-8?B?dlFLQUtwSmVFRE10UjA1VlR6VHZFOWg0N3VxcFhtVE9OTXg2dURLQytFNlB1?=
 =?utf-8?B?MU9ZeWlwUFVCV0hCUytVYmFydWIvVktoR2JVeUlXVm5IUUpsL1RTcDVpY2xJ?=
 =?utf-8?B?aXgvVjFGUW0zM0xJZ01mWkhrbnRKRGNYMUw2MEd2NnBCL0NYbXowUkM0em5R?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abc801a7-b70a-4b64-435f-08dc2c656344
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 07:28:35.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKuUCqfu8x11diYzCgCjdlXgY2tiW3bAdnvgWhcaKFqH4Og846Ni+xmsjXL5IlvSs9EcJiPiIsfnJF0Taq63JdifID5w8wWioAeoRme5gLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com

Theodore Ts'o wrote:
> On Mon, Feb 12, 2024 at 08:25:33AM +0000, Reshetova, Elena wrote:
> > What if we instead of doing some special treatment on rdrand/seed, we
> > try to fix the underneath problem of Linux RNG not supporting CoCo threat
> > model. Linux RNG has almost set in stone definition of what sources contribute
> > entropy and what don’t (with some additional flexibility with flags like trust_cpu).
> > This works well for the current fixed threat model, but doesn’t work for
> > CoCo because some sources are suddenly not trusted anymore to contribute
> > entropy. However, some are still trusted and that is not just rdrand/rdseed,
> > but we would also trust add_hwgenerator_randomness (given that we use
> > TEE IO device here or have a way to get this input securely). So, even in
> > theoretical scenario that both rdrand/rdseed is broken (let's say HW failure),
> > a Linux RNG can actually boot securely in the guest if we have enough
> > entropy from add_hwgenerator_randomness.
> 
> So the problem with this is that there is now way we can authenticate
> the hardware RNG.

Sure there is, that is what, for example, PCI TDISP (TEE Device
Interface Security Protocol) is about. Set aside the difficulty of doing
the PCI TDISP flow early in boot, and validating the device certficate
and measurements based on golden values without talking to a remote
verifier etc..., but if such a device has been accepted and its driver
calls hwrng_register() it should be added as an entropy source.

Now maybe there is something fatal in that "etc", and RDRAND needs to
work for early entropy, but if a PCI device passes guest acceptance
there should be no additional concerns for it to be considered a CC
approved RNG.

