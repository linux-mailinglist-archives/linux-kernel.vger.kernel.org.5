Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438767DB317
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjJ3GGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjJ3GGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:06:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0458A9;
        Sun, 29 Oct 2023 23:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd4TOzoOf0mFdHHE1LJntTez+fkSArF2sCupHsn/gtl4auOC9b5ametOR2P69flPG5oxv4uDTQDuXri751/GK5Yruh3/LAGviGHCOuPtcGofT7VOLkk5mYaNI/7vLmXkuRg6KeXUwcblbX1joxg+UR8gMdMW3kdwNWwRLbci6U9EVBfJbVCnWuNtv3O0QxWDTjg3FoaVkicSxeYwKDdp7HnGS3v2qxXX/CPJ6v+/OWyzkdHUcg8jtJZX/MsGnaE4n9VsuXyb1MBP718lgrxKgDkWgt8UZa9n52o1rPb9zDaYmfvUHYSGryHbyHz6dGukwAodQHlKxfgLMLuHKkT/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn8fssoxg2/GxH8MzhZZVuW2+aYbk+P8uR6t2K6peWI=;
 b=S2613paPRmf0FR+t2ZLMTh3sE7c57IUW3Sr32cXjhF4ZXUb6IgtbD9ezUjccWH/YMIWTzwu707i08T7G6haNRKxsHRqgWq6BNkM/iBSdVLTa3ssuujZ9UmkoosHjja3OS8NiLwOKDiJ6Txu9pxjhgEQiypP78jPHDigPVONFduc2kN16Ltju7yZfgd1M5tNPTsTyd3aC44Hw12sTQqbDyn+ajWyBn3ju1DxKBhybwbcRlPFytF/vEDfqPxFswE05VmOl3BoL88avq6Ymd5ryhtKWHnpS9T3TFF5Gd6Ah6q+Ri5XPm2mpuNDzhvriCVuAFWND9MaVatCmX0lcEW8GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn8fssoxg2/GxH8MzhZZVuW2+aYbk+P8uR6t2K6peWI=;
 b=Nm97d/tejiyNwA6u3umXNVZBEBJAfrLGOst82tfxCauA0adBF4pEXhngMSYLSpmRr22bGnj/qyO92sIDuKN9pgwjYcW9fSc5Vb3LGguJme9h5acqxRzhEN0SeKnWpDYI5TPP4xDgrEqvS4HrsjS7kXTO2tgP02Qm5b6UUd33IZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 06:06:08 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9b29:df63:fce7:8b3e%2]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 06:06:08 +0000
Message-ID: <be7a774e-54d7-4ebf-8476-de137c47f020@amd.com>
Date:   Mon, 30 Oct 2023 11:35:57 +0530
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
From:   "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
In-Reply-To: <ZTtJdU5a/P4kg/Ss@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b75436-3f02-4075-8bfc-08dbd90e4eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2W+YF7UN/r+tD7JpWd5QLGu9xdCJiR3YWSYu5XknlCZnNyqztEkXEfscWFXvCI2uJwlOEIEL9+m3FxP8GsOGotkVT5/G7+miiDRLSu2YuFU1MHqqRQseUThSVcLPnIaLeUgEb3dE6wMPMTRdfT6O1KxxHDy0julFaxD5oLxmC/uY/JT1sPhA72o2seCmeU0b/49ftF7rrtDuJr5yRYZUrkIjs+YjonaKUWR2KDDKTq/eflV89T3PpJnUjY9ZZA0VSVj0YwUT5nfrUxrYwNcPlLy7UQLRECbmMRuvHGM2FPdgoHe29u5EpuT6JDM/0mc5C3b385YEJmm1WKySa2jdsw4fyIc8wnvXNfPRD+fZBveBSpFC84XrxE236gjbdXyySd+O0szTNW4yV11RFcoRjq2RNSpbLxIG1pEZZIBtYyrOhiifjkhzcOgS9SxVgJS6gHMqmA5jjhdyhpARE273TqkOQQq0XQe96vp7ps7Rca+2g1V4I/7FtJOS3sCrcWbra2ragIL8vWhdX0EDZvwUwAh/Hueb7g3T7Dz2T78F06OMaia1QjpkpCe21ydhOgVe9vO4GPqL13iTKTY6yOk1TeqOGUEtFbtTQKw/V4xDw5p4Z8dkKghJUUXb0ulFQxbceFrX4bzvV+5f8+IJIGXyjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(6916009)(316002)(66556008)(66476007)(66946007)(26005)(4744005)(8676002)(4326008)(8936002)(31686004)(2906002)(6486002)(5660300002)(478600001)(6506007)(53546011)(6512007)(36756003)(2616005)(6666004)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXAxZFdVaFFqbW9nNWp6L0ZHS2xmMjczYzEvNTJ3Vkd1a3ZrMjBQd1NRbERo?=
 =?utf-8?B?SWk2SVpGWlA0dThSYVprbGV4dnJHbFRMWkp3U1gvS3ZPRHZKaWJFblZaM3JY?=
 =?utf-8?B?WitUMmRqUC9PUzNTZ1NLVU12alRGMUZ2aDdPaGFGT01LNCtJc0lVODk4WG1X?=
 =?utf-8?B?WXVPVTNXUmtWUVFtSy9Md0VqbU1IVzlpZjFxNGZKTHUwaHdIZS8yWnNVMlV2?=
 =?utf-8?B?Mmp3Z2N5Z21UbUFZeU9vc2lFRFVjNHI1dmxpMFJqTkRQeGpETW9hYVVmalh6?=
 =?utf-8?B?aTlmRTRhd2FJM0xRVUJHMmFxalpKWXFCdVZqbFY4U2ptWGRMeWxTaWI3RElW?=
 =?utf-8?B?NElIRXhYaXFnVTZVcUR5MDFFN0tBRHY4OVp5QWdtUkpJaTl2WEc1bTVJQ3d3?=
 =?utf-8?B?bituRlFCM0xQUmVTdDh0Ukdoc2REdEp5eWJqT011SURzbVgzS0IvZlZrbTcz?=
 =?utf-8?B?QnRDY0ZSNGdxWmtzY3lnSnh6YXp1eTNjN2JycWs1SG1iNEp0NmxmQm0veEhV?=
 =?utf-8?B?cTh5M3hpRC8yNzlaZGJqYVNjbzlzUkNYY3Mwd2NhSVEyanB1SkFEMDZ3WHRU?=
 =?utf-8?B?RldiTFlCN0xDUXNXallRREVIdHZha1RackhVUmFzOTR5RVpYbklDWTJyOWpn?=
 =?utf-8?B?Vm8yM1ZqYjljcTd2Y2IvcnJjUTJWNmtsNlAyTzNtMEpVK21UdTNUdjhtOUx6?=
 =?utf-8?B?TGw3R1pZQVU5enBKb25xelRENDZicm5lZDd2ZUI0ZjNFOW1MUWF2SGNBTG1G?=
 =?utf-8?B?VEI3T1JEVmZsazlLeE1mZDEvK2lVbk05V3pOb3dtbDFQNktjb29McjR0S1RV?=
 =?utf-8?B?OCtCWmZEY0w5MitUNXVyRFdOaC9UZWdKMEY3QXNrS1c3QTlvMWZvdXhHL0lF?=
 =?utf-8?B?dkFlWS9IaE1RTEpyUVc2aU01QkFCSVlkKzBSZnBNSEx1Y3F6RW5JR0RKSlJT?=
 =?utf-8?B?UWxvL2p5elhCdHBGUjFsaWR0Q3BRQnlKUkJEZklhZmlvaktWZFdjVlpSS0cy?=
 =?utf-8?B?TWJQMXR5a3Joc1NHSTM0MTAxdWFXZ0xrUmJlakdiYTRIYzNPUmtmVlJidzVR?=
 =?utf-8?B?VWZhVDQ0TWx3eU9NS3dVNWRJWHU0YWJmT1ViTHVDWWFlbnlzR0cwZktqK0p5?=
 =?utf-8?B?a1NGbzE5Q0VrOW5PTUFLdjlhbmZIbjhtU3YxWEdjWWFiU2JFLzQrV2dXZ0Nt?=
 =?utf-8?B?bWFweU5iblBvU0lYM2NiWnJTOVFZb2Qxd1U3dE9vU0JPUUI3VWErM0kvcmdu?=
 =?utf-8?B?RUJGNkNuNGxNWjdweGtKMnJhZGFwR2hDd2l1Vi81c2xPamNUSlhjL0l6SjJO?=
 =?utf-8?B?WllQeThqWFdZWFp2aFFoZmt3K295Z2UvMUlpaEJrMmk3blRpYkhEeTFlUzBC?=
 =?utf-8?B?TkZJWjRtVjhZYUp3RlNqbnNMQWlicFp4NDdhUDZoVE1jcWlIeWxpTVVtK1gy?=
 =?utf-8?B?OXZBWGRZK01RSmNjd2REcFJ1V3loaGhYd0h2eHBIbjlZaFhOaWV1NW9DWDJM?=
 =?utf-8?B?L1d2VXJoZ1dpRmF0Z0lSZm9TeXhCRnMxWEs3K0I3em51L0UxeU85eFNqck9I?=
 =?utf-8?B?Vzl1SU9GQzFRZExLbzdQb2NxclZDOHU2cDFRQlk5RGQzUHdFYzVLd042WmJj?=
 =?utf-8?B?bmp0NjBxeWNDa0U5OUxWaUt1ZHg3WHowWHVpZEEwK2pZQktleHhIR2NGdXBO?=
 =?utf-8?B?T1k3dUlYaERteURWYm43RXVZLzFaL2xTWXZUaW1wOEdYL2VkUWV1MnRWdXh1?=
 =?utf-8?B?OUhqRDM5QzRVVGo0WUdaREFDbFQySE9zV1BhYk5MaXVNbUprS1llRnQrUUNx?=
 =?utf-8?B?VVYxTTZDREhoV1JzMzQ2bjhra0RsN0YrcFMxN1JtNDF5MUFrekRYVSs2QU8z?=
 =?utf-8?B?UW04Wi9zN3dpMHhjakZOazB2aEhWeUlqMzh6SW1JTURWNHhWS21xbitFVzNQ?=
 =?utf-8?B?c1ZnMmRlZThSWmw2cnM5bTE4bU9jTm1KYlZlalJ4d25sdC9EV1B1L1kvSHZ2?=
 =?utf-8?B?NWlpZlBvSnY1cHpxblVwQXc0eVhKdnpSaHB6cnZrUktteXhFOGlqM3dJZXJM?=
 =?utf-8?B?SzdlMHVVbzcyUWZnRjNNaXVWNWRTb0g2ZXN4c3NUTXZIbXQvR2JCS1lSWkRy?=
 =?utf-8?Q?B5TiGqp3kC36pgwQ6Q3GrJAFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b75436-3f02-4075-8bfc-08dbd90e4eec
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:06:08.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvjU8aBHEFyXGDIOqjIzy/KrQNsku3J0rAWexLZeefWOFTEL11fN8Cni79SjG0mkKIKikqm0yLmzTTybpEoehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 27-Oct-23 10:54 AM, Christoph Hellwig wrote:
> On Wed, Oct 25, 2023 at 12:26:58PM +0530, jeshwank wrote:
>> +	tee_buf->vaddr = dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
>> +	if (!tee_buf->vaddr || !tee_buf->dma) {
>> +		kfree(tee_buf);
>> +		return NULL;
>> +	}
>> +
>> +	tee_buf->size = size;
>> +
>> +	/* Check whether IOMMU is present. If present, translate IOVA
>> +	 * to physical address, else the dma handle is the physical
>> +	 * address.
>> +	 */
>> +	dom = iommu_get_domain_for_dev(psp->dev);
>> +	if (dom)
>> +		tee_buf->paddr = iommu_iova_to_phys(dom, tee_buf->dma);
>> +	else
> No, you can't mix the DMA API and iommu API.  You need to stick to one
> or the other.
Can you please elaborate?
