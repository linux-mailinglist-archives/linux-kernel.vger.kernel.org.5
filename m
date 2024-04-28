Return-Path: <linux-kernel+bounces-161549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF068B4D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480F91F216C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202374438;
	Sun, 28 Apr 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TGuYhJnO"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F473176
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714331631; cv=none; b=CQV+ksQloJVcwIuUcN5FwBSCdKdU6OU0eD/DoSD28SHOnPJcH4xD/LQYAnE1VHgngxaC4JfrCRnP1kN6k8J7kU4oe8xBOIJQRAJl73XkiTl888kqfvnvo3j2lGbWVDYC1cJq0ejgHi8QfJN0v3BHySHUWmb1VKCkKwL4t2I2nXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714331631; c=relaxed/simple;
	bh=M+kIdKV83CeWIYfNFH0404fY2395INVzEpA9SjmBJdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+OPwlqv1tUV9FG4ZQri5/HOjM8KQMvkWy7CmJaVRExBq5fHVHdpp7y3q5M8W+eEuZ0Do1Zk/VwJo7pKqFUviGJHxIW9a97mp7KukiJH9aiDoj9tLIP7CiuexWxESID9e60MO0Neewqbt0YQ9bMZs5GrHQRjzaOCKrme/3vG0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TGuYhJnO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57258c90899so3936118a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714331627; x=1714936427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9DYSc62j/dkZT2dYI+dTqeBrvYapxz40+LCqscPcm4=;
        b=TGuYhJnOxzQ7VqCo3xgDcSxtHSnvRy/D7MGZse3EemPPR62o+NH0WXddNYn9C5Ms0D
         GlFPrG0fEkgrqPx18rJWcLKz0dy/vKD0HpZZ3P29JUwygP2ZPrrDXSobYiWEzkex6/eA
         W/XwLHhEwc14RrcLTXt7qun0bdMWzyhZP1N2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714331627; x=1714936427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9DYSc62j/dkZT2dYI+dTqeBrvYapxz40+LCqscPcm4=;
        b=uSsvnCABosAxoYhUHH0bHqAJabQTx3EPFUCcDBDcpXLf5D9deE0iCzNp9gDiSLoYt7
         KvkemgtPXCK4IsDOS/P+QlOBEcdc7S/D210TNzgHRjCD/Iw4EG86Y7D/jeT2d8iSYFjv
         w70i5CLSTInO4w9Qw8+W4vtXNHaSGZ6pkmtgPzpir0LCe8ZF3yH5IR+sntgYDL/+dnTe
         3BgxaLVChwwqZJ28TY0FhZVGRSunjrJex73i0ZqcBnq86CukfEKv6Srh0woXtIUWwmts
         synHtqKuU22AG4gPIJcO0jmY3Pzv/qhiTAIeLUU/WqkYvkuIcLefi8ihxGDX5URDIC6H
         dfiA==
X-Forwarded-Encrypted: i=1; AJvYcCXKKE89vYhSf/Lmzcc2YDRGNiI0j9Cp8bnGTxXqpOyECvWxt6C8kvHprj1bpdkEJO8oFevgA9ttr+Nfs4M/Yrt2GAhn9NsskLb2Ox5R
X-Gm-Message-State: AOJu0Yybk1OZfOMfPGhJep8+O+b0UhZb2kUCpuq26zy60mPce1ktu2uw
	h9Vy5MkPY/M2BbyzMAvMlMZ7PypJkomx5ehuve9/sr981JUO3tiuZ854/6YQhioXOjhbTsLdLJ1
	X9iaqOw==
X-Google-Smtp-Source: AGHT+IExDfeKCWN9l5n72lDqnK3BQmgs8NdDuZR9h5pknVrrCMJZw0lIAxrTbqKMYh1ILbx58Fwy5w==
X-Received: by 2002:a50:99c4:0:b0:571:ba0f:fb8a with SMTP id n4-20020a5099c4000000b00571ba0ffb8amr4797908edb.1.1714331627363;
        Sun, 28 Apr 2024 12:13:47 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id t22-20020a50d716000000b005726e206449sm1898611edi.24.2024.04.28.12.13.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 12:13:46 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58e2740cd7so229679466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:13:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDcrnPkTjQkSI0O/jx/SDjGvyvkyCZHKYof9gVnUzvTUnuqeE+om2Umb8obyeHDcKNUKkspLPnzBLBQWqQikuoZGve2TZcPJXnyBFB
X-Received: by 2002:a17:906:370f:b0:a58:eb0d:f2a6 with SMTP id
 d15-20020a170906370f00b00a58eb0df2a6mr3535098ejc.31.1714331626134; Sun, 28
 Apr 2024 12:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi4HyMFJBwm+JIKZ@gmail.com> <Zi4MBjmqMr0Ndwpf@gmail.com>
In-Reply-To: <Zi4MBjmqMr0Ndwpf@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 12:13:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP1KA8sg9=PVTs7Xj_AC7yDpLujB6Sw=Eofg5Jtn0ymg@mail.gmail.com>
Message-ID: <CAHk-=wiP1KA8sg9=PVTs7Xj_AC7yDpLujB6Sw=Eofg5Jtn0ymg@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To: Ingo Molnar <mingo@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 01:42, Ingo Molnar <mingo@kernel.org> wrote:
>
> Merge note: in case you are wondering about the timestamps, I ninja-rebased
> these two commits shortly before the pull request to fix an annoying typo
> in a commit title.

Hmm. You also forgot to have a diffstat..

               Linus

