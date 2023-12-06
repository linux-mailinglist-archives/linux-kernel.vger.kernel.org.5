Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB48075F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442700AbjLFRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjLFRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:01:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE60C9;
        Wed,  6 Dec 2023 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701882123; x=1733418123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MgqNmIvzHCUDnqqpd6VhU2sm9e4nwuGwyiMYB6rCQXI=;
  b=k0VPoeNd/bKpq6Qp5b/bLgcxPRV2cumzJg/FhOwa/+iio9sT1mmdecSG
   8wLxsqtcjzRIW2fXNK35AuMRCPmR8IjEuhSkf3Qlc/364kD3MZ7j0SW3S
   D/xb2qb0TGMIG27pxcxaf4dvTgvr/UaGFfLOWVwX3MFTxYT6eFa9r8h1b
   G7XIaZtvTkvXz0ha1Wi0AIFh2L2oYWP7NPMPz1S3Bzek7g4OwZt9gxthV
   8y1U/Cf5AOpOUlNiwFAAR/5+7kXiWguypBBSTqt69uSwZx9qu56DQv/KL
   tm1FpKZNQc8DWuUTSYhypyDvPJTxIULoy0gJzUBZmcJMNzyXLofZORtcB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374267207"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="374267207"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 09:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="19382073"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 09:02:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 09:02:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 09:02:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 09:02:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 09:02:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXAS3ItHl4f68RLLw8o3III3QbuF+xUY6w9QhTLniNrcZX19jw7toFfDKjFa/NDeJnkRIdMtcOYzmBCJTP4qqlaWS8qDfCcVNmaKoa47HziJQJFMENGeZXGvR78dksrGv/acBIGicT4gETj3zr5iB7Ua+e5OoOT/QjO1S8AWrWFn3grTP7xe+AJhNM2AWQHNxlwnz+Q3m5MKnpbJ8DFZfxSIfhxwgdC1YtS3CrMnBQxgDcaxMxpFYjV76TKoCiYvTj1eji3FpnYmUnlGzk33BPB0mayI80ECV0ZYjmLpESFjibjhKxEhEGGgRx72S3Zh8wpvfzDQ7++q8s/kotZoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzrz3xMWEgsrmgzOui5kIkM5UBHxa1vg3+ct2hloujo=;
 b=LrDAxzF1R7KLMTgCzonoVhMFSOY5P8kJ3rkj3Zxn6LWHbzXw+aMJ3B/ngXD+7FQKzHKKHib27uBiLgpu6IbssrAPyyfE9gIj2DbJK5pQdG0dNScrZMiMefjQsIynDoumKd6ora6oqxQWmte92JVq6B1XrAv/GSZHK22UDj79Htg+3YsGynYYlgcFEEFelXZ9TvtJ5srSZLEOpaVITvsrMhBOECj7IkxTH7BXBBYDebn1FOFdXGb7foQQ6iYWFWxUQgej6BZMXvIR5EZYdtbZgoAgHZwZTwbFCZ371IrLYayBK5+JKvvYmwCq1PDz+0t8tP9qVT1lTEY2am41WJRDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 17:01:54 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 17:01:54 +0000
Message-ID: <575e4395-dfe1-4399-9706-cc02f56d7ebe@intel.com>
Date:   Wed, 6 Dec 2023 10:01:50 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] ACPI: Correct and clean up the logic of
 acpi_parse_entries_array()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yuntao Wang <ytcoode@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231120114143.95305-1-ytcoode@gmail.com>
 <CAJZ5v0ijJeOLJo=ooru9raj0n=iiGybFCud42Z+EEtncgNk47A@mail.gmail.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0ijJeOLJo=ooru9raj0n=iiGybFCud42Z+EEtncgNk47A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 81234d37-f09b-42cc-f487-08dbf67d0c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cb2j+lt26T0AAfF4xltHuVIMsSM/HA9sAGl3MetuFc129rRhhWOng+SBrQSTULDTqbX4fLp/yMIReoiWWRRrH2VdK4rJQECvleyfLVGZnXGGtpUpNOeGo08aKxueAj7uX5FjFtrq6xvZPQcwv6XWvpkZvBAt5rZMwwoERnFSqDiFOB7c4ZCwMrIEUFhMpufOQVU961dmw2W01fd1CFi+ywEOSkjzKKM0bxKq09xxpGYn+JoORvsXX85RNUObVaZqPRKkG9Kdg7fUOgeaG+BVhhFXNTIsJXnEvd3DOjU6pEynUfdn0QUBm+jjKWQdNir7lkAtJBVm1772JVqUbSF67O/hmUlGG5gSJzXsOfCo1GE4J9mFS8o7e97updUzec3fSyQuRDbHvpf//5xgtfq2CH+X2totkue3T5Su84qWblSmI5FrxjLQGqrJpJ7dYqgpYK5APJb8HnwCWlj4QopTVzg/hhPVazs1Hnl30Zn02oo1/sBKIlkMJGFWU8d8auHgqWfJBJJJDkAmv8dlkVKNdRzvUZrHX0NjjY4Z6a8Mkuy382/OMGaGNniyW9e1kYCQpfidf8VXk3FdixkcMJIJxelEa0yh5jukK2QHDUakWwlQ6cFoIdjx3xDO0ujvig5wH/+xWCWV9K8Ov6hfiyCOUQtzESV/pW1dAXjXGZDbAr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(6486002)(83380400001)(478600001)(6512007)(2616005)(6506007)(53546011)(26005)(6666004)(316002)(110136005)(66476007)(6636002)(66556008)(86362001)(41300700001)(8936002)(36756003)(66946007)(8676002)(4326008)(31696002)(2906002)(44832011)(5660300002)(38100700002)(31686004)(82960400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUl6QnM4ZXl3c3F2ak5KNVNvaUhqdHloVmdCOG9iajRGZnVKU0xuaHRScUNN?=
 =?utf-8?B?d2I5bWZkSExOUVpDRkxEeEtXdDdWT2J6QjlJeFlZaUVxZWc3TytuRUFzV3Vh?=
 =?utf-8?B?aCtkS1ZXVlloWHJXWmVPa2Fyc285YmJaaU1pWEQrclp1REo1ODVIbmdBTTd1?=
 =?utf-8?B?bHp2Z2lLTmdsaWdXZ1pydHpndTNoNEVjWmZ0cEhSM21FWVNQRWVMSkdRNVZY?=
 =?utf-8?B?b1FoSERJVWpjc0NTR1JjZzJ3MythRnBxMGthKzQ0SmlJM1BIcFpMK05oeVI5?=
 =?utf-8?B?THhGMlJNRGkzcTBmTU40WW94QllQR1pYdEZjcDhvaWlPTHNZekRRMnFyRnlh?=
 =?utf-8?B?TXlmZ2hWWDBjcjFxNDZIZVc2dS95S2dxZm41cFdwSGJaN2ROdk5xeGxwQ2Zp?=
 =?utf-8?B?d0hYZXo0VzVBS0VWaW5KVEhteU1wNzRqTFM3TkRwdlVvOXFBRTFPOU9RdG1O?=
 =?utf-8?B?OU8rMmV3NU9RZFVwdjRNbGpHK25hM2c5QTlyaHdoTmFFcEE3aDM5WFpSbnpT?=
 =?utf-8?B?enRtaUp3dWlhZDEraCt3ZEZndnpRTVEyK1ZqNmtUR2RqeFhqZ3F1ckdGTCtO?=
 =?utf-8?B?VC80dVdueUNUa0x0cWorL1V1SFZkc2Y4YVJYMlUzMnZWTGlqMGNXdFNHL1JC?=
 =?utf-8?B?S0VMSHlpTlFaZlZpbWMvL1RsL2RXY2dHVmg4T1pnR2JSVERSazQzbkJwUXdS?=
 =?utf-8?B?K2gxckE1VnJUaFFiRFo1anJ3OVBsUSs0Ulk2dXRQOGdnc2luR1ZtZlNJbzBL?=
 =?utf-8?B?VDVyU1g0NHdGZnpHK0dtdklLNG1SQTBSM0t6NVA0emRWcmd2QituaXc4d0N5?=
 =?utf-8?B?N2lJTE1BaVRJWnBIeWtLaFJBeDRJZFFISk00am1hTE1ucTQxdSszcGV1dDlj?=
 =?utf-8?B?eXB4N1ZXVTdkeUh4Y3dUMkVlODdjM1Izc3k1RWVNa3B0cDA4eEpxRzNkY3Fu?=
 =?utf-8?B?cm9OUk9LWG1GZzhCc1F0OFZpVzlsQy82NS9qWGxQazN3QWdGUGZNK1h3THM5?=
 =?utf-8?B?cDhYeXBlT01QVW5kWnZVamxZa2FaYkJYQm9sV01rNjBYSHFZQlFYKzdzRkpn?=
 =?utf-8?B?L2RnZFVtV1lmK0Y4YlRKSUg0T0FKRG1SdUEzSklMRTF5dG5tNVZIQWt3aXJq?=
 =?utf-8?B?OVFQKy83dXlqWWJnblZSVjBEK2hNYy91WXRhelNBSXlnUEJDT3NBN3RJNFA5?=
 =?utf-8?B?N3pZbG53ZGV2T1l6ajRSUW5TT0hlaEJIR2R6SG13TERXdThpTWdqM24zWXRr?=
 =?utf-8?B?b1RPM0JhQnRJVzNsODlROFBOWjJrTVBFSDcxYkQra3lXYVdEdXlteWk0a0dQ?=
 =?utf-8?B?K0JlbEhOTXVsVDhMS2tHaC8yK2xzRnFxamIrcmJsNkwzL2xBSzlnUTlNT2xB?=
 =?utf-8?B?V1BPU0pWQjAxNWtYV2FoQXZ1UVN6WWhIV3hvNXpQRVpQVVNIK2VWd1BTdUhM?=
 =?utf-8?B?REJqY2dNQ0JmcVJqQ1dVYjNqa1BROU40cTNvcVZDUnJwdnJMU3NWNUViRndY?=
 =?utf-8?B?OVd1dlVCSVZoRkFQOS83YVhFR3NpK3JodGs5SFFHVGxPdFpHOU5uS1E0Y1hj?=
 =?utf-8?B?UkpBcWRIdTVody9ndXJoeEtuTEJPN21JbU5RNjY3QngvdzhUL0FBdGdUTTRo?=
 =?utf-8?B?bzV4N29WMllKdVJ1YjFIZ09jbmVFMFJmT3hCeGZtN3ZJbldXbEprRmdoOVo2?=
 =?utf-8?B?Mk11cng5TG1RQUpUZkR0WStXTldFWjk1bVJsbTZ0MSthN2oyeFVEWEF6VTlm?=
 =?utf-8?B?c1JSV21hVnhoSy9PWTJZRjAzMjdHRE84Tk4vZE4xR2k3b1BPZzlLV2tHUnNw?=
 =?utf-8?B?Q2dWOUdjTktiWmdtVU50Tm9UNnRKem5Yak9waFo2d3crZ25HN1Z6VTgxaGxy?=
 =?utf-8?B?Q3ZUaDRyNTVpZG1YZWIvOFFUdWhzS1UzMUMyYTVKSUR5OHBRbVovcTV1MDht?=
 =?utf-8?B?TnlnblIvMjl3Wk9zL3FFekJNMVhVUFhsUUJNdmRPSHV4ZVZGdER2UlBld2dY?=
 =?utf-8?B?dVlxbDd5cm1oQUM1eXB1eloxU0lOTHR3OW53dzRMdmgydE0rL0JjUEVGb1FX?=
 =?utf-8?B?N3dmeDdpSTNQZDZqSWlLSG0yeEdWa3pDajFMVFpNRnB5ZEtVZzB2VGZYR2RY?=
 =?utf-8?Q?z1CZV2Av6tuw7+cBymyEZ9gR0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81234d37-f09b-42cc-f487-08dbf67d0c2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:01:54.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8MNw4FzmZg2NXgojncyPULdqceDkcvFjEFjyYM6bf9JwGAjmtdiiILuq014Ic9Dtt3LYrwxcZUgPevPZ2U6Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 09:42, Rafael J. Wysocki wrote:
> On Mon, Nov 20, 2023 at 12:42 PM Yuntao Wang <ytcoode@gmail.com> wrote:
>>
>> The original intention of acpi_parse_entries_array() is to return the
>> number of all matching entries on success. This number may be greater than
>> the value of the max_entries parameter. When this happens, the function
>> will output a warning message, indicating that `count - max_entries`
>> matching entries remain unprocessed and have been ignored.
>>
>> However, commit 4ceacd02f5a1 ("ACPI / table: Always count matched and
>> successfully parsed entries") changed this logic to return the number of
>> entries successfully processed by the handler. In this case, when the
>> max_entries parameter is not zero, the number of entries successfully
>> processed can never be greater than the value of max_entries. In other
>> words, the expression `count > max_entries` will always evaluate to false.
>> This means that the logic in the final if statement will never be executed.
>>
>> Commit 99b0efd7c886 ("ACPI / tables: do not report the number of entries
>> ignored by acpi_parse_entries()") mentioned this issue, but it tried to fix
>> it by removing part of the warning message. This is meaningless because the
>> pr_warn statement will never be executed in the first place.
>>
>> Commit 8726d4f44150 ("ACPI / tables: fix acpi_parse_entries_array() so it
>> traverses all subtables") introduced an errs variable, which is intended to
>> make acpi_parse_entries_array() always traverse all of the subtables,
>> calling as many of the callbacks as possible. However, it seems that the
>> commit does not achieve this goal. For example, when a handler returns an
>> error, none of the handlers will be called again in the subsequent
>> iterations. This result appears to be no different from before the change.
>>
>> This patch corrects and cleans up the logic of acpi_parse_entries_array(),
>> making it return the number of all matching entries, rather than the number
>> of entries successfully processed by handlers. Additionally, if an error
>> occurs when executing a handler, the function will return -EINVAL immediately.
>>
>> This patch should not affect existing users of acpi_parse_entries_array().
>>
>> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> 
> This needs to be ACKed by Dave Jiang or Dan Williams.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
>> ---
>>  lib/fw_table.c | 30 +++++++++---------------------
>>  1 file changed, 9 insertions(+), 21 deletions(-)
>>
>> diff --git a/lib/fw_table.c b/lib/fw_table.c
>> index b51f30a28e47..b655e6f4b647 100644
>> --- a/lib/fw_table.c
>> +++ b/lib/fw_table.c
>> @@ -85,11 +85,6 @@ acpi_get_subtable_type(char *id)
>>         return ACPI_SUBTABLE_COMMON;
>>  }
>>
>> -static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
>> -{
>> -       return proc->handler || proc->handler_arg;
>> -}
>> -
>>  static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
>>                                           union acpi_subtable_headers *hdr,
>>                                           unsigned long end)
>> @@ -133,7 +128,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>         unsigned long table_end, subtable_len, entry_len;
>>         struct acpi_subtable_entry entry;
>>         int count = 0;
>> -       int errs = 0;
>>         int i;
>>
>>         table_end = (unsigned long)table_header + table_header->length;
>> @@ -145,25 +139,19 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>             ((unsigned long)table_header + table_size);
>>         subtable_len = acpi_get_subtable_header_length(&entry);
>>
>> -       while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
>> -               if (max_entries && count >= max_entries)
>> -                       break;
>> -
>> +       while (((unsigned long)entry.hdr) + subtable_len < table_end) {
>>                 for (i = 0; i < proc_num; i++) {
>>                         if (acpi_get_entry_type(&entry) != proc[i].id)
>>                                 continue;
>> -                       if (!has_handler(&proc[i]) ||
>> -                           (!errs &&
>> -                            call_handler(&proc[i], entry.hdr, table_end))) {
>> -                               errs++;
>> -                               continue;
>> -                       }
>> +
>> +                       if (!max_entries || count < max_entries)
>> +                               if (call_handler(&proc[i], entry.hdr, table_end))
>> +                                       return -EINVAL;
>>
>>                         proc[i].count++;
>> +                       count++;
>>                         break;
>>                 }
>> -               if (i != proc_num)
>> -                       count++;
>>
>>                 /*
>>                  * If entry->length is 0, break from this loop to avoid
>> @@ -180,9 +168,9 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>         }
>>
>>         if (max_entries && count > max_entries) {
>> -               pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
>> -                       id, proc->id, count);
>> +               pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
>> +                       id, proc->id, count - max_entries, count);
>>         }
>>
>> -       return errs ? -EINVAL : count;
>> +       return count;
>>  }
>> --
