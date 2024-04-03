Return-Path: <linux-kernel+bounces-129362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD22289699F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7B6B2C46B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207AE5FEE5;
	Wed,  3 Apr 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru2YtW5Y"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43F6D1A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134040; cv=none; b=e0W8jtyBbGoi57lyIUVD7JKerMDzco3ZOP+26Cz0barwiSfKachJwZwJyid6NgEHOwxnHTAIHIZvqJkgJcjGwV/5M805TAkBDJs+qHkAE/WEUuLJ/3vCT87xUBk0HCu7Cgqk9U1MukLmKX+ngBu7Jl5XLhkdcfziZE+fD09cKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134040; c=relaxed/simple;
	bh=eBvhLbLX4/TnMQo1CV7W0+IZO/aYxwwpmwxEleXEWBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDSnfHVb/QiJPEzvS52aKmKwVBBqicZEYjprn2oV3+ZBzUGetLQD3Snmfuj6Wa5PXdwG5ask3eji5K9j2scLRrmp8zBRoqoabN1bzq7AuASmm74r0Q66Ix8YWxmO+B7IXx4rOQl8WtUGBHkVuOzQovrT+vx/u1ebUIA2iWTUdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ru2YtW5Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e277154d4cso85665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712134038; x=1712738838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBvhLbLX4/TnMQo1CV7W0+IZO/aYxwwpmwxEleXEWBU=;
        b=ru2YtW5YD9WcakjznNpLTICb6e2//OB/Hau3Z3khOMDnnMpr5dm3pqhkRBCmy345St
         gBVfoGMMZo6X1s6oa2miyhJS0a8B6Dp6Ps88+8UrL+lwto9oSyHQpjUBQZ+9vIaVPZ4E
         9n/waf4Su1Wh1kQNIdJtFQFQisURa+P33107noW2RpwjfweCRnJ0gsdVzxTn/neUnvWv
         9hMhQ8hXvpM1ClnhR9Ne0CGyibpr1npIceQHj4UOBVLOhQAVyVbuhHWVTMRTYWVrAjdo
         kzVWuUv3KkXWlJGnGez8YPGXfbdBLz1G9P9sDhxswYWdQDIBKDK3JWGqXxzAMtl1Rk5I
         7MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134038; x=1712738838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBvhLbLX4/TnMQo1CV7W0+IZO/aYxwwpmwxEleXEWBU=;
        b=hkq3ysMS8wonCT4cZtP38HqahUplbzeJNiaQlr6B/ysbI/oGqbFfblh0yhn3w9TT6G
         MmPwNOIFZ3CpUQDt8TTBggp4tzqPEQ4ZXMlruLY/E+yoE4lBXxWtE+50pl+rhnF8M8qf
         qCC5zlz7/x+Cm6RUed9EXtb5UFTHr/P/tbT4ld3SgN2GyKUAQcetHOGEuQjujsbxveN4
         E6/6MBfaONiqE7EJ0cDUHC0S+zwOq8uO0X239Ya4ZirJ6OFN8wK+Qt2ao4+2hRhV+Ykk
         da7N3Nl9PxR9Nxzs/pwJg6Lp7f2JWSUlYAm0obD9IIYORbgrZFm+2Y46rvGuX5WLiPqF
         xEFg==
X-Forwarded-Encrypted: i=1; AJvYcCXoHAO0R4nh1kdidt6jGLfwFLLiz7BaPNxs52vej5YtF6UIgXMN5tiiDzhzuydoLanwJ6nlb5QLNrru/Q797kb5oPJS48rEVjGSkH27
X-Gm-Message-State: AOJu0Yx/9eMHgclG39ZJ3AizH2l8KaadRv1+oWAZLgR1WxlX0ZwkkAHm
	kYnKuP2jFqYcZJzuX4hKgr9AoWMBOxhq8Ay7e96iWMrot73TPRBNHFI1bFevSnSxs0/puKgGbFD
	JJ79ilE9o2F850jSX9UNQt9Ntui+K+4k953Nk
X-Google-Smtp-Source: AGHT+IEiBb5D9qd3I2D88fJuBpuM9WiVMChpsPcpGqlzadOkT0g0yJH2m0q80UOP9f8weaXlNTBAw/blwMTr5rhDh+E=
X-Received: by 2002:a17:902:ea04:b0:1e0:a0d1:ade8 with SMTP id
 s4-20020a170902ea0400b001e0a0d1ade8mr141144plg.7.1712134037992; Wed, 03 Apr
 2024 01:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f9ce6d061494e694@google.com> <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
 <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com> <02d29315-13ee-45c1-984e-13c98e88247b@linux.dev>
In-Reply-To: <02d29315-13ee-45c1-984e-13c98e88247b@linux.dev>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 3 Apr 2024 10:47:03 +0200
Message-ID: <CANp29Y7WXm58E=Dv5WFivKuSz-OSCjMQLhBVdPA=ZpNmwcMitg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexander Potapenko <glider@google.com>, 
	syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:59=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 4/1/24 11:36 PM, Aleksandr Nogikh wrote:
> > Hi,
> >
> > On Mon, Apr 1, 2024 at 8:55=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >> On 3/26/24 12:00 PM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>> BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lp=
m_trie.c:448
> >> Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot m=
y vm
> >> any more. Anything special I need to do in order to boot a KMSAN kerne=
l?
> >>
> > Does the kernel print any specific errors to the serial console while
> > booting? Or nothing at all?
>
> In my case, nothing at all.
>

If you're using qemu, please try adding "-machine pc-q35-7.1" to its
arguments. Otherwise it's known to have problems with very large
kernel images.

--=20
Aleksandr

