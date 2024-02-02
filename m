Return-Path: <linux-kernel+bounces-50094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614184742A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180711F2312D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717214A0AA;
	Fri,  2 Feb 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfMwjSao"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2E14A096;
	Fri,  2 Feb 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889922; cv=none; b=fgQ7LgeJAVYKVX+/udC7eChjh7HkJPiZm0qye+UFvJNlMQLIMHoEvQgurq8K83rpCv75qVUrhgaf23MV1Tsf1c4GWhcBl4tFIQalb+IkC4QjHdx5NKloGDu3u9xH5de6s6RpsEOyKcem5VRH08LUve+yjlRmPTlG3eTNDH4/lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889922; c=relaxed/simple;
	bh=jX74YmxcgCmEmELepiQIjYfkj4EhbJwtDcV1u+qSGXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyvyWA8Bg6utS/h9jhduD8bAD6watlIc69b1IkAV+ZA2JORy6QRRS43/P7ljT7D/p+niUmOUlpixKm6fAOnDpR+rpgdJ7lyVpD3XyK4ZtBVSPC2QGbD71fL88YIfAvwAEtXdyGN7mmpLr0W55sxeVA66Jc8Y5gD05bCrP0tjzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfMwjSao; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1770522a12.1;
        Fri, 02 Feb 2024 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706889919; x=1707494719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLlRPXBIEL3X1bT9VeDZff9MrnDp+zQ7VNRcupI/Wt4=;
        b=kfMwjSaoXYublwapY5si4blLRG6ens1ESSv5kMLR1VOGZC/53/U9tcS2Mh7OITYxYn
         4OC9pJ8YdNLzUkJAkecN1uHBDg1IOiFr/gdmlqxqTz3fML9GxkIrTLdHFzBbr+UKOkuy
         SdcYmic67OPpmcb8iCvug0Whp5Trx+Fbju2OJi6D0OkmIzk3IUj9kbwBpAKmPAb/fE5B
         HNrOBDZKebZvquZGhdcOLk9vrl62CGLFISLqqG8QAwYiXxuGtZUeJYQ32J4SYy48bQRL
         CNIpW9UIyPkIzWMCKsr099614FthHYJWy/oSYuNHb2X2/I9AA+HoUR17BrMdFSVtTHCT
         bQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889919; x=1707494719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLlRPXBIEL3X1bT9VeDZff9MrnDp+zQ7VNRcupI/Wt4=;
        b=ownZHHSIArlcqIQTdQIhaTj6Nesb4WYyBoPLSef2uXsz8+5gyjstJ214szKW4Hp7b1
         muxxJasTEF3dRg5n+jbcADjdQU2VAMO5qeWwbWm9I4QUsYCMhPh/vZhze4xXCvRUxER9
         SgCp71/+lVFxIMp8UsAwM2Cz+NwA/JaRqlSFBx3mWMz1hJRCu/2Y4Y9vrv0B93payGGD
         sTlraM2rhJurLs/SKRKqpY1mQOHotsW1fNHUSHGcbSMS3TGAIv9XCbGW7E6h08ICxqoO
         vv2ovPXMz9p3mBUALJQc6ePNWpylK03gAA3/S/9rotgL0ovH0r5V8pRN3ZG2la6eYOvT
         7a2w==
X-Gm-Message-State: AOJu0YxmQ0MH1nP+9oJNny+w426B4Z/YSpcXOjwknER3C4jfw3KD31UM
	Qwp1ZOwefczS7Ffhzx0XIzIxnVcRWNFtyty3Oh5lYnlqdFcWqUtmZuuRXf7DfZtu300YckNEshQ
	02SmXTRpVehNGOFJAoQq+2MEJPFU=
X-Google-Smtp-Source: AGHT+IF2slK9fXYPzwfDD2e5yHoShmAfdPNFPYP1AwFwnfIvZq1ro3WVBw4BwoJUCQXQSeCzb/p18f/Aik+8HMPoGHg=
X-Received: by 2002:aa7:c88d:0:b0:55f:f301:35d4 with SMTP id
 p13-20020aa7c88d000000b0055ff30135d4mr34904eds.12.1706889918650; Fri, 02 Feb
 2024 08:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-6-thepacketgeek@gmail.com> <20240202115151.GL530335@kernel.org>
In-Reply-To: <20240202115151.GL530335@kernel.org>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Fri, 2 Feb 2024 08:05:07 -0800
Message-ID: <CADvopvb1phuPW+M3L2BQ576vJgWx2zeFN943OxcVq+iTL8_3qA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: netconsole: add a userdata
 config_group member to netconsole_target
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, leitao@debian.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:52=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Fri, Jan 26, 2024 at 03:13:40PM -0800, Matthew Wood wrote:
> > Create configfs machinery for netconsole userdata appending, which depe=
nds
> > on CONFIG_NETCONSOLE_DYNAMIC (for configfs interface). Add a userdata
> > config_group to netconsole_target for managing userdata entries as a tr=
ee
> > under the netconsole configfs subsystem. Directory names created under =
the
> > userdata directory become userdatum keys; the userdatum value is the
> > content of the value file.
> >
> > Include the minimum-viable-changes for userdata configfs config_group.
> > init_target_config_group() ties in the complete configfs machinery to
> > avoid unused func/variable errors during build. Initializing the
> > netconsole_target->group is moved to init_target_config_group, which
> > will also init and add the userdata config_group.
> >
> > Each userdatum entry has a limit of 256 bytes (54 for
> > the key/directory, 200 for the value, and 2 for '=3D' and '\n'
> > characters), which is enforced by the configfs functions for updating
> > the userdata config_group.
> >
> > When a new netconsole_target is created, initialize the userdata
> > config_group and add it as a default group for netconsole_target
> > config_group, allowing the userdata configfs sub-tree to be presented
> > in the netconsole configfs tree under the userdata directory.
> >
> > Co-developed-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
>
> Hi Matthew,
>
> some minor feedback from my side, as it looks like there will be another
> revision of this patchset anyway.
>
> > ---
> >  drivers/net/netconsole.c | 143 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 139 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
>
> ...
>
> > @@ -596,6 +606,123 @@ static ssize_t remote_mac_store(struct config_ite=
m *item, const char *buf,
> >       return -EINVAL;
> >  }
> >
> > +struct userdatum {
> > +     struct config_item item;
> > +     char value[MAX_USERDATA_VALUE_LENGTH];
> > +};
> > +
> > +static inline struct userdatum *to_userdatum(struct config_item *item)
> > +{
> > +     return container_of(item, struct userdatum, item);
> > +}
>
> Please don't use the inline keyword in C files,
> unless there is a demonstrable reason to do so.
> Rather, please let the compiler inline code as is sees fit.
>
> ...
>
> > @@ -640,6 +767,14 @@ static const struct config_item_type netconsole_ta=
rget_type =3D {
> >       .ct_owner               =3D THIS_MODULE,
> >  };
> >
> > +static void init_target_config_group(struct netconsole_target *nt, con=
st char *name)
>
> nit: Networking still prefers code to be 80 columns wide or less.
>
> ...

Hi Simon,

I appreciate the review, thank you for the feedback. I've addressed
the comments here and in the other patches too. I'll be posting a v3
soon with the changes.

