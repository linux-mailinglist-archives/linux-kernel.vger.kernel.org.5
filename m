Return-Path: <linux-kernel+bounces-23946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F82882B449
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE071C23439
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAE4524D4;
	Thu, 11 Jan 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hGPI6AfT"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17F524C0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so6546843e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704994973; x=1705599773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wE5ZuBbJGZvm1+tXWIds9qs34jd9tFXTLXg/uz/Nfmc=;
        b=hGPI6AfTrIFUGvVvZYrrxh9N00hZDXya3xpRJAPAXO60QdOMZbQf8Qcc8gjXc/mRMs
         907GFs9/cSTUIXbbWpVL2bdmy2fILqJRdwkpXUvqHhHDNPZIhXY1N9fzFG3QhZwPI3pY
         ZW+bhOMsf8wkcJQ65zXjA/iNFYgt+j1qhJ9IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994973; x=1705599773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wE5ZuBbJGZvm1+tXWIds9qs34jd9tFXTLXg/uz/Nfmc=;
        b=Uc7maWdLCL6NGM7NO6uStML8UxKgC35CBMgwxraKt113i2xZJ4B698x47MjpHncz7M
         zGeQTN/QqiAr5XxMFB1kZ9BQwNtymgbK/hdJkm3rw0G6R79nQJBr0Dt5tEwz4JKFB+io
         yncIs1fdZyjyCI25t9in3ZyhIl5Lvyg+F6jyH+eyUw2oEz+OpePJmk+5oHnDNidMxw78
         LUMrcObwgE2ThhU7ewV0R6MBrhgtDuB7qVCTtzCNjLIYZPe9KPiCzkexsuvzwst9+01N
         CtsL8Rr+tdS2zeYjpGfLMXKEez08zaCMeCqbDGRL1khyNFOBkMMXd9zg/zZBkAXLEApb
         NDGQ==
X-Gm-Message-State: AOJu0YyPK8xd1ubGkKbex8SripfHpkIXgu6Pu9Py7FkrGzf9QUY50Q/y
	3NDii5zbz6KmgqDNQtQyV3HHgB5PenK+hVupiuCTJa4e1RvTs9Jm
X-Google-Smtp-Source: AGHT+IGXTlOHRo9UWHjWMTsf6A3+O6Ebyw1rWzx/Hzqj+uBWyl1KFTDBBINeUyUvNb1CuAjhVESPzw==
X-Received: by 2002:a05:6512:3e06:b0:50e:35ef:681f with SMTP id i6-20020a0565123e0600b0050e35ef681fmr25876lfv.139.1704994973075;
        Thu, 11 Jan 2024 09:42:53 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906524b00b00a233515c39esm827172ejm.67.2024.01.11.09.42.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:42:52 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2ac304e526so489767766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:42:52 -0800 (PST)
X-Received: by 2002:a17:906:318a:b0:a2b:9580:c447 with SMTP id
 10-20020a170906318a00b00a2b9580c447mr11535ejy.110.1704994971881; Thu, 11 Jan
 2024 09:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401081028.0E908F9E0A@keescook> <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org> <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost> <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
 <20240111094711.GT1674809@ZenIV> <20240111100501.GU1674809@ZenIV>
In-Reply-To: <20240111100501.GU1674809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 09:42:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-aMO1GuN1odOz4MZksMNECVdrORuXKfqSS9DoTx0yDg@mail.gmail.com>
Message-ID: <CAHk-=wi-aMO1GuN1odOz4MZksMNECVdrORuXKfqSS9DoTx0yDg@mail.gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Josh Triplett <josh@joshtriplett.org>, Kees Cook <kees@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 02:05, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Something like (completely untested) delta below, perhaps?

No, this looks horrible.

This doesn't actually get rid of the early filp allocation for
execve(), it only seems to get rid of the repeated allocation for when
the RCU lookup fails.

And *that* is much easier to get rid of differently: just do the file
allocation in do_filp_open(), instead of path_openat. We'd need to
have some way to make sure that there is no left-over crud from the
RCU path into the next stage, but that doesn't look bad.

So the "path_openat() allocates filp on each invocation" looks fairly easy.

It's the "don't allocate filp until you actually need it" that looks
nasty. And yes, atomic_open() is part of the problem, but so is the
fact that wee end up saving some flags in the filp early.

                  Linus

