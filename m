Return-Path: <linux-kernel+bounces-88653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29D86E4E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28DD1F238E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6270AD1;
	Fri,  1 Mar 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="SfmZgJMq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C86F07F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308942; cv=none; b=GaBYbhk8npmwvMXHRxH0v4VCcKQZPeEX+8cRCryB0AqNXZUkh1IYIHU7zRJvu2J8JKyyfUIh5ZvZx33EzSkWcmIlZo5TJ6aRJLHzFel1M4mCzsEJhg4I95n6nlt/vY6VGsB4rJK34UqEKPFThYvbkEPl/cWQ1Y52Bttq0juIBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308942; c=relaxed/simple;
	bh=pkYf4eVrF9RQGkZzf25TuZboi/Slpp39ldAgTSzquao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/fy+7o9axXSctH/cQ+1sy4tAC4S/XK1ABhmvVxAkKVRVM3rzXaGHhR7qPxMCVk2DwydhxFy8na/5vsJFmqYDjH94oWhR+byO4sQ2+9b9pbhDlqH/wGf8OlO/oZYr8LsP5fzRPp0qNOYp1crJsNXk/Po1eebWCjCLoqqsA1qyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=SfmZgJMq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so3023427a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1709308938; x=1709913738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oQwmGTy2HuYaucFNDSxKCc+zEM8EWrzNxrSprFrQWE=;
        b=SfmZgJMqPWw/tGE0TmozjFWaPOC68QeMrBn9vWnHqm4PmL0Z0DK5v7yQinUPr3xSLl
         AAveiXayOosfceWObUZzhw6mfqUcexEo7QNRi8k2xjxctbM6gLv6uhyLP1AUS+4tc3S3
         IMbjR7JxNagwlLB68YRS/nQLz8jMvWl3JsHeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308938; x=1709913738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oQwmGTy2HuYaucFNDSxKCc+zEM8EWrzNxrSprFrQWE=;
        b=Qzw5NtdyN1jN/ZfKwNyW48LJA8sVIVFr0IxUsZ/P15b9vodcYAOmHpiAE12eUO1pX1
         hkVZCePGAcfhyI0lhED4hks3cbMrAqx4cp73M3CZKGs2Ard2Wb4U3qrxCliCS3cnt1HE
         v7lVYFukvRCgZSJgnWIUp8mt2v1620dCSCU5vvjaC9NZn1jb2/pEsjaEneoDXPdqzg+R
         zQSO3ZCp0V1h+17jXygsjwI7XQ2abquuOfaUYgbUOVezdXMKJQuKmEGd4QCOgS5Odpdr
         mNYx95/srsi3mdq6PHXKm626xlYhntaiDQEkw2IRnRhrdWgFMUnAKVz9yddDXPvvry5Z
         HL3g==
X-Gm-Message-State: AOJu0YxQ6Zk7+sesnx+tRpQquYU1hzehPpH5TzPyZQdacBoKwXPoidlI
	vr+IZztXFEik8b/YT0XrQf3YjIlXAun86avP3BltDHS21dRlt+OXn4q4GfnjsqM=
X-Google-Smtp-Source: AGHT+IFMSdOtR26FB9Z+BTBCSfEzSfK4E9ZwJ9MuhgC+WcfQ11S/LrvadC6BSg5TLpyQCGkdR/vxYw==
X-Received: by 2002:a17:906:f355:b0:a3f:da1c:ae4c with SMTP id hg21-20020a170906f35500b00a3fda1cae4cmr1880451ejb.54.1709308938633;
        Fri, 01 Mar 2024 08:02:18 -0800 (PST)
Received: from [10.80.67.149] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id ef5-20020a17090697c500b00a449cb924dbsm505368ejb.124.2024.03.01.08.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:02:17 -0800 (PST)
Message-ID: <2fadcf62-e77d-49b4-b194-1cfa987d8709@citrix.com>
Date: Fri, 1 Mar 2024 16:02:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/boot] x86/boot: Use 32-bit XOR to clear registers
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
References: <20240124103859.611372-1-ubizjak@gmail.com>
 <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
 <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com>
 <CAFULd4a1sv7LZyT4CMCCsCxi+F9Rm0qAmSV-s=1re_1h71SB7g@mail.gmail.com>
 <CAMj1kXEg=mFe0pJyiLNVV2Am8NJadPR3M-2iAYYj1+jNyaHgBg@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAMj1kXEg=mFe0pJyiLNVV2Am8NJadPR3M-2iAYYj1+jNyaHgBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/03/2024 1:10 pm, Ard Biesheuvel wrote:
> On Fri, 1 Mar 2024 at 13:51, Uros Bizjak <ubizjak@gmail.com> wrote:
>> On Fri, Mar 1, 2024 at 1:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>> On Fri, 1 Mar 2024 at 13:39, tip-bot2 for Uros Bizjak
>>> <tip-bot2@linutronix.de> wrote:
>>>> The following commit has been merged into the x86/boot branch of tip:
>>>>
>>>> Commit-ID:     721f791ce1cddfa5f2bf524ac14741bfa0f72697
>>>> Gitweb:        https://git.kernel.org/tip/721f791ce1cddfa5f2bf524ac14741bfa0f72697
>>>> Author:        Uros Bizjak <ubizjak@gmail.com>
>>>> AuthorDate:    Wed, 24 Jan 2024 11:38:59 +01:00
>>>> Committer:     Ingo Molnar <mingo@kernel.org>
>>>> CommitterDate: Fri, 01 Mar 2024 12:47:37 +01:00
>>>>
>>>> x86/boot: Use 32-bit XOR to clear registers
>>>>
>>>> x86_64 zero extends 32-bit operations, so for 64-bit operands,
>>>> XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
>>>> a REX prefix byte when legacy registers are used.
>>>>
>>> ... and so this change is pointless churn when not using legacy
>>> registers, right?
>> Although there is no code size change with REX registers, it would
>> look weird to use XORQ with REX registers and XORL with legacy regs.
> You are changing an isolated occurrence of XORQ into XORL on the basis
> that XORQ 'looks weird', and would produce a longer opcode if the
> occurrence in question would be using a different register than it
> actually uses.
>
> Apologies for the bluntness, but in my book, this really falls firmly
> into the 'pointless churn' territory. The startup code is not
> performance critical, neither in terms of size nor in speed, and so
> I'd prefer to avoid these kinds of changes. Just my 2c, though - Ingo
> has already merged the patch.

Without trying to get into an argument here...

The better reason is that Silvermont Atoms don't recognise the 64bit
form as a zeroing idiom.  They only recognise the 32bit form of the idiom.

Therefore in fastpaths it is (marginally) important to xorl %r15d, %r15d
rather than xorq %r15, %r15.

But this instance is not a fastpath, and it also doesn't save any
encoding space, so I'm not sure it was really worth changing.

~Andrew

