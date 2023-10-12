Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400467C7551
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379630AbjJLR6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:58:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4CB8;
        Thu, 12 Oct 2023 10:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2WhkgbQHJJe0lFkJIuBpLSx81IbPk17xOhhdJ1RVtU3njyfjbv6K39s47I6q0oh6qdwF0fK7Nvo44n/LHz9vJ5nYZXQtu0qREpMvHV9y8XSoL+K0e39jsHCTv+uSV84+PJMHO+3k0YjWo0wmAhYbShXDpNKBIKFwgFjgMVgrGX14IWc1izLXnZXdxxNRgKw4766vni7gUwdN13U/JsqiLP9uTvnJk0gzU4MgkIb3vsjkOsVNLHQC6BI5vk56d7t37U4O8Bw4rcbXjxsQcHOgeXTqQnnIIfgtebZK7Q5i5ymFJDm91kLrQ/X5h2BFWELkoV5uYUGppUHoHXL6sdNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc6Lg/IEfJo06+1YHtOBM5XIAkHqJRSaFbFyGtcixjA=;
 b=OEfGbNf80xDp1jpAl58bE9pAhpd02myXevUt9B8sRKIKos7kaE9E1OGOG8wYQJ4As6vuoWYa3jEXbRieGcvFvgWXTUP6mpHXakTkD0w4OCNa8dT1N9q6a38UBgfc0iZGm4bxIB6dq+lctFVx85k2KLs12t71OKCAGziaTZYBAyQTsyNAoQwsYGMyPP6hfLc/fXCOE1d7liCsr4AB5x2kjOvV78CeHB4NWWBrllXb4TDJ0nve6xw1SoU0jl3Pvg1Pd+lySuzchHmb6jgshnv/6lWsVhh3ZGCTqZfcwGXdf/1oogmuoZ09+Kw7IyJ0MNmLuA+uFG4ozcbWiSINAB4DtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc6Lg/IEfJo06+1YHtOBM5XIAkHqJRSaFbFyGtcixjA=;
 b=pcB/G91rfjki3W3qK/XuRbSerE8fO4TkSiaCWWLjnWhuDzPpUnNjtKvgd4BZuOc4TO9fYkGH/yU/mwCuJ8Feskoe6MWryQyTsyp5HEIUHheV1uEJBnsJF7Dh6dcxueVYSfpVE4S7pFhW5m481VvA6PtSsxz4/JCzeWuMBwGMdNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 17:58:22 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 17:58:20 +0000
Message-ID: <030bc89b-837c-4c4a-9ef9-8b7e461505a4@amd.com>
Date:   Thu, 12 Oct 2023 12:58:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ccp - Dump SEV command buffer registers on SEV
 command error
Content-Language: en-US
To:     John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        herbert@gondor.apana.org.au
References: <20231010204432.899126-1-john.allen@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231010204432.899126-1-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c294df5-e1c9-4901-27c2-08dbcb4cd209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3TZP8ZlFD03KpkrHu4hnAXDBIxqOBZtUa6mJGPfH2yrxHUJjZr1KtNEjNE4aZ5RuYdGf1/uMVHbwH1IrJeyBsxEKho2HuYSfEpCOdZPCZAmOj6fqbjIB4j/PdxkSbvhLN5uvl2HhiQzlIs0t7bL08gTYRVzv9fkpBJdmF2YrRHRuM1Tot1CGNFhzImlsgINwqt6xyweaQUbJlUDQu6MEB5Bpon+ut5PXK6Qls/7NObJvQpPY/p929azfmByztOqFYS/yVIwpyL+3x1KZ+6PisUet5524ytymvRBGZmRFqh9PP2fJVedWlKSC4FAxpbxdt/sx1dc7r2LAOt+mqP5sxTDGr55gkjZRJmDdDRxML0doyMwOBHX3nSCPRKAftzjt5hB2/JfpviN+VI6+YjSBNWR0gzTHKUSRChatXWqgsJIP3AOIJwqFOwwuTx4QJQfq17fztnxKdsVE6GROQ8ZaK8JQlDuIsEYxW6O4keKO59Yk6fPBXh6OiXMvfrHqXcR+ackOEixoTTHCfp3iYQHA3RpRO1n7uTBdxKm31saLh4KD7WcdCq0LlqjlVKiIESY5c5I5nDA7JJNJZ0jjwCWhXEhCN1BY4gP6hnZ+t25GHItZketPNwCc4xIbWp+0c/vc4CWApPNlQhCaCdc6u0i+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(53546011)(6506007)(41300700001)(2906002)(66556008)(66476007)(66946007)(4326008)(31686004)(26005)(478600001)(5660300002)(6512007)(6486002)(83380400001)(316002)(36756003)(38100700002)(8676002)(8936002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEhyYWx3MXVMcFdZTmpzMnFCSzQ2OHphWEZlNlR5RnlESWZ2V0cxc21iWUg3?=
 =?utf-8?B?WE1GM0hLcXUwQjJzb0VHd24vdkRIV0NsdzRNZHFpNEVZN3VjTkx1TGR3WWZD?=
 =?utf-8?B?TkJETy9oUVlpRitadC9xcUlwUkp1c0pBWGlrdTRxMkxwYitnenJ2UGtUaHdU?=
 =?utf-8?B?bG9NUFFhM2xQWW9kYXpTWTVqbU9uc2hWOVpqR2VTRUlsSUtpci9UWjloN3hN?=
 =?utf-8?B?N1A0SFVudCtzem5Ub2E2M1ptQlM1MjZ5WCtFd01yS2hFZzFjMTVZTzhnUnJ5?=
 =?utf-8?B?VkozeU5Rc0ZKRHhrVS9yS1JibHl4NFgvNjF2ZFhOb1djSWlVTktLRnU5YmJr?=
 =?utf-8?B?b2Z3bE95MFVvak1QMkgwTU9FeURDaEZLUmdFaHRyVmViWnh0djE1LzJKMmtK?=
 =?utf-8?B?RTVWZFdNaVJoRHZVdlNyREJrTXBoWHE4Z2VMNVAzdTgwTU5NN0tDWlhMMmhk?=
 =?utf-8?B?MmltRndZNDFXVkFvOEkrT2F3eGNOUG0wc0Qvb3Q3L0ZVVDlRS2VOVmlaQVdL?=
 =?utf-8?B?RCt6ai93a1lJYUNUSllrL05hYzR1SGx3VXJiUVpBdkJvMlBqSW45OXN6WXFW?=
 =?utf-8?B?bTZHSE5pTStJdXBZUVlrcTN5TllobkF1UWlWb2JhVDNjSXdsSWpjYnFzSjZQ?=
 =?utf-8?B?bGRWNTQ3VElScTR1QXJ1M1IvZmlIb2lUVFRnRTV0dFNCeG5IQ1hyUlVQbTY3?=
 =?utf-8?B?VjM3VUpDRG9qcXhKNE5YaGNHKzZnaVJ5TDQvTFhnNWZXSFdqKy81czhZb0pq?=
 =?utf-8?B?em5Bei9WR0JGMUdoaCtPODFUWE5FUmlxUk5vWUlQYzYzQ3h2UjNrZlV2UDN6?=
 =?utf-8?B?VlAvZ2M3aEJkSmE3aXVReU9DSkNUYjVVYXJmUjlIVFk5UFJyUjZnZVRVNFVU?=
 =?utf-8?B?cUlITzZrM0dDZ3IxM0VuOW4xSzhDZkpXM3VhQ1hMQzg1ZFRxNUpBRjcySVAv?=
 =?utf-8?B?UzB3TXZtNXRsem9KZ1VyS25CMzBzMGMvMHBrRVlIcnVKSE9OUDcvMXF2dktq?=
 =?utf-8?B?MUQ4Uzhaeno5ZURkL2pZS01lUGQ3dUx1UEhFY3ZGNEE5TUt3S3Z1bmYvODU4?=
 =?utf-8?B?ejhEa0JPQ2hlenlONDl0Z0hERnNxdEc4U1hGYXRkaFlzL3g0YWFOeWhubm8z?=
 =?utf-8?B?b255a1pKckRlV210bFhBM2VPc3RJZ1FNMEJXbXBCYnRsOStwbVlDSnUyU1dN?=
 =?utf-8?B?NERON21zY3NYUGVEMmlHeGxvVi9od3JwV1VlSHNtbDErQTZIMWRmdHVET0Zh?=
 =?utf-8?B?UEFzeFFtQ3VmNGNtWUdCUDJzZGRDa0ROSHhzSmZ2c0hOQ09wVUxPcWV1ZmFx?=
 =?utf-8?B?ZGVKUEJPQS9UbWhQRW5QWFJXaGhCT3FDaE5DS0hFQmFTZzYwQ0lSbHNaRVl2?=
 =?utf-8?B?bVY5U0I1aWhWL1hSUWJIYjIxRzBISVZUQ1VtNjBHZ042QnI1eGRmaGhUbkZM?=
 =?utf-8?B?eUZVMlczS1NWVThKeGtaTG9rc2RYRlpQYWd3U2VBWUJZWjNhUXozSFhpOXEx?=
 =?utf-8?B?aEhvVFdRbWlSMDRaVTdGTWNvbnhCSGxtTmpBVVRhVXdyZXQvQWtNcFpUMzgx?=
 =?utf-8?B?ZVdNNGZ0WDlXNmNhaXJtME9BSW5KTHNvNmRxWVA5Q21EN0NObVE3WFVzRHgy?=
 =?utf-8?B?Z0tic0ZYYjVEWHpWV2JhUHZBMkFOTFd3ZXRaL01hWUdoN2JzanJmUHNJVU9p?=
 =?utf-8?B?bm5MZHFUVmFXc0M4WEFGdnlTbllHdnJtRS9oNU5saW9Gbk41b2kwek0xT0tO?=
 =?utf-8?B?TjhFUG0xTGpneEZZV21Qd09mWkJHNGgzc3N2dmZUdUtXSWhkdEU5TjcwYndM?=
 =?utf-8?B?RFZMamJ6QnBrcVVmZk5oQ2gzZVF5SVJlcVdYaDlpbEM0cXhqSXlhaGROTFU4?=
 =?utf-8?B?VW1vZlQxZE11OTNMR0V2cGkzc202REVDQ2ZwMGdIQy84alR3aDR1T0VKbmFm?=
 =?utf-8?B?UENuZUpVc1pwQkk5N2cxVXBTQWJ0NEFYMjR3cTZKSVJhWlU0QlFHblIrSGRX?=
 =?utf-8?B?Sko2V0NYT2lQM0dGY3NuajFTNEE1RU9oa1RtNFFjQVltcy91ZytJenJVZ3ow?=
 =?utf-8?B?VWRPRGZpZ0pvQWVmUVNZY2J1WDBRVzlPUHNMMTR5eFYyNlJob2t0bjFDc1Bz?=
 =?utf-8?Q?e+4EN4m/tyC76XxZFOc7HLyc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c294df5-e1c9-4901-27c2-08dbcb4cd209
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 17:58:20.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkZ1PBo7sx4Z9tepIuh5s0MTid9ihLCAQLr7ffyTQmIjZj2EmJvvsdccQpR3UZtUIBkOeBKWJpAR/gIB1E/OOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 15:44, John Allen wrote:
> PSP firmware may report additional error information in the SEV command
> buffer registers in situations where an error occurs as the result of an
> SEV command.  In this case, check if the command buffer registers have been
> modified and if so, dump the contents.
> 
> Signed-off-by: John Allen <john.allen@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sev-dev.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index f97166fba9d9..fcaccd0b5a65 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -309,6 +309,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>   {
>   	struct psp_device *psp = psp_master;
>   	struct sev_device *sev;
> +	unsigned int cmdbuff_hi, cmdbuff_lo;
>   	unsigned int phys_lsb, phys_msb;
>   	unsigned int reg, ret = 0;
>   	int buf_len;
> @@ -371,6 +372,19 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
>   	if (FIELD_GET(PSP_CMDRESP_STS, reg)) {
>   		dev_dbg(sev->dev, "sev command %#x failed (%#010lx)\n",
>   			cmd, FIELD_GET(PSP_CMDRESP_STS, reg));
> +
> +		/*
> +		 * PSP firmware may report additional error information in the
> +		 * command buffer registers on error. Print contents of command
> +		 * buffer registers if they changed.
> +		 */
> +		cmdbuff_hi = ioread32(sev->io_regs + sev->vdata->cmdbuff_addr_hi_reg);
> +		cmdbuff_lo = ioread32(sev->io_regs + sev->vdata->cmdbuff_addr_lo_reg);
> +		if (cmdbuff_hi != phys_msb || cmdbuff_lo != phys_lsb) {
> +			dev_dbg(sev->dev, "Additional error information reported in cmdbuff:");
> +			dev_dbg(sev->dev, "  cmdbuff hi: %#010x\n", cmdbuff_hi);
> +			dev_dbg(sev->dev, "  cmdbuff lo: %#010x\n", cmdbuff_lo);
> +		}
>   		ret = -EIO;
>   	} else {
>   		ret = sev_write_init_ex_file_if_required(cmd);
