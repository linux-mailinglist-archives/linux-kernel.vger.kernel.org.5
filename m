Return-Path: <linux-kernel+bounces-108148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991838806AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB231C22018
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD493FBB3;
	Tue, 19 Mar 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OjARSyXE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD93FB9F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883369; cv=none; b=FfR/MvadFmP5UfGct6WAyRqKNGV/iKAS8oaS+QeJDDgGPh6fLaR+sr6iklP3GTem7UxOLHNTbqgUuiVyN4bxPJDo9eW9XjDR1ty0qhYtjHacWVGWDKmprcWJYR3GeW7SinUqSCNo4jzc+vJvUt4NYGXFflSu0QDqxX8CoVVIga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883369; c=relaxed/simple;
	bh=n2jzBsLQ0Wrm2lIftzl5WyhbTaPYcftIWZRzrou++fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS+4EqlS5mik5JFUxH1iccc13cIrDK/VyR6HUuAtcOg2LkVZ6c0PD5AtuIHHaXs7gM+84woIYSHewTR8wFhilmMe7jfHSju5apWH6YMfPfBFhdviSewAV/SgkJwbShDbS46WLQaw2saoJercVFO6ty5JRcjfy/ljmvou6CBIaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OjARSyXE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso2827821a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710883365; x=1711488165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A3mbW0Axndl0DdAfMvicFiRl5fwsj7RLVMqVJZ+vdSI=;
        b=OjARSyXEodyQySvh+M4gMeMHgwoYph9ey/+t4OYJqY9VVb9bm4VxduxeFKFnM8VBiS
         ElOKbtWsC3YwhZ09Wte5cAYe1Q6mNhtIQn9wMIFnt8BiFdxWCwpOznQ8IzJ6tCVMHr2v
         WuoerfZRG5JK4wbxTCji55WX7g/5RDeBtJ3SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883365; x=1711488165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3mbW0Axndl0DdAfMvicFiRl5fwsj7RLVMqVJZ+vdSI=;
        b=B6AaxpvylP6yg8Yr8gVQDyqRPZ839LhQqRyUVSIHmqNwCBE0n5Nn/T3+zw4yTNAD0W
         aJqHuZ1vVWIWkQlMtSgTGC2Ba6KUdN9CPe1VQsqqLeuF9Z488UKlABXi255u5k8mMUsu
         KR0DiJHm84fY4+lm5d90S9np0D+JcDFjR+7Nwy6HUXuyDu1sQEnnivNfGiODM+z8f+bU
         BoTJm4+/E85TSyXnH5/bwvUlmpdTK6BGP1GG5WIEg0otYrfbtfl0548/EY78m/BwVant
         qVT/7209KISC4M429ugB84z08OQ1Q6WIgIaJJfDwZrWRZidM4TzD3IMO4o9jVEmOUBOG
         zZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj/HKbuJd/qJBk39q4l2LFhYNIyiui5JnSJqApbn22QpizXXrDsrWKER+EMeKNCT54JMKO4Bh2gKai7W3b7CfSnO4QJU4y1VTpofox
X-Gm-Message-State: AOJu0YxLIffXVuUe/5n7tMgifMBvV0rB/kexhmtcJcdn3rZ/tWPFu6as
	nuStRqjT9zr5Hs2nM4jjhHls7sRfDNfYumJKBtd74+K7QzUyZ7UeHJjq2UTfm1W52KajLTtwBQ8
	h8yxGCw==
X-Google-Smtp-Source: AGHT+IHzgy7iooZ5nZm03gaHqGQlvPeoFmMdD/Uc45CfajlzAgb4ROohEgScgty6x5EPFCh0fhnQ5w==
X-Received: by 2002:a17:906:8417:b0:a46:be37:2685 with SMTP id n23-20020a170906841700b00a46be372685mr64105ejx.19.1710883365646;
        Tue, 19 Mar 2024 14:22:45 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709067f1a00b00a46a643b6fbsm4415832ejr.15.2024.03.19.14.22.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 14:22:44 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a45f257b81fso793946766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:22:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIWA1P6RU17LmRFWTyC56kjiy9H9vDU19sk7p3Ew/W9ltHJGvZIGQ2y4ZpE22xoRuLX/YlqaiaT2Sfhp6tKG54GGZbziT7kAO0TaBA
X-Received: by 2002:a17:906:f110:b0:a46:eab0:953b with SMTP id
 gv16-20020a170906f11000b00a46eab0953bmr60957ejb.23.1710883363785; Tue, 19 Mar
 2024 14:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318113053.7f87ce7f@gandalf.local.home> <CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
 <20240319130653.0cfdaf6e@gandalf.local.home> <20240319131333.504c93fc@gandalf.local.home>
 <20240319210329.GA742040@dev-arch.thelio-3990X>
In-Reply-To: <20240319210329.GA742040@dev-arch.thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 Mar 2024 14:22:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJH_k5+h=3TOvLsGN-FOBNfLh_Ln_bZRLQV-oe9Gc5tw@mail.gmail.com>
Message-ID: <CAHk-=wjJH_k5+h=3TOvLsGN-FOBNfLh_Ln_bZRLQV-oe9Gc5tw@mail.gmail.com>
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alison Schofield <alison.schofield@intel.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Huang Yiwei <quic_hyiwei@quicinc.com>, John Garry <john.g.garry@oracle.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Thorsten Blum <thorsten.blum@toblux.com>, 
	Vincent Donnefort <vdonnefort@google.com>, linke li <lilinke99@qq.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 14:03, Nathan Chancellor <nathan@kernel.org> wrote:
>
> For what it's worth, I applied that change and built ARCH=x86_64
> defconfig with LLVM 18.1.1 from [1] but it does not appear to help the
> instances of -Wstring-compare; in fact, it adds some additional warnings
> that I have not seen before. I have attached the full build log.

Hmm. I'm no longer seeing any problems with commit 24f5bb9f24ad
("tracing: Just use strcmp() for testing __string() and __assign_str()
match").

But that's clang 17.0.6.

The patch that Steven sent out (and that I applied) is a bit different
from his "I'll change it to this" email, though. A couple of casts and
parentheses different.

So maybe current -git works for you?

              Linus

