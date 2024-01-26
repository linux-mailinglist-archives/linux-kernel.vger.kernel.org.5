Return-Path: <linux-kernel+bounces-40782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C33C83E592
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EA51F215A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C917250FD;
	Fri, 26 Jan 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PpQnaLrF"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001654BC0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308594; cv=none; b=NjhyH6tWHtmdXwYJh4NvQGJDcGooDIvVnQiJLnbcWbGDgEDaNWEGx0lZDL41uGaci9bIJ7xMTsNVUzG6OVfRSkDfPm791K+c/PPPRdingtiTErf04DhXuk5Zw8YFQG0fWjpvIHhbMP3h55+wPDe2kXy37X3v3B1goizFh7GasIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308594; c=relaxed/simple;
	bh=TuLldHRMoPdhbvg4tAmasRPjnDmfBZBh2qMiSNy3aIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOuCQ/BOHc/eFbrPMMwEPEkypK6PhMdCCE7c4qa1r88eT/UmHn9HulNvzDl3nIXETgcwATnlnfQZ171grh/buDJVwnvTJ11IQ8V1qm56hsSWsl6R2pVVFJwSljZSg4YeCErg1it3AoKm9xk0IRYyXgbNqA9MV2khIdohQa3JlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PpQnaLrF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so83741966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706308590; x=1706913390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vb86YnCobjeOJ1buOfJZ8O/sRnmqyBtak+zDHciKpI=;
        b=PpQnaLrFhwvHKLjwPrX3w0S0GFitSutYIKMHGe/Xb8n5kUgWcriDKfDrSqnRoAlenP
         R++3lIhpFDBg0KWd1NjPC3wQHlwHNbEllaz1KLctTAiQ6gJ9svUHyX+iZsBspI+JwlcV
         m1/N2pIqc4GuNq8hn9FaaL1QWmvgrjWo37P5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308590; x=1706913390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vb86YnCobjeOJ1buOfJZ8O/sRnmqyBtak+zDHciKpI=;
        b=r2VnyvZQA1YUbj8boT202h56Bz2atEE0YRdMP9EHctk23U13NhwO/R85LJmX5hEl7P
         PUTt0FQ+R8q16PbPKjBtgUA3q3BGMnZrg4Nrt2g3paml4rgFe7U6e2pxxI1GC7iGSJD8
         MYhvN67dkLEPA/OEux6fUw8ole0dkGWqNS5QiWCxKqpjZlsk7TzjsTbRu40eQtOYk8+c
         cqkGby4PpnFp/6yfl3yCuIWvnuubUWOR3DPT2xpAkgb+cVCaxuBn2B/W/xH0H+7lSqUt
         hQYfhGsBgf3kn5jsTLbJ4ZPqDcaXtZ7YsQ+bxChVWe/97Jjy/1PVjLH/Fys+iAN5lZTo
         mAAg==
X-Gm-Message-State: AOJu0YxNz17ftXW4CDPR6bTW50rBz2pN2huAzscI0zEhg0+Fx8ItBbuf
	a1R5OmR/m+dy/RR6cy14456Ua3bNpDB0hu9Qx//hWJ2QP2VpNWBc7ShxrHxxWsA3vOe8i14SLJC
	53IgxQQ==
X-Google-Smtp-Source: AGHT+IFeQxcqhEiVu5E6IRaugmrzcoqvTYQVVLvb+u2ITiftA0wZ8Xm3dysl31SVLS1T2opAkCnCMg==
X-Received: by 2002:a17:906:1c02:b0:a30:d5ae:2833 with SMTP id k2-20020a1709061c0200b00a30d5ae2833mr248775ejg.56.1706308590613;
        Fri, 26 Jan 2024 14:36:30 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906085300b00a30c4871712sm1062268ejd.202.2024.01.26.14.36.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:36:30 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so655951a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:36:30 -0800 (PST)
X-Received: by 2002:a05:6402:180f:b0:55e:825b:724a with SMTP id
 g15-20020a056402180f00b0055e825b724amr263564edy.16.1706308589610; Fri, 26 Jan
 2024 14:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za6JwRpknVIlfhPF@work> <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com> <202401261423.7AF702239@keescook>
In-Reply-To: <202401261423.7AF702239@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:36:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
Message-ID: <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:24, Kees Cook <keescook@chromium.org> wrote:
>
> I think xe has some other weird problems too. This may be related (under
> allocating):
>
> ../drivers/gpu/drm/xe/xe_vm.c: In function 'xe_vma_create':
> ../drivers/gpu/drm/xe/xe_vm.c:806:21: warning: allocation of insufficient size '224' for type 'struct xe_vma' with size '368' [-Walloc-size]
>   806 |                 vma = kzalloc(sizeof(*vma) - sizeof(struct xe_userptr),
>       |                     ^

That code is indeed odd, but there's a comment in the xe_vma definition

        /**
         * @userptr: user pointer state, only allocated for VMAs that are
         * user pointers
         */
        struct xe_userptr userptr;

although I agree that it should probably simply be made a final
variably-sized array instead (and then you make that array size be
0/1).

               Linus

