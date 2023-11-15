Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D757EBD31
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjKOGrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:47:11 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B741B3;
        Tue, 14 Nov 2023 22:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnfIkxUvTpcVy7iDt4H3ax7imyOqiHwyy4UFALKq6NyOevbmsNi/RkoPKh9UAKeoiu2mK8nqW03/jso2sYMmmePrAXfiSwr8PfAOg4nC9bgV/ofTSHS6tf+FDNGt1W7IzRw+3ltci50dYVQt6sanXBwshqLJZmoNDexekvmn2qQY3czOBF1xELd5SmG/DhgqaMgu16GEYXsXziDi8E1atbLvqDgaVIG90oe3eti/RtNBtnJ//4TOAkUVmJIAIP9nMdss9kSdGr00QEJMWnuC+AHzFbhQnjCZL3hEl6GkZ0q19WJ3I15fhuNkmxtxrhxO3s64nNIypIrEbLa5TJtttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlOdvYwyaNN56+4A+zj8ZYUmrnyxcqPQBRPsUIJhbeg=;
 b=nZDEK/Y2NWhrSuP37AWtv1kNWxpXByvoLwDldMZC6a5sztB3lSRJedGV9bNaf/QZL3PvkTfb66ey4DFT7F5uCAKpYX9u7fM1gJCXMU7eCgCSmXpz9d+XuN5RLbwJHg29vHuThFfGYhv5qyP3h0T5KbyofjyeaK9ac5CtGiCKOG077ZM8lCXTHq4RMdW9wBt01i7HwSqrgcTy29/5k5PMqDVDc+zra9VdhkuFosvu8ECgPDw3KqyKGxnulQ6wcNeC9t1OV/StCHUlgNeCRAA/SDPRWBZs2RUT1t1CHNfRCDY9936BnlBbpIKfrkfO4GW8Xi/E12eO4GECeJqJNDBR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlOdvYwyaNN56+4A+zj8ZYUmrnyxcqPQBRPsUIJhbeg=;
 b=igjuWsUObT+tYg2IAtIFxg+1FRtRg73WjUYR8Dit3TtYBWrvzOE6KNkgW+T3CKSVkQu5F3Qw87NB0sJuCvaUMyoMVnmrBKDEhCXFfHwUnUbCGQD1W6b8+/dQs7FAIBD14hyWgMMkVI/MvSQgDyHi374NOdgB4GhfZKlwG4JyT2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 06:47:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.6977.033; Wed, 15 Nov 2023
 06:47:01 +0000
Message-ID: <6f5b2c30-8336-4e03-9239-be2be736a09f@amd.com>
Date:   Wed, 15 Nov 2023 07:46:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ZVNzS2EA4zQRwIQ7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cde0b0-4dab-4e0b-0450-08dbe5a6abb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+Nl0W769+dbdcHUox8lVmullEsbovN3/b1kN3koUcZWL5B35KShVSuPJQXAkeJnqSenIznd3aj1iTcZFtUwR5Mmj8jI34AVZA+SH1adwtDNABGHJTLwCxJfQnyvNLwjiT0iDUqDGU0gz6ecvkJrT900OxvXXgEI2Km0On6LyTKAthY2mJ/EEWo77y8ZrVfEoPncgafhASArOz+hKsyAbZd4q6JnngOzFfI6UR9nZgWczKY8amYwE+2fTkAgZRF5xu/kDXjZSQ3Q5nd/9Svl5tAvMZKfy3HpTGy1jiFW46Q+05nlOtiepiSw0cyJwWuA03oCJEEUEjR/kij7yIj7tWSmhf27b2j1Va7T2OIizmAILt3yoE2kgk78ux3tlCiG3HUwQKcIhR6omlOht08TlQUnTRHm+MEwjOtjSDoQMZqz9NyJrvo68fcX57xp4lW01JXOXGN5e6wT3C6LooAyLxHw8bcTpE7RvPopBxGlwg7A8apyRCsfZ4fDkqKA4tzkF+rSByJo15IKfooa6fMNAse1PRkB5hMqwyxiYjr0qG0NvmL25uro0qk+x5lg8orBsbYTkTnnNRpTSbQcIQn/pmccw/aPg7tLnvbWh3SFJMcrcY5HY2MNlzbSDbnxtMiQAOciuOlNW9WtlCX9iKuUAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(41300700001)(36756003)(7416002)(4744005)(86362001)(31696002)(5660300002)(316002)(478600001)(2616005)(66476007)(66946007)(66556008)(6506007)(38100700002)(110136005)(54906003)(26005)(31686004)(6512007)(6666004)(4326008)(8936002)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU04dG56bUFFWVRpdUpHb25qemZHZ0hya1cxYWNzSXJGVEdKZnNSUHZOTE1K?=
 =?utf-8?B?YUZwS1h1NzB6MnR1bjNRR2QrOVE1UG0vbk11cVlsZGNRRG5vZlJZUjZaVWVC?=
 =?utf-8?B?cG0zMTFobUxUU3l1UWYvbmR5ekFqbXlQQTZoeHBRUVg2N3haTEZQd2ZHN016?=
 =?utf-8?B?Tndkak8yWVJhWWxlYjVTV0dMUU5EWHNBcVhqSTJsL29jc1Y4bjk0bklFT01D?=
 =?utf-8?B?QTF2SW5OcjlCKzIvQkhaWjZoNzNjK0tzcTdTVFpXclRGcDB6cTVhc014ZnY5?=
 =?utf-8?B?dmNMY1JHTXJLZEQ5MHZlK2VYSHk5aU1RM2I1SThoeDRWcndqSmZqNmJHNWpi?=
 =?utf-8?B?MW5pTFVyRE9FQit0aExSTThlL1l0WWI0QmYwbnpUMis1bmNOT3ZUZWNJelVr?=
 =?utf-8?B?Mi9Sd2RLdzUvWTZxbDRwYkVKc3lVRDlyMDFmTzRTQWdGYjVHQWp0dUwzdFEr?=
 =?utf-8?B?UWJtT1c4Rm41MHRLcjRxZXdYczNvdWZ1UXZ1eW0vNFltZ3M0eExDbnNMbW5S?=
 =?utf-8?B?cVU5b2tzd3RzOEhkV2REQWs2RGhMTkhQL0R4SjJ5ZFYyOVg3cExJNFFtM3VC?=
 =?utf-8?B?Z25vaEFnNEJFdXpkaU5HN3NNbk1zZTFmbVg1K2V2T1Noa2xOTDFhbGl5TGxK?=
 =?utf-8?B?S2llYWNZcmdDbGh2emFFSHlNc21kN2lQSWM5VVFOL2Z1WmsxR1JtakVYSDBT?=
 =?utf-8?B?dlJhNzFpVDFPVEFIWGlGR0xUc3JBei9KWFJMQURMeW5rbnJLUlpUZkNTcG1w?=
 =?utf-8?B?MkNtNG9MY0w1YzNrajJEd2xmT3dMaWJKNVcxRUxFVmUrVG16Yk9nWXZDLzM4?=
 =?utf-8?B?cmxNMmRMVWw3OXV3Nk1tNWRjSXBiMGVSdDQ5WDQyWU1Vc0loY3Vaa3o5b0kw?=
 =?utf-8?B?TzRXc3dHbjJBTC81V2NrMW03TFNKNDlQaU9aQkF1UkpDMjdGRXRpdllLNE9n?=
 =?utf-8?B?c2VKZ2xXZ3Z1QlFzNWxQUDU3WllpdnN1emZkZW5Ybi9jVnVEUVpKODA0eDNo?=
 =?utf-8?B?SUs4ZlpXYWVJdmNacHN4WHg1UTRqRFg3VW5odGZaMnR5aXdJNXh3NkZmVHVt?=
 =?utf-8?B?c1N1eHpXYzhXamFxM1FkMStOM0lia25vUjZ6b2hqSTlmc2o1S3lreEVHZGtp?=
 =?utf-8?B?aHFwckgxMjhNY2NPZGF0cXlnZ0VrOVFrdmQ5d1RuU2xnc2ErWE9WNnNwL2U1?=
 =?utf-8?B?TEZGdDI2eGhCNjY3djdUQ1VtN0NaSFIxK1VXb1FhTnZUeWtMZThJK2tVWUtj?=
 =?utf-8?B?dE5EbkxCR00zdjU0NW5wYXZIQVRzUy8xRERvZTNCQ29zcTNoRnBXSlJxaGhs?=
 =?utf-8?B?bXRoVG0veDdPMWxydFhVMmx6MTJyOHVrbmZBMkNsRWhjb1ZTL1NGVzJLV1My?=
 =?utf-8?B?eXpMeWRpOExLNTAyaUowZ2FDcFlqVzR4Y1BHZ3QrWkp3cU41RmhqUUNZU05x?=
 =?utf-8?B?eGs0ZW02Y1BLS3JzN0xmbVRZdnlRLzY5Ymg1RG1wYThFeHY3Sk9aUnVIaVo5?=
 =?utf-8?B?N2Eydm9oWU1Na1hnYWcxMS9RTjFJaGo0aDQ0dzBBZTNiYVZNMTBXNXRGamhl?=
 =?utf-8?B?R1lmZ292SFR1ZUlBV1hNaGdYZEZ3bGN6SXlRZmhWTkRUZmVmdWlLWHZ2ajdT?=
 =?utf-8?B?WWlCaENPNTh2QWF6ckVsY1BGNVl5WTRWaEwzWndwRlRKNlEvOHJNQUtQTFFN?=
 =?utf-8?B?SW4rTEFPVHVDOUZkZDdnMVY5L2tnVFVtTEhLc0l0MmMyUHJyUGlTTENtOWJk?=
 =?utf-8?B?UlZTQ1owSEFZUzk1Q3QyME0wWTNyRnVSWFJZanE3dDkvTlR1TFJxRVQvQzBP?=
 =?utf-8?B?azdISWJEK254QnNyN2lHN0UvN3AxZldLWmM4Qlh2R05QdFJxQmU1T01vMUdy?=
 =?utf-8?B?ZmVHb2lVRnNzNmk0bWFyTGVpSVR0UUdxNEdRek1kK09XakdpbjJEYzNOelk4?=
 =?utf-8?B?ZG9MR0NDUEtLc1Nhd0Y1eXFDcXBmdUZweFUzcUw4Nk1sc1pzU1g1a1g1Rjhv?=
 =?utf-8?B?WGFvYlA1enJ4c0tKRXFXTVdsRFZ0K1ptaU5IcjA3VjhVTXdJUGJWQWNUejhG?=
 =?utf-8?B?YnA1SHgwd3JjUUltOXZ2bjFxYmFtOUY5cDFabUN3R0d0dnBxVGhhWDNSeTh1?=
 =?utf-8?Q?0XoY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cde0b0-4dab-4e0b-0450-08dbe5a6abb8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 06:47:01.3693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygMZLdcsam0UnH6sy2l8skZ3ZneLGGRySdmKSW+EA15Y9fR009VELCkRmHytgTlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.11.23 um 14:16 schrieb Jason Gunthorpe:
> A non-mm owned struct page should not be
> passed into mm calls. It is just way too hacky to be seriously
> considered :(

Can we please print this sentence on T-Shirts? Or framed on the wall of 
meeting rooms?

I don't know how often I had to repeat that to people.

Regards,
Christian.
