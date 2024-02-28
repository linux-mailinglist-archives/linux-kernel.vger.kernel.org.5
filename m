Return-Path: <linux-kernel+bounces-85643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB65486B89B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C991C26158
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA285E085;
	Wed, 28 Feb 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMjMPkbd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC15E079;
	Wed, 28 Feb 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149899; cv=none; b=DliOhwP6+6eP1WCKrgjsIHRfsudEKI1tNQ0z4YHaH+nFv0n20C5NISUng95YjOXN6DOtOc9bMtKTaAeQ55XEg23JR1UPUrh3i52TopHX1bkfxZoILiNmPNFbnAovDo4EfBoJsWyhAPD2LRlLjkQeHkp7/fB0G0ougRv8DeI8foA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149899; c=relaxed/simple;
	bh=kArOyMHY5+4vffML5guH3LLRbRSIeEUWV6WhuUq5CBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8luiv4F6hm4We1gQkEX0STYy7Z+IOapXQ03m9uxnWdaQus3ijA02dyJZJ/Yu7QH2mPqjqobJNvPMNgDwZ7Ya34NJLCUFmZ1DWzHrqlOE4xVtshfpqOLt6vpEM3lOpxZGVifMsT3gfWzuggDbpd/e50lMJusJujHnv1amjCi20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMjMPkbd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so305831a12.1;
        Wed, 28 Feb 2024 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709149896; x=1709754696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXcu3bFZcsrAoAiVrWjtsqyBDoVNoBgQRciFYDiNitI=;
        b=cMjMPkbdGZDmLR+nDtzqTULHvY0UDrSlOmqlmfkiRxJJi1zAF6eWOXq2pxFYELrsHL
         OPTWby4CojW9NxBSF5q11oqWnVQW4XQ0UOlHggEMAoJiR80q/95CgATNh8/Cmv87L9WY
         Y6MRO025KLkBEYJEFbqMiJaTTl52c7kksTTPGRfr0szvfk1yUfpJSqhd2FsdZRBnIOjR
         Yr+mnkZUL2/qBgI+2+Vab+Uhvrk6hRsvT7tg/V46oB3vcSQDkIFlZNCjYt+pPKNFbdRB
         OxHIiz/UL1Wq8uonhaIomLp2mT9t6qaGVOGq85FgA3U69LMP/dQePWyBCD6SgvFE4/NG
         Qp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149896; x=1709754696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXcu3bFZcsrAoAiVrWjtsqyBDoVNoBgQRciFYDiNitI=;
        b=u1YwqVjlVpqgWJ0vpfcPaM8N92iIC4xNb/+i8MBSmSCV4VBZwQm5xOrwGifImOnDR9
         YWnM34SWcSlc/1vwxT6CU7/OIMZdfGsv/Hn+4p1IvFYtZpbFFGJshvQInkGLCxTmBHH8
         EpEoafEah6coo8NwWk9IXHtM6FSq3oj45Xpg/XnhcD2X/1945biQEi+cGWnFsln06WI9
         5GDHxw6prFaFr+jd50ksEEoWEIZpl/46fbfylOuwvO6KDxFTqFv7zu1zJoWdYX+jDOGO
         BRhI/mj6wS9cYGozMKJOiRLKj86QP/IOzgFI0yJmfDKBlP1bD0DRomqA0E0gmSNMUtII
         pSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX/0F4Ma3iVGC/abX3zU0GczVbyk6wf8fRCY91MoMHUWU4Lcl527ztUqOPJmOFpqUei5ZavRkZDHumKEfjuJBeNrXX78mO11Zo+i2CU+nc4Se+6Ki7onjq+mNx9MLCpNAfBbebJWiOKCgseXLPwScpuYtXcdHEj31WCZOgbw0V
X-Gm-Message-State: AOJu0YxPjm5HbAsBFzLx6TP5vPZjplxc09ouQX3aFE5Lt4m4Hcp/l53J
	hJhS4TGPdoh+KIweWnIWZPeZvn0OiYzmYJYHyRBUM3Ln1v1+THOhE7PQ3oLYq7QzPkqiPPL/Q7o
	FPODgF9M5vXpaLk3+vxDTho+DsXY=
X-Google-Smtp-Source: AGHT+IHVoY0oGVQWBGe4FFrjlo5iWLfO+2p8dgc6oJtU8Gv/j7UJJgrbF3TuRNKK1nSur+YZaq6r/lJD8LKpK0qMdOY=
X-Received: by 2002:aa7:dd0b:0:b0:566:821:d183 with SMTP id
 i11-20020aa7dd0b000000b005660821d183mr242179edv.42.1709149895985; Wed, 28 Feb
 2024 11:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228172948.221910-1-thepacketgeek@gmail.com> <77497701-3bd2-4f5f-9404-b32d9e91683b@gmail.com>
In-Reply-To: <77497701-3bd2-4f5f-9404-b32d9e91683b@gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Wed, 28 Feb 2024 11:51:24 -0800
Message-ID: <CADvopva5LAe2WQa8N83mhi68++GRvh1Uw8SqatYY79uEOEZTEQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: netconsole: Add continuation line prefix to
 userdata messages
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:32=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 2/28/24 09:29, Matthew Wood wrote:
> > Add a space (' ') prefix to every userdata line to match docs for
> > dev-kmsg. To account for this extra character in each userdata entry,
> > reduce userdata entry names (directory name) from 54 characters to 53.
> >
> > According to the dev-kmsg docs, a space is used for subsequent lines to
> > mark them as continuation lines.
> >
> >> A line starting with ' ', is a continuation line, adding
> >> key/value pairs to the log message, which provide the machine
> >> readable context of the message, for reliable processing in
> >> userspace.
> >
> > Testing for this patch::
> >
> >   cd /sys/kernel/config/netconsole && mkdir cmdline0
> >   cd cmdline0
> >   mkdir userdata/test && echo "hello" > userdata/test/value
> >   mkdir userdata/test2 && echo "hello2" > userdata/test2/value
> >   echo "message" > /dev/kmsg
> >
> > Outputs::
> >
> >   6.8.0-rc5-virtme,12,493,231373579,-;message
> >    test=3Dhello
> >    test2=3Dhello2
> >
> > And I confirmed all testing works as expected from the original patchse=
t
> >
> > Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string =
in netconsole_target")
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > ---
> >   Documentation/networking/netconsole.rst | 6 +++---
> >   drivers/net/netconsole.c                | 4 ++--
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/networking/netconsole.rst b/Documentation/ne=
tworking/netconsole.rst
> > index b28c525e5d1e..c2dec12f6060 100644
> > --- a/Documentation/networking/netconsole.rst
> > +++ b/Documentation/networking/netconsole.rst
> > @@ -197,8 +197,8 @@ Messages will now include this additional user data=
::
> >   Sends::
> >
> >    12,607,22085407756,-;This is a message
> > - foo=3Dbar
> > - qux=3Dbaz
> > +  foo=3Dbar
> > +  qux=3Dbaz
> >
> >   Preview the userdata that will be appended with::
> >
> > @@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
> >
> >    echo "This is a message" > /dev/kmsg
> >    12,607,22085407756,-;This is a message
> > - foo=3Dbar
> > +  foo=3Dbar
> >
> >   Delete `userdata` entries with `rmdir`::
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 0de108a1c0c8..ffd3e19406b5 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -43,7 +43,7 @@ MODULE_DESCRIPTION("Console driver for network interf=
aces");
> >   MODULE_LICENSE("GPL");
> >
> >   #define MAX_PARAM_LENGTH    256
> > -#define MAX_USERDATA_NAME_LENGTH     54
> > +#define MAX_USERDATA_NAME_LENGTH     53 /* 256 - 200 - 3 (for ' =3D\n'=
 chars)*/
>
> Could we take this opportunity to define MAX_USERDATA_NAME_LENGTH based
> upon MAX_PARAM_LENGTH - MAX_USERDATA_VALUE_LENGTH - 3 then?
>
> >   #define MAX_USERDATA_VALUE_LENGTH   200
> >   #define MAX_USERDATA_ENTRY_LENGTH   256
> >   #define MAX_USERDATA_ITEMS          16
> > @@ -671,7 +671,7 @@ static void update_userdata(struct netconsole_targe=
t *nt)
> >                * checked to not exceed MAX items with child_count above
> >                */
> >               complete_idx +=3D scnprintf(&nt->userdata_complete[comple=
te_idx],
> > -                                       MAX_USERDATA_ENTRY_LENGTH, "%s=
=3D%s\n",
> > +                                       MAX_USERDATA_ENTRY_LENGTH, " %s=
=3D%s\n",
> >                                         item->ci_name, udm_item->value)=
;
> >       }
> >       nt->userdata_length =3D strnlen(nt->userdata_complete,
>
> --
> Florian
>

Yes, great suggestion. I'll send an update with this change tomorrow. thank=
 you!

