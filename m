Return-Path: <linux-kernel+bounces-127449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644E894B89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA76FB22830
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8A2BCF6;
	Tue,  2 Apr 2024 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ1JLCQ4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BD24A04
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039821; cv=none; b=jRyZyIvuShlEFJ75q7h3H0me4NI/MKHp2EfhUeweQPBP1GF3sVxAsFa4By7cTgur2ReHo+92ockpcqPrlmsB71aPWYvGDwG9WyhwRRa7gbN5V1zLLEjykN7WDeSNghKYRf2hf3XzYyDG61xnzlgpsDZAMWkQrkrshs+C3oPjx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039821; c=relaxed/simple;
	bh=h8a0KAn+MZnFGoNEOgIGih+DjI3NRQeEw1chqipA2bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnA73cmAGeMhsGri0zPd3Tyiv7/I6SfdMO5E1h68Q4co/WxAfvAdCXpQ09757tNnplU29dGuYmLNbRV2GKPbZxT4bBouqiyX4BrJY8/A8PLnZ3wKy+2C9aIAAsEOxbtcJjifvMVTkbNcGxjkBMe3eYQMgMWiYXQwIORitsVtIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQ1JLCQ4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1deddb82b43so522155ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712039819; x=1712644619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8a0KAn+MZnFGoNEOgIGih+DjI3NRQeEw1chqipA2bk=;
        b=fQ1JLCQ4oWQtcYn2cpCEwh47GKZCoC+C05ScG6RFFSwQs6JJkcHwf26WNFwVabJuGh
         qdEQndr2U7kDZMjnE5zb34AE+oN+vHt3rr2ENkXEAT/OVS2YRp91mv5tDW6GjcDiF4TO
         s3n6JAYTG1nn8NyjYvPRgaxgUfy46IH94ghJeKx2TQm7Z8hvWllY+1E24vXkWWFgVqjm
         xFG8xVs1o7qcbTo2qXlQH+PYm9/6JybdMJw5SPeK+tk6DzFV9dkNOBZ9u/T82h4CHiru
         e+XCN0ZyNeKbURxM1W0bHDXJ2AsU2j+nBfHMquxFzP/XLU8oBz/osjI4fZX2afsJHRGc
         luhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712039819; x=1712644619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8a0KAn+MZnFGoNEOgIGih+DjI3NRQeEw1chqipA2bk=;
        b=Hcj2QAB9Ev3MnzcaT25PY+fik5SSbnPhwCFpRhgxySKAs0OVZsk58hp1gXhibrk0+7
         doLmNuBC9drpbuhouuiaCsYDWoTYIvKvuBWtZOXdxVVyA1zVq9lNwZW2B942O3VTuW9H
         TSCNhnXh2A2vI5xomfmfggPaBxAeflP5wbMeVAhzDGibB2b9XHKyT9tvKcpM3Ec7i0dj
         l3hbPIL3vnTLDWiG5ukrqe5tQiKaGufMDFdcSfPYufs77tmSSRoeg+GKQiDv+jYmdV4U
         3uyDKXjyd0UYL4ww5b79SIFNhOTsu3gekYfhefG9dPV9of1+36D8LpWsHBxPmMLDvSB4
         LRHA==
X-Forwarded-Encrypted: i=1; AJvYcCUpMpsTnsibbkgXqncO1WIP5zPSvhnD6adktwUsD6zXj+bp5RE83VaqL02ji9fseU1Zu9j1Fgczgq4HCOCDltBhvhjFRxrnfERivB2+
X-Gm-Message-State: AOJu0Ywks1dJ6lO8DGnwvHshvJm79GHda3X3WaEFm1/dm0t6B4l2pm4z
	/qUs1MYkzgBv3ZMigfVEW4aaOZ7Kg2UjPSCHCxUixkICY12Pzgg/JTfHPO9BDsH4FMD6kF5B0mD
	ZiYvLdZbCQmisiyEkh7x6uOGEuiGue24QOmlo
X-Google-Smtp-Source: AGHT+IH1D3EvNP2RfVkhzg6uErgJllKDJPH5Iq1dkh9LIhzec3cd/ilQ70sNT+BjVKJJdnN8gztjWnT089iJ+9EkoMw=
X-Received: by 2002:a17:903:11c4:b0:1e0:94bb:c4aa with SMTP id
 q4-20020a17090311c400b001e094bbc4aamr728537plh.11.1712039818767; Mon, 01 Apr
 2024 23:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f9ce6d061494e694@google.com> <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
In-Reply-To: <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 2 Apr 2024 08:36:44 +0200
Message-ID: <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
To: Yonghong Song <yonghong.song@linux.dev>, Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 1, 2024 at 8:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 3/26/24 12:00 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_=
trie.c:448
>
> Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot my v=
m
> any more. Anything special I need to do in order to boot a KMSAN kernel?
>

Does the kernel print any specific errors to the serial console while
booting? Or nothing at all?

--=20
Aleksandr

