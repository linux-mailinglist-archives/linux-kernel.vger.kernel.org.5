Return-Path: <linux-kernel+bounces-130660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F288897B20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A5F2861E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96818156890;
	Wed,  3 Apr 2024 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IVSAQ5V"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C0156881
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712181598; cv=none; b=KNpAYAR4qnKd6kDFrVnkQH2+1t1ANxHp5H5Y8n5sw4++BwQ+dr/0cvAmlxxUfCaLuCG3qG/OZafq/vZTRl74pLst2Uk1ryQH2CLQ/5HwNgjM/VOrDBYey26mbQ3R3acX1OI7y7uJfTty12T04faU7Zquzqe3JBLEPpa0yTv/1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712181598; c=relaxed/simple;
	bh=J5cX4GqktbP0gID6yrJUxK/jCIdoAH/C/9xsI+yoDaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOhXXT2T9PUaUtUGQ2BizS1gqDmkcxdWpo7nhHb7o/dSyyegDpO42LIXk5+cTiySsVaIC3UBx3Oz99kINT2qy11GzpnjK67mNJYFCPAJodDVkN6zLVrKO/xbEsgh7Fqi25i3UtKOJ3Tlf2HNGW8FAUudywuG0y8lhcIkBwtjn9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IVSAQ5V; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso1656a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712181596; x=1712786396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTy7UZvOGfVzOyBfYCslewqivjbuSdMwhgF1qVbAn0c=;
        b=1IVSAQ5VFCMovnIRk+cGRDEWfEwK8iC+gQ7wq77X+DWJ0/O2F+rIzuAntdOROFV6/0
         HJpsjnAi48P5hBCYkokapjSLIfKYCWjnOXInpr9XMOdvfywFsmFTfGFD76Dn+UVJu/Mp
         N50VbviqV4I5DbiL85StfH0HJZSigFzPSTmOuEiGPo+9Hihzs+mV+p4FxoTrFwwAa5fM
         QKTseOEsSNws8Uyu7rYlHWAliAkPdRuYQHpxN3bRdsbzh7Sas3yu724Hf21HYGcDKg50
         vnABWme91nBIqMKfrb2vv+MEOu1YZpUmXU4v1CeFeJguRg/UyredijICSKOvoMJIXmI3
         pz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712181596; x=1712786396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTy7UZvOGfVzOyBfYCslewqivjbuSdMwhgF1qVbAn0c=;
        b=pe1GfKEwcfxSdu0Jg/yBvgJ7eQMIAFpchAmXysGO1/+nNG5ESTc2zkh6ZXJYA7nQBO
         AS7AaEMTwGd5LP+ErTDYacdo7O5bPZX4hvFQTBGNoNAb62bW9NArEJsxPXv7H2mnCukE
         CQhdLrI2TzvsvjMewgJeakFfHislPytdPhC6vlvM03fSBfD3L02I/whyV/hEm08S3n4I
         gQ+mw8U5nJ30k6aXJ6xXJ1uwtQEzZFpIo1Tn14qbyyHE06QQZAVVi5hRYhkj6t8fCunD
         YKdoAJ0dGqtR1fO+CHZeZQq3ou/8kptdXQrfJnYXYT5Ms9HXZNjxmyWsN6gMMnJz6WzP
         f6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm2PcI3C16Bm12nkwLXMRp0rF3qkf93+scsbr3AZFBY/7Utpv6nFhO01ylbbNKUONjspdqSL/gNGL1krZk1ksQiJOUrfhcFJlZHTjz
X-Gm-Message-State: AOJu0YwTswj67/RQ26jkmT/AvJoM+kOCo2C5l/QeOkCXInIxFL3Cafje
	3oBZXsMdmV9bLgG9XI4MvfvcNyaeM3MfLCxeW9Bx0a5altuH1UqJzuyzAdgo4AP+AfZUUAxjWU4
	mRrbzKydbhvDUxtmBH2FGQ11yDoC5mqdQ5jLa
X-Google-Smtp-Source: AGHT+IHTInqBsj+mNZa49X8OvTOGw8WohoVAZbNq1Rfczn2ElBMyortTXet/IJD1sZ4waCx5tYiTp/gANpZfOjPunrg=
X-Received: by 2002:aa7:cfd7:0:b0:56c:522f:6799 with SMTP id
 r23-20020aa7cfd7000000b0056c522f6799mr278607edy.5.1712181595529; Wed, 03 Apr
 2024 14:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402125109.1251232-1-jackmanb@google.com>
In-Reply-To: <20240402125109.1251232-1-jackmanb@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 3 Apr 2024 14:59:43 -0700
Message-ID: <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Clarify test filter format
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:51=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> It seems obvious once you know, but at first I didn't realise that the
> suite name is part of this format. Document it and add some examples.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!

I agree with your comment on v1, I think the extra verbosity is fine.
It's still easy to read and this should hopefully eliminate the
ambiguity for most readers.

> ---
> v1->v2: Expanded to clarify that suite_glob and test_glob are two separat=
e
>         patterns. Also made some other trivial changes to formatting etc.

<snip>

