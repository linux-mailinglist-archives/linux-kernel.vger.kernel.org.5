Return-Path: <linux-kernel+bounces-50711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C9847D26
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195F528AFCD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222568594C;
	Fri,  2 Feb 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZEdjKh81"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA25B697
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917001; cv=none; b=IeifyZoGLekndr3PVXtxyCCKQizK9W+UWR/yVOgXrSArXhiLZ9ILBaJWY+Uw7D5VfKJO2r038atWd9XTCouFUPLJqJCjg9sgFSVoI5pcwi+sCngrqIkf9lb3mZ+T74b39XFN2H6BF458iJwKcQJfSp1MrFFPu5jppB1grEWynoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917001; c=relaxed/simple;
	bh=V9SNWHDZPQxXdnt+QLityMKsnJ5V5efabUBxNJBV1ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lKhGFMQJMVz5lRx03e1hvfrjxhJZN1VZoROmgURgH1dGxLejZNlj0E4CBHW4T7QkDCQlhWo6LGhiXxIunlPqjTH5v+fUYcjqwNmIG3Ked3HHEby61ovKxHggOAasp1BrpTaVbi1qA+YQwAxlspwrXfqZsmanacnuE3B1pARkiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZEdjKh81; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51137c8088dso1589162e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706916997; x=1707521797; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SRMNOsCcbrOqX9adwJsQYa/MyESMyF05yAtCSmgC7c=;
        b=ZEdjKh8161v0s5LILKgBlWz2kdnadjzhobAX+JWN5ro6czzFsekPo4o4fzQ7RMtzuJ
         pYDglOvZyWe/wJgVYiDeYbpomu1qsGomca83EnHappy38+GWFYIWuQQsgOLlEm0DGINc
         J4h+V4jgSI02g93JqgombPCB5xRsOLXCzU2rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706916997; x=1707521797;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SRMNOsCcbrOqX9adwJsQYa/MyESMyF05yAtCSmgC7c=;
        b=UBfcjNpIQJ1UikY8rszQn2qZL2zic8y9hODOqEFQLS5QYIV+CDdkWpwFt17On9p7g7
         njAcUZiftz8ils0TsrW+fNkw5g1O7CSCx/ToTmwBjSFMKvqtcsvpuHDryx9QV7MgXAEv
         h7/TR6JtoknFb3yt6m72ZQlnrbwnkna/BONcgotRlYKwG69vR3y3CpZTJtICmaGqbn56
         LBIK019vgMmBOMMkUiyYtmrFj7Fg3VkihqOeHsAUwTdeLg0uTGi0K18JxoCnDcy2vVit
         nA0aC9iJb7Gq2mVYOKZUwC5FXorrq8b+q9NTUxsx8A5TrtEYzDvPPqUB9mEXLmBvFBfp
         54JA==
X-Gm-Message-State: AOJu0YyUx7afAhCjcF8PLH/7/i/hqTtX/m/B3q6rniA9Z/U//4/8iJcH
	KGOToZdHXUQT3uZAGwY88onWzH/5U5pio23cwqCcp3NPJEnZOgPVn9+wIGIW73H80cX5ugj9ZyU
	9li/7uw==
X-Google-Smtp-Source: AGHT+IGdvzGYzqloDEUotjrtWErdTdQporFSEhEfk7kPYphMSgQAeulrhkywDIYfxctY41C9SKw8xg==
X-Received: by 2002:ac2:4145:0:b0:511:3652:afec with SMTP id c5-20020ac24145000000b005113652afecmr2023276lfi.66.1706916997162;
        Fri, 02 Feb 2024 15:36:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVoZMrfj82+Uj4UFJFDNcYt7SrpoZOaSDySBP1tx0KEYWIx1MdtLBp4D7EhQGJcFX7fpXcyWN0BQv/fHedrL2Cq52Ng1vjiZa89dCoV
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v9-20020ac25589000000b0051005706900sm439337lfg.75.2024.02.02.15.36.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 15:36:37 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5113ab4ef05so919874e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:36:36 -0800 (PST)
X-Received: by 2002:a2e:8902:0:b0:2cf:5247:23cb with SMTP id
 d2-20020a2e8902000000b002cf524723cbmr4207675lji.39.1706916996415; Fri, 02 Feb
 2024 15:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
 <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com> <20240202211807.6sca4ppezma7cyev@revolver>
In-Reply-To: <20240202211807.6sca4ppezma7cyev@revolver>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 15:36:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Message-ID: <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:18, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> There will be a larger performance cost to checking up front without
> allowing the partial completion.

I suspect that for mseal(), the only half-way common case will be
sealing an area that is entirely contained within one vma.

So the cost will be the vma splitting (if it's not the whole vma), and
very unlikely to be any kind of "walk the vma's to check that they can
all be sealed" loop up-front.

We'll see, but that's my gut feel, at least.

               Linus

