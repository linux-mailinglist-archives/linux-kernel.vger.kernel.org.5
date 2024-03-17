Return-Path: <linux-kernel+bounces-105393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E589487DD4C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DC9B20D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83E1BDDC;
	Sun, 17 Mar 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5LLc2Ga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0511BC39
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710682962; cv=none; b=Iao3FSDS+p0Bfo+wUo+GKXz6P+fxM2EVdjSKtLxwZzq4AoCKEA6iJXXpyGKFlhN+jMpQsW/2B+CeOuVvHg5vzVkhBS08wLHFMRtsn/HG0D/SGihmAJQbISeFrSiMgnbB3ujupxjNJbfm2CUtZYWYA8gklSh6mnQvXV2wilLtuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710682962; c=relaxed/simple;
	bh=HKn+wSzPxAgbDRqOBP1YPX1DBZwiZhj/zwBVkf4MIT8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fEC/qepZtOL7rLs47TeeeaTOyRT2G5SlhDrYzXDyDuF4LugDJHT3tsQGUaqlTijLKe4B7kDZgO+MznS4NZMKiHWgMpqufVs2DQxvOMuFG7jm8q4LMQpzudZHUSZ1tEYjOgaJGm2RHtFhDP2P6N9KYZOHuczXyivxRKdWQW3mlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5LLc2Ga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710682959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lE5LN5pRZ0/6bku3pPgtdVGUxkTbfetlBUflbCRYp0s=;
	b=U5LLc2GaSJii3cskHwJBxQ/PVHW8HT/N0nYn3Rezsuh7FmdezNcnbZairDX2eT6akNxqj+
	sKofR86lVoTIBm4xg1WiCFXmBkjvL1O+E8NSqOAoJaJmOrerDDxNYrbJARHxBLNv4juYiI
	qCU5i0kDdzRv68A682bNNLqkpa/Ojl8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-OA2gBvg8PsGrVyn-DCSyQg-1; Sun, 17 Mar 2024 09:42:38 -0400
X-MC-Unique: OA2gBvg8PsGrVyn-DCSyQg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d4a8dbf2cbso2164501fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 06:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710682956; x=1711287756;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lE5LN5pRZ0/6bku3pPgtdVGUxkTbfetlBUflbCRYp0s=;
        b=HKI5XE+THolY4KHQ6B/dkuDNODBeU6pUCMQmgRLMZH+MilYlNEvhbV2KN+rkOIp7Px
         JHCBeewDE1dfFqU7AX8xIdoxkQKLUejfJpLQxE+kN+xPu8Ax0uiTLkYMclLATqRRaPqq
         34PxFOG5fI+Pnk0VDcS7AxuDwOK1KmzVl6Ey4i5zmtNuJT2cqv7J23+8kOc0vBec5lD6
         CQ4Vo9HVzezfxEoq8KrH+DUQGIbDCnrYX/pDWB3MQZCLPpLNYsGKTflYUaDhiHboi1hR
         UmkpLoqfZR9N9NTmFhhof2r9X1+LmGZLxpVTDEsB8NuCDRYKfKX931lHhqUvQm9At+Ox
         2A0A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/QiffYvphcHImXvPXMkNKSIIhHUykhE6zGIE1LHr1QARr3Ewutz9++Tf7Jnq1ixLqb3cDnp0nvvKWt81Q7JnXcyGgMzfXSq4Q2wm
X-Gm-Message-State: AOJu0Yz+i6DRAV/WZUKGtoEW79oEs0ELhFG3IPCpXFcDybXPKUOnvobt
	6NMqLWjxneTjJVAh+/jJHgBtE+ZTizu/OLQkN7Jl5t6bjShc7IqZ9AoP4s12NRwZVSq+DiTnRjI
	OS4BbvlYd/4kU4vXJf6WdhN1LOeTjV3Za7nBZVw1Of+mTPN7qIMnttXa4Ng0ZUQ==
X-Received: by 2002:ac2:4db2:0:b0:513:e223:1959 with SMTP id h18-20020ac24db2000000b00513e2231959mr2789150lfe.23.1710682955901;
        Sun, 17 Mar 2024 06:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjeOo1KY2AdDRh6n3lebXG2sP7191wBJ4E4igHb0tO+gu4DHNA7iMBFowVrn06ww4A3teZ/Q==
X-Received: by 2002:ac2:4db2:0:b0:513:e223:1959 with SMTP id h18-20020ac24db2000000b00513e2231959mr2789134lfe.23.1710682955497;
        Sun, 17 Mar 2024 06:42:35 -0700 (PDT)
Received: from [127.0.0.1] (93-45-170-156.ip103.fastwebnet.it. [93.45.170.156])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709067fd100b00a466782e438sm3787263ejs.139.2024.03.17.06.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 06:42:34 -0700 (PDT)
Date: Sun, 17 Mar 2024 14:42:32 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
To: Marc Zyngier <maz@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
CC: Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM changes for Linux 6.9 merge window
User-Agent: K-9 Mail for Android
In-Reply-To: <32892705-1A39-430A-9553-DBF254C723E7@redhat.com>
References: <20240315174939.2530483-1-pbonzini@redhat.com> <CAHk-=whCvkhc8BbFOUf1ddOsgSGgEjwoKv77=HEY1UiVCydGqw@mail.gmail.com> <ZfTadCKIL7Ujxw3f@linux.dev> <ZfTepXx_lsriEg5U@linux.dev> <CABgObfaLzspX-eMOw3Mn0KgFzYJ1+FhN0d58VNQ088SoXfsvAA@mail.gmail.com> <CAHk-=whtnzTZ-9h6Su2aGDYUQJw2yyuZ04V0y_=V+=SBxkd38w@mail.gmail.com> <86cyrt16x6.wl-maz@kernel.org> <32892705-1A39-430A-9553-DBF254C723E7@redhat.com>
Message-ID: <2A3D1FDC-CFA8-489E-AB00-FCE3FA36400C@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Retrying without HTML=2E

Paolo

Il 17 marzo 2024 14:34:02 CET, Paolo Bonzini <pbonzini@redhat=2Ecom> ha sc=
ritto:
>[first time writing to lkml from phone so I hope the formatting isn't too=
 bad]
>
>Il 17 marzo 2024 11:36:37 CET, Marc Zyngier <maz@kernel=2Eorg> ha scritto=
:
>>On Sat, 16 Mar 2024 16:01:47 +0000,
>>Linus Torvalds <torvalds@linux-foundation=2Eorg> wrote:
>>> > You can also make CONFIG_KVM_ARM64_RES_BITS_PARANOIA depend on !COMP=
ILE_TEST=2E
>>>=20
>>> No=2E
>>>=20
>>> WTF is wrong with you?
>>>=20
>>> You're saying "let's turn off this compile-time sanity check when
>>> we're doing compile testing"=2E
>>>     https://lore=2Ekernel=2Eorg/linux-next/20240222220349=2E1889c728@c=
anb=2Eauug=2Eorg=2Eau/
>>>=20
>>> and you're still trying to just *HIDE* this garbage?
>>>=20
>>> Stop it=2E
>>
>>Well, if you really need to shout at someone, it should be me, as I
>>was the one who didn't get Stephen's hint last time=2E
>
>No problem with being shouted at, but "depends on !COMPILE_TEST" is actua=
lly something that *is* used for "maintainers will look at it, it shouldn't=
 matter for linux-next compile testing"=2E Most notably it's used for -Werr=
or=2E
>
>When Stephen reported the failure, I should have noticed that the bandaid=
 doesn't do anything to fix allyesconfig/allmodconfig=2E If there's anythin=
g I can blame you for, I thought/understood that you would be able to fix t=
he failure between the report and the beginning of the merge window, so the=
re's that small miscommunication but that's it=2E
>
>>I'll try to resurrect it as a selftest, or maybe just keep it out of
>>tree for my own use=2E
>
>I still believe that "depends on !COMPILE_TEST" is what you want here, bu=
t yeah keeping out of tree or even under a special make target is an option=
 if Linus disagrees=2E
>
>Selftests have the advantage that they can be marked XFAIL, but I am not =
sure they're a good match here (also because the flip side is that I think =
XPASS fails the run)=2E
>
>Paolo
Paolo


