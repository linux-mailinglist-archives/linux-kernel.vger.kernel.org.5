Return-Path: <linux-kernel+bounces-17104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9F824859
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE2AB24B27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C128E1E;
	Thu,  4 Jan 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MDLm+/VZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1028E1B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5555f9061b9so1117742a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704393982; x=1704998782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSK+c0gfVwSu7jtoMzSmkd2iBFspX1CIYM8sXAK01vI=;
        b=MDLm+/VZqQYwPPf0gYVfTIeM7uE+CFSsmYZwGpsQbRroZNF0RdyVCzYwxSJ/f2+YyJ
         A6WRpP4gwBAApCv3itt4HCS44ImpgpmcfRWVquFNKcAnZCd46Ht3gsvPp8CK9cLFDAh3
         9Ia2EK53XdX9Dkwy03UZMPgNV/uc1kNJ3y/9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393982; x=1704998782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSK+c0gfVwSu7jtoMzSmkd2iBFspX1CIYM8sXAK01vI=;
        b=Z/7peboaMXkNP7t2P1MhAx0ufOJL5heAxuKhyysN/SZ0PBmNJ6CWO+cZxDSf6qEQAI
         gH+0magvpkclXgjcvmI7DTlJ8PzqlKGPa8/2nZkxDo/fgoXvxeyRi5yoEEmviL062fL5
         PabgKyV/0EaB1nKqzij5fwgnOMOZKar8vLa2vyBD5chD9XtitP3KDQJb5qus2ujpk9uX
         wUjw0M2MukufGPPxIhS+EWOu53aV4baC3lfD1kiMyFD0wyAkKCEqHnp26IkMF+e0+aLq
         nnLNI1CPDjKivyHXxNG2lLC07SnuAGslJwx97UIBddnliHAEOBJQ7id8S9tZJA1hogi/
         svmg==
X-Gm-Message-State: AOJu0YyqcJ82bq3a4ISMH3JOPZtRTSxLQL3J2FjZEoeITglIIyZtp+DV
	Zj0sszfvsEus2iLIOI3qLHXnbElq2++k5yojH4aOz4+bdsniKhEu
X-Google-Smtp-Source: AGHT+IGe4o2UmfYW2rhGDAXtHXpIGxywFpOSd2qcJwH67D1NV8SmxT4Bg4ym8EKHLK1J0Kqt8To2bg==
X-Received: by 2002:a17:906:3455:b0:a19:940f:b9d3 with SMTP id d21-20020a170906345500b00a19940fb9d3mr622208ejb.25.1704393982500;
        Thu, 04 Jan 2024 10:46:22 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id eu18-20020a170907299200b00a26e53be089sm10821661ejc.44.2024.01.04.10.46.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:46:21 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so1106799a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 10:46:21 -0800 (PST)
X-Received: by 2002:a17:907:26c4:b0:a28:cf59:60c8 with SMTP id
 bp4-20020a17090726c400b00a28cf5960c8mr751629ejc.33.1704393981134; Thu, 04 Jan
 2024 10:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104164703.808999991@goodmis.org> <20240104164738.483305222@goodmis.org>
In-Reply-To: <20240104164738.483305222@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 10:46:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
Message-ID: <CAHk-=wiKwDUDv3+jCsv-uacDcHDVTYsXtBR9=6sGM5mqX+DhOg@mail.gmail.com>
Subject: Re: [for-next][PATCH 2/3] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 08:46, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>         list_for_each_entry_srcu(ei_child, &ei->children, list,
>                                  srcu_read_lock_held(&eventfs_srcu)) {
> +
> +               if (c > 0) {
> +                       c--;
> +                       continue;
>                 }

Thanks for putting that at the top, I really do think it's not just
more efficient, but "more correct" too - ie if some entry that *used*
to exist and was previously counted by 'pos' went away, it's actually
*better* to count it again if we still see it, in order to not skip
subsequent entries that haven't been seen..

And that very fact actually makes me wonder:

>         for (i = 0; i < ei->nr_entries; i++) {
> +               void *cdata = ei->data;
> +
> +               if (c > 0) {
> +                       c--;
> +                       continue;
> +               }

The 'ei->nr_entries' things are in a stable array, so the indexing for
them cannot change (ie even if "is_freed" were to be set the array is
still stable).

So I wonder if - just from a 'pos' iterator stability standpoint - you
should change the tracefs directory iterator to always start with the
non-directory entries in ei->entries[]?

That way, even if concurrent dynamic add/remove events might change
the 'ei->children' list, it could never cause an 'ei->entry[]' to
disappear (or be returned twice).

This is very nitpicky and I doubt it matters, because I doubt the
whole "ls on a tracefs directory while changing it" case matters, but
I thought I'd mention it.

              Linus

