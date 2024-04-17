Return-Path: <linux-kernel+bounces-149334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC48A8FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF85D2825C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14773128811;
	Wed, 17 Apr 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="g58usF9q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ift4++zV"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA4A7464;
	Wed, 17 Apr 2024 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398262; cv=none; b=F4Lny0B3qnjOifsPU9L3AL4kc8TshcsxcQPGkm1Cg/kiknFJzXsbfWBRs8VudyEl8x4JMhRQgn+KqcCYpjr97s1PHxghpjwKfwX13IWyfBdsdcLQSrsYGfk2HkSHVMyREpevqUPr0OtN4wrf428xbsAV9QOJH55Uducjg7LzW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398262; c=relaxed/simple;
	bh=3oebNk1jMXprM1TjnaP15jUS+q3l9nHDmGnbKhQkT9E=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=O6oEgOIXye3eVLF3Rftf/YBynAuL7Yx/zzVrdpAZ+vuTMwOh4Dmdjm8hW731iE/6gmTx71mRt09aWIYJLxJFi2Ne2N8Uy1FuxMAlfbI8s6UY4h+nBnzUsuDeWUPIP2RUFHXSqp4C6XDetvfhiCzBbfvCBMgVsR8HS+mX0h/7Plk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=g58usF9q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ift4++zV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id EEAC9138023B;
	Wed, 17 Apr 2024 19:57:38 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 17 Apr 2024 19:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713398258; x=1713484658; bh=vQ0R2zuCuJ
	DMnV0woeSURJz1wHKlUMP5n9tccB0GAqE=; b=g58usF9qjD5/9mxDGYihGDD8C0
	EFD0lSQ9Y4nx7KF5IIMrOZUEhkNsgqQQmEJj9CS2KrGkeFHYiyZzyOwMyoLMw84H
	EmJ9vomn+yvTsvTAzm4V5Oa3muFTzHjm8x56DSoPW3hdMkXYhR07cMmoDBiCXz7I
	v1gn2ThZwkNH8qUAzyqR8/58SaOjT0N8OPPBJNBRrwvH+vaXKjGTTQbEM5btMMl6
	lXaG9BskY2vGOwfTr7S5XX1cF08JZfowXdorsulcbNc5YWWDTfv2889foaxxc1L2
	HgP/i59tixEdu/jn5MJnVVFxJWgpmQbtUzAtvX3Q2idCZ3E5F79fCe4DGBuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713398258; x=1713484658; bh=vQ0R2zuCuJDMnV0woeSURJz1wHKl
	UMP5n9tccB0GAqE=; b=ift4++zVPKLbCGv/gs1YuiHbWyma/GoqViwYN8oSM2aM
	Hb66JtlQdxq44okEePrjpSoqMaNlftFd1gvzA2/sMFKk64ZcuG/cjdbLXDD9Eam5
	v/IUCCPz6/2DyBDGMHfS8oDl/BTgzvvXxEYLohWUN4+VayEklPT5EbgLLsCnRSAu
	4lM8SOsCtAch0hiO7f9jVzmdT9YbLdg0Bm+I5ssrD0onifYgkPk/eGRodxaqCg+W
	VGp7mgaE4u6yH0WYEnd+xM7Q0xl+3ZJKLVgQp9wEovViwMAtounGhwDiCYYzHpYn
	YmR4q9adfA2cFHHIVG7GRw0iI7eYgJsEYrFt8hK93Q==
X-ME-Sender: <xms:8mEgZqhwfmWaavYh2257UGmgKTIHdfEKaYwGCPuPOR_yH9IbT2YIyw>
    <xme:8mEgZrAD46L0zSB-EVE_057womXerHTiBTXjdeVHMMo_yWgO-tWv_wWkLxzfiW3_0
    HROSfGcVDOM5WcjXK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejledgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:8mEgZiEKmU0NtN0WpITXmRQ3sgqak2QOjinkWY2S_AWfnp5vD8nUnw>
    <xmx:8mEgZjRiksJsUwbCWoiNRRI4Wnrqp4fWeOA64wR2PKoB3Vycqd0MpA>
    <xmx:8mEgZnxMwjht6WKNFTqU20VtP8Ir7_VOFaXARjAFpAAr8vgwivi2Vw>
    <xmx:8mEgZh6VqEa-Tq29gniNsSpS3tq8xrJ_KhqdGOaLzMJQgpuzpWl4tw>
    <xmx:8mEgZvd3lKjGTCM0K4D4bQYru0nwRecxQMbXjZrz-qfBD_P2s-S22FCl>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3F71CC60097; Wed, 17 Apr 2024 19:57:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a7f7d94a-f1c8-4d6a-9c65-b5de59b9f7c0@app.fastmail.com>
In-Reply-To: <55ded7c3-fbc5-4fa5-8b63-da4d7aa4966c@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20240417173124.9953-1-mpearson-lenovo@squebb.ca>
 <20240417173124.9953-2-mpearson-lenovo@squebb.ca>
 <98082080-0fcf-470f-afa5-76ec2bbffee7@redhat.com>
 <55ded7c3-fbc5-4fa5-8b63-da4d7aa4966c@redhat.com>
Date: Wed, 17 Apr 2024 19:57:17 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 ibm-acpi-devel@lists.sourceforge.net,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Nitin Joshi1" <njoshi1@lenovo.com>,
 "Vishnu Sankar" <vsankar@lenovo.com>,
 "Peter Hutterer" <peter.hutterer@redhat.com>,
 "Vishnu Sankar" <vishnuocv@gmail.com>
Subject: Re: [PATCH v2 2/4] platform/x86: thinkpad_acpi: Support for trackpoint
 doubletap
Content-Type: text/plain

Hi Hans,

On Wed, Apr 17, 2024, at 4:06 PM, Hans de Goede wrote:
> Hi Mark,
>
> On 4/17/24 9:39 PM, Hans de Goede wrote:
>> Hi Mark,
>> 
>> Thank you for the new version of this series, overall this looks good,
>> one small remark below.
>> 
>> On 4/17/24 7:31 PM, Mark Pearson wrote:
>>> Lenovo trackpoints are adding the ability to generate a doubletap event.
>>> This handles the doubletap event and sends the KEY_PROG1 event to
>>> userspace.
>>>
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>>> ---
>>> Changes in v2:
>>>  - Use KEY_PROG1 instead of KEY_DOUBLETAP as input maintainer doesn't
>>>    want new un-specific key codes added.
>>>  - Add doubletap to hotkey scan code table and use existing hotkey
>>>    functionality.
>>>  - Tested using evtest, and then gnome settings to configure a custom shortcut
>>>    to launch an application.
>>>
>>>  drivers/platform/x86/thinkpad_acpi.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>>> index 3b48d893280f..6d04d45e8d45 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -232,6 +232,9 @@ enum tpacpi_hkey_event_t {
>>>  
>>>  	/* Misc */
>>>  	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
>>> +
>>> +	/* Misc2 */
>>> +	TP_HKEY_EV_TRACK_DOUBLETAP      = 0x8036, /* trackpoint doubletap */
>>>  };
>>>  
>>>  /****************************************************************************
>>> @@ -1786,6 +1789,7 @@ enum {	/* hot key scan codes (derived from ACPI DSDT) */
>>>  	TP_ACPI_HOTKEYSCAN_NOTIFICATION_CENTER,
>>>  	TP_ACPI_HOTKEYSCAN_PICKUP_PHONE,
>>>  	TP_ACPI_HOTKEYSCAN_HANGUP_PHONE,
>> 
>> I understand why you've done this but I think this needs a comment,
>> something like:
>> 
>>         /*
>>          * For TP_HKEY_EV_TRACK_DOUBLETAP, unlike the codes above which map to:
>>          * (hkey_event - 0x1300) + TP_ACPI_HOTKEYSCAN_EXTENDED_START, this is
>>          * hardcoded for TP_HKEY_EV_TRACK_DOUBLETAP handling. Therefor this must
>>          * always be the last entry (after any 0x1300-0x13ff entries).
>>          */
>> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
>
> Ugh, actually this will not work becuuse we want hotkeyscancodes to be stable
> because these are userspace API since they can be remapped using hwdb so we
> cannot have the hotkeyscancode changing when new 0x1300-0x13ff range entries
> get added.
>
> So we need to either grow the table a lot and reserve a whole bunch of space
> for future 0x13xx - 0x13ff codes or maybe something like this:
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index 771aaa7ae4cf..af3279889ecc 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1742,7 +1742,12 @@ enum {	/* hot key scan codes (derived from ACPI 
> DSDT) */
>  	TP_ACPI_HOTKEYSCAN_VOLUMEDOWN,
>  	TP_ACPI_HOTKEYSCAN_MUTE,
>  	TP_ACPI_HOTKEYSCAN_THINKPAD,
> -	TP_ACPI_HOTKEYSCAN_UNK1,
> +	/*
> +	 * Note this gets send both on 0x1019 and on 
> TP_HKEY_EV_TRACK_DOUBLETAP
> +	 * hotkey-events. 0x1019 events have never been seen on any actual hw
> +	 * and a scancode is needed for the special 0x8036 doubletap 
> hotkey-event.
> +	 */
> +	TP_ACPI_HOTKEYSCAN_DOUBLETAP,
>  	TP_ACPI_HOTKEYSCAN_UNK2,
>  	TP_ACPI_HOTKEYSCAN_UNK3,
>  	TP_ACPI_HOTKEYSCAN_UNK4,
>
> or just hardcode KEY_PROG1 like your previous patch does, but I'm not
> a fan of that because of loosing hwdb remapping functionality for this
> "key" then.
>
> Note I'm open to other suggestions.
>
Oh...I hadn't thought of that impact. That's not great :(

I have an idea, but want to prototype it to see if it works out or not. Will update once I've had a chance to play with it.

Mark


