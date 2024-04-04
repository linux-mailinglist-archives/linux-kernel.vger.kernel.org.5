Return-Path: <linux-kernel+bounces-132095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC7898F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F0C1F2311A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3171350E3;
	Thu,  4 Apr 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="J2civ10P"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088113441C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262204; cv=none; b=X6y1J/IeHbTdYByXLZV/vX2dVIi2GXwJPwtRxjzYA5K2XyLr2T8k6l4V9LNdg0X9o3lMbx6pFXgidM7Ecyjj3ZtOfapDeNPmeFihXE+nZC/cYpMNks7qfhoatF4IS7Iqq8CSJSAcj7wPBq8abmtekf8hk58vMfqXZsXduQbDfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262204; c=relaxed/simple;
	bh=4yEupevdxTfsi6EpiXizJPMKrr85Gj88QTmbDbVv/6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lF+Tw1dGyuaAMBChfMFZ50W6kTIUUwksBk4EyyExHaM+37qc+CvfgL0dZ5VqZZIrl1oJ4Vq96zGv/mamIZo96WNrNssUPXbkzuTWyKtfHYyQeqhVoxXYwu7dLiE4t0JirKlHN6fGOFBKRh+P7HImiazJgyLDheIOohb3I/nONpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J2civ10P; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1236943276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712262202; x=1712867002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz7AxBn5f8YxKgE6L33pdnqQtmTBvQk60RTId5exw6M=;
        b=J2civ10PmJ85t97g5eVZzjHN9OvWBckRgN2/dzRNKprQpEcY5R8LMqsBGjx71BBOA5
         YrhTLiOmDfNJB5QsBx1HyVQnTNdYmc2vNhfSqwghiNhFWDPrs7BWVJKlgBzdOcG9D5gJ
         J6SMjQa17N2aGF+4aK9cyviAmLS8aJGAk3SbdS8WbE96dyr/8mmi2WipjaNydQmJZ+KJ
         yo7COfVm/eKSw9xzbEkT9s/eJNq8sDfE/is2zY/6djRErHRnFtoniEeV9cTXgfmE06jB
         fmUQhfSJ3g5RLveOmWf7wRFv5d3WaCFl4G+z2NdxgozEfaOryHXOsGC1k51qH794zOE5
         XayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712262202; x=1712867002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz7AxBn5f8YxKgE6L33pdnqQtmTBvQk60RTId5exw6M=;
        b=Z63vumgCGyvysTe4D16rrJ69erqFRgMdc1ph2CB628QxtlXCCsZvLvhqybna2NblS/
         dc/prpkiVbXevDv4Yli9OO+uusxnTAIXDGJe8a21s5oZc8QwiDoV/QgtGJNNd5h6ui8I
         E6zv98f7xpK/+gNJujO9zJQAaoc+1S4jhj1bh/n0k37HBaXO9bV4ybAKsJPIjqYsXt5Y
         Z3bYmMlKhRqrFqGgVZh1SikBlXBoBW7kCi1I2bUhNNDrbsFhPwVdKU68j1IHTAnSNYXm
         mY3hLvaWyr8n9LVq28RDKQP5J52uvZXMQbOGq1TDnr0LIVFdJ1B7Jjlm0+y4SzYHT+Vs
         7bKA==
X-Forwarded-Encrypted: i=1; AJvYcCWS3Lu+e1+XJpLEFI3WDAevRWSkb40xZt0pNxynQA3WdJ+XTuxR1i+xyHu/SDsO2QTPHvwJCcI0OBRlMYXpGILi4iz8qzA+f5qExcnx
X-Gm-Message-State: AOJu0YwvZdH4bKscXDEqWVpa2OYLQ3yyDOGyWOxaPcYYXlEr4Rf7gJq+
	iOKUVZ3v3nZmzfdRkuiZBSzJvUuNNKnRyjbCIgjWI83JKQjIfZbSDSCaaF9weyxWEIddBFD/nJ5
	SYgRKO5bi3/DPWrxy+VIgPsxXw8DloVCkEKl/
X-Google-Smtp-Source: AGHT+IEywlzeHmPZjrFNkaHJuAWinYokj1Z4x8uQFcdXt5pavkB3sR2HERi6scNnqzU3y3HHhZ/KGTbhnVqcuPS/44s=
X-Received: by 2002:a25:a228:0:b0:dcf:eb30:c580 with SMTP id
 b37-20020a25a228000000b00dcfeb30c580mr481340ybi.3.1712262201732; Thu, 04 Apr
 2024 13:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404171726.2302435-1-lokeshgidra@google.com>
 <Zg7hrt5HudXLBUn_@casper.infradead.org> <CAJuCfpHvb5Jt6J1P9aHVdRWYUHmBL1edfp7QHn=jF88gJRD7RA@mail.gmail.com>
 <adce9a6f-fccf-4c9b-8ca3-3140a6a3d326@redhat.com>
In-Reply-To: <adce9a6f-fccf-4c9b-8ca3-3140a6a3d326@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 13:23:08 -0700
Message-ID: <CAJuCfpEyb5tWGFUGMREj1zUBSiE3HNueHSPxGcPFnAwdfw6qmA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	zhengqi.arch@bytedance.com, kaleshsingh@google.com, ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:16=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.04.24 22:07, Suren Baghdasaryan wrote:
> > On Thu, Apr 4, 2024 at 10:21=E2=80=AFAM Matthew Wilcox <willy@infradead=
org> wrote:
> >>
> >> On Thu, Apr 04, 2024 at 10:17:26AM -0700, Lokesh Gidra wrote:
> >>> -             folio_move_anon_rmap(src_folio, dst_vma);
> >>> -             WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,=
 dst_addr));
> >>> -
> >>>                src_pmdval =3D pmdp_huge_clear_flush(src_vma, src_addr=
, src_pmd);
> >>>                /* Folio got pinned from under us. Put it back and fai=
l the move. */
> >>>                if (folio_maybe_dma_pinned(src_folio)) {
> >>> @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd, pm
> >>>                        goto unlock_ptls;
> >>>                }
> >>>
> >>> +             folio_move_anon_rmap(src_folio, dst_vma);
> >>> +             WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,=
 dst_addr));
> >>> +
> >>
> >> This use of WRITE_ONCE scares me.  We hold the folio locked.  Why do
> >> we need to use WRITE_ONCE?  Who's looking at folio->index without
> >> holding the folio lock?
> >
> > Indeed that seems to be unnecessary here. Both here and in
> > move_present_pte() we are holding folio lock while moving the page. I
> > must have just blindly copied that from Andrea's original patch [1].
>
> Agreed, I don't think it is required for ->index. (I also don't spot any
> corresponding READ_ONCE)

Since this patch just got Ack'ed, I'll wait for Andrew to take it into
mm-unstable and then will send a fix removing those WRITE_ONCE(). That
way we won't have merge conflicts,

>
> --
> Cheers,
>
> David / dhildenb
>

