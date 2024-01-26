Return-Path: <linux-kernel+bounces-40755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D883E561
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BE51F21F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D72511A;
	Fri, 26 Jan 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G0b+K8dK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D129250F9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307989; cv=none; b=c7RA/2E8InXVJCXtwE2PA4tq/3jNApCpDuQqj/2GxnS/UJvrV+ydTYUxRa72vQG2C++eFB9zTCqdUH/C6iSxcrkpAOzbCXQNYZdYZzDX8JvDfaDRfn3fT+kdrxFuzSMwNm1TncuRp8QScbgbNXoDanqGM3QX52ehU+JuRcGW04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307989; c=relaxed/simple;
	bh=ulYxyMID4hoDqqkZq7ZMib690LO/V3+HiOYKu4iA5EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6U85P08jjo6n7eU8TF6E/iAmf4GG3Ai/N2TOCrEx44nJ9O9uIKubDAT4S2iVFQH8MTVHaAV0i+61I4b9cct+vllZo4kzie7o0ahDnhxdGQ8tzbt/Z3Vdcs4/3SfIYJOaR8iuYCwk0vyjLt9+TVrKQlGbSZkVK70mtlq4aIUook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G0b+K8dK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28fb463a28so78350366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706307985; x=1706912785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7RgCCRFdykhHgupnFCoE0SS5Tr46EimKI36cb0Txx4=;
        b=G0b+K8dKSaXhtj/LF1iMD6wZqs1UnX2DuWYXjXfIXukLmUdh9ieE9HvalEHFleujju
         hWEUmLs1vA9PrCLZLauOgOch+V9E4Shox7k9C9vcHDvmYJh6vIYYFcPBfE9MLH7hRhyg
         H0U6DbaBApv8Z9eONS/HV+1Qa6sUSQ6dbIJ9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307985; x=1706912785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7RgCCRFdykhHgupnFCoE0SS5Tr46EimKI36cb0Txx4=;
        b=e8RzZvhpGxjIxrNLumyow0RtnQ685ZM+QFR+4uS2NeDl5aWH+0AcjK4IMVQO8ZXKAm
         2sxV8QDPbuKU8qZ3Vkwwy/OPvukJ+YaXRkVSgU3nZFRlFa2e5aaCTYAGgcGx/umv2e8W
         fa2Cmhv5roVjdLuo4Oa5ci0rBl0R4DctFNzb2zgd+vHU+QsW/KJgPGyDsRsB/5+oyBMw
         BZX8YN++M9WqYlAv6czk2slIx7UG6aWheabw1xDbkXLWBEZQfUeSSOMLVmR6RReACsBD
         I9OzY38k4c/sWIOdEli++iiptLNWBjnv1jfJxLDuDaH2cZpiplkf5/bj1fEh1NIGJrwC
         6/0Q==
X-Gm-Message-State: AOJu0Yy14zcLFct59UfA/mZx8S0RZbAdUlQzka+AvvD7LO3jhsGyxakA
	gNrFw8bscCKVUUX5Ji4LvqzYQWHpHJj2bCVjjpNsSehYdzBvXovB59Xm8U7HCPLVXZo/eWOeqp2
	j5zJe8Q==
X-Google-Smtp-Source: AGHT+IHKx52wMgFFlakGG7kBNEZ77G1g87mbStM3+ndY4iQrVL74kD/zoGb6A8BuqOszbnvNnhCz8Q==
X-Received: by 2002:a17:906:d155:b0:a30:4035:4b0a with SMTP id br21-20020a170906d15500b00a3040354b0amr253317ejb.50.1706307985702;
        Fri, 26 Jan 2024 14:26:25 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z20-20020a170906075400b00a32d1df9c29sm1072916ejb.64.2024.01.26.14.26.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:26:24 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so643540a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:26:24 -0800 (PST)
X-Received: by 2002:aa7:c64d:0:b0:55d:71d8:9dc1 with SMTP id
 z13-20020aa7c64d000000b0055d71d89dc1mr232273edr.38.1706307984490; Fri, 26 Jan
 2024 14:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com> <0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
In-Reply-To: <0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:26:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
Message-ID: <CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I'm not at my computer, but when I tried deleting that, it caused issues with the lookup code.

The VSF layer should be serializing all lookups of the same name. If
it didn't, we'd have serious issues on other filesystems.

So you should never get more than one concurrent lookup of one
particular entry, and as long as the dentry exists, you should then
not get a new one. It's one of the things that the VFS layer does to
make things simple for the filesystem.

But it's worth noting that that is about *one* entry. You can get
concurrent lookups in the same directory for different names.

Another thing that worries me is that odd locking that releases the
lock in the middle. I don't understand why you release the
tracefs_mutex() over create_file(), for example. There's a lot of
"take, drop, re-take, re-drop" of that mutex that seems strange.

           Linus

