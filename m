Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFCE7D83EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbjJZNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJZNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463141BE;
        Thu, 26 Oct 2023 06:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DICij4fXd4Dzi9IBEpNSBn34G2zYiLFO8gazEDWNO/CtpgqxQ/TmFnW3NPVX82TzHp/iPhVokm41ASYWF7HsOc4aaZk91IhLzrmJVRP6w8FN9kxQfUxbD4E5xiBNMHdlyaF53z7+BjXDchzaiVMPgflkkwJ+admhztDM25sCfargVWAUGU/zb0X9p2ZDmr+bMwlXak7NWrHO3sWYGxeLyZAvY7g3pbJygIW2bEI2oPYdsMEMs6AsPPl0ytxZzsvxRTnEV9sRhyAru1qpjm/zSN1pVA7NeM4daqcssgYM1GhUvGxmBmkJ4qSyFrHeyWdtW9ogbVNwFHckZcAOhVJbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6O8fY/tuNBE65th767q9JF51iR9X9QuxQCTxZe0iOw=;
 b=muwr1rIbT12RvcNvzhJyu4tKyOCwOQTz58ImVxWmgfzQM5xLtdMOBEj/n/PNhHb9yNs6jE2noqRwBs8oSKhSWONd91uRzuWSGKv2ebRgLsCsP7l1Spndb7ny0t0Ia0Pte5fKVVNWqcAnlQaU3RjZ9XaXDX6grOOMrJn8EHMTe4vT2jB7T7d8So99ld6ff3wDk8QsvlFTKUEsFL/M8yLOud9cJbFqikq42PS4al2VmJPVM8FU8L0ByxidIrhjviaNbCjDba4OwCWP4V8B1QWGQRL8ePx1LdxB6Aot8npXt61pel/ZORWgYmzmrJpXlZQAqbWP/q/dbZvgOWLYKTrqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6O8fY/tuNBE65th767q9JF51iR9X9QuxQCTxZe0iOw=;
 b=vHhutLkq1+boJqMuC5Z51oUZkl8n9r4Bgrn3rE3/LA3Sfapk9eICSskFDkJP/6Golt1Zd9ni154EiixBPK8V4x0ZfBoqa+lZL7x86wq2SV0JLSnwkgH0kE9Au4IdIcsDFpnEXYpoW7zIOm1Q/8em3KGBxI9Lt+Jhc0rnWS19Vjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 13:55:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:55:03 +0000
Message-ID: <0e62013a-1819-460e-8d19-697273d63367@amd.com>
Date:   Thu, 26 Oct 2023 09:55:01 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 6/7] RAS: Get CS fabirc ID register bit fields
Content-Language: en-US
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20231025073339.630093-1-muralimk@amd.com>
 <20231025073339.630093-7-muralimk@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231025073339.630093-7-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:408:e0::12) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 88de47b2-0759-4bbb-8f14-08dbd62b2749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcM2jcTsniYECFfG76Cansdze0oFRdHAdKw8etWcZW3s9+Hg/JJZZ+Jznf5JEhw2znHBrfkzodzsumk3A00DU5RyFoqs/BFk7Tuwq6i8yIcBbCjonrRYwkPvO5wR+E9MV8sU3SaCyvhnxzEatW247b8+jGOiuTmB/sIno7MSkbsuhZBsEkEDGSQpd402RA/XGbtYKj1XRA9jeldUOtaF6nIiw5zHBUZ/ja93G1O84GEQbGcF8aoTZ6EpDJBwLtsvOWGqpHUqk1BgAAFgC+PhbdCQXbUZ7mvwlbtrz/Afqi13Sr0AwfoZxDOw08JFi9bVE65BTS/7CqZN4CeIV3cT4BJdS8py/CJrgN3fXxTyqsOkY7nu4mqNmLtM82Kk//gxX0Jd296MtsLnflq7ytl9ZmCTdEGkgv72qFvgPs6DGuD0kGgQ6K0Z1Vr1C6QTBhm6HudYXLY/gIKBLisa7Jl8TrmOC5vvTkIj1qaC7rWqU0T8THShLCMehNBEvI8hkk0ovS7ZyLSdOGxWIpjQmimnUHmrg5xz40b/HZOwFuYf6ySA+dWyCGsx824DPuAO2QQqhNH6T5n6NBZIcwTs+zvsAKzjmbF4cRtfxm+x+iumAGLwNdoMvX7/dRgIb1S2ZyWLbc0BjucaesKIB5yxPCJ09g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(31686004)(38100700002)(2906002)(44832011)(31696002)(86362001)(41300700001)(5660300002)(36756003)(4326008)(8676002)(8936002)(478600001)(66556008)(2616005)(6506007)(66476007)(316002)(66946007)(83380400001)(53546011)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2paKy9HZkhFMndqWk1RWXFETXdxdXp1bjBjRTJvNUZBR20rcE9ZWmtxZnNz?=
 =?utf-8?B?MGxDclpLQUlvRTZ4dVRJUFVrN0d0VmYwaVBEMjZKQmVrWXJ5YUNTeHRpVWRX?=
 =?utf-8?B?Q2dOTURMbXdpcGFCZksyQWhlbXc3eEZuWTJUVmE4YXFGU29KZzlGL0Vic1VF?=
 =?utf-8?B?bU1BKzltc01Scnh0VEliMFk1TEE3RDZOYzlzN3hMVkRvZUFXRkF1NDhUVStv?=
 =?utf-8?B?N3d2RGpFZC83MDJwUTdySDFWQ2NyZnNHTC92Y0t4WjhwZ2lrcFNPcmx6VUtX?=
 =?utf-8?B?dnFUMnZmY0R4TWdkdU05aExCOHhsUjlNQy90d3k1RUhveEl1RnUxQ0xLa08y?=
 =?utf-8?B?TTZ6RGMzcmhkSGp6UzQ4dGc3eWNmMW4rRXRxTVhJN3EvUVl4a3pzQ2luZDFD?=
 =?utf-8?B?UHg1LzlTYVgrb3J0bnNuR3BtcDB4SjhabStqY1FxSXFlNm9BaGxWbFBmZ2Iy?=
 =?utf-8?B?ZHR3UXRtK1FxbVMvMm1ZSFZSY3B3elREbHp0MGpXeWxpUjJ2ZEU5N3M1ZmN4?=
 =?utf-8?B?RjNrc2lZbi93aFBUWW8xT2hJMG5teWd4ZktaZGNvOUVHZlJtU1lWRWMyNTBu?=
 =?utf-8?B?ZXZUVTZpUFN4b0sxMmFWMkNVYXh2VEIvK3UrYmt1Q2xDVWlNOHhqSlkyMWZu?=
 =?utf-8?B?ZXpjTUpseGxoUkVITnRKMnRZY1YvelVyRUZSOGw3aHBjRVllK2RwNWdDWDg3?=
 =?utf-8?B?RHZnTXhWM214Wno5Z0pFQUdSbnpxODY5aFdWajl6ZUl5ekErWXYzeFpCWlAv?=
 =?utf-8?B?N3I2VmFPMHoycDNBbnBOSnRHZDBrTUYyTzFpMHlQZk1BeGsxTk9SUzF3dWhh?=
 =?utf-8?B?b0hMVEhKNmt5U1JDQXpqbzBKY0RLM2QydUQ1d28vVC85V2pTdlR0TnJxaExR?=
 =?utf-8?B?bVdpeEVnSEY1dFRQY3l0Qmk1eGdlTUFzTXZvektXcW9KNjV4QmhRbmZaNDRK?=
 =?utf-8?B?ZTM3TmNodnpWY2dSTmpYdDB5SEpkemdmRVZ0dGI0cGo5dysrUHNDelFHSHVC?=
 =?utf-8?B?N3dNMUVTa0ZVOUhlZllzdkhFVUF2YTZSWHdyV0dqVS9hTTh5NlVkbVpjc2FV?=
 =?utf-8?B?dmtMQnl4MVBvczZWRm1lMjlrcWxSWnJuY0tCRGhNVlpkQ3pFd3VqOWx5RXpy?=
 =?utf-8?B?NTFxTlRyY3ZWdHpPR1IzbUcxZndWeFRVamlaOWdFMXYwa2I2Nkh0eFZtOHV0?=
 =?utf-8?B?MnBMVXlCWktPdFZ0OUt4NDhVWjY1T1hJRFEwcHZCSUZBbHpIYTJIMFBDUEp5?=
 =?utf-8?B?dzdqREtXSkJDL1I2RFRoUHUyNnJOT1FuWFRRc3MwSGFaaGVoSHE5QmVwVjlj?=
 =?utf-8?B?RXZrMHVoM0VaS3VtN2VXNGJvcDBnSUd6bHVmajFLZHhoMGRjREdFWTlWc3pq?=
 =?utf-8?B?OVU5QzIwbUFxa0I0WjdhN2d0V3pwMlRjcXhnYlpvVm45Z2t6Q0I2eHd1cHBD?=
 =?utf-8?B?MDhkRFBtUGlmd0h1WEZKaHd5SVplVkVhYXg0Q29HUEtSN2d3OExWK0xZN3ps?=
 =?utf-8?B?WFJNQnBYN3NtOEVwY2t6Y1FPRzdDcGV6UXBLWjlyYTBjb3NBdHdSY1d0QmZv?=
 =?utf-8?B?TmhTaDltZ2pqZituTjdwZ1hGdWxlQU83SEM0ZnlEc2VibHFSclVoa0ZNRktX?=
 =?utf-8?B?dWRNd2dVKzRFR0QyZ3NsYU1UcUd6dGJDM2dxTnJvajZlbllnb3BIRVBRd1Vh?=
 =?utf-8?B?azVQdVVvZExXRXVMeVRjS09WdjFNNkpsR1J3Z3Q4Zm1NMUFQOWY0WElFazdi?=
 =?utf-8?B?Q3JYZTV4OEJlQXVnd2R2bHNRdC8rQWJLdWdaRkl2QzdxcGYwNnlWNFRqZ3Ev?=
 =?utf-8?B?aFE1a0dBTmZhcHE3VXVzZGxzUUtRODMyeDdsaUFFMk5ZN2ZEL1dYTEt2VmVs?=
 =?utf-8?B?M1pVN3VaUjY2eWNOUWtEWEsrbHRlemxDeFE4QXh0Nkl1c1l4c283aEtJbFRm?=
 =?utf-8?B?cDZnK0NnZlpNVjhrUDBNMDFwUDhXUExlbnh6cEtUSDk0TzZjRllLdmxxelBO?=
 =?utf-8?B?Q2xsVFAzKzJkWGNLUUdGeUo4ZzQxMjdRNGxVUk5HNzEzUEhBZ0x5ai8yMlBs?=
 =?utf-8?B?eWRzVVhoMk9hV1FYRVpBRzVYQm56eDRMUVFmWkUrVlI1S2MwR0FodTVtMmdO?=
 =?utf-8?Q?qJJTy/O8OtMVvw9flW8TnWRT8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88de47b2-0759-4bbb-8f14-08dbd62b2749
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:55:03.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HVi9Z+qIcTgDh8kHisI3FZkiw76oCHGhMTiID3oQh+tYwyUGbu5NJiaiec3GBpntpk/2MjBSyyi9t+PQTROFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 3:33 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Read correct register bit fields for cs_fabric_id for
> address translation to work.
> 

What is the problem exactly?

> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>   drivers/ras/amd/atl/reg_fields.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/reg_fields.h b/drivers/ras/amd/atl/reg_fields.h
> index c3853a25217b..6b60091f235b 100644
> --- a/drivers/ras/amd/atl/reg_fields.h
> +++ b/drivers/ras/amd/atl/reg_fields.h
> @@ -28,14 +28,14 @@
>    *	Rev	Fieldname	Bits
>    *
>    *	D18F0x50 [Fabric Block Instance Information 3]
> - *	DF2	BlockFabricId	[19:8]
> + *	DF2	BlockFabricId	[13:8]

DF2 should be [15:8]

>    *	DF3	BlockFabricId	[19:8]

DF3 should be [13:8]

>    *	DF3p5	BlockFabricId	[19:8]
>    *	DF4	BlockFabricId	[19:8]
> - *	DF4p5	BlockFabricId	[15:8]
> + *	DF4p5	BlockFabricId	[19:8]

DF4p5 is correctly listed as [15:8].

Special cases can be listed separately.

>    */
> -#define DF2_CS_FABRIC_ID	GENMASK(19, 8)
> -#define DF4p5_CS_FABRIC_ID	GENMASK(15, 8)
> +#define DF2_CS_FABRIC_ID	GENMASK(13, 8)
> +#define DF4p5_CS_FABRIC_ID	GENMASK(19, 8)
>   

Even though the most significant bit changes between DF versions, it 
looks like the upper bits are all reserved/Read-as-Zero. So we can 
document the correct field, and use an expanded/inclusive field (like 
[19:8]) for code simplification. And make a note of this for reference.

Thanks,
Yazen

