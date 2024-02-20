Return-Path: <linux-kernel+bounces-73686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E05185C5EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68902817DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FD14C596;
	Tue, 20 Feb 2024 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gKSTKmgm"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957B41AAC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461457; cv=none; b=R8hWM4XlBGVBlW8QC3FylenxHvYe+veYwTyZujgOi5uywPrT9encAic7PQ0IeJFDCSMtaPfYluheFZt8V5GdDKreRRHm92XS8eKNinbxuUoAJRK+WIcVs74eW4B5w19Zoc64nhXXaeGN5yWU5L80SneKuh/Kq5AE/a0KsiY6CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461457; c=relaxed/simple;
	bh=pRuwmO49T63p5zDymHDgJJj2rJzTiV8lqMH38Cv+tSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5rP1SwGA8wjcbOtor9WsCch/CUD8rQYv+fumnRmnEi6Y8nboQfhHrzDn/spCSg30Txs0y87e1wlvRmNBjuc955Vi2a/Cd1RJcxgeDhE5u0iE7QTnPa0YzHAmMxAzwNflyr5i2U/G2X6skEU4sjHMCXwxHo+k9VD6uQUFjtFgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gKSTKmgm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so3867003a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708461454; x=1709066254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qI0UrHzEPl5QWMPn2t45bxUT1eHsGpTVPxHJmyF8et4=;
        b=gKSTKmgmzjn09I6nEPk/oSuACtjqIe3sN+CzFzILti0aDMuVq+eeke2m1oIjQ2hkOp
         LnWKt2X5IyTPbM65kXB1XULRPAk8CPQ7/g2LYbTJvYx+Wsa7WTO7h81Ybe5+prvdZjU2
         Qi4LBPuoiuXi8m+LUr0SSgjKDf1ck0R+iQ9KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708461454; x=1709066254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI0UrHzEPl5QWMPn2t45bxUT1eHsGpTVPxHJmyF8et4=;
        b=jZOu8H18g5FnCdlZJCH4msry1Wv2Sxy6evpuVp6W5g5rCM1b2yEriktQBcSH+CYOXb
         p69JfhHjJ/DDbsiQolZIvVmO+wDWd8RqsJYOEtB5pTIX1DF5uGlBgXaGBVHk6Lb6Krus
         QS0NKcAy40MH3lHVI39Dbs9V0uZwm49jxf18UgCGYISu+00Tof9+cpGzk+VlDQPc0+5C
         jI2rWZkknwpvUjJ+gtbADGoG4DIujcS0SXB2vkbTapJzcDqXs68i799yBYtmPwOkYI2H
         sW97ftMrftCHE6r64smWgdNJ+B/nDe1cyntbL92/yjSsMumWpagnP2C+FhRm2P4tavVK
         KxGw==
X-Gm-Message-State: AOJu0YzPesEO85Q8x9ija1lydOm4VSdpDOss7PBZPpUEAPUndgQsILPt
	qca+f/k9ceZjUz8arHq59mgSc0KW7nHKWDc+L/PWw8cqmPWaI0zs8o5hx/zEUeFKZMxYNLsUo8A
	dbXmqRg==
X-Google-Smtp-Source: AGHT+IHtlFLx6OwEKEgi4FvX69Q2pz7rbZAhfmj9imc+nZW68TplMt6prMQruNHB7GL54ngOfTLehA==
X-Received: by 2002:aa7:d686:0:b0:564:ee23:35c8 with SMTP id d6-20020aa7d686000000b00564ee2335c8mr309129edr.11.1708461453912;
        Tue, 20 Feb 2024 12:37:33 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ch16-20020a0564021bd000b00564732d1208sm2296027edb.26.2024.02.20.12.37.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 12:37:30 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564a53b8133so2677300a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:37:30 -0800 (PST)
X-Received: by 2002:aa7:dad1:0:b0:564:4221:9aa9 with SMTP id
 x17-20020aa7dad1000000b0056442219aa9mr5676634eds.38.1708461449915; Tue, 20
 Feb 2024 12:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net> <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
In-Reply-To: <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Feb 2024 12:37:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5+Sb3gWGxYumt4Sk9WsfXfqCN_B7uTXfY=jbF0fYBFQ@mail.gmail.com>
Message-ID: <CAHk-=wg5+Sb3gWGxYumt4Sk9WsfXfqCN_B7uTXfY=jbF0fYBFQ@mail.gmail.com>
Subject: Re: Linux 6.8-rc5
To: Guenter Roeck <linux@roeck-us.net>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 11:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> As far as I can tell, 'ps' is never modified, so the compiler should
> be able to just treat it as a constant.

. oh, and it looks like gcc *does* manage to do that on some targets.
Or at least some versions of gcc do. Because I don't see the build
failure on 32-bit x86 with gcc-13.2.1.

And apparently neither do you (you list csky, openrisc, parisc and xtensa).

I'm not sure why those particular four architectures - maybe it's
about the compiler version, maybe it's just about some basic quality
issues wrt 64-bit support on them - but yes, gcc does do a good job of
untangling that disgusting code in many cases.

The code was still unnecessarily overly complicated, and simply not
using 'u64' is definitely the right fix here. And while gcc did end up
avoding the 64-bit divide/modulus on x86, and did end up noticing that
n_pages was a constant '48', the code generation was still showing all
the signs of doing 64-bit arithmetic for no good reason).

We have good compilers, but that's not an excuse for writing bad code.

              Linus

