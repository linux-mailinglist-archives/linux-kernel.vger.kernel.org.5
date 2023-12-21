Return-Path: <linux-kernel+bounces-8876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1D81BD91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538C11F21797
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B663500;
	Thu, 21 Dec 2023 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q6gsePZl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD956280D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a268836254aso129350766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703180762; x=1703785562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Io+O65t5bdOYeX7rjnfPtchqtd91gUb6zPccYQXRtPA=;
        b=Q6gsePZltqqxxML2RE6j1aZhPVVjvaiZAqYqHNouUlG+pnDX4jgsYGWZvXRBqzPhLy
         SZD0RVu00PPQKEWW5pRwftag6F/xe7kuES9YobQgwKZHDn0H1CSrVab3h7/9+LfGakXU
         Q3RjjVt24wryLcrDgTcrnil8xWfpfHiWJ52hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180762; x=1703785562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Io+O65t5bdOYeX7rjnfPtchqtd91gUb6zPccYQXRtPA=;
        b=LycFR5f3pJICdaSwlrq4CMd0xdCFmw/Da3+YVp2MhWi2N9kSXX4OI2QaxLQPGH6ZWK
         3GJUzDeQyFnCqIPDsMNNex4g+sQHvp3XUvP4VCDjE73JiBIMrytnugNdSAEH6OOBVFCB
         6deZ5odt7AQ+lKSr6cuKiT1KKEeW671qdHsBcHCVCEtjWUBnDzMm+fYJH6OMt984f8TQ
         deTsJxworeBrZxp5Ume7bTn+RCs0/BV4HXq8L5mQwFvZXW2TIMaitL0f6mUPMbjdnCn4
         Tfh3V0aeQkbOQ1Kze2YnFLuHWmDGQljPunX5qslc6u7wr43EB2gqxq6uAkTBM/4VSdvP
         haJg==
X-Gm-Message-State: AOJu0Yy80B0CJEgDkuEscqbV3l66GljorPzRYn0WsxVfTmfOG7FfqyU5
	itkPlmQTZuFx3ZaMQvLfYimHyoWHilNaYBZ5hiPsQ2Zvh2H3yMia
X-Google-Smtp-Source: AGHT+IGVgIjrxNV+eaG47p5p7TYJgRkjgzWDOK2X4TiP10j/XDwz92EkLL2bKOjaivjc9nGhhPzDfw==
X-Received: by 2002:a17:906:a288:b0:a23:2ccc:8eb1 with SMTP id i8-20020a170906a28800b00a232ccc8eb1mr76479ejz.134.1703180761817;
        Thu, 21 Dec 2023 09:46:01 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ft1-20020a170907800100b00a26aa420389sm681764ejc.33.2023.12.21.09.46.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 09:46:01 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a1fae88e66eso128309866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:46:00 -0800 (PST)
X-Received: by 2002:a17:906:5c:b0:a23:6d09:413 with SMTP id
 28-20020a170906005c00b00a236d090413mr84157ejg.46.1703180760380; Thu, 21 Dec
 2023 09:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221102703.08dc1273@gandalf.local.home>
In-Reply-To: <20231221102703.08dc1273@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Dec 2023 09:45:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com>
Message-ID: <CAHk-=wiwQtUHvzwyZucDq8=Gtw+AnwScyLhpFswrQ84PjhoGsg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: A few more fixes for 6.7
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 07:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Fix eventfs files to inherit the ownership of its parent directory.
>   The dynamic creating of dentries in eventfs did not take into
>   account if the tracefs file system was mounted with a gid/uid,
>   and would still default to the gid/uid of root. This is a regression.

Honestly, this seems to still be entirely buggy. In fact, it looks
buggy in two different ways:

 (a) if 'attr' is NULL, none of this logic is triggered, and uid/gid
is still left as root despite the explicit mount options

 (b) if somebody has done a chown/gid on the directory, the new
dynamic creation logic seems to create any files inside that directory
with the new uid/gid.

Maybe (a) cannot happen, but that code in update_inode_attr() does
have a check for a NULL attr, so either it can happen, or that check
is bogus.

And (b) just looks messy.  Maybe you've disallowed chown/chgid on
tracefs, I didn't check. But why would it inherit the parent uid/gid?
That just doesn't seem to make any sense at all.

I still claim that the whole dynamic ftrace stuff was a huge mistake,
and that the real solution should always have been to just use one
single inode for every file (and use that 'attr' that you track and
the '->getattr()' callback to make them all *look* different to
users).

               Linus

