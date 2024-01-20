Return-Path: <linux-kernel+bounces-31842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C00833560
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BDE1F22929
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB87EBF;
	Sat, 20 Jan 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FN6ejpF+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E111718
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705768833; cv=none; b=HOQp0an+ng9g4JMQ335sr3CmCMJHrAXPAghHqS16lRTo7B5chlGZwURSdDLlDdlNwwVvs6LGACVeO2AYJasaHMYUmqpHNV0hRSVWJ4YrxwvEI+PqctPiBUvEzL7ftwg4H72P72fRLDEkPXwBpWZHWWS4IW48h+9QjVpITcXpS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705768833; c=relaxed/simple;
	bh=YB/JxYQ/pIR3ToqU03uuFdu3N6gqG3VeZ/Otmp/LweM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkcr0gik5EQWokPnHWM+GsuHOUg+FTEUsiMGw0de1RIvZINWNUutSlMGWh2zLX/TPJtOzmCa9xO3San1FJ+ihm3x30BZ+DTzQlMbfL9lIczopONwMW97xIJ/oscmgKtAkAOJCTIPI0ueVyJF1BayZ+Ra916ZBN7udxuza+/7xvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FN6ejpF+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd64022164so26218431fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705768828; x=1706373628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKz6ORL5rgrlrEyJEOMpjmvWzW5nRmmd6FHj6yauGbM=;
        b=FN6ejpF+L9dgp8KND9TPj9npiH5QvdRHTOcEDMd34HWarnbpQz9xYHsVXnlDhFcx4v
         iBDv8ajaxN3O5jk2TTpeeeEVN9REF4FjhfpHCaNo0nJkElHIwnH6/UEKJFfPH7mdZIwE
         bgCZgnT+GENXeGZl3tlAIZa+ulnTJEYHUvIsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705768828; x=1706373628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKz6ORL5rgrlrEyJEOMpjmvWzW5nRmmd6FHj6yauGbM=;
        b=K/nvXSgdv7S3JmRLQJKgPlFdblbA5qJwcExBxlFIfrh+ErWbnJzeAQNDsnaGYL3oim
         RFn2kfmDy+dUBWj+Ml5R+ZuZWdsWgGuoFSE/PQ3EMlw7U8GoapWsoZYmj2isKim87lbJ
         Johq3es4CCRYIEIyWZzZde1lAVyY16gXQMl8TM9AX1JZVt+9M/WVskb9kLfxoIFhTfNU
         aSTwu2dqiLFApXHE5QAXaLYd/NbrmhXu8cG+l+B91wYDeb9NsK+CKuf3HSJ9wtgdtOjF
         Ob1jyQbr1qsFJpYEh2t3aFumKSD4hAtrZBj9ZhSDvPST5wzurW9b1o5aWjXvuvevpx96
         Y7Cw==
X-Gm-Message-State: AOJu0Yz5pWZ/wMLGWtLnaz41NHhT6NuHax8nWWQvnG5yCSydd6WN7uJ+
	64V2kqkANpjaW/9fjjrziYdQgbN0a3lxyiHbi/97oRH/qEFEmxNNxMYtF6JiNR8e211Ns0Iuh3q
	BNCa0Ow==
X-Google-Smtp-Source: AGHT+IFBhiKHLfhqhAo+Ajpiyl3MvAUmzevsBWF2y8fQyaO8o7k6bzzHXUSHt+8QKbk1g1lwNXifsw==
X-Received: by 2002:a05:6512:558:b0:50e:44a5:57b0 with SMTP id h24-20020a056512055800b0050e44a557b0mr605594lfl.121.1705768828378;
        Sat, 20 Jan 2024 08:40:28 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id wk18-20020a170907055200b00a2808ee8ab1sm11528280ejb.150.2024.01.20.08.40.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 08:40:27 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a6833c21eso1183729a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 08:40:27 -0800 (PST)
X-Received: by 2002:a50:8d56:0:b0:558:d206:3bba with SMTP id
 t22-20020a508d56000000b00558d2063bbamr704311edt.20.1705768827089; Sat, 20 Jan
 2024 08:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
 <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
 <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com> <78111.1705764224@cvs.openbsd.org>
In-Reply-To: <78111.1705764224@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 08:40:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Message-ID: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> There is an one large difference remainig between mimmutable() and mseal(),
> which is how other system calls behave.
>
> We return EPERM for failures in all the system calls that fail upon
> immutable memory (since Oct 2022).
>
> You are returning EACESS.
>
> Before it is too late, do you want to reconsider that return value, or
> do you have a justification for the choice?

I don't think there's any real reason for the difference.

Jeff - mind changing the EACESS to EPERM, and we'll have something
that is more-or-less compatible between Linux and OpenBSD?

             Linus

