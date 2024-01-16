Return-Path: <linux-kernel+bounces-28316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6E82FCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618F91F2A089
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F955FEFF;
	Tue, 16 Jan 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjIrTYip"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9643C680
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441174; cv=none; b=DGIc0aO6HKi5BKXdvURrgdmmS3IUJC7FPRhEp0T6opIyYyIpSuK2bEKEv8wT2vE+EWwMYctfG9u+18EVkeVHUDUx880Z21NjJ+/YuUyxeBXz9UclUwGq98YGRCqEM2lLV+ytrETGoc4ROXnTv0FlYuMXQrAnOZG32iFdSYhD5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441174; c=relaxed/simple;
	bh=0jStnFI9YrHyzfCYM4yDsEjV0VthChPbc/C8UHzsq34=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=NTw9g+iXVy8pqVhVUntsanlDNS8uzytWARPIKNVvrczxSzRfxUE48NWydJtwtvvUCcWbO5R+WiAehPzlCGWFzlGWui86PKdAlSZn1R7/8tO6i+Ku2Cf0MoREV5KyrJdw10kXq6q421ru9Tp5SbdjTuu+TmlYmd3ISdfTsUpTvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjIrTYip; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso7775603a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705441173; x=1706045973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn9WRxszwhkZhf1JTzhEy6otcflMsj6ENkJnNyTS5zU=;
        b=hjIrTYipq6sT3OSfAvsxKAo/9baKKoc5CVH5c7+vmz66p5uCPcb9ZfXPG9Ge2AG9Wc
         EbmCPpJhtJaE4raWFMZ+I+hIJCXU87P8yO9862y1G1x50BKcNhN9i1t2Z1Y9kN7dW8sx
         14A99xbhKeIOpvrbprRdYMrAvtkKZORheX9s1bOhAID7+1IY7EIMXu21AG34kPGQ8Wo2
         PS7MdJJCDVm9Hl4KvEQxrX4lMSK7lRBumjrqKGP+h+UQyIeNlqWikMHgInKa976vOLdA
         1ZqdosU2UhtSOYiV2d3pTxER4aGnIaPq/lKRTjoRVisnxgytBqFjZkWOQzmeEQAPEDN2
         8GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441173; x=1706045973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn9WRxszwhkZhf1JTzhEy6otcflMsj6ENkJnNyTS5zU=;
        b=qIbAzC4pgrjNeU6L4HRhwQGUrEEGutNf/WpuMAO9bZrwgykz6CbJACafaOg5TjVT0/
         jzBy4U+dhwgHWNEfpPdnTuY4xWCVS4laP/1fVuFx+ZqVQV3ZayqQZw1wbYULmRCUOwi6
         pS7se+ntnc7uh2kPGa8G1ayddxXWlWbGGKUGni+3bHL3dZhu2Wi7TIjdaPngKc37BRdb
         f+R+KIfRlS/sC2j7SJvuxgTpI23nwTQqfX3nbzOyHSRcJOo/gSymb9fUquT02f0LtvdZ
         TpPhW9kRpoxSeoHF7SMwDTS2GHw1gnzoz8BCJg3xYwxcEbVZSfxrlnC5fuwFrCTZ1LmW
         V35Q==
X-Gm-Message-State: AOJu0YwOvrNYsTzq5ZcEwkzuytalJfx/EEJC747I4/zlngIXHY/pKyDB
	bXCLPiuFxWJpM2ULDkHDUK/mgcWIqqQ57eAtLMk=
X-Google-Smtp-Source: AGHT+IEzZt7O2Sc7ssRMjvQPsqfBvGNDOIRMqRH7bdmPLwfSN3okiE+h45m+bhNx9/rquAIig9ZxSSkZ0ZAR8g18cik=
X-Received: by 2002:a05:6a20:7c25:b0:19a:5d55:2d8 with SMTP id
 p37-20020a056a207c2500b0019a5d5502d8mr7102543pzi.44.1705441172798; Tue, 16
 Jan 2024 13:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065943.2803551-1-shy828301@gmail.com> <877ckb16xl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877ckb16xl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 16 Jan 2024 13:39:20 -0800
Message-ID: <CAHbLzkpTuTacnB-zes6H2dgy1Hb3roqkMGgUyrk8ULWf5TQhDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: mmap: no need to call khugepaged_enter_vma() for stack
To: "Huang, Ying" <ying.huang@intel.com>
Cc: oliver.sang@intel.com, riel@surriel.com, fengwei.yin@intel.com, 
	willy@infradead.org, cl@linux.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2024 at 9:52=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > From: Yang Shi <yang@os.amperecomputing.com>
> >
> > We avoid allocating THP for temporary stack, even tnough
>                                                     ~~~~~~
>                                                     though?

Yeah, it is a typo. Thanks for noticing this.

>
> --
> Best Regards,
> Huang, Ying
>
> > khugepaged_enter_vma() is called for stack VMAs, it actualy returns
> > false.  So no need to call it in the first place at all.
> >
> > Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> > ---
> >  mm/mmap.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b78e83d351d2..2ff79b1d1564 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2046,7 +2046,6 @@ static int expand_upwards(struct vm_area_struct *=
vma, unsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > -     khugepaged_enter_vma(vma, vma->vm_flags);
> >       mas_destroy(&mas);
> >       validate_mm(mm);
> >       return error;
> > @@ -2140,7 +2139,6 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >               }
> >       }
> >       anon_vma_unlock_write(vma->anon_vma);
> > -     khugepaged_enter_vma(vma, vma->vm_flags);
> >       mas_destroy(&mas);
> >       validate_mm(mm);
> >       return error;

