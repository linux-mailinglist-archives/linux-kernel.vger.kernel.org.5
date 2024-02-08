Return-Path: <linux-kernel+bounces-58598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02A84E8B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9288D1F2F883
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A513288A7;
	Thu,  8 Feb 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV61E/ar"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CD25601;
	Thu,  8 Feb 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419242; cv=none; b=hEhN33kDsnNUtUKFEDeVDdrD6KsMoZEAjR6+JXInJMtvwJn5vaKECSLsIG1I9UfkhrieCgOoV9ZgjKhpF5EpnIM/EUceb/+wUcg5zkbEWzoWc+IcOrPUndCzc2MCjPSmgwREkX+Y/hBz6jQrhk7Sjiv9FwfiSj1UtxG5phwbGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419242; c=relaxed/simple;
	bh=AZ6nQb+M1vD/2zX5upW9ouxqeYE6QGKcCE/8DY0UebQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wst6HFgdfQKja+5yM+pEqcU4pN9446gke8AYKiCpQiEUmYMRF8GAJfMjecXX7J2Q1RoN/c9WI5nAFtVVM8ZROsSPovZdopksDQTO5uTlx0ZmbyzzVhBrHMiQXp1yX/aW56HgiQ2Kzoidhrou8yqeG91v3CmJkYU7Gnm/2XeJyJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV61E/ar; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so45045b6e.3;
        Thu, 08 Feb 2024 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707419240; x=1708024040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=202GKaA8C1i5cx4LlHBZXcPKNf6nXe/ES82zbqrpd+0=;
        b=YV61E/ara/kkIUYAtCwjGjxniHntVcIzrVYz5b4hqEJ4ZmRn+FZaUIRTqPgIU/+GrP
         QcandcyNGWP9rhwxWDSDTtH29qD+MLjipibhJQ7wivhwc/fRQdm0fT7ocenbU33HQphj
         8mPuMPIZuXFE/d0ifYto7fQYq9PAU3n5LcOACf9HikgMoBILfJmD56deF8DeF2pOFjeS
         Z8AMeknTM+aQMqRgnKVs3O9N5TnunnvYmZeizDBGPTOixieEBQ68OPrZ0LzL1AZYAUh7
         /oO105E6pnBuWn1cpcfzUpNDGsZni8qpT6Wx7Hi9lnPV9xnzbRgJ4xuMAvRckCNUii3O
         kOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419240; x=1708024040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=202GKaA8C1i5cx4LlHBZXcPKNf6nXe/ES82zbqrpd+0=;
        b=BQ0NSpkz58zjBywW7gUcFBIBK6A5XX7QOhulBvH0DvFNnLrQm5E6hj8ycxQRs4Qftd
         5DipMG97Z4wOdziS44KSMRPIY8TeucGNNIaoZd+g7v0uWHFmMm/3WrargbNVaY94sPY1
         4qGhrSMJRWvUtfDJX8oIT0g2DC8Q8feEKvUNaUdZ7HTpnaTs5h48j8W0940leArl7XGY
         +iEDs2wHluJi2kjI4rNjclTxNVJ4QdyjnxbxDZCqonjdLkL+w7MGMoSUs80zv3CZiKbi
         glrT6b1K9vNlPaSSK6ZMtXFb5FoHR8EeOVVz3wTRZiJXhpYC3UzZbDW3IgxgnWfg1otT
         w2Cw==
X-Gm-Message-State: AOJu0YxjxD7vgis1xDDHhb31uxoONYTHzilTEOPbQXEM7tP0v0TSrmPG
	d9oq63k6UCZ7sB8NFNZoCflti5Ic1m33OvSIawIr95qndEglGRA8OUUrNoXiNgtIltVfKMfifmP
	BPqFegD9mazxdbt6C0ulYvDe+zp0=
X-Google-Smtp-Source: AGHT+IF9hg109QvfX/FVAlSXVFZcAMD4vHPe8lrRCgMgpJ1NJrDk5BP2mYMHYbEPaTJSq92jJEG9nWdXOHPoWqKh+5s=
X-Received: by 2002:a05:6808:1524:b0:3bf:f3a2:cd8f with SMTP id
 u36-20020a056808152400b003bff3a2cd8fmr279809oiw.41.1707419240598; Thu, 08 Feb
 2024 11:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <ZcACvVz83QFuSLR6@slm.duckdns.org>
 <CAOMdWSLNMqsZNJ-oCLN2RjckZmJSvdU_Yq0F0frmqMqa67Oy1g@mail.gmail.com>
 <ZcFPKaWwxJhgy8HQ@slm.duckdns.org> <CAOMdWSKQC4UWXp57qubcSOHmPj0E7wHZWWbCz+yCZqROhoPSGw@mail.gmail.com>
 <CAOMdWSLF9AaQF0ux03-tonw-Jy+4rXdKEZGzPrp_v+fnas6SnQ@mail.gmail.com> <ZcUHsHzlLpE7meaW@slm.duckdns.org>
In-Reply-To: <ZcUHsHzlLpE7meaW@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 8 Feb 2024 11:07:09 -0800
Message-ID: <CAOMdWSLP1HxnD9JsQMk7ZU6fvLfUmWz1CywqY5ZkyiUFUTALoQ@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9] workqueue: Implement BH workqueue and
 convert several tasklet users
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Feb 07, 2024 at 11:02:37AM -0800, Allen wrote:
> > https://github.com/allenpais/for-6.9-bh-conversions
> >
> >  I am holding on to the patch that converts drivers/media/*, as I haven=
't found
> > a right way to replace tasklet_[disable/enable] api's. The rest should =
be ready
> > in a day or two.
>
> Yeah, we'll need to add something to workqueue to support that. As for th=
e
> rest, looking at the code, I think tasklet_kill() should be converted to
> cancel_work_sync(), not flush_work().
>

  Ah, Thanks for pointing that out. I will update it and get that fixed.

Thanks for the review.

--=20
       - Allen

