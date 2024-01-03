Return-Path: <linux-kernel+bounces-16048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A48823774
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD952850D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9BA1DA3E;
	Wed,  3 Jan 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AVDB1Z7T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91ED1DA35
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso5710571e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704319623; x=1704924423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGTvqwTPDHKOw2dBon6pGIVG5u9VcyiSKusgLBhPCPA=;
        b=AVDB1Z7TGxLakr4zrO8x8Y8LlJAnX0UjP1UojpUwoSo3h1QnGqBouP6cj2kO1TIU9z
         V6SfvrbwNM3U7EsTN3nuDBxfXhLnMjX97P9E6qNGOtSHpuGhWb1iJmW9oLqFkWYzwpDL
         ofJ4xKn1aClRwHd8ioXNIhWigb69UwH+WcfEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319623; x=1704924423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGTvqwTPDHKOw2dBon6pGIVG5u9VcyiSKusgLBhPCPA=;
        b=wjz7bov9AuJfo0cIjUFdrEvtj+UgWDP09uNSUcJFlGeckSlVNQ6ZvM9N7r08KV3mzx
         JFeejJC3RMs9e91q13U4z2G5yBKoTC/PErbuIAHKQIBARkr/4GszAYD+ZEzShxMrurRn
         VQ/35DteVl548TYlvvErdCD/pINY1j8XZejmsQ6Nyfi/3T6JW/nSEefKJ1ep+2eC0vjV
         kYyVadV8m/K5onc0g4iorMzqi12nx7VAtxYNiNe5i4qQAQKnjXi3uuW0kvyE3LT9qV8Q
         PGZnCw0fsz0CLDGDIUarRfQjVr3EhBX+ibu1dmnjvTUVM0d55azbWX3zRRBZNeWAJR5g
         7flA==
X-Gm-Message-State: AOJu0YzPJ4bc2sldt4Hglwyc9Ut2JSS/8gOF1dBna2yxZDukMAU61WLi
	GEAV5s5glmZmmJhOCiZG6rmIdWoX/aPdYBCO59E0fWf6EHWssAli
X-Google-Smtp-Source: AGHT+IHtlE3K1Z78n1wPbQO//2CPx1BpcJudunYmptDOnHdliBgLqRNKFa15LpXbGjP/zO1v7860aw==
X-Received: by 2002:ac2:5dd8:0:b0:50e:74e1:144a with SMTP id x24-20020ac25dd8000000b0050e74e1144amr6634865lfq.15.1704319623783;
        Wed, 03 Jan 2024 14:07:03 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id mf6-20020a1709071a4600b00a26aa8f3372sm12523580ejc.27.2024.01.03.14.07.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:07:03 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso102684645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:07:03 -0800 (PST)
X-Received: by 2002:a05:600c:3c94:b0:40d:62fe:a160 with SMTP id
 bg20-20020a05600c3c9400b0040d62fea160mr5605515wmb.93.1704319622802; Wed, 03
 Jan 2024 14:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:06:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJouS5fWAf7ReooLLES0rq2F=V1s-fPyLDX+OoXX+JBw@mail.gmail.com>
Message-ID: <CAHk-=wgJouS5fWAf7ReooLLES0rq2F=V1s-fPyLDX+OoXX+JBw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Here's an updated patch that builds, and is PURELY AN EXAMPLE.

Oh, and while doing this patch, I found another bug in tracefs,
although it happily is one that doesn't have any way to trigger.

Tracefs has code like this:

        if (dentry->d_inode->i_mode & S_IFDIR) {

and that's very wrong. S_IFDIR is not a bitmask, it's a value that is
part of S_IFMT.

The reason this bug doesn't have any way to trigger is that I think
tracefs can only have S_IFMT values of S_IFDIR and S_IFREG, and those
happen to not have any bits in common, so doing it as a bit test is
wrong, but happens to work.

The test *should* be done as

        if (S_ISDIR(dentry->d_inode->i_mode)) {

(note "IS" vs "IF" - not the greatest user experience ever, but hey,
it harkens back to Ye Olden Times).

                Linus

