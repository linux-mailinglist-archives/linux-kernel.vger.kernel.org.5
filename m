Return-Path: <linux-kernel+bounces-42063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD64183FBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CC82B21043
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C914DDB7;
	Mon, 29 Jan 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISm6P5l3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BDF9C3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492055; cv=fail; b=I9wsuIEz8APy7tAU//mJvKzoSPFgo2FttqPwkYuFDmVFHKX4OUcXFrU2tGnW+xfA4zIlzzdAqkadL4INVPe78cSYllyDz0PoQKxVUl0q8Na0oLhOJmDt8p0ebU4eu5qgXnqmLmO2U7zlLPTdAOJNozedm/CtvFWIXOyYYMTon2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492055; c=relaxed/simple;
	bh=OWUhrqmDgCvCRVabDsQywqL+6xbvX4BlY//SysZmbf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svDqxaExvkp6DwxnTrn+hszEo753EDBv6UQpVJfv+cnfO/msf3SHF9jtu96d6BxnhjWjaMb7lWNcd1dMPIOs5/Oy3EpFmUtcUqZKl58tUrdxZNv3PCsEhEniv3zPPYQGI/eFKj8IwOzwO79bX9CJNQDhvaaachQK9MDKTcaWypI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISm6P5l3; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706492053; x=1738028053;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OWUhrqmDgCvCRVabDsQywqL+6xbvX4BlY//SysZmbf4=;
  b=ISm6P5l3OHJWbG8mkRJo7C51sNcGos3zGZfy4Jo+tn5JVcbCWwg47kIv
   0sDEqJCHdzE97CBPYCHQ9tq3Ot9UTgWfUxAFNEV6ZzN0QgmgJm0I1i5aA
   pO3XBGaYNUVsekbCdgy3DcsqQDmCWuiWKycKKqumN90KqOf/LaoEt0BXp
   Kx+taowN+OzIjet1hJX3QfoW4pHwwdBgs9ni38/N16yjJcd+khAZxch32
   IiAB5Gl2fmF5Wvr+cbEu2gt2s2fvnhHvM1rv1OiUYxqn1XvA+OLLWl4pN
   57lxpgPJYLA693fKf2Wigpt8LOQYbSQXw2VFFIwCrn/8GfkQouHccZQ7Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10211915"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="10211915"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 17:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="787675859"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="787675859"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 17:34:11 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 17:34:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 17:34:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 17:34:10 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 17:34:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncZ+E/QRIoqJUf9Jd2LFD8JCU/CLHdoNSIqCLuaAdbshHvJgr3/dNUOhpjaWmr2mhdSk6qgpK7+2/jPQ7ACXkwvmKekA+Sg0BxqoZkeroB5VnFRIL1waciigBt6BMaVSMpXvJ9JNQdjmAQBMj7FBBoRAAZ84VuBu75CskK+G/5bpRydBqgi1WbEAxdxL5zAS1YGgCekvSFFEgbWWWxaqDxYZ3EQBDxFhp4jWdsXFLyqODeW368iGF7Wct2ABjfcvLysjuZi5TgBWoDdna7lEN342aoEmdbGNL8hCNt8rB5kqaOfTaeEyi6EW/NX1gP7c7eZV3lFB05j6LvchbWJImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcMSWHl9Fx6YVbCh0XZCfckxfm2n82/6n7FzD+Fwaeo=;
 b=IyqCnX+OASLojXve8cNHAU6u136FSiRDWAjTcUmv1eDao3EPWoN00Ne1dRTVV0SJFEh/k6fiqVOKsy9pJl4cQvYYADj7nXr14lFIhPzG+c0D1N0gjbbzsF3a71NTkUUsoUeS1JreyRYGg25uD1yIhxj9VtLH2IagIOqCJZwTe5ZWXLQ1TVqjf7xBSBw5VoPWDb0rDPY3062MG9R8AwZmIud89Gkkhdws9Aj7MzqAI/RlKXLfjPZ6uCcVOWv5yIOIK4cznh2Qc5LEUEghEM3/t4mzA0Ywjnc6C0LjCtWWqfGu03bYFtxrKDeE4el0Dx4QzgWxK7WWhQY/464hF54/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 01:34:08 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::9692:ab94:5995:2f35]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::9692:ab94:5995:2f35%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 01:34:08 +0000
Message-ID: <2422b6d3-2534-4751-9f75-f8b0c40e7bc4@intel.com>
Date: Mon, 29 Jan 2024 09:33:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: iommu/vt-d: Add the document for Intel
 IOMMU debugfs
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, Tian Kevin
	<kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: <linux-kernel@vger.kernel.org>
References: <20240126064704.14292-1-Jingqi.liu@intel.com>
 <34eaf7d6-72e7-4f72-a42a-dd2922d9b8b8@linux.intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <34eaf7d6-72e7-4f72-a42a-dd2922d9b8b8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|SJ0PR11MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f3d979-839e-4f24-b465-08dc206a631e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5XCKb94IJpW7ctQHI3bvU2rGX1iqUh/gmrZZkBMc0VZzQ6CFVKZLtlVN16vPsepbX8Tlow/RgkhW6D1gxxNhDM9GtB/4GSwNVl5+pcGTEEeNZgiHG8akvV+BCLwuyzXqfa7wkjElfJtJf5zOS15GoZQDO2C0jgrOPWfWpQiNJ1FlWre52JpZkS/Jwbi5+fOVoHnqNMQUP7NvE0Wam/AISKkE/2z7Sux/TNQ1uaU/QNRmYFLBkbg8BZ3jo+6oZ+G0NyxgXD1byf4epY9WuAudE+WkY5B1TWxonPGeGY8lF56tuhUYERz03H9cjfXSRnaKBo8G/BThi2qVD7s21HULNeecUYvQgHXSEW6UXu0ShF+5MzWutsHI0zVvyMH/MVsQDEIl2abU395sH7nDhAqkoyi9zAZ/OE8ve32Lv+6DVO8btA/BoKbGgZMdttxS7EKDkeSBJ6LrUnXpeZe9tqZxccvEmXugsVAJ6TyDN5acHqoH89UFpUjGMP1xke2r4aEpW9SMyDHMZdIU9zYuA9b77+1xmMEwvcK/pGbTSolCNwOwxCqnNsP4cIbH61mP4TW3rUxcqCX4bS9pMYFM7s6/8zZgIQPO2AQBQxkWumy6DrsZ0TPjpnq0WFIAkUVuPBJGzLUXOhB7II39Nh66ZKIJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(316002)(66946007)(53546011)(66556008)(110136005)(6506007)(86362001)(66476007)(8936002)(8676002)(6486002)(478600001)(31696002)(6666004)(4326008)(26005)(4744005)(2906002)(6512007)(2616005)(5660300002)(41300700001)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzl2ck0xV0NQWkx0a2d4eDZ3cUxoQW9CTVVhL2ppZ0xtZzNzYm1UOWZSNWlO?=
 =?utf-8?B?blFFenZlN2pRczEvcFRFcC9vcWo3WHc5ZUZNL21JU0xBaHR4Yk9PcS9kQkNS?=
 =?utf-8?B?dnZrdTRaTnFrQTQ3VFJvNE1SRnVDL2V0dERuRXdBWkpmbmJNV251bnROODUw?=
 =?utf-8?B?ZmRJUUJYUFFFNDEycjF4STdXM2w0a1Nrc3NZZFJ6Y0hhTDN1bVgzTlR1N0lE?=
 =?utf-8?B?VFRXYkYwUXFDQlVaamtIQ0lKYmwxa2JHZ1ljQmZUYm5rLzUrbnE0alZnSm1J?=
 =?utf-8?B?WTAyRk0zcVdPSTVBZllCWlpUODFLSnN2eXRRU3JoOE0zcmF2bzVPMnAxRWhJ?=
 =?utf-8?B?clBYQkh0STczZFFIdkhsZVFpTm4wUVpQUit3bUlTaWJrZFpvTGRWbkIwZkRS?=
 =?utf-8?B?YWZObit5cmJVcGZ0WFJzaVRVT1JJdmVMQUMyY1Z5bFZxKzNJRnozOCtKTDN4?=
 =?utf-8?B?aldZVTRHVDdmZFNhMjgzQzRGS0RjdEtFRmZNcHJoZ1kwNDZLQVcwM3Vjb1hR?=
 =?utf-8?B?YTFyY0NHcWlPZXlMRzRGRkNqNUw1VXBFb2p0SnkxZWplR2tMSDVvT3g3M0pu?=
 =?utf-8?B?ckQ5ZGorcGtnSUpZdUdZSVBUT3I2a1BURWt4VVJ6VzJFMDVMQ1orVVVyc0tj?=
 =?utf-8?B?ekdpcldwWXFVZ2tGb2l2ZEloOGd1UUxrME9KUjVHSURuVWo1Z3A0Q3Q2M29E?=
 =?utf-8?B?ckFFU0MzcEFOTHhsa1dxeU8yMjNqbkhxL2pSd3hVTllZWENTaTZZNVJDZ2U1?=
 =?utf-8?B?dzI3Y1J1SU9kWEJoVzNSeHhvTE9tVDBaYXd2cWtNYUw0alQ4R3M1alYxRHp2?=
 =?utf-8?B?bnlLL1JhNUs5NTRlaTE1eHcwNlhOUXRRbi9SdzdXcTBKQmlUSEp1NjBDWU1C?=
 =?utf-8?B?N2JoRDNUR0RPUHF3eUdwR2VFTGZyeU1sMTBtcldmZXRPNGNwYURQbUM5L3dq?=
 =?utf-8?B?SlBQZWRuR0xIQmV6clFUdmEycXVSVytKcXJyUklsR25LVU1MWjMybzY1aHBT?=
 =?utf-8?B?K21lcVg4YkdST3lmR0w5SlZYb204Q3B5cFFlU1c4V0F3ajNyUDVtcFRUMjQ3?=
 =?utf-8?B?OFNxaXZNdGFvR1FzamZ3Nk5tbi9icU1BeW9veFZNQUQrUllrOFhQM1FibWMz?=
 =?utf-8?B?bVBsamFabmxSYjk1Z1ZrL0lqSlpLTWlCWWhvdHh4NWxHOGl6andTS2lVeUhM?=
 =?utf-8?B?NjQ3SUptTng2MlJQZm5CRnRwUHF2T1BCTUsxWld1MnFqOGxrZTR2QmVLQVo0?=
 =?utf-8?B?elBQdENEakpHdUVaLzBURXNaTUFQVStjU2FLbTVzNHFlSGJHZDBKRFJwOVRO?=
 =?utf-8?B?TFhURWZNQis1ekwyWGlFc01VYUN3bSszc2VmOWtsajhpa3R5Z21xR1hneW92?=
 =?utf-8?B?QWMwWUtnZXUxVUYrNlR5ZmV2YW5uZjZrOFJwdU5QbS9mQVRJNDA5L0ZrZmo0?=
 =?utf-8?B?cXR1bWJQdjRWRW9PckZUSTdLQk9OaXdqT01RS2RlMHZ0OU9kUGVoZmZaaFhk?=
 =?utf-8?B?RUN5NE5vU3ZXd29OcEFhQzFKd2Q0T2VkaG01TnB2cmh3WXZBVFNIVlV5a2Vp?=
 =?utf-8?B?ZHVTR2tVNkF6cG54MU1tTFN3Z0xBcmtCY0xvQUVrTDd1RVJZcWxCczFHWU1r?=
 =?utf-8?B?OXgrQ3hNQStDQTl4VXc1ZUhKRGpWeS95TlowbzRlZHRJdUxBbEpCMXBOaVVV?=
 =?utf-8?B?cHorMHFocWl3Y3BXN2dlM1NFUFBpOEtCVnExdTBYVXZwWVAvRU01VEplYVRC?=
 =?utf-8?B?V1NsTmNycHN1M2hIa250b3ZxelMyRnp3d2JiSVR0aEtYV0FONHBxc2VmU1k2?=
 =?utf-8?B?TVAwTlV5L1FlUUFjZ1RNeUNYUlptY0EwV0dNOHZTcnl5bS8xejN0ZUVHdk9U?=
 =?utf-8?B?ZmEzSW5kc0t1ak1TeTROTkExbE9YRnlGNm5nek4yb3pMMjVuZTRFM2kvT0Fz?=
 =?utf-8?B?RHFoRnZLcFUxbG42TGF4UVI5Vm10WXNhWHNiOUtQVCtJL01jRGRlTkxnVkVQ?=
 =?utf-8?B?TTNPMFd0MHI4YnZHSlFIMWlUVk5qdlJ5dGFJbzV3b0tpdTFxWUtSNDBlRjlD?=
 =?utf-8?B?MXVaU0hwemlIZGMra0EzVGMwQ05DdHA2TTFVSjJqVGxPQWJuQ1g4aU9tSm0w?=
 =?utf-8?Q?QSfCXCJ4PtdKatFc9vW1yD3Xa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f3d979-839e-4f24-b465-08dc206a631e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:34:08.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNB0yC/EohL5m+9Xa0qb3Eu8+t2Fcqe2M/josXFEXHBplE+GSTMXQIs5n3UZdDwqDH3Ah7L6DOFyvxqbspxecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865
X-OriginatorOrg: intel.com



On 1/26/2024 5:16 PM, Baolu Lu wrote:
> On 2024/1/26 14:47, Jingqi Liu wrote:
>> This document guides users to dump the Intel IOMMU internals by debugfs.
>>
>> Signed-off-by: Jingqi Liu<Jingqi.liu@intel.com>
>> ---
>>   Documentation/ABI/testing/debugfs-intel-iommu | 276 ++++++++++++++++++
>>   1 file changed, 276 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu
> 
> Next time when submitting an incremental version of a patch, please add
> a change log after the tear line, so that people know what has been
> changed from the previous version.

Got it. Thanks for your review.
I'll add the change log after the tear line in next version.

Thanks,
Jingqi

> 
> Best regards,
> baolu

