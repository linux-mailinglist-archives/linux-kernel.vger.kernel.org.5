Return-Path: <linux-kernel+bounces-77836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17EF860AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17E61C221A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473312B78;
	Fri, 23 Feb 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="g34vepeG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mfes6p7w"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C2125B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669977; cv=none; b=gwM7ozdL7Tt7fiLSu9/lx3Fr7XCSVZV4W+9DloiOh/bJLCXRn4nzRNW+ZSVmTZ/fGEIca3lt5+R1AZHO8eBK2tTY5QTIeRa/46UwQcQFXr5wTnB9cY7SGonGuNfREwva2lWVTaje9nfEr8iqedtcVDM9jCATkdezO5GPpDhHppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669977; c=relaxed/simple;
	bh=YVTcHhINAplglABGufyOgS4DKfhL9lhLuTXhvwCnU24=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lNjQVMbrdxpzZAz+Qp6Kwb/RZIWfdVGmweOGlihlSdtnbkFNil5EXFd5FkdMMxhBLJ6wzKmXLJ/hmT+Wlxt03HF8+E+7wnIyhYjgUeH80W1OXL8wchxj5je3TBmXhZquSBD5izeI+kpfsPEermc46p1Ert8e+FnwFg3xYBPFSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=g34vepeG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mfes6p7w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B255913800E3;
	Fri, 23 Feb 2024 01:32:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 23 Feb 2024 01:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708669974; x=1708756374; bh=4/sLXmisMY
	q1s+yoX1YTX4ulIOX8nOWk06ZkTuIwNvs=; b=g34vepeGSsw6B6vJEwhpkxN5K0
	bK8CMrOCF0bZhwabWPyETtN8lmeCwN2CsPPm89hO+itIXz0PXtdqZ8fihLl/p6O3
	/Kz5QdCy+E8doVx+pDrCSf7cpa6MH4ppJ/1oS6Onr3XrqJjHAtz9EK7LZmW8tz0U
	BgCRZB/xJdOR03qAbqKD6shQTCOWNJlgR80U+qoXzls1RmmoHV46wDn085KoDc4F
	/o/tokD86ED69+AE4xQ2MjbbL6xnyONxsBxZTOzxVsJxBlih8lYKrakt07RYB/Ng
	N+fyaedMxJ5iD8nbmztVtE9QvVt4sUmye8/9Rb9Wi5atBm2FcweBs/HX1TWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708669974; x=1708756374; bh=4/sLXmisMYq1s+yoX1YTX4ulIOX8
	nOWk06ZkTuIwNvs=; b=Mfes6p7w6OVJQbYFdSPWiwbfvnoqq7puFUs+lgAdfhFq
	ekeC8YQyqvw/fxu+AymJL0gKW4rVfWvY+Nq/79qHSykAoy2fkR1F5wI8XEq592er
	89iHSOWtoHk3CIQjnvSpVUKbWYAA7ZdrnfK9QkKndxv6d+Ta1fwE+WzG2EahZB3p
	eeP1cptF/ec6vEQclKGlb88qPxzBzLvh6akXtREqTs5iMXd40ygTGhoCfRx0qLy/
	RUHLWn/D4eKwnVMllpa5ak7wnCMzwLXy37H93PhDXddIQnezBZekYerJMn8Rjj2c
	ay7mTyNa33jHYk44BBz3HTRiFnudQl4sBbApcsxcDw==
X-ME-Sender: <xms:FDzYZQSdRT6eTr1H9PUlgaAaW7D6Xi2CAPUFpRrLV-6KHvX0N02XRQ>
    <xme:FDzYZdyOW44Hl9JLYnPhP03_XnewSHPnWRveZIFkd1Stpj1zi7tHlecNDhGKI7YoM
    jdN2J5UCLm8ZT0m6R4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeehgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:FDzYZd3ThVE0JeHw-3b-KlmCcTV82n7nT1fVDnaqc2N7gMF1phgD_A>
    <xmx:FDzYZUAv8yyJR0uQV_on9PFielyaFX3bfQR_oUnX9P8vw8kqGF0Fgg>
    <xmx:FDzYZZhiQuvjkfhs2T9Drc3F9eBmOYzixg8ngNI93JSov5_JmVvnkQ>
    <xmx:FjzYZcRyF8f7LlZu3OfWS4Y95qZd4jARhwDhZKEr2lXypd65wQLrvQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A5D40B6008D; Fri, 23 Feb 2024 01:32:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7f5c111-6c8b-47e6-a6af-05abdb9c6595@app.fastmail.com>
In-Reply-To: <7396cdc0-e878-48fe-85b9-d88611d28444@huawei.com>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
 <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
 <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
 <7396cdc0-e878-48fe-85b9-d88611d28444@huawei.com>
Date: Fri, 23 Feb 2024 07:32:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Eric DeVolder" <eric.devolder@oracle.com>, "Rob Herring" <robh@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain

On Fri, Feb 23, 2024, at 02:39, liuyuntao (F) wrote:
> On 2024/2/23 0:04, Arnd Bergmann wrote:
>> On Thu, Feb 22, 2024, at 12:24, liuyuntao (F) wrote:
>>>
>>> The position of the caret has been moved below the right brace
>>> of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
>>> the entire `KEEP(*(.vectors))` as a file name. This could potentially be
>>> a bug in lld. Perhaps we can temporarily
>>> enable the DCE option only when option LD_IS_LLD is disabled,
>>> like risc-v:
>>>
>>> `select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.
>> 
>> I would really like to see this working with lld if at all
>> possible, as it allows the combination of gc-sections with
>> lto and CONFIG_TRIM_UNUSED_KSYMS.
>> 
>> I experimented with lld myself now and I did get a booting
>> kernel even without the the KEEP() on the vectors. I also
>
> When the kernel booted up successfully, was config DCE enabled?

My mistake. I did have DCE enabled in the kernel I built,
but ended up passing an older image to it in the end,
and that did not boot.

     Arnd

