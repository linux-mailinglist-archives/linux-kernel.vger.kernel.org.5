Return-Path: <linux-kernel+bounces-41980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F279F83FA44
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E57DB2212A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762A3C490;
	Sun, 28 Jan 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U3FCvQDV"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BD3C46E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706479691; cv=none; b=oceLlGXhGrU36iWFwXCIacfW2WuswXDs++8ad7Zh0FZzwziqcfoQ7FVYZAkFlVlglS6i2WKWt3qLDu5pVciqN4BIp61qWp5+VWxl5kUYL9MJoupWak9o0YQ3XyHad8dtY4b8hFnYzCsuqdyPUBSSo0atLviRZtJ0YTbvtBube6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706479691; c=relaxed/simple;
	bh=QrkyxoSXHYJTqgfXOZsbnZEyWO+kRuXGCx6MVdeKjaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LODkBP9qHg0z/f7wouckm13xz6L17qGWAL706N7VOHOijZuHy4xyLQFzw5H2u9V+3XX+YE88yXJ/UOl88Zq6ezNlnbNf11RB8do+YubUQhIk6jMDk3HQCxYvoMA/eXxWPI2Duln5xyp1lbSDhzftHMNdx4/Cj2aoyf6xj+tK4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U3FCvQDV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a30e445602cso665740566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706479687; x=1707084487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4w5EVcmzkmBCRT4EQRf6hOGTNZV4Vu2foNdqvfEoib8=;
        b=U3FCvQDV8wlDZNQrqgPMR6yoI5S4khe4tysgj6L1hYlLrS8Yp2vPLESMrGSTMsSNFH
         1YrqbYeyaCyP9sQ2P6H/4qOcgNYURSTigbIB/fxKQDgnXnrKqIGetSyt+iFkXrg9zyU0
         7D/XwV8lW5yjohpaJATlmJFH1UnSln/8DreEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706479687; x=1707084487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4w5EVcmzkmBCRT4EQRf6hOGTNZV4Vu2foNdqvfEoib8=;
        b=GD7PV9kBzNlXL4FaH2WYLNMiuw1oigo0mLRGWzxO4OWicAkX79X/fFs9lBEuiqbcTx
         p7mRmwF6b1Gmb5cMonXwnQJzWL7sU82Oi5FNpBToB4ooXO1AiTO8zQG9yjtuljzZQb3B
         DB2AzjeZk7TZ9xWZlEsQ7ZSJIRLsc9w3Nn32xDSLHuR3pUhC7oLO42/8D0GTwx6y4mUv
         uAPEqnCZsVwQxW5ha2XawKm3lp1Az3sPGo/jQfVOSdP/2QPGmZTJKfg1wb7ceTRjniw/
         zT3j/AFncSGf3GPF9er89K+XlNaEDMJKidGMoXJp+SEL7IagzqiTVdY1KSWEgSn1IDKI
         RTIw==
X-Gm-Message-State: AOJu0YxPbVDFnOku97EY0Jdxsva+ilkp4cnS4qpMD3lCndmOLjyY9ocP
	6yvqE437UQHOkZTyCGYY7TO2/w6yF3RkCgftcsaUDbSFAKk41rAG551EyU1/Hv4f7nru7fLXIUY
	8tiN1LQ==
X-Google-Smtp-Source: AGHT+IGf0v3MbxPBKv2/TQUKYnFdaHwzudROjqzA9n2WuShbFFN/QCFBdM60YXZe45w044QESVI1Ww==
X-Received: by 2002:a17:906:387:b0:a31:818c:ffe0 with SMTP id b7-20020a170906038700b00a31818cffe0mr5520146eja.19.1706479687312;
        Sun, 28 Jan 2024 14:08:07 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a3543718f5bsm2073282ejc.221.2024.01.28.14.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:08:06 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55efe051e4aso422215a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:08:06 -0800 (PST)
X-Received: by 2002:a05:6402:94a:b0:55c:93c1:4a50 with SMTP id
 h10-20020a056402094a00b0055c93c14a50mr4633321edz.13.1706479686311; Sun, 28
 Jan 2024 14:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
 <20240128161935.417d36b3@rorschach.local.home> <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
In-Reply-To: <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:07:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com>
Message-ID: <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 13:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That's just wrong.
>
> Either you look things up under your own locks, in which case the SRCU
> dance is unnecessary and pointless.
>
> Or you use refcounts.
>
> In which case SRCU is also unnecessary and pointless.

So from what I can see, you actually protect almost everything with
the eventfs_mutex, but the problem is that you then occasionally drop
that mutex in the middle.

The one valid reason for dropping it is the readdir callback, which
does need to write to user space memory.

But no, that's not a valid reason to use SRCU. It's a very *bad*
reason to use SRCU.

The thing is, you can fix it two ways:

 - either refcount things properly, ie when you do that lookup under your lock:

        mutex_lock(&eventfs_mutex);
        ei = READ_ONCE(ti->private);
        if (ei && ei->is_freed)
                ei = NULL;
        mutex_unlock(&eventfs_mutex);

   you just go "I now have a ref" to the ei, and you increment the
refcount like you should, and then you dcrement it at the end when
you're done.

Btw, what's with the READ_ONCE()? You have locking.

The other option is to simply re-lookup the ei when you re-get the
eventfs_mutext anyway.

Either of those cases, and the SRCU is entirely pointless. It  really
looks wrong, because you seem to take that eventfs_mutex everywhere
anyway.

             Linus

