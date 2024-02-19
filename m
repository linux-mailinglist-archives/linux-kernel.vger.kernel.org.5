Return-Path: <linux-kernel+bounces-71207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7771C85A1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4E1F23777
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E242C1BA;
	Mon, 19 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QMHV+HnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nblDJDTS"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0082C1BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342231; cv=none; b=LlNdh2EtuOfPd9Fe8EhiiPIgFzBLqfW6iIZvEIlMxkrPAVpp6JfCYjx5GV9ImoR49XV/VOLBryFSBkIvl4nKB4yBuQUgO9Xnv0og24ZwECoMqftef6LcPmt2pTyxqHeKCF9L1P7azKpLHlj3p49W88lfvow4D8G+P3qN/I2o/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342231; c=relaxed/simple;
	bh=X9M+tjEeoip0TeLuPx3RYlT1m5MOUQ+xB9mh2j89o2g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GL8j5HhdUMkIyGbFKQIVK5+1aumP/vyZ2AkRWJ8vv8R9E7GVKpO03woPpWeFuwNGiNcApMymv2iRFCfZEuYZGp791+gS/4fAsJs4INg7m69rXf4tUGM91JSYKEsUXlJkuGjQfyp4jCzitZe5syZtYsQUil19bW0QsetcWqwdutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QMHV+HnQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nblDJDTS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9548F11400C3;
	Mon, 19 Feb 2024 06:30:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 06:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708342228;
	 x=1708428628; bh=ZTYwiFQEp8cThTaa6T2QNUW4Hfm+lei5RwnJjMUwvVI=; b=
	QMHV+HnQ/Ms+W3R44Cr/1qex2YyCm6zb/EbvPgsSH0wu7U/uu7hUJJ1KqKvaXXex
	5Ds/oCnEhN/eXFE5IFDj5feFJRYKAPFaWk8mLSjEeVuTGN5mJ2qw3s5shrzvALNN
	CrXnqwVje76o9aojr+pjb3kYdJz+1GSpu1Je75wEjIZV/q/whl9Q1jORx3sjGD9U
	GKcN7LEZO4l+TDMV5uYqoT7R9CF4qI5PoarzqlxR+W3QNbXQAsgho7h54l3mE/ND
	u5m29DeomnQ0ncY0gj4dn6SPl8bXh3AZ5tYXpe07wrzr8G+g+1Hawmg4LGSsj/Xa
	LnTop0Z/w9Dkktv7ONHsYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708342228; x=
	1708428628; bh=ZTYwiFQEp8cThTaa6T2QNUW4Hfm+lei5RwnJjMUwvVI=; b=n
	blDJDTSgAdRv4JKz/DXFmuy+vw2sbTMeiqIVGmBsvCRUVYoyJwMyUytITeBNtOvW
	zOAcKqTOsoEnYpyOVXXzsSCsoYRt2DtR1tuKEBXngjEd8QHZd7sVlRJe1J37NrD8
	LONbAkRIr2HgFNzckiAae4uAJ5lBt5a45DCDfuBGxoTrHKleQRlDk7bMEutrOkjn
	hf2NKSHRcfz2nsduvb+qNpb2U+AKwFmyCTprMU2Vjg00PTbx3AUi0EoDvH4I6zRN
	ZA/2SvX3ZjS7MuQu00AevLGWZVhrR1zBTS8xphqPNGIUgOww7B5J8egR66gC4S5M
	I8hrpA+IOeyJGDlkT90MQ==
X-ME-Sender: <xms:0zvTZTLPW0B06TNGLqFApIpZhVWdUrtEhyvFJDXKtJwKK473VFCTmA>
    <xme:0zvTZXJATIm4FZyGRN-olEkB2_6u3MbMWXPxugjqwoF8GyXBZgt5eotnY2iMtwEIu
    XEM-dREj-1PA5Az-Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0zvTZbs01jMkFgvSVsuiWB2gmXY_1znay3rIUmXEhGVMv9DG9JTQAQ>
    <xmx:0zvTZcbh25BMdGyftcN1Ke5d6P7MDUZ4ZSZD6m4ytyXWfiaJwXpGhQ>
    <xmx:0zvTZabJQk1KOjVMI70npcifY1lp6jPNte-CeX5hhIuu4grjFPzPpQ>
    <xmx:1DvTZSoNGlsCr2gjSLvlIvfNerBMN7MZips93aHJPxlQA30VJ8rSvw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D0AC0B6008D; Mon, 19 Feb 2024 06:30:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fbd0426c-fdd2-4b7f-a13e-072ed5f973de@app.fastmail.com>
In-Reply-To: <4cdc5b58-11c1-490d-8c3b-6352d8f1b8cb@amd.com>
References: <20240216202442.2493031-1-arnd@kernel.org>
 <745e156e-c3ec-427f-98ad-bfc7d3cfd846@infradead.org>
 <4cdc5b58-11c1-490d-8c3b-6352d8f1b8cb@amd.com>
Date: Mon, 19 Feb 2024 12:29:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Dave Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>,
 "David Gow" <davidgow@google.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 "Matthew Auld" <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tests/drm_buddy: avoid 64-bit calculation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024, at 12:22, Christian K=C3=B6nig wrote:
> Am 17.02.24 um 02:31 schrieb Randy Dunlap:
>> On 2/16/24 12:24, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The newly added drm_test_buddy_alloc_contiguous() test fails to link=
 on
>>> 32-bit targets because of inadvertent 64-bit calculations:
>>>
>>> ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/tests/drm_buddy_=
test.ko] undefined!
>>> ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/tests/drm_buddy_t=
est.ko] undefined!
>>>
>>> >From what I can tell, the numbers cannot possibly overflow a 32-bit=
 size,
>>> so use different types for these.
>>>
>>> I noticed that the function has another possible flaw in that is mix=
es
>>> what it calls pages with 4KB units. This is a big confusing at best,
>>> or possibly broken when built on machines with larger pages.
>>>
>>> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test=
")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>
> I've just pushed a similar patch Mathew came up a bit earlier to=20
> drm-misc-fixes.
>
> Sorry for the noise, I have to catch up on picking up patches for=20
> misc-fixes and misc-next.

Ok, thanks.

Have you looked at how this code works for larger values of PAGE_SIZE?
Is there any need to change other things or will this work with the
hardcoded 4KB chunks?

     Arnd

