Return-Path: <linux-kernel+bounces-17188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D8824959
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458411C226BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A782C692;
	Thu,  4 Jan 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcAgY24T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618482C68C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso7501155e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704398539; x=1705003339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jDsDfmbTpiQpvGnfOhd0ROcnisF14caf1vpRK9xqg4=;
        b=TcAgY24TVMOu9UYln9SgjwiLLt7KXvS7eV38BEAz0LiDd4c8Itbp+aRmvCzgLDsv8z
         btwA0mPop8VYEmcWhQ9S+Z/LjiG8BmIwlZkLeHhQpB6VdU9jnXdE62t18jTPZqKJsD+z
         4ZpyUNzjCDiJrE7ciRzvpBMU8+3XQB7D0qeNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398539; x=1705003339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jDsDfmbTpiQpvGnfOhd0ROcnisF14caf1vpRK9xqg4=;
        b=iohUrl8C5h73jAqPUyG8t1aerCmpxspR8w0KQV3W4gFd+irk/7aoYdctU+OLcSBovK
         mMOZZD37FFwBzul6Ut4Nrxpcv2c4eD0LehVW0CCamQGwM/7PEv0eb8B46txCHu1B1Oxc
         toUn2DwfH7nTGn+gDsS4tdmZfjQSdvltlWqrKcHP9m9YFRNO8I0e2+Ev4leXKxNrwbn/
         barBsq+sAm8thgysGSjK4Q51c2Z4Z/rJM/8mkohUnCqy1z/bBbbZkqyrKgq8Y3a6I9tR
         RZSvWCI1Lk/wSxGoQQh6OJW6J2mwRP5l8ghlNFToWZHSbuiOl1GYa/npdLH6eGOyqbYk
         0GVg==
X-Gm-Message-State: AOJu0YzefbhZtJ2rGuTdX+Kjb6wvsAJMTVqy4mpeZVg9R827MGSqf+Gy
	1Djz2CcdnH5tWL0RcmBqLSGNXmwx7oLbDiNvTHoymX9mHQWLZ11e
X-Google-Smtp-Source: AGHT+IEDK81qQpeVF1oJvgjgO+S8JTazV65QsBrkBUvEHbZvxji3F0+Kg2P7gvisuFXTfi6iDFTldw==
X-Received: by 2002:a05:600c:1912:b0:40d:6841:14cf with SMTP id j18-20020a05600c191200b0040d684114cfmr644099wmq.112.1704398539554;
        Thu, 04 Jan 2024 12:02:19 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906249700b00a2327e826ccsm16213ejb.201.2024.01.04.12.02.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:02:18 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28d25253d2so99055366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:02:17 -0800 (PST)
X-Received: by 2002:a17:907:360b:b0:a1d:932f:9098 with SMTP id
 bk11-20020a170907360b00b00a1d932f9098mr716728ejc.97.1704398537679; Thu, 04
 Jan 2024 12:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV>
 <20240104141517.0657b9d1@gandalf.local.home> <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
In-Reply-To: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 12:02:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguvq7yFt3qaLrWoZK5FCK8Joizrb2wu=FN==mYM9PSbg@mail.gmail.com>
Message-ID: <CAHk-=wguvq7yFt3qaLrWoZK5FCK8Joizrb2wu=FN==mYM9PSbg@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>>
> Which is *NOT* the inode, because the 'struct file' has other things
> in it (the file position, the permissions that were used at open time
> etc, close-on-exec state etc etc).

That close-on-exec thing was a particularly bad example of things that
are in the 'struct file', because it's in fact the only thing that
*isn't* in 'struct file' and is associated directly with the 'int fd'.

But hopefully the intent was clear despite me picking a particularly
bad example.

            Linus

