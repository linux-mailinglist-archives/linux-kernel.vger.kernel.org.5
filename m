Return-Path: <linux-kernel+bounces-29612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873668310C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4431F22199
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05323D8;
	Thu, 18 Jan 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="WmJiqwfq"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680D417C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540493; cv=none; b=SCMnNcXF1yCDpHo2eDJ4HEwWAl0m7StPMzGHlSxNqotTKp5nvphxMEJg9n7k5jrSNTO6l3SksLNq6nEMm6x8tYy0zdpC4NhbAn9RMiwMZIVGQY5oaXKuRwHOzE+XXiUSmdU6W5lSccFt1F0TvB6MJkAw8Ko5ElYCP3XGE9DiDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540493; c=relaxed/simple;
	bh=fkGhIFTMptb9xhfAhyS4A/QpWk/RM2gHSsGnq5nv6Zw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=uC1++y2yGjHVGiPyxIVMOrJqj8tMftdC5/2ZAwJfjPuhOF4SffNicm68NpgSwLz1T5zhczJSOPq7+bVGNBdTfyJHQQvSkW73Vd+dh2y7TvDFFY3LWHrbpIGl+Sx46LlGI+BIwwbTE95jY5CjBwKwvP5GcmT+hvREJuodkv+K0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=WmJiqwfq; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so8349387276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705540490; x=1706145290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtVNathGW0JnXzul60vJtkgKIy5SlrExorwVsK7K+oY=;
        b=WmJiqwfq7/pVOAlZEp6o7ofI0Du0xE0RwWi1V0RtZJpdFGrtODt+LA51yIAp4AZ+YH
         LOUQbjIZ3JHDILCxIy6deGJMxdQTaTfGCHG8X6BcRTv/YiscSmo6Wj/ep8Kv78lScUk3
         SSRd8vaaZ9HGZMa04OkizDtRoOOkCp8OKJp2mmMOFP+B3nuOWrbpOv5EFAeBjmzeRvXv
         9Imq3EK17Iy3/ICLjw+HqfGNt8fAbx+WnoNzW4/MQTo1r39O8b4RNIOyYgIX2PnVjgZ/
         eeZweCItldy/Inw3ODxSnG6jm7mdOqhZUQpuoGouqHPdgkVpNFoLXUr6X2EMZMZfWVgj
         J5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540490; x=1706145290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtVNathGW0JnXzul60vJtkgKIy5SlrExorwVsK7K+oY=;
        b=hgjtDNtXufp8VPI4QUjU0isTGElF4toayux2qYg/r7MVwEm38JJ/JG02walJDC3qHH
         h4snwNJ7amwV1DRUnrSN9LoGuS1UvoBPjny8rwt0e21f4vw147y+XZ5AJ4QPIykGWU3/
         qiC+xBYnRFnxd6l3drx3NTmJLqkGVvemQoMNMPZzGuwK784wPKv8YJLC+wIEp4LrvkYG
         9nfPm/RM7mMIvmLx7iooxdXxEI1/gi+GmhpY1Np1AkuB+rfbN2aA1Uhbfb5TpbuFW2tO
         o0V0GVlJj5wllyOLh178xItMFZ1oiWs4V6NM7AaL/jP1b9Kj71t/QTns1lISAsERtxIB
         Ln+g==
X-Gm-Message-State: AOJu0YyIViIkYY5DE+nvrGspBFCKvEkoZm/wCT/UxdMH/4yYutIfbnmO
	QjdF3GQDNwmX9H+6ZnIMPTh6oBGd+sVSv/vk09MSJzEkV1UYk3pH/am3125JEU9LNaz59Q2NhZ1
	66tzoZUmZeB4xh5JK015mvFfuZHANK5lYqrHBE7F6FY9AoidkKgadKQ==
X-Google-Smtp-Source: AGHT+IG4BS+zDXJpf2yOlKid1p1vo5m1dHuTxpvBKzBUiTuRGsyofb9U7Mhtf1c/FacchHKgt/7wMXgl5ZwN9Tfpdkk=
X-Received: by 2002:a05:6902:8e:b0:dbe:9dca:f1ee with SMTP id
 h14-20020a056902008e00b00dbe9dcaf1eemr34208ybs.120.1705540490228; Wed, 17 Jan
 2024 17:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240117001549.169160-1-kernel@valentinobst.de>
In-Reply-To: <20240117001549.169160-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:14:38 -0500
Message-ID: <CALNs47voQwiJysBKF-cdOufu8SRjfs9eNTHSwEihZsDJLVNJ4Q@mail.gmail.com>
Subject: Re: [PATCH 12/13] rust: kernel: remove unneeded doclink targets
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:16=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Remove explicit targets for doclinks in cases where rustdoc can
> determine the correct target by itself. The goal is to reduce verbosity
> in the source code.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/workqueue.rs | 10 ----------
>  1 file changed, 10 deletions(-)

Perhaps "reduce verbosity" -> "reduce unneeded verbosity" in the commit mes=
sage?

Reviewed-by: Trevor Gross <tmgross@umich.edu>

