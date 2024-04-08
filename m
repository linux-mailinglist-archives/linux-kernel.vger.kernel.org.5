Return-Path: <linux-kernel+bounces-135766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCE89CAF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF461F23B74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA91442F1;
	Mon,  8 Apr 2024 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q4zTfmam"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979E143C64
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598423; cv=none; b=bFVFyaIcoGfHy8Yx/ZdLM7efvYFpM2kDZaCaycP8KfHFnyrbgA7IzXzJfqiVBhy6N6vj8dLxbkd1t3m3AHZT0RPMnAOso65GQYn+JMXn8H+CjGC4NfacYm4M7nsfdUqlhs7OfHGSqV0OHID1U8/IIUXGWSqu1mNrnyr19DKDQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598423; c=relaxed/simple;
	bh=0YbW5SOLOTenM+r6RQas4H/M9J4T+E9gkfjLqxxbMwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6uFloNmi6kUCHUhFZfXdMlr1LcE5EvjLun3qdejPO+um9qmeru6rcLZMHX6+x3ewwEPkXX0lmVt+YCfpgmSoWcBBZVejO6BHln0xll0t0tahtcJuPiZk2mflvj8axVBZ2UWPUH3FLuzDNP9PVu/puKzjchx+No6fMGVZ42on/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q4zTfmam; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc74435c428so4646448276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712598420; x=1713203220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YbW5SOLOTenM+r6RQas4H/M9J4T+E9gkfjLqxxbMwg=;
        b=Q4zTfmamJ1Q6kXNdlC/fVn6zTRUwsc0gZs+hVpDAGbkL0UW0w/iyoQ5SLfJUA20Igj
         UBbIfPFHxdrB7SbtpCf/AAJa4rNEmdWHO5CYFQ39eQVjXVPUZJ3JamV6Y6S3DIO4TrP+
         VKFovoHDUTdsMg8wWiDsyjmZypVJP4VuCzB0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598420; x=1713203220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YbW5SOLOTenM+r6RQas4H/M9J4T+E9gkfjLqxxbMwg=;
        b=cl8w/mt0oP+yfCAhDnW/UVrwLnK6ZUPh00pJSizPralnSHDnmKy15ua4hSiU38tYte
         SQIZ7lCyzKylLFD8cQrYKwjNWFfnAr28cKMa9G65L1kkHzSRbZZRfCl0urYEeN2JQ2l2
         T04KXR0gdRUZZDzQ0+Vwz8Xk+8ANIx0nenKmj74xIhQWVIttNjmQ8wzU13pOyVm0gbND
         VH3qVZ9eYhjimXRJNRRR9hutTxmYUAfZwumswe7Mf5G7zlzLFLmox3pm3N8HqjcGe/0u
         2VXDIxpGZj3kb4MiuPBj8RQJ50wZxbAjdK2VtFI/sgxefc/LqUXGSxp1x1aUmg3hh5C8
         UrGw==
X-Forwarded-Encrypted: i=1; AJvYcCW2zPIws5Jjyty4B1TeM8UqKjOkTpxqRwuBb8wo9zxecD/GIPEuBudym/8hTbbxYT82VzwCt2FMAnngjZhoMVmnBUcEWOHXmbUQuAcr
X-Gm-Message-State: AOJu0YwilBaZW8gviw1+MwxqR1ORlSDJkcWmHjYJSbnA6SmkqUIaJVgM
	SBKTZ+Vl+BuFzDMN8iJhX4DcSDu+qRHaHpiHycxLZq8QUt2hYY/OhE28MLJEZ6FExVFXmhtIsvK
	kBiohS55jUCQkeWNk9SDMmyH8juhcsre+QeG7GlD4i7dJvxk=
X-Google-Smtp-Source: AGHT+IHJElG6RyxN5KsSAQgpDvZ6UdSTRc5tikioKhfMtj/AlFIOyYZ9i8vPa7wr84cqzBwszV2q3jnb2JLEmmtXWQw=
X-Received: by 2002:a25:bbc2:0:b0:dcd:2aa3:d73b with SMTP id
 c2-20020a25bbc2000000b00dcd2aa3d73bmr7422172ybk.50.1712598420397; Mon, 08 Apr
 2024 10:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408155605.1398631-1-zack.rusin@broadcom.com>
 <843fdfa2-348b-410e-8ff1-84ab86cac17d@amd.com> <CABQX2QMtTB9iiQuce36dnk6eO1Xcsm+Xt3vc1Nk93TGD+TtV9w@mail.gmail.com>
 <5ca415e9-fb3e-4d81-b385-71e8780a1399@amd.com>
In-Reply-To: <5ca415e9-fb3e-4d81-b385-71e8780a1399@amd.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Mon, 8 Apr 2024 13:46:49 -0400
Message-ID: <CABQX2QMaF6e6o4Ewg6sExfaEZMXRaUrNHNYUCAYG3+44P=7epQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: Print the memory decryption status just once
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Ian Forbes <ian.forbes@broadcom.com>, Martin Krastev <martin.krastev@broadcom.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, apologies to everyone. By accident I replied off the list.
Redoing it now on the list. More below.

On Mon, Apr 8, 2024 at 12:10=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 08.04.24 um 18:04 schrieb Zack Rusin:
> > On Mon, Apr 8, 2024 at 11:59=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 08.04.24 um 17:56 schrieb Zack Rusin:
> >>> Stop printing the TT memory decryption status info each time tt is cr=
eated
> >>> and instead print it just once.
> >>>
> >>> Reduces the spam in the system logs when running guests with SEV enab=
led.
> >> Do we then really need this in the first place?
> > Thomas asked for it just to have an indication when those paths are
> > being used because they could potentially break things pretty bad. I
> > think it is useful knowing that those paths are hit (but only once).
> > It makes it pretty easy for me to tell whether bug reports with people
> > who report black screen can be answered with "the kernel needs to be
> > upgraded" ;)
>
> Sounds reasonable, but my expectation was rather that we would print
> something on the device level.
>
> If that's not feasible for whatever reason than printing it once works
> as well of course.

TBH, I think it's pretty convenient to have the drm_info in the TT
just to make sure that when drivers request use_dma_alloc on SEV
systems TT turns decryption on correctly, i.e. it's a nice sanity
check when reading the logs. But if you'd prefer it in the driver I
can move this logic there as well.

z

