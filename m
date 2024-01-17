Return-Path: <linux-kernel+bounces-29082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A3830817
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5281C20E49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E99B208C4;
	Wed, 17 Jan 2024 14:31:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE501E491
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705501879; cv=none; b=QO0qTCt4/DmpK7yXw00Ippkf4OoNRaqhnIQL3sEYjG6WusFbOWwndXxUj2zjypkLiF/h3DU7YbvLBgDiXG/Vfx3YkF0k6lM+qtNe24ex5AU0nla8CvLA/n4oGS0015toKT22rpbzFgyPnsO4SQJtD+rR2U9mCoaobb00bOnHvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705501879; c=relaxed/simple;
	bh=+JWptn8VJG+GLb/8pY3sfJfb81aAyZC76P1KZ7bCJ7g=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=mtzUCIkr5iMG3I1DcJTgzjeSMsChvmV3TwulBxejwtkSeyuOwWL+9ejXoI6VtuWayq9HsMShPUiBUadKQC1MVzJOVfZ2yK9j0LchaFrgxtGv4CtTfGekmZPEb0dTLqt7JPyeYq36Bumqb5QBXzcu58PFiQGq2ifSTFy2IjCzYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E6EC433F1;
	Wed, 17 Jan 2024 14:31:18 +0000 (UTC)
Date: Wed, 17 Jan 2024 09:32:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
Cc: <nathanl@linux.ibm.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: make DECLARE_SEQ_BUF() usable
Message-ID: <20240117093234.660d4150@gandalf.local.home>
In-Reply-To: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
References: <20240116-declare-seq-buf-fix-v1-1-915db4692f32@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Kees,

Are you OK with this change? I ran it through my tests and have another
pull request ready to go that includes this. But I don't want to send it
without an Acked-by from you.

Luckily, Linus is on non-voluntary vacation so we may still have time ;-)

-- Steve


On Tue, 16 Jan 2024 08:09:25 -0600
Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org> wrote:

> From: Nathan Lynch <nathanl@linux.ibm.com>
>=20
> Using the address operator on the array doesn't work:
>=20
> ./include/linux/seq_buf.h:27:27: error: initialization of =E2=80=98char *=
=E2=80=99
>   from incompatible pointer type =E2=80=98char (*)[128]=E2=80=99
>   [-Werror=3Dincompatible-pointer-types]
>    27 |                 .buffer =3D &__ ## NAME ## _buffer,       \
>       |                           ^
>=20
> Apart from fixing that, we can improve DECLARE_SEQ_BUF() by using a
> compound literal to define the buffer array without attaching a name
> to it. This makes the macro a single statement, allowing constructs
> such as:
>=20
>   static DECLARE_SEQ_BUF(my_seq_buf, MYSB_SIZE);
>=20
> to work as intended.
>=20
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> Fixes: dcc4e5728eea ("seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str(=
)")
> ---
>  include/linux/seq_buf.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 5fb1f12c33f9..c44f4b47b945 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -22,9 +22,8 @@ struct seq_buf {
>  };
> =20
>  #define DECLARE_SEQ_BUF(NAME, SIZE)			\
> -	char __ ## NAME ## _buffer[SIZE] =3D "";		\
>  	struct seq_buf NAME =3D {				\
> -		.buffer =3D &__ ## NAME ## _buffer,	\
> +		.buffer =3D (char[SIZE]) { 0 },		\
>  		.size =3D SIZE,				\
>  	}
> =20
>=20
> ---
> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> change-id: 20240112-declare-seq-buf-fix-9803b7e679bc
>=20
> Best regards,


