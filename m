Return-Path: <linux-kernel+bounces-162377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069778B5A33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABFC1C2162C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB4DDA8;
	Mon, 29 Apr 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="cF11eXIJ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2111.outbound.protection.outlook.com [40.107.7.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4853C70CAA;
	Mon, 29 Apr 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397776; cv=fail; b=KvqtDJkXN5zLnBCs0u65dz/Yw2RHUZvBsxteqi7s2kjP5Y5+x2HoR+MAvbhu8lvTFL+wRMOZml9MXabqHELgbEpqS3BLE9zTi7ZlBBmrVlzmI7T5O/5kRO/5pccT6puXapcXHSM3MiSoiVxlCuV76tfFTw83qDavUHkQrtN04Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397776; c=relaxed/simple;
	bh=mPz17j8a4IHEa0xQ3LIdo6bFeELnHmA0q6rbRgSPqyc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BwnUTMtdhi98L4HOeJTxw2Wyav0VzIoKryrFSOkdhT4Z+GcbHo9JqTXZvkJp25GQXZI4YdpcTffLuXrWmsWRDW8CmwEj02JjNuN+rvVQZTd6AhvOiTmtwJur8U2/cF/8u99sbFgZdT0VRdQr7hp3DgImNEKnRGg1Dbjuub5bAig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=cF11eXIJ; arc=fail smtp.client-ip=40.107.7.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb6tKmkrUONOxqwVdaJAuQpbiZI/H1F6kYs9i9TErdG7ULjUrAWj069lErpyTDVRROP109jR5Lp0xLXkgWclL4vblYVUREaxDLkT8zGHaJYN2TXmtOPEmewrsUsURD9Z9P+TbwhXVK0mGP1cnnhjQ+vul6dWZRn9i47la7t/T2xVp4/QWPaZGhb0BCw8Cb6pJOza9mj0GOLT0u4W1iF9XzkkbUK3iVaEj4lvex6dJwpmZV0lZPLojLd15vI22CY6IpU4eI7s142LVX+Mi8fOiis7Xz/MAGHF3i332GQOhsXznUxZeY6AFgL0gYbuDOotHVYGT+FvQdGu5ZPy4TtH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncjrC3kUTsgVty4+sjzIsJ+cO+ZALoxrpo3b3eMhqM0=;
 b=ny2eep901htm7oFbrQVtp+5sbVsBZfndimNNer2Y7jD22S7TRbYcLQ+I6yicAAB5tsVZRB7g5P6Sj5hAx+T5M9tXfr06su/cWk+pQOZ9JMtfl6GaKobf4eMI2JAnO4K8ttTLHNOLKvCSgEqcGnvC0KZDvLihnPuZCreDuBp2vFD2hndfrYdzZptM5fjfWIYeU1/Ivnpsgnw5v2qr2HPScgMKwG59uuSRRILE7P2m3YAqQmBXa4voGz17/klnXokEN1KnBPVlDQU70T0LWaO4SBoxtafxmGIUkjkt7faBs+15Zpve1we+beTvSozzU+sq+krmZ182+N+XVgfgZwsERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncjrC3kUTsgVty4+sjzIsJ+cO+ZALoxrpo3b3eMhqM0=;
 b=cF11eXIJ+bxHWzp+HZwrWsTWqY8lwQdN07RaM49c1/+eCj0mV2zIMZZs4YxPpTu180R1iGsQbhC+CGUbOBzTeCOwllssJqXUT4cHa3evxWsvjP52gzYaAuBaGB3lGUD/SpaQdHLNyKqj0Rr3mAYC+SsHLUZi40oePtyJof3unAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6087.eurprd08.prod.outlook.com (2603:10a6:20b:29c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:36:11 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%6]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 13:36:10 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 29 Apr 2024 15:35:57 +0200
Subject: [PATCH v3 1/3] usb: typec: tipd: fix event checking for tps25750
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-tps6598x_fix_event_handling-v3-1-4e8e58dce489@wolfvision.net>
References: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
In-Reply-To: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714397770; l=2021;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=mPz17j8a4IHEa0xQ3LIdo6bFeELnHmA0q6rbRgSPqyc=;
 b=zm/dkARaTTq5ui496GhXZdoMyCKpZqc6SvpP0mvKOdmivcIgsvJC/Xfw/mAypt+SEmEaG66mV
 tA42EgNcm98DehkhDIJv9MiTtIXqcXOQ4+HkhIg9idWqukNcEwoP07M
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: dada9d60-776a-4daa-8b8a-08dc685154e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEFlWWZoUzM5MG9vb05TbWRwanJWbGIzaERJMFJHS0d4VGRNVExQU2thZkJJ?=
 =?utf-8?B?MjFwQU4wL2MxbzFIN2tLajNCN2VEVmJwOHBnRHlCSUlQd0YvUkgrZm9WRWxa?=
 =?utf-8?B?MGgwYXpHNVo3UkdPQ09pZmlDSWR0K3N1Vm5yb2grY0NZMTdFNlVqcjdvVXBW?=
 =?utf-8?B?OG9ISlVvOFNjZmRsS0NPOWU3ZTNuanc2b1pteCt1c1NRbHo4eTFZUmh0OHcz?=
 =?utf-8?B?VFc3ckdua0hRRGYwdEFaSGRlcUh3cktia1d4bGRmeDZiOUwyQ1BjWEFjNlZn?=
 =?utf-8?B?SDNIbUlyQ0tPTmx6Y2tVdVg4aTl1em5kbWVmS0l6M21ZajBCS2plekUyK1Z6?=
 =?utf-8?B?SkF1V1VPUXZNY2FOQXd2TFJNWVRZVG1IRjVhTG55dm83eENQTWlwWUtLSnVa?=
 =?utf-8?B?UE9ublRkaVYwbFB5eXM3NWtac2RlOUY5cDdPUG1NZHI2YlVVaXZjRjdob0NY?=
 =?utf-8?B?UUdwQU9kVEpaMmE0b0xFbE5MSXRRcmRDdzI2S0FBY0MwWnRNbkk0MTBGWnNE?=
 =?utf-8?B?N0lSOEtoVHUwSTd6VUx0c0pLeUwwcG01MC9rNnlVQTZGSy9yS1c0RExOT2ZV?=
 =?utf-8?B?Y3Jzd0hueXdGallBU1RIQ1RCZmtianBhT21oRjlLaEJEYUJYeHhPV05kUDY0?=
 =?utf-8?B?YkVOc3UxMjNXTGRpeUFmbVlwVFV2RDZaeEVEYzVTdXJ1Qk11YVJudkdzbHZH?=
 =?utf-8?B?TnVocHZ5UldsR2NBN1JIM0JXL1RrUWNCeXJWdGp2TElMejRXYW55dWt4VWVo?=
 =?utf-8?B?VFVXRXJnRm5SL0hZTjlucnV3emVTNDg5VzJxVUJxNUs1N0FiQ1JwSVRZMi8r?=
 =?utf-8?B?SzJUbE9GTFRXK2xxWERsMVhuaGVPZnFBaHNraVhEVXcyUEVlN2VYYzVzbzhk?=
 =?utf-8?B?cUVBd1FjcE85cVp6TmFXM3Y5YVZMeXhmNk9abkhEYW0yMUIveTJpOFVtTHVK?=
 =?utf-8?B?a0NMaFA5QlhOYzVpeFZ1V0RuamxRSThlQWV4NEZQL3BKbk5Za240NlJRSjZM?=
 =?utf-8?B?V1Q2bHpGZU96MjhWNWR2OVl1SG1IeHNhV2R0bmtwdkxuR1RhQ3N6VUExN1B4?=
 =?utf-8?B?VFlqWTJLZXBTRTR6cThYcklmZURqVU1aM1A4ZExpTUJBNnNUQlJCbE9rSkJk?=
 =?utf-8?B?d0NCRDBWb2U5SXJoWDJYRHoxWFNZcG1KNnNxN1lUQWJwcXJ3NWhSeE9SbTFy?=
 =?utf-8?B?cHFZWVFWUW9JMWREMC9RaFo1dUl6WUVGd0dFQWlDVWxVTjdKdWhXVGFYWTNQ?=
 =?utf-8?B?aEZibS9iaC83SU81S2F3QzBSaTZLUmp3cTc5Z2g4S1ZXeXNhZU9WM0Q3ak0v?=
 =?utf-8?B?eGVhK2FZcE1Xb3JvMGpnSFV2WEFCV0dzY0JvMVFHZjBJd3RDa3krNkVjayt6?=
 =?utf-8?B?WjZBTmF4WUVTQm9Dc2pJR3dEN0FseFRBdTVzSlNveG4wNzNrKzdhd2VtclZB?=
 =?utf-8?B?RGw3bW4zWllQbjBXeTRhNDFWOTlvNTV6VVJpSVhvUkZrZ0h5ZkE4MUN1MzBq?=
 =?utf-8?B?VU5TVFJEZy9aUmlFVGlyanZJNmV2SkMvWFozeWt1aTN2Z0dDcGxvcGlzeVhP?=
 =?utf-8?B?ZWJ4QkE4aGlsc1NYdTJIWGI1NG1SSU5yTWtqRkYwQkdScVNOekRVblNuQ0Fm?=
 =?utf-8?B?UWZSMm0wTUlxTXh2REFUd3NobkFwdDM4ZnZWek1UYUJnU05qS1UxSlh1b2xN?=
 =?utf-8?B?V1BKZmZxcUtVNjFFRzJRMklwQjB5WGN1Z21yZ2NoTkkxekNHL01tMDlpK2di?=
 =?utf-8?B?cld6WnlwbWhTWUExUUxzRDZWTUFOR3V0UUZ5QzZMbXVOYzNtcEM2S1NtQWJw?=
 =?utf-8?B?N0huK2UrV3pRWm55MUEvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUhhaG1tWHRFcGMwTjAvakxSV2VkTytOdm9zMi9ZeTZOeW1lZFIrdUZuKzRv?=
 =?utf-8?B?eGZhbW0wbnYveE9rZmRZOExZWjdadThlaVNMME00VVJBWnNhMlZCWjg5bUZn?=
 =?utf-8?B?NUVYVmlTMnJtNjVQSTk3V254UUE0YmlmSnVURUpwTDRGMURjUU16VVFrMEI3?=
 =?utf-8?B?djVCSUhPT0hvTFdyWitPYjhqdFh5OEtobVROSC82RGU4eVBCQjI0SXVWVllx?=
 =?utf-8?B?L3grb1NIbmJrMytDYk84T2lJQThlRFRQZXYvS1hGOHdJRHVuRDNYYUtDRmdJ?=
 =?utf-8?B?bVRwNVhlbk5xVFpQSlBtNzRhZ2RhcjhJTXFPR0NQYkd1S3VnWStYamZmVG1N?=
 =?utf-8?B?Z0FkVDZuTmhMbW54YWp1K0xCamJ1UmtxYUZlVmxTQmlCSGQxQk9OL2syV1dS?=
 =?utf-8?B?NzhRZGVPcG5HYkhTMzFyOUhIbVhjVk9pR2RiM09sTURLZlBCbVJNWFR3ZkVn?=
 =?utf-8?B?cHNGWlFUS3ZCS2FZNFplTnhHTlkzaGhmUDB4RWhESzQ3eE1rQU55RVVHVXg3?=
 =?utf-8?B?ZkVkbXJ6eGptQ2pWVngvMXdUQjhyTmlOa0ZXMGtlK3JGdzlrcGJOa0xlUFlF?=
 =?utf-8?B?NGJFTk1KNWphN3Nhc0xGclk5UWVRQTRxd3Y1NmdZcHZCeXhlRWVkb0txNnd4?=
 =?utf-8?B?OEpiUDZGTElFbkVzSEphdjFsZVZOdFRLL2hOcnc3YVdZUzZ4SW9KR1VlS1Fx?=
 =?utf-8?B?NExRdjNId2trZGhVZHV3ckFCajZGVTIyQ21QWE11Qi9ZL3JoYnord2V5ZnAv?=
 =?utf-8?B?S29EZ1g4Z2cvODFoWTRQMERUNk5LS092eGFSZXZ1bW43ekZlN0RzZy9FNVNR?=
 =?utf-8?B?eW9rbjlZbkFDRjRCaTFnZU5KRU9qUXVTZjVHTnp4TlJWdXZZMmNkNHhqWDZz?=
 =?utf-8?B?Q1RLVjBjMEVjbFJuTy9wd3RVNmhZYUZXNGpBNHdkMHlBdTZFWEthUHNiMis0?=
 =?utf-8?B?Q1VJd1RFUGRmajk1bVc4UlVCb2FnWGkvUWcyUXpBRWc1ZkNMNFY1SDBpWDMx?=
 =?utf-8?B?R1FBTHQ5S3Vhdml4T1RvcTlaODcxQzZvS3RWS00rbWJHVCtmY2orNUhpVjF2?=
 =?utf-8?B?dk9YTFlnb0RSMG8raDdPWktBYUpOZ0M2dUpjbXN5cHNxM2NqTzQ5QnpDRDh5?=
 =?utf-8?B?NHkxM3FHanM0N3diR0pCZk5Takw4ZVN4V3BNb1BrVEc0ckhMeXdhZm53ODJj?=
 =?utf-8?B?bko5dlV3di94VG14UmZVbGN6V3JTcmtkbFhzdW9WUFZhVElmYVB2N0ZNUlBM?=
 =?utf-8?B?NWptUUU1Y1lCNk1QSkpXdk50WHBEcHRIQVljSW5Od2wxb0ttbHpXR0tIVmVS?=
 =?utf-8?B?UW9TNGdERlFMaGNsSTYrYnRwKzhmcmVNSWRzNHpoM2xCZnFNb1dmTDBGblVC?=
 =?utf-8?B?ZVNzWGpsWHMyVUJ5TnoxSkxkWWFxSklIVVFrY3VaOW1oMzlVZGZoVmp4R0NN?=
 =?utf-8?B?YUNOT2dxUTRwOU1rcG1zRUFvd3BDVUJ0c3hwZWVuQTNMZC9jMDhHc3MxSEsz?=
 =?utf-8?B?c2N2YzRWWTNhZ3VYaERHOUs5T3g3dTdmdEJnVjBVNGcxM3JzMjRPNDliQ0cr?=
 =?utf-8?B?ZVpNaXNoTzNBK28wKzZaVll6RE5EWGlvUWw1d2FRUU01ZFphL04wSldPaXUw?=
 =?utf-8?B?T3NnWmNwNll1Tnkxd0ZkeE9CSENCbzBqRHlXRzNOT2czT0xaYjlMc3dGU094?=
 =?utf-8?B?VTF2Rlk0U3VDTGlPSlhoS3V1SWt5SE5nMmtWMUxjVkJSeStFYktWWUFlQkgw?=
 =?utf-8?B?VWNLVEJmT3BLZU1ndEM0Z3B1c1E4Ni9TTmQzVXd3SVpwWHJWTm9YUUtjL3RY?=
 =?utf-8?B?V2owZ2JZRnNIcnBNWFM1YU51SU1NYzVJNHV4YlhVa0hpbzJJazlGb1dOYU80?=
 =?utf-8?B?b1VSMlVHZmVlaXB3ZkV6M2dTUk5yUGJyY0xPMi9aVTZMVm9LQ0lKNDFqWWxQ?=
 =?utf-8?B?MUMvYVdXdzJqWUtZdW1ZaEI3L1ZrSTl5MmxWbWY4ZnZieEIwYVRJTVVxVVht?=
 =?utf-8?B?SzVaVGdFYW5RbmJ5bWVjTlkyTTFGOUVPbnp6cTE2UG9BWGZmaFMvTHVsK2tw?=
 =?utf-8?B?eVpteCtwZFN3U1F2MXh5QXJVcFBPUXA0dWZKNXMybzZvbWU0SjROVUN0djgx?=
 =?utf-8?B?L01FNUR4UERKMnFaSDgrVnVrY3hVZ3VtWm1Od0dhWWVBdnhock1tb3Nja3Nl?=
 =?utf-8?Q?74+3eHVi+cwxaEm5/wvnaU4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dada9d60-776a-4daa-8b8a-08dc685154e0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:36:10.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3T0eUb2Ti6bdIFRkyjXXEzAVQNrKic49/vdvbBXWufbDpoeX4gsHv4mkAvG9LJFhjTeZFjKncW42l5oHhmgRUDfSCfUi/LRWptaam9bwR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6087

In its current form, the interrupt service routine of the tps25750
checks the event flags in the lowest 64 bits of the interrupt event
register (event[0]), but also in the upper part (event[1]).

Given that all flags are defined as BIT() or BIT_ULL(), they are
restricted to the first 64 bits of the INT_EVENT1 register. Including
the upper part of the register can lead to false positives e.g. if the
event 64 bits above the one being checked is set, but the one being
checked is not.

Restrict the flag checking to the first 64 bits of the INT_EVENT1
register.

Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
Cc: stable@vger.kernel.org
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0717cfcd9f8c..7c2f01344860 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -604,11 +604,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
@@ -617,7 +617,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	 * a plug event. Therefore, we need to check
 	 * for pr/dr status change to set TypeC dr/pr accordingly.
 	 */
-	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
 	    tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 

-- 
2.40.1


