Return-Path: <linux-kernel+bounces-153949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924908AD53D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C25283FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785C156F27;
	Mon, 22 Apr 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IG7gSkli"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9DC156C44;
	Mon, 22 Apr 2024 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815439; cv=fail; b=XN5aPrEpMjm3wsPSRx3zgA3a48xsmhudGx6Mp1t9QxHG+5/XoVLimtayCeCRiEebgK8ovZJkBPv7Y7VT5WwrsNZ9gA0Vso6cyNT/I5G3uiWwQOfmI65tJEXPosIwZ8qIrKYqjzQNxFgmn9DmRqtbv2C3dyUqLaGyOVhpBIWgXZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815439; c=relaxed/simple;
	bh=6OOXkM+2/9s7Gte+2idEtd7dgphQ7pl6WSs6xuYBucA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=W4Ek+icAWfDwnu3Np7A3DpAbqxfipFPWXjEPFa4Spq7xvE3TUkg377LPgjqDcw2k5aq+x7xGMQ/4/gC3TEFspbTyjc1zTK7uIWWE79AT5JRuLvhWCgQNDKyasuOKO2oe7NYDY6+VfVzCBCFZWbznE2bSin5BFQAqsM2wS1l82qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IG7gSkli; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9RFjbgjmxIWWgHOpYF5ED17OLQlzdcSvtMYZhzbQ3bfSQk38KazxgQPLhJQ1fg6ayJfL7p8GhspAdM9UTLTyZ6xi6xw9WHWs9wSTNkUN3QCOks5JXpW6tMPqvcqNKZMTEpee9RvpiRhSnojK5e6MhDWBTT2RWc+weR8HRvohhY9LJvzV6F5vYI5EXftmnFxoynH+rFzpLPwzXV3Vl+j7ae99XyTp85CJq9upqZjV0dsQZ1cs3YLf4W1de4yLTvAZjJiEyaF811a6/lR9n08HW/cZ5irRiwMbYqBJMuo/BvdmfMnSHmTeJ80ZtVj2De4qbZuPYV0/mDVJrf88C+Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjmAn/avbYTncc27pYxd33Wqjmb+DbimrzovFkyFIRc=;
 b=C1ydNvN2TJlVf+3UIe8QxGNvNcm7PMGMQB7ZKIgSRP/x8+E3AtbNn1kNn+qVusM4NNQKEdvvrfOem7n5/WGK1+EXGHCfheqYdOv16l1MQIzu3A0ojRpy1HwtbKCDVhcua+4uTyr/yML61+uJVndc7UyEK733YyxqVUubYbwDKgD/IUfzBzwpqA90X80jM73aVTZMY0J7XF1gmFY/O03QKoBWxWtlmcZojJO2DGgW7v42Ik/ij8fz3tvDva2YdfIoBNSSdG2RN3BgiOUxqk9+Z2RFw0vnyvMCNZqBugT6JL366b+XIFsNlPiOg16AsZTueaUjkoiHuwJZt69C8SklQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjmAn/avbYTncc27pYxd33Wqjmb+DbimrzovFkyFIRc=;
 b=IG7gSkliLOhFAeto8I0Dz5zlT/kOXeTLbbAcQQDkHodlT3L2qK5nF9Hpt+mSV4dE6Fn+xfv8yzZlyvb/afADUqPfV+1PjhMiTVHW6/m4mGkg6WifX1RJd1BT3tynytsDkxAPyCYuIiLKTVh3TF181VnMJKWGUwVJfre29yfHuu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9734.eurprd04.prod.outlook.com (2603:10a6:150:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 19:50:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 19:50:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 22 Apr 2024 15:50:09 -0400
Subject: [PATCH v3 07/10] arm64: dts: imx8qm-mek: add flexcan support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-dts_8qm_audio-v3-7-680cee731ced@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713815413; l=3069;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6OOXkM+2/9s7Gte+2idEtd7dgphQ7pl6WSs6xuYBucA=;
 b=mTzWoTUNl4KN81cRkR95UUIlxsnch3yQEFgkaSFdvY5EqKm7eSxOK3qCO2nO9zuMOpQ9A1p+P
 MQWQ2b3qHfuBHYHsoUktdbRTGwKN42emmyD1ZF7sGHA+GUhFgZnDiEA
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
X-MS-Office365-Filtering-Correlation-Id: 942a1875-6e53-486c-42cd-08dc630576a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFpMT2lhL0FlcGh0a0VZeDlENkJkWDhZV0kwdWRrMGZ2aDhIbnBLWTZ6MW9t?=
 =?utf-8?B?R2hDTms2SHB3Zkg1Yk1HdTdscGdxVk9RMWJBY0YxcGk0VmpYNDB4VUtyQ0Ro?=
 =?utf-8?B?Ris4NWhab2N2VHl1RVJ0aGxhWXVyaW5RUUR1L3ZmbWRWMUlad1FzMUNSZGtL?=
 =?utf-8?B?c1FTL3oyM2FPcnVBSFVSTHY5MysxeFd3NlFVTTN4SHQxMmphclVDSzZtOStq?=
 =?utf-8?B?REQ2N2xpWEltcE03czk1ejJjY1Z6aVZnU0MxSW9yWG01QmZHYmNBYnpSVDEx?=
 =?utf-8?B?ZXNpdkhvL3lGczBISk9YQ21qSFZCcGtWU1dPUUZKNnVKSzFQTjQyd3YrbEEw?=
 =?utf-8?B?bjBoU1N3dmNCNDZ3RmpRY1JxME1QUGZkQktzYkFFbEtUY0UyT1gwOHlIcWVZ?=
 =?utf-8?B?eDV6cE1OZzRHRkhaQkZXREs3czRScG1oTm8zVVliTVhzMmtJMDF1WHZMY1ov?=
 =?utf-8?B?NEJKWkF1ZmRiZ2F5YWNad2o4UGgrc1ZFZVA4a2x3bGdrMk05eHVKZWdiR1F2?=
 =?utf-8?B?L0VLelVpQUNiMTd1dTloRHB5T1hMWDNEK2FYb3RqV1FWd1NTc1laSkU4L1Fi?=
 =?utf-8?B?aEp1d09penJ3ZVpYeXBGeHVJclorVGlxaXVqckVucGh6RzBNZENEV0dKdkdS?=
 =?utf-8?B?VHJybTBOOVlJa2VndVQrNmF2bjk1Nnl4ZEowZWJ4R0RYWU8vRVU5aW16OGJX?=
 =?utf-8?B?V2llT1JieHdKU2xDN2MyMVhuUWRvUmRpNjNGZi9GbDl6QjMxRG82MWdDM1RX?=
 =?utf-8?B?ZUQwTlNtaVR4eVJyNmovdmVMRWhGc0tKZ2ZzR3RITTdqZzMxRmM0MjlvWC9X?=
 =?utf-8?B?alVMMjVteGt1bHBFS1RaSlV6Tm5RenBBbGlzM2I2bnNUcjdseWI2eFRTNmE3?=
 =?utf-8?B?cGpGNG9jejZnd3dEUVpUbkozSS9iT2FleXluT0Z3UjJQU0M0eWEyWS9mZWx4?=
 =?utf-8?B?N1RGQTNmVUZLRzVoU1B4NDlpQjltUS9MT0J3UVNQbW0zMStWb0lnczBRQ2tF?=
 =?utf-8?B?dEJRVWNuM1pNWWQ3Lzd2ZUdFOStrQXdtQWQ2U21jVkxtbmRDc3JzOWcwYjMx?=
 =?utf-8?B?aXFkczVnUGxUajh4STBHNTVmYzY2UmZ4M0dDZWFNM2llemlkcXpWaFp6SURu?=
 =?utf-8?B?TjdVMUU5ZVRsZnkycGp1N0RRTktLM3NNaG8zVWlTVDIxVzhjQkVZRXpLNk85?=
 =?utf-8?B?MWVaUCtEZzBHUWQ0OXRYRDF3STJNeFhyNEY3NHZnQU42NkxVUi9HWUd5RnVQ?=
 =?utf-8?B?UWplRERsODNVYnhzby9xUkxWQXNJakpaVXUvS3lIUGo1VzdBL09lYmU1ZUpn?=
 =?utf-8?B?WlJ2NzNRVTFnYVRuYVRFUEsrZlVsUlBDQWRkTTUydDlPVXErZTByaS9pUWlq?=
 =?utf-8?B?Q0pDK3h0dERHVEpGa0pFUk5HUk10MitkbEtadm1pZzIzT0l3UzBRQjZCYjJH?=
 =?utf-8?B?ekY5UUJoMUo4VFVybWhCdm5uMWFVUU9zZUthMXVZQytRbG4zTWFqUmgzR3hp?=
 =?utf-8?B?c2h3UENobVd6RWwyc3J4bEVmWFU0c2xPY1VZNXBrbndSZ1J6M2ZtTkc0VFJQ?=
 =?utf-8?B?bVRTL3ZMM1kzNHBZTzl0YWFGSVMvdDJPbHhNK1kweGNIdUFVRDJuSGdycWRD?=
 =?utf-8?B?cVVsM3VWSlNEWnlaMGN2TDZYZEdOREJqRHJXOHRGd09mRE51OHNZMFF3WlNl?=
 =?utf-8?B?eTJGdHhiakUzL3JQTUw2bDRFN3hDZGNBVUlnSU1vVDBER1h1UkFwdWpWK1RQ?=
 =?utf-8?B?SmtpQVRKQWJGdkpoZ0tXVm55QUk5cGNNc2V1Q3BGSExtZkEvbWlwRXVrblMw?=
 =?utf-8?B?SlA5alZrTjFUaUJSV3RXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tJZ1F3Zk8rbnZMaUxldjR2bEpTNUV6TS8wc25iMkJmU0xRcTZWZWQ4aVE3?=
 =?utf-8?B?alEyaTBIczB0U1FPZm1ZU2FydVdlYzNBaUw0VzZVY0ptK3lsY2p0SkZvTmpm?=
 =?utf-8?B?WWV6N1ROL3RCdnBIekh3TDZOQVRMVUFLaDRPZzNaYjJGN05TekgxYUpRVG44?=
 =?utf-8?B?SkdTRXB1RmZOUlM1NHJBMVRJYUFaa2xOTG10K3lBWExxNXFhRE1iZTcwdjNN?=
 =?utf-8?B?czdZVFhYRVc5UXhRc1VCanJNQTFqQkcrS1pwVmJUZEp5c0tiSHI4SHBwTFNV?=
 =?utf-8?B?YllXUnNmL1lMNThyT2JucCtBTHVYNWJnQ3pvWjhnZ2JxNTdQQ0JyUSt3YmpX?=
 =?utf-8?B?ZS9Xck5YN3J1Q3FhTkxnZnBwMHhFQTRMenJaWFlFbVZ0VlpvZzhtd2pRMkVB?=
 =?utf-8?B?YmZoKzJqZFcwYmNxQTloVmVsbEVOSXY4RWw2UWs1bnlscElSWEYrM2t3eStI?=
 =?utf-8?B?RSszZSt5ZTRUaWNPL1JidEdMR08yNmgyZEw4Rll6bTBQQlM1c1BTNGk1NjQr?=
 =?utf-8?B?NmF0U3dxT3B1OXgzTzdGTkhrTk0vOWh6YXowaDhoWjhCdWhCdXFablJyS0Jw?=
 =?utf-8?B?L2FlcE0vOERrSVgxdDl4QzFFRUgweWRNTmN3UU9wVjdXZzY1VGZKenM1YzZV?=
 =?utf-8?B?L3JVcDVJQ3licXFBSkwrV2RwSjBPNzYyNTR0OEt0cXdhdlpCbllZMVNjdlZq?=
 =?utf-8?B?bFM5azh3QjMwbTF6cm5vOVJSRHNjSnArYlU4dGduNE0yTGdqejd1WURrcWl1?=
 =?utf-8?B?bzVjOXZkVXdCbzlqZ0g4NHkzK3U1NXI2c3ltRFpYbXpKdjVVM1JYcjlYdUVX?=
 =?utf-8?B?dmNCU0w0RmFEeFJaS0J4alAxdFdocjJPeU5GTCtSWkVManhjRVJqTFViUlow?=
 =?utf-8?B?MkF1ODl1cDBBckJOTWM3QzFyYlZjWERXMlVnblpQNXErWjNjRkx5Ump6d2s3?=
 =?utf-8?B?UExwcGI3dzd1cGNEc0hNbzl3dUFtdUJlWGQzOCt5WVVqNmlYeHpkWXptWWt4?=
 =?utf-8?B?bEZKVlZIbmJYZmFyM3NxWmFxcnV2WjlMVGJESjRxV05MTFQzNFZ1SlEzNDBT?=
 =?utf-8?B?QlhpeFlacWxxdWdrVFJHQXBjUXduK2UybzA2NWdGLzd3TEdVL0VnN3YwOEhF?=
 =?utf-8?B?UHhOcVFyYUVkMnhNenE1VmIzdWtRcC9EMm5rUHFvU0plbjR3N2dlUUFSZVNV?=
 =?utf-8?B?RUI3b09JbGw2UHdnUmV5QUpSS09WaFJHRWl6Qm5MVTdheW9IOUUxd1U0YzdY?=
 =?utf-8?B?R2RCVjVYT25XdTNOSlpIdXhCdGlTQy9pV0MzMDNnb2paLytUeGlHVEJ3Wmdi?=
 =?utf-8?B?bGpiV2hGVE1COXpqSTNIUEE3V2V2N1VtS2I0Y2ZzMDhWd1VqTkp4L1NvVGIy?=
 =?utf-8?B?UTBZcUpKZGdZc251NjdNWG9hc0pBdWRRVnpxUDd6ci9lVGlVRkw2eHYyNTBC?=
 =?utf-8?B?RlJSYVpNMmEveVJ1SVBac3k5M3g1cHRrZUIwR0N4ajR1OHREODZaQUJDOXlS?=
 =?utf-8?B?MFh5Zm80ejkzQkVBbTBGakxYdDIzVTNlekovdllmTG40NVo0aU1EamhLd2RJ?=
 =?utf-8?B?eU5ETnRNN2d6d2RyRzFMaVdmSFYva21SbVZaeDdjSDNabGw0UHVwM2xHMUhR?=
 =?utf-8?B?Y0tqNlVWeGtmamF1SVhjK1B5Yms0cTNQbDl6b3pGN2RQRFUwRWcxU2JPbW5H?=
 =?utf-8?B?WEswTWxJbmx1eGdQUWRIR3djbGJUWnZyNms1Y25ESWhTVFRhbW0veks5QUgy?=
 =?utf-8?B?eUJNMXJtMjlkVWpON0U1b0czdzJmcURBYWIzSlZjWDdpREY2bEZ2em9xeWl3?=
 =?utf-8?B?WC9VbEk1VVp5ZEZwaE05eW40L3VNNEVoVkNML0dLVzVGUGp1Zi82VFV4K1pX?=
 =?utf-8?B?cjZNaStGYldKTlNUZWFyU3dlblYyU3FkS0hOdll2d1BGczVWaDVLMm9tUE9i?=
 =?utf-8?B?aytBZTVQcEhBVW4xWjdRVXFqV3BqVWhHdVFPSWxpMCtSSzgwVWgxVTgxdTVX?=
 =?utf-8?B?UHI2V3RiSW9sZHowR0FTOW8wNzE4dG9yc0RCNHE2OFo3Tzd0MnRWVkh4aFJr?=
 =?utf-8?B?aUlLNHcxajhBZWg0OElNZzg5MERGQjhCTk5DY2FnVEtFWis0b2tUZmwwcjF3?=
 =?utf-8?Q?wsY9pcR72CzfGGEmpHbZvb+GO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942a1875-6e53-486c-42cd-08dc630576a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 19:50:29.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amOO6+Vp+Dn64f8DtaKJ0eu8sEDcrdgGsspMyXj/i1BOmoj92xrUFCUlOnaUpBpBEq6tbYH9hdKdjjO3Ez1VaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9734

Add flexcan[1,2,3] support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 3ab2fab7f7fa3..62ea3efd1ee2c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -40,6 +40,44 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		enable-active-high;
 	};
 
+	reg_can01_en: regulator-can01-gen {
+		compatible = "regulator-fixed";
+		regulator-name = "can01-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can2_en: regulator-can2-gen {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can01_stby: regulator-can01-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can01-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can01_en>;
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pca6416 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can2_en>;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -241,6 +279,27 @@ &cm41_intmux {
 	status = "okay";
 };
 
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can01_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can01_stby>;
+	status = "okay";
+};
+
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan3>;
+	xceiver-supply = <&reg_can2_stby>;
+	status = "okay";
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
@@ -433,6 +492,27 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan0grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX			0x21
+			IMX8QM_FLEXCAN0_RX_DMA_FLEXCAN0_RX			0x21
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan1grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN1_TX_DMA_FLEXCAN1_TX			0x21
+			IMX8QM_FLEXCAN1_RX_DMA_FLEXCAN1_RX			0x21
+			>;
+	};
+
+	pinctrl_flexcan3: flexcan3grp {
+		fsl,pins = <
+			IMX8QM_FLEXCAN2_TX_DMA_FLEXCAN2_TX			0x21
+			IMX8QM_FLEXCAN2_RX_DMA_FLEXCAN2_RX			0x21
+			>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020

-- 
2.34.1


