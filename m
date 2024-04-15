Return-Path: <linux-kernel+bounces-144913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759958A4C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011381F22670
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D15B20F;
	Mon, 15 Apr 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="wKvX/Wwc"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021007.outbound.protection.outlook.com [52.101.133.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E0101F2;
	Mon, 15 Apr 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177123; cv=fail; b=Tl9UIaMPCiWfep76Fndgq/JKmF1aR1v79HZ/lHbcv5do99KGvO+Qi6VuR50wZg4TCKwMowK9Je5q6wYWgNAE0Nnqfy18oZEXcEMLdw5+ONds6Bi2iS946DPI9RKkvVRkEZ9uECpindQ8jAIs6Pg0VhRInxeHaKJFQUzDQbaG0BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177123; c=relaxed/simple;
	bh=pjWjZKBDp/tkysmccU+clmRQPlxYOWeBt9QsM8IBgrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hVXiXu9eZROnki0aqxj9PXUYJ1NN1b03YaoiZLhuYklJSH8tiOqWu7lnjfRSKkHYI+y5VFAGNLcr3bkVbfH1ac1fn+tsgDh3xEEPIDgxvCGFwNYZaH/Rj0Am00pcYaBhu83yaJ7c0HatFW33FiYo24Cy4zt4+/bDv7vwT50yViU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=wKvX/Wwc; arc=fail smtp.client-ip=52.101.133.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLLWGqFDtRQTJeqwGXgAewKDXR2M/1GPLHez0UNPT3jNppMsrVCtFRS1+XOjAEvH+ojIcErD5kMx3nCTbtBKifHj2B57MtczjcUrVtcrnba89QoPeQC5Gs3SyEauyZz+owUdfUN8FD3+VmfAmAnSTY95VKrsf8Zl7LsvFGLhUx6YbPAfNEMZtnp+Kj0qKODcFCbHEEh+FGgZjDybAxbh4ErQJwE0fnf+QwSyantpsNTGjUyw9hK0/4RFqFTFPOe2q5yoEw1KO0HxNy6cPOqBIRsb1xF8G8/1t1zWylcMADGklwZAGokVAkbSh3Rke71DIXSJTObwB5+lS3amBdmQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds3L1mtXBJMHEFdXwN/fDYE5noDINJwrKk8MVbKSTfw=;
 b=PuxDNc4u2INRJknlxXNIe459x7rA58b5zabjAkdXngE8VpSgqQqa1T1geLLb+ualMXx536ufEZatA136Gp7xyLiyMjH+Wmfony9jXBp9JXpTdTUh1Qj/TbhAmKlua9g1atEbW3zJ0NK0KG8JtFAI0tIOHo1eq65FndgeK7bACnj3oVnGkyDg2idoq5oUcmSkDPXitm6TDjmJY7Y/4CZ2HEie5DC+V1KRdCMClyCqAXJBgMK4tVu50FawjRsVeLMotO+V6KtCaYH4sn8FYgOYZ9tL6NJI0IcacFg2UGP7Mr5cBnRS8Zo+C4E0DVkEaole4kq8zdpiD39by1oR2l9GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds3L1mtXBJMHEFdXwN/fDYE5noDINJwrKk8MVbKSTfw=;
 b=wKvX/WwcjDeBlzn68ykvIPeLbdq8WanDuGUcasM9PtEGchJdFqqAwE99QDX+9GQo0aQIo8gvYrtlpNUnxJRwHO7fdppWu2FRQpzoC3t/Oz1aUdaplMQ+ZEkdQt0XCiBYMlR3FY7GeBoGWy5Q909f0jEgvYUhxxAFU4NJ8V2sTNujCrlMY7If7DxyEFAAy6TJJSkAJ2b+uRPVBpJn4LbytAnKYWmdDLlCGPgWr0A0t/g0VyY/gKIHJv5IaMGXrMO0Q06H/RJDf6z14vKockzJ0XztAlHXRER9WYuHCGaKhyBFETL6/PuJ/kRiWqaRUXadQxbr1enFrsmN3GdWNCpElQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by SEZPR03MB6958.apcprd03.prod.outlook.com (2603:1096:101:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 10:31:57 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8627:9243:4397:43c3]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8627:9243:4397:43c3%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 10:31:57 +0000
Message-ID: <48005005-54ad-473b-826d-23b0b3f3a52c@amlogic.com>
Date: Mon, 15 Apr 2024 18:31:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add Amlogic T7 Reset Controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 neil.armstrong@linaro.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Zelong Dong <zelong.dong@amlogic.com>
References: <20240329-t7-reset-v1-0-4c6e2e68359e@amlogic.com>
 <20240329-t7-reset-v1-1-4c6e2e68359e@amlogic.com>
 <927ad2cb-3b41-4eda-b930-856be64ae9ba@linaro.org>
 <10650c59-96f2-4234-b5fd-aa8efec90e5b@linaro.org>
 <579a1569-7bba-491f-ba5e-7cfcb34ccc1f@linaro.org>
 <c7e243e3-3f61-4d63-8727-3837838bdfcc@linaro.org>
Content-Language: en-US
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <c7e243e3-3f61-4d63-8727-3837838bdfcc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|SEZPR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b34fca-25ba-44c6-83d0-08dc5d3746f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0RTaXppWlZ2b0lHdzdHK3lKSnJiVGJqS05NZW1NUzVORzMzdlNrMWxlVWRq?=
 =?utf-8?B?NmZZb0ZScVFOdVJLUlhQalVtbWpTM2ZIRnRSa3ZPWldYUElmZDFERkpaei90?=
 =?utf-8?B?WXJWbGgvbC9ONldJRlppVm1MeUtqZVQzSExnazRmc2x0c3Z6cGxjRy90djU4?=
 =?utf-8?B?MlZ4RVJkcGRYWXZ1K1czNUd4YTVhQ3RNYjNLRjQ2am1UbHVGUERKWEVCQkNW?=
 =?utf-8?B?aXhIbmNZSnVHN09YQ1FMa3g4OUtWM0JOd29CR1A2VllhUHMyb1hOVUV1MlVv?=
 =?utf-8?B?WElxQjQ0Z0JuUm0yNXhWM2J5ZXhsTjAzbTNNUy95bTRkMFhjaE81L0E2UnVm?=
 =?utf-8?B?RENXYitDMmcvdVRJZlZMc1RVaTY0UjRHY1dwVU0vQUNac3JQZGViTy84MEor?=
 =?utf-8?B?ZXNTTXd0Vzd5S0JIdlZJZVNlcmVFSW1tcWlmVUprZWpKWlRyVzdmSm1kWUZ4?=
 =?utf-8?B?UzBoUUNGWWxra1VMVndweWNVT0t3Z3VidGRSZ1dQRzZEZjBFckhsS2ljN3dt?=
 =?utf-8?B?Vk9BWW5uWjljRVM3dlcyWkZRczQwSHZQVTR3MUhyRzdGeHFTS0VWdWVyMWpS?=
 =?utf-8?B?T1Izem9jeC95M0VKaVBqdWtXdzJhQitXMTN5OE5WMGNtY1psY0ZJQUhyS1Bu?=
 =?utf-8?B?ZUxGeVhidFduVVRKUm84S3IwY3JoVFMwQy9Kcnk3cEhQNHRGelQ4enFZUWVM?=
 =?utf-8?B?MUdSZkpvOTI5QkV0THhoc1dFNC9JL1BpVlM1VTJBdTVYMWZkeG1SOXhPbzlN?=
 =?utf-8?B?akpMbWU5OG80bHhVS1VDSTZkaFQ0RklRL1NWWk55UFZiRStrWUlMWDArVGV3?=
 =?utf-8?B?Kzc4d3NOWnpTWXh6RDFyN29YdGg0OUJXYm96Y1VTSTFzL2VkWjBSRHRGK1Jx?=
 =?utf-8?B?bjIvdEd3ZkNjcW55TVdCN2JRbk1lRVdnU1hCekhvcFV5cmwzRmhWNExkeUdG?=
 =?utf-8?B?eDZnOEVmWXNzdGwyamZZNnJZSjB2cElMK0tmVlM3OXRVSnZUNXkyZFZZQXVS?=
 =?utf-8?B?alNLVjZSWEQrcXRCU0k0bDhzMktpaGdGK2o3dVNreWM1L05nVFlHZUZZY3Rr?=
 =?utf-8?B?K2ZHQmJ4WllCKy93azVZUjhsa3pQaFkvZUpuVEk4em4yMnpIN1BaVG5xT2dP?=
 =?utf-8?B?RnVRdjA0dnZDV2s0RThEdCtmbW9BaHpheVM0enE0WXJCa203amNQd0ZRa3Ix?=
 =?utf-8?B?bEh1NHA4aHd0bTdrRGgvSllScHJVbFBXR2JmN1p5ajN0LzFUdjhYN3R4b0Vo?=
 =?utf-8?B?djBWNEtOY3R2L2N1UGw2MDhPSEhzQTZJbjY5V2V0REgvYWlJMkg2ZDZjdUNP?=
 =?utf-8?B?VnI3KzltcU5Obm5qcGliODM4M0FOT2lCVHZUeWt0Y1JNSmwvUlVNVjhLK1hP?=
 =?utf-8?B?Nnl4c29wZjJ3WEVWVFMzRG1PSnY1d0I5UG1wTHFFdkptOVVOdDE2SnIyYThI?=
 =?utf-8?B?aUppeUNpeXJtVjUranFKN1kzd2pwbWFaOVA3WldVdEVyb21aREZ0bEVqUmVG?=
 =?utf-8?B?bXltdjRPS1c1UmRJejhvRlM4UDRzaUdsOHVTeStJQm1HczU0U00rYThlMHh3?=
 =?utf-8?B?NU9MUHpnbFlZcTVFbFVMK2RzMWU2Z0RKbXBpTmkrWGhzMEVPZGx1M2ZWQ3Ey?=
 =?utf-8?B?TUx6OTFaQXdrWFBFMzYxTGhaOEVmejJBQXpzR2VDVngvNmlGVDFsVjFuc09a?=
 =?utf-8?B?NE1ZRVFhSE5rV05zOS8vejRmRnB1NjliUFFRa29QR1kra2haclBwMCtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHZOeWI1SU1rc01OaWJFZXAvZTV1UnFsQm1OYXVBZW96Z1ZSYWdMMEpsMFJ2?=
 =?utf-8?B?MTF5OTZTRWE4YWZtMC9CaUE2VVBVVXRybGxXa0ZTSk1CZGxRWFVLTy84UXlI?=
 =?utf-8?B?R0wycFNUeHNIUUFRTk5GUE5kK0lkT1V3ejdoQVRJN1JsSE0vWndkdVlvbDha?=
 =?utf-8?B?am9uWGhwOUhXRmxNM0QzOWJWc2JaQXRUUC9SWHA1N2pmNkZQSVlyQURKNEcr?=
 =?utf-8?B?enR4TU5PRUhLQ0RNYzJpWEpDR0RVeTRCQ0YvUE04eklpVXZ1WkNDOWRjUmtG?=
 =?utf-8?B?eEFOQlJrZ2ZrRlhjYzRMRCs0cWVWK3RJUll0MFdjZ3dxMGhvaERYZzNFL0JC?=
 =?utf-8?B?bU5KSVBPWW0wSlRHZHJzSzM5aWNQOGZVZ29rNE5pMVdnS1k4eisweWhJd0th?=
 =?utf-8?B?VFc5cVFmNTlmbk9EdGlCaTcvak5oQlhNTnJMdExHaWszL2VPMWlNZ242VUFl?=
 =?utf-8?B?SHlVUUZWWUVOdXZrNVJqbUhiaE8xL3BjSmxBQVV2RHNncFpaTW5jSWpJR3hj?=
 =?utf-8?B?QXpIWlBmcmlPczlKZE55d1B1Uk54VW9BM3FFUXRBczIzSEV5SGdMWHcwelph?=
 =?utf-8?B?NzhCRkNXZEJuaUo4clFwS2QwOStnQlBlelBsNGJNWStncFoxdmJZNUpJVDBZ?=
 =?utf-8?B?L2YzeExodDJmUVY2V1Y5ZVh0TmR5ektHb2pLTjJxOG1DMmQ0Si9MOG9meXh6?=
 =?utf-8?B?NUdEdzNKb2pGVktNWFg0Vm1EUktoOXdrdTFFdGZOQ3RubTBYME5DMm1Yb3dI?=
 =?utf-8?B?cFZDMjR4Tm1DMHdxei9GdDdUUHV6dXNoWmt5OTVnVlBhSmdtNFpTUDlqYjkv?=
 =?utf-8?B?SU9vTDdQZWw3aEU0M2NKQlNnUzBiamdnV1VIcS81RGIzWFRDQmZZU1ZzMk5T?=
 =?utf-8?B?TkNxa2hwcGpxU2t4RmpBdStaM0hscW9US1hoWUY4U0JuMi9TUXRQbGVGR2Mx?=
 =?utf-8?B?OVMzbGFJRVZibXJDOC92VG9adGsrdG42SjJUVUordTk5azF6RWVUSWlzSDNP?=
 =?utf-8?B?Zm43eGUvaHhHbno1QXFaTWdRNjNGb09Ub24zY2NtV3VIVkJScVB6d21tUUpF?=
 =?utf-8?B?RFFRNllXSldlR1hLYUN2MXYwNm1YSnpZa001TDY1M0ZvNWVEVEVFdU40Njlj?=
 =?utf-8?B?UUdBV1o4eEtmSUg2c3EvR2RLdStBRXZIUlZ5RE9GNGxVZXFlYU8xVXJvNFl6?=
 =?utf-8?B?TFdMb2t0VHVHa2lranViUVBtNllhb3FwSXZyZVR5dm1VTjlpNkpwTENXa0Q3?=
 =?utf-8?B?NUpYYk1TZmZQa2xLZTJObVNXTnNDK244amJsZHdjbThITGtzb3cyVnFBemlO?=
 =?utf-8?B?UlZKQTN1NUZOOWRsVkVKSDRHNEgzZWJnZGd1UHN0cVVTazhnL1B3VlZENENT?=
 =?utf-8?B?bjE5T3p6QmYyU0ZwWUpMaWVTbXozWDFqRUtBVVphMHpkd3N3Y3ZSaDROdWw2?=
 =?utf-8?B?NE1rTXZWSGVNTmZTM2c1YVJna0pkK0VmWkJITUM3anNmb2Zjdi9rbktSdUZ3?=
 =?utf-8?B?cE9uaml0ditjbVJpWG9MQ2t4eXpiTS9BbUJ5czZGbTNkMmdpM2tBUS9EQmRX?=
 =?utf-8?B?MHFmOENQTC80aTdhY2dNUiswUjczOHppdmRDMll4TjFrelpkenFJS2czR3Q4?=
 =?utf-8?B?ckp6eEthaXZHYk42MjBTQ1Ewc1ZHcHdycjRjcnlMdDVWTWVlWHF0ZlNZQVph?=
 =?utf-8?B?dlExZENZU0pyT3p6YUV2cUJMZWlUS3k0VndQbnBvS3BmWGI4eDBJNmlqRFFB?=
 =?utf-8?B?SVNoRGxBMnZaUTRpSHVUN3VlQmtxKzc2djVoeVJaSll2K1V6Z3VnN1hTTlc2?=
 =?utf-8?B?dnoyRVhNL3MyR3dGNzhoUGk1eDl4Z0VnOWVTQW4yWlp6eXdHL01QWWNQSklL?=
 =?utf-8?B?bHdPQllaQ0ZzbkhoU0xDTkRPSGpCWUdVdXNmWWRFUHRuOUtSamRSWEVnM04w?=
 =?utf-8?B?VDJzcitqNmlwSUVSM1FQT2kza0VSUEFTa2lJM0xoMjl3YmlUaXZ6LzFQeDk1?=
 =?utf-8?B?TXNvampiNzg4NFJYL2htaVpjSEVocW00ZXdCcTNNKy9wbzAwdVZnWVdsKzRJ?=
 =?utf-8?B?c1E1bVZtaTFGaXdnOC9iN3pYZjRCUGMwQnV1cnoyeWVlNFRlNGFhRllneUgy?=
 =?utf-8?B?RXZhdU5nWTFVdVlIV1labGpYbHg2VDVuMExXMGpnNzBjWHNOYld1Uk1mVUpB?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b34fca-25ba-44c6-83d0-08dc5d3746f0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:31:57.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xr+vNb7UcoR4liksWm7yxw9Et3odT1e6SwBsCaE/wKaIzPzUXkqOh7h87fgbZgQ+r1EE+ffa5T0T2A2CPwoKT5SO3ZEtoBS8cO7Euk3gCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6958


On 2024/4/13 02:03, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 12/04/2024 19:57, Krzysztof Kozlowski wrote:
>> On 12/04/2024 15:12, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 29/03/2024 20:39, Krzysztof Kozlowski wrote:
>>>> On 29/03/2024 10:17, Kelvin Zhang via B4 Relay wrote:
>>>>> From: Zelong Dong <zelong.dong@amlogic.com>
>>>>>
>>>>> Add a new compatible and the related header file
>>>>> for Amlogic T7 Reset Controller.
>>>>>
>>>>> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
>>>>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>>>>> ---
>>>>>    .../bindings/reset/amlogic,meson-reset.yaml        |   1 +
>>>>>    include/dt-bindings/reset/amlogic,t7-reset.h       | 197 +++++++++++++++++++++
>>>>>    2 files changed, 198 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>> index f0c6c0df0ce3..fefe343e5afe 100644
>>>>> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
>>>>> @@ -19,6 +19,7 @@ properties:
>>>>>          - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>>>>>          - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
>>>>>          - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>>>>> +      - amlogic,t7-reset # Reset Controller on T7 and compatible SoCs
>>>>>
>>>>
>>>> If there is going to be any resend, please drop the comment. It's not
>>>> really helpful and makes it trickier to read.
>>>>
>>>>>      reg:
>>>>>        maxItems: 1
>>>>> diff --git a/include/dt-bindings/reset/amlogic,t7-reset.h b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>>> new file mode 100644
>>>>> index 000000000000..ca4a832eeeec
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/reset/amlogic,t7-reset.h
>>>>> @@ -0,0 +1,197 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>>>> +/*
>>>>> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
>>>>> + */
>>>>> +
>>>>> +#ifndef _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>>> +#define _DT_BINDINGS_AMLOGIC_T7_RESET_H
>>>>> +
>>>>> +/* RESET0 */
>>>>> +/*                                        0-3     */
>>>>
>>>> I assume this matches existing drivers which do not use IDs but map the
>>>> binding to hardware value? I remember we talked about changing it, so if
>>>> something happened about this and it could be changed: please change.
>>>
>>> I'm not aware of such discussion, and I don't really see the issue...
>>> thoses are IDs, and yes they match the Hardware offsets, and ?
>>
>> Bindings are not for hardware offsets/values/addresses. It's just not a
>> binding.
>>
>> I quickly looked at your driver patch and it confirms: not a binding.
>> Binding constant is used by the driver and DTS consumer.
>>
>> I am really sure we had this talk in the past, but could be I think
>> about different platform. Since this is not a binding, I do not think
>> claiming there is any ABI here is reasonable. Feel free to store them
>> with other hardware values, like in DTS headers etc. We already moved to
>> DTS headers several such "non-binding" constants.
> 
> Un-acked.
> 
> I looked at my archives and we did talk about it and you were CCed:
> 
> https://lore.kernel.org/linux-devicetree/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
> simple-reset is an exception.
> 
> So to recap:
> That's not a binding. Don't add some real values to binding headers
> because it is not a binding then.
> 
> https://lore.kernel.org/linux-devicetree/CAK8P3a1APzs74YTcZ=m43G3zrmwJZKcYSTvV5eDDQX-37UY7Tw@mail.gmail.com/
> https://lore.kernel.org/linux-devicetree/CAK8P3a0fDJQvGLEtG0fxLkG08Fh9V7LEMPsx4AaS+2Ldo_xWxw@mail.gmail.com/
> https://lore.kernel.org/linux-devicetree/b60f5fd2-dc48-9375-da1c-ffcfe8292683@linaro.org/
> https://lore.kernel.org/linux-devicetree/418c5f0c-5279-41f5-3705-345ec9a97ea2@linaro.org/
> https://lore.kernel.org/all/201401111415.29395.arnd@arndb.de/
> 
Got it. Will delete amlogic,t7-reset.h and use the hardware numbers
directly in the DT.

Hi Neil,
As you know, Amlogic reset controller is divided into several groups: 
reset0, reset1, ..., resetN. I'd like to discuss the rationality of 
splitting the one device node of reset controller into device nodes 
according to the groups. Then we can use the bit number within the 
'resets' property.
reset0: reset-controller@2000 {
..
};

reset1: reset-controller@2004 {
..
};
..

What do you think?
Thanks!
> 
> Best regards,
> Krzysztof
> 

