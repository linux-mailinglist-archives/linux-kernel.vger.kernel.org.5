Return-Path: <linux-kernel+bounces-34215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B385C8375B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB961F28DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524D482EF;
	Mon, 22 Jan 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS7BnEvv"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983CA2E3E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960737; cv=fail; b=Mq0wgm2B3lFVRSceAIeVIqpZV38UFTUB/YxWz/LNUxbAc4ee3/GBsPJdGXPFpm4oGr3sEpMYk45s23qEjt8UOwFxls02GK2eZJE0BAmm2I0sw20gegI/8kVse2et/7x5fUsag+fqFejpz6omOxnL8X2qNCTLE7DRflaSC0HnvIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960737; c=relaxed/simple;
	bh=md0ookuLXsFTJ25f2kyqSKisIcVySDDiO/7xXDYMoVo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OJz8/vNB0JGeHdmz1IqAYGtKn+AYpdY8NmrYzx0RuxSv8Fz/QqYDHO33WgBowZBj+qcXWmE8mo0YZZwAQYd/uYXmWJm5uLdOTV1GdYYfbeTm/867X+WP+m8p+xwen7BLzN5pojbEvrqhZ9JMGkx5NimqIidfDqvLF8bWKRxMIVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS7BnEvv; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705960734; x=1737496734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=md0ookuLXsFTJ25f2kyqSKisIcVySDDiO/7xXDYMoVo=;
  b=fS7BnEvvX07EjIMHXoqkbccxJx4NcC0NqMytqZWSwhgzGDKg2p1GgkwE
   PBgCK4vHV1Eg2X/IYJz9JN4K/vCNXFg6UMj6BlX2OKOr40HlsENDcknfv
   SJtvHl0ZYuc3hUuVJa7Zam1XuhMV2IJ5Lwr1e0qJF92IkwclRcEsSVEHw
   jNn8JsSMzw3XOaoDT6yFLYoFCz8nm9bAIKbjHmqfcIZKV7OwgUNMWEPGs
   8pJkBJcg4hggFqU3kDtwa6zxr6316y6lgc2CVNK4W5LWLI21hbMmYfi7z
   6vfTDdrfhNNsCq3pMy3v6gothZi6jflTHR1ECB08wCCSrHlNG4VhWUY1b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="405094496"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="405094496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="876100407"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="876100407"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 13:58:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 13:58:51 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 13:58:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 13:58:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 13:58:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd1CYP1t9mdeJmWQzxXzwt6vq0MQ9uqdVR3wuV5oyI/ek01Z40FDBg/sWfIP00L6psdW+hvPIyYNgZOrLYL9yayTA1xQVeHcvTp4K7HH71p3xYGSIcB1VztnZZQSZHf90EkttTjSCrKc+xNLt/BwtKsznWASrHtWXYSdPQ0o9aO33lJE4yB2LnLKtF8/l1qwr3gMIgDLi++c5JhibCLmdWwL+I5xu/pW+9BF7/lKEdbvAr+LfY6+pglK/ksC36qsXGEr0/pJTeKX3aHR+rsyuw6nU66PF5LZZ//dzMOGhN1LE2z+66Up4KAarQVL08K+069iJMo863/Us3yJ7JtxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvN3qeE9WhdqUSEQNgUC+fKGrfCYjN1utu9qI2ohoqE=;
 b=DdYazY/XjOixENoThIPB0Dh0W0wdDV6be7cJ2QkPglQCjX8Fb+E4lESzzT6HPlx9VyOd288aKHXAZtc8gFYP0CuTr3x+Hi4o4SzHSkpRsf5ruzEFqrCSY5NX0XwDiM3jAD7AtLxMLBx6WXdrahzHyQOapq2+NqazQiN9uyOpbS1HysewyrtmY09y+u0bOifAGIWZ9A+bgRqITLObqMG+9gEUvn6lFQibDjVqoPXro43CAxQZP7sXP/+qkQK+c8uJFSQaaSisK509JeEJC1Fyy3KXjTsic07sb+ZCCdF0oImJ73IlMfIUWJf3VB5QGxOXf6m+DvVQUxVTBRXGYa8t8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 21:58:46 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 21:58:46 +0000
Message-ID: <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
Date: Mon, 22 Jan 2024 13:58:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
To: Dan Williams <dan.j.williams@intel.com>, "Yao, Jiewen"
	<jiewen.yao@intel.com>, Qinkun Bao <qinkun@google.com>, Samuel Ortiz
	<sameo@rivosinc.com>, "Lu, Ken" <ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer> <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DS0PR11MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: a97d63ce-9e47-4043-00a2-08dc1b954e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NcHI5EeHlL1nrVxYw7ClxGt6Icl/Jmu/ETog1S3FZpqlKcd4de3sY+NuhjbCWBXq9G7O2fRcUEtBRaGPTRdIS65Tu15bnuxIcCo7Uu4HCLeVNPdwHXA9rMZYfjt+mf+xHZC/vC70fiPrmnA0o/wE1Tthh1ei9Ki2Q+NunL15FZWZVHb+czRo4skBadzaD4dFuZYqd1UwviHtKJrT1Yf01JuGOusURoNUTHA0UzWzEgywV0FPUzoI1Dgwr9P4tcZEEPIJiYHoMq52TVPXzFce2gjXnEjM2qF4TklVu718GeVcLj6TAVr96CueUsM+CUvh5BSRydBG/QwPAUn3SawCpeWPQnJwqo/W/SIQzIEpxgLFkTehpLsPstSO4LOZczcocAe/9BnLLt1WBbN2f1vhK6trvXoQdR4uP9HqzJOcGJlfdMCk5OdKXV48fpTgz1+A9SL8VwleMdiHdR5iDX3jKUaCuRjHb02+RAL/FUHDM/wVBFP1QJqNJOcfC51aY5SpoGtnox58gvm/NMB0kdWjEEFJLct2k7kFWBRgcyp5bFxefyr5BxMu0rrAFMMd5CfPqWIS4OJGBXmD7aMtZ08W0Nrln7NpmtNzzwtpzl7p4CQR1jlWukz06UOCWxCh7nbTsnWfowZUdMkbAioiGdlJIP+R4SloutpnN18YqkObQEtnBYHuUj3Ro+MOvTyg17g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6666004)(6506007)(6512007)(2616005)(53546011)(26005)(38100700002)(31696002)(86362001)(36756003)(82960400001)(83380400001)(5660300002)(2906002)(66556008)(41300700001)(8936002)(66476007)(8676002)(110136005)(6486002)(4326008)(478600001)(966005)(54906003)(6636002)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFuN1BNdG5IcHFtRWxBb2VQSHlIMktkS2F2SVNqeHZISmVZU012Ky9jdDZN?=
 =?utf-8?B?cnJXdzh3TG1SQU9EcjVOdUVNYmFOYWhmTTJrWmkrNHRRT3R6SjlSdWU3eHZq?=
 =?utf-8?B?K0VjemVwMjc3QjlTbVZ5V28weGt3NVhmTllBeE95aUFVY28wbkV0VmhBOTZL?=
 =?utf-8?B?OXoxcU8wWU41cDMxL3NkdmxlZWY1SDVackRKU2xVbUQ1cTYxdkIxUlZsM3NG?=
 =?utf-8?B?NlFUNXd1WXN1OWt5NDRXNVJPOElicnYwZUhKWVRIRnFnT2hZSUE2eTFQRmNJ?=
 =?utf-8?B?UUFiYXg0cDN5dVRNdGFtVjcrcUlkeHREbGt0TjRMRDNtRkNtTHRtU280cGpy?=
 =?utf-8?B?N0tjTkErcU1CN29VT2ozWEpLd1EyaUdNbmtRZUFWWW5BaUwyOVl0ekRNM0lV?=
 =?utf-8?B?SDZJenMxMkR3emFDOUQ3eDZBYjFhWHVVM1dKOUc1L29RNjMxNVNJMG9pREI1?=
 =?utf-8?B?UUJHVnhGWTFHQitZZDl0Z28zL254ZHJJTUxRL0pya25vMkxuWXZyTHNDTHNX?=
 =?utf-8?B?ZFFBbWczeExyY05tRDMvVmpOTmJJcmcwOFI0MGtDdHZvbEsxMDB5eU1va1NE?=
 =?utf-8?B?TnptWDMvK0lTNG1GeGlpdkphYmZFUitnN0VLK25PRUVCSnNEMm1acUdMbVZx?=
 =?utf-8?B?NytCblQrVFdYcTcxcUtUWURsSWRlTnIyaGJNdWQ5ZWJKRGVMREFkUWxDR29D?=
 =?utf-8?B?Y0k0b2tDU0RoTW54UTE4d2Y3T0xYSnZQdVhMb094c2xab0NESUtnNUFRUGFw?=
 =?utf-8?B?Skk2cWhkN3l3K0xWazhtUUpMcVR5dStoMWZFczNlRTJzeWtXWklLRW9RNHNH?=
 =?utf-8?B?eTZycURISHlTZ0JkbW95Znp2bnFHandnSVYvZHJUTkE3SUNTYUovZkg2YVdI?=
 =?utf-8?B?dUtITTBnSWtnTjcyc3M4TjRiWHUxVVFNRVk1L3IzRStJVERaR0hKTTlEaG1s?=
 =?utf-8?B?Y2JZcVc3ZVJaaTdZQTNHSjdZazdBTXFjdUwvK1ByZG1sTyt2Z21wdzVrUU9D?=
 =?utf-8?B?UzJKVGthWFNPb2Zaay9BL2NjS1NEUUR1N3Q4Q3dxTlR2L2NRcGRZTmdpWkdo?=
 =?utf-8?B?YWVjbVJaTzZoRVZsbXVvczhxOFNLekdNZS9KRFNoZVVGR1o0QXZOSXRyUVdv?=
 =?utf-8?B?L0lIRW43SkUwMVhrU0tZd0lIMXh2UWZsenhNZ3Q2c3VpbStnTXpjYVpNZEF1?=
 =?utf-8?B?V2xLZDQ5a0hTWDMzTk5waC9QaXRIa0ZsSytZYUtJc3lERm5WU0MvWEE1ekhQ?=
 =?utf-8?B?dXIvaU5uNDViMjgzcHV6VnZDc2R0SncraTZSc3V1YVhKZGR4QmErWjVBd0t4?=
 =?utf-8?B?a292WkdyM0piY1d3SGk3M2h4Z201ZXNzdnhlMk1pVmtiYngwM2Ivb0tickZQ?=
 =?utf-8?B?L0NJbVdSZXhGd3p5ZjRyZHczL0FoTEEzcWlERFBwcDhQM1AyRjNvQWhTL2VH?=
 =?utf-8?B?UTNkUnFVNExqSnlNcVVUcUpvY0lxVUhxUytmOGZZL3hmekRkbWp6bytYR2E5?=
 =?utf-8?B?Q2x3YW5TTkRweUZob2VKdUpBSWlaMWhpWmZlYUZGTkpoVVNmZGZxZnBNMk15?=
 =?utf-8?B?cHM2Q3lENGZXb3UvQ3V6T1MxSWp6VWRZai83cGU4S1ZTMUoyZDNHVStIS2pu?=
 =?utf-8?B?bHQzM3JyS0ZlTjRJSUEyZUtheTVrWS9ITU1EdzFoZnNwK2JvUDM2TElvZkZw?=
 =?utf-8?B?NGR5V0hqb3pES3JXS0ZVOGJ5YkVIdTVLdEg2VmJyb0FCendaRVloZDc2d1B5?=
 =?utf-8?B?YUhqZEFYa0tOcjh1SFhVczBlSDZ6dHdkcjRiV1hmU2c1MGZFb0VjQTZGbTBP?=
 =?utf-8?B?cC9oQ3h1OTNCTG5wZkhqd1U4UEZ5NGx4SXJhUzZOajI2MFV5ZGlCeENZa1gx?=
 =?utf-8?B?WHNNOHdYdVpTaHpOY21MTzJyMHkwYTV4ZHp2VHpCazNxZEMrKzZUWFZaK1Yy?=
 =?utf-8?B?WG5hOVJwcmFqQ3ZmenR3eHZQbXp1QWlyQkE3M3NKaThFMnZnZldtUlJWOXpa?=
 =?utf-8?B?VmFOamxrMmMybGE1QkxjdUVPWmMwTEpDUzFqTVhoUWJ1TGVvanVHY1VuWmdI?=
 =?utf-8?B?eEZmTU9YT0tiam5wWmZiMlo3b09XQyt1Nm9GNUc2ZzZaWGg3R2tLY09BeU5Q?=
 =?utf-8?Q?mNG2/ZK1gr2NTx2ffekQNqESn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a97d63ce-9e47-4043-00a2-08dc1b954e5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 21:58:46.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz+/xMHm05yQGEDVg6jpIzznKqzr2x8EArGU28ofYF8zTZvl5VoJ6+/lKxE4z/xyN/514dn5oCcYXKS+vx/+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7971
X-OriginatorOrg: intel.com



On 1/22/2024 12:10 PM, Dan Williams wrote:
> Yao, Jiewen wrote:
>> Comment below:
>>
>>> -----Original Message-----
>>> From: Qinkun Bao <qinkun@google.com>
>>> Sent: Monday, January 22, 2024 10:13 AM
>>> To: Samuel Ortiz <sameo@rivosinc.com>; Yao, Jiewen <jiewen.yao@intel.com>;
>>> Lu, Ken <ken.lu@intel.com>
>>> Cc: Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>; Williams, Dan J
>>> <dan.j.williams@intel.com>; linux-coco@lists.linux.dev; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
>>>
>>>
>>>
>>>> On Jan 21, 2024, at 8:31 AM, Samuel Ortiz <sameo@rivosinc.com> wrote:
>>>>
>>>> On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan
>>> wrote:
>>>>>
>>>>> On 1/16/24 5:24 PM, Dan Williams wrote:
>>>>>> Kuppuswamy Sathyanarayanan wrote:
>>>>>>> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
>>>>>>>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
>>>>>>>> expect a Root of Trust for Storage (RTS) that allows for extending
>>>>>>>> and reading measurement registers that are compatible with the TCG TPM
>>>>>>>> PCRs layout, e.g. a TPM. In order to allow those components to
>>>>>>>> alternatively use a platform TSM as their RTS, a TVM could map the
>>>>>>>> available RTMRs to one or more TCG TPM PCRs. Once configured, those
>>> PCR
>>>>>>>> to RTMR mappings give the kernel TSM layer all the necessary information
>>>>>>>> to be a RTS for e.g. the Linux IMA or any other components that expects
>>>>>>>> a TCG compliant TPM PCRs layout.
>>>>>>>>
>>>>>>>> TPM PCR mappings are configured through configfs:
>>>>>>>>
>>>>>>>> // Create and configure 2 RTMRs
>>>>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
>>>>>>>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
>>>>>>>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
>>>>>>>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
>>>>>>>>
>>>>>>>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
>>>>>>>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
>>>>>>>>
>>>>>>>> // Map RTMR 1 to PCRs 16, 17 and 18
>>>>>>>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
>>>>>>> Any information on how this mapping will be used by TPM or IMA ?
>>>>>>>
>>>>>>> RTMR to PCR mapping is fixed by design, right? If yes, why allow
>>>>>>> user to configure it. We can let vendor drivers to configure it, right?
>>>>>> I assume the "vendor driver", that publishes the RTMR to the tsm-core,
>>>>>> has no idea whether they will be used for PCR emulation, or not. The TPM
>>>>>> proxy layer sitting on top of this would know the mapping of which RTMRs
>>>>>> are recording a transcript of which PCR extend events.
>>>>>
>>>>> My thinking is, since this mapping is ARCH-specific information
>>>>> and fixed by design, it makes more sense to hide this detail in the
>>>>> vendor driver than letting userspace configure it. If we allow users to
>>>>> configure it, there is a chance for incorrect mapping.
>>>>
>>>> I think I agree with the fact that letting users configure that mapping
>>>> may be error prone. But I'm not sure this is an architecture specific
>>>> mapping, but rather a platform specific one. I'd expect the guest firmware
>>>> to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.
>>>>
>>>> So I agree I should remove the user interface for setting that mapping,
>>>> and pass it from the provider capabilities instead. It is then up to the
>>>> provider to choose how it'd build that information (hard coded, from
>>>> EFI, etc).
>>>
>>> The UEFI specification has defined the mapping relationship between the
>>> TDX RTMR and TPM PCRs (See
>>> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-
>>> domain-extension). The current RTMR implementation in the boot loader
>>> is “hooked” in the implementation for the TPM.
>>>
>>> When the bootloader needs to extend the PCR value, it calls
>>> `map_pcr_to_mr_index`  to retrieve the corresponding RTMR index and
>>> then extends the RTMR. Considering this behavior, I don’t think we should
>>> allow users to configure the mappings between the PCR and RTMR. (See
>>> https://github.com/rhboot/shim/pull/485/files).
>>>
>>> Add Jiewen (owner of the RTMR changes in the firmware) and Ken (
>>> owner of the RTMR changes in the boot loader) for the visibility.
>>
>> I think the mapping should be static and determined by the hardware architecture.
>>
>> Allowing user to configure the mapping just adds complexity and
>> confusing. For example, the user must understand clearly on what is
>> Intel-TDX/AMD-SEV/ARM-CCA/RISCV-CoVE, how many registers they have,
>> what is the best way to map it.
>>
>> It also adds complexity to the verifier. For example, the verifier
>> must understand how a user configure the mapping, then get the
>> expected measurement register value.
> 
> I agree with this, what I have a problem with is that this:
> 
> https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
> 
> ...is vendor specific, especially when the kernel enabling is being
> targeted as cross-vendor.
> 

I have the same concern.

> So, yes, the mapping should be allowed to specified by the low-level
> driver, but at the same time every vendor should not reinvent their own
> enumeration method when we have EFI for that.
> 

Given PCR->RTMR mapping is static, I just wonder why it needs to be kept 
in kernel. Given that PCRs can never be 1:1 mapped to RTMRs, and that 
TDX quotes are never TPM quotes, applications used to extend PCRs would 
have to be changed/recompiled. Then wouldn't it suffice to define the 
mappings as macros in an architecture specific header file?

