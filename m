Return-Path: <linux-kernel+bounces-130228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B18975B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DBE28BE01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE1152172;
	Wed,  3 Apr 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hsy8gvWm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C6150980
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163408; cv=none; b=BLENyUFwl3+fWMWnPCgRtyCxnQS8Ak5MWAE/TB4/5giN9rRGAJm1P4j2Fgqopxfhqi8jfa3pT/vTgzxuUuU3E7bp9xiOyeN3sCk9ARxCvlF3ggXdVSFiAd2XZ6lDZw/tc+/rd2qe2VV51RBNI5khvysyAdtkgTMYcZuSOGu9M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163408; c=relaxed/simple;
	bh=5pdOUUNk0QN6oJLZ46GUGnM3Gj6Ge8kHKMQVFmHpCjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fusr6c9rKsUGnY+XX0YR/NOaW0aGhb3/7rzwiu6s7TeIr0nxTFFWR1jhFqYse7rPh486ib1yag6I20KuWnMEcMBrAMxhIAa110g+pry6BPToOw4LAQGPjcpy0OMuBspwB+zrSjdhXKazSax2pfM7GHkRdzuZ/k0Bj4DIhCi5Z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hsy8gvWm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56dcf805aa1so30086a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712163404; x=1712768204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iBcL9nm6pAxCV+RLg7Wh9pL8ACKC92BGseUAAvh8CwE=;
        b=Hsy8gvWmyKM2pZTO1ZriZdf2A5JUkkZlbe6JsjFkjrSNeAxTYTZgrKwojZKp8c5nDu
         j34DCJlLjxHkFVthlmovx32enBHII/mEAfnisjIeovkOYMhaxx55ZcsgZKspc/ybexvq
         UBwFtz+9WLQUg3Z2yOwQwONQWxx+dtbhGc31g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163404; x=1712768204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBcL9nm6pAxCV+RLg7Wh9pL8ACKC92BGseUAAvh8CwE=;
        b=iAe1PfVepzS+g2jY8J1eZtf0TZtcmZC1zpcUVC6bD9slDRJZc0f8wsL7sGYR2c33/3
         7MCoDIxhghfo8rrnNShwNGEm+oeHi2UMRYgDWicpPsr36khSP7W57IIcQOeSsnRfhSm1
         vUu+4wJY06HmYPFl5cqdjn709NkFRO6BhQ95cDw8ujs7Zs2YBMRU12B3NyCcWPaI25kt
         MdRTKGv+6vP4sFQfKU88we08EIjiJBjjIvB6S4Sv1Xik0xOCeVM2Dbr/uopVZLqyLwt8
         IMZrXVFYJmpc3UXzrKVjoO3kKOqGz1V9fmXXh2uhorHMFLcwzNChvdK9nwJA8c3M7Uvp
         WeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1w6FO8PucKNxBnh/xQ9zVGmr7YClWST7pcVS2vidQvgKO1elOaCFit/+YiKHVt6DOg/wa6icd4NGrtUgHh1Ue/Kr2t8uFeSLZSB3s
X-Gm-Message-State: AOJu0Yyh70dft+GDxAjVMLM3u1sO3YpJJNN9HL1ZJ59UTRl0PsR/N8r9
	f/gNvO3E/onntfJTkv33mR389dJ72c40z/kTsppGxe6Df1mr0zxn98BqOh03bp0UXkbSD8/a/K9
	kb2D66Q==
X-Google-Smtp-Source: AGHT+IHgjO0+kbmx/Tcl1lH6xu32BG/K9WmEv0rQU3ovVuGcKzTYaMVBovkl/nKyK+/5WV2PC/+DEg==
X-Received: by 2002:a17:907:7213:b0:a50:e067:e211 with SMTP id dr19-20020a170907721300b00a50e067e211mr1430016ejc.36.1712163404571;
        Wed, 03 Apr 2024 09:56:44 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709060e5100b00a4623030893sm7819211eji.126.2024.04.03.09.56.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:56:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4e61accceaso11927666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:56:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0LPvw7yitGO79DwtBCUKIE3GNaT0xAQk8RTPgUJa8z015dX6dV5FxswjehAim8qo6OmEnuMrgtCbx1RyM2ScsMDikZR2XxO8tuvcV
X-Received: by 2002:a17:906:3945:b0:a4e:6b94:7d4 with SMTP id
 g5-20020a170906394500b00a4e6b9407d4mr6495526eje.24.1712163403638; Wed, 03 Apr
 2024 09:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <969ccc0f-d909-4b45-908e-e98279777733@metaparadigm.com>
In-Reply-To: <969ccc0f-d909-4b45-908e-e98279777733@metaparadigm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 09:56:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3khqjXnHmShPj+tZvC=SyUitTZ7BkDO-rqu_aCVPrXA@mail.gmail.com>
Message-ID: <CAHk-=wj3khqjXnHmShPj+tZvC=SyUitTZ7BkDO-rqu_aCVPrXA@mail.gmail.com>
Subject: Re: user-space concurrent pipe buffer scheduler interactions
To: Michael Clark <michael@metaparadigm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:54, Michael Clark <michael@metaparadigm.com> wrote:
>
> I am working on a low latency cross-platform concurrent pipe buffer
> using C11 threads and atomics.

You will never get good performance doing spinlocks in user space
unless you actually tell the scheduler about the spinlocks, and have
some way to actually sleep on contention.

Which I don't see you as having.

               Linus

