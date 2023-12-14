Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9403681323F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573297AbjLNNyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573115AbjLNNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:54:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C18A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:54:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/9GLpJovii9eN4fynLAmbBol7fR3khdgQSvnT/KlI8JCtm3kHcUfxVi7joFdhNsAdgD5Dnwsdqly++uDOeUNCl7L8dh6PXtdP1W88isANYNDkc87wFRGWGFkSE8oPqcaqasBkNSkl6XKjCGsndxWc523zQWeKIDgdNVuagqLlU81HDEuIiTfmSLcWiCvuUjEL5kgCYZ3e/yDDhUGSQq6Ii7mvseZYTp1x4h3aqmBKhIGpX9hnbbnw707Xxr74uPpgSOXLJx2LzWtoBl43euNRZpK4G8Lrmc8rIhYbRGfV6qhkcPIDOhFgRn87m/WtMyUJ93CArwcRUpYlx58976Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3UkmMBXkbFllY+BStH5X7wm26oKapvbVTKUD3kfxzw=;
 b=MsrICBm67rttqAYIUnDfQGMBWJH0w9lOTm1YROCbdRxPLA/znXyfqczOk/YTFsMEfxfTvcc8YknrYS4H42PtZ356aYDVBzo3yansk9WoyFfx0v1mBStVAn/VI7xrWeyJaFh9bQ97qT9w5CKXSz05nO9isqaZqJz8HsySXgcx/L6uLF/Qbb4Gq333lBurrkRfh7G4XIwOZvtNA8fpGQioH4Caqgp8SEV0J1HgW4zw0lqc8SVf/U7095GtjNRzaWCpNUf9PxPG/HBLfRTYBmw42eHQrVrEeQcz0FFtPxxwmLmjhr7g8EMTkktc+YYSEvJpD9T9B+RdkvEEhDvGsRu5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3UkmMBXkbFllY+BStH5X7wm26oKapvbVTKUD3kfxzw=;
 b=H9/kTZaYIoztxtZEsilZyP5lobJ/CtwdPgqwsiREz0HydzTHcL5rNQ2e5IaEV0r+gCkbYz8Pdos6XwIqv9/ilpifv0zNDsr0Nc/9SO0jBnUhpqA1/uD6FUR9k0C/30vx03nmO0MLqJFOha/reKxdbaNU4/sO8UPjwqrOKH6swgW6lNj8KSNZOrbQsm6rPBXdzuWnj4mxOTtTRJsFGD6WPaNEHoJDoccXLqEB0rMtukoEHF7V8xi4jyUIIa7b0Duth+W8ezM0n9Q7FRn4+ayzFrqzEX+OzhSAHbfFGpOCwrnv3QfcMK7gdtQL8pt/kkBeDahk7jTZJTCL6kbBavAoXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 13:54:51 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:54:51 +0000
Message-ID: <30f26111-2b17-6ef2-6c58-4b16c890ef87@nvidia.com>
Date:   Thu, 14 Dec 2023 15:54:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-2-dwagner@suse.de>
 <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
 <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
 <20231213153833.GC7301@lst.de>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231213153833.GC7301@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd035e1-da3f-45fb-dd7b-08dbfcac3e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VnwOwgLaSCLJYpSRyvazTq37tFshc8KPJaIadn2L1EV1DTtl+pat0PP2W2xFreji3IrE0TMs66T+LOSBXxc/MJs8KsuicuOV8q9D/W+mTPhz+QpbkKJDo+Fd4mtZlQd2ayQ2cpfpGa7/E81UTISsL5DytOVn24TBqsPSiITiKSw0NxuJyTx80hBijfY0JrRE/ZfmpcrPCTD8+qgs3VUvWEDa9Y3IVeQE0d9QoSOP7wPk7ZJGnmP5l0uNI2lRtczJbJRjhnPQnKnu5ISB9WrKtYkEWWZibvb19J6VBfCBYOrZoM9Zv5QEnYOVmODAMTgG+JboGXxoF4ihj4yuWEmYWqd/PaSvedZwi5ppDFodwpSa3ZbnurOu3bsqlJRMHjF0IeIzOcMW3cTM8QLeupbJN+/L8Ov1tuQ1BGaaX/sIpVTaAZcJXFdEOFht6s6sGjiAoahB5liZ/BisA6scl1wNneuaDmkcREHovsZkGMCoqnYxaeDhW13H44DcJDe94krFb42MvcPt8tN7IqGjJg2Kg7q/mcMCg9SxI3PeYDtg+MVxRSWTn/T/MRaI03L/ZX3AonAqtdvQtaAIWZZYpUb+cGc4NuVAyMpIcSNWhlTj3v08nGNV+2Adzf3aWYi7G7SQCqKvMjJ0T+Yym2a1ChY9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(26005)(4744005)(2616005)(478600001)(6486002)(66556008)(66476007)(54906003)(66946007)(316002)(110136005)(31696002)(6666004)(53546011)(86362001)(41300700001)(31686004)(38100700002)(4326008)(8676002)(8936002)(5660300002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW8vNUlveW1DeTcyY2JsR1pUWVBWWjNRd3BuOHlhMFdJajlpR3F4QjNBK1BT?=
 =?utf-8?B?WDNFMnI2clV4VmNOY2VqWkFVdGpBS3BrLzlCWFBHWmlNdmk2aURWYWJiWFhv?=
 =?utf-8?B?QzZMR0kwOVE5YnJhYzR4a01sLzA0NjBna2piTXRRZjA4OW1LZnlXcWEwK0w4?=
 =?utf-8?B?OW82WXR5Zk1XcG8yM0pTSlpESDJid2FGd1M4R1JjWGIrVUJva0N1bDh3dmhF?=
 =?utf-8?B?SFZ3QXpHVTdoY1hwS0tRVmk1alVNMzdVd2hXUGYzZ3FVendFUmN0U0hxTlJh?=
 =?utf-8?B?N0NFaFcxb1JyMGJVdGlRRFdSSE83cDZldllDVDd4amRock9qWVBLYnQvdWJE?=
 =?utf-8?B?S3F6NHRSTUNBV0U0ME5aQUF6M1lwWFdlZ2FNOXliNWhNcFl3WU40a0xEOVBj?=
 =?utf-8?B?c2xhVDFxeElDZGlubE1IMzNoTEU2ZFQ2YTA0My9zZHN6bDVEUnc3cnN1cjAy?=
 =?utf-8?B?dFdQMEhJd1gyVS9scWJ5a0oyd0tkYjVlam1jeVRueW9pdjFqank0QUlscVND?=
 =?utf-8?B?UFdEb0dxODNmZzJDTnNpd29oWkJCU0VhckhEY0UwNUgyNnl5ckZ6dUVyN0tv?=
 =?utf-8?B?aFVDMkdtZkdyV0FLd1JQTmJQQVMvZk1RYnVCY1BjeXV2UG1TRzdNS0Rsa0U3?=
 =?utf-8?B?dmd0cXUxMVpGYWlHYUpaOGNoM0dTd0s2M3cxYUlwR0ExK0tIVFdwY3V4SXgx?=
 =?utf-8?B?RFZDRW9JODZSaGpDNjRCUzhVS1YvQlVjQVVKeEhpQitwdDA2YjNBYVNNSHg2?=
 =?utf-8?B?cXVJSmlFOUlrMVFqeVpRODBvUkRxNmFTVHd4OWRjbTR6UkNIdE9HcGx3Nlpx?=
 =?utf-8?B?M1dYV3hKcXJQZFNNb3p5RGZjYThrVGc2eGN2a0xoNzh3YkFBSWx5eUVBUWZj?=
 =?utf-8?B?cVhxRTJ1YmxjR0gzK1ErY2Z5VjlodVZZc1VDNEJXVVNCWUU1L0ttYnkzSE5w?=
 =?utf-8?B?SkpvcWVwa3N3c3ovQnpUcUhTWWI3M25DRlRjQzRLelE2Ny9ITVZxSXpuOXo0?=
 =?utf-8?B?YXBWTXovaTFsSlN6RjRrd2lwNVp3MVlSZ2xUdmlRQnd3RHNXSXd0L0NEZC9y?=
 =?utf-8?B?NnZMcGNpZXpvWTV1V0J5M3FHNjhudURuYythcXVpMENsWG5EN1Mzd1NwNjlL?=
 =?utf-8?B?bTExNDhFRUtqYWNmZjhFcENjMGE2emtKakU5dUhaNGZyQnpJd1NHSWEwTnBY?=
 =?utf-8?B?Snc0ai9xeDBMc00wVXBDUWIwdTNYWUhCanR4SkVidkdEdWlzTmlJYVhIZ2Q1?=
 =?utf-8?B?OXUzZkkzZ21CanZ1VzREZVc4NUdPK3VKaCtoNW9GejFXL2UrNWpta3c3RjRZ?=
 =?utf-8?B?K2NmclJvMUNiYkxEdXZZZHVQVHJ4YU1hc21EUnB2SURFVGppejQ5c1cvNS9P?=
 =?utf-8?B?RW9rc1JvRUtHVlkvMlUyL1NFbklsaGIySnc4Z2tMWWNPcktuNk1BNERnN0ZO?=
 =?utf-8?B?MUpOMCswT2g1bS9LeGQvU2YwaHdkMzFzM2pMNFp6UzY0ajV3anFmM2Q3TnFN?=
 =?utf-8?B?dDdxZUtPZDlucjd2bnlTTHF4SFBST1ZURjcrUDJMNC9ZYTVPMnFPakRsemor?=
 =?utf-8?B?RWZ1aC9tc2tJQlNxRGxPaGVXekE2YktwWldkTE1PQ2svaHc5ZVNCQmErcEpm?=
 =?utf-8?B?c3dsNWY3Mmk5dlVFNDRmRzYzSWlBTVdwYkhDMlJSd1UvYjRJL1VxYWlpdWho?=
 =?utf-8?B?Vk5QKzlzMjNXYnU0TFVGU3hPK2wwRTVyZDF4VEZVY1NFNGsyN1daaEVuaTFx?=
 =?utf-8?B?aTVsbnNDTEFRTy93eW9CNnpvRkRPUmp5RHV5V29qMEpoOXVRUkpqaWc3c1kz?=
 =?utf-8?B?OFBWMnRVS3FHdW5XcnJqeDVPRnpuVTlkMlpNdDZUOEx4dkloT2JGK2k5dDMx?=
 =?utf-8?B?NWR0eXpMWDVQTXdlYVdrMlYwa3dvMTFKb0paQ1hkSHE2TXNtak44RXdNM3Mz?=
 =?utf-8?B?bWNMcU52blVtM2k2cU1yN2NlaHNvdWJiSVQzWll3NnRlN3psMkV1R0lYeDc3?=
 =?utf-8?B?YUFINlNwK3AxT2hobkpGYkRkdE9sN0k5a3gra0toRDJDa1pGSmw1cHZpWXFP?=
 =?utf-8?B?MldHRStQS1N4N05iYjRnRm5Qc0JOcFViVnI3SmdJTC84eVdVY2krVUJIRkda?=
 =?utf-8?Q?iYQVj1kt2ULhVUz/EPxwPXMC/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd035e1-da3f-45fb-dd7b-08dbfcac3e05
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:54:51.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUcEYWXtbzgCeks1pXlmbiyoRwgugVXgTMRIfDpgyPMApL9EiQgazkh+LXAPdIHxX2DuqjOng+TAM/ARa55yhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2023 17:38, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 03:54:25PM +0100, Daniel Wagner wrote:
>>> I think that the whole PI stuff needs to be taken with a bit more
>>> consideration because if not all paths agree on the pi (as we have
>>> hbas with fabrics) we can't just override or do a logical or on
>>> the capabilities/attributes.
>>
>> So should the PI variables stay in nvme_ns at this point? Or should I
>> add some checks which avoid an override and warn in this case?
> 
> Didn't we merge the patch from max to require uniform PI setups
> for all controllers that we're using in a multipath setup?  I'll
> check the code after finishing a few more things if no one remembers
> offhand.
> 

Not yet.
I will work on it and send it soon with some another small bug fix I found.
Then we'll need to rebase this series on top.
