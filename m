Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428067C5885
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjJKPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjJKPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:50:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757BB6;
        Wed, 11 Oct 2023 08:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O69YaPBvV60YFCESJLdIL8jxxgGY8OMuVhZVL4KkGW1ijjrNeIUue1b/Kux24VSykYcM5VpoDr9LkdeJjFIKXbomwP0e+SReraVFeHMxASrzxlRZHhgI9WUst3c/Pe/Dc+lqiaHvmuvBlgfdwI+GWuF53I+IAgGVr+gJm+ZCrCBhLbMBwe7Z4EFdtsiYuToJpfyT5H1a9RlJ6JpYzzesxxffA0kPaSvUDVRWVxQGXa1+96AWpMEYu7JhaOrb8zbMyS92uPcJHn28BcytS+64FWdQmoU1zI1C7v53NOiOV/xsnhq3Oda4EVwreYR4wD/xAuzAm1QnibbiC9WEXBD5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ59gngvREtsZTWRR6ZSib2E21HJZqjt/625xefBwss=;
 b=QL3SUqR4usYl85vJtoe+1ZjX2s8chTzaUzT5mzu2yMEzYbt1AtWPrvpT5jmaoDGmuBf8hlwCw7KhUrT9+lUlc0LwKmJ/OXZXHa3bxUSSuXj54x0uZXYDCzymCEGSujvtSWlyMxrRC+OXOgP1RvV0JkmvURdYIsXeHzshQcl1h0KHVDPDd4wRtFRc4d7k+XqOYTMaV9KA3K/EL2ZdiX8c3IMdd1+ec9Uh/1mRlpeZrf3Qp49JPOoKENloP4hWuc+RV6nwM62JggUO4hFOJfNe4MPmON37UXybkia+CxdLyTe3D3BWMqfR572Yhj/cttzv1zt4fzIoW1QrDiytnR5CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ59gngvREtsZTWRR6ZSib2E21HJZqjt/625xefBwss=;
 b=oEyX/aw3cN71ZbraJXaORYabdeUTw8dCYnhMkdMIbgcv1ArrSE2O/CHbLzHlujUVQffWKU8nCISFM6IyoGnkG7UxwQM3yv3Q3P5EOi2y+haYQOPE6qMQhODzNl5MI03RA9xZPD/pSF2IpqKKYTYC5cCOeyIKf1a5ih6ZJaK2maI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 15:50:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 15:50:13 +0000
Message-ID: <3d46425a-15bc-422d-ad92-30bf077aaf4c@amd.com>
Date:   Wed, 11 Oct 2023 10:50:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ccp - Dump SEV command buffer registers on SEV
 command error
Content-Language: en-US
To:     John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        herbert@gondor.apana.org.au
References: <20231010204432.899126-1-john.allen@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231010204432.899126-1-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:8:56::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: c526a0b1-e767-4d67-b073-08dbca71c1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nLpSaiQvf+UO38Z3MPX+1XsD1yIj4vmKHLdIC8jgqD2ucn6JNdAv5iyzCDeyAJgNdIN0BkObvYZ0bTWjRNH0E9y/kAGXbsvUuHxAnfPcyqWN0fP/bvCtbXgyYkIF1//0l/wjo8Vnlv3Ru+x1TKIZamtEokJ/zszEtJIC24/st5vV+2Q2XV7C/gMV+Rl7RnTXz3LGE8NEPHyuQK5qs6HPtM6VQMEJXzqza6UfUgWX2ByhA8rNkRefExj0VG6NMS8fIhU9PJHWe9raALIemavlf0vHveCgv/WBR+N3VkzRFnN9TFkP3hIa7BaxWJrkfnfdfXPDUe/KTg9WmnJ7Y8mmbNH3NzwsXQF6Sy9NjPxeeqoOjTl3zQTuhRQAUfyTDwjw0glA+2a1T1Uncma8Gf52pt+dm+zJkGTq1lwmgR0mja0bTTv4iaB9BXxY8APPcvEO4co3SAg9lOdD27hpK16JcDzdVT4oYQCat7M4zMqUq4vfkKz3sSaxt2ttPZqsTJtict+hSUh+9KzYP0Rm+HMn2E2dKmSjWnCGNBCsr3lRDM+fQehjaPGsoU/cQvU5Vne4kHtg99HwxvWQ/1aCf/onE/7KWYHk3sv2dLag+X2TfuMidQuRQxpf18RxyLp9VCqNgXNXZJiGqYItgdCc4A7hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(6512007)(6486002)(478600001)(2616005)(53546011)(66476007)(316002)(66556008)(66946007)(8676002)(8936002)(6506007)(4326008)(44832011)(41300700001)(31686004)(83380400001)(5660300002)(2906002)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGMxZjVMK2trTnhjaXlqeXVLaTdkemdNTXUrZnlzR3REakFITUdKR0ZrbE8r?=
 =?utf-8?B?c3R3dTR2eU10TTNrbThqMWpvTHlGbVVZR3BCQkFaYW8wTTBLQmwzaWI4Vktt?=
 =?utf-8?B?OUpjYm8rRWFwbzl4Wm9jdkRIeUNJYjFIZ1RtM1Z4OFUxTzIwdTd0UlYwbnhL?=
 =?utf-8?B?M3YxdGFvd3Q4QmV3dHEvOXZRMERUVUViTHZMWEthSlVFb1dSckhURTV0bXBL?=
 =?utf-8?B?cTd4WXcvWGYxbmhSRnd5RWxxYi93T0JjemN5M1N5VlY4cGF3STNwSHJPOEFx?=
 =?utf-8?B?WHFhV004a3lob2cyZ2ZCamtkcEZmd093a1dhYVUvcFV3NFdxazJhR3Vpc0NK?=
 =?utf-8?B?U1RvTWdsYmJQU3hnQTVHTXVUeVhXSEtlMmhoc1VmL1lTdlprcUJydjN5U2pS?=
 =?utf-8?B?Yk5sTmdla2E0Z1lpTHp5TEVySGxjVXlna2NRZXR5Qm9zbFZ1QUlvVVhzLzRB?=
 =?utf-8?B?SzZHUFZWWHMrWXpWcFY2ZWVOS01JbjRVODcyZU1iSTUrUmhvbzZuS3BMejZm?=
 =?utf-8?B?SGRia0xoOTg4ZC80UmVyb0VqR21EM3oyMHQ0VE5VdFRhd3FORmhkUzQ5UnMw?=
 =?utf-8?B?OFhJdjQ3YmFLbXhxdWRpa01QL1dnTGdtc3g2dmgzMmdMVW54WFJBalVmYXlS?=
 =?utf-8?B?c0xxVGcvM09UNjQ4S3ZldSt6ZXQrQjNiSjJyU2tTUWVZRXJNM3o2TzYzV3U5?=
 =?utf-8?B?Uk5qR3Uvd0dCMS9yK2FzdFpIK1pSOTNmaGp3MEk3eGlpakNoZk5wWWNlVkEv?=
 =?utf-8?B?SlNPTnFBc1NnbzR1c1B0SmRkTlpIRDUyM2pTTUh0VXlJcG92Rm5pSzRCejhR?=
 =?utf-8?B?cFM2ZnhDYjVrK3oyZXdxOWJJS0ZRRU8zMFpwTDdKeFUyNitldEdyVENrVTBY?=
 =?utf-8?B?NVJYOEgrcE4wQmlLSUQ4eVhvS0g3Wm01S21DVFFSSExGU0N0MzA5bnBKQUtF?=
 =?utf-8?B?ZFdudFloODl1VkYrTFhMRmxDWk5LM2VZUUdZaWtuV0g0dVVPYlJWZ3JORGJl?=
 =?utf-8?B?NUd3RTNXUHBDaXUzdHN4U3ppUjd1UzhDcm5MU29XWkNtZzlPditXZUFQRGwx?=
 =?utf-8?B?WE5UajFBZnZacGw0MFRMUjFGdXAvYUFCcFhLL0RtYk5iT1ZIaTFxL0VBZUF3?=
 =?utf-8?B?cTVKS0wzQVVxVXVEOXZoeS9NbSs2Y2EweGNCMVFRWGtrZE9UdE1vT0ZBM2pW?=
 =?utf-8?B?d3JQeTdMUWMydXk1ckNXaHI0Tkg0OXFBK0lTUENCWkVSNDJEMDVnMjVnTkFz?=
 =?utf-8?B?K1lGM1hlcng1bHoxWDAyaStZTDNsTmZzaHJqOG5WMCs4SHE0dnNpb1k4cGY2?=
 =?utf-8?B?dElhNE9jSkR1Y3d0SmZ4ajl5K0tzL21QOElqa1FaZ2VkS2NBUXhEOXhwaEgx?=
 =?utf-8?B?aW9iWmo0L1dxRVFjd0JTbGxYZGFHWjltM2JHQk9oZGRyTFZEL0pUSk1PL0FR?=
 =?utf-8?B?czNaL21iZmU5Vm1ya1pMZ1RUa3F0STlRaTJ0WVdqYi9WOHJ4SEpEeE55enZs?=
 =?utf-8?B?QWF1T0dsdkhlV0JQSmU3cmM2VExxaDl6Rk9WcGlMdzR0K3hXTFJYbTVJNmpj?=
 =?utf-8?B?QXlGcjdEbFZUNnVVR2lGVy84YnM0Z1lPZjVnVDF2czNGbUdLckVtRmVsZjJG?=
 =?utf-8?B?TXhDck4zSHZVd2NvelJwT3ROQ2pBb1RBdUgwWUsrMlNieXlxbmtWVDJEckts?=
 =?utf-8?B?STRObkI2M0dvNk4xK2wrVmJiV21QR0EzMjZCNW4rWGhIeHA5ZWc3L0hkK05O?=
 =?utf-8?B?VXJsa3lSM0xmSTU0NFJmM1BiYTQ5YkNvWDgxSWRxN0k0TXIxVjQxUFNJUEt6?=
 =?utf-8?B?M3V3REE5a2JtMnp4SUhIM3JJRm42UUxSQ1FvazkzdkpNQk5rc1U3enZXT0xP?=
 =?utf-8?B?akxnSk5LUGhNTFI1K0JkTjM3QkY2eXU5aWMzNW83cjRiVWF5enJtc0NNei9B?=
 =?utf-8?B?aEhwb1cwdmM2RHdFYVdJbHhDeVdZUlBlNkpjSkVQUVorN0xoYy8xLzhtOWNi?=
 =?utf-8?B?N0NRZi9CbUYyR0sybU9ZR081VDhTSFBWcll1enduMVRyRjhSZ05EaG5HSU0w?=
 =?utf-8?B?QmM0U05uWVZ5Z0VOSW5wVUoxak4zS0FFNkdueVVjaERNRkNCNDdJZ2FqTVB4?=
 =?utf-8?Q?iYSWPBDb77vACMG0pv03QSf/F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c526a0b1-e767-4d67-b073-08dbca71c1ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:50:13.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlfiHBp0Zq9a7Dwu4Yet+vR2f/d9CiQMUjzbmNZm3/3RpkCuF8evSaZ7dMyZTeON79NehZBI4UGQG0KaP6ZKoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 15:44, John Allen wrote:
> PSP firmware may report additional error information in the SEV command
> buffer registers in situations where an error occurs as the result of an
> SEV command.  In this case, check if the command buffer registers have been
> modified and if so, dump the contents.
> 
> Signed-off-by: John Allen <john.allen@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

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

