Return-Path: <linux-kernel+bounces-37338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB183AE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C8E1F2602C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621407E56B;
	Wed, 24 Jan 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9cKEKO4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4BC2CF;
	Wed, 24 Jan 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114065; cv=none; b=iMQiRfSufPzYjh6P/NOt/owNDIyERWfx3Wr0i2RaalHtqczabK0aSuKZpraaX7uwcVMPt9o+ZJsGj2H/qZwSGI+SapOlELEtAYhHFWsiY/k3ZcI451CtpLG7/KtMEw054EpXXsdDYsXNTJ4PTffG1lNnloIV96hHHh7tDGqhACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114065; c=relaxed/simple;
	bh=sgx8ilAQVVkFLAHgMf8ODEiKF3+c8msoYovUPGHWeMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRWsHHK8Wj8Pb8Vk36RGCJ/vg3EFXPqx3i4MfPXJlUMQffcrak9Lc/Z1NdzxjRD6wu2Ma4RWtfAI937ju7LPsSx2dljQ8IKQBBjFkCYVjWo5Nf2CjSQo7D8y1qJuAH6pT0dT2NG6YOQ5RrFerJEPDlfDrUqEoYt/pr1FIjzV1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9cKEKO4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf1c487235so14588881fa.2;
        Wed, 24 Jan 2024 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706114061; x=1706718861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lew07ZUXyfNt21POuOD7kT3aXq++nsV2uwlVuAt3D6M=;
        b=M9cKEKO4p2+XChYjbN7D7DwoxTR/G3AYZZ4lLxTC88e8naFlZSbxoVIbmtwfm1cDA3
         3fR4a6GW0u3+6/IIXFuziu5jsRgC2UrqWTqjZE8/QQoMPxI91SBuwEjTYmFmVBGQqTCY
         gcyw74cDFYERvhc/mwTAx0kM2/X24YQR7kaQEN1nljukMyGZOw4At7FDAGkp0IDTJ6B+
         +laz69PAKW6zptcA+FfSjkBdvr3skawavLzJGHaCTHT5NjO8zD9aBxdzM/56yaUAhdON
         kXYkzF/EBE2/xk09Sw6CEVHg7hCpdJ3jbKE9TfNB6xHN3XlgSVBdVc57MsxIVI7oMa3r
         TJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114061; x=1706718861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lew07ZUXyfNt21POuOD7kT3aXq++nsV2uwlVuAt3D6M=;
        b=nP8uhvWr+H9FENqqHB9w/4m0IPqH55xCIpltFhl1nKEnZ+VuZEh63bGni6ZhTVRk4B
         Aemv++yGhDp0TuG19lNRlUXVXWParMrl9bMc6Jgqm2sbep8XOfPG92LNR9qt7hL8hl+1
         JryE/D8AehK3DCIgNYYwZoqS9BNm5CDQA+L27lT74ijC08EdAivUcPYJjFzh2pTz8Kab
         jrhtLorXLxjeudDQKOCXtg1kTeoar8gYEMqIhgjrkPt0fn8IzR4JEA4K/tvAC5erU7lS
         tKciSvO6A1ICihugqvbuZWTTAy8rJG1iQoQ9rdlDCuk9TFFYZqiv0qrTBA914LNOnSed
         Q4yw==
X-Gm-Message-State: AOJu0Yx6mV6hKQaL6ovtiZEcrvAt1zm5HJxjIdYvEw0YKXahPd2aUCkf
	v5yFjVgK/UC/MAgMkg5/dhorndRC8ECbBxxseJihdg8qIxtkb4Q6DIUOs1q6gY0NlnEuQ6/e3HD
	H0i5jQMFokBd03qtTYnxHHNl4rb8=
X-Google-Smtp-Source: AGHT+IGn6jVE2k/fqv92X7RIFVTwAsQXldpoiqzV1k7sGdZO1gY/ID7PJW7T07t5wnp8dlxfaEm2/itBtmQobgn7zMY=
X-Received: by 2002:a05:651c:42:b0:2cd:86db:c98c with SMTP id
 d2-20020a05651c004200b002cd86dbc98cmr875909ljd.99.1706114061254; Wed, 24 Jan
 2024 08:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108224614.56900-1-verdre@v0yd.nl> <CABBYNZKV176teECGnGKTCNNo45ZYbCRs=YddETOUMUsJQX5PdA@mail.gmail.com>
 <efcc7b97-6bfc-4e5d-8e73-78f2b190fa02@v0yd.nl> <6e618827-c9c1-4ef8-9c98-27ef10b6d6a2@v0yd.nl>
In-Reply-To: <6e618827-c9c1-4ef8-9c98-27ef10b6d6a2@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Jan 2024 11:34:08 -0500
Message-ID: <CABBYNZKMzsjcBPLKPf9y7P1u-DzGcbXaLyTqFtmigsYBZ3OtAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Bluetooth: Improve retrying of connection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Wed, Jan 24, 2024 at 11:17=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl=
> wrote:
>
> Hi Luiz,
>
> On 1/9/24 10:57 PM, Jonas Dre=C3=9Fler wrote:
> > Hi Luiz,
> >
> > On 1/9/24 18:53, Luiz Augusto von Dentz wrote:
> >> Hi Jonas,
> >>
> >> On Mon, Jan 8, 2024 at 5:46=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd=
nl> wrote:
> >>>
> >>> Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
> >>> requests"), the kernel supports trying to connect again in case the
> >>> bluetooth card is busy and fails to connect.
> >>>
> >>> The logic that should handle this became a bit spotty over time, and =
also
> >>> cards these days appear to fail with more errors than just "Command
> >>> Disallowed".
> >>>
> >>> This series refactores the handling of concurrent connection requests
> >>> by serializing all "Create Connection" commands for ACL connections
> >>> similar to how we do it for LE connections.
> >>>
> >>> ---
> >>>
> >>> v1: https://lore.kernel.org/linux-bluetooth/20240102185933.64179-1-ve=
rdre@v0yd.nl/
> >>> v2: https://lore.kernel.org/linux-bluetooth/20240108183938.468426-1-v=
erdre@v0yd.nl/
> >>> v3:
> >>>    - Move the new sync function to hci_sync.c as requested by review
> >>>    - Abort connection on failure using hci_abort_conn_sync() instead =
of
> >>>      hci_abort_conn()
> >>>    - Make the last commit message a bit more precise regarding the me=
aning
> >>>      of BT_CONNECT2 state
> >>>
> >>> Jonas Dre=C3=9Fler (4):
> >>>    Bluetooth: Remove superfluous call to hci_conn_check_pending()
> >>>    Bluetooth: hci_event: Use HCI error defines instead of magic value=
s
> >>>    Bluetooth: hci_conn: Only do ACL connections sequentially
> >>>    Bluetooth: Remove pending ACL connection attempts
> >>>
> >>>   include/net/bluetooth/hci.h      |  3 ++
> >>>   include/net/bluetooth/hci_core.h |  1 -
> >>>   include/net/bluetooth/hci_sync.h |  3 ++
> >>>   net/bluetooth/hci_conn.c         | 83 +++--------------------------=
---
> >>>   net/bluetooth/hci_event.c        | 29 +++--------
> >>>   net/bluetooth/hci_sync.c         | 72 +++++++++++++++++++++++++++
> >>>   6 files changed, 93 insertions(+), 98 deletions(-)
> >>>
> >>> --
> >>> 2.43.0
> >>
> >> After rebasing and fixing a little bit here and there, see v4, looks
> >> like this changes is affecting the following mgmt-tester -s "Pair
> >> Device - Power off 1":
> >>
> >> Pair Device - Power off 1 - init
> >>    Read Version callback
> >>      Status: Success (0x00)
> >>      Version 1.22
> >>    Read Commands callback
> >>      Status: Success (0x00)
> >>    Read Index List callback
> >>      Status: Success (0x00)
> >>    Index Added callback
> >>      Index: 0x0000
> >>    Enable management Mesh interface
> >>    Enabling Mesh feature
> >>    Read Info callback
> >>      Status: Success (0x00)
> >>      Address: 00:AA:01:00:00:00
> >>      Version: 0x09
> >>      Manufacturer: 0x05f1
> >>      Supported settings: 0x0001bfff
> >>      Current settings: 0x00000080
> >>      Class: 0x000000
> >>      Name:
> >>      Short name:
> >>    Mesh feature is enabled
> >> Pair Device - Power off 1 - setup
> >>    Setup sending Set Bondable (0x0009)
> >>    Setup sending Set Powered (0x0005)
> >>    Initial settings completed
> >>    Test setup condition added, total 1
> >>    Client set connectable: Success (0x00)
> >>    Test setup condition complete, 0 left
> >> Pair Device - Power off 1 - setup complete
> >> Pair Device - Power off 1 - run
> >>    Sending Pair Device (0x0019)
> >> Bluetooth: hci0: command 0x0405 tx timeout
> >> Bluetooth: hci0: command 0x0408 tx timeout
> >>    Test condition added, total 1
> >> Pair Device - Power off 1 - test timed out
> >>    Pair Device (0x0019): Disconnected (0x0e)
> >> Pair Device - Power off 1 - test not run
> >> Pair Device - Power off 1 - teardown
> >> Pair Device - Power off 1 - teardown
> >>    Index Removed callback
> >>      Index: 0x0000
> >> Pair Device - Power off 1 - teardown complete
> >> Pair Device - Power off 1 - done
> >>
> >
> > Thanks for landing the first two commits!
> >
> > I think this is actually the same issue causing the test failure
> > as in the other issue I had:
> > https://lore.kernel.org/linux-bluetooth/7cee4e74-3a0c-4b7c-9984-696e646=
160f8@v0yd.nl/
> >
> > It seems that the emulator is unable to reply to HCI commands sent
> > from the hci_sync machinery, possibly because that is sending things
> > on a separate thread?
>
> Okay I did some further digging now: Turns out this actually not a proble=
m
> with vhci and the emulator, but (in this test case) it's actually intende=
d
> that there's the command times out, because force_power_off is TRUE for
> this test case, and the HCI device gets shut down right after sending the=
 MGMT
> command.
>
> The test broke because the "Command Complete" MGMT event comes back with =
status
> "Disconnected" instead of "Not Powered": The reason for that is the
> hci_abort_conn_sync() that I added in the case where the "Create Connecti=
on" HCI
> times out. hci_abort_conn_sync() calls hci_conn_failed() with
> HCI_ERROR_LOCAL_HOST_TERM as expected, this in turn calls the hci_connect=
_cfm()
> callback (pairing_complete_cb), and there we we look up HCI_ERROR_LOCAL_H=
OST_TERM
> in mgmt_status_table, ending up with MGMT_STATUS_DISCONNECTED.
>
> When I remove the hci_abort_conn_sync() we get the "Not Powered" failure =
again,
> I'm not exactly sure why that happens (I assume there's some kind of gene=
ric mgmt
> failure return handler that checks hdev_is_powered() and then sets the er=
ror).
>
> So the question now is do we want to adjust the test (and possibly blueto=
othd?)
> to expect "Disconnected" instead of "Not Powered", or should I get rid of=
 the
> hci_abort_conn_sync() again? Fwiw, in hci_le_create_conn_sync() we also c=
lean
> up like this on ETIMEDOUT (maybe the spec is just different there?), so
> consistency wise it seems better to adjust the test to expect "Disconnect=
ed".

Great that you find time to dig into this, and yes I think it is fine
to expect a different error if in the process we clean up using
hci_abort_conn_sync we just need to make sure nothing else is affected
by this change.

> Cheers,
> Jonas
>
> >
> > Cheers,
> > Jonas



--=20
Luiz Augusto von Dentz

