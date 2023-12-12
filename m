Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD580E159
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjLLCVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjLLCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:21:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2223.outbound.protection.outlook.com [52.100.165.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B291BF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGbKCjUxdrdBgjteswH4Cy7Aiv/iR1PVEKuaDBZW7EGjZU+imGtmKwyl91beFSQ5lqZhNf0As8fMZGIUs0ljE4l4S51488xIEkDWLO3cEl52mQbJ8degZWD4j09yK4Wix9ksb10VCGdm49IQpxSq4QlxSHox2bFtX05Kf+isj6jfA3BDobS3wan82/AYIBK5rJKQzFA7EhzJ8jXTkL1eXYhWhlDldLsvaD8zn6FZIieWuXP5jdfKb0+8rVUHrqv0wpDPVKJpEJ0IcExUo/bPPCZXf/SBkfc553fWcSrCZtcH4ewp29oXa/yBQOQptNajk4MOoaZEz+boDuntDkC09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rY1U4N7HePNTAV/dgvxd+qFRZZDmnxftEq8kzXGmXM=;
 b=NzuTXzf2Yv1psZiMpCtWMfQlc8axcu8flp0RGhe1FIPs1Oyw5FOBKTqBUeaGbWoi7001uzcT1HU0w4XUmMxOsNlOj/UTcilua+UU8pbARuSFoVCh6uoDwQ5ppQH/46a7gnrzDqJDP0iLHRFLzkob4HULuj+DBUujurBKOy1OgfZZX/1sokiIaiunxsl8NFdykIpJebvqlF0O5jXbCP4o4vGn61Md0Dt6MpKhdSgULJ6g47Apt3uDhHxtgww5Rrw+Jcbocg7DxxTjjW8RPasqHI8UcvvRHrZ4itzJejryv6I2VhhFxHJNugOsHKMliVS3SLePUXhjybTwpydcx8s1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rY1U4N7HePNTAV/dgvxd+qFRZZDmnxftEq8kzXGmXM=;
 b=D3pqLkGAwxcRA3rMR8N17OMGe4SE8AsZ/NOzBZGbNtpCcLi2FbQrBAipquf0hDQEA0tg0TCrYUfoMct2J3h6V6HwikQO21uCEAQLqE2WJd9u5cvzNg6k2KuytuFXuwf6GlmIuJP+OXfq6ZHiWtHHN/ANrwsMRYI4rbhz2tr+ejk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA0PR01MB6457.prod.exchangelabs.com (2603:10b6:806:ef::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Tue, 12 Dec 2023 02:21:52 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 02:21:51 +0000
Date:   Mon, 11 Dec 2023 18:21:34 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ilkka@os.amperecomputing.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: Fail DTC counter allocation correctly
In-Reply-To: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
Message-ID: <bf20c32f-6426-f4ba-3bcc-41aadd89968@os.amperecomputing.com>
References: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH2PR18CA0045.namprd18.prod.outlook.com
 (2603:10b6:610:55::25) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA0PR01MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9aaeb4-d725-47de-f97e-08dbfab919d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?teBU56LNAUq4aY8FPBxt3nbOVHlSG/fSO8UxJ824OhjtSqUrzbhK/NwSFT7J?=
 =?us-ascii?Q?4RLozG6Nr/UYoNhAYezceSSEcys1XVRYrz3yLzHq5bNssfcGBXe3vfZil7vJ?=
 =?us-ascii?Q?gTCjf+29Tjs4XXt6AYYDvKuTvTVQ4xTknov8+vOMLISxVX7ohkVj5JSGRzuj?=
 =?us-ascii?Q?adedj+nzOF/FSLICU9rpkloLX2jrasTGInO50DmUQaosd08IrmaxzrCH2sJt?=
 =?us-ascii?Q?c+I8HDXadVTOXA+omL0FkLxNslKCNXYEHtOefGdwucQOmw34meaGgWTwG4fh?=
 =?us-ascii?Q?fNHBDDp77TrqjnayOTm6TDpktsnVu9DeBg/iaier96kIAf4/wX1rFhDqy8Pp?=
 =?us-ascii?Q?erlpnPrql0G8mPkSbpoDPsH6TzL7kU/cqdIk+v2A9EiSv8UWclLP5Ux53zMl?=
 =?us-ascii?Q?GsT4IdoR8E+s9OIW/gZyMLukjk6Ot5++nD4F6cVHn3A82c96Fi1Y8n08ZNOo?=
 =?us-ascii?Q?hDpIVEelRCju8l0zIU1DYYBVVthnHMhiwz6dVnBzs7wD3ICT0j6weqz9cvZH?=
 =?us-ascii?Q?a0TebORQo4bzWRKP+DhWOAEWcDuCRCyH9c2KkilgfEoDEaU8lnxi1qtNlIkG?=
 =?us-ascii?Q?soqGaRDNfzH5kb5VRYsK5ogAQTrvC0nsbMm5d4pZyuCI2VnB0ULjhXZ8Edl0?=
 =?us-ascii?Q?8zDvpTKs4S2UfnaqjchTHZ+TYz9N4pgPdBeDFwL4EZwzJcF2f08M+FUY9i75?=
 =?us-ascii?Q?Jnzcge9NBKiPSrCBcTQXQO+Zpvn8zQQvDhkWWCBtcXcHnbpItxtmW0aE3sNi?=
 =?us-ascii?Q?BMw53jEpmDNwfu4qTObvuM6SvZCw8/s77/TAXDAeHPD2jv4nzk7ryDGy4OoL?=
 =?us-ascii?Q?y3mnRir5uHdBCz5XfeTHPz7NkGBrzF7/vo7BaA1SDCRCKVBs5DP2viIl8+Xy?=
 =?us-ascii?Q?LKyqtZJB01FnNj89vlwqxxrWQ3GddmCK6z8DqR2G8a70//4+cckQwku4ok9B?=
 =?us-ascii?Q?aG30R0quzUlmhkxuCRUZMMQBEl4NWSXsGwdncqlVY3ohrLjtJMEcP7OPYgnj?=
 =?us-ascii?Q?nknN/go/UAXNZyojYnv5BnfhwYiWxHwNZhC+g5ts/xKJRro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(136003)(396003)(376002)(39850400004)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(8936002)(8676002)(4326008)(83380400001)(86362001)(41300700001)(38100700002)(38350700005)(2906002)(5660300002)(26005)(2616005)(6506007)(52116002)(6512007)(6666004)(478600001)(6486002)(66946007)(66556008)(316002)(6916009)(66476007)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H1VtinIbrHUC2uAP1HWuZKZNVhZozwPmqsL/h1u/eJTIycH3IVnJthnrwlPU?=
 =?us-ascii?Q?mRU+iuHPyHjDfspx2Q82X2YxG0K4e2QKny2L5o2GpQQP3Uc2yNklpqsNRO5P?=
 =?us-ascii?Q?RA7cgZcF67HsnCnzIV9NcwNfOptYSXPulsFothJi/hYnRLzwop/FA2x2mBaB?=
 =?us-ascii?Q?4bSCkX5ONBmAX44xjEbjX8eMWepXUk72Ju+HX3t9BKUGP97gLGPtqCEdqzfC?=
 =?us-ascii?Q?D8CrJcC2FLLmVpdINqjHQfdBWNweytToHfUJtDRACz0M7bQZ6rcgFvzdheMG?=
 =?us-ascii?Q?obn1agoZvBzpYMTw99zIHnHiyKkfPn+3rNcwMyK+StHhhU1/uUR9/qEKUpHf?=
 =?us-ascii?Q?6PwIyMJFqkXpBjZ8Ero3QM79qL7N9wF2azLn7khFxxUwYvbMqpkPu317bHQB?=
 =?us-ascii?Q?b6vufXOB8z1MnEW/RqAWlTABNVlVXSCYu/csMWGBdGxzBGZTpbVIzILo+zCn?=
 =?us-ascii?Q?IMDav3cASQYSzfhKD/hqhfqoYqY1XlvDAcyk5pIPywBOSgHttl40Bsu55qik?=
 =?us-ascii?Q?BQi5zuNalvOw16SfWjKMRExDgi/mTiVoGAvHdLOjIp67m1n5vPrYnGYyD4oT?=
 =?us-ascii?Q?n7CgneUMzml+7aeLLCYf4ait0evw/cVWYkRXtVLxRP6p42wB50/xD1aRd7vh?=
 =?us-ascii?Q?zmPKvN8LLzV4zIF24ilpUlYeOdKMvgawXFzuj3LRoodZJW2hH78UkgIWr/7i?=
 =?us-ascii?Q?1V/8299aasNVHqya32KdZbwJ2jD95FZMk/hpY4tO1EtRAXh02w2TVNFVVqf8?=
 =?us-ascii?Q?Ig36UYK+MZjsNngB1EeHnhUghINb13kUr6p2TwActhZccHO7q43VSWsYtCGT?=
 =?us-ascii?Q?deF1wWq4YoM9pAlcnWQT93oJCbsq27CzZTnJ4yy3U24gGdxi4HAIphxPxKLa?=
 =?us-ascii?Q?8eCx+HP6AckAh2r4NVRuohp1Ay2j6XRu9UIh6pSki2KXt2R1D1/iXQGi+jzb?=
 =?us-ascii?Q?0um1ARotB+p3LSu0dzyL77ZQJhS7jQjl4dy3w3rIFPCQZheV7IQgVSs+AY5A?=
 =?us-ascii?Q?m1tgUSrc2+a7ysq9SeCjnTqY2C4pVIm9hVMRYmMDlg4JyfrqAXxkFkuvjYe1?=
 =?us-ascii?Q?uA+QCHw5m5yuFB27ggyU9j/ieZxW1IDhp9PSdD7FbHU0QWNvyKlI43XpgFDG?=
 =?us-ascii?Q?IDrgk1JQcB7V9iWk+tnhF6ZKtMnH//kxMmZA2SFSxtlSLDN//8gKS5mRuG//?=
 =?us-ascii?Q?81BXGFmhbpEwWGacvZHYaCrPAfXobYASZzOIH88cfyPNmaFuKzUotnrIw1hP?=
 =?us-ascii?Q?p65b2jBWXMo7xPfXDt0S3FrSj4TSb8Jxk2pKtSckdBYfj00NP3wEYxCmb147?=
 =?us-ascii?Q?0ZEIZxH60trOgLL4jGJahCZjXsUOuqSe6PBIgqJRQUgBw33OoRlP930PuZ5C?=
 =?us-ascii?Q?jdVMAWdE5eKn9zvc8WruiF8CyqWlHq3ZNygzn9Iic3rTQ946xCDfF/CD6W2q?=
 =?us-ascii?Q?/CeuJXaX706RWflZrqIjUCQLGda6WRPtBUOERlJhSI2DMc9gj+FnzNAj/HoA?=
 =?us-ascii?Q?ntt36NLr0YvmvHHKzHKX1R4irdAu1J7JG8ZrofSobBNMjmqxBFQur3Q+scbS?=
 =?us-ascii?Q?wzZa/+PGY7pAo404aGM8P0XWZFQD8mlSN+5S4k9fMiwW7svDP3Ts/Z0Ytw5W?=
 =?us-ascii?Q?MLg6EvY/HK2JaCnS9kKOSKM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9aaeb4-d725-47de-f97e-08dbfab919d7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 02:21:51.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT3bFBXxrGXmH5W5Se4EeJoPtzGX3rZECP7ygniSdWo0zDvO3JyaxeoXxz5cwOl4ww34n6ICIGOxBMyBTYPxg6iyqL92QclDQuFHekmmdCbmncSAgYqEE11ACVNJ5XlX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6457
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Dec 2023, Robin Murphy wrote:
> Calling arm_cmn_event_clear() before all DTC indices are allocated is
> wrong, and can lead to arm_cmn_event_add() erroneously clearing live
> counters from full DTCs where allocation fails. Since the DTC counters
> are only updated by arm_cmn_init_counter() after all DTC and DTM
> allocations succeed, nothing actually needs cleaning up in this case
> anyway, and it should just return directly as it did before.
>
> Fixes: 7633ec2c262f ("perf/arm-cmn: Rework DTC counters (again)")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

That's a good catch.

     Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 86d970e74129..c584165b13ba 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1816,7 +1816,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 			idx = 0;
> 			while (cmn->dtc[j].counters[idx])
> 				if (++idx == CMN_DT_NUM_COUNTERS)
> -					goto free_dtms;
> +					return -ENOSPC;
> 		}
> 		hw->dtc_idx[j] = idx;
> 	}
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
