Return-Path: <linux-kernel+bounces-153943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171288AD530
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3CD1C20E72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F21155738;
	Mon, 22 Apr 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VjCMvnbD"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E306155399;
	Mon, 22 Apr 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815426; cv=fail; b=aZAQMqb/PgPIrlj+/L7o2TPnE/MKrAPr2iiGMJkphNc8bGyJ3VtTU99YI91QU74fw4nPnCw8GxDGfD9moeU4J5s1Qzx4pdPy1PzmIrYdSoTzcAAxOK0HtTvvuVaCcnJhAbFZ9n/XJScYttbyeAixvQC9Owc+oBlQBpO02menjxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815426; c=relaxed/simple;
	bh=74WRf2hZ01bpNrBc57wX17mWK358KdyRuKdmddDwo0c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JkCssI57I0ithNjUIFMArV0bxH7EA7lPtdRcyGJBEZR9F4PdXwJojbhg/oACbNnPm+Qki9n3yNdYJ4MddDi+bBQdZIRTCbIvCnw96zHJizuLdgV9UTQgEoqa4rC9sVd2z/H/RXmS3QEziXT1nbwQN3CaGapa6LUr2zdKwFZfVGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VjCMvnbD; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRXkxuznRnF5LdK4D/mTuaqc6tMMl1YPA84gZ95GEhutcSP09aTFYLeIdsAzReW+dpU6Xur6UfeUu1IdcqvEqAmbrxqM8V/mjT1Xwr0f+v03uQzXTsJIerud4kq4DwI7RLHxOyomM3hOsyRIE2eXI4ljdKBF/avDo4h1SQQUjplpayKteAVOSL+/mRouYu1jSc1FgVXwyOK9sTX6seDlyMYpYo+2k74EOlQ1ryAI0dmphzDdG1FJgNwDhMAhbf3XTuDj+Ire2sGNANNyn+sdnj853PAJyqQ5wtpD8eLI4fR/VrrPoaIhzEEjRqMTg/sC28s/+RsLHGH8v4H3PoQFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOPwZ+dxtfymvQm7advunBIoPjrQe9QwrXrhqCr248k=;
 b=giHNJX7p1P8fPuuKNVXVX4kEPAjs8ksUH2C6U7rD0vvXSlwnqPlO11xHhzSI1XcgrBS5BdsGAWtr2vXnp6NFWlJ+QlpZ1Nj/PJfuo/glLMchmRMVZ0PBDPD6MuI152iU6eQMziDOw6tBZC++eW59/h4ZwuPErZ6igzeNEYZUCi6d5sBytlgDfRZOiJqHf1byZ1V2rqEFO7HsE5ZllkTqRYsVS1AsBNfytqnpVvZVj5RO4Z1iq8NJmtM1/L80arGDRss/lSWr8BrY30QgZs9O6Nhfvi6OGF+LhT9qS7J4n72chMdoNTJCz2d89shDW5TySwLfUTKH0gDmhSsdHRKrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOPwZ+dxtfymvQm7advunBIoPjrQe9QwrXrhqCr248k=;
 b=VjCMvnbDJivHhglr0k2O5FoilCZTzU7oR6xz7pvAf8EMLx82GQhaQJR9/TeqKB47c0ZAXOqg7S6Fz5TxLB/Thkud/S5rQ7NpC4lSrRiKubOoW4zcTFO1G3n2rrb0j4PShz3mZU2ifuAr6wjXks/XbVgNnVbKLw1Y8mF24Dtwy7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:04 -0400
Subject: [PATCH v3 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-2-680cee731ced@nxp.com>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
In-Reply-To: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=17204;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=74WRf2hZ01bpNrBc57wX17mWK358KdyRuKdmddDwo0c=;
 b=rdKTgs2zd8oW5Moq2U8dSKPkGukahxdFLhwGWhwL5m9PF8OcR1gJqEvv/IOtHXhef/nx/xJU/
 v1qj4AKFzFqB53guPhinnSKvCBY8+3yk2FaXtQS3f1gsUAFQCz7J/2n
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9734:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfd08d3-d820-4b94-c60b-08dc6305709e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBYYWhjZWV0MVRweVVHam9RNHEwUFd0eEZQZ080cW9OVGxXaHk3Wk44M2Rr?=
 =?utf-8?B?UmdhUTAzMkNCV0NibE5uNlMwMTl1ekxsQkdyQWRVRm54Zit1enROemlrd2lZ?=
 =?utf-8?B?M2lXaVNEU1JIaGNZeFkxUjVnSmZmUkdpcnJXN0hEaTRwVXZDdlREeW81MFBp?=
 =?utf-8?B?Q1dwVmR0U1NFeXJBVHkxK0xDYXZCZ3N0N1p2YnRqemhrb2dVb1ZpdjdZUllM?=
 =?utf-8?B?NkpYS2Z2Z1pWR3A2NmNncjNYelo0M1JJQW8yYUNRRE1lRmFFa2Fjc2M2Sy91?=
 =?utf-8?B?MlBGYkpPMzVUMWFSKzhTdjVGdnBwbGNta0lZa2lRdHBzcVJCRmk0UE90d2Fp?=
 =?utf-8?B?dnlwYWwzVGdVM0VQbmZzSHRRaFRrSkVZRTNxTTVkTklNNUZmT3Q1c3FUTm9Q?=
 =?utf-8?B?RlBBUmFiOTlNb212SVp2dmlvK2JLM3dVR3E4S25NUVZLdkdKVm43UlRMWWtE?=
 =?utf-8?B?WnhQWFIvYWpCbWRPWmFvcEh3enhPQ05KaHJ3WjFaejNmMlZFZ3l2eE9IWHNS?=
 =?utf-8?B?RXBPdTZBN3BWWXVHOE1xWTFabWpLcEZJZjdpRzUweUFZOWpBakhHMDVITVRB?=
 =?utf-8?B?M0hXSmdmc3NVdnZUK2dTdDFDVmtSVWcyUG44M1dOM1hmVGRmOHRMZmwzMHh2?=
 =?utf-8?B?TGN0ek40bThPekdnWC96MVJmLzFsNjQxSWpoenpNNlJ0M2tCUTlPWmRKdVZ4?=
 =?utf-8?B?NUkyd2tOTWFwR0NVVEFhdjBtL0dUeGozWWQwRWlwY0UxQUFmSXFhTE9WaWZF?=
 =?utf-8?B?WmdrYXJLcGVlSWFYMU1CK1RHUURDUjQ3eUlReFVLNWluRnFWKzdHeGhkWlFR?=
 =?utf-8?B?SEpQSVZoUE5vcEFQSjFwM0JMUlJaSWRoVHBZQmRYZjFrMWkvVXlPRFJIb0Zt?=
 =?utf-8?B?bytibE5MeHhkUlAwRjNLb2szZ2pDSlVHVzdPT2dWb1pBL1JyanVoRHl4cFhJ?=
 =?utf-8?B?UnV0ZEJIRlIvREVJTFBUd29CS0YvT3N0Q1NDbE9oNkpQd0MrOENHU3pIYTM1?=
 =?utf-8?B?bkRiVVJxaEJDZk9keVFwL2pTMHVKRjZQVWRVV2o0dWxGYnI4YWVsWnBoYlZR?=
 =?utf-8?B?b3F0ZExPUTdDQ1lEQ1ZiTGwrUWs3S2greFltWm0ramlNM3Z3MmRWSTBGNXcy?=
 =?utf-8?B?ZWU3SFRsMUp5ZmN6K2RUa0J2V090dTZlWW5sb1YwMmYrUnhEc1ExZnYrRmh0?=
 =?utf-8?B?ZFl2R0IxeTZDNGFBYStBRllobnNGcDljbmhYcTUraUpHV1FvdjFpNmc2cThK?=
 =?utf-8?B?U1RZWE5ia01kRTIzQ2x5dXNwdVdiVFQzZ3FwckNINDdVemVid0NMT3RWTC9K?=
 =?utf-8?B?aDJEa3g1Q0l4ZFlLUnlGbEtPR1VrQkxpSkdESEs4MklUMzlNSnNyVEdvNkNM?=
 =?utf-8?B?dFB6UExHY3N1V1o1cGpyUy9vdVJBODBSd28yNk1wM3JGMkZKYUozdUkrNVlX?=
 =?utf-8?B?cjJrd21vaksyZmVoaXltSUg5akxsY2hOaDkxbGFyY244UHlTSVFwYU1OeEtj?=
 =?utf-8?B?aEM3RmR5UVlZcEtNVmtBeGVSRFNuUVRHb3dqSFZwU3Q2UmN3d283NzBqdFkr?=
 =?utf-8?B?L0ZDT3dJSUtJNkt3SXVVZ2p1Z1VDdUNxeEhzYWVEeTVDd1JydFM4R3ZWWFBS?=
 =?utf-8?B?RTVrK2Qyd2NLdExZbXJ1VnRJd1dYb3VpN3JIQi96a2VOeGVOeVJKRjVxVTU3?=
 =?utf-8?B?eFVNVkxzQ2xxRUFlL3JyN0hPV1VLeVN4MnBNSGpxZzhQQ1VDbThoQ3lqa1ht?=
 =?utf-8?B?anlxWkFqVmdOOGtxUHR0QXZ1b2RGVHQ1emZUOE5XeWdXeFU0b2NKUFhFY3NK?=
 =?utf-8?B?ZUVLaWVZMlBRZUJCd1V4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnM2M2FrTldVS2FuUEJWUS9sWkpLQmdnZnpUQnRHTngyeU1XZmhpYXFyeFhJ?=
 =?utf-8?B?a0NtQ3RFbnZ6NFFkVFU1NzdtVjlvY3VJMWJWTXpSamtWWXFyOVZDVzdyM2VU?=
 =?utf-8?B?c3FpMnhSakVXSmRBUUZzejZqbnM5a2tZbmxuQng0bHJHTURLVFdhRFlHMDY0?=
 =?utf-8?B?TzBON3NSamFXSHg3YXRwTU9EVjlJaU9lMlA4Z1M4TFZ4QkF5aVNoV0JXVWEr?=
 =?utf-8?B?eGJQa3M3NVg2dEpkZVBVS0tFbTVaV0d6R0o0QnJnRUliMUU0SDBlb3A4RlU3?=
 =?utf-8?B?dHdDVU9mVThFSzlvelB3VlcxaldvbDVwaWRyS01iL2FnWnY4R2ZrSWw4VjZP?=
 =?utf-8?B?bE5lZGVKZStEQXFRWGpZcDYvYlpWMXBVQ1dIbGpwMmpsNVJ5WWhDenFFQTYv?=
 =?utf-8?B?djNWNHEwMlJqaG1jb1Njd3kyWkJSSTlUU1QzSjRZQTZYZ29sRVZ4MHY1ZzZt?=
 =?utf-8?B?NExKK2gyS2J0SUJ0YXZlNTZ6ZTl1ZURaR01ZU1JQUWoyQlRCVEFUZ0lWSC8x?=
 =?utf-8?B?TWh4aTU5UWpaTUhhLy9JeFNMTk1MRHJhSXhSWEpFRllpTXcvbzBWNXVEZ0cr?=
 =?utf-8?B?VHhlOC9ZdFhJaXNBczZNeW0reXI0S2dVTVloaTRmTTBzMGVmKzVjNFRFa2pB?=
 =?utf-8?B?ZjhyVUF4WGNES3lRVTAvV2dlUDBuZ3RpcUpiemx0R1UvcE5jT2FCQUhiU0Jo?=
 =?utf-8?B?cVB0NHNrUVdEN0ZhbURvbE5KQWlTYW1mbWlta1MvTTB2N1RzaEtpRm44WG1C?=
 =?utf-8?B?eFdDeWd6KzBrTytHaG5oL3JhVG1namhPTFVYSDBzT2VOV21BR0tpMHJFYjlI?=
 =?utf-8?B?Wlk2MkYrejNNdnpVUGVsU0FNMit0c2FLeWlJMEhObEsrSjhUWGdIRDlWOU1P?=
 =?utf-8?B?Y3NleENlaEVEM3N5dERuZ3RERkcwR3B5cWxEc1JiV0xZZFRCT0g3M3U0STVy?=
 =?utf-8?B?Q1lDZXkxRXFFOEdWUTZYVE1nTHZrbjNuVEpRRGk1ajBOeVJRay9Zam1nNkpV?=
 =?utf-8?B?WkY0SW9sTUMreVlNVXdrdmVEbURQaXFuZCtQMXdZZXpRSXhDb1RycVZRYzRj?=
 =?utf-8?B?YllzcFRSdDh0VVZaWlRTNWlEV2MwNFUvajdIenVlN2Q5N05CWHNaM0VmOFR3?=
 =?utf-8?B?SVRWZ21QUmczNWRBeTdpcFRxUmsybVNDMk00cVZFanpOUldxQ3VQSFB3Snlx?=
 =?utf-8?B?djVlSHZqOWJBcVJhTmlwMTRtZmxObXlBUUhWMXZ5L00zMi82Y0lxTXdwckxu?=
 =?utf-8?B?ZzZNbVpkWlJ5N2QwaXBoRzBONElUVkIyMG1NdE4rWUFvRHk4cld5QWQwVkxV?=
 =?utf-8?B?bmZHbTFCbFVkbGdsYVRhY2dCSk5obUdMcytUVzFvbHBoR1Z3UHYzWXVHTW94?=
 =?utf-8?B?d3hvWGtXTWNXaFJVL0tlUDVDQjlCOW82V201YlJmOTVCVmFPeVZtVUExRHYz?=
 =?utf-8?B?WHJYY2gwR3dGb0xrMEFDdVpsNElybUJ3TzNGOWtYcTZlSmJMK2ZoNEFYSEZC?=
 =?utf-8?B?OEtRMnFDMDNxWVlrZkNmWFBtQ24wZERyNERDeU5ub2JlVElDWVZtWVk3Vlls?=
 =?utf-8?B?NnhIQ1NFV1FEcGNnNWdNT2hRRTBCTDRQek1CT29VNGR2T0tQNkRZTldzR0xK?=
 =?utf-8?B?bnhlcHBYNWlJZUFiakRXSUR4UnBNVGtaQTZRSituZlRpcmhzMXRlZ2t2ZmI0?=
 =?utf-8?B?V25WNDZhdjFpSzFjQS9RdTQrMDlsakpBZGpUVG9wVEMxeWlaUTFEdVZVdWlE?=
 =?utf-8?B?a1JuNytmQStydUptcmlMYmdpU3NhWnJ4V0dxblpZRzdob3VqK3g3dDV5aWNz?=
 =?utf-8?B?NTF3R3hHcGJXZEQzRnFtRS9FcHlNRGJkQm9KQlR1a2w4Sk5FdFkxbThxcENT?=
 =?utf-8?B?aEZYcUNIMGJQdHhGcEdBL2hhakJXQXZId3hONStSK0hMeUJoM1JQdjBTUGNp?=
 =?utf-8?B?WFNuSkVlWWljaVdKUWpEZE9sRkFhWDUxZTlnUG9OejhveFpHbGtWZ051bmxi?=
 =?utf-8?B?ZjYzaDQ1Qlpka2hnaDlodVVJZXFYbkpMU1NncHg0L0RYeXQ2alpHdXlscS9j?=
 =?utf-8?B?SDBEOHRpNjRWbE5SMXZBS3BNdUtHZHJudENMbDJUVkFXQW5Hb3BidUN2ejh4?=
 =?utf-8?Q?870Y8bTorNByJhFRxDOpCcAQc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfd08d3-d820-4b94-c60b-08dc6305709e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:19.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uimzC8gBI6TQI8jZggpMMENfKX1tBiGALruzwbwY07wDhPhn1t5hBNbjCXcdEr4tuwEhEtFclyO/Nc1ldx1fbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
 2 files changed, 559 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
new file mode 100644
index 0000000000000..ed5a1b4af1d76
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+/delete-node/ &acm;
+/delete-node/ &sai4;
+/delete-node/ &sai5;
+/delete-node/ &sai4_lpcg;
+/delete-node/ &sai5_lpcg;
+
+/* edma2 called in imx8qm RM with the same address in edma0 of imx8qxp */
+&edma0{
+	reg = <0x591f0000 0x150000>;
+	dma-channels = <20>;
+	dma-channel-mask = <0>;
+	interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>, /* asrc0 */
+		     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* esai0 */
+		     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
+		     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>, /* spdif1 */
+		     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
+		     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
+		     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>, /* sai2 */
+		     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* sai3 */
+		     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
+		     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+	power-domains = <&pd IMX_SC_R_DMA_2_CH0>,
+			<&pd IMX_SC_R_DMA_2_CH1>,
+			<&pd IMX_SC_R_DMA_2_CH2>,
+			<&pd IMX_SC_R_DMA_2_CH3>,
+			<&pd IMX_SC_R_DMA_2_CH4>,
+			<&pd IMX_SC_R_DMA_2_CH5>,
+			<&pd IMX_SC_R_DMA_2_CH6>,
+			<&pd IMX_SC_R_DMA_2_CH7>,
+			<&pd IMX_SC_R_DMA_2_CH8>,
+			<&pd IMX_SC_R_DMA_2_CH9>,
+			<&pd IMX_SC_R_DMA_2_CH10>,
+			<&pd IMX_SC_R_DMA_2_CH11>,
+			<&pd IMX_SC_R_DMA_2_CH12>,
+			<&pd IMX_SC_R_DMA_2_CH13>,
+			<&pd IMX_SC_R_DMA_2_CH14>,
+			<&pd IMX_SC_R_DMA_2_CH15>,
+			<&pd IMX_SC_R_DMA_2_CH16>,
+			<&pd IMX_SC_R_DMA_2_CH17>,
+			<&pd IMX_SC_R_DMA_2_CH18>,
+			<&pd IMX_SC_R_DMA_2_CH19>;
+};
+
+/* edma3 called in imx8qm RM with the same address in edma1 of imx8qxp */
+&edma1{
+	reg = <0x599F0000 0xc0000>;
+	dma-channels = <11>;
+	dma-channel-mask = <0xc0>;
+	interrupts = <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* asrc1 */
+		     <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>, /* no used */
+		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai6 */
+		     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai7 */
+	power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
+			<&pd IMX_SC_R_DMA_3_CH1>,
+			<&pd IMX_SC_R_DMA_3_CH2>,
+			<&pd IMX_SC_R_DMA_3_CH3>,
+			<&pd IMX_SC_R_DMA_3_CH4>,
+			<&pd IMX_SC_R_DMA_3_CH5>,
+			<&pd IMX_SC_R_DMA_3_CH6>,
+			<&pd IMX_SC_R_DMA_3_CH7>,
+			<&pd IMX_SC_R_DMA_3_CH8>,
+			<&pd IMX_SC_R_DMA_3_CH9>,
+			<&pd IMX_SC_R_DMA_3_CH10>;
+};
+
+&asrc0 {
+	clocks = <&asrc0_lpcg IMX_LPCG_CLK_0>,
+		 <&asrc0_lpcg IMX_LPCG_CLK_2>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ASRC_0>;
+};
+
+&esai0 {
+	clocks = <&esai0_lpcg IMX_LPCG_CLK_0>,
+		 <&esai0_lpcg IMX_LPCG_CLK_4>,
+		 <&esai0_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ESAI_0>;
+};
+
+&spdif0 {
+	clocks = <&spdif0_lpcg IMX_LPCG_CLK_4>,	/* core */
+		 <&clk_dummy>,			/* rxtx0 */
+		 <&spdif0_lpcg IMX_LPCG_CLK_5>,	/* rxtx1 */
+		 <&clk_dummy>,			/* rxtx2 */
+		 <&clk_dummy>,			/* rxtx3 */
+		 <&clk_dummy>,			/* rxtx4 */
+		 <&audio_ipg_clk>,		/* rxtx5 */
+		 <&clk_dummy>,			/* rxtx6 */
+		 <&clk_dummy>,			/* rxtx7 */
+		 <&clk_dummy>;			/* spba */
+	power-domains = <&pd IMX_SC_R_SPDIF_0>;
+};
+
+&sai0 {
+	clocks = <&sai0_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai0_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_0>;
+};
+
+&sai1 {
+	clocks = <&sai1_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai1_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_1>;
+};
+
+&sai2 {
+	clocks = <&sai2_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai2_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_2>;
+};
+
+&sai3 {
+	clocks = <&sai3_lpcg IMX_LPCG_CLK_0>,
+		 <&clk_dummy>,
+		 <&sai3_lpcg IMX_LPCG_CLK_4>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_SAI_3>;
+};
+
+&asrc1 {
+	clocks = <&asrc1_lpcg IMX_LPCG_CLK_0>,
+		 <&asrc1_lpcg IMX_LPCG_CLK_2>,
+		 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+		 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK0_SEL>,
+		 <&acm IMX_ADMA_ACM_AUD_CLK1_SEL>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>,
+		 <&clk_dummy>;
+	power-domains = <&pd IMX_SC_R_ASRC_1>;
+};
+
+&amix {
+	dais = <&sai6>, <&sai7>;
+};
+
+&asrc0_lpcg {
+	clocks = <&audio_ipg_clk>,
+		 <&audio_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_2>;
+	clock-output-names = "asrc0_lpcg_ipg_clk", "asrc0_lpcg_mem_clk";
+};
+
+&esai0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "esai0_lpcg_extal_clk", "esai0_lpcg_ipg_clk";
+};
+
+&spdif0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_4>;
+	clock-output-names = "spdif0_lpcg_tx_clk", "spdif0_lpcg_gclkw";
+};
+
+&sai0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai0_lpcg_mclk", "sai0_lpcg_ipg_clk";
+};
+
+&sai1_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai1_lpcg_mclk", "sai1_lpcg_ipg_clk";
+};
+
+&sai2_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai2_lpcg_mclk", "sai2_lpcg_ipg_clk";
+};
+
+&sai3_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "sai3_lpcg_mclk", "sai3_lpcg_ipg_clk";
+};
+
+&asrc1_lpcg {
+	clocks = <&audio_ipg_clk>, <&audio_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_2>;
+	clock-output-names = "asrc1_lpcg_ipg_clk", "asrc1_lpcg_mem_clk";
+};
+
+&mqs0_lpcg {
+	clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+	clock-output-names = "mqs0_lpcg_mclk", "mqs0_lpcg_ipg_clk";
+};
+
+&dsp_lpcg {
+	status = "disabled";
+};
+
+&dsp_ram_lpcg {
+	status = "disabled";
+};
+
+&audio_subsys {
+
+	acm: acm@59e00000 {
+		compatible = "fsl,imx8qm-acm";
+		reg = <0x59e00000 0x1D0000>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_AUDIO_CLK_0>,
+				<&pd IMX_SC_R_AUDIO_CLK_1>,
+				<&pd IMX_SC_R_MCLK_OUT_0>,
+				<&pd IMX_SC_R_MCLK_OUT_1>,
+				<&pd IMX_SC_R_AUDIO_PLL_0>,
+				<&pd IMX_SC_R_AUDIO_PLL_1>,
+				<&pd IMX_SC_R_ASRC_0>,
+				<&pd IMX_SC_R_ASRC_1>,
+				<&pd IMX_SC_R_ESAI_0>,
+				<&pd IMX_SC_R_ESAI_1>,
+				<&pd IMX_SC_R_SAI_0>,
+				<&pd IMX_SC_R_SAI_1>,
+				<&pd IMX_SC_R_SAI_2>,
+				<&pd IMX_SC_R_SAI_3>,
+				<&pd IMX_SC_R_SAI_4>,
+				<&pd IMX_SC_R_SAI_5>,
+				<&pd IMX_SC_R_SAI_6>,
+				<&pd IMX_SC_R_SAI_7>,
+				<&pd IMX_SC_R_SPDIF_0>,
+				<&pd IMX_SC_R_SPDIF_1>,
+				<&pd IMX_SC_R_MQS_0>;
+		clocks = <&aud_rec0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_rec1_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>,
+			 <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_mlb_clk>,
+			 <&clk_hdmi_rx_mclk>,
+			 <&clk_ext_aud_mclk0>,
+			 <&clk_ext_aud_mclk1>,
+			 <&clk_esai0_rx_clk>,
+			 <&clk_esai0_rx_hf_clk>,
+			 <&clk_esai0_tx_clk>,
+			 <&clk_esai0_tx_hf_clk>,
+			 <&clk_esai1_rx_clk>,
+			 <&clk_esai1_rx_hf_clk>,
+			 <&clk_esai1_tx_clk>,
+			 <&clk_esai1_tx_hf_clk>,
+			 <&clk_spdif0_rx>,
+			 <&clk_spdif0_rx>,
+			 <&clk_sai0_rx_bclk>,
+			 <&clk_sai0_tx_bclk>,
+			 <&clk_sai1_rx_bclk>,
+			 <&clk_sai1_tx_bclk>,
+			 <&clk_sai2_rx_bclk>,
+			 <&clk_sai3_rx_bclk>,
+			 <&clk_sai4_rx_bclk>,
+			 <&clk_sai5_rx_bclk>,
+			 <&clk_sai6_rx_bclk>;
+		clock-names = "aud_rec_clk0_lpcg_clk",
+			      "aud_rec_clk1_lpcg_clk",
+			      "aud_pll_div_clk0_lpcg_clk",
+			      "aud_pll_div_clk1_lpcg_clk",
+			      "mlb_clk",
+			      "hdmi_rx_mclk",
+			      "ext_aud_mclk0",
+			      "ext_aud_mclk1",
+			      "esai0_rx_clk",
+			      "esai0_rx_hf_clk",
+			      "esai0_tx_clk",
+			      "esai0_tx_hf_clk",
+			      "esai1_rx_clk",
+			      "esai1_rx_hf_clk",
+			      "esai1_tx_clk",
+			      "esai1_tx_hf_clk",
+			      "spdif0_rx",
+			      "spdif1_rx",
+			      "sai0_rx_bclk",
+			      "sai0_tx_bclk",
+			      "sai1_rx_bclk",
+			      "sai1_tx_bclk",
+			      "sai2_rx_bclk",
+			      "sai3_rx_bclk",
+			      "sai4_rx_bclk",
+			      "sai5_tx_bclk",
+			      "sai6_rx_bclk";
+	};
+
+	sai4: sai@59080000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59080000 0x10000>;
+		interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai4_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai4_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "rx";
+		dmas = <&edma0 18 0 1>;
+		fsl,dataline = <0 0xf 0x0>;
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5: sai@59090000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59090000 0x10000>;
+		interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai5_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai5_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "tx";
+		dmas = <&edma0 19 0 0>;
+		fsl,dataline = <0 0x0 0xf>;
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	esai1: esai@59810000 {
+		compatible = "fsl,imx8qm-esai";
+		reg = <0x59810000 0x10000>;
+		interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&esai1_lpcg IMX_LPCG_CLK_0>,
+			 <&esai1_lpcg IMX_LPCG_CLK_4>,
+			 <&esai1_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>;
+		clock-names = "core", "extal", "fsys", "spba";
+		dmas = <&edma1 6 0 1>, <&edma1 7 0 0>;
+		dma-names = "rx", "tx";
+		power-domains = <&pd IMX_SC_R_ESAI_1>;
+		status = "disabled";
+	};
+
+	sai6: sai@59820000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59820000 0x10000>;
+		interrupts = <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai6_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai6_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "rx", "tx";
+		dmas = <&edma1 8 0 1>, <&edma1 9 0 0>;
+		power-domains = <&pd IMX_SC_R_SAI_6>;
+		status = "disabled";
+	};
+
+	sai7: sai@59830000 {
+		compatible = "fsl,imx8qm-sai";
+		reg = <0x59830000 0x10000>;
+		interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sai7_lpcg IMX_LPCG_CLK_0>,
+			 <&clk_dummy>,
+			 <&sai7_lpcg IMX_LPCG_CLK_4>,
+			 <&clk_dummy>,
+			 <&clk_dummy>;
+		clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+		dma-names = "tx";
+		dmas = <&edma1 10 0 0>;
+		power-domains = <&pd IMX_SC_R_SAI_7>;
+		status = "disabled";
+	};
+
+	sai4_lpcg: clock-controller@59480000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59480000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI4_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai4_lpcg_mclk", "sai4_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_4>;
+		status = "disabled";
+	};
+
+	sai5_lpcg: clock-controller@59490000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59490000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI5_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai5_lpcg_mclk", "sai5_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_5>;
+		status = "disabled";
+	};
+
+	esai1_lpcg: clock-controller@59c10000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c10000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_ESAI1_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "esai1_lpcg_extal_clk", "esai1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ESAI_1>;
+	};
+
+	sai6_lpcg: clock-controller@59c20000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c20000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI6_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai6_lpcg_mclk", "sai6_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_6>;
+	};
+
+	sai7_lpcg: clock-controller@59c30000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x59c30000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&acm IMX_ADMA_ACM_SAI7_MCLK_SEL>,
+			 <&audio_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_0>;
+		clock-output-names = "sai7_lpcg_mclk", "sai7_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SAI_7>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index b3d01677b70c4..da49d4bad32ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -461,7 +461,92 @@ drc_crit0: trip1 {
 		};
 	};
 
+	clk_dummy: clock-dummy {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "clk_dummy";
+	};
+
+	clk_mlb_clk: clock-mlb-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "mlb_clk";
+	};
+
+	clk_esai1_rx_clk: clock-esai1-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_rx_clk";
+	};
+
+	clk_esai1_rx_hf_clk: clock-esai1-rx-hf {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_rx_hf_clk";
+	};
+
+	clk_esai1_tx_clk: clock-esai1-tx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_tx_clk";
+	};
+
+	clk_esai1_tx_hf_clk: clock-esai1-tx-hf {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "esai1_tx_hf_clk";
+	};
+
+	clk_spdif1_rx: clock-spdif1-rx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "spdif1_rx";
+	};
+
+	clk_sai5_rx_bclk: clock-sai5-rx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai5_rx_bclk";
+	};
+
+	clk_sai5_tx_bclk: clock-sai5-tx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai5_tx_bclk";
+	};
+
+	clk_sai6_rx_bclk: clock-sai6-rx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai6_rx_bclk";
+	};
+
+	clk_sai6_tx_bclk: clock-sai6-tx-bclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "sai6_tx_bclk";
+	};
+
+	clk_hdmi_rx_mclk: clock-hdmi-rx-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "hdmi-rx-mclk";
+	};
+
 	/* sorted in register address */
+	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -473,3 +558,4 @@ drc_crit0: trip1 {
 #include "imx8qm-ss-dma.dtsi"
 #include "imx8qm-ss-conn.dtsi"
 #include "imx8qm-ss-lsio.dtsi"
+#include "imx8qm-ss-audio.dtsi"

-- 
2.34.1


