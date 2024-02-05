Return-Path: <linux-kernel+bounces-53051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9103684A011
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6294A1C21BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A453FE48;
	Mon,  5 Feb 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqWKNt/P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82573FE44;
	Mon,  5 Feb 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152294; cv=fail; b=Cj/q/0vGmEGO52Ake9RULOnogNYV1+9GVt2hEdZ9bu7IMPLn0gNHLr5FpTq5ekX6PR28rsr703gWkC5Gtl1VROu8g1YDe6cGtzjWL14Hz77+4DFhi70vOEFCQJXxhQzOn5LjLLoSiR6XI3POnOL2+LGx3DkAp7s0K9SnAzUrtsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152294; c=relaxed/simple;
	bh=gMUmXKhdgRMe4Ty9H6k7kBM3LeDWyMNFUPPWsGy5yjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SP9hMb7Ds6ByxTeVjon5/jiP40aAmOQLT2vvmdNOVnu5tYMre2AzVCvNlHZppUxhC3bn4+sQ61C1ZcOFG2LxTg/3vUYMXc4RQV9iVXeviHyBXOI/zy79pIfUXuu/ZWdGdXH+Iev2R+CYGzcWAqKzDTmNMEslC+p/oY2Q5t6Rbd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqWKNt/P; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707152292; x=1738688292;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gMUmXKhdgRMe4Ty9H6k7kBM3LeDWyMNFUPPWsGy5yjY=;
  b=OqWKNt/PYF1+u4OLOfpeMVp76xDuCK8Mp/BkUD/7qho7y+ySAMvMhYxJ
   yW5ktcf+wchZCPLAld2L6eqo/vjiBk09TPOuiFDiDojlElPOjSwZ1BOGz
   uEGKsP3V3wnMMCLsGfUekcp1HRlPzCfS6oFUR6SCV7Cf2DCPaYoZ8DwgQ
   izDmESa5lNRZcxVHavN5OwMf0AnT6GiYRohmMLG5KL3+ZcjxD7/lXA6QC
   /sXtTI2M8ud0UAPODcYF034k7xkRv8v6z6n/tGI148wkelljFoLJidNoi
   C0imOHQOxyGga1XGKlfLtz7fDZjQ21MHvC/T8wDPGVm3fapqREoRjS5lC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4377474"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4377474"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 08:58:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="24008763"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 08:58:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 08:58:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 08:58:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 08:58:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 08:58:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8TQwEtiFkEpl9lbSnE8EdcUUMpwCmARbKtXKd2dWnB7lB+iwlIYobLdtlaRUbgUSVu9LAG9+v/eiFzRbJbzTHuVhvKII0g4Lwhu8LEe+EoH5xs5oB0wDFauK5tHf6bhfW0009p6KlNctpNXpU6f69yn6ECe0E9gCZuOGbt1jtJgEphNgIc337h7WSYXlarHStVolr5Ug7Q7Mtby05vOHjo/yJMVVh9czMNK2/puUVjtF4Bux3HnrCAA44tKbDj5V6qSRqnH9puCdimjXts+MiSVN/EBWMeEgTZdDK9inwA+j6C8lBgXlEylWSMyQ2vinVMkj+HvJcl06HHEz+Miwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU8e2uU+3m6old9RqvfIAJMHjSXBHun24GFtvJwKkpw=;
 b=UejXiUMMtYWznAzLtqLGvUnDvJX4sYp3o2ieOnwID7evJUyXklxquoM3oQKou1Y7OfMKKnW0+T4n0h3r2OeyT3vkrWCNqZMNdSUVAeQGsKfe2vBdV5SxNtK1SBIVm8b/qV7JF8yiVr0/QGZmehCUN1XZPRN7IolLUV02L8fUqMTmCEnQU/6kHDZDHCAj97kICDTWdMrkFoLvRQCSZJeUxBE6Y+jTUnXSyxxgYLe7pOJtWzQMQeWUZrBk7jlIOidLBCAsRXSwQbiW5Hv+20dAXELE2T0zOC2l2U7Xcbuh7gC6yresv84gmIPuuOwmphrzENrUmG+/dK6JoZD/jkw18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 16:58:05 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 16:58:05 +0000
Message-ID: <5228a235-69f4-4a9b-8142-96d9b4a5a1c8@intel.com>
Date: Mon, 5 Feb 2024 17:57:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
To: Chris Leech <cleech@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nilesh Javali
	<njavali@marvell.com>, Christoph Hellwig <hch@lst.de>, John Meneghini
	<jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, Mike Christie
	<michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>
References: <20240201233400.3394996-1-cleech@redhat.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240201233400.3394996-1-cleech@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0235.eurprd07.prod.outlook.com
 (2603:10a6:802:58::38) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 078163d4-399f-4508-0dd0-08dc266b9f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZgjcaHUeSz6oYP9mI9txAPkG9ss8QIIj6cXG2s/QjbnTEHn1FqNqB6o2cNpKio4aYdXssC6RAAOlt4fULj5cvGgR1MXffoxIcoB9ghcWG4YlXOrxvGNO/tDDLdqqzT6CeAr2HT0fa9JDMrk5V2TuGHWJXXaTLk5ij41h2LBO0Y/EsVs+hKSSEz+3H6XyqTTRGv0pMISdRPb22LznmK0iY6N6JU1DmWMx9yaDLvW5WFOw9Qi47lDebzXNRrMCiLqzzXguTxnF3NulkeJj7gEfg1pTrD6foUmIrH+6VKxiRb1b9zx0QSAoLEleYghlJrFItXWqSWCpCgwglQZbOpEsKIs+cItS+hPV+NsPlyUn3SPEnJ/JyLTW4tQEhdrdO6YGBnw1iv3SSoHiX6fi3fjrivF3jac3siH5FJS6ZE56pvMb0mNmpp709GXoEVKr+UN/z+wLeUl4kSOFpPHQiouRHQMZkeIEGaZ2wB2W4NEsCYt+5l9BRzJsoxEuo42JsfbymdgMTz/2IKZvzjR37yzMy+LU9ecWpeZzVSD+lYn5MWO2LIsow+JNOhUXBXM78tvENZH12UTrMypDqfYU3oe7WW0rrp/k/1nuJIyFV4n1ZZzX4lFOEcttGhG3wxW1U0KsnVeTlJ2CvuiP/Y0GwsK9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(7416002)(54906003)(66556008)(6916009)(66476007)(66946007)(36756003)(316002)(2906002)(5660300002)(4744005)(4326008)(8676002)(8936002)(82960400001)(31686004)(38100700002)(6506007)(6666004)(6512007)(478600001)(6486002)(2616005)(26005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVF1RGxXYnBFY0dySTlRMVcyWnp4Y1p4VG1qdFY2UUlvbFBjV0FtNTMzNWE4?=
 =?utf-8?B?Sk1qN0xnN2YrR2E5dStQVlF2N0Q5bDF6Tk5yNVBQMVNZMlhkMnRHNTlFaFJo?=
 =?utf-8?B?dVpjZGIwRVRwZXFVTkduZHRIVDNjdVNlSDdaWitlaGszRzQ1SkJCRVBkT3hJ?=
 =?utf-8?B?L3FmWnpLbkIrTHA1NGh1czRQU2VoN0VRc2pJODZtY2pYSzAzVkloWkJPOXE4?=
 =?utf-8?B?NWk4ZlFFaEpOdThtR3ptRitHL3N0blh5WU9QYzlMVEFqL0tvVEZCR2ZKeHpV?=
 =?utf-8?B?TEJmYkZMeFNrK0NBS3JSemI2cUhJck04QWhOSkZHYzFmZnpYVlpWc0dkOEg4?=
 =?utf-8?B?U25jeGRHMmY0VGsvTW1qUGZtV2RLMGdEY1JGT1Z3SVZJOElBVXlFLzRtWTdY?=
 =?utf-8?B?R3lRKzFqQktYUWxveGk2bWFEUE1yVnh1YWpMeWpyRURFNU0rZHlSMnp0cjFa?=
 =?utf-8?B?NFdOcUh6MU1LTUZKcVpxV1dWRCtUd3RJd0k1d21qZFVwakwxNW82Q2VVNmE2?=
 =?utf-8?B?MTRuaE84VWJwbG9OK0hWVU14Y2pYbitTQmp1dHVWVzV2bjJDVFlOU2hrWk5l?=
 =?utf-8?B?ME5yVnRoZk4yRHZYeDB2MzdBUENRMGtlOXFEZFRka2N3QW1CK0Q3M0FHaDUw?=
 =?utf-8?B?dDlnSVhzYkVBZmsxaUN1ZHlDZUlZTHBMcVdackwvTlZLYWg3Z1JUbG1CYmE2?=
 =?utf-8?B?NThLWHZpQWM4S1JSM0RwRmlKZ2FidXJHS0VtcEpFNkt6QURNSS9KdzY1M1Vp?=
 =?utf-8?B?VlkyUlZuS01sTFpHa1ZKVldBcVNBcmJkZktXbmxkY1BuQ3V6eXhpUmszZ05C?=
 =?utf-8?B?M21PRHBKTC9BanpoUmNoOGkxNTJUMWhPQ01lcHZRTDRJWUhBZjVFdGQzUGxs?=
 =?utf-8?B?aENVaU9DbFdxT2ZJdTJ2Z2poUDliVUlnTFpOdE10TzFqcnAxTGpjb1lNNVlG?=
 =?utf-8?B?SW05d1BmY0tvWG5iMFE2WDJkdnRWNWhDRVp6OE9RREpiaUZ4WGNGYks4Z3F6?=
 =?utf-8?B?QTNCOVczNkNyMGlqaTVCMm1vUytUQjVSRHMxRHB5ZGZmbUdUTDIyRmNMOVU4?=
 =?utf-8?B?T1RHc1lCZ2dsV0dYRCt5aGczRzIwQm81RFNnU1BneThwZFp5dm40TndsTTJx?=
 =?utf-8?B?d3g2dXgxVmJWaWpia1hwV1ZwdGxSbDR2MTFKTUZsUStIZTFKTGtIZjJkYVFn?=
 =?utf-8?B?bUVFV2EyMTNNbkJWK3B3OVlkd08xWEp6TkkrZk1majYrRkNBWFJQbloxcEpH?=
 =?utf-8?B?MFBWazk5VytPZ1JRY2hMS0RTeGcwUkVOUnNtdHR2MktoUVNubGkzRFN2Wnp1?=
 =?utf-8?B?LzdyUGNTTU5SL1d0YlVuam0rUEFtRWRHc3dqVGRFampBMnQxNG1CMHFtNkE5?=
 =?utf-8?B?aG5tWkVyTXg5ZXdUNUxBbDRTdGtFZTU1dlc2VW1yOU4rOEJsWnRHNElKYk40?=
 =?utf-8?B?YkE3TkFvR05FeTVWUEZ3eGtZQVhIVVNyTFRJaCtFanp6endtNW5wbUVRR04y?=
 =?utf-8?B?SEpmVzFQcC8vMjU1UWxhSGFESldCcFRSc01QaE9rbm5IS21KMyt5YzYyb0Zs?=
 =?utf-8?B?bVJ0MVZvSU1UUlp0ZnVUZWFaK3U0RVdxSE11amEyaHdkN3J0WWIzVlhZTFhE?=
 =?utf-8?B?VENEeXA3N1d6S2NKNk5NOVo3Tk9NQ3lLZkxKQXdLNmFWRlhORkJLalFkVHly?=
 =?utf-8?B?akY1Vk5USDY4QWI4K0RwZEQ5WFlpVXg4eldKc2ZSYnJMSG9Oc21BUnY1ekdR?=
 =?utf-8?B?cXBUQnFjd2drcUd3RlgydGkxYkdWbGZDdTRxWUdNV1R5NzRWT2dpVFVDNEl1?=
 =?utf-8?B?RHNSaTlBWG4xZzFacDBGYUN2OHFWT0J3YmtqSU1oQ2lQVUZnMklsUzJibFEy?=
 =?utf-8?B?WU9FazlMSFAzOGtGT0MrMVB5UzdkUGtFcnlHbU50MmhQNXVKT3RHMmlyZ3FN?=
 =?utf-8?B?QndTWWg1ZGl2M3NhVW1CQmdoUVZaMzd1dGJ0R2dRY2krdzVUU1c4TlBiTXNG?=
 =?utf-8?B?QTQyNEszK2hxcnpIRWxKUlpIVWhrTnpkMXI0cW1QN1pidXNlcGltU3p0OHha?=
 =?utf-8?B?QmRvbGVTY2hsTUwyVUMxLy92Tm5VNThONzdhRGZOa1p4WUVrcFlpZzNXVHpG?=
 =?utf-8?B?ZHd4Vlc0clg1TXNQZGtDY2F4QjBtUk1UR0VJVHZGRGdYR3RMSzFnTFlFUDBa?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 078163d4-399f-4508-0dd0-08dc266b9f43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 16:58:05.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YXZxksQjlMAZikh5Inbw8CrG1L0y04fwVq+Tc956cNaFEo8IwU38RIfEZw4fr0oiLmZanynLCenhYvH1NgYzhE8GpBeZfK7dYvaD4tcTiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
X-OriginatorOrg: intel.com

From: Chris Leech <cleech@redhat.com>
Date: Thu,  1 Feb 2024 15:33:56 -0800

> During bnx2i iSCSI testing we ran into page refcounting issues in the
> uio mmaps exported from cnic to the iscsiuio process, and bisected back
> to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.

IIRC Jakub mentioned some time ago that he doesn't want to see
third-party userspace <-> kernel space communication in the networking
drivers, to me this looks exactly like that :z

Thanks,
Olek

