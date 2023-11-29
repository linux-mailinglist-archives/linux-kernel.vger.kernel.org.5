Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5647FDE54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjK2R0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjK2R0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:26:30 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC9112;
        Wed, 29 Nov 2023 09:26:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOYjOSeX3yCgE3FgG4LB20ltWzrmnGVAjXxMecs3Poj7Z4vn8/nSrK0fkBgmqcOHx+W3eK72Abm/2uq1iQTvRAcRskxzzUllnI00JBbsvNnYOH1KyN9kNc8Kr6gvtwvtbXTW7rnPyUJ7+CjI1mKVdZiWPZqIpW49SHtWr+Vf/5ZAUIU29zjC1iZKpnBxnlbofIrv9IxwlkjNAkI/vRNJO93hN/K9v8tHf/uuBlVviiTq3KjedCxyn7oDOFMwwR+BWWLPnptEU0Oc+erZ0eobH6MU9qQMJE3VmXMRjXoAAvhPLc4/wIY2rZvc8dxaiAj71DL9mA7jdbGpusWYvCGTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QyTTQgV6hkmajaKflSgvz0YeNp0ADekIOT3BnEXqog=;
 b=O91gzX5Sq49SVpblQOdTu4tNeScUDqcmmBJIJiPVi/4m09fUKLGXeOqUtyXG4KEFMx74P+ySSx4cqCTsqHilHDQRONj1N5iz0RP90pEjPnWu/DO1DMsgY5Q+EMB/4rSFHDxaiw4VBktER/0wDgTlYUKvQlWzBOWux46NOHfaZYa1ZBubup97kULg2P9bYSbp8p5AawfLVe8UNbCl9csg5sRKPif6iesTAHbp5uy3YjMw3+5r9i0LaiX/SZ5rgsLkwQfX1Vwv53ASYU8vzAD5hjYV39EqCjwtBdaU5DS4tTyowSQJOjSqxGPe7ew7f77czLUkmVw4ANuXZaMJ2LYBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QyTTQgV6hkmajaKflSgvz0YeNp0ADekIOT3BnEXqog=;
 b=qGMG5TMv7RP47neU0jU/Ymghn1oJhYyhTOBFvqsEhuRwLbL8BmHjIIayCUvCerTjDlO4fyFDfvuHPGGSjB+mv/N7OVkIT9wO1CTzYkMlYk6KwS3Cy0rrfCLS/co9aSmYBeOLjjOOo0MAKBgJRye0Jp8ryqwhW4XtHHs0qtP9Tdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 17:26:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 17:26:33 +0000
Message-ID: <c76148d0-d5da-4c64-b080-8147b5491946@amd.com>
Date:   Wed, 29 Nov 2023 11:26:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/9] cfg80211: expose nl80211_chan_width_to_mhz for
 wide sharing
Content-Language: en-US
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     majun@amd.com, Evan Quan <quanliangl@hotmail.com>
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
 <20231129091348.3972539-4-Jun.Ma2@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231129091348.3972539-4-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:4:60::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e143049-49cd-48b6-de16-08dbf100555a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5ZpoFpiCSjz1raOeTAs6qRL5oiKOfXX38aFV+GOoTC3+kdrwTzSoUKaQsOE5ZXRGdgV2XrvnEAiFF8tksBklpQzTEV1M0Ww3MOCz+0e5YOOGpv7nxxlPoj1qGETYC3zu1g/+A/XWxd6dci/qhSHJAIWkjy6hOQ97GIAl6CfolZKVqrPhgzExYt4fxNl8PN4nzog0R0sXSVkUzD/MMI7kW0pwZt5H3swHjvMaN7XT6XtzjvqXwJbkEMMEVxObJEF7EWYY8LewylSryvBYqz6WEYyBfDCLd7WWkQf04gRjOu22YdswD8ttcfcOjNS4Qi92gP4LYmjccw9cWfIhULQDsrlEoCePTG+5gWNW2KGYQCV81sr+/RuCaTMp82MoMgYN3cj/wf32PsKobfQGA+FYySCp2XsZzVxzp29sr6l8uHHRJ4Jn5a7LpSvoRpSmjX92wgb2hPFA1hyA8yWcGN/JuiH3v6BoL3Zl65qNAjiexjowdc6NPUu1dzqqjp6PyZf4SyC6yc4JMGgJ2UKcoYYBNfFQs4r6smZYB7tGu8/BtyOk2ROJwDpzaQ3wUPV7iUc8+yOqnRltQtAWO7rbSfyOP/An7s1C6FiHyglYoqgPv/U1lwBZxa03WG+nh7uIdCy/S3YD2TJodpPPU54h1QW8NSz09j0MakDdk7nl2BYpDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(66556008)(316002)(6486002)(53546011)(66476007)(6506007)(478600001)(6512007)(83380400001)(36756003)(86362001)(38100700002)(2616005)(44832011)(4326008)(5660300002)(7416002)(8676002)(8936002)(6666004)(921008)(41300700001)(31696002)(31686004)(45080400002)(2906002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5SUWprQnloSmdJSG9pYndDV0piN3RZUjBlVG1iRGF6ZEtMQS9EMHdvd0l4?=
 =?utf-8?B?L0doYU1PcnRLcHQyVkl5L1dMWG9SLzkyV1k1OGFDaWYxMkhzYVd2d2J2NmFF?=
 =?utf-8?B?RGZHZVNNT1ZpNFVxbTNidzBnM25ObW1FMHR0UTg4aUVkT3Rqd3YzbkxWWStF?=
 =?utf-8?B?SVlsNnFyZCs2R2g4MUdUNk91ZmhJd09kUUJkYmM2ZHE5eENScTQ3STRsUXhT?=
 =?utf-8?B?b3YzMlpOdmlhb21PODlaR1JnWkNZOFJ6T2U4djNSNTViblhVYVdqYlVIdHdz?=
 =?utf-8?B?ZnpnWDFMQ1JtTlo2THdsMXFKbkV4Y05xeW9NWnNISXZ2L1VlR3RKeUxwdjA2?=
 =?utf-8?B?U3FvUlRxcHBtSXZCRW1XaFkraXhnMWgrdGNHNUZIZmxwcnBiYTgwRm0vVVZY?=
 =?utf-8?B?dXlwSTFhcTMvMkZNVjVITzZlTlZLQ3ZHRUhaODgyeVRaUElvOGEva29QMFhQ?=
 =?utf-8?B?Q2RHMnJkUUtULzlDeDQvTzdEVytQMlVRajhOam45dXlpR2VYRjhDa1gyR0Fh?=
 =?utf-8?B?c2ozQ05vT0NEOEJlTmo3dGo4M3oyMXZYZ2dFNGJHcWFXZ2N6Ylc0bDVPc0Yw?=
 =?utf-8?B?dGcvUUMwUGxRWmhuRkc4ZWUyckpiM2hKeG8yTTAvQS9GRURRM3o5QkcwNk5j?=
 =?utf-8?B?bzNpaVFrUHpsVFU3eGxuNFpYZTdxNWhyUGZ3dXdkNDVRdHdzdXFpczRrUm5w?=
 =?utf-8?B?cmsxbkZnVllVM0R5eml5dC9XZkxZNUFtbTNRZ29kUk1hVzhLbFRLalNFd01M?=
 =?utf-8?B?N3A4bkNtWU1pTUZXQjNPaVFMUnhWbEY0WmxSekNjNitGS3RkWlBQUjM4M0pX?=
 =?utf-8?B?Z213WWY2eFUyUHNJS2laWWVjMnExL2llakxjME95dnovTVZsT1RDcCtXUjM5?=
 =?utf-8?B?ZVRMejJDYkNrdWRuL1Y0WUJOTVo1MXVnNFd2M2VxUFRweFNsdkE4VkxITm5D?=
 =?utf-8?B?Si9sQVd6aEFDZS9LWktOc3NtUHo5WDA2VXVGV1JxN0xQSmtteU5BcnNJblpE?=
 =?utf-8?B?UXNDS3BwVGI3dXlRZmtjTmszcEI0czdWNkhOYTl4ZUtjZWw2UGVqRWlzQ3po?=
 =?utf-8?B?SEJGT2pQT0t0bHNkVFNqcGhmYndsdG9YSy9FS01iRkpOcVBjSjdjd1o5RTUz?=
 =?utf-8?B?UVFoYyt4b3V2MnBTTG5tazRvMm1KK2RvT0VjRXl4U2hZRk1DbkRPbWQ3U09h?=
 =?utf-8?B?M3VkcHRIMkNtYk80SnIzZGpBMnVhck4ybXNnQXpzSGlmNE1kcGV4RDBUVkpa?=
 =?utf-8?B?RFFaMDRhc1ZXWnRITDU5cng4UmZIeFNmU1B2ZUxWS2VtSFVJcm92OE5OMGVF?=
 =?utf-8?B?WUV0dTljdmhtTzhNNUF6MlBqejY4Z3Urd1NOUVcyM2x0L2tuUGh1djMvb1ZE?=
 =?utf-8?B?TDdtdVlYSElFSG1CNDhzckNGY2YxU3BOQlJTN21LeGFmaDd2OGlnVjR2ZXlZ?=
 =?utf-8?B?ZnhBdThBeWpwMjd2ckFKWFROU3p2U013Zk9ma0pUeGNUNnd3b1ViMDNBVEgx?=
 =?utf-8?B?NVNYbnY1WThBTmpMTXZRekdkejZvWURDQW82QnozRE80R2dZZE1KS1JTdGVv?=
 =?utf-8?B?TGVlbWo3U3lRNWpxYlFNakxyTmtnZG1Ma094MjVhT3dFNUx4N1hpK2x0Q3Zk?=
 =?utf-8?B?aDJxZnlROWl0cHF6VS95enppbGpBOWJ0N3B5bkRLZFdqRVdDNk8vSTI4bGxn?=
 =?utf-8?B?MWZ3Tld5ODJCVFNGL1ZWR0xnWVhmbHV5ZE50TU9pQ1dvTlhzNU9qaFBiVFJy?=
 =?utf-8?B?alNwd1Zkb2Z2dHFHUHZLTHNmaWhIR0ZsUVFYbzdEMVhjNFpSVmtTcTlFSW5o?=
 =?utf-8?B?Z25GVXBWSFptRndZdWU4Nk95OXpobml3YXgrVSs2c3pxendhYWFJKzZ4R2RJ?=
 =?utf-8?B?V2Z2T1Y5bFkxMVZTNGI4QlFpK3VSMDN5bHJDRFBWTFVhejZJaEh3WGxOQVQx?=
 =?utf-8?B?Z01PWHJLWmhoODF1UVBWdWVXcmw0SWEycEU4OTJzWHNHSmhDNzhqTDVrTm8y?=
 =?utf-8?B?dVJKUy84N08xcUNMbkJzQlFrUStzVlhSZDZaSVBOY1BFV0hVV213Y0ZyTytp?=
 =?utf-8?B?RFg0VkFWM3hCWEhGTENjYVdXVzM5dU5SNlFkWXBhUHlCN3JWbm9qOHVkWDJN?=
 =?utf-8?Q?tzh9fqpUq3ZrJU/YozAy2D09d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e143049-49cd-48b6-de16-08dbf100555a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:26:33.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcO1/neCC+Hm9/nZJCtdl7p0aFUaDPFppcXR89YZA2LkBPKFRG7XIbdhGBsD8u9TufQP0G7ObkunmB6GZFHi1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2023 03:13, Ma Jun wrote:
> From: Evan Quan <quanliangl@hotmail.com>
> 
> The newly added WBRF feature needs this interface for channel
> width calculation.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Signed-off-by: Evan Quan <quanliangl@hotmail.com>

I think the order should be the other way around for these SoB as 
"you're signing off on Evan's work".

Otherwise LGTM.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> --
> v8->v9:
>    - correct typo(Mhz -> MHz) (Johnson)
> v13:
>   - Fix the format issue (IIpo Jarvinen)
> ---
>   include/net/cfg80211.h | 9 +++++++++
>   net/wireless/chan.c    | 3 ++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index b137a33a1b68..08f0d7184167 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -976,6 +976,15 @@ const struct cfg80211_chan_def *
>   cfg80211_chandef_compatible(const struct cfg80211_chan_def *chandef1,
>   			    const struct cfg80211_chan_def *chandef2);
>   
> +/**
> + * nl80211_chan_width_to_mhz - get the channel width in MHz
> + * @chan_width: the channel width from &enum nl80211_chan_width
> + *
> + * Return: channel width in MHz if the chan_width from &enum nl80211_chan_width
> + * is valid. -1 otherwise.
> + */
> +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width);
> +
>   /**
>    * cfg80211_chandef_valid - check if a channel definition is valid
>    * @chandef: the channel definition to check
> diff --git a/net/wireless/chan.c b/net/wireless/chan.c
> index 2d21e423abdb..dfb4893421d7 100644
> --- a/net/wireless/chan.c
> +++ b/net/wireless/chan.c
> @@ -141,7 +141,7 @@ static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
>   	return true;
>   }
>   
> -static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
> +int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
>   {
>   	int mhz;
>   
> @@ -190,6 +190,7 @@ static int nl80211_chan_width_to_mhz(enum nl80211_chan_width chan_width)
>   	}
>   	return mhz;
>   }
> +EXPORT_SYMBOL(nl80211_chan_width_to_mhz);
>   
>   static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
>   {

