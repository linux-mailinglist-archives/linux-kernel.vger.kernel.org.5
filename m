Return-Path: <linux-kernel+bounces-48356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5D845AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EC31F2585B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0162141;
	Thu,  1 Feb 2024 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="LV6k9hUt"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBB626B0;
	Thu,  1 Feb 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799847; cv=fail; b=IOAumtkN8mg0myfvZgVxuUjqEtqUNCdyb/uAQQWmj3p5MJUWMF4AhTs34+TIZLiD9qw7uSftH+LW1fWn8hGnbEePMEgw1IA0FIGnXpiUFZ+zMyVexddnL2eYLXSM1bNnaw5STsB+czST80NW0pOap73Xs9SRdiOfq4BHEy9m1iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799847; c=relaxed/simple;
	bh=pVHm9H7V1jokh5EqfJIzaS5d96j/xyq8tWl04Bib/6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G+lie9PFkfujmIX2jnB6b307ofgNbwj5moEFEbt0cez+oLI7IiAnFIgRTIzEnMfzArTkG4TIgoDgzAm8OIJKmP7pupzGOVGXoPSCjcIGxjtSoQjM9s1Xg0Wq5bvhBcb1OrOTnRQntkBNJUjvs2LzLwvKnXHjtU6oInKGQP5qUyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=LV6k9hUt; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXDC13GJn9EtNafph2wSMOgCq+EQKYjoz+LiNeczIJ9xMmQiKwWyfkOfrCu3fI6sOv9ta8w2hoqL0nxPLNy8NZm232kTBHOeowasM+QBcbWqj/vw+YdVimg4rW8AnMUxKFeDFYusQyXMKHWTOrkXI7FzUijKALXJee8tpB4jqdJ2ALuN1BmJm0xXGhKPXczCQPqR2KDbENdTZVwHGW7+iS7psSfivQLCB3zooorQLbrzIGxF4nU/SBxsvMo3uwBlhCrFa4/8/41RinDIOKmbs9+z4jJV7Dd8cplQ6c5SgWUmjdKZ/J5llpUOHboc8xHFIuxFGaYOZ3IJGYRL6TaUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meBZfXvtH0W6hvOi/i0iU5QR5ywYWl2OUcxJ7gL8XOU=;
 b=gI5ulT4vUQwC/E5pR0KUooPVXfZktTfvaUFMDAJ2hfw6Xiw19t8XQ2wTFMlVMxc4IcPTlcx1J322bRuh9oxfvOg3mPuuKjjzZU3zn2d12kc4dItOCtzKzNjSi+VJJBDvV8cvIeRKQNt9lAPfYFjUD36HNsNdedY5nJIvozPQIGCf+LIEEh2WXGzFs+Hslq927THPmK2BsDp9Akm8KnQsDRBpBSmGnTvyVIDoLytLM1wu6MYnZDWD5mF0X0zppXJMe2U1d3D9nrfT2XGuvnllkW8TQVAuoyRvVo7U8cgSly1gUX88KepFP/0myQvto2SRQcssVTl7AQkeG/73nexFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meBZfXvtH0W6hvOi/i0iU5QR5ywYWl2OUcxJ7gL8XOU=;
 b=LV6k9hUtCuXR5Dkq6nCCTbIo0qh8k6TViNKO5IsCX3P20i8Tzh5W7gxIpK0bonF8yJDSirUsY4OcPG0FP1SCZgvXKdIhd/YUQ8PacxiwylaMxLvHt60+KYPY9U4pcCriKdi4oo9IczILBjh0nVQsM1G1SjVMCAI11PBY3QrOIl7YQW/JYx5JG8OAd8MmOgETvHxo70qny2ZgI4rWzZ6p6MzKlZOuhyf/DZZzKiRfpqXARXC6VcNBXKBP69j7W6ZNKjt7EMr2mjwitt0b8iZWNDQFgSReoL13DWaKXhoRQqPMLVtgzp/zjS01DYZunShtC4YnVXKs5K2uVBiIXZlutA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB7740.eurprd07.prod.outlook.com (2603:10a6:10:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27; Thu, 1 Feb
 2024 15:04:02 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f%3]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 15:04:02 +0000
Message-ID: <9da01fb1-9bab-436b-af49-783e44821b26@nokia.com>
Date: Thu, 1 Feb 2024 16:03:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] arm: topology: Fix missing clock-frequency
 property warning
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
 <dfccb849-67b6-489b-8e83-3df1f9b29877@linaro.org>
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <dfccb849-67b6-489b-8e83-3df1f9b29877@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0294.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f8e366-9655-4999-f003-08dc233706a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zgW/4BVpVjh4v80wJiFXBCcwJkajR6nC1m/OZU0CjOf/P9OJeeRecdgtS7Y//8yahM02BR7PCkbUZGm7Ze56LRrZMFsgDUlLzsCXsOdCOsX7ghDspmSVpt2aF3yqLBPjpZ4PL/81iWNtrbJbe6lkiDs/1sZjH6991+R+gpCze3xokkKV346rElw4NjvtU4iDjIH1Vb8bTafCajDYwrmVKbicodjVGuHLtVoG56T3/TF+67Mo77lspd0kzedlb75FxHv2rNlYCYCP6dpPhnfmteJ8MgkxLfIHBFFkYpi6n6FjBHuStzvZ7/iCmmWDF3jYajX6iia+C+ShqUT9tbrMJxiX/tBmYtR50bNjtafNTx8uXG98HI9VxHgXMXJYpFJETMZWI2zCGt6/G93/7VgB01CvyFNcEQUwULK6H57FhvghVB2dd0YVcSweLTCA0H9nEXtRjK5qHuhI6MXOoAFjFtCJFMdv2KT6dZWb6SWno0vvvC+7A3rm3kJ41XyBCuKABq1QOZkevmUwJFOaQ+ZtHf1D58fbmNYBwZ/Ob/N5VLxAisROAY7F2xr+siBWFpZnasWxuhI1va954TgFKhD2mLabMZTQW00oSLmhVj8nH7pLGJ4iJIaOQq1rtWqbpdxAmqJ24wnvGlSlRm3if3YhXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(83380400001)(82960400001)(36756003)(86362001)(31696002)(41300700001)(26005)(38100700002)(6512007)(2616005)(4326008)(6506007)(66476007)(36916002)(2906002)(6486002)(966005)(478600001)(66556008)(66946007)(110136005)(316002)(8936002)(5660300002)(6666004)(44832011)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmlkZ3BOZkRBZE85bjN5VlBKTXA4eDJrYnVhQ0NpQVFmNmVDeEhPYnA2MTN4?=
 =?utf-8?B?U3RMVTMremVnMjJLZkZldm9DSkI1eXFvbVZhczRna2hYZWc5dnNXdWJZNmNs?=
 =?utf-8?B?YTY5ZnM3eC9JcVVybDgybUJHVWxWTDZ5Yk14UC9jRVUwMUFtaHlFZUlJbmdB?=
 =?utf-8?B?d2dCcTdQMlJWTmVzZWdxNjc2aEx5U2hNRFlyS09DUEY3QXg0RjdJWWpIVzBX?=
 =?utf-8?B?TVVFOXFmWGNQUmUvSUNRdmZ3cHduSE81dkVkTkVDSU44dnl4WmtndnY0Tm5U?=
 =?utf-8?B?NlFoQXRjbUM4VkZvLzUxQWttd1dCZ1NrS2h0WVpJREQyOGVxTkN3MkVPSlJG?=
 =?utf-8?B?aUZMbEFlcWpjSWpyUWNWRUlQS2NOeG5paXhSUmNxU2VNU0FrRlY3eXVjZFA0?=
 =?utf-8?B?cTF5UUxzRTRVV1BSZzJ6aTJNWEk1YURJZ0x4ZTc1L1hncTlkd3dpMmw5SWhX?=
 =?utf-8?B?MEdUYVFuTHNQR1AxYVhDRUdXMG9VUlNUM1pwSVR4SjBaNkczZ1F4TVdKbDQr?=
 =?utf-8?B?N1R5cWpkVlFUSU01S005d2FSY0NnQ2JrbkRaQTEzVTdMUkxnT1l0ZnZocFFw?=
 =?utf-8?B?WHdXbVpzUFEwZllYRno5a2ZUbnBkUi9vSm90K2srNXpvQXJmRDhnRWxPd2Vl?=
 =?utf-8?B?VWlTMWlUazUwZnNQVXBOVTNlaVhwekdQQjBKR09US29hbHdDYUJBVUhxR2xU?=
 =?utf-8?B?akY1UUFQbFhvbWp5RHpYc2Z0SWRMUnVGUTRXTTBYbDB6dTNjUGdlR0t4YlAx?=
 =?utf-8?B?OGZTdXc5T084SGUySTYvQVZJNURzYnN4T284d0V5TkdwT0dMTDhIeHJFNEkr?=
 =?utf-8?B?a1liSGdsT3JqcndaWXE0blJrV1hJc3FPWE83ZTBLWW1wUHpyVEEvTXh1WUdn?=
 =?utf-8?B?aHhSTUJ2SFNiTDdnRTdoazRibm01MGtlUUFiQXJKS25MMmlidklBNmU4TWIz?=
 =?utf-8?B?QjZwM2JHcEJsaEp4d3JYaWFsbGJNOTIycmhHdXdqTktKeWo5S1pPOEhzdE9h?=
 =?utf-8?B?VGtwNG5ZK2hzWDd5MXhJbVczWTEzYk5hb28wL1hLNUYyZlJ6VlAyeVpmMTFK?=
 =?utf-8?B?M2lFb2dZL0w4Y1ZtSW5VNWZaQUhwb2pnSkNPWFlJazJIUlpDUEZiMWY2UmM1?=
 =?utf-8?B?aUJ5VFVwVFVJWHZmWldkdGlUTHRvNVlmY24xMXZ4NEtRTUQ4Z1hwRWw0YzUr?=
 =?utf-8?B?N2JBd091TEN3WWlqVk5jVmVvYVcwdko5cGN4UFRBSk1VRStlSlU5eXdVdUdI?=
 =?utf-8?B?V3p1bk1ZeW9xaWFFSGtRYW1ibGpQUEFMYWkzV2lKMXZNaDc1cjZXa0ZONnM4?=
 =?utf-8?B?YytIZW4wL1pybmZ2ZnhwQ0d3K1dlQmV0OUNWMXBqQVJqTEpDbjFyUitRYTNB?=
 =?utf-8?B?b1JHRXBjaXN5a3N2VC9XUUZMdCtTYklHelA2akZHVFRLZ291bkhXSTF3bEFQ?=
 =?utf-8?B?MXRQOUdpeEtlaXhmSjJzMkQ1SVF3aUNqcCtiL0dEOTJ5SmVwWEJWSUtmWlBx?=
 =?utf-8?B?dHh3VnJmMTBQbkEwemNHejlVdzNpVU5JN0lsSnJEK2VqK2FLa0prYWYvS2ZG?=
 =?utf-8?B?bTVkL0prUXhjTmZDUFE4MHdxWkNQREtIb3R5QjlvemdzQ0VEQ2NWQzZPUWdn?=
 =?utf-8?B?OC9ya1BzUVBTSUhFUzFkNElNczJ3VHgrN2ZxZmpzeHQ2Q25UR3BrTlozcGw1?=
 =?utf-8?B?K0NmRGx2Yk9vdEc0RHI0QUtveG4xVjVoMEFoQUhFZnRvS2VCRFpLWTR2azlV?=
 =?utf-8?B?MTFWcHowbEl4MitKV0pOaDgvMytIRUc3cUY3TTBvQ25MYU9sTTBEK3JyNXB4?=
 =?utf-8?B?VnlvZ2FHM1A1N0JOSVpUMTRSNE5qQU5Ra3RJcjZxMVRzRTBacEJodjdlcEpt?=
 =?utf-8?B?NXlYd0ZQM1JXdXFJc00reFNlTUZSSXlsWmNncmtZNE43QUw5MDNVUXpCUkVC?=
 =?utf-8?B?Q3AwMmlDQTh1aFRKRTI2U0lySjJNTXZNSGhuRmJlYWI3aWhxZkZyRFREcVox?=
 =?utf-8?B?bEt1UFhkTVM1VndXK1JlMUZ0amg5dXVsUUkzWjAvNUFjVVI1SElacmpBSlVK?=
 =?utf-8?B?OGo2WkM2dEZPbDFrOU5xbWF1UGxPc280U0hIekRZc2pmWmgraTlLaUlMTjly?=
 =?utf-8?B?WGJjaDljdnZNY2VXd0VxYnBQS2QrZ0pTbVB1bVJVRWU1dnd5cytjTlFnV1RR?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f8e366-9655-4999-f003-08dc233706a9
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:04:02.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4e45w6nW44IzYZGPQETtzCc2PYJvj3I52YqvLXBVd1H7Vp2Bfn96K1GUfjXmjY2xpA+ofbZLULijlc1jVeWwUOydeA6ySRFMUs5oTOshTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7740

> Does this mean the /cpus property is like a default for when a CPU node
> doesn't specify the clock frequency, or does it mean that the /cpus
> property should only exist when all the values for each CPU are
> identical and thus the individual CPU node clock frequency should
> not be specified.

Good question, the device tree specification in Section 3.7 [1] says:

 > The /cpus node may contain properties that are common across cpu
nodes. See Section 3.8 for details.

And in Section 3.8 [2]:

 > Properties that have identical values across cpu nodes may be placed
 > in the /cpus node instead. A client program must first examine a
 > specific cpu node, but if an expected property is not found then it
 > should look at the parent /cpus node. This results in a less verbose
 > representation of properties which are identical across all CPUs.

So I think it is pretty clear that it should only be used for 
common/identical values.

> Aren't you adding new property? Is it already documented in the
> bindings? After a quick look I think this is not documented.

You are right, clock-frequency is not mentioned neither in arm/cpus.yaml 
nor in any other <arch>/cpus.yaml binding, but the DT spec has it as a 
required property [3]. Should I add clock-frequency to all 
<arch>/cpus.yaml bindings? Only the ARM one explicitly mentions 
following the DT spec.

Kind regards,

Stefan

[1] 
https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html#cpus-node-properties
[2] 
https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html#cpus-cpu-node-properties
[3] 
https://devicetree-specification.readthedocs.io/en/latest/chapter3-devicenodes.html#general-properties-of-cpus-cpu-nodes

