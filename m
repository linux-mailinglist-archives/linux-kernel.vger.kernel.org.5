Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6C7E1E40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKFKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:30:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E7C0;
        Mon,  6 Nov 2023 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699266638; x=1730802638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lm7Xmey6ELbPuKb0cNkWZsfs3Ua1fv5LubFuqYhmEgk=;
  b=TjJy9GLXPpnKltP/tNCQMFzNOdxaR+nwOQifa1WqSpHHZoBK2VLgl+BG
   HhRUXdSbjWo5Mr+dOVaATIcdRpYTl8eq7SS515fNufDw1azwX6lbR/yx3
   Y30MswCFxe1mScyIFxnHfRNoePVKIUZksn1PaTD0RnpAFq8SSCM8luzFW
   xnLzxTC9ctuMXluPy+e/j1LN3aUOajg8oL/OIU5G/tGQCA4c5Y+Q4gO0S
   ZlJ5v5FDWZJu5zW7gyZpxhf4Sr8BcfAcjIAxlHniyV+EqClmKp8QHHC9I
   l4uSluh1FHPDQEmxMnk7WAG/uka/Ijk2hqIC/2OJaUvFQerrSrNx42Gru
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2236439"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2236439"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="3585531"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 02:30:37 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 02:30:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 02:30:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 02:30:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 02:30:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6GkT4iNE6uGMpKe9cTQephcSf8FF2tCn9tNP9tOs2tqg+FmK+8HbjTezfKfIWo1Zs7xgKNS69Dg2honyn8D2MkCkQQesSkoKx98jxsNBeIOUXi4w2gm3zgWKKRKWt3i4pO+qS0WVzE5lnqgUxLkaauckAcjyBUVqICqI8LwdmvKfBkv5I6Y7gQ4/liv12I43wkxcL65kwLScZ2vbJSF5RpfsKldSQPUTzTdoPAuqQviZb0FT7gThIaL4o3LUJ0C3T0/8fN9E7djaUhXny1M3X73bK1Z/xRLyxQAc9901Fr9+T+v8yicH9AP/QZXpJvdm1llGhQwE5XRt/5dtn75Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr0vLRMnFQJQymVIc4FTRtqkJ6y/XIemG9SxZbJGez8=;
 b=nw77VtOLCU1PAgNvb5bt6EPhOnxW20gcvy6/g6dhraBgxTNf/u65J7qCll8Kakj9Fc4c/NAemAovU/0SmyGR+5eqSDR/pymT+uJuFknW7h6FK7lMJy84oWiCij5HCanm/BgxwuEszDFFo7SCasOejhMgjlQ/6fX2neWSmQMEmk+lHeD3evZTwyb7UfDoIWWOuI6+wvRN4p0CYX5IANryxfp+lIbV+oEFFcfT1f1GojyzOIG/KGfzdo/va8wJ9KK4Q5IUwRKNGI5HAEpm5O1Sld4EyNARkamu9U7QhFDdR54JsYFlL+n+oJUV1/cwp4d7ILiUWhBbXf1IefV42ct7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 10:30:13 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::4bff:ef3:3532:d7eb%5]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 10:30:13 +0000
Message-ID: <07948380-e893-4b1f-e96d-cf889d57d512@intel.com>
Date:   Mon, 6 Nov 2023 11:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] rfkill: return ENOTTY on invalid ioctl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
 <a069393c-86b3-ef79-82dd-0b60caf2a907@intel.com>
 <613039a4-41af-48ff-8113-3b0ee8077bcf@t-8ch.de>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <613039a4-41af-48ff-8113-3b0ee8077bcf@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd39ac4-e35d-40b8-fa83-08dbdeb35bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3manZncCO9Yg94tEdeIA6Ix6FSiJe/63vULw7SFeuwSxeZNp81gq5Vkqvky2d21QqrFr1+UZbHzXyzWWsZsAWV5jMyzM65KXi6wEcmgQfarjoTLgAYNgkouk1eA15bpiyPXu09Bg0KNXAL386R21IjeBf4zPqa6lh5pglWevJn/sSv6yk8qVMgM0IJP063eu5t550ukKfK42RdvkCb9P3TDqueUF10850VLFNngdpKi1orjybkbEscBnccIgrCUAr2JZgpz1slasQSYT+z4ltAMbWyOquRTpvJ79o+HgJWU/Lw11BOwM44hujzj2oZfFx29g9pvXOKuF1k6PpC/LVjh4zJrS69b0QDviicdGrZJnep7e++eFg45Js190Vo0QzymZ3kOauCluCxJv892sASrghAMV+zewXsWzYzeoM92W+vbB0H2xPSUj3AMOAWbWllSSb1+LdyoZxtnQ2NWrK51jry//DR1k+2NlQuOxkoT3Y0akuX6cDgRZqIGjt79G1HMXngKWhH89yD303wTdfVn8y7HkVYRBtlNVzv3EzA1rwwxlMAb6Lv8QqqpUpQVpOOxrI8nIxJafQjGGpZJ1rzQFHgwCkTE686mj8XIdxYG9Bdr1nId2qrtR2Oa4enLwGgIvQ2MENysVM7UTWuMRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(8676002)(4326008)(41300700001)(8936002)(36756003)(2906002)(38100700002)(5660300002)(31696002)(6512007)(53546011)(6486002)(66476007)(54906003)(6916009)(31686004)(86362001)(66556008)(66946007)(83380400001)(66574015)(26005)(82960400001)(2616005)(6666004)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlBbldrN2ZKUHVWbXFwQVYrUVRwQTM1UFRpdEtTM2dUVmxNZ0cwZmlOOVdL?=
 =?utf-8?B?aWZJZ295Vk1vd29GWTFVVXVKSGU0Q2FGY1FROHRMWlYvZGFLZERkNjFDWHVZ?=
 =?utf-8?B?WFJZUUJpcVRiR29BRGh5VGNOUERqei9ZTVYvbGRQSGdCTXlLcEtGeGc3QzJS?=
 =?utf-8?B?VitBZlJZb2crWlFFa3dRMU9wM1RtV3QvNjM2RHFoT1BacjFzeG00V215TnU0?=
 =?utf-8?B?WENGdlNhNXV5VkJ2eUJSbi82d2tqM1ZjQkkzRjZPUXVXWmo3bjhvUWgrREd5?=
 =?utf-8?B?b3lvbUJrc0hyWTBBVXd0UGNCR2RrbFAySlFKTXNVaEZaZzVxakdEMndEMTZD?=
 =?utf-8?B?QjBrTnVjamlJSExxcFpIWS9CaTQwNVI5TzZ1QzBSUzd6MkVDMWFaU2JmdzhS?=
 =?utf-8?B?T2IzdTZFTmdBM1pwd29POFgxWnQ3QVQyc1NKWS9oVlY1NXZNM1dYcTIxQlYw?=
 =?utf-8?B?TnFibjdtT1NkaFRodmdWYkE0dXBZSC9QSC9mYUhKN2UvcVdDanBZN0FVbGVY?=
 =?utf-8?B?Yy9reXRmYS9TVEs3QlVoblZUUzI0RTlXL0pvYk1RQ0k3bGdvQTFSQnduTFJr?=
 =?utf-8?B?QlQ3SjBTWnI3RXRtLzhJek94bS9YYnVSeTBJc3FYSkt4OXJDMm01czhpSGV3?=
 =?utf-8?B?QTl1Q3RId1JmT0F2ZEc1Z2lmalI0LzdKaWNTMUd1Rk8vUEtCWmtMdk5RZEZs?=
 =?utf-8?B?NlVnMHRxSTkwc0J3N29iRHhpb1liRTl3ZENBcVpwWjcrZXJyaHVvZzlrRTZo?=
 =?utf-8?B?a2JPRjVGdVFWVzNHZGJXTStDUE41cUJSY3RibVo1d2JpOEpVbVVnTTJzNHNi?=
 =?utf-8?B?RitkNFFTNFEyZ0NzZUhVT3pxUUkvSmNkWFZyS3d6N3E0MlVMbnk4KzRMZy9T?=
 =?utf-8?B?bEhmTUlTeXhZMWNOT2hnZXRRRkkzZ0JrcWRaMCtSMXJPazZlZ3RJS3d5R0xX?=
 =?utf-8?B?dXNWYTNYMkpUUHdsY3BuaklKUzQvYThaanJHTUg4NkJDZ2pYcG9WaXpXVDBW?=
 =?utf-8?B?WDcvU3VSTC9QUndxRllwZEUyUVVhZXVwd0NJcFNHWlB2TCtkZktrV2lRSGsx?=
 =?utf-8?B?T2JGTVdiaVhiM0c5YWtYU25ybmo5WHcvbEc5Qm1oL2pZSTBrUkhBL25DTmJ5?=
 =?utf-8?B?aXVxVFhXUTNkUEN5MTVHazVTWGU0eXFCaS9lS0U0cXowbEQ0TVlkQW4xbnlW?=
 =?utf-8?B?a0FadllPcmJDQ2Y0QTZYdWx4UThLa0FYSGN5aHlOaktNNFRWNURoV3IzVW5h?=
 =?utf-8?B?VnZ0MHdaVTFac2JJdkFyYjExMERMTE1VMlhzWjhNaEpHclRZc0xJS2JVdmdH?=
 =?utf-8?B?bWlJdzdYZ1NhTklGR0huUFFTSVVMMmxVSGl5NDJSQTdmVG1QZzAydDkwZTNs?=
 =?utf-8?B?cUtvcWJyNG1iVnlCMDcveXI5bTVpbFJlZEpURkNoY1IydXpWTEJ3cldFS0My?=
 =?utf-8?B?RkJmWHJhM05iaFpYcGhPY3ZxSVRtZTZZd1JHaUhVUTF5SXFxQVBDZmlFOTlx?=
 =?utf-8?B?SjZsSkVHL0dXek1oL0RqSU5kRmFONlJDZkxBRE5zWGJuZnl1bGY1UFVKNnRC?=
 =?utf-8?B?MDBWUzNQNmJhS1JSK3I5SkhJaXZwbXZIOUJoOTFneXgvSE5yTHR0Rlp3VE4z?=
 =?utf-8?B?dmNGY2lWeGpHNWdTZUF4VmNtZi9wbm1BWnF4WCtXVGt1UUNBYysvTHh4N3hN?=
 =?utf-8?B?YldkWXVUQkJjV0g5T1ArNU93bGhiZUFRUnB1RlliOTQwYWNTVzdHMmtkSDlW?=
 =?utf-8?B?SUFVV09haUw4K1hzRGNuekt1M210cFcrOW5lRFpHK2s3RndpdnlpcHA0YlU2?=
 =?utf-8?B?ZVJEdVlVb09PQnROcGxZV0c5cmdtSW5lb0xNUGg3Z2Z0RXQrVzZxaUtHdXJK?=
 =?utf-8?B?U0ZaL3dTZVBkUVo1NGx6WGpCQThqd2ZsTCtScFQ1Z3VKOGtXUjhCOUhiQVJw?=
 =?utf-8?B?WSs2YUFBaGdNdUNuSndDK05sOTZlUXlrUE1zVDZYN3o1dU16Q2xKdGlDTXY5?=
 =?utf-8?B?RmZKQmxmRG1Ob0pwM3UzeFFOejdzdmpCYkQwc0J0MFcxdTVrOGZOWlpuc085?=
 =?utf-8?B?MTJTNGhFYU9sR09yNkVDb25Hai96U3ZNZ3JTWHorT2ZtV09VTW1jQWRhYlJS?=
 =?utf-8?B?NDlLYjJGMWJzZjZ2MXlGd0diQUdqb2FRMEExWWxvNTN6eWd1MkNJNktDMFFG?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd39ac4-e35d-40b8-fa83-08dbdeb35bbd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:30:12.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaU4QDIaKgvHIyAQPEMwg6ydiGckfTqFSkKdXQJmRM61giYFIvnYE92uj96PbcQ9YvaUVHXA1FsQ0OQgg7yxtR34fk3ojbwg2AptgRb48Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 20:14, Thomas Weißschuh wrote:
> Hi!
> 
> On 2023-11-02 09:57:45+0100, Przemek Kitszel wrote:
>> On 11/1/23 20:41, Thomas Weißschuh wrote:
>>> For unknown ioctls the correct error is
>>> ENOTTY "Inappropriate ioctl for device".
>>
>> For sure!
>>
>> I would like to learn more of why this is not an UAPI breaking change?
> 
> "break" would mean that some user application worked correctly before
> but does not do so anymore with this change.
> 
> This seems highly unlikely and I was not able to find such an
> application via Debian code search.
> 
> In general I did *not* mark this change for stable so if some
> application would indeed break it gets detected before the patch hits
> a release.
> 
>>>
>>> ENOSYS as returned before should only be used to indicate that a syscall
>>> is not available at all.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>    net/rfkill/core.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/rfkill/core.c b/net/rfkill/core.c
>>> index 14cc8fe8584b..c3feb4f49d09 100644
>>> --- a/net/rfkill/core.c
>>> +++ b/net/rfkill/core.c
>>> @@ -1351,11 +1351,11 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
>>>    			     unsigned long arg)
>>>    {
>>>    	struct rfkill_data *data = file->private_data;
>>> -	int ret = -ENOSYS;
>>> +	int ret = -ENOTTY;
>>>    	u32 size;
>>>    	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
>>> -		return -ENOSYS;
>>> +		return -ENOTTY;
>>>    	mutex_lock(&data->mtx);
>>>    	switch (_IOC_NR(cmd)) {
>>>
>>> ---
>>> base-commit: 7d461b291e65938f15f56fe58da2303b07578a76
>>> change-id: 20231101-rfkill-ioctl-enosys-00a2bb0a4ab1
>>>
>>> Best regards,
>>

Thanks!

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
