Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF037AF419
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbjIZT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:26:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286829F;
        Tue, 26 Sep 2023 12:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVAcQHfjJbKCJGDmOmDJn6hzADRfsq6h5R7kZaIjHrOY9e5FpHwyszc3sBECxoQbNtd/+eRol88fuiNAtEcY+5l3N8IEndwiGZ7+nxiVOvNm6N7XdqODbZxOXAWOwQwW8yrPeipOaIzfAv0Nlz3W95sbVIFHv/mFF2AU78EeGTfhZm7pdF91qi80pzAJSskn8ZXrV7VYpAWgX888WdmQgEHToWG6TCvxL0QPEl0s27OWe4TWlnbIA94rDiwllminItnDO/kE7setlh0mDOlf1JKITBA0VYNLtrk4qwdfRGt4gb99kRAuDHIGnIrivkto8ffwgs20gDZWrchCtM8oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmS2KKGH6/VKU9WOiBteGqE/UtTrLFNvxeX2KfMJz+0=;
 b=M78IGzviqnQ4GCeFzFaC0sbu/krd4Zo9xwnslcjdWnDjYBmql/yI+3PqwD5E5NI8Ce6kMOEaQPM43ChBkLFfvpXQnnFiBvH+KdfeTJOrJJbH9wXJh3zyfq+jqswb1TsiYwm8svS+69L3efla4QWZN/GDAw9qqHlGpkwg0LPEuwY7paNOOahyU3xGlSFxFhmCVSX1sKGFrZCjVZuIYGYPwmpPOti5HoOhvOrsmRB00gFIeiIjhn6pWh3xXEyCDx2444P7jgvIRaEtkl9163KHK31wpJFSOQ/21pD8LuRl6q7yIV6AeLUGAPIPjFbf1Q9qbBq3HLrolvUqKgnBxDdHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmS2KKGH6/VKU9WOiBteGqE/UtTrLFNvxeX2KfMJz+0=;
 b=R8EcQdFD+F9dKImCiXDq+7Octgsi/5ch1wP+yTG75dFTqBGzDeDmxKFcZOxyl41lIt+60R4nBuFDqdRXaMbj66BjczoT2XVu9NigN3ZUkfDjLDbobEBUWcv9CpqBYmb7w+HPkFQlJR9kBNsj9u2YPgmqJ5cXVJRWchV2BR0owHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 26 Sep
 2023 19:26:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 19:26:14 +0000
Message-ID: <e2949d93-946f-51c5-dd08-64de4a272f3e@amd.com>
Date:   Tue, 26 Sep 2023 14:26:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
 <560710e3-ce47-db07-e81e-3abd61e6ffbe@amd.com>
 <SJ1PR11MB60831009ACAC814C4F2A6072FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB60831009ACAC814C4F2A6072FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:8:2b::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 573aacca-9564-47d1-dee0-08dbbec672cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG8abXMBQM2aL4fRkVXduHShp76VdA4uTXHO7009FmP9W3gYFxoO3sdkkclo+N45XT+6hO656+1V9GqzAom8Pd3znU5XXT+38mkSTcfBDEd5q/LUhGjJOR7q1WwlLx/rDI/Ga9Fgh/hWiFI96QIPYKEGj0uNIoZVu9kl8DP45nYkkOlWpr5n2pqzSHNbrnhl8B/j25/4Zux7UcGitA5uSX45Ire45LwVdBuNRd8IMUXFUwqhHe4IhR48Ym/8fTVYIGirEp2lCVLA/BfJWpKmgqpU57KQaD1VYwaBG+x7bSWPxxOqqM/IOb5YkID2xtlh8AQH1A6mkNVHa2gAmSdnJPuEbI4fvHYmFJx4B1mr08bADs4ohANpUyQkZwd/7bG4gC9O77f8PvaR7pXtDJmM3HCZsxrfuAvflAaCPRJmha5V+NKaG7Cx2EVUhfGmVd6/6mrLyXOR5uoxPUsNP7jZX1tJUbk0taX0JWmLUCAYb3LE86UbDp+hulfyNxLb4GVpSeU275st8818NKbAd+W/0FLeIyMihOrzqcfYlARLPgV/ON1uSYNa3v/F8rQ9AWNjZJEanOsuRy0LA5X/vqbSsTdRxQ8iTkog9KJSgClKP8P+9I5SXtr2qrqPEqOk4qGRPXRck4BFfNeDKQ49t0DZJ5N2XBvJI9erXhXkT39MVNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(478600001)(110136005)(66476007)(316002)(66556008)(54906003)(66946007)(7416002)(2906002)(4744005)(41300700001)(5660300002)(4326008)(8676002)(31686004)(8936002)(3450700001)(6666004)(6512007)(53546011)(6486002)(6506007)(2616005)(26005)(83380400001)(38100700002)(36756003)(86362001)(31696002)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxkdGZQdGNwbitoR3FzUTlMU2o3cEU1QVF0NVdNWHU5RjlKNDMvOGR3bVNW?=
 =?utf-8?B?djgvL2hiMWRObTdndHVkb0E0bjNLSnhrandiRzhPeHRpNk00MVJzbFlRZHJ0?=
 =?utf-8?B?NVljRE9KVXdlWGp6YndsdVhGRmxqQ2tBckFWSGExQ25XKyt5ZlUvQ1VnYVJM?=
 =?utf-8?B?a2c0dFhzS0IyUmxZUkV1RTY3ZTBVOTBrems5dGJRbVdGUVJKdXlWd1EzdkQ3?=
 =?utf-8?B?bGtKY2RxeGxFNXFJUzlzd0xzZEEvdUVSNlcxV1FtbW5WNHFXZlhIdU1UOWRP?=
 =?utf-8?B?aG40MUNCODI3QUMzdjNHTDJCaUJaZks2ZnJBdkJkd053RWtONCtLVVNWRnB1?=
 =?utf-8?B?ZUduOGJtK0xyWitVaVpvNUFHaDBPWGNYWERNb3JMYlZMRUtPc2o3VTIvZG1a?=
 =?utf-8?B?OFM2Ty9JQlRCT3BkRGJGbEJaNXIybHhCbGtOY1RFMzN3bHdVa2ZYazFvL3Fp?=
 =?utf-8?B?aTVIWFJic3FUVGo2enM5WmR6TDBMS3doRFNzRlJ1aGhIT3p5a2RJSnRKM2s1?=
 =?utf-8?B?MlB4VWkyQWRRQWZpeFJMVmY2UmppK2FIMy9ldCtHTHpISVpBelRQUmJEdnlr?=
 =?utf-8?B?dW5oV0IzaWFmT2RDUXVGdXRMTDhmQXJ6Z1FxMmVzTE0rTFFyd0tvd0pPbHh0?=
 =?utf-8?B?cEhUclJsVXBqVWVEaHRaaWNmM2F1TFZJQzd0WEROSVpGeExOWlFQV2dRVjJs?=
 =?utf-8?B?VkNVa1JWMVM4SStKbDRCQ2tCdnlSU3IyeFd3M0YyUW1CeWdVYWJjZjFEZ0hJ?=
 =?utf-8?B?Qm12S0MrTGJkOG45SElQSXBmTnBlU0VyaGRVdHJZWUY4c1JNWmFUajI5TFhX?=
 =?utf-8?B?MnJaVnJqdVZDZFVpL1plUnhWeFd1NzcwUHoyQi80UHJleGZURW9GeWMraWZx?=
 =?utf-8?B?eXJQYU1tVXVyYjZKVmdzZnc5SWNYZmNRSHA5Y3hXd2tDNUJ5bEUzYmx2ancv?=
 =?utf-8?B?S2NXK0dOaXFyZE40cUdncjdyaTU3T21zbm9aWWNKWDVGK0Y2TDd2eklwOHc4?=
 =?utf-8?B?aG5wRm5hMEJNejFvbTk4S1FwbmNEbk1adG41SzgyRkxVbi9DQzAzNXhlZEJr?=
 =?utf-8?B?ZUo2MFk1Yll3WVN2NkVMbFE3Q0xhYTc4ZzZObVZJWTZCUkgzSGwzUmRoNERR?=
 =?utf-8?B?VE9NMmN5c1VuQ1VQdG96Y2s3WHZwWnVHUVBSRWJqQW1ZUnR2THpyaGJ0L1Fn?=
 =?utf-8?B?RkQ1dVBzVEFSbVBpMzMxSTRzaTR5Yk03MkxsMFdNenh5aXJETU52Z3RMaFlh?=
 =?utf-8?B?Qkd6Y3g3THdBQTAybmMxVHNsOHdIS0tXc0FTWGxiZGxIZWlISlVuc1FmQURx?=
 =?utf-8?B?azBWL2c4VUlwb2dUSXZObFNhNUhrcjJmdEtsT3c1SHNEVGEzQlViWkZZS0hV?=
 =?utf-8?B?ZDBLSlpnQzBlcWlpMnRYVmNVbk1CNm1Udlc0Y3JWZUhUL3h0VFVzVmszVUVw?=
 =?utf-8?B?Zm1IaDFrOWpzbm9pN3RWYUpPTzdYa3JGUnZoQ2xacEpVY0J4S1NPelgzeTF3?=
 =?utf-8?B?RDgveTBDSVE5NHBnTTRpVEozeW5uTGZTakU4UFpUeDF2eG9CVDN2TTg3RTJJ?=
 =?utf-8?B?VTlsRFZNcXIyd0NwcEVTTFJDeHBlbVV3VDd1K25WRVNqT2Y1Z0JtbHZFV3lO?=
 =?utf-8?B?WFQrSjFSR2xLUGRnR3NhekFtTk1BTENxYk9kejZ4LzhVL2VVRTFpeGhlWU1D?=
 =?utf-8?B?OTBDcG5YYW1sWE1JRjFJZHBYeFl0aXViandRdndPZTdKNU15Zm5FS21HSnZO?=
 =?utf-8?B?REpNRVRYUHlVNjlDMkRoU1F6ZHhNV085QUx5bnJjeUZITVRvbjgwSEMvbnpQ?=
 =?utf-8?B?eEJ3NWJtSzVZVlVVeVBlR3EvSHZPSXlpQVNmQVBvUmlPTHRBdVRFZTc3TnFS?=
 =?utf-8?B?SXhPYkJLWUhwVTBuYThCMTEzNGYzVk5NMnJOcUFpdDBmWG93UjZzcnd0L3Er?=
 =?utf-8?B?QmtPMlkxbGxrOERjUVdBaVlYcG5iVThpSmVKRkhOUjEwb0M5NU5oSllzTHQx?=
 =?utf-8?B?Qkt1Q3dCSUUzZzNrVnN1clNuTTNDbEVDRkZMUTJidVQwVmRoeDE2R2JvZUx2?=
 =?utf-8?B?ZlBDVlo4QjdRLzlnQ0VMYnVEVEFJUFcrKy9NVTZPOUNxUXlJaTBHYjZNRnRP?=
 =?utf-8?Q?PPKI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573aacca-9564-47d1-dee0-08dbbec672cf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:26:14.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9r/g7dPvOqzfwUd32XObse7mNSecpzlk54c8MPAPGYjg6JXcPsSjxQYekXwA5yO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 14:11, Luck, Tony wrote:
>> How does user know Sub-NUMA Cluster mode is being enabled on the system?
>>
>> Do you have any information in /sys/fs/resctrl/info?
>>
>> Below documentation does not have any info about it.
>> Would it be better to add that in "info" directory?
> 
> 
> Babu,
> 
> My original patch series added an "snc_ways" file to the info/ directory
> to make this visible. But I was talked out of it because of a lack of clear
> user mode use case that needs it.

ok. Lets go with it.

Thanks
Babu Moger
