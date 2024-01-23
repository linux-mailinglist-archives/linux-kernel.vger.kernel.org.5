Return-Path: <linux-kernel+bounces-34586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1CF8381C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DF41F26995
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AC26AFA;
	Tue, 23 Jan 2024 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YQcJEBiL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22121340
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973179; cv=none; b=UqYqOXsakLPS3fdGO43Z1MZ5PXDRtrEf0NmAVYZZ+BngbAyZ+QRrbRTnEY3dWP9dn5tmZw0yF656WKQo/uDtu1TPq3km0KJ3uUBaX1H++ejzZV77eGaHhb46ANZ5zBHsxLYvTNZDZBaSRZqt3p4cyFn63Jq/fJr/bJRxkUB8bB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973179; c=relaxed/simple;
	bh=wO0luKUt6JJ8AteGlx010Dz9fgA4X/MUoSN9b3z/WkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7y8vX1r4a+nTQIYsjfXHVXrQ13mLuAIZJKqWJHDskIlO++lCug0X1Yq5r8+y/Bg8ehCwAhupq6XCEuLToR242aLjVd3ONzYheW4hzrGKIbstPX5oaPG9XDwFvtG6LlrX5Z2X5NH1DlQKMeGUt1EF/9wLChEhqpsvQOyy0/+kiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YQcJEBiL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso48779655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705973175; x=1706577975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=br9E5KI+nUh9y1ENUcsXEpHmHOk92uTJMp6hh/0UfzM=;
        b=YQcJEBiLB0ZbsyFZe8/2Qomtgtxpf2IU4vGdzapqL5Y8/5bjpsaPT+yKGlxr1swRqa
         MjV3s6QYmENiI+kXlaB47irMQxWuo9lrxBlufBimwPd3i6Q9sUsSUM2mR5o3nK86zeT+
         bkzgLdAm69OFLaMZ4r6OviFUZjvycJYPWnFhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705973175; x=1706577975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=br9E5KI+nUh9y1ENUcsXEpHmHOk92uTJMp6hh/0UfzM=;
        b=kRe/OjMp/M1Q+xgsuvvuXTI0a4TDlPPB180R7MBhwJKn3zhstP7rCYG2s1UJoRiVdn
         rxx6lX6fwGZ7DmYO8j7GviOTwtKWiKSpQczbPydqA9zgF57esNzwb3h2XiehEna+xgDc
         1ZXTxE0wZ/bksqL6u3wznwq7ZQEuAa43h93f0xaODi9D2lRAcFf91fIEQ5I9jrQwAuQm
         Y0/W/paB443AKzdx/WtMUjZ8bndcfIT2p1kjbZVPDHDTPpHc4IVeiE59m/YhGDVu2LMF
         UGfIkZRsYXPgjQesHCmNAPqQkqGvoGzf670DnVQJEHSeP6dtPe/xaDTT4RjCD/grGPDV
         brtg==
X-Gm-Message-State: AOJu0Yxqy5ljqSCHF8fi8OzxDUck/n8P6ygRr3Rzl3FUkMk4cQ9pBnlY
	6jDbcOzal2dt5WR0IKJF/AkPSUjN5mOkuygDvrv4jJKhQUkJ0C8/ntbjqMrB2yIpSdKWtTd/cHi
	fglom1g==
X-Google-Smtp-Source: AGHT+IHLgqHA4qvrJHSmMK+DXdDBPZT/voQPn+1bGpHGON4m4EzcCTiQG7yf3noY4/Y+GEW/nBoBZA==
X-Received: by 2002:a7b:c8c2:0:b0:40e:5659:fb0c with SMTP id f2-20020a7bc8c2000000b0040e5659fb0cmr61066wml.165.1705973175095;
        Mon, 22 Jan 2024 17:26:15 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id fi15-20020a056402550f00b0055c73b56bb2sm385730edb.29.2024.01.22.17.26.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 17:26:14 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a685e6299so3815845a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:26:14 -0800 (PST)
X-Received: by 2002:aa7:c887:0:b0:55c:6df8:e18b with SMTP id
 p7-20020aa7c887000000b0055c6df8e18bmr400918eds.12.1705973174033; Mon, 22 Jan
 2024 17:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122180605.28daf23a@gandalf.local.home> <20240122181547.16b029d6@gandalf.local.home>
 <20240122181901.05a3b9ab@gandalf.local.home> <CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
 <27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com>
In-Reply-To: <27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 17:25:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9XK=TQ7tk6+2ymx8Upm6r36vY6wF9REpt1sho2ySteg@mail.gmail.com>
Message-ID: <CAHk-=wi9XK=TQ7tk6+2ymx8Upm6r36vY6wF9REpt1sho2ySteg@mail.gmail.com>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at ttm_device_init+0xb4
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 16:56, Bhardwaj, Rajneesh
<rajneesh.bhardwaj@amd.com> wrote:
>
> I think a fix might already be in flight. Please see  Linux-Kernel Archive: Re: [PATCH] drm/ttm: fix ttm pool initialization for no-dma-device drivers (iu.edu)

Please use lore.kernel.org that doesn't corrupt whitespace in patches
or lose header information:

  https://lore.kernel.org/lkml/20240113213347.9562-1-pchelkin@ispras.ru/

although that seems to be a strange definition of "in flight". It was
sent out 8 days ago, and apparently nobody thought to include it in
the drm fixes pile that came in last Friday.

So it made it into rc1, even though it was reported a week before.

It also looks like some mailing list there is mangling emails - if you
use 'all' instead of 'lkml', lore reports multiple emails with the
same message-id, and it all looks messier as a result.

I assume it's dri-devel@lists.freedesktop.org that messes up, mainly
because I don't tend to see this behaviour when only the usual
kernel.org mailing lists are involved.

              Linus

