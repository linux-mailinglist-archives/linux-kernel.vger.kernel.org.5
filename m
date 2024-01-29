Return-Path: <linux-kernel+bounces-42389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C18400B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772591C22301
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765554BF5;
	Mon, 29 Jan 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="NoggrED6"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8954BCF;
	Mon, 29 Jan 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518640; cv=fail; b=QCnUCDWh0iLfM2OJQ7X3SLDPTe7LquyPmaTMVO6jLkBqdNhEquVbIA4UEs2RuTe7VA+84OWraflv3cCH4BmULVSnsaCH8mzDcMHE66bqV2xI0r8wRWW0ptuvwU8kGp0KjdDJwxRtaJlm6pGpYZ0S5fafwq+RQrpxmI0vf4dMmis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518640; c=relaxed/simple;
	bh=KiTY6AAwokQQ/Las4PrqmRLJHTiHfOMeoDDkQdaw5/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cpPzcL1zGr1UtQjTyv5unU4HpvrkAehbb0L90+UH//tcD6XtRV0km13apZALXTVusL6LGlOPqWNNysrNBV4GDmV1PPhv5RorhfFzmx+44ti7F4SiXsPhh40q5C+bg8kp487idsCZmHp6bq8TZUW2u+VBrkVL0zRxO78e99Y3Hv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=NoggrED6; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZQOHf2QRMgZf4SY8QdSG8fyG+GrklQvX6G/wIr3V5IcthrW2Hfo0Lv6Z9QQoDH7pcU5XJxm28CHTeHmM+20iADhUiSZPs8BocEl3hvqFfpffd/wA0oAeDxoauJzbpHUZvP9Zml4q9no+7CuJ8uVvXYH756APJVwF1i4E5vsGCYJscFtMfDPi60i9JhN2M0ZOUQ7Ksnoe7GvOF1d9hc69H+srPUZ1wrwK51hGUQp4nIWl9t11+yYko1/kufd7XF2xx8oFh3fUPk9VgM2Mymob8NEfnWBSQlZLNng6BH3xoXF8Sn3XiTjSi89qMMAFNJ+uzVUhqSd9gq0ba2XFkpYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q46nCmTFHjWwJBg0J/4G6n55uo6ypLPpWnEJs7WYOd0=;
 b=gPsfh8O3SfVG5SUtPTPJ2lUDkBae6PGAcS3HJfC3GSpGXJmrqxRSln1t/js1PEIOP9zfkjK497Ein0id4v1yhYSdc0qeH3c3VcX/sk+1Tgy+00g6F/fk1koJAM4gTvTIsQohzae6kseasBImhNjB0oNRxmI699m/YQcZp48HZMo4IqbQK+GYcQlMluRygcPXO6Ie1T5zyUr5m7JEZPBJXREaHF9TnsQLXIp/YGwaA53H1nFXzUjkpIno0/faydRxon011BMKIQpUKFJJ772Rz6gKn6LtPCFJYGvr+y+gj89stndMP8xIY6gCI6CHIHDeQY5catFJVCfXh2Ub8VRRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q46nCmTFHjWwJBg0J/4G6n55uo6ypLPpWnEJs7WYOd0=;
 b=NoggrED6y3E2on3aknVI1/dHd6Mu8a6U4ZchiOTv56jsLhLCoWEJiet2tbnsFKqY4mG2D5yiPZzP4qzTmpS5aHZpLaQLtk0Axzq6C3ngSmP1KTBCuPzXHN/2Z1t57AxHk5XiwGHao7JeraRLUEjUtdKURzt3wc3trpc1B5udVl04yq1+0XJF4m2PMP8PrWkfQauoNwGBxCGjr3Nqp23rRJHX5qGxxhtEmXX+p8R5fYwSe99azpfqu8f13WkU/DvIXxX9fbAg0kIuqJtboHNWw3xQ/zGCDzriKWLqAjHbqV5wouqFmrO5xXIj+21ZqgOtB1V0bipA/dIVA3Fr74JYQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:57:14 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::d4b1:cea8:7085:ec50%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:57:13 +0000
Message-ID: <37522087-d3ac-4cc7-b11b-c844d36206ba@theobroma-systems.com>
Date: Mon, 29 Jan 2024 09:57:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] serial: 8250: Support separate rs485 rx-enable
 GPIO
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 quentin.schulz@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
 <20240126-dev-rx-enable-v5-2-5d934eda05ca@theobroma-systems.com>
 <098216ce-50b3-43e4-ad1a-42228c58b761@gmx.de>
Content-Language: en-US
From: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
In-Reply-To: <098216ce-50b3-43e4-ad1a-42228c58b761@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|DBBPR04MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: e3518b05-c824-431f-50b2-08dc20a84937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FOCT+6hKvLZ9KENFi5F0ocEHfbd1wo7VEwgVxtbJPdYPzWPim7rOayph2RSedDKwbF8DriHwYSuQmWiIfj2bg6wYCz7DX9KRWdX7b/7ZiX/sGh23VdjPnLRC+gUCjx0UfMPZ82jAnW05ontD+KsLavGVGYoJOp4rHGkZWM/25OCPIcK9JxS9KEVvtA+CFY0ONgqMu7/fn/4pG4sRH3j12AZZd/caYbGs3LDgQKCpYFI346DQEuKztnxuXKhqU/xDK2gZc7Go5suii/N5xrIQ+6FUrldsS4A6qNMFtJGXTxZymANTMtxAc7VFq1x6600j6hWvTGszy21bDYquc78CL+0jXMD9JqenLJ2FgXNVRg5qOZ3LM5LnGBiaqj7hOH15Qo3RMK3chFeag9WKyZn3s8oUMtxcs8NNYmydtEByaStvJ1ki2H6F6FiO5crJdmK5J9AsTxUrbSiqS+yCyx5qM8O6rGCraWmijiEauOfPlQOWM5UFzXiBYQy+DAHBdph8e6uN13Xx+63SwArU7SUTPj5DawuV74eSh0JkhlOWIO7ENvs/qCdOTSVBBSJFAMF8VaU5CyiAX2+AD+W12RUHTg6wovfeD9vmkmjE4oKtIRytZkZWUzHOpw/IcIAeKFCK/xsvz1bLc5rOXcm09/4iuQrMTm9DKG/RbOGZH01VOK6Nekul0YYPywj20s4I6Hzc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(366004)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(53546011)(6506007)(6512007)(2616005)(107886003)(38100700002)(5660300002)(7416002)(8936002)(8676002)(4326008)(44832011)(41300700001)(2906002)(478600001)(966005)(6486002)(316002)(54906003)(110136005)(66476007)(66946007)(66556008)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGpuK2tMV0dmRXZwZFYxNkRvMmtGYXFCS0czdGZJR1RsdU50TmpYZFE0RzRz?=
 =?utf-8?B?QkJqNnRObmgwdmxIUnJsT0pzUUNUZ2tqeWZkcUJsQmg0bmdEZTJUS0hWOFZy?=
 =?utf-8?B?RTRQRFlWK2tvb2pKdjZtUFlFTS8wVjZGTGZIY29MaUUwakZyczcvUmw1bDFV?=
 =?utf-8?B?cXVuTFJqKzR3bDRrSTlRejJKY1MrZ0VVWHM4My81Mlk4SWhHYkc3RHR6dklU?=
 =?utf-8?B?ZWpaeVBJLzNqaEE3dlI4Yk96TGhzWTVmelgweUNldkF1TkFjV2c2blh3Ni9h?=
 =?utf-8?B?QVE1anYrNzE0V3g4ak4vUEU1aStrVmNaNitqWkpsc1BUaXFkMGl2VG0xdnpw?=
 =?utf-8?B?Kys5YjRjWWtqOEhodzFIRzNyK0R3ME1nVlVOMU5yQWFVZStJeXVKMEYyQngv?=
 =?utf-8?B?SzNKTVU1OGVLNWhkeVJBb0dRazl3K2FtblFwZkNUSEFkUXZneFREaGRkbWhq?=
 =?utf-8?B?T1JNTTh1MEtaYTR3MkVrNmRPRFFLZjRkekM5bUVkM3hTU0c3ZC8weXY5c1NF?=
 =?utf-8?B?M1dtN1ZuUFpOUjVqTFMrdmxlYW9EWFBBdk90U045NHAyS1JlUnVFSnM1UTIx?=
 =?utf-8?B?Z3RWU0wwMHBnejBoWERucW13VGUrNnBaS2sxb0V5anV3UFhIODY1dm92c04r?=
 =?utf-8?B?NERXWlBxZkU2a3h2bzR2U1JqRjk5TS9VekNZTHlyREV0Qy9tSHppanZZUFF2?=
 =?utf-8?B?WUgzTE5LNCtYQ3ZMenlJNEp5VlA2enlSdVdWWlpoRERDNklHWkVSaVAxbzMv?=
 =?utf-8?B?Vkxtb0hacXp6T0Q2MldFMXI2dnQrY1R2NFZndzFnM2RaT053bTdicE9wMGFI?=
 =?utf-8?B?b0JpQnp1VW5GM2hNMGxNN1R3OEY4OUppVVhEeHU2elBYVzFVWWZ6MVJrY1Fu?=
 =?utf-8?B?RUs0Y3l2T3V4V1AwYzljc093bW1wZGV1aVVyT0tOM0JkajZ1clpvaUVkRm9z?=
 =?utf-8?B?aDc4MzRhcTlpLzdQd1VwaUp5R1Z6emRFaXZjMXZ3NFlHTmt5TlhBbVdWdEJR?=
 =?utf-8?B?aGF4dDJKem04WUY2MmtOMng4a1EvVW5Qei9uNVRRTlJEUFFkTEZPL0g0NE53?=
 =?utf-8?B?ZDlTN0JiL1BLeFREL1MydHkzQUZzWnBWU0ZtbHNwZFFTL3l5N291Q2phNXdl?=
 =?utf-8?B?VVJjdE1UNDBzbmZtK005b3k2bTlKeUdEdEkwWndIZk41N3FJUStlbG91Tkh3?=
 =?utf-8?B?VzM3RzI4ZkdSQzg1SG5nV1JMWVovYzQ0NkJ3dUs5VnZFLzdvdUh5ODJ2K0Mx?=
 =?utf-8?B?citaTWJpWEtLT2ZjWFBXWW5rRWhNSWc0NUszK0NJVDhYZ3haMkVLVmFtcy8z?=
 =?utf-8?B?dzZQNkhiVjg5SkpxWDAwamgyVmE3cEJuaVk4MTZ0K1FrNlVuWlNEY2t6SmRr?=
 =?utf-8?B?NjIzbmpNOXJXbENEbCtObFlhNkxEbFJlWGNxdEJwN1lhMUxSek8zMXo5MHNr?=
 =?utf-8?B?MklXUis2d2VFK2JGYldhSEorN0psOC84SnMzVTN4dllUTndnRXhtT2lvY1Fq?=
 =?utf-8?B?QWFJR1hzZGVJWWN2RmJ4bHBCc3dSQjkyQkYzZTVyTXl0VStHbllnTnZnQU1F?=
 =?utf-8?B?dVk5ZGNrVTREZEM1VDNqWXhlWTFtZThvcmRJSVdSTWt0N1ltdXc0RmhldkYy?=
 =?utf-8?B?RE1yYjk5SnR4Q21YVUlXQ3hKSXlSK1hLUkNFRUhhVkV6QS9CYmVkNFZvWnND?=
 =?utf-8?B?RHJZM3orS3NtcEVZUis1eWJoWmlPMDY4cVN4MmQ4dTl5WFB2d09QVlNDWkxv?=
 =?utf-8?B?cXJpSGxyNXRYMlFCRmI1dTRnemZzVzhnZDY5RFpZWHFaSW4zd2xtTkJUbGdB?=
 =?utf-8?B?Nm9NT3ZXd21PcGJpS3FPRkFWeTVIQUFTVkJxTWI3cmNEaWt0cFpqcXhrcWVD?=
 =?utf-8?B?cnRFenZyT0szLytOWFVJWFZvK3pvVVlmbjdJaTNROUZsbEpib1NFdDU0Q1hF?=
 =?utf-8?B?aXFmSTZhSWZtSVhFSjd0eHVKbUZZUFFKU2EzcEhWbFh2V3Z6TDRCOENuZWt2?=
 =?utf-8?B?L1BBc1NlMlNORm5uM1Y3LzR0dTZTMS93U0lPeENrQnZiNzloYXJZalFENUZa?=
 =?utf-8?B?NHpLU0JMV0c3cFdRUkducTAvT3hiTk5heGI0WkYvdVlKQzdBTjdjM09HWVBQ?=
 =?utf-8?B?WVhKcGpwM0RaLy84U0J5NlgzekwvYVd3K216ZUEyK05HTjhPYnRpM2J1R21P?=
 =?utf-8?Q?4zeAboY5y+36FFwB+EN+6Kk=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3518b05-c824-431f-50b2-08dc20a84937
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:57:13.6044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuMuNEpJ9OhmH8OmExjhsE+Aw0xKuMR2dC1aq2WD0AZKoDHsbrPsk7l39X1A2QH5ZT7bPBas/mpdH0nRbcthrjGLXiiOLYPRa3qMEf1DQtmaImTdf4WA+Pvg4Z+sirGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561

Hi,

On 26.01.24 20:58, Lino Sanfilippo wrote:
> [Some people who received this message don't often get email from linosanfilippo@gmx.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi,
>
> On 26.01.24 18:27, Farouk Bouabid wrote:
>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>
>> The RE signal is used to control the duplex mode of transmissions,
>> aka receiving data while sending in full duplex mode, while stopping
>> receiving data in half-duplex mode.
>>
>> On a number of boards the !RE signal is tied to ground so reception
>> is always enabled except if the UART allows disabling the receiver.
>> This can be taken advantage of to implement half-duplex mode - like
>> done on 8250_bcm2835aux.
>>
>> Another solution is to tie !RE to RTS always forcing half-duplex mode.
>>
>> And finally there is the option to control the RE signal separately,
>> like done here by introducing a new rs485-specific gpio that can be
>> set depending on the RX_DURING_TX setting in the common em485 callbacks.
>>
> we just added the rx_during_tx_gpio to the serial core.
> Why cant you use this GPIO for your purpose?
>
> Regards,
> Lino.
What we are trying to implement is a gpio that emulates the RTS signal 
itself as we do not have a dedicated RTS signal that can be controlled 
through MCR. The rx during tx state in our case is a fixed state of 
"NO_RX_WHILE_TX"

Regards,

>

