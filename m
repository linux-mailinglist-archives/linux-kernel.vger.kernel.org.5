Return-Path: <linux-kernel+bounces-16337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4F823D05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E6F1F23333
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9EB200AA;
	Thu,  4 Jan 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TlzjCQqt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF220307
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so269604a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704354870; x=1704959670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FMZw4cFNOlZCe3LgKcDEPhk2BNsirOIn4+PIr9aaThk=;
        b=TlzjCQqtY7ghXeG6Sx+Yq/JATqKkELgot4KQV4EKJyDFXAo2QrRmhp3vGcrMeetVJK
         RTWUDTRp2BYo7PlLcYrp76YNArgWf0mBJf4m/wRjQ1Shiboly8LGFKC/uzBklqCwhHXb
         lF5ZtSZC9q+3S0RaKXBmwYg2kNrimzmWVZ1k/D6GGNEpOO7MvFFsHMtXKqHkodlSGDM5
         UKg3g+gBELirPOnMFihGVGyCU9Zg3QerE+/X4belvDebUs+RV0FNP8+o0HvL2HIw+0OW
         i++zHmQDibgTmfzc8AyFumTEXbq9t/fdG9yA35dw8rxbeF0Scbkb3B3U0HTDMaCF7Yaj
         6n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354870; x=1704959670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMZw4cFNOlZCe3LgKcDEPhk2BNsirOIn4+PIr9aaThk=;
        b=UtVUc86ObiB88geI/R121HCtA10LW/Sm7cz4V+BeTmmP2drXpgdCMovGadXbvTaEm2
         5pwOa9QclkfJ+IWfaVN2BNNiw35i0cD63A6po9e3aQzGsvjfFPR4wDfWP5juJcH9wR1U
         AOebUgFw5a/jNAbkCEa+UUfzvC2f6aEeb2RLw3bTDv+8nd3fxxxILg1/d/QrYspLVr01
         6HfGFozTD9GP5TIdxAMGbtCQWia0mNKE4GPIN3dGv10LGAPYgg0MTUjsu6uNp+764hHf
         VlUIWfhrm9gRVAUafABIr8yLv1AjfYnUcb86BnYv41zvQxGtbTfkZ+eTc6htiw8pH4O2
         x/tg==
X-Gm-Message-State: AOJu0YzXRtNLcxikfQmuaEOh0GdVDrN9qWdsKJC20/9HR+jw+zmWjQy5
	o3GbRXH2+hzUyx2Xgm0xwLi9pLyYQ/lqQQ==
X-Google-Smtp-Source: AGHT+IH+gp8sR4jijlxz66n6nBqPgfl1C6WwMe2IvUUGPaGUD5/hnknhybsx3F/XonaoOg51fUvkng==
X-Received: by 2002:a17:907:368d:b0:a27:59f9:5156 with SMTP id bi13-20020a170907368d00b00a2759f95156mr106470ejc.132.1704354870520;
        Wed, 03 Jan 2024 23:54:30 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906258a00b00a28e2b72db2sm261954ejb.56.2024.01.03.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 23:54:30 -0800 (PST)
Date: Thu, 4 Jan 2024 08:54:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>
Cc: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
	jbaron@akamai.com, john.ogness@linutronix.de, keescook@chromium.org,
	ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
	sergey.senozhatsky@gmail.com, upstream@semihalf.com,
	vincent.whitchurch@axis.com, yanivt@google.com,
	gregkh@linuxfoundation.org
Subject: Re: [re: PATCH v2 00/15 - 05/11] dyndbg: change +T:name_terminator
 to dot
Message-ID: <ZZWIhpIBqQzL7PcE@alley>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com>
 <7cb5c8b6c6efba7e437595266638be39f23361fc.1701993656.git.jim.cromie@gmail.com>
 <ZYCBlI56kmDMew6U@alley>
 <CAK8ByeJHAPijVWbATUxXpXHa7uCn3dwLgi_6ckfWY0ADmBwqcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8ByeJHAPijVWbATUxXpXHa7uCn3dwLgi_6ckfWY0ADmBwqcQ@mail.gmail.com>

On Thu 2023-12-21 16:21:49, Łukasz Bartosik wrote:
> pon., 18 gru 2023 o 18:29 Petr Mladek <pmladek@suse.com> napisał(a):
> >
> > On Thu 2023-12-07 17:15:08, Jim Cromie wrote:
> > > This replaces ',' with '.' as the char that ends the +T:name.
> > >
> > > This allows a later patch to treat ',' as a space, which mostly
> > > eliminates the need to quote query/rules.  And this in turn avoids
> > > quoting hassles:
> > >
> > >   modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p
> > >
> > > It is particularly good for passing boot-args into test-scripts.
> > >
> > >   vng -p 4 -v \
> > >   -a test_dynamic_debug.dyndbg=class,D2_CORE,+p
> >
> > Could you please add example how it looked before and after?
> 
> Before a user had to issue a command in the format
> modprobe test_dynamic_debug dyndbg="class D2_CORE +p"
> 
> Now a use can use either
> modprobe test_dynamic_debug dyndbg="class D2_CORE +p"
> or
> modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

I see. This was not clear to me. Please, mention it in
the commit message.

That said, I am not sure if it is worth it and if it
is a good idea. Supporting more formats adds complexity
and confusion. It is the reason why people hate perl.

I agree that quoting in scripts is complicated. Well,
a sane approach is to use quotes everywhere where possible.

If a script works correctly only with class,D2_CORE,+p
and breaks with "class D2_CORE +p" then it is a ticking
bomb. People might try to use "class D2_CORE +p"
one day because they would cut&paste the string
from the internet.

> > Is this format documented somewhere?
> > Will the documentation get updated?
> 
> Documentation will be updated.
> 
> > Could it break existing scripts? [*]
> 
> It should not break any scripts as this change does not change the
> interface but extends it.
> 
> > The dynamic debug interface is really hard to use for me
> > as an occasional user. I always have to look into
> > Documentation/admin-guide/dynamic-debug-howto.rst
> >
> > Anyway, there should be a good reason to change the interface.
> > And the exaplantion:
> >
> >    "Let's use '.' instead of ',' so that we could later
> >     treat ',' as space"
> >
> > sounds scarry. It does not explain what is the advantage at all.
> >
> I will clarify in the commit message that this change allows to use
> two formats either
> modprobe test_dynamic_debug dyndbg="class D2_CORE +p"
> or
> modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

But the patch replaces ',' with '.'. It looks like it modifies
some existing syntax.

Note that I am not familiar with this code. And I even do not see
the patched function in the current Linus' tree.

Best Regards,
Petr


