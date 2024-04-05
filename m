Return-Path: <linux-kernel+bounces-133064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4D899E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E218FB21FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698A16D4F9;
	Fri,  5 Apr 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0dpdXlM"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E816D4E1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323808; cv=none; b=sNwnOS3iiAG+ORekoz9WW9tmQ6M0/isgrWaAbgeui3cxVCDB7Pf92MSvfYrMZHtIjEqhkzFp+DjtCQmAA57LYYOAw7gtItVV0Sr43utmqisfSmHdkYUGnG9n/izjhJxdYrALKRlhLadOURZAMowX3WQudNprqOHIIvNTWxG87UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323808; c=relaxed/simple;
	bh=wSswXutQJ+wCZIDOdh13zZfPNpNOZaTJPxJxnSQYIrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntnYOs50vyB6uQ6VsRDocC9dcD20tzRCubiBYakuV0JwGcmuVbbmevpRiZPUvrkhKJxxZBmpt5EhgDkMc6GCd80+UKJC0dNPrwsIAxbYyW/foRx/VILCGUpu/g57VHr0oSKoUVB1sgU1+s5/Y0h8I8M53tBAve4PtBIWgQEDz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0dpdXlM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so10435a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712323805; x=1712928605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udhYzo9d/0PPqGVdd4D3LGjxi+bDzO7RIJlIIFERmQE=;
        b=h0dpdXlMP0f9BdNCgI3z2niKFXY9IYX0Nco1p7nyhoLd2RFtzrVsqFiIjztlGdKcx7
         wcyCekVug7fXUGKUXGx5ORzxP1flB2jj7auYgifZZ5v5fInbkVYHYRKdln0OP6jYD3pi
         Xrv6ggpi8FVSsputPRghJWQWJ4s4eEaDTdjH+Rlq4RVRJIs/Rx5AlZgSVKEi3h9MbmGa
         gQtPAikTtw1tQDjJxSxH/JL0aOakrB+KFbmYjCdKmLPE1EyobbmSLJnyMPbrkoTqX5k1
         CUjKDAqTaF/mn3kknxmnVsUo4HaIa30jD9yu2vX5fUmOMLvVRCtdIOHp7FG2/lBbYGJN
         ORxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323805; x=1712928605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udhYzo9d/0PPqGVdd4D3LGjxi+bDzO7RIJlIIFERmQE=;
        b=r7nFC/3jwrA9yK67mSOeguqla57x3oxlppigQJEoRbjl97sJqefl/jkI0wsvvyiDDX
         7kP7RMDMHbtSEKHSh5HS2wqNqS2dXy/JsYMnLYAwUkaQRxbrnfH+6VDZHsOmGh1XiBZq
         140qNyip1UAdn7c+4sakATy8G1c0NIPA/j0TBGoCgorkvUjxS7lWqcVKAyjkaHBfSpLo
         AlHEg0xFzQ/pna6wmgQRg9XrBCxk8li0hJVttzwNvaSOs95XKS+BP4276nAGlBiUfRVy
         8EZfoEXsPPOVE2pgoFPprH75cMzLbuaHdrP43lM85BDAPf8YrXS3GjhZ+HepfZmqBD4d
         Vl4w==
X-Forwarded-Encrypted: i=1; AJvYcCW2OBjxSagFIJta1Hrx1EA5ivBZAWbUgmrEzHVXV9KKIaNU2FicZHQIWxuFR4hd/U8BHg5IA+zfvghbV6KuAkxoYCX31jhJd9KUfjLW
X-Gm-Message-State: AOJu0Ywoi8v9VxusSRfgyyhwAkcYdttPU+un0N4qAhHGPP+IB103Px0F
	xNi9HL4G1S9qGxQI38eLxOVYgymIMFiBfqfXyZMy+7if1Wxyv81pwwpItaxsUqil580C4kwitx6
	zg1mwyXyGbKIoIA+I0ADvKyCHJULjTTn7CBX4
X-Google-Smtp-Source: AGHT+IHKnNwfoWVM8o54afDpZXoYzLLS0/kJjLYpGez23Xun7fuG7ohs51CmC+MLEwtVWDcCBP1C25v11O1H+kvmdgE=
X-Received: by 2002:a05:6402:26c4:b0:56e:22b4:fa72 with SMTP id
 x4-20020a05640226c400b0056e22b4fa72mr347542edd.3.1712323804808; Fri, 05 Apr
 2024 06:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
 <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-1-52dc49453649@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-1-52dc49453649@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 15:29:53 +0200
Message-ID: <CANn89i+2TMNF7chYaDFEBNRng3iLPaXBqXKNtZYevDd95-PqmQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: add last time fields in mptcp_info
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 3:06=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds "last time" fields last_data_sent, last_data_recv and
> last_ack_recv in struct mptcp_sock to record the last time data_sent,
> data_recv and ack_recv happened. They all are initialized as
> tcp_jiffies32 in __mptcp_init_sock(), and updated as tcp_jiffies32 too
> when data is sent in __subflow_push_pending(), data is received in
> __mptcp_move_skbs_from_subflow(), and ack is received in ack_update_msk()=
.
>
> Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_rec=
v
> exposed with TCP, this patch exposes the last time "an action happened" f=
or
> MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv a=
nd
> mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
> deltas between now and the newly added last time fields in mptcp_sock.
>
> Also add three reserved bytes in struct mptcp_info not to have holes in
> this structure exposed to userspace.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/uapi/linux/mptcp.h | 4 ++++


> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 73fdf423de44..2ec2fdf9f4af 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -896,6 +896,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptc=
p_sock *msk, int level, int
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *inf=
o)
>  {
>         struct sock *sk =3D (struct sock *)msk;
> +       u32 now =3D tcp_jiffies32;
>         u32 flags =3D 0;
>         bool slow;
>
> @@ -930,6 +931,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, str=
uct mptcp_info *info)
>         info->mptcpi_snd_una =3D msk->snd_una;
>         info->mptcpi_rcv_nxt =3D msk->ack_seq;
>         info->mptcpi_bytes_acked =3D msk->bytes_acked;
> +       info->mptcpi_last_ack_recv =3D jiffies_to_msecs(now - msk->last_a=
ck_recv);
>         mptcp_data_unlock(sk);
>
>         slow =3D lock_sock_fast(sk);

 lock_sock_fast(sk) can sleep and be quite slow...

I suggest you reload now =3D jiffies32;


> @@ -942,6 +944,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, str=
uct mptcp_info *info)
>         info->mptcpi_bytes_retrans =3D msk->bytes_retrans;
>         info->mptcpi_subflows_total =3D info->mptcpi_subflows +
>                 __mptcp_has_initial_subflow(msk);
> +       info->mptcpi_last_data_sent =3D jiffies_to_msecs(now - msk->last_=
data_sent);
> +       info->mptcpi_last_data_recv =3D jiffies_to_msecs(now - msk->last_=
data_recv);
>         unlock_sock_fast(sk, slow);
>  }
>  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
>
> --
> 2.43.0
>

