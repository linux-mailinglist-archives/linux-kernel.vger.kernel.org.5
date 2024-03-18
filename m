Return-Path: <linux-kernel+bounces-105815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37787E4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22F4B21594
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65726AF7;
	Mon, 18 Mar 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WbTzVS7Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xDPIXjyO"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79122086
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750644; cv=none; b=l+Lqh2ue3YYhj75RzimsQgvtUZ3gALoYzsSuYHU51Cs+yI+nVTKADdfAWqpEXqAJytY2hma73ZCtNarJDBotXu0jO/6OAqjDbyAG06PUz6KDccSFiWHNenblS8yMC3jpWpVkkKBvBm9Zojsd/9CY0nqgzLQ4W4VaBIlPjndpzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750644; c=relaxed/simple;
	bh=6e8qgncYW+RnLPrtDD7i0E/LZBdUAlFp72Fl17NKnb8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UiYIAKyBLRlQqQbU0pdBjRQ7PxRbnj22EiIcBSwWh/7EFR8w3DrBBJpN2YKlmpgO+SyImf0e5SnkdMmXL7sAIQx4UKwX2J21EDaxSxjthFoA29Re1x0UtG6Pst8bYT5N085qdZatt3w6oLbhqzCSpoMQSctoEAeydcHLpLI+mB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WbTzVS7Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xDPIXjyO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6021513800F9;
	Mon, 18 Mar 2024 04:30:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710750641;
	 x=1710837041; bh=K8UFES4KEJzR+9ryXQi7IwVdeZdxrgH5kWPmcyDwpu0=; b=
	WbTzVS7ZwQp1jY+my92szG6vbXb8dH+9q5TPJYfKeg2MTxp5tjc1S/f64ghYbS5Q
	ICXIAXX5Ie3uan2w3IFPCkHpM78sNzln+mZKeOQ4J+5PKMQyvbKLj5Y66Ddv9nf3
	bny8045MIkJgBOo8OR4vBLJCyN2rqWbrE9zanVJEeRpuRHsstnfGszYL7CSiFk1u
	x2D835eMoBiHauahAyRsjxj6YcnXcT46WJdZJP3IGcXB72sVvF0dMSzqg43UHDNN
	IrQl0YScMPg6rPhOChSlPjpIV679GJ7MKuRWmaZeFID6eaDFw8Zy9U+j60LCyIYW
	ROtOYRV7owtiLDvGUGweeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710750641; x=
	1710837041; bh=K8UFES4KEJzR+9ryXQi7IwVdeZdxrgH5kWPmcyDwpu0=; b=x
	DPIXjyONcVYsfWYKpGCoCdy7rJA5BHwmil73mZ8aEZCxtDqUeMDE+lfwEoS3SoeE
	24rYswJlX/AiAcrUrowQtw1oXmnmF690lIECmFDjWaxF01ZQzgdW14/AoZkOYTMk
	vQIaLGZGFxn9bjw31qisvavmNB+Eq1ZB/sd8c+54PjA4dqUvkcqrpCfaAKRkmwVI
	qAjf29iS212QAXK22VgPT8g4Tu7XpubjStn6+Fa6/Btj2kNni47+SREyFvZmfmEO
	/HKSrC41zUYsC6nromblCjMFRQQeaT15ovikx5nDpmTkG7weS8hgx4xF+zIICgfI
	lfjQch7d/sDaFMQFotzfg==
X-ME-Sender: <xms:sPv3ZYnpsIBg2F4f3WNsTfuo3TlBAvsCYQp-xenHetgC_XSL63-0Jg>
    <xme:sPv3ZX2hZh2aACd643evdWG-okTxQdai_jkmIiLGfWMuq1jtwcdOW7u_-LjYtf17a
    qFe-XHl-s04z0CkgvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeeigdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sPv3ZWpoZfYpPO1QPl002rBHqFgC6UN26vBUFTWKnd798IpUGGo0YQ>
    <xmx:sPv3ZUkdmHeheJIq_rtmXYqr96xynBuR6_cQSRXzaCZ8hFi3kUS89g>
    <xmx:sPv3ZW3Sox8Fk-DIkIPa40InJDQKTSy_HZ6T3fp0gY46o1YjDgUbYg>
    <xmx:sPv3ZbsiMauJ_XFogtKA5XNt3pUjpIslbQPQWrbrCtDmTpHWY4s5gQ>
    <xmx:sfv3ZfvZBxpY_mQfQFkMmMPkT47CWR5Xi9Aq5QkQKclbKz0DHqp9cw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A809EB6008D; Mon, 18 Mar 2024 04:30:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <940451c9-cf0b-4be0-9116-80cf7c89a611@app.fastmail.com>
In-Reply-To: <cbdb25ca-f419-4afe-9b58-7d274445aefd@moroto.mountain>
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
 <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
 <6c772d15-d249-4175-93f4-ca523006129b@gmail.com>
 <5716d138-ace0-4621-ab34-118610255207@app.fastmail.com>
 <cbdb25ca-f419-4afe-9b58-7d274445aefd@moroto.mountain>
Date: Mon, 18 Mar 2024 09:30:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
 "Lee Jones" <lee@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Larry Finger" <Larry.Finger@lwfinger.net>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Kalle Valo" <kvalo@kernel.org>,
 "Julia Lawall" <julia.lawall@inria.fr>
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024, at 09:01, Dan Carpenter wrote:
> On Sun, Mar 17, 2024 at 09:20:34PM +0100, Arnd Bergmann wrote:
>> On Sun, Mar 17, 2024, at 21:07, Philipp Hortmann wrote:
>> > On 3/11/24 08:04, Dan Carpenter wrote:
>> >> On Sat, Mar 09, 2024 at 11:09:24PM +0100, Philipp Hortmann wrote:
>> > You are right with the statement that it is this commit.
>> > commit ea82ff749587807fa48e3277c977ff3cec266f25 (HEAD)
>> > Author: Lee Jones <lee.jones@linaro.org>
>> > Date:   Wed Apr 14 19:10:39 2021 +0100
>> >
>> >      staging: wlan-ng: cfg80211: Move large struct onto the heap
>> >
>> >      Fixes the following W=3D1 kernel build warning(s):
>> >
>> >       drivers/staging/wlan-ng/cfg80211.c: In function =E2=80=98pris=
m2_scan=E2=80=99:
>> >       drivers/staging/wlan-ng/cfg80211.c:388:1: warning: the frame =
size=20
>> > of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
>> >
>> > But It is not depending on the line you pointed to.
>>=20
>> Right, the kzalloc() already clears the data, so the memset
>> is not needed.
>>=20
>
> No, it's inside a loop so it needs to be cleared on each iteration.

Right, at least the conversion could not remove the memset()
without a deeper analysis. It's still likely that each
field of the structure still gets initialized properly
inside the loop and the repeated memset() wasn't necessary
in the first place, but that is a completely separate question.

    Arnd

