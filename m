Return-Path: <linux-kernel+bounces-160130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9278B398A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729661C234E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410721487F3;
	Fri, 26 Apr 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fazB7Bj2"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260A7E573;
	Fri, 26 Apr 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140727; cv=fail; b=j1trF2JzKkBxKTJEU1seR+9pF3tnyIBskaSiwEwPtMAYy4pEKf9zXhFVEDAuG5JGcZvFXnSk8mRpbj3F1NIoHw191kIH8RNrjYKs4mQD0xMayrW2T5WX76wyhjoBhxoEo+JHEN5N0tDh2q54Gyk/zk4JAvv09MEmP9YybXvmoMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140727; c=relaxed/simple;
	bh=j7sH/nhSZf14+Hvtikex1wBTBz5ldcpQimtjgB90c80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A9JrltmR6z3ZC2nqmTzkLS734Hw5U3SvHh7AgBGeWE+KHcn8GpTV/9rHEmn9q2yyLQPR1tSIWk4J2QLfUKnm09Txfd+L+Tb9Eq4EogcMFDWJKu+RUc9STO1+sJSqJa0iGMGrQJqSPFIMURaPJEXhHo2BVcG9uQSFoZUwvT2Ygrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fazB7Bj2; arc=fail smtp.client-ip=40.107.6.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeE46/pneU3CRMZ4RAI4b0JFTM2dKKUMAaZRvIRwpKQRGQYyM1iHhoIaGmOIzqWCA+Lr61aJBabWO5xF8tBL6PMQAKGRmibagOiBXk++Zp9U5auyx8TbSxcnyY+MHIQUp3TMg4dSPHVv8Mxi30TJbYRs7se2la2JDCkOO1jbd/ck/poCtU1c0AOl+JpqHBn9T133HWx4aCM4aMYmc1iXaVgjhwSK8GOb4VKYtaWDFeCMUNKuIMulLyXcJLEPyzFCYPr/mpNO+/AJ/QvQr7E8DdRVPdIA2/o6/q0n+aNQNcgIhicjo78aMtViKL/CYH6SDCTQhEZoDr8GSjujVZYuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHQ0zetNjjfkdi/YsxJZFtd9f+ukRPdE5oXf3SxQ9T8=;
 b=d4UKII/AMSEq7ActnR3UtPuxTB0V+URnviv53YiCN1r8Ugy9gH4XOS9xyGmtOiJRJ4dcXwSuZRqJCubXPJ9frcIsis3HSg88Ch7Tai362FLSffhJnoRU4GDBfr4dM/uZ/G8yOSDPyqUJI9Sm5JnNpvP+XQTLHO29WwXMEIUms0OSu2ln0F8gyZaQLddObdPThIv1zJoJpE59Nj05PkpIRRQSgBEpc7pHKp5zYLAmlLGbGuk9MdJjPGSaRTe/py4aFUOwxviSEBrirYFsh7H8eyolBDPLcT04fnjTxwEL7ypsZKrwfjdvNNwWMnjuXV8xERri5+0W8ZLxdBXavwpaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHQ0zetNjjfkdi/YsxJZFtd9f+ukRPdE5oXf3SxQ9T8=;
 b=fazB7Bj2rXUakJ54vldlAJ0hywpaq+jqmJ115QIBp3BWuPhOctkDVaORIKpgD3FKSRwpHuB8Bb85ZeQD+7mTO/EqV6trWUvyU2wU/jvp2CuEjZQ83lTfoMlO1FQXKasJodieeNZzWiDDYKBNjEpf3tt9oJnJMTfAnbqL28sJkz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9021.eurprd04.prod.outlook.com (2603:10a6:102:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 14:12:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 14:12:00 +0000
Date: Fri, 26 Apr 2024 10:11:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8mp: Add delay after power up
Message-ID: <Ziu2JjDVO/+gCESM@lizhi-Precision-Tower-5810>
References: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com>
 <ZirB5sWBsOXucVsY@lizhi-Precision-Tower-5810>
 <CAA+D8AO4Hzg3ydc1CkidZ0T18bJ3M3d79WPSxAcWZ2xdT4=rMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AO4Hzg3ydc1CkidZ0T18bJ3M3d79WPSxAcWZ2xdT4=rMA@mail.gmail.com>
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: a91a36e7-f22b-42f1-74e5-08dc65fad6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vng3aHlvMVV3czlrZ2NHc2tMcms2RlpXUTZqRjE4ZExHZFJTOU1pYjFMeXRh?=
 =?utf-8?B?QXNqcElKNGtzRnZQWlBXNWRGTkNxb2p1NFNMNzVZSVBqVEMveDhXVnY4cFVH?=
 =?utf-8?B?QVhUZVAwZXFqdmZ0OE1HSWc3UUZ2Q1hyU29HcDRzNmRTRWllTktabzBmTTg2?=
 =?utf-8?B?S3dZRzVrZENCOFFkRFNZSno4dTJvWVN0MTBKeTU1S3lURURjS0huNkRXQnpa?=
 =?utf-8?B?RFhnYkg0WGtuMGh6L1pFRWx6TVlrQnZVWnJEWkpBdmtuYXdnMTMrNEtlbUtv?=
 =?utf-8?B?SER6cHJIUHdVZXNCOUhHRnFKL2FwMUtQWCs3c1orTk1zclQ0UWNRTHpJcnVZ?=
 =?utf-8?B?UXdvUXlHRUt4amsxR1ZCNCtxVzhXWHVZdjIwR2RIeTNIcnpWd2hRQ0g3dmZK?=
 =?utf-8?B?K2k5RmgwU1JjdytGdUdMMFN4dmVGRlBkNVdVN0hsNXJUaThYUXg3bWxzdmFo?=
 =?utf-8?B?SjFmNnFNcFRBK0Z4Y3B1c3YzV0RYdXJvQXc0WVEzS2ZIWE9ybjY4Z2hxWTdN?=
 =?utf-8?B?RHNIbHdXWU5WWnk2MFZiOUd1aVVDbnZ6d211d3ZGc3RDcUIyMlVyVFhQbWpS?=
 =?utf-8?B?RXd4NjlMSFRzeHZTdjBwaUtqaG1yd21QaDlKT2w5eHlOY1pSeGJoWS9TcE9P?=
 =?utf-8?B?SXIzTUU4R01yTEM2R2JESHFkTVZkZ1N0dVNIL2djTWNXOG15dGN6K1BxZDdu?=
 =?utf-8?B?RGtZQWoyVHJxTldKUDd1dEhLVmw0SUdRWEQyM1N6OGRySzZXZ3Y2V1M0b2Zo?=
 =?utf-8?B?enp1TVJ0UFFqSGlza0VyQkdVSlRFeVAyUVFoT3lGZkVxYmg1Y0wxYkthdzFt?=
 =?utf-8?B?Z0o5bWJSaFdIQld4QmZGUk1yYk1BM2JkMlJoUmExOXk2MURzZG9FU0VJaEhv?=
 =?utf-8?B?dGtQOCtjWTRPbk5FcFkyNG1KV250YVNTd3U3MWlndmRWQ25CUi80RzhwOFFr?=
 =?utf-8?B?dnIrbDBUaDIrMkY2Sm5mNnVWN2g4a0J3dnFMUEl2RVh0VVRKUG4wckhrRnl2?=
 =?utf-8?B?bmpZOEVzek9DQ0Fjd0dZSlNFVkd0WWxlb21DZGhTOFlCOU05OVZaN1cwRlA4?=
 =?utf-8?B?MGVpQXFaVXU2MkVoMXBnMVZFdytEQTFwQU5IYVAxQld1WFQ1VGhHZ0NIWWRq?=
 =?utf-8?B?ZjRhS1MwK2RYY2g0WDM2NHoxbWhaNjR0aVpSQnUzM1hGTEc5cHdEQ3A3U2lE?=
 =?utf-8?B?aDk5ZUFTd05uWnROZ04xSm9MK0RCZEE5WGxDbUhxSmRxRTQwQ2R6Zzg5bUFR?=
 =?utf-8?B?TTRSN0VFTFVHYnpJQlZJZ00wMDlBNnVBdk5ZMnp6NVBEaCsrQTZUM0pOZFd6?=
 =?utf-8?B?Z0F0My8vcjhWVEFTd3Z0N2hqSzhJSmZaZjBsY0tFeWo4QU8wTlNwT0ZaWThw?=
 =?utf-8?B?VmNUSHgxcXIrRmlCSVdwcmhzd1B2aEtES1FsZlFyY2FUS1pmZS9yb0xybGlK?=
 =?utf-8?B?UkZ2RFB6NzBjeE9jVEd5MjBHeHE2dzBreGx2c0o4Zkh5N08yUjhQdzFSOWpV?=
 =?utf-8?B?WWtMYkNQRndqM3gyQVhTK1pOWWJnd3djMHViT080WDU4MGZwWUQyOWFjSkt2?=
 =?utf-8?B?S29KbkpLeVVYWWI3Wm5QcVRHQVozVEdzWDh4SG1GN1hPWGJxK3B3U244UWVP?=
 =?utf-8?B?Y0k4cTZkdTBzU2ZyMythemxicmVhMlBQLzVpMkxzQjF2amtRLytSVmxVWlNx?=
 =?utf-8?B?dUJ4cGVzRFNzSzB4dWl4TGZPOXlZVVljK1cwWVhvY1Y2eC9ZakFISjh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0dEbnBMVTIwYnpBczNMWWtYakRiNVZmR0FDUm0zcVBkMTFzdzVuQXFMN3NJ?=
 =?utf-8?B?SEZuTWMwNlNVQ2NEQTQxbEwyZVowN2Z3QXlsWXhJTXgrVzUycjgyT2dsVDI4?=
 =?utf-8?B?UXVoNHdzWDNxK3dHMmFDeS8rSGlvU3R1U0FIMGxJMGh1RFQ2RzFleldSY0tx?=
 =?utf-8?B?L1V0cXV3LzZoQ1ZKbWF0dTNoNmpHOWVNbDBRSTZTSStkbzZGYURVQnZJb1lR?=
 =?utf-8?B?MlpoeDVlUjBXTUZRZWMwQXpNYkkxdDQ3dGtKZElaTHdtNlFNUitjaTRqa05I?=
 =?utf-8?B?U3JwTGhBekJCYThHRlRDRzN5dUJxUGo5bWkzSS9ROExSTXczNkx2dUgxRFNT?=
 =?utf-8?B?YzlGNDhORExiekxjVzZYOXFVRXhHc0FhdGtuUGJYNGlNN1AyVE1STzVvSldJ?=
 =?utf-8?B?THFjWmVVaGc1eEJJTllqU0dUN3FzZHJuS28xTEJOZXgzYk44K0JJbVhpbVp6?=
 =?utf-8?B?V09XUWJzVDUxTUY1bmg4OXRUNmJUeUdaK1k2QjRKN2hJdXpoNkdCbFp0dUd0?=
 =?utf-8?B?NGNFdmRtKzNEMVMwOG1TZmppOWpNS1NGcFRoVG10QlBIMjB2STM1UlJkQjU1?=
 =?utf-8?B?aVJCUDRDcDYrWGY0aTk4YXJSMjllR3o2b1hzWG1JK2YvcHlSTHZ2S3VnRUxW?=
 =?utf-8?B?L0FoRDIxMUtTbzlRWXZ1TEJBMlVtWlRBWFFZdm9VbW1yMVR2Z3ZGeU40cW51?=
 =?utf-8?B?aXhBdE5UNUtHUDFXdTBwNCtMWFV2UmxzSUp6MmU1MDQxaS96QTcvaXJtWWFC?=
 =?utf-8?B?WEFVNDNaZ0NLNzZrWjk4WFhMQXpFenlQMkU5aWdwYkQ3aUZpVVNpUlo5MkZn?=
 =?utf-8?B?ZG15QUVpNXRBd0pBM1BJOFZFNTRrQ0Z5dmNoU0JsOFpiSHNsdElhekcvRFVn?=
 =?utf-8?B?NU5FWHN0SnNsMW9XbldwZG1COTczaGU2MGhYeWVSUnBPRlZEdHkrQUF6WVJ4?=
 =?utf-8?B?ZS9iZEw2Z0dIMlExTGQzUkJuSHdpWGVQZzVUMWFGUE1EcmRSck5pd0VLRHcw?=
 =?utf-8?B?aVhZeGxwMFZEYThySzRKNElLRUJveVA5bVJwTVB5ZUdHd0t2aUVOZkN2c2tI?=
 =?utf-8?B?aGwraC9lM2JJZEF6UEJ1c1NSeHF0M2JlZ1B6NHdtWFFrV1dsOE50VGpWTHBw?=
 =?utf-8?B?cDEwMGhBS0hBT05mVVFrNkFWdS81RXU0QVYwVi9xclpMUmx5YVVScTFmSWtX?=
 =?utf-8?B?TlcrTFFac2hDQnRsVU9NemtVRzhtbTJIT1ZQdVExRUpuRjJadXFIRzlyR1pr?=
 =?utf-8?B?a2JaNlIvT2FVMGRhNEExeUpSeDYxbGwzNENheEZFMWtlMXFXTEtjNHlSa2hv?=
 =?utf-8?B?MHo5MjVCUkp6RVJsYUNnV0xaeUtvT0VoUWYwdys5Y1dnaHozOEhLY2ZXU2Vx?=
 =?utf-8?B?QmFaQnVtVTdpRDg1bURDLzBPZGV3Mjd2K3ZSVXdURjArVkJGdUYxMmthSE5L?=
 =?utf-8?B?ZUNDcGtLM2drTFJNNElIVHdveGFMYWsvTXpBdExhdWJXc0UvckNIMkNtdkVK?=
 =?utf-8?B?ZDdRZGZYemRyNnNIbjdRaTIxUEZXSTZoOG15UDZiRFdrL2xVOGY5aXQrR2xY?=
 =?utf-8?B?bVVhWDVRNldCVHBrSGFqdzVEemZXTHVja1ovclc2NTdPWUZ3WUJ0QU85aWE3?=
 =?utf-8?B?aTR1RnRKb0IxMjBaVklQNkVabk4vN05jd0pYempLaGdqdWZzalBPQVhFdkZ6?=
 =?utf-8?B?aTdKT0praldtZmdjRmtmWmkwdlZFbkljc1BpcWdEcHhwSS96cmpmc1ptdjN0?=
 =?utf-8?B?dEhNTFZWaDFvbmZTTXdjK2wxajhFR04zWWFRWWdUS0xDQVYxdnVSZFZTWU8z?=
 =?utf-8?B?dTN2ZlR5YzBDdm1kL1F0bHZVN0NneU54eHFHb1FKK1NOaG9BOEJwbHBYeUIv?=
 =?utf-8?B?YkkwWWhrcWNYWElMNFVwUHlkV05haW5QanV0cUZaOEZId25pSDlqY05tUEo1?=
 =?utf-8?B?RzFMck5jUkpjazEraktBWkN1SGRTRVJJQi9pVkFjTnF3NWgzUFJhOGhJMUtU?=
 =?utf-8?B?TG1QZnR0NmJmcjNLWm1MV2hKRS9Ma01tLzAzLzN6WG5OZHpveFJLeVZ6MGYz?=
 =?utf-8?B?bkMrZ2VOT0lIMHdrLzE4a1hDeUZKRC9LZDdnNTRRbkowWHRZczE1WjlzQ1pD?=
 =?utf-8?Q?KgP4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91a36e7-f22b-42f1-74e5-08dc65fad6dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:12:00.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPSb0ShPUaK6K/bV5cU6jYX8eP3QyqWyhidWVLtyh2S89G6hFpJoT+qGO5J0UOpTkdXtAWTLdMNp0EGJRiRRTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9021

On Fri, Apr 26, 2024 at 05:40:52PM +0800, Shengjiu Wang wrote:
> On Fri, Apr 26, 2024 at 4:49 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Thu, Apr 25, 2024 at 06:19:24PM +0800, Shengjiu Wang wrote:
> > > According to comments in drivers/pmdomain/imx/gpcv2.c:
> > >
> > >       /* request the ADB400 to power up */
> > >       if (domain->bits.hskreq) {
> > >               regmap_update_bits(domain->regmap, domain->regs->hsk,
> > >                                  domain->bits.hskreq, domain->bits.hskreq);
> > >
> > >               /*
> > >                * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
> > >                *                                (reg_val & domain->bits.hskack), 0,
> > >                *                                USEC_PER_MSEC);
> > >                * Technically we need the commented code to wait handshake. But that needs
> > >                * the BLK-CTL module BUS clk-en bit being set.
> > >                *
> > >                * There is a separate BLK-CTL module and we will have such a driver for it,
> > >                * that driver will set the BUS clk-en bit and handshake will be triggered
> > >                * automatically there. Just add a delay and suppose the handshake finish
> > >                * after that.
> > >                */
> > >       }
> > >
> > > The BLK-CTL module needs to add delay to wait for a handshake request finished
> > > before accessing registers, which is just after the enabling of power domain.
> > >
> > > Otherwise there is error:
> > >
> > > [    2.180834] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
> > > [    2.180849] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > [    2.180856] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > [    2.180861] Workqueue: events_unbound deferred_probe_work_func
> > > [    2.180878] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    2.180885] pc : clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > [    2.180900] lr : pm_generic_runtime_resume+0x2c/0x44
> > > [    2.180910] sp : ffff800083423a20
> > > [    2.180913] x29: ffff800083423a20 x28: 0000000000000000 x27: 0000000000000000
> > > [    2.180922] x26: ffff0000c0e4e410 x25: 0000000000000000 x24: 0000000000000000
> > > [    2.180935] x23: 0000000000000000 x22: ffff0000c02afd20 x21: 0000000000000000
> > > [    2.180945] x20: ffff0000c162a000 x19: ffff0000c0e52810 x18: ffffffffffffffff
> > > [    2.180959] x17: 0000000000000000 x16: 0000000000000100 x15: ffff8000834239f0
> > > [    2.180970] x14: ffff0000c03d0a1c x13: ffff0000c0a03440 x12: 00000000000003c7
> > > [    2.180982] x11: 0000000000000000 x10: ffff8000825010ba x9 : 0000000000000008
> > > [    2.180993] x8 : 0000000000000008 x7 : 0000000000000000 x6 : 0000000000000000
> > > [    2.181005] x5 : ffff8000838b0000 x4 : ffff0000c0e66088 x3 : ffff8000813852c0
> > > [    2.181018] x2 : 0000000000000000 x1 : 0000000000000004 x0 : ffff8000838b0300
> > > [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> > > [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> > > [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> > > [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> > > [    2.181064] Call trace:
> > > [    2.181066]  dump_backtrace+0x90/0xe8
> > > [    2.181080]  show_stack+0x18/0x24
> > > [    2.181091]  dump_stack_lvl+0x34/0x8c
> > > [    2.181104]  dump_stack+0x18/0x24
> > > [    2.181117]  panic+0x39c/0x3d0
> > > [    2.181129]  nmi_panic+0x48/0x94
> > > [    2.181142]  arm64_serror_panic+0x6c/0x78
> > > [    2.181149]  do_serror+0x3c/0x70
> > > [    2.181157]  el1h_64_error_handler+0x30/0x48
> > > [    2.181164]  el1h_64_error+0x64/0x68
> > > [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> > > [    2.181183]  __genpd_runtime_resume+0x30/0x80
> > > [    2.181195]  genpd_runtime_resume+0x110/0x244
> > > [    2.181205]  __rpm_callback+0x48/0x1d8
> > > [    2.181213]  rpm_callback+0x68/0x74
> > > [    2.181224]  rpm_resume+0x468/0x6c0
> > > [    2.181234]  __pm_runtime_resume+0x50/0x94
> > > [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> > > [    2.181258]  __driver_probe_device+0x48/0x12c
> > > [    2.181268]  driver_probe_device+0xd8/0x15c
> > > [    2.181278]  __device_attach_driver+0xb8/0x134
> > > [    2.181290]  bus_for_each_drv+0x84/0xe0
> > > [    2.181302]  __device_attach+0x9c/0x188
> > > [    2.181312]  device_initial_probe+0x14/0x20
> > > [    2.181323]  bus_probe_device+0xac/0xb0
> > > [    2.181334]  deferred_probe_work_func+0x88/0xc0
> > > [    2.181344]  process_one_work+0x150/0x290
> > > [    2.181357]  worker_thread+0x2f8/0x408
> > > [    2.181370]  kthread+0x110/0x114
> > > [    2.181381]  ret_from_fork+0x10/0x20
> > > [    2.181391] SMP: stopping secondary CPUs
> > > [    2.181400] Kernel Offset: disabled
> > > [    2.181403] CPU features: 0x0,00000040,00100000,4200421b
> > > [    2.181407] Memory Limit: none
> > > [    2.463040] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> > >
> > > Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> > > Reported-by: Francesco Dolcini <francesco@dolcini.it>
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > index e4231e9c8f05..cb44c460548e 100644
> > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > @@ -6,6 +6,7 @@
> > >   */
> > >
> > >  #include <linux/clk-provider.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/device.h>
> > >  #include <linux/io.h>
> > >  #include <linux/mod_devicetable.h>
> > > @@ -362,6 +363,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
> > >
> > >  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
> > >  {
> > > +     /*
> > > +      * According to the drivers/pmdomain/imx/gpcv2.c
> > > +      * need to wait for handshake request to propagate
> > > +      */
> > > +     udelay(5);
> > > +
> >
> > https://lore.kernel.org/imx/20230727152503.2199550-1-shenwei.wang@nxp.com/T/#m2dc5111e9628235f031c0bad2a137222b0205a61
> >
> > supposed clk_imx8mp_audiomix_save_restore() is that write save data into
> > some registers.
> >
> > See above link for detail, it may not delay 5us before write to register.
> > You need
> >         readl();
> >         udelay(5);
> >         writel();
> 
> Here we need to wait for the handshake to be ready,  we have nothing
> to be read.

It should power_on by writel() at somewhere, maybe gpcv2.c. 
1. writel() //power on

2. udelay(5) // in your code,

3. writel() // in your driver to init  audiomix controller. 

1,2,3 just distribute at difference file, but basic work flow should be
the same.

If here nothing to read, you put udelay at power_on code, maybe gpcv2.

Other driver may meet similar problem, you met this problem just this
driver running close to gpc's v2 by driver probe order or compiler linker
driver order.

> 
> but I don't really understand why the code is commented.
> 
>                /*
>                 * ret = regmap_read_poll_timeout(domain->regmap,
> domain->regs->hsk, reg_val,
>                 *                                (reg_val &
> domain->bits.hskack), 0,
>                 *                                USEC_PER_MSEC);
> 
> If we uncomment the code,  it can also fix the issue.

dose git blame give some clue or ask original driver owner? 

> 
> best regards
> Shengjiu Wang
> 
> >
> > >       clk_imx8mp_audiomix_save_restore(dev, false);
> > >
> > >       return 0;
> > > --
> > > 2.34.1
> > >

