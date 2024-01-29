Return-Path: <linux-kernel+bounces-43559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508E84157C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDD0B23FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F8159589;
	Mon, 29 Jan 2024 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Yzbs7s9p"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41C266D4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566817; cv=none; b=BjRFa9R/WkKNauCUhC9ZyN9uQctGkQcyiSbxo4O26+KzXGLYR4Yl4zWQ+srx90/U431zzxbFz7MJxX7y+FcFlz++/jnv5fW4Qb0y5mV7dTjct0lZhoLgHjzcy97d7YpgEyLkwdtKLVGxVcaDdyJqM6Z5loknPQZDS8XUNCtTOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566817; c=relaxed/simple;
	bh=PP4Ucxud54uO0dEnP2Nul7Kvjbb/eked+1RH7DqpTNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHCCSVRnVt7PFI3blMGtUj3scFyqYjHqmiXc+qLjvCMTQLj0PY4BTm1xXlxKu8D4TuzEnNw8Uw+NE3Bmwlx8tw/rCQvlL+szfr3HAiQQMxp2kI+A5i6jss5kNQaFLjS4gzEUVfQLo08wgah/VHBfNR4bC3pESnaU0UXnVbx42SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Yzbs7s9p; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3604697d63so76372166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706566814; x=1707171614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iay1thZs+tUb09oVitGMEBAcP06SPOZDG0BLc7NtdM8=;
        b=Yzbs7s9pa+2mQTU1/3pUlmxoordvJUhDiZdCIUCiQdJ9Knkf8z43Xg4awIAkwebzz8
         qWrl9t/1Z1NNWczgQmJP9HiK0PabIna9Ctj6Fbze0iXtBH9FxOSQi1zbBIXAfld+Tjki
         bGFCqCQv9dXF21RIX5r0mjeXxnjJ9gRHOxQtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566814; x=1707171614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iay1thZs+tUb09oVitGMEBAcP06SPOZDG0BLc7NtdM8=;
        b=FWyF891A58t6hdbDYtBx0ksYg36xD7ZGYNfES1VmuZW/YRbEy7lHp69ERgTyiZgLjd
         ovqrCcbQwTPuIOB8E9bXOEw9stjXd7BqXbUQBdPfihLAnZpT2Os4hy7qgVMyPpe/Auqx
         xcSTBlL4mer4YhGjQvysgB/S12J3nsSmGsn6JCKFFPq9TKEa6TAFdV0Nf68pTq3QvhCB
         cnYV6AW/vp0hiLhnTbZdhb0YsDrDTb6/O5n16HVokwwzKV2Ss5qFu2FzHltLO4bGlmKz
         lbBGYjg2VBqyfD4KATuYKlfc7e/K+Ll0B4fGe+0PAKgmMQuIdW82FroQH4qU/72TfDP4
         ahpw==
X-Gm-Message-State: AOJu0YzNbDR8vFBGmkdofXyFRYvzRohlP/f3FJQPiODm8Xe/lfyJSAIp
	5jKD/A5ZEIcdVxM1UQcnCWvfzdGpnXCVMLSeu/lLt9CQKZdF5mjCbNthgXjKiKmywF5AwAHRjCa
	dJSiqcQ==
X-Google-Smtp-Source: AGHT+IGEYBPdoqXmq9j/TmlufzV6qY7QlE4U8G6Y+L04C/dMPKHsm3Sge+h5SccN+Sykacw6Wg2zUA==
X-Received: by 2002:a17:906:b18d:b0:a35:9513:4077 with SMTP id w13-20020a170906b18d00b00a3595134077mr3659116ejy.13.1706566813918;
        Mon, 29 Jan 2024 14:20:13 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id un3-20020a170907cb8300b00a3516240ab3sm3843563ejc.215.2024.01.29.14.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:20:12 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so3365040a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:20:12 -0800 (PST)
X-Received: by 2002:a05:6402:27d0:b0:55e:dbb8:4c6b with SMTP id
 c16-20020a05640227d000b0055edbb84c6bmr3540555ede.42.1706566812300; Mon, 29
 Jan 2024 14:20:12 -0800 (PST)
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
 <20240129164522.72482faa@gandalf.local.home>
In-Reply-To: <20240129164522.72482faa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 14:19:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcy_8snS3znhTB2M_=rDg5gy8bQunKvhLse=AVPp6rOg@mail.gmail.com>
Message-ID: <CAHk-=wgcy_8snS3znhTB2M_=rDg5gy8bQunKvhLse=AVPp6rOg@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 13:45, Steven Rostedt <rostedt@goodmis.org> wrote:
> >  1 file changed, 50 insertions(+), 219 deletions(-)
>
> Thanks, much appreciated.

Well, I decided I might as well give it a test-run, and there's an
immediate deadlock on eventfs_mutex, because I missed removing it from
eventfs_find_events() when the callers now already hold it.

So at a minimum, it will require this patch on top:

  --- a/fs/tracefs/event_inode.c
  +++ b/fs/tracefs/event_inode.c
  @@ -230,7 +230,6 @@ static struct eventfs_inode
*eventfs_find_events(
   {
        struct eventfs_inode *ei;

  -     mutex_lock(&eventfs_mutex);
        do {
                // The parent is stable because we do not do renames
                dentry = dentry->d_parent;
  @@ -247,7 +246,6 @@
                }
                // Walk upwards until you find the events inode
        } while (!ei->is_events);
  -     mutex_unlock(&eventfs_mutex);

        update_top_events_attr(ei, dentry->d_sb);

to not deadlock immediately on the first lookup.

And honestly, there might be other such obvious "I missed that when
reading the code".

Let me reboot into a fixed system and do some more basic smoke-testing.

                Linus

