Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADA7E3B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjKGLk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjKGLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:40:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51F10A;
        Tue,  7 Nov 2023 03:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhkW6j7yb11X7YY3GMAT4OeCp+4ojmK6zBp9BNa3LmtJOs2OjzziQB/CfUTVqKQwkSvGEuIEID3PmFI92v/wTCDqFuFTnA7GH2jWjHt80pqhgJzLW9p7gvXKgDkXcUQRQ++aONHEAaM8Etjz+tHhB6Q+UKOEMrEHBfdEvniTTSUylSHcgOgIA8N+GR/1qC3fc1qyBa2PmJdU098zMW9rbo4nG/LOvhTfAr3lS5/4JTuJag16ZqF5WlXYNvZ0Eor6rEwe7l5HOAsEMnxHeWXEFMgKSt6JKO2VTwsKcvuV2BydPFrtFhvKBXUcYmqyV48cIDj0nKzegcr2pz6/ss8iPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=if6Pjj/JFEbXLF+9die4gOLdoXSGve2QnVpQMeeNGUI=;
 b=Uy7CUQp1g5f846mleC+QnbTtO9bUJ2yezaIggkP2Mu6k2AB1v25PGb0+9slPJ4vknrquW2FExDbE7y0/4Oz6Aj2nq5tetHeAtqliVuTNrNtfR66gAG5wVIJ1EBnIkfcfYEILwVk4h4BeKyqLU8MAu6UMhLabNvcM8MVr8EelWIIGAMreeLScyJexfhC6j1ooLQ9i47dR/TIFEE3MmatjMPhK1Ax+cgCg7n9NVvcax9BT7XZefa78QPlzhZBsha4etQz8e4+90zCUR8LKuVC++qL8BdKklZTU5NyekOA+eAmxM4GllCm22ALjsIZRZzBXROVyAhGEkzWde79NtNWuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=if6Pjj/JFEbXLF+9die4gOLdoXSGve2QnVpQMeeNGUI=;
 b=qvgwk5RSPxRo7stOU6Gd/Nel6xXIBpUxOzrNc5qvoUK2y0eYWAHku5maGwpV2RImqumIa+LtRyrs54XX127i+GVOu9n3NCwh9Twjr/L6Mkdq+AEVCUkqaTyBO6V+yBrZ2LD9eUubLevqWYXEqjc9913dtSN2Ps1VoyHddM0qbCEOeDSbDh9YszDnNJSzPczNpyjGpaptAwbKc6yh44mfCLCDtacDD8pecIzpSCGgnGshJJamQH6RpwW9+F03F6BpeqC0vt9mputtUNxA0ooCPgi1DRsiYciX0yRijuVu32ikhQ3SwRB41OmF92H0kGdOStuld3Nc/23X0hDKsiy9/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 11:40:47 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::7f6d:9dd0:95c4:3194]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::7f6d:9dd0:95c4:3194%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 11:40:46 +0000
Message-ID: <1bf51dd9-459a-466f-8b82-a55f7b84bda3@nvidia.com>
Date:   Tue, 7 Nov 2023 17:10:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory: tegra: Add SID override programming for MC
 clients
To:     kernel test robot <lkp@intel.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        dmitry.osipenko@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107052824.29418-1-amhetre@nvidia.com>
 <202311071607.IzbwSn2f-lkp@intel.com>
Content-Language: en-US
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <202311071607.IzbwSn2f-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8729d920-b0fb-49c1-27e0-08dbdf8661d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvuntDUWo8GMl2KAvwh+CgWkgCy5Alh0n1l5NMEz+PHTxYvuGUjTkoMV7/1ZEyg2lCVAOavrexNnO0tOWzZvRmPLoPvfPRC1DfGLsTHKqCFsu5qmKageKfuGm7eCFzWqsCchwTJFN6J9VaHO1vdXm/iQGDqgjunmy3Z2EDIkM4Jlcle+9eHWTEHKkU7J0Zj94O8HwJHYZIxsF1BdRC3/SDEcOuUu68ncykxPJWN6PQ7L6T4h2ua1CBeTaKO4ZhbHdwyKbvueoD7W8+ip/kOTj9R14UbLKFSiBPeO6elg5xYnebRHI/3OZkkzB3DEOa92qGeOvW/YPOg0WMETF8w+MWjo/F/dlVh2EMLpBJi2f7I4dwrkutwU09pgrx+RfmVPtWXbnykph4YWtlhJrGl+BQMhnMqe9vjKnxyv9QNTmO8S1GCQq3lz9L0sOXGrozc1OXh0awkfvuoaPnRnnC5LzcM2v8y9Q6GwIMgP7sYpJ8fSWKPoDtCxwX8+KeAUqLpoh2Cagnr3lOC1mSE3tqlZaMMCyJ4gi6POfNX4BlRX3Xsy1OVgPc8g9Jxb/BBx3oxTEea1jmGwtnJkiIrA0dZLAtaeTbUgZBGen/gO8YDVBOIXUPjZleKf3DIbA4p7iHVpzHbiSSPjJVJChr6o4GSWblvAQ7MMQUCYVhA0UVRO+uHIRV9JrhtoeSWqibwB0+RbTo2MSipEkWMRpT0bGPa8CO7mbGEZqz2ptJNf6RffoXr3+aUmfef/lC925gWEuoiXkJ9yJYa/xg/WYejzLSJeoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(2616005)(6666004)(6506007)(53546011)(6512007)(26005)(6486002)(478600001)(966005)(31686004)(38100700002)(8676002)(66476007)(8936002)(66946007)(316002)(66556008)(4326008)(31696002)(5660300002)(86362001)(2906002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0l3K2VZd3RENFFweFhpa3R4R1cxMjM0WkFCV2dkeTZDbUtPZUNFaVJhc0Fi?=
 =?utf-8?B?bzdoWkwxcFRkUEFEUHNDeXJwVkhHdFVXY3J6NUY0VVEvSTJIR3ZtdTQxU1Za?=
 =?utf-8?B?aGJvQkkwUXdBaGViNzQ4VEsybDdxUWVkOFRncTZIeDdkcVJZVC9Wc1l4YzdO?=
 =?utf-8?B?QkR1VVhCVTdFcTV5SGtYMWNjSk9jOTdybmlXY3hJSTJhNGlmVEI5N0V2cHE0?=
 =?utf-8?B?blBqVERmNmFvUEtGMDhURldCakhRRjRuVUlQUzludkxTdC92bjVraytuMmVJ?=
 =?utf-8?B?WmRBVWh3ZVBhQW9yVzU2aTFqV3kzVDNEWGErN3VVTC9XcVRNT24xRWFTb0Z1?=
 =?utf-8?B?TE1DaDVJcWVYbExkZkQ4WlozMHFKY0g5RzdWd1p0ZStwaVdKVzJpRXlkVEZz?=
 =?utf-8?B?bXE2bGYrZWw2ZzN1dm1jQWRaa2JJR1RXbHQ4ZXBaN3ZsL2FUWWQyUkZYR2FD?=
 =?utf-8?B?bkIzTFhuRmdUdDNrWGVlN3Y0c01Mb1d3VzFFQi9uN1hTa2k3Y0NkTHJuTmdF?=
 =?utf-8?B?WHppYTVBOXZIWmkzWWNpOWExSS9NU1ZlYXdMa3BIc3N4UlNRTllqdmR2OE9t?=
 =?utf-8?B?alBiaEpqb1FYM2Ewd2duR2g5WG1TTmdNVFFEY0VoeXpVWHUyM3l2b2dWNXJT?=
 =?utf-8?B?eDA1SmpWRzR3VnhOR0Q3amZJemduTXdnbVlsWUo2clZQeEVaOTQ4MjBZR1lS?=
 =?utf-8?B?OUJzaWcweGZTbHQwNlhoZTEwZ2JYUEJRTHlxL0lSb2tPbFJ5N1hZTVRKcE05?=
 =?utf-8?B?K3U3M3Jqc1g2VzlWa3M5cjkrNnlhalM4SUZYaXVYQUlpbXk0WWpwTHdhSTJo?=
 =?utf-8?B?MjRZa1VkWktlTnBwdlBYU3NHMTRtaUdpWjRJV05HRDU4dktRQUJuT3Q3L0RQ?=
 =?utf-8?B?eXZIQW9XcncxQ01RMHRla3VxRWxZSnV2bmNjekxWNDFaSFdNUnEzTWxjRS9q?=
 =?utf-8?B?STJLdGtwN0FLeTQxdVYxQjd5eTJMMGdqcU9BZ2QzaDNMTjZVWENZanVPbWpk?=
 =?utf-8?B?cnVxNDBxZ08rOTNLcENtUy9FbWR6QVJ6dFpYaUVMR0YvZnJjN1VpYUtPaUtY?=
 =?utf-8?B?RTFKSzMrQldRcWFQQmdHemN1OVk4TzlzR0lZaENycDlxdlpsZjlCY3JJUDRa?=
 =?utf-8?B?Q2huaUIxRVBlRmRnSS90NzlXNzU3QmhEY0tTaG84ZDZHMG5WUmhSbnlDM3d2?=
 =?utf-8?B?RS83d0h3Wm9sK2Qyb0dWUVU2dkRDN1VweDg5MEFzdUpOeWRSWnQwdWNNbGdv?=
 =?utf-8?B?UXkrdFJTcU5lNHNNQTUxeXZhbk0vclZWV3JBdUo2SEplRHVFM1h2NGZnUG1V?=
 =?utf-8?B?a3VmMDlrQkNOSTJNajVxTzNHOEl2K2ZTZHNkeUVhc3VjTU5BQW5NOC80Qlln?=
 =?utf-8?B?YitKNkRWNy8ydnFPTzBxN0JwQUk3UGx6WW1EdnhVdVVQd3NLcW5hbWhodVZo?=
 =?utf-8?B?OVlGVWN3ZXdoQmdFZ1F0cm40VXY5UkpVTnV2a2dueGRtUXJlQ1U1SHc3OWdu?=
 =?utf-8?B?WXRzVWlBRDN2cm5KbW1oZFVjeUNJMDBIQXQrb0IzL0VYOC9ISzNqdlNrUTI2?=
 =?utf-8?B?SnluQ0F0eVkzZVMxWXFpRGYvdThLTkRjeTJ3ei9OK0pOVmsvRXU4K2grRnp0?=
 =?utf-8?B?NjVIVi9ESGV6MmFhdEFzNFE5N0UvdUxydXorZGZyQkoxYjVjOVpRSVFhWG1y?=
 =?utf-8?B?Nkl4eTA5SXA3OU4weThOM0xKcTdXbmtuQzd3Nmd3Yk9KaFZTTnp2YUFEemNw?=
 =?utf-8?B?ZkVwV2V0VjA2THo3ZTNoR3FRS25scDdibVpiSkRkVmNXeTlGd0F1U3hVeUVs?=
 =?utf-8?B?bTkwK0pLSFZvVEsvTVhLdUU3T2dFVU9oVlFzVmdPNVBkdHk5YU9HYjliWmgv?=
 =?utf-8?B?WC9DVkZEbjR0NjlyM3RsTzluWDZseEpHdE0zZHNCcVJlUWROelpOeUZ2ODJY?=
 =?utf-8?B?T1dwN0xUa3NqUzFKNllmQlloenl3T05ISENXNkJsY2YvOHAvUXZqM1ZzRUh2?=
 =?utf-8?B?TmxNcnRwNHF1L21vay9SRFNJaUN6UGkxSjlCVXdmdkU4QkQwZG9sTnh2cU90?=
 =?utf-8?B?RUtGTncxSngwRzlzRXkwRFdxcW5wRCtqOXhUL0YwYS9wRE9OZ2RLelVySGxM?=
 =?utf-8?Q?C7Ewe25Fan3pM5n06r5bX3NsD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8729d920-b0fb-49c1-27e0-08dbdf8661d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:40:46.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAA70tXwdp/ML+kSsIxuxvLN4h8d6IZE7UGC4CC4YcbsRVt7qjMlNRqKVk24rg3eWy39bFJ/+IAqDupDwL/lHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/2023 2:46 PM, kernel test robot wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Ashish,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tegra/for-next]
> [also build test WARNING on linus/master v6.6 next-20231107]
> [cannot apply to tegra-drm/drm/tegra/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/memory-tegra-Skip-SID-programming-if-SID-registers-aren-t-set/20231107-133149
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
> patch link:    https://lore.kernel.org/r/20231107052824.29418-1-amhetre%40nvidia.com
> patch subject: [PATCH 1/2] memory: tegra: Add SID override programming for MC clients
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231107/202311071607.IzbwSn2f-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071607.IzbwSn2f-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311071607.IzbwSn2f-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     drivers/memory/tegra/tegra186.c: In function 'tegra186_mc_resume':
>     drivers/memory/tegra/tegra186.c:78:17: error: implicit declaration of function 'tegra186_mc_client_sid_override' [-Werror=implicit-function-declaration]
>        78 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/memory/tegra/tegra186.c: At top level:
>>> drivers/memory/tegra/tegra186.c:85:13: warning: conflicting types for 'tegra186_mc_client_sid_override'; have 'void(struct tegra_mc *, const struct tegra_mc_client *, unsigned int)'
>        85 | static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
>           |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/memory/tegra/tegra186.c:85:13: error: static declaration of 'tegra186_mc_client_sid_override' follows non-static declaration
>     drivers/memory/tegra/tegra186.c:78:17: note: previous implicit declaration of 'tegra186_mc_client_sid_override' with type 'void(struct tegra_mc *, const struct tegra_mc_client *, unsigned int)'
>        78 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>
Fixed all of the warnings and errors in V2 of this series.
V1 wasn't applied properly in our testing because of which these build
errors weren't caught. Sorry for sending V1 with build issues. Please
use V2 of this series for the reviews.

Thanks and Regards,
Ashish Mhetre

> vim +85 drivers/memory/tegra/tegra186.c
>
> 7355c7b9ae0d45 Thierry Reding 2021-06-02   70
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   71  static int tegra186_mc_resume(struct tegra_mc *mc)
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   72  {
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   73   unsigned int i;
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   74
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   75   for (i = 0; i < mc->soc->num_clients; i++) {
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   76           const struct tegra_mc_client *client = &mc->soc->clients[i];
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   77
> 142620fbbbbba0 Ashish Mhetre  2023-11-07  @78           tegra186_mc_client_sid_override(mc, client, client->sid);
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   79   }
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   80
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   81   return 0;
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   82  }
> 142620fbbbbba0 Ashish Mhetre  2023-11-07   83
> eaf89f1cd38cf7 Arnd Bergmann  2021-07-22   84  #if IS_ENABLED(CONFIG_IOMMU_API)
> 393d66fd2cacba Thierry Reding 2021-06-03  @85  static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
> 393d66fd2cacba Thierry Reding 2021-06-03   86                                       const struct tegra_mc_client *client,
> 393d66fd2cacba Thierry Reding 2021-06-03   87                                       unsigned int sid)
> 393d66fd2cacba Thierry Reding 2021-06-03   88  {
> 393d66fd2cacba Thierry Reding 2021-06-03   89   u32 value, old;
> 393d66fd2cacba Thierry Reding 2021-06-03   90
> 393d66fd2cacba Thierry Reding 2021-06-03   91   value = readl(mc->regs + client->regs.sid.security);
> 393d66fd2cacba Thierry Reding 2021-06-03   92   if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
> 393d66fd2cacba Thierry Reding 2021-06-03   93           /*
> 393d66fd2cacba Thierry Reding 2021-06-03   94            * If the secure firmware has locked this down the override
> 393d66fd2cacba Thierry Reding 2021-06-03   95            * for this memory client, there's nothing we can do here.
> 393d66fd2cacba Thierry Reding 2021-06-03   96            */
> 393d66fd2cacba Thierry Reding 2021-06-03   97           if (value & MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED)
> 393d66fd2cacba Thierry Reding 2021-06-03   98                   return;
> 393d66fd2cacba Thierry Reding 2021-06-03   99
> 393d66fd2cacba Thierry Reding 2021-06-03  100           /*
> 393d66fd2cacba Thierry Reding 2021-06-03  101            * Otherwise, try to set the override itself. Typically the
> 393d66fd2cacba Thierry Reding 2021-06-03  102            * secure firmware will never have set this configuration.
> 393d66fd2cacba Thierry Reding 2021-06-03  103            * Instead, it will either have disabled write access to
> 393d66fd2cacba Thierry Reding 2021-06-03  104            * this field, or it will already have set an explicit
> 393d66fd2cacba Thierry Reding 2021-06-03  105            * override itself.
> 393d66fd2cacba Thierry Reding 2021-06-03  106            */
> 393d66fd2cacba Thierry Reding 2021-06-03  107           WARN_ON((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0);
> 393d66fd2cacba Thierry Reding 2021-06-03  108
> 393d66fd2cacba Thierry Reding 2021-06-03  109           value |= MC_SID_STREAMID_SECURITY_OVERRIDE;
> 393d66fd2cacba Thierry Reding 2021-06-03  110           writel(value, mc->regs + client->regs.sid.security);
> 393d66fd2cacba Thierry Reding 2021-06-03  111   }
> 393d66fd2cacba Thierry Reding 2021-06-03  112
> 393d66fd2cacba Thierry Reding 2021-06-03  113   value = readl(mc->regs + client->regs.sid.override);
> 393d66fd2cacba Thierry Reding 2021-06-03  114   old = value & MC_SID_STREAMID_OVERRIDE_MASK;
> 393d66fd2cacba Thierry Reding 2021-06-03  115
> 393d66fd2cacba Thierry Reding 2021-06-03  116   if (old != sid) {
> 393d66fd2cacba Thierry Reding 2021-06-03  117           dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
> 393d66fd2cacba Thierry Reding 2021-06-03  118                   client->name, sid);
> 393d66fd2cacba Thierry Reding 2021-06-03  119           writel(sid, mc->regs + client->regs.sid.override);
> 393d66fd2cacba Thierry Reding 2021-06-03  120   }
> 393d66fd2cacba Thierry Reding 2021-06-03  121  }
> eaf89f1cd38cf7 Arnd Bergmann  2021-07-22  122  #endif
> 393d66fd2cacba Thierry Reding 2021-06-03  123
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
