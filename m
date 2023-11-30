Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03917FF930
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjK3SRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjK3SRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:17:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926ABD6C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:17:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqPsjevm7ku7M5hlmJTAAZQNWDPZ3QC5omplsPTkRjnTsRCt+8bc1VQYnPsQ3w44We89aAv84h0y09+ZVcC33IBb2PbEdE8cOOL17x5dmZOvUFz5YCjtOa8Mb1RFfZ53D3+ZcVHxtjJLd6ujbl2iYCgR7sNkMMYxj52iWai3N3wjLX1Dz9b2/H9kGRk80fLM1KsjX2cUji0jhCZyGvO6HcmCYpNVHuxvEMOkPnJmEzKiAlLJj88I2mL3bn7sXRNJivjmCd8+GCns+pNvSMmH/y4N4RETZYFV6bqvyYcgl/fw4Xfd32V9ltCu+tQ5gj9u/5iHAKkAH6yZQClz6j7Xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJUnX+Wu3m9daOjW5ZSBOueCSVkoOzmexkGhBkaSCCc=;
 b=erL0NdRM9sCdSzigN98IZYa9iALWJccjNZN6johEfpJ6hxUj5IpiAQywtmaxja4nTCUUV796Gdpc/H8S9Da6KsxLc92MXeBGJF9X+BjHbxeC3AYG1KtN63IFh5mkDWxnHd77c/V3IxFw6kz0Quq/B1qyPLFZ973Wu6ilNFk/5w/dcBg54vyfz3aOJncIYKAm4batoPPidE5y6LHnLj/8RA0qnsWVkrSPUzgGZPQRDOkVKm/hxUiMrd69+fbblyUTecMRxrNvUoIRCcb0NMsJ/7CFJwOzWeoZBqd/jGRWmhLE7MJltou7xr7tcWoJWIJLDbTnti8KInpE6DW7y4/I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJUnX+Wu3m9daOjW5ZSBOueCSVkoOzmexkGhBkaSCCc=;
 b=2je8pp2dfboEJRA3dMIkv9ZWQMHdyBrRsHg6cFlJO05uf9Fk7aom9bLYLItnyUNKXgMkCVjthJs14aCptboSCt8l3WnxRCAl3vuwcRtn+8uXBa1f782dIybIy47H1X5TuwBonVsgD6pwpCLMWQ2AJc7FeT5oPf0/0RWmtIsFvos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 18:17:05 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:17:04 +0000
Message-ID: <16400d3d-8264-4f3f-96ca-168064944462@amd.com>
Date:   Thu, 30 Nov 2023 12:17:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] x86/CPU/AMD: Add ZenX generations flags
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
 <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfae9f0-3eb6-4592-218b-08dbf1d08e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdqDah/hROB2qg5isHbc4jghHDYLQtE8x4+5mlWsDmW7Jp6oCd1FseOeY9IzcNmeP9t4j20/hFtbv+dTWpCcOUJmsJdXGhxEk4tnhCKzJ20pk9AA/P3EzZ0Eqruk4IY7/6vq767xLU33zBZAhQBBRrqnbOSPO9NHpP/6kd1mXwiZKDpev2w4J3IkoDDmE2d2xrQmeVQm+TcXM28x5jTMruMtFJtOTQFaXv4ShhRx685zad30cmmsFicmrF+GrOEdEMPYxOJomNp4TZboodhRWHp0VMrkKaNy24e7axpvqxC0vE9P7fk4o988AAUZgB0Vu3k77m2uLR7y5DrMxa+aQV3J4+tL3Wcr053VCgU+E/QDcY9Yq9GA2OqmE2A+tEvNlApNPIRIM9V46h0Na26de4SSBcc07BeIa9yJTECCWqs5SsXAONEKYGt49oYnMqogCeQ3CeKfIW256rswPx00HVSgezzuaSY53YUwH5wgc8KsBfw8oT6OiqqmVaapuPRtW1frdL7NF6xid6zKIhAb/uWbLdESdAcroIxX5cwrejVVKs8EqSCnCZpiLxCIRZ8SG7liWPNWOeY/D+2xE1dR69amO1BLEN/J57xiNLNoatf4qj5DNMS3RjHfjWLV/P4WjSq45gLqRGp5LPCR9o4gxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66476007)(26005)(2616005)(66556008)(66946007)(54906003)(316002)(2906002)(4744005)(8676002)(5660300002)(4326008)(8936002)(31696002)(86362001)(41300700001)(6506007)(36756003)(6916009)(53546011)(6512007)(478600001)(6486002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xqeEpNNGJwVERtSGpyT3FEaVFTanluMVB1STlhM2FuTjBDbmRZMS8wTkFB?=
 =?utf-8?B?cksxU3VkTDUzSzIrQ1U3K3J4QkRNSk9MSnFDb0tqM2ZEV1I1TlFMSkpaYkEz?=
 =?utf-8?B?OE1kWHJIdU10UkRVRzE4TlY5L2NrTVY2anFaQmpyYStrTExzRE16NS9XK09J?=
 =?utf-8?B?ZnNRalRxMmZrMElKd1k0bDlpaVZsMjVmanNJK1NuMlM4clhWbWpweGExeUZV?=
 =?utf-8?B?M2hCY0lmcytYbDh5RDJkMHA3eFkrZVpVTmxaaDJNYXFISFJrbmtkVFpWUHZa?=
 =?utf-8?B?MlZBQ3pYazBkS3l2OWdLTUUrNE42UVBsMEJyeTlQSEZaRFNYS0VJOHR1VjJu?=
 =?utf-8?B?WmNNY2pHaTJBdEtVRm9FOFdTRlN1ckk5alg1OGtTQXB4MFpRK1M5a1pnTE9q?=
 =?utf-8?B?eUFPZEJNbnZBUGU0aktMNUs3dTBzblU2RTJYZE5UOU1RSjRGdGR4eFk0ZFZQ?=
 =?utf-8?B?eTN3NXZlSGQxTGI4NTRHU0V5Yys0anhLVWpBK2xpYXMwaWhLbGdPVEVGczlV?=
 =?utf-8?B?bDl0M3IrRUlXUUI4a3hYYk16bE10ODRMT1I3dVBPYXQwdnR6bVFTNlNTcFJq?=
 =?utf-8?B?SkdobG1YcFA4THhIVzQrUWxMdVR4TGJNYVZ0RUxaUk8yVTZQZk12eldMRGpz?=
 =?utf-8?B?RWtVTVoydWhrUDRUTnRaZG5MS1FsWXh2SUFFT1RrL0tIWFFBd1Ixbkp4UUll?=
 =?utf-8?B?UjhZaHp0cTI1SzczNTFuS05RMW0wTnZITFdPd1h4eTk4MDhvanp5YmV2dzc5?=
 =?utf-8?B?bkMreHRHTWxPTUpLei96d3BMZXlEYUhKUmU3ODBCVUdydVFmUGFQOEpBWXA0?=
 =?utf-8?B?WlgxajlGUzU2cFc0bHNKenl4bjhleWdJWVFDeXo0T2MwajlUSFRBUW5XdnVz?=
 =?utf-8?B?cjdDR2tkY1oyVW0zRlBSL0NqRmlIc1RCeFY1S054NFBXd05FdHBobUNhbjg0?=
 =?utf-8?B?WlBIaXBqUHkyd3AwbjA0bUN3MkxZTG5IMHltNkNIQzk4RXFablNOdjJEdkZ5?=
 =?utf-8?B?S3JOZDVtKzZDOVY4ZW4weEZnMzFLVHQyOGlrYjY1dUYwcjIxUmJxYytmVld1?=
 =?utf-8?B?bEh6WU95L2ZGUWVGRkduc1ZCZU8rMWg5RjRqYkFGL1FNSkZpMVMyWStldkxE?=
 =?utf-8?B?dW95N01hS3pGQzVvRnpmT05iajFYNzhVL2FCeS9tS01UVWhPL0x0eFFkM0tV?=
 =?utf-8?B?NDRab0hicjNZNmszUU1JVXUxWk1TV3l5dDhMVzFHd3RkRVN2VURTemxBRjh4?=
 =?utf-8?B?VkxSQjJnM0k0Y1dYOUNaeVBKaFllZXdRM1ZPTzhlQW5jb083RzR1YURXVWxX?=
 =?utf-8?B?SlZCVzRkL3hJRTJ5OEQ3S05qN3h0c1NrM2c0Q0J4NWNvK25icFlGdUppOEpD?=
 =?utf-8?B?M2NRVjVSNUJQWllTK3Y2eFA1dGNXd2hZUk9VNVp5Yk05dmthUng5Z2ExVjRJ?=
 =?utf-8?B?RTVRaWhBZ2RlNmhWbW5paVovekFsRDRubVJXQzkrd1U0eWJBYXJOdS93ZFVm?=
 =?utf-8?B?cUNYK1JNckJ3dit0bjZVNm8zdXZPKy9LOExNREQxMXlkS0FESzdBbGtpcHBY?=
 =?utf-8?B?VmFGeGRZS3lYeTIzSVZEVHYyT1d1MFZIeGJBcFp3OG5DUnFoQjBmTVFiS01N?=
 =?utf-8?B?cXdoeFF4d1BDVElzMjNEZUFUQ2JYRW1KT2lZUTBVcTJyUTNGaXEyRjBUZFpM?=
 =?utf-8?B?K3Ftaysva3RYc0YzQ3FDbkRQeFdpVTN3M1Q1WEN2Y2Iya21ENnpjQWJ4V25m?=
 =?utf-8?B?TU12Ulg5ODRYaDFDQVoxRVZhV2ZreENnR1JsRzRBZUowNkxKb2VtYmVoVERD?=
 =?utf-8?B?emRGWTcxYjdnRnZNS2tRcXJYUHhndHV4eVhWU2hVVUEyakwwMTB6YnBkWFZ2?=
 =?utf-8?B?cm1RbU01K294MVUxM1pVNlBJN3MrMTFFSCtxTlRpK2pIOGdyRytSUmNwZmtX?=
 =?utf-8?B?dnZ3YlRzZHJTcTJlWUE5REtzekdRKzF4UW5WR3h4NlRvSDd0TlV2MjIvVVp6?=
 =?utf-8?B?L3BlZk8rK1haN1VESU9tVkdNcUFwdjR5bkZ1UEdBTldIUEozNXlyT3d2bWVt?=
 =?utf-8?B?SWtwZnozSms5L2ZnZGVTT2dTOHlGdXVtL09PSDg4TnBkMGlaRzNUekhXVmJa?=
 =?utf-8?Q?kPhjhXSJdvr81YWyKpE6LXHKC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfae9f0-3eb6-4592-218b-08dbf1d08e3f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:17:04.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMlIz6KLk1mi47ZR2mv8KPOFL7ULhGDCZxnnVB9RyNCrvqO3wG7+yONWF3oWwbwJ2Jv/l5Vi1sY9W8uewWR4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 11:13, Borislav Petkov wrote:
> On Thu, Nov 30, 2023 at 11:05:14AM -0600, Tom Lendacky wrote:
>> Previously just being family 17h or 19h would get X86_FEATURE_ZEN set. With
>> this, if the model check doesn't match, you won't get any X86_FEATURE_ZEN*
>> set. Should you do set X86_FEATURE_ZEN here, e.g. lowest common denominator
>> for the family?
> 
> My assumption/expectation is that those WARNs should never happen
> because they will be caught early enough in enablement and I will get
> patches.
> 
> Besides, X86_FEATURE_ZEN means only Zen1 now.

There are references to X86_FEATURE_ZEN in arch/x86/kernel/process.c and 
drivers/acpi/resource.c that should probably be vetted.

Maybe having X86_FEATURE_ZEN mean all ZEN (and set for anything family 17h 
or higher) and a separate per generation, e.g. X86_FEATURE_ZEN1, when you 
need to be specific, would work.

Thanks,
Tom

> 
