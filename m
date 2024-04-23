Return-Path: <linux-kernel+bounces-154947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C98AE367
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC051F21D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57D7D408;
	Tue, 23 Apr 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ghbb0qEv"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1983762E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870408; cv=none; b=gqVY97E7w35l6a3nSPT6lPZp3BUFHioDDJfI+3pKd2KAjyoKtmQpZYPR5FrpA5o6l7dOhvL39ZTJ5Q8ESxt3r6VcPY9tPU8tthQYNhURo3HhOzk58ky3JhDe+HJIfB8cnsWTU8+hCUyi+d7xHGj/xxERWcBsWHmqj5tgBiO3jwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870408; c=relaxed/simple;
	bh=AdPVc0A61kGLqMdPSFwl4zNIhRj+J3lsict6JN3wJUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAO2G2SQK7pfvGqXgThbBBBN29Fq/SeD8EY+gOC87Xh3QGo2hl++IpqMJxuFKzZ4YO252o+WVj01Jx7hagGRScrW5HzWPwShK1vboa8A2kPlHeFcO0F+IBBj0jN6jBt7VBs+PraroM07cGe3OODT90kOBfNzU519OcKeaKzSFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ghbb0qEv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5544fd07easo618769966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713870405; x=1714475205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4wUsxduyxnw3tRxR+5pqJbGtttgBs5DrdX3QvzytJP8=;
        b=ghbb0qEvROFxiYb1AlYkC25WMO7m7vDXMUQn+lj4ILBihB0dHB/vISDW4a3Vm26pQr
         B4WGP8WV3bKgaGq0OhOv5gn/2Wj9C6W4oo74SMnxMFcA5s/RIAHU6RL+oudnMb9Ka4kb
         4qoVrc9AaJiYaOnkGNrYEvwYmzpaKvv8OeqF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870405; x=1714475205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wUsxduyxnw3tRxR+5pqJbGtttgBs5DrdX3QvzytJP8=;
        b=WvGCqTp/b//EFUUKQYiUgpdYkklrmaLnDaWdD17YWUCqxZM4kzxhxpuQ3lQz1LpeGU
         TRB14g8YTMuZQCBCqs4zLbasbZgjgKW1qOY2hCd9/Zct/BzfWw7JcvVE/vWE1NqFYT5I
         ms/1h7byaVCPnOXpX/J0dL2jXsKNus87CqlgBXaExNmkhS9RAGI3qwfsc33a0uNTllqy
         aLtPg7nAf2CQ9Lc7GmMB4xVoJ5F9mblg0oxngtQYNJmG0ndFC7gKiOUCdb6y9vXQFYBH
         IT2XQpDna6qZSFZ5hUlIlLNaS/ptYA94nz3b7RnrlfbU8OP1JrU2bxko+3Tl+O5HY6ft
         rxRg==
X-Forwarded-Encrypted: i=1; AJvYcCUNJyYc7GYXT9gwcpM2w60Fl5IIzRAu4WEtx8OGrgooRxJtD2iJfJRya9Z+JIgFBVe9ci/o4DcEVEjokL0GlhmIH3aHdlQCigYuhM4K
X-Gm-Message-State: AOJu0YyGwDr24bVi9iv0JRh9JjFLB1q3wLSA3er65HjHVtVXFYHZ3DIN
	PIcS5WuhahAjfyuijLwvuFEEQ03L0kdnaTmva2+W03si4IGRCDXZXwalEBAZe576gNYLXNnVySu
	IAQ12iw90eCcwvhqYPu4g5J6tEu5UEJkEhbwTUQ==
X-Google-Smtp-Source: AGHT+IHDBjoZdM2gVk9D3aqNPCHyKjZYa/36GqKJ1sdnx9QyLzoetXb2axAuN1nqXZn7TD7Kvykchg7hZpOhqjv3lWw=
X-Received: by 2002:a17:906:34c5:b0:a55:428d:5de9 with SMTP id
 h5-20020a17090634c500b00a55428d5de9mr7869885ejb.28.1713870405155; Tue, 23 Apr
 2024 04:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
 <20240412140122.2607743-3-stefanb@linux.ibm.com> <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com> <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
 <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
 <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
 <e052c1b5d2aa29b3a1f3a8086af4fb8a94c4d318.camel@linux.ibm.com>
 <CAJfpeguzh6VzhdnwOPf_hM4x0FbsK8hhZp=VK4kWpCYn0xeBCg@mail.gmail.com> <254ee35d6534089e99f7396582572606f24ff3a2.camel@linux.ibm.com>
In-Reply-To: <254ee35d6534089e99f7396582572606f24ff3a2.camel@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Apr 2024 13:06:33 +0200
Message-ID: <CAJfpegtH8z3uRcSPCQ_3kj-XoV9rUnJc5nE+CQSrCuBMajEmeQ@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 21:06, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2024-04-16 at 16:46 +0200, Miklos Szeredi wrote:
> > On Tue, 16 Apr 2024 at 14:18, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > Originally there was a single measureent unless the filesystem was mounted with
> > > SB_I_VERSION.  With commit a2a2c3c8580a ("ima: Use i_version only when
> > > filesystem supports it") this changed to always re-measure the file if the
> > > filesystem wasn't mounted with SB_I_VERSION.
> >
> > Does the i_version get stored and compared only while the inode is in memory?
> >
> > In that case I think it should be possible to support a version number
> > for the overlay inode.
>
> i_version was insufficient to detect a file change for overlay.  Commit
> b836c4d29f27 ("ima: detect changes to the backing overlay") also compares the
> i_ino and s_dev as well.  Refer to
> https://lore.kernel.org/lkml/20231025143906.133218-1-zohar@linux.ibm.com/.

Which is rather ad-hoc.

I'm talking about returning something in overlay i_version, which
really indicates the version of the overlay file calculated from the
i_version of the underlying files.  The only issue is making this
i_version persistent, AFAICS.  If that's not needed than the overlayfs
specific logic in IMA could be moved into overlayfs, where it belongs.

> Here in this patch set we need to detect IMA read/write violations, based on the
> i_readcount/i_writecount.  If an overlay file is opened for read, but the
> backing file is already opened for write, the file measurement is
> meaningless.  An "open-writers" violation needs to be generated; and the IMA
> measurement list needs to be invalidated.

If there's no other way, then let's implement an API to query the
writecount that can take overlayfs into account.  This is for the VFS
and/or overlayfs to calculate, not for IMA.

Thanks,
Miklos

