Return-Path: <linux-kernel+bounces-90797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE3870528
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0591C23526
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B6D4D5A1;
	Mon,  4 Mar 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FN46C1w0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D24CB47
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565348; cv=none; b=bQYioIOYzf+A7yfm/YiXm+rmLlfAihzT7CV6Yg3BlqgYskZ3xrApR6uOtM86+8Xkv8mx6tUCdsFgsw3z2Bw85UuThW39Ng5WqGkVj+U3dMQ7mG1Il9YV0mmMjO/vZtdliH2V3SdsaBi6JAd2CGmNUaNVMoGGewQSHNsJFAsGHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565348; c=relaxed/simple;
	bh=JaftqBjRUd5OiE9mP6ElGruCPofNrsQHVf3pU9lO0lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmrS2zwIpW+8+V1KLUVEgP9qTgwaPDNJkvfor5c0JIGMWfKzEUJ38I55/8SD4wg+dn3EFbqXokhncILmna9Ry/pirw+Wqkr7WAUw+28k6uWZCzp0E6TVGa9f508AyYz/a9ntvt+CiGRUqtFfBvpTrw8p5EQyMOqQMtLvOv8kfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FN46C1w0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56693f0d235so23481a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709565345; x=1710170145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaftqBjRUd5OiE9mP6ElGruCPofNrsQHVf3pU9lO0lo=;
        b=FN46C1w0opZL3pGHIueXrQM50J/X+AFiedCy/K528RxK763i+sQCdC2uY7bnXfK82f
         A9+2zCM8hCtu4sp81xtJiNEq9IT19WJF3WtakgIMRd51hXxnRJHQzxyvmbuQ1+FC0Y3B
         8pKg7oWwCsIoqYfQs6WG9XRykmZIFoNaSWAm+VaIpupWLR+PVfWh2G8NOF78d2EuAngy
         BGI46NV0vW/PofhoEtOAm1e2T2wmcJd9GtWDpdyA1ZJeEkohbbX4OtAH+YK5pQkafxMR
         hCIlyk2x35x50+RvMMaG/pt05FsHcJTTan01adb5a9qfyxo0VvXozafRMfkHs7PKV7Th
         tu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709565345; x=1710170145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaftqBjRUd5OiE9mP6ElGruCPofNrsQHVf3pU9lO0lo=;
        b=KIb6fJqvQ+J/dx1t1BDuUnxWJTgSoKzWbpzg/m/Usa7HY8r2qvGfbnA0Q97lbiJcrr
         0eOhFzlGItJalOgUZSgdp/3e/rWFd6X3Cwr8omEepbdgN8h//2EPcOCDYVzMoNKQGcHd
         KpYTz4HzPXClbADsAbjag6hHjcaAPSLmDlu+QGgXQPeME9U5xStnAfQYUxufnjQe7m0v
         /DddNlKLM457WrTj4goH57jD4vHTxszUXIwr3g1rsa70gWyaVunm++2zoJgfR10yu407
         7VCbmzCxRTqC/MWhgHiUTOh1/6+mUdGK752ZCSMXcbkQi2Dh68GNKZAX2yTzioowFelZ
         LQRA==
X-Forwarded-Encrypted: i=1; AJvYcCXpSsQuk2Jhmav6BEk+dUZdBmp4BsJpQLbBYDcnH1ZC/kN5CUA4aVQ4BEcq/RvYuB4dMQa2/Ijm5z9H1V2uti8pS4jhv5aGtaUQOczT
X-Gm-Message-State: AOJu0YwgrMs4khds9MPPevvpfuu/b8zn+BMRN8qnUXDU/AdS8/Incqxz
	y8QwqVlT2ZUJfluuVxKxzDiIlALIDbsoC8N955dUKqqnrZYDBTQNPRiXHsFAf0JoimPK9SRDu9C
	ewVcunipjtDHJUHIzyz/w7ZktKO1ugYVL4dtb
X-Google-Smtp-Source: AGHT+IEtc8iFkUDhfxTXSKFmqZJRm6+dqGzN80jS12Vcq179DqSiAJDtL89r2EpdoV8ru4yX3BzzCTnXQuN4tukZYxk=
X-Received: by 2002:a50:bac2:0:b0:566:ecde:290d with SMTP id
 x60-20020a50bac2000000b00566ecde290dmr291227ede.4.1709565344548; Mon, 04 Mar
 2024 07:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
In-Reply-To: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 4 Mar 2024 16:15:07 +0100
Message-ID: <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: gustavoars@kernel.org, akpm@linux-foundation.org, jpoimboe@kernel.org, 
	peterz@infradead.org, dave.hansen@linux.intel.com, 
	kirill.shutemov@linux.intel.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, nixiaoming@huawei.com, kepler.chenxin@huawei.com, 
	wangbing6@huawei.com, wangfangpeng1@huawei.com, douzhaolei@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 3:02=E2=80=AFAM Jiangfeng Xiao <xiaojiangfeng@huawei=
com> wrote:
> When the last instruction of a noreturn function is a call
> to another function, the return address falls outside
> of the function boundary. This seems to cause kernel
> to interrupt the backtrace.
[...]
> Delete __noreturn from usercopy_abort,

This sounds like the actual bug is in the backtracing logic? I don't
think removing __noreturn annotations from an individual function is a
good fix, since the same thing can happen with other __noreturn
functions depending on what choices the compiler makes.

