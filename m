Return-Path: <linux-kernel+bounces-125901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DBC892DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B8E1C20DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A049381DF;
	Sat, 30 Mar 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ft0qMpZG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99322069
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837947; cv=none; b=l77b8FAmwJ8Y8V69wffkCvCFVgIbXNyD9D+KiXjKsaajQzhtMiSZh018iDhqaIb9s8MJeW44fHVNxLZLN2WcMjRahR5Ly/fg6UvtYYZGLJj4Rf5QX4zSmgKr0fmjfbfUsDmzib4zdYpvdQ4mgJNLvK1RTa7cDu6tdZPcfO+JDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837947; c=relaxed/simple;
	bh=U43Wuq55vMxCLBzqGRdkR/mMGx+zO2GmUgWVZu6Gawg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC2kKYr7hZxlvL4KY6eIEyVXE7a7fBRrGhPrDC0/4KsNGWlhsMhIj4cXEGurZOT0YSKrAxzHJWIz9Vk7XbeQZguP+jmFM20dS23QbMdlZHlCeFtpqxpfuheSfe6YkBVGB1lsv0z3cmlb1gvf8abB75czUYTMAg6dXTIlGZM4UfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ft0qMpZG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515d55aaf5aso767217e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711837944; x=1712442744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh7m7AzKE9zxgcmaZLpWEMMQFO2AQlI5WB3LlhW1I44=;
        b=Ft0qMpZGU9No1lDtNY6m+QEK9VUB3iCBlXDau5eoyGUjPfc6s69wYnViDKOvrtDhts
         4cteyZ0It7eEa6xzoND8JiNqN5EYI1zb+xyCXMFw7oyiXZJ0e159qI4flnyp2Dpvbz+y
         8Jle660pX/0lAxvng8Eu5kDc0+bfz5sKol1pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711837944; x=1712442744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qh7m7AzKE9zxgcmaZLpWEMMQFO2AQlI5WB3LlhW1I44=;
        b=lfEMUAM+dMfzcY41f91KYBX547+RMogvPRR0PjQthWIlWhVSHWzIbwu7sEvxNquojo
         LB9IdfqF7Sm8FICm+WmB0pCA4jmHGzgIViUkkm15cPbsACrO/Rzo5Ja4vMs5oNhVcgk4
         MkJO/+y/904AjaDmotytwZxTZYGjgskf/j7JctLiERKKeT6mWpapV9SWD0H5wQZZb3k7
         HOoUrseuSrH/0v6ScKt5HBJWm+BiD7Ck1JaRNkxYirwQYQrQLNGH8/h0UNxHsCFv5eGP
         IS/GcKEr7g5izm/yG0edogzyieh653U0f9kVQKXlzLaTIVqtVBE4TCOvy6jxqr1H/eMH
         ev9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgHYXXaMb6fNrOJJkuIza8qYpc1wrqXuou0RBLd9Do6Wm6uoSeDMn5CZg335KAstRhbrKrj9lW9iFwGMP6S3Kt/FUIil/G0L/oEC+Z
X-Gm-Message-State: AOJu0YzLZA9EfTj3MVzMmppFC5ocFfs2cesfB3JMWxpoPSgYJbsMrUBq
	Ui28Vf1vt9y7O8yuAVV004t7K0Hb13QJkre3vxhFl5oFMRgoG9iI/yjP/HVDzEP9wcoG+G8rh+u
	O7B0=
X-Google-Smtp-Source: AGHT+IHoEYY8SM7e1gU0DYFywT6hL16F+O6qLec/790twgFmLR5wjHT0zheJNExGWw5wy0xsQ6bvtA==
X-Received: by 2002:a05:6512:2389:b0:515:be10:e288 with SMTP id c9-20020a056512238900b00515be10e288mr5056125lfv.21.1711837943767;
        Sat, 30 Mar 2024 15:32:23 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h20-20020a0565123c9400b005132bdbcbc5sm1002577lfv.135.2024.03.30.15.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 15:32:22 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so34088391fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 15:32:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpZgzHfgiD06oGxEh+SAIJtRDeaSVAgKt6Q0rmso6FMfCAg/o+v5pJRZERHqSsk56AxUVqxa6akcQBhVuIML+7SL24kKzphr39Qi2L
X-Received: by 2002:a19:5517:0:b0:515:90e5:4555 with SMTP id
 n23-20020a195517000000b0051590e54555mr3507469lfe.16.1711837942133; Sat, 30
 Mar 2024 15:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143838.15076-1-jarkko@kernel.org>
In-Reply-To: <20240326143838.15076-1-jarkko@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Mar 2024 15:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
Message-ID: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 07:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc2

So I haven't pulled this, because the subject line (and tag name)
talks about tpmdd, but this is clearly about key handling.

Also, the actual contents seem to be very much an "update", not fixes.
And it doesn't seem to be an actual improvement, in how it now does
things from interrupts. That seems to be going backward rather than
forward.

            Linus

