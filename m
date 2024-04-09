Return-Path: <linux-kernel+bounces-137393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615FE89E16B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848611C210B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26778155A29;
	Tue,  9 Apr 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evF2W+/s"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177413D625;
	Tue,  9 Apr 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683189; cv=none; b=X5kRS0d7NBpinC6Z8f4DydMp17vnpL4NCooXDooV8cV5hGAZ0iyd8O91B/5e46KH8YWZnct26NVxxap9vrvW5veePx7fwL+Gy17/ppr+xpgd/fi7NNpivkL555CuGPFRZ983qmv3urxikT1kbEhzRZBo+3CNzf9rxNx/pk+Dsmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683189; c=relaxed/simple;
	bh=+VSy3cxkOwch0V4CbdGsETLz5jDAHn6p7SuVkzXBKlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpzUEPztdPZWONiAsru93T62OH40vcVC25bstsU4inXHsZ8a/m7tqRLNeC3jKAURGi3m8q7TmsT5Bj7A5KY4xL6pZjDZbMHzcfGS1WzbUUu8loPVs8h6mwU5+kRtO0gsq7U95m5Md+mDJKaF/BIYEIakQBGG8geLgvrj1otaTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evF2W+/s; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d536f6f2so4663858e87.2;
        Tue, 09 Apr 2024 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712683186; x=1713287986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KKTyTIbsFc3DDsu9SnRNh0iL4iS4ZelDeybkdPPbqE=;
        b=evF2W+/sIAEa0mu/zAhMZ2ym7zuH1mJxH0ATUyLyokmDbTht7q2mEMDiAnhSoumjqg
         mcuPLX3+wd4FbLcxqi4pI9wWyIDIiEiJUikToWHBqLh9sinWh0WWa1jqZH0A3sYsTv+4
         gRpMxS+Eg0gdG5P6YaCKridW2oIUgWmbPotpIKxU3Z/qzhZMAa5uKpg9MnO6FPZn0GMK
         ffz2K8ZhptteLdG3mBqN6kVK/B7YKtWMi8LZ+WkKni6Pwk2n7Wd8cl1ARdylx2QOsRyL
         NXobt+WVBEsEyNU/3qI/W4h+u97FHaxiBOWny86N3SjA+4mjGdAZ7MtjcRosZoVLSh2p
         DxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683186; x=1713287986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KKTyTIbsFc3DDsu9SnRNh0iL4iS4ZelDeybkdPPbqE=;
        b=vUIXASVaU9N47RIjtaAuKsDAEuswIStkOOkKiJgZFKlbrguTKVZdDk5KiNU6qwtDiX
         tvT03WalM7+xKN72eAAcmB58/0ZqNOQyJ00FyhjFx/dPAouoE2knU+YaqXMUOPY3oPGV
         C+huOmcrdfiC6e0RRo9G9IKwzMPzDRfT8ETpLOBeKU9QHpbrNgUqubybjn+p4MoLkSQt
         YeFE/wvcdVIjukfHM7XZJMu0L0EMLP7xTheaYoRZUMoKPS2qz0/BxcJDUZwQQ/Gk6sST
         sK9fXx0EStJkGI8IGp3WS4Hhvqokn0/X6QHFCSs7HfN8PXtSnIvND/OpX/WDjOH+al5O
         A5tA==
X-Forwarded-Encrypted: i=1; AJvYcCUeUXKIauekJv/Pxcp3zy6PAg0wrUlNdBsdrr9uVq6EqBDvNuIuNTGEKgfr8j76E+r+W4wajSziXymaVgP+EY18ubwoz3CjVRTgsVwB
X-Gm-Message-State: AOJu0YwDQMaNkGp1dQ95qRAKPlvy0lOXJrY6dcnrS9sTx25XZeSy0SJq
	Xw75pjmVcXSTOmJzEjSw/GyO88LYoYA/wFxnHrzXgMGo3b/nQ0GaeFHrWV42dQ/cdy4bUw/v+fo
	8NuM6yRupNJ6nHiGPsJf9AwxPflY=
X-Google-Smtp-Source: AGHT+IHt8ErjIQn0O9arjDfyXAUYVqGbU2vGyiifjGUrhIpjsTlIKqBAACuFKQqa8zx36Zjqw844fK8J4vt+g0KmYVQ=
X-Received: by 2002:ac2:465e:0:b0:516:d250:86c4 with SMTP id
 s30-20020ac2465e000000b00516d25086c4mr37955lfo.59.1712683185400; Tue, 09 Apr
 2024 10:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409112758.467112-1-rickaran@axis.com> <20240409112758.467112-2-rickaran@axis.com>
In-Reply-To: <20240409112758.467112-2-rickaran@axis.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 9 Apr 2024 12:19:34 -0500
Message-ID: <CAH2r5mviWen9OGKq++d+c=eGgKgGequ=97df+agFy0gn8hK9fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] smb: client: Fix hang in smb2_reconnect
To: Rickard Andersson <rickaran@axis.com>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, linux-kernel@vger.kernel.org, 
	rickard314.andersson@gmail.com, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried this on 6.8-rc7 and current 6.9-rc3 and it didn't fail on either.

I tried (to Samba, and using the mount parms you suggested for
cifs.ko) with both "killall -s SIGSTOP smbd" and also with "killall
smbd" - but unmount worked fine in both cases.

Do you know if this fails to ksmbd or Samba or ...?  Other ideas for
how to repro this?

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

