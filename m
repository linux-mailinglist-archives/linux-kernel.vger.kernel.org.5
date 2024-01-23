Return-Path: <linux-kernel+bounces-34629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A5838565
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60E51C29FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4A4C67;
	Tue, 23 Jan 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdTRTKZi"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F84C60
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976517; cv=none; b=gvKLi9v1PPAmZV/hPRpTJRzcHfdaxRcLy+wP5VSkWnA6GHMyzSKoByhPDp8o9LyTDcWBRcO6iFlOqfxxuopp1BJ31fjlNTxtGmE+GxrTjxmIGiVC2bT7AqUhxfEiyj08Nq2fkEojnROxjyGc9VLJNDMaCHyUumh3JiXJkI3Db30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976517; c=relaxed/simple;
	bh=1k8ROicesrNsqWVQWRUqg7MU8rCvHMOIi47paJFQ+KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDfnV8IuU6cvBGG7bccGwvVeco/LUM4/asyo2db7T+h1fJIYbDQTtOMDlmqAncJyFw4yfL3a/q4peq3KvXiETzQOuSZIqrpnuZ8NgLGCYoVYUKSeqNZ6uc0gxKxHlgg0yl5HF2VCJVPxX5OqZ1c/TIf1a/irF0Q1Ob7LV4bv5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdTRTKZi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a30799d6aa0so126782366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705976514; x=1706581314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ8GDI8FzhEiMu6pZSg0ZuOmMJQKcLLfU4p0987uNpk=;
        b=RdTRTKZiSG0Fvsc9I+Y1/0fPnWqmokCMZbBpbUBIpkcppfMOVpvBuaUsj0vMMaw37S
         SBY73gbKB1VYRyKLHTh34OPsHHhVlRZjzpFs6tsVDulXP+0J3me2K3VJGByMG8jDx96x
         PxC+G4+HreQWB7p/VcAG/J6yRDiTXrwTjvD6yS1YH9Ac6LIZM/UMWuKBJJBhsF5KuOa5
         7PPGB8di+GlaqYpIlL29RRQrCTRiJ+6tRhPGLTXG2IFr8ct9RzXfYTfcmC9wsV/+ohv/
         FiHWx+0k8/MI4vZrVK1ZGzkHtudOTwUdJ6fPtZSHVY58fCIVOds6GhNSfCtXrn3GIM/u
         FDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705976514; x=1706581314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ8GDI8FzhEiMu6pZSg0ZuOmMJQKcLLfU4p0987uNpk=;
        b=Ba+wvH1VBn5c13ZJb67pPBxutDUOnBrQi4EkWgKPWI25ejoVq5m1KNcdxwtV7GjdnK
         EnvQk+nIIX5MfpHWxYauPDGbVvqGGsS45EP2yJoifjR+IChgUgFhtkX2sFpKS2BGqN+c
         80nByWwVG6wosgo2/Fzxnmo4OFzX42jl5HpLAYVfYxvr3gm0w5NAZoqAQAiXAuZE3HV/
         Qf2g7YdsvW9MvCz3QvC+lq9nuzJJGmjOtNyKkaIWhCp5w2Fo5IYadn0tfG1NaOZo42m1
         P+uWkrj0rWDaGMdWBiPsbUhybsd0ZRNbkBzB3l3SLMnYGhxuljqlPbzK0oe8YYG6QU1x
         oH7w==
X-Gm-Message-State: AOJu0YzD5/LwbgU4XCJc8sV/FpwdLzSUV+c1SpScjJvfMb59W9SR7+uY
	HvSp89kkk+EP+LQFpbvqneY7G+eSRRp/V9B1q2iKhJ72Ga61LSI0xwFYQTDtU6xk/LeJAxPsLpv
	H0jjUI6Tq+Wp8FT6Ys8XaEHmgoxE=
X-Google-Smtp-Source: AGHT+IFDCkj/zDpLb0MKY6dR1bSTBGpxcp2rQ+Gl8K7k1K8bcQXP4Bux8V5sPQoBHVJOS7dyfJRf8nFN/evo0h1C2Js=
X-Received: by 2002:a17:907:d405:b0:a2f:c878:38c0 with SMTP id
 vi5-20020a170907d40500b00a2fc87838c0mr3133557ejc.59.1705976513487; Mon, 22
 Jan 2024 18:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122180605.28daf23a@gandalf.local.home> <20240122181547.16b029d6@gandalf.local.home>
 <20240122181901.05a3b9ab@gandalf.local.home> <CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
 <27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com> <20240122203552.529eeb20@gandalf.local.home>
In-Reply-To: <20240122203552.529eeb20@gandalf.local.home>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 23 Jan 2024 12:21:41 +1000
Message-ID: <CAPM=9tyQ22nw4_u366EX=PnROYcWPD7ONRFpPEKxRvTZo0B4zQ@mail.gmail.com>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at ttm_device_init+0xb4
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, Fedor Pchelkin <pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 12:15, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 22 Jan 2024 19:56:08 -0500
> "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com> wrote:
>
> >
> > On 1/22/2024 7:43 PM, Linus Torvalds wrote:
> > > On Mon, 22 Jan 2024 at 15:17, Steven Rostedt<rostedt@goodmis.org>  wrote:
> > >> Perhaps this is the real fix?
> > > If you send a signed-off version, I'll apply it asap.
> >
> >
> > I think a fix might already be in flight. Please see Linux-Kernel
> > Archive: Re: [PATCH] drm/ttm: fix ttm pool initialization for
> > no-dma-device drivers (iu.edu)
> > <https://lkml.iu.edu/hypermail/linux/kernel/2401.1/06778.html>
>
> Please use lore links. They are much easier to follow and use.

https://lore.kernel.org/dri-devel/20240123022015.1288588-1-airlied@gmail.com/T/#u

should also fix it, Linus please apply it directly if Steven has a
chance to give it a run.

Thanks,
Dave.

