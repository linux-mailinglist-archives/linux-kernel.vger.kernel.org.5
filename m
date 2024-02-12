Return-Path: <linux-kernel+bounces-62007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5078519FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B231F23C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9493D3BF;
	Mon, 12 Feb 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNmqJokx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEA3D0D0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756558; cv=none; b=EoeuWLcbc0DkxRjCK3oafKOXjCzvp2Fn5+pzi6bcb54O1S/5+lPIK3lvCZBYoMTQh1NO5UCUOPXcop9eEvgAV3BpHB8eLnnvUipFVIOg8EexNXLsEOSw2n1Ep3Pz/RUyDVj069YyrE0+4Ewt3utV+yOoz/a+pCZqG0fdxrf15so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756558; c=relaxed/simple;
	bh=hXu9sHdM7IJbBPOMIED59R9v4IKiIdSqswjDn3ekmdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uwwb6MZzHwyX453aLnci/rkpTxvBXSxpc//q2b6QdVKsFqY3cZzH5HnfOLquApizMMvtcLq+wxt09QS7+ybjuFjL7kLdQgE2O3xEpKgTWcZnYljRbxmBhDmzoLgzZKmugWMywKWhAVssXJAWmvWK2m9IzKf0n0y3S8SI+Mv+SDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNmqJokx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604acd1d164so63692307b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707756556; x=1708361356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPlRou6Cx1Kdm8J9ZJTFkbCu7oULoCtJIpW6s3E0mRs=;
        b=GNmqJokxsI8aKjS2krCmc0qdSe6NyftOx5gCWtz7HB4VXuoWG+0zGjn41YwKFaRbPf
         fqeek6CXgXEbzNOQFmMgc+/4ezs/lHy3E+GDhk/DmtxIAbsbBScRqJ7aT/W5xu2IKJpo
         9KYnh7ivuK+kYg6tjhpcnST+5HYmzAY3jQpdUwlHI3yo4LFsEN5+PUieQhxgKN9wd7Oq
         SzrWmYdq6e7Qvbq2SAeU/7GhbWyDNOAZV6Lx3TQ9TiVvGmMNlx9IKqqXv68qPKv7ubEF
         wC9c8UrIgJZtfqYNw+zQnCfiGA13nuPgXISVZv79TD6DOTDd8DW74cNN4+tfI75teUMI
         s2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756556; x=1708361356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPlRou6Cx1Kdm8J9ZJTFkbCu7oULoCtJIpW6s3E0mRs=;
        b=nG78IodzyyC9nzUsktxlN8iJH++MpXm4H/bny6QxgekfpxDftfkaX8iN6HgBhjsoLM
         srH26IwNZ9EOISADrBh5sLW8Vg18Q8YmfXEYNagpxTKMihyZIV/lnutkpgCarBVJQKQM
         eRWaOWCximUMqtMLM6IM5v1mXEQlGeGUnKkTwZPE348oi1l5NGvx03HizVfoF9Y96KBt
         XAV6w++CLGK07CS9ltLf+bPSbjRawx/a5cSsczFgVVJaOP63XV5fCPj4p3J5vUpR/+OO
         qDccpr1TaLAF3LAmEqg171WH/oVcmBurjTntgKCA4R4fqOQwESiH9xqqt0nLnNYs7hIJ
         2GNg==
X-Gm-Message-State: AOJu0Yx1d3n6HnkmnMSlwcSdxGvUetmBwqG3dfsSRZMRuD9i6OkWM1Yi
	B/bvxsoZBDCGW6OXrNfWG3K1zW+jO7Sa9Eem0TuRufE0N/6azuM9dp7DOVYdU6g9mg==
X-Google-Smtp-Source: AGHT+IHEfCmAmT/rBYK+wi7o54NKRrx/37fqsl6J959zqBb9V8tYzhdFiVREtU9nIAEW9Q7UkGAkihk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:3388:b0:5fc:6edc:448e with SMTP id
 fl8-20020a05690c338800b005fc6edc448emr2177007ywb.0.1707756556445; Mon, 12 Feb
 2024 08:49:16 -0800 (PST)
Date: Mon, 12 Feb 2024 08:49:14 -0800
In-Reply-To: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
Message-ID: <ZcpMCnJMwbgiUMmE@google.com>
Subject: Re: [PATCH v4 bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 02/09, Oliver Crumrine wrote:
> Originally, this patch removed a redundant check in
> BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
> the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
> reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
> and add the checks to the other macro that calls that function,
> BPF_CGROUP_RUN_PROG_INET_INGRESS.
> 
> To sum it up, checking that the socket exists and that it is a full
> socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
> BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
> function they call, __cgroup_bpf_run_filter_skb.
> 
> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

