Return-Path: <linux-kernel+bounces-126274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D789349D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FFD1C20473
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0307B15FA66;
	Sun, 31 Mar 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ft0qMpZG"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226814A4D8;
	Sun, 31 Mar 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903429; cv=pass; b=SvjIyddp0btRcvwlpucA+LzEpJ/+/2Pyrf6kaoK3kAhmEo93QL0M1Od0CnEz9HgVQsKaVak+42vaY09IEq61evgZ/rx7Oy/Kh7Tg9HYb42Q4dAOJNdI8OJaYNTSRoULd06j8/SwpiTBnVT4Svr7z5MJmhjk6u8U0Gpbf3Mgb3E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903429; c=relaxed/simple;
	bh=U43Wuq55vMxCLBzqGRdkR/mMGx+zO2GmUgWVZu6Gawg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbpUM4u9MWori+3Z9/89dh3BkdybqHf2DfYSBITk2KbCi0omMB+jO47vrQsw3jO3QeGuVzvJ9CjwJoc//ZSubfS4mDZPQOYi3ieJXJ6SiyTaxsKeIM0o7zzJwgY7E/uJs5irETrwEzrDVTJQ2GC0SLhKtLx+ZY462H8wqDsqiU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=fail smtp.mailfrom=linux-foundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ft0qMpZG; arc=none smtp.client-ip=209.85.167.52; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 55E74208D7;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ylLn7vdyrTRC; Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A3F03208D1;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A3F03208D1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 972D5800061;
	Sun, 31 Mar 2024 18:43:44 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:24 +0000
X-sender: <linux-kernel+bounces-125901-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAsGUFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAEcAAADligAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 12931
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125901-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 49D7F20764
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837947; cv=none; b=l77b8FAmwJ8Y8V69wffkCvCFVgIbXNyD9D+KiXjKsaajQzhtMiSZh018iDhqaIb9s8MJeW44fHVNxLZLN2WcMjRahR5Ly/fg6UvtYYZGLJj4Rf5QX4zSmgKr0fmjfbfUsDmzib4zdYpvdQ4mgJNLvK1RTa7cDu6tdZPcfO+JDeg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837947; c=relaxed/simple;
	bh=U43Wuq55vMxCLBzqGRdkR/mMGx+zO2GmUgWVZu6Gawg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC2kKYr7hZxlvL4KY6eIEyVXE7a7fBRrGhPrDC0/4KsNGWlhsMhIj4cXEGurZOT0YSKrAxzHJWIz9Vk7XbeQZguP+jmFM20dS23QbMdlZHlCeFtpqxpfuheSfe6YkBVGB1lsv0z3cmlb1gvf8abB75czUYTMAg6dXTIlGZM4UfQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ft0qMpZG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711837944; x=1712442744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh7m7AzKE9zxgcmaZLpWEMMQFO2AQlI5WB3LlhW1I44=;
        b=Ft0qMpZGU9No1lDtNY6m+QEK9VUB3iCBlXDau5eoyGUjPfc6s69wYnViDKOvrtDhts
         4cteyZ0It7eEa6xzoND8JiNqN5EYI1zb+xyCXMFw7oyiXZJ0e159qI4flnyp2Dpvbz+y
         8Jle660pX/0lAxvng8Eu5kDc0+bfz5sKol1pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711837944; x=1712442744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qh7m7AzKE9zxgcmaZLpWEMMQFO2AQlI5WB3LlhW1I44=;
        b=lfEMUAM+dMfzcY41f91KYBX547+RMogvPRR0PjQthWIlWhVSHWzIbwu7sEvxNquojo
         LB9IdfqF7Sm8FICm+WmB0pCA4jmHGzgIViUkkm15cPbsACrO/Rzo5Ja4vMs5oNhVcgk4
         MkJO/+y/904AjaDmotytwZxTZYGjgskf/j7JctLiERKKeT6mWpapV9SWD0H5wQZZb3k7
         HOoUrseuSrH/0v6ScKt5HBJWm+BiD7Ck1JaRNkxYirwQYQrQLNGH8/h0UNxHsCFv5eGP
         IS/GcKEr7g5izm/yG0edogzyieh653U0f9kVQKXlzLaTIVqtVBE4TCOvy6jxqr1H/eMH
         ev9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgHYXXaMb6fNrOJJkuIza8qYpc1wrqXuou0RBLd9Do6Wm6uoSeDMn5CZg335KAstRhbrKrj9lW9iFwGMP6S3Kt/FUIil/G0L/oEC+Z
X-Gm-Message-State: AOJu0YzLZA9EfTj3MVzMmppFC5ocFfs2cesfB3JMWxpoPSgYJbsMrUBq
	Ui28Vf1vt9y7O8yuAVV004t7K0Hb13QJkre3vxhFl5oFMRgoG9iI/yjP/HVDzEP9wcoG+G8rh+u
	O7B0=
X-Google-Smtp-Source: AGHT+IHoEYY8SM7e1gU0DYFywT6hL16F+O6qLec/790twgFmLR5wjHT0zheJNExGWw5wy0xsQ6bvtA==
X-Received: by 2002:a05:6512:2389:b0:515:be10:e288 with SMTP id c9-20020a056512238900b00515be10e288mr5056125lfv.21.1711837943767;
        Sat, 30 Mar 2024 15:32:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpZgzHfgiD06oGxEh+SAIJtRDeaSVAgKt6Q0rmso6FMfCAg/o+v5pJRZERHqSsk56AxUVqxa6akcQBhVuIML+7SL24kKzphr39Qi2L
X-Received: by 2002:a19:5517:0:b0:515:90e5:4555 with SMTP id
 n23-20020a195517000000b0051590e54555mr3507469lfe.16.1711837942133; Sat, 30
 Mar 2024 15:32:22 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143838.15076-1-jarkko@kernel.org>
In-Reply-To: <20240326143838.15076-1-jarkko@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Mar 2024 15:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
Message-ID: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, 26 Mar 2024 at 07:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.9-rc2

So I haven't pulled this, because the subject line (and tag name)
talks about tpmdd, but this is clearly about key handling.

Also, the actual contents seem to be very much an "update", not fixes.
And it doesn't seem to be an actual improvement, in how it now does
things from interrupts. That seems to be going backward rather than
forward.

            Linus


