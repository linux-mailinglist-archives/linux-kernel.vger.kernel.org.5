Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F03675CA77
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGUOp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGUOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:45:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078E358E;
        Fri, 21 Jul 2023 07:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD76WV7AayTt0LMM3KPP22PM0vWOHoK1mJUuqBDHvHoJ/RQqS2wgvpDkr36KBTCiNN052LXnrEB67GxQxPcbRz5dWc2VCxsvy0WfhoardG/vUl+r3vP0szu8ywe8yi7Jq9EQbFuyR12fkrQFjBEDvRDTWpOdfTy4+q6jTSB33FkEK7+JOmA6C6KdvUk/wvzncelZWnPFW9W5y3ozgcCH2OEU9jUWaGEfLRpRa2hZv3umU8UXEBKdODpbhJeHaLxwNoMCAojN/4XIIPjgT5gLd9VBUGaoi4Xnprknv4fSqtR/Lcifj9zEKy/eTYb0Z9YAYkVCti/94+Nj6EculM+lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaYr9grmr/TCbem9eacx8JSH29mPBuZQbr/TRbrydLM=;
 b=M9/RX+zTydfxgcZA0Pv3SAyX0IjMcSK9I+Yh0vQKK/GJGLc0zDlW7NwJg9bjAfKC4wOljoglE9yFJvO3FekIce9hnoYAAj4gbW/U2f88Th3gzZ5uQk8NcWcUfcbKcXQL1ef4UBlWMtRZjiBJr5ILSJd3H/oREZtm7lQZe+qZ0yOvdK+x0rT/hyR/yXlSNKJHPFNBI2TFbWbF1a3dNxg6aaNMgubnhxE/1x/B+OIQkrRgEpZm4FtYbNzLiU/w7Ji6iIkDOUY+Zh1Sz9vi07ZKUepLPk/jG7B+XYZ7cT54sz3r+Ho5MiFr3gDSaD5kUMvVKPHSckNfpfBMZeoRp/gJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaYr9grmr/TCbem9eacx8JSH29mPBuZQbr/TRbrydLM=;
 b=Iw3Io5DDCSEX+E8KXssl3mOaMAFipi8sF6RJ+LdyfQKa88caVPg/+De9523k+lACApf5CMJveWk+vPul7UH+yDpjD0oVFJ8JxabkeMVU73D5mN3R544QaXz3o2dq46A73mvdKp4WS+grHxkX9xLUB8z5HUCSEszM0GRgi2o/edU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 14:45:34 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:45:34 +0000
Message-ID: <74beab00-091b-0359-0ef2-da6a9d34bdd6@amd.com>
Date:   Fri, 21 Jul 2023 10:45:33 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 2/7] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "M K, Muralidhara" <muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-3-muralimk@amd.com>
 <20230720135950.GHZLk91jGbX7l+7AMz@fat_crate.local>
 <b70fa364-2f68-1336-8d1c-7687f5c4f1b4@amd.com>
 <20230720155533.GBZLlY9cgqIZb2kd5J@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230720155533.GBZLlY9cgqIZb2kd5J@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0779.namprd03.prod.outlook.com
 (2603:10b6:408:13a::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a5d742-e1f1-4c79-ad8d-08db89f9238c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eqe1RjNMKKG3E9gYeRl5y/QS8VAgMGjrEZXdCZsfeDwsSLPibxuDwjkYAwDtgYoOuuZdX+V9/+O03TQcS+dXch+0Omp3Mcyrvy+6gyYf7JOjsNvRkbeUoYSf7Nbuy6j5NjW+iNZvxHlvZWvkmj1ML0stF3104GnYVT8Vf/gdKODdFRbjX9piKSrKv6v6QyT24eFB+C2YZGnR0KGBBvFuCDfekVTdmnTlkFwpCHRUkKSzeZaCwbjiuAhnmp3ySsH2EAKHuN/pk/vBiE3PXMayElgh/OVTyfWghrcykPZYR2+K06iY26HEkyogD9gis3UA7nb0x6T6uguxLuM4lDNtB4RZm7s9s3VpUUGj4wtijVCfCVNhIwgQOYxkLxlGkK5DmrwD1mOwFf3tLIDUU4GzZlejyZTBo+k+9ldCVx7JuZogMsoKI6tmam92OTesIOexIYjIKWGtf7ATpF76eKC9NjPPodTH5OvT4vsLEyVcBuvj9JV/kc22MQYor7oUr3qvnjSUxX3Z1xscnO/6NJkJPk2jXbCoz35X25FcIIQWobIjXLD+yGb+lsZVytg+sg5KMDmj9lo07YyJvWxRTRHXIfMJZ2QgK721IGNNZpDls0EeBN3vEm6PV3OFTfRMG40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(31686004)(6506007)(110136005)(186003)(478600001)(2906002)(6486002)(8676002)(36756003)(4744005)(44832011)(4326008)(316002)(8936002)(66946007)(66556008)(66476007)(41300700001)(6636002)(2616005)(83380400001)(38100700002)(966005)(6512007)(86362001)(53546011)(5660300002)(31696002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFjZVBKeDRCRHgvVkkvZlBsb1hhd1N1d0pUL1ZKK3RoejZRVzQrRWtiUTlD?=
 =?utf-8?B?dmFrYjlJeE82QVY2MVduR1orSXFjMVlHVDRrWm5LZVhnZkFxd3J2b1BTMWlu?=
 =?utf-8?B?ZStJVUJVemlVOEh5WkFRZ1d3WWkydFcxYmxROXdvVDBmR292Y2lwdEtmWFpL?=
 =?utf-8?B?WXJicjNOT1QyRHkzeDJVS3orZWNjNHkwWjhLUnhKMUtVWjlsWXdxME5jb2Js?=
 =?utf-8?B?eFpjOG5EUHdUVWFwRGdLT1d6aisxM3NHdU82YXdoRG1JQ05vQkJ4SkxpdFNU?=
 =?utf-8?B?a0xOTVQ5RjVMRWwrdlBwc2k4d1pFSXJmQVo3YmVIeldTNzNXalF6dC9GcFg0?=
 =?utf-8?B?c1JXVUQyYTBpNlZ6Y0VOYno0RlhhdmJqTHNhc1EvdmY3amlDUkY5WmYwZ0Z0?=
 =?utf-8?B?S2Q2Nk9pZnY5NDU3aGtLYlJHUSs2Ym9wOE5oTU9JMU1waGJiYUxSYWs0Skwv?=
 =?utf-8?B?aFhXL1Yvdm1tb2lxekhQZmVpR0U2bW1oRFVkYkNEdE9UbVBQbHNJSkdyeStR?=
 =?utf-8?B?a2xNOFZvbGsrY1JwcEN0eStmVHg5NHRReUp0N0x2eE9nUmw1UTgrSUhKczMr?=
 =?utf-8?B?a2ZhWWNVNU82OUxiU3JRcVczSEtHNEtLaDAxY25UOXJ0bVNleFlnYXJ3ZTJ2?=
 =?utf-8?B?V0tKU2RoT1ljSVdwejJkVFp5UnEzWDNISWhPbjBWWjlBU2FSK0pZQ2dKaDVM?=
 =?utf-8?B?YjJmOTJNNkF0NFFEQVd5TUViWUhNVmpodm5QemhLdHdSaDhuUUI5b1REWmhO?=
 =?utf-8?B?QjhMS1ZqWmZzY0Q0a1c4NTBFdXpHMGx3OVdJWnl5YWhPTStUWVVXY2llZTNS?=
 =?utf-8?B?Q1JmSmR5NG50U2wvb1RKVU1jMmFMR0VIUEFmdGJjeUlCbHZsQXFCZk9CbVp1?=
 =?utf-8?B?U2tWRlZMU0NuWU5Lci9WSGluWVRVVkRPNlMxYlVQdG5uUzdyMTBmZmNnYU5p?=
 =?utf-8?B?SkhyNUhXVDhQVk9SL1MzeDlaTTQvNFRDWVRYdWt0U2F1UnRhdEFFN3grYmxT?=
 =?utf-8?B?TWRKc1NWZ1RxZEdSNVJoT0FOOXIrWEtwY3VvaWpCSzZRYTBtWHIyMUg4ZmFW?=
 =?utf-8?B?eHcyVE8yeDBqTG9oLzhqTXN5dXZUOXBqblNNYW9XMnN2NHZVYmhGTzgwRkMw?=
 =?utf-8?B?N3NQdDJaVHVBYjVpcGdtcllRRktBMUp3ekg2UDN6NUVkeUliVHRrYzJKTlpX?=
 =?utf-8?B?d1luUGQxRDV6WFZWa25IYkRIc3Z3c1JzWjVnbHowUkxNdVdNNzB3RDFCQm5D?=
 =?utf-8?B?NG05MWVLaGxLK1NxNFVNMzZmMnYxN29EM2hsRmhScjFFYlViOTdQMnl1V3R4?=
 =?utf-8?B?MUlzU21kOXRtemMzSDgwbDVDSkpkVERFNG9wN0JHSjdueUViZ2JQSkNvaGF1?=
 =?utf-8?B?b21jc1VReEhDU2g2SXZ3SVJrS1IyVDYwZDdXNkpxTmdqcGlyNU8zUCtGRkNZ?=
 =?utf-8?B?Q0F2ckxLTFRZdFpRUFZqMnE3bHRqV2dyVmJzaFA4RW1ZYlhiVk1lakVNVXE2?=
 =?utf-8?B?c0JpRzkyMG9zaUFvUmJnN21hQnJaTi9wVm9CZlJrdHhhekZCTzltbXcrK1Rt?=
 =?utf-8?B?S1NBTDFhUTZlamFMcW4wUEwxNi9xYmJBWStydWpWZk94cHJSVkdKcUVWdVRV?=
 =?utf-8?B?MnVpSDBWVFRZdGZYbTZaZ0FXWFM1QnhGTGdRM0l6dmpRQm1Jd1pKRFU3UmRm?=
 =?utf-8?B?cDAwR0JycVNuYkgzbDVMU3Z3NVU5bUV1QnR1TDkxRlp6c0E1c0Y0dEpXYlRI?=
 =?utf-8?B?TkIzdng0Mml1NkJYL0hyakdyRU13UFdZVy9ScjB2ZlFFTURZNzRwVjZyL3Ey?=
 =?utf-8?B?RzcrdTJlSDcybWw4aFBsa1RpaG1sY1dKQ1FqZ3BBeGFwOU1weVowNDZ6dU5j?=
 =?utf-8?B?S0NLblkrZm5RZ3paL3NSVmV0WFE4WmZISFNyUjVadFVLUmJJdG1WY3d5OCtK?=
 =?utf-8?B?UjVSVDFHallzUGsrN0xNVkR6RzJFcDQ1UVNkRXlmTUdZSGJ4Qm1GRlFSbzhQ?=
 =?utf-8?B?MmZQcUFuM3ByK2dqZy82WEtCNXMyL2NyelRGMGNQa1lvMUlUMnM0OHV4L2tE?=
 =?utf-8?B?ZXFIV1B1a2U1MFg1OHlZR1BXeElJOFdDSFhIMUFmMlgxbUJ3bi9hSjl1WHlN?=
 =?utf-8?Q?f/d8kN5hy427y9xenJP/fqk4P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a5d742-e1f1-4c79-ad8d-08db89f9238c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:45:34.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOAX5nsc1+ESG1jGntX0VZBazJpAMAgKX9KbD+KLG5VPkt+bN27YWK0+jCixSDlm1G6zlxpllhg+FV8XQPUzBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2023 11:55 AM, Borislav Petkov wrote:
> On Thu, Jul 20, 2023 at 08:55:01PM +0530, M K, Muralidhara wrote:
>> Pull request created in rasdaemon for the same.
>> https://github.com/mchehab/rasdaemon/pull/106/commits/09026653864305b7a91dcb3604b91a9c0c0d74f3
> 
> I'd like to see a single error, once decoded with rasdaemon, after those
> are applied, and once with the kernel, before this change.
> 
> Then add that info to the commit message so that people know what to do
> when they see an error and how to go about decoding it.
> 

Agreed. We have already discussed this...

Thanks,
Yazen

