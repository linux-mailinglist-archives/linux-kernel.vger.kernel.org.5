Return-Path: <linux-kernel+bounces-104271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C787CB82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FC12814FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3823182D4;
	Fri, 15 Mar 2024 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="OYzwDElx"
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF941B5AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.109.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498778; cv=none; b=Wm95ZfiKUZVfOlkqsFDCQ+hauEbdJB0vlIeHqqA5Oi7apw/QgvCltikO4hH8v5zzYgTLhhgzKi1FGU/VL/iJoFSzd4Z/zKTruMmIlKS0U+Ww6Wb6C1Z/0qxyrX104YXJs//9JHqch/UoFx95Gw/tX+ve5ef0n/BiJ3WBjdmLqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498778; c=relaxed/simple;
	bh=Lysa3j/b+7vY91N4LKyJOXIxDfbOuECbYmClh0Al9S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=SDlvBi+9bu4DUoRxfqIblgxQkPyBi1xEASp+av1V8EbtxUFDTpXKPCrMRWvTeWTFaKJwl43ph4NObufO33HtkSzecfg/vHhCM3XdZYEXXKpJ03duGnpgnTt1L7rV62ssiCvxqMyK4ZccXXkwHxTYIH5gvwaT7nAYCsn70RbEYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=OYzwDElx; arc=none smtp.client-ip=194.104.109.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1710498769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lysa3j/b+7vY91N4LKyJOXIxDfbOuECbYmClh0Al9S0=;
	b=OYzwDElxa4zfvDif50B8SbTRujxiNA589vjSCPOA3Z//OoGa1+E+IZK6yKq7GJjDXAgBPj
	kJQdpYR/EJIRMEWQ63NihIX1lhh7hC08PC84YSI07myQJL7bg2GdTTdrttn/qE4ZohBldS
	4Yphx+K73VGwM35KORJ1UdXcvnvQL9U=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17011007.outbound.protection.outlook.com
 [40.93.85.7]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-59-3h8wLJniMfqJbUmeoCreYw-1; Fri, 15 Mar 2024 11:32:47 +0100
X-MC-Unique: 3h8wLJniMfqJbUmeoCreYw-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 10:32:46 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2128:374f:6717:b13a]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2128:374f:6717:b13a%6]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 10:32:46 +0000
Date: Fri, 15 Mar 2024 11:32:43 +0100
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH v1] ASoC: wm8904: enable fll with fixed mclk
Message-ID: <ZfQjywL8r+egtG7V@toradex.com>
References: <20240308155831.141229-1-andrejs.cainikovs@gmail.com>
 <Ze7smWSeoCVIcxIo@ediswmail9.ad.cirrus.com>
 <ZfBG9IMFEjjIdgdi@toradex.com>
 <ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZfBdxrzX3EnPuGOn@ediswmail9.ad.cirrus.com>
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|GV0P278MB0949:EE_
X-MS-Office365-Filtering-Correlation-Id: f12a33e0-46c4-4468-bd79-08dc44db40f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: rnIW+bCH7VY68btCO0TAR8uwjiLdHwORcc93xv3043gHcL2I/g0p0Xn+ZTH/wVK+StzulwhATTKoTdtg1wBlEivdzdleuShFf22Cv1+6XMSXTXoZJv1zXQJapGEH3rKOwdzu/sJyupiYcPxGe4XGw4RbE3eCYPFnXoS3zFGPPn8kJJggCn22aoO6DxrRTVMAGoQRyWSqrzY28xGNdW+1WSkpDh/vLFwwRMvH3G/lJi710KoEcRebBB2tBo07+Yu7tpFUHG7Ly++YB4v7fY9YObZiJt5hHrllulqwWSKb4OPt4uyS08HpUAFsL5tT7xSeGXSVwubAaTk33XWvM0WoWzoxPpp/9vXkGJYR+3CjGHzxVZF+qo5LfAk0tPHVFT46qsCr1ssjKCOmQoQbyTa+ELKI489JCZh/gfqXbGVEGb6gWwEc3XqMQjNRISn+5FdReZJ3RPkVn1F3SCD6QJiTll+9ScqKj+RK2VtCS5JF9h9mN6CHDM6hBZxw3yJt0MKzQfuRxrv8Np3BIElT/GYl9GKGeB0XG2NOuVzlILYAHrmf8uxikhdopakPEnFouiB98TVWWh6EhhWC92JXOK2dULRj6fjhOMiHV8A/tqvH2M7NR4Km+K/aht3sBm83TMRT6kNWZuATHIZOjyQSjXMFcMJeg9vrQ6EOBd9Bqm6xos8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IZZzzHVt3rj3IdpFghaNTxQbB2bCozuF9ra6nAJPDevWrctZSPSl1yMEZBVL?=
 =?us-ascii?Q?Fjq2+vGTUc5DizAzYkEzOcBenFBVwuJZBu5uAyU8PxKeTcWDmA0nB9Sf+tV/?=
 =?us-ascii?Q?5UR9ioaq//80q/s7vceC6i28murIeNB0To5ABkVETQnAar8nHMktwlBmnTPY?=
 =?us-ascii?Q?0rzXzpf8lZH1UkIZImXgd/v/r0k+cw3ZSSWcLfN0G3Mge8TZbHCuf7/IZnGp?=
 =?us-ascii?Q?7d06rwJ3EkTAiWdq0vER6FyFl2bXyXBmxM5lmEbUibl2+E7GWIvvMJSSfrGY?=
 =?us-ascii?Q?UENZTnXH2xuLMswcvivnbOi8+EO5Zy9tM+VXIipIXB6AE43KRQi00y4nXe1O?=
 =?us-ascii?Q?B+569OuZN8ZJ4s4FV29yfUdnMbe/iBkCSwrxL9xImPX9AIT4jbyTk3aIGjdV?=
 =?us-ascii?Q?oeEfFsCArwk1+bEYd8bkkNuAnglTLix6oeBiJOpRaLTw6+iw2XpLfqW+Jgz7?=
 =?us-ascii?Q?jk3lx/iibeb17QK9WOL9zFYPlvR/k6Rd40uht+cuqf5BVtKNUr4yqKqvgy5c?=
 =?us-ascii?Q?EUk46Dhm+oXVbFq8tEplTi8/L3EPOEwAfy8TUMI9eQTg20cX11YBrPFuRQ7n?=
 =?us-ascii?Q?sXmS/zWFb75dqCvPPCYfQW6TJuEFRQIAQbtiMpS6e/efuoNeIOnQ1mk+xEGB?=
 =?us-ascii?Q?zke7N5Uq6IIsVeB8wEFV+Vjjr+ksjH/wS4mieTo9ZFBW61R/V1GETlT9VUqy?=
 =?us-ascii?Q?6obsodVnkFirqnz9KAXv0CBAsPfvWeQJOqgV++7CyGCYAUX51A1ySZ+6EHMO?=
 =?us-ascii?Q?uMMxmXPAiAJTH4s8ifWPbBLwuiHz3dyAmdvz0YM5FrlJyaH8CJ2Wyq5Qo7ix?=
 =?us-ascii?Q?4/8c566rMb3M2dpUY4jcbUivSlHGrOR0zkK/8DfT1XTyxyjnX7990nDDnhlz?=
 =?us-ascii?Q?3MH3ATWbYSoN7Rai/ooqovTHIxkRliX9dUEmhCcNy7ywDfyyxOyd4D44SRW4?=
 =?us-ascii?Q?xMJLUTHFHF6WXVBx48npn3jwyheOHSXmDgTBZFlO5+F307puQpM9rSN3J+aA?=
 =?us-ascii?Q?TgMfPrdu3bbV/X/t9SGruDU+c0jYf+GKkr3W6zf/bGNtwbxWKA8tabSlMlfw?=
 =?us-ascii?Q?GBoFx7aSv4P08q0HStEtIxBkUwaJbSFVkKHcu6p8MkuqeMBQZ6iWR6o9aXsM?=
 =?us-ascii?Q?rTeOI0D0KLPtYf/Z8OrzvZqZMpL+t9BRK1Q54qFkB9x1MIOZeF2h9pEgGZSk?=
 =?us-ascii?Q?uaYIeIBVYfZ9z4n/+lgvzU8Esznn7sivseTdqhgx/61/6ccu+Sn+SEYoekbb?=
 =?us-ascii?Q?RY5LwF4yq1p8nN6kAb0B2PbKQQ6mFyAoxVaMrv7rY5yU+uVDXgtMcsrsDb3J?=
 =?us-ascii?Q?OY1ROqYD01bDJredVO6mjIuk4E5kqTG88lQim7avFlPw33wYh2q96DQvgSf9?=
 =?us-ascii?Q?JTpG9c90weZ1OvAMwnl3twe5Jr6/URMZrpgpTSiwDYR5zYn24IrA5fcky41J?=
 =?us-ascii?Q?h7ILc1M6hfualBnf6EzJENXuJI/KPHsYBy7Ow3UVDogGy9kQgAmU3edtBtN2?=
 =?us-ascii?Q?smIYMJHRkQzwEK0lcr1AKjDirHE10qcxRzUL4ww12ZnFUO5ctkDNF8D14ZM7?=
 =?us-ascii?Q?NgDUR1O9sPFbvS2fmw58+gQA+XnFSYFwpzoNVp3ZXOeAwKHko/O+qpBBZqzk?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12a33e0-46c4-4468-bd79-08dc44db40f7
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:32:45.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W04d1rrPbFNberYzyvWaZuDtiA1ozO7msQRlXWi6PipT9jMibbbJnhJeeomzJNJALZhvDdNxeuLPstsytF8bgeXe4kmvCIjrqjaY4Nf7bP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0949
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 01:51:02PM +0000, Charles Keepax wrote:
> Ah, ok I see what I was missing here. simple_card_utils calls
> clk_set_rate if you specify mclk_fs. Which you don't want in this
> case. My gut reaction is that really the problem here is the machine
> driver doesn't support the clocking setup you have.
>=20
> Having a quick look through the simple card stuff can you remove:
>=20
> =09clocks =3D <&audio_refclk1>;
>=20
> From the machine driver DT stuff, and add mclk-fs. I think that
> should cause the simple card to call the codec dai_set_sysclk
> but without ever touching the audio_refclk. A small change in
> simple_util_parse_clk might also be needed to allow it to return
> without finding a clock. Which feels like a much simpler and less
> scary change.

Thanks for your help, Charles. Your suggestion works as expected.
Btw, there was no need to touch simple_util_parse_clk as it does
allow to return without finding a clock.

Best regards,
Andrejs.

> My only slight reservation is the automatic clocking thing only
> really exists as a hack to support simple card anyway. But overal
> I think it might be better to try to move the direction of travel
> more to adding support for the clocking systems that exist into
> simple-card rather than tweaking the codec driver to work around
> it.
>=20
> Thanks,
> Charles


