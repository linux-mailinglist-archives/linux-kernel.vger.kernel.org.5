Return-Path: <linux-kernel+bounces-60251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED685023F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AB31C23B51
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF30525B;
	Sat, 10 Feb 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FsV23qRh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02093FFE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707533162; cv=none; b=gjNmqGPfnreaUHX+EskQ2mUYpnbAQ9M46AtiA5f5owVXBv18JSSCV8++xHlFhOQ+yKuzdsec6b8Gp18p2tG29uMa1PFp+ioivvaomwSdDxMm1rwR2bG7SteWPqugMCF9Q9qSlHUXGQ+OWXmAg+tEAvG9EFiBIzvQcz+hi1i2Egc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707533162; c=relaxed/simple;
	bh=fvcxdwhch+UgCOqtnEyZPh1ECKl5d5IgD43prRrJsXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piW/hq2WCLepNN22oDWpAdCaZO/6p/0KOl4umxXCErgXyNFVBma/wfkDuMFMQrBVtmaGhbsaJfN1rlP//e7zBDyOSNKruqhdfU/MlpZOtR6IQHjtMITUM19CXvwZZ9vuC8VU+MiHsI4BnXALjk8YtztgWzYR4ttQNY15vHicC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FsV23qRh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8ef977f1eso13721655ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 18:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707533160; x=1708137960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juvAKGT5CeRrHs5S/LFrLMDdPScLSP5NQP+Ax181rF0=;
        b=FsV23qRhe5NqfIAPYtjRTgh5nDJf2nmCSeZ9e6MTvkdNvQL2XXHld8zP+U4UsM8E1L
         qTqO/zRwefc78kJB7t1Vws7Juk9BcfPS+TQuLHGo4CdFEMtYT9EXmFxfwjsmDeOQ99zJ
         YmgHXcRp0CUKO9RAIMFPmdXLx1bP8iCx4IJjVbNdqdorUNFFHQVbtmGzL+gv6eT7VJIn
         gcAaDtws+OhMjCJ6JF3UPfXSupgXKDUX501bGbCjXOKJ41/tc2sLEMCMm3xM/Yyggbtj
         yvp682EFc2LfEC6XolT/H38hICo6OhwkIDLTl77YGH7Sh+Yg3BDoeoKZzefEMf2hCq6E
         WsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707533160; x=1708137960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juvAKGT5CeRrHs5S/LFrLMDdPScLSP5NQP+Ax181rF0=;
        b=XVeKBPC/GMAKySELwSc51oYdW7Rsdg8d574iz57NprC/mYmXV3HcjoKaUle03EK7vA
         sRQTAyvZgn/QC7oijAWpVO/5bZNK8g0l4hrn1xXLxiy7GS7C0FoEmKx0AbdxdqE+4Cl6
         UQI7+WBerVzC9/Yn6f4RRmSsqcjBj7rh5oB/d8DO62BZPM+7799/SDiCRIOz3O4Z/i7H
         zXPLiSr3DLOE/b/5d9mupB5TIq6SSnoaVHeo74IJUWO1awV6+czbCgKufKTv93qepr8Z
         OtK6eznWYA92tBJVnisPW62EgI72hvxGYtwOKO8R56kkjgPZ/5MVnsLTWYRc8/9w3sy2
         gMDg==
X-Forwarded-Encrypted: i=1; AJvYcCUY8nGWeLy/xCrtEtY05R78lr+aRS1ZcLzsgFb0uJveo3+4nVz6PgYdMaHoUfHtyLlUyaoAa6K2EeLYOe9hHAyk4XBPCfR4QaxDq5qp
X-Gm-Message-State: AOJu0Yw0PGhuU1krw3fKpM3+1qydlR3mLGE71jbdoIZCRZ2L7+Uxfj/J
	Yha/kKcvyM2bGAvo268Kv1S1/DD9nkm80QH2IK/U0lVFm99kWnkjhBqL9AMMbmk=
X-Google-Smtp-Source: AGHT+IHEDqbAC4lmL3ZpUXSCN9GdkEM2l7fe8xTltkLkxmu1UR60/e25RS/zMOOX5wfJlxuteXW2tw==
X-Received: by 2002:a17:902:ec8f:b0:1da:e86:3d9e with SMTP id x15-20020a170902ec8f00b001da0e863d9emr1412208plg.43.1707533159777;
        Fri, 09 Feb 2024 18:45:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMhzRkPJU68x71VCI0cCzTS1iGPROvorEHI8y/T4VEsPqoWKRiyLc6jpPnVnKyR0zJXFEBaQnHeIE9zBh6zGXKxKyy+69dAWbHc0cnlF/TixP9rdrhlkWGVbNYTmzwM8fPlu9XTnBpdXUyqMKn3yTL6Rsutw05p5yMUO5nqD1NE31MbFZvloHyWGYSV1eJJVaMWJ2keeytwpKYeVaELobWX4mCrvEtYg//ovV0TKLVKwXW7JhD3Tx4+WaLMube7ba5D8oQGgw83DyJ8YXup0gXBaT92tcI0eNYel3yhLEXra2BvSwFKyGdEJ48enl3MzyOclUYmQr1sL3m8FyrEm8q8rLyPEjIy+uHll/0f0hse679uE3lxbRm3BP676KdKumQKhN3ISg6shx/pXVo63coSaXdfB9bti21OvyKuV/uhofsNXW5tac4rbv/lticgt4p+dalE9KXCG3XGt2a5rTwLptPsnyG+3nsvILh9cGGbTQZYElnQdeGHU/SzhqwIloQYcRKUR0cqO54hwxFz1nBRZx+OVdWweRwpzKCKYsfSHi1DphxVSx4LeLATF3KML1avYiiqwq+Dx1TeVhwXMGLdZa4EXGE+V64Stk=
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ee8100b001d94c709738sm2149523pld.217.2024.02.09.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 18:45:59 -0800 (PST)
Date: Fri, 9 Feb 2024 18:45:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240209184556.00cde1a2@hermes.local>
In-Reply-To: <20240209183133.1cc0a4f5@kernel.org>
References: <20240205185537.216873-1-stephen@networkplumber.org>
	<20240208182731.682985dd@kernel.org>
	<20240209131119.6399c91b@hermes.local>
	<20240209134112.4795eb19@kernel.org>
	<20240209155830.448c2215@hermes.local>
	<20240209183133.1cc0a4f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 18:31:33 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 9 Feb 2024 15:58:30 -0800 Stephen Hemminger wrote:
> > > I mean that NL_REQ_ATTR_CHECK() should be more than enough by itself.
> > > We have full TC specs in YAML now, we can hack up a script to generate
> > > reverse parsing tables for iproute2 even if you don't want to go full
> > > YNL.    
> > 
> > Ok, then will take the err msg across all places using NL_REQ_ATTR_CHECK?  
> 
> Take _out_ ? That'd be great, yup.


I don't think that is actually a good idea because new kernel needs to still
report errors to older userspace iproute2.

This is kind of academic hair splitting, iproute2 doesn't send these kind
of missing part messages. It is more from test suites, or from custom
user programs; found this when looking at DPDK device driver that was
sending its own netlink.

