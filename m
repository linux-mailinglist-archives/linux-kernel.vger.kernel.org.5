Return-Path: <linux-kernel+bounces-129120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C95896543
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808FB1F23E05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A7548E0;
	Wed,  3 Apr 2024 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="sJ17JrcO"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazolkn19010001.outbound.protection.outlook.com [52.103.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183F17C64;
	Wed,  3 Apr 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127690; cv=fail; b=iL5bcTKy+aiDPTF/FXDYImFVk99zWHfOElVRFbekZLfkKIbnV0oL9pwEJvKtL8qK5xDu6lsWTQanp/ISEq+q6Xc+5JkK/uYmqPF+qGWjU2D8zfql3KK+acJtIw7BWedBwGuKrnq/aTP20DsOGe79QKIUKfH56cfOa7MZqSME2dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127690; c=relaxed/simple;
	bh=H60V+0kWIwupyfX8LiuhZW+j3UzDmQE/vZc2Ic8yR3k=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=gDGLY65Qevip7oQNaiWOepoTHoFno4ttAtUt4tPz8wixuVBOnE433aryPDxBWaB1ZpWw37n4P4TAlmuEGOjnvT4WpA6dI6J4kfsuc28Y5Marxddi/sPoeal9bgv6oaQ+2tYvCV+qaUURQPiHPRF8Lpc9Z6/ZYdXV90jbn43Q8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=sJ17JrcO; arc=fail smtp.client-ip=52.103.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3MjU8sZfb7wRJQdEgixCNKdvRnFKY5/6f0ARO68+PWoJJUHag8rD6hTI7mGThKK0cx/sJwok/Lg09sXpS3uJm4IrzRfc6X00qQJSXqGMwoVnJuTJKxYVGafPzkG0jI2j0imCWPUIVFm7KYdu8HTsWzp/jHaD/yOFG3OXvF2QqMEMNIONR1DujbkBHA7y488QnIH9Tfa+NWQ/82V9egbNRK/EHPtP0SkUw0Gn/VBUhKFHsxUQLLgHzAFYieL/xeojs1FNYqdGCxJhb0aXKlDLBGiY8NwkEv7s2cg9z7Sl5e1eVa8hdZDCojglDqBBHWARN3Z4g4a7/Mx0lEylVCp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKGTi1ZgvXJbZ7IBc9CNYpo9oehRZlmlZ4pQi9FlzT0=;
 b=KpbP5UEg3t7vBRBh2RyJQXkyjkMezV1eg4fZKSk20hhIiA3FJ/+XIBewMLDJbvn9HQm4cbS7ZvDVvZQnFT4pMRQQ5QwZ/fqQG1JMiI6pC35y9WsVVREkgUB4E97cGoyd7JDfQhOPPDj84uR3JujhVd0GjFQajdHkPhTEqDPLhPSvUHMBPm+YP6BjbdhqtGY0ll1od7AdKQqyLyP/1EjoQHTXRHua9O8Qd/9YzH61azmignPkT9cqy48PtdsqZzxHVzJke8J609IeNpOqJbqWgy/sip6/QxbjqTx6QyQ8UGbcHQCrmiuDbhkjQuXy9tIR2MEqShfwHOcX//AxDrX1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKGTi1ZgvXJbZ7IBc9CNYpo9oehRZlmlZ4pQi9FlzT0=;
 b=sJ17JrcOoy4EFg9NvgL7SbWQ8bF/JKCH1pLnlULUjVb/hlpcN6G0At9UOaUhspOPlLOX3EHXESGnoADsA3KWM9Sh3FYP1udAAg0Sx399ZvVC5Ex4LIYo9KrSSQCXBSsqOetELzEj2+ZoAQyiePQYxdE6tuj728Np1H+Dp8cZl26tQGE/JdWzgqAuS6bq/9LSFRw/Ua+TYveHuEQ3DNXl3dUOUOwDr1qGrggT6STcjQ3SlgdiNCqtV55JqQZe1IR0l0K3TUM4ynCBOsmLZK2E6HXaPOycBOHifvhcKgXJ/MVHA6DmqdThyG8mpH6Y4OMNiQfZHxD4EPZ+ZiLmzfjDRA==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SG2PR06MB5106.apcprd06.prod.outlook.com (2603:1096:4:1c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 07:01:24 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:01:24 +0000
X-Forwarded-Encrypted: i=1; AJvYcCWnMCspvVFyBDsidQi0s8mqMN05MJodJP0IcEvBm5BxFeUtIBHYptA8TIC9Hd7QMGAiDKuhNHDFAd6oir3LmvX6YwlaNRXpq8BZmubZWrxpvSKIqQYz2hw6CqHLDtEmT8nOwWRH3VcFdatgwSHfQIh3z4ae9FG9neynXNB1DYL7GabLeunw
X-Gm-Message-State: AOJu0YwYbtKSuLisgJERhlVVKbOOomAJDO74ldHgzMXpPARiFZ3BHEaS
	300+WIqF8xL/ZjJcj9FbmIsAm723uOmoYbq74mQ7wH+7+YYBh2KR6SCTA6I1yHH3GgkG61dHy5d
	bxDuJDb0SF0CMkixybemou5AfVbk=
X-Google-Smtp-Source: AGHT+IG9fQgqqTrzxdlhtlz4B9nRtzrY/gbDlxx/zNcwmdUHvwxuBujVSYzkUK8n/9nqlsHKIhI8bmjUTnm41AZwAso=
X-Received: by 2002:a17:906:1390:b0:a4e:3a09:4854 with SMTP id
 f16-20020a170906139000b00a4e3a094854mr1194787ejc.61.1712127199729; Tue, 02
 Apr 2024 23:53:19 -0700 (PDT)
References: <20240402104930.1053016-1-allencl_lin@hotmail.com>
 <TY0PR06MB5611C37640AA40B2B7716ABE9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240402-doable-routine-8e8cb4f07ffb@spud>
In-Reply-To: <20240402-doable-routine-8e8cb4f07ffb@spud>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Wed, 3 Apr 2024 14:53:08 +0800
X-Gmail-Original-Message-ID: <CAEr79DWDD2rxnpgSAHiXYaO_cGpPr1d747PYFUxUsEP8cYA1tg@mail.gmail.com>
Message-ID:
 <TY0PR06MB561132CACFD67235EFC76C219E3D2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
To: Conor Dooley <conor@kernel.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [Xuj2PbHvyVyWj8ITJFyGWMdroB6KGA8t]
X-ClientProxiedBy: AS4P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::25) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DWDD2rxnpgSAHiXYaO_cGpPr1d747PYFUxUsEP8cYA1tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SG2PR06MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 262654f8-7630-4bc3-a65c-08dc53abdfcf
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd/JEwNiiJD34Jowu7eWn6ZGMFRCnmooCN08X5nZjL8UgRvkEIheGt09Rwmun5hB4IbKTQmCVyNt6+/5ejAN/bSO51WVzZ7zqpqB6KY/dJuclH5GmBcaDYRrlq23hY0D1wQzS4E6dpCEwpUn2Em8Azmz8fwwmlZ66IQ9IkU+0MjETiIRiCCfqmhrP2sxDZQHzoz7v7doXYOUPw2niu0KzEpBJ9PzOjoejmD23KWyUl1BKPBT+/3ET4ukDkUn/EliD8YImL+0s5739yKVNrt6AHGu/wizU3OoIVA+fTljrf8pCNO9G8FU2qk514SmRBEE8eS05V5Lf92Ffl6Y6XDntPFyT6DV5bj3b4hfjDuDoHsZMNlFlPbkKB6ihxwUETiuYUAH9HMIPZKHOAPBE/3hy4beimpcoy9a+DZDECk0Qudg7ysMq9InaqWmTrk4yOGEjfP4BE7W6QPSVs4xAaAn8Dtt+1CCrjwwVazyAHbRo9BC9aR1xfEr45gSqFMDzw1sBrYx4rCvlLKgIl5ikXOwF+cVQPNrGPbBmz7se9O12cN8OC+gf5d52jwdp1Xm+UffyzQT8g59RnFUuXic3oSol12tcdxPjyviQLkH83OGQI8MX3PL2msHvb/bgQjb5D/AoZ1vk0vTap0dMRgqKKelGiW54lSiQ0gOeaDEXOyrItkd8gpWPmh0+ZCt7hYFHaqS9UQAuq1I/b7lEL64gTBoNrwv+1/7izozu4BO2r313JvpaJkwq227xavPjv+CMKwWUpOOewBntwsn/rU+0Fr6ZVjQBPgfztR2mWJnEJjaWQIWow==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ZZt4AmFdmL8gOoHIFFO3nM/NZWdtNA62mvrIN3w6GygBnCBySMN2c03h6zjcolkCRrfmUP12S0KfE0kfLiEPW7CQcjUq9cklWFeul2ARtWcD+kogifeMo98aOHZ5GFVh2q6yRg/FMVxLOMZai8l/3OB8yaE4J+LApcjnh7T1yz7LjrKSRq0lLRNW9T0G1IDvoJv8BrGq92vE6jvnk/tpyuCoM/5tSC6AinbPgARVjcQwWZs2VkXm6ZHpmNKIQoRfCDvE0z93A1Tu15aEdjXgh9eZWNwCRkA9tDgnVZrkyVpqaco+WToWIjnfft1c1JHaMw79Ql3/ITlFgTOAtFAkt603lC/XgWBGHb5u0FPnvtNwriCH0p4j9pLdVFcZfA6o0SwEsLbtBseZgWTVU+Z7PBMKS2mVX7IrZiw2ldr85bd3OefgSHz59/1IaEbFOydY1Rsrq597AD1heiqmAB67dpz9JU3KAMiKAdLl0Vbnc9e7BY7z5qC8XtZl3XqW8TXqI/1ggij19LxddLeauy35oQbomyHxfxrIhmPcg8cnuTjR5yVyWE6BMALo8laXaXkZIqMgEvUI76Jw/3Nm6oHSjpgnKmdEHDfz1NXlKCqtjhJ5ex2/0tDQf3pjSM8P/Hi2jerQQxFkLObZFCPIAk2BYus4RGeKFrolWRtUY9BGS4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitLeUhLS1JibmRwN29DNm92YktreEU5STlVaUtucnJIQllwK3oxa3NQS1NR?=
 =?utf-8?B?VlczTkdrM2ZrL1JpQTk2RmFpR1ZLVGtzUm5BaHpQdFF0MjIrbFFDYWF0QllI?=
 =?utf-8?B?QkNiTXBVbTh6QmJnWFMxVlQxUU41MnBrUlV5MlVjOEp0eHlKeFBKK1EwMk9P?=
 =?utf-8?B?dSs0M3o5U2JPc0YydHBQa1YrWlRoaHorZUlqOVdJdWd1MnRsR0VIbmlpU0Uz?=
 =?utf-8?B?b21JMVp3bTRXRlhtK0VSaFlsbmpaSzgxQkxQaXhQVWlZa2R3alMyRHhBdkUy?=
 =?utf-8?B?SlZJVnhjbU9TdFYweGRPNlEyb29Gc0kyTitFQVR2aDFjR0xtMjNwOGRJSVpk?=
 =?utf-8?B?R2FBamtJLzk3ZktWckVDL29RWVBiRW5zbWc1bmZyaDFIMVNoa3V4Y1kzTUMr?=
 =?utf-8?B?Vm93SDdMZVNUdlBCK1drNkxTeGJvWkljMnpzbTV5YTlFZ1pudmErbTFYY1hW?=
 =?utf-8?B?eWVnbWQ0WXpabDJGQlJ2M2lDcElZM2U3N2VGQWYwTHA2ajlUamVJZW1xME9u?=
 =?utf-8?B?YjhiVGViWk9hZjIrMlNoOUU2ZTNKdUN2R2UyVnhNWFlackxSRFJkZkRseUQ4?=
 =?utf-8?B?aHRKc0FlQjJhQUJoREF2Y0FrZ01YSVFiNnk5MVJxeHQxVXg2K2ZMVlJmYm01?=
 =?utf-8?B?K3l2MndEVnFBQmZ4RFBBTWFtbkxZam03dzRsZlZhSkw2T1R6dWptbEFGMWxJ?=
 =?utf-8?B?aEh1SHJ6NUlzOVFPb05oVjJGam41Tm5DZ29XOFhuSjhubld6c2lHUksyOGhj?=
 =?utf-8?B?NDk3UXdGQ0dDczFQc2IrSWJTWStBMmx3dVR5NFFEcExmYzVKTjB1U0cwc0tv?=
 =?utf-8?B?WWtndGs4citmSjEvbTQ0VWZMZkVxOC9NR3lMQ3F5YnhBd08xandIY2hIM1pq?=
 =?utf-8?B?N1JUT09FODBORmFDRGswYS94eWpLTlg3Ny9vSGtlUUQ2TytNSXVWdWJFNTdW?=
 =?utf-8?B?V2pSVlFZQXozWS9JeGZVRHRISDNFZE1xK0QvWjhWS1lMQnIxQm41eFAxZjIz?=
 =?utf-8?B?aFZDNGhBWC9YN0NFTXA4SFFnamRtZ0Y3QnM0c0lhalN5azlxWS96YzcrWHE2?=
 =?utf-8?B?VzZUUTI0OHFNREZkMjdKeEg4RHNNTlpOTnoveXU5UzVOU0ViN1BaVUovUU9o?=
 =?utf-8?B?bFNhclh0cG1XMC9iVUQ4emdFQXFSNTY4UlZUdlJpTE5FK2FjRW5MaUNnZURG?=
 =?utf-8?B?OTNDdWgrM0xSNG1PZ3VTcnJibld5RFN1Y2NLOXZnRjRjSXNsK0JpUDdlQktu?=
 =?utf-8?B?clpQaW5EZlBSaGh1N3M3c1ZSSDRsbENkeFNZdEJ4bWJTbHVVNy90TERDd3pq?=
 =?utf-8?B?KzYxd2Q3TTF6R0tQY1k1akJEbldwN0NRdm5kNFpicTV1bzdwTWpWK2p4ckVk?=
 =?utf-8?B?allhYjBJbWJRYnhuSDJwQVhHMmZGVUJZRVE4ZlMxN2J2QnVvWWlYWUdFWklu?=
 =?utf-8?B?RzcrUVp4MXJsNWtFK1hFbkU0ZHZPNTVaU2FvWVg2Ymg5aENGVEwrL0dkOUtk?=
 =?utf-8?B?QTl5aHFhcXdOdkJmVEs0ejdSNHl5K3NUYTBRalBEYnFHZzgxU0N0YjFvSTNX?=
 =?utf-8?B?UGc0ZWo2YVdUODdIWCtUa0pBWHVzR2J6QVBJR21qRXdXaHNqOFUrWFE5aE44?=
 =?utf-8?B?bHhNZHc5NnA0RmFUOFZKdThzRjN5NS8xazFRbTJNOGc1Q2VFcXNLV2FFQ0gv?=
 =?utf-8?Q?N38m0p8fTJLivtyLxdGg?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 262654f8-7630-4bc3-a65c-08dc53abdfcf
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:01:24.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5106

Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B44=E6=9C=883=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=882:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Apr 02, 2024 at 06:49:27PM +0800, Allen_Lin wrote:
> > Add the HX83102j touchscreen device tree bindings documents.
> > HX83102j is a Himax TDDI touchscreen controller.
> > It's power sequence should be bound with a lcm driver, thus it
> > needs to be a panel follower. Others are the same as normal SPI
> > touchscreen controller.
> >
> > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > ---
> >  .../input/touchscreen/himax,hx83102j.yaml     | 100 ++++++++++++++++++
> >  MAINTAINERS                                   |   6 ++
> >  2 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/himax,hx83102j.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,=
hx83102j.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,h=
x83102j.yaml
> > new file mode 100644
> > index 000000000000..fe79129f704a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx83102=
j.yaml
> > @@ -0,0 +1,100 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/touchscreen/himax,hx83102j.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Himax hx83102j touchscreen
> > +
> > +maintainers:
> > +  - Allen Lin <allencl_lin@hotmail.com>
> > +
> > +description:
> > +  This Himax hx83102j touchscreen uses the spi protocol.
> > +
> > +allOf:
> > +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: himax,hx83102j
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  vccd-supply:
> > +    description: A phandle for the regualtor supplying IO power.
>
> nit: regulator
>
> > +
> > +  vsn-supply:
> > +    description: Negative supply regulator.
> > +
> > +  vsp-supply:
> > +    description: Positive supply regulator.
>
> Cool, thanks for adding these.
>
> > +
> > +  ddreset-gpios:
> > +    description: A phandle of gpio for display reset controlled by the=
 LCD driver.
> > +      This is the master reset, if this reset is triggered, the TP res=
et will
> > +      also be triggered.
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> > +
> > +  spi-max-frequency: true
> > +
> > +  panel: true
> > +
> > +  himax,firmware-name:
>
> firmware-name is a standard property, you don't need to vendor prefix it.
>
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Specify the file name for firmware loading.
> > +
> > +  himax,pid:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      PID for HID device, used to validate firmware.
>
> Why do you need this _and_ firmware-name? You should be able to trust
> the firmware that the dt has told you to use, no?
>
> Cheers,
> Conor.

OK, I should trust the dt document and fix these issues in next patch
1. fix "regulator" spelling
2. himax,firmware-name ->firmware-name
3. remove himax,pid

Thanks
Allen

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - reset-gpios
> > +  - panel
> > +  - vccd-supply
> > +  - vsn-supply
> > +  - vsp-supply
> > +  - ddreset-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      ap_ts: touchscreen@0 {
> > +        compatible =3D "himax,hx83102j";
> > +        reg =3D <0>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&touch_int0 &touch_reset>;
> > +        reset-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
> > +        spi-cpha;
> > +        spi-cpol;
> > +        interrupt-parent =3D <&gpio1>;
> > +        interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> > +        panel =3D <&panel>;
> > +        vccd-supply =3D <&regulator>;
> > +        vsn-supply =3D <&regulator>;
> > +        vsp-supply =3D <&regulator>;
> > +        ddreset-gpios =3D <&gpio1>;
> > +      };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 43b39956694a..aa51c60fd66d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9669,6 +9669,12 @@ L:     linux-kernel@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/misc/hisi_hikey_usb.c
> >
> > +HIMAX HID HX83102J TOUCHSCREEN
> > +M:   Allen Lin <allencl_lin@hotmail.com>
> > +L:   linux-input@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/input/touchscreen/himax,hx83102=
j.yaml
> > +
> >  HIMAX HX83112B TOUCHSCREEN SUPPORT
> >  M:   Job Noorman <job@noorman.info>
> >  L:   linux-input@vger.kernel.org
> > --
> > 2.34.1
> >

