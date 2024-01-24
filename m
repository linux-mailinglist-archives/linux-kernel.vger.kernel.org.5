Return-Path: <linux-kernel+bounces-37488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D098383B0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C82287894
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADCF12A173;
	Wed, 24 Jan 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcMuqn/L"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351B129A97;
	Wed, 24 Jan 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119872; cv=none; b=fuD7qylix2anE5zqZI/IG+Bl+XTHXWOVmTJ7TcRPgaZRRsoeHjjxZu6MRV5GJoy/9c8M9WBoF6aFa2F042tDkXHnt2yPzPV3rdauj5h51o1M0FihQtjF0R6cb5ACO/XuaCLLYimFSl7vbqoEdkaXxYCIqp6ZD4d1VmDcG5MD2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119872; c=relaxed/simple;
	bh=5UQE6R6C6AUkzbId7Ykcdx4OK37OHsLAgXu519xwaEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzIPHPGaNJN7D4lvI9vxT/xnoqafaQcZp0otjy4NXuUYQHMFH8rCxvpJJotroZ3E0+7/vj430B0zYurXqhEtHEdoYsPpKOOCAbnwRTXfIwmptegJArLwpO3ZSX5OnhIl2Gjhz4PaTJnvzUMzyq9PTydoGxaJEdt75Nn2tj450Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcMuqn/L; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so63393771fa.0;
        Wed, 24 Jan 2024 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706119868; x=1706724668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8c9nUjIPANslCx2Ew4sSi05//NjSwZV6nm4afuT97Q=;
        b=OcMuqn/L7ScXXZ2XOivXIPe0eQXUnbldVnAgCS6Wpz5Idx9lhA/cA67X8BThI4gUVR
         w7gVL/AGGXR6fU2QP9B5j+p5Q6WE2h9WESCVYaNwERIJNYF5q4TdZhdyv1lZ/Ur8cdOv
         GzNB81XVk9F1RK4wudVCnFe+VNUl3R72O0dVX5Wbd2tKGgor0eK1RVqOOE6JDcLkc5/8
         NN1q5s0nvd0kBu5K1xCPu6mqMf37GUsMauT6uRkhpGz9ilLj3LNsfsXMo2VutbMXlHYc
         X0vPvjEgux816Tn+9BcR7Ibbs5Dj+lx147DEi34o8ZwMrH5RUR3kS+qpxZnQKn+8pKgJ
         8x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706119868; x=1706724668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8c9nUjIPANslCx2Ew4sSi05//NjSwZV6nm4afuT97Q=;
        b=wDTd3d5wVwdfd1NiiR8auDcqfxWbZGkENikYW2sPZGcWrHrBppRqKLLBWYipDeBTLv
         rjH/ZCpKVm3mpi/JT/GlLbMCO+XpEVmJtSi/qC0ys4LE4p6Ta5wIzAREtvXsOSk261DU
         4DVCgG12FjCfadfLaZ81cWUM3WwxERrj+tHq4lPBdYLY+KxIWz/if2Ek3ELc/o+aLAws
         lpDYsH9YQ+LStezKn9n9amTtXOrXomg7qtzkq1jjswVICDUhmt861H6r6P8cuYlf//xb
         qWhMegM3WRjOdofQSSDyeto+ut7l7OBIM/mulEIDgzJCVWBtYUC1vCtdugIjXZzTt+g+
         DjIw==
X-Gm-Message-State: AOJu0YymmDKhsuBLvJeYn5hK6nquCO6iex6Q3LyfU1mAQ1zJsm7vdR7S
	lbpvyUCVhBiUMBDc1ZjBuUZRkXVlboyXLccExHlyyPbLcLcbsZde8aVFyClQ7HKzHeWnSM+cBHu
	NArBtSlMHluwpKvW+s+Zed4E41n8=
X-Google-Smtp-Source: AGHT+IFFXNE3muV10N3ttExhgNCetj5vrx4blsUxYPxIoqW1KTrLMSWHeFr341ly5/HXNCopRHJOt5VliEGljk2s0AQ=
X-Received: by 2002:a05:651c:2d1:b0:2cf:56b:3c04 with SMTP id
 f17-20020a05651c02d100b002cf056b3c04mr531543ljo.170.1706119867851; Wed, 24
 Jan 2024 10:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107180252.73436-1-verdre@v0yd.nl> <CABBYNZ+rDo6ftN1+HdeWm6gij14YF_19WGRP7LM4Vjw-UWOTng@mail.gmail.com>
 <7cee4e74-3a0c-4b7c-9984-696e646160f8@v0yd.nl> <e6f4e681-63ca-4d85-b050-e215f86a63bf@v0yd.nl>
In-Reply-To: <e6f4e681-63ca-4d85-b050-e215f86a63bf@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jan 2024 13:10:54 -0500
Message-ID: <CABBYNZJp=RhwJoB9u7QT61M085a-+Eh-HN+X07GPmNoRJQHUfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Disconnect devices before rfkilling adapter
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Wed, Jan 24, 2024 at 1:00=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl>=
 wrote:
>
> Hi Luiz,
>
> On 1/8/24 11:25 PM, Jonas Dre=C3=9Fler wrote:
> > Hi Luiz,
> >
> > On 1/8/24 19:05, Luiz Augusto von Dentz wrote:
> >> Hi Jonas,
> >>
> >> On Sun, Jan 7, 2024 at 1:03=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd=
nl> wrote:
> >>>
> >>> Apparently the firmware is supposed to power off the bluetooth card
> >>> properly, including disconnecting devices, when we use rfkill to bloc=
k
> >>> bluetooth. This doesn't work on a lot of laptops though, leading to w=
eird
> >>> issues after turning off bluetooth, like the connection timing out on=
 the
> >>> peripherals which were connected, and bluetooth not connecting proper=
ly
> >>> when the adapter is turned on again after rfkilling.
> >>>
> >>> This series uses the rfkill hook in the bluetooth subsystem
> >>> to execute a few more shutdown commands and make sure that all
> >>> devices get disconnected before we close the HCI connection to the ad=
apter.
> >>>
> >>> ---
> >>>
> >>> v1: https://lore.kernel.org/linux-bluetooth/20240102133311.6712-1-ver=
dre@v0yd.nl/
> >>> v2: https://lore.kernel.org/linux-bluetooth/20240102181946.57288-1-ve=
rdre@v0yd.nl/
> >>> v3:
> >>>   - Update commit message titles to reflect what's actually happening
> >>>     (disconnecting devices, not sending a power-off command).
> >>>   - Doing the shutdown sequence synchronously instead of async now.
> >>>   - Move HCI_RFKILLED flag back again to be set before shutdown.
> >>>   - Added a "fallback" hci_dev_do_close() to the error path because
> >>>     hci_set_powered_sync() might bail-out early on error.
> >>>
> >>> Jonas Dre=C3=9Fler (4):
> >>>    Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
> >>>    Bluetooth: mgmt: Remove leftover queuing of power_off work
> >>>    Bluetooth: Add new state HCI_POWERING_DOWN
> >>>    Bluetooth: Disconnect connected devices before rfkilling adapter
> >>>
> >>>   include/net/bluetooth/hci.h |  2 +-
> >>>   net/bluetooth/hci_core.c    | 35 +++++++++++++++++++++++++++++++++-=
-
> >>>   net/bluetooth/hci_sync.c    | 16 +++++++++++-----
> >>>   net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
> >>>   4 files changed, 59 insertions(+), 24 deletions(-)
> >>>
> >>> --
> >>> 2.43.0
> >>
> >> I will probably be applying this sortly, but let's try to add tests to
> >> mgmt-tester just to make sure we don't introduce regressions later,
> >> btw it seems there are a few suspend test that do connect, for
> >> example:
> >>
> >> Suspend - Success 5 (Pairing - Legacy) - waiting 1 seconds
> >> random: crng init done
> >>    New connection with handle 0x002a
> >>    Test condition complete, 1 left
> >> Suspend - Success 5 (Pairing - Legacy) - waiting done
> >>    Set the system into Suspend via force_suspend
> >>    New Controller Suspend event received
> >>    Test condition complete, 0 left
> >>
> >
> > Thanks for that hint, I've been starting to write a test and managed to
> > write to the rfkill file and it's blocking the device just fine, except
> > I've run into what might be a bug in the virtual HCI driver:
> >
> > So the power down sequence is initiated on the rfkill as expected and
> > hci_set_powered_sync(false) is called. That then calls
> > hci_write_scan_enable_sync(), and this HCI command never gets a respons=
e
> > from the virtual HCI driver. Strangely, BT_HCI_CMD_WRITE_SCAN_ENABLE is
> > implemented in btdev.c and the callback does get executed (I checked), =
it
> > just doesn't send the command completed event:
> >
> > < HCI Command: Write Scan Enable (0x03|0x001a) plen 1                  =
                                                                           =
                                          #1588 [hci1] 12.294234
> >          Scan enable: No Scans (0x00)
> >
> > no response after...
> >
>
> So I think I found the problem here too:
>
> The problem with this one is that calling hci_set_powered_sync() from
> within the context of the write to the rfkill device blocks the write()
> until the HCI commands have returned. Because the mgmt-tester process is
> stuck in write(), it can't reply to the HCI commands using the emulator
> (which runs in the same thread), and after two seconds the HCI command
> times out and the test ends.
>
> I haven't really been able to confirm this other than that we're indeed
> blocked in write(), does this sound like a sane explanation to you?
>
> Seems like for this to work we'd either have to stop blocking userspace
> until the rfkill has finished/failed (don't think that's a good idea), or
> write to the rfkill device from an separate thread in mgmt-tester? The
> latter should be fairly easy, so I'll give that a shot.

Userspace code is normally not thread safe since we usually have been
using the concept of mainloop to avoid entering into the threading
support which might require locking, etc. That said we could perhaps
either not block at vhci driver, with use of hci_cmd_sync_queue, etc,
or use async IO mechanism in userspace so we avoid blocking btdev
handling.

> Cheers,
> Jonas



--=20
Luiz Augusto von Dentz

