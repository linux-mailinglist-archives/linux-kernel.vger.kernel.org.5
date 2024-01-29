Return-Path: <linux-kernel+bounces-42684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C494F8404F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FBFB2223D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E80605A8;
	Mon, 29 Jan 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZPpTt7gf"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A060268;
	Mon, 29 Jan 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531222; cv=fail; b=VQj4vrh4/T4nuh2KWicKKL4SG8fz0W4yrm9mlTn7qZh7YottduqQCuurdJdOE1w/CkoF5I63zkofMTLNvfFcHDtwEc7x24AejAmzyYfdrL85TkfEOJt2q206PDDK3DbTTNDriKosI0PjT1hXZ2IKogtducu7zZr3MUy4PDGnIAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531222; c=relaxed/simple;
	bh=Sf+yXHcar/4jVG49d5XKK4fVlrVrZulgUY0oGONYo0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PROfzmI3Q+r3f+ZW9LXfj6Hs9J1Air3OwZ4DcrcO20g/9K0RjoUQqURjZ0APAqBVrXvnppSMRwauy40vt0KvA7Eiquq52ZrKwPzj+4TBqeKEqzkv8rE7U9UesGFJKQDZNNSlSuD3v/jwybxUTopxOmNSs82ZQSNM3imoY39wfSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=ZPpTt7gf; arc=fail smtp.client-ip=40.107.15.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b864DDshFHOsKc5rMDjVLIMcd0Hu/qvvUCNAQS9+jh7+PvlggGnbeKD2jPA9SMQWGlFChHn+ihU7AsXa5p3eMZeYPIBD1nUHt2VBXd+q2BOi2fA8uBQhHRZg1DWCohZU3VfxaTSEctqEq4bLfBcYXLqWfhX3N+XMWlc+jbSmiqZIJbp7nJyU+iiXe19ys/aLEC9VbisOpwbeSJ7+12lfzlb7RFq3VgTRix4mi5uF3hElCCI55TJiR5rqagNrIV0Y4ZenGZELQZM2uO7YcN0bPVoAeas7grYB35aqKVOC2EsHZPzwjTRCZGFM4wpZkC/lnBdxpCysH2kgOKUQgLfPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OSB0slF6u0irqDrbvFBjn7u3ORW7uo0P6moc/FZsAA=;
 b=V4q/7agMLdj27ewDF6hTXU5a31tLDdscNDDonaSARi5IAfB/6FpRlxgY87DUymCU8vTMIDJCK1tFsfMMhatYfWq1N0mR1CUgzFAePm5RD6mQT1sG4Rqbpz1o61oTnuLKjIWWK4yx5RzYNg9ETuWfCiXrPLrTMue8S1lN7kOJRr6QEIn+PBBm6wnnLmwKAgUmGYTav+SKpaXjrXWRXu7Knyh2GlmWzh87SB+Z1+Izxuexyxw15fy/1AZQZg49/7W9lM95c4Pq4guiRxB5/dIW+xoha7ngvci/l1B64I5zgv1wT3TYNnYhTA9QSVJqIUwuEfQG03u2uuR7Z5jeeTOmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OSB0slF6u0irqDrbvFBjn7u3ORW7uo0P6moc/FZsAA=;
 b=ZPpTt7gfQXRwc9Iqkr2Xf04HX1pTmBBujUEALOKrGWL6MKb8Laam4+3lTR/cAZi1RzyN0oWxjbRSMlyjUdYKmrpC5q2oH2MvPSNd+hHmQEtwBBHABmSujEtODVe77Rmsn9AJNYsBjELKWOAzEMiTIewVt6J78vAMpNacSImseX1lka3dmijCB3Y4nrQaWtDquHiF+rIzYr3wxhbfhnoWM4fnMR+hdkdFlXTF0IJ7R536OtOU8X3lu0wT116xUjD2RKU4lgl1+959vMgw3D1tTELj+iTgT3xuW60fmOP8X8HHG39sY/t2BAZfznCSESfykz3iTpbDORM+3ZV5eP1BpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:26:55 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:26:55 +0000
Message-ID: <da864300-ae0a-43fc-84bd-94e985d8ac73@theobroma-systems.com>
Date: Mon, 29 Jan 2024 13:26:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] dt-bindings: serial: add binding for rs485
 rx-enable state when rs485 is disabled
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>,
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
 <20240126-dev-rx-enable-v4-3-45aaf4d96328@theobroma-systems.com>
 <20240128-vagabond-mutilator-cf8dc6ac8a41@spud>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240128-vagabond-mutilator-cf8dc6ac8a41@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0158.eurprd09.prod.outlook.com
 (2603:10a6:800:120::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 932af928-0637-44b3-746f-08dc20c5944c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1g171F/6SBuubDFTiMSY2BaJC1C3lfJ7dV5/dycTcQCR4uviFEv5I2yUrkJm45oke5dDePePPKQuNePFBkTnEM3wyf1iyTiSjSWu6Mx0jpfqJ5pX/BgC4SeZGbOAcCHUGV5HnuBXtpVxWIvZIn6YPgYaI0tIZK/rbB/32T6PKgso+kD/RKej5eLKM6bYusXzCMKNczWW1EE6lKXTKH5kR9MJ+6p3McKUhWP1EvnXArTyiFC+Fdh4ZE0yHVm25qTDBuyvy/aWP3x9oNPk7CVIiDw1n5zBg/l7CBwN1PGzc0fAXyGQvlwQ/q1ejSKe9BUd7NoKVlUr9aCHpjzpP3jbBxGQqb3ZRQ6NUcf4ktJn2AZU0fbqhsKeed4nrcGdKk+DfOiG8akmQqHgdU98wdPpWafqrGODzRnL/PviFg3jPmfmDR5VE4s4FTdC26C0S7siWMMjaDVyxPQG6JBIUl6vI5OX6pczt4Kna3L/v3EIojBXRd6WxenSZ+/0JkZrIlrXa1TU+2SZlPwAmjB7NQ2MybvzPvPzXyKX+ihyj0VBVMcWprz2smbn2vBQrIvevtSfZZRZW2y05PW+sbRL5JAxw6Ej0HW6wKzn3hj58O5RJ47oYVCBLBPXFvbZrpQcCCxocQyFZeHVTuZj1XjWU521zQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39850400004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(6512007)(2616005)(38100700002)(44832011)(8676002)(8936002)(5660300002)(4326008)(7416002)(6666004)(2906002)(478600001)(6486002)(6506007)(53546011)(66556008)(66476007)(54906003)(41300700001)(6636002)(316002)(66946007)(110136005)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amY0U0hvZFR5WC9WcVhudmNYeE50bExHSE1vR1dmTmRJbzBxMFlWbXg2OEky?=
 =?utf-8?B?SG9QVlM1bVhSQXhjWXRWV0MwQ2VXM285V0JhZUxqSXBZejBBWE5pSEJJZ0I5?=
 =?utf-8?B?cFFKZXdOaitWcEp5ajJLQ0EwcXlvUSt5VTYwdDdsVDdHbVlJam4rbHJTMklD?=
 =?utf-8?B?Nmk2eTVaWnllS2lOQ2c5K2RWUm1QODJtS05EaytBUUdSdG0vV1RoOVdtSHZz?=
 =?utf-8?B?RHBuSWJwY25hTCtBZWlFcE9FdjJoVlMzMzNhZG1Ob0g0SkdkNitIMXdmTTVB?=
 =?utf-8?B?RmZtaGhFejh6a0FSWmJYZzF0SDcwMllxSzZSU3draHJ1TFJ1Ly82N2JQUmZJ?=
 =?utf-8?B?ZllzRXplOWFpMDNyemlEMGg1UnVOMkFEa0VqOWVGRmlIZEM0SW9wMG5YS2VH?=
 =?utf-8?B?YnM5clBtdG5jOWpMV1grcUllWDB0V0wrSjBQYlEvZGVkZmpuWHZyS1BpK0Z4?=
 =?utf-8?B?MitXNVliWlBocmRwdFNVRVRCMnZydERVNjUvS2Q3cXRqOUt6a0lMMlBES0Rk?=
 =?utf-8?B?c3VlRFpDOFBuc1lCelJsYWc0V3JxOUQxZW50Nmg3UmFHQ3laR2tmSEhRQnZi?=
 =?utf-8?B?UStLalZBRGl6S0lGNmdDRWpPb1luTTBRdytxZUp0ZVFnYzZpMHBxREgwTFUy?=
 =?utf-8?B?SVhHL1M3R2lWd0FDM1ozQWovcnMvK200aTYvMGNubnB0aUtFY2VwYWNwaE1h?=
 =?utf-8?B?U3NYbFJpU2ZiM0ZWWUZYMzlCSXN4YVZ0WDhyTkhPQktDREM3V3JFdDZTWTEx?=
 =?utf-8?B?dktxQkY2UUNRbXJZbUN0TDhHOTJFbC9YdUN3VkJUdDVZVzI4QllEWUxpVDc0?=
 =?utf-8?B?WkxMQ3AxMXBLWGNPaTBubysrRCswVUczOEp1eHN6SEVBOVdOSWdxQWZJZGc3?=
 =?utf-8?B?VmRkUngxV0hQa0NrUlhaSlFKc3hwUzl0cEpoUGt0SHBaWGVUM2w0b1U3ZVdL?=
 =?utf-8?B?eHBkZ2xSYUdsUlJrd0YxcURvaHZwZ0E3d1lUN2NlZjRtd0M1NFNBNjhXU1dq?=
 =?utf-8?B?SHluNmFjRGVzUy9SZllBK1JKeGFKUHhZR21YZlBFV0JHTzkrL0N1OE9qNklM?=
 =?utf-8?B?Qmk0eFBKclBVaFNiaVRENkVvTnFaY213cEYwMjk4Rjd2ZUloYXdrNDNsUmtw?=
 =?utf-8?B?Y1pBMEdPb3I3Wi9Dam4rbWsyZ2dzR1huTlh3Y2hZRDVrTlY2ZjBlZVk2dzlW?=
 =?utf-8?B?M0xJbVk5UDhSdWo4eGw0Mi8yUFlERWZ0YVFJamFHZTUvelVxL1dkdUFMT2pY?=
 =?utf-8?B?OFVwTmJORVVTaEhDZ3k0WWw3SW5jdzZFSEtFckZDYytOcFZ3WWNVVENWRnpa?=
 =?utf-8?B?REdYc2JWU3MxdHN2TnNlNEFVRGFEQnZFOXJWZkRXZURKZUo5OENjMUk2V2to?=
 =?utf-8?B?MDQ3MUtVTGdWUTVDL20vNFUyZDhGTzBvSU5INVorVGNXZjJ6MnhZNWZaZjFQ?=
 =?utf-8?B?V0FyZHpTVVdqZnZJUkV5OFM1NXNhc2Q5eDZqaEJJUktNaFN2NHI1alVFd2dE?=
 =?utf-8?B?WDlmRGQ2WkNweVJ3aFhYRUR0TjBmV1UwTWUzVGw2ZHJBQlhITVNNb1B1akx4?=
 =?utf-8?B?Z2Qybm9qVTRCNFMwdS96YnFLV2VmajVialZZL1IxWWdQQlJuVE9tcDNOdUV0?=
 =?utf-8?B?YmNXRVhLSGlhS1ZEOHluL1BpYVBjcjE3SmxySjFsWHhGNGswNVp4QTBRQXhU?=
 =?utf-8?B?ekxxcWl2d0JQQ1VVSHB3aTh3cTRnVEM0MXo2aTNOYkh5bXhxYWVnSjFjNThw?=
 =?utf-8?B?UUE0Y1luN2VIc0NNWlkrM0p6d1Y3b2llSTBtMW9WQVdBbmg5bG1DT21MWmtC?=
 =?utf-8?B?ckQrR1RKckZKZmJFQW9YcEppWjdZSXB0TSt5YnJYT1FqUGx3Skp4QTF1d2dR?=
 =?utf-8?B?bDRSL3Q4ZnNieTNXbkFRTUx2TDFWaXlBVGRZU2MzSThUbXdjNzZLVmtHVEdD?=
 =?utf-8?B?LzQ0SHJnUzhjVUxYcXlCdW9kRElrYXVjRkpWZ0U0eGhJb21xdi9WSS9yVG9P?=
 =?utf-8?B?R3ZEOWJPVnJONFBiK3ZPRkFaYTl0OCtPeS9lY1ZNQjNheVJJM0oxYkxSczdX?=
 =?utf-8?B?WEZFNzZ4VGRrQ29MdmwyNmdyUGNhL2VnS0c3UENXVkEvbVAwZXJocGVVdnAv?=
 =?utf-8?B?QU1MdEJ6MUlpclpwSU90RDdlUVkwdjFSVER4UlN5Q1lNaGlrZVJvRklYQmJp?=
 =?utf-8?Q?5CM3cAwbr+OphoHE+HETifo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932af928-0637-44b3-746f-08dc20c5944c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:26:55.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Smjx7S3sfsfokiRbSVaLp3WxSOyZFZHz48HMIn/Bo0fbSA8qzAxEHq4mBcL2Mqsu1m58YRbo92NnoldtjwUuu8l5+CD3JPrftzs7B5FEdehPxVlmJ6VPCm3O0B4cpv/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

Hi Conor,

On 1/28/24 18:38, Conor Dooley wrote:
> On Fri, Jan 26, 2024 at 03:55:12PM +0100, Farouk Bouabid wrote:
>> RS485 can have a receiver-enable gpio (rx-enable-gpios). When rs485 is
>> enabled, this gpio, if provided, must be driven active while receiving.
>> However when RS485 is disabled this gpio should not have an undefined
>> state. In that case, as DE and RE pins can be connected both to this gpio,
>> if its state is not properly defined, can cause unexpected transceiver
>> behavior.
>> This binding depend on rx-enable-gpios to be implemented.
> 
> Why do you need a dedicated property for this when there exists a device
> specific compatible for the uart on both of the affected rockchip
> systems?
> 

This has nothing to do with Rockchip's IP but the HW design of our 
carrierboard, so using the "rockchip,px30-uart" for that (which I assume 
is what was suggested here?) is incorrect since it'll also apply to 
PX30, RK3399 and RK3588-based Q7 SoCs we manufacture.

Did I understand the suggestion correctly?

Cheers,
Quentin

