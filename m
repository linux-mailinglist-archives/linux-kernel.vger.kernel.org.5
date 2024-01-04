Return-Path: <linux-kernel+bounces-17103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8D824852
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB341F251C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C95D28E1C;
	Thu,  4 Jan 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QHRpzxA1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DA28E06
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so88102566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704393520; x=1704998320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qcWSnpsRjyKueVFNiRAZacGpJTtuUWC6zXsh0YuQGj8=;
        b=QHRpzxA1cwuNjRGNDI1ITC6UDsZWaAQ56n+1V7DPnmAr39aMmYctF+4gyRtSvEvlvy
         o6w39+P6rWv6wgJTv3+3qBIy7qJkFFb16IbSjAwmMgAD65lnVh9yZJsQ2qk/W2F7Mxv4
         ReHQ1dXaMx2Vn+6bleH8KgoiV5Y+K32Tdg3iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393520; x=1704998320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcWSnpsRjyKueVFNiRAZacGpJTtuUWC6zXsh0YuQGj8=;
        b=W/pfJdWHT9ZTHyA13qB5tv6SjoUXz0xQtoHRZLNdzB1DWem/Ijgb4WR9aNRBIMHiTd
         fYYnivc9tNSMserl++7xKH7GZzHUIxIsdbcsP5DRx1rXue2vzCL/QFBhgrX0QrYEpxL/
         yFeR6BmIxDyukeIwNIk/ZWg/L9RXSDhz5CjcIQ9XJt5NbykPpnPovtvMni0M7ETVDJc5
         y2BRzfseuPrhHy9A1BMfbnZoicm/sNKPlSxlhrKxvTaamopgRWJw6dGX5EpSjSoc5l54
         c+hi/YIjh1IYP64ZJEUaxkSaEadqkar5bJt1j+mrHpOX5DsaPyvvdJf01BDzMjPyUB6P
         WkZg==
X-Gm-Message-State: AOJu0Yy7o1TEb7WWaq7js6Lqv57NnCmkSdg86SZ+4IlMJEe+HjY/llTj
	H+OuSNhn8k5uh/gN8tStgcL4vggdasyQwPNRxDUYWOfBHPOeJAgh
X-Google-Smtp-Source: AGHT+IH4IIIL1+oKQWjAv8e2BrXCqXkbkhlJOsoKp1FL5aPNN6ao7LX08XxKVGf+X8k670Ru40KbtQ==
X-Received: by 2002:a17:906:58d:b0:a28:893:64a8 with SMTP id 13-20020a170906058d00b00a28089364a8mr594893ejn.85.1704393519862;
        Thu, 04 Jan 2024 10:38:39 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ge24-20020a170907909800b00a1d5c52d628sm14048584ejb.3.2024.01.04.10.38.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:38:39 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28ab7ae504so87339366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:38:38 -0800 (PST)
X-Received: by 2002:a17:906:3605:b0:a27:edcb:b3c4 with SMTP id
 q5-20020a170906360500b00a27edcbb3c4mr540792ejb.137.1704393518612; Thu, 04 Jan
 2024 10:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104164703.808999991@goodmis.org> <20240104164738.649338183@goodmis.org>
In-Reply-To: <20240104164738.649338183@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 10:38:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvNLR06Pr+4=L6drSMijmwxysHtZWNkLPoOWKm1ySxEA@mail.gmail.com>
Message-ID: <CAHk-=whvNLR06Pr+4=L6drSMijmwxysHtZWNkLPoOWKm1ySxEA@mail.gmail.com>
Subject: Re: [for-next][PATCH 3/3] tracefs/eventfs: Use root and instance
 inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 08:46, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Instead of walking the dentries on mount/remount to update the gid values of
> all the dentries if a gid option is specified on mount, just update the root
> inode. Add .getattr, .setattr, and .permissions on the tracefs inode
> operations to update the permissions of the files and directories.

Looks mostly good, thanks. This may add more lines than it removes,
but the lines it adds are *much* simpler than the removed ones.

I don't understand why you do those odd TRACEFS_INSTANCE_INODE games.
That seems entirely new functionality. The old'set_gid()' thing did
none of that, and just forced everything to new gid values.

IOW, this seems entirely random. I *suspect* that you have just tried
to retain some odd random semantics that happened to be the result of
a random implementation detail that came out of the dentry tree not
necessarily being fully populated by the time you did the remount.

So this seems wrong.

             Linus

