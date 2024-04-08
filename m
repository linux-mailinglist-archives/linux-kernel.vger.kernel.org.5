Return-Path: <linux-kernel+bounces-135551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D826489C767
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F228355D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3A913F011;
	Mon,  8 Apr 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jPQtOQlU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUMs5gBM"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8641428E3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587590; cv=none; b=JdGG6ohVnesoKDkaJGvGJVtT5ugn18q7LX0D0VKtRDXraWJw+UTcFuz1gvlSRrDWdSZqfBn4kdxcP9woPPjd7mZUWao48DuJGNG1Pye1CyuaWv3fTyCb+3PHkSHRT7FUUetv3xTs37EGRMnTxOUQvbQHC+d/DOYIsBiGvj9JwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587590; c=relaxed/simple;
	bh=v4yKxV+/WzRBeB81VjjZZYKzuZ7bP6EdeLsNPvivKRo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ptuqW2TNpvTc5tRSRX/1b1ubt058Ic9FpspbKN2zS8m4RHw40XqemE3qt9gyKBKqAgOOgJptSI7Gw2sRl3VE1u1lJHhRsAjHmBBpicCZjuthN819vNmjlIDOkSOVewEI1oj6TtswlIKxzALWplwY4LDdIyc4r504UmAtWO/NOfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jPQtOQlU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUMs5gBM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 76937114011F;
	Mon,  8 Apr 2024 10:46:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 10:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712587586; x=1712673986; bh=nIY/vooCvW
	b7sDpDbVJLzdbAh6TBB6z157QyPtKUGXw=; b=jPQtOQlUmbM+DvUTeMZjnxT8fJ
	QbSAiTEKNmoRnYmmzc0Vpnl2SCsnoUfbVmoyhXtf49OALgRDWQGGQ0l5fh8BO8Hg
	GFOcHbWSSYp7KzT/Bxl3lFalc881zXadMVQwE7diD5t0fUUzZvfv8PKjXhiEV7bx
	QQdgyKff6Oa5k9qKzKAPecTSh2JVBrwDmJdCefFWdRJjNBH2NgkJc4LXW8lEpfmC
	XlZcwOtXACsxPi18F3JfSRggjId8d9cqwHd1LbbKqqKI67xueMBuvbnPGCmdNzPB
	JtxzeTuC7WHm7kN9aWBxfRPucjoFk5h7C5PR4Je/JWk/bfM1Gxmt1YmSyYTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712587586; x=1712673986; bh=nIY/vooCvWb7sDpDbVJLzdbAh6TB
	B6z157QyPtKUGXw=; b=lUMs5gBMgCW8CKyLjNn+iLQOwZHcm/eH0WpZKi0SehAJ
	Pm5bY8MtyiFnAW7apphtj6v95Mfkz6DHx4oUxuhR5u0tUsLVKIujIvtq4+Wh8LQV
	93BGckc2wAymkLaWE/vyQEbeU0AJ1ATmAVjsF3KjouORS1xEKIx0EC1Jj80zZxzA
	vzA10Bm7Kf4lbTT8swcno/9QE79hO3L4s4gBIXC9v60Ei8vdSCU4I+37/v4VDd1m
	Wvg4TNOvhEhIvwuLWSCEAAZdkKMDTll3xtpVcu1b774dWm6A9V7FZJbdNs7u5Xyj
	of5YiI4K53rGFXHNieCtQZGhu/c+56VULhLkH0EjkQ==
X-ME-Sender: <xms:QQMUZkV1aTfbmdvvGe9Zwcc6wDARKCE-CHHPE0Esg_RSm2_0zZ66xA>
    <xme:QQMUZokI1ZCDPQ9VTjz6J5mMZji013ykJz1xv36vZFvBFI5x5nXSI4K5wUChKIYPm
    ieeWUS1ZYsXM3mS5t8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QQMUZoYQDLRYIu4qvtWhc3IufGviGcT-BvLVn2gkPMDztYdUfwFJpw>
    <xmx:QQMUZjXZZjSUO-Koda4Mi6y-699QYiF2J_XQQ5raycuBuFfAJU4W7A>
    <xmx:QQMUZundDyYYeoU8Smw5YuuykVa0Wcu5VAJv5lCIUqbXqy3-_Llu4g>
    <xmx:QQMUZodu05fRktHQeWSSsqRZ0mfpz_n4f_TA0B1PHblSN7wr6cPsbw>
    <xmx:QgMUZsa1YpMyIR4nR7kkQOowyQwqwVZa7BlXtGC3t8GqjxGT1YM9Mkag>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ADD29B6008D; Mon,  8 Apr 2024 10:46:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8ee72ec-c16f-443a-b9c1-555dcbc69182@app.fastmail.com>
In-Reply-To: <695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-4-arnd@kernel.org>
 <695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain>
Date: Mon, 08 Apr 2024 16:45:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Kees Cook" <keescook@chromium.org>, "Daniel Micay" <danielmicay@gmail.com>,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH 03/11] staging: replace weird strncpy() with memcpy()
Content-Type: text/plain

On Thu, Mar 28, 2024, at 17:35, Dan Carpenter wrote:
> On Thu, Mar 28, 2024 at 03:04:47PM +0100, Arnd Bergmann wrote:
>> This partially reverts an earlier bugfix that replaced the original
>> incorrect memcpy() with a less bad strncpy(), but it now also avoids
>> the original overflow.
>> 
>> Fixes: 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")
>
> I don't see a problem with this commit.  The "sendbytes - 8" prevents
> a write overflow to buf, and the strncpy() prevents read overflow from
> inquiry_string.

I agree the commit did not introduce a runtime bug, but it did
introduce a warning about the string being truncated.

>> diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
>> index 08bd768ad34d..a73b0959f5a9 100644
>> --- a/drivers/staging/rts5208/rtsx_scsi.c
>> +++ b/drivers/staging/rts5208/rtsx_scsi.c
>> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>>  
>>  	if (sendbytes > 8) {
>>  		memcpy(buf, inquiry_buf, 8);
>> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
>> +		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);
>
> I think your math is off.  The string is 29 characters + NUL.  So it
> should be "min(sendbytes, 38) - 8".  You're chopping off the space and
> the NUL terminator.
>
> This only affects pro_formatter_flag code...

The extra two bytes were clearly a mistake in the original version
at the time it got added to drivers/staging. Note how the code
immediately below it would overwrite the space and NUL byte again:

        if (pro_formatter_flag) {
                if (sendbytes > 36)
                        memcpy(buf + 36, formatter_inquiry_str, sendbytes - 36);
        }

> This code is such a mess.  I'm not sure your fix is the complete fix.
> When I see code that's clearly buggy like this and it's not sure the fix
> is complete then I generally prefer to leave the static checker warning
> as is so that we are reminded of the bug occasionally.

I still think my patch is correct here, but I'll remove the confusing
spaces at the end of the strings and try to improve the commit
text.

A more readable version of the code might construct the entire
56 byte buffer on the stack and then do a single memcpy, but I
think the simpler change is sufficient here.

> How close are
> you to removing all these -Wstringop-truncation warnings?  Maybe we just
> add a comment or a TODO item in the drivers/staging/rts5208/TODO file.

I'm down to eight warnings for clang now (on x86, arm and arm64 randconfigs
as well as allmodconfig and defconfig elsewhere), and hope to have it
enabled by default in either 6.10 or 6.11 after those are all
addressed.

I think gcc shows more warnings because it analyses buffer sizes
across inlining, while clang only does it within a given function.

      Arnd

