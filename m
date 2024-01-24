Return-Path: <linux-kernel+bounces-37513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9383B128
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686D81C21E14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036612BE8E;
	Wed, 24 Jan 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K4mXIT0y"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5C12AADF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120998; cv=none; b=WcwY2R1rKwkN3zwWw+rnwj5UtGZQ9gTVPoYeWcow2FB9pqHl31gYNQtDIxAEt1qiypbhxq80BR9zEa4TE9nKT30vAP+n9w0IZsvBpMncrNVf/+NP4pu144hH0/eQjhhkt7sU9hrAX6pcqzUd1y7IOpYIWX40OVCqt3Ticd7GJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120998; c=relaxed/simple;
	bh=SW6iKvLIfjtPb7161k0Be90L2EGbRQCt76qGG32t4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCGxmcg8cm3LIcIFYGZPWoPGOTi7AJdVwR5vT9fylLUpdod7hUcDL/kWHwtNKaMGKV5LlAdozL6Tp/herDYtj6C+3B2XO+80ETiWwQLk9DdxCVXBinhaWzGGR9OkWPgCXrwOg5SYVFJPhRwhcoY6/nuBi6CXWqZ5QOiJv+/WDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K4mXIT0y; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5100cb238bcso2607991e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706120994; x=1706725794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0V0EohxWvuuUENl0m42DMDVa8sdRi34P5EyN97xnskE=;
        b=K4mXIT0yfeheSgC2LsLz2nHgNl6thRtk8zzRl3uwJozdi/FHPEAnDmrgy5q5NqAaMd
         mMED7fGAoTUmUbxgRZstGmrd8nk0duTbUE/qDyZK9uVGZHeCiiNr9t35GunDEfpIvrG3
         D1pJqA0VSY/ee7n5PDo+So61y+Hb7M05u/syo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120994; x=1706725794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V0EohxWvuuUENl0m42DMDVa8sdRi34P5EyN97xnskE=;
        b=S1t39vb0TcI1j5LDFTkRIUJQXvrcoNO8kAdFEPN2R7rPCo3ATNidoklFkt/ZLpQmab
         6BvEIWy1QzuhhxnRAq2wQd+mJQjbTWqeeGznd7qm5fMOuZZhKlOt9HijeLNXk5qD9PI0
         3ZawkOuDO1ldD0YvtSNW6LY2PTKWHd0pLxc/7Re5vtX6t/4LACH2S6q6ubcOTpu8aZ1A
         zceVzwVyKdUm/95CKlbagwuqmP3HUnrP9PCNyjETPF9xGvywQ9AVUD0GopNfaz24yRzh
         KbzG++0Aqa2uxAPWPwBxrnufCLIQBZnWf1OUWN+Pp6VePOC21DnHsIigL/wZ8nWfF1F4
         F6Mg==
X-Gm-Message-State: AOJu0YzxVSgCl6rCR2vHtxmYN/tNB42orjaZ2uh6sPluTjVfkwlqKNUB
	hYhssedDv5Jemp8iAQUACdZ7M66tL7NT2Eov/Cg58SKAdJMzSAriJxGsEzG4am/uGvWkSTxgIH+
	PVYKoaw==
X-Google-Smtp-Source: AGHT+IHtf3kGf4Th4RR5Kepe1kKJtjnR/Q4rzB2o+w95H3rHrOsiX/64pe5KkTCf52RzB1qHFI7QlQ==
X-Received: by 2002:ac2:5d31:0:b0:50e:6d96:4b32 with SMTP id i17-20020ac25d31000000b0050e6d964b32mr2972704lfb.71.1706120994529;
        Wed, 24 Jan 2024 10:29:54 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d34-20020a0565123d2200b00510125c8d7dsm195173lfv.140.2024.01.24.10.29.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:29:53 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so78167871fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:29:53 -0800 (PST)
X-Received: by 2002:a2e:be05:0:b0:2cf:784:d3c4 with SMTP id
 z5-20020a2ebe05000000b002cf0784d3c4mr1264354ljq.35.1706120992964; Wed, 24 Jan
 2024 10:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
In-Reply-To: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 10:29:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgx71FcBsPF_sWoGAHyL6ohG8NRtCdPEqOt1jtSpiJN5A@mail.gmail.com>
Message-ID: <CAHk-=wgx71FcBsPF_sWoGAHyL6ohG8NRtCdPEqOt1jtSpiJN5A@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 10:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> UNTESTED

. and just to check who is awake, I used 'file->f_flags &
__FMODE_EXEC' in tomoyo when 'file' doesn't exist as a variable.

It should be 'f->f_flags & __FMODE_EXEC'.

That way it at least compiles.

              Linus

