Return-Path: <linux-kernel+bounces-125477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CA58926BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F021F22E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220313D53E;
	Fri, 29 Mar 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IEoMp3dl"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1E28DC1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751275; cv=none; b=eYydQukQ39Mpg6zhgf2a9AOHzVu1Vc31LRk8r4SfuCqQzt4Qt05BPs8hA5N6qS8SvzZDvB4gzlpjEGmPHpM7PlpaOjTIAXLO4nF72GEwEWKR3tlVWWOmnybWkZCreSe+3hEsmy7HFStK4e9uIkyqp/n6tfYQaWRr/62mUdHmfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751275; c=relaxed/simple;
	bh=OItPe4IxJL0pCs1NqBvO0JG+rzxeP0lBb2Zs+NNTtBM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=gAT02SQ31oQAitaAEND2nCHqouGdAOaMOAGE3FLVbzj6J9sNNJdShR0/in3d6i2gvpAOneCsVQElS5Xo+BfdjDuCSuViyoOZlwv9esXMC4/gMtq9DQc2ryhFsqFVEIBeBaFqqq0eV2dwGFVzqBYlGOQrusIlG/msfbGOpEBsZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IEoMp3dl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso3954618e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711751272; x=1712356072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OItPe4IxJL0pCs1NqBvO0JG+rzxeP0lBb2Zs+NNTtBM=;
        b=IEoMp3dlIWtpBiY2R9r6Kivqjltt3CHCUbiRTzTAZPfpkfE5AJLRgykkK7kyPPwgvW
         1jJpa1/VUWJ4gFg/zQPQXj2IoV4U2mZ/jglOfijIu691GmWPLDvromMNYRjJwrwIUHLU
         KY0umPL3tQhomdW99GxRiayRU2kdXJQ4+rh5/FsMIpze/UOEhK1Bf/7dpDHrbx/FKuWJ
         UQIqSRcE4xJXF/11HckRQ3axggF+24rFyeTqlCrRnS2X6zVkDnlatBPr5EVvbatkxWI8
         YVY3fumZuTcDrBIBvUiQPBPGSo9g1H3mI3R6tuzoaSZC7vRFnguCSINo3T34ylHMNKv0
         OI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711751272; x=1712356072;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OItPe4IxJL0pCs1NqBvO0JG+rzxeP0lBb2Zs+NNTtBM=;
        b=VSV/v/f3ZDegsq0UqUaCf+800Ges7FToGUMHGdkyppoWrp95LFZG7jZemEKULWd3s8
         zlEvu/3REJ+ZxlyAh4XnwOYUu6RQeFlPtmzLUBFUCB9imr580dPJjXWk84GhPPtGlJPJ
         YvYFztAhbgCCnWpISPMcze2VrTgl3Hxt89YHW8rWsIrW7xPFXxjp2qDl1/B53Ecu60VQ
         LhqvljXeyZFDlScEQC3uFWITq0CSmyR980MPGb+iIq8Eq3L2nXc/xl28XE46MI9xZKqU
         j+VCjtUbJu1WjeMiqlgAoGIIqJxF7HOSz7/4MBIvvpfH52Qq2Ss0kNoCuSfC79I+DMbz
         sCzw==
X-Forwarded-Encrypted: i=1; AJvYcCUvTI9vlCvRrXyQvau3vqUIXf3yaw1spF2Q56BjgBHccmQ/6TExJvwyyKHKzhLi9tM8EZeZIH+g6fiG3CJsoWCzLj5sWhg5/5y1/ONh
X-Gm-Message-State: AOJu0YwR2+7QySMxh+z++nKk21Pyo8UEKidXtophjsgiq+SjyExoGegt
	l75THOj0MGG+q83CeWl0GoM1WsmUskyv1qqNUCWWMv4fa2Sv5G7gnrdlL7E4Rog=
X-Google-Smtp-Source: AGHT+IHMmXVGYK4oukisP78/fV5DWJ//WlRa6i3lXOGdqxqsLxiY7kMWE+d0zU8MiSuQc0nB3HJWxA==
X-Received: by 2002:ac2:4d92:0:b0:515:d176:dfd1 with SMTP id g18-20020ac24d92000000b00515d176dfd1mr2034213lfe.56.1711751271625;
        Fri, 29 Mar 2024 15:27:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906240b00b00a46be5169f1sm2396680eja.181.2024.03.29.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 15:27:50 -0700 (PDT)
References: <00000000000090fe770614a1ab17@google.com>
 <0000000000007a208d0614a9a9e0@google.com> <87le63bfuf.fsf@cloudflare.com>
 <CAADnVQK7rpbNbo4XQRfX2G6v7Mx=2rZNu6D9my9KCi+jRpTUJw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, John
 Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in
 ahci_single_level_irq_intr
Date: Fri, 29 Mar 2024 23:27:06 +0100
In-reply-to: <CAADnVQK7rpbNbo4XQRfX2G6v7Mx=2rZNu6D9my9KCi+jRpTUJw@mail.gmail.com>
Message-ID: <87cyrcbrmi.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 02:43 PM -07, Alexei Starovoitov wrote:
> On Wed, Mar 27, 2024 at 1:05=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git mas=
ter
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>
> Great. Please submit it officially. Hopefully bpf CI also will be happy.

Will do.

Just had to verify if we need a similar check for map_update_elem.

