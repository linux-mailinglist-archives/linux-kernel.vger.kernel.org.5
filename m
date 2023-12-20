Return-Path: <linux-kernel+bounces-6272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0A819695
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2DD1C25100
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4981F606;
	Wed, 20 Dec 2023 01:55:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B821F5E7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 0A7C224DBFD;
	Wed, 20 Dec 2023 09:55:29 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:55:28 +0800
Received: from [192.168.151.176] (172.16.6.8) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 20 Dec
 2023 09:55:27 +0800
Message-ID: <2cfc670f-56ad-4453-82f3-d72dcfd05840@starfivetech.com>
Date: Wed, 20 Dec 2023 09:55:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 resend 3/6] i3c: add actual_len in i3c_priv_xfer
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, <miquel.raynal@bootlin.com>
CC: <alexandre.belloni@bootlin.com>, <conor.culhane@silvaco.com>,
	<imx@lists.linux.dev>, <joe@perches.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <zbigniew.lukwinski@linux.intel.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
 <20231201222532.2431484-4-Frank.Li@nxp.com>
From: Joshua Yeong <joshua.yeong@starfivetech.com>
In-Reply-To: <20231201222532.2431484-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: EXCAS081.cuchost.com (172.16.6.41) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable


On 02/12/2023 6:25 AM, Frank Li wrote:
> In MIPI I3C Specification:
>
> "Ninth Bit of SDR Target Returned (Read) Data as End-of-Data: In I2C, t=
he
> ninth Data bit from Target to Controller is an ACK by the Controller. B=
y
> contrast, in I3C this bit allows the Target to end a Read, and allows t=
he
> Controller to Abort a Read. In SDR terms, the ninth bit of Read data is
> referred to as the T-Bit (for =E2=80=98Transition=E2=80=99)"
>
> I3C allow devices early terminate data transfer. So need "actual_len" f=
ield
> to indicate how much get by i3c_priv_xfer.
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>
> Notes:
>      change from v4 to v5
>      - Add Miquel review tag
>
>   include/linux/i3c/device.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index 90fa83464f003..ef6217da8253b 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -54,6 +54,7 @@ enum i3c_hdr_mode {
>    * struct i3c_priv_xfer - I3C SDR private transfer
>    * @rnw: encodes the transfer direction. true for a read, false for a=
 write
>    * @len: transfer length in bytes of the transfer
> + * @actual_len: actual length in bytes are transferred by the controll=
er
>    * @data: input/output buffer
>    * @data.in: input buffer. Must point to a DMA-able buffer
>    * @data.out: output buffer. Must point to a DMA-able buffer
> @@ -62,6 +63,7 @@ enum i3c_hdr_mode {
>   struct i3c_priv_xfer {
>   	u8 rnw;
>   	u16 len;
What happens if I3C device does not terminate the T-Bit because it=20
expects extra length from master?
> +	u16 actual_len;
>   	union {
>   		void *in;
>   		const void *out;

