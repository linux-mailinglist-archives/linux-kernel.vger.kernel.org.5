Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E833676DD35
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHCBa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHCBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:30:54 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9026BA;
        Wed,  2 Aug 2023 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691026253; x=1722562253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LKWttjAvvFnjpa/e2MLAMGeIJGBwkqv8be/kapqYLyY=;
  b=QV8jfT6sMlXVvidFPDSfnEL9eMOiUnjO2t9QnBZJ7fJ1HohU1StwDKEV
   ByE7NfITQjZbwLZiekRs5oHQvodoaS24OdHk9R3sL5N/7NEa5WioYOLyt
   gEm1HQ7SjSfa0/ZD2Wx8gx/5kqsbfI86R9F/CaoFzoeE11H5sLteIG9S4
   rmPtuermPFSsgxd0BkLf8lCdPRLljtGPCmwQSk7pCgTYJulc63lvZ+80k
   LJVj9oD68XZYq9SxZgwuT8j61WIP4ClYcn6f3e6gQvrm2dHaTpEt0iyAp
   /4VhFPwVIvMJuRTCVuw7aCODgC28RUBvN8AFW42amz0GWQJIU4oatwpdH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="367201376"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="367201376"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="799336244"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="799336244"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2023 18:30:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:30:52 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:30:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:30:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaEnUskLQEtZYrSsk92A0YE54fi9pCVvE9ELR3y/ZoMK3znnScBoqqyyr16xUpkekl4AKxD6MTwxzhIS76fvfh/3Q+MFwnllW2TRs/c2nbdptXJ9pxWkFjsrRarzIxqOP3jAjKHWw5AGJ2IlSQj77tq3uW14GD8dCOICsULQcRi9jXWoRQKZL3zMfn7pn+FI3nKPaiQCGeGcntSHwrmVQhLSTFVsmsju4uixJYDYi6mGoUi3KbAU3xf+mjWCwFBxMQA3hfFwMM3r46vTCJy2E5l5pAPIeeAX4AgKDsYCSRM21PWx5IC4RKW5OS2oN4IlRk6kOCnARku6wCZ/OkcbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju/llU2/2tBMEdHeRIH0iAmKgSbMRNrUlgF79LTKVaM=;
 b=X/DPr9fI4LsXp5a4oXfayuGDRXqZGsLztveEjhQo9QvC0Jm0ePjaTizrGae9DjLeywxZiWVJ1QxBBeS6wyClmvdbVyNyZnw0q8wqaCSe8Q7oLbVSp6IXm0aJoP1DK2t5I7RmT42Vvjd8wRKcECirZYqEzp55l2ZcgDSh1tOde8fFA2HRRB6XlhZ+J0pXrg1IsfVJV4O+9NdNp9277sNNX1zVXXhsJoTLx2jN/QO8LStZII83hXgJcjyzu9HpQa8k/eWpYCP+DwpYEUXWYpBOWhnj9grzW5EWnMHaq2JGmyqkQpbNW6JGRC823ZyrA66CKbjye/zwf4HV4yY2N4qFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Thu, 3 Aug
 2023 01:30:50 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:30:50 +0000
Message-ID: <bfcad832-d5d0-e38b-e2c8-3c1cf2d59242@intel.com>
Date:   Wed, 2 Aug 2023 18:30:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] prestera: fix fallback to previous version on same major
 version
Content-Language: en-US
To:     Jonas Gorski <jonas.gorski@bisdn.de>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vadym Kochan <vkochan@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230802092357.163944-1-jonas.gorski@bisdn.de>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230802092357.163944-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d8bafd-e2c1-494f-46df-08db93c1455a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1cyWbt+3qCJbMDv0rKoqhiQRVVMbfG94qAUf9FqHSgb+LBsjnGlXvk7cg0X8TGp4R1l5AAjxeZgwzYtCrN8gcJb43i1N6UbgPepFoaB/uTWc501eWRYQwK/WAkiqk9+uOPoLzcCVlfkxcfWdVGGFt9A/+YdE8TmbZ/3FuKDXdm+Bo0/GH+NU3gDXoZPZCOE2UHfqdHSZgRPQyqd6kt/mTNfBsmZpY4I46eJX0upK0uWGESJN845gZhfzsYBjVqlILcU79LIiF42N6Imjw9Ls2ovpfiinfQ+FB5p1IC12/IiNNF2t9MiNHcHf7lFwJqxx5cImsmv1wuJBMpYSL79v8eZcABi8iuvelVechAONKY2n9ykdfgATHHnC7uSyC3ebrFMcoSkQ6KLpn6fkmbRQQVaSir9N5XB+uSlTZplsIpEMqcaQVTDmn3sjQazVIjuUjM3BojpsuZ8vgEPyEZtYeDJ5PIHL4n+oyO3Pkubsj3hW+YWX9osJrKsgxMaeF1k4vY+DiNIOAtD3sdAtIZ3n/eSQTZXA2XbDbjo8cWHPbmXVNxzRVqEyekjgUwOQOFvg0NaOwgAOcSQKvm9pj7JPHK0TvBqEv4DcOMKdZI4Pzn1HFdcl/OtCV7pQWWVQ24YXXQjmjczJs3ZxUx+iLUD1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66946007)(31696002)(86362001)(66476007)(66556008)(6486002)(6512007)(2906002)(31686004)(4326008)(110136005)(44832011)(36756003)(478600001)(83380400001)(38100700002)(41300700001)(2616005)(82960400001)(7416002)(5660300002)(8676002)(8936002)(26005)(53546011)(6506007)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlVakxNeDA0MHQ3TDJhMkZKbXpTMmJ6Q3FxNUp0ZTQ4RnZDcnUyMWE4RlY4?=
 =?utf-8?B?UUF2TlIxdC9OUnNHNURuNEVYWTBXZXY4aThKRFcwRmlZbVlGSHQxQnAwS3li?=
 =?utf-8?B?Y3ZxdUNEczBQTE5NVUdNVmJlMjRxZEgzL2pTeHpzdnhFbklVd0I4eHQ2eHll?=
 =?utf-8?B?YWYwTW9PWkh6ajA1Sy9rRzUwK1Vid1I1VndoeWc0ZTd5Tml1aWxPOHZFd2VC?=
 =?utf-8?B?K1E5amJiSHBidStvbWt0bVZvWDNVMm1UQUpOOEhkNDNtSE5KM01Lc1gwUnFL?=
 =?utf-8?B?NXZWV0hVZVc4eEpHSXIwcUxHUzh3d0UySktmSUFoM3d6NkJEUWl2NUlQaHpp?=
 =?utf-8?B?UGJxakZiZmIzbmlIM1lxS3lhUDIrWTVMWkcwc2VTZnFYT1MwVU5rWEZ1ZzZV?=
 =?utf-8?B?ZkxhUFloZ3Z1TkpSMzhoQUswQXhjbXJFNlgvZDFFVHlHaFgwRDB1Z3NNTlR3?=
 =?utf-8?B?anpvbERmUXZuNHpnVWRLK3NhVVNkeDdhZU9peTA0Qy9lMUQ1VlErbjZZdjNZ?=
 =?utf-8?B?REpqalpLdnRiYUFCTkZHUnFWcmZHWnJNWm5LQVBrWEFtZXBEUzVXTzAyYWRM?=
 =?utf-8?B?dXdqdmNpSVBjdm1iN3hxa2dKV3dNRnVVUmkxcHJRcmlXa3F5Qm0vWlNmVXZB?=
 =?utf-8?B?KzdtaUdvcEFjZGpNNi85Qmx1UDdwUWFSMUN4ZVVMK0ZZakh3cVpiNDBnN1ph?=
 =?utf-8?B?bnhpMTdiZDZrTlk2b2daeFJVOEdkeVhlNVVyL2JJZG5RMWYyYWR0YS9hbm5a?=
 =?utf-8?B?Rndla3hFYk43Q1dWYWk1MGs0VVdoVVM4c0JYZFZkbWdmR203bWRUSTY5NExx?=
 =?utf-8?B?NHhxTE5LdWVyaVMyWlBvaTZ3ZVhNRDZXamVtMVBMeEM5b3FKc2hBcXBJSnhE?=
 =?utf-8?B?WXZ1bjlqMXJMUlNDemp0U09iRnlxS0NFc055dElYc2x5c3VLZ0lwSlZkTUhL?=
 =?utf-8?B?U0NoWU5MV0RUNHZzVTN2U2lEcXU3UklHdUhZcWRjdGlML0QxZnFZSE8vK05F?=
 =?utf-8?B?clllTnhkZHdncHhyclhBNmI2NWpGVmtxVDlSc0tEeVJSeUpPNFl2QTZYclk1?=
 =?utf-8?B?Y2hIM0VVZ0hFUm1vSmF6cy9aV1pzeVhKWGZrSlJBTDhlU09jeVhrbkhsZnY3?=
 =?utf-8?B?SkZpQ1Y0R0dEaDJFSmhCR2JzcU5TT3hmU2dLRUZuL3VnVzdjZDBHaWU2SWJu?=
 =?utf-8?B?aGFBN2M0Q1FOdnN4RE9tV1IwRk91SzFKaVhQZ0hpdzJxemxObTl1NzVZdm96?=
 =?utf-8?B?L0JwQVpBcHVqK1ArMVNKMWQ0VkJibjFTaFV1bGV6NURJUWVPWnJYamVVaTdE?=
 =?utf-8?B?NWFyVEhNdEViRmIrVlpsMS95bkVwNlQ3dVJDVWgxTk50cXQwTnRyRTVLVEZ3?=
 =?utf-8?B?Mk1aWkZJaTYzYWNEaFgwQ1ArUjRNdTU3UFF3dXhuZnlVZDFaUlIrTlNTVnBS?=
 =?utf-8?B?Y01VWU9HMkNsNGxncHAvZkk1NEp3eEFVMkxpMmkyZWdYeDFodDY4aWdvekJn?=
 =?utf-8?B?alZVV0svY01pQk5rY1pFMnJEajJYZkl3MGpjQ1cwYVNjTElFVnJpeERmVjIw?=
 =?utf-8?B?S3RkUnlQL0U5b0dMMUJmRFJ6NUtkZ21mN05sNGZJSmN2alowYnBzUXZUeWJZ?=
 =?utf-8?B?TlM1ekZOWEhzUjQwTFlic29mLzZJeTJFcUxIRVJEY2p6QnlqbVJsMlZUemFB?=
 =?utf-8?B?RURyRktIZW0vcTArWjVZam9IYjlUc05mMmhTZ2hnZWxvMVlEcSt5aDZTWisv?=
 =?utf-8?B?UWI4OGFvTlN3VjdMcnl5djBOWERpekdLWXZwNmFGd00vVHNvV0w3bnhUVURz?=
 =?utf-8?B?cmZyWEp1ZXJ6Sko4VWUzOGhGT1prVHd1OVYyWmRRSy9kbjU4RWl5TzkrZjRi?=
 =?utf-8?B?YlFRUTNHNS9Ia2l3ZzlCQWJjR3E0Qld6SzVQRDZURGNNYmEwSkNlZXJSak5r?=
 =?utf-8?B?b2JNSmNGWkMxMytOQlBCcEp5MWlFcENQbTRmMkU2THc3cXlMRDEvRWJKMHhV?=
 =?utf-8?B?N2tORDR5Ulg1QkxWNjF4QldUUStQSkN5SlQwd2htV0orbkpKc1lJdlllL1h4?=
 =?utf-8?B?ZFFjQkdGWVFEbThtWmMzSkN1ZG1QRVhVVERwSGh3bEk5b0FtSHplUm9VbTRh?=
 =?utf-8?B?cnExSm1CVTVjaU1GWjAxSW1uQncrWHVjRGl3QWZWQ2tsZGtSQUFvQUtBYmVx?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d8bafd-e2c1-494f-46df-08db93c1455a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:30:50.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW3DRvgNqH+8aS+tCBqOhjGGdIy1gWWb2MqLHEO1KUIeooOxOx1nKsHhOwZ07kldzrkz1aabBuGixk1BXc89LYS047QOYSjR0LwDRDAzVGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2023 2:23 AM, Jonas Gorski wrote:
> When both supported and previous version have the same major version,
> and the firmwares are missing, the driver ends in a loop requesting the
> same (previous) version over and over again:
> 
>     [   76.327413] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
>     [   76.339802] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.352162] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.364502] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.376848] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.389183] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.401522] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.413860] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.426199] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     ...
> 
> Fix this by inverting the check to that we aren't yet at the previous
> version, and also check the minor version.
> 
> This also catches the case where both versions are the same, as it was
> after commit bb5dbf2cc64d ("net: marvell: prestera: add firmware v4.0
> support").
> 
> With this fix applied:
> 
>     [   88.499622] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
>     [   88.511995] Prestera DX 0000:01:00.0: failed to request previous firmware: mrvl/prestera/mvsw_prestera_fw-v4.0.img
>     [   88.522403] Prestera DX: probe of 0000:01:00.0 failed with error -2
> 
> Fixes: 47f26018a414 ("net: marvell: prestera: try to load previous fw version")
> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



