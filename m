Return-Path: <linux-kernel+bounces-34823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7D8387F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E2C28264B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7651C3A;
	Tue, 23 Jan 2024 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d/t1jmYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVAGtaaU"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25851C52
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995270; cv=none; b=G+H+YqsLcoh565XhjCMn/XyLvlm9D+LZmA96LCuLWzwNEhbAOAxd+yOX6RPGbyedz47Cm9AUx+DCpDc9Cq5rbBnyA3RZtR08HtLbt8KH9L2nmBVQ1xYqsg2qwHbuYZcJ8BzqSQQCkQwgTxRONox2qkfIjShAMTSJI9Mq6S5EZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995270; c=relaxed/simple;
	bh=FvWzwHTDVEyet3HZiGtusiSZVWNkuF9rpU6YASueXuo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EXGsBhrFqLQzMOChgfr18ICnmLe/mtYip6vVbaUu80JJtG3/VdxSurNLadpnIaPxKdKrgDeXjcFDquWI7TxhoJk1w7cNxcLshdMb2mk83PjlyQ3+XT+et+PHvwnmj8Z8Ll8NnbVYHFIdP91wlfSPkhW4D302bZARDaAthjliTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d/t1jmYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jVAGtaaU; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 978493200AF5;
	Tue, 23 Jan 2024 02:34:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 23 Jan 2024 02:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705995266; x=1706081666; bh=TWAFZjSQ6D
	f63rcQm0mLoFKrDX1HkRJ7iYKKyR4vOb0=; b=d/t1jmYwEbp6g7avHbkITWc3wd
	1goEo1tNaVMIJpAt67kobRXr/1wuYI6dbIzguIHLYHSkl71WlDeqVXHg/SGzGqoU
	xiKpi4Z6z1wYeni5QoXvWUlE3ONFBWERNSJRY65pWz/Sj8IMsXtNx7YHQXslnrhi
	G5rHwvVlR3MJ623wVrNDpTMWSoMx7iwOvGUF4NGcfd6xD89yMlFBoG+qRCFNha9k
	LiTaUqwAKwcR8GFmEnAiFeBG7rkajJ+8cBMZRoxAwiikgP1qfUfhKOgrXGbiTL24
	8ECPdr+rcQMUKQto37fQfPBV0ZlaXa2VPzdeXLSE5YXIyGU29/cLur2A8+bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705995266; x=1706081666; bh=TWAFZjSQ6Df63rcQm0mLoFKrDX1H
	kRJ7iYKKyR4vOb0=; b=jVAGtaaU4oNW9+LiowsUYxrJDZd8xQ4fdYXQoDt0o0Pr
	rYZc0o1bQflxH91jWzhUWSH8UoE7ki954hKoLa/qGfY1CTkxUC5bpuLZq0JcXgtT
	g8L4qRyvhik6krVKU0NM2OsklUfT97H0Y0LvhHHMnXA0zC/QYfTiDP7eHRzKu7FC
	56HbUvK8IDCPWWODIIvrSrFojJklplHxDBG8HIv7fRYVLL9eGzSe8LcWs4tqcLEp
	QBMe83/fzlBJpHNUlnsaQ2p56o+fO2bp+85+WB5lhiM8Alm+TnklV82Ay11qL9Z+
	KFR6au3fa/329RulocRIn5fm3R2ZQR46FDW/vLCriA==
X-ME-Sender: <xms:AWyvZXEzKdynUjnxVDjbwLDx7QbYSxuTclNydqMznDzEC7hCBlFq5w>
    <xme:AWyvZUWJ5HNXmuTQ58NsThBKGs41v4eQf-7H4SdMj6m4NBMgUVLdYcDiJ-fwg6ddq
    qoG4Ofl6X-d8071o1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeekudfggedvgfegffeffedvffelgfeludfhueefjeeiveektdevfeehjeff
    keehveenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdr
    uggv
X-ME-Proxy: <xmx:AWyvZZLIngQF7PL50_kSnfKfZSVdZctg6rHBgUEoBxjpmpfXbyu-NQ>
    <xmx:AWyvZVH-SWe21EYEGA09JyIq4REqB3QFDQYgyU4MsFycwrtuy-iz0w>
    <xmx:AWyvZdXS7WG1yXXS5uebGyBElLsB300WmYC9_dGmoO2BBkvKkXos4g>
    <xmx:AmyvZcHuxjtWK1rR5murBek_j9Wy1PMPe2kZgqhvmLAszEGAgy_tog>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 107D6B6008D; Tue, 23 Jan 2024 02:34:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3da403ff-365d-4cea-86f0-4009d1da6baa@app.fastmail.com>
In-Reply-To: <efebd848-c952-41f8-9422-fe2235d92259@app.fastmail.com>
References: <20240117104448.6852-1-arnd@kernel.org>
 <efebd848-c952-41f8-9422-fe2235d92259@app.fastmail.com>
Date: Tue, 23 Jan 2024 08:34:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Janne Grunau" <j@jannau.net>, "Arnd Bergmann" <arnd@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: asahi@lists.linux.dev, "Hector Martin" <marcan@marcan.st>,
 "Sven Peter" <sven@svenpeter.dev>, "Asahi Lina" <lina@asahilina.net>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: apple: mark local functions static
Content-Type: text/plain

On Mon, Jan 22, 2024, at 21:50, Janne Grunau wrote:
> On Wed, Jan 17, 2024, at 11:44, Arnd Bergmann wrote:
>> 
>> -int parse_sample_rate_bit(struct dcp_parse_ctx *handle, unsigned int 
>> *ratebit)
>> +static int parse_sample_rate_bit(struct dcp_parse_ctx *handle, 
>> unsigned int *ratebit)
>>  {
>>  	s64 rate;
>>  	int ret = parse_int(handle, &rate);
>> @@ -715,7 +715,7 @@ int parse_sample_rate_bit(struct dcp_parse_ctx 
>> *handle, unsigned int *ratebit)
>>  	return 0;
>>  }
>> 
>> -int parse_sample_fmtbit(struct dcp_parse_ctx *handle, u64 *fmtbit)
>> +static int parse_sample_fmtbit(struct dcp_parse_ctx *handle, u64 *fmtbit)
>>  {
>>  	s64 sample_size;
>>  	int ret = parse_int(handle, &sample_size);
>
> thanks, patch included in my dev branch and will be in the next pull 
> request I'll send to Hector.
>
> I suppose the recipients are generated by an automated 
> get_maintainers.pl invocation. Is that desired for out of tree drivers?

I was wondering about that as well, as I don't usually send
patches for code that isn't at least in linux-next yet.

I ended up using what is in the MAINTAINERS file for this driver
in the branch as that is is all I have at this point:

APPLE DRM DISPLAY DRIVER
M:      Alyssa Rosenzweig <alyssa@rosenzweig.io>
L:      dri-devel@lists.freedesktop.org
S:      Maintained
T:      git git://anongit.freedesktop.org/drm/drm-misc
F:      drivers/gpu/drm/apple/

I left out the drivers/gpu/ maintainer addresses though. 

     Arnd

