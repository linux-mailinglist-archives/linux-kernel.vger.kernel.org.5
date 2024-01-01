Return-Path: <linux-kernel+bounces-13846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8C82136E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624881C211AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3E23AD;
	Mon,  1 Jan 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X2fd9lWX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E817E4;
	Mon,  1 Jan 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704102407; x=1704707207; i=markus.elfring@web.de;
	bh=ohTC7seVsNS0COAISRqD2zegJLuYh8qhP2umPTLV674=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=X2fd9lWXGmNSQNbN3kzZQxJxk4vMWQNdXdoGd3m+NcMqTWNYxTg/uhpZZwmF7EKc
	 XphdcV2pWxcQ5VIpZzj8ooE4SMJ5srmL/qLfQD1pLXeimmJdTAK/G/DQZM34q2v9s
	 rT+b8DycnW3ujXQ7VScBRtGbWSe8hKaF4vlFFuesm6nYUvPonowHbVZuoaILouJaj
	 d4o8pgYsz4T6EfrX/GKJ57jXGfHG1PnW3T29huT2aQgK0nVx90is3dmQAR3iuaUXx
	 EGoyUy2+1AQjce9XgYWFuFqewBc/U+BvtG4XrxQ9+z4+DjrrIK65eYwCNbkxWZzsV
	 CCFxXuv1iXJHgicvng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc4q-1qiiHH0ang-00gAQK; Mon, 01
 Jan 2024 10:46:47 +0100
Message-ID: <a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
Date: Mon, 1 Jan 2024 10:46:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: packet: Improve exception handling in fanout_add()
Content-Language: en-GB
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
 <6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KGfwOwu/eh5LtNtDcfQEBI45/T0hTBcGx/MVu2HzdjjE90FwTu4
 41iCdR3ET9SV6e1PktEj9RVgKgi7iEgSGFLccSyIQBKVoDqXB8cuJ6uvxNb2ExgvDka6Fh1
 eWE5eax/j0uddKcx9zslYVogHVodTfW2dK7U6Sd+IcrKJkp71yEByJcc6a0se/rkBHqtw5Q
 MwRqkE2F4+tw/n8qxiJ1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KYd6LUFArsY=;CCkVL4dKWDh6cWNFSXUvpopHMbd
 l3ToZgfQnrx4ofAA6ksaAXU/bRHYh+9pI8CjDwfPh8Tl2urEbncxcsDFB0vHsJJXAzQaSbpu8
 ZMYQ7Ihb/hCBFzkSnd5lef9f816VXvYdi7Q+fJI1BuTHh+u+VZIB3qnmvWUjllRdc5PTVE0dv
 7S3uItmcujQxSLIH4uJY5TWM56ByBjQHyLSbo3Ykf1vd46EuW6jtcXNBsT3sb1ojq3SYCXL/w
 zHRPDI4rUKKI8RsHNqMHTZ0QBgNLJ/Ana7FHl9jDoZWv0CJibDZHaokRXU8ryH2ay/YkacFKJ
 qgrNJMHmaG0k1jFCwt6JUs7CbFYWdGQFkDC2ytE03LixrRa5X9XqIPznMfxdgqYB30xGp/lIM
 o5StJJrYbr7Hn0R+LxnBV9BGRQG8RJXGw1rke2qeJ4s/pkNOBTOU3rM3z8U4J6RgG5KDxn3W6
 ift0Bgzq7YdXU6cRnqswXidaUtTG/N2uw2IvJqWyapxLqU5yRsNEdktrZ3t9S00Q7+p8G8oQw
 hRFyCeVc5XCGMUCZPpb52lkUIXkp9k5SUKeHFsDVoL9o4VsBS8j09M2iOAT66siQWBVFJCFon
 Mp4lctVbaxK4m4m7RE5+ioRg2v5dMtMhFufeb1fkZESuz/UunmV3v3Ti+fpjNvhLJhabVVCTm
 7RJQbtC5f0idzx4AjFdltl+iOvbArVSkBkJT1g1NEBsz/UULTfNOLnqniptBnQExREl4ad+xN
 bj8WPCMqUoyxM77fuppkb/LSN63fvYZNovQd49EQNM72WEhISP1TR4SE2hpWGqBE3FhWc9Q+Q
 ZfVxWa2HP1DLoEhDNlqIMzaBHx7paLbZQ+5zc1XVTa0t3xu4v/ZVqYsl4NUiHpCsdXC481pT+
 ELYHayC1ZMQdvwu+GcqVc7p4HTN5vLxOaRUbanxj6m2UNO11O7zxgG3TvJyuFfIcC1h05ByBb
 hLVbAo88My9+3EzWwZxDmHSJPtY=

> It is fine to call kfree with a possible NULL pointer:
=E2=80=A6
> 	 * If @object is NULL, no operation is performed.
> 	 */
> 	void kfree(const void *object)

Such a function call triggers an input parameter validation
with a corresponding immediate return, doesn't it?
Do you find such data processing really helpful for the desired error/exce=
ption handling?

Regards,
Markus

