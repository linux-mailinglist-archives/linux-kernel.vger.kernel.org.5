Return-Path: <linux-kernel+bounces-118829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090B88BFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6012CB248D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EAB4C83;
	Tue, 26 Mar 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="n11ToqI+"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2105.outbound.protection.outlook.com [40.92.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E612B87;
	Tue, 26 Mar 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450086; cv=fail; b=G1QZQl05E9QNsxQJ10H7rI0iblTSVpr1iabl/QMUBWvLOHP7BQ80BQhxbaxahwm/F+IZdz7NCsQERnsVMswMy9F1wGT21L+aE8v69bZY5TI2j7v6rzEUG9+yvDt3XhXlGy4hJ0LVudzk0HZbTL5/68C1mSyrBYdRuPM2EctCQW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450086; c=relaxed/simple;
	bh=tvbkpu0j+UqO9z3dlWPAKtRiNUn8JIJ4JlI5DAS4Pl8=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=Bp+CfV0WciYHgUCbnzd2dDdEOQJqDC+AB+cXjRk6MtIiqHDQ77smC+GEYwQRDINZbRz8XuLNxOXyreKx8MxSrscZihnomARA2itD86JrzN3M0vMqICU48APkExwSuV8l5qdcRZlC95h5n5WCjRxi/8Cdlz3tn7Xw6x+LJsu+Obc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=n11ToqI+; arc=fail smtp.client-ip=40.92.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlf2iOTV/I5Kpf4tp5Or4JKn2jItE7dTKDCW17Cdel6atpodi13RlY0cEZGZLtPa2CgS5SVyNGVSLJYDvU93SDh/GWuCLitACbQIyhxmWwfwWhv8wq5E+E3W3dUz37Nh0TPnrCRbXgcraUyfpLZeB86LRXLXvuAsF8/F/f+iHHz/IXNIqikUjfAY49+63JA94XqZovp8LjqwvDZnx8N9TGBnxiFlEJgX+taRgwsLWvDMMhlX0fQ2Tqdl7iGzZ0LQx0ZtbO79SK18vCCue6q8uybuV+TM+nN7uUXc8QSb/L/enAaU6goyPani1BpzjOnwBnjrjeDHxvEvrsCNhR8QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANd7lW1p3WcQZLLW5h0eTHA3WPerP8VV1Gp7MC+kXSs=;
 b=hJ0qBsDjbNaTdGXuVdCEjN7PVp15jjMkEevqLhK8GoP25KfnWvabryrU+oMR3/G3TSnnioGl3qoIXftI6ByVHA7mB1Ouxi6woE+ZcJEI1nu4vwuFSugMMP09wdSxqH4ZJiiwukvYWb8xQSaAHb61pgWqxaq7kMwJLeWEIyzZwSd1OLENKA6md93X31hc3PHz5FM1Ke/qZbNd8OnaBDPKoj6xmv+MFFT/xKycu+oB2EBrpmDpDCBPq5Af3Qz6Tn0w0LtIfxyh3rin5jaRHXRy0A7sf78VhsNIU3OHg8flQr56wCMdZmVhky6bIg6QPwFaH2STqmniL6aqIKh1Cze8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANd7lW1p3WcQZLLW5h0eTHA3WPerP8VV1Gp7MC+kXSs=;
 b=n11ToqI+mL4ApDPaNOt/PP0wldG0jD0Nyz8d7mlRUP+p4kv3kCfL1KDCRrRUzuAqBZ5/tw08BQI14kzlNJfN+OV77RNxrejS6Pe5Cmajsu643VW8TPHOv7r7OgXlaXtAc+4zNc3LSezPYQe7AFn7BPvglBPhMkfq0jPThiyRtwyfszQ3moFXQVKos7Ajq7MB+S4PAa8OilLzVkD2pc7BVC+duE/RpxweYoU+VCRH3plBrMccYL0eTKuEn9mHqIZSnEdrcrGx1XYA1XpdTtONh6jN51oM46sEJG49usy8vBc9YqCGRuCaKt8ATl9Gu4oiXXoQT/ACxMAygi/OqxuE+Q==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by KL1PR06MB6986.apcprd06.prod.outlook.com (2603:1096:820:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 10:48:01 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:48:01 +0000
X-Forwarded-Encrypted: i=1; AJvYcCWqyH5gFpDdnPPB4R5zwv+iRLI683eTRPzasgu1bvHSh2Ik99QfQaf/SrJpiGObAg/JLJtsOreyMQlIdbEPLYzjH1oHXarcWhh0LPdLKTAv5w2f5th5gVEdySKfkOxtkKwj6nIAORS4UMt0ZhG/+RMNwijOMlqgqLmTXCizf0So5CuOacoD
X-Gm-Message-State: AOJu0YyILI60bZMedxltgOUH/oIuLoH+GlDYSXizbNyZAxPO0lOvOe9p
	ZPo1Sbh/Cn6RGJhr8kKDLRLoG6bDtw5Ff8tvH8XgH/NwVkMJdDrWRNK4dL/58mxKieg1VpbPxG5
	3uKPHLLJeskJMIqadLScvxtl59PM=
X-Google-Smtp-Source: AGHT+IEzBApxx5yI3mM5Vu3r9F2NgawJXuZixR7QdwfWMvlMp6jTIf7XpbmwxlZqR4f8gQBmMtbUNTY3atqZCg9UmJ0=
X-Received: by 2002:a17:907:a0a:b0:a47:52e7:1068 with SMTP id
 bb10-20020a1709070a0a00b00a4752e71068mr4757726ejc.52.1711449640030; Tue, 26
 Mar 2024 03:40:40 -0700 (PDT)
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud> <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud> <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-whoever-spotter-1fe7ace35428@wendy>
In-Reply-To: <20240326-whoever-spotter-1fe7ace35428@wendy>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Tue, 26 Mar 2024 18:40:28 +0800
X-Gmail-Original-Message-ID: <CAEr79DU7EF7F5aJi6fLRip5HZ7V82Fva-Z4789A6rWq3e6F0Hg@mail.gmail.com>
Message-ID:
 <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, dmitry.torokhov@gmail.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [4mOVz6y+ODafbP/kX8pevhBiofeCWs3c]
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DU7EF7F5aJi6fLRip5HZ7V82Fva-Z4789A6rWq3e6F0Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|KL1PR06MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 9100a42e-cbc4-49a0-c3ef-08dc4d8234d9
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd9HkcCcDjRjCdtpMAlt6939v3oEdKjrGaIXPV01swwrZUllK1sIiUz02lW2M3dahsaLlUUQ6wEZBV0hgirFOYz8ev0hx4XE8jhPHYty3cwoVwLP7p1/7/45SoSHsJCrd4llkUO7c7VKGBrVKKcJlcSF8mq/Biz71FsiEEw1jyN9gNnYuvFLmT7Ud7iv6nJqf14V9/mcipD3Rtw0GZVWBEY9a3rZVFSx3LNVUSt6BAW8ZXgdvk1oBXBMesh4q3QiWdZlZzL1pI5dkjOH+dyz5eD114brC4csj5NkwXMpekiKyKl3mlDFa9bdKNj0WREUBSuTFjJJLhT3J1KM+5Baho7mv4iItzWJB4rQPL3vZxDvuiLtAOWEVBlzZqvnaoeLgWgYZU+OkksIjMhkUv5AEpFWQ9SI7zR3er5dtbeVfoLA+a6bnOBHqS8eTZF06ZscpH3I5lcduIkYx3LKyQtutxLIhMfGjJw/LdR0Q7ZQRlNnOq0gqhubHQOqtoMIXbQfxjcDfkpt+u2HwmldQtjqw2Y9e5AWT/D8KaetmUu00G5lNWKztiVvsHrgXIsm+ZMuGNdQqj8Sm+Lwy5sQbi5XoaeaBQxMrhR4XCn1wGo7thxo/mOkhTImNIrIOByr63UH2NX5+R5bZys8nGXl9nblkP+JBljdUXwgSJDl15yLjgl8cBrWt/SS6Wuv6hYjGcerxZpjT1uOHWRpTnxFVUkzEB4DVsh2c4MHRZ/HvRh0wNEYM7lqkVzLREq3J7/HO4QJZAAFS6cM87Yd6J7/gxkAVcyPasfpTCcXsDND8xKFtuOX8g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mQVCtaertngBXt3SlcvYlsEWyK3EJJs7CQcTUEPAvrP2I+cSkt408sNclEeZ736CZ+ytulk3A9ezzrFS/hMQbkJbuAtie7XTY6W6dH3qN95T3m97wJw1DisOSfhzXXgxN1eI2vPeFnIRoAOz2+sR8Lb4gxLVCFddDjSCncasw/aau8qFconmFYNmRcVQJrG7mYeeiAYS28O1lG3knOlKF4MTTTpbyv45i5rtvsev7dx1v0trzHwQoIQPiSW8omjtcEpSMyafw4eKD0CycwiFy//N6M2IqppUjPpbGn/azkQhu8LiLRAve3kM1IlZNldrkXs9KfK2yIdI+gHZFXaLjqU3+Dbqb9FssuhrFyKd8RIRoyKnNJNcDjdhTd87lUjHM0/x0N6HB8z3T9YexNFdB/OJPGTtv+gbqYs07LyO/JeLpe9O7LOyxPPB90c6wl06g/LDwFXIvskHSJ/PyJj//1DuFaAjhGbvaCQSjRziJWYVyIHvXCfhgLlPOz6/UIze4cMfnAAq0S4BTU6bKQ/uQ6GCySvJBXyPn9q/Mi1RujxapzbxaBsXN4rch1rkyTyZtJjzpUMeBsLmC8YmAY92SWvUbHqcUZagx9fhsCcH458jzyq5dWsHJakZ+Bv0Ib24WYnekY8ORHLK/HvLk4Ke3zzhRjOnnd1QGEpgpB1Rj+U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJqbEtPNDhKM01UekdRRWQ2WmdkL0d3TzNCVE1pL09xUjJneHhlZWl5Wndq?=
 =?utf-8?B?a2VHaDd4Z0F0OHB0VGh0QnpRWkZMa05ZRUNRZlQwR0Ryci8ybHRUdnJWQzZL?=
 =?utf-8?B?RU1TQ2RIM1pwdzlIbEg3WHVFbzNIeGxscmpmMlZQL2VjdXBjWVNic3NXZzBD?=
 =?utf-8?B?eDV0Zk9LNWlvOHM4SDZOR1RGOTVXYmFaUS9xTHRpZ3hLKzY3MGRLNmY0TFE4?=
 =?utf-8?B?Q2crdmxNQi9rNTR4YkJNWS85SUpSK04zVXFNSmMzaFpraXo3ZDdLbmZaajRC?=
 =?utf-8?B?dGNXUEI4NC9zY2xFd0FGSE9nSTVnMjc5WUFRbG5BeHBrY2FyUUxERzY5Zisv?=
 =?utf-8?B?T0pNUW10R25BeEkxc01XSTlINVptY3VNVS9jalYxdnNRYyt5WWh6c2M4NG9Q?=
 =?utf-8?B?dlU2N0ptY2kvM0pGeUpuZXZvV3o2bXBoWG9QSGl0U3M3VDVIVUFOcE56YTFY?=
 =?utf-8?B?NWNhZzdXMkx1YStEakdibXpoRHdmRENRbVFRcFoySWpiNVdKWmEzMVJvV1B2?=
 =?utf-8?B?WFVNRTZKYnd2SHQzdENYc2dzeGpUbUxLSnduNFFOSUZ3bkNpZGdJdXZUZDJv?=
 =?utf-8?B?RUJJZ29Tb2ZETmtWcWRhTkx6VW9ZdlA1YTVYYmJuRFZSWHpWRi9TMXZTRVlF?=
 =?utf-8?B?UjNUQ2F1OFdpQlB5SXFTdjJzd3E2YmtpcTZlNTN1WDVQQlZFOENLU3ZZU2FP?=
 =?utf-8?B?b0pueDhQUXV0Y1hlSGtEd2VZZjFZVFVyWitJSExNcExaUElhVm9VVXBlbkxo?=
 =?utf-8?B?V25mWWJwS25mMnlxdWdkSkgvclVZZlBzYUo1dlV2a3ZpOVRYNWFuL2h6Y3JK?=
 =?utf-8?B?L0pDNVJBblRnWWdDK2U5ZkJ6NG9SdmloTGRqL2JSZkRrc0dDMzYzUHo3d2xC?=
 =?utf-8?B?KzBTQmtVcTdhZVdwR2tTRTREL1NiMGh4QkZQVzBQeVBTTEJtYkVESEtnd1A0?=
 =?utf-8?B?OU9lL29XNG1USWpXSDFJaHkwaHk0TFhBaXZrWTBsb1ZZb2kzSTZtU25XMHZk?=
 =?utf-8?B?R29IeUtUcXJRbkk2czJRRy8rLzRkN05VcVRGS1lIcjdzVkhDY0NPTzZ3UTlT?=
 =?utf-8?B?RTU0bGNENUpDYllnbTBBZGdLQ1VhcSszbXMxV2lncjZFWjFWelpZL2lwQUU3?=
 =?utf-8?B?aWxYR1U2VDF3bnpoNUNmRkUvbmN3VythZWhxdmExYm5Fb0lKU0g0RnZuVmNq?=
 =?utf-8?B?cDR6QXNDVGt1ZW1HRWdBUk5jKzRiWCtyUnQ4TWlibUxhOTFqcmVnMDhMUVMr?=
 =?utf-8?B?Y0NJWkc3VUxESUpFaDVEUnpWTm9Db0M3K1dyV29rZ215ZXgrOUl3cWNRZHR6?=
 =?utf-8?B?OFV2RjRzUFhiREdaQjFyL2pjeDAzcGdvbUtQZ1d4RDNhNHppVHEvdHZYays1?=
 =?utf-8?B?UlUyYnFiUE9RNlVFQU4zSHBGTjAyN3lwdGo4ZENXemxBREllREx1ZVY4eUxh?=
 =?utf-8?B?L09YcGdMK3hyWEZLSEl5TFBxYTUvODBnYnN6WHpieFdYOVBjYWN1eXdZcWJN?=
 =?utf-8?B?U0QwTWoxTlBYa3ZIcUNBYjhwYUZqUS9kcCtpalBPSGFkeEhqMmZlMlc0cDRX?=
 =?utf-8?B?WXRRY0xseHRsUXNrNklMZWxJNjhBLzBScjdkNDFOYkZrOVdYdzAzZDMrNWxj?=
 =?utf-8?B?cWpxc3JxbUgxeHM2L0xRb1hqSW91YjNqQUd5SVMyU0JCTUM5RTBXaU9rUnBT?=
 =?utf-8?Q?Qv0nGWIQDjJoksjahLui?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9100a42e-cbc4-49a0-c3ef-08dc4d8234d9
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 10:48:01.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6986

Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2024=E5=B9=B43=E6=9C=88=
26=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:48=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Mar 26, 2024 at 01:46:56PM +0800, Allen Lin wrote:
> > Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > > > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > > > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > > > > Add the HX83102j touchscreen device tree bindings documents.
> > > > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > > > It's power sequence should be bound with a lcm driver, thus it
> > > > > > needs to be a panel follower. Others are the same as normal SPI
> > > > > > touchscreen controller.
> > > > > >
> > > > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > > > >
> > > > > note to self/Krzysztof/Rob:
> > > > > There was a previous attempt at this kind of device. This version=
 looks
> > > > > better but might be incomplete given there's a bunch more propert=
ies in
> > > > > that patchset:
> > > > > https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@hi=
max.corp-partner.google.com/
> > > >
> > > > Those don't look like properties we want coming back.
> > >
> > > Oh, I don't want most of them coming back either. There are some
> > > supplies in there though that I think we would like to come back, no?
> > > Maybe this particular device doesn't have any supplies, but that does=
n't
> > > really seem credible.
> >
> > We will use Firmware-name in Device Tree.
>
> > For power supply settings, because there may be other device using
> > same regulator.
>
> If there are other devices using the same regulator is it more
> important that you document it so that it doesn't get disabled by the
> other users.
>
> > We plan to define it as an optional property for user to control in
> > next release.
>
> I don't see how the regulator would not be required, the device doesn't
> function without power.
>
> Thanks,
> Conor.

I will set power supply as required.
The description of power supply as below,

properties:
  vccd-supply:
    description: A phandle for the regualtor supplying IO power. Should be =
own
                 by TPIC only. This works for TP digital IO only, main powe=
r is
                 given by display part VSP/VSN power source which is contro=
lled
                 by lcm driver.

required:
  - compatible
  - reg
  - interrupts
  - reset-gpios
  - panel
  - vccd-supply

Thanks
Allen

