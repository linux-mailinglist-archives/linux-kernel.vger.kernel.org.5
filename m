Return-Path: <linux-kernel+bounces-38058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165B83BA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1D7B22DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38162111B5;
	Thu, 25 Jan 2024 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gbhHpNW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B71119A;
	Thu, 25 Jan 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706166416; cv=fail; b=Ye0Hvhsv6EXb+V6tuOdXYfOU6YB8lU93whJlOQvb6GCtNAx6vanvGkmwYzmluYj+NaVQv7JeVu8+LMg7Xs4y3crDK68hpi1TwAYanvMaOGcuVCVZ0VVBcokWZuhMOgmE9eCMZzR74+fAMMEHVFH9DW+7bY+KcOAKFlQkbn26qeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706166416; c=relaxed/simple;
	bh=XGF84Lor6q+USyH8VxdcBAwROS+FBr0wPfhPKPjhn9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fmGWS5mu7CKtKHm9y4OKIpjd2QrRrRcxv+trtluKoSbi5qAbbq0WJShuiSwC/bW+/3gSxIyP2pWjrKlpLNZID44RqhIaHjDGwZe2lLagHuG80LBXGnVMrUWc/tIO2z75369t27ZlCmEicmw+wLmzZfY04NjrIFyfHb9lVLnja7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gbhHpNW; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8eE9bPL9wYP1ZUNUcU9Nzvep66AHEhnjYY995MdpEQdOBVPYbk54epTlNwCCpwpzrQTJYGpDftzwW7az34LrLvtX/gsKTuqGht9BDDtmaURGshemeRoZw3wy/nkRQg0tD8LSSLiQw1M9cWax8BcN4nIhxLX2PrCr4Yp+QNK0s73IYLuBbE/pYQDRgm2rpnHmieyrUvVkrfr3xKlFO0XZPVcBCVzlMEAhanZsjraNx5c2EkW+JLabRAwYgR0EPmM92zwh5X2hAtTVx5G6lSrPOdPZTbpfxA8WVCDY1UW94DAwtIjY2Fs7F9ZxqWAv+MqseCmAB5qOZ7V177sjBCQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJomHCpULmcT7yu/L+pOBzLm1UC6qCiw/anIb1HBd9o=;
 b=iLgdRsOhLd6NyiBURon+3j5pRn10heuCYWvBzdjJDlRZpCpvh+daO8yzHRCVC7aXBvnD9I1ED5fB0VlLuMqCYmv9ZodLqJwy72iDnqxASTNw/CC/mEpVYaS7Os9lkenHegmcROmnXrRJWLeeK1+D1rbi3zFfkT0qxLk7YpFuXJvef/9n/26CZVkD7GLz3Or655vS4IGgbvuuph3Pw797VaXj4a9PpNL+mKKPbDQGlnSb/fFkBUuExMJb6i377zqa3LY2UXRERZDqQo/5S3lWHJsWTz+3LIGbLRckPFu3DMi2TESkJhyjZuK4yQCbAJRjwW4H+odbMwPcuTST9kgz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJomHCpULmcT7yu/L+pOBzLm1UC6qCiw/anIb1HBd9o=;
 b=2gbhHpNWhQB24iyO8Y57M+zlgScDHu5GLeTqlTcI7xwZT3lIjwFiRDNx3vHathKAKBt0wx+KxERLMbQFViAf4KyEQj3dNUvLSgqJcMA8wda1lVgnqcTO9lIz2y+lalRxjBVDzMLKobbfgVoFD+0miUiubFJgjupi4MmCLcCB0J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 07:06:51 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 07:06:51 +0000
Message-ID: <5f2e3917-4767-48ca-9217-fc51fb181daa@amd.com>
Date: Thu, 25 Jan 2024 08:06:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pinctr: pinctrl-zynq: Fix compatible string
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <c1307a4dd5e30290acacc786cb2170deb9eaa539.1706087258.git.michal.simek@amd.com>
 <20240124-frolic-onyx-56bd63791aca@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240124-frolic-onyx-56bd63791aca@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:803:50::45) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0707602d-2445-4e2c-b890-08dc1d743465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ucb1izrxQF85MENhOlVmzCqh4bMEG22A19ujv3C3vG8C5DfkA4ko7ZCy7xJi7lUAHvpbPgdL9lwGti4+d0LVZBg1q5wTDdNi8095ttSFT81K/ZQoAU2kb+zFuM9jqCK3j+Yy/qj/iqv7GcoVHiBvMNbFCRkr3i3byYQhA0ext2mKrrtPLUreKp8sY3trOoXC+iseSMIp4MtbT2B5KRnKSrPE0mnOlbmlWEft/uG6/hdvbO6gqBUEeLBeUmI194i3oD6N+aCJjZELq+IdCkT1buQCnDnUlZW4tZRi1YcaldxAUGTZ9WxeKm92Syoi3sikUMzppWP2jbYvDtBfQ7JOyJbdeCAB/WtIihYvV2knEosKlNZrV5PfX56mKf1DKq77UHfnSSRHu0+n0BDeF6ix1vevty60gGSFgPZ9i69x2HDCtsi6iiM+rb6atqGWXq39UFJLu5dxstNZ5W4MqjWfoCJ2ZRH+cj+tPQKT33lZu7/ixgjo5aKdKUWY0LBav35fnQj2xH5ZDtnJD4PkTu5ucdI513Ib27gSi6pU9qqATLQXrqU/0iECBNJg6QHJLUPKXkQJ7Nq2pEa8u04uvh5oF69uqEr15AcOrU9okgjrNWnrH6YD8h+LdSmZcSVclc+mlnD5UuhC8zAN62ngY9KQZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(41300700001)(83380400001)(36756003)(31696002)(86362001)(38100700002)(2616005)(6512007)(26005)(6486002)(6506007)(6916009)(2906002)(66556008)(44832011)(478600001)(4744005)(66946007)(316002)(53546011)(54906003)(66476007)(6666004)(4326008)(7416002)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3l5TkN2M3d2N3VjZWhES0VQZUo5Y1EyVXNxbzVZYTkramRIU2c4Z2ZUcUc2?=
 =?utf-8?B?N3FVbGxlVUM0VHpaWVlRNTIxZXI4R2pIOGZMQVU1WU9jWFYzU0FNQVpNUmsy?=
 =?utf-8?B?VDkrZnlqaS9RNXU5cElCaUpXeGczTXNsVE8wb2Z5K1dGbStSZUt1U09TZFAz?=
 =?utf-8?B?a3JGL1pKbzg1OEhSZU5hOG9yM2xrS2JwZ2pNbGVTZjRFd3ZFcXlhcVRzYWRr?=
 =?utf-8?B?MmhFMGlBVUI4U1gyVERWYTFCZ2ljM0M2SVVRQm1tL0pNRy9vejhBSXI4TFdw?=
 =?utf-8?B?RlIzYUpqZzFhMWwyNkVmcXJVY1VCUUxleVRPc0ZpMU9TandWcEJWWUtKSlg1?=
 =?utf-8?B?MmQ4WW0xaXl6QkdzN2FORE5pcXIyZURpU2FwbG1OSEhvRGdVMHRTdExMMGZT?=
 =?utf-8?B?M3A1R1J2dC8zK0U2Z2dKRmtka08vdForMkxTWFU1MGdMUm9rcXI5WHlNdkNi?=
 =?utf-8?B?TTVpVmtLZTQrZXo3ZG5qTmV0bENwaTMxWjlCNjN4NC9jKzJpSW5ISUFkb3pY?=
 =?utf-8?B?ckY5WmR1SmJobTIzZytKckt4MS96RFNBU1JTVVhzV2VwM1llUEIxeTdLY0RG?=
 =?utf-8?B?OU1rTHp2U05zbjVmZzVBZlI4MkVwOEh2VUZjdit1V21jNkZ3NmVtUmF2b0dl?=
 =?utf-8?B?NHFQR09LS3A1NzhVQTFYeEo2NGszS2ord2dpNDdjeUsxSHpFdU9zQzA2aS9S?=
 =?utf-8?B?ZTZYdUNCK0xHcGx6czQwakp2cEliUXFkMWZVaUtwYjVzNks5TEFTTU91cFZD?=
 =?utf-8?B?YXpicTE1ZjNSRmZsaGhUQjNoTERqdTBieWRzQ2hhdUtqeXMxMXFvMG5KMWMy?=
 =?utf-8?B?UkRSb1p0K3pSQXlLWTQ1eE9KTzhaQTZpK2xuUm92Ti8xNlVna0JVVUNmL2tI?=
 =?utf-8?B?UlVvYTRPTFp0N2pxaXVaVDFmQ3RNMWF5dmZxR3M4eFJZSnZ2WU1LSDV2N2VT?=
 =?utf-8?B?Q0NvMFNnMVVId0pGYXlvd0YyYjVIcUFyOFkxY0drOXgveTUzZlRWai9kSjYz?=
 =?utf-8?B?cTE4VHJTVE1WcHlpa2xFRG1qMUptMzdBUmZLS2FFeWVXM0pWMTFha0o1anNQ?=
 =?utf-8?B?WWsrTStmSi9SdjVQVEUya3RhdnU1aXRCMEhoU1JkQTBIWjJhWk1KN3NqZmxO?=
 =?utf-8?B?S1lQWVptV1Z1ZDZuRmlYcWw3VGlURnJzbGtrOVppVWJQQmpsbHF5djBpdVNZ?=
 =?utf-8?B?R3F2VDBoUiszUmROM0ZjK001dW5aSFlZOGp1enB3d3J6bSs4TjNxb3lvYkZF?=
 =?utf-8?B?NkRwek9HTzJCeS9TVk5GYloyeGVJNVJyZmhtaEtJYlpzNUhxTjhpWTNmdUYz?=
 =?utf-8?B?WW1Dc1Z2YmFQZjZ0SmE0TG43VEw4RFVYU21ydWl6cDVmL1ZiSjNQU0RmaHZD?=
 =?utf-8?B?TWFqSUVaemd1UndiKzQwSHVhSTMxWVZFekJwKzFsbHF5aEJFSytucjNRZWdB?=
 =?utf-8?B?bERkMnhPbzdmOWp6MUpybWtSa1hiU0JmU2U3cCtNc2krcTNpWlJSMUxManlJ?=
 =?utf-8?B?ZzdUMEY2VDgxTml4SGxCVjZFTzZLYmt3aGs0NG5kWnZhMnJZYm1LWEV5UEc2?=
 =?utf-8?B?SmoxT3JkRkNyYkVNbGJmcE5MK2xTYUdHdUF0TWY5VVVoTkVHWXJZL0FJODhI?=
 =?utf-8?B?WlJKa1lPWEd4UHZXLzlzT055Sk5QcUdlYVNvV0lML0xGV0RDaGsxcisxOWZW?=
 =?utf-8?B?WFBHcCtnK29QTWdHU1UrVWlwcmEvTGZ4YTNXNThMNFFnM1JSeGJWT3hvUmpj?=
 =?utf-8?B?VytMWnlsUG9BZElkYVlzVUZnQVRvKzY0SzhCdklPdERpa3FCcFNrMExwOW44?=
 =?utf-8?B?OFFvV1VCSWs5YW5FVGhOUXo4cjhnaHVmWDBrSEhKMlN2N0V6STlCRGxFdlZH?=
 =?utf-8?B?TmQzS1hzSzlMN1pDWkE5NGlzYUZwZkxCRVBobm9IcGdhamRORzlmeVRMMW8v?=
 =?utf-8?B?NzcxVzlmQ1JsN2w3VjA1Y0d2MGhubUJZQVZoeFdvRS9iWWhEYmZueVltOXY2?=
 =?utf-8?B?eGVDQ1pwVVhJd3l2VUpHeC9leFVHSytGekc3Y2xqYUc4eVUzd3EwUTJnR1ls?=
 =?utf-8?B?ZTZwdnZTVHlpNnpudEc0ZXM2Zyt3M3J4ZXJYMGV4VXEzOVBMVXhnY1RMNXBk?=
 =?utf-8?Q?asRtWzFZvrkthjB5LfnK/Pd+b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0707602d-2445-4e2c-b890-08dc1d743465
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 07:06:51.4335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LbLt4oNTlTz+kP1aMeCO6jwszQrOVcR4Qh00MDFfqJPWuns1aY/270Xw5f1xaEa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045



On 1/24/24 17:16, Conor Dooley wrote:
> On Wed, Jan 24, 2024 at 10:07:46AM +0100, Michal Simek wrote:
>> Compatible string doesn't really match with compatible string listed in the
>> driver itself. While binding was converted from txt to yaml
>> xlnx,zynq-pinctrl was listed as compatible string but example was using
>> xlnx,pinctrl-zynq and also this string is used in all DTSes.
>> xlnx,zynq-pinctrl is used only in dt binding and not present in any DT
>> which is stable for quite a long time that's why use old compatible string
>> and update binding document instead of starting to use unused compatible
>> string.
>>
>> Fixes: 153df45acda0 ("dt-bindings: pinctrl: pinctrl-zynq: Convert to yaml")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> I assume that U-Boot etc all use the "incorrect" compatible as was in
> the example? If they do, then the patch seems good to me.

Yes. U-Boot is using "incorrect" compatible string from 2015.

Thanks,
Michal

