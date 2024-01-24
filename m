Return-Path: <linux-kernel+bounces-36819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582083A754
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39911F23BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEEE1AAD4;
	Wed, 24 Jan 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1L+sDet"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB171AAB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093882; cv=none; b=BYtJqiwjVG2XJ2WlAK/HU829bQjuOYR/GZKwYz+bIvNj8W9zGjLUUR3ZOYGQjxopCMsg2M9y23YUFydIMM35wvp3NyPlk88QpJWoznazQsECA/xIFpEpHI8wZCq2mlWBqfmvM/ugu9dy0iYXZh3s/WlztACBOlSY9WAqseUAOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093882; c=relaxed/simple;
	bh=095eySjr9UdkzN6h8F///pYrDXdNnhrwqoAvJkhHULs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUaSXeBWAbVkayChUj6qHF58mVfTZz1SV13ESCzIOyk2rVRiJkVMjSKuLWsHuDrbCvXkN6chwohTKXg6m+xYsr3pl/RbBjbyzIYe/5q+Hr5XPj8UKpT85bmYUi5Num8UxeZVxJPDvOKh89J7DpxGlu7vABqOUFlPcS+IPAOZmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1L+sDet; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso13555a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706093879; x=1706698679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=095eySjr9UdkzN6h8F///pYrDXdNnhrwqoAvJkhHULs=;
        b=e1L+sDetBI1YtsLpOjLl+VO4HeiNaLjIEvXNzSSEKart/kF+Zh6xzqkOW0x4ipMz/y
         YGzzHomAOoc6Jrusyrzvc69L/20aHhm3Enkn+nii0MngahBGvW1JVMW3WwNDlgKqRqgH
         WX7w60pRllwL7r52s2vyLW1YIZETzlZKU4aOgqfJtddLV5XManymdP/g8Q4mDiwD92WT
         oFjvB3rfkEuumsOpHPxg67f/1dANoY9Qi4DhiAoDyhEAVs9NX5FQ9gbbV2By8iNeo3Dj
         pk3I9B88iCcQ8fPqBaGOPhjYT9stq+vWZZauR06GB3mHu5P9TOnXZix3WQ2BAqiTk3Vq
         ZjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706093879; x=1706698679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=095eySjr9UdkzN6h8F///pYrDXdNnhrwqoAvJkhHULs=;
        b=XOhnw+eR3vZYjwJ/iLcNbJvka2riqC9v72ctUmEJET67BurpOBISBTGcsMVC/GeSbL
         yNP2tlqh5TyvJVC+cFwdyVPGNEHg4i1SJluAylpu1/Qc8yJ1YRE3tlrEnWE2yeugMZ3f
         eVFPI8428nGC7PIJ62NbugZECpwHIwq1DhdKG3TXAWx10gWZIhSIT2bNM6IZSfdaI+Hp
         WbTM5L6SulEe2zO4BioH0l+rSK99agHMTIoIYjRhC7TqvwkLxeN+Emcvgobt8KAk1+BE
         6qEL42zLbxXNX1PrhUPoKnVL56V7XKP+ELWMpYAdvfxbo+ALHzWENYJnqBsHamrL39c2
         LD0w==
X-Gm-Message-State: AOJu0Yxo7p29XUmGtDzrdf6ukVYb3AYIoqAD+AMI69PmntQUi2l3tK+g
	FUGu5C+dJgJvsDNs0hR0OXsTqEV0NypxI7eIXfWpc+s2tkakf0smr7juIGVU/lbk/O7Me92mwCE
	MjUdlwY4rIco/FA9oPnRLBMvYGGNOaW0pu+Md
X-Google-Smtp-Source: AGHT+IEyJLEJeXzrz7WWPOPz319HwrQPvPDFw7AtqAnVFipnMCWC8jtIyoIoTMP7JJeoV+a2BjBgXMK8TZV1bSra9MA=
X-Received: by 2002:a05:6402:1d84:b0:55a:4959:4978 with SMTP id
 dk4-20020a0564021d8400b0055a49594978mr44083edb.7.1706093878885; Wed, 24 Jan
 2024 02:57:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
In-Reply-To: <20240124101404.161655-2-kovalev@altlinux.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 11:57:47 +0100
Message-ID: <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 11:14=E2=80=AFAM <kovalev@altlinux.org> wrote:
>
> From: Vasiliy Kovalev <kovalev@altlinux.org>
>
> After unloading the module, an instance continues to exist that accesses
> outdated memory addresses.
>
> To prevent this, the dump_pdp_en flag has been added, which blocks the
> dump of pdp contexts by a false value. And only after these checks can
> the net_generic() function be called.
>
> These errors were found using the syzkaller program:
>
> Syzkaller hit 'general protection fault in gtp_genl_dump_pdp' bug.
> gtp: GTP module loaded (pdp ctx size 104 bytes)
> gtp: GTP module unloaded
> general protection fault, probably for non-canonical address
> 0xdffffc0000000001:0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 2782 Comm: syz-executor139 Not tainted 5.10.200-std-def-alt1 =
#1

Oh wait, this is a 5.10 kernel ?

Please generate a stack trace using a recent tree, it is possible the
bug has been fixed already.

