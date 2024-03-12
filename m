Return-Path: <linux-kernel+bounces-100251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE8879407
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562771C22CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D057A129;
	Tue, 12 Mar 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="U4PW3S8p"
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A0BA28
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246013; cv=none; b=gtDM62jdKl9KdCq+bQW3UdjQeuRCN3+In+idYt/7WwRaIYSNVXjZ/yPh9jmJSNfRrTP8bPRT3vQcngpSoGb0CWv71iFs6Kf/muAFaYBVFxbVntvP5XnB6RuSS56pl4UWOsyG2yJf2Yf7xYRGRN0PkqBSSQon1nKRu2j7mUwM3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246013; c=relaxed/simple;
	bh=gLUzS3eTYC0hPJ7c2hZY9UrcLQR0LQn42c6zRsApbeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type:Content-Disposition; b=r8tjnX3eefGABux11/HEFoHHtHqhmR+I1sjmM5IYnpBgvf9Q7DUGFcgKX5sRT8HjEwo8giEZ1ZjHrIK6jvYnEspkES2qODFYaIhLmz8R4OZtpcjRfufvBqGGoiDDMXmw2+L5V1LehrKyxij/YEcYPmd0TXEPj3II3k8VBLVHVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=U4PW3S8p; arc=none smtp.client-ip=194.104.111.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1710246009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2olypZqgezlh5lmeLhwphDOh9NXAmWQKlgglX9j1Heo=;
	b=U4PW3S8p0Crc2u5VYsmobCfswui3ReAoX9AzILbSINjnrU250bFFQTvHo1Qqqc2NQPoH8W
	i2yXjGtWRgc2p6HQ7ZQ47Ms2Z/V58qYZxtzIslBViunxtz8zp7dTixTsylNkJwoFMN6cZ1
	pLQT4+VHkpYEKdBrZg93K2bMpTv8X+c=
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17012010.outbound.protection.outlook.com
 [40.93.85.10]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-63-a0C1h2JtNcCRP0RnDkg2Fw-1; Tue, 12 Mar 2024 13:13:44 +0100
X-MC-Unique: a0C1h2JtNcCRP0RnDkg2Fw-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by GV0P278MB1106.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 12:13:42 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2128:374f:6717:b13a]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2128:374f:6717:b13a%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 12:13:42 +0000
Date: Tue, 12 Mar 2024 13:13:40 +0100
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH v1] ASoC: wm8904: enable fll with fixed mclk
Message-ID: <ZfBG9IMFEjjIdgdi@toradex.com>
References: <20240308155831.141229-1-andrejs.cainikovs@gmail.com>
 <Ze7smWSeoCVIcxIo@ediswmail9.ad.cirrus.com>
In-Reply-To: <Ze7smWSeoCVIcxIo@ediswmail9.ad.cirrus.com>
X-ClientProxiedBy: ZR0P278CA0119.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::16) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|GV0P278MB1106:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cdae49-b22c-4ebd-a39d-08dc428ddbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: kAy0AVjmZi+vkW+xmAGPHMdgqUPM+i5zFTidLanrURoJHVX7fMH59bFHtoBk59pyRPNc5lLVhG7zBHno6XsvG13gg6DHT5tHtOWwB+O+Awurtxruj3o+UcxPSi+i6SKb9WS1n+XS4oRiPrUAKSRI7q6IsbJM/w01mKUVwyCclubdD/K6/5i62XciBwv6Og+HWSbuYgfowhuDdKiX1rRnTPwBfeMbhMcURksuoy87Wx4Rt3KacHuWFxb6teWWiEwBlMEmhlxT3kAnind+JmqxYdvmMO7PT49nwTZj7ZO+hJAoi7AQY990Pks5YM4RGC7Qetm3ABWOScjW+JEjCYYOYd3iMX5cqtqVYVwTi4NWrjuFyBrAFRPMoNKj8j8HZTHo9fuyG02STOkPW3dLt31aUOvufWiHx3OBEaA/86HrepIBh3eY2BLTxvGfdc0ZNlppispMVXtCVLyqQSAwayUgxNdgicB+C/D94aDTgF6oD0Ca4TXUSchaDVzEzvVnLUL1wx/UTuyU7Ns2OCZwK+tgQ2+dBWLvT1Ur5GQ9owA6HiHJvhMxzTdzFKhWaU35aFV+01thSgW/IDvfeepaLlIwKTomXbcm10iytQeAgBqPRdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNCi58KEAFhGIfjXIkdbF6/gjGJ+OhugXq+2B/qP4znWpm7VnUtUqt9rsx8k?=
 =?us-ascii?Q?brTBALR+ZEZ9oWnYrK5PcvXotJr8jBwl5t/PXv+EKfBrMG53XQr7bvuzrdfs?=
 =?us-ascii?Q?hE5iXvyL1Bqc3zX4lciLpu9UeMm6RjFjxx9wIgpxOgezXQX6YBJk9bYlweNr?=
 =?us-ascii?Q?rVsLPmO10Gj4Vl6DqHlyrCvURUrzmzL8/mz1dhaMqDSVVkKSxM/Aj2RiYVJi?=
 =?us-ascii?Q?KXESBPXYgPyqpRNeQR/Xoqoum/tfE9CaezHF51JjnhBYVCjD8oBrQplqzt+h?=
 =?us-ascii?Q?LX6V/YM/n071aTasLVrU7H9hqFk9V1hVYQwx8gvNA99KdvyWhNOLgXMOVlW4?=
 =?us-ascii?Q?pGvYto132a2bi2bxB9+eih0ta5Yfer/701VFMc4JN9/278o/8iId3JxmtTWY?=
 =?us-ascii?Q?5m7/Y2GYReOVcHo3Cpn5rQBNNVLpq+H9x1VAJ1AHKvu9DVudOFX6EauCyyoz?=
 =?us-ascii?Q?+iYgLupUydKNdieV14Ct7ois3qIvgNtD5IBjZnfiqZYrf73MbmF/OvtK87k3?=
 =?us-ascii?Q?pgp9sw9iqimCOXXHf6NmK6RldJgQiqWJKRmAQRIO01i9141ILH7/RP0k6JRs?=
 =?us-ascii?Q?HKepdaNEztW/gsw5HJjtyia39wSgwUP7fM6SaV74TV6xYw5rpf1UuhMnc1mz?=
 =?us-ascii?Q?GF6jiE2Hhm+VRlBbPUcES5dIYrsadj3iL/wZ9LLcIAoU2k99hdL+i752h7cF?=
 =?us-ascii?Q?SBkIU+lMoT5/Yo7Ytx8r+h5ncEMXMD+lxUWkSqOhb7hDfQRQ8Qi6hBNwvFWl?=
 =?us-ascii?Q?0EaYyYr52r7/1peQPFegvUQTRjqNGwsn5JA+sqvuCnNqOQzNFdnQcHYi3FsU?=
 =?us-ascii?Q?Kz5/IhyoEO0U/DwWnYrEZubvYi3EDu4NMRk2qdZdG0AZ0Um4LzgqKZWR4zGR?=
 =?us-ascii?Q?2wj6nnBQzr+pAQsL5uj/17hYGTxgZHrrng7eaXGI3JkV0FXf7uMv+WGzFP5S?=
 =?us-ascii?Q?KMsAwyhX3YJl6IdudnaZ66H0OCg06aeZnB7PngdSzHy9bH0KvufdPcbaQBqb?=
 =?us-ascii?Q?rz1BIalQNWkL6mQPAo7FrunpIAlyjE45yuVofTdrh65WCT0VC/CIt3kO01t/?=
 =?us-ascii?Q?ROx7oppFWPp3LdzCA4EPUs52pJIdRE/OOwhbqfUeXmpT5cgUk+sZsdgJunpR?=
 =?us-ascii?Q?7xjkAEJ2zBCKcCwwZNPkvv4WdIt7DpPKxMXjYeaiwg1v3nB87Bqw00iTPF9J?=
 =?us-ascii?Q?Z07NsjPs9I1ezxuM52kTTbug/Ma4/mkIKkovEkEadosarMhUoxWWRFTPZV1N?=
 =?us-ascii?Q?YiZGIu5zbd+kKwO1YXtUapDbyS8njCw7mcIAlrtYz3eytGDeBcWhBVwuE+JA?=
 =?us-ascii?Q?BV4ZOWAomhWnWaV2HgNMBBtm/vTiba/kFthbDq+zS9q7jwbLYF6SAyU2pVm3?=
 =?us-ascii?Q?PtwgrrGz7+yOwffS+c7VMxmYig3HRU7JlPChj3/WvOGzTCjFkgR7FO5ZQX26?=
 =?us-ascii?Q?hvt583cZsn7nhGuz1xPRGT5uDfUaU/11IZ2SqmKigPB8ITd8qs9e3tIyht6J?=
 =?us-ascii?Q?dyIH1hBscy2DLMa6fdJuGWxgJuREc8GKTCvB8HTAcf7VUZKj/AMu5NAg+Nzq?=
 =?us-ascii?Q?VlKww+0HF7o7RNgPwbJc9BGxwuLOd8Pr5fiqN7S+3os7qPlWL3aczteBk1c1?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cdae49-b22c-4ebd-a39d-08dc428ddbe7
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 12:13:42.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZJ6kxyMBZtW3gNSg9Ttq/iyfssdd5g9V1DjjZwdzBVK2qXqQQ8LVcsCWUjsWIofaX7OUbPcWQV9p2tMpEsctfwmk/xXvjVnA9Hw4dzqeAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1106
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:35:53AM +0000, Charles Keepax wrote:
> On Fri, Mar 08, 2024 at 04:58:31PM +0100, Andrejs Cainikovs wrote:
> > From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> >=20
> > Dear all,
> >=20
> > This is an attempt to change wm8904 for a scenario when reference clock
> > supposed to be fixed to a particular frequency, but is not configured a=
s
> > a fixed-clock. While this change is working fine, I'm struggling to
> > finalize it, not being able to find a proper solution of adding a check
> > whether we want to use fixed MCLK with codec's FLL or not. I could, of
> > course, introduce a new device tree property, but do not feel this woul=
d
> > be a proper way forward. Hence, I'm sending out this RFC patch to gathe=
r
> > your valuable feedback.
> >=20
> > DUT: Dahlia carrier board with Verdin TI AM62 SOM.
> > Audio card configuration can be found in ti/k3-am62-verdin-dahlia.dtsi.
>=20
> At some point one really starts to question if this is really a
> "simple card" any more.
>=20
> > On systems with a fixed reference clock output rate it
> > is impossible to use this clock for all audio frequencies.
> >=20
> > Following is an example of playing a 44100Hz audio on a system
> > with a fixed 25MHz reference clock applied to wm8904 codec,
> > in combination with simple-audio-card without mclk-fs:
> >=20
> > [   27.013564] wm8904 1-001a: Target BCLK is 1411200Hz
> > [   27.013601] wm8904 1-001a: Using 25000000Hz MCLK
> > [   27.013611] wm8904 1-001a: CLK_SYS is 12500000Hz
> > [   27.013654] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> > [   27.013663] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> > [   27.013671] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCL=
K
> > [   27.013680] wm8904 1-001a: LRCLK_RATE is 35
> >=20
> > This leads to a distorted sound and this configuration is unusable.
> >=20
> > On the other hand, configuring simple-audio-card with mclk-fs will
> > force the system to change MCLK frequency, which supposed to be fixed.
> >=20
> > This change forces to use wm8904 FLL while keeping SoC's MCLK
> > frequency intact:
> >=20
> > [  234.108149] wm8904 1-001a: Target BCLK is 1411200Hz
> > [  234.108304] wm8904 1-001a: Using 0Hz FLL clock
> > [  234.108722] wm8904 1-001a: FLL configured for 25000000Hz->1411200Hz
> > [  234.108794] wm8904 1-001a: CLK_SYS is 1411200Hz
> > [  234.108835] wm8904 1-001a: Selected CLK_SYS_RATIO of 64
> > [  234.108875] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> > [  234.108913] wm8904 1-001a: Selected BCLK_DIV of 10 for 1411200Hz BCL=
K
> > [  234.108955] wm8904 1-001a: LRCLK_RATE is 32
> >=20

Charles,

With or without mclk-fs wm8904_set_sysclk() is called always during probe,
with following parameters:

clk_id =3D 0
dir =3D 0
freq =3D 25000000
mclk_freq =3D 25000000

When mclk-fs is set, wm8904_set_sysclk() is also called before each
playback [1]. In case of 44.1kHz:

clk_id =3D 0
dir =3D 0
freq =3D 11289600
mclk_freq =3D 11235955

In both scenarios, clk_id is always WM8904_CLK_AUTO.

[1]: https://elixir.bootlin.com/linux/latest/source/sound/soc/generic/simpl=
e-card-utils.c#L441

Best regards,
Andrejs

> Hmm... the driver already provides an option to automatically
> configure the clock. Is the issue here that in your fail case the
> machine driver never calls wm8904_set_sysclk? Or if it does call
> it, when and what parameters is it passing?
>=20
> Thanks,
> Charles


