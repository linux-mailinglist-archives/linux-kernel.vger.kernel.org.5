Return-Path: <linux-kernel+bounces-68980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A978582F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268741F233AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF571130AF7;
	Fri, 16 Feb 2024 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gnlvQjHQ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819A12FF9D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102051; cv=none; b=K2/6yPQsANVeFKpp8NdYnvGi3Donhzl/vH80TyW0V7JETYe+Cu56k3qkLh6Oz1ktKggg+e6FGovqELH4o7cos5VHl8ph7DzIzxMW3FToa7S81NT1rMlUs4AiKXk4NIoF+r+IvdpMX2umK0c90f8vY7LBPOjdQaF+7H8Pz01h8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102051; c=relaxed/simple;
	bh=HDmaMe11IDoKEb6TLxFcSdYHu1ll312hWuanOVtOSc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ts1lEDJw+SV04aS1SBqI4zLmVHqyd2SZIDf9JFCH7anT+Lp5dGzyJfYRUyDXtUKrerzVWPpuLb3kvb0aSGxSirqvWP8n49ExKEQDlWsRgrLs7tqiLs2zfGYG5cAecBRXpA8YVjJf6go4GwTDlQSycQvjnZrt3Urbc2PYacUWVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnlvQjHQ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42db1baff53so297381cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102049; x=1708706849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXkFceeXEfNVDWEJpo0yVBOYLfaZe08nALnvmUBTlbw=;
        b=gnlvQjHQHd52rYPa8WOvarhYaXcfV9MDrie2s4zhxmJq3MfTP6vQkm2lHZxck61fPm
         WCY3FesurvzSK950BrjywB4PYiUf1pJsmOFa670U3yKkkIPhd8QNObtVQicPBwfNtn5B
         aoWQXSE8VI8WAz8YQqr+2JaZZytsfZiph1n8LUsfEyhF+wFh9CaViToKcz393xOsl9Qs
         KP1CYqpEurVxT3/izTfaq6zAUI1vjWuHrauX920WyxkYsHfD3jbjpI2JDomBzq5hkx0r
         fF/cxM43a/LId8OJmwap9aP83GZAFyLOslz8CklVf5zJb1ixF10gmjJ4sLHZIvBBa+Ch
         mIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102049; x=1708706849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXkFceeXEfNVDWEJpo0yVBOYLfaZe08nALnvmUBTlbw=;
        b=N2+py53LpmiMBJM//06q7Xa0P/JhnkG39dSmXVPmpdLXo1lci8gIepRsuwGopoM/DL
         wfNTlFJ+vVqRWu9+NvXNtc1V1aCDwbNOJjsjXFkLcmzsk62S73eSVbOPOyRH3JG20xT8
         Yrt/JtPHJhA0mayCRUqjg10a9v43whtCz1PneTsHnBo2c6/lp2vnEn7gIqwjLDxm8jaP
         tNqktf7c2YH1KQFmJNWIieXFoOreV7lji4/1I6fcsYfSyTDbPcEU4ZbRKQnzN8lWr2PY
         p//4xL4Uhvr47F7mtpHUHYtMjC5s/pLlZZ8vUCzhyTSSjKCD1B/e+2b6O3yk8sKg7PGY
         6PVg==
X-Forwarded-Encrypted: i=1; AJvYcCV8FieVfa+MpG7S/nKgTiAwUDyx5a3868A78O9kQhK0yK/xbVELMJw+82r+wqi6Zl3CMO6Nt53q8hMLWZYVxq4KA4DPgya+tfjBXflh
X-Gm-Message-State: AOJu0YyFTidOQSipeMHXcZLmwwbUWsgYlBSl7YhfzhR9qtGF4MINWhiB
	tKc8T4uhnHlZAuGx06+Rb0QS4mylvJBCb+BbbfJwJF2yiusYJhemINpfZAW2OfbE9KGKYB4Sw3x
	1/fkHUfpdsU4k24B7qERGLOXWNRFi1nFDDTcW
X-Google-Smtp-Source: AGHT+IEVpZ5HM9rbk02BkNTIep9N7nAfUAfy8yxcNkKX84dnrdPT03xkqCecOi/KKpBtxCG8YX67VLl1EuYrKkcA64Q=
X-Received: by 2002:a05:622a:770b:b0:42d:c91d:9317 with SMTP id
 ki11-20020a05622a770b00b0042dc91d9317mr291479qtb.14.1708102049017; Fri, 16
 Feb 2024 08:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
 <CABBYNZ+MJRSAWHjgNTNwcWCdq5y0zBU5f8XJvr1tv3LCqvdKJw@mail.gmail.com>
 <CADg1FFfgNHF9q+dSn=K9qjVMKx1zaBpG=NoeM_3Gr942Zj7_bA@mail.gmail.com> <CABBYNZJXxYJKR3zxSwO8xuWTTgkSJjdGgZbJYqgJzmpPfwUcWA@mail.gmail.com>
In-Reply-To: <CABBYNZJXxYJKR3zxSwO8xuWTTgkSJjdGgZbJYqgJzmpPfwUcWA@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Sat, 17 Feb 2024 00:47:17 +0800
Message-ID: <CADg1FFe09dXWr51OFKutAf=ax0TFXa5HN=6J+AX9QHbb1QiO+Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if
 hci_request is pending
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, Ying Hsu <yinghsu@google.com>, 
	Joe Antonetti <joeantonetti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Good point. I found the hdev->req_skb is actually not read at all in the
current code base, so perhaps we could remove the legacy code entirely,
and reuse it for solving the problem we're facing now. This approach
seems cleaner to me. WDYT?

OTOH the below snippet in hci_event_packet (also another similar one in
hci_le_meta_evt) needs redesign as well. It distinguishes LE/Classic
event per hdev->sent_cmd, so the hci_req_cmd_complete for LE command
would never be called after a classic command is sent, vice versa.

/* Only match event if command OGF is not for LE */
if (hdev->sent_cmd &&
    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) !=3D 0x08 &&
    hci_skb_event(hdev->sent_cmd) =3D=3D event) {
        hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
                             status, &req_complete, &req_complete_skb);
        req_evt =3D event;
}


On Fri, Feb 16, 2024 at 11:54=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Thu, Feb 15, 2024 at 11:21=E2=80=AFPM Hsin-chen Chuang <chharry@google=
com> wrote:
> >
> > +Some Googlers who would be interested in
> >
> > Hi Luiz,
> >
> > How about moving the hci_req-related data out from sent_cmd? This allow=
s sending HCI commands while hci_req data would not be overwritten.
>
> I have something like the following in the works:
>
> https://gist.github.com/Vudentz/251275bb688fac32585f90ac0076c407
>
> It is not stable yet, but I think we can get away with it since it
> just means we can keep the pending request stored in the req_skb, that
> said we might need to overhaul this design since it is not very clean
> in my opinion.
>
> > On Fri, Feb 16, 2024 at 5:37=E2=80=AFAM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> >>
> >> Hi Hsin-chen,
> >>
> >> On Tue, Feb 13, 2024 at 12:24=E2=80=AFPM Hsin-chen Chuang <chharry@chr=
omium.org> wrote:
> >> >
> >> > hci_cmd_work overwrites the hdev->sent_cmd which contains the requir=
ed
> >> > info for a hci_request to work. In the real world, it's observed tha=
t
> >> > a request from hci_le_ext_create_conn_sync could be interrupted by
> >> > the authentication (hci_conn_auth) caused by rfcomm_sock_connect. Wh=
en
> >> > it happends, hci_le_ext_create_conn_sync hangs until timeout; If the
> >> > LE connection is triggered by MGMT, it freezes the whole MGMT interf=
ace.
> >> >
> >> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> >> > ---
> >> >
> >> >  net/bluetooth/hci_core.c | 7 +++++--
> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> > index 34c8dca2069f..e3706889976d 100644
> >> > --- a/net/bluetooth/hci_core.c
> >> > +++ b/net/bluetooth/hci_core.c
> >> > @@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct *=
work)
> >> >         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> >> >                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd=
_q));
> >> >
> >> > -       /* Send queued commands */
> >> > -       if (atomic_read(&hdev->cmd_cnt)) {
> >> > +       /* Send queued commands. Don't send the command when there i=
s a pending
> >> > +        * hci_request because the request callbacks would be overwr=
itten.
> >> > +        */
> >> > +       if (atomic_read(&hdev->cmd_cnt) &&
> >> > +           !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
> >> >                 skb =3D skb_dequeue(&hdev->cmd_q);
> >> >                 if (!skb)
> >> >                         return;
> >> > --
> >> > 2.43.0.687.g38aa6559b0-goog
> >>
> >>
> >> This seems to be causing some mgmt-tester failures:
> >>
> >> Pair Device - Sec Mode 3 Success 1                   Timed out   22.75=
3 seconds
> >> Pair Device - Sec Mode 3 Reject 1                    Timed out   22.53=
3 seconds
> >> Pair Device - Sec Mode 3 Reject 2                    Timed out   22.52=
6 seconds
> >>
> >> I think this is because we need to respond to an event with a command =
like:
> >>
> >> < HCI Command: Create Conn.. (0x01|0x0005) plen 13  #241 [hci0] 16:25:=
38.699066
> >>         Address: 00:AA:01:01:00:00 (Intel Corporation)
> >>         Packet type: 0x0018
> >>           DM1 may be used
> >>           DH1 may be used
> >>         Page scan repetition mode: R2 (0x02)
> >>         Page scan mode: Mandatory (0x00)
> >>         Clock offset: 0x0000
> >>         Role switch: Allow peripheral (0x01)
> >> > HCI Event: Command Status (0x0f) plen 4           #242 [hci0] 16:25:=
38.701881
> >>       Create Connection (0x01|0x0005) ncmd 1
> >>         Status: Success (0x00)
> >> > HCI Event: Link Key Request (0x17) plen 6         #243 [hci0] 16:25:=
38.702375
> >>         Address: 00:AA:01:01:00:00 (Intel Corporation)
> >>
> >> But because Create Connection is pending we cannot respond to Link Key
> >> Request, so it is actually a design problem if we cannot send commands
> >> because something is pending so perhaps we need to redesign how we
> >> store cmd_sent so we can have multiple outstanding commands rather
> >> than just one.
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Best Regards,
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz

