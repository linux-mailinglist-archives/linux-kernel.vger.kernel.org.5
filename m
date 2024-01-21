Return-Path: <linux-kernel+bounces-32053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3165E8355C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7041F21E30
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55D374C1;
	Sun, 21 Jan 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qNo3AAna"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2067.outbound.protection.outlook.com [40.92.107.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DD376E6;
	Sun, 21 Jan 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841016; cv=fail; b=JS+4UASEgGXXHAltMZhCD9ZlOhVVfYcs/oypu8CnXPuspiydrQPQFoSMnV7CLlJ8tOeXmlRBfRABottSp09FQZ0g/ukR1l1hxG0fveNpOMC5d2MhjP22Xial094WWOkEy8dcKmUK+qlAyknoZit29WXgRSZeFkBKikl9sxJvxQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841016; c=relaxed/simple;
	bh=Yd3sc/A65qEoCUzqW9OHndbiU2nMrQBNLdc7YzNElYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoJ/5CUR+ecLXCsJts/BCZH/pbNN0Z+GgokaEwd9UntNz51ZWztte4JCJUVgCmhqhfaxuNars3NgHy/bUCL3pbsLhVFXg8nbzi5EUo3NkbFpLZ/mTPAM0Bwa8qUblfPr55NiZY1g2Mvi3CnTWKeKz/ijwk6MW9GpAOB5AAIMjpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qNo3AAna; arc=fail smtp.client-ip=40.92.107.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk0MmBk4V5MW/HOIUdkrFcfQtLzg1JPZCNYT1I94l/yzyRaNAzxbpsFUAtbnia0zBSE2JujWBTb/B7Yi9jmDZ2jQf6DwCBb2HwYANVeQL7oDTi8IknwA+VB0HxhhoQCtij/CjxQUJcr8wbBFCs7+pASm2m/LLITy5GvWcQRPuAqiHMxyXYFNgPOieTNwjaKo9BgVgHFQFyDvLHbZxn5BJXKEtcoJZQy4KqHUvU5B/r2X8e7xQkkWiCVM6KXZIp6RHp/iFInlOggIoMdOIkHTBZrlAwf2GMPJXbCdP9nM9nqg+EQerdYNdKoCadkdwr/ECWRG2bAZ/4l4qYcF8B7zHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnRRuLNvK/g8gaz8gX6Cg8mwYr7wdgAjVPAAoZnD8zw=;
 b=dGvDfpJCkA5oKeqtBuM3GHzlUOhM9JVjzQvpTV/rTKt/IxV9XamlAjcXcvNDbW+NYwEBja/Z6KGGgpNh/cQoYmNXSXF0sS87zv/JQ2mz5ktfNbJ51gb2iXDP/pHUDcUshIViolx1eTZ1jIS+0APs/BejodGvfwMfX6hcgw5dDKMFqPdquriZTp76TDpga1BxHSH6s5KXe/22U7lZs8MLcRuvzRQ67U6slsiv9z3sGcV/4xazNSFZ2K8j+ChDjGi7K6ePnm/tNidUSD01Ywiu0ZkUeZOBcB2Esc2bfrTJAUwh1IGWP0AbRk1VhFuWQD6hVB1VMITXPil4dKX/2QzlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnRRuLNvK/g8gaz8gX6Cg8mwYr7wdgAjVPAAoZnD8zw=;
 b=qNo3AAnaYvXgWxwJZnKq8Qw1mMFofK2HkUSvCbfXtES6Iu4KyKK9jRIFzOaaBygKOMYftmS+jsz3XgufExjiri4MMJndiwEInMlG6m/GX8cJ5/ZDMTjLdwyn5x0iBxOBta2pG8vwz7PFktfzTfWBhTmN+7oTk9tHMuh1EnHnhz8A1f96LVnQmYhjte322FhWDGhQtX1QytkYQ+DdY5D9ngqgbQ9NHx3dWSbOG/pyZjP4irdPtlsUd16jb8HneteEHv3J2aidgxB8knVm7xy5Fss4hZ3Qi1A5PEB7DDbxq7TB3Jn5Bnh3e2Ni9YF0Tkahl3p3xhF7jhTif6v8NCIAJA==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:43:30 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:43:30 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Praveenkumar I <ipkumar@codeaurora.org>,
	Abhishek Sahu <absahu@codeaurora.org>,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 5/8] clk: qcom: support for duplicate freq in RCG2 freq table
Date: Sun, 21 Jan 2024 20:42:34 +0800
Message-ID:
 <TYZPR01MB5556DEA3D4740441EC561414C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [eYikeWM2GM7qK/WtHoB+cI/jJ5r4GrkIov4uetos/j1E8TsBXaboEw==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-5-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 1605bcff-1402-43c9-7ccb-08dc1a7e9247
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gDACqTU4RL2Oukh1rNPZerDsRxyS9zGyWZesrSWoxEUke1Ezh2etJtFy4uEGL+N7E9TInuEy2KeZIzmhO+ar2NYJoOfODyoC05NI5OKXRZszacoEQ0KZHI9jMPradhnuzd0pLQnE4is2xroru4BxGDtFtsFN3sZisaujC83QucEUXOdCeCj7b1lAZU9fFIH6kO1KGDmyMX4TutazE8AT35YqLXgoFzWH/A8xgnSrGKKyptEQvYoyh7tuTGLwA4iws15SFVpKpsfC7rO6i/5JU8qkbQIRcUx6xmnshmz672ntDWtwUDGa+5xk+0OVJa+Ew1mb33l+J0RGe0yHAKssdS4XZfUZ93xCpsOPYyOdk0L3VtXaNULvR2x+1t0gmj6tpakBF1beITf4RF7lapRXuoFuu12UArPB3OVO6aZ6pcXKjv17zuptD4bgfTzp0jrU+YR5DRK1oq4imzGK8IUtDjqgDAILUMomnN5wihvlUQ49KyMGGRbqW4L3SgHz+yeIB04LDveDumozTlyZz7K+rWAdBRTBWwL2V1rNh1FvW1GbwskBxkz7t2drTiFeKBLdrfiZQPRmTbcxkb6sJZ78c9q6IrtyaQXtxhOaeYVIQSY94bEhVIRfNF2eVCHUWDM5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlPYUJvYlpITWhkanhvUWYrM0FJOUhSOGFPRlk1Nkw5NjJ6MXlwbVg5bGY2?=
 =?utf-8?B?ZlA0ZFhJcFFrT1VOYU9pVDhSVWJCcSt1UnhOWjJmWDdCTi9oYzdybldYYnU3?=
 =?utf-8?B?VUhmOWNZZWxDMmZONnhvMElhTEFxNTVlVnNuZCtmeHVtRDdTYWJWeWt0Q01O?=
 =?utf-8?B?dm1SZFM5RE5OU0pHdEpVT3FMNkV5Sm94aUtTcjJLMTduUnRZQVpGWk1samJr?=
 =?utf-8?B?MnRiREQ2MjAxUnA2NS9ibUVqK1Fzb3ZVVFVXTG5zbUVPNSs0c3BoaXI5T1pp?=
 =?utf-8?B?UEtrdUt3dHpGRWdZak1aMFJvNmZUZlI4R2JoUFUwT2NBZ29pbVo3V2MvVWZT?=
 =?utf-8?B?ZmtFcEJXcTQ2RGtZSThzWnNRc1pWbDFPRXhmL3BIRkJIbW5Zamc0MVVOZEdR?=
 =?utf-8?B?QlJlTXZ0ZmY3a2FZcTFpLzF0WDVLb2RvcDVaVEZGb0k4ZS8rWkxtWnFRTHZQ?=
 =?utf-8?B?eXI1SldzWXlXaFZ2dEdsc2VtT3lhWGtndDVvTnlaalp0dUtkeHljbERMZ0FW?=
 =?utf-8?B?RDlBNEVkK3EyWGFIVXJDVm1KMVVGdjZaMXQvbzcyWWcrSWR6OXBLMEVpMXJD?=
 =?utf-8?B?blBISGRGbko3Nm9MZW1qZS91YTZkelpGaHEzcGdrOGE2ajJkYWpzQmZNemt4?=
 =?utf-8?B?cHVmOEZLcFk5dUJGV3Z0TFZYUVB1V0FWVCtpR09NNTNiSkwrUzV0L094VWdG?=
 =?utf-8?B?Y2VmWE5HWVI2L3pBTmh6RW93aGhjTUF4dGVkdnpsLzdLUnlpcEdpcjJKblBH?=
 =?utf-8?B?aVBVNVJpbmY5bVVkMzdnUUNIV0FxZWVuMlhEOVRUT09hcUM4MFdqZTlidWhJ?=
 =?utf-8?B?Z2J3TG9LS1hEWFhESkMxTThVVnNvc2cyRVVZNkF3WEZtQmovWGU2OFNpUVov?=
 =?utf-8?B?d0t2aFJvRi9aeGl2ZXAzNEwrYm9NRHdXM3hITDlSZ2VzY3NPcUlLSmdMMlN5?=
 =?utf-8?B?dC8vcE1qWG0ycHZPN0Z5R1R3c1VWclc5U0YrenFET3ZDZXo4WHpXckFwY2xM?=
 =?utf-8?B?clY5dkhoaDZhSlVrSnVaQVZlSmoxYnNtekcxRlNVZFVRZSsyS3lhTC9NcEJP?=
 =?utf-8?B?dHJlUWtocDA1NXJxM2ZPMHZQMGRYUHMwcVE5d0I5dEJSZUdBK2dLbGI1WXVH?=
 =?utf-8?B?RGZVY0V0ek1EQUlFR2ZWaitDeVpzcU5weWlodlNuYnN4YVJTQkU1cmNMYkxJ?=
 =?utf-8?B?b3JTTWtnWTB0ZDlQbHdQclNmdTFJZGY3bG5XaFVyVjNINXowdklNMFFVYncv?=
 =?utf-8?B?a0JuMkc5Y0tJYTJ2VVNHVFhJYTdiUmZRQm1aVWN1NTE5MWRwSWpGM2h4clZl?=
 =?utf-8?B?MG50QnJqdTRDR2RFRUVRZGpJNjRLMXAwSW15WElFVHdpVzkvY0xOaGJ3STly?=
 =?utf-8?B?OFQwUzg3aE9pU1g5K0poRlgzc1FkRzlvbmlyMEVKV0crT1hwc3hBMHUwOHMx?=
 =?utf-8?B?RUc2S2ZXTDg0RElEWklVMVBqTCtPeThieURZbWJTN3RybWtJMElmU0VRdDhX?=
 =?utf-8?B?MGFmdHp0RUhzQndENit3UDNiWVh6NlZRWG9qL04vMUx2S1QyY05HdEhNb3BZ?=
 =?utf-8?B?bFViS3VWdGdKT1pkZlZKT2t6VmZ1SzY3bndyZnBHTWt5Y042QmZTclhWMlUv?=
 =?utf-8?B?ckZuaEJTMWZ4a3hUOVRxNEFUdDRvT3Avd2VIdWlHd0ZJb1EzUklPSHpKTm9K?=
 =?utf-8?Q?siM01/vooJdD3R78MyQu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1605bcff-1402-43c9-7ccb-08dc1a7e9247
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:43:30.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

From: Praveenkumar I <ipkumar@codeaurora.org>

Currently RCG code looks up the frequency table during set
rate and return the first available frequency greater than
requested rate. If CLK_SET_RATE_PARENT flag is set then the
set_rate request will go to its parent otherwise the clock
framework will configure pre-div, m and n according to the
returned frequency table entry. In this case, it is assuming
that parent clock will run in the same frequency with which
pre-div, m and n has been derived. But it may be possible
that the parent clock supports multiple frequency and the
same frequency can be derived with different pre-div, m and
n values depending upon current frequency.  Also, the same
frequency can be derived from different parent sources and
currently there is no option for having duplicate
frequencies in frequency table and choosing the best one
according to current rate.

Now this patch adds the support for having duplicate
frequencies in frequency table. During set rate, it will
compare the actual rate for each entry with requested rate
and will select the best entry in which the difference will
be less.

The existing functionality won’t be affected with this code
change since this code change will hit only if frequency
table has duplicate values.

Change-Id: I97d9e1b55d8f3ee095f6f01729af527ba90e50e5
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
(cherry picked from commit 775e7d3b69ffc97afb5bd5a6c9c423f2f4d8a0b2)
Signed-off-by: Praveenkumar I <ipkumar@codeaurora.org>

Change-Id: If10193fc79a3c1375ab73597813745ff1f4df0ad

Pick from https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/6dfb368bae130bee58e00ddf8330b55066e1c8c5

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/clk/qcom/clk-rcg2.c | 86 ++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e22baf3a7112..6141e4991fbc 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -209,26 +209,82 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
 }
 
-static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
-				    struct clk_rate_request *req,
-				    enum freq_policy policy)
+static const struct freq_tbl *
+clk_rcg2_find_best_freq(struct clk_hw *hw, const struct freq_tbl *f,
+			unsigned long rate, enum freq_policy policy)
 {
-	unsigned long clk_flags, rate = req->rate;
-	struct clk_hw *p;
+	unsigned long req_rate = rate, best = 0, freq;
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int index;
+	u64 tmp;
+	const struct freq_tbl *best_ftable = NULL;
 
 	switch (policy) {
 	case FLOOR:
-		f = qcom_find_freq_floor(f, rate);
+		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
 		break;
 	case CEIL:
-		f = qcom_find_freq(f, rate);
+		f = qcom_find_freq(rcg->freq_tbl, rate);
 		break;
 	default:
-		return -EINVAL;
+		return best_ftable;
 	}
 
+	/*
+	 * Check for duplicate frequencies in frequency table if
+	 * CLK_SET_RATE_PARENT flag is not set
+	 */
+	if (!f || (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) ||
+	    ((f->freq && (f + 1)->freq != f->freq)))
+		return f;
+
+	/*
+	 * Check for all the duplicate entries in frequency table and
+	 * calculate the actual rate from current parent rate with each
+	 * entries pre_div, m and n values. The entry, which gives the
+	 * minimum difference in requested rate and actual rate, will be
+	 * selected as the best one.
+	 */
+	for (freq = f->freq; freq == f->freq; f++) {
+		index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+		if (index < 0)
+			continue;
+
+		rate =  clk_hw_get_rate(clk_hw_get_parent_by_index(hw, index));
+		if (rcg->hid_width && f->pre_div) {
+			rate *= 2;
+			rate /= f->pre_div + 1;
+		}
+
+		if (rcg->mnd_width && f->n) {
+			tmp = rate;
+			tmp = tmp * f->n;
+			do_div(tmp, f->m);
+			rate = tmp;
+		}
+
+		if (abs(req_rate - rate) < abs(best - rate)) {
+			best_ftable = f;
+			best = rate;
+
+			if (req_rate == rate)
+				break;
+		}
+	}
+
+	return best_ftable;
+}
+
+static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
+				    struct clk_rate_request *req,
+				    enum freq_policy policy)
+{
+	unsigned long clk_flags, rate = req->rate;
+	struct clk_hw *p;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int index;
+
+	f = clk_rcg2_find_best_freq(hw, f, rate, policy);
 	if (!f)
 		return -EINVAL;
 
@@ -360,17 +416,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
-	switch (policy) {
-	case FLOOR:
-		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
-		break;
-	case CEIL:
-		f = qcom_find_freq(rcg->freq_tbl, rate);
-		break;
-	default:
-		return -EINVAL;
-	}
-
+	f = clk_rcg2_find_best_freq(hw, rcg->freq_tbl, rate, policy);
 	if (!f)
 		return -EINVAL;
 
@@ -1032,7 +1078,7 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
-	f = qcom_find_freq(rcg->freq_tbl, rate);
+	f = clk_rcg2_find_best_freq(hw, rcg->freq_tbl, rate, CEIL);
 	if (!f)
 		return -EINVAL;
 
-- 
2.40.1


