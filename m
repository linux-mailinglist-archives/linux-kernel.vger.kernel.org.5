Return-Path: <linux-kernel+bounces-161256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335C8B49AA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA781C20CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2683AD4E;
	Sun, 28 Apr 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NVtS5JRj"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0517748E;
	Sun, 28 Apr 2024 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714280407; cv=fail; b=QweK6PQ1gaz1hVk8w7xRSu5vnWoMKU6ldyTpSHkMnXbt6tam3FhRJ3Otja8HxKfnoRpTxm1JGEhB9PjzsnElYsBE8ajIGSZjyBhL48pvAkpZRnXiGl1eAQqO816hiJXSCwZgbP2TtgAaqbQAznTVSoMCAiG+m+jhocfoFzLTQuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714280407; c=relaxed/simple;
	bh=WTZ7YwNm/8WPxZlzkPznE0QEoAFR6b1n1hH0qOGF9Rg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=icZRgAEarYtth9e2Yf7LcwiDkqlvmCgXkaZHBRe/EV12/wzHXHhvcEdboeFKG9hPJWYbV4Y2uauiDVjGTOpLyIO97LhvmVzo5m6oBjxAAiAhvJdQj5N6yEZ3MSo4BPR/iV4ogzlB2pyVdoguXfyfinkwEwOmU5Ip9+zopdPXHQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NVtS5JRj; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbUrlaaNrigT1acm3Zki0/WI4DIk8d3kGs9bClmG7e0VkPWt+MPVA3+x69nEl2EIBOUZUUQ3854eBzrYXmmNHY9AK99bOkbdilScHken4lKIVYt1IrQLhWSxjv3PZ+uNMmX7DLY/q4snd5jAI+bnxFr+gJ2pdmN7wQ+CvmFkGXFaitNDq/x42Bb7j8roaOIh2a/Hdd3VzHBGfc6PjYlpnUrhudvjNjV6plNlKGR+YqoHCvx6i2Vxb2GxVOWQNalUvUU8dFz6A9iXiRyvcAkO2lhvr31cpxyCz9hosVJw8oNPa4VrFgepWbHAfwOAWPy7zR1rPtgVsqIR7DIMsQVn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12DFYM63ULaEgVDZPXt8ffcWw3R7pE947r7KT9S2Pyk=;
 b=DVa4acmpQUVk492OawZuGEaYN5SzmOxX0KMZjpcJa7vRdk2KSBlrLKu2yBLeHDomcm0UQdNPa2kfbAvywFrYWTvqtqQUzOoa4oMDTCe7brXCGQfm871p9LHMiuCUWwYaRfm5HpGHW7TlGvFtxZh+Z24FR0hG/K8NpbLGu2klj5+qpO4bWg0dZZZvFnq+c9p74/fM6fPTKSOiXnvnw5EGPlRTsP1dFbnFJ1uQrzTzxsZYJxiEkgUCE0YV6LfosLfTe4ekFcNUjncgvVTW8ZS2oh8S9mYiVc6mFpAEcfBzuox1eD0tZ/7ya6MsHzcqVRlhgcxsOjcYwkTC4tQsnxxraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12DFYM63ULaEgVDZPXt8ffcWw3R7pE947r7KT9S2Pyk=;
 b=NVtS5JRjmSI3SWh+kIs/ykk1QkfJzM5YBiuaASaUZsTBvxc+eao92gPejl1/7T2rbC4+P3zDdpAqoOXGFxKRD4g3PWDDXK6TlI7EYhlXhK93h7+TVdCojcQQldjyB0KjQTjaRBfvXCWwkhhOj4ioXCtAO0LMEGMWAZKgIC0AmpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 05:00:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 05:00:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 28 Apr 2024 13:07:47 +0800
Subject: [PATCH v3 1/6] dt-bindings: firmware: arm,scmi: Add properties for
 i.MX95 Pinctrl OEM extensions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-pinctrl-scmi-oem-v3-v3-1-eda341eb47ed@nxp.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
In-Reply-To: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714280885; l=2762;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=07Om+tiXUr57qz8djpSP7JUajKxdHALgoEKb63kMR5U=;
 b=J1+j4wOe27traC7/Vk46N824kchuD1DuTW9xInAQtGcXdW8OsNfTEPTqr+F1xz8aUmfggw+on
 yxtXneSafuOB5VG9NUKRPGezU57/JIds11HsAWhxGWnOVO5Fy8Fx3I4
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0245.apcprd06.prod.outlook.com
 (2603:1096:4:ac::29) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: bf78fab4-5567-481b-5d7e-08dc67401046
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|52116005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFdYL0ZQQnExQW02MStvUWxPKzVjK2F3SVJIWVhoUVRBODVzaUVWOEhzQ1Y5?=
 =?utf-8?B?ek5tNDZJbHRrR3NBeEMrS2hFb0V5b1hldFhzVkNxNkgyMFZFaUg0TUxuMW1z?=
 =?utf-8?B?WkllSklZalM3UDFndXVIeWRGa0xjTXU4TjBCa3QzQ28ydTNNbGVsRTB2SFVy?=
 =?utf-8?B?a0xkOEdpRmtBT1FzVjlDWWRhRlpqVmRhZm5qbXR0N1laRHgwNXdrcjl2NHlD?=
 =?utf-8?B?TTh5elBwc2EveStTVVVJUkFpNFlSUGh1cTNycHJVQmVZWXNyOFJNUkg3RnEv?=
 =?utf-8?B?VkE0aTBsR0M2WDB3RS9pSjNsa2VhemlSYWRiSFFQcGlqUnhnUnBYRmw5L0Yw?=
 =?utf-8?B?UjJOS092cExjeXVpcThNWm9YVStyeXV4Zm04aWk0Zk1PcmYzK3FmU1dtNkd6?=
 =?utf-8?B?ZUFtMlFHZjFaRjlDYUpkUHByWHR5N2VqTStQdTI2d0c5QUxLT2I0R3I3MjZ6?=
 =?utf-8?B?czdpRFdOODV3cm1FR0l4WkMvQ2hEQmN0NVJYSWhwY2s2QTJGVkNFNGlOVkVM?=
 =?utf-8?B?UXcwUmd0KzhZaDIvTmlHanZzRng2dE5pTFp5aWFWYytsc3oxdnNHc3N2citZ?=
 =?utf-8?B?K0tlM2RpMHc0YTYvNE1KSmJMS0tScVppbG5rdlNYeFZvR0lRSHVXRmo4NFd5?=
 =?utf-8?B?S2VuemhqMU9QbkRyYm15eEpsUWdnZXdheFo4T2tWdkQ3MkU5MFZHQk9sN2Ry?=
 =?utf-8?B?YTh0YkYvV0xuSlRMTVVDVUJVT3hSYWpyc3VicWZIWkVRakNCY1B4TGJJN3Za?=
 =?utf-8?B?NzRjdmovMjN3M0RmaFRxd2o2eTd4cEJFUyt4TzlKZ3hJVzJEa0dCeWRmVFZU?=
 =?utf-8?B?K000Kzg5SnQzb1pNakJRVE1neUpJeExIem15ZkVlcWE4bHNkOXQyY1g4SUpt?=
 =?utf-8?B?RVFXVkF6a2tNdkg3MTUyVGtkalp5NEJKQjN0dktSUGVtZUJZakovTDBUTXpj?=
 =?utf-8?B?YU0yZHhvQkJNVy90WDJ1MW9HVmJ3V01sVHltNkR5dGxLYmZGSEZkbFE1WmZM?=
 =?utf-8?B?bk42UytiTDZtNTMxOXpkcEN1ZXVud1NGYy82dUEwWUM3UzVNVmxEOUY4UFJu?=
 =?utf-8?B?SjkxMGhCSlNRNTh4L1lXRWl2Q25pT01ZQWk2SjJDcXhSSW01RVZ4YVRRcm5T?=
 =?utf-8?B?TXdrZUpENUkrVldxcGpKWTVYL3drdmJaWnk2c1pjMHZrOHNGU1FjSTJ6SXFF?=
 =?utf-8?B?a2VKNW5vL2NrUEt6aDZSbXZpeklJQ1V4MHlmcVZHZlJYM3ZhbUhRTFpLU1pC?=
 =?utf-8?B?eThKRHk5SDdpaWs4dE1HS09namxYZE5vMVdYWkY0SitLdW8wVk9PdDlSai9D?=
 =?utf-8?B?cUNxWEZPMEk3NDFGREJpbVJFWGdUMjhwSW9ud2ZRaWp2dTkwTXBDTk9wUmxa?=
 =?utf-8?B?Mk52SnlBc2xWVlFQb1AxR3NsanFOTUpSVUw0V0o0bDNsNyt6dkRDQ0ZUTG95?=
 =?utf-8?B?RXErNVdsdmM1ZGUwUFIybHZoSGMvT2g0ZFRzMkR3WkRST1RVSmdUaE1UVGdC?=
 =?utf-8?B?aWhFKzlaa3RoN2lkbjZqQXp1Y2pWb2VERWErSUorTVVoejFEMzBrVmEyZTZq?=
 =?utf-8?B?WUhZYURmZmRRbm9oSnRwNzZJZjgwZllMWnh2Vi9Fd0IxcE9oNXBVME03aExw?=
 =?utf-8?B?ZkxTLzNoSjRxUFVOQnpLZlVpTnpoWWN2VmFXM2IrY2Z5N2plYzdocmtaOU9p?=
 =?utf-8?B?a2FOZGNMbDVHMU5oT1h3dzFnWEVxVWl2bFVraWp5b0lSS0lsSEZQQ3Q0M25j?=
 =?utf-8?Q?h3n0+MJmoEotcBZiLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWtzMm1WU3RUanRlR3FDK0NsaDJzMHMwTDZhMTBZLzg0Z1orREtjSG94dEdF?=
 =?utf-8?B?aWR4REZxajlEY3BGSEVYcXBNbmxoOHJwQ0Y3eEN1UVhta09jM2xDRzRRR21j?=
 =?utf-8?B?OEwreE9PdW1YS0dMWlpWOVNaRHljRjc3NW1nZEw4RG51Mkh6b2lJL2JDNmMz?=
 =?utf-8?B?SXRkN0NFRjlDOWRINlpnSDJCOUdmOVNlbEFDbmhhNHJDWnlkM3BYMWRGUGRa?=
 =?utf-8?B?OEI0Mi9yQjRoNk5rUFB3UGljZloxQXhqRTdYOU5DbWhqWG1tMVRVNmkxTGdj?=
 =?utf-8?B?MWtkK3dLbXhvaytaNmFaMDFXb2dlcU1SeFJJUmhlQzNsTXV6V244QnNEMEJz?=
 =?utf-8?B?TGF0N1NrQzZ1d2t5MHBwOFRuMzA2aHpKL3pBYmo1RHhOMGJYak55Zk95TEdI?=
 =?utf-8?B?REI5aitCQXhhZ08yeHpsUFh2UVZzWkphRlB2bFdoS1ZRbTZhYld0UWhPNU5I?=
 =?utf-8?B?aERhUm5Td1AvdWdqbGpwUFVIU1E4ZldsMWJic1FyZjhMSVVRc2E4SWpOOE9a?=
 =?utf-8?B?NTZxQzNkTXFZUm1LQ2ZMUzU0L2gyem5reVdHakhkZXYzMFdUS3Zqb0dOMStV?=
 =?utf-8?B?aFhXYzhQRllTV2s2Y3djdHBjYWVsa3NQYllqTThEYTRJS1E5M0ZESlBkVlFv?=
 =?utf-8?B?V1ZTZWJoMEZkd1ZONlI2cnMvbjRDalNUQ1hTMWY3UXBFZ2tPYi9Rb2hVYWZw?=
 =?utf-8?B?eGNaRGFoUGdaQlV4RjhKQXh2UFp3T2RvRUVZcmpySk1kbFMvOW5UbVUvcDYv?=
 =?utf-8?B?VVBOMjVyV2RVVmV1ekVSRGp3TzhIZFJiVU1ZQ1NjVVREaW5OUWpnY256cjVM?=
 =?utf-8?B?VnZ3Qkp6WWlKME5VRGM1ZDQ3UUpBNTNDa0NQRm5WUXVRNGJXamVodEpQd2Fi?=
 =?utf-8?B?UW83SUZqOUFzcGdMNUVzazJmV2o4MVY0RGgxY2x1Wno5WTRDQ2xPL1JQZkhw?=
 =?utf-8?B?ZEJmY3hiOVJCaXJxdE1KV1NXcjVSTFZ3dHM3TTlwcm9VWnJWb2dSWkVnVnRp?=
 =?utf-8?B?Qm54aHB4bW1nR01xMVlPTkgxUFg5bHl4amN0WWY4YzNmUXU0T1JDTUc2dkhX?=
 =?utf-8?B?bldjR3d2eTVwQmkwaFhQalMrZll0YkltNDhBWCtJQXhmT0Iwd0hIVXdaT0NC?=
 =?utf-8?B?VTZRTDVzSzJuVFNTN2FZaEc0L0tDNi8zY1E5Q2sxaXlDS1N5STVBTExYV0pL?=
 =?utf-8?B?MkxNdzFzYmgvL3ZaSUMxN0RnSUlPdkR0bDY4MjhoQ0RKNjB5dS9qY3FRSWNh?=
 =?utf-8?B?d28yaHFRMVNGblcwNEFQM3NaWDZ0MnJlOElaRm5lbHFIRnJvVzNKdWlqWVdH?=
 =?utf-8?B?ZVYvKzYyT0ZSc00rNWticVpQUmVkcXhYZU1oKytwbWZqUjE0ZFpGZnBIcWFj?=
 =?utf-8?B?T2UyQUdpcFBhRGVSRDhaNG0zaE0rc2RxdTk1QUVicFdJWWRsRHZ4Q3ZneThW?=
 =?utf-8?B?SmJKdGY2cWdCcCtRMmZNN3FoT21SWWw4cTM5N3hIa0RuL0owZ1lWU1gzbXJO?=
 =?utf-8?B?OFlIMVB5SDAxRGVqM01rcW9rWkYxSFAyVDRBajNFYUM3WDd3aDFXSTlRMkNr?=
 =?utf-8?B?Y2s1ZzNDZnppdlFGZC9jaldhVHZXby9FZS9hVW1abHcza3RHUjV6RlJMUURL?=
 =?utf-8?B?Q205TmVKaHlVcmM0UE1BdU1KUFdLQ1oyam52TjRxRG5tRDVtZGFaZkNxbTV6?=
 =?utf-8?B?Tk9PMGFIN1Mxb3dsdGNrcmJraHFXL090Y1UxN1JFK3dqeVRqOEhlQ1Q5Vkd6?=
 =?utf-8?B?dE9iN3dWbjllQ2RaRFg2ZEhBUVNhbFVNUXFzcmJieE55T25iNkpMK1hpVVlZ?=
 =?utf-8?B?blAzTGppdUQ2Qlc4dDNlZlYxZTFOdlplWUEvZUdVck1TZ1gxZGpyZ3VJQmYz?=
 =?utf-8?B?Y0p1RlFDL0VxL1hYanowU1c1eGVCRkRJRmhNQ0lFRzB2NnFIbVJHczFQTmFI?=
 =?utf-8?B?ZTIzcEg3RlRWN1FicW5RbXBqQURxVENSejFjVTFRR1ZXbnhwRzAveElRblpt?=
 =?utf-8?B?OXp5YnAzTHdhUUJLeHZJMTBGaDcvaTFCOStNVlRZdDQwV1lzc2kzUlZ2QWZX?=
 =?utf-8?B?N1dXcEhPUmJ0WUlYN0R0ZmJQOVE4NWxtcXlCUjdGNDQ5eFRIc2VRMnFSNVdw?=
 =?utf-8?Q?IBIZNAu0SYyFSCBuYFB5LyKWW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf78fab4-5567-481b-5d7e-08dc67401046
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 05:00:02.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YHBxCDcV958UZAmTVGkuT0FGR/m5avdlraJ3DdeUbYz1fDuDu2kO+cJRijWmkO7bxMocD/DQ9+9v13xS39SnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

From: Peng Fan <peng.fan@nxp.com>

i.MX95 Pinctrl is managed by System Control Management Interface(SCMI)
firmware using OEM extensions. No functions, no groups are provided by
the firmware. To reuse generic properties, add the binding to enable
pinmux, slew-rate, bias-pull-up and etc, under a subnode of '-pins'.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  9 ++++--
 .../bindings/firmware/nxp,imx95-scmi-pinctrl.yaml  | 37 ++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 7de2c29606e5..bd4dfd7a85cd 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -262,9 +262,12 @@ properties:
     patternProperties:
       '-pins$':
         type: object
-        allOf:
-          - $ref: /schemas/pinctrl/pincfg-node.yaml#
-          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        anyOf:
+          - $ref: /schemas/firmware/nxp,imx95-scmi-pinctrl.yaml
+          - allOf:
+              - $ref: /schemas/pinctrl/pincfg-node.yaml#
+              - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
         unevaluatedProperties: false
 
         description:
diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
new file mode 100644
index 000000000000..1a694881f193
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+patternProperties:
+  'grp[0-9a-f]$':
+    type: object
+    unevaluatedProperties: false
+
+    properties:
+      pinmux:
+        description: |
+          An integer array for representing pinmux configurations of
+          a device. Each integer has the format, pinid[31:21], mux[20:16],
+          daisy_value[15:12], daisy_valid[11:11], daisy_id[10:0].
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      drive-strength:
+        enum: [ 0, 1, 3, 7, 15, 31, 63 ]
+
+      slew-rate:
+        enum: [2, 3]
+
+      input-schmitt-enable: true
+      drive-open-drain: true
+      bias-pull-up: true
+      bias-pull-down: true
+
+additionalProperties: true

-- 
2.37.1


