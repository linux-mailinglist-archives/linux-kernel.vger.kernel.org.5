Return-Path: <linux-kernel+bounces-27068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D582982E9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC68A1C230B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D388610A3F;
	Tue, 16 Jan 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9YhNtfH"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB010A21;
	Tue, 16 Jan 2024 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705389858; x=1736925858;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pH2qoEhACY6piTDfl4tnLxW1iWME/QEQDJ9CMDZMS4U=;
  b=m9YhNtfHznIhNq5V9B1TOS+hieSpZpSmxapqJyWmAPXAaRzmVGBMUczW
   etG4M4Let0mK6Q0UXSgUjRAqZPpXSAgFpjJRmY79zCLLT0itO20X5ZK/t
   LMXeajxLLff2Y5F6kCXBFhum3Z9cP+1aKz/m/jNOWGZfj4koISR33pR+R
   sCrc5oaI7QbnaYarmVlEnxowUzr28o3JJbhXXdl0ssbTD3TRvke2F4mrJ
   en+FNlmoaTFx70BjKsbrHY6qVyD4JTO6wUWSovwO86kQaWiMY+9zSwRTs
   D02luL6yqQAw341GFb08zX6MFqIJvjuMYhlM37ikjfucWtuiMVt90diGV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="403532850"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="403532850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 23:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="25695951"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 23:24:17 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 23:24:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 23:24:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 23:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZCoOBVE+i/hUGYhT3bNb+VbrlffEj4LtxFRIl80/bauLAVEYsB7+CkQfcUuiMmFdLUmdPlui/esQmBljQAd2h2u0/pXqnjWdXc28yXGnjruOkxtG0SZ7/eSR4re5r74L2ltU9ZELQ1K4IEgQH1JBDn4klvWIoF3S4xGPM8Ln4vBFjO7lGdgWR/q5Z5N+Vy1kBKZXdrYn7KtkvCLeUzVo0ICZB8VTbWzlK3JlQTSwp5wtt8F+XpsH8db5/AMSLsJqsAHvwDiE2cSqvaZkUvXdgZ56JyYgGu/s757Coh0Ks4T1mG3Lg+vMGN59nnplYCWkJZ6+UqwHKurG/px44bNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C2ougHS0iq932zLSAxlzYhxx57Rppu6TbtmBBOzRvo=;
 b=OSPRpHDvQgaOf20Y+hCULTekshxT47J7VqbDYeUoWohJXLeBvqTqWGVEP99Ob+dNDxnb0ji+Rxz3pSxxCaukZ4dbBkx1X1P5JfLF+o/f6NX3d27HbDTxbew+cTRH+J8opkEQBooV24EJmuelbt4cDNYyROHCXa3yjl425S8GtWUaKVsih3j9nsL6oR8Jtcn2zsv+UhzRty/2kiOMYoB0FiVXS5mjGS2bKTmaKALtclHdDUnyYaQ7OZ5MrHhDVU4jjOCtxfMcxD/aJG8U7v2+98s5cG9ekyzgiIh283OfEJ5YO3oDshl4rmAlAt6BmfcqyMDjSsZ3Re3mLWOaxPt5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8724.namprd11.prod.outlook.com (2603:10b6:408:1fd::5)
 by BL1PR11MB5382.namprd11.prod.outlook.com (2603:10b6:208:31c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 07:24:14 +0000
Received: from LV8PR11MB8724.namprd11.prod.outlook.com
 ([fe80::28ed:e2f9:9973:b40]) by LV8PR11MB8724.namprd11.prod.outlook.com
 ([fe80::28ed:e2f9:9973:b40%5]) with mapi id 15.20.7159.020; Tue, 16 Jan 2024
 07:24:14 +0000
Message-ID: <cbdc15a7-f0f8-472c-ae24-178037b99da6@intel.com>
Date: Tue, 16 Jan 2024 08:24:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/42] drivers/scsi/isci: Convert snprintf to sysfs_emit
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-kernel@vger.kernel.org>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-25-lizhijian@fujitsu.com>
From: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
In-Reply-To: <20240116045151.3940401-25-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::45) To LV8PR11MB8724.namprd11.prod.outlook.com
 (2603:10b6:408:1fd::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8724:EE_|BL1PR11MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: c97870fd-7408-4898-9cf7-08dc16642434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Rdd6GiaIsh1d785ou/NtrrkVYu4fq2vnWAQ5b5F8dht++XU7a5tzuxkuw+wXrFsKfyeoit+TqIb+hF4WIhm3skv7wPW+CeVB+brdvsFLAracCb3VaLd8x3q6ZvZJrDqsdQkQWzxzM0FKpyQOWgX/Bww2P9iycBgZzlI3RaHPru6zaRqP3+j+l5iJMATquuLZRnNuXx1BFfOA9dU4T88LjSxCbX9RAlpDFlcQiMAmA4BqaxkCX/8wpEvX7UhAWunCsw4gt7MofLprbHZJpwZ8aQwhyPxsZ/NjUG8s6IfgvZa2KNfqMHFLO8B46PGho32pvHd0gU/PNsLBvkzEUEK4kfJlqP4W0E19rpRUMUAED6vm3w+SL/Q9aMX0KGtj++ZVNttZlnPsscVgiuygHxltJglUtbkKoi6cF3P3URn9qPZDBHVuYrGeTNlwsNgqrv4wC/6lCK7aba9QXSUjFnh4sxS+RAkEYjurUtCocog3ZCVYWlq/Od/hSNgNyVJodVD2XHnFRzIWS/sJtw86ZvXy5+is6hQjI2b0a13lPsowv3NdEZuH+8/t2drvYdJDn+ITA29Y7oiFCpJU162+V80Ey2cv2ZW4V/Rlna5QRHdXhV7ZH2es3zX4sIsTzw1xKAWsAcqtKTXBJ05N/UUrjkyy9GRtqD95oH6BfBahz3rDVGHijaKSykM8+J6SxWjz55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8724.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(31686004)(6666004)(478600001)(53546011)(6506007)(6512007)(26005)(2616005)(86362001)(31696002)(38100700002)(82960400001)(36756003)(2906002)(44832011)(4326008)(83380400001)(41300700001)(4744005)(5660300002)(8676002)(8936002)(66556008)(6486002)(66946007)(66476007)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RFYTBjWmR3SlhEdjdxL3l3V21sTW9aaVFXN3pLM3BWbmVWY0l4RnE4RENC?=
 =?utf-8?B?QTkzbTVtSnhkQUdONTdYTlNjWlRoL0pHRkkxV1djV08vQ2NOUXNleU5Oc0sy?=
 =?utf-8?B?SnVITVNLaUZ4aS9oTFRYVnNUVjB1RGFCRU1QU1grZGMvZi8wODRxMnNaa2lO?=
 =?utf-8?B?dFBnZjFsb3U2NUZiKzI2K3VhenVCSk1UZDh6VlQ2R1VjTExtWFZ2cTdHczUy?=
 =?utf-8?B?UGZPR1g1V1NsbXBpK1NVYVhvNkNkcHdFb1lwazlvTm03SmN4RkppUkplbXFM?=
 =?utf-8?B?SzBuU0NwK0ZkYmUyQ2laZFVzdzIxaGpvWGdKR0hpUHkvVy94UTMwRDU3MjRv?=
 =?utf-8?B?S0UyWlRwdG5SejR2K0V5RURSaVF1UFo5cVYvaS9uNVBzcHBFb2JmdEVZQVVN?=
 =?utf-8?B?MU9RaW4rYUxWd3FxekQ4MGU5cDEvRDQ1RFdySUsvM3JWdVIzUXh6MThuaUVD?=
 =?utf-8?B?bWxacGpkTndFV1lTQlhFdUQxVGE0aWlwWEM0dXNkOUU2NWFhOXE4NHl6SVV0?=
 =?utf-8?B?SHZmMFJRR2JWNXhBTkN3L1Z6MFJ6SllxQklIZ2xMV21PWUN4bGJHN1VlcURU?=
 =?utf-8?B?ZU96TkRvOWl6QjY4YWd6cGVCY2kxWUlwOEZaRm1ieW9RcWs1amt3Zm9SQUlB?=
 =?utf-8?B?SW5zbGYyY3ZlQ2VPK3pheUhTSWtHTzA1cGZhSUcwbGFQd2liYWhpeC9pREp6?=
 =?utf-8?B?eEgyNkpDUkRxZVpuZFRsNkZmSW9hTGpaVGFXbnRmRnd3czFRN1hvRUlmeVd3?=
 =?utf-8?B?L0N4K0NQR1JHWHRzdTRnblo3WTI0YUJEaDNqK3EvN0ZicFJQTFBzWmdoRmpN?=
 =?utf-8?B?MEJKWExDc1JmWW4xT2dlNVJzMHlaVW1FWEtjZWNzdmpQaWJhUXVyNkNBME9L?=
 =?utf-8?B?eExFdE9rTEhhRkxuQmNmb0JaSFBZTGVFYWxkeTd6bWJSZ3FGZDd1ZFRJREd0?=
 =?utf-8?B?ZkY3b2V4NVl2Z2U0aE5yT0V2Zi9sVVFkN2JPZmZLbUY1c3JxT0o1eXpwNFRL?=
 =?utf-8?B?MlBNdnc2OFpQT3dFVHJqV3RubkpPdmtwa0JYZkNtdkNjOHBHNS92VU00dFZa?=
 =?utf-8?B?WlV4bXg2bjJFTUZQTjBnaCs0a292b0xMelRxVmRsaUFuY05IVmNOR0VmVVBI?=
 =?utf-8?B?K0RjMytadjB4QkcrMy8yUEJHVmhUdVpVUXFwSkNZR3d5VjM3TkZWRkRMWERu?=
 =?utf-8?B?eTZ0SEMzUW5iWGs2TnJMWEQ2aitUSFhERkZTRXBZbXBieWp2em84bjVTUDJ6?=
 =?utf-8?B?T1hpRnhkd3E0NGZGdStleVp6OE9wNmV0R3Z4M1ZUdGV1eHhCdkRGZ2FvT1JE?=
 =?utf-8?B?b1lFZC9TZFJ6cUQxZHdOQVVEdFlBNWZma3BPVWt5U2p2RkR2dGRDWk5hbFhK?=
 =?utf-8?B?Z0Y5dGlMUW1kdCtlV1BXSkZiZzROOVVmci9BVjJWRHE1Y29iYUR3Z0hpay9N?=
 =?utf-8?B?M3dVaXVETzBiQzZuRGgzQlNDUmJqOHpJdUMveG01M2M3Uk5HUHhwWFo3WE9p?=
 =?utf-8?B?MTZvaUU2emhOcy8wcFFRMS9iLzMyN084TFZJTUk4WkpCY2VWdGJFK2NMa3hF?=
 =?utf-8?B?NXdMdUIwNTMxM3VJZ3RUd2Rndk5DUzE5Q2w0K3dYOTNEU2d4ZVVwNVZaTTlK?=
 =?utf-8?B?YmR2MEhSL3BIdlNYZ3p6ZitBVUVJRHpURDcreHNMYS8wUGdMeEZ6SXB5TDN5?=
 =?utf-8?B?Z1oyV1JDMndLWklPU2JmRlNnNzV1TVpUV2JLNXJqRlB1YUw3TVRJRXBUakRL?=
 =?utf-8?B?bHBEL2lpTHhaZFg0dlM3a3Z2TWU4U0xueWpnelJGR2RzTFFpZUdkZ2RFOUpH?=
 =?utf-8?B?eG5ZV2RROWc4K0Q4TEpJZ1N2bXBvNmVMODdoZDhkVTcwOHAyMzNqT0hjU0NW?=
 =?utf-8?B?QlJQZjRIV0NPckRzZmRvMmRVMEd6V3VwRFRPTzBnb2ZhUTFrWW5KM21DVlJ5?=
 =?utf-8?B?UGdJZ0FGL21nTWtXdnVLbVE2bHkrdmRrY2l0YzFzVHJuTS8rQlBYUFdLUnNG?=
 =?utf-8?B?YkFGVis4Y1JYUTQra0JGRjBuNzBrUjlncHlGQ0dQRFRWdWFzOGVKMTlvUGhs?=
 =?utf-8?B?SU9jNmd5aXJsbk8xdU9Fa0VqRnVDcTNiZVJ0NW1NcVQyZVh4ck1pODJVVzdU?=
 =?utf-8?B?djkyZERSd0lTUHV4QlQ0WmYwTUVWbUlQeFRxdFVLa0NaZmU1MVhkZUZ0TkhE?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c97870fd-7408-4898-9cf7-08dc16642434
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8724.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 07:24:14.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUEfCHz+khhXGRyJCQ1/4s721Fhmy+nv3958B/BnUsXz+M/zX4F3blNofd8uDE+S93qhJ3E5Zsnbbs9pRflirwjVbay67SCNMnudbllPJQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5382
X-OriginatorOrg: intel.com

On 1/16/24 05:51, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./drivers/scsi/isci/init.c:140:8-16: WARNING: please use sysfs_emit
> 
> No functional change intended
> 
> CC: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: linux-scsi@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>


