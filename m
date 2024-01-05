Return-Path: <linux-kernel+bounces-17768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE382524F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FDA1F23AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBD1250F4;
	Fri,  5 Jan 2024 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="ahcWSTWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21252C691;
	Fri,  5 Jan 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704451469; x=1705056269; i=linosanfilippo@gmx.de;
	bh=VlmhTpPZ6/DLSBoKQjVBM78xTc7tFS9bvVMLHu/gujI=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:
	 In-Reply-To;
	b=ahcWSTWB4+Gg+VaPKht8owHL9Z/qgtVveN2C1ldaiQP9uyj36CNIkFErlWQY7oC7
	 BSmHlKl0M1A21a3lxdPce5TyHsz5q9qtnO9z2fgbCMS5fbPyfLQzYDmeGbNW04I1X
	 ZwkwAY/XdxpzHf8z0Gcxl/aowCcRrJwKYgFtkEUWJFMj8IUCHv7p16/nIEPx2uDAn
	 DXAyt5ztSleSWT2FsjIbJcHjVLYN1Ougr/FDMW6W/JLicIbhsjcEcTneU9ou5aGrQ
	 lPlndjPJ1xKqc0NNFSOlhTlLx7a8tsRH06AFI45spBvzqu8it0Dfb/JH/tAib0i1r
	 oZ1G0LJHh5/R1pOi8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.15.98]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1quebv0qaQ-00inRR; Fri, 05
 Jan 2024 11:44:29 +0100
Subject: Re: [PATCH v7 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 hugo@hugovil.com, m.brock@vanmierlo.com, LKML
 <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>,
 Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
 stable@vger.kernel.org
References: <20240103061818.564-1-l.sanfilippo@kunbus.com>
 <20240103061818.564-2-l.sanfilippo@kunbus.com>
 <485fbc21-d099-d316-2146-36fef116f894@linux.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <ddf185b0-1a6e-cace-7dbe-ea48348491d0@gmx.de>
Date: Fri, 5 Jan 2024 11:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <485fbc21-d099-d316-2146-36fef116f894@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cON+uAom9WLCxa7nEVAwB+HD1igo5z8st1aDwqQcTSX3daYFnri
 hcTsI0tzVWPYUiv/tFud7Foma2G9Utb4yIvQdF8bVLhL22aTEUn9fh++MeWPh+jHhLuQUEe
 Weiry39N7AuamQ3Qjim6UowZxSs8MIveQkh/mUE76kvcC40tf+VKFXnNNb3O9px+PcBWoIC
 jmyGqgUxF0hsAqkETFxAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YniKicCEILw=;hNp7S56051Ato2JeMjKo75QDS48
 y05JINy3OJGxV2pazbW0V5XPvlOh2Ft5WSQkDChWkHPrst9YDAOXiMDEz4wDOqmkj7YIewEtd
 GEqRZQR/AaJ+UL+dg5woKXps8jQbxGrwMPaXjsgam8K8k3i4D5vC0/OYhkJwADi1HPImgV/tr
 f982zggOdB9fAcMtACjH08CHHnNLfOsidjKl7cKmlWHvfrWHWml93g4aJecTiOqdvLY4aRw+t
 VXdtzN7XxtoJFST+/SfPgr6nr2Z9kGeOuWq9FawMtpRILRXjYHOTzb8ikcU5Ski92QXoyDi7L
 vyYjooDcLJao+XBZyCd2ptoo/Snp3woTxwnAecz0ypHFZf/qU6WOpKZRwc8AwLKO6PJajEvAA
 I2Ppmn8DWHUGLsv/UzaUYaWVF2lrc2N4W4wLlh0WDscD0P8oRlOS1OwmQU/UTzzuoFJoENAiN
 J0RGczLifvWnwkagERiJ06RVk16uRGsfFEujHRfBiFM9eri8mxJXJfYLZEtnzYogAxH0v0r1S
 RhsWSa6llRr/quTguqD7CIhBzWE+k2TFHZ6cce6ArHuMp771m+Ti9boDhNewLGz/Elt4k6Lkh
 GotJ8J68zUcLfDl4AYTwYVYmUcI4cqLv9v4H81ZeqnMBZ4cP7lB3Htk+FR1UA84e94f6LGNbK
 cUNsEvlbvmKEkCbhHccKSD0OnKgPxxaCI0F8RkYPZ6vda0uzZK756jKFsYn8rt8g/VXnNpPwH
 VHYiaDjqFIaj8eWMvhzsc0aHYbnCRouOCQGXYft0XNTv3ZrluY7KfdvO4pVER9BQNpDcVawwp
 6mdxMOb9J+KDi1TeGk8J7+Pufeb5pw0OYSRuR+2p89bN9V9lj9bmf0wApwdS+MdtMMqbJ15EB
 XFL1ETteq7nLOdn9ww4ry307Q7uWdjEhRHYcUvmoVrGKVK2d9xqrBzHOn99fX9y+zNNZ/MAXu
 EdfQv4Huxk3RiZE/QLeT5U0LN10=

On 03.01.24 at 12:10, Ilpo J=C3=A4rvinen wrote:
> On Wed, 3 Jan 2024, Lino Sanfilippo wrote:
>

>> Also with commit c54d48543689 ("serial: stm32: Add support for rs485
>> RX_DURING_TX output GPIO") the SER_RS485_RX_DURING_TX flag is only set =
if a
>> rx-during-tx GPIO is _not_ available, which is wrong. Fix this, too.
>
> This doesn't explain why it's wrong and I could figure it out myself
> either.
>

Ugh, you are right. I confused some things here. This part of the patch is=
 completely
wrong and the concerning code was correct as it was before. I will correct=
 this patch
for v8.


Thanks,
Lino

