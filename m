Return-Path: <linux-kernel+bounces-14117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1A821803
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375841F2276B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5D23C3;
	Tue,  2 Jan 2024 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wCoBu3+q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6A6AA1;
	Tue,  2 Jan 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704180751; x=1704785551; i=markus.elfring@web.de;
	bh=EhFYnh+cMjLhe96c/DjhnHwH2X/+PqHgz11UD0BfHcc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=wCoBu3+qiO2GczBp3vxu8jULTnyOX4c4WdQMy49nHoPgkfNRQvpB09U5lthXWqPZ
	 5LgoJU6hFTb+ytWtv6t5RxhAJIYjfQogbFVqvRug8TAtsMUjGbF3ytMStiVjHVpy5
	 get4nhz9XMjRqiPgM1LkEj54PzOoDLZTwTPTDHUKWatUqXB3t2Nuy9bTRJpJMX7X0
	 0uPpxx4nGMp0awP4nvkeOL4433AKXiCtvqVE15O3BM5m6UxpQz2xpKiHWmsuMTzwO
	 DsSBaMeazMNL24p+Ndlul6oFxwdJDhuTH0h23RCinX4ZYfcC77UPevCrlVAmvGQxT
	 2g2/pDrmQToqA6TmVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCA3-1qxf800uf5-00voof; Tue, 02
 Jan 2024 08:32:31 +0100
Message-ID: <70a94379-ee4b-46e7-8cb9-c817590ad851@web.de>
Date: Tue, 2 Jan 2024 08:32:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: packet: Improve exception handling in fanout_add()
Content-Language: en-GB
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
 <6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
 <a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
 <20240101101221.73276d5d@hermes.local>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240101101221.73276d5d@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2NpcJNTnh/PMkkkoUV4Zb96so9kvmH6xJEr4I3R816oo3zU7nqv
 XU4kKOBDV0aI4x3eW61/C1JWPirfCwmx+Xdj6jMWX67kndC1DfCLnbYB9+LLraghZF6aGuo
 Zfh2H5Rir331bZ0kw4zR5heqMQHdOwiBENeRgEPZbKLpwstm69ACXyJjHFHQnli+OmMa2hF
 9SuSd3BRXepdjvbc6bW0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0UhzYiaB31c=;OdzWLEIlrEXm8/ORIMdPgkfmBgy
 5g7O+kDaQrfv7Gy5f9GOFJT6fOgMdvkKjV0z7Y+Cnsv0LzyYK/Pvm+ZM2Sf0fo4onOhF73TYp
 h1Xff8VOlsl4elxxGyQkmw57h2A+djO/FXGSBbca1rKm+TDTqliBvQvSczif2adekWCOiGRNL
 JFsFPvQaMU6MilAC5rjKfzGXP8LjDtJSEM0WXrBCKAXfeVi506vzdrMf615Dsef8nMtDilkJU
 ffoexDRFkCurvmiQHrRsWXWAW7vlo9gxgKdKmHsymMqDa72IGywcR6kH3LvsiOx3qSyF3/6sX
 Z0o5O0glqM5vpR6fGXJe9/UIGx9rwWooquOzDGZgWjjAI3pWGBgXOnYNsSwrgdpdKxB1S6asi
 qF873LNbkPN6U1Tkx9xbgrVM7eJbxdkJDDx9bavW9a1Joirit04xPijY3etXY1L8FVh1q13uq
 pr+iTrXc8M2t2zYL7vL9UIBSnSLH6fF0+pXopjjcDb3PqW0BCW7slCAJuBa+whMEQUjqJbEtU
 Soad0myJ22Lc2c7AqE9deYOQEMAhCqa9qlQbj2BZaazfJQLluXFKzj2B06IDdW/yolfj3/9jQ
 yoG2URT/SDRtMVZW2vk0F2rcSzVeXAk0eFgvhW5NqlBEytNn25IBB2pEUAzTst/Hjk/AT4FF+
 MNeU1s4Jfahf68hwZ3KTm/uXdPPMnMhkQ0iLd+tA3Pwu2U4Kmu1XGUf6tM2J7HLGc1vzHJSR9
 SJuIIxlg0yNB6c9uP+rQiMFKlnUfba4JtSenJL56kdbGQLfxKr5AkTUAQZW2AfbjptOO+AgeE
 qt+ogYEjJ3bhgzwehANvgeTUfdWwuaCp/yxQ5Mo/SMcYrPZ9w0TSQfmKORhU4VAb1IvW71V66
 FTsET3tW6wBykDsBc3/sCv2K3NrrDWNTJSObsJP4Ixu3I12+8ITEpSOA8d11nHWrwF3HGkYWD
 Y98gj2hzUtaIwk9F+l2D73CbN3o=

> If you look at the existing coccinelle script there is even one
> to remove unnecessary checks for null before calling kfree.

The avoidance of extra pointer checks is an other use case than
omitting redundant function calls, isn't it?

Regards,
Markus

