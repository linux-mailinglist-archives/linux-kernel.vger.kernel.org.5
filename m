Return-Path: <linux-kernel+bounces-68924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71588581FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325F6B25BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0012F58A;
	Fri, 16 Feb 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjzdIlQt"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1D12FF6C;
	Fri, 16 Feb 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098866; cv=none; b=hKAhKVu2iXpo4Rxx9UzZbv0C57y7+H3lINPLZ9H5R4AV4uXMF+b4BWp5trMLb10WMJkhb1nfUduf+TaBK2Ca+HbrAAGMJ6/vLFBqlhG+c22vu7CkQ3lar8jlHcQE2bZgB6PsW818ZW7SdMMG8/3pw2Oeg8FXm/NmHlurBXVCj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098866; c=relaxed/simple;
	bh=Tjqbu1II+07DpMdKvtq6sw+ENXJIB5UD1OOkHOIVFUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VocKB7WnwdV05iahmiT4DU8YLz+bmpXxNDD5DBS2fjlBaD/HkWTUkYQEbDmS8b0+zHCUsKmmScbZ91e7cxmMDrQETdSHeWROj7GlZbRnVY2vqtQAbspiDLKAB5u5rV9CEJ0gJjIdci/LpJVfcOlmfn8kXp+4wFGS1AHrbtoxcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjzdIlQt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so26530101fa.3;
        Fri, 16 Feb 2024 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708098862; x=1708703662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QieQktmjK48aqD6qsFc/4IxxBa+SIty3IcvbMdQjY20=;
        b=MjzdIlQtl9Hznz7Pt1UtCkg8LJODIc7X+1dji8FjH0GF2w5trJHGiLp8ko4uLb4Uo8
         k1q1I3VIhgCHwrVtNw9n6JxAZOE/d9AwYGuyxrJ99B9bcZHSyfs+ibD2TP5cjX73yWCW
         uczHMBNg7gXKRYTOxaVAnRqJ7WhmfVr6R0cYRYY0aXIgtbjCGXWVK//egwMowKJn5REy
         l1lMpJ/cEys793KrFucQT+qJOMuoJ8sKdzZC2VlUsldO+6SvAQhk4YrwNxeS6oQp2TyU
         vAOPFahgvVzAMru6ScXwIg2EQk8awh8QW4oQvV8PBoiMBK9WQqZ79fhbzWdJ+TMCC12j
         me+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708098862; x=1708703662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QieQktmjK48aqD6qsFc/4IxxBa+SIty3IcvbMdQjY20=;
        b=YyiyOTHXkTX/Zw+MRh+kE6qR1c0UbENiHiHnAKNXRPrPbpcvz6Z91KiAWtQzYxnrBl
         1Bquu53PuW197gwW+hrS8IsVVtSOqV9OP/A3leFcTOx40eVPu9hp/mwUeyX5T5f7RDqa
         x5IEGgQP0v4Z/FuYKo29zWTdgBtXMuQxUex2/F47y56NRGWCT9IaFf36YF+NSTWXHzvU
         M0/Qwb+YWvBkjyQ4eS/N1zV3kCXDAU+AHjiRCwU/ISqXoqD8OgEWb5HppshweQGN/1Qh
         RusR4rT8Fee9whuhhgUE3eeiyEc91F5noGWxr/v5JhbaYPMpab20uY2FEEfoMZqezFLa
         GWPA==
X-Forwarded-Encrypted: i=1; AJvYcCVzQXDCAbbkIu28Nt6Uw6aZEXNVFnplT7+SHqDIIv2IVz4bC2vwk73YvPGjg+b5nEb3YfQaPb6A1yodOj3Ybq7JMivKfSRRdex07u4zHqyNtpBK9o6v5sdcNs0AdlbKVIdWqHcEO2HoLVfZFjZ+
X-Gm-Message-State: AOJu0Yz6q59JkjX0qr6HiMrQMBQT78ppVVBgN5YUb9z/umyRxmBy/pBx
	phtfTcu6uTUULdQ6qpdALAw+eR7uNKh5VRJDbX6Nd/FAMMU91YLrVjEEPRgGTuRsHMWKDJfMCoP
	HFH/ErtK618YuGdcOWjIf3nwGJzk=
X-Google-Smtp-Source: AGHT+IGWJZT68TbDcVic8RQrugq/ayZu+n01cf4f7WcHo5EJqxmZ+x8j+V+eIUt52VEDfUbVWIE8ofKhOCrLv7yfLUA=
X-Received: by 2002:a05:651c:b20:b0:2d0:f87f:d7f8 with SMTP id
 b32-20020a05651c0b2000b002d0f87fd7f8mr4635538ljr.3.1708098861903; Fri, 16 Feb
 2024 07:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
 <CABBYNZ+MJRSAWHjgNTNwcWCdq5y0zBU5f8XJvr1tv3LCqvdKJw@mail.gmail.com> <CADg1FFfgNHF9q+dSn=K9qjVMKx1zaBpG=NoeM_3Gr942Zj7_bA@mail.gmail.com>
In-Reply-To: <CADg1FFfgNHF9q+dSn=K9qjVMKx1zaBpG=NoeM_3Gr942Zj7_bA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Feb 2024 10:54:08 -0500
Message-ID: <CABBYNZJXxYJKR3zxSwO8xuWTTgkSJjdGgZbJYqgJzmpPfwUcWA@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if
 hci_request is pending
To: Hsin-chen Chuang <chharry@google.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, Ying Hsu <yinghsu@google.com>, 
	Joe Antonetti <joeantonetti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Thu, Feb 15, 2024 at 11:21=E2=80=AFPM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> +Some Googlers who would be interested in
>
> Hi Luiz,
>
> How about moving the hci_req-related data out from sent_cmd? This allows =
sending HCI commands while hci_req data would not be overwritten.

I have something like the following in the works:

https://gist.github.com/Vudentz/251275bb688fac32585f90ac0076c407

It is not stable yet, but I think we can get away with it since it
just means we can keep the pending request stored in the req_skb, that
said we might need to overhaul this design since it is not very clean
in my opinion.

> On Fri, Feb 16, 2024 at 5:37=E2=80=AFAM Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
>>
>> Hi Hsin-chen,
>>
>> On Tue, Feb 13, 2024 at 12:24=E2=80=AFPM Hsin-chen Chuang <chharry@chrom=
ium.org> wrote:
>> >
>> > hci_cmd_work overwrites the hdev->sent_cmd which contains the required
>> > info for a hci_request to work. In the real world, it's observed that
>> > a request from hci_le_ext_create_conn_sync could be interrupted by
>> > the authentication (hci_conn_auth) caused by rfcomm_sock_connect. When
>> > it happends, hci_le_ext_create_conn_sync hangs until timeout; If the
>> > LE connection is triggered by MGMT, it freezes the whole MGMT interfac=
e.
>> >
>> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
>> > ---
>> >
>> >  net/bluetooth/hci_core.c | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index 34c8dca2069f..e3706889976d 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct *wo=
rk)
>> >         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
>> >                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q=
));
>> >
>> > -       /* Send queued commands */
>> > -       if (atomic_read(&hdev->cmd_cnt)) {
>> > +       /* Send queued commands. Don't send the command when there is =
a pending
>> > +        * hci_request because the request callbacks would be overwrit=
ten.
>> > +        */
>> > +       if (atomic_read(&hdev->cmd_cnt) &&
>> > +           !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
>> >                 skb =3D skb_dequeue(&hdev->cmd_q);
>> >                 if (!skb)
>> >                         return;
>> > --
>> > 2.43.0.687.g38aa6559b0-goog
>>
>>
>> This seems to be causing some mgmt-tester failures:
>>
>> Pair Device - Sec Mode 3 Success 1                   Timed out   22.753 =
seconds
>> Pair Device - Sec Mode 3 Reject 1                    Timed out   22.533 =
seconds
>> Pair Device - Sec Mode 3 Reject 2                    Timed out   22.526 =
seconds
>>
>> I think this is because we need to respond to an event with a command li=
ke:
>>
>> < HCI Command: Create Conn.. (0x01|0x0005) plen 13  #241 [hci0] 16:25:38=
699066
>>         Address: 00:AA:01:01:00:00 (Intel Corporation)
>>         Packet type: 0x0018
>>           DM1 may be used
>>           DH1 may be used
>>         Page scan repetition mode: R2 (0x02)
>>         Page scan mode: Mandatory (0x00)
>>         Clock offset: 0x0000
>>         Role switch: Allow peripheral (0x01)
>> > HCI Event: Command Status (0x0f) plen 4           #242 [hci0] 16:25:38=
701881
>>       Create Connection (0x01|0x0005) ncmd 1
>>         Status: Success (0x00)
>> > HCI Event: Link Key Request (0x17) plen 6         #243 [hci0] 16:25:38=
702375
>>         Address: 00:AA:01:01:00:00 (Intel Corporation)
>>
>> But because Create Connection is pending we cannot respond to Link Key
>> Request, so it is actually a design problem if we cannot send commands
>> because something is pending so perhaps we need to redesign how we
>> store cmd_sent so we can have multiple outstanding commands rather
>> than just one.
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> Best Regards,
> Hsin-chen



--=20
Luiz Augusto von Dentz

