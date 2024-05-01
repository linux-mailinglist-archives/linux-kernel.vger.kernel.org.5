Return-Path: <linux-kernel+bounces-164841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A3D8B83D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567821F23A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EA4683;
	Wed,  1 May 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVNfEYFp"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E803646
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714525089; cv=none; b=J8yKw4x+tiGimk/Zy+4fc2NGeXliVmmUwosH9sX4IpEcNWxtB1QlO8IaKYDWo6Hg3znGhGRXtY7M6zn3DlPrBYdkzUjibB8cKrF73pL5oqYFD1zhTi21LpRRTQ03aqkRRKOtvwh40zxkb/Ie0nD730NEma9E4L9ZKfDXKiM09hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714525089; c=relaxed/simple;
	bh=AwQbgzdzpGbtyYMH9wxZBiQxDi6CK3h+nhpG4KGLzzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g38viJPOaSKWm+IS/TMkSXGhiWHFFkdo5CPsl1ui0DftKbmZH9UhTOPCurNfKdi95Gfgiz9R8PxCCMNQ+UgRmX2CZg9DhqByQXCodbJ3OjP566k/SMQHSGzScM9/4gw1rP4pi9OAJt1UtHGX7NQINjfyrG27+PT9QyRJ18DSLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVNfEYFp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58c89bda70so602440466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714525086; x=1715129886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzev2xwn+5CekUtcLFz9kZ+58wNIVS2hbRZ3PNKfybs=;
        b=WVNfEYFpET4LAezEswFQF05ne8WEQph27ZVb9Fb6TDN1oI8vjlJzC7PAvH5pxCGvXn
         NAIqQrz7gj/aaC+q5vB/9OlLMpPyzuZbA/sCk+fcLmstg72ljLzNNum74xzlm+WRS8ao
         Xg8QLYKZ6p28wMlY3xj5bEQ0v9nnSSpbmhlUFD2V7X4By5mUXJtFKhPfsel2ldknS+2Q
         o97cV/pvRIx06NMxy1WX93wO3jMpfCCPrEnCxUIq2KaczyPx/CKa/bVBysHpD9Glfhm3
         AXwNVbFIbl0JHwppBrEYG9HORSBnmWunhagsvFSW3Hlj5QWZYFTUqM73dn/9imlkzLux
         vfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714525086; x=1715129886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzev2xwn+5CekUtcLFz9kZ+58wNIVS2hbRZ3PNKfybs=;
        b=FiSPp7stVeZia7tWgPkjRRq5QgXbGwvNx8vNiz8WI/Lm9OIIi3OYsJ6BVzDtIBc4NT
         y0WOzc7CUpQZ2/Kg9KeCCBlaF6/VANJiRXYLH6mQLNgmB4Gqu1ggaOS8g/nlySKbDJFU
         DleelN7tHe6K7pqf/i22ghn2RJNrW9spc7TTMK7gJxARKL+vZ4yZ4qFHwOt0ErK/oueH
         h12K1ECoXgis26M5IuYyNB6oLlIbhEvBssrf+Qvirg+NRG65nCDpvpOcJ+B31lyJZUT7
         GL6+4C/IKSmzci8/zHt5AfMKCCiB6/WEFEoggEV4BgNSzcj6Mtk4Z5yrZMJdEVeC4z6w
         qdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZqS1RurWmr+NUQrw7ubEYAnE+0/OfqR5r9s1whCzz3Dh2xhIN7mSliunRvQsUpcCoqolJyPf1qWJwhgXE1EX5dNELyv8DpXG4M9i
X-Gm-Message-State: AOJu0YyBn3pIn+d/sGnYFlnihsKPq6uEqPqcP4AM1UT1dkX4wb+XpYVE
	C/WIY9Af6x14ibBtab4sLWuUhFAMgtupH9AxM+aLNVJKTRn53J+OW8mlA81jN5bmt1INEi47yg8
	6rWovSsJd534JxPuehRL7eglx6R8=
X-Google-Smtp-Source: AGHT+IHHCy0c8dpes1GMk5LcfbECV9HNNXjpuNlZG8xwfgVN38aOQvdFlQiTlvl7jbzWeuwUHRhjEz8AmQbCH2E/qos=
X-Received: by 2002:a17:906:4bd0:b0:a58:c6b2:7885 with SMTP id
 x16-20020a1709064bd000b00a58c6b27885mr794543ejv.5.1714525085549; Tue, 30 Apr
 2024 17:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430083934.26980-1-jason-jh.lin@mediatek.com> <2b46b3c0-f4ad-48e1-964b-128d29bafa9c@collabora.com>
In-Reply-To: <2b46b3c0-f4ad-48e1-964b-128d29bafa9c@collabora.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 30 Apr 2024 19:57:54 -0500
Message-ID: <CABb+yY1P5q8wHFOmTTR0sQnnS_gDeJB=f6tQ101bjY44qfHeDw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Fix sleeping function called from
 invalid context
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Jason-ch Chen <jason-ch.chen@mediatek.com>, 
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
	Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:39=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 30/04/24 10:39, Jason-JH.Lin ha scritto:
> > When we run kernel with lockdebug option, we will get the BUG below:
> > [  106.692124] BUG: sleeping function called from invalid context at dr=
ivers/base/power/runtime.c:1164
> > [  106.692190] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid:=
 3616, name: kworker/u17:3
> > [  106.692226] preempt_count: 1, expected: 0
> > [  106.692254] RCU nest depth: 0, expected: 0
> > [  106.692282] INFO: lockdep is turned off.
> > [  106.692306] irq event stamp: 0
> > [  106.692331] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > [  106.692376] hardirqs last disabled at (0): [<ffffffee15d37fa0>] copy=
_process+0xc90/0x2ac0
> > [  106.692429] softirqs last  enabled at (0): [<ffffffee15d37fc4>] copy=
_process+0xcb4/0x2ac0
> > [  106.692473] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [  106.692513] CPU: 1 PID: 3616 Comm: kworker/u17:3 Not tainted 6.1.87-=
lockdep-14133-g26e933aca785 #1 6839942e1cf34914b0a366137843dd2366f52aa9
> > [  106.692556] Hardware name: Google Ciri sku0/unprovisioned board (DT)
> > [  106.692586] Workqueue: imgsys_runner imgsys_runner_func
> > [  106.692638] Call trace:
> > [  106.692662]  dump_backtrace+0x100/0x120
> > [  106.692702]  show_stack+0x20/0x2c
> > [  106.692737]  dump_stack_lvl+0x84/0xb4
> > [  106.692775]  dump_stack+0x18/0x48
> > [  106.692809]  __might_resched+0x354/0x4c0
> > [  106.692847]  __might_sleep+0x98/0xe4
> > [  106.692883]  __pm_runtime_resume+0x70/0x124
> > [  106.692921]  cmdq_mbox_send_data+0xe4/0xb1c
> > [  106.692964]  msg_submit+0x194/0x2dc
> > [  106.693003]  mbox_send_message+0x190/0x330
> > [  106.693043]  imgsys_cmdq_sendtask+0x1618/0x2224
> > [  106.693082]  imgsys_runner_func+0xac/0x11c
> > [  106.693118]  process_one_work+0x638/0xf84
> > [  106.693158]  worker_thread+0x808/0xcd0
> > [  106.693196]  kthread+0x24c/0x324
> > [  106.693231]  ret_from_fork+0x10/0x20
> >
> > We found that there is a spin_lock_irqsave protection in msg_submit()
> > of mailbox.c.
> > So when cmdq driver calls pm_runtime_get_sync() in cmdq_mbox_send_data(=
),
> > it will get this BUG report.
> >
> > Add pm_runtime_irq_safe() to let pm_runtime callbacks is safe in atomic
> > context with interrupts disabled.
> >
>
> I see. The problem with this is that pm_runtime_irq_safe() will raise the=
 refcount
> of the parent device "forever", which isn't the best and partially defeat=
s what we
> are trying to do here (keeping stuff off unless really needed).
>
> At this point I wonder if it'd be just better to really fix this instead =
of working
> around the problem.
>
> I'd say that one of the options would be to perform a change to msg_submi=
t() so
> that it will take into account that a .send_data() callback might be usin=
g RPM
> functions.
>
> Ideas? :-)
>
@send_data:  The API asks the MBOX controller driver, in atomic
 *      context try to transmit a message on the bus. Returns 0 if
 *      data is accepted for transmission, -EBUSY while rejecting
 *      if the remote hasn't yet read the last data sent. Actual
 *      transmission of data is reported by the controller via
 *      mbox_chan_txdone (if it has some TX ACK irq). It must not
 *      sleep.

As long as send_data() does not sleep, ideas are welcome.

Cheers.

