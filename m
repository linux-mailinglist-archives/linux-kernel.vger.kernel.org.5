Return-Path: <linux-kernel+bounces-130216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E489758C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC01F28B94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789D14F13F;
	Wed,  3 Apr 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aFgcC8Lr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752E1B7F4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162747; cv=none; b=NXwXinth60PyASV4lzkhQ7t+6o744HnzlwzNp7xi44aXexslf4LUg3w6uEfliRYd0V5DA8r2kIMeophUGF9138qki0YXTci2s4sHl4eTYbRcvSNgPvklmsNZibMU1/Ln4iI1PzUOQLWsEeli0zlTG6kAwSIXhYBpFQlUKt6Rz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162747; c=relaxed/simple;
	bh=WkOp0jt83v59PmTbpG01/8bMvUonlZp+wBHAUkpikYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvcnFbN1RjMi2/sHlBJGvgvmClT5PXyU7Q5RDmPPjBEmiPtn+w/K3nTQyjdm9KeTKIwNcrqqgjrSSbq1o2YqJV2yff44tPToVYiLyz8lgzApUH4BPeR2RDZTn8a15OdhgYUCunWAsx+pzC4PM0yUMK8m/Wb8Bs6hUlIc+GjM5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aFgcC8Lr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e61accceaso10301666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712162743; x=1712767543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BA+iBcOT7cJaTUdOkwv4QgkljAgFbNor67YZYYCKl/4=;
        b=aFgcC8Lruc7gJPA/k9vsOJ5zsM5If22oQ6DffBnywNsy6I0I/FXWjx5UwiY+yZexeR
         0YpH+mTxp828McTSJn0d94FvtXXashnWDh+5T66DnbefM+n2mQbCSOs3HrBLu2lQq5z4
         1RQzHy8VkzRbtKWXJTNfuHy7AunkmBZ3gM9js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712162743; x=1712767543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BA+iBcOT7cJaTUdOkwv4QgkljAgFbNor67YZYYCKl/4=;
        b=CegujdBe0EEM9W6CftFML8lNfOVu/2+o/WvnH/gU/ILsT1E4CAu/LkR33RvFCRSq25
         EY+eJAXVJcxFs1cDMM32Hkh3+1RMshIoSjggf3ijNjkCTHyWRp7KzdSrKgKcWvMz5O2z
         +71N0Qm+D0TIrN23M3LmMmjJSdQGCZKZDG2oxzrJDNwi75m/QRTi//CARaToP2OT6R8H
         V0LQgzD2UlaOg7KkfHeV9aMpXaRVe8im807cti7Fj36jqI1lDXilbGDaVOk5cyq3iIZK
         hm/5D5dx0KHgkSuXlqfYQnM8oEWzcJYicvHeMZMnjagCnHkSDdnOT7VmFmn+KRVRzqmu
         AeXA==
X-Forwarded-Encrypted: i=1; AJvYcCXx1XmS84YOiI4nsVw6rM/QR0gMa4pZEWg/JHEC0Ygj/GXtd5JdCVkRvY0nHipoEzoo66U+G7tRdfQQCGyluV0S6dQeWaH6ngwAUmrj
X-Gm-Message-State: AOJu0YxKmywUvqrGm0Xyf9fTJXUVnoiY/zXsegvKymAvTyYzPujk3jqZ
	nhxe/SHxgAKF9f1bBUeY0EfO483eswLbhat6HCVgoItcM275RtZWxcMKHEkSz6C1NPhG4n+MxpR
	43xjiDg==
X-Google-Smtp-Source: AGHT+IGLFrgwSNZdWL+Ki08w9YacQpahXWv+CnwE+wDplAebtFy9UNUyVtQq3AB7+JlGi+W/8Anw2g==
X-Received: by 2002:a17:907:7859:b0:a4e:2873:e94c with SMTP id lb25-20020a170907785900b00a4e2873e94cmr9913991ejc.1.1712162743681;
        Wed, 03 Apr 2024 09:45:43 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id gl20-20020a170906e0d400b00a46c39e6a47sm7985783ejb.148.2024.04.03.09.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:45:43 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e61accceaso10297666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 09:45:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjpGDGtg3pRMpMWeBw5pGaqSeNENSEooDKo9mySUWFsAD/aQPAuK80Y6L4hmvLo8dl6ZnIJknKhODe6YFMJ6RDge81gJl+iZRjAarc
X-Received: by 2002:a17:906:57c2:b0:a47:3b6a:a29b with SMTP id
 u2-20020a17090657c200b00a473b6aa29bmr10816968ejr.13.1712162742304; Wed, 03
 Apr 2024 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404020901.da75a60f-oliver.sang@intel.com> <20240403122350.GEZg1KVvsyc-Z3bwro@fat_crate.local>
In-Reply-To: <20240403122350.GEZg1KVvsyc-Z3bwro@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 09:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+Q_LXV0Y5+kBvv-5sTxT3Y7E=8wJ2sX4vzWksd3LWzA@mail.gmail.com>
Message-ID: <CAHk-=wj+Q_LXV0Y5+kBvv-5sTxT3Y7E=8wJ2sX4vzWksd3LWzA@mail.gmail.com>
Subject: Re: [PATCH] x86/retpoline: Fix a missing return thunk warning (was:
 Re: [linus:master] [x86/bugs] 4535e1a417: WARNING:at_arch/x86/kernel/alternative.c:#apply_returns)
To: Borislav Petkov <bp@alien8.de>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 05:24, Borislav Petkov <bp@alien8.de> wrote:
>
> Subject: [PATCH] x86/retpoline: Fix a missing return thunk warning

Thanks, applied directly,

                Linus

