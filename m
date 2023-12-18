Return-Path: <linux-kernel+bounces-3317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01480816AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22142827E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE413FF2;
	Mon, 18 Dec 2023 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AtOQGxyU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C39134DF;
	Mon, 18 Dec 2023 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702895008; x=1703499808; i=wahrenst@gmx.net;
	bh=RtQgQ0O+lg07WrGEYnya2kc07+m3jaPp0Kl5bpka9Qw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AtOQGxyU/hOySBF2x/+Nt60p2F4sHKhg3gOjQY9F1XAem77Tywoa+NUkxRVUI6fS
	 RvttdmhtGyi/B4Z39Ef1BAK4KU0TRFPn5xBdZqcJjrLNpqf8/w1NHXrsBzgyxifIM
	 XxVKIgeVvw714IgvsCLqiDJGTJaZ2i5QSq3L+fUFID7c65s6oNULGqGFIFdXMslZY
	 W/wNvWXSV9nMjqME0+eYNTXzLdLgfL6LpHfyFnBbnnvioij1v8KrfvuIcDarAj/Ye
	 jT6bj2/z8zLOmZlbNnogPri/rnF0W1cIY/ha5Q9RD6S6gCSu3DwakVu6QtfxeJ1h2
	 FYLomzjDvn9GDwSkkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1qi29n28tb-00bGxP; Mon, 18
 Dec 2023 11:23:28 +0100
Message-ID: <badc6cff-7f16-49eb-a600-d99b0e01b92f@gmx.net>
Date: Mon, 18 Dec 2023 11:23:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12 net-next] qca_spi: Improve SPI IRQ handling
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231214150944.55808-1-wahrenst@gmx.net>
 <20231214150944.55808-3-wahrenst@gmx.net>
 <c5b81005-e309-46df-b534-b24814d10006@lunn.ch>
 <8cdac20c-e860-4157-95c0-6e8250e50af5@gmx.net>
 <0a372815-ce13-4254-ab3b-12bc2ca1b1a2@lunn.ch>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <0a372815-ce13-4254-ab3b-12bc2ca1b1a2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lmcEzQ0pcH14yj8EbWceUbVqTVqouP2RR2HFKHNyiG7smbZZ3NB
 f76vJBNZ8NKpJsLS7zJn7X0MC2Mz5f2S0zwnlLR17D8LpW+gA+cz0UtqiEoEV/sq2KrNi8K
 BUnrdNyvQ27gJn0OG6u+9oKSuZoWg+ZoyQq6LQwtKta1VmMuNvhsPKryeAu+YO2x+rSD3KP
 3Y8fTBaVhmos++FfsDFag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QbHPcr5qu08=;Syv/13cM3tSEqLh4agX1OHHEJEO
 CtBGJVtRePkck9lxVVp2PKdsiV91bqoXkPrAIkH4DNvfozg7n7847m5qT8pnhX9lhvxsYUlsC
 X8DUlS6ksi+dzhUO9HJd3f7OCJ20Kk4B6Dpe8QQdo3RQqm9V7yRTsdzKGyXbi/8TlU/VzxAq1
 PULjJqI0VrXrvFGKg9jLIctEUq7iEzqPctzFBERQjwewfK+wgrzGdmB0vC2Mv86XWlLW9ctao
 xiLCB8MROk/5STYAhTyjrU4Ya1eo+Fpn49FBbFv7im1gQAwbGdThFY/q9oAcLf17MVht0Zawo
 qTjvqOIO9OiojykyDp0n9SRXXewnl+QQPF/x4vXpSbJk4zBVoPgxhRQ7yRzc8PoSWFBhRoxiY
 K0UO2cZtDCypnUu3mjHP5VExoiuOFc6mgf2bi79MJ7bmJPnFauISFHh7TG7hIsMGadrWeY7DW
 1GXtjkD9pkmswei7axwsRQ6CP5Z7meIsdA4ZvWONxtqndtXf+nhmXvAtQDJi94dLYzQd+MKeN
 Fcyhyz0UnJ2ZLxa29MFWCZh5NS46XjF3asRB38SnhB9EWkd3GZG88Q1/mpUi4RbW9gMc7xIgs
 wCZMxwkgUURd1HmjY44Wp6OYMm/kdNfu7HyYKsEahu8807EX9YQpiqiKcn8Um0bopQhBZKHkA
 W15n/0w9BV/lOfj14b9pJ8x6hSBciM48lLxr4Esqb+MGgOPyodGHv1MB9X8Aml4MPoQK+juiQ
 pKpKA8Asvo9yIDuwbQqUXURxFM/+hUZW0qbM5pYSCdHfhpXjVYWsWQ3mEO8w9KoOQXt2UEqoJ
 VhfAN3uf+nhd9ClP0KsgoDG+sZzjPC6UgPaXJcvYQLEKUbsyHD8KDQKYyhas9FxMGqMtkyKhl
 Q9RWUms+IwkDYhDMvqknVFjDsqgwOa+e2fc6pPLRqJgLBLuLIVqWZvL6AlHmlvX2oryKJcAJs
 nV395w==

Hi Andrew,

Am 17.12.23 um 23:48 schrieb Andrew Lunn:
> On Sun, Dec 17, 2023 at 08:17:56PM +0100, Stefan Wahren wrote:
>> Hi Andrew,
>>
>> Am 17.12.23 um 19:14 schrieb Andrew Lunn:
>>> On Thu, Dec 14, 2023 at 04:09:34PM +0100, Stefan Wahren wrote:
>>>> The functions qcaspi_netdev_open/close are responsible of request &
>>>> free of the SPI interrupt, which wasn't the best choice because
>>>> allocation problems are discovered not during probe. So let us split
>>>> IRQ allocation & enabling, so we can take advantage of a device
>>>> managed IRQ.
>>> Could you replace the kernel thread with a threaded interrupt handler?
>> the kernel thread is responsible for receiving, transmitting and reset
>> handling (there is no GPIO reset in this driver) which must be
>> synchronized along the same SPI interface. The interrupt just signalize
>> a chip reset or a received packet is available.
>>
>> Could you please elaborate this request more in detail:
>> What is the problem with the kernel thread?
>> Why should i use the threaded interrupt as a replacement instead of e.g=
.
>> workqueue?
>>
>> Please don't get me wrong, but i need to convince my employer for such =
a
>> big rewrite.
> I don't know this driver, which is why i asked the question. Its just
> a suggestion. Maybe it makes no sense. But there have been other SPI
> based Ethernet drivers which have been simplified by using threaded
> interrupts rather than a kernel thread or a work queue, since the
> interrupt core does all the thread management, and in particular the
> creating and destroying of the thread which drivers often get wrong.
thanks for the explanation. I guess you refer to enc28j60 and i had a
look at commit 995585ecdf42 ("net: enc28j60: Use threaded interrupt
instead of workqueue"). The fact that the qca_spi driver has a kernel
thread which is kind of persistent (see patch 1 of this series) and the
request to change this confused me. So your suggestion is more about the
interrupt handling and not about the kernel thread which handles the SPI
communication.

Yes the usage of threaded IRQ makes sense especially this would allow to
support level triggered interrupts. But i think this complex change
should be a separate series.
> 	 Andrew


