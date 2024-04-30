Return-Path: <linux-kernel+bounces-163266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501BE8B67FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B9DB22A38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF1D29B;
	Tue, 30 Apr 2024 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jrQ6+cwu"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C88F6D;
	Tue, 30 Apr 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714444009; cv=fail; b=sT583sqTciz3woad2tlgT+crAGWL6kvcIL78Uekm9i/9HaesZn9FAHp8ixLfCbO4c+BfpsYUK6RjSyVRQGh3Xxu8Siclb5b36YzeTu+N7PIxPxrNm1jpzB8Dnu61lIa2nnftxjGsfwCsBkc5qPjBEjDh7aziCj3LF1FRAmnEA6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714444009; c=relaxed/simple;
	bh=dQSPoLDIcVXVrv0tT04ckAFmdGEmehBwmhmU9tWQVAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANmn87iutPXW9KtcOqGCSlIDZqquZ/ZBnaNtChsptLw+vI7qJvxngM5SFJGOvPxDFPiSZWwJnn7LgnxXXK833PSOouEqjdFYOYajd2RdP+1olk4nfd2OJwoEIgufIbTUBz76FJP+vGpZE/HSTGlySegjX8eub0WDY4ITSOXrjas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jrQ6+cwu; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doDv4Uh1O3TMrPbmopdu+qH83dFCRh9LejiCq1n/F64upT+SYvd++Js95ZHIwPSkDRhw070jtXg201CPcGANN/GUsXDei1Jd+YBHDtCA5IWqYT0aUypf1gCNGr3hOT624lwmjwoHclEonD9XMQp8xDeYxQzzy3Llw9Nu1XRo2OrP/BWIF94WuWdNErru3h5gT/VKlA1NF5tR1uPys9/WoOhZqP4ygJSulr8gYqMvr+tj9X3zE2c2g/jIEQ4A8n3YsJEUFZrkI1gpqTteVFB7GbCwBdnl3E8zUrhvYyHMHDfp5pxkfZU+N7HhVHrhkSspewq3iU0IIKRT115oSs/v2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvk2WSknsLFBnpPpKJal9z4Uv8JTVSedgC7r7i3QLwQ=;
 b=CqT2w9zfsUp6frm8dmuEDZKDeJrDZt3eYn5p7VoykDHEIB63idbJKyX2+FAQxIVzwXkHRsrDsaip7erxnp3yt/zJgCwNvZOAQWW041mAiinUVE58RGa4MkpylOm7yL9SPrf4UEb27HtyM+0ASjgK12x1ZhOEMHOW1W1uNIFaJhyjttoIe32of4U1pV/0xkJHx4iGHjJjZEtj0xVhBSoF6uygPpLA7yG0IirqA44obztAM1DjNEzGGJvKMzSlGIofgukQ6eP/spJ0vslOF+cCNETNI97EGKBwCyIdB+jwzH91s3y+3cdm3CjjWb4XoSIeQyLX1FYcorBPi4Gh3ExjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvk2WSknsLFBnpPpKJal9z4Uv8JTVSedgC7r7i3QLwQ=;
 b=jrQ6+cwulmdlHqFZ+NolDeAaHmsFLs1W6ajmo8CscAuPxb9hNLpCZM17MIa71kQ7ErBQrH39q3Tx07PIdOAAFFzE/445+x9po8ugWi4sSvm2OMEOSWNh6g6GiFUQSbLD2SHokqu/DofCln2Bz4nUFUUVr+Wq7oC/Ch5Aau1QaOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by DUZPR04MB9983.eurprd04.prod.outlook.com (2603:10a6:10:4d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 02:26:42 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 02:26:42 +0000
Message-ID: <be54f273-7bba-4db0-bc52-5ddbb3982d84@oss.nxp.com>
Date: Tue, 30 Apr 2024 10:32:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: amphion: Remove lock in s_ctrl callback
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <20240425065011.105915-3-ming.qian@nxp.com>
 <8c39b3c3-8146-4418-8835-6dbfe38a85ec@collabora.com>
Content-Language: en-US
From: ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <8c39b3c3-8146-4418-8835-6dbfe38a85ec@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0045.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::25) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|DUZPR04MB9983:EE_
X-MS-Office365-Filtering-Correlation-Id: 49640a1f-f84e-44cd-b1b7-08dc68bcf906
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFJYZDZBUGlsbDJKZVhLN05QdnorRDh3eE1lcTRRc2FXWnJ0UCtRSzR4dmc5?=
 =?utf-8?B?T3dOUWxnVDRUZEdaanZkOFdNRjBjQWhrN0JFaGlNUEMwcXZoTXNJTG8wcmJR?=
 =?utf-8?B?bVhEVVFHL2tmSWdBT1lLMXJ4d3VISjRGd0VoMjNEMkZsYzkrNjNNRzJXUWE3?=
 =?utf-8?B?Z1lBVjQ4Tlo3Q1ppdFpvQVlabU50dkJtN0hTZnB6eW1FQTM5YzBmbk50VVZD?=
 =?utf-8?B?MXlQei9MMG1EaWRwS1ZEajRKWWxXV1hXVTlLREhFNzh0TDZtYTVHaHJqZGtN?=
 =?utf-8?B?bFNiSlZHNEVuOFBVeGwyRjdQem5xM28wQnlOZC9MSzFaZTVhRXRJVkdWTlB6?=
 =?utf-8?B?c0FUc0lpRE02YmNRdUI1NjExb2cvWVd0V0VXQVVlbEZaNXFjcmVkbGVWSTBy?=
 =?utf-8?B?cU8vaTBmWUtTMFNqZURlbXFuL2NPVG41b0k2WjFsYzRDcXpNQUhMS3V1ZVpr?=
 =?utf-8?B?RzVpb2lUeWFVNDhlbU1rOUJ1a3AvZUxNL1B1TFF1bldIb2krekFKcDNLUVhD?=
 =?utf-8?B?N2lya1ErY0dlV2w2TXBiS0pVZWc0cFJkcEFibjJ5V1E4aUpYZjc4eXlpeEpk?=
 =?utf-8?B?aVlLUWxlOVQzdnJFK3lDaElEMy81NWtaNEZxRFlKMHc3eU5iZ0xheUMyclBT?=
 =?utf-8?B?R1diSmtnakFValFMMXRIZzNhWVloeHFzTzZhZm5UcEdITUYyUUplRVo1NHVQ?=
 =?utf-8?B?a0RNVEQ2cm9vV2RWWEtSekdJcE9za1JXN1k5VjlBYzd5MFI0cHFLUDRSSHl1?=
 =?utf-8?B?SXFRZW1WZmJTcC9QRE95bko1YnFXeVppLzBvbC85NklEcFpxankvYXFsZCs5?=
 =?utf-8?B?VFJpTFhrUjR5ZVVPRmU1aEtEcnFiUElwK3dPeWZQTDZFdDhSc2xUT1VPK05U?=
 =?utf-8?B?azFHalhYcUJKMXdiWEQrTmxrM2JOYTY1bTVNNG9RUHJXblJRQndTNHUvRTl3?=
 =?utf-8?B?cUdHSHY3TUhYZENpVjZZeEVWUU1VVWxFWmdpZ3c0bHFPMWhEeUdvVEh3NTd1?=
 =?utf-8?B?WlpFbG5DNWlDYTRUdG5QalVpaGwvR2RwcDN4MENFdDc4YU1qN2pocVFIdERS?=
 =?utf-8?B?azRBUGZxZnNiUEhjN2prUWJ4Wm9tU0RiOUcxa1g4T2V5UTNYTjNaUHpPU2t1?=
 =?utf-8?B?dWFSSGc5c2VtS1c0UGxWRzBhZ3lLL1JmV3JPNnh6Zy9PUVFhZUdVelNZRWNZ?=
 =?utf-8?B?cFp3dlk1Y1pleWVnNU1XaGJEQVU5OGgvdWJYRW5iSm9oRmt4RVU4OFMyUjhj?=
 =?utf-8?B?L3RKcDhvTXB4ZVdyd05LMlZnU2ZtQk1nTmJ0aDRVNG12SnBZMFA4KzVEYjJo?=
 =?utf-8?B?VUlMdVJpZ1FwUzNaQytJRUMyUU8za24vM09sbklBREtxVFpkNm44UVBJelBF?=
 =?utf-8?B?Q084U2FIankyU08zNE5zZ3dacSt5NEtMUFVrb0lPd2RPNGlNcEVxWmJHeEQy?=
 =?utf-8?B?NThSTENpMzlzNzgzaVFHZXIyalpTendaMG8rdU00SmxlcjlSLzU0Qzdudmd5?=
 =?utf-8?B?TFcvVDF6bGdzSC9EQ0hZQkJvcDVHc0N3SHdPODd6OXRPckl2RGxNQzFyRFlo?=
 =?utf-8?B?Z0hSZFo3OVg0Q2IxaTJFc3ZBajRnNXlLRFRkdC9NK0NhR1poRlBmUDgwK21M?=
 =?utf-8?B?SVVkWEl2eTRqM01UNi9JeTNZemg3ZDN5MFFBeFA1eDlOdytadENHVlBGbFYx?=
 =?utf-8?B?d0VOdDRIc3JqZTlqRUJvd0ZCazgyVm1XczNXYUtHSEczL1VKcEdwdVlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhlaXJYaXlxUk5EUW1heUZOT0FQRjFnYmloZXdnNjZNNWRZUWl2czBBQ0J0?=
 =?utf-8?B?MTJ3aUpWb1haNzZ1NlZaajZscmlNSHl4N2pZWllaQzRYeHN4bVhmcTN2eVFR?=
 =?utf-8?B?LzNKMFRlOG5lc0dQaEV6TkVtSVF1aDE1TWM5QndGeWQ1S3pvekdwbHRLQ0sv?=
 =?utf-8?B?dTVqOXZ3S1JTbTRwNE9odUZVeUxoMnVacjhIMzFKWW5WUzFTM3VrRG9jWWtY?=
 =?utf-8?B?QndUanNId0E0M0NuWlFsNE14VVVBVVNlMzdwbXRTWFRZUkZtTmVsR3E3VG54?=
 =?utf-8?B?ZUoxWm1LV1NoZk0yZEVuQWg5akdpWE9ERkxzOG9ialhzZ0pLVmIzTHpiS1I1?=
 =?utf-8?B?QkxuY05YVG9RQlAzOUZPZGFyQlQ0NllKck9pTTd0WXBSOVViamhuU0gvTm1J?=
 =?utf-8?B?Mm9kQ1QySGlCVStZbG1RLzAyZU5LNUR5SXhrb0FGT1JaaDlPMFI0QXZtMjNr?=
 =?utf-8?B?RkdSaHF6NW5HWFl1Umo2OVRNR3VkY1BIL28vSmtZdXUrNkNOdFlOMVNBQ1ZX?=
 =?utf-8?B?Nk1IODZSSzFLeldHWmpITWFac1FIUElkUzNiL0VvZksyOEs1ZW1lKzJNQXNU?=
 =?utf-8?B?VzBHV1hZYXdBUWRjV0xISituZll4TVlRVVp6U0Y4K0pxNytRVFNNaWQxbnA4?=
 =?utf-8?B?OWxWR1FaUTVKSG9WbWZIU05rRFNqMGdNTEpKYUFlbDFLUk16cEt2VlUvcFV3?=
 =?utf-8?B?ZkhlaEtISEJSbTVGSXhrV1djWXBmb0JvVnJqQTZzTjZEM3JzWjlwNVFKZk11?=
 =?utf-8?B?eCtuQmhIT0dwcmJpRjBDN2haT241NUdacWhGMjFDWndsaWF2ci8xYnY5dVJJ?=
 =?utf-8?B?NitDazdsQlMrQkFYOC9xbXNCVG9YV2RjY01pcE93N0syQStuWW5NK01CbXJB?=
 =?utf-8?B?aU56RkwwRms5Z1kvWGVnTllnN25RbHZETVNSTDUrMW1lS0licXFrRWxhOGxi?=
 =?utf-8?B?ZkI2RUtjdkRQTnBoRU9uZGFRVkNJM2gyQ0hkRTVhdlVNTWVYam9wR0xGbVho?=
 =?utf-8?B?ZDc0RjZJZ2x2eVNxdEMrQ3Nld2J6aHFUUDJZSDQ0NXFJYm5FV3hNNDArUFpz?=
 =?utf-8?B?Mkp0c0hWR1NSV0wzYlRoaVNBRCtKblZDcFJmRzdlZGlIVy9XTWw3aUlLMDJt?=
 =?utf-8?B?dG8wdXpPeXVaOFdGTWVGWENMeGM0cTgzMHZqaThVdlJwajIwUlV3MnZ0TXQz?=
 =?utf-8?B?NWF3elJxSUU2RnV1c0Fubm9JWmlOT0lsQnFjNVRkUFNTSW5EVjhmd2hHdXN1?=
 =?utf-8?B?Y3laVFZDU3FnSkNQeG5uTGtEQ29lSnBsQk5GcnVTQUlUOWx4MkRUQ1lhbjBG?=
 =?utf-8?B?eGFaV2xiZmpmbEJQTURKVEdVd2tuL3hJbFgxT2pBbTRhcUNub3QvYzZrRloz?=
 =?utf-8?B?ems2TmZUOVpiYXp4RHh1dG40UHQ2cGpESHh0RHN2NkpYWDllNTEraVNzYTVD?=
 =?utf-8?B?QXgxZllXdlBaY0Ntam5jcGhlYkxGTDhqV21oN1hQNmU2bkZzSkNEaURZM0Y5?=
 =?utf-8?B?RXdXb0h3MGZCbnZLMnlzczkrUXFFUjVoTm5JeFhuUlljaUxCYUpHRjVNY3o2?=
 =?utf-8?B?Qkp3VDd2WkYrZm9yL3VGYUhjZHlabXlsUFQ3TTYweENXY1pBUEhUVGE0UVlx?=
 =?utf-8?B?d2dxUHh0WjdCSU9MeFUyekIrRjRNTG40SnBpVXhUalc2NjEwNDN2aDFPR1Bl?=
 =?utf-8?B?dk81cFBrMzlOeXlBSDBhUjRRblBNZzl4QytUc1ZtM3FMNktzQVlCUHdEQk1x?=
 =?utf-8?B?MkVPMjVxdS9GUXZnWGF1NThlbFdHUk1odms2SCt6RjdJTjlCTUcwcDlTeGRJ?=
 =?utf-8?B?Y096OTVNSXpmakZBQ01od0ZnSGZ6aUtITWNRbE14QW9YOXZodytaSllPUExU?=
 =?utf-8?B?OEFkeEMvWVorZEZuVXVXdGNrTC9ydWo4c2NhcndvUVBiWExqZVJXd2tLaXJr?=
 =?utf-8?B?M1VqUFVmNkF4ZGlEQ21PL1VPNjk3Y1RHL0YwcVRmcWx0WGF1UU93c3grc0ZW?=
 =?utf-8?B?WXlIV24vVmp1V0dlWk1BZS9Hdzh1dEdncXZOVGdIRllXUXdXbEhYRFh2VkpN?=
 =?utf-8?B?cHNpak8vOFRIaUU5emJDYzE0bXdrUkxNMHc2UlNVdzlkSXQ4bU51VFdzMlNX?=
 =?utf-8?Q?hN7sPB8DH+LBxbSrVaTbePXrL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49640a1f-f84e-44cd-b1b7-08dc68bcf906
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 02:26:42.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KrQMr7DWq1hu4zolrpqTC8k95F0DaxtzV0p31CK3F3rbPz9I82VNfLTaFYZprTdO6aLZ/nks6unQOTzHdU0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9983

Hi Andrzej,

> Hi Ming Qian,
> 
> W dniu 25.04.2024 o 08:50, Ming Qian pisze:
>> There is no need to add lock in s_ctrl callback, it has been
>> synchronized by the ctrl_handler's lock, otherwise it may led to
>> deadlock if driver call v4l2_ctrl_s_ctrl().
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>>   drivers/media/platform/amphion/vdec.c | 2 --
>>   drivers/media/platform/amphion/venc.c | 2 --
>>   2 files changed, 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/amphion/vdec.c 
>> b/drivers/media/platform/amphion/vdec.c
>> index a57f9f4f3b87..6a38a0fa0e2d 100644
>> --- a/drivers/media/platform/amphion/vdec.c
>> +++ b/drivers/media/platform/amphion/vdec.c
>> @@ -195,7 +195,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>       struct vdec_t *vdec = inst->priv;
>>       int ret = 0;
>> -    vpu_inst_lock(inst);
> 
> I assume that PATCH v2 2/3 might cause the said deadlock to happen?
> If so, maybe it would make more sense to make the current patch preceed
>   PATCH v2 2/3? Otherwise the kernel at PATCH v2 2/3 introduces a potential
> deadlock.
> 
> Regards,
> 
> Andrzej
> 

I actually discovered this problem when I was preparing the v2 2/3 patch.

But in the v2 2/3 patch, it tried to add a read-only ctrl, then I just
unset the s_ctrl callback for the new added ctrl, the potential deadlock
is caused by call the s_ctrl back in a locked environment, so after unset
the s_ctrl callback, the 2/3 patch won't trigger the deadlock even if
this patch is missing.

In order to avoid encountering similar problems in the future, that
driver may set or get some ctrl, I added this patch.

Best regards,
Ming

>>       switch (ctrl->id) {
>>       case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
>>           vdec->params.display_delay_enable = ctrl->val;
>> @@ -207,7 +206,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>           ret = -EINVAL;
>>           break;
>>       }
>> -    vpu_inst_unlock(inst);
>>       return ret;
>>   }
>> diff --git a/drivers/media/platform/amphion/venc.c 
>> b/drivers/media/platform/amphion/venc.c
>> index cdfaba9d107b..351b4edc8742 100644
>> --- a/drivers/media/platform/amphion/venc.c
>> +++ b/drivers/media/platform/amphion/venc.c
>> @@ -518,7 +518,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>       struct venc_t *venc = inst->priv;
>>       int ret = 0;
>> -    vpu_inst_lock(inst);
>>       switch (ctrl->id) {
>>       case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>>           venc->params.profile = ctrl->val;
>> @@ -579,7 +578,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>           ret = -EINVAL;
>>           break;
>>       }
>> -    vpu_inst_unlock(inst);
>>       return ret;
>>   }
> 

