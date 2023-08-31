Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ECE78F0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbjHaQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245191AbjHaQCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:02:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DE1A3;
        Thu, 31 Aug 2023 09:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAgp6JiYrOOIU+wIllWd1gTePpEzThImO7ZNqeDBjcrLtkoBTLz6v12SJMAT+biQliU/xOw36fTXPMZKrZ7H+KdkVZru0/wEP6m8TO+Cco1hQGgTGbImsO86oVBDCJiUoBkfK5a6I0MySaCaof50mC3f46xvoZlNN8OkAUVd9k61tNxqTCsYbNPRFVfSo4uIzQvEjh6Ff8OdDwn6CSZlCwPXR2TnDNRVbpFEtlQw7c+w2YJf28ClB68vVkS9I6H8OuO3UfWTbB9hg6qlD8jkGTJS8YPrTnhSegaCxF6vvgazsa2as2rSSiwQO9BUb6HJaqXH04LohoP7im39p0psnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM1tHnai0NZ2PPz0cFbjb767oKlzXB7aigi+VrUFbKg=;
 b=RRHEFq0BK7/ow5+LZlG2kepxrUZnz7QbKrHimTN0dJbAdMU3+eZmx1t3ZqSIAAKNzG3MP1uyH9DAQJRJj8Fgha1LIyHSeaS3m4q639X5YhbvM6q71PnVRWnjaJN8UI3SNFFXz+fKFkN042q3FahttUm7EOEVJ9QORvSqCHWqY2OuSkoSQcwI0N9nRbHohMhKkCZ7RDZL7pKvtn3VlMpBdFg2YNRgp0Ue9jP2JUlqLPJHTFt2Q7jVRD4QMNkoG/9ttIVduwh/ZdCJgjEVD2L5V0yk1yw8GzN9iPYtc5EfLfcQjecrQQ4xtb1sYfTrC1gVbSw01EzOZxdBsxFU+yg4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM1tHnai0NZ2PPz0cFbjb767oKlzXB7aigi+VrUFbKg=;
 b=Q6WmB51Rq6VUS3GNR5rBqzk0qOBWyxACDpCbRwo9g2p8uKEB0RpPCXjdPT2tOaPouZrzAkaMnv6caOuY/CYrOxBlfRbsDry/pWYk7tYqyLjjEgjVVMc1P0sZuE/5Xv+hqlIl1RDTOgsZco8/WDx1Tro9uDymLhr1O2aWIZ6aHnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 16:02:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 16:02:09 +0000
Message-ID: <c9857f6d-f8f6-4fe9-adcc-8c0cbcfda42a@amd.com>
Date:   Thu, 31 Aug 2023 11:02:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Fixes for dynamic boost control for 6.6
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     thomas.lendacky@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230829150759.156126-1-mario.limonciello@amd.com>
 <ZPBXL0OVXMpp/BUb@gondor.apana.org.au>
 <2e7637b9-0f84-41e3-bc6e-d22a74b53c74@amd.com>
 <ZPB/4FAL4DKrS9vw@gondor.apana.org.au>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZPB/4FAL4DKrS9vw@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e855fb8-e3ae-4372-5501-08dbaa3ba172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUI9aQ+/C/hdp7+FNw9GWWBB1OJvraXMQn56QMbKfcBH9bsh+G88nACfavbo0oAaEZKda3wFj3aA8oagcJh/zRzaD5ytfOZ65iKmNQZW92WKEdqcf6Oc5zNXbVnHKDrVTjMbEt01aeG81iVPNrtIA+Q8xgtQ1TuPWtKjEsp/PnL3LjuM3Zvqs8QuRenxHJY4q6qzsrA+6/V+NGlG3qsq5d5ukuC/DPKX0VBFqQcesKiwAVeWWdqVCLBvWH/2ZyYmwkUzjG/CI5iHAJ05VofwTLQw04Y0WXBDqJ5OrWxEBvZ2O6QpKiaAq8wb9pCfBeW0t12J2w1azWT65jotBdfaMrQ8Pzz9Tpa75PsA9kLB1Jq+N+TTxgDoi5ohNIQPaVy2AAY9fgzL5FYhLKKmiGctS+4MjrKikeiJ9ZektI8YknYI2z1QdIo52X7zU+h9hG/RvXOUJgBFXAFXIzU1wnD9HMrawFCH7vYxEWOkopDJflPEKWYvUBLdtDln72dSjUIvcfhYZ0zs15h7keMd+sF5SVW/xjNCmt/Y1a5cYdWa7lMku2qOEJUH571BAel87N202imI6enlLQPxruNCpUCyuJ8UDLSeMHVgNaUuKYFjbMJrRkBsvPOQi20yJ5+og8/8apRZDEZBxh0a16AX2VsFHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199024)(1800799009)(186009)(6486002)(6506007)(6512007)(53546011)(478600001)(2906002)(2616005)(26005)(4744005)(316002)(44832011)(6916009)(41300700001)(66556008)(66476007)(5660300002)(8676002)(4326008)(8936002)(36756003)(31696002)(86362001)(38100700002)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2s2QjlxWW9OcmZPVDViOC9wYVNTNkFTeVVyaU16dDhtdEEvZmJTeGhjcVhn?=
 =?utf-8?B?U0l4UjZDRzIrNlJ3OW1rbWk0OFBhZmFibE9jc3NMTjhJYkNTaUJKUWVyNGoy?=
 =?utf-8?B?U3hhZUdqdU1PcFpsNEZDeHUrTGVMaVYxbU12RThsdzlmNHNPdmxFYVFwK1VI?=
 =?utf-8?B?d2MwUndMREREOFgxejBicHpXTGloVHlhNmY0K0NzakdBZ2h5c1U2OHArRlFi?=
 =?utf-8?B?YjY5RmxpZzNGc2NTTytyR0lwZ1ZzNzJqSXpQb3N3d1ZMYzNxblBqdnVmMEdU?=
 =?utf-8?B?Q096UG1oVEFTeUF0ZnpBNEZRei9ycEEvQjZta3hweXJhaklYTHNONFB5S3ds?=
 =?utf-8?B?TDQ0cEppbWhLaTA1T21NdVlmR29hT0Vick85ZUtZSlFZMThucGpCL0dQazVy?=
 =?utf-8?B?S3R5WWM3YjE4aWZCM3YxbUE1eUpxaTdNZ21yTGNWUWUzemF4MVJpb2Zvb0Vz?=
 =?utf-8?B?UStyZ2JNSU9naWQwNlJZNDlUZHdtTGp5UUZNd0lSZkUrQVAwc2k2cmpubkJV?=
 =?utf-8?B?QlNOa1ozNDloYkJORjJsb20zd0lzaFZHZk4waVkvM3JWWUxZYmhTdGJuc2J2?=
 =?utf-8?B?WHp6N2hCQS9rVHFZYXJFcngxUnQyMnZQUS9SZGNkcGtkTTFOdy93U0liSUs4?=
 =?utf-8?B?RUpSVE9JN3VGZWFacnpSb0d3VGpDWURVeENMc1BnNEpMOUtkbitVUG0vWWtF?=
 =?utf-8?B?RWVPbWt5d2hORlpzNzk0TzdhR1ZHT0ZvL0p5cDhTRElzNHoyQjYwSUJXOFd4?=
 =?utf-8?B?b2NRSVhDZ0JMcXhQOFJXbk5yZ0lKU1BmLzVjTEcvOElINTdpQjZIRmpDQ3Iy?=
 =?utf-8?B?U0MvUGN6bHFjNzJXUWEySWFjQVRqajJGQ1ZRQktJNWYvQ0FMNjJ4TjJNWlRw?=
 =?utf-8?B?SC9ZZktZMGlyeUdjQTFMMW9lWnRrQnBDTVIwOXA4ejJMc29EYWg4Z0VUT2VB?=
 =?utf-8?B?M1hHVUtpM1dRUDBvMDcyVXFIUVk3dTluMUY4cXBzdGlDUFMraDUzOU56aG9x?=
 =?utf-8?B?UzBmSEdqVDZWeWZIbGJ1dXNFaktRU1ZxeTBTMHF1K0Jwd1VmMTVpRy9YdFpV?=
 =?utf-8?B?d25Ec3MwS2dCV3IxSU0rTW54dkdMdWFyR2hqY2tuV3c0TVY5cGFPdFdtcE9N?=
 =?utf-8?B?S3dWSFVQVWVrYSt0VlZrM2VjVU9aeGJFQVZGVmRheHF3RGkvUXFRSEtEZzRp?=
 =?utf-8?B?V0luSDBrN3FyeGd3bWhSNzlzdTdTMGRWeS9XUGczRTk3Nzh6TVpsUjJMVzAr?=
 =?utf-8?B?TGdyWDNWVkJQYncvSGRCeWVieGJHNS93TmgzRXhWSmpXYzAyYWI2b2lkRkVT?=
 =?utf-8?B?UlVRMUNSdXBpU3pWZ0Uya0JjdzVlNm5lS1Zyck9YRTFSMGU2MHBRaFlmVk0r?=
 =?utf-8?B?Y01nN0krOWNZVGNpMUNYaUNkNHhOTisvd0pzREJHdGZMRmxVRVE5WDNMRUlw?=
 =?utf-8?B?WG1nNEpNSnArdXVrQUh0Ty9CMUxTbnVHaHd4ZGNmYXFMVnMvSzlaN3Vldm9V?=
 =?utf-8?B?L3BtMUZYN284NTBycEZjeS9KUklNek0yZG8vTnk2ZkxmbVMwNFRSd1VlbFJN?=
 =?utf-8?B?WlhoWnVuSTBIRmZwdVhJR29DK2p6ZUlabTR4UXpUbVdLeDJPS2RxVHRxNER1?=
 =?utf-8?B?dzhIK1JYb0tQaFVTbFBvWGVMSDBsRkY5UGJDenhBK093c2k2MFA5aWgwdDFp?=
 =?utf-8?B?S2gzQ2p6cmZQL2N6QnlmQllabUpoYWY3RUlJRkJIczR5SU1mL0xyQndoUWx5?=
 =?utf-8?B?dXc2bjZSb1Z0N0hoSU5qS0F0RUlKN21wRnBrV1VhNVU2RDRCTjMwT0VTT1B5?=
 =?utf-8?B?V2xxMXNNYk5iUGxxZTBlRjJ1TlNZaDRHOXlnVjJWdWZCenpPcWt4MERzMjVY?=
 =?utf-8?B?aGJXQzB0cnJTNmtjUng1dzQ3Uys5dUJCajhRUjBZcmpueW44RmMyZytqc3g1?=
 =?utf-8?B?dDd3Q1FGL2F2QWlUNXZtdWFMbE5wclgvUWpHOC9QNW12Q2ZwcWlXK2x0eE5q?=
 =?utf-8?B?OCtSa20zU1QwamREL1IxdjdBQ1ZoVFcycUJIaWY2OW9kMG9iMCtOcEs4dGF5?=
 =?utf-8?B?by92RG43OUEySmZzcFkwbWdqOU5vTG5oOXZCT2xPK1YxdDQzYklQUkd3a2xp?=
 =?utf-8?Q?FbY6lg1GHR7P/geTz6ilapih0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e855fb8-e3ae-4372-5501-08dbaa3ba172
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 16:02:09.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNMqsi4Ufew9Qw1ogaozY4I5GHp9W4NGhjXqlc19oCFFSB+7BN4H7fC9VFuCYIfZWOblVCCBRX3I+B3AMIt9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2023 06:56, Herbert Xu wrote:
> On Thu, Aug 31, 2023 at 06:27:59AM -0500, Mario Limonciello wrote:
>>
>> So some boots you see the character device and can interact with it, others
>> you can't.  If you start with 'ccp' loaded and it working, then
>> unload/reload it might not come back.
> 
> Is it just the new functionality that's broken or does it cause
> existing functionality to fail as well?
> 
> Thanks,

Fortunately it's non-fatal for any other functionality in the driver.
