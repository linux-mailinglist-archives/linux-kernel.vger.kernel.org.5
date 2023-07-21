Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4175CA6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGUOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjGUOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:44:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B44F0;
        Fri, 21 Jul 2023 07:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEvwcTCPX9KZZzajvU6ZSL0/Cs1rH3JNyJekt8Aok9O6SUkYHHFtmKykf3e8DGgw1zSDnXtbYlk2z+KYMKsLd9dvZZRZoF+acXrYnteIsn92OiNVybAZf13Oae24EDBTkhVE/TLSZ5pkQnS2ax/ueIySH/VvhwBzvNaH7g5bWd+25+MCm/oX2fbzi4Mi2XWZSaFDMCCl+tTCJ+GY2B+/4vDuUICQ32yqd3a6f2fjTLeQ3mM8KR6aqoyUCH5AKUQz7SUKuPYNo171zmXyrv6Gy9z2akMHV3BoOqD/qtMT21SJFWA6gc3tP+dMFR79DYvvJq/zH8UiLDNzyHmf4U+5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFt/rgZQFvybHUhCz8RSGY8DAsbxP8c66bS4LKCRVSo=;
 b=Ds816AAVXnL+3u65FQ2HxePW4XAwKTh8ljFe4w/4XmltTya7so84TLNnRBC9YJ6X6QniwiepiM7SkVmYNh3tZ19Z1NCBUzEGQDCeadMxdtRtVi29au8hwaY7EylFHB56jwUf32EIyMNmPxfHgP8KFYKe4ZaKm54DVuC3DUmdvYanqHK4IBHbswwzO8Ey05Vkj+RnSx7EX8KCKeayiObrkjLTE6vHnGdAPENNdXKxk0PsQ7qm+yBIX7KeyUJWZ/wrGLh3X3OB3KnhhbpQAVw+92xpl8TgzK8G8YQVWFEh8/yFHa9xYn+zNC1V7HGKLtergUbIkv3itzGKRDzJnBwGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFt/rgZQFvybHUhCz8RSGY8DAsbxP8c66bS4LKCRVSo=;
 b=Pzc8dAYHnxO9bc9nLvyRu0YD6GsWccBB3hAf2Dsx7aDaN4yPBEFneT90aRY7LrY1TxfXUQQ6nTosaSMQI+yDFQ7tYnJIdQ+hgGsSQRH5/NoqTdFuJ0PA/HvcIIc8oCNRn59Lo67L/NzHeDDMWGjscQyYdCoEPopZP1Ros3fYx2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 14:44:47 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:44:47 +0000
Message-ID: <6bce6a44-890e-9d50-dd10-e621b4d2a735@amd.com>
Date:   Fri, 21 Jul 2023 10:44:43 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, mchehab@kernel.org, nchatrad@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 1/7] x86/amd_nb: Add AMD Family 19h Models(80h-80fh) and
 (90h-9fh) PCI IDs
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-2-muralimk@amd.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230720125425.3735538-2-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0779.namprd03.prod.outlook.com
 (2603:10b6:408:13a::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 80859934-905b-4241-8131-08db89f90757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Qh7ukqJMG/35E/IerP4qQ9AIMfKzYMH22W6VPKaGPeJMlAqMaOSICt5QlbX1eYRFF49fZ05DgpNB+iCsVNcCbRM6x2Zly1VInDXZsIr4+2gzYbxIAZ9dgQC5WbxzDWjtA4ed0OwjD0wZ3l/g5HjwaELW7jMp84/Quog9Ut4U6RnDCmsTdNsFuFMfjrhkMPZ3aYn5MEHWf68GBZEIYMkw0IXcGgchSJVL4Bw5JO9RT7ylcKWma8D2veEW26KmFxb7eVixQiP8yR6iVlyKPrULmou3hS3KRSdwMVQmm8HnsJaGmUh6z0MKPOTbQH5qhYX8ZDlhXJPP186FM7+pq5+yp6UOQ+5TiT+cJ/5KL3KE32hTLv1aJRe5Pf+PyV8gcD+o2TAlp/xgWnlFOWGkS0aPnxLf67sB5AynrtI6Jm55l63F9RgGvCtXNBe/bhMNsyy80nyctexatN0w2hMZfp2Gdz3KR5F2cbgQNfhwI3qphW6Xz8744tQ/apSV/58oVTuI2hbSzXyVn5pxH/OJAG1Q0kfoT4ixfz8omCW3GTQWTmJ9b7kjcFeASpKJuykt0pON+/WQZbTJYYU+1eUu2ntHyO7b4fAXj67JZM5Kl91MsmJkLy40XIcCtJJmmHdNmDweyRQLkEHMsmMaacENy/roQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(31686004)(6506007)(186003)(478600001)(2906002)(6486002)(8676002)(36756003)(4744005)(44832011)(4326008)(316002)(8936002)(66946007)(66556008)(66476007)(41300700001)(2616005)(83380400001)(38100700002)(6666004)(6512007)(86362001)(53546011)(5660300002)(31696002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVlNHM2TzRYaWNNNnVrRGEybUdzUkFOb0x6cTZnK3UyV0NGbVBueEdlZDBN?=
 =?utf-8?B?aTdrWHBtaG01STZhcDNqU21JS2hTZE4vS2dUYjdJNU9QNHF2VjRvV1JKMTZH?=
 =?utf-8?B?cUdTMS9vVExYQmc0Vm9kaFduY29uclhJc3RrbHNmbzNKeUpTZlhIZExGTURL?=
 =?utf-8?B?MFIvbnc3cTZtRnRKM25BRlZyMEZwYWJLTjFpakhWSUQrZWh0V0JOTE05ZGw5?=
 =?utf-8?B?d3pUTmFYK0hGaHBsZUtDQmQ4WUhVRm0vV1h3NnFSbVhmZ0tJdk1nVnM4SytD?=
 =?utf-8?B?QXZvN2FqSkFxOHlvcXVjUWFtVjVjeXBMcGdSNUZjb2hrUGFHNEdQdGFhdHBy?=
 =?utf-8?B?b2NZQytiMnZjN1E5L0p2d0VCV0lkNWhuRXRDdVF3R0dqV0N4aHE1ZUdZdlk2?=
 =?utf-8?B?K2x4U2NpSVJMRW54WVpHTnNZek01aklrUG02aU5FT1NQTmtFSitIU09ObitB?=
 =?utf-8?B?R3dEZTFVNEVhUENvWGdLaDZBN0FQMkpqQ2s4QnlkcWNXTXJWNHh0eERpZmYx?=
 =?utf-8?B?N2ZEaU9BcGJKOGJzdUd2UkJNSXNTbUpwOFZNbnRhVUNJMEJ4Q3FwdVJSc2xa?=
 =?utf-8?B?R2ZtRnRLWG5BMU9EdHJzbWxoa1Z3dCtVNmtDL3NFQWF0NnVBdHJxaWhMY0Uy?=
 =?utf-8?B?eVhaQm1CelV2QmduWmYvM2RaYzYwQXRwUS9OZitLTWNDSTZlak91bVVuQUlr?=
 =?utf-8?B?c01HVi9rYzZ2bXNFS05sb2dYeUttVzRmZmlMaGQ0bWg3WHF3RU53ek5Zc2kv?=
 =?utf-8?B?Qi85cGFEblJRVVRLdEdPaHFuMmd0S3BFc01hbVhuZ05QcHM3bXcyNUtpWTFK?=
 =?utf-8?B?aWJ3M21OWGdlbTdCeFhMaEF6WDNsY1AzRjBpd2tHOWppUnNZeHRScDZWc2hQ?=
 =?utf-8?B?TUpCWlRSaHNER21HcUpoSE9DT2xtam5kVDJSeHc3ZlhPLzFHN01HMEhPd1hm?=
 =?utf-8?B?YUc2K1RPcjlSd3F2cG9sRzcyWWMxYnBXbzJmcTFWR1F3ZzRIY1gwNEVqQjdG?=
 =?utf-8?B?aGdoOFdZQmhuemtYYzNBNlQ3emtBVWNoTVpDZ2htdmRWOTMxMHRpbjJVZm5L?=
 =?utf-8?B?R3UzNEpKN3RnQm5iWGVUc3ZNZ1ArTkhrRTYrWU5HZjc4Q3hiNHlGcm1aYWh5?=
 =?utf-8?B?dWs2LzMyZWh6YjJyV2tLYUwwTWpZSTZNTkdoeWUvemdtS3VwSUkwQjN3MVpF?=
 =?utf-8?B?Y0JZYXJvTmtVWDNFYzVVWFdYS0VPMVRTaklxMi92SVhmL0RwNEZVMkFuU2Rp?=
 =?utf-8?B?QlJTaUhTZXRnS0tTNDg2RGtuWXRVR3pOY1ExdU83Nnc5K0pocTZ0WHJsS3BJ?=
 =?utf-8?B?YlRnVENCWmJRWWk1enduc1Q2VGtrMUlGR2pxVHF1UTR5a3ppQWlCQmNNTlFo?=
 =?utf-8?B?eWowNnVJb2NJUEVQWXo5VjBDVWU1ampreFJWbVFxRzNtdFp2N1dBVTVua2Vp?=
 =?utf-8?B?RnJsU1RmSjdyUGdRKzQzTU1TbWJwR3lRRW43QmlvbjlTZHFieWI1S01DWERt?=
 =?utf-8?B?bnk5UGtTZmx0dG9ySk9tZzFKVWx0elFQRGhPbXFaZ1ZPUEQxdmpuVUVjYnd6?=
 =?utf-8?B?dmw2V08vZ0ZPY1FzcVkyeG5nNi84NHFzaEhpVUhXaEpYWXdxTWxrdFMwZ21t?=
 =?utf-8?B?OWNJTTdPL2o1enNqTXNCTmZXWktKMFY5dFZ0MmhqcUJVRmhvNGF3THJJemUx?=
 =?utf-8?B?anhVN2p4T2NoOTBPZnZMU1dQUS8xd1RPZG1PL1VaYXQwTllOLzVuNVd1c2pG?=
 =?utf-8?B?NDNhSEE0cDZKTkpSdDJFTmY3ZnVrZG1ZWTY3M1Y1eTU0emR3REhjQldyMTBa?=
 =?utf-8?B?NTBHRDVoUVp5MGFacWozZ3RFUXN3SWErK1JabHAvekdjY3gxRnNCYktIeFRS?=
 =?utf-8?B?bzh1MlJsKzVIZXVnRlltOHM1b2orejFqSVUvVkFGOUhoMkk4M1hXN3oxZTA2?=
 =?utf-8?B?eC9WZEIvY2FJU000WWZnLzUzQTliNlBKMlJKcS93N3BUb2xFWEh3QUlXbzRk?=
 =?utf-8?B?alJ1SkRwbFNiaEpsc2lZeGFZN3p0QVA3TFI5dldhemNhbDViMXAwZmNQOHda?=
 =?utf-8?B?eTNsU2Yzdlptd0lhc3gvRUNBc3RMZ1o0R0dqMEZsUFdzaWVpUEVhSG5uLzRm?=
 =?utf-8?Q?TGjtWVDJgHyda2hC6wT0Om1Do?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80859934-905b-4241-8131-08db89f90757
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:44:46.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WruCL4ccy3dstj5YcvGzJFzqdnbT60/V39iXkJGwVBbH7bdcx84isthbGhk4dEN3yC5Yf0uqOs6gEarzgniPVg==
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

On 7/20/2023 8:54 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Add new Root, Device 18h Function 3, and Function 4 PCI IDS
> for x86 AMD family 19h, Models 80h-80fh and 90h-9fh.
> 

$SUBJECT and commit message reference Family/Models, but the patch uses 
the code name MI300.

I suggest using MI300 in the $SUBJECT. And highlight in the message that 
both groups of MI300 use the same IDs. You can clarify that Models 
80h-8Fh are MI300C and 90h-9Fh are MI300A.

Thanks,
Yazen
