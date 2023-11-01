Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE47DE237
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjKAOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjKAOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:12:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425B83;
        Wed,  1 Nov 2023 07:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8elzXfRSeWIwj1WMOav63ZaoXZV9xpCMy8leIAWrO9dQrQU523padYvMw0Zxj+ZjJft3vAf1FIkakN7sjH+SRvSdnc9LYbPTKKl/gmHHR7JR3t4R7/OeNUpLThweeifsidZFh5yRjQB7OsDiU2L3yXl/P05ur/n1Sb+IZYeN5ldfYcPhxnplNg7SzgCiTSkOzUszgbEZjQpBMpoykNuHVKoERs+zGxqZ0aFjSqOhvO3nQs8FQvQ6OQJKMD9OY0GQfOwe8SUvw6hJFofZEwU83t1LX/IZg0a+nYODz2lzXzVECixTy/0ErGo66fxpVfEOj39aPc9S+arn96F1G03FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/HOO6S2f1Q4bmcAWouHRq8lvufSNEf/syKLVn4zn/E=;
 b=iWbFDOx5E7wIK8jT4OYtOiRslVH8B7FSWD4hm8h6P0wwmGkkjX5hEqwSS7E9Pz0AbmXowZbo87/iLfysrdOZ2kvpQcXMP1KcOjGmvCdA/GH7Y9eMkVaMbnosZHn/2ll3zqUxNBghdWAlEuzcwjZEwn/iTNrmJOL6P8Gw+tQpiwJHjX5LcxBf0REB/iChANozIvYk1aIOUaF6V3vfCfbNQcQJ3FtSq7EI+/SmQ9lYqS8AqiW02Budn4NkZECNznH91R9XMRg52ZUTvSawNklikClc1QD7fi89UNrPW5FhGbpCbh+ZjY6YfaMmbdguJ8PDKZftvHtSKteEYeD6z30KgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/HOO6S2f1Q4bmcAWouHRq8lvufSNEf/syKLVn4zn/E=;
 b=cdmZEmr3/37oLu8vDRXi32TDtwdBzNWkN2CkjkdSB7QYdZmYcDpR1M6jLsA16HLRrfhQqIxGXUCFScpd7MwRqWVlKondzXbgt9FIXyye0zWEQFxxk5YkjY6tfZ6j0aTfKuoiz2XxCVGBRKsTnvL2KgYFUNZW9v8w8C7U7YTQ+L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 14:12:26 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e%2]) with mapi id 15.20.6933.028; Wed, 1 Nov 2023
 14:12:26 +0000
Message-ID: <9505fea9-1175-4427-a6b6-1783329b8c93@amd.com>
Date:   Wed, 1 Nov 2023 19:42:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: ccp - Add function to allocate and free
 memory using DMA APIs
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     thomas.lendacky@amd.com, john.allen@amd.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jens.wiklander@linaro.org, sumit.garg@linaro.org,
        jarkko.nikula@linux.intel.com, mario.limonciello@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
 <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
 <ZTtJdU5a/P4kg/Ss@infradead.org>
 <94059f5c-10dd-4d75-a69c-76b21ff49546@amd.com>
 <ZT+wkcITIz0ThWU7@infradead.org>
From:   "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <ZT+wkcITIz0ThWU7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0230.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::15) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 11968a13-3955-4348-7e0a-08dbdae49355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //zSMU8OefcHMCtmVP/cwPb+yV4FdcBbJZxqZ8vr8A3UZI/gHfuB54p0Z3ZYcjBShHaxC1VifgqG4BMO25Dqdvz/dXP0/AAd91qWU+T39f9vHNm4NiUhdx5U1OaNU0a916AHGNKpSKbvAPk38qJRH8x0jbrxEa6wc5v80O1kSWgA+You0ijLbGDoI0d89FrmHcsYzXx8poj2QClYBtCRUTdlCMlX6y2G5Z8IgOYxszJYJsi8JuRM3DvPfEH8CszxZ22ZPqGU8z9xAca1gEHCI2ILgFhVGGy8PfwG/Jlx/pY6dt2ckE7VF+0taBP4qHQ9NlLU6WRri+apqd4oKgApiNo2Oi8jftKqZnhgQ4WWRI7YNOgFsCHjhC0yByH32Z+EsU2/De1/ZAUDGCToiXBrawOi45YlwYVy09La/0gfOJrlBe5Ml4sP+JGA9xMqBXrgnJguIep+vz/jEpMD48eWUXxELQ6RkE6x2ja76+uo3fQ8Z/w8oPyRQkGgNSnNzyXbRsUp/4XCFbaCQ1zYEwVyKiu6sCHBup337b/KQ+OP/AZ3onCqZ4TMiq4fyOxuZAtt+9XyHecwCiqesHQCQAD632Rjyo+dCLp95gU0oGMdlc4zPY6bNNmWIKrXqkeuCOf1nDEnM+GZg+0veQ4jw6Bjfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(6512007)(2616005)(6666004)(478600001)(53546011)(6506007)(2906002)(4744005)(5660300002)(8676002)(41300700001)(6916009)(66946007)(8936002)(66556008)(4326008)(6486002)(66476007)(316002)(38100700002)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEY2WkFnT1V0UitzbjVlc3d4RXIvQkZxb1kyUWU2eE9qMXZnUEZwQndzVERQ?=
 =?utf-8?B?djJiSDE3T2ZXQnFrMGhrbHlKUCt1UHRrWnZ4djNIZk9WTThIK3lwaE9PQXdZ?=
 =?utf-8?B?cHNxdGNXeHhjK3gzUE9HYjF4c1lOOW5rY09qUXhKNlVFamxucko3MkxTS2Iw?=
 =?utf-8?B?eTlhOU1QM0hwZkt5NXhZbTQ1WFU3OVJ4N3J0cktqZzh0alJ5Tmxudkd2WTB6?=
 =?utf-8?B?YThwcHlsc05KQjkwNSs1cStCUHpESW5BWDZkZk1QVGRMSEZYZkQ4NlNOZXNt?=
 =?utf-8?B?S25TakZUc2ovQW54MHR1R09za2FLeFlxcDVJMSsvck1LVFdtTFdGKzF5cmJy?=
 =?utf-8?B?TUVvVDM3blFRQWVuMFlnUC9tdkY0SG1PWU5XYTN6VTNkZ211elEzVTQ0enVO?=
 =?utf-8?B?T0o3RDF6R2p6OWwyQkhlTmRzMGpFZHlxdXRNOW82SzhuTjgxdVJmbnV2bGZU?=
 =?utf-8?B?ZHM1YzFnUXZRNmhzTnpOcC9jVlVhNW5LMVF6TjNvWGJNZGtlbXhiTVRzeStD?=
 =?utf-8?B?SzgyS1o3RDFXMEdkaFVGQ0xqU3BRYmdUaERqd09Jck43SVVsWGpFS1kzU3Qy?=
 =?utf-8?B?TlBTTVNlQzZkSWx2UHRUMUNVWTRLWmlueDVHVVV3bXBocmNIQVpLK1RNVWNZ?=
 =?utf-8?B?bzB0VHcrUzZ5UEVBUEVaZXEralN0QTZqSGFLUXhxc21ZdFZ5RDlzVjJNcHpw?=
 =?utf-8?B?Q0hLcytBaFBIWElqTENoajc3aEtOb0t1VnNBWFFjUmVKMVpVNGhDRTdOaW5z?=
 =?utf-8?B?YW5Tck15QkZzSk5pckRsNTVnRmdlanRvRXZJbC9vVk5Ca0k2QjZZSFNqQS9H?=
 =?utf-8?B?cXZNYWlqa0pKQkswQkR1VzV0Sk5FTnkyZk5wbTMxeDZNNzlTaHdwUytuSTk5?=
 =?utf-8?B?NEM3SnEydEh4VTRORm40UEg2STl0SXZ3bzU2TmxSOW5PUS92WHZBMDBUMnh4?=
 =?utf-8?B?OXpGZksyM2lFNUQ4bjhrbmxYWHlIaC9IQ3lPMzZBbVE1M21Ub1N0TXNMb0Zx?=
 =?utf-8?B?czgwNW84SmNBdDgvOThpZFdxNDFwcE14S2lCNWVnVEVWMk9qVm5RalBqcVdm?=
 =?utf-8?B?d0lEQXNzNi8vekYrZlNadk1IdEJyK29IUUNiTFBCSEdVdGE5dWhyY1BrSXJV?=
 =?utf-8?B?YnZnNUE5NlYrUkRxdStoQkJIVWNhQW1NVC8zdjRoekk5K1VBa2pxNFUxb0FT?=
 =?utf-8?B?QStQY0VtYVZpVzlsa2NhS2M0NlAxbUY2cTdaYUE0ZHFwSnRySjQ3N3FRT2hz?=
 =?utf-8?B?TFprbHA2dlkySHBHRzI3S2hZOStlY3BvOWxwcnFpd052Zm9qWU53dkxuNEtM?=
 =?utf-8?B?amMyUXFYRUNHdytreGN2RkxCbnZRWnpmdG0vWkd0OEZZRE9LY0g3VmZDMVF3?=
 =?utf-8?B?MDA5SWtWWk1uREkwcGNQWnIvS0xRcUtBMU9OSThnaksrWDU4WDJjbHB2VEFY?=
 =?utf-8?B?U1Y4YmpoY2oyUGFidk9TOHBGeG9NZlVUcHZvVFEvYXIrc1VvOWFGSkJNMXln?=
 =?utf-8?B?eVYxT0hVeVhaSEhoNmt4QS9qZzhpTFRSU2xmbE1VeHBpcTRYZmdsc09BTEk1?=
 =?utf-8?B?bFI5NnMxQXFudlRremxnanFMTzlIYm5BdEhTTUpMSHh1eXJ3Y0xTVnRFdTRL?=
 =?utf-8?B?MG56QmtmUUJjM3NkcE5ZSHdsWkgyYzJrOExHR3MvVGtWZ1VxbnBkcXlUSC9Q?=
 =?utf-8?B?bVZxNVBmODk5K0hESnN1MU5MWDIxTTFXeVJDTFA3WkVES3IweUsrY0ErbnNK?=
 =?utf-8?B?V3ovL2VCTUdpTlNEOGwwMzQ1UytCaUJKVmlEWTZ3SWFPRy94OFhLSXM5c3JP?=
 =?utf-8?B?Tk5qbFdTZ20wS0g2Q1lUS1RmL0VTK092RnFVSXQzNEorOUt1TDdHbElaUDha?=
 =?utf-8?B?K3lGRlhlalcyUE1uUm5mczVlSVNOUEtWRXlKSXZVUStyK3pCNzVIbW5LQ2c0?=
 =?utf-8?B?SVNIWGRoMG8rd3FaVGJPOEk0TXhwN3l1SkovK2hBdXZaN3laWlU5RU9ZQ05T?=
 =?utf-8?B?aS9yUmlsZW53UWgwaDc0L011azBSSTUzaFAvUXFRVEZETytvd2RNREJBeXZL?=
 =?utf-8?B?K2JramZBQ2JoVUZiZlJVaDExWmdIV2s1KzlycUZhV1JPSzRhR0tJVjlxZlNK?=
 =?utf-8?Q?OzqrnFaDciniXkvR4ywT3JPUO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11968a13-3955-4348-7e0a-08dbdae49355
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 14:12:26.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBsAqNDq82Lsv/Q0Sua7joO9fi4N0K8hU4MXQNeSm3kK/GLG+/CXI0t7lI+j3BMbyQwl4vXis7PO2+QWavGDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 30-Oct-23 7:03 PM, Christoph Hellwig wrote:
> On Fri, Oct 27, 2023 at 07:05:17PM +0530, NK, JESHWANTHKUMAR wrote:
>> Can you please elaborate a bit more?
> Becasue the DMA API is a blackbox.  You can pass the dma_addr_t to
> hardware, and you can use the kernel virtual address.  That it can
> sometimes be implemented using the IMMU API is an implementation
> detail.  Similarly you can only feeds iovas generated by the IOMMU
> API into the IOMMU API, not any random other scalar value, which
> is what you can get from the DMA API.

Thanks for the explanation, I will send a new version of the patch.

Regards,

Jeshwanth

