Return-Path: <linux-kernel+bounces-64565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474E854055
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19591F23C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA36312F;
	Tue, 13 Feb 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xwyOMhUS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFB6312D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868187; cv=none; b=Z/SB8ToDqceRQzP2cYt7PrLcyFttW1QAxMo4jnoILw4FvWiKaNTN6TvNrNOqvTIsmOiQWQgkFpGByAP0tM0dT7aTIez5411MuHzVTmAUrzSljB8u/rvlqWun3sYy2MJ7EC9xIeRp+orp8DM0d816FwMhnvOjDMK1hitEInWx71Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868187; c=relaxed/simple;
	bh=0W+rhN0UAZexn1dEtLfCeV9iTTxm3Ye4I94zVL+vFfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oE7sbwI9cLr2qL6mftX3EBRSFXfpvS3ZBL/q0UdJGrHeRcTfOEZLOZPMGovz/9KmmaKJJhqZbnbpcTL0gtz0BJVEwHT2bXe+YPMxAZagpkMOyrydfL8kk8u1deEufL1NuoT39XinLhKb/DWF5LNstxT6gInokVQAr9n3dldndSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xwyOMhUS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso101302837b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707868184; x=1708472984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOs2miH9PU17seTtpB1seNG3pbtPurqQtu7wPIC49WA=;
        b=xwyOMhUS558BZUlUwQg5f94+yOhe1xVs8qlwoG0ur7xGXtEr8f9eLSVKGhBCCCRPbv
         eC5RQl4VWTqIahk8BJ9xA0hfeUZs3E5T1T6cPUFdDpuQK/kJ1cc2buLR0agsCtb42AiS
         nmdu+MYX9HbG+pgdckCi35hZ7vOuvkU0bjXSMDxT83Rqy+87uZ/NHP3QRLn0gqAE9F8n
         SUWwXldsmsNmcEANRDJL4PfZoqQiQSejy4G24u2ZXkbZHanXpY9ja3qvmK1gtaROmKT+
         0r+EDUGCpZFT6FHDW36iyx7UudimSwWCZEcXtBKBs/lgfNjjciiz1gjLclL7Dw3JRu5N
         AGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707868184; x=1708472984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOs2miH9PU17seTtpB1seNG3pbtPurqQtu7wPIC49WA=;
        b=LrpN4hq+WlNAq7sLiy+IRTkd1Dp6/MdQz+L7PGm6oZIZ9VvB18Us3Yhl5vNGMJ5MIN
         xMn4wNoX0YlfSPGwwk+HXhQVdqJWvt4+Px7VJF34R0RWX2OIfGH3dYV7/csZd70LA/EQ
         wdYnFGZlSQbmnraNJgqsUtXdkwAULQzQmnNFC4T+JKSCMM/0VNeNEZDYd8sI5oGNbN8J
         Qlq5HCedzqvDugMrjGRcv5HEF8Q6jaLipevZ1gn/AJknVlz0qdw1ueJwQbWaTS8Eiqpa
         saybOIG5gtmbwIdiO1g03iuGWV9hytkyZP5x4KUPDF8vF+slhdsxRswsv6b81KyTrW/8
         ixUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHBRbdfh0G2tpaBHBWy1XBO56FtrfUO45VrcUbX5D8lpV9ahYrVzwnFOwe57xQV81Lit2CDrLjU+25eMvryD6Si8tzHKQv8PMBHjw4
X-Gm-Message-State: AOJu0Yxz/4eh9tz138R1gIseR4OEU9jbU2fEkfayIXIvGmMeD1j1oJqO
	IJdfl9fyMPajd4KYZidwQ/2g73Uk2kSg8H8EdrvSE4Vb79TLI8NILNgcZ47TFew68A==
X-Google-Smtp-Source: AGHT+IGHf83SU73QMpoWGsBs1qN+kUZdHbYrRWrkECx5WYuAxot83SCCGtb4frwd19PWxw3fxN0QPms=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:dd09:0:b0:607:8d3b:f1e3 with SMTP id
 g9-20020a0ddd09000000b006078d3bf1e3mr203365ywe.2.1707868184549; Tue, 13 Feb
 2024 15:49:44 -0800 (PST)
Date: Tue, 13 Feb 2024 15:49:42 -0800
In-Reply-To: <r4mpzzib2rzcinai6ctcb32jvcbaenrjfddfcr4o6ghfvnqwct@gcmlz3pi253f>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
 <ZcpMCnJMwbgiUMmE@google.com> <r4mpzzib2rzcinai6ctcb32jvcbaenrjfddfcr4o6ghfvnqwct@gcmlz3pi253f>
Message-ID: <ZcwAFtxMb9j46-rC@google.com>
Subject: Re: [PATCH v4 bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 02/13, Oliver Crumrine wrote:
> On Mon, Feb 12, 2024 at 08:49:14AM -0800, Stanislav Fomichev wrote:
> > On 02/09, Oliver Crumrine wrote:
> > > Originally, this patch removed a redundant check in
> > > BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
> > > the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
> > > reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
> > > and add the checks to the other macro that calls that function,
> > > BPF_CGROUP_RUN_PROG_INET_INGRESS.
> > > 
> > > To sum it up, checking that the socket exists and that it is a full
> > > socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
> > > BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
> > > function they call, __cgroup_bpf_run_filter_skb.
> > > 
> > > Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
> > 
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> Quick question: My subject had "net:" in it. Should it have had "bpf:" in
> the subject instead?
> 
> If yes, would this warrant another version of this patch or resending it
> with a different subject?
> 
> It felt right to put net: there as it felt like I was working with 
> networking code that was simply calling bpf code but I'm not exactly
> sure of that anymore.
> 
> This is my first kernel patch that has actually gone anywhere and 
> I'm just looking for some feedback as I couldn't find much good 
> documentation on kernel.org that describes how I should be doing 
> this.

It's fine, the only part that really matters is [PATCH bpf-next]. That
puts it into bpf patchwork so somebody will merge that eventually :-)

WRT documentation, Documentation/bpf/bpf_devel_QA.rst should have all
the info you need.

