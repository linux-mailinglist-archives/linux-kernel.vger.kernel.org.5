Return-Path: <linux-kernel+bounces-168139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042238BB428
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D471F21440
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1F158A03;
	Fri,  3 May 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XMnBcTJK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPxN2IkV"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171E13B593
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764897; cv=none; b=FdY8TTOaq7uwYuqXne1AXefDuF6NaXytEv/XqIIhy2UYEGzOkHYvIJ2GlKyODpTM5Q1AdDPMrdMtGU6ZasB74xDcpkm6M3PKigL2js7Rl/cmJyTpMTrPhV79qa/n9Sc6BO8TLP+nX/nhhqwKZW50ccIZ9XXL7010rsYxsYpYav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764897; c=relaxed/simple;
	bh=4OSCQtExy8HDG9vzT7OzvTAzSTFKGqszq7wFXETz4sg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DlIoTK9wAIq7rTT9gzxUPSvLBuo2Q+WBlS35ari05XbWfDyEzcKAW+F2bLT0RsnpVVPunGaZ8Tem7U7p8Lc/MIIacewC5+3E+PiBUNjKP/mP+G3xFPzcVYViUtpSqURfj72WiIWUclD1A8WBLb8ZFxZ6NnUW9gFBGUFHY2jyIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XMnBcTJK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPxN2IkV; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A856F1C0008E;
	Fri,  3 May 2024 15:34:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 03 May 2024 15:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714764893; x=1714851293; bh=miihCwvzsW
	ti5H/aziJQQJwZEV59oT6FVoAAjQJ/FoY=; b=XMnBcTJK6WsK8VnpK9FybXx/lc
	MANr2mIMS4jUyBH3rA2/deUKa41SFOllmTMDwhhmPTNEK3zMZz+Q0AZJ3IRzLuLF
	vYxF74S9idutLcRT5zd90CcdyhneGxCAw6f95CqM8FwwtGuV5Qe2XZQPWsuLbiDR
	mfdlU7AonokQRHKmuznwSMlxMn9K0aDsGc+u9cFUK/dt+M6AkQu1o99XqrhlPNnx
	ZGjdTMVAnMlOPsuEseEzaLZryslT8Ij72vYnMVrHGPln4lrrjf4manOjvCAJGLfA
	T6DAGaBwIsxFGGmE4aRVZUmdm4hay10di3dQ49ZPVS/2W0U9km7zO1Wyx8SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714764893; x=1714851293; bh=miihCwvzsWti5H/aziJQQJwZEV59
	oT6FVoAAjQJ/FoY=; b=CPxN2IkVcXUYwd4icjzj9Y7e5Ris+38L/WrSmjwFpqs/
	GGm/wVBu7YnlcdSaYGLxVEljKiktURHUu5GC/3UublQcMsdCT1p9rvnkfTDWLw0v
	E7tUsCNoBgimK3hG6QK/mSTuFCAiwpK5Dn/3XtbB6GBxJd51AL12s8GCe/e89aeR
	OmRoU+hPKqhEHKVESS7Cj0XKwd6NKxvAq+6I2gWnqUTdJIXUlQ4doRahUCxDF2E2
	JkzYXG9ooK03ZIna8g61caFOahrv2Mbh2vHNuQBF+WfLUbW5GmaKU3o3dCsDk6xK
	aKneskem/dT5woD5rd9MaOgyMc5W1bngaWguIVsGwg==
X-ME-Sender: <xms:XTw1ZgNlOYHYJXtlY1bKoGAbOSrilDJbl8YBbwfiZOybegHdN9kKOQ>
    <xme:XTw1Zm_Q6pY4karNe84k5t__kdu77sWW20VT76R4vqW9uG-hdox8JmSl534i4oM-N
    c45SQWJ7VGiYzPmgzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XTw1ZnTR8pguF3RYs5Ef2nRv91ItQ6zc75hRnTu6ivlyy_ci3FOstg>
    <xmx:XTw1ZovSZDuoT7V67cZ0gYLfZB_7Co9GcISgkLKCPpOIF0nwclNntQ>
    <xmx:XTw1ZodLfr0ZS96yw63m55-QtwC0uEqIE6NoPrRuHS41YNk4INpjtw>
    <xmx:XTw1Zs0O_FkWXLZcHkNKg9j_NQ0Rm6FYloFiGF0Xp2Fn2pvWY-rQBA>
    <xmx:XTw1Zpqifl5vv38rMBAve1CUAYod5EkKwrcaSmPf5JHFZkolXSkTiY34>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E7D63B6008D; Fri,  3 May 2024 15:34:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb22252d-1ea9-4094-9f7a-b94c2142d1f2@app.fastmail.com>
In-Reply-To: <ZjUzt3Rysyk-oGdQ@smile.fi.intel.com>
References: <ZjUzt3Rysyk-oGdQ@smile.fi.intel.com>
Date: Fri, 03 May 2024 21:34:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "David Howells" <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiler_types.h in UAPI?
Content-Type: text/plain

On Fri, May 3, 2024, at 20:57, Andy Shevchenko wrote:
> Hi!
>
> Today I have stumbled over use of __force and other compiler_types.h related
> things in UAPI headers. Can anybody explain to me how do they suppose to work
> outside of the kernel? Or did I miss something obvious? Or it was a mistake
> during UAPI split to move swab.h and byteorder/ (most of the users of those)
> to UAPI in the first place?

These get stripped out by scripts/headers_install.sh during
the 'make headers_install' stage:

sed -E -e '
        s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
        s/__attribute_const__([[:space:]]|$)/\1/g
        s@^#include <linux/compiler(|_types).h>@@
        s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
        s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
        s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @
' $INFILE > $TMPFILE || exit 1


      Arnd

