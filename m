Return-Path: <linux-kernel+bounces-40837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62283E6C1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61ED1F2A499
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F26859154;
	Fri, 26 Jan 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mg8KCWC7"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3E55E66
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311056; cv=none; b=IKWAjPVKUGtKtO5+vQwgXMWDy8XUekYPHOFcJD2EIBSOaEPc+Qs6Wk4NCJx6oM0gJ0j+g9YCkkhvdw5UaSnfUzDD1lxwah4w8PrPCsINCzifc6i8EzaSrvZZbxl9qQIBVUyRCKtuMMOX2OsY3NeeeB5havNASjAO6iVvVG79X4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311056; c=relaxed/simple;
	bh=QmVspYtlmSmjhcCoSiCpOR9/r0lxSB1GXdq7WVzBRp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSnaoL5Yo4UEKr+vhMIE4PNFW0v1C6lhHeJGSnTCUt0YkpdSIZ/ksfixWQXwrMA/ZbEmIK/usIoDf5s5uGuqOlIabHh4kgrBbuKuPGFKdFDhVcU9zuqWUWlA6SIV53L9pfVV118zY56rx03Sn8rRpP5FYpEWBbLpqa9iSy3zwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mg8KCWC7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51028acdcf0so1045365e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706311052; x=1706915852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC+HuLvY2p6RWyDAc32xlp18wOorWJVU3mokVs6SBvk=;
        b=Mg8KCWC7ftFgTMxx63cRE+MeYtyaEvDFAaR6eOLYpTKbjBePAgmi8GTy/aUmLcBQFL
         Frzdy4Z3j+8IMyf6XEB4LLR9QaZSgi0P7LTOFhYA+tI01y/opJYak8ykUQxidXlx2ke1
         p97RAG3+tmE8KreC/b2qzOfN1qMzdaVWV3o/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706311052; x=1706915852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC+HuLvY2p6RWyDAc32xlp18wOorWJVU3mokVs6SBvk=;
        b=PCefLW/ZRxn6CUBqMH+kOjAEEjhIsKcBM8EMoydD8wuXdXaiBjO+Y6wm1x4JIE9NuC
         ZpmWca13rUX8/RbPQqzznyb7+oz2lrQAkbgN8ldeqdFLPF93/xw8eQTRJ4LpSmyN1QBy
         LtlNx0SItrn+skQIOfGgrb261C+cCn6fPJtBz1o2wUc8YJsOA9dWfuq5nT1ISECDgYuT
         9GnLXEU150sK7Et5Ues7m8CpcVh4uZYvg1r8dGCJseUoX+8yj53CTdkqK4XQSS+7aD+U
         ecF6472rVdR68v/2qz36syJBVKHyybRVJAcR3Srk5paP1fpYPGnIKCnNJSmaB2OdcGgJ
         trDg==
X-Gm-Message-State: AOJu0YyLlOjVy4h68o4kQTnOLZFR5tvIJekYYuKRRRxyNEU3Z2PZQkZN
	zjEAEkxuQ4iEtodX1hkChuN49lhqU6+hYTviCrsl/9xEwNfy0nZZIhbWcmA8zfwoGIK/yaNmE3a
	8Dahm4w==
X-Google-Smtp-Source: AGHT+IGRYdQU/Bxy5kykjCRhcI5y4E87g2sFkJyrRRVZsxdQ7HFrx6qDVZ5ZvAQ7RQyjeH4fhgscEQ==
X-Received: by 2002:a05:6512:12d1:b0:510:f47:8d82 with SMTP id p17-20020a05651212d100b005100f478d82mr288109lfg.22.1706311052131;
        Fri, 26 Jan 2024 15:17:32 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z5-20020a056512370500b005101e4600cfsm318576lfr.252.2024.01.26.15.17.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 15:17:31 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so13176121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:17:30 -0800 (PST)
X-Received: by 2002:a2e:7c19:0:b0:2cf:4a53:90f with SMTP id
 x25-20020a2e7c19000000b002cf4a53090fmr374339ljc.7.1706311050498; Fri, 26 Jan
 2024 15:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <ZbQzXfqA5vK5JXZS@casper.infradead.org>
 <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
 <ZbQ6gkZ78kvbcF8A@casper.infradead.org> <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
In-Reply-To: <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 15:17:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqu_21AnXM9_ohxONvmotGqE=98YS2pLZq+qcY8z85SQ@mail.gmail.com>
Message-ID: <CAHk-=whqu_21AnXM9_ohxONvmotGqE=98YS2pLZq+qcY8z85SQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Matthew Wilcox <willy@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 15:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 26 Jan 2024 at 15:04, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Maybe we should take advantage of that historical oddity.  All files
> > in eventfs have inode number 0, problem solved.
>
> That might not be a horrible idea.

Note the "might". I don't know why glibc would have special-cased
st_ino of 0, but I suspect it's some internal oddity in the readdir()
implementation.

So considering that we do have that commit 2adc376c5519, I suspect it
would just be more pain than its worth to try to teach user space
about the whole "no inode number" thing.

It might be safer to pick something like -1 instead.

               Linus

