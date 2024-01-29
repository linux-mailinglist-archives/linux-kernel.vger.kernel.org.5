Return-Path: <linux-kernel+bounces-43575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6508415D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FB8B23870
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D55103E;
	Mon, 29 Jan 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C7XpMCIP"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D853E07
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567758; cv=none; b=GJM2KSkc6K87OkTSmTX97ybNFijjsvhcoybgpr1P2607Umz95Wwfur/6WrTIiJi+tL+HSboY7Lql5fotYK6a2xllOwIW5qJxcGU60qLfmWl4eiLGeGGEGgVYxf1IJc4Ap5MPLMRraA/GAn9mMHqux7xj3rP/rsCRqoaHo1m4x2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567758; c=relaxed/simple;
	bh=VnTiScXQo7bZZSg4GpsGPNgsG9aIQqnuAmV4bkEVHE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/L2k957VUELg3xGk9+Nq3or/B1EILIxxR6AQojyh8tLBVVO0weKHqc9n1R7IXzhyC23F3+44hq2Ro+IL5fb2XR4BblQyJsGDxkgoY/FBOybKsqIpG+Pt1qBihN+EpP7Jn7HIavs/Q4q8sIps3E+ZcIskA3+w1mu+Z+s0UZwjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C7XpMCIP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso17398591fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706567755; x=1707172555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hj+C8eVFms56HSNUtGD4vDso2zbX9G6i0iFWoHn8+w=;
        b=C7XpMCIPLV3aBXlRpK/jSod7hMEzchvQUqK7g+DKNPBMmaUd4+MoIt+5JzQOHyQSjU
         jbkV7n8KpR2P+w/i28qeZt3cmjiVSEtvRu1iEniWF0ha6ZXZM0lkxWwoxzadf8LLomj6
         RNiltSzVL7i51n4z6OF/XH8UPTbF2IcCrUMmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567755; x=1707172555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hj+C8eVFms56HSNUtGD4vDso2zbX9G6i0iFWoHn8+w=;
        b=O45xC/2xp/nzDxqm72/B+z4Yqnjw1UETFkIy/uMfAPPOVk4oi1ZPxo1BB/SPufZWS8
         nO/TXxZr2wUZwpx6m8vAE146tXj+37cCTBjjwjM2zjA/PlvJ6A+cOPcXAOQSD2kxQrSz
         5RQXtc9iMleRZCRipZk9wvM5+wUetO8ctlyH/qRl9jiZZZA1KlM4UL/8Czcz8DC/JfZf
         bc+1KYbaBCaPfRp1krWVvSbrr8a9MXPB4WZJsEJDGrgOqbwsbfIx94wPpXosrgZZ2j5Q
         I9GrMJ8VYoXZ7oH8US9dQ9uZXAeffLBppHZkaDxUnkbTDB+w0aM/ibGmAqr3qscBXJ+m
         4YZQ==
X-Gm-Message-State: AOJu0YxtfrC+NR08dnhMTdRcQEPuyFTiICQveqTWiZYQ6htGWtAzk86M
	hmKPQl38JBjTfwDFBvMQlZYSqaF30v2egf2ixRXSaXEo/rgX0TaI2860zxMmHM9D3Nww/jg9AUi
	36Hp/tw==
X-Google-Smtp-Source: AGHT+IFeN3kYVh/9JlJC7I5bhTd70/IDKtVf2h8DOcl2QfuVpYDgLPvhcJqw1ZftilChi2hXDUvExA==
X-Received: by 2002:a2e:95cb:0:b0:2cf:32cd:80c with SMTP id y11-20020a2e95cb000000b002cf32cd080cmr4975717ljh.32.1706567754736;
        Mon, 29 Jan 2024 14:35:54 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q5-20020a2e9685000000b002d050c4da1dsm336124lji.121.2024.01.29.14.35.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:35:54 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d057b6ddfdso2946901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:35:53 -0800 (PST)
X-Received: by 2002:a2e:9a93:0:b0:2cf:22f1:bd5e with SMTP id
 p19-20020a2e9a93000000b002cf22f1bd5emr4180113lji.44.1706567753589; Mon, 29
 Jan 2024 14:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home>
In-Reply-To: <20240129172200.1725f01b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 14:35:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
Message-ID: <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 14:21, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But crashes with just a:
>
>  # ls /sys/kernel/tracing/events
>
> [   66.423983] ------------[ cut here ]------------
> [   66.426447] kernel BUG at fs/dcache.c:1876!

Duh.

That's a bit too much copy-and-paste by me.

So what is going on is that a ->lookup() function should *not* call
d_instantiate() at all, and the only reason it actually used to work
here was due to the incorrect "simple_lookup()", which basically did
all the preliminaries.

A ->lookup() should do 'd_add()' on the dentry.

So just replace all the d_instantiate() calls there with "d_add()"
instead. I think that will fix it.

Basically the "simple_lookup()" had done the "d_add(dentry, NULL)",
and at that point the "d_instantiate()" just exposed the inode and
turned the negative dentry into a positive one.

So "d_add()" is "I'm adding the inode to a new dentry under lookup".
And "d_instantiate()" is "I'm adding this inode to an existing dentry
that used to be negative"

And so the old "d_add(NULL)+d_instantiate(inode)" _kind_ of worked,
except it made that negative dentry visible for a short while.

And when I did the cleanup, I didn't think of this thing, so I left
the d_instantiate() calls as such, even though they now really need to
be d_add().

Hope that explains it.

And I hope there aren't any other stupid things I missed like that.

         Linus

