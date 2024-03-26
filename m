Return-Path: <linux-kernel+bounces-119064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236588C390
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7440B22CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919674BE8;
	Tue, 26 Mar 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiAUb/a2"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387704F890
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460132; cv=none; b=blxHR8aQQxrzmhr0KWaiUwP1/q6ByBQ2Bak+NpI9moXX6T0GuP03HDQ9ubn6X6K2WHYqZhnFRfowie2illc/6rsDbOpUgZaoumR/ymaBujxVUwabdz8NNs6cPe2uoWr0NPzOYo1F9NUhni8lNZhesGOJ09mtVseikDFbjBnXY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460132; c=relaxed/simple;
	bh=rj9wNslWKACImubsN/JQmDHu+gQx8aSv4Y1IPRRrmlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMEZ+iiDwEDsE9DRefYUss98gm/rDSwaBz5fFibl6ayVL5IC/o7bajExVQnKD6nsSE0AYnK54r7JV6aLp8CkE9GPrMishpJCJ+pNOlYiJWc9mVtWvV4+sXK9eYkQ+pCknV7sSEjTXYajQQdSAA6WiJef0fA0L0KlV/8cHyIxCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiAUb/a2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so765000a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460129; x=1712064929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkxXRF/aPdhL4L2cV7/gEtwsEUt/jGctHq5T5exwZMc=;
        b=eiAUb/a2EfSmCe17+lhYq5tIXccdS6ErRxv76cdhHfsy8liVjarp3M5FU30UgFOCdc
         YLqjfIWF1PEXOT93Srl73QfxJlhTcCDgRG0vxmbRJDSH0wKAmgw89DswSSOVW2soRrK7
         ZS5JW+Qmz54Q33v5uTXGI+eq7p9+QHhBr9cvz/g+Z0V7hEWNrL3CTuKU2e+k0K23gaum
         3EXZjyJ/MInaZ6OufwVlrmgfCsTfhFzmQzYljlRQ3in7CiXRLShID9OfYC/V2yVXZ2Jh
         db8B4iN2q92bxmU1XvWvy2LSgsnuQ2bDW1fdotvwrA+1YDpGyORpDQS34ADiGLchDhLo
         oHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460129; x=1712064929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkxXRF/aPdhL4L2cV7/gEtwsEUt/jGctHq5T5exwZMc=;
        b=McU6pSydTMT41CoKbhEiMm5ZiiZtjsmWamErBcXNt1GsA8m0Ggk4XooxNOa92xVMNv
         CZUdiYjUZa6eMW7TIUdIGLtg9/aol+HyRQowDEe7aRsDvwZpV9aIfwI784J2jmfoy+mk
         CiUbQYG9Ej9Bl+RwKf6541tFgR+4zcHUyKJKqur1pTIkofYJb1EB3Y1aw5DCRRU//PQX
         LJJuGe7UYsoD/9qSRv9qBpnfNbFulrWI4VXJFHnBAvybhbEb9y/hUlJ6k6MVW08U8ywa
         XkzwZzEMP6RGwnUNvxYjX+AFwBAX4evrSlSCFF0VqRsJx/J6XVNOZBL968V0GZnba05S
         y4jw==
X-Gm-Message-State: AOJu0YxcxW5qHKDRNq28WLUxDGjESDXtzzsEIk2nwLbkJU/R31Oi7IX8
	mkhHmHWTqSMbZi1v33yxpcjPQBESIObi0IAuzN0KvQLJGcyZ+ZgLHVd/hJKp67GKMBH4dWHyFcO
	OSj9pQ18kSnFJXSAUx63y3Dplduc=
X-Google-Smtp-Source: AGHT+IEGrVrMhM0dW6wJQt8oE6SVOzkXc07iqDZnePDXG8W1ZSvUSUqgtUkV2K/HH/TGSpvR6aXX7bs/tv2AYdNf/U0=
X-Received: by 2002:a17:907:868d:b0:a47:5351:e8a8 with SMTP id
 qa13-20020a170907868d00b00a475351e8a8mr2629227ejc.33.1711460129234; Tue, 26
 Mar 2024 06:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325035102.15245-1-adrianhuang0701@gmail.com> <874jcueydh.ffs@tglx>
In-Reply-To: <874jcueydh.ffs@tglx>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Tue, 26 Mar 2024 21:35:17 +0800
Message-ID: <CAHKZfL1xq-pemEMo7m8DctEVxSG_ASQWxCC_HsN=-92UAjP_Mw@mail.gmail.com>
Subject: Re: [PATCH 1/1] genirq/proc: Try to jump over the unallocated irq
 hole whenever possible
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Jiwei Sun <sunjw10@lenovo.com>, 
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 6:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Why are you not handling it at the place where the seq_file position is
> iterated instead of doing this + 1 - 1 game here and getting the next
> number only when you already ran into the hole?

Thanks for the comments.

Yes, I did think about the changes in int_seq_next().

The reason I made the changes in show_interrupts() is to minimize the
traversal times of the 'sparse_irqs' maple tree since irq_to_desc() is
invoked in show_interrupts().

Does the following patch meet your expectations? If yes, I'll submit
it for review.

Thanks.

---
diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cb..ac051a9b8 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -19,6 +19,10 @@ static void *int_seq_next(struct seq_file *f, void
*v, loff_t *pos)
        (*pos)++;
        if (*pos > nr_irqs)
                return NULL;
+
+       if (!irq_to_desc(*pos))
+               *pos =3D irq_get_next_irq(*pos);
+
        return pos;
 }

