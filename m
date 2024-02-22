Return-Path: <linux-kernel+bounces-77428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26716860541
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D537C28854C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C37A12D21F;
	Thu, 22 Feb 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7kr7uFD"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BFE12D21E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639017; cv=none; b=jPxGURWL88iB0gBctX3HmZ370nwwq60JIZxF4JpdrCfZkklkOGhUjZZvqPOxPaZ18GkJhqRPY5tHrCxYW3T0SsxcoF2y9PTTGKFGVpcyAsndBp2PZmTjarRoWYvIMB3fTTtrSvjHrDZftRznhugZ45ZMYbKKrJQjoolXD9QhHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639017; c=relaxed/simple;
	bh=A4yo5UttVBcl4+Wm78BT/nDZL2S8f8QLlOLzHENw/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkjW3VtdMCqx3cXVU5duNq/LcAQmgveErlzvBVjAsXLY2Bza0EdlqDngsAA4wxKuvhQnfqNf000P2ZVilvlkalXNdKXKsaR5DYFjH7TgBtZ3FbwL3K9mdaax/c9cxAgVgDYEZ5dB7Tu1bt5zleH6Kw42KQvg85va8q/WM75mLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7kr7uFD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6002317a427so2019727b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708639015; x=1709243815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4yo5UttVBcl4+Wm78BT/nDZL2S8f8QLlOLzHENw/qc=;
        b=i7kr7uFD2m50ApkR4P95WmSd9BMXPdKVHBOmqUGRNCNcQq2BESs38dcS/keb9MIfyv
         bw7+QFGMAGLyksBOIsW30cBV10JqdSkJRLktcwD60GDvdHjQygQrD4/T1kSbfscGHlON
         YaUdG6BFulc7P8/rEWqRo4mEa+dqjUl6ektTDVQ15efUg0cHKlnKNBFweHVXSbgO33fs
         ZdHMNymErIvqAZqtpmdu24+d2wEwxrF2+JJ9BWC5YFKYjZXogXniUoEJ3/uC47t0ablo
         0SggEJiM2GuqgQZvVRi9egSJ4t9OWJMNiA4U95YgFHlZIpUxo7UNqLeuVP7E2rmidgcc
         H+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639015; x=1709243815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4yo5UttVBcl4+Wm78BT/nDZL2S8f8QLlOLzHENw/qc=;
        b=PFaEf9Ptd7mNkOpBVOVTA4HOelU3ehfTzkX3NwajwXl8qF+tOXyJsyf0+GAYlJ+ZHO
         cRiitSfqHJDZfcXaYX1pjSddM3mi2iTf1Iin1I19AR2JeSNdNypw7DSDAwDzcFHIh/nb
         hq73x+XrnmE6FqjqtylUWX1UzVqbLXfNjaMWJTtpK4g8e8jtXPM4KKXWDqcQoyRdJHfD
         FhBiyE4PnCBB9J5/Jc1jWQ9tDeLvu8z4yptFAF6plf7ruhKRDPfmaXsV8C6VoZ5KT6By
         3VhUrbANDab8MWh4KSac+reYa1ZA6R+1NYtoJDYkEiedEoBu0UbTENuHaoUUdFFLU2O5
         VaCw==
X-Forwarded-Encrypted: i=1; AJvYcCV1HcqM0GWZ6+Azh1BBIFQrbExoqiq+mJVi6Ux0qtN9Aje/Ct7r9OudfAApUb61tYhekGVEN2RhICO2wStZ1gy3kFp6hjMc2neNMl9G
X-Gm-Message-State: AOJu0YzyWIOSt7Gw0dYMVoFHKVRBomyp0NgLjWosYtObehSZzPHy/DAn
	vnILzd8V8TT+RqbETGbwWawA3EXnq73OWtqjopiIlSddG6n5niX63Ui5xQFwdu4mhdOXD39rFZ7
	6klMgG5Rb4Aflk8Ql+6yEqRbV2hIkzOirYKUA8+Cn5OEnx6Lybg==
X-Google-Smtp-Source: AGHT+IFmgRVvi5T0P1Czc7H/RoVAFBHNXb7TfGgkcvEuKJD6OdVQOUibgYRqWAU/Ms6SXyWzass5Lmaf9TDZOL/tCgY=
X-Received: by 2002:a81:ad07:0:b0:607:d5c7:6a8a with SMTP id
 l7-20020a81ad07000000b00607d5c76a8amr455225ywh.25.1708639014981; Thu, 22 Feb
 2024 13:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222080815.46291-1-zhengqi.arch@bytedance.com> <20240222130005.c3f24eed1c1a27c66947e9df@linux-foundation.org>
In-Reply-To: <20240222130005.c3f24eed1c1a27c66947e9df@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 22 Feb 2024 13:56:44 -0800
Message-ID: <CAJuCfpHoxAZvRx2VN+SzsjefB5demhk5OV_wPe8JYnsejgA91w@mail.gmail.com>
Subject: Re: [PATCH] mm: userfaultfd: fix unexpected change to src_folio when
 UFFDIO_MOVE fails
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, aarcange@redhat.com, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:00=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 22 Feb 2024 16:08:15 +0800 Qi Zheng <zhengqi.arch@bytedance.com> =
wrote:
>
> > After ptep_clear_flush(), if we find that src_folio is pinned we will f=
ail
> > UFFDIO_MOVE and put src_folio back to src_pte entry, but the change to
> > src_folio->{mapping,index} is not restored in this process. This is not
> > what we expected, so fix it.
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
>
> What are the expected worst-case userspace-visible runtime effects of
> this flaw?

It can cause rmap for that page to be invalid. I guess memory
corruption might be the visible effect?

