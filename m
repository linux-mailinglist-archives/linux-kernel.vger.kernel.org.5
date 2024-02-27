Return-Path: <linux-kernel+bounces-83234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FD6869093
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A0D1C24BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1512F38E;
	Tue, 27 Feb 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X1WNMj8w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="osrzw/mX"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30E16423;
	Tue, 27 Feb 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037033; cv=none; b=q3dScn00gcUmjGekvescGWAtAmLZYBVoa3JmwwBH3D8ZWFiT0GlC5CX3sYx1hMq75HRVNdrW5DrO2fUeCnQAsMq9DghtIzu3hM1WA9WOoWBuYvU7jObCJNWsi9E/PrDz7Kl8WeAfhSsZCHEkUnR/n8Vtxmp+SRRdIU9Z1UnCMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037033; c=relaxed/simple;
	bh=0HKakmzqYBDg0qBBfaGHutRFP4329ZyA5W0f3BwieQA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W0X6Km7lJou9f+RB0Qunqf8WQEbVIxt5tCjTxDUyKW6wlr0M1VKp3tGlteXFMK7K8nchUXlyFQnJp72HCRZ0mNCC9S97g76+0W22y9iwel3s7+WPM8nfNhQckAvFpe87NfxpzU75hq+fcBpXMkCz8je4RXbJvQFUvSrl0fO/5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X1WNMj8w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=osrzw/mX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E68EE11400A9;
	Tue, 27 Feb 2024 07:30:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 07:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709037029;
	 x=1709123429; bh=qqBbSmicccEaZRWFjxZw2zuynONkC517ooPIyNNTL0M=; b=
	X1WNMj8wIOYFRikCCsz3IU1UGw2DKfQ0DJPDKbnHZlK5tHnX8qbCozMmTIJs+aXu
	Am/BlxIaJbJJ0LDhF2rYv5UogVyhUmh9CC7NJl8ZnfkfLxVM5+nKn55vp9lTzW+T
	qmlMOHCMWvmgkk0MB2Iae0noHgw1SqAiWqHY8OON3oEcpEwrKZJKMx39mwSx9M9L
	D11SMOPR0vtLGq9TPdeLynMlBAGwEx/KyWb5s9x9Ye7Ad+IwE/ZUibJPHVhJ7C0j
	+z1mQ9BgUmAGQvjJ1oB53TZ52jlo2mU90ucSjsDPTuQKBHh3qs7W2a15IOfMCDtl
	s95KgLaozxSrul1wqQUsLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709037029; x=
	1709123429; bh=qqBbSmicccEaZRWFjxZw2zuynONkC517ooPIyNNTL0M=; b=o
	srzw/mX7WXnjAgKeNzPP433kfhGPkXCmwFf2I73FKKK3iJGK7lXHwYX6yHnXnD8P
	jcBtj25AcerNoFqgemRYfYqkPxVh30F0SJmvETrvzULtn9p5T1o7y5MIyyP/Jlxz
	kJ23iZUJeUQK3I+4z8VzqNnN4p71m/vslr+DiOMpArU7owtGyq57THJ/2MU+TSU4
	HSwcy8ePAh6SGxHNUMzpeRd1/fSKNE3ubYwq5YhMoKgrkusoeJ3iOl3FMyuctKa8
	3TQatt8xjdAwEsCLTpzc036rjH2AVJgk12MJhKxNch61cgwSEeChbhg0Dy/AUVvg
	0kXcIPQ4JQ9dDeXnDC2HA==
X-ME-Sender: <xms:5NXdZT2MBgoXvaNAO9ObgCC4iI0Xr08k_sVC9QoRvJbDVbiLHhNh2g>
    <xme:5NXdZSGg-pyDKEzBtrcXyE0RL3JG_imVe1eb8gQFmpi5PuSps6gYX95t_rIbcD87F
    h7burAudw3nrw45EFU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepfeevgfdtueetuddugfeuiedvtddtvdefhedtgffgteektdevkeeljeekhedu
    feeunecuffhomhgrihhnpehlihhnuhigthhvrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5NXdZT4sYDb1UBkZ8j1J1Uuxlcgi7hno6AQSkrh_G5nX8smYDLooWw>
    <xmx:5NXdZY32vWCgblML1DeEoAzPb6g9ZcgBUHZ9j4O4AsMBNkBNb3D4uA>
    <xmx:5NXdZWFspKj32wwy0o6rtCe_klNmvM7ZclTGrLe5-EOMe7ffGSxSpQ>
    <xmx:5dXdZTIyRC3Z90rby6PGRowdyc3Cy7ZWkq2vuKRWTT2EUa1Mh0X7hA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7BD38B6008F; Tue, 27 Feb 2024 07:30:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <54dcfb0c-9861-4abb-8a1f-83b5d1722ca8@app.fastmail.com>
In-Reply-To: 
 <CAPybu_2JoNfr158FXqYGUV=JuTW8i85XM6cf7K40_xZe9m2qyg@mail.gmail.com>
References: <20240224121059.1806691-1-arnd@kernel.org>
 <CAPybu_2JoNfr158FXqYGUV=JuTW8i85XM6cf7K40_xZe9m2qyg@mail.gmail.com>
Date: Tue, 27 Feb 2024 13:30:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ricardo Ribalda Delgado" <ricardo.ribalda@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Minghsiu Tsai" <minghsiu.tsai@mediatek.com>,
 "Houlong Wei" <houlong.wei@mediatek.com>,
 "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Tiffany Lin" <tiffany.lin@mediatek.com>,
 "Yunfei Dong" <yunfei.dong@mediatek.com>,
 "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
 "Nicolas Dufresne" <nicolas.dufresne@collabora.com>,
 "Alexandre Courbot" <acourbot@chromium.org>,
 "Pi-Hsun Shih" <pihsun@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: mediatek: vcodec: avoid -Wcast-function-type-strict warning
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024, at 12:38, Ricardo Ribalda Delgado wrote:
> On Sat, Feb 24, 2024 at 1:11=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The ipi handler here tries hard to maintain const-ness of its argumen=
t,
>> but by doing that causes a warning about function type casts:
>
> I worked on the same issue, but in instead of removing the const, I
> tried to constify everything:
> https://patchwork.linuxtv.org/project/linux-media/patch/20240226-fix-c=
lang-warnings-v2-3-fa1bc931d17e@chromium.org/

I had almost the same patch originally but ended up not sending
it because I could not figure out what to do about

typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *,=
 u32);

which is a generic part of rpmsg that takes a non-const pointer
and gets called by mtk_rpmsg_ipi_handler(), which would now
get a const pointer.

     Arnd

