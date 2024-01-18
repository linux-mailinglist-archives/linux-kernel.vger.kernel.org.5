Return-Path: <linux-kernel+bounces-30516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F5831FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5196B1C22B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB72E40C;
	Thu, 18 Jan 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3u/Av31"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457042E3FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606154; cv=none; b=efLBHkja5ZOuO2YuRULlt0F5kzPHm95ygsXfo+KzK1RP3f2H3YMKzojW3f2M8RV0zrIYJNMpbv5C4eUgULnfLSfEWN2hK7S3mSsf8f9caEq6ki+kgjVdbVOireR7yQXouxJu/65Bk7X+JmmLbG43XJMdx16X5maJ9R/JbMZagDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606154; c=relaxed/simple;
	bh=EYGd/BtwuvtD8ZA8Nfy4r9pHo1JatfhJ33J3FjqEQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjpeMlRYeJOX7iBKbXMggWC8MPmvWdofhkivHEk4pWsqpdB7uiLu5uFwsuz2schFC4eFvJmQqWX+HYRPGe/5e0Ju0ZI0VQgPCgwIULOoaGQ0PP6zB5ysi50rGDynEKqO1ARYjMdr2LG8LIw4D7BySUxiuvQSIHFsOZEFkPLzSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3u/Av31; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28ffac1ce99so45875a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705606152; x=1706210952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iomTbXqRTjibxPrZcFIaAB8B6frVBWEtPfgQV/mc1o=;
        b=S3u/Av314bbOChT4eb5WgE0aLJdxWthB6iKAfRqC1CA59rt1pW5unaFdmlBfnJeedP
         cjKM1qDTXCCKEWOWQ/gpWvnQ1lF68ASBYjP29kT5H8JdTUCwFmc6VyQb2X/vmXrXMwxs
         UJ8TaYXJmwBZZm1QPVI9I83uLnO2T05RK1mFQ5Z+KCub5WGV8YClTU0LrROXS66DJPK4
         vOZaoZOi84i22Fc8CIFEoz+yAafYtyh2QGmJbTMtxyFbkFHqyEhSYwRSfK88d/dUS3Q7
         BXg+rS7pRXpCypYQZy9KBWSoi2d58knqvFw0c94rEngi/mNKSBCm1cI6S9pyvHwFcXrh
         U77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606152; x=1706210952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iomTbXqRTjibxPrZcFIaAB8B6frVBWEtPfgQV/mc1o=;
        b=epQV0/seaylXD0BxkzOEQyCCxJxPrAPh/X9PBL5cWfXYJzVk/6REuTqe+9gkHw0G0y
         W6EkfBqo25clrdE3rcrwaJTC/P6jC0/fINnBTt9ZhSDh0RTXfhtMvGSrwzAwtw4/vPwh
         NnWwY+d9DsWU7bjys9jvmpSUwdXhhbRjWdKa7LwuKdZ6ae3xGXISZB1nkSmEch2JypCu
         7Fhrd36q3O/5RXZ9zzngOEXhPZKN4i2yYPN0Hga+Ea392jwx0Fhq0ZbPKDSVj6D1A8Wc
         yEr7wF1dKALMlw+CXWjGupXc/OZZfO9zeGSgVL+YMabvtoRCtmQdq3CJMeY8ZHMybZ6C
         RItQ==
X-Gm-Message-State: AOJu0Yzc+6IqyG6iAHzGbkqkKwxRSiTupR8oTgnoUsRTErANfzg/3Qfy
	5ArfHAe1/Rsswd/BMCb+s/2z0l9diKjA3mQOUHAuayIxEmolHfs5GyzfBKqiXg==
X-Google-Smtp-Source: AGHT+IEDU0f/LZTZf0+r3K8CSuUlFt617cPqAtIUeGN2vr636LX8vCpmJ6gjqngAJppnD0SbvlrATA==
X-Received: by 2002:a17:90a:e2c8:b0:290:45a7:3ed7 with SMTP id fr8-20020a17090ae2c800b0029045a73ed7mr158870pjb.3.1705606152436;
        Thu, 18 Jan 2024 11:29:12 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id oe15-20020a17090b394f00b002903a89ebb3sm716848pjb.31.2024.01.18.11.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:29:11 -0800 (PST)
Date: Thu, 18 Jan 2024 19:29:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brian Swetland <swetland@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <Zal8A95q3jVl4nu5@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201172212.1813387-4-cmllamas@google.com>

On Fri, Dec 01, 2023 at 05:21:32PM +0000, Carlos Llamas wrote:
> Task A calls binder_update_page_range() to allocate and insert pages on
> a remote address space from Task B. For this, Task A pins the remote mm
> via mmget_not_zero() first. This can race with Task B do_exit() and the
> final mmput() refcount decrement will come from Task A.
> 
>   Task A            | Task B
>   ------------------+------------------
>   mmget_not_zero()  |
>                     |  do_exit()
>                     |    exit_mm()
>                     |      mmput()
>   mmput()           |
>     exit_mmap()     |
>       remove_vma()  |
>         fput()      |
> 
> In this case, the work of ____fput() from Task B is queued up in Task A
> as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
> work gets executed. However, Task A instead sleep, waiting for a reply
> from Task B that never comes (it's dead).
> 
> This means the binder_deferred_release() is blocked until an unrelated
> binder event forces Task A to go back to userspace. All the associated
> death notifications will also be delayed until then.
> 
> In order to fix this use mmput_async() that will schedule the work in
> the corresponding mm->async_put_work WQ instead of Task A.
> 
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Sorry, I forgot to Cc: stable@vger.kernel.org.

--
Carlos Llamas

