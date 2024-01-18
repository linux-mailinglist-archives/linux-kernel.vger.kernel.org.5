Return-Path: <linux-kernel+bounces-30152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE4831A93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2022F1C22585
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F725559;
	Thu, 18 Jan 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SH3OaEhn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254B250EF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584518; cv=none; b=fh9A7HXVOeYSH251LYyLIFbd/upGPe+3rNiTxC47yS+Rbs2BUT3/x4LAwSm/iETFnT3bDFkmca6/F4eKxlW/kMwVbWpLX4s35ZDfqt3p2GW1a8/iWebPJU/GMcqKkIhWTzOfpAv80WMxWp0nd7EyO0iuWTdCYMS7n36p5gSj22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584518; c=relaxed/simple;
	bh=PSZfDQy+rxsoZQwcLAXYzVgScCvbozQaEUpVH3JDy/c=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S918rz2N4wXbRUlPePUXmHYSxZZWUtRVp0XoQrJn1t+pXS1IDFaEcPL0KA3ronzFTpd0VDebrHlqlYHMoHfDIrSgg8acc6SmYA86Tinpp5mjjvqqJODg763ZuT7Lf7uDSYuYZH02S3wsT+xBgmZwiEfCNNwyI0Hfg0dLxIeRutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SH3OaEhn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso6862a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705584515; x=1706189315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSZfDQy+rxsoZQwcLAXYzVgScCvbozQaEUpVH3JDy/c=;
        b=SH3OaEhnX6BOf5u0M0xjK94iok2Ss87wJLJko/ZZSWyB/XsJU8ZQYFDWd6eZXMI30D
         jtQ5GurKWIKF1ednFyUu4y8xErdAR1uf0kAmFRZlVW1CJK4sO/1krmqbdWvzh1tLXcTU
         Zj0h6TiEpnp3ON1ORkoIvU5k6zGyXVJgzoV9VtP0H4LRW+S+BU0WJAZ1FkvhtAmGlnWG
         eXcDEfqSokkupHPxhP028jwyYp1vee16XZsTA6YYV5w1s6wTnaNDINW1hayyrOMk52qf
         8u9PYgoViFH8MQODZxHJ4/OtAuALVj7vyZ0ISqDI0D+5T/0mzZwhnMe/dlJp7pkKRzio
         f1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705584515; x=1706189315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSZfDQy+rxsoZQwcLAXYzVgScCvbozQaEUpVH3JDy/c=;
        b=qJh3WNK59OWQKBLo8iSxPqJ35ZvN9vHXbR36qVE81LLsmAnj+P4fiX//1YGwdYK81w
         IrUFQua7H2XQthqb/mKG6MpccbbKGvxlzd0MCNp7p8dh8Im9Syfj/BcYs098emrEwv4Z
         lI/6ZN67C86KpIqrPbwUDfWU1+G+wbMl1BiOjYH2Gf6pBYh8znHZrE5v2KAAEIVrj7vm
         LHMO0uK3WbDr1Tz5Dudpb1wW7PjT1X/q+Bnct17Levp3OPB2f4+yreoHBQZ4Eg8rKJBo
         iW31j0WiBSa1q6OFIj2GgWycQdSp9/AbZZzUQZ8NHcmnFLHbdP8dN8PrGwaLiF/s2abe
         zN9Q==
X-Gm-Message-State: AOJu0YyrSAmSp62y0mrggf1VssI4tjPhYLE2c40F9x4OFlXWJhVyMy2M
	inonW5H7RF3kTXVAxBDt3GGqnhMnr48ZvlJQHHt4merR2mTxfFmN4spqCpNfOjVo2gg4lWECLna
	aTUOL2vxqaj4OYHMQ+BTiNkoefDpfC/U0FDhi
X-Google-Smtp-Source: AGHT+IHqePTvtGNp07JBxb7FAfRP01FQOVDqhd+sI8ncp9unArToQRLQH0XZBGBRgpedxsTiYylm2a4/ftrApPRGB+M=
X-Received: by 2002:a05:6402:b4c:b0:55a:47a0:d8ad with SMTP id
 bx12-20020a0564020b4c00b0055a47a0d8admr1367edb.3.1705584514725; Thu, 18 Jan
 2024 05:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
 <CANn89iLUxP_YGLD1mrCmAr9qSg7wPWDjWPhJHNa_X4QVyNWqBQ@mail.gmail.com> <549c658e-28a0-4e6c-be09-95ba748410b7@fintech.ru>
In-Reply-To: <549c658e-28a0-4e6c-be09-95ba748410b7@fintech.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 14:28:23 +0100
Message-ID: <CANn89iL7W_uMuDWpPSZ9_a4hVQE=qF3ES+R0jCOdWkj=M03CMA@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 2:04=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:

> Just to clarify: should I incorporate your change into v2 version of my
> original one and attach 'Reviewed-by' tags or should I send a different
> patch with your suggestion?
>
> Apologies for the possibly silly question, got a little confused by
> signals from multiple maintainers.
>

No worries, we can wait for net-next being open (next week) for adding
these lockdep annotations.

