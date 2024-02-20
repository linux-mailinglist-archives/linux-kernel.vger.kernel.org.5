Return-Path: <linux-kernel+bounces-72324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC085B1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A00B284F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BC56453;
	Tue, 20 Feb 2024 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJ/phHWP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81856777
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404631; cv=none; b=t8r+UkhhWg6gtNYMJFfDFLqFKxSZG/TmnCBL9QTpWwnciQ5LqHQuCzu8yBos9c/Uv7F4gFbrdkcZoKWi3Q4rQ/ESJreJuNv/lhtsl+SZ2dwcRzxShLlOIKEzdEjih326Jtw1Cm/pV41cwwZexhftH613orJ88DWmWJPF98yrKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404631; c=relaxed/simple;
	bh=gnYTVEhLa2UI/BXFUj5DRblz/ShatFGmeSySyZRlwEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mezc5E8NfNr6lgBehLWdIZX79uRUfBWdB2++hKmzQGwOzAvf0pSDofodrvI0/UUgLJ6wiFk4gg4HSdL1HEmWO+Q1RHH/CtwAaBdq6Ka0+9xpPGh0A17tciGH187Qm3V7oJ7BhBTj6UmvNXpUQNJlXfv40hVgkcQwupriHVllYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJ/phHWP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4910491a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708404590; x=1709009390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBhO9GN51pgFt/DHFo2a0IcTSs/s3/od7X4R5TK/fL0=;
        b=kJ/phHWPfMdbwH0yo3aHTKlJQBZslvsniIY4q7aOO9tjUAs74hdSNQpwbVrLq8zIVj
         aovF/FXmmcwuXI6dtISQNyWxUBmqrcgN8NhmDol+/vxszpACo7FssKQnlPeJsQAj5y4p
         6PXudZAP6O8bPThU1WjL2L33KHb6JFQMZguG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404590; x=1709009390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBhO9GN51pgFt/DHFo2a0IcTSs/s3/od7X4R5TK/fL0=;
        b=KHXmRg/8X22zSwbiAqk3Kt4sKgET4RLme1TJD8T2wnBkkP1Ov+WJ9x3tErY5oWz2ir
         yPRk8qGSnQGcIHz3ima38a5GwN7UzWdx1ZLWdxiHwK155VJovEBaiSUT+RPl7r9AVJGz
         aqWRN9bp6AlGL6S7kBlxlz0SlJ5JGuWqurx3yknNpyPe5YFkZxN/x7cqjekf76ToauK5
         fED/v126DGSOdOTGP4QNZvDgHnjJHlLpKuNWiGc8lq/CzJCq3QR+rP8Iveex2+CFqI/e
         hzYfNYWIdcCSrlOQNYMVH7TrbyOXHnaDQWIkrQS8v+CEFtPyMFQAb28ULSa6HNPxqCIU
         o/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcBM+UxBo3McAGEvJuRPaWMvr4Il1b1jOsQ9anTz3ph3hGnHclUA1iP/XCBgIjojJCsS3CgXzNmEGzyRoVqVHer3GLu7z5E5gX7aBR
X-Gm-Message-State: AOJu0Ywfzp0RMjLxfwciRm0PcrllPQjz/9Gi+QTSZIdSmb9zKQCuv9VF
	UsHUc7TxoH2Lstc15N6wlX0LlCTClj/eStXm2aMFkeNRoasw8xSDa/CjVYeLU7/bk6k/OlqtDcZ
	5Uw==
X-Google-Smtp-Source: AGHT+IHcQ5PK8/gjPe5hdjRkEx3ZXM7LO5cJKLvDTCv7gtrkzk1UJXVIhkQGYyF5oWRDyGHjENLw0w==
X-Received: by 2002:a17:906:bc4f:b0:a3e:b3e6:5b71 with SMTP id s15-20020a170906bc4f00b00a3eb3e65b71mr2298065ejv.62.1708404589936;
        Mon, 19 Feb 2024 20:49:49 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a3df7003552sm3565057ejc.32.2024.02.19.20.49.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 20:49:48 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so36812f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:49:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3QxNDnHXCNCekwfg42jC47/kX13NvvxCE0WTZDI725TDEl35aCpSAI2w2drBxmTjUSfrliEu37Qy/oYtMmVnL7X0PPE+3VNBZhO09
X-Received: by 2002:a5d:44cd:0:b0:33d:3893:838a with SMTP id
 z13-20020a5d44cd000000b0033d3893838amr5261433wrr.56.1708404587902; Mon, 19
 Feb 2024 20:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000cb40790611bbcffd@google.com> <98b81fbf-4905-4b45-a8c0-33e7399ef84a@collabora.com>
In-Reply-To: <98b81fbf-4905-4b45-a8c0-33e7399ef84a@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 20 Feb 2024 13:49:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cs-eeHsCZ6VWrzChTJqd4FSqBS4z6ncd8tPQPNMdN68Q@mail.gmail.com>
Message-ID: <CAAFQd5Cs-eeHsCZ6VWrzChTJqd4FSqBS4z6ncd8tPQPNMdN68Q@mail.gmail.com>
Subject: Re: [syzbot] [usb?] [media?] possible deadlock in vb2_video_unregister_device
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: syzbot <syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com>, hdanton@sina.com, 
	hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl, 
	laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:49=E2=80=AFAM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 19/02/2024 =C3=A0 14:10, syzbot a =C3=A9crit :
> > syzbot has bisected this issue to:
> >
> > commit c838530d230bc638d79b78737fc4488ffc28c1ee
> > Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Date:   Thu Nov 9 16:34:59 2023 +0000
> >
> >      media: media videobuf2: Be more flexible on the number of queue st=
ored buffers
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D166dc872=
180000
> > start commit:   b401b621758e Linux 6.8-rc5
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D156dc872=
180000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D116dc872180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Deff9f3183d0=
a20dd
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3b1d4b3d5f7a3=
58bf9a9
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13ffaae81=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ef909c180=
000
> >
> > Reported-by: syzbot+3b1d4b3d5f7a358bf9a9@syzkaller.appspotmail.com
> > Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the n=
umber of queue stored buffers")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> Hans,
> I think the issue occur because of this part of the commit:
> @@ -1264,7 +1264,7 @@ void vb2_video_unregister_device(struct video_devic=
e *vdev)
>           */
>          get_device(&vdev->dev);
>          video_unregister_device(vdev);
> -       if (vdev->queue && vdev->queue->owner) {
> +       if (vdev->queue) {
>                  struct mutex *lock =3D vdev->queue->lock ?
>                          vdev->queue->lock : vdev->lock;
>
> but I wonder if the correction shouldn't be to remove usbtv->vb2q_lock mu=
tex in usbtv_video_free().
>
> Any opinion ?

That is probably what triggered the failure detected by syzbot, but I
don't think we've ever had a guarantee that owner is NULL in that
code.

Looking at the uvc driver [1], it doesn't seem to need any special
locking there (after all the vb2 code acquires them).  (It also
doesn't have the custom clean-up code that the usbtv driver has in
usbtv_stop(), but that's another story). So maybe all we need to fix
it is removing the mutex_lock/unlock() calls?

[1] https://elixir.bootlin.com/linux/v6.8-rc4/source/drivers/media/usb/uvc/=
uvc_driver.c#L1906

Best,
Tomasz

