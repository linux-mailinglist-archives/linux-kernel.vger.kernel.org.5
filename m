Return-Path: <linux-kernel+bounces-161543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A48B4D85
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D832816FE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50047352D;
	Sun, 28 Apr 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AYtvcu5X"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA29EEC6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330236; cv=none; b=tb2BVvPKZiyweXbhJxc6Hrsn+jsU/I80GB4ZSKnP8y5SlK+Psd0VxItejl4xg+Jva8uL5A2DwF4cVO0Ix9+DLA8o8DmT7d7SptberRW0ok9HB7CSxwtXBus09viuvMqLgRb4PYQooqvT60B0RzpVTzxkrGICNNfPODu/U3ZbYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330236; c=relaxed/simple;
	bh=VMI+ua0sL2L95bgyIs5dyIDlZ/AGAU1djmVqBeGNFVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yfu51IIDbluz3I17jk1ix8Kx/Sbcy5ACI1lj6GJgayLlMy2vyF2aJdUATchkQh7hvaPpiEdRmbbKhHwKGKJcosiz7Pg+HGAxLGX6dPeDWCYLKBvSAKLIyjlFuq4aK1ohTUC7I8xxC5VSbp56VjQx2kWD0Aoa+qpXXi7mdAfj25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AYtvcu5X; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2deecd35088so34557391fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714330232; x=1714935032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAlC94M7he/5/Z9dYzwoM4nnjSgK1MGblRHi8mBcmD8=;
        b=AYtvcu5XqeS2npyYOdOEv6BWjDnXn8b5kKrzhBENCvx+AA8xRqmoJxVJC3a0ytdbYL
         stLeDWXS8wUptLaC4wJaQYzkc+tW0OqFh51fuqe/LqdiW2j/lRlhmN4ekDrizg6Jk0pe
         9bjW8A3waU/TJG4HBsSZ74daD4CHp1omYkUNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714330232; x=1714935032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAlC94M7he/5/Z9dYzwoM4nnjSgK1MGblRHi8mBcmD8=;
        b=tGb3yZ7Cyd/zfP8ufcYbSc3nphcwrPuqzRl45/kfR9Pt/5SJ664NR9tdQNH2Ne0yVt
         vlGZj2w/o2mu9iMUxZK4TwGZnZi1UERm1tucwWuL2P6GiO3v0Q2Sxf2nPRP3XUWlcLJk
         4PbBvc5Nw1XPzJz3nTOqDWA9OgHtySxCV9X5AII01oviA2vymfkVZXGNikTOWyEusj/2
         Hxefw+yF55t2p8kndZwX3HwVX7cFU4LGuPALleyZDiYy/fvG3hPpZCZ0sSHBrUlYVkxs
         2nQhbSRTyBYlQMBW45R/jQPJrfT3ISXsvNk955FKoG/3aI9O+6ZUIBOFUn6FHI6PLouh
         OClg==
X-Forwarded-Encrypted: i=1; AJvYcCXUl3nx0j21nMzmMzzuGOMD0tnVZsMtYi+AaZm5/ESZ7EFZXlLPpjlgvGiKzDiaAMiKoSZDbKtdQgw4WtnL5rOuhOjUAP4RwCsQ1W1j
X-Gm-Message-State: AOJu0YztF10r9EVwH6v3yyCBdCFtT+KqSjk3CBKtlDZkyPqMtIgB+2mj
	wvL779YYmBT8ACah8r32Lm++0UsMnrtniAq5mnu/gLyrTdUTvkpngM9IUyhATxDG+nTnbknaLni
	1t4judQ==
X-Google-Smtp-Source: AGHT+IE3gC1DJDRvUD+RkmR/KHAkJ4a6pTYDLBV1MomI6uJ+mOq8U3ICyzmiZprek5cw1jQDSvXtNw==
X-Received: by 2002:a05:6512:1156:b0:51b:ebe0:a91a with SMTP id m22-20020a056512115600b0051bebe0a91amr3947222lfg.36.1714330232254;
        Sun, 28 Apr 2024 11:50:32 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id r6-20020a170906704600b00a58e0d1d5bfsm2277783ejj.221.2024.04.28.11.50.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 11:50:31 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso53756766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 11:50:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU58HTgLvZheZPDYMFtw0LfX93mgs1mQRcfn3FsHhujWc4awhO+0BoOhjg5Yt/KZzL0mq2WxhnRVALjdBnsN59UT/kyPLnSF9sKr23A
X-Received: by 2002:a17:906:25d7:b0:a52:13ff:5317 with SMTP id
 n23-20020a17090625d700b00a5213ff5317mr3659858ejb.38.1714330231089; Sun, 28
 Apr 2024 11:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV> <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV> <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh> <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh> <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
 <CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com> <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
In-Reply-To: <a3be44f9-64eb-42e8-bf01-8610548a68a7@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 11:50:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
Message-ID: <CAHk-=wj6HmDetTDhNNUNcAXZzmCv==oHk22_kVW4znfO-HuMnA@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 03:20, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
>
> If we keep the current model, WRITE_ONCE() is not sufficient.
>
> My understanding is that KCSAN's report like

I find it obnoxious that these are NOT REAL PROBLEMS.

It's KCSAN that is broken and doesn't allow us to just tell it to
sanely ignore things.

I don't want to add stupid and pointless annotations for a broken tooling.

Can you instead just ask the KCSAN people to have some mode where we
can annotate a pointer as a "use one or the other", and just shut that
thing up that way?

Because no, we're not adding some idiotic "f_op()" wrapper just to
shut KCSAN up about a non-issue.

                     Linus

