Return-Path: <linux-kernel+bounces-59272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA084F45D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E4428BFF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698928DD8;
	Fri,  9 Feb 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2XQae5ap"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73093FEC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477362; cv=none; b=jJSrxrbg5DHNV8XfuKpG0PL3+sNGJpOATVHIHgwU3ku/PeGEZMSn12y4MbRkbvLbju+lbqkkUQmaVe778HRIAVGcwA8vmUTP9WTmH/Lg/U7FGjsBpVd37ClsmCm5aM4wLRh4YN8yEeTXOBLyP+MlCVujjIbx0e3Df6dc/oDIj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477362; c=relaxed/simple;
	bh=RgFHHs7raVYUXy7WupCB2WW9Niv6eFSl7EsJTR5+7V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vhkb1ItYXCMUf9tqZQIuX1LadD4HTT9loqpgaJZGxd5cNX1PG9D9jV3LDPbBzRpddL41+ZnNqpnP+DCo1CVKLq2MBeRWks86CEAEvrN2/UYpBnWwdhN/0Z4CURla8cSjVP37LwkhqT41GX7OlowCqQwFwLA68x1wAchRqepkbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2XQae5ap; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so395521241.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477359; x=1708082159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed++djY+4BK8SmyO+juBd+LCPHe4DjXsTTMrzEs49OU=;
        b=2XQae5aprUmX57r0mX1D61jjfJC4QRuGFBjm55EMBhOk9cpeUrBclyGRoafg0uwyLj
         XNw2YDQY/JYj7YjCvru0ucM7oV8LQeuJX8mL+AIticoaz25ELU1DUrX/2Kv1vUIdVLgm
         iNA8dXFrZZMfbwKBPXAbI0o8rHsIeu73LnHRVYTKTBV0V9uGGuxwhaLr6piVZLMSWaqR
         1wb8DgqKfXHcTQUU7dCzFk2/70lrd8MG7G3KypbC32/jn/fPZBmz9bmF4kVMV8/vxjKs
         uBJ5GdRI6ssfygG4q/qkegjOCPylKNU5eiE7Tgn+xvX59fJT8VfhNMvXlduHdQwgRPcX
         zfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477359; x=1708082159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed++djY+4BK8SmyO+juBd+LCPHe4DjXsTTMrzEs49OU=;
        b=WqujvpRrpziO1yuXjKOFz6s91cou+dzeFmWT3pFwdfKEWJGdJLzSYxIQ/v+abnzICK
         du7uPfqd2nD1j8uWthVh3zUplOuDy27fWBsMPeU0q6AjLQgoRy2iWSdx4iLciS+tjOzA
         e/qFpVG8dxVxIhvUSD13UQxcgaF8eE8pHdmD5k0Qjz+Ph1PWRzd51KaeN+keLwTF58GN
         v+CUcPcrOF1WZ1QGPL5332dVSTanV7TvZabD1KRI/xbsTEAyqDOEaNm7L5zG++TXft7R
         JqpbwOPG0R81ttpLUeFACm7vNWKvFnioBlTTP1yG0B7UovPiaPAtgb+Lk+0AKT3EkTKc
         X01A==
X-Gm-Message-State: AOJu0YxtReRJKgVSXVdoelcmPF9uZMvwbq4xwKOJd4FuXtluTpfyvy0n
	yBD6/xZfuwvWhhUi/CmgNVFjZnmVD/x7EgRDsLCv9tR02W07oVd/2Vg2CkLupnQhnXz9BWqdETo
	HgKGrRm1ee7/NtIVJspzQKLZGWqLde/1nKlmT
X-Google-Smtp-Source: AGHT+IH0++n+IHTTWPdJfvdvuEsjvhUJCSq1bKiKaAnFQLdwkCp91mU/3dxy8RDqz88HJr1OypbDDQyyy0IfIB2ShjE=
X-Received: by 2002:a05:6102:1607:b0:46c:b7a8:4b59 with SMTP id
 cu7-20020a056102160700b0046cb7a84b59mr1154577vsb.23.1707477359448; Fri, 09
 Feb 2024 03:15:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-alice-mm-v2-1-d821250204a6@google.com> <20240208225407.11951-1-kernel@valentinobst.de>
In-Reply-To: <20240208225407.11951-1-kernel@valentinobst.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 12:15:48 +0100
Message-ID: <CAH5fLghObExCR55dEozb2MSsPZWd7432z5FyOYmNKHFKJHt8Lg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] rust: uaccess: add userspace pointers
To: Valentin Obst <kernel@valentinobst.de>
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	arnd@arndb.de, arve@android.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, maco@android.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:54=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> > +    /// Reads the entirety of the user slice, appending it to the end =
of the
> > +    /// provided buffer.
> > +    ///
> > +    /// Fails with `EFAULT` if the read encounters a page fault.
> > +    pub fn read_all(self, buf: &mut Vec<u8>) -> Result<()> {
> > +        self.reader().read_all(buf)
> > +    }
>
> I think there is also no need to give an explicit `()` for the
> generic type parameter here as it is the default (applies to some
> other methods in this patch as well).

I'll change this if I send a v3, but I don't think it's that important.

Alice

