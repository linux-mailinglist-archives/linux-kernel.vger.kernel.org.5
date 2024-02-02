Return-Path: <linux-kernel+bounces-49135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAA846668
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160031C25FEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A5B16431;
	Fri,  2 Feb 2024 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="Wl8WYYbR"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2135.outbound.protection.outlook.com [40.107.8.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253514F7A;
	Fri,  2 Feb 2024 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843295; cv=fail; b=eM0dPUVzTxKxIncYa6ETqhgWNdLGq6NQ2nS6bICAKHEQFHcth7uZF6NcfZeFGZCafEkYPUo5qJGxLX+APYPhJ/eI21QTbyWzWF1HanuNWfWyM1/R0vYgPAP86I/6txLx5nO8jmM9xlzcUcehxeDykBZkUFB4c/FB27Glm56lMRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843295; c=relaxed/simple;
	bh=taQZokjdrKeAfVsey/h/iraRiCNlpUjLBXTDYBF60Zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UT0kPneVFCjq9G7ePOGmWKysBPmVBmz42TFDxm/4rz+oQ9BoSHp90BP10bJrc4mxtmI10mJqsKrHf/E/wY0eZvYCPIihJgYXLdfjootp+3Z34Ht6CVNtMMXU9uD2OSdXus2XQDOi0/rQect0dfO/lRlqfFNc41I4NudTifc85vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=Wl8WYYbR; arc=fail smtp.client-ip=40.107.8.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6jco/PLiL4ghENico4Udm1RSamTkwlItnh0EIOH6nu51+vCiEATxuYFjxrSOF0oaYjWgHr+q1e5MQmOY6R5gIsx75x/HaZ65ypvbFd/+2CfiClwNdLnIH57fzHAHmQvreB6OR8iR3mLCu9J/fvIIksGHApUps9lRaxRmEGGTi0PfeefplTVe/WeRYBBgzjXc/CYqI65NsUIuJ6RV/xiDbs2RvFdfKN0TljxZYz0+ZKkIwCrClyovtn6+prU4wDL6Vo0oLVqCLwEfRG0XNA9l8Eb5MAH+UbJ2A5ELcewF6D6muPbrag4K8J0u7kMYEN3XO7QT339LCv3B6aMv0D2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp6ii9hSdDf0Hg8LzzG8WLQuitfQwm74RJxpeEYcyRM=;
 b=GP/A+3WaNhbsRriTleIKv88NmX7RHkkn6AwEF2VXYY4IbKiTyYuc27NdJZ9npLaLohgidUSt6K3ckztFykyY3/agTjhOnYcayShoiH0EGV6HoA+2QU+bl6qXzeF9GaExccKK0NnXw4F+vtQgWLy4BZhI3P3/5XZrPwMueVbEbWuvcipXLdlo/R5TQnHaMSp/LM1Du9CLjcXq69peup957QJYtwrKfsftHrhtFIg+n+IFFUrSD8xvR9dML/JKxtWEl4z5WeNEiUEKcTM4BmKz/GBucrGikF7zw1sZZlDoaXrFRhhkzc5gnKSqVb5IRIR17bL4eWXiBD+2MoWAj8orog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp6ii9hSdDf0Hg8LzzG8WLQuitfQwm74RJxpeEYcyRM=;
 b=Wl8WYYbRgxVa+gFrg0ElOEaGIOCdpnUiiycdVLswXyhkyCClA9JZdvWB26Jcug9rqOrsJvomxA0MHdtPb0g8JI8RQXSlN7fBMUy+I1VbYuprbQD1OIG4gvVRHRW2GN0E0Pcrc+2wXLVF6x2Q4FuQYlzweI80U6+7SjL8++wWabY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from AM6P193MB0408.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:4b::27)
 by DB8P193MB0502.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Fri, 2 Feb
 2024 03:08:09 +0000
Received: from AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
 ([fe80::87d7:22fe:81fd:2bdd]) by AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
 ([fe80::87d7:22fe:81fd:2bdd%5]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 03:08:09 +0000
Message-ID: <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
Date: Fri, 2 Feb 2024 04:08:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Sasha Levin <sashal@kernel.org>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ross Philipson <ross.philipson@oracle.com>,
 Kanth Ghatraju <kanth.ghatraju@oracle.com>, Peter Huewe <peterhuewe@gmx.de>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:4b::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6P193MB0408:EE_|DB8P193MB0502:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5fac62-7840-4ec6-bc3a-08dc239c2f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oPHkJ4rGcn4TEBEm7SYiY5QWgROcGMen1xdzb5Y8zch0UsZkRqK6Qdj6z5EbWUyF1LyZOtpc8o5bB4vpNZ3Jr9BeHR4O4dfmsDbk3aRRXs7g2bM2I0mfJwvYRDuQkQ27+VRO1PvZbuKToeWPyF61nJgYztngNm1vJhRRGRAA147MeqRNMKvaPlQgzFepureXOz8l39QHuExyO6//jl9n5Jq3YU+R5M87csa8Zy4J5XrKR+6+ESo7UIf1JbROKnAkcqQw/oCZGKV0N9C1b8fwgDyizGDD04aVFBHGoT6HlLWcMRCGl0mq2D7yUw/MzBw6wCwW5pdcP4s/ONAJB9MtlEC87WYAcMsGcoMwwfpNsmDpRhbctCEISLpPufVKqIaKblNobEwRvlEeTVPk9J0kECbLC9ZoncdR5yXiF64Z5LVsw4oawZGKjwy8E0qjG7DG0xpfw2TzzlXJ1zFtjuLbYBwuFZ4qJJfzWE7hohxS2sDAo3MwFYIbZ9+VY7fKDuIqG68DOiwsZrr6KAsYKMUEVZLSrZ89lEKPy/jl0IzHEGzAtwH0ev5WF8MJU5QJxNK9AKjggGigxdxS0uMrOk/5lwS+f8lHMuxvvqvAaQVITwpoLyshlFCXo8c6RjhDTouq1id2AhI6MpVm5sehn1nlRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6P193MB0408.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39840400004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(36756003)(110136005)(478600001)(31696002)(38100700002)(41300700001)(83380400001)(54906003)(6486002)(86362001)(2616005)(8676002)(316002)(66556008)(2906002)(6512007)(8936002)(6506007)(5660300002)(4326008)(52116002)(66946007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0NLaklUZHMzejdXMklnY2tud3RRelQwWkFXcDR1UC9GRU8yV3dYdlplQ0Rn?=
 =?utf-8?B?ekN6NWhndVJhTUp1c2dPWm5IYW1EbXdKdS9wU2NLYVlKV2trZlBzTXV2Q21P?=
 =?utf-8?B?SGQzSVNPRlUxT0p4TE5HYVZZOWVjc3RTV2RWQk1LYlNWbzd0dXRPcUt1cmxO?=
 =?utf-8?B?azQ3RWNISjk3ZXlPcDE3OTFyNDBpRWlHYzkxM2g0bzVPTXBtWTNjTTRYUzdl?=
 =?utf-8?B?Nk8zY1NkaVVBZ2dESnVCdmR4eVBzTGhHdFF0RDVJQ0JKTlFYc3ZBcVU5aExz?=
 =?utf-8?B?SHhjL2hicWxQc1dEbFhVNDh1Qk9YdXRMNXdXNkRwUFZsQkJPVXprN0k5L1Zr?=
 =?utf-8?B?ekZHdHhXYlRrNkhzVUczNGk3UVBBZWtTOXhlSUVJK3grMXBNRnRzQnlDYkhk?=
 =?utf-8?B?YkV1RHoxdEdRbG5WdDJzT3JoU3BlNXpDK01NZjYvT0RndkZCeStUNXl6WUJn?=
 =?utf-8?B?aStwZVVrendwUjB1Zmt0YTVwYmE3RkJDckdTeE9peStIdzIweGdQQXd6cGdZ?=
 =?utf-8?B?ZTJQTlg2bnhUUVdHNGllWVpaUFZkU1c3MGthMGRzR21hMXFEUjk4U1dkdE83?=
 =?utf-8?B?K1ZXclZsZk1pYzJHUm5mbWF0cWdvK1RkSlFuZnJWcmJlTGl6WnNRRmI0K2xr?=
 =?utf-8?B?MEFLdVdqaTQ1OU9wMzVzbWdYSTRNdVNSdWg5NDE2dTRFUUZ1N1M1RmF1SS9F?=
 =?utf-8?B?NHlhU1h2YnB3OWZvYTljN2pMbTV0Z3VtZFdkb2V4dXRDaXRSblNyUWJQM0RB?=
 =?utf-8?B?dGJaQ2NEenR5VnQxVWJYeUpmQU8rYldhOWJZSFFjQk9pbXZkN2p0VFpDcGMx?=
 =?utf-8?B?MHZUaWNJMGFEU2ZZWUJ5bkgwcGFCNVlXeTB1N3FpQTRmOGliTXJNLzZQcXV3?=
 =?utf-8?B?MlFSTmJIRmMrNEpQZ25YSUNnNUV0VERsbjBURFVTYmhuUGJkQ1hXK0FCSkNE?=
 =?utf-8?B?ajJHMEcyZWZFaUQ3MlExb1BLU3NDUmZsTHdnalNKazdmODZ2eFN2QU53MUdS?=
 =?utf-8?B?czRyMmpUdUc5eWp2eldWYlJpOTFuUlg5Q1EvcXE2OHhQN2ovdDV5dzJmOW5F?=
 =?utf-8?B?VTVTWjBUQnlaN0ZkT3Nab1NMOHNkNUI2QTNHWmUzc2VOZHNBN3djVVE3RGJ4?=
 =?utf-8?B?aWJpcC9xbDJEYzhCNzQ1R2FlVzlQamJKZU9XL2dBWDk5SkV3TitXTzY3QmtF?=
 =?utf-8?B?QXhjMmVDdzlOTmQ1b09MNXdiTVYvK21vSVhmWlBueUpZQThhbjhCcHRUQjNh?=
 =?utf-8?B?cnJkTHV4TG4yNUVqcXlTSDdDWGkxbzVnUkZuMGN1WUU5bGhaYm00NHFiL0lS?=
 =?utf-8?B?TldrN20vQ0w5eUg5YmNzaUtoK3IxL0l4V3FEYm9pTnRCS3lERDdFRHBCMG9t?=
 =?utf-8?B?bnJSNUdDZ1d0b1gxVEhkRnA3ZXVqN2k2OTNjMVRJemoyeDlHRWNoWW1EZEJt?=
 =?utf-8?B?UllGTGdGRmVPS0UwUUhMb0ZJQVgwVCtJSlZXcnZvSEt0Q3ZrRkt5NEo4NTZE?=
 =?utf-8?B?ZWlHRThlVEd3Z1JLVVhJbFAvMjFLOHB2dVUyYSt6KzMvSm5hVUhJdmFDWWMy?=
 =?utf-8?B?d0JRT293cVBnaEJIZVdjNVlDQS9SS3hHVnB2Z3V5T29hNVBSRG9GT3hlc2pm?=
 =?utf-8?B?RzVhWkN6RkxmUnYwTWFLeEhWTFRYSE1uWnhSTmJqdVJqYmZ5ZWdMZDVyMkoz?=
 =?utf-8?B?Nm1aWUNUeHczQjg1T0V2d0x5UkZpTHJkbGVvN2VUTTMzeDNrakNjZkk4cFVs?=
 =?utf-8?B?OXFNRWduMk5pa2o5YTMwUDhOQVFnWVRqN0w3aVkwczQxQ21HWlRmc2tzZlVh?=
 =?utf-8?B?OXZ6c2FpbEl1eWFtNTdpN2VYR1loUHdpdjhPNm0rN1Z5aDMvRFRRTWRDTFg0?=
 =?utf-8?B?RUk1RzZaMVpNcGlyTWlRNFJDTVBZQzljQ05nNktrS0xuWFlZSWplUVVLYXgv?=
 =?utf-8?B?NzJLdTNuUGZidlNBcTlrTGlBWUhSdTNCODZJbzRYcktXOXBEckM1OHg4WFpQ?=
 =?utf-8?B?QXNCT2Z6MG5Bc0tkNHdndGFma1hsbkFsd2ltQ3E4aml3dHE4dWUxWi90UWtQ?=
 =?utf-8?B?MHBrZnNWZ3NuV3Z2alZma1g4R0dCMVVqNTkwQTlZTmVvTlMxYXVETTI2a3lt?=
 =?utf-8?B?OExYZnMveHVWUW00VEJkTkRMMkcvR1ZRa2JOV1RKUmhKRTM5UlBkQ1JNejRX?=
 =?utf-8?Q?dQmFWg53UXTWrHxdMY5OXRV2hV4Nn1oEYELbmEau/SFH?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5fac62-7840-4ec6-bc3a-08dc239c2f49
X-MS-Exchange-CrossTenant-AuthSource: AM6P193MB0408.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 03:08:09.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lboE4qIsVkeZp2BpCZvEYMujjXodRlkMIDQK8kFdbGSwekfhU5bd0dRrMWwP4hNtyNdlwsCVYGXEKCwt+OfRLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0502



On 01.02.24 23:21, Jarkko Sakkinen wrote:

> 
> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
>> Commit 933bfc5ad213 introduced the use of a locality counter to control when a
>> locality request is allowed to be sent to the TPM. In the commit, the counter
>> is indiscriminately decremented. Thus creating a situation for an integer
>> underflow of the counter.
> 
> What is the sequence of events that leads to this triggering the
> underflow? This information should be represent in the commit message.
> 

AFAIU this is:

1. We start with a locality_counter of 0 and then we call tpm_tis_request_locality()
for the first time, but since a locality is (unexpectedly) already active check_locality() and consequently
__tpm_tis_request_locality() return "true". This prevents the locality_counter from being increased
to 1, see 

	ret = __tpm_tis_request_locality(chip, l);
	if (!ret) /* Counter not increased since ret == 1 */
		priv->locality_count++;

in tpm_tis_request_locality().

If now the locality is released the counter is decreased to below zero (resulting
in an underflow since "locality_counter" is an unsigned int. 

