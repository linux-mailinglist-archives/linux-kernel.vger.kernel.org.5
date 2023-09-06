Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B4B793C34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbjIFMFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjIFMFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:05:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C426BF;
        Wed,  6 Sep 2023 05:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1YpDCsnL0lGCo0NAHxFKNSOP6CKutY8lL8WO3byvrtoaG2l/+IBkPwHxjVY/ytrQJS75nWrufSfHel34/aC6k/4N7moAvR/8+s7UC3B5TUy6SgOxTMjYaXUQF7Ywh8+0gCFU2u9pRi0CNmPf9Q+vlgCF/zUCbUtLY7Fz2cEZlO2FiYGTkPy1nU4kyMNpm47s81oTlKcnIQFfo1fwoB4LUNUIh87culOhKktNYUhdWP3ub90ywWAKO1ECzqdzD8I9n3G/HREsBLm1BvvpZH6VUnxpQG2FFYEzYuPJREyG9mbTngzkOThWf0dZgtRY+4s2dkHVtfEjMRPNMiaa/nPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+mFrzaJYIzAhGVyZzx+eqMuuorF9fFWAqUXtrL81S0=;
 b=U/YKBJpCe9FzCpO7vwFNjmWn0BotElSdI7BQlSrUyREF6kf7Tog6OjfOPDfSGC83ybEZuoPlv5qltSFuVifWuuFv063FqBRhsg8sLbsdwK5DS/rvksTQ6KJBDh6HRC6MDQkAFukhs8PKm+QuQdVdzQMKGusve2Otj1a+CXEmXZHo51NQlHsxwejMBFccXhAbvIwkda84N+9koNBR2IUUVJONbxAzFQPJv/yiYIt+4kMg+iiDlaztgPIwUtQ+PrvK+YNekl9C09CX2xU62eciB0/mNskiX/lTBjMFJgRxMLvCYGCz95f4nqx/SAw0X4ubeALkbVOB68sS2MZnEDJruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+mFrzaJYIzAhGVyZzx+eqMuuorF9fFWAqUXtrL81S0=;
 b=T7N9bcUgwW1TjL3hT2cJ8Xzo5H+qSjdG4wPKbJf8lTGI4kxVSu9WoXVHtq+WGhYAIqZSebHk8CCpFsMQOlVdmG6Dx1fseAKkjiRF1eU9niGsKIdSSFtwr5WZXe1cgWIKizzlMn4uBsKeASth9p+/+3CPXS/BrDLu84nluFaDbGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 12:05:25 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 12:05:25 +0000
Message-ID: <288ac4c1-b66d-477a-ba2e-9b8d8dde4dc6@amd.com>
Date:   Wed, 6 Sep 2023 07:05:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wayne Chang <waynec@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org
References: <20230906084842.1922052-1-heikki.krogerus@linux.intel.com>
 <2023090638-overexert-endearing-3726@gregkh>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023090638-overexert-endearing-3726@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:5:100::19) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c319a1-5ae7-4fa4-e66e-08dbaed18cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zru2iMZXf9qsv6fsD1fBT5NxOAMAzLuOac83hLcsEKLPyJsJbPV/XYl4ZLbTMACGHooeVWoFBGDYogqk77EWkrSnaODDRAkcJf8qOJiXzxLh0OT7+t2zBAIqGnh5752zCqMwqFLfVBq8NiG1CV2BoUuVU8vXdwrSAtnXTax6JX/h+FHMsiQ6KHqiDHN7eEfwyRGa1zC97SaCbZ0/tDleqowJ/U4tHtSS+DlNbtdQbcL6OalyGEFKhSDV6FesSBkGtFfcm0ikuInHHBGeBX5xxo6FxnRVXqbz9e4KIN+oz4lJujXFcMRpiX15IpmVRcDvA5lcNPPc5PS4RT6l3VdGfG3P7gEoMF8zmIEGB3lIj+S+Lu42kJSdfZ6ruuuM2bIwygTwQ1IBFNeNsjGoGWX+dtRS6pXYTFxjkzk+s7fGU4bxUdqzNuxXI39NkzrY5zVEMovUB/NV55cFtIChfa+E/cQQEJq+IrsI9g0+ISjm7Y5zoyelRLSWZj4fCDOBoj8PLCfb6O8hx84Szq7uA0YXs+UfcbPK8izHMoWmyksumSdYtSzHptGDCU7GDg9oL3dr05buDrXm6S1rWo8QgTtd3jy/Z2FLg3b6vFFWg3nywArb8q7C7jf0YrwWSp9EtHNJW8EDPy9sSBNf4WDnih7AmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(1800799009)(451199024)(186009)(2906002)(7416002)(31686004)(66899024)(66556008)(83380400001)(66946007)(36756003)(54906003)(66476007)(110136005)(4326008)(316002)(8676002)(41300700001)(5660300002)(8936002)(44832011)(6486002)(6506007)(2616005)(966005)(86362001)(26005)(31696002)(6666004)(6512007)(38100700002)(53546011)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpsS0s2TzJNekQwL2t6aHBGQk81ZjlYcmRBc3FGQWJ0M3BwS1A2WjV2Wk1O?=
 =?utf-8?B?ZkNOWWt4MVhYVXJqK1JNRFBTeU54VStyRzJNYUVuN2l4ckZJWCtYajZ2YXU0?=
 =?utf-8?B?VUppN1I1aHZHajJDanB2Zm9oUlJiUkpxTXE1R05lcEhXYWM1UkpacEUrWFR4?=
 =?utf-8?B?RFdWallhZkRGZ2F2aFdGbnR1ajFEN0ZaNzI1V1RTMndCZWlkelU1SWdMRlY5?=
 =?utf-8?B?SzdBMFpxVm9jRnZUdll3Nit6VFJxUU9USDZsVTNjSWVIdHlFdTl4WUdtMWdN?=
 =?utf-8?B?azhhdnFnT1JjL1RLbndiaU8zMnlUenZ3OGU5RVM4L21TWUJZTHRjdzJnOG9G?=
 =?utf-8?B?S2JaWXZwcXhLanpObkIvWDQzOU94dCtXbXBNZUVRVXZFK2lmenAwZDZycFUw?=
 =?utf-8?B?SVY5MnFLTzRZUmxBbkZPZGlOYUlZRGdZeEo1RG50bzRaVG9EZnVCdkgwVWdQ?=
 =?utf-8?B?OXpDcHJLb3RhVXhyeitqVWtPemkvaEYyTEhCbFk0ZlRibjU2aEwzeFI2dHNF?=
 =?utf-8?B?QXphcVpNMW81Sm1MRTc0Tndya2p4bDdTVUFVMVRhNTZVOHhZVkhIUCtrU2t6?=
 =?utf-8?B?enhkaElEOTB5TS8zdXhiZEkwZmI2WnExUWtOdlZMekdrQmJ2UFRnRm8wdXNl?=
 =?utf-8?B?TU1lV1JzbGw0ODFhTmMyVmZDOUhrSXF1MWVwcmp4aEdiMWVEUlF6MlhMNjJB?=
 =?utf-8?B?UjlMNFVLQk1aQXNaNGQrbFpReVBwZXI5VzRjcXFiNlVEMDA0dUtFTTNpV0NP?=
 =?utf-8?B?NjIwYmNDZWtNZk9FWWxIa1d5M3k3Sml5QTRCSDViVTlvdnpORjlSclk3ckk0?=
 =?utf-8?B?WjJlQ1NWQ3pnV0JRVC82dStBT2tiUHBGRDhzUWQzanRhb3pZcnl5QkZiOXN4?=
 =?utf-8?B?bXpjcHEyMGp1Ly9vWHdHZFdCTEFRdEVFTUZkTUU0QXZ2YUtqZ3h0QTdPS1Av?=
 =?utf-8?B?SnVkT3lEYXdCcFhHQTJrUTJTVmd1OWxTeXJFS3NVRzBwcE1UQytUWU4yWGRm?=
 =?utf-8?B?OTlIakJLenlmMGV6OGM2cmFMK0M0SmNTays3N1lwV3lXaGxBNFBWVFBaRnB0?=
 =?utf-8?B?ZXh3Vlpna1pTMmZhWUNTYkg0eVRNTHEzR2R0UEN3M3plS3RhdGZ3eXp5MGhI?=
 =?utf-8?B?VVdtRlVRSnJDamhFa0pDclBwWUJCQ0pLMHltaXQ3c2NGbUV4VEo1V0NaM1lE?=
 =?utf-8?B?RlVGbU5CdXdzQi9rcjFieGZxV1ZxNGFlV0tobkhNZ0xTNmZrVWtpMmxyM2p4?=
 =?utf-8?B?ZzdWVm13RXQ4cTN3cU1sL1FlZWZiRHlzWnRRa2NBaHNubmdvTkoxNmhGZHhG?=
 =?utf-8?B?NkU3VFh5MEc3NVErNHVEZXZ3dkhpeGRZZ2hQWVdFZ1hjT2pSaVpLRmNUTitC?=
 =?utf-8?B?cU1INFVFN0FKNUZOSlduRnEzSlIxdUo5UWVjTGNQSWdWSE5jSk5pcVVJd3cv?=
 =?utf-8?B?b0FPa3A4NHNrTmp1Vk8rcER3UnZ4c3lHNEx3S1pqZUk3bFlaZDdna2pVNTNH?=
 =?utf-8?B?Si9GczJkRi9VbnVQRGkvNUpoVEw4QzJMelJyNzVQQVpYQUFEelRpN1IyaGFt?=
 =?utf-8?B?TFJRK1ZVUXM2ZnNRWnVKNUgwdFp6NzlsV20rdEhvVFJKTk9kdUtmUTdHVWRC?=
 =?utf-8?B?SlVvdWJtYnMwczliMnlCVzN6emVOY0pVQjRRZXVMU1RHb1NSQ0hFKzJQYnZy?=
 =?utf-8?B?MERuZGcxbW1MaGRDVmk5cTNYQzJrZnV5MXRqOU5ycTYxckR1RTR4bXc5dkZM?=
 =?utf-8?B?bzJBSS93VmxxWnZERE5jaTNTdWhpR2VpRHJjNEw1TWRUb3hjeXFpTXZZdnJy?=
 =?utf-8?B?RngzV2pYM1dmcFM1WExhSUlxVkIyY3Bzbjl5MWlhWmhkdHBNRFNacHBtblgy?=
 =?utf-8?B?SWlwVE9QSkFLUE5SRzVSeHlldStNTk1STWdUTW81UCtOK0xacmJoYm9mL0s0?=
 =?utf-8?B?eWQyVWk0WGJFbUZDYUwzMGFpZVAvdFFndURhck12V0hmeEZPT3VycnFPSGNP?=
 =?utf-8?B?d3NYZDhzK3Y2YkZ0SUlWMlhHYkVuRXFnVTJMem1wUk1lOGtwTk1SNkFmRC9a?=
 =?utf-8?B?UVJQbVN1cXE4VmNUZm93aHFlRFlpQ3UvcUFrQUo3Zm8rRFVSUmh1TXA3SnJu?=
 =?utf-8?Q?V/ArgG8v28vk2Nz5EO3kG9D/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c319a1-5ae7-4fa4-e66e-08dbaed18cec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:05:25.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /B/iTXlYRwNs/uq+fkxzUFC50YGCZNgwONAOdgaLgGoFhBM/JRpJbCiBICthn1Vqp/zYO7pyeJmp9x0fCdGBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2023 03:57, Greg Kroah-Hartman wrote:
> On Wed, Sep 06, 2023 at 11:48:42AM +0300, Heikki Krogerus wrote:
>> Making sure the UCSI debugfs entry actually exists before
>> attempting to remove it.
>>
>> Fixes: df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
>> Reported-by: Dave Hansen <dave.hansen@intel.com>
>> Closes: https://lore.kernel.org/linux-usb/700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com/
>> Suggested-by: Dave Hansen <dave.hansen@intel.com>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Saranya Gopal <saranya.gopal@intel.com>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

I could also reproduce it with 7733171926cc336ddf0c8f847eefaff569dbff86 
on two different laptops.

>> ---
>>   drivers/usb/typec/ucsi/debugfs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
>> index 0c7bf88d4a7f..f67733cecfdf 100644
>> --- a/drivers/usb/typec/ucsi/debugfs.c
>> +++ b/drivers/usb/typec/ucsi/debugfs.c
>> @@ -84,6 +84,9 @@ void ucsi_debugfs_register(struct ucsi *ucsi)
>>   
>>   void ucsi_debugfs_unregister(struct ucsi *ucsi)
>>   {
>> +	if (IS_ERR_OR_NULL(ucsi) || !ucsi->debugfs)
>> +		return;
>> +
>>   	debugfs_remove_recursive(ucsi->debugfs->dentry);
> 
> Why are you saving the dentry at all?  Why not just have debugfs look it
> up when you want to remove it based on the filename?
> 
> Anyway, not a big deal here, just a comment.  I'll queue this up after
> -rc1 is out.

It might be worth sending before rc1 if it ends up being widespread.

> 
> thanks,
> 
> greg k-h

