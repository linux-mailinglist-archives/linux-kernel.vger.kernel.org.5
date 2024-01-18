Return-Path: <linux-kernel+bounces-29610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C168310BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996CC1C2212E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125928F5;
	Thu, 18 Jan 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="noiMZr5T"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E20FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540281; cv=none; b=rQm4glDlNyYhaCseyLfAgT31g1pgfcT1K5HvvO9J84HRqKjyEUGui4n4vnbiek8mPZ0JyorL9qfSaQfPOncRQ+lgXLnGNj3qhFHYeuc1LeT4Gu3L7SdTo48ztNIOH1uj4KGq1iiGwuYHpSeTAuW9algLRoNZr9XmgVpnvC2jmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540281; c=relaxed/simple;
	bh=Mbiemn9bNiqAzsD5hmKIXqM++sizsaeERmPkQsqYaMI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=qTcePvQuTJVKs4nIbu3+3qdB0fj3k4sY2v5wre+Uoo5ETrizrcKYEmTPO4sfFzzQkz7vB856UdnzE+wZUnRTRKVnxNxDIjcXk83BLByhCSpE9oMblnSa4EpSRWNfrQ2VcolKSGxZdfLpGh3jIxl13RzwiAg4/0IDOwCTFAFFX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=noiMZr5T; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5fa4b03f3f5so84268567b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705540279; x=1706145079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbiemn9bNiqAzsD5hmKIXqM++sizsaeERmPkQsqYaMI=;
        b=noiMZr5TDMMViTZQIlnAwRJxKmmSyrzM8OdXQeabufpNGn5GwKjN0CgwHRHiYgh60v
         p09XX0QWeCbbo7M/SuprVPY50wj1TKTJm5730P83AnYL4vewsfKE+twW3E9CAxtTyPkg
         zyeHseCCuLNrPT//+57gp/84SmuIaLb12UBBrve3le25sjKsGHErJ0SB6K4QR6b9VZbu
         lqsBomxS/6Er6lkfVRGTwmahkiuAGvN7LwK1pF1u2Bgc//O8AHmyIymCM8C/UKXIXkJw
         Ll75gE04W6ZNO7n19MnKZI4FT8bq0yUE6VR1NqfpH93Ts6GDASzvxEEa9xu8dVjbv+pb
         Yzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540279; x=1706145079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbiemn9bNiqAzsD5hmKIXqM++sizsaeERmPkQsqYaMI=;
        b=qqpSrNlqS78wgRsW84l2dVDl8OGgkhTUnkADZ5KhlIXRzMLaKExmB7G05dVM4J9ifn
         C2uSRnrdv7jInmFe+mVpKP9ip9xo7RqRrh75E894UludUMAVqMC4VsP9qIvvgMqQv13p
         2bDNgm3XVIOcAxkJzL5SpWhBjwQaEc6GpWxcLbf0J6596Rwy9prhIDvxrUw/2QkSMSzp
         We+TGUQ/bLAX9Hmzc+Xx99ZC1YELdOBM0HVXnb7MYF7Hmy53h3+xY1dukguhnNUigpSE
         WVLm4akYxDroA7+RzsTWqt5/GLGXM8arxV/uPqnyhggoCFtXsbPXovHa3LauKdyLvOoM
         LYCQ==
X-Gm-Message-State: AOJu0YwnSi/ULD1ymca1XzG8cmTaakAi57AbBon4V7SdthHa1RIEYbMV
	RfjvcY1r14K3moi+GzJ0MgzZ7POMqDDFKfX7Kr8HRImFe8R+kkKaqvQh2mw9gI2dT28aGWCetaa
	1mSyX2wMcZTzXMCAEN13BLbXXti9a2BpH+F3aAA==
X-Google-Smtp-Source: AGHT+IHBCsfQctPq2b/mqGf5kAt0lT17/b/zhvefM8308FcYubd+ZlwIaNu1OG6pW9VXpJvA7GY9mU7Yg73C+w0NsRY=
X-Received: by 2002:a81:df08:0:b0:5ff:7a74:412e with SMTP id
 c8-20020a81df08000000b005ff7a74412emr84621ywn.38.1705540278832; Wed, 17 Jan
 2024 17:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116231035.168838-1-kernel@valentinobst.de>
In-Reply-To: <20240116231035.168838-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:11:07 -0500
Message-ID: <CALNs47u5ZhDm8Wu_nuPJnSkk0E2dzPcGTtN_D5cPBfcLKYgyug@mail.gmail.com>
Subject: Re: [PATCH 09/13] rust: kernel: add blank lines in front of code blocks
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:11=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Throughout the code base, blank lines are used before starting a code
> block. Adapt outliers to improve consistency within the kernel crate.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>

