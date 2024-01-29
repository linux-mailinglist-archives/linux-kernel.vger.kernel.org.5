Return-Path: <linux-kernel+bounces-42414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD084010F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E8E1C22C02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1DF54F86;
	Mon, 29 Jan 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCYLv40d"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097754F8D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519603; cv=none; b=CpkEkx7Ur2DeHWac0xBo7F2wWVUzYa/efOiS8gKLUGtxx7ejcKSOdtCz+BZ0dMlIyP/ZRIyv3kU1+NRLBEpg1rsXgWCMJsGiVX7aPWcHPCvgO60YVUPvOgGGeaev8shkjtmY8uivypBeAfXL29NyVeAO1gSMQ6re/HluV6CvjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519603; c=relaxed/simple;
	bh=bF2t00xOJXl9AvwcB0rZA/dsnVo97qcDg+JBwusX7LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh4vgHWzQl1UuC+GZJsTaB6JMqhwNI/eH5cRDrvlUGPiNyx+Ce3vS3JkquKgyOKEjZl8riqfNeggMa9ZmJatgfvPsWBltj8gWL0hHaxslZIJ6Z69se415aMK3noIScXT3x69KzNXc84vp2wWRlZe+Ey7esWmnYF0qtNH5h2joXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCYLv40d; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so175697241.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706519600; x=1707124400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF2t00xOJXl9AvwcB0rZA/dsnVo97qcDg+JBwusX7LA=;
        b=cCYLv40dri8D7E/Ptt1xW6bdpRdL/WAt5OZe+bb/1wR7niwrXN3YPlUY0+joU1mLZx
         lzeBnnjaIDn9OQOfCoNsRx5/jya5Y0Qm4klnFWCUvcF2oaDaYiat1Mw2KzI9jq8kLf6m
         DA0+SlPNbV7WLpmpTwvATTlGAUVFcnLFSIz8CLkg3bxCAELeHf7gGrjiqKxASWIo73bB
         FZL+DzFA8H8qcoIfeWDxMXfIbwvs1+Z+eG45ETiBHN7yM9e5tHk0vIslxnxRU7OqmglI
         uTr1w9pqnafplHfw76N3z9VDny029mr6FxSZ86AAKH2z+stFj2YR0CwBOwgQmX3658Jz
         kmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519600; x=1707124400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF2t00xOJXl9AvwcB0rZA/dsnVo97qcDg+JBwusX7LA=;
        b=l+zPDiP3qPYlaCgtr2x4TxKGz4W6C5f8U8tUL/6v6D4ikvmShxi0nlpQN3WXMRNvFG
         NROHpYttzIdYhHmR7Occq4Jj8WW/y0/ule4VtrxSUf6BgR6+9oLWbPtSEkIpdX5V5d/D
         BbCfV1vw0+xE64A54oTTh2sNWmlBBDcdgXS1a3QOm5fBr9auk7Lk56eT2tQjlVz8I21B
         TSPo6SZMaVfmPTJfu4VCcvKcdEZk0Zw0h72hsfZ3A0vvzzzYrVpwPr5lCftlp8to43kX
         +420a3COoORCF0BLKKYYKXlUqY7Hj/a2J5NmN24ghCyYga059oeH7jYb7DnBYFuACaG1
         nuaw==
X-Gm-Message-State: AOJu0YzKxHRgLtKDDwiNwxZDCN9jGWqflg37aATYaou1k3cHKpPvHj6N
	/dZ7GSuG3VwjmX9teFSkKrLy+3Vcem0GGp0B8+lVryQO+yKFynsnmWwK5UPqt6dZV3XHkSXeWZ+
	CNL+Y364g9JvIEPqNhzOgN5CyKNml56KssYuo
X-Google-Smtp-Source: AGHT+IGgAGwvVfvdtbbTkD9ZuBzd0jtAAwxq50MLBKg6EZW86P4Umb8kCDg7pbtXkf13tfB5hqULi0rOXznuOjmIJ2w=
X-Received: by 2002:a67:fe0c:0:b0:46b:28b7:26ef with SMTP id
 l12-20020a67fe0c000000b0046b28b726efmr1443056vsr.16.1706519599234; Mon, 29
 Jan 2024 01:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com> <CANiq72kx8oBO_oFZqfKdC2U9R+je1UiA+nVAAwZAEivqvfiZQA@mail.gmail.com>
In-Reply-To: <CANiq72kx8oBO_oFZqfKdC2U9R+je1UiA+nVAAwZAEivqvfiZQA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 29 Jan 2024 10:13:07 +0100
Message-ID: <CAH5fLghZad5M3sAFEiaTePyMxbR_=fhMieg0m413rs8fHc2KFw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Additional CondVar methods needed by Rust Binder
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 9:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jan 8, 2024 at 3:50=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > This patchset contains some CondVar methods that Rust Binder needs.
>
> Applied to `rust-next` with conflicts resolved after the `wait_list`
> rename, added `CondVarTimeoutResult` re-export, fixed typo and added
> note on the `sizeof(int)` being unlikely to change.
>
> Alice: please double-check if I missed something.

Looks good to me.

Alice

