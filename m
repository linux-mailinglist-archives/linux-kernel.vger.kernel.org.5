Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55AC7EC451
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjKOOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKOOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:04:44 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26969123
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:04:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtbAmZF6j5NGEbgZ/Ig5UJ8ljcZjXQ26arHp5YsuGlCtQF7ua+RQbJcKCRSHA+M5UE+ECblYJA+6kJrOEV+b3THd/BlPGIALbs5FJgrYhhTZbFCeT/7FwmKQ1MgAJtnITsERRJTA7VjvnNegwuDtrxfEJG/Z5W43UrmcAG7YApJrHy0nv4mBM2503lk3Gv2p2qp4hapiJ+5Hqo9uH3ec/m8TA59wA0QTygcl3bwuNE7zUZb3XBhOreoEYQSiDu0jWg55jfju/YounCkK1U2OmBLT58AzorPKLe85m7L94a3AR8y0qPKFOB/vQPUncKZYyg4hrZNgOCoeqvt/NmJV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zF9b12wLD7Kl97rznOAloqG7Jh5j4iYFUkI9sTjJ5U=;
 b=JpUEzw4iHvA7JA4HspXqXMx1RQ0TM7uGkFxEYnH0N7uAwrU+Ydp7rYo/0etdhQExH4G5o4s9WY1tVBZHUP23wXZXQPNa9KWsiYli3Nu1bwW5n3jC6cpDTpl0srUphvUg4yanipsDPyI6sa6F5Ba7zqK4+GcgJcMRlW36NRNjCUDlrJ32MAy7VyRbQmZFSRvM73rtXM6zbOnu6azVymiQUX+tiype2pcmsd5HAIiRBEKWTLSp8tJd2S58YTFfFpKINEK0Hkspp8LJS6gF6STNy5M63YtRedeP6EuYiz4x75EM7AK7MrsARzFYc01rPG6ygIU9ANuxBfCdMeZO68gk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zF9b12wLD7Kl97rznOAloqG7Jh5j4iYFUkI9sTjJ5U=;
 b=GTytVpwjx/fQ1COf0gHXcJ668SvzWFvHa7Vz1YL8e0jEDwUGbUIerGwQl0DQDv27h+02lHZYLgdxtloXf3hqKjW7RqZ5xxAiRDcm34RaQFVAqhvSPF4omipDc4oyWNQeqMTRdnT1BrkXyn3HO2Cy+PFnToesMjEaR/X14XGsIZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 14:04:35 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:04:34 +0000
Message-ID: <e80b4ab8-4e17-4a28-8ef9-e86d70e5e2d4@amd.com>
Date:   Wed, 15 Nov 2023 15:04:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: fix quoted string split across lines
Content-Language: en-US
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, robh@kernel.org,
        arnd@arndb.de, ruanjinjie@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, Michal Simek <michal.simek@xilinx.com>
References: <1698430295-2731040-1-git-send-email-radhey.shyam.pandey@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1698430295-2731040-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:510:4::9) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: bea652eb-7ad1-4f01-2d2e-08dbe5e3cc16
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nwcfsxt59lTRwWdKuLcDrPdHzBNv/KCuSrtTxluVHKWJdHdQcmkLDZPVhaXOdyagSHYG+DOROr2ZfA7o4As0f6IRLhn3Hmn4+mhGGDrx5JAdzpVYOqOPz5T+bAL4sZSkj8bumvHsj+NCS+yk9jHF1cjWVr91cFnR8jaGrMUzraAELGdA/5zvef6HWUyrKWUNUO/PwPC6hdFD47cOK9m/mu1Leg4rxa+gefz8j2pzF+rT7mxKJgzjeh0c5BisWhXLt3riVsgPRZZpGIaP/A5RL1kB4cdCLQXUC7aQNDWKGvN4IRflcI5jSTJP3qc6Flp08q54mkl4Tx+YbdZGkEyeBehuJrylkqA0ycOeVFTh05wm2CCVQnxL5kpdFyaFAHsB/+wbkPS9djw7O3axHKFUUsP2ltBTv8tsqY2FhMMg7OLsqNfdfUO+EZ5kZe6X2WnUh2Z1c/mUeVD7k27B+BVWzyquIawQJoIUcTKCqOFJ+/0MndYXcI4v8aH3/7jyZfdCBfmytOf0zYbUNFcln1SmrKo/BakznkdWH6H7sVLwByOAMcIbgRz6khLFc5CuFhUy8aFy5mGf2S2DZ14UU2QVeU2rthWogJJkqRTiWMyp20YqFiK7La+0xPHB3aa56s4nErrqkP3DjAHEXAK+TahkzXsbNiTr4wTpIMDUPCzLP+lxnO+0gn7odrC7+H1TlzU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(83380400001)(558084003)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(31686004)(36756003)(41300700001)(26005)(31696002)(2616005)(6512007)(6506007)(53546011)(478600001)(6486002)(2906002)(44832011)(316002)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhUVWM0TnBtOFkvTnM2S3oyemgzOWlOR0k1L0ZOcnU3RlRnUWtEeVNmaHJq?=
 =?utf-8?B?ZUZoSjdERzlpQWZmRWMwbzVyZnFIQ2ozT3d3aVZjUDNnM0d5bnNJcnFuakpm?=
 =?utf-8?B?djlkTUw3NjFHM3l6cGtWa3FBV2Evcm8wZ2tENVJ5RHZwQ3BxTEE0UzFQOWNn?=
 =?utf-8?B?S1J1bDlWWjBwa2hVa21SQkhYS29pWi9QaHlSL2Exd1hMc1hyU3N4aEtlSDJu?=
 =?utf-8?B?a3M0cEpSNithN0N5L1pkM2hPL2xPSGt0VVVPVGFiUi91eEtEM0RLY0RmQ2N6?=
 =?utf-8?B?NXo1N2tqZWYxQUUrdGUvN1k1VlYxakptWGRIYlRsTi9nNTZPQjREWWNoRXBu?=
 =?utf-8?B?Q2ZaK1N6K2wxNitBQ0RCU3FBRy9IYytDV2FjdGJCVkZEZC9TY0RoMVBoL09W?=
 =?utf-8?B?LzREcU1uTGZpVjJaeWMxRnFVb1M5alVPMU5pZWtpVCtWUnNWNUhxZEZyV2sw?=
 =?utf-8?B?aENqVXVNVkh4VTU3TEQ1Wk1iOE91NTlydzlTN21RMFdHbmE1NDNmLzFQSzdj?=
 =?utf-8?B?RlRoSS9zd1Zqak44YXhqc0VocnFnYkhEUXkzaE0xMXhzVmlXeUFFSGRNcGtN?=
 =?utf-8?B?cHZScXJFY1poQlB1Y3lHWEx5d2tFVit1MmRiRndUckkzdXlRMXRPdldTbXhS?=
 =?utf-8?B?b2JzSnRyYVZKS3d3UE9EYkNscmI2OWIxK3k4UUZ4L3hkSS9NOUV6MVdVTUpW?=
 =?utf-8?B?dC9iR1VYMDViMEs2aXJnM2hrS0tTMW5ISzV2aVlibFZuOTJmM0piOTJuUGh4?=
 =?utf-8?B?RnFhb0tGU2tNL3d4UWdtclRkaFBkTGFlM1NlQlI1U0RHOWxCTEdQM0hvdS9x?=
 =?utf-8?B?d2xlcEdVdktsNDNpZVljSFN4S3ErSElDZXVOZkdFNXd3djhnU3VNa2xUWk1q?=
 =?utf-8?B?WUYrM3cvcXNwSWY3QnJaT29UUU41a2k2WEMrZ1JJZDVCakxmNG9rZTZjRDNa?=
 =?utf-8?B?bnhMdXZ5ekpBa21QeWZTYjd4UGd0R0IrNkpiS0xDdE5Td3YvamF3eTFWZzBE?=
 =?utf-8?B?a0FuWjMxcnJ3b2xaYWM1K3JFdFlBS0lvWlNBdVFRNlY5Um9DZUo4VjFpdG9q?=
 =?utf-8?B?dys1SW1GUTdaYzI4M0JnV1J4RzFLSEpXUkgyRUJOemNibnBQVDV2MzlIMk8z?=
 =?utf-8?B?ajM2UVdveDVWV2lnRDVvOWx4VXkvNnVFUjE5ZkZYQnFDUlI3eGh4UDhPczJV?=
 =?utf-8?B?WVdOVC9Ebll5dkFqWWZlcVc1SmNVZGdtYTJBY0JEZjdjME9xYy96Z1A5MVg4?=
 =?utf-8?B?NEVPUVFUUDFLVDFkNEY0QVd2ZVdWZlI1TVd6TE5OcXViSHdSNllBWXpERkpa?=
 =?utf-8?B?aUdJcGdKSlJ1R05qR3ROb0psbzZsQTNrTVhXZDF5OW1VZmExa1pTejBrK3gz?=
 =?utf-8?B?TytPanlYeWZtK0R2cXRtVGFyZXBCbmE2SVdGZGtyd3FodHp3Y1dReXZUWlhv?=
 =?utf-8?B?QlVrQzRveXpLaGl2NFJlNFNuQjZYaDJFWGFNaEZvMnN6TVAvdnk5WkhQSXN3?=
 =?utf-8?B?RDVJUXB4SG03S2RqUWFpMUJjeTM5ZHVtUjAzMWdvc0NxRFJyV0tmQzZaN2Jz?=
 =?utf-8?B?WUs4SWF3ZEdkUEYyQ0RyOTJvZTU1aU45SW9kMm1EWnNoZ3cwVDZpZUZtOWtR?=
 =?utf-8?B?eStyWjJkNGkzdVliQUtkQ2t5ODhnc0VGb1hZSmh6eGFQckNveC9mWm04T3pM?=
 =?utf-8?B?U2VjSHRReFVJYlFIWFZsZWFNWFBMd3JnQVdmS045czg4YUJNQlg3MnVaM1Y4?=
 =?utf-8?B?U1h5c2RlbnhkRXdpNmkyWDRnSEloU29IbzA3YWNUSWY5L0dySjBQT1Zoc2pp?=
 =?utf-8?B?TGVLY2tKWkRmU2xDSGZEZjFwd1dOSUlVcVFxVnNNNCs4UWhCOVZhZkVMY0FU?=
 =?utf-8?B?WjVGdXNDVGJ0NEdWeVE3TXU3eHRnWjR6U0xMSjZza0hNcnlnMzBSbHJxaVEz?=
 =?utf-8?B?T1ZJeVZwMWNmQStaaC9OTHlPVUZZUEJjM3RVeGIreUpvendSWUZyNWpXVkw0?=
 =?utf-8?B?OUVjUmMyNU9EbWI5WWluc2VxNDJaUy92NWx2YkhTUVN1Y0lqNWpKbWpDVXho?=
 =?utf-8?B?ZjdUSURWbW83aEN3ZzI3RnVydm92UXZxZWhzZE9lM0cwMSsweUdIWTk3MVFX?=
 =?utf-8?Q?RfJrkobTclSgAFsP0kkNf6u0E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea652eb-7ad1-4f01-2d2e-08dbe5e3cc16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:04:34.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSJWD7uKZvvgD5Qbk3zI3cx2zQ+PwkegTiRtZNA+rGtY1i+GEGx7itGljDR46WJr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/23 20:11, Radhey Shyam Pandey wrote:
> From: Michal Simek <michal.simek@xilinx.com>
> 
> Fix checkpatch warning "quoted string split across lines".
> No functional change.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied but with amd.com here.

Thanks,
Michal
