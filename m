Return-Path: <linux-kernel+bounces-139449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93AD8A0383
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9832841CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32310A11;
	Wed, 10 Apr 2024 22:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmW9ZfgW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4647F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789075; cv=none; b=qea4zAFgjErbOttFYKxYBIG02Rjy6+Lw0k33z6wEGhwJqti1etlpmeS8k6kPX2Oo1NOi3oiYc2ZP4g9TUbXSjMDsvJXNu9cUedjuTGNczG7q1bxTSWgWFsXzP3Ty/nVBif0bMBFZ6bPAB232zYMFSuYcXz5BihPQI9HXYKH5f/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789075; c=relaxed/simple;
	bh=dEkR85D4XWCbgYS/l0Yq6bPsB1nCapF1eIhnKyIY7b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STDa7hvsjUECCRZWVE15/oLbU0U1uUm3imy9n+t1uhGqkb6zTU6E4FfjLr3rNXDfANQyz+g32zvi/QRX4XsnQMUjhksDg0ReFm+KSDIW64oYKIYglGbKJ9itOSIbotP0ytloOH8G824PLq+k222R2bUnZw37GowihD3GWMOyJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmW9ZfgW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so8306494a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712789072; x=1713393872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMizZl+Vqp5JNwp1YMb5ta7Uk1RvNa2X4SM4hK/B6PI=;
        b=OmW9ZfgW8PDzkW0jAbMU1NV90pqZfg4xPXI6mvQZbIrE/KoA/fmwkXkg+tkkrSWLVd
         fot0m6CmqTu/7T2dvd+jspzFehnMNcMt2PR1CAb6E7YHLgNYK0p4zLNbE4LqlNFgbSMQ
         6NWNu9PnJTPe9xOStURE0QuiYH7jVzWPgf0KLhOrMYj28eHRIXVEo2+Eab2cMVr3Gcg0
         fpxyodyy/Xsx+W0nMcexdW105rnipqmZULqNb5J5/AcdEYpzCG46MBt3y0BWNVM7iZke
         wId4Zd1RWTE4ytH6LMKdu6KBL1YcZzNSgMF2wVxZhzkI6dZnAt++/WEsY5zeBQ/4PFqZ
         6KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712789072; x=1713393872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMizZl+Vqp5JNwp1YMb5ta7Uk1RvNa2X4SM4hK/B6PI=;
        b=j+1UC6LU/0MYFn+KVtYZC37exvo85l/P63HhaSG8Z2Giw+788WmfCsuHVuDopFqWrn
         6NfESX7hcj+by6yiXMyOKNc6etubEXCe0wMVYZi2rPl7K6nOKS9LqRvVInHo91aHUmam
         e7lZx3qN10Cgu8rpbifm063RJeldUM/ccT7+qwCKn0qzw5xvsRQs7ziHksII4TxIZyU2
         7TP6tj3+CPZoKVUbu/enO2BfP7NMu6MabE9W/PAeEiZcSZDmUiq7BURMvxcG/CPdss3q
         XKi2hC9avmtQNXZDLXcgr/RszsvK+jpFb4e80cqFhsAQGQWt1V279xRgDcqqVu4FGrwP
         UKeA==
X-Gm-Message-State: AOJu0YzbZu/QrFgFlxe9E87KswK8i9j90HT1oEvbFLzSf+1vdaj4Vt3F
	vX08ncYor8Sf+cAZygnfTUWF13fvj+FxmA3w8wJ72/UsdD8HCMkOTHR0eoRCpbXw87CQvCrlzN9
	vQUSMx4loWf3QeHySaBtxTe6KiYm81Dlo
X-Google-Smtp-Source: AGHT+IHUb2kSqmQGoyf/pmBPVmanUCKY1ukJu0Hjls0xlJbsF3+yQNgx6yhmq+jquYJQb7UKAKsU2zKca4hxGXn8sEU=
X-Received: by 2002:a50:875a:0:b0:56e:359d:fcea with SMTP id
 26-20020a50875a000000b0056e359dfceamr2534639edv.34.1712789071572; Wed, 10 Apr
 2024 15:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409094712.21285-1-jgross@suse.com>
In-Reply-To: <20240409094712.21285-1-jgross@suse.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 10 Apr 2024 18:44:19 -0400
Message-ID: <CAKf6xptBEksXYaPg55fEHAvPLuCkW+h4iWerofxzu1GdLcrPBg@mail.gmail.com>
Subject: Re: [PATCH] x86/pat: fix W^X violation false-positives when running
 as Xen PV guest
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Juergen,

On Tue, Apr 9, 2024 at 5:47=E2=80=AFAM Juergen Gross <jgross@suse.com> wrot=
e:
>
> When running as Xen PV guest in some cases W^X violation WARN()s have
> been observed. Those WARN()s are produced by verify_rwx(), which looks
> into the PTE to verify that writable kernel pages have the NX bit set
> in order to avoid code modifications of the kernel by rogue code.
>
> As the NX bits of all levels of translation entries are or-ed and the
> RW bits of all levels are and-ed, looking just into the PTE isn't enough
> for the decision that a writable page is executable, too. When running
> as a Xen PV guest, kernel initialization will set the NX bit in PMD
> entries of the initial page tables covering the .data segment.

I think this is a more accurate description of what I investigated:
"When running as a Xen PV guest, the direct map PMDs and kernel high
map PMDs share the same set of PTEs.  Kernel initialization will set
the NX bit in the direct map PMD entries, and not the shared PTEs."

The WARN()s I saw were with direct map addresses.

Thanks,
Jason

