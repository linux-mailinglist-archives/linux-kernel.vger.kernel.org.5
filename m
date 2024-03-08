Return-Path: <linux-kernel+bounces-96957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF6876398
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507E2B23055
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A685647C;
	Fri,  8 Mar 2024 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O1G0eL1u"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0F56455
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898454; cv=none; b=FsKpIR2hcCNv3LgF23Sj6i/OUmAoFOm6XIqIDdPd5oBMh98H93qjgK/DAEOfSDllHqgNjhHveupvk/8a0zqLUHineJlG60cCJywRCCzWA+Vsuf0/68qGpVBuqDp9fmkveAqLa7LDPexOGEi1F8fLNFUX12kY93I96XvSOmMqGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898454; c=relaxed/simple;
	bh=1cmWuxioymsaJqObFxvlX94MIOPKMFzPNwfpzu9hVrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVnqTjrOW+JHpAVk5LfngV0Q8IOBNTrp1Gl0wGFAWJ+swrbUl3M88jEW0QbpsWLIlLlwf7UlKP+6Q1HkkP4dGXKcJlirHuycQWCzdkikzdgsxJoZ4bLJmx4p0KC0VcSPdh7dAoKwsMVxgZOx2dMdMEl1ts07UWE11n4GbtzxU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O1G0eL1u; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42ee0c326e8so224211cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709898452; x=1710503252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cmWuxioymsaJqObFxvlX94MIOPKMFzPNwfpzu9hVrQ=;
        b=O1G0eL1u/3mOURwEQuGdxge0CsUMXguS3aoOiT59Lno04BAfLP/tT7lq3689jJHb8k
         Wtq3pbSKBwP9euzrfvk4nR8KEdlc6JfgBr4kfvYAVkZrin76Cn25TSyhWbYlGLy68RSv
         gUOyqT2ZJbJ8dDWZdq/71M376oivL4bH29dA4hwk5An/73lamgSIhRgSNP807sxQHy2/
         xnJVxuIJBWVOcmsZMI+I602o2AfVf/75vTVqLh9zP5vZuBaddh7Eyx1CdulWM+HDFjIB
         RIxm8B3cqTuhGA+HuO+HpnNudUhdNrhgZrfIAZSI1usvWXUQ1DleH3q3d5T5l2Frvq8/
         a4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709898452; x=1710503252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cmWuxioymsaJqObFxvlX94MIOPKMFzPNwfpzu9hVrQ=;
        b=WOFJotfmfXFJcDvL0PpOqR65FLp5j5FBVB4V9Bx2YxY6hbLdzYXGOPo0JvTqBiHVVE
         naHAaYac0tFoGNbCvHFR2oW5IvR089gS8oGgJBkU4xuCwYSvek2wBRLVYFfrzyNx/oW9
         nt2R7ZEHbLNTKimqn9QAljo6YqKpjFYzP39U91gPJg83llyJMeKHpTaXIuVNTVMGXyPv
         7uM3RTEUqD4qhdBeflgjVvuBCl8QzqjCPLfEf2lEKoPMp15SDlaOdJhP2j9+VnKtTvlz
         XvrPA9a8AeG5ve6fiT7qjJPl18Xe0Us5DT+ifuRSkvYMqotgJfL+jnOFuXGw1bc0idm7
         4wBA==
X-Forwarded-Encrypted: i=1; AJvYcCVM6YqA222HlLxtFdnhQfVCF/OJQv7/V7z/XiIm/ILIrM0QMpIlF9ZKEYL/rUNbs9L7DJzCseUBxOEZ3SZ0SjKbTeolz7AMD9+6rLZ7
X-Gm-Message-State: AOJu0YxKpqcpVZUSMQ526rNxQVhwHsgE3gbVD78NYFu1+QtazuJPQzk8
	ZH+xM43d+bwyDZYYx5u/+Hyf2t7qNjFB2G8jJ3Npd6o6LW7V0YSN/gdOB50RoXiMn7FLLVL4mWi
	wqzUvOU+vG0oZ5oSh1mwgPQmQom5XpV9vYcrg
X-Google-Smtp-Source: AGHT+IGPOqprHhMJkgjBrB+wgYAmcpdie7nmOd7ylnxVDyd8IN6rpm51JSosupi80fyFkW0i7mkNRzWnZlD92z0nDCk=
X-Received: by 2002:ac8:5e0b:0:b0:42e:b7b2:2e99 with SMTP id
 h11-20020ac85e0b000000b0042eb7b22e99mr697473qtx.2.1709898451413; Fri, 08 Mar
 2024 03:47:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141801.396398-1-khtsai@google.com> <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
 <2024012724-chirpy-google-51bb@gregkh> <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
In-Reply-To: <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 8 Mar 2024 19:47:04 +0800
Message-ID: <CAKzKK0pmswLnGa8zabp_wo=6BcvCd9DR368FCJ5mcpZ38i4Jdw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, quic_prashk@quicinc.com, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg & Jiri,

On Sun, Jan 28, 2024 at 9:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jan 18, 2024 at 10:27:54AM +0100, Jiri Slaby wrote:
> > On 16. 01. 24, 15:16, Kuen-Han Tsai wrote:
> > > Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check i=
n
> > > gs_start_io") adds null pointer checks to gs_start_io(), but it doesn=
't
> > > fully fix the potential null pointer dereference issue. While
> > > gserial_connect() calls gs_start_io() with port_lock held, gs_start_r=
x()
> > > and gs_start_tx() release the lock during endpoint request submission=
.
> > > This creates a window where gs_close() could set port->port_tty to NU=
LL,
> > > leading to a dereference when the lock is reacquired.
> > >
> > > This patch adds a null pointer check for port->port_tty after RX/TX
> > > submission, and removes the initial null pointer check in gs_start_io=
()
> > > since the caller must hold port_lock and guarantee non-null values fo=
r
> > > port_usb and port_tty.
> >
> > Or you switch to tty_port refcounting and need not fiddling with this a=
t all
> > ;).
>
> I agree, Kuen-Han, why not do that instead?

The u_serial driver has already maintained the usage count of a TTY
structure for open and close. While the driver tracks the usage count
via open/close, it doesn't fully eliminate race conditions. Below are
two potential scenarios:

Case 1 (Observed):
1. gs_open() sets usage count to 1.
2. gserial_connect(), gs_start_io(), and gs_start_rx() execute in
sequence (lock held).
3. Lock released, usb_ep_queue() called.
4. In parallel, gs_close() executes, sees count of 1, clears TTY, releases =
lock.
5. Original thread resumes in gs_start_rx(), potentially leading to
kernel panic on an invalid TTY.

---

Case 2: Hypothesis. Similar to Case 1, but the race occurs between
gs_open() and gs_close(), also potentially causing a kernel panic.
1. gserial_connect() enables usb endpoints.
2. gs_open(), gs_start_io(), and gs_start_rx() execute in sequence (lock he=
ld).
3. Lock released, usb_ep_queue() called.
4. In parallel, gs_close() executes, sees count of 1, clears TTY, releases =
lock.
5. Original thread resumes in gs_start_rx(), potentially leading to
kernel panic on an invalid TTY.

---

Since both gserial_connect() and gs_open() initiate gs_start_io(),
there's a brief window where gs_start_rx() releases a spinlock for USB
submission. If gs_close() executes during this window, it could
acquire the lock and clear the TTY structure prematurely. This happens
because the lock is released and the usage count remains 1, making it
appear like a valid final reference, even though gs_start_io() is
still in progress.

My only solution so far is to recheck the TTY structure after
gs_start_rx() or gs_start_tx(). I would greatly appreciate your
insights on how to address this race condition effectively.

Regards,
Kuen-Han

