Return-Path: <linux-kernel+bounces-130688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A675897BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE181C25E20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F542A80;
	Wed,  3 Apr 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KUp/WqDA"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54709D2FF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183497; cv=none; b=UFeA5HFDy85kkJByK1mh4Po4PM+/rGpeamQqpGevhKu+U9fo0Xg+Uc7yoAWQqt9OqYkwFZDvtqD0wnmtO97M2c9cFugRer82FRqsxpPcUMRueQowOplc04m06kNHijZzOJTHaTdcsM4BTSl443kyO/mzs6quIIstivgnIXhkIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183497; c=relaxed/simple;
	bh=LdjWg8CKqILSv/gh2DiSM1tZ0mdeTtL00TrMqH9Z+qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgseOTHqin8CxOF+U/1vvV/LiXmq61V4dv10k+p/hJkU+GFuDXVetOOuTXcXgdA37gumVLofLmcqRUX45w+14H9i0BzwR8bZKJ+Xf9K5jwfCicQmtOsxfYT5R3K0ZlsSMpsVRcevvcMAWSacsjMhNXXSJsWUyDVf4pn4hT8ulWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KUp/WqDA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61500da846fso3825067b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 15:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712183495; x=1712788295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH63Wj4aYXN7kae3y+ikS2p78PQsFgI7iiixaCrlIVk=;
        b=KUp/WqDArtBJFdnnCraYlTBMEOS8YY61C9PjAAC5vQ4Or3NL59Ih/QzPaNzMhMOm9t
         ohqG6W8zfLaU37b7xRk9uzWyp3U5udPUJDOpEVhtCwtDTj0mwqykPlMb05M5/V4SPUBw
         wMAfZCtF32dlDoqldHRqseXBORaTdgPB/m0tCXBvgxmjJQzH1WzSuubkxlk9B5qtDAx6
         MsW92oo+udiz7K0iqEy5VlLFq5l8pCvCUSToUdHmCmrxSaFgfbV9MyDAPPLfUpgBHtSw
         1zdfAI3JYA8iyvpUWvyKJ4IhcUZpt179VV5I0Xr5okiVGmFRwWAbWLfPCYlJB+X9lfz1
         Vmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712183495; x=1712788295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH63Wj4aYXN7kae3y+ikS2p78PQsFgI7iiixaCrlIVk=;
        b=KbDWFAEHWOHeOMyuUNnC8ov0LQWJzGN7vgUB2p0vOsNv3lgsUgEBk5SnLVWMqHJ5Ep
         fglLQlgehyaVYBRPbclyQ9j6zYa/sn+xkCzdwsdjaMdL6yvLy2gQFPU9Oo1iW17c4CGO
         I41BRB3Qo7f5IkuVQZtRDlmHXObFAtOq0WRYBIASzh97MjoZ+lUl3awFSOzafj/a+k9O
         XI7uqXL5HV1JKEylW2eHTqF228J49+GP/5pu2jMkZRO8M7FO1Oq6ySnUlFqSwP8cTdBu
         +bnBDaWZTI51+lfkaiXLzSlLuZK+nQaMFs384vWLmJMH3gcggfwKO0pjqlP+1iyLD7Jc
         Vu/w==
X-Forwarded-Encrypted: i=1; AJvYcCUL27+hAkpMGJnxzZCZzU1Qw6N64OrTgHUCqvYvAcfEJnkMoPLKHbuQj+qMtZtM13E6hLRp8G+JIDT+D20iMf/R5tGFLeZBthNAPZPF
X-Gm-Message-State: AOJu0YwwAuz6rEr6RuhpnJO+iN3nEFKsn5Vr6GOp7cw75j+yE79OYFnJ
	rJS5cwFU2QLaUOK6FJUhY/jEQYya/sEdmzg01GR1snbUKQePKgqLSskADmCs8icYR8jVqJBIZQ7
	nOtkYT4oKd966fBqhxFfKxRIYUHLalxdEZFb/JpKPgcbmO+6kMA==
X-Google-Smtp-Source: AGHT+IFmcizi6Omv1Y1ictRXuc7fO8m0PbYuI8fB3NEQayH//0uZR3axbmuT0evljdV2eohQhvgUjUg9e6TWHNd1xjo=
X-Received: by 2002:a25:3146:0:b0:dc7:32ea:c89f with SMTP id
 x67-20020a253146000000b00dc732eac89fmr815830ybx.15.1712183495036; Wed, 03 Apr
 2024 15:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402180933.1663992-1-surenb@google.com> <20240402180933.1663992-2-surenb@google.com>
 <20240403145719.547d1083fede2cb4ca2c41ef@linux-foundation.org>
In-Reply-To: <20240403145719.547d1083fede2cb4ca2c41ef@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Apr 2024 15:31:16 -0700
Message-ID: <CAJuCfpGMDz7jKCLTVFZZB+XVAb9jfK79C1kNa7-BsYGDT7hj3w@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: do limited memory accounting for modules with ARCH_NEEDS_WEAK_PER_CPU
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:57=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Tue,  2 Apr 2024 11:09:33 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > ARCH_NEEDS_WEAK_PER_CPU does not allow percpu variable definitions insi=
de
> > a function, therefore memory allocation profiling can't use it. This
> > definition is used only for modules, so we still can account core kerne=
l
> > allocations and for modules we can do limited allocation accounting by
> > charging all of them to a single counter. This is not ideal but better
>
> I'll queue this as a to-be-squashed fix against "lib: add allocation
> tagging support for memory allocation profiling", OK?

Yes, that would be ideal. Thank you!

