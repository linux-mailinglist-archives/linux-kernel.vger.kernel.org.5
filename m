Return-Path: <linux-kernel+bounces-143642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FF08A3BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C1A2837AB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24FC1CFBB;
	Sat, 13 Apr 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqv9b+We"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CFE208B6;
	Sat, 13 Apr 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998951; cv=none; b=V+iSV4wnX2oQlbzmvkBqynmCKAhqoycnk01N+66HmdSPqa8Ascpf0vwy6Df2cGWiiwfgyV/M9A94HnSOJOL2f6K2hWzhqJhuiTOGirYVMtCfd9p/851wDXC+ukQVrePLhD1fg1q/b852v2uqHQtFL8unPdB518sFKe21uJwLObk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998951; c=relaxed/simple;
	bh=XPRehqCoDRDu9KhHYz3crrBqqIS6vn4FnjXgBrmLMmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuqFukTJyt/bhem+tD2lVdMKS80ENzqqF03Nzdm7E1gYjSJlhe+f/23jUuiSsgF3T4/ORs6QRikDhx+jIbcaRBYj50Fp9tcCpm10TvLA+7ZbtHS07fWQXbiKSjS+8G/eFhHVgDf4LfuidwLoXz7FMYjYCJGXq+z0vjvT9pd0qZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqv9b+We; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so24168611fa.0;
        Sat, 13 Apr 2024 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712998947; x=1713603747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp0/G7jaP4xfrxL+Nun8zOzJR4cjAehFUaa+BSEMdpo=;
        b=Wqv9b+Wewe3YOICMKgyxyJvhHgSLliQdYiTZZz1l4a+b5OLZOcNRkd9unc4IVlLXB4
         ExPLzId+d3eaERVU2VNIBpUzlyB9onkymM132PW14p8JqAAtL2N1gbl1Re7YTuRqb+8d
         foVS4Nwbrd5tSKmG3VSOwmBOlc2Xz/UNGXj7o7Hu3b0QcubENchpSKrFl14SafhMWywv
         8ABDHKxzqdrE9o9kzyhetFrg6L2mGNu/U76Vr0oPJxP/a2BY0DgZt6n94Y00WtCzanUD
         BRqP1WaPFwSZH1HkwyyXwiCxKDhs3qV+ZRgwxWN0r+4cH5biWui6F+vcMCTXez9Vc6ap
         qR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712998947; x=1713603747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp0/G7jaP4xfrxL+Nun8zOzJR4cjAehFUaa+BSEMdpo=;
        b=tZUw/RQovQuvdzETIe7+VDm7IGIWXmccKWLki8hwiFE8b7+Tm+C9gQ8sbej/jY62gc
         W52qMq0kkdQp2DFUj5STkPQ2AlgYJmp57k8LSfgiS/st8LPchAsQae+cAFE6iUnSDKgA
         SVy9SyeJTfQLOWvixi9D3LiQWzgWXNdR5SJ3qsKBx4RIPRFtNOY3Qk84m73Ya68NJCgc
         mDn+IVZmdedPOvra/plmCakIvKd8tIU/Y0R/hTe14+JHMhZuidpj06s/9dCcosUIW+lg
         Hf+6QOzywSa6OPd9GVi92dbEkja9xAhiko5Nt5dMiCGCNi060VOH+EAzwASTCMhzDM9H
         UmTg==
X-Forwarded-Encrypted: i=1; AJvYcCVT41ZVEchC3EMdw1NZLKWeO5dbWQu47ANlZ4dbZNGnNMS5nNCMEjqIFSx0vp7fWMVG+gQ9B13LZFpdH+4NWvSTu+Hq1OCZ0nDJWX8L
X-Gm-Message-State: AOJu0YyNkK9b10oAP3jcRlekBx9FlUicDi//F7e4M0ndpIQwUUZbuFZT
	xFf7N2MAm2qtKjqcwTflk03PhbshoLbBMcPYssSLSWI3m4aPcKdSMr03TTf6rUGrkrgLagU1oUm
	pv9n4Nut3+mTSIg+mpy2VNXowDHY=
X-Google-Smtp-Source: AGHT+IHbtoFqqjXX5yyttD1d6EXR2Ucsz/XnNTkzhDCPle8jgk8iv+xWYiUcY861uOmzEGG6a/rKvF6l9YveU6MTRbc=
X-Received: by 2002:a2e:81c3:0:b0:2d4:9fbe:b5f with SMTP id
 s3-20020a2e81c3000000b002d49fbe0b5fmr2758427ljg.36.1712998947218; Sat, 13 Apr
 2024 02:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409112758.467112-1-rickaran@axis.com> <20240409112758.467112-2-rickaran@axis.com>
In-Reply-To: <20240409112758.467112-2-rickaran@axis.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 13 Apr 2024 04:02:15 -0500
Message-ID: <CAH2r5msm+xFyMPCJV7Luf6aQ04cHOhevmjJi8J-2Bf711T1ziQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] smb: client: Fix hang in smb2_reconnect
To: Rickard Andersson <rickaran@axis.com>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, linux-kernel@vger.kernel.org, 
	rickard314.andersson@gmail.com, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shyam and I tried some experiments and there are two cases where the
patch breaks:
1) ChangeNotify will time out
2) Certainly byte range lock calls (they can be allowed to block) will time=
out

An obvious alternative would be to not make this change for the
commands like ChangeNotify and blocking locks but allow it for the
others.

On Tue, Apr 9, 2024 at 6:29=E2=80=AFAM Rickard Andersson <rickaran@axis.com=
> wrote:
>
> From: Rickard x Andersson <rickaran@axis.com>
>
> Test case:
> mount -t cifs //192.168.0.1/test y -o
>   port=3D19999,ro,vers=3D2.1,sec=3Dnone,echo_interval=3D1
> kill smbd with SIGSTOP
> umount /tmp/y
>
> Gives the following error:
>  INFO: task umount:466 blocked for more than 122 seconds.
>        Not tainted 6.8.2-axis9-devel #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>  message.
>  task:umount state:D stack:0 pid:466 tgid:466 ppid:464 flags:0x00000004
>   __schedule from schedule+0x34/0x108
>   schedule from schedule_preempt_disabled+0x24/0x34
>   schedule_preempt_disabled from __mutex_lock.constprop.0+0x330/0x8b0
>   __mutex_lock.constprop.0 from smb2_reconnect+0x278/0x8fc [cifs]
>   smb2_reconnect [cifs] from SMB2_open_init+0x54/0x9f4 [cifs]
>   SMB2_open_init [cifs] from smb2_query_info_compound+0x1a0/0x500[cifs]
>   smb2_query_info_compound [cifs] from smb2_queryfs+0x64/0x134 [cifs]
>   smb2_queryfs [cifs] from cifs_statfs+0xc8/0x318 [cifs]
>   cifs_statfs [cifs] from statfs_by_dentry+0x60/0x84
>   statfs_by_dentry from fd_statfs+0x30/0x74
>   fd_statfs from sys_fstatfs64+0x40/0x6c
>   sys_fstatfs64 from ret_fast_syscall+0x0/0x54
>
> The umount task is blocked waiting on the session mutex. The reason it
> never gets the session mutex is because 'kworker/0:3' is holding the
> mutex and is waiting for response (see line 1209 in
> fs/smb/client/smb2pdu.c.
>
> Stack trace of 'kworker/0:3' just before calling wait_for_response:
>  CPU: 0 PID: 220 Comm: kworker/0:3 Not tainted 6.8.2-axis9-devel #1
>  Hardware name: Freescale i.MX6 SoloX (Device Tree)
>  Workqueue: cifsiod smb2_reconnect_server [cifs]
>   unwind_backtrace from show_stack+0x18/0x1c
>   show_stack from dump_stack_lvl+0x24/0x2c
>   dump_stack_lvl from compound_send_recv+0x7bc/0xac8 [cifs]
>   compound_send_recv [cifs] from cifs_send_recv+0x34/0x3c [cifs]
>   cifs_send_recv [cifs] from SMB2_negotiate+0x410/0x13dc [cifs]
>   SMB2_negotiate [cifs] from smb2_negotiate+0x4c/0x58 [cifs]
>   smb2_negotiate [cifs] from cifs_negotiate_protocol+0x9c/0x100 [cifs]
>   cifs_negotiate_protocol [cifs] from smb2_reconnect+0x418/0x8fc [cifs]
>   smb2_reconnect [cifs] from smb2_reconnect_server+0x1dc/0x514 [cifs]
>   smb2_reconnect_server [cifs] from process_one_work+0x188/0x3ec
>   process_one_work from worker_thread+0x1fc/0x430
>   worker_thread from kthread+0x110/0x130
>   kthread from ret_from_fork+0x14/0x28
>
> Change-Id: I53439ffb007c9c51d77ce40fb655a34e5ca291ec
> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
> ---
>  fs/smb/client/transport.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
> index 994d70193432..96b8f8757ddc 100644
> --- a/fs/smb/client/transport.c
> +++ b/fs/smb/client/transport.c
> @@ -32,6 +32,8 @@
>  /* Max number of iovectors we can use off the stack when sending request=
s. */
>  #define CIFS_MAX_IOV_SIZE 8
>
> +#define RESPONSE_TIMEOUT_SECS 50
> +
>  void
>  cifs_wake_up_task(struct mid_q_entry *mid)
>  {
> @@ -735,13 +737,14 @@ static int allocate_mid(struct cifs_ses *ses, struc=
t smb_hdr *in_buf,
>  static int
>  wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *mi=
dQ)
>  {
> -       int error;
> +       int ret;
> +
> +       ret =3D wait_event_killable_timeout(server->response_q,
> +                                         midQ->mid_state !=3D MID_REQUES=
T_SUBMITTED &&
> +                                         midQ->mid_state !=3D MID_RESPON=
SE_RECEIVED,
> +                                         RESPONSE_TIMEOUT_SECS*HZ);
>
> -       error =3D wait_event_state(server->response_q,
> -                                midQ->mid_state !=3D MID_REQUEST_SUBMITT=
ED &&
> -                                midQ->mid_state !=3D MID_RESPONSE_RECEIV=
ED,
> -                                (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
> -       if (error < 0)
> +       if ((ret < 0) || (ret =3D=3D 0))
>                 return -ERESTARTSYS;
>
>         return 0;
> --
> 2.30.2
>
>


--=20
Thanks,

Steve

