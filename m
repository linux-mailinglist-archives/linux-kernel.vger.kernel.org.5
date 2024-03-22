Return-Path: <linux-kernel+bounces-111827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA3E887159
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E93B22144
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E760EEE;
	Fri, 22 Mar 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6L4OSWa"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951760DED
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126391; cv=none; b=YL7U3RCUCtC3LBmTKLOn0sQboXcXQwnw3+0NeeZ8SAJgVjX0f+xadj+HXvuOiQVG4DKK1knz0kWqhdArQBfQqqMM64Ej2du/5TLww34RQkVKh8Y+DzeF11oZtkxlNzL5LvKCunBNrt7aaF8Id1RnhnWP8MA+Gbd+oIEDLizqui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126391; c=relaxed/simple;
	bh=3irpeDcqAdDpE2rqLZI4qYVJh+S1lvekoao7Dv5Osgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s71IKW6dr8eI6+rY4t8Ui+mRAXhv7UypW2hYhgeyUloIMoVxGefRxsLpQe2QOOU/BYt5v6oAcn6PGqdmyQY2gkf74sl+bzMGYYXJGvSjy1homyqoUkr01qlmoWBOnWr2C29kFcPfBp/7yruAzkblyUx+/efYHjcWcJE4FV9J9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6L4OSWa; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609f1b77728so25486947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126389; x=1711731189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nstuaT0LN40IL7s6uLGDUdwXoJs7igsYUfqeeJ04Rw=;
        b=Z6L4OSWap/EZnwoBmzQ+KGniZ7b06wBl7WDKF/J+qNZNMn3oNYYd0NzZonEXBmpvy0
         Bl+OHFmoO6aYZy47DFPHWMiSXTsAHm5e8XnLEq2zLr2xeBtnmr08ib1+Rv/nCRoVxWIX
         repk3eYYCjesw9V8MRKdSSfSyK8GL6TKmpqEonwZ8g2Ma6IVYwGlNjpuIgQlriNBXB72
         OuSm2TXqE6/roLyAYTWy9j/i4H8zIqf95d6DZNqFLDqtXwnMxlBiyFbNt1t1NAmbaNXm
         IbXflP0GxPVQlJP/FRb0qJtdX2iR47qu80NIJw7Li8qKGnX3vMa1eUixPyJ7cBVXbCFN
         1ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126389; x=1711731189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nstuaT0LN40IL7s6uLGDUdwXoJs7igsYUfqeeJ04Rw=;
        b=uLkyEqFd6KodYaBx/LBw1f2oJ/Zl98ras3iXeM+PWrCPZ1UbIftcV+9fwSXcn44hdv
         Rmvuq8syWsKE/DiY/37iv0R55k89v1Yc00BYFxmjvcmwYBfy/1PUtWt3JYS58Ni10vx5
         wjZgzZ25eOrUKXISMgJur/KpI29t3stbzIzZVC92eo+oMy8NzFizz6tuis8RqpP1RhzP
         VcAnJxjpxo05AKcWd7okPebGrbTvA+QZSTzcPN0JGc7F1SM5/5TvJvvYJUQhMoxUpxXV
         B5G3v2Qhvui3T+zP5jVz0otCiKzujTO/DrkRXuV8gazsJEXA1L/fBooEwmPtzSD3rFrq
         3z3w==
X-Gm-Message-State: AOJu0Yy69/nC/ynOSBVNyCbmQ+cBiyztxL+iuFbM937cYt3ceR6PD5a/
	YudB5QOM7SN4MUsnvhcAmOm8slE5m8NUuCrTY1BT1+VsKiyueZu4PStSmGT1u5ZgN3nxc+6Uf0R
	MGsL/QZjQSHok4LR0spkZaWlEkeI=
X-Google-Smtp-Source: AGHT+IH9d7BeHhQEKhygz/6EACJboD/Ap8ZeN4dWpquqlHGM1RCDuzxnHQHXz4+7g++JUJvjL/5i9dDdaiNJjdFVK0A=
X-Received: by 2002:a0d:dec4:0:b0:610:ed33:98d0 with SMTP id
 h187-20020a0ddec4000000b00610ed3398d0mr191587ywe.17.1711126388751; Fri, 22
 Mar 2024 09:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140433.1966543-1-hjl.tools@gmail.com> <264400cc-ccb6-46c5-b054-403f6b82860a@intel.com>
In-Reply-To: <264400cc-ccb6-46c5-b054-403f6b82860a@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 22 Mar 2024 09:52:32 -0700
Message-ID: <CAMe9rOrZ8XDoeDru+zm1ad7NsLHgkD1cm=CL==uhWY4OqqQGJg@mail.gmail.com>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:49=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 3/15/24 07:04, H.J. Lu wrote:
> > 1. Add shadow stack support to x32 signal.
> > 2. Use the 64-bit map_shadow_stack syscall for x32.
> > 3. Set up shadow stack for x32.
> >
> > Tested with shadow stack enabled x32 glibc on Intel Tiger Lake.
>
> I don't think we should wire up code that's never going to get used in
> practice.  I think I'd want to be sure of the existence of some
> specific, real-world, long-term users of this before we add a new ABI
> that we need to support forever.
>
> Are there real users?

Were you talking about x32 users or x32 users with shadow stack?

--=20
H.J.

