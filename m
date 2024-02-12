Return-Path: <linux-kernel+bounces-61822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E18516F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BC11F229D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473183BB2E;
	Mon, 12 Feb 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdngOZQo"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330893B78D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747748; cv=none; b=AweSGcVPSVrvmGpuhchUxNI+sBqjPm9rTDlpOyr7iVoMyVKKnFsWK5xPMl48S7Ol2XBiLeSLuzNoi3kn3B1v5bFbvt0CVo0KR5ILTzc65+TL5QA5SmCfZHJsU7DeXlgGvR/JmPike4kpgbQHo94sBAE8WriXq3KRIIyEZIm3GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747748; c=relaxed/simple;
	bh=fPFMCUSQsbybYYsyahcIf+x82OS1p8+vzVVjBWGByI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaM7b7OyahePPKOh6sWC8TeX90YPuyt4ez8WA0/33MZIMtezBlgMy9RzSjbq4D8KaDfuCyDbh1fIVF2NnRlflFsJm00UJ74v1uasc2SDNzuWZxyNlvdafrZGHdg+LrtwnBvZiRM6zFO+itOvUOFC03LnEqSqOfnxjimKoKyd9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdngOZQo; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso874611241.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707747746; x=1708352546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3LbdBXEWnAUnj+b+2jhT2ldLpLCcKlNQ2zbvZ1/YpM=;
        b=QdngOZQorjz8pwucczOJ3oVwy/OpsXpfLA6pOGGghemnmaO5emtS8VJOZj+M//PsQE
         lyR1qdftpmuTRU05uqm6GWkWD0GlpyTfTQXSZEXWJzsDlXNgazfwrv6/1yN38CwZwAi1
         lhrngJd5OiX4QCDZObAyGI0/XvcdzqsSvUBRUy/9tveZ+roMsE7dwxdG23mHImiVMsUQ
         k/3aI2gfCH9w1y7UKGmsZrQk5y9hj2wjfl892jQscLeF4Rjh92Kztqfo65lzkUSodKN5
         Exo3jPTgB8/5+0g6WSZRbwTUrYmPTwgxivR/UCzGFZs08K+bPyqYX65+7pEVK6QDxDMY
         Y1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747746; x=1708352546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3LbdBXEWnAUnj+b+2jhT2ldLpLCcKlNQ2zbvZ1/YpM=;
        b=m6ZkyGXPN2QPRT2AhWq41I7RNrsdO1zSExlE5gOvvD90xH6r9wcaSzRSdJPF6/pynU
         9DB5Bcuqx7iPwSzH0xbL0DocvPg2wzHCqexa36u24aGsCCUU/9AqBbhzWefrSwfEaHBA
         XYZVsb2QehXY1Tg8hKBqucRnQUyxoQJk/LoagppjmxHcxPCB3GVFSaD/JJdUBoP+uqrv
         3MEdV7GsGe8jMcoUnIC0OK4gmbZR0YoGs+JMSQ244B2+ar06D26EKTiv3oEX+umD2zg+
         62DCZS/y7TsoT1ECFpS25NtEzGK8kkemHUf4O5DoyKo/lLXKsLTXfdfMiTqwq0VTy7uO
         TQlw==
X-Gm-Message-State: AOJu0YzCu4gL7rRXOehl1SHXk0AA4Iov1xGRX4RO0UMindzwnjrPKZ30
	gEr7rKsweCBChj/5vRKS+B+JG7IrY/HICSVA2EG/VyJBHVPy+yV1bcOZUyJm7xBHI7Y9MSk2+rP
	XUC7TYiqpo4d7EC1zvbO/WXqchXBkDFaIZ+F0
X-Google-Smtp-Source: AGHT+IGcly7MGpGlQ+IX/7WhJbvTN43iKbx6NBGvEk+t+fbdMNeIGEIqTF6T3+x8UPm1Sblqp9i52vyvtYcK3j33zrY=
X-Received: by 2002:a05:6122:4a8b:b0:4c0:7756:547c with SMTP id
 fa11-20020a0561224a8b00b004c07756547cmr1723692vkb.6.1707747745819; Mon, 12
 Feb 2024 06:22:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com>
In-Reply-To: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Feb 2024 15:22:14 +0100
Message-ID: <CAH5fLghTKpLs=Wb03cjx0LRQbZgmXRoMNy1cyheb7cQRL0mjsw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: locks: Add `get_mut` method to `Lock`
To: mathys35.gasnier@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 3:13=E2=80=AFPM Mathys-Gasnier via B4 Relay
<devnull+mathys35.gasnier.gmail.com@kernel.org> wrote:
> +    /// Gets the data contained in the lock
> +    /// Having a mutable reference to the lock guarantees that no other =
threads have access to the lock.
> +    /// Making it safe to get a mutable reference to the lock content.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        self.data.get_mut()
> +    }

It's impossible to call this method. You can never have a mutable
reference to a Linux mutex because we pin our locks. At most, you can
have a Pin<&mut Self>.

Alice

