Return-Path: <linux-kernel+bounces-68105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54F857609
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B7CB233DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92AE14281;
	Fri, 16 Feb 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="u0FoHj4u"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2077.outbound.protection.outlook.com [40.92.53.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E60149DEC;
	Fri, 16 Feb 2024 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708065050; cv=fail; b=FTTbmelBNsOaCKG5ME6PT+fCJU9n8Vf1lICl7lVmQg2aojlbuwYu1eP4+359vmo4CY3r4XRrTuzLTP5w/AdesbBGPaUyz4av01o3x3biDGiNcAnl4GFCCNvW6QvLAX93fpvo2lsY5PYZJQkBcnBW95ZLpNwIvyOj7t5Y57uf3vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708065050; c=relaxed/simple;
	bh=6/tmG5Wtf02L0q1ceKYA1Es2GoZaFt/zdaC1AcdSQkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H9qa9OTgy5ku0PPfOWyYeTTejLPxC063l8lNR+oTq50Xvt5WmBQmPzAXxdB6pj9yZsIGUgAfpMUOKYEoZ0zPBcPYhNbwPltrYyUq/W4qGXeSGnJ7hXhLmLeroEO+lGrc1Ca0VIQZsw7lhSUSusm6YNdo3cA8vYmIqmERKhLojEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=u0FoHj4u; arc=fail smtp.client-ip=40.92.53.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJPG2Ce9hTPhDI5lTfecG/gl0kmdyzv4zME051bmL1gqppbWwjeIx8ei2ErhDS85YsnfKodo8TbggDXq554BQe7dR7kcWyxUYVEFBnFmep5Cllc4ga0LzURaDPTLgl0e4LTIS0YIaXapQJ9TVgfAANqhY3DcmRp83Xp62esAah/cYsa6f2LlKbzXKb6ciVJTlXjg1rlwIMZD8/oTnfKLcAyDIt2do02wIsVL5d5RQPkDDz46Gp9w8PMvI5b7/kALct+8M1DE+Lj4QJ8mKAcnFwgx6eeawmqgsMvlDXZg8d38Mwr78tm8AIIkdBewHaHeYhbtQwyT4g/VPCHHrxoYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSk6s9wB2lK3ugJHw9dj2CpihRcfaf+uZuT+ig6R08c=;
 b=A4+FCYy+SR64LFFoLGx8DM8i+jYiXP+kc6LZNWl8Qlq0osPiedMxEmNEbyG/acBWlsqTmG41fMfghVgyXqtISUDRwrFw1yJ2heICn/DkZiJ3k6U4KB+DUQBY48JPKTcO1aXUAZofA0t4D6fAKquLJ1OL5uNuCEKKqQ24Kh9a9Lvt1kc//3sb6LQxBywMpoBmwl+dznhcSTwfTp9/JdLuKMadlnHJbcQLYBXATAiwJYdvYiOvJBcwoHho6H/jD+FwIrITeki1/jgQLRVblc5A6+4ivg6+5Hm9jgYEIsgscemfyma/DwD9oMr+K0E6H9ZooN7y2/R7CZVg6PPURqoGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSk6s9wB2lK3ugJHw9dj2CpihRcfaf+uZuT+ig6R08c=;
 b=u0FoHj4uKjzha3/HV/sxDAHtBgc4KqtWa56nH2QKFmIhDy+nrManpRz1tdOfsgrMjy/d+oh0OQdkOjgydvNvzLGA+7ryDttiAo7ntWIg/liiRBvKYznF2Htu+mZdvb+3GdArRGHCX8f0dfzDI0fSFJev56gv0vkH/N/CS49Li4Se/MIEnuZ6fAEvIkNDlnms5e5wq1Pmhe/PxsAz7w8eoPxLXUKFfF0ip9SbKaQvOF6ZuYs6f8qj9XSwuPtHvPJ2+c5eFG1YzGEmVAxwwD7lDK/JUiuTj0MjlmwE3FRPsAopL+tf7oXSDkQcGLx9ZBxTbcNqApRxD/Dm7YoLMQofOA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6778.apcprd06.prod.outlook.com (2603:1096:101:170::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 06:30:42 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 06:30:41 +0000
Message-ID:
 <SEZPR06MB6959E0F113C7C7CF2669E40D964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Fri, 16 Feb 2024 14:30:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: add hisilicon-femac
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, netdev@vger.kernel.org,
 Salil Mehta <salil.mehta@huawei.com>, devicetree@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Yang Xiwen <forbidden405@foxmail.com>, Rob Herring <robh+dt@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>
References: <20240216-net-v1-0-e0ad972cda99@outlook.com>
 <20240216-net-v1-4-e0ad972cda99@outlook.com>
 <170804935994.836701.6122628077585764606.robh@kernel.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <170804935994.836701.6122628077585764606.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [44//FnF71gIypGoshfNSTDEgysf1lFWquuvWTZh9LDFt8M/sjsLG/fDpDcdBshUBJ/TaeQuOK/w=]
X-ClientProxiedBy: TYAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:404:14::33) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <edc42c86-da16-4ec5-8f44-b0068c69ab56@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2317c78b-ab57-410a-a730-08dc2eb8cc24
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RV9of1MVp7gBuaNuMO9HVchoG05L/hPeqmOzWBlk2q8bkR8RLQh2q5AJaRLLrYfXy0u1IxDX1gihdUb4JonTlrv8HtfKEM9K7akn3frrgb88YVw87/zMlbVoCTPmBnkeitSB3JP0o5U8PKaX9S+eQa7nSHNmeeQAUH/dPX57Igm+35mL116AYaOXRFfwH5LPHhF46GJ3HwHzBrEWj67OV3JSovkbm+nNXTC/+zfLxrzqf9gh9v7EjbbyxBF/JmBG9K/KWXby5wVravwnlXomEstdPh+Ifvg3YGOdsrLciHXsJrn5zFt3RWwUiqb5ZJpR8ZmrAyXdvXGaqx212gdvoLeeMLH8n+W64yz9E4lseBN+ScBs1UowFaflnTvvVIgS8uYM4mY5s4BiBzIbklApnvVHE0WIuBUmCCUKIHXUCKJSBW5sVgwhdzH2/XzaNn1jPUQjTPz4kc8TY4t7KcSuPBSmvZc95Xeqaqd1yBmKequziRvJZSGqtNpI2kGvIfgO7MGJ1sSPZgjri+j9xYoEePUdJ68YYSSh9Np7oan3G4+vL1LCruw/7VKKps0vq9dlNcxdhs19Q7oThdSnszyAlJrjy2deXr4sQov+YjHCiOc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkJ0NmFpUUJjWU56WTlpMlRwamZLdFpFRUp2RllGeVVpWG8ybDBKakwxQ0hT?=
 =?utf-8?B?dVc2aytjblF4THpZMVBCaEw3dXdSSi9COUs3amNnaGIyMDNRaURIc3ZmRWJa?=
 =?utf-8?B?akIwblJOZi95WnVoYlozMnBSNGp5THlncDR1a0RFWUpDdnphazNqZHVNVUY3?=
 =?utf-8?B?TEpHdzcrc2Q2T25ESjRJR1Z3K3lYMTNqZkNKWC9ENnlZQnllNzM5cFVBUFIx?=
 =?utf-8?B?RkJGcnh3NUVrNCtpUHdob043ZHpDeGpsUVlSNlkzeHVrZ0NISUROcDQ4SVlL?=
 =?utf-8?B?OFc1N3VtcGNWMm9EYU4zcVArb05CZmZMbFE3NUMwNFZRN0lCL1VRU052Tm5P?=
 =?utf-8?B?VGhRT1dKd3VyTGo1S1QxY29xd0hLYlNkMjBReHlDTHFTcDc1QTVrb0xVbDJX?=
 =?utf-8?B?eldTUnJUa2QybEhtU2IvUWhUS2pxR2NQdWtIM1l0bVVhZWZiRlhOdFQ4ZWJj?=
 =?utf-8?B?RU5rZWpsUWtiYXRtcnB5MTRqTTRxRnhQQ0ltZXNsYlI3aVNzZG9XSThtbkox?=
 =?utf-8?B?K3d6eEY0enFJcXpqc25Pa3FoOUFUaiszODJlSGFpUS9nZVl2WXZjY3NYVGZp?=
 =?utf-8?B?ZU9lL3lYWEdtVmZUcVZoYWNtelJDazFCRlhwVEpXUzY5T21DSEVWeTkzSWFK?=
 =?utf-8?B?ZHV1NWlkSXdvV3FZRzZvQWk3QVgxVUJJTE4vUXptOWVVTkJTdllieWxmK3hZ?=
 =?utf-8?B?TnlEU3IwVE1UeERubDVOQWVxNFR3Y3R2UjZCUWQvNjh2V2JFbWdhRU84Tnhx?=
 =?utf-8?B?c25uZkJHdVVzaUhrQWNRR1Bka0RkUHllUXlxYTdYZFExdXNncSt3dEZiMkQ5?=
 =?utf-8?B?YmVKRHpYK2VuREIraXh0OXlsVzR1eldleDJKczVuRzd6Z3NqeDJuRFZueC80?=
 =?utf-8?B?RzMyVXJ5ejBHZjJlNkU5UzBFYUFNSVhyS2FRRGFrek9iUlVtNGxOdWdFcUNw?=
 =?utf-8?B?bWdrTjNNOE14SGlRcnJRNmE5SndhMFF0NEd1eVkzeEx3T0ZVYTgycUU5TnUy?=
 =?utf-8?B?dnNkcXlSTk45bjVldU1NdnlIaWFhMmdGVWZvdHBPbmFrNWF1d0lzcjVMZlZk?=
 =?utf-8?B?NjlHd0FsMDNCUTNDc1QyVEovNy9pNVZaRjdMRHZjRFdsOEE1cTBDN0owVXRm?=
 =?utf-8?B?L25kZi9MMjRkWER1STFsazNhek8vZStTRk9lZi96dVk5NkVqN1JsS3VjM2hJ?=
 =?utf-8?B?Tm5VZWt5MUVRUVNNM3dVSGM5OEM3M084Ujk2Nm9XOFpjTEN6MldVQ0xnN1J5?=
 =?utf-8?B?QTNlOHNBbHlCZ2xoSnRZT0w2VkxKdkdqZ29iYXJ5T0dXVlNhbWJpWWIxcFd2?=
 =?utf-8?B?ZGVpQVk3dTE3a2RFZWowYXRsRGR0YURxMmx4d01KR2ZGWW9HSm42WWE5QzRr?=
 =?utf-8?B?bE5hVWxLRWxFa0s2MUk0M2lTUXJZNnFJTXJ4WjRINXplM1VTV2QxVmFuWEEx?=
 =?utf-8?B?dS85MXVXZWFVMkR2TnRPRkR2K3VBb3F1OVBTZ1RqSEdROFJrMjk2SnNtOVJs?=
 =?utf-8?B?cHcxclhaSEcwOTNMK05vTHhaNU9BOUpXNkJzVFo0b2h6ak9ONzl5U2E1ZWdK?=
 =?utf-8?B?SFVEdVB5b1RNWWdhUlFBWGFuSWJ3RzJLV3ozTmRGNHhRdkJpRFYwbVRsY0Vy?=
 =?utf-8?B?VU9wYU85cm1JSVVOTTNaQlVLZGtHVDkzNEh5YTltbllUdlF1a2ZiUTNrS3NE?=
 =?utf-8?B?dlgvcEkyeDloR3BWSWVvREtTb0tVQXRrVytralV2SCtVaG03U3dMVU5veURi?=
 =?utf-8?Q?0lyp8DF3bU8XAaFWukqRQ9fJwmZBZ/mNsnBMbGA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2317c78b-ab57-410a-a730-08dc2eb8cc24
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 06:30:41.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6778

On 2/16/2024 10:09 AM, Rob Herring wrote:
> On Fri, 16 Feb 2024 07:48:56 +0800, Yang Xiwen wrote:
>> This binding gets rewritten. Compared to previous txt based binding doc,
>> the following changes are made:
>>
>> - No "hisi-femac-v1/2" binding anymore
>> - Remove unused Hi3516 SoC, add Hi3798MV200
>> - add MDIO subnode
>> - add phy clock and reset
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>   .../devicetree/bindings/net/hisilicon-femac.yaml   | 125 +++++++++++++++++++++
>>   1 file changed, 125 insertions(+)
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/hisilicon-femac.example.dtb: /example-0/ethernet@9c30000/mdio@1100: failed to match any schema with compatible: ['hisilicon,hisi-femac-mdio']
it's fine. This compatible is documented in a plain text file 
`./hisi-femac-mdio.txt`.
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240216-net-v1-4-e0ad972cda99@outlook.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

-- 
Regards,
Yang Xiwen


