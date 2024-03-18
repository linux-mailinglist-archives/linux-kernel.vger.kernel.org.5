Return-Path: <linux-kernel+bounces-105924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095DA87E675
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2945C1C21863
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6EF2D029;
	Mon, 18 Mar 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="mj2aDmlR"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922122C692;
	Mon, 18 Mar 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755607; cv=fail; b=LlDlpJIZ54YuPHd0DpShm6XAzpSmu6rm5CadoAGKeGJQRozZSHA9d0N3fl5FEyP83j8Qkr2LH/20TpRjRgcIGr4mOHf+7KOmokQ62gnYvgaQopdP7sSZ1GQpE6N6pVgKoyomleokyhVyRK4ci/1vKxJJXpiJRWVovKkk0w7ZmAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755607; c=relaxed/simple;
	bh=L/DkK5eOZAYEezwrmIs4IkqMJsoA2SeCB3agZzsqneQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iluyGHUra8lpsVTTJsLs+ocOE7oozntwN+fJP8ZfZlS9HSRTcAvHulD89+FF8rlyTAWBNOqdrYbG/Ut/E/gw/O8hMV+9FxU0T9tj4aE3qjdfFGUhguSU9mrZ+YbuL9krBuXjLj/5oOXsHhg4CbJECMwNxA3QezGi/z0brPdvKjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=mj2aDmlR reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.220.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH1p9002cZzeu4a6yEJNuVP7RW53tusR+eNPTjKP4QTW6Oxuj3PB6TurApThvHd/n8EBslfkyfrm7383mO5raJ31HVtikEn6qe4ZRBNO6F6l1KtihlFz4ZjmJ4G/uVtY9SenKCbLraNUrrpE0xU0DIzhjFNcQTnDzYio1fFj61tmaXpVX0j2ysPONzPw4C3YJR4z+NPE1XW2gRHS7IM3/THT393ZFJR/D2/uasiDu4zMFtLp7go51tk61AsmXHDINlwl8BcJl7sb+sIF03cMXckP2qm/5ZbL1vRzc0Pbo6JwmNbz3JSM86GwA1oDIqltZXVoTWOuOFo8MrcMfv2Tpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRoUxzfQsi766FgN4eu8RdcBeYODo79dt6sdx0sOJqQ=;
 b=LPpEYNwfP4lBFr7p3wBI5oc0tUS7mC6jD92YbhNL7Wxbce2BLSC8fuOUBVg5WvbHP/s39k0KcHVWCWcuIVhTqr88mgUBm10b8i4zgoyjvovNpU29elb6EJXi9o5pj6da5NciDJvHgTg94i4f6SpA48YQ/rcNwOz2bLjGBtb+j5rgj3lk5gdwBEl18z25kYKeIByQV3DSny8/L8P3PIpMtQs5lwkiiffB/LXo9WbcrQg5av7uoMi+catA3w1NB2pQOQn77Es/6P6txumA0j2XBo/eqQDRqw38EVV9emfmAwhSHy5oDT0N1my8Wmf86uABz2krzw9y00BcQgmipoCYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRoUxzfQsi766FgN4eu8RdcBeYODo79dt6sdx0sOJqQ=;
 b=mj2aDmlRmTyXqgrPGZ64O/TZsxBwsf0Q4HbzzXBnzIE93jzXA4zUv1763he7ZXsJFpZ/LZfE7oTvP9Jvoc7J13l3il4d6uVmYwoVTz4dFm44XOifH0hRfP98IDn4X80NDn44RRT43I74IgDaucue6vzuMx3ZVM6EMgNAoIlMbVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 SA0PR01MB6473.prod.exchangelabs.com (2603:10b6:806:ec::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.23; Mon, 18 Mar 2024 09:53:23 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 09:53:23 +0000
Message-ID: <ce8b2b49-b194-42f7-8f83-fcbf7b460970@amperemail.onmicrosoft.com>
Date: Mon, 18 Mar 2024 16:53:17 +0700
User-Agent: Mozilla Thunderbird
From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Subject: Re: [PATCH 3/3] dt-bindings: hwmon: max31790: Add
 pwmout-pin-as-tach-input property
To: Rob Herring <robh@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
 <20240311111347.23067-4-chanh@os.amperecomputing.com>
 <20240311173438.GA1451467-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20240311173438.GA1451467-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|SA0PR01MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: d41d6db9-370a-4cfc-bf23-08dc47313fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LeYPdqCC8BpqcYGP86ZLJMGDsvpdx/zCUctOypWxAOyHKiLc8szjihcOog9QtNrmkcetjgHu1jTYftRDTZMZ7BsqblTEI8yIxH0TLyyHQCDHrTw5gJrGB43J8s2YX2bwoQPW3WhF6zeL7dlc2oOlCLtAJ9JU8xQG9hqKJpJh6R3eg1gEGtPtYKFIjNk1Jcm583FSmBmoOTOk/oTiukPs9z6xVWukNxRHGbw/fWAlt6D1pBZpbEDE/vXr4Rpqaquftj4sVDwPD8r1LpzTpum4+sBYUXqXt5znofUbP2DEO8cTG3PzGWzwri56GM1hnm/AIDNFkqaoZ4nnqYvZDfluYbpC8MwIaW3to7FFxNvTCAA9+6D+46s6dUEhYH76uwpCG4oqK+aXwgHNZ75osVl/wubC+PXJJ1sbP52a57m4lgEQvgZGmuY3Dp6wes7NlgSmXfYUMwfVWcOnEAgqnd7T0FwfrKzi0vvCK2LxCq3gRLGKpJLXXJFTZDiIEGpDVBUNSJFqRfzrhS3smqL993r4bRS49iDbHGuI231IgHQoV1MqdBzVELt/duDH3tnPQ8e4qyzn9Bknyd2fsIAxk8+2L+evfLeXHSqEfLn9PPI1y6GfpnB6DU6bPCpmzWQP7sYbGTYVjUGotgL/xPykgCIwVnE0x6ih4nYRP6qw7SCo9CY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHh6QVpteHg4cm1SQmhSOElValM5WVZIcHQzTitPY2c4WWFtS01KblRCRDM0?=
 =?utf-8?B?ZmNzT2UyZVVDMU9uc0hiKzFCKy9zSjBIWlBITS9pZnlCdXpJRS9wQkEyUFlG?=
 =?utf-8?B?OHg1TE9PVE5pWXhEdmhBZzRMdW12QnhuK05xMVZDcURXWEp6MDVuRlpsYWRk?=
 =?utf-8?B?d09tMCtadklTWlFPNWtGZGJQTzhWZXpYU05rTktRcWZ2c3dsZmM2dHFyUEdi?=
 =?utf-8?B?M2hsd0JTQ0ZadVRXNzl4a0lNVVQ5M1pQY3VOcFdYY1ZvZ0UybDE1QS9oazBH?=
 =?utf-8?B?ZDBCSVMxOHVhVGZaQlFkNkR2VzFPT21VM2t0QjBSVXRUQjhaWUVud3pUNFhm?=
 =?utf-8?B?WG9QQXhRMjFmN0w3L3k3eWxyWTJVK0k0ejR0Z3ZISnpNVDVqN2UzY2V0NjVr?=
 =?utf-8?B?eURJVm9tQzlDaFJIVUNYNXpPNytRMFg5QmJUUjZVVUl4MzVhNjh3NmhITnNP?=
 =?utf-8?B?RWlhWE1rRjBZam9JekpJaUlOK3pVSlgrRHFwak9BNHVhZzFaM1hmVzBMaUNz?=
 =?utf-8?B?MFl3SmFHOFp2ZTNCY1ZDN1lNdy9iS25jWjdCZ2xwRitQVTNEakZEOFY0VFE1?=
 =?utf-8?B?djFrMTRGdDBjUE1aT3FpL256S25uYVR5WVJIcFNrNmxKWWxYNUNxNWdoeGxT?=
 =?utf-8?B?bkw3Y1NzK0Y3d2d1dkNqa24wbEZsM0hkTm8xejlnK3hkWDZ1emlRbW1XQjg5?=
 =?utf-8?B?ak5OZUZVbnlqVlkvL05Gc0QyaCtIdE84OEovSFJBNkFWZ04xM0M1UFQzWlU4?=
 =?utf-8?B?V1lBN3BWSHFSYUhHbVI2U25qTGpqR0NiY2daOENETFAxdVFBbDViV2FicEky?=
 =?utf-8?B?MVB1cTczRkVPYjdBc2NOWVVLVjVIbkJ1WGUrYWI4Rit5MHdoQVQrSW1IdzFJ?=
 =?utf-8?B?dGhZNU84dzRFYTlsMkZ6MkdCMzFSQUVQOXpRWXBtY1dFeVRGUUZoQ3NrWGZE?=
 =?utf-8?B?UXhGME1PWkpxcjd0UHZNRlFhWTlkdmlMUjRhU28zVzhOWTNwSGM1aGs3SSs4?=
 =?utf-8?B?MjBWMW9qYVg5RTFBeTVNejhVVmc0bGZ0M3Y1UjgvQW84elpXSGtDLzJ4ZTRM?=
 =?utf-8?B?aVdxRmhDU25JWndEZTZwVHVzWnFCaUVhUS90MmlEaHZnZUNKaFErc0Q3dG5E?=
 =?utf-8?B?Nzl5VzFZQ0dCT2NOVmlZYmN4NXN4NjRWVmxac3Z1M3hkb3J5TU50SG9tZE82?=
 =?utf-8?B?cEJKVnJOc2x1NnYrNWRTVEpHMWNlcHkxSW1QWEQwMmtGODhEMzRNdEFEQ3lR?=
 =?utf-8?B?QmttNFhnc3NITnQzZ3NMVGJzdUZSQWh6S3JsdjBlRmxXYUdlQ25oVWp0RzhE?=
 =?utf-8?B?K1JkamNZL1JiNzJtLzdTeUlXVWl0anBuWnd0UE1lKzB5U3FrdjRDMG84MUhY?=
 =?utf-8?B?R1dYZUxIS0Z5a21GdDRGM3ZiZWhPZmRxOEU1Z05KaW9pYjRMT1pZZ2ZXaUpR?=
 =?utf-8?B?OFEra2xJRTNWUlVyQlM2VDNLT1ZZRWxCZVVZd3ZkaGdwem5KSDN2ZUhFODFE?=
 =?utf-8?B?cmttQjNadnhDSkRYdnNjZGxNdC9RSVBhZTdncmprWEpNRzFEYUwrSWlnS0VS?=
 =?utf-8?B?NEZYU2VPVkFjamtDSGxzakVLdldLTUp6ZkI0VUQwc0cwTGNFeit1ZUtNZGwz?=
 =?utf-8?B?TFpSQ2Q4cnJ0VnBzeUNraklta3NWcGxCLzdCZFRTdElmanp0MWVDV0dyNmFV?=
 =?utf-8?B?UWgwK0VxNW5QUWEvNlVlenZmc0hRZUhyY01ORGlEa0pVWHVZemR4SDVvRnNE?=
 =?utf-8?B?TS8zTG4xU3VqblpFdjdBM0xXY2JoRk1KUU1NOVBRZVd5NTBORXpLZk5ERlVz?=
 =?utf-8?B?ODRLM0gyMlBXcjRoRkdra2NlTDMxb2VhZ1Z6aFZmR0p5NmJMMlhoNWsvaitm?=
 =?utf-8?B?VDRpMzFYRTE4c0ZqSFVFVlhSdFVWUVRwTVdIQzByeGw4ZndSWG1KOTU2OWQ5?=
 =?utf-8?B?cGdoWkwwRlk3R0tuVEV5WGFicXEwc0FyMmRLNGVWY3FsWUxlK0R1Mmt0bzNv?=
 =?utf-8?B?QUpMQTRlcmtHOEVtRUk3b1VXZGZHV2xxK2xiWXNPME02S0wwN002NTFKVmdo?=
 =?utf-8?B?em5vMnJXWGV0d1BMQmZRYnM3eEo3T0Njejl3bS95aHI2ZUNBN1JZN005WTJ5?=
 =?utf-8?B?bWVNdzltd0R5cWprUWU4eGNsR21tUnpqeHQ3NEp4NHhmUGZxTXMzQm96VW1N?=
 =?utf-8?Q?hQMc8AIIM4U8l+UOgfPQRjI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d6db9-370a-4cfc-bf23-08dc47313fa1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:53:22.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5IB0STQqwkP5PmG+PpN41urW14l4zlI/49DFS+NTql2/PWA1FAwX8AsGKtpvofo4TOsKRxFfxUBfXd82HxR39evHaNDFvOOcvomkVB3jHWyj4HoGozS6rY4FmScbKC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6473



On 12/03/2024 00:34, Rob Herring wrote:
> On Mon, Mar 11, 2024 at 06:13:47PM +0700, Chanh Nguyen wrote:
>> Add pwmout-pin-as-tach-input property.
>>
>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>> ---
>>   Documentation/devicetree/bindings/hwmon/max31790.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/max31790.yaml b/Documentation/devicetree/bindings/hwmon/max31790.yaml
>> index 5a93e6bdebda..447cac17053a 100644
>> --- a/Documentation/devicetree/bindings/hwmon/max31790.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/max31790.yaml
>> @@ -25,6 +25,16 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  pwmout-pin-as-tach-input:
>> +    description: |
>> +      An array of six integers responds to six PWM channels for
>> +      configuring the pwm to tach mode.
>> +      When set to 0, the associated PWMOUT produces a PWM waveform for
>> +      control of fan speed. When set to 1, PWMOUT becomes a TACH input
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    maxItems: 6
>> +    minItems: 6
> 
> Seems incomplete. For example, fan tachs have different number of
> pulses per revolution, don't you need to know that too?
> 
> There's a common fan binding now (or pending). You should use that and
> this property won't be needed.
> 
> Rob

Thank Rob,

I checked in the 
Documentation/devicetree/bindings/hwmon/fan-common.yaml. I found the 
tach-ch property, but it seems define the tach channel used for fan.

   tach-ch:
     description:
       The tach channel used for the fan.
     $ref: /schemas/types.yaml#/definitions/uint8-array

I would like to define a new vendor property to configure the PWM-OUT 
pin to become a TACH-IN pin. So I introduce the 
"maxim,pwmout-pin-as-tach-input" property. Please help me share your 
comments!

