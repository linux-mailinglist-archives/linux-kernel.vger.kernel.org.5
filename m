Return-Path: <linux-kernel+bounces-55258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6B84B9D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DA28164A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94C1339A1;
	Tue,  6 Feb 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="A0X5EcZY"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50A13248D;
	Tue,  6 Feb 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233925; cv=fail; b=NcBGxvl6yeEvbB0WinIea67l6AL2Y16qYl8fHhxB5EdSBV9RUNk9q/py7XLn10sLalmvIRgcED5AVXQzm8bI6U7dDGRtJqx/LLUj9gU8t4akRahi8Z+qjFf7pzy5pdn+OwMtqp0vfeFJAijrF9r4V4p6hkGNnJarCxUQzL4RFxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233925; c=relaxed/simple;
	bh=kxmw3Iifjwi6nPtr26GFMmCb5T+8MjN8o+/fabMOugg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htEY70fvzBs84fl7BvbNtofygy++LhIcSHdPJVutGAbTkS8WdqWflwDNtsoSBFT8CqcKPczaUkHEcxQqN8c2xRWjd6TOxTxy15tiURERuPTjOeUoHCzF/bLH4aIhk6Z3ztfA8aTDjbG4SPyK+vgjtON/FQGTm7VZ8bHj3uNNWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=A0X5EcZY; arc=fail smtp.client-ip=40.107.20.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGVrC9qKG3k5pGk8BBAnwyqCf2kqJKpiHE0dUnVnNdHjLwLxY/2caukXH6K6OWvEgo9j39MzdSQTlbzmcsan0T+x8fWnkhCdFrFqgboh0ZKFKi+wgXo5o5OMG76hu+NukthzTmR3bf/18uYq7MpgDZ4r//vNaIeyKZ+P5zxXNSgrgsafORznGbIQ0cEIxfigV0HJg4GWXtFmJ/1VBTxHuE8Z0yXeWLkVRnn9lH8Tu1rxiEyqNGMwrs0GY0cXUnTE/Qdmj+uOx/uupbrrxTr6AETj7u1WDyJBDc1b7kEm/uEil431kAFPrZNh2dqVr3KNMqVepyw+k50b4XZUfpSbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pjWmqYBSPobbz+fuyObfpLqkcPazZBx26kXlbOVOyo=;
 b=lVwf7/UQWUtKUxpp59//Wzb+HhruOwtMwlAhMYt8Z0dDUqpSihK0DbAel9y60q8F8B8rpfwqDwQvXUAhWQMeQVfr2MiyqyK10kZ/3RGptuIalvt62RjReeINdGUbgrg1okKab677qG4A8ooD393l+IVzNJ9ynT8zZ+/iwMv3GHPJBI7hwhQmbuNQf488mNFfErS6YrI5KCVUYUJiSCSpN+Ewq8JD1rN2h8K2R4TfIfmDTKi1yYeNsl+YycUyn4P0C79QSQu56VR1Ayk36tTifwE1kGx3idJ7csHv6/t9GL68xbDy29jUPMLjJ6CKVebk5zht6wbxWuXlH8RJZe6L7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pjWmqYBSPobbz+fuyObfpLqkcPazZBx26kXlbOVOyo=;
 b=A0X5EcZYfPHd54lAAb/krDFuhigfiXVyc1z4fs0mPH4ZC+5HEtB86qTqP2FUR/fnmKmfgNIqlGo+aeVEJtV04p48I/DOYUwvIedH+wNYGeEN43d9ppgkuWFcdabPmcH2W8FQEkbO/XcCMPY1HWpXIor9JHqegAfMOtHsuNPFFxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB10763.eurprd08.prod.outlook.com (2603:10a6:150:15c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 15:38:41 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 15:38:41 +0000
Message-ID: <920c2c18-6cf9-4a88-84a5-eb1208ad1d42@wolfvision.net>
Date: Tue, 6 Feb 2024 16:38:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
 <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
 <7b472cb2-6658-446a-ae47-411d08798cca@wolfvision.net>
 <ZcJR0LrwaS5GAf5h@finisterre.sirena.org.uk>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZcJR0LrwaS5GAf5h@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB10763:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a27da28-a719-4f30-5b3c-08dc2729b1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v8otOjXwT1c5M8174mbfnpZ7ObjkD/bQyCP+yYl/0YsycBBsEdvBJyPX98aeJiGfihlv2NuvG1gnc5ivPRUnG9pcH26RaSxAbpDqNzCY0p9txZ7qCGnPGh+zfIhChDgiPQ4SO6h0g0zDKZimr1egSPv1pEWO/tLhwWJkyqG3drpKXtxjvh1RN4loR9EpM3JPY2J3TlzbaR3iNAp/cZA08GYDO8pqBbQfh6piY9zRVKYhVcb6v9524W0CsfdgEh/r+chd/m/Pi5OJmQ9qZPVlh0IUgzIgUOfrJavGK+gS0DKiFSBpsKlo2XzxOYFWGQ2uDDFvJTHFrgpAv0RAFIasMPmUzsEGg+olMGX07ADrjBLt3o2XiYW1XKFcPuc6uUtbSCHthLNyz/yfJBaNwJtVIt/KPRB2LttBSoAl372XvEDwpUveu2HzWRM33IaXdBDuRowFOJx2ZUVSTFJnNAJsYS9TU65ChHGtIRHzVoS0K63hpb2YyehauTHY5ZAtBPOHIqdkXEh3gXWE7LawewsECAbQLQFAE9M48fIPLmOEGcP4woK9d1REH31/3YUq58i/xSe8ZqmYMotayQA2EwP4P8bcjuFDS9igvsnsQYjooceM9oLq7xdWYmqHmGHS4F7QmT4JCybxuQVauQm/fyYPWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39850400004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(2906002)(83380400001)(38100700002)(66899024)(41300700001)(26005)(6916009)(54906003)(66476007)(66946007)(66556008)(316002)(31696002)(7416002)(86362001)(4326008)(8676002)(8936002)(44832011)(53546011)(2616005)(6506007)(6512007)(5660300002)(36756003)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnVVcjRMamhXZEIvRUVMOWVMbUgwNnordm42VnhOQ0hsTGZtaEwxNTRwUDAr?=
 =?utf-8?B?aWRLSmU4OWY1UHh5UGZtZnVjdXZiVllCR3FXZ3FPR1o5bHA0US9CQzRlY3d5?=
 =?utf-8?B?ZTV4dXIxWmlqVWpIR01FekJaWm42TjhvUURFbmpJRjNRWUNBa0c1c0cwMk5H?=
 =?utf-8?B?UnIrekFPbkVSWHM3LzJma3d1d0VCaXREbE9WVWFHeEk5MGtSblZCL3pPY2N5?=
 =?utf-8?B?bEJuVVlRNHpVZzNMcUJxZk5jTkk1YnVPdVRLK3Q5eC9zMHU2V25FdGhScG9G?=
 =?utf-8?B?Vm9icnA4OVRyLzBVc2MwQ01kSmZZSEwwRmRmcS8wSzhnekJZQ2pFM3krcXVQ?=
 =?utf-8?B?L042dFRTR3JOTXBXbHVWM3VZQVV1QmdjY0lpTVlLOFBSUXVkYUJ1ek9TU1Vw?=
 =?utf-8?B?emZPQno2N3d4cVgrWVU4R0VWVmFuQklnV29raHE2RHpMaXlwYnhhWk9jMHR5?=
 =?utf-8?B?QlVQdG53OXl2ZFhFczVpQ2EwR3lyb3FadzI0UGJDU0RLOFVIM2Y2Y0lnUDJB?=
 =?utf-8?B?aGI2OGkwUmpwSGdkQm5DaXdUd21LQ3p0Vks3aTJVazRKanoyZ2lBdUJFU0tw?=
 =?utf-8?B?Ty9ERGNIdXlsK1lpaXlZQUVtN1FHZWd0MVBEay9JTUpzUVd4bmZtMVY5T0M5?=
 =?utf-8?B?bTlLQTFWOUx1Q0dQZy80ZWRTVHhoVEM4bDlOaDBFdU9mSmJIN0xET3NDYWtW?=
 =?utf-8?B?OVgvUG5zUnBlTmg4c0UwblJDR3dNY2ZGQk9SQUNwWW9OOEs2L2VtZEg0SzFy?=
 =?utf-8?B?TjEvVXlxaThPanRqTDJXRGtCSEl5MnpBdkZBWmZlaUs5aFZlMFZFNHg3VEF4?=
 =?utf-8?B?VlpkNzV5bnhlWGF1Z1d6ay9aTGNiRng2bHJtRUFLQ0p4OEtmY2tFeVAvMUJL?=
 =?utf-8?B?aXJZQlBucXlIMEl2THNteWgxL2FrVmMvaWdpcENhUTkra2JlQ01rNFlKSWFx?=
 =?utf-8?B?c09BT2R6QUt4cCtVRW9vN05VY2tGRDc0THJweWh3VjhPOWtPeVEwOEJiZStw?=
 =?utf-8?B?dkVyRXd5TlF6bkUwYWVMWHBCUk1HVUxac0RUYWpOdkFkc2lBNGNWR2ErQk42?=
 =?utf-8?B?VUR2aFo2R3Y0VHViQ05FcEptNVdyTFExVFpranVYaHhRUURPSkZGQ1Z0L05k?=
 =?utf-8?B?R1A5N2EvTGQwVDFkSjhzbi9Tb0ZWT29OUWhIbmtLR1ltcmhJbHBBWVduMjVV?=
 =?utf-8?B?ay82WWFxbDcyd0xQcUkyYXFmT05Xc2dKT0U2akdKY1p1dkE0YmwxWTZJc0sx?=
 =?utf-8?B?TDVlRUhDdGhkeGxSdVlQc3R0MERYMzY1SVNRZnhuVXpxQ1J5SVZnNkZiS3Vw?=
 =?utf-8?B?cmFadlRXMXZZdm9IeTBmLzFjbUpRZHRsbmlvdlNkUG8wTFlLTk9DeFVRbUJz?=
 =?utf-8?B?V0lIOWNlUlhSeEh1UVRPYUltL1ZmMCt4RmJIMkluNkNIWE4rWlljMUc0bng0?=
 =?utf-8?B?anZkM3JaTFNwbmgxYldIK2lZaWhhU05HVFNTbHRYem5RYmFjeVFDWE9tS0kv?=
 =?utf-8?B?WFBaYk1ZcXB0cHJZM1p3MVhZWWNuVFBsRmpzZ01DVmh6blN2SkpWRE1ta1RO?=
 =?utf-8?B?cWFUK0o0aUFyRzlZYmZXdFhCaHYwTHRtSjVUYlU5MXRTSS9ZQnBGMWdsT291?=
 =?utf-8?B?cUx6VkcvVzF4elFQNi9kSllQZWdXVUtUelM1b204UXJpNW9MMThZK2F6V2sv?=
 =?utf-8?B?VkdpVjlGYXF5MUZ6N0d6UThRQSt4aS9hUGduQW5IbXh4dHhaWlBvbjl1OVB5?=
 =?utf-8?B?enRRTTk0OGg1Mkh1VE1ZQ3p2blowWWN3WFBsNjVZUjRJdnFtZ0M5cnVaSzRp?=
 =?utf-8?B?VVRGVW9oZFRUQmNNTkJuNmxRakV2a1U1aFU3eTJaRkdKdW5kc3N4SE1idTlr?=
 =?utf-8?B?K3h4WWdQU0pkazdlcUFwSHJKYVVJd0p6OWtxemgxWUFPS0ZrdVlYNXZoSStq?=
 =?utf-8?B?d2tKSkRnMkJ1UnpJbDJ3d2wzYzZUM3dGRldKR0RyVjZqNGJkTGk2a2Q1TW5Q?=
 =?utf-8?B?Y0NiWEZ1Yll1WWJqUTJBSTlqd3VqOGVmclhMZ2VkdFFIcWlYbWFRSnliekRH?=
 =?utf-8?B?NlJPSW9UVElmektDTlZVeEhRVEtsSHhTTElFcUFxS28yZm9ZNitqK2xJWGNE?=
 =?utf-8?B?RHlmRG04T01sWVpsNjV0cGo5TGw4aFJ4VWNFaWJETVBLbXN6dTFRUTg1OGx5?=
 =?utf-8?Q?sdJxkMj6XiydO3u137tq9O8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a27da28-a719-4f30-5b3c-08dc2729b1ba
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:38:40.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GSTzWsGcEcH+3go6+lBd9nC4aPDTOmlYe6Ydd4L06oG76/T+uJg7qmv+9cFmO/arAbKYt3chjdmvS7ijf7gvGcQCRQlpW6yOz8fyCIOHM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10763

On 06.02.24 16:35, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 04:05:15PM +0100, Javier Carrasco wrote:
> 
>> The names in the datasheet are vdd for the 1V0 supply and vddio for the
>> 3V3 supply. I named the latter vdd2 instead because this device does not
>> have its own driver and instead it uses the onboard_usb_hub generic
>> driver, where the supplies are named vdd and vdd2.
> 
>> Those are the names used for devm_regulator_bulk_get(). Is that not the
>> right way to match them?
> 
> The binding should really use vddio instead of vdd2 but if that's an
> existing binding then it gets more annoying, probably that existing
> binding is wrong too since vddio does sound like an entirely plausible
> standard name for a 3.3V supply. :/  At the very least the binding
> should document the weird mapping, though ideally the driver would be
> tought to request names matching the datasheet if the compatible is the
> one for this device.  Doing the better naming might be too much hassle
> though.

That is in line with my last reply, where the bindings I used as an
example mention the real names of the supplies as they are defined in
the datasheet.

I can add that for the next version.

Best regards,
Javier Carrasco


