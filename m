Return-Path: <linux-kernel+bounces-145709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D608A59E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED82E1F2251D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0C13A897;
	Mon, 15 Apr 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LDHfeHq5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643C74416
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205666; cv=none; b=Wdui9a8kMjEKQpGx0Rs7EQNpzIWgbLC9f5rOcA4L5jvOoLJecdjqulgGerooVZdVCRGFmvlyhnMGc32Y1qN9UnWJY6Md6dfTnSCV0izZ7wWubFUlOjQqY5xayNuNegkF0ukDG/XCCrYxjA7rpIfLcIrbHcUQ6j68pEcom541rBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205666; c=relaxed/simple;
	bh=umxCZeWTQDH3zMqqM6T6ZP1c8rPGI3duZNpIriEi1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYIibxER2nGBbr+dHcTiDvyZ53b0/2//7ax3nOIRrUNVZL/U+3UOq43oXiXQ7WUqbQ4CgCWVCWjr8uQPlHGInGME/xuidfrAEnBbNKZALQVDpMQkBeYjG2emtDBM3GvUocv/t84sldEjiC/lOnNhGz9SJSeK3UAMfBQN7Ft3uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LDHfeHq5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5252e5aa01so293736266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713205662; x=1713810462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXQXQf6BkxnxREYjP8+VxnnUlawTjdMp0f5jlbh5Zh4=;
        b=LDHfeHq5B+JNxIGW77dbjcbbOzaeVdPCCP/koOz0bmGTP0sG/sFbgBGYjXptqRksls
         aEaENnRD1y4yA7DRzNYqGxzxwDn0RuD4oPGGOm8xrMD7WbblJvbgHJ77o5lLIzloOQeE
         1FisuNJfTq4cMJzlhw13mogodePyTbmMSU60Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205662; x=1713810462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXQXQf6BkxnxREYjP8+VxnnUlawTjdMp0f5jlbh5Zh4=;
        b=em4px04nmzGwPC2R0Lu2C/yHod77ajdMlfYgDSTPe43iirAMDU2A0qIkwQ2y3vmvqm
         FGcvucWzkBFUhMwALDYAWZuHFKH0AfTLF0ZOttG+DZ8VLD2afEmQ/wAXKKkKHVIr3AN/
         qBCCjgaSPsizVIVY+9IL+ik1JV/AJ9spO/swQKaGSX8hk/xyjgoN8PozqVmD/HjTU4L+
         BdrCLLwCdEtndVZDZuymFCFTITokBh4ByPD3rdfMz6gTb6aknU7H3ZEq36dOOWt2lExK
         NRuTYz4dH/NwAZL5FzNjP9X0XEBck3Bkecm/VSKvFNfjSu6DaVc7xJ3amiYu9xPkr8KA
         DUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWFgyi+TshydToh0z5K16alHlmK0qAUb6Fcw/rTFsp1HY9pycCJJ7btB8l4dcJ8mxkHZuK/sRq/vGIwss/GHT1VU706VcXbWOhvxUNS
X-Gm-Message-State: AOJu0YxdVPJxKKAxmUpV85k3BXEWE/MAAKsTTOMV50GRUPP7u0mHtamF
	Vn5W8kF2H3K7O/7inRBuGCmIPn1kF+v4p4jE//Nl8ECk1GFYMbh+fpbLareY2SIMYeZYTj3ra55
	C7TTplg==
X-Google-Smtp-Source: AGHT+IG5BtJtEHI8uUxUzZlCrq+h65BBoo2Vi6UrHtQat/WiQTWDKG4XOKDpiAu2dMwSwiNOrLeVsw==
X-Received: by 2002:a17:907:9450:b0:a52:5df2:ab4c with SMTP id dl16-20020a170907945000b00a525df2ab4cmr3419477ejc.16.1713205662607;
        Mon, 15 Apr 2024 11:27:42 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709064a4600b00a51f2b5b1fcsm5778886ejv.75.2024.04.15.11.27.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:27:42 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46a7208eedso504237666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:27:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUATSe8C8hyatStS+uSPeW0BBdp6qixXDcDaiXCj3rTlrQvjiiM2y5eUAWc+BXXtNBVr+kuBkEVz0q1oNZtB533iakXS15ugunt9igp
X-Received: by 2002:a17:906:110e:b0:a52:320a:6320 with SMTP id
 h14-20020a170906110e00b00a52320a6320mr6421452eja.51.1713205289339; Mon, 15
 Apr 2024 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-2-jeffxu@chromium.org>
 <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
In-Reply-To: <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 11:21:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
Message-ID: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] mseal: Wire up mseal syscall
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 11:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> It isn't logical to wire up something which isn't present

Actually, with system calls, the rules end up being almost opposite.

There's no point in adding the code if it's not reachable. So adding
the system call code before adding the wiring makes no sense.

So you have two cases: add the stubs first, or add the code first.
Neither does anything without the other.

So then you go "add both in the same commit" option, which ends up
being horrible from a "review the code" standpoint. The two parts are
entirely different and mixing them up makes the patch very unclear
(and has very different target audiences for reviewing it - the MM
people really shouldn't have to look at the architecture wiring
parts).

End result: there are no "this is the logical ordering" cases.

But the "wire up system calls" part actually has some reasons to be first:

 - it reserves the system call number

 - it adds the "when system call isn't enabled, return -ENOSYS"
conditional system call logic

so I actually tend prefer this ordering when it comes to system calls.

                Linus

