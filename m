Return-Path: <linux-kernel+bounces-122446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F155188F7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67214B21CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D94E1D3;
	Thu, 28 Mar 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="L/Jizirf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2097.outbound.protection.outlook.com [40.92.52.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90461CAAC;
	Thu, 28 Mar 2024 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711605939; cv=fail; b=V+YLmhbyleHcc6d1K7Tk4jlVZoefBndY2xOPfmHMpqf0+N8rPrZcR3XUjsLvDOTazgow6jw8YzndiIxIr4VxI7RDetYn7m5PAZGChGhmFXU81Oa8qjQqscKkRTDwDt7iVWZaaf6R0fA4wDTt3uLiGegvCjpIc2xg1G+JKzA+LxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711605939; c=relaxed/simple;
	bh=/YeUnquGaMAIezS+FT16JsdSrziiYPsFcpfTc8DkkQ4=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=Ij0jM+vQYCMDZUPjCHh292Llqvm12lFtmuESTbXFPOHzhZ/DC1bxhqod1O5W62SzpPVBhH4FMukUJlCKlkXI097zpqixG3Kx9m29vIhWhxaqTgDW4U4/Pu4H4z9JufMgake8lWvsfvBd+hdlFYcrjtIrRpBMFHr777cCcJvVjcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=L/Jizirf; arc=fail smtp.client-ip=40.92.52.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZV8yd/Vn17+x4RFewqC8RUnoy8lFrSjJd5xQ5rfRe0VZm9ctQkrgF55orz4m6qwP7yjjQl6VqKDm1H6FnULk8IFB1m/xef6Yb7QuqYkC8Qm/ZviiD/4ofB3R0j71On/tPniwhETLyuL7kEmDH1oaELh+gfZ0apR9IRCnIAAylNsA8pDKukf/sLJAjop87Xy4WFJkNinin8xiRL6AcgDKJu3a62VHhrsv8ltTsRHTNOGxC4QFbUe0t3gnPardMK+VDNwoQsZbxjH7OQQPlorplIt4ATT307Sd7NadPvTKqoaWOrOPWr2YEHktr8qijlBbBjkAyBDZZrAPA2SPx5jvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cDzX+FUpEtAoBJ8ECzcWnoOqnrbqMIk88OXWcm4kbM=;
 b=UsCTJalsse4cUsbrjhh78Js8q/P+WvgabKZPN50MzG3Z04dIb9PjffYGVqp7xam/wcKl+TYZL7SUAIz/rAytIz4WSweLMUN9Tm9NVAtdLqL3+MKgXv+8eu3v/bNmQbrHUzz5ulC3t6kZKSR0ivJk3u6nxlv9rHeLuWuKWJogQGydL191M5dVFZebu5OJOjvygWhR+Ul+5mj6UfMcy20nYNS4tSFfvrfJadIBpmvJMxx7WD4CnwQfK2PUKnEAKaO0oocBy2HutdCuQR2kjp3V9Jndo8ZDwllvX775pDKmZJhOil5BtvByCJs5x8g2CtYybavSSqEg2CCzZU++qKJhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cDzX+FUpEtAoBJ8ECzcWnoOqnrbqMIk88OXWcm4kbM=;
 b=L/JizirfeGCa5mRTJhs47TsM+XkCG2nTxb8MVh2QSmPD2wjcdHMOsMneEUMn8WRsk6oh0DVcLjuR8D1B5816bt5PtifKdpQGlMK6mVUomDu0Bz50rRKy3oSNaArP0cCWwyh3hDAzUx/UPBzX5a06XRehO+WzxpIvbLQ1idCv6ajLkshjT+u1fDbBDLOlWgO9ii7ijusrCd8GasVyrG7MQ/K92YxR0hLL7TwavtYPm5Fr14qdNQa7tsN98+m6K/5Dd/1g+0sGNiq+UUnlvrVmnbZskikh7DQGs8bdcHa7ecCXq8os7aZLWrddOTpCSu7fZWwETHPZn3aK++w4vgKu5A==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TYSPR06MB7453.apcprd06.prod.outlook.com (2603:1096:405:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Thu, 28 Mar
 2024 06:05:33 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 06:05:33 +0000
X-Forwarded-Encrypted: i=1; AJvYcCUl3sMOzD4mrOFHxqpi4hphYlK+pU7W+KgExeRWmi6/RIL03yFjx5T9Z00eYMrGnpc3fsCZtfgi75N9V99Zv0Tmur1/u7EZJTSik0xphpHMJR7/d8+Kd9KGt1p7rCQOQkBEYxTDhR4NKVlju+UUTqlBFslJtDfXgybHX6mETPbqy+/a6XV5
X-Gm-Message-State: AOJu0YxmX8LitoauBe+vtotT6hebAZzQWTiNLeYB9eqY/lWohw2l7dmC
	/g2JJHIn9J+rY5DzyVLvWTALYA6zeU4MFipVzdbWxf9naMb5FEoSl7zlMelp/cdcri374Jckr5w
	DJ2IhwJmswXWig3BubEZ2pPfT2HQ=
X-Google-Smtp-Source: AGHT+IHJzGJq1gpsKqxscRnX2H8Kri93hWCNDLwCxVuTScAC00nsfZtQKDaprNSez/FJV9PyGIl7JKO1OIL84KeEFKc=
X-Received: by 2002:a17:906:4f17:b0:a47:5171:8d61 with SMTP id
 t23-20020a1709064f1700b00a4751718d61mr952990eju.60.1711605929041; Wed, 27 Mar
 2024 23:05:29 -0700 (PDT)
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud> <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud> <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-whoever-spotter-1fe7ace35428@wendy> <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-granite-snipping-7c8b04480b2e@spud> <TY0PR06MB5611AE812B72B349E85118D59E342@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240327-pegboard-deodorize-17d8b0f1e31c@spud>
In-Reply-To: <20240327-pegboard-deodorize-17d8b0f1e31c@spud>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Thu, 28 Mar 2024 14:05:17 +0800
X-Gmail-Original-Message-ID: <CAEr79DWGTC7LQUH+LqaeKxYs=qHyHqsRDLaEqJV0VHn1rs6kjA@mail.gmail.com>
Message-ID:
 <TY0PR06MB5611F7123B22C4FDEE319C049E3B2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [PBbt5lyzFf46YvQERM0D1XeBILpmzFki]
X-ClientProxiedBy: AM0PR06CA0100.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::41) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DWGTC7LQUH+LqaeKxYs=qHyHqsRDLaEqJV0VHn1rs6kjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TYSPR06MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 9135e4b0-1317-4d51-7f45-08dc4eed13fa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ivJPNZxv3QhkC40zxnXC+JfTVrp3MLjocr9rRF3VpBQJISYXivBIfa3ZtKBpKSzowZhoSKAN9fdMWJilSY5JYADI0fi5cW8A+GlqaTtmiUOKaJg/K3EMyGHQ7Cxb3ILO7q+WBDP9hqOPsz0b2lxuix89IbJA90NxXdXuU4OsuifMTKQXvs/YTnFOD2/JKxV9agNvr7arvNS2YDfKYESAD+yWBjCi6wSIR6UfrB6eAmunKDYTV6+n2/6AJdhHccSdOJNpVczAw1uGrA763lRYSkEj1uSIf0m/+K4COJyEDuMkV7Xbkyvj8pNAYlPkezVny5W7s3wmaL3JvHImfsuLS9uCMjFs60e8wOG3tfpZI/ZfkL0NjM4RIZKfy/gBO3W5iYoRXxqC5s6niWAjzyn6dxYB6BMzeJsHMe+GsgaT50pVwKmmYlpl9RiSg8n5jreqmyEAFk41BpZG1TRt0hOzfs6KdKCfDldmlyELhPBvckw8Om/JROGYcILRlog9SopY3BvZTNe557Ke98YdUBtqjhX/AgmckkJIYuagXjWE7e9WiBa6G5jrkL92LPW4ql8LbeL4NdR/Rkwyh49JKJreiiR/KSQm4n4NGgu3TA861DW8j+ZTA+kXsu22Y1j3aprFgEzwvvOhX466U0b4KZ4dQRzhGJR7FO6KxhJ2f13yZCw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VqeUdITXdCOXAraFdidS9EZHMybjJtYXhaTFVMb1FLVmxkVmttNlpTMXNv?=
 =?utf-8?B?V2I4SE1DNGhCc2lwMXJZNnF3ZklDMVRyQklLVGZWUTBZS2JVUHF3QW43NkpC?=
 =?utf-8?B?cDNyeWE0ektneWNlYUk1dWswZVV5Qk54cGplZWRNTGF5ODdQSmpBbmpwLy90?=
 =?utf-8?B?cFd6SDBHbGlxc0x4NElDSGQwV011OExCdHh4aC9Nd1FleDFSN09MRnhJcVhY?=
 =?utf-8?B?NTNTYUNFKzVNS01helhFbVhNT0JwSjJubEtFejdybFJuSE16Q2xuN05TM3c4?=
 =?utf-8?B?emNDc045R3pKcUQ5cnQrSUU2czdnNmdWVXpSNE9IekNMU1Z5SWx2S2VlVGwr?=
 =?utf-8?B?Y0ZDNW9mNjhXVE9lb3hob1FtTm1TcEV0WGtpMS8yRWwwdHlEaXBJZFBFeXoy?=
 =?utf-8?B?SmdqdWREU3ZQeVdMUzFpS1hPYTFuR0Z6aHl0SHVMVGtXVFphU0ozb1N6NXV1?=
 =?utf-8?B?elV4WEdQMFFxK0w2SFY4R05JdTFJdXhXNnNhM3lYZzhVT09GUDBZMThwUmhr?=
 =?utf-8?B?UnBrOElEbFNpTE9nc1BxRWdmejBSRFlRUGJMOE54amErS1dwMVdIQXNnQ0RO?=
 =?utf-8?B?RkZjaHE2NW9ibVlOOXNEd2VOT081MWdiTnhHSU0wSHd4Q01nVWFaR3Y3NENW?=
 =?utf-8?B?VVRNNkUySEVGZlJYelZIYmdVQ1dyWFVnMzJtUnVHQjcvTTk4K3hudkV0UTBa?=
 =?utf-8?B?RGJralJwSzVrRGJSR3U2U3k4STZ6N1Z6TWhndjZuS0ptM2RFSDJGN1hWR2Ju?=
 =?utf-8?B?YkR6Y0FFcit0b2xiaCtPa2ZOaXVWU1hhWTJLQi9uNUhEeUxsYjlRK3NORkhM?=
 =?utf-8?B?LzN6RDAzbE1oSG1yUWQzQXN0bU9wMWNSVEluK2QwNzZ2OHFMdWpBd3ZiRjJR?=
 =?utf-8?B?Q1A4OGhnYkdIY3NSTkptTlYzZXNOc0EveDhiaEFYQjRUNi93bFd5bG9KV1Fi?=
 =?utf-8?B?UUtzNUJKcDk0a1BTdEt0L3N1VHJlY0RSdk9wTGJrcHgwSzJaVW51L0V3V3dI?=
 =?utf-8?B?QWtNQnVacHdKQ0lGcW9IcGFSNmc0eDVJUFVZbGl6cHI0SjNZc0tmdnNtVGh4?=
 =?utf-8?B?ak5SdE9pQXlwT2RzNExZNVJtNXFaSU43N2tXVzJkQXNFWXUvYUNiQ1VJT1B6?=
 =?utf-8?B?bU9GTWsvQmpZMDh0U3hOaStONzcrS2V6TUtPeTFTdWxwa3E4dlBueGZYUEhm?=
 =?utf-8?B?WkthMlpwV1FrRS9mUnF2OFlIR0FHbE1tS2QyS1NUaTJjbkdRS0w3TFVSbzEv?=
 =?utf-8?B?azVtK1R5YmZjNW9IU2RrSEtseXV6QXpoTU9iK1F1TzBqcVB1d3RXWDhpS05n?=
 =?utf-8?B?ZjBMdm9NMmpaczZmN0gzWjZUMWJ5SU1WNVFIZmlLRWwvb2RGdHU1Z3VtbTJh?=
 =?utf-8?B?SURzOWplN081Y0VRZHVkTWVNK3NoK2tMRjJvdytFQlIrNzlUYXlJK1JCa1BG?=
 =?utf-8?B?M3ljU2F0Mkx4REZXM3NnR0prTlh2YSszaDBXanpXYXJJTmQvVTR6aGlYbXpv?=
 =?utf-8?B?ZmlDMHBlRloySEFxT3pzQ1A0QXRoUmlId29DRmtXMHVTWDVQWExhQ0I5UXRk?=
 =?utf-8?B?dE5Rbm5OeUJmWm8vRWxsc2VKQmo3MXpmNGppcFJVamZMTmlCbFgwaFR5anBR?=
 =?utf-8?B?elZqcUdQb3B4anJOelU1eUNuWlQvTVo2bHI2WnNsUFFmZHI3b0llTSswa2tz?=
 =?utf-8?Q?DpmkkIWWIYPWhMsqFeAk?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9135e4b0-1317-4d51-7f45-08dc4eed13fa
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:05:33.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7453

Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Mar 27, 2024 at 03:48:48PM +0800, Allen Lin wrote:
> > Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:28=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Mar 26, 2024 at 06:40:28PM +0800, Allen Lin wrote:
> > > > Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2024=E5=B9=B43=
=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:48=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > >
> > > > > On Tue, Mar 26, 2024 at 01:46:56PM +0800, Allen Lin wrote:
> > > > > > Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > > > > > > > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrot=
e:
> > > > > > > > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote=
:
> > > > > > > > > > Add the HX83102j touchscreen device tree bindings docum=
ents.
> > > > > > > > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > > > > > > > It's power sequence should be bound with a lcm driver, =
thus it
> > > > > > > > > > needs to be a panel follower. Others are the same as no=
rmal SPI
> > > > > > > > > > touchscreen controller.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > > > > > > > >
> > > > > > > > > note to self/Krzysztof/Rob:
> > > > > > > > > There was a previous attempt at this kind of device. This=
 version looks
> > > > > > > > > better but might be incomplete given there's a bunch more=
 properties in
> > > > > > > > > that patchset:
> > > > > > > > > https://lore.kernel.org/all/20231017091900.801989-1-tylor=
_yang@himax.corp-partner.google.com/
> > > > > > > >
> > > > > > > > Those don't look like properties we want coming back.
> > > > > > >
> > > > > > > Oh, I don't want most of them coming back either. There are s=
ome
> > > > > > > supplies in there though that I think we would like to come b=
ack, no?
> > > > > > > Maybe this particular device doesn't have any supplies, but t=
hat doesn't
> > > > > > > really seem credible.
> > > > > >
> > > > > > We will use Firmware-name in Device Tree.
> > > > >
> > > > > > For power supply settings, because there may be other device us=
ing
> > > > > > same regulator.
> > > > >
> > > > > If there are other devices using the same regulator is it more
> > > > > important that you document it so that it doesn't get disabled by=
 the
> > > > > other users.
> > > > >
> > > > > > We plan to define it as an optional property for user to contro=
l in
> > > > > > next release.
> > > > >
> > > > > I don't see how the regulator would not be required, the device d=
oesn't
> > > > > function without power.
> > > > >
> > > > > Thanks,
> > > > > Conor.
> > > >
> > > > I will set power supply as required.
> > > > The description of power supply as below,
> > > >
> > > > properties:
> > > >   vccd-supply:
> > > >     description: A phandle for the regualtor supplying IO power. Sh=
ould be own
> > > >                  by TPIC only.
> > >
> > > What does "owned by TPIC" only mean? Why would the vccd supply not be
> > > allowed to be shared with another device?
> > >
> > > > This works for TP digital IO only, main power is
> > > >                  given by display part VSP/VSN power source which i=
s controlled
> > > >                  by lcm driver.
> > >
> > > What drivers control things doesn't really matter here, we're just
> > > describing the hardware. If there's another supply to the controller,
> > > then document it too please.
> > >
> >
> > Below is IC power sequence introduction.
> > https://github.com/HimaxSoftware/Doc/tree/main/Himax_Chipset_Power_Sequ=
ence
> >
> > TDDI IC, which means Touch and Display Driver is integrated in one IC,
> > So some power supplies will be controlled by Display driver.
>
> If someone was to turn off the supplies, would the touch component stop
> working? The document says that these supplies must be turned on before
> the touch supplies, so I'm going to assume that both are needed for the
> device to function.
>
> > In yaml Document, can we just list power supplies controlled by touch d=
river?
>
> If the touch part of this device needs the supplies to function, then
> you need to mention them, regardless of where they're controlled. All we
> are doing in the binding is describing the hardware. What drivers do
> what depends entirely on what software you're using.
>

OK, I will list all supplies required by the driver in the Yaml
document as shown below,

properties:
  compatible:
    const: himax,hx83102j

  reg:
    maxItems: 1

  interrupts:
    maxItems: 1

  reset-gpios:
    maxItems: 1

  vccd-supply:
    description: A phandle for the regualtor supplying IO power.

  vsn-supply:
    description: Negative supply regulator.

  vsp-supply:
    description: Positive supply regulator.

  ddreset-gpios:
    description: A phandle of gpio for display reset controlled by the
LCD driver.

required:
  - compatible
  - reg
  - interrupts
  - reset-gpios
  - panel
  - vccd-supply
  - vsn-supply
  - vsp-supply
  - ddreset-gpios


Thanks,
Allen

