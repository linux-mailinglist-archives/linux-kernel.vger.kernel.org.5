Return-Path: <linux-kernel+bounces-42151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962E83FD14
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D3C2835DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10597125C7;
	Mon, 29 Jan 2024 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VqkPGPVk"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6C014F90
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500902; cv=none; b=T91euSz/sg/4uxRU4uET4wmLmrPqqXOz9XrtKcQU2Qqx9HKFfsShWtt8nPV2SO7CUzxcqKyDcmtx+mDX8tHphJPDSGbqApXqN4X5F9WkNsdQU264DFmkJsOY6dU5lXLn0O9pbGWoV0P4oL3rDKUcjle5wBwTbZDi2dwKV/oj5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500902; c=relaxed/simple;
	bh=xkL43O7OU7ppcLkBh7OlkPsjLq6ZFYIqsGEUJU4E5HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNAZsjUWMUIu9Al57/U6YHi8cLXya5CaEU9taIMS9/WdB0vDigasQjbsu909ChMyb9Pp/epJaK29tdQ5JmRYy4kjuUVGFhaF77AHNk7tLWBUe+r/qJ75mT0r9wZvJBDBOrGYNO5PxfeEi1C09HSSkTWzjMhoD9/b2q/2CdfOPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VqkPGPVk; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-510e0d700c6so882973e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706500898; x=1707105698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3rcnUVyGJZKxOB2+kTh5T1A/eFH+JMPmm6YXhef9ps=;
        b=VqkPGPVkhy8EqpLeBANqz3+Rc7n0CByyEgJsKoo8153BBLEAGDwL606nmXm+QM7f1q
         zWOt8Q3VKDgCxiRKmubYLiBxf4viwUfHNJMnZKyyECCDSTgImpqxBxT1uNAaokReumTn
         QYW9IxrSLXDVLo3tDb7+/N+6uNimjKA7YOngA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706500898; x=1707105698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3rcnUVyGJZKxOB2+kTh5T1A/eFH+JMPmm6YXhef9ps=;
        b=DTN2v4v6KxXM+rE6vyhmrIybN/aTCaceel434jvwFm/LLo7CBXh/brYeo0UM+RrDQd
         y9LZG7EFKykV+XdOjj6DTN895NTpGvtsAsHmR3R/JIT7WO79zvBAyAZxFTYfB11MBL8g
         lt/rdG19F8Hp1JcYPdEtzqq29gwAYHaR+SucTM7QRd0VVt/6NV07A1i0aQciSQaTKqc+
         a8y1tLcd6u2HYNkbGPqAkeVv/eIPrff0OFkX5NALX2NF1j4hu4qIQ4S7eXaBsIFdTDgJ
         wUs+xZGVqXItQVYxnm3g80bLGY4yZKN5H+P2mp6tNGHB5zW8Yg7Rbckz+Pr4b3HojuvL
         b7Qg==
X-Gm-Message-State: AOJu0Yxpjz7lGzkUYXq05l5ZlQK7HCcOpToMVEeBlYVatLcBWhEK2Zwv
	Y/qmXBDKZMkc5lXgwAU9hq1p6cU2bPUBHipl8qHYgxCbOix3kdWOHp5JkZXn2vT51B8j9Pkurg1
	rIS8Mzg==
X-Google-Smtp-Source: AGHT+IFrSvU3MthLrqT3qUTdibzK8lOOyzqMNhwtXC1HK7iMTTGjmCbkOKAJPtzsTMBvYtz5Ae9OHw==
X-Received: by 2002:a19:2d43:0:b0:510:2367:1bca with SMTP id t3-20020a192d43000000b0051023671bcamr2744208lft.4.1706500898230;
        Sun, 28 Jan 2024 20:01:38 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x5-20020a056512046500b00510217b6db5sm974757lfd.216.2024.01.28.20.01.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 20:01:37 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5110c166d70so1076476e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:01:37 -0800 (PST)
X-Received: by 2002:a05:6512:12d1:b0:50e:6317:54ab with SMTP id
 p17-20020a05651212d100b0050e631754abmr2806079lfg.42.1706500896681; Sun, 28
 Jan 2024 20:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128175111.69f8b973@rorschach.local.home> <CAHk-=wjHc48QSGWtgBekej7F+Ln3b0j1tStcqyEf3S-Pj_MHHw@mail.gmail.com>
 <20240128185943.6920388b@rorschach.local.home> <20240128192108.6875ecf4@rorschach.local.home>
 <CAHk-=wg7tML8L+27j=7fh8Etk4Wvo0Ay3mS5U7JOTEGxjy1viA@mail.gmail.com>
 <CAHk-=wjKagcAh5rHuNPMqp9hH18APjF4jW7LQ06pNQwZ1Qp0Eg@mail.gmail.com>
 <20240128213249.605a7ade@rorschach.local.home> <20240128224054.0df489b8@rorschach.local.home>
In-Reply-To: <20240128224054.0df489b8@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 20:01:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whjO4zAmoP8fQkHUQJANahFMZaviNu=Jfd36E=knLPVgQ@mail.gmail.com>
Message-ID: <CAHk-=whjO4zAmoP8fQkHUQJANahFMZaviNu=Jfd36E=knLPVgQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 19:40, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> [  106.258400] BUG: KASAN: slab-use-after-free in tracing_open_file_tr+0x3a/0x120
> [  106.261228] Read of size 8 at addr ffff8881136f27b8 by task cat/868

Are you refcounting the pointers that you have in the dentries (and
inodes)? Like we talked about you needing to do?

Every time you assign a pointer to d_fsdata, you need to kref_get() it.

You try to work around the tracefs weaknesses by trying to clean up
the dentry data, but it's WRONG.

You should refcount the data properly, so that you don't NEED to clean it out.

               Linus

