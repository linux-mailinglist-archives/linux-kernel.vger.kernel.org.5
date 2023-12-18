Return-Path: <linux-kernel+bounces-4376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94779817C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7431C21F32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658F7409B;
	Mon, 18 Dec 2023 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gy+opRBx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D673478;
	Mon, 18 Dec 2023 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702932507; x=1734468507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W2Hs96AqQiGDi2exTUitBAzOrbDezSDZ9jpmjOMwKAU=;
  b=Gy+opRBxbA1Ux29ccYHe3KlHUioE+9CU2n++IixImGLS5Wm2DlETnhqs
   SzAPKbmR7DL0SjbHeWk1fIO+wKSuf+1zM46WKkddcqM+fHcAcf7nuQT4/
   bhEb/lZteQmC/I/bABks66uVpQVKCV79wY6IQQ4fspQWbuBTZOumHg4eM
   LBt253a6evY+x22sFprG05rdKVRpTLGMyrSvdJBwxzZ3isuedOgxbzRWe
   2dEL2zNIgJT0EViUByIrlTXJ+rsqp64gPgG8tvZhsb+ROrwt6I/wALMVK
   uMbTPblsig3Uoy3xAEQ+b5SJwcb7uUsN81LGuNkBfgVc2fskWZofajy92
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2774767"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="2774767"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107088611"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="1107088611"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 12:48:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 12:48:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 12:48:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 12:48:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPS1kHNTPLCW57Vxt9Ccfc5j8270z+wWPKOAKZPP4r5sC0yEPRLj/XfYPJqwjY+cwX+PKFx+56LmaZB91hiALqhvJbzmzjCGAoejTXpKQtNoCsrJEqVJXe2zLpd8kxMQyGw5bv6LkhaAnTHVRoImiwL9kSwSI0AGpbQaubMqib/tGKnY6ofmKxHFjN3WTEKq4Z9QOwCzguly7vxo2eFLE1QP7GVmgNAZFrpgXvWbW1w4j+Ow1v14vnPZQlMkgmm0xBf9pzdnKEI3Q2GO9hwA28PMoQN+f8eXXij0JOPp2pAmEqQXmWRqpuSPliS2rDL01k5UiI+cJ7HryhqqPljxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BasrHyiLqQ00kDQPrUV/fst0YIPII3j/7mDUPH0MDQI=;
 b=iyknWckRiGt063XygDreEHkKicK+l0oMMwamWNAyYcoYziIFTyCy6VINJMLdOcsQek9JfCxvhl49dLzhJ18X8wjvXUShK2SdtgGxKlvpiqtM2pyHYg3pi737stcNrILW0edn7sIUXX/RKJHbnmxoE33eii+GE5aQ2orVIgH/b10HDkbKY0utfE/QCX6Y9W0LZJST7bV/Kh8j58LaBNklih4RhfInoxSz+l6Axg3nY07fnm6tYgeq1qhgMnyFGaHv+UGVLEZxBqJgQTB2JTyGF7Azhq1g6BWSkBW7AZLYCga3alRu3qf2jmo9y+GT4f0dxs3g5okekWb3ZjELKj3AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 20:48:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:48:22 +0000
Message-ID: <159702bf-3bc8-482e-b4f5-65799d330d7f@intel.com>
Date: Mon, 18 Dec 2023 12:48:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: stmmac: fix incorrect flag check in
 timestamp interrupt
Content-Language: en-US
To: Lai Peter Jun Ann <jun.ann.lai@intel.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Song
 Yoong Siang" <yoong.siang.song@intel.com>
References: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1f1182-8f48-4447-b84d-08dc000aac75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3m95ZCmdt59Fa7I9CA6YwccbcM6hC6v+pbOsjThwGQ7G57NSkM5MD+Lt5Sk7qeMCn6iH7xzql/nz03alEpq5OXllEd+YqqNsPBK65PXDOpxi3K9nOFf3Ui0cGlj8+1lh+IakhhW1VWfmt35cW/ulJ7dVAQkRLAkEU3/HaU/G53ne0CBWqvT1PFhn9pKTUeSF1NsoFREq2zqFRVrWM7/TtRtHEdhHJCui+FZmfH5IiXeTJ5GW7a710g1PoGyUGTuCxvvDHxC7HESZNbn+GjgRxqGxXTCbh5C0wZrAolIklX6E/xVObEUdk7V72kzRoM4qQN54gVrnr46u9ZcJo3F0KgmiIR72+lauzG9VnmO203hcUE71sAEUdytrW9RBipXyyS3c1f97ffzIrqsJ8c4HsrbnzzJCdyObE5j2idBSokyXV0l5BZxqbHqMshCegTticgH1DS4N88jjTASdqEJwWoQu4oDu/ktu9kUJO4FnL9+UMQVgghMvTyKS0iqnwr8+8Tb8UCpYvtPp3A/6uY8x4dYJtWt2nLLoRSJ0MPg0u7cONw07xqrbwuzCo+tEI/vDv6vpFDFUXXWSsbF1ybOWqFTNxAISDTSVZEK7PiMM8QoeVezthYC2LXuJnJBn0ahfSurgUar9dnGHrGqrrZHpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(83380400001)(107886003)(6506007)(2616005)(53546011)(6512007)(5660300002)(4326008)(41300700001)(7416002)(316002)(110136005)(2906002)(478600001)(6486002)(8676002)(8936002)(66556008)(66476007)(66946007)(86362001)(31696002)(36756003)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxHbWdNeGdHNndsOVhOMjlNZXpsa0hLZ09lTU5xdDhLSmROMisxZU5GNDZL?=
 =?utf-8?B?Q0JqdlJ3V0lJVkt3ZllSVE5ZUWdkSWJ0TmpFNU9KN1RTcnFadGhLRFVwalQ2?=
 =?utf-8?B?bHZWT3pUb0VwS3k0TUx6TzJmNHJiWVY5L0RUdVhPQTVIK0REYlV4QzM5WWFa?=
 =?utf-8?B?QWpVdXJRQ1FLNTV6dGtJREpMMTdCd3gvcjdmbnpYYy9vMFphVlpxa3JoZ0hC?=
 =?utf-8?B?NHJ6dCs0S0lQb05UL3JRZlpKdThMNENIMDl5QVVoUmZPZFN0d0FiakdrYVBm?=
 =?utf-8?B?K0ZVYjk3MWxxb3Z0VVJydmdPclo4c01WL01mVHE5eGdxSElweDF5cm52K003?=
 =?utf-8?B?eUY3UmVLZWJ6Z1A5ZUY0eUpIeGUzN3hUZE5WbjluU1NndmdGejlhdjZ1eitH?=
 =?utf-8?B?Y3RobmRKMUExTTIwY2F1UGMwaExOVmpSazNyTHdyeWRMQUhLcEh2WmtTQzNo?=
 =?utf-8?B?ZmpDWFg2eERub0RDWnplazVJUWRUUFpxS053cXNoakFFVkpEOXJocW5aWnow?=
 =?utf-8?B?VStROWJaNVc0RWJMNXR2WU1LNVQrYUZCdXFLSFNEUlpZL3FhRVVaMXg4U204?=
 =?utf-8?B?UzEvR05iWlQ2ZUtGeGNKV2QraTYrYzBSSEpzTHlxSEs2SXhBeDN4cE1FVnlG?=
 =?utf-8?B?RDRFOHB2N0dkbjQrR1pWcFJQQVcxY1pLdkNwZGhsdjNwemRMQ1JxRnNhN2to?=
 =?utf-8?B?YlB1YmVWUTE3SllGQzErYjczL1BlZUZYaU1GbHdlQXVML255c3VuWjd4blJQ?=
 =?utf-8?B?QzVienNzN3pJMWlpM1lkWlN2eEp2a21zYzB1RXhxeVBoaXl1WjNSU01qc0gz?=
 =?utf-8?B?TVBLOEhZdm1wRVlKZW9uaGR4d1JaSjgrTTZCY214dUJQZ1pOV2ZKWmtNUER3?=
 =?utf-8?B?Y3RPcXhyOVdDeVdGb3h3Y3doMFFOaDBVWGtKMVFkZEx2YzhiY1Bnb2VqSWdP?=
 =?utf-8?B?TDR6elNsc0UxK291RDRBN3JNMTQwQ3RUb2tUU0k0ZFlmVDdWS2U0bXJoT0No?=
 =?utf-8?B?aSs5cnZ2b0Q0SG1rVURwdlBqQkducmFURGVhSUhWUHdUQlJ2U0NVYUh3OWpi?=
 =?utf-8?B?VDNkOW5MeGRVSmFFY1krM0MxeFhRRTF3NlAzVEpHVEVWZWs5WWVjdVN4RnIz?=
 =?utf-8?B?OE0rQmNFS1NraTlTQ0lmRTJNbHY0d1Y3RXRYU2xUZEE3Tkp1bGdzK2xFYW1y?=
 =?utf-8?B?UWxXeXBldVQ1L3Y0U0YzYWYrK0F5cXdCTU4rV0hTNVFnTytuY2NGWTMxL2xN?=
 =?utf-8?B?QjRNUlV3OTNaVDhQNUxmdFNUVDhMdndyZFUrd1hIKzl3Vy9vRlRlcUxHcTlk?=
 =?utf-8?B?UFU0QUlwQkd6VXhWK1dSVUdUSDIwS2ZETm51c2YramJpMnJkbHpUcW1qUUtN?=
 =?utf-8?B?aDQyWU9lMHFqTDRjMUZnTk9YMU0rUi93WUtXZzl5MmpaQWs0ek5kVWx5dmd4?=
 =?utf-8?B?eDBSYWwyUFQyNkRQOE15TXF0aWJ4emhKWlJOdDhsZUJ2aE9reFBjVTVtV1VM?=
 =?utf-8?B?dnBucTdWb056Q0ZkNEVyK1RvM1UwZERHN05wVmFqeUNNRDIzZS9SSTY5L1NL?=
 =?utf-8?B?UnhhQlJLZWNlbjJPbGZiNkd0blhvbWNydGZJSUZFaEh4TjV4NktnVW9xTGpw?=
 =?utf-8?B?K0c0L3BlR0tEOVVnL1ZlcEtORmJrOS9ocldBaWlSd2RwazAzcTNpcGMwL0ls?=
 =?utf-8?B?NEwzdld3ZWlRZzdBOXBaZTUwSk5QejFhYjg3QUV6NDBKTHFBZzBtM1NRTUp5?=
 =?utf-8?B?YlhIVTFyRllNeUZ2ajZIdmNILzVWOFFib1pLckxrWWJULzlvekZ5b0xiVVJn?=
 =?utf-8?B?ZmtKSmUwdXpKV3pVeFVFQStNOXNZc3RaR2VQSVNtQmQ1cWNhUmRqS3RVVGJy?=
 =?utf-8?B?ZVZoUW9VQ282Q0hXckZyZGJVekI0MjZDeU41Y3dtL2ZBQ3E4cU5ORE1KNEVJ?=
 =?utf-8?B?enNWYUltSm9QNDl6M0RSN2xSODhpTnRWV0VsTndsQnBPdnlrdDhHNE5CWXkv?=
 =?utf-8?B?UElXcjVxeFhVRGFXTmR5aGx5NVBnQzA1d0ltZlhhcU1JQ3UzMG4xNnpqNUpl?=
 =?utf-8?B?cDJtVTVNMGVYR1pkNXB6VW5NY25ad1BLdU5pZUZoWWdDODJtMHhVVXZqZlBl?=
 =?utf-8?B?dmFBSTladitsaDJaZEhLQWd2d0RTeU92dlh6V2s3YXNaMkVRbEZTdlhBa2Fu?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1f1182-8f48-4447-b84d-08dc000aac75
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:48:22.4013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3PVOsAtSLyWv+3/W2SQCkA/pqKU0XRVtHHW3BlNkK9ZrzMB+lc6iJd/P5Eq0V+trzyuxl7H9r6Y0YFNE0038xd+hQ5ovKXiVgxJL2wuL4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com



On 12/17/2023 11:51 PM, Lai Peter Jun Ann wrote:
> The driver should continue get the timestamp if STMMAC_FLAG_EXT_SNAPSHOT_EN
> flag is set.
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Fixes: aa5513f5d95f ("net: stmmac: replace the ext_snapshot_en field with a flag")
> Cc: <stable@vger.kernel.org> # 6.6
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> ---
> v2 changelog:
>  - Add fix tag and stable@vger.kernel.org in email cc list.
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index 540f6a4..f05bd75 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -237,7 +237,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
>  	 */
>  	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);
>  
> -	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
> +	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
>  		return;
>  
>  	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>

