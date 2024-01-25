Return-Path: <linux-kernel+bounces-38237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5F83BCEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41601C28977
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B01CAB5;
	Thu, 25 Jan 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aDyEMSHb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794471CA88
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173752; cv=fail; b=m49EVrfLnT4GZEAEzeoVpIlG1p9RDFAvgMssTjDYSISDdr7y2nsQWe9MMBQOiA/hHKCTSqYGtYL84FH83RLYhwTcFafxQ91ayWBxBFi9URSBomX9yG/EbSB+ePjwLQ98nA1RdFXgsowqbxG00BYAVLEnyUmZ9sFmxI247bCPO5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173752; c=relaxed/simple;
	bh=P66YI8WjnvEneZpRHOQsAc7werIcRJZoaypnoWZ7Iqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVvevSKJnOAqIK++09A/LQCARhJXsuYR1eQ0szvBVFVZbInX4g2+DTCUSZZ7/pERH9AQewceYxy5v+shWxERNz3yGyhXpOp1lls9KuZA0G5uzJn0rXgV6+5tpnb7wX1She0sywaA3uwQF46v9ON1IW2t1H9wfICeXYkFnA1qHW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aDyEMSHb; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtZHpuWPymMonf0EzY4rYU5LMfk+3kySUB1/0qQB788eUkbmEKYTRUS90ChXzvnhNesNIkNXLYtIycwOfF2T9RcAl9cn9i9tylyRcD7dfKfPFHsSBOhRbNCB0GH1XcS2Ady2Vqu8Dzbv6LdBq2F+dYnaVuQbF5blMLeQFZa72G5KgUJxaCbfPojdRw3+69+vkmtUNZn2TIHLgF7olhrZKKBtMKALnKTYa7A/fbZd48LCPzEq6fem7PLnt001KzBgfC2L68AX6qkZfCBSVlLPxctEDTglkqQAdvNEhVpwTm55XXgAOrnPdUZjk9z1xSbuljLc9+m66f5mkIBKJr7hPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uk7eKQHMboF/rFOxcnapYF93Ic/jimEaoGeVbLx/dw=;
 b=irNN3YLXIr7Phtqr+DpnSPPAV8OBw9BS4EmW1XRKdH5iWP0c8n9uN30qRNZObTGMfX5RZUwE5CoC/7UpPxAmw0HCbeT8iQXFIMUd9j4umP3oVv1HCQK8aW7cctkVV8jPXMSw0u5Mb/nNyFYT9PNzgMcH625qSLF3OIG0WKetgYLxHXauVytYuzWAAjaN/UWuRksm7jyKlSjpR1AqRDEK+VqFVom2x/CrOT1VTjAc9rKV/FmfGHfn2YoTQeF8j/Jsy+CoFcrKKPBUe4CKp2e4ZG4NXPYjhe0t90YxjXv7M/eK1dOjLsPIhEtRT0ODafVR1ZjkD/5m22NYBIepSxw31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uk7eKQHMboF/rFOxcnapYF93Ic/jimEaoGeVbLx/dw=;
 b=aDyEMSHbDR0l+Y347bzl8+kF2Qe6Y0iK6bf6Rva9tlZRGInBXPpGMTaqrr7giAj9TqMdVoIrtCiUWg+tCn3+RN8ZzN52/Dlp2KtzpjtuGk77lqzWBq87tbGok1U4pKJq4R/b1LwbDip9dyjXfEsVadXy8kBfzt9EyYCiCC4TbxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:09:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 09:09:08 +0000
Message-ID: <b021c9d0-3e12-4626-844e-7715a13eceb5@amd.com>
Date: Thu, 25 Jan 2024 10:09:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: zynq: Remove clk/zynq.h header
Content-Language: en-US
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Russell King <linux@armlinux.org.uk>,
 "moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>
References: <d7b129c8e3f867c2fda5fb0adbb1983103c5be5e.1704885029.git.michal.simek@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <d7b129c8e3f867c2fda5fb0adbb1983103c5be5e.1704885029.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0071.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::24) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: b8efad5f-d83d-4a8b-b499-08dc1d85499d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c17hwAoa8N6SsrfHbLtgdFS9f7dC6LAvkLMWivSTpU0sKL5i15CWvhMoHCHjslzVYsS+AlIMHT+BwBCPaSpgrctcwu1RRfRKPBemhEjFw54OiCq8hCl3TXud2QW0GDPIw3TZmX1k1w4GRFjHHcHQAMZgCKowKuesMC7F4XratHSoj9NVOgSc/EwyeJMKS6z6JDRzzbXnVPyDjJ4CW2NJpyln+tM5PLCeEOwV/tb4Wqmj/xCzvAI5eiO8nli/9AM+XhIQGHWzUYlw79brDfsy4eNxfJOQM5ubBwcesNZ8ZelBB3NMfd7QtbLyG9gMsq/l91rLb15Ro02NzjvpQ8vVEWSE2wqj5ER/F/bd4gwpmTWZxoD/tdZx9NrqrMzi7+vQBaHJRYR5lBO+4mxLGcdysc1MhVWdeDR/FctdBi0nuVS3RVTUPNHxQBVgM++HdWKvdri9WQ6VqPeXoSe++NhTXBjjcfPUkmvkH0oQMRUuafcIV/hopc3xiVF0a4W61J30mrIwAgEdFQMJb6TaUbV3WNkSJGOsR8wSIYmYtnNWf0HWbVa5WIXbdRpxppNXA0mE4+RXlRtM/JR6qy5JN6lpi9PMYtJod890fnZeLrRE87YA0PScBBwvQ8Xm6mirTxlWSIszMQ3G/aBEYlinVaV++g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(8676002)(66946007)(66556008)(54906003)(5660300002)(4744005)(66476007)(316002)(6666004)(2616005)(8936002)(4326008)(83380400001)(44832011)(2906002)(6512007)(86362001)(6486002)(478600001)(6506007)(53546011)(36756003)(31696002)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUdwc3B4c2ZrYWZmS2FaUWFmQXdtTjlHSHdRU0RXVXR2UVZHMGt2T3I4SURH?=
 =?utf-8?B?T2NTVDN6ZUlQOGhsdWhJM0JuVEs0ZHkwdHh4TEpHcUZGYTBDdUl5aWloNEJU?=
 =?utf-8?B?Zk05L3BPSDFpTW5Wb1VrN1pnVmc3MGJwZnFzQnNaRDZOdllxRzlzNUdGNVRm?=
 =?utf-8?B?U0F2b2R6UWduT2E2bjROQXBPRWlTQmUvcFJ6ODRLemt3R3RMelhTNGV5SFdm?=
 =?utf-8?B?K0g0R0Nld3JzemJlQVp2R005ZlBlT3l0MjNacEU4eFZ4UTJxWE5LM0tyVUl1?=
 =?utf-8?B?a0lBbEFhT0JRbUVaTnpVL0hKcEdJSzQwelRjQkdOUERuUXl3T2VydFBjVTBx?=
 =?utf-8?B?YjEzc0dBcTRhejF1U0E2YmlsM3dhd3E1clhjT1Z3M3QvaFkzUXRsRWo3TzdD?=
 =?utf-8?B?RmVtanN5elNTaFJYaVVXU0hqSE5TWlgrTTdSUThPcUlXYUhMcHg4WncvQXdS?=
 =?utf-8?B?WFduYU9kTHdWKzV6TWhMa1dLUjIvVnkwTjFsQnNUTU1vcENoQlRweXNjUkt6?=
 =?utf-8?B?SldGdkF5UXJIZm5LeUN1R0ZDaDZtWS8xei80SXFja3ZnZUtBcGlyVWFUZTAr?=
 =?utf-8?B?VytZSkNvWGRhU3hGQ1UvcXZDSWNVajRRdzJoR1JMZTZEWmNpN0tNYk1ZSzB1?=
 =?utf-8?B?c2toMElyOXFmMnNISDdmNEVNYmt3U2tOOWRiakVKWWJRMUN5R3dub3o4VWNh?=
 =?utf-8?B?RnZQRVpOM0taUEZ1cG9zRUl0T2V4SE1LZGNTczB5aEMycHVhbFQ1aklIRkxj?=
 =?utf-8?B?b0o1WjB1UEtMTmw4Mlp6bG9XcERid2REU3N0amlhLzIxTndoTVdEcncxY1BP?=
 =?utf-8?B?YmtIdlh5RTFWOCtHNG9qbEZURElHS3RUNnZERU1kcFE4MVhQemcxMG5jRXVu?=
 =?utf-8?B?WkVTVjFzRnNIUVZzNmpWd3pFcmhXMk1hdW5GMjVpM3lXK1lVM3hTZVFVNUM2?=
 =?utf-8?B?SXJiVW0vMzM2emEvT09yUmY5SVJGZ0dMQ1RBbnRPalZKMnMvOTF2NHF3NlNG?=
 =?utf-8?B?M0VvcGhyQnU0T2pQcFZMQkFSVnhrT0lDcGNxY1lDeTlJUmk5YzNvOE9OMmQ1?=
 =?utf-8?B?RFJweW9haFFwaFg2MVhJNUl0ME9aK3VWdlZkMHphd1NIc3pBSHRacDNYQjFI?=
 =?utf-8?B?VS9QbHd4S1NqMk8vVFErUWNoWVprWWxVaGszc0wvZFFrNW5KeE9qTWhuV1lw?=
 =?utf-8?B?RHRzVUV5MGFtSTg5czZSaWd5YUVabjNiL1dhaWhEZGQ5V05yS0F1SlJwVTZQ?=
 =?utf-8?B?L2NocEgzRDdnWC84TlVTYXJKT0dvZHFkSUg4eTRpY0lRb1cxUklnSjZ4eXJu?=
 =?utf-8?B?YWFMSkpkLzBTWlc5N25ZY1VxNjNNOFBQekpPU0JuRDhkZ0tPNlNkWHhucnFN?=
 =?utf-8?B?cm1JQWxGVVdTdmJOY3c3VXp5RWV1Zkhta1pDZkxzM0FnVW94dkVMV1NpaVhP?=
 =?utf-8?B?akw0cGRtZnYxZFZsY1pNc2pybDlSS2QzZFRidEpKbU1haUczYk4xT0VHNWFT?=
 =?utf-8?B?M0M0c25aSlp6SFBtQTNHNHJtalNlbkRJbnljTERHbk0wY3h1YXJtZU1Ha2lh?=
 =?utf-8?B?VXlRWnQ2eE9tYW11Y2dQUTliNXluU1ZCdW1zdXRZZlRGNnE5eWd4WXMrTXI4?=
 =?utf-8?B?WDIweXJqcXp1MXJOSmVDUStqSDA4a2x1SHJqQ0dwMGJTaDdUaGh1Qm9pZDNk?=
 =?utf-8?B?SVN0TjJPSXBZM3NScndXUW0vSUtDQTJhR2tpdXQ0S0lrblVSR1dFTlYyK0J2?=
 =?utf-8?B?aEtmVzVNWjRNM1BpSWdua1Q1czNQT2dGQTNQR05VSnRKK3ZEN0JvNmFJbnVW?=
 =?utf-8?B?T1k4NGs2U1A3VUF0WE9FWGlxeHhTNWxDOHIzWVhoM3Y0ZjEzcUR0c3pEQWFw?=
 =?utf-8?B?TFJMK2RIRWZaY0RoYllBMEFDWitZOWRYKzNiVEd5NTEwU2gzdldMcHg3VXh6?=
 =?utf-8?B?THhPWEFsUEZQTm9LNkNTNE1WdUtEN0pHZStiOUc4MzVGVjJDNUZKYWdvQ1Rh?=
 =?utf-8?B?UVNYb3lyc1JxMkhtT0QvUmNLV1c5TmI5VWRBekxZMk5xYW1ocE1KTzB2T2t5?=
 =?utf-8?B?dm9ndVpNTnh2dXE0MzBjVUkyQzZiU0ptWXI0cWlvZWJBRGxzbHZpeEJ1dGhh?=
 =?utf-8?Q?xSvk8MtD8DfeaYX/+4vb5UTgU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8efad5f-d83d-4a8b-b499-08dc1d85499d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:09:08.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTeF9/fCLzsR12pMxmGhywVmNxx3azmWi2NaP5gC8ujmVoPllRfUyOPcPYodwS52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299



On 1/10/24 12:10, Michal Simek wrote:
> slcr.c is not having any reference to clock that's why remove it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-zynq/slcr.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index 9765b3f4c2fc..c517cd4a7737 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -10,7 +10,6 @@
>   #include <linux/mfd/syscon.h>
>   #include <linux/of_address.h>
>   #include <linux/regmap.h>
> -#include <linux/clk/zynq.h>
>   #include "common.h"
>   
>   /* register offsets */

Applied.
M

