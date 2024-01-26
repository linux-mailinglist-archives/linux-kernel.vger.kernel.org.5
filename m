Return-Path: <linux-kernel+bounces-40561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F246683E276
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319141C21AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466802260A;
	Fri, 26 Jan 2024 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hiPcoD9v"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8001DFE4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297141; cv=none; b=f6qi7n1JQoDPsl0HZVIW4Vv8lbuhlDVVgoC4xqAH64APd3cF6RXAT/MZofNMYXl7krPcWqHT8Q8H6OrTYXQhs+7ej/AjgNvzGJYjXMCYa4y6z5wAWg0jU5NpszN1lYCtfQmCzywIUN+BszrseSMD3mtTW6xvuG6GOCJy6IoXcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297141; c=relaxed/simple;
	bh=rUiNaZKR3Iuzu1fK+xJ+TVad4AnomEYlxpttSGZqYUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN45H2ofIZQhMCSeiXHbjWdGfCxNmBM94vN0l9J1c8+8QL61Mp+zZbNbU51/LntZ89h1Z3SRk01LYEybLgpObmhJyC4UeUELQFD7+SyP2U8snk56m9mY5SSazaMiMoXcVZp9vnShFhlKo8mwC3ND8E2gW+CBC5YTJdlq7IPKeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hiPcoD9v; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101055a16fso855413e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706297137; x=1706901937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVgLLemGUp0dKHDCBdd+B6bdetHWY79sotP32hy6/1o=;
        b=hiPcoD9vgOxA32Ms8HIo0WBEpyioIENu0tg6MfaHyINAlsUSK/bNeN6CJdztgJ3GZV
         Gj7lHTWT0kvHzhmTWbdm0yIBDNIdPBPvkIg6ECyfsgzA0bWxsDRCFm2t2HwpkJQ98Cc5
         E1LLN87wmaRunhtx5wpwe77fbYgxhjYVYnaHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297137; x=1706901937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVgLLemGUp0dKHDCBdd+B6bdetHWY79sotP32hy6/1o=;
        b=doLeTwdLSEUOaWj3doBSlY9ERmoQyQR9IlBdwn6jizF7thXz7ZtmzTJ6pClnJ/jcAs
         ANJYiF1RsSsdYKwTcPjq4dm0XVN85janEVAopU6Wbt27PX88wdZcZtHE9xp0prl+uOTy
         KfL3euyGf1Z7q89RX1YRcETLkj5uvM77Q3tgQlmhCKyakiZmxJ0Z60aLJr11TuXPsBcw
         NVjYUamiwhLCWxMJdHi+LC6nrvR6H3HhrKZNcAY0uHuxKUnKQaFlDhCYKijSGfx3HVK9
         a+dItlzmnFjxDmzzLdU/r4xUyKNdn/TPGDtHokH7uFsYn1N8V0QXnVxPfedQ5NST33ZC
         rK+Q==
X-Gm-Message-State: AOJu0YxavlmxUs9BKtHsO7HpVGz9x10sy7/dC4zMwiWhylOv6Jdhc8Dc
	PtJPerNBzu4pIKZNrGLARGkhxNvb4fS//8HBR7APOZQaZ5QeH2mCEPtp0jpTWX4NLIgbEEmjaC/
	UdKy+2A==
X-Google-Smtp-Source: AGHT+IEeNbX/me87KxHE3MjsmUa/KgKQLWWYfqmYwhTPDp8ttn7kXfRjdgDLihJ7JOE06eQZnF6XTg==
X-Received: by 2002:ac2:4564:0:b0:510:253f:32d6 with SMTP id k4-20020ac24564000000b00510253f32d6mr95751lfm.32.1706297137186;
        Fri, 26 Jan 2024 11:25:37 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y1-20020ac255a1000000b005100d4e7d02sm263149lfg.27.2024.01.26.11.25.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:25:36 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf4a845a76so8714601fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:25:36 -0800 (PST)
X-Received: by 2002:a2e:b8c4:0:b0:2cc:a67d:fee6 with SMTP id
 s4-20020a2eb8c4000000b002cca67dfee6mr236974ljp.39.1706297136223; Fri, 26 Jan
 2024 11:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com>
In-Reply-To: <cover.1705946889.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 11:25:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
Message-ID: <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:34, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc1-tag

I have no idea if this is related to the new fixes, but I have never
seen it before:

  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
ino=5737268
  SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
ino=5737267

and it caused an actual warning to be printed for my kernel tree from 'git':

   error: failed to stat 'sound/pci/ice1712/se.c': Structure needs cleaning

(and yes, 117 is EUCLEAN, aka "Structure needs cleaning")

The problem seems to have self-corrected, because it didn't happen
when repeating the command, and that file that failed to stat looks
perfectly fine.

But it is clearly worrisome.

The "owner mismatch" check isn't new - it was added back in 5.19 in
commit 88c602ab4460 ("btrfs: tree-checker: check extent buffer owner
against owner rootid"). So something else must have changed to trigger
it.

           Linus

