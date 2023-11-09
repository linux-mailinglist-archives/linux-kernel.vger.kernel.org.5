Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7527E694E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjKILL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjKILLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:11:55 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90822D5F;
        Thu,  9 Nov 2023 03:11:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRhCQPPn/yCirm0CTzWE8a9GqDY05vC+4nDrBd9Zjmze6jKkqoDBCh2VMYtI7YxpxJbfqm/cFzryXxI6bdLxVOD5WBdzTV95qalZecjpaDVubRlU6lcQnQmm9+QzInOFhoFsdhixNf/IsUZLVyXsxl++63dVWvfvdDxv2g41JSeaY9SKIK5/XY7ffdauqmlzoRWwkDWAd0l0BQpStT0dHWIXfTWhiu4a8VfW3SCWIaSWPV+3gMu2o8VI5CXSpIbtoc3J+X/HweHop52smcGBRQoqlBxHwPhjVngIZHMGkBq2fHmtHrchshQqevy/38whAdfbOWwXInrXjJRpmYOKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kZfdre/69bHLBBoCv+wmgSFNDltsMax6AhjFYYi+40=;
 b=m5m3z644Ky9fxLCfza0N4KNv2MQ6UW1n6BooCPaJDLIgwZ4bCwPl7sqwCBhDOQosdE1rm2hFMM3Mfveo7JlOetDuJSd9tPHvXgmtC8GqkfyoK9rHxi2DXKXWMmvpnS80xwooam819i9QJ67lDXJDD8x+RJHFDB39Eemm03FhOCGAp7SDSCyIEfOUFeLN79FuPKpX/jKnl894kEuAAFAcKo60ZHc9a5CCF8mlxuinALwlqRCBErIB0WprN2txQCTDh6o5XAHs8UYKnm2FHXnjuTYZfO0RfvADACVSn40DwqYKBm8lHrS1tJ7a2J1nFbHkNyfhk7tuPnlw74ZwYKFC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kZfdre/69bHLBBoCv+wmgSFNDltsMax6AhjFYYi+40=;
 b=LZnllcTbgJoUiJ4y6D0lbBMJ/UCvGuryXguQ5/RLxa0Cz11TQO/Wa1u71LocNHlNgeXdr6650rLZBx45Tm2RNYoTt5gvR1zFIT8+tyD0YFprKrGdrqA1hDpkmzGJCHSkWuMsN5PFsu9kcss7y/vSRdn2jgeDf8RcTUWuqdTvepQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 11:11:49 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Thu, 9 Nov 2023
 11:11:49 +0000
Date:   Thu, 9 Nov 2023 13:11:46 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of
 cycle_time and interval
Message-ID: <20231109111146.qrnekz6ykyzrcpbd@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR08CA0246.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcdb38a-5bee-488b-9ff5-08dbe114ab85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWvoQxt7okb93K5i1m9p8p0pCRGsugJji58ovVptOM6Q3Zlkb9bhTSiSSytby5HerIKvioBpasEaWES25UCmiERLe/0q0bfnSMh+qj1T2YpvdA/7ZbKyQ5oXijN5pmT063qPl1xtHtZY7owYb0QnWY88obN0EjTPMcJRnh0M5ZdFLZUkW2aBvOgvfU+QpUY1h3h2/9j/3HwCM7pWptnZ3uRs2jNdijeaLI7IbKM9JrDJTCzyoj5FXQ02G6sUUsF6KAageneOws0YR60QJNdJkkeSRWI0hrtmz/VdKMseGWoLqQx8iE/IbSA6sIxKJP0vh3YBLHXMF9CiqBZdBbf8CXBv+6f4pyCh6N0vTF0grcuOxWEGWRxM8MFv+h7iBjlCVOaEVZ34Qc5oW2jo+P4LkSKJIW0siIjLEfaTkK8TqIQy4We0Fns0EFXEf+wj6Id6b5w4SOEvwwHRtdEaoU6R0XpH/Di8QYkfQ69lAbY/rGcvakoNceRnBwLDfi9U36ktV18p1l4pDdYeym3HsePV0fMDBdyjeUt12JYmJto+ONksBha5cHMelLtLOkk3JDTi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66946007)(66556008)(54906003)(66476007)(44832011)(110136005)(316002)(8676002)(8936002)(5660300002)(4326008)(7416002)(33716001)(6486002)(2906002)(26005)(478600001)(6666004)(41300700001)(6506007)(1076003)(86362001)(6512007)(9686003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxFeFd6Wm85YTJGVzJjUmR2RHpIM0NkWUJZVnFPbUVkb3owWVBYU253MjFl?=
 =?utf-8?B?Z3Zla2RBQXd3d3IrTWpESVJqZkV3TWgrdmlsREEvOVJQVFJaUy9RRjU2d0xI?=
 =?utf-8?B?bzBwVFJ1ZTVIdU1LVEw2UTRVREhGUHI3RnIxeVBSeEpRVlNWQzRXVHAxd0Qv?=
 =?utf-8?B?UDJWUDl0WExNdVhKTmxTK0RhR0o4T0NXRG1CVURMU3cwZk4wR2ZFaUkxanlC?=
 =?utf-8?B?Ykl4aFUweUtzbXBvbzRjdzR4MGVIZUVscDF2RDgyWkFGZVFVY1loS0EzRk80?=
 =?utf-8?B?UVhZSzBVaFQ4SVk3a2NmWldvRjdlL1VITGdnQ0ptaDU1V3k0TlcxWkI0Z1U5?=
 =?utf-8?B?TFI1NFBlVWRyQmJpN1luL1RscVFick90MWJudkJuL3ZFdGcvdGgxZlY2enN0?=
 =?utf-8?B?bkR1L1JocWgrTHlLQ2N4M1ZvM0JXZ3kwWDMyQ0dadEk1cjBKS3ViRVZpNmhZ?=
 =?utf-8?B?T2U0Y29FQkpFeHM1UTdEKzBGaU93ZjhEcXZOcElWeVRPZ1lmYmdPOEVWSWtW?=
 =?utf-8?B?VTJQalhXeUl6REVMelp1cVZPVlFYdjZuWVpocnVxTmxoM0lKMW5oZWhwdFlm?=
 =?utf-8?B?ZzgwSVQzc0VFUmtxZUk2VXZ1VlBJc1JvaU9PSTMwaWdQZ3FVa3pxMDA5NUdj?=
 =?utf-8?B?R0g2R3FwcFJnNHhCOTZjQ3pxdFJUdDhwenZsdm9mODJhKzd0U09WZDFIelV4?=
 =?utf-8?B?TGp2N2laUkJkd2JpdGpJLzFYVnJMazhGaE1SNGYrbVVHWGhZc0svK1dMdkoy?=
 =?utf-8?B?SmEyWmlvenB4Uk5XT1BsKzQrOWRLbFJjVzI5Y0tNRmV1YkhGU0Fmai95R1Yr?=
 =?utf-8?B?cXAvQVJqU0VMVmhNMEhycHdJLzZhdnlmU05Pc1JwMExPNURZem9jQkdpeXpO?=
 =?utf-8?B?TEh2RGRpR3NuOEczM3dIVng0QkNwcXdNWXFOWW4wUC9DaWIyL2czeEtlTy8w?=
 =?utf-8?B?dEo2NjAvbUhiQ0pNMVFNOUNnMnpNVkZuM2hocjBQOW1YZm5jdWIwdmV0S0d4?=
 =?utf-8?B?Y1BsTWZKQWkyL2hkVWFTbzNqdjFHQjhWNU1SMHhnMGk4YUlxSVJIdVU2VEJj?=
 =?utf-8?B?RjFnZVllTUZoRWdxQmxjY2ZFcnord3NPQTIxcjNQaTVvZHBSZWVJaVpDZ0Jq?=
 =?utf-8?B?Q3BJblBSRmVFUGpIOUFEbjB6ZTVLTlh3T2d1SjhrbndDVkN6SWF2YTRSQXBN?=
 =?utf-8?B?RjRKaGlKd1BpQ0FOWFN1eDA2eElBY1hxVXZpaE1KZ3k4Q2JSa1ZUZUx2QkVH?=
 =?utf-8?B?WVI2TVFmay8vMlkvWS9scC9HdjVvcUg4ZUdXR3R0QVNlTHFORXpSdDNQNFI2?=
 =?utf-8?B?VDJjdWtTS2h4Yld6SDZrZFNqNkFKVUJyaUJ1Nk1PUEpOWkFheSszcGJGRmlk?=
 =?utf-8?B?QXVaTEtWNGVkZkVtc2J0QXV0a2NyeXpmUWZaRkNFVFUrM2pUREI0RWdxZFZN?=
 =?utf-8?B?cjhtYmxBL2FGWUorSE9FYU5JeWZYMlE5UE9OenhSMnJNNUdoSXBnSEtSdmhY?=
 =?utf-8?B?Vk9PMHo2V1RERmVRTXRLVERROFA4RmhYUDR0ZkFYSjRZRnlIci8rNktrU0hq?=
 =?utf-8?B?cUZzRTZDcFRBMjVQd01iMEZpbUpSNWw0dFdsb1Q0VmlGcU81a1c4VzlaNzB2?=
 =?utf-8?B?cE5iS2ZQRmFKaGhsTmRucmh6aW44c0tPQktWdUh0QXBiU0lMM2dRaFgrN29r?=
 =?utf-8?B?RjRzVGJqdnRxNGlKR3JtWTNIQ0tMeHgrZzdvTEFTanBxbiswakttUUMxdGhN?=
 =?utf-8?B?ZmlBcmg5elcwaVJ6Vis0SEJwbGt5WWFRRmFXWFlIaXBNcnd2Sm5mNFp2cm9U?=
 =?utf-8?B?ZUQ5Tkg2aGh6L1E3Um9QcEl3MFdjMVNURTYwNDVZYVJ4V0pCekV2dFJ5WllI?=
 =?utf-8?B?bndocXV6NHNTK3VmbUJTN2NsOTFpcy9RcXNpNTFaOE5wenVoNEpISDRYaVcv?=
 =?utf-8?B?ZUNHZ3VaQ2xVdDVYQ2hKbFd2YXROVGdxMW9YUGRkckVFRDM3OXUrOTA1eTBZ?=
 =?utf-8?B?TUk4M0J3K2h4NzRmcTRVQVo3WE5GVlBMajdLenNueHhhaUF3RmdoUFF3ay8v?=
 =?utf-8?B?eTFjUnZMWjNpNTQvOHJncmNxZHZpdnFBbktpbk9QRWl1ZVZwYW1ML0JwMCtP?=
 =?utf-8?B?UmxSdVdwcEhmQmEybElXR2cxY2NuQkhWZW10ejdocXloQmh2aTBnclVWSmVp?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcdb38a-5bee-488b-9ff5-08dbe114ab85
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:11:49.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQhiizr1e7NImMHLjokgzBXDgkbZLdA4b/W1pop5HqnvCbfgirNL1mCzWlubh/v0KnUQvP0ZFGjk2YvECMWxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:20AM -0500, Faizal Rahim wrote:
> Retrieve adjusted cycle_time and interval values through new APIs.
> Note that in some cases where the original values are required,
> such as in dump_schedule() and setup_first_end_time(), direct calls
> to cycle_time and interval are retained without using the new APIs.
> 
> Added a new field, correction_active, in the sched_entry struct to
> determine the entry's correction state. This field is required due
> to specific flow like find_entry_to_transmit() -> get_interval_end_time()
> which retrieves the interval for each entry. During positive cycle
> time correction, it's known that the last entry interval requires
> correction. However, for negative correction, the affected entry
> is unknown, which is why this new field is necessary.

I agree with the motivation, but I'm not sure if the chosen solution is
correct.

static u32 get_interval(const struct sched_entry *entry,
			const struct sched_gate_list *oper)
{
	if (entry->correction_active)
		return entry->interval + oper->cycle_time_correction;

	return entry->interval;
}

What if the schedule looks like this:

	sched-entry S 0x01 125000000
	sched-entry S 0x02 125000000
	sched-entry S 0x04 125000000
	sched-entry S 0x08 125000000
	sched-entry S 0x10 125000000
	sched-entry S 0x20 125000000
	sched-entry S 0x40 125000000
	sched-entry S 0x80 125000000

and the calculated cycle_time_correction is -200000000? That would
eliminate the entire last sched-entry (0x80), and the previous one
(0x40) would run for just 75000000 ns. But your calculation would say
that its interval is −75000000 ns (actually reported as an u32 positive
integer, so it would be a completely bogus value).

So not only is the affected entry unknown, but also the amount of cycle
time correction that applies to it is unknown.

I'm looking at where we need get_interval(), and it's from:

taprio_enqueue_one()
-> is_valid_interval()
   -> find_entry_to_transmit()
      -> get_interval_end_time()
-> get_packet_txtime()
   -> find_entry_to_transmit()

I admit it's a part of taprio which I don't understand too well. Why do
we perform such complex calculations in get_interval_end_time() when we
should have struct sched_entry :: end_time precomputed and available for
this purpose (although it was primarily inteded for advance_sched() and
not for enqueue())?

Vinicius, do you know?
