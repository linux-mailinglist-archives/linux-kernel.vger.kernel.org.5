Return-Path: <linux-kernel+bounces-106356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D187ECF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BB51C21100
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11CF53377;
	Mon, 18 Mar 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPMBfRAf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2144F5FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778038; cv=none; b=cnL+RLo+udHN4rGUZe+PV70EWl3pbGVXsiXAR71kENTSz6fHx+iK0PsjwbuRB5oeX1F4A5+1BVTnbv8uinwZHqOjxUZWsZuMoiZbkX60/SYsbrOEjhU8FO6I0ADgkpbxLD9zMrmRo4vfZ9avKQ0PVH/4kNGYCjLdSUbUk0u4sAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778038; c=relaxed/simple;
	bh=5PXmXrICF6GrxaIO5e63Q2oLbzQ0JOSVAmmok0aNVlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Th5IzgsDPg8K+spkawmQX8IRqJ3pYl492nuAmlLv5+vZxR7cr8kGpDP3YMmdtxK5Dtn2tuWjYIgsWSWXDmoNFkyEjbP9ZE9ll/jSZGUtEDO/sJLCOVX7lGxIRyd1b8clK+H1zW9fTV7a8Gf9uIzIR7TzmVQnc+/OElZ2gxn2yFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPMBfRAf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so7390818276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710778035; x=1711382835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRMBKkFLpx5UEPxApBmIvNsw7kmzwH3SFmSAn82Rk90=;
        b=OPMBfRAfTDzTP/74uNhVXmO+gTEpKu7gbzJ5Sb5V+BQlqjvDmHP75aMYXGYpfxUqRg
         7Vo0pnr73pB1E3PJ4b/KwoUeZlkGFYoimtt/WgavjE4oxTi3IuK2ttCq5F2Z2tz2Px8Y
         EGwMfHmlv9JFlPX4xFLXQzk8IX3RjsP/ZNgs19mRCyItI50rxvv2cIri3oN9dIkSjQZm
         dQjTtnVfPEGz4B0RnmJGP4UzOqPsIIhzidHZN/8m+LJbATYyelLuB9XeLlpd248TOFo7
         t3m5bF96seueMF+2AF1+abFHD2UJoJny23BDwfE6GxWPknAyfR0nkyYsHSxQSd3JVlxc
         0GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778035; x=1711382835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRMBKkFLpx5UEPxApBmIvNsw7kmzwH3SFmSAn82Rk90=;
        b=IljSt1dDqYo8YoJ3k3qFQC9rrLWDpao/QRQus60jxiwBLalUqo/u9GuV1rMCVUbiby
         V6d2dtC49aji9psaVkoyU5K6ZjWtzSKml5d7EPWGFOvSNadlxaePABhYSEFkJXvtiW3c
         IStagWPCSEoAqHQAJiKXfRL9GJqTxqmpIkVAs0Ixs+Ijr7/wsEndSHQV5lbyD5IvLUUS
         Zn5yitpgwn+ZBSuK+cONug8esWDLoO6Xm+0bLwMz1W8bFe8NamHUZA7h/rLzcIqhEDn4
         aXWlpticVQU7yc/YsRS/V1nS/Si3chpgrCmhLBZhGnVStGfmB8A7HaMxcsX8Vd1Xkrbx
         D6ag==
X-Forwarded-Encrypted: i=1; AJvYcCXPE3sRSrI3r77AjPBsuo698Q5EEjbGxc8CJjqnAWcwlBg858v5GhIfQkS0YZmB5u1YMUJrvzFhh8xzvQoiPV7/85eoWJSA6W4pkQvk
X-Gm-Message-State: AOJu0Ywcc8672UvkTNIyLbzMcQH00gICkpvgFWMg4uZ6ed+gE+BYIP/7
	vpPi55IstRTPdfA8hSLBEZXbUZKCWmbQ/y+xWC48HSTkEnrk5SbQR6m/t2hQmGtCqQ==
X-Google-Smtp-Source: AGHT+IH5LNfmfR88tF1ClH5Z2TED8izBfSAYp4ik0sspQZmPUIP4mgDyRQxQVlVvUfOwjAEa/ngdslk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1004:b0:dc7:5aad:8965 with SMTP id
 w4-20020a056902100400b00dc75aad8965mr3240384ybt.0.1710778034738; Mon, 18 Mar
 2024 09:07:14 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:07:13 -0700
In-Reply-To: <20240316162241.628855-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240316162241.628855-1-josef@netflix.com>
Message-ID: <ZfhmsVTIe-khu9uP@google.com>
Subject: Re: [PATCH V2 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
From: Stanislav Fomichev <sdf@google.com>
To: Jose Fernandez <josef@netflix.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="utf-8"

On 03/16, Jose Fernandez wrote:
> This patch enhances the BPF helpers by adding a kfunc to retrieve the
> cgroup v2 of a task, addressing a previous limitation where only
> bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> particularly useful for scenarios where obtaining the cgroup ID of a
> task other than the "current" one is necessary, which the existing
> bpf_get_current_cgroup_id helper cannot accommodate. A specific use
> case at Netflix involved the sched_switch tracepoint, where we had to
> get the cgroup IDs of both the prev and next tasks.
> 
> The bpf_task_get_cgroup kfunc acquires and returns a reference to a
> task's default cgroup, ensuring thread-safe access by correctly
> implementing RCU read locking and unlocking. It leverages the existing
> cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.
> 
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

Acked-by: Stanislav Fomichev <sdf@google.com>

