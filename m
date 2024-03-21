Return-Path: <linux-kernel+bounces-110546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E704688605D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993A01F21FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366A1332B7;
	Thu, 21 Mar 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EKNc5zkK"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92512BF3E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044782; cv=none; b=ZZF3sEbPnIL1YYHCQefOeXY0E2c9WcWX+PaR03/ic9kQlg+OGodAOEwrHluT0LYT80aceYAOHQH4aX1y3xBhvwSg0quXSCu644IPwKgHhJaLiURJDukY4ObRsOve/1n8ohrNnSD2pVkn8GD3UimRw5eqQMJ5HEHT7p4s9gVQirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044782; c=relaxed/simple;
	bh=WXQ931QfJbmec5vuyVH/cqzWhVr3qlsdOAwdRqTWd+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3DMHC3ZHqs0Az9qoTsTGrS5piCJdAcmstbJYKFhKle7oUXjhEbH4LcVHtRGp/NKjaQfTBn0Uc5q1WiY6q74v5/V2d8mF3Sh+P7Au33fDTuG/eABaakt63VgsD0qJvdtAugE9Q+43JKby+SdwIrkdP9e0fwhrm7Iofup5cXXjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EKNc5zkK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56bc7b07df7so1752786a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711044778; x=1711649578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q/wQDn+XrvGaKVfjTo2fVVoUWFJ48sLRKpaxsdz0AY=;
        b=EKNc5zkKgMG9XHfk4b9qDpEF8wgHF72IgUyjjEZf1fOWZ9oB9mKu6Vk+qmca135pcA
         OVVtid2jZESdtHuj6pyYTefPYLC8TpWSCvNUYvBG79y39oFxEyjyry6NmRouSvyafFOG
         IjF30AxN+a/XCuHrfgj0k3QSmj10zVdZRDlt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711044778; x=1711649578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Q/wQDn+XrvGaKVfjTo2fVVoUWFJ48sLRKpaxsdz0AY=;
        b=VG2nWhzq7NB4r2psw1hpP3wy5RLRepyZOVQ0Umhrp9PW8b26L+kYg7jfCmMQCsJb0D
         Z3kv6pUytYx1gQfa0GujOhSz+3Bn8MOL4wq8yB15/CMRRTSuQ7turmXtAPmUtrmurcDn
         BXvvCTlaVrMPsLzlu81RMslvKr801+YNw9Lr7j5rEHn9WnNxayQPloXa/GAt7TuUAvmh
         yIxSA5e40U1t83Rip0q+elLsJcP8gsy8VkWdyHmY6u40JJdnchWEnvilaeXBdOgFV0+4
         l/mf/EKk1L5BluQNMzkxd3dHEQfAfC80cXdxb99TK12rVYq1gXqNVkAKcNASZgiTqRS5
         4sSA==
X-Forwarded-Encrypted: i=1; AJvYcCUZn+4jB+SAV0SAQUL5ao6gvcEcszILLao4SSjXjXVyPlaayVKbsDsFaRb5zwxQM1dQR1dRENBHwW0fZPkB7R73RSycu79P9yFu23nv
X-Gm-Message-State: AOJu0YxXFfxYS0y1xMY/f9pNAjx3MEsT7eSO6qirsRvukMH3gvpkz9/Y
	ZzUZDd7d8YxTLzA4d7XkDe/Xww1lIJdCF0Bxz7Bk9c5UhlkNuH7h5YJZsBtijXRV40LcXnuUUJ1
	jlO1+Cw==
X-Google-Smtp-Source: AGHT+IHbCujvGh6coAiH0W3tUGvH+8VNldOn1bG+FmtAHxK0Qpnpa+D+MN4OYOApf6E9fpDIaQIakg==
X-Received: by 2002:a17:907:76c5:b0:a45:f9c5:3024 with SMTP id kf5-20020a17090776c500b00a45f9c53024mr2947563ejc.11.1711044778484;
        Thu, 21 Mar 2024 11:12:58 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id d3-20020a50f683000000b00568d7b0a21csm129882edn.61.2024.03.21.11.12.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 11:12:58 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so229872866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:12:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/GIxqtL5+ezteFBW2pQrDZDJIa5hhWFO4hoJN+4nKMMT++m9xaIsm59XA+s8EiYV1jmb4GQsALey99A9hM078OQ0QOT1P5vY8uQ4u
X-Received: by 2002:a17:906:6d18:b0:a46:8846:5ab0 with SMTP id
 m24-20020a1709066d1800b00a4688465ab0mr225246ejr.2.1711044777393; Thu, 21 Mar
 2024 11:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfwv2y7P7BneKqMZ@kroah.com> <20240321134831.GA2762840@dev-arch.thelio-3990X>
 <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com>
In-Reply-To: <CAHk-=wgGhgkEngBBureLRLKe7mQ-sRhYngUQNvxEUqR9mmc60w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Mar 2024 11:12:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyOUaDohM3z5vqxjRdw-vo5sfE41VuOfckKq7=_yBJng@mail.gmail.com>
Message-ID: <CAHk-=whyOUaDohM3z5vqxjRdw-vo5sfE41VuOfckKq7=_yBJng@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 11:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the "labels without a statement" thing is not only a long-time gcc
> behavior (admittedly due to a parsing bug), afaik it's becoming
> "standard C" in C23.

Actually, let me take that back. I think it's only a proposal (WG14
N2508), I have no idea if it's actually going to be standard.

            Linus

