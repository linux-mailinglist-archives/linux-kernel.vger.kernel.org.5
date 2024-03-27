Return-Path: <linux-kernel+bounces-120470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F888D806
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636F01C2604C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460F381C9;
	Wed, 27 Mar 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N3/NbQoO"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010000.outbound.protection.outlook.com [52.103.64.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E72E62C;
	Wed, 27 Mar 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525749; cv=fail; b=SPpvQx4NMlhj4uyklpn/qoqSrzBV5Rgr4fQWABli0T0kEpdttlGroCP64DDzAYt637wcdKXzm9dqiktV/xxyRPLiP7GlhHHaVjdGABp+RjiV9HJOSdYxtTEEduWxTVV8xoimD+EbYvTbIQq1ntgXYuRR9UrlDYybjYnxmqU4HOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525749; c=relaxed/simple;
	bh=nI+L5ovwueFs4Fh2+dDBqm7ZD3RbrBo9NvxyCBe2RhM=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=cri1QJ9/K9RDFAOm+YReM42ePLkvmADVSX1jy9gXAIhD2aoqH94Ol1RxiJjLt67yUs9JnzGBAmtunnI3kjinzXlKjVbOlk5sPjOpwkT5mnKd6fkzaXGVhYft+8q4BONj4SOlN49iMhTRj7zMAL1BDdksv386wGTqMCD4TjaosR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=N3/NbQoO; arc=fail smtp.client-ip=52.103.64.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXUK/8eAVioXfQ5Em/QEzZvMkq+9N6P7zzdkNphoKGDrqjNOL8D4fYmJ/B38yWIfnv9yok51JVtIgyrczf3b/TSr3cPauoV/EeXPiaaabETDC2ysZNkdS772c5LdmWMl0XVTPYfvIZlE6IKDXfp97awWOPYGNp4ECqxOHgUTv6d5ocdiW/WGsZ8mMoCBADMttRe632+CX1J5otOi1kw3gIQQ0mCvjGQnWsrDaKbxUR47e5lY9XajSGx4HzKf1Xk4+iB6jhkwCbjtJNxKKvL/dabC458RedtCGaFZr1ngDal2/LFVs6+KMyAhMPc5U00uul8q6iZJbEdreuJ/yZI4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOjjd5i1zfAx6zrGiAFQ48yqsfV1pLZKhiZ3witV5u8=;
 b=KuU62UMH+ocDNjJnLK83J5z7NCZwAiAYTQc0G71MwPB+BbYGyls96XEa3ntii1/MspLop4RiONAcaQR5nQXQ+kkrk0hedFPfBZXJJFctVrub8Q6w6gyFLwTsyL9b4skioZ/6zMdGUxm3c8dAME9dwaytAAWKbIwUS29sGu5QwBj1/ylvEK84QgWrvF/TrkSRA8lkpfcRydLUzkm5qdjh59WqhGraL/e1nooQqjVOr9Bl3c7QVc3EFMkREyk4JJZxvAcFnDJ9+Q6RSvvdmUnuMvvlhFL+mI93K6gUP3MK4qp4HX7YIgIuB2XW64WUvxivcJdaLmqf1i3VfpQJ3+XWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOjjd5i1zfAx6zrGiAFQ48yqsfV1pLZKhiZ3witV5u8=;
 b=N3/NbQoOAUiW/qyBy64XoJxuoXj00/Pcg/rcw3s61iFfyk12KfJlWInUGV1jXep3T81y51TiL+1pQMYjsqypo/OvdVsldfve5ENNoisUHTJSMCxoL8Qe7FVju0oQN7itg4rLZ8cnuXS2xAvtPC3vnvN6h8JuDFusevoKyDT2KRMM3EIcY9bzgesU9F3bnEgMbU4v1XAbJn6EG4LJlCrXB6GcWnrVTjpMseop3iTEWt1sC9NATFc8iSs3OVDhdXTKD+dCw8Tn8dN6nebg7DlGrt1Tk/Ugt1vwFtMm9PjhxnKjJENV8b7QGdlzFZOrHX4xoA3QgRgXxhUi3LgdrxFXlg==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by PUZPR06MB6125.apcprd06.prod.outlook.com (2603:1096:301:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 07:49:04 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 07:49:04 +0000
X-Forwarded-Encrypted: i=1; AJvYcCXnf2QC+02rlkEjR0rrGj0K5upxKpRcskWFwrTyn1CmRhxAKNw6w4oL7bhuD7UqXT2S3BANSryZU6wADu/w2l/OpyUf5Rqzt/XdUunJ0uO+ZBQcD9AqJbYNbG729JtdnmpA3dWvun3Vkeh9MbYXAJCAkcXzWSZKrzw9LjDbeP7U2QC0eB1Q
X-Gm-Message-State: AOJu0Yz+5BPdxNqzbrzoYRTJQDHTcEXgNDeB6GFgWPtfCrh5LIUb+ohi
	aO3ZoI/yZkgHXrhObp/8lJz1bVt80hoipkarWVxYTKkkdnP5UIDxUgOowXysd1AuN3cn/BSdLaC
	u+TVmk8VcTDGUFZaL3DLSH7glJLE=
X-Google-Smtp-Source: AGHT+IGR98E99snR8ZacqYE2MRI7s2T9kHEQlqHtKp++4lrT+QpRw4p7pySWBxN94XoQANb7LhIhLc6mxAL7idYr1h4=
X-Received: by 2002:a17:907:7d8e:b0:a4d:f902:f505 with SMTP id
 oz14-20020a1709077d8e00b00a4df902f505mr2602102ejc.43.1711525740287; Wed, 27
 Mar 2024 00:49:00 -0700 (PDT)
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud> <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud> <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-whoever-spotter-1fe7ace35428@wendy> <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-granite-snipping-7c8b04480b2e@spud>
In-Reply-To: <20240326-granite-snipping-7c8b04480b2e@spud>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Wed, 27 Mar 2024 15:48:48 +0800
X-Gmail-Original-Message-ID: <CAEr79DVNFh0Zo80J1Cg9ySdhXdiEDMYkCq5Er6bc3sGhUkzGzw@mail.gmail.com>
Message-ID:
 <TY0PR06MB5611AE812B72B349E85118D59E342@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [m9dxMnbIEX0xNd6TIadL0qdt7pIGr+RV]
X-ClientProxiedBy: AM0PR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::40) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DVNFh0Zo80J1Cg9ySdhXdiEDMYkCq5Er6bc3sGhUkzGzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|PUZPR06MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 44384e24-ea6f-4a71-22dd-08dc4e325f8e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U0fBSDQdLZLUmC7RKr7sZanwMZkVDczBuVQO2LoZd4iecA+V3AoBsGHu6s0b5eCzlJ+SaFc/MNaPFNzdS0uwULCpS9PdbiWs/jpywmw4q+lBkUuvhzI5GdXLYcRs2uIyZ2PsP4ZGgJPNhnLsRq+ZvUiTPn3MNPLiDEYyoar52knBU8aE2uYAsJxNEhaZZaQyd1rFRqqKpAC0qzR1nwTqpqcIdoPUIvNj03PSgNpbi1ooAbP/k5BstP0gDJ09CYg29Pukoo2SULmQdOzNE5Rx9m2l0LfnHEgPdF4jKOaPHR0eX/OF7o1E5pVlvzRpvkN+l3xU7G7CZY20tCjV3h+oZIh3jFTSw7qchX024gSBV0wqWNvcyKPlXJvrtF1O+B10rWL8vcQC1q+pmvVmtS4X2nlHgT2P3X4lHSeRsBMaaoFHloMkf7FP2c5dS5w8ieBKeLOU5tJPcyhRTR9AkbxSHizPqbsgM4V0Y5zSWRlwxEf9eVY/W/+s4eo8Dl38Twk+nwu/yP6p5cDtJo7qErGcML+ynyR9SGi+I5rIU/flouGqK4funRRnQ0VtOHPR2KIVEDLyooQEk6zWEdpwsIV3+Pnb4QFtSYyx2k4HbtWWCi2owCyiuXy/lrzL/vzuJbUd8PpHJ36/dhMzYmTEbo7aqYJCwkiOIGat4GwdrM6VD7Q=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFZac2tQTEZhTkV0N0JJRnlHMkpSN3NHaytrNXNidWtBaVUydmcwY1hPVjYz?=
 =?utf-8?B?S3BpOHA3UjFGN0FUWUNkWUE3d0NoT1ZobDloVkVFV3V6bkpuNUd2QTRnWlNm?=
 =?utf-8?B?Zk9INDgyMWVSWmovdHdpRFo4bDJLd3NkZUNYNDdYSGF0WGRNTzQwYmN5YTVm?=
 =?utf-8?B?SmhCTEVpck1qSWFqUEluVjRtOFNRdDNZVzA3NXp5dVVQN3ZYQVdpeVJFbUlV?=
 =?utf-8?B?K3ozQ1EwOTRIcjdYM0FuU3VXTkdpSWh5ODRuWVJabHZjVThDYXJ5QmJHU3lK?=
 =?utf-8?B?c3Q4cTYwSHF6elg5RXhCVFlLSExHMUlVeWNjSHErQzRvUjNhOVBnMzFKRzBs?=
 =?utf-8?B?KzJidFNSV25qUW94Rit0a1NwNU1UdWlJWG9zSzdIdWZMZXpxWGJpQ2VxNmk2?=
 =?utf-8?B?V1YwRXZZS0hJdTY3WnRaVythNHpLK0wxWUNrbERGVG92UFRpUnJPdVE4NnNk?=
 =?utf-8?B?dDVUcE5mTDlmd2NQVzJ3V2JucTdGWlN3VmJyTnVZMGJvZFA1L0swTFdUb3Rq?=
 =?utf-8?B?R0Q5bUtPaHhhYnpGZjJhSzFvZlhJYUlXRjE5c2M4Z0g3R01aclZwWkdkRm1W?=
 =?utf-8?B?SFpDRHlXZkRMMUlXODNtSUE3amNGdXljWGkzcytNQjlrU3R0emNLdFBtS0hl?=
 =?utf-8?B?YWt2VVFOb0N1T3hBWVlkQzAySnF1MFlsN2dGVkhHRHkxRk5USHBZenY5UWFB?=
 =?utf-8?B?SkIxSGxuSG5PREZ2RXdyUXcweit1ZHNYS1VndngvSzdVQitteGF4R3VNSW5m?=
 =?utf-8?B?SXQrYzZVOU9aQ2FQUndhYlJROGwzNFo1Y0Nkc0tkWXV1UHpqOEY4Z2RIWmFZ?=
 =?utf-8?B?ak9BODg2N3czdGVNUG1qTzN5eWI5SUNYZXkvckpjelN3cVVDTzJjWmt1cmxm?=
 =?utf-8?B?ZmJ4Z0R4clM1NHEydnVVOWoveUpZVnFRa1ZEVjF0ZnlrM1c0WW91ajc1M3Q2?=
 =?utf-8?B?WjlhNjh4MmUxT2VDYVEwYkVLL0xXVUp3c2NiOVJVQ0srajZWSkplMFdLbXNj?=
 =?utf-8?B?NDVwakpUWlZoRElleHMxVXFYaUVqK2NvdlZSUjhWVkd1WXQxb0xCYlN5VjhJ?=
 =?utf-8?B?TDdIR3JyS3lsUXpnUktzbWQ2NVh3VEVNcXF1eVlpMVlUQmh4VVIxVVBudDdZ?=
 =?utf-8?B?Tk1kVE91aUd2OVhiRENsVFQwd2dkTHRGTytvT1BkNkdOZFk1dThWbFNZSjlE?=
 =?utf-8?B?dUIza2dEUFhubm9oYkxyQ3lENlV6eUVTTzRrOU8xL1J1ZHVleUNzc3Bqb1BE?=
 =?utf-8?B?SWFOZ2dvSlRrbGhqNXg3V0x6OVpqem9IV0ROb2o5M09YT1FSTkNwOVZiU0VP?=
 =?utf-8?B?MWFDcXY1S2dGWGo1TDVyYThuOFRNMjZRdm5pcU1tekx6cE9qTWM5SjYwNU93?=
 =?utf-8?B?ZFVzRnZBN3diam5JVTRmV1BkbjNNbFJNU1Erb0V1amhnL3UzU1BHcUxpYmtD?=
 =?utf-8?B?VEdZVmNuU3JpMWJpaFdWK0dOMFo3d3huQ0dUdnlONGd6ZUE0ODJScVhuVTdl?=
 =?utf-8?B?R01iZVZFV1QvL1A0VTZUejFXNGJpUXlHSVplejR6bWlSSUNSU0hLenpkK2lW?=
 =?utf-8?B?cHovbGl6YW9wN2ZxTUpXTGtUNmRnOWVlbGRMOURCc1c1dUllTGtZaUdiUGlj?=
 =?utf-8?B?ZUlFdUtNNlFQZ29lNnFBNzNLU3FRMVZYcitpQ3lZYk5iWmV1blkxL0lKZWkw?=
 =?utf-8?Q?Q7TMSy0NZ2pMKKPBEfEg?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44384e24-ea6f-4a71-22dd-08dc4e325f8e
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 07:49:04.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6125

Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Mar 26, 2024 at 06:40:28PM +0800, Allen Lin wrote:
> > Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2024=E5=B9=B43=E6=
=9C=8826=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:48=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > >
> > > On Tue, Mar 26, 2024 at 01:46:56PM +0800, Allen Lin wrote:
> > > > Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > > > > > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > > > > > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > > > > > > Add the HX83102j touchscreen device tree bindings documents=
.
> > > > > > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > > > > > It's power sequence should be bound with a lcm driver, thus=
 it
> > > > > > > > needs to be a panel follower. Others are the same as normal=
 SPI
> > > > > > > > touchscreen controller.
> > > > > > > >
> > > > > > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > > > > > >
> > > > > > > note to self/Krzysztof/Rob:
> > > > > > > There was a previous attempt at this kind of device. This ver=
sion looks
> > > > > > > better but might be incomplete given there's a bunch more pro=
perties in
> > > > > > > that patchset:
> > > > > > > https://lore.kernel.org/all/20231017091900.801989-1-tylor_yan=
g@himax.corp-partner.google.com/
> > > > > >
> > > > > > Those don't look like properties we want coming back.
> > > > >
> > > > > Oh, I don't want most of them coming back either. There are some
> > > > > supplies in there though that I think we would like to come back,=
 no?
> > > > > Maybe this particular device doesn't have any supplies, but that =
doesn't
> > > > > really seem credible.
> > > >
> > > > We will use Firmware-name in Device Tree.
> > >
> > > > For power supply settings, because there may be other device using
> > > > same regulator.
> > >
> > > If there are other devices using the same regulator is it more
> > > important that you document it so that it doesn't get disabled by the
> > > other users.
> > >
> > > > We plan to define it as an optional property for user to control in
> > > > next release.
> > >
> > > I don't see how the regulator would not be required, the device doesn=
't
> > > function without power.
> > >
> > > Thanks,
> > > Conor.
> >
> > I will set power supply as required.
> > The description of power supply as below,
> >
> > properties:
> >   vccd-supply:
> >     description: A phandle for the regualtor supplying IO power. Should=
 be own
> >                  by TPIC only.
>
> What does "owned by TPIC" only mean? Why would the vccd supply not be
> allowed to be shared with another device?
>
> > This works for TP digital IO only, main power is
> >                  given by display part VSP/VSN power source which is co=
ntrolled
> >                  by lcm driver.
>
> What drivers control things doesn't really matter here, we're just
> describing the hardware. If there's another supply to the controller,
> then document it too please.
>

Below is IC power sequence introduction.
https://github.com/HimaxSoftware/Doc/tree/main/Himax_Chipset_Power_Sequence

TDDI IC, which means Touch and Display Driver is integrated in one IC,
So some power supplies will be controlled by Display driver.

In yaml Document, can we just list power supplies controlled by touch drive=
r?

Thanks,
Allen

