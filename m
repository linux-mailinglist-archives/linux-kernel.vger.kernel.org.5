Return-Path: <linux-kernel+bounces-63619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BB85325D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9476DB268CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234F5786A;
	Tue, 13 Feb 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE2A7S2C"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B856764;
	Tue, 13 Feb 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832403; cv=none; b=EP9X2dme9h76LuMXdn9qI3FpXR7Jdd1mg8/ePptfitRwtjIsR51Z3h6c3y6MsRX4fcUQnQ+rpz0d8nBgSY/p5GQbIX6QkrIyB7Zf/XtqG9uakXfclsyNpExhTiBu4bk14BhFwtvGoWLJk6uIj9zOA0X+N0xfLYQ78/4EgElXSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832403; c=relaxed/simple;
	bh=TT+Uo5hokvB40TVEtKJWlyD5Lcbvm2PVEeGdGbedPV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnl+gUtsQzhI/Anw9e5L57wnXznTwmPFgIZvLJ9P4vdANR2GfYCu7RRJ78JNMvlkAMSzZgsR3fT5WyHjZw188K6i4ZK8i5M7Eez8PcGNSReTvfOP8osfdmNtkZeI+wCxbLI9SKrZIFtM1MqdkwEd5zwybGgsG1gKNJtplI9UkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE2A7S2C; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d1025717c7so15890031fa.2;
        Tue, 13 Feb 2024 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707832399; x=1708437199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoCg5rElDx4SNvccw3uK27O6lXXShxjuBSZkeogl0H0=;
        b=UE2A7S2CvAQG7i25V7vKMA1KeDcn6YpyQmY8/6EIAbE6JrhnsIfYg4ZT3k190sS7AN
         FmHAe/SZcvxv4qnJjuxOlCeA5N+5/fP0gD4A6yYgCic3wvHDPyoqgPbBGT45JvW5GGfi
         iM4l/OvvukKS+zVnNWHI81uQuzV4DXFu5ads/LVfJx+r2caPtnBNZeoUMOC2UZyOiYlG
         fW0O6gHXNsCNQUM/1kFu9C7AgTGnSJXSR4TI8mlwt7L7rfNFtPr8KF+4SaTGOI6ZFCEe
         FleyKJye51hvjPX3B4+hbrhJxC54Q5/n7i5ocPoBOjU0e5anPNTdkMC+u090b7Xp1FlM
         ++Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832399; x=1708437199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoCg5rElDx4SNvccw3uK27O6lXXShxjuBSZkeogl0H0=;
        b=bn7GRNrjUZ4Rf4D2mL9sHfQULYG3862MYEpE0zEMUSNRK1UuVd+rJ5fYhha54q6L0x
         T2r5db0bmYhjYzdrg8wVw86xPjbqNtZd/rWQ7GdlOU1b4gNaQdzO+G1C8MZuCHbBTFmi
         ISPFw6/MFtkWFkeTNOIMIeTkR0hBlmCDBz2QO64ISd+pulEmbj9bPliJgQx+GjPeRBSr
         d0xYXyZTyxyOeSzOOTPoHgNrz3j/0fiETa0Ly/gaDkBu4ilwoiyOMx1IX1N5mb8voiC6
         CEjRXTn5zy1UeHlEnnZKG+IiVWvKgtYoHle7cUvRmj1UvFuolci83HLVHaJdJ7D/S0hE
         BSmg==
X-Forwarded-Encrypted: i=1; AJvYcCXFQspJYUdPy8nx9sm0hoKG4QoY6bX+w7i6yTOlebG6/5nxf2NDaD2/K1s6dCNn82Et2iPO91Nchu1j6ABfjSWjDf7mejykijY4Ejq7gu9hyJYEvHsiIjIegpBVM7/EGuKXWFLgJhnTPG6cpjoeINJ2y0K+LhLL4Et+KVKAmRKUOuzfSD62
X-Gm-Message-State: AOJu0YxDU1UYXRMG4Qy4LcIEVPLX/y/Tg9Oeu8qFfZK/y9PW9t8NIgv2
	7Ug9OqZWag7WVaXsL58JcW0zloDpDt8ZYOgbNioPteQLf2MrQ6+iDLaaftHlLRQwc6lZQWPUDyo
	aidn8A4DzHGIi5uxvqS9q/82Je+E=
X-Google-Smtp-Source: AGHT+IEkUoKys1Ghiq72y56fmHbY6NxfFJ/wg6BcyaM28sz53Fd8+OTwEICvkxoRxNu9XlgxuVEkaK1OcSThctp5CtE=
X-Received: by 2002:a05:651c:60d:b0:2d0:cbf7:4943 with SMTP id
 k13-20020a05651c060d00b002d0cbf74943mr5293795lje.14.1707832398916; Tue, 13
 Feb 2024 05:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007cea730610e083e8@google.com> <216c95d9-db1f-487a-bf3d-17a496422485@v0yd.nl>
 <CABBYNZKPaMLK5+HnsRWR9jwpdZWvbbai6p9XbePhMYdKSYUPPg@mail.gmail.com> <bbd64fd9-395b-441e-be04-39440359b035@v0yd.nl>
In-Reply-To: <bbd64fd9-395b-441e-be04-39440359b035@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Feb 2024 08:53:06 -0500
Message-ID: <CABBYNZJ=SgwgNz7K9j0nK-aV-wgMF6_yZ9psF1ydWG7HAhwFYw@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Feb 12, 2024 at 7:29=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl>=
 wrote:
>
> Hi Luiz,
>
> On 09.02.24 14:36, Luiz Augusto von Dentz wrote:
> > Hi Jonas,
> >
> > On Fri, Feb 9, 2024 at 7:37=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.=
nl> wrote:
> >>
> >> Hi everyone!
> >>
> >> On 08.02.24 16:32, syzbot wrote:
> >>> syzbot has bisected this issue to:
> >>>
> >>> commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
> >>> Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> >>> Date:   Tue Feb 6 11:08:13 2024 +0000
> >>>
> >>>       Bluetooth: hci_conn: Only do ACL connections sequentially
> >>>
> >>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D154f85=
50180000
> >>> start commit:   b1d3a0e70c38 Add linux-next specific files for 202402=
08
> >>> git tree:       linux-next
> >>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D174f85=
50180000
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D134f85501=
80000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba19=
5662a06
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0a39be7a2=
035700868
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d9514=
7e80000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D107c2d8fe=
80000
> >>>
> >>> Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
> >>> Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections se=
quentially")
> >>>
> >>> For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section
> >>
> >> Hmm, looking at the backtraces, I think the issue that the introductio=
n of the
> >> sequential connect has introduced another async case: In hci_connect_a=
cl(), when
> >> we call hci_acl_create_connection_sync(), the conn state no longer imm=
ediately
> >> gets set to BT_CONNECT, but remains in BT_OPEN or BT_CLOSED until the =
hci_sync
> >> queue actually executes __hci_acl_create_connection_sync().
> >
> > Need to double check but I think we do set BT_CONNECT in case of LE
> > when it is queued so which shall prevent it to be queued multiple
> > times.
>
> Nope, we set it only from within the hci_sync callback, see
> hci_connect_le_sync(). IMO that makes sense, because in
> hci_abort_conn_sync(), we send a  HCI_OP_CREATE_CONN_CANCEL in case
> of conn->state =3D=3D BT_CONNECT, and this OP we wouldn't want to send
> while the command is still waiting in the queue.

Yep, well I did a change which should work regardless of BT_CONNECT
only being set at the callback:

https://patchwork.kernel.org/project/bluetooth/patch/20240209141612.3554051=
-1-luiz.dentz@gmail.com/

> >
> >> This means that now hci_connect_acl() is happy to do multiple
> >> hci_acl_create_connection_sync calls, and the hci_sync machinery will =
happily
> >> execute them right after each other. Then the newly introduced hci_abo=
rt_conn_sync()
> >> in __hci_acl_create_connection_sync() calls hci_conn_del() and frees t=
he conn
> >> object, so the second time we enter __hci_acl_create_connection_sync()=
,
> >> things blow up.
> >>
> >> It looks to me like in theory the hci_connect_le_sync() logic is prone=
 to a
> >> similar issue, but in practice that's prohibited because in hci_connec=
t_le_sync()
> >> we lookup whether the conn object still exists and bail out if it does=
n't.
> >>
> >> Even for LE though I think we can queue multiple hci_connect_le_sync()=
 calls
> >> and those will happily send HCI_OP_LE_CREATE_CONN no matter what the c=
onnection
> >> state actually is?
> >>
> >> So assuming this analysis is correct, what do we do to fix this? It se=
ems to me
> >> that
> >>
> >> 1) we want a BT_CONNECT_QUEUED state for connections, so that the stat=
e
> >> machine covers this additional stage that we have for ACL and LE conne=
ctions now.
> >
> > BT_CONNECT already indicates that connection procedure is in progress.
>
> I still think an additional state is necessary. Alternatively (and maybe
> a lot nicer than the extra state) would be to add some functions to hci_s=
ync
> to check for and remove queued/ongoing commands, I'm thinking of a new
>
> bool hci_cmd_sync_has(struct hci_dev *hdev, hci_cmd_sync_work_func_t func=
, void *data);
> void hci_cmd_sync_cancel(struct hci_dev *hdev, hci_cmd_sync_work_func_t f=
unc, void *data);
>
> I think if we had those, in addition to not needing the additional state,
> we could also simplify the hci_abort_conn() code quite a bit and possibly
> get rid of the passing of connection handles to hci_connect_le_sync().
>
> I'll give that a try and propose a small patch tomorrow.

Yeah, I did something like in the past for hci_cmd_sync_queue_once, I
will resend it since it had the following function as well:

bool hci_cmd_sync_lookup(struct hci_dev *hdev, hci_cmd_sync_work_func_t fun=
c,
             void *data, hci_cmd_sync_work_destroy_t destroy,
             bool cancel);

> Cheers,
> Jonas
>
> >
> >> 2) the conn object can still disappear while the __hci_acl_create_conn=
ection_sync()
> >> is queued, so we need something like the "if conn doesn't exist anymor=
e, bail out"
> >> check from hci_connect_le_sync() in __hci_acl_create_connection_sync()=
, too.
> >
> > Btw, I'd probably clean up the connect function and create something
> > like hci_connect/hci_connect_sync which takes care of the details
> > internally like it was done to abort.
> >
> >> That said, the current check in hci_connect_le_sync() that's using the=
 connection
> >> handle to lookup the conn does not seem great, aren't these handles re=
-used
> >> after connections are torn down?
> >
> > Well we could perhaps do a lookup by pointer to see if the connection
> > hasn't been removed in the meantime, that said to force a clash on the
> > handles it need to happen in between abort, which frees the handle,
> > and connect, anyway the real culprit here is that we should be able to
> > abort the cmd_sync callback like we do in LE:
> >
> > https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_c=
onn.c#L2943
> >
> > That way we stop the connect callback to run and don't have to worry
> > about handle re-use.
> >
> >> Cheers,
> >> Jonas
> >
> >
> >



--=20
Luiz Augusto von Dentz

