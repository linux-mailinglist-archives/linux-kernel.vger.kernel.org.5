Return-Path: <linux-kernel+bounces-100485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5E879875
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0911F2425F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C447E776;
	Tue, 12 Mar 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qys1UsJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmejt48P"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8B7D093
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259082; cv=none; b=E5mXZMf1W79NlGjlVnDYmRtz/aKFAYXn15Kbg+NFaFbD0pmcM1TC4Qom2f+WvtvXg62/1FZuAr87R5BUUTV8Kle+r5UpruipQ188eaHbR9RfSVBCtHvNGQIhOG7DSfK8f3gcsKRKV5LAU3lBUP+ja+O91Xv3L3G/EuWPpT7LfRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259082; c=relaxed/simple;
	bh=OHpe7uyThgZlN6Pl7adIfVnWrEppX1cFzmO61w5qHNE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EH1rZWDgTZLlEEjdtN6hvwAesYwJzoUzQWANXPFSuFtkiRBcyT37Y2lv54ThXMQg9Yz+oCqnjDHGz5g2SUfqrwvLgGtcwjz39RlRzCb2BvIhEnmLMsLtMU63lOYsKlKPNDf8l5XGw0zhaSyzrK7XePoFJEDM9Llo18eXWgmLjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qys1UsJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmejt48P; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 74B6B1800091;
	Tue, 12 Mar 2024 11:57:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 12 Mar 2024 11:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710259078; x=1710345478; bh=YsSZl05VvN
	YlGGdKIaMVn8wUwHQ4u1oI58NKNni6V1I=; b=qys1UsJyeX3yLUg4PihUdb26AH
	qq20AEaNCirPfdNWR8Bd6BfTfAqpJP2iG1HHNMFz2Gbsk6OYsxGi4wlTGix2F5Ba
	E5n5JtVFsJevWBwSj7+DZ4ooixj7UACpCVmedJdo9g6aIZJWJkL3747Q2zSr/OzS
	sLD6rXYz1Q96YUZXl8LcijHWrXyJiE5dAoSNjfqnFJcYojgy+DMIYThDRQ38fftw
	fvxOF8yGaIXfIt59C5VMHTa0ygU/7UJqIIUpyTStL36Mpm9d8fy2/lGHTHOYfGw/
	Q35Ntgmo8yHuhubCbh7L7CdokCu7FC0hvDXUJ4uQziW0dA8NacpzcLXE5XnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710259078; x=1710345478; bh=YsSZl05VvNYlGGdKIaMVn8wUwHQ4
	u1oI58NKNni6V1I=; b=fmejt48PIO2b38tcaMKE720ij2JonoIKc09Q0DfZsDf9
	t/tbOml5mQsKIdwbaJkUDjXsDA3WxjM8NDnraK6WnIbKQDS4OFvjqJMFfbI3JXr1
	PwodZ5HwNnxe8I7KLDUma0amKIJqGjv+xF5QHix68o/cJwQyJmQg1GnlhSe8zzsr
	YsViJpG3/KaXhnssPYMO+12lX4GlNwMFpmKaWNdh7aK6C3leCskH3+wTuPcAK90o
	VYOnm/g+LVU0tKKO8760fSMaFUJT9/cL7dyWzHtEBx/X0LizaqnofJj5+HWBCgcz
	10d6/IuK2pNOpeqozz0NJ+u3RGbtGykXxGxxmZKhrQ==
X-ME-Sender: <xms:hnvwZSmpJtwrKMV_P2Q0JqIS_W17l0cJNmhfPTJrcB6DiuSQwsjQ5g>
    <xme:hnvwZZ34MkAVF28b6k-0vtn7xmKVAzv5ZKeCB5x0hvufeLJ5yQt8jSpXgSExaPjKx
    6p3t4O-QEIXsFB2_ZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hnvwZQpBLW86WJqTkkaiu5a2VlI7daSPZWz1kpRO8ABprBvG8P_ppQ>
    <xmx:hnvwZWkZz-RI6McBdcqq9ykHKWnZt5nlY7LX6Y-NUNNpLqND4GzShQ>
    <xmx:hnvwZQ3sETR6zyyXHXbomrprMHMQv8W5P7UXr8BFF4ivSqu2GL69PQ>
    <xmx:hnvwZdvLl6gcbYBOicPasQXmz14j_aquccEOolRR4hajkUGzU-c7Rw>
    <xmx:hnvwZRnkbywgzHyNAjT_3ddwhy-hCx1OvXpO1-UIL-Ufl_vEERaLQEl7S3g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A9CB9B6008D; Tue, 12 Mar 2024 11:57:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <35b27047-4e5f-4e22-ab7e-cd5ee983a232@app.fastmail.com>
In-Reply-To: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
Date: Tue, 12 Mar 2024 16:57:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "Larry Finger" <Larry.Finger@lwfinger.net>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Kalle Valo" <kvalo@kernel.org>
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Content-Type: text/plain

On Sat, Mar 9, 2024, at 23:09, Philipp Hortmann wrote:
> Hi,
>
> I would remove the driver from the mainline kernel. What are your thoughts?
>
> I bought two WLAN devices (DUT: D-Link DWL-122 and T-Sinus 111 data) 
> that are supported by wlan-ng driver. Issue is that the driver is not 
> working anymore.

I don't think it matters much either way. I did send the patches
to remove wlan drivers that were either using the old pcmcia
interfaces or the old wireless extensions that I think we should
try to eventually kill off entirely, but this driver uses neither
of them and as a result has a lower maintenance cost.

On the other hand, there is also little benefit in keeping the
driver if it's known to be broken, given how better USB wireless
adapters are dirt cheap and widely available. Even if we find and
fix all the bugs in this driver, any supported 802.11n device
would be better in practice.

       Arnd

