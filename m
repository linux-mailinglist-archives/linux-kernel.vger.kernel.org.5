Return-Path: <linux-kernel+bounces-49789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB519846F69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574A9286D68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535813BEB5;
	Fri,  2 Feb 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="SbW4IRTu"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2138.outbound.protection.outlook.com [40.107.241.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF63168AB;
	Fri,  2 Feb 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874577; cv=fail; b=VnwLyepdYAyuAN9aCLrx3V5p1NaWhWiC2sgs/CybyFNW5hBU2iG1WBXL5PJ92UObY33cvgthnl9ZznIPPTAr4iOygKswM/6/LidRJ0VmInUls2DcpHERaMMWCTz6N8VrrougaxTGaBG3+16XIP2JiWx7jOIobjtgFGhS5wYTKZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874577; c=relaxed/simple;
	bh=mgkPUbPZpGptdNrJLVZL6vtOMx6twc3sz+KeUjrtxnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=afjr89jrBkwhRX1iw9eDIQfJog8N/fCZByyxIzODdqVQXyq4fCNS4uGBIHG4/+E/wBUnJMgaFJVHMwps4ixeCR/hL1wQHWKqURUWD2mKW+QaVCMw/2+Il47S3e39rjn8ZwN/4qtBEFn65cylb4R1IwtQOhzhTAwNF8FPMGEFL4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=SbW4IRTu; arc=fail smtp.client-ip=40.107.241.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lee7jfZnISw5XHoxagV71eMph7KLI6rbUMSZyQl745Ba7j3sR2YO9iLPnEVdloGP7PSoo4xzaUiEY37Zx74k+DriGwJbfs7BGHmIjp9xlCEx9iTepJ24WkwJs4qmwHpPAgtRoPq+rE5lEfHOh4O/CRTcfHFPFtxP/LFCnEw6Oc5aci8ApN/7xef2rtS+cxDK9MHhgkZG+GhdI5XGjPK8PaF3dl/qezQ2M0nA9ru3DPQFpYsxA2du+0Z4XJJgcjYZceo4iZoonTLq116QzISv6CgL585UXzJX4UBzA6cvUDd/5E9TeSgs37I+nGtLW2DEbDUO3XCbiPFEAHuhheJw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UkFJv2bBADZCd+Yr8aJGTXk2MNK464JF1Z3V9J2eSA=;
 b=TfZ+61hlkND1FgoOXULKRRlt3pTqzscmsmeEeYjkCWLc1uZftaJr9vqlxXFchrj/A55EucR4hHA7iz/f7oDobAKNA3nMN1ZED3KPmKs7pi6Ravlm8XLS6fod1HFSryR6L0yOqUyi1sc8JAhKhOlRE9+1AkGjt6N0lbGOVtAogdMXJDgKdGXBUDU+BqTQjRbiUqpEyHRtozX5RgwEDsZ7vAwQaGheTIFk6HRXw9/gFyAq3sM63Iq7AqxbnEvzzoKowgCujZZrFOGy8Fh8LOvbzpLXKKsMiSCWhzrlmJIUIDVScJiZnlxcUdoQ5vxrDahsnG5nTr7/SEHA+XWUBuVLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UkFJv2bBADZCd+Yr8aJGTXk2MNK464JF1Z3V9J2eSA=;
 b=SbW4IRTuWJZ7/LRNs5zJvdb9gPM0E8QZ38z5OiNioHxsv5J22IVHPf1hXTVEZfqbfRvHAUqg5U+qKKvqPBWK8re9xCWl+2gBinWwmiXL6Ivpp47HD9JI+vSWy07A151S7i050TnNthEF5getyavheK4LhTcPuZh1PmoAjjn76J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AS8PR02MB10411.eurprd02.prod.outlook.com (2603:10a6:20b:5be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 11:49:29 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::693e:dced:4695:274f]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::693e:dced:4695:274f%6]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 11:49:28 +0000
Message-ID: <e8b30740-379c-9ab0-6bd7-d4726f822381@axentia.se>
Date: Fri, 2 Feb 2024 12:49:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Content-Language: sv-SE, en-US
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
 <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org>
 <20240131163516.000043df@Huawei.com>
 <20240131-stylized-defile-d8fe346ab197@spud>
 <CABqG17iNxfKFNqydkgo6gL8ZmaZ_bqm=pG8kNEhzx_h2eaGuhQ@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <CABqG17iNxfKFNqydkgo6gL8ZmaZ_bqm=pG8kNEhzx_h2eaGuhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF000013EC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::19) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AS8PR02MB10411:EE_
X-MS-Office365-Filtering-Correlation-Id: 72aaf025-9b2d-4ca5-c559-08dc23e50305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mAa61vVh7byqm6TFqwYhGXq0MeK+jgHQrPlCgAVjnJwt9UpVFXTswmeV76+m2QEwDhqaEg1KTNGD5JptpH+jHDKK2ulEnr2r74GcR27tfPywL6SImRkZRR8ywkY6Qd1XmJ8WH+zFdMW4Rl2tfDhmOdrN8N0N6wwVeRf1U5CDoEjWVEArUxxKW3OXhgFP4NUrm8+gA+SoNybAPfQg3RfW8ZGsTL5wfigoJ0GnLbeWczoBldrzG2A/26FKWkm/rzuw6c/yaZ3rHbHqvVsC+ILhmmcj+TkFB2ot0U6JcdXmJwyQjwRAr9BKzQeVGqMb75BC3vo/xtQrhkQ2Eftc90PGSC5znaUHhK1rIxX1UAvmYXNWp9VJUYBEZi+07pQhMyn7wwXYPl3isESAgx2thvHhANei1yBE69DcB+zlderqMrLFhSDsk7Ef2NZ3PPHIEyKKD9ih5qdhyBTuPlG4H4nRbYjlVtn1/x1NhRUsR+mJqYnVujOYPDmR/Uk4N45MsFFAwl3y8PulG/mfg8PjpSYlK1q7J6rjQo1RxTbU4IUqKgRSODpIhBLgvZjSCsYISptvEAWbL/P+NehJSsrQVUTpKoV3gz9HyuuMhIM0u2TDNUF1SVcbgkHbIoK8ogV7EWuFs3RgKeH8gi9+o0n/lD1fzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39840400004)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(83380400001)(36756003)(31696002)(86362001)(38100700002)(26005)(6512007)(2616005)(8936002)(6506007)(478600001)(53546011)(66946007)(316002)(66476007)(54906003)(66556008)(7416002)(4326008)(2906002)(5660300002)(6486002)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZ4NG54WWFkeGl3bFpHcThtUFBnckwybVJxNzNlOFp6Qkh2MXJTcGlNN2gw?=
 =?utf-8?B?N3kvSW9GUW4wYmVtQ1duZUxDRUo4N1lWM3ptVUZrYitOY2V0Y1FsZkYrSS9P?=
 =?utf-8?B?MFhoaEdQREh1SXF6YXByNUZnZEVTeXNVak96VDNVbElZOEhIRVl4aHNvb2xQ?=
 =?utf-8?B?aGJ1WEd1TUNoUTFuWDhYTDhSNWxYdGxTZndBbVU5TndOYjRiTW80M0dMVnhD?=
 =?utf-8?B?RHR5ZFVXZnVMUVFWWGRzRU1jVjd6bUdYeVNTdVQvaHR1TGRaUEUxUW9PWXVN?=
 =?utf-8?B?WkhuaVZPYWtwWG9QQnhLTjBFZE1RT08vdEFSTmNQSHQ5MEF3dTVhQ2FCVWJa?=
 =?utf-8?B?cDlTdk4rOUVDL09UaGcrcEhUYlhWUzE2bFlPZnNjaE12NzJKdVFzQ3ZUOWdy?=
 =?utf-8?B?NU5TVXcxbUJIM2M1NnBjWGZINDE4RmloR09iTkxnQmxnODhWa3F4Tm1mdHJL?=
 =?utf-8?B?SUQxMkhoYkNkTE1jUy9UbWduVkhvSzcwRmFYZU1HYS9lMG5TWGZISVFYbHQ4?=
 =?utf-8?B?M1lCcFdCUWRrRnJHMm1wRnp1VXhNcDQ4Titia1lTZmE0NlQvazYzcFlDUzh4?=
 =?utf-8?B?bXNrYXhGYVc2U2tzZExYa1hBZE9hSE8wSzcrdC9FOGp2U1lWalp0SFF4ZTBX?=
 =?utf-8?B?RGNySjJoZk5iY2FDUExOUVJ4L0lQV1BkY3VXR1U5c1NIUjJFS1JGUE5FVFRx?=
 =?utf-8?B?c3dnSXFXd1d3QjllckVvMFFWbVNuclpjYjEva3ViRHVseGNJWloraVZKaWg3?=
 =?utf-8?B?M0pMRjdBYlRkZmNIbEhFMVhyTGVjOWR1MEhCU0phWGpySXZuUXRwNGNtT25I?=
 =?utf-8?B?d3BuMmlPcEZTMUNrcXNrTXNjNjVRNUdzYTc5Qk13cjkzZ2ZiKzB4WjBacjll?=
 =?utf-8?B?M282bWtNTXVtOHhGNmNqZE5oa2I5djdRZkczeDFWWExiTFV6Vy8wTWVpNE5S?=
 =?utf-8?B?a1dKQnZEN2FYUUh5R0JnUWpndnkweTRTa3NGYkYxcmhSeHJHbG1JdUMveGhu?=
 =?utf-8?B?ZGdNYlU0QkpneHdXd3IwaERlOFppMkg2SVJXUFRyWU44NnlqYzg2ZnNldmxr?=
 =?utf-8?B?ZmEwSjlJUUljb0MxS0hpRUpZZHRsZWxNSDQxYnNSUWtJL3FuZWZrUUxqWkFy?=
 =?utf-8?B?VitMN1BYSlhwVm9VK0ZNSlJvT2VLWWJPOEpnM29jL1FxbFV4Q3RRY0N4VG9T?=
 =?utf-8?B?dllHZW1IRUZoVXRXUkFVVk1CNjNtQzQ5UFV0clVOSVlSaVJ1WVA5K09FbkUr?=
 =?utf-8?B?bTJyZDQweklRR0g2VUhmbnpobE5CY0NVeUxFOVFEYXFLVHdxM0RvVlBhcUR4?=
 =?utf-8?B?Z3pLdUZJZ2NwZDUzRXJNbUhyM244TTViYno3ejVrVGM0ZkFWVkI5T1lIMVNX?=
 =?utf-8?B?b3RmUW5lVEd0K1hqY1k0NVRpeTNJTkptVlp6Mk1pSVVTYUJoeS81Sy9ueStV?=
 =?utf-8?B?TlRNVVc3dzhUbERwSmJYOW5tRVdCMzZlSnN0SlRrTWh6a1N4ZW83UWhTQXZK?=
 =?utf-8?B?ZmFsZWx3WEdRUlBnRCtHWkJ3cE5QbmNZRTBKZjU2ZEhkV2Nyd0h1V1BnMWtF?=
 =?utf-8?B?RGNERDFPeUNoeDdOY2U5SnNqTFFldVRHRWVLNDJlZWJCbk83U2FlakN1eGow?=
 =?utf-8?B?SWZYK0d6WFVIdGk4ak5aN2hRcUZaNnNFTEUyM2MwempnTDh5NEFLZ2JadVVD?=
 =?utf-8?B?K0dkaUxMNDY2M0xCMk8wS1FDQTJOcFhyeUM2M1JpMnROd3ZUeWhmSHczUStV?=
 =?utf-8?B?eWZDSDl5Qk45ZVhZeVNwWHVCdzB3WFNFR1NteDF6d0hoTTlUYlFacXVwbVBO?=
 =?utf-8?B?T0hXaDJhWkRYbXEwenZ2Y01NY0xHUEd3NUQzNVV5VFdaR1BLQzRrS0Nvc0Zs?=
 =?utf-8?B?UGFUdVZJaHU5azlqZXF5VzRrVGtFV2FHazZZZEtKcVFsbEdEdG1sR1RwcGVK?=
 =?utf-8?B?T3IyLzBvd0tzQm5uQnRqOUNjR1BUVG5LMjNPWjhKcFJ4WHhWanRWVFpYNmts?=
 =?utf-8?B?dUxyV2RLZE80Z2ZCaDJEK0Z4N0o3WlZCZHc2djUwVDRtTVJoSURUSGdZdWdN?=
 =?utf-8?B?bzRaY2hyTWR2Y1hUSXVIRUJvd2FDVVpPNEgwaDFoZjVDeW5YTWJWeFdqUVBr?=
 =?utf-8?Q?BwXoNFZWZlak+XXfnK9nl9Hhm?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aaf025-9b2d-4ca5-c559-08dc23e50305
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:49:28.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRcJvBzXltiimHZ1YxsSd67LOVIH9a8rnVcu7zeEJCdQAtAVO15onwdN6lECIXoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10411

Hi!

2024-02-02 at 11:43, Naresh Solanki wrote:
> Hi,
> 
> 
> On Wed, 31 Jan 2024 at 22:24, Conor Dooley <conor@kernel.org> wrote:
>>
>> On Wed, Jan 31, 2024 at 04:35:16PM +0000, Jonathan Cameron wrote:
>>> On Wed, 31 Jan 2024 09:29:59 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 30/01/2024 12:56, Naresh Solanki wrote:
>>> Conor requested an example of the device acting as a consumer and a provider.
>>> Might have meant in the patch description?
>>>
>>> Conor?
>>
>> I wanted it in the property description to help with understanding when
>> to use it. I don't think the extra example nodes actually help you
>> understand what it is doing, only how to write one yourself once you
>> know you need it.
> I'm not sure if I get it right but what I understood is that a
> voltage-divider can
> also be a provider to other devices & hence the property.
> Also do you want me to put a complete example of it in description ?

My understanding is the requested example in the description should not
be exactly /how/ to hook up the voltage-divider as a provider, but
instead have some words about why it is interesting to do so at all. And
those words would also make it clear that is even possible. The latter
is something which, to be honest, is perhaps not all that obvious. It
has always been totally obvious to me of course, sorry for not being
clearer when I wrote the binding...

Cheers,
Peter

