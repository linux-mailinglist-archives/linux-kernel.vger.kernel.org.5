Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E237680D081
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344435AbjLKQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344524AbjLKQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:05:49 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5C19A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:04:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD6yaBwq2J8ZXln0pKyIZeMSURi5+9jCvLae9azb5CGOAdnEsqHDs+rsAtozE0ydoBBDAjQ1UfJjYPRi2H+YRmMxRwP7cbOxw0J9L0Z36/e0t5fLScn/SQOXmj5KowpWYnNZm7M0Iwot9NXqTdjJMmm9RpU2KoO+PdIrRn7px1I6LZnWvrXNrHUGOs6cpEkoDVgP9H2N3ba9d+MZQpLLSlrz/cmiwjRaqsfCsab6A66k3JBNLL3kNQd08fbhvOK9/9npG9hlqm1J0pzemKey/KjXI2zgpDOWFJ3KEeDh0APBcQZFIyKC0lVbFTvi9v3vGM/iwUolIaob+i4SaaRDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eocxWwcwaSg4VqG9orY6rFg+TKrVsfiQUShWbk/64jU=;
 b=Z6NKeAv9HP/vcFHkO7F+dN0LobcPK66S575D0Ce5O7fj/ZJ5hvZlQ8sSYRxBD7UVEUM8ufCaJfWi6hqCBocB1wg/cQeZZmMWebw+guLfPpxEOTBepgMHH/oIZ9tG9zEkWIxX5eNX6ORcxC5VTX9INV4qB706vvM2IZMxcWaRnUZt2DAIT4xvsL+O5Y8uU+2gXLyfvwOaYd6wPIfVsg3Ux05Qx5Z8jkTrOOTqQVBmTXC0qSjjEwXDz1p9kJIUDZMq+kZDr8kX5z9yMVm6nrokftM9cmy3lPcphlCHew6Wh4ocxtlkahKk2McHOmw7PRsX4Tp8SeC816xiixXfr8xSfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eocxWwcwaSg4VqG9orY6rFg+TKrVsfiQUShWbk/64jU=;
 b=07hrhkKAD9Xdr8RQDCS+8dIwT03SYD8UV3w212I5wcrVVIZSPZSBwHveRy38uiT40B7iSuXHyyCYQa1jFbaH4ZPaGQRalDJ/Oy9c+pEt2LpAxQjSgVbrRfnooF0oJRxVN8y/Gg4Snv/e3vwdaDPx2OJsavYLXnfveHNCSx9+qXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:04:19 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::8b27:b871:419:2466]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::8b27:b871:419:2466%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 16:04:19 +0000
Message-ID: <3dc54ea0-be0b-4a02-9aa0-ec59f07e4541@amd.com>
Date:   Mon, 11 Dec 2023 16:04:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] w1: amd_axi_w1: Explicitly include correct DT includes
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
        Thomas Delev <thomas.delev@amd.com>
References: <20231207163318.2727816-1-robh@kernel.org>
 <170202303354.5900.12072769319108903531.b4-ty@linaro.org>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <170202303354.5900.12072769319108903531.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::7) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 336cf1d0-cb82-455b-5b95-08dbfa62d4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDEYC5gJUIFxy/adA4nIqXlHm4A4V6QS6RlQYYotYWdO/Sma8DQlbt3UnhP2W/H5qzjL/5E6SvEMJGch428L+hxKMBI0kHuz3RatAHRPoBWMx7C3d7SKzqNuPRXs+I9slma+u3xFbHjCdayy0UK9abqcXXJ2jQ3/jPDtts7PIp6OSr6uzECCFmfDFO0bgUPCkNKzCb/rT1/AR0273//HMWV1xaMwILR4UKx1Sd3dCBKxUoHYrOI7obTS32bkYz7jQOjASuKIMcinU0IFWQU7HtHFYATMG7pNSp5VlN1AAHC4AsoFLvhTxxPAn5y0TM3iMrEH37CAB6tBbBqM/L4K4j8dw/25n4dgpxaaNpGXpj2Lw84WjPvA0M/RiCfxT/G4K7UDFZEGmfDl86r+oREwH9jYR/xYArebhrZzyXX639Mdd9+ioaZ2GPWwPvbo42Y2W/bnYSv3tmdRzSGxWlBrteKQ5tvZbuy13A+pBADRB9pI65tLmkDX2IzBqmsiKFJhWjytHFm9YPHim5U6mCMvh/vNV5/seRTfm+bXeuyvfOlTaqa9snwaQj7hIWyOmciHibD85YZoiEjEDZKvPc/LDaKfiHvG8pcqGfh81V1M94L/XP/h2CrRexWZppnGqFw/ZKSyEiZk67ss+CZDWHfYAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6666004)(6506007)(6512007)(53546011)(5660300002)(44832011)(41300700001)(4744005)(2906002)(4326008)(478600001)(66946007)(966005)(6486002)(8936002)(110136005)(8676002)(316002)(66476007)(54906003)(66556008)(31696002)(38100700002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1kySXVFc25VcTdLQXJmZXVUdG5rc2cveVptT2U1M3NtOHc4N3NjZkl1SHdm?=
 =?utf-8?B?MU03QVMyekNvb2xMTS9EUlljUnNRVTRIUXVPQTZlSklVTnZINXRNcUZtS0c2?=
 =?utf-8?B?NVNkZW5GKzFkVnhLOVpUdFV0eW9PeXF0amsveEVRMnlKV3NEcExUY013Qitt?=
 =?utf-8?B?dnpaUmFPdEJrWGkva2ZvSGlqT0wxU3FMR01ZK2htWWxRc1doc2NlYjMwdk5C?=
 =?utf-8?B?d3JwRjk4aUpqanppdjNOWVZrRXZvWC9wdW1rQ2M5SS93YkczNnBjYlV2bU1E?=
 =?utf-8?B?UWtScW56WHlvaVc4akwwVnFDOUsrd1E3Z3AzR1NxOCsrcVlGQ0xOV0NYQ2J1?=
 =?utf-8?B?Z3I4WWVnSU9RVGRra3dsaHZsVDNRUEtoRlJXb1hXakptVHd2dFJvZUk0MitT?=
 =?utf-8?B?YjBLVHl5M2g4ak9iNzhkS2lnWlpHcHJtSEJzMG4zdktHN1dONDRrb0M1aXhM?=
 =?utf-8?B?RStnQVFzTWdtYzBKc2F0NEx2OWFZdGNPMzhqbUxZa1dtOXVrNWRIazY1dkcw?=
 =?utf-8?B?SXhZNTRlNjdwVjFsQU8rM2NRRnl5anJXbjZZUTIzU3JMYWdVTmF2MmJrK2pS?=
 =?utf-8?B?QWVseDdkWjNQc2R5S3ZpMjc4Y3hzcVlNbTIxRjNYL0xKK0NtUmZ6ZUdUbGFL?=
 =?utf-8?B?bDNWenB5WDYwYWtMbUVvaDBXOXc3bDFzbSs4WlBXc3VXRi90NGQ0cTV6dkkv?=
 =?utf-8?B?Ri8rbmV5RFhlQzlkN2NRSm8rTlh6VDJNRGdZL1NwV083WG5IOFhLUTZBZEJ6?=
 =?utf-8?B?NmJ1Mit1aE9KMVVEWHA1ZGNRdVJvNW9iOGtWWENiQkVldThETnFHMHM0Y3M5?=
 =?utf-8?B?ZmdlT1VPdGk0a1d6elpYcG80QVR6cG5jaGE4aHc2RUlxYkwvbThSaHNxbjNM?=
 =?utf-8?B?aGk1MVhIUWNDNld0MXM5SVlaNEdpckNFU21DK0hBdmljVzh0K3l3SEg1a0Fy?=
 =?utf-8?B?WjVyVEZ4NzR6aUdXZE5uSjUxRlhVUjk3SDFZK0ZDMHZacTBSaEpuSG8zOCtZ?=
 =?utf-8?B?WmVtVEdJbjZzVVZYR2lXRURNVDhGY2pBOGFja3lGRUlYeXN1bm5PVmFETjVy?=
 =?utf-8?B?bjR5aHNQbHBhVndBbHgrcnNTNTJBTk92djBXSVdrTGcxM3JxOU5mL3BzREQ0?=
 =?utf-8?B?VE5ZcnFtRTJ1aHpYMTVrNXV4SkowUEI2OFd6UEJxYy85aEJCVkt2cjNodlRM?=
 =?utf-8?B?WTBoNXVaNnREUDFYdzFFUXM3aDlvTlRqUDVnSDhFYzNya05tcHlUdVo0b3lU?=
 =?utf-8?B?VExUb2Q2dktjSXN2SkNjdlB2SWoxUkRBMlgzaDlheXdrNUcyYm1LVUxaNDZt?=
 =?utf-8?B?VFhuUGxyRytmSnJlNEFTU3BodkUvcjFwMVpoVFR4b3FnaFFacll3NTA4dHNy?=
 =?utf-8?B?OHdQaThvL0FCS2U1ZTVseUJLMHZGNS9nVlJwZ2owUUFuMFMya0crVE95MWJL?=
 =?utf-8?B?VnNsWXNWT3VRb0pDSDJmVG1RWU9USkNRTkpCRm9xS21RRjhpbnNxc2hOVEVj?=
 =?utf-8?B?Z0Jac1I4T0EySlAyZXgwTUU0aitnUFU0OWZQMFNuUU8zclZickliWjNTOTVW?=
 =?utf-8?B?MWpGTDE1dGJwY1FLSUVEem0xa3pSeW5sTkxPdXdWYW1SMVBLNTUzVVBzaE9r?=
 =?utf-8?B?emV3TEoyajI5WDlHUnRFOXd5ckdsbzhsYkRCU1BSSEZKbkpqVEN0cEJRQjVo?=
 =?utf-8?B?MUlJM1dLNXpCeWRJTFNydy9NR1RlL3VTbk5Pa0xIQmVrcXpab2Z1ZlZpU1R1?=
 =?utf-8?B?WXlPOWwvMExjV0h4anVUSmhSOThPZURUbzdyRXVOM0d0TlpwT2Z4ZDBveER4?=
 =?utf-8?B?TitvSnAxMmVMcC92MDdyMFIvRXI4dHBKTjlQM3pCWTRTK24vbitaSEpTbk9o?=
 =?utf-8?B?UUZYTGhTRjIvd0paZ2NqcUR1S3orOW5obzZiNS9mRXZmd3VPYU5qb2VSU3dX?=
 =?utf-8?B?blpJODNUaXk2OERXYW1zamQyRlBCUDZqU1VvSUl5V09ERHI3K1U2amFSM1FW?=
 =?utf-8?B?RUhSY1hBSmx6elduR1M1SWQwSE14Q0pQa29oY1IzMkR6L3Z2cnZaUkQxYmo1?=
 =?utf-8?B?MzRjZXUxaW9SbEVWcnlhQkNQaFFUbm5zZTQwa2NLencrTWdOSVVsQnprRGto?=
 =?utf-8?Q?xtG8S4/boEUQtMDBrVKj5JS/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336cf1d0-cb82-455b-5b95-08dbfa62d4ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:04:19.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeXnfvVaC96sKg7CtOIy7mW8bSXDl8zvZKLwuRAnDxnd7b/ijUEeiSN/xEamA+K3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 08:10, Krzysztof Kozlowski wrote:

> Applied, thanks!
> 
> [1/1] w1: amd_axi_w1: Explicitly include correct DT includes
>        https://git.kernel.org/krzk/linux-w1/c/efc19c44aa442197ddcbb157c6ca54a56eba8c4e
> 
Thank you Rob and Krzysztof,

I've regression tested this on W1 dual instance hardware running on the 
AMD KR260 development board and it continues to function correctly. 
Small change, but tested nevertheless.

Tested-by: Kris Chaplin <kris.chaplin@amd.com>
