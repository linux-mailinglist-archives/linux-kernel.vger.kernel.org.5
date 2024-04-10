Return-Path: <linux-kernel+bounces-138678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EBB89F8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A941C25271
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC216ABFD;
	Wed, 10 Apr 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlJp+iQE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF14B15AAAE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756956; cv=none; b=KXKs9gJQAYXwxXaf5JHqw3wyzTgW5d8//GCxwGTW1GRh5xiM8mCg+q5GWHJJ3aH8Mq5eUSdBjllkIj4OpJLDrkBL0HxZrjAs0HaXhtIZtxeZGucvD7zbQwn/VoiCQjklTXSSW4KNzFHiGr9ssQcGWtwqDL1DVnyKpNrA4AaOW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756956; c=relaxed/simple;
	bh=Cf0VIAqDSb/gy54QSip2sFyzOngRpmfL2IFWsxjUkH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAmZ5mWGZL3hE8ui2OpvlILtISmSfIGDXZ2Wi5i0ArcJvw1svcKgRNCdn5BJUZpNSY7sArSPH+pbnuksm3sHcn+mQzEDAtIW8t+1SHqy3BLZkWQLqmm+9oG+QiD8MAXJs0SJLH7xla/92i3XtFPEU0DcutFRiX1jookVyBVEFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlJp+iQE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5171a529224so4083412e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712756953; x=1713361753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+dXtCH8jnqWE5F7028nhs7r5lV1EGaD1BUvcnI4eco=;
        b=FlJp+iQEJL9f+gcxu+faG069N4li2lAVQIrtp30TJiEiPOhtnzP/5/OwbjUut1kZdc
         Fwtcwpsn/1diWs3Qcu4XJOo0tQQHUMesGFKBmjBob4WeNAcTUcjq99P/SyU9knPgauDd
         9wcMo+9apW7UVPdFgw0P3e4kfmBVVn98AoNW2BsexcusfQqrBJ5WQWl6r+m6fFKoAXOj
         D7RTBJlrUeOoFlLHFSxkHh8gYn1QaGGAbB5HtNhE6FVrf7kBur9YctVoQo3AhOiOMoXG
         gBzsrJluMHAO6f21gr1DjbG6hhWQhnQFWxczbg3mfDxaEPd6inwxZwmVDhnT+AtOZCRN
         BrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756953; x=1713361753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+dXtCH8jnqWE5F7028nhs7r5lV1EGaD1BUvcnI4eco=;
        b=SAn57q7QzW0tqaWUjDCqwaYfR/qiuIZWYAUgkjH40vuwJp1m25EXxY5s3ATE3KE03e
         6XR72fgc2RuLwEKaoAnG8dfzVYVoqS0HBpE0hlaJyoikULD9bWStcr2vwZ4Nm25wtb7N
         Fj+qrv9w9c2SZDYUbIcz5H2DqJmrdVby5a8R7RdrQ5rqtBOpiiAqc9YL3wn80I7I2iS7
         aNXxipHfnMJF4p6WS14nNxEAg2LLc4XQ8jC8KFIqlp0i+b7Rz1mlrZhJcVMBf9nUZVqG
         ce6y9XqcUelbrJY+MXvWJCeR8VUFMwt+3GkbGbW0EXhnFnPx/Qero6NLdhEBCnhv9Gr3
         330A==
X-Forwarded-Encrypted: i=1; AJvYcCVOSrBlBSrbWYgdPbM9cX0S2Y5AMNQoMTQZ7hQQ5yu/uGhBELsw3eB3uTTXXm6BDnV1pWn24DvAPiJtVWPIkt6oQSNWhv+ySKeYygUp
X-Gm-Message-State: AOJu0Yxcxragg+e57EeYdwvugKJ6KFta24yPdqyiED49v7KdJkkfy/qF
	7jKDnOx41wrwFQn6A04LXaAY+lpD3/iTr56zOFfTN6zsvXoILm2q
X-Google-Smtp-Source: AGHT+IEq60Yg/j1QJXccAfkwLpWnu8L6rfCRPNHKD0WtE8plV5slgi5KxZJiDIiouKpCZUx5yda+yQ==
X-Received: by 2002:a19:7015:0:b0:516:e8b1:9ed5 with SMTP id h21-20020a197015000000b00516e8b19ed5mr1653498lfc.59.1712756952439;
        Wed, 10 Apr 2024 06:49:12 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402048b00b0056bc0c44f02sm1156609edv.96.2024.04.10.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:49:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Apr 2024 15:49:09 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Conrad Grobler <grobler@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH] x86/boot/64: Clear CR4.PGE to disable global 1:1 mappings
Message-ID: <ZhaY1bJhBlo/MyxE@gmail.com>
References: <20240410102520.348017-2-ardb+git@google.com>
 <ZhaM2N3EONa7tNgl@gmail.com>
 <CAMj1kXEFDqaHa-St+3k3N+Ngxn=u7ovf4wfYnPdL8xzJSoiibw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEFDqaHa-St+3k3N+Ngxn=u7ovf4wfYnPdL8xzJSoiibw@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Wed, 10 Apr 2024 at 14:58, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb+git@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The early 64-bit boot code must be entered with a 1:1 mapping of the
> > > bootable image, but it cannot operate without a 1:1 mapping of all the
> > > assets in memory that it accesses, and therefore, it creates such
> > > mappings for all known assets upfront, and additional ones on demand
> > > when a page fault happens on a memory address.
> > >
> > > These mappings are created with the global bit G set, as the flags used
> > > to create page table descriptors are based on __PAGE_KERNEL_LARGE_EXEC
> > > defined by the core kernel, even though the context where these mappings
> > > are used is very different.
> > >
> > > This means that the TLB maintenance carried out by the decompressor is
> > > not sufficient if it is entered with CR4.PGE enabled, which has been
> > > observed to happen with the stage0 bootloader of project Oak. While this
> > > is a dubious practice if no global mappings are being used to begin
> > > with, the decompressor is clearly at fault here for creating global
> > > mappings and not performing the appropriate TLB maintenance.
> > >
> > > Since commit
> > >
> > >   f97b67a773cd84b ("x86/decompressor: Only call the trampoline when changing paging levels")
> > >
> > > CR4 is no longer modified by the decompressor if no change in the number
> > > of paging levels is needed. Before that, CR4 would always be set to a
> > > known value with PGE cleared.
> >
> > So if we do this for robustness & historical pre-f97b67a773cd84b
> > quirk-reliance's sake, I'd prefer if we loaded a known CR4 value again,
> > instead of just turning off the PGE bit.
> >
> > It's probably also a tiny bit faster, as no CR4 read has to be performed.
> >
> 
> Fair enough. I'll go and change that.

Thanks!

	Ingo

