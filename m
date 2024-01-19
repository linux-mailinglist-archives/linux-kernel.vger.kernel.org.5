Return-Path: <linux-kernel+bounces-31392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73C832DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAED1C24CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23E55C19;
	Fri, 19 Jan 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4ykK8c4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A7A21
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683979; cv=none; b=JNE05fafemZKSGdaIV0HBK0L6L9ebRqvR94KQrMPxok3ShUTrExQ5uhRzJf74VFCTyz0do9SHV0Yp8wxzaxQhCAdidvhXs7fknGMa4ma5RaiMGvMimqzTeU6U6VFXxy9gGotdCFj0fLRADyLmtVTnjIlK0x5gW8Lyq2ucKW5Ps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683979; c=relaxed/simple;
	bh=WwTWLHApJpL7oFB6z/WTaZRjRBFj9Gbq/YQh1U69I3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNXhPBTeR7csl7DqVdRhAHUC/sL4NUBtpWebs16gD4TlIleQHauSG2pujGh4u7zwOa9n/6wxFRY21h7iQpHDcKYe+XRaKIb/9wGU+LobFmJTA+8I4JD2coku1/qe9Xrl7zl3s120aFh/l+g3GC6pVh8wYZPGV5MWp/Mrw4oAw1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N4ykK8c4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so938836b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705683977; x=1706288777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5pm5/KO3I3N/k8NKEcPj3kZdPyGnTD0Pk/IAEXHv4ns=;
        b=N4ykK8c47VkYVafLA06Xx8ICnMKpfwR8CB19WJwSud6zCMpiVu/Z53ciS6qebzcn5q
         mpk4tGlksKT7FipKENGPrlJGzkk/10ogUPxtgbEaPZxJmlr2klILn8FSEJzk8E9pbVo4
         uGvffFVwZZ/hRIpjHIIWZ04sbbEJTj0UaaDHXsivsI25Nb+HKDk3IUuvixqJm6vl2yqd
         VqLGYetQmH9H+SZ65F5/7xS0B8/WSIwBa8GsbJ/o35JyCKgfSniN7jJLrqE7ZkHLAoRY
         aSdhpfY2WzHuf7P4Hw6DKpt8zFzPtg++2+yW0gOi9aeoQffBH+LdHzLUPlukAP9Bxwue
         NK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705683977; x=1706288777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pm5/KO3I3N/k8NKEcPj3kZdPyGnTD0Pk/IAEXHv4ns=;
        b=UsiXL1Ha1kZRBXmjV8z9QTnIF1SrV7TiCiLMDrMPDDD0U6S7oa+ab57luuOLGmCyq6
         vmphBTg5+lPEG8MQZgs/Yi/nXTapWkvoJnaEYOi44a0OsKGChUNOx7DLrxZJbMpa5piP
         HKx54qRIbWtml6meyOGL9ACnrb4bQgbYv4pVOVwLmaL23xwydSex2+S0EqClNqxu/+J0
         WH8umecEKDKIHL80yTKb0xHhEvn86oMsnRBO9+Q4BongURj5nl3XNpS/0fPhh+wJKZWH
         rh4ZwWqR6tBLz2+viM8XU0Bq4OR6S9Jihj2I5C7d4clw+l2rdiY3vAnouxfEQgoWsOMy
         McYg==
X-Gm-Message-State: AOJu0Yzqag3jHknFrmVmNB4ntG7LtibeqZsJZZZ2MrXms6tOVzx1Ur+l
	TtZ3PqeFjLsocqhPH377yFfzrRsQUInwnxvBKi5rN0CBIWh2tDflzCQrmAl4GA==
X-Google-Smtp-Source: AGHT+IG3DzZgz1H4wFkqomGjQMHbhrs1iJKKi0BvCCS6dCcddik8WAc9qVLtoSuQ9tNE3iNQihXSlQ==
X-Received: by 2002:a05:6a20:6da2:b0:19b:1edc:ded6 with SMTP id gl34-20020a056a206da200b0019b1edcded6mr118656pzb.85.1705683977538;
        Fri, 19 Jan 2024 09:06:17 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id f1-20020a63dc41000000b005c6617b52e6sm3767308pgj.5.2024.01.19.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:06:17 -0800 (PST)
Date: Fri, 19 Jan 2024 17:06:13 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <ZaqsBTQ1x5lQG9Rq@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
 <Zal8A95q3jVl4nu5@google.com>
 <2024011935-placidly-justifier-4338@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011935-placidly-justifier-4338@gregkh>

On Fri, Jan 19, 2024 at 06:48:43AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 07:29:07PM +0000, Carlos Llamas wrote:
> > On Fri, Dec 01, 2023 at 05:21:32PM +0000, Carlos Llamas wrote:
> > > Task A calls binder_update_page_range() to allocate and insert pages on
> > > a remote address space from Task B. For this, Task A pins the remote mm
> > > via mmget_not_zero() first. This can race with Task B do_exit() and the
> > > final mmput() refcount decrement will come from Task A.
> > > 
> > >   Task A            | Task B
> > >   ------------------+------------------
> > >   mmget_not_zero()  |
> > >                     |  do_exit()
> > >                     |    exit_mm()
> > >                     |      mmput()
> > >   mmput()           |
> > >     exit_mmap()     |
> > >       remove_vma()  |
> > >         fput()      |
> > > 
> > > In this case, the work of ____fput() from Task B is queued up in Task A
> > > as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
> > > work gets executed. However, Task A instead sleep, waiting for a reply
> > > from Task B that never comes (it's dead).
> > > 
> > > This means the binder_deferred_release() is blocked until an unrelated
> > > binder event forces Task A to go back to userspace. All the associated
> > > death notifications will also be delayed until then.
> > > 
> > > In order to fix this use mmput_async() that will schedule the work in
> > > the corresponding mm->async_put_work WQ instead of Task A.
> > > 
> > > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > 
> > Sorry, I forgot to Cc: stable@vger.kernel.org.
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Oops, here is the complete info:

Commit ID: 9a9ab0d963621d9d12199df9817e66982582d5a5
Subject:   "binder: fix race between mmput() and do_exit()"
Reason:    Fixes a race condition in binder.
Versions:  v4.19+

Note this will have a trivial conflict in v4.19 and v5.10 kernels as
commit d8ed45c5dcd4 is not there. Please let me know if I should send
those patches separately.

Thanks,
--
Carlos Llamas

