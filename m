Return-Path: <linux-kernel+bounces-23756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E40082B147
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2045A1F242B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278304B5BA;
	Thu, 11 Jan 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ofI72sB"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B004D128
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbd7d60729so4544179b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704985349; x=1705590149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXxf4IYdHRNOCXV3BfrCT7sMwSBwZiXUq0fFiawq+m0=;
        b=1ofI72sBfEKFrbfIddPIRvLj8hXMWN0CnoJ4dz79C+ZGTD223cAwDJ3iJqrf+whd5b
         6gW3DniKA3biV1yPnPe6wp2bsa+ujFUNcqnVZp/V2k5UUvzpnU9dD+9xWO09h+phigd9
         KsyP0k1gZ3nmTu9xXcoJZcOGey5Y0gZgbTaj/rgMEi/SQtU8M1VPMIHXubzzlx414xLq
         oWBc0IRabVp069qge1YpkKnv5MLKeOyQ/ygwejIpDOw0LchPjdTFEp4SckvhGDLU8zib
         FVVBcZieOTAedJ7lc8ztYbeN2+F8VcFP1igmu3K1I9O8fcQsO28n8A/jloIj7txDSrmx
         XdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704985349; x=1705590149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXxf4IYdHRNOCXV3BfrCT7sMwSBwZiXUq0fFiawq+m0=;
        b=P/D0IB8SpVJ7gxlfd/w3v3ljb0OpwCX0087Qk7nuig7FN4laXBW5+iKBfuMJvFb5yn
         IGWKRVJ78bD1udkWEIkOO0P8eZPE/JPBwqH5UoX1NfnJhaP8i5SsKVaBY+nqz6i0wnvN
         KUAPWI+wXAKRF2TymRRS/ITFdyugUKI1hrTHbbV8irG0L/7OD3UESgUACgG5JWSd6+W/
         YmiKOer52nrXQjjKhsWv7Y/DWcyso2MGy/0BRYhU2oD5j2pjorfp+o1XK3xuqsTJLc8S
         jffCd+bNUMB9FPmKbxAMrD0iiOaKXEyAwGYgZaMlc1MRBijQCVy2UYu5vujN0wvNfBUC
         Oakw==
X-Gm-Message-State: AOJu0YxAi1Xd5JbHJFaJXPoI8OwG5BMGSefYC3cHXSZVFEm93X130+2D
	al9z8PhjgJmeQ4C0z3plWVR3nr8/dj31VDo7ui8simCJ6izn
X-Google-Smtp-Source: AGHT+IF93tOujgWbRonD2nfYrfu+/PBOD6H5SB+QWbotDoP6sUofoL00lp3Jp385fPeLA0Ayoam+fRNgK03LqW/sun8=
X-Received: by 2002:a05:6808:1152:b0:3bd:59b2:93fd with SMTP id
 u18-20020a056808115200b003bd59b293fdmr321214oiu.68.1704985349083; Thu, 11 Jan
 2024 07:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401111558.1374ae6f-oliver.sang@intel.com> <b1adbb1c-62b7-459f-a1bb-63774895fbb3@I-love.SAKURA.ne.jp>
In-Reply-To: <b1adbb1c-62b7-459f-a1bb-63774895fbb3@I-love.SAKURA.ne.jp>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Jan 2024 16:01:49 +0100
Message-ID: <CANpmjNNgCt0pByJhEhViyCQXk_9_1a-KfVjQcx4rSFZtuZNe9g@mail.gmail.com>
Subject: Re: [linus:master] [kasan] a414d4286f: INFO:trying_to_register_non-static_key
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: kernel test robot <oliver.sang@intel.com>, Andrey Konovalov <andreyknvl@google.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Evgenii Stepanov <eugenis@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 16:00, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack calls")
> calls raw_spin_lock_init(&alloc_meta->aux_lock) after __memset() in
> kasan_init_object_meta(), but does not call raw_spin_lock_init() after __memset()
> in release_alloc_meta(), resulting in lock map information being zeroed out?
>
> We should not zero out the whole sizeof(struct kasan_alloc_meta) bytes from
> release_alloc_meta() in order not to undo raw_spin_lock_init() from
> kasan_init_object_meta() ?

Does this fix it:
https://lore.kernel.org/all/20240109221234.90929-1-andrey.konovalov@linux.dev/

> On 2024/01/11 16:29, kernel test robot wrote:
> > [    1.582812][    T0] INFO: trying to register non-static key.
> > [    1.583305][    T0] The code is fine but needs lockdep annotation, or maybe
> > [    1.583887][    T0] you didn't initialize this object before use?
> > [    1.584409][    T0] turning off the locking correctness validator.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/b1adbb1c-62b7-459f-a1bb-63774895fbb3%40I-love.SAKURA.ne.jp.

