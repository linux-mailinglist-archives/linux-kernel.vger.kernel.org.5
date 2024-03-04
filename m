Return-Path: <linux-kernel+bounces-91329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D538870F12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EF61C23998
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A846BA0;
	Mon,  4 Mar 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T03ece2d"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE51EB5A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589034; cv=none; b=PWWNVJrhr5eUn2sJWc9LGGygSh10zBwhWvL8IvgnkV6upTkescwaZJkTGxD5Ua//khTouwPRXGgJAbM0R7ILzE4C1njIyE9Z+fAgw1UjWLDboY8Tegdp5EICPmTXWTNtOWdBL9fqomScbS8LJVg8N2lhb4RKsv58npB+k4OilJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589034; c=relaxed/simple;
	bh=bKYPgpFCbSl2NydzosXHHWUI+moPSjodsNs3QOvUJ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBRE/wz+DLLMVR3dvhHVn6t2KWLSXz3T1CB5jCemY5f++hlNlQczj2Rxk3p13ZfEwhX0fRx+asGNP+pGHl9MlfSfMMsYSfsGB7ujhY8Qao/QG5S/tRDRmSv9JEBGfND6o7A5OR7yiCkCty6JOrcWxupAgmkDDPfmVVA5AhuIEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T03ece2d; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b3b04995so3716716e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709589031; x=1710193831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IkcAw0ofkPUvRZUJ8G0b0hx/gIDaFjT663GLHM5RzmQ=;
        b=T03ece2dKs/6tTECXOict21Kl7OrRqwW9FsD/erafY0+kwytNTMT4SOs39tqwMxRR/
         jR2cy+ur5ZrAwkgNDbWo5usAbnpmBymqw8zNo+Sr//doHpwe5v51R7fCILfW24cNLdGU
         lIaTW4rbNEqjENfuR5chU+qy82l6Evr5E0q0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709589031; x=1710193831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkcAw0ofkPUvRZUJ8G0b0hx/gIDaFjT663GLHM5RzmQ=;
        b=RA6WNYW8UkqpiTa6iwA3sGHlG9s5T7xqvFSTDTECJ+fB9PRse0r0XiieF8YVPZUpM7
         FyPn1q3YC5HsT3pgmva2TRCavVXL39gsb/GpEjNALBWy03+heTSKVDGsaUDoHabnGtzz
         0RlmCyntIa22/DsY0Q7wpOxkMFr7zpDx0I2dVSAZTgjdvn+lgBOFVYBKRlMyDhaAo1ic
         Li7pB5xMBOQClQhG7NBZA68+q1ev3O4O1RDWmn25P2QdjCHquuqIFi7B5OF0+bdLKPwK
         1xqYJtjoRTONaKjBzv2xi22y8CU9ZgbxKRmExc6N2n56HLKchoFvTOayKZ0y0ELfpDSZ
         mMew==
X-Gm-Message-State: AOJu0Yyoi9rQnyQmk1lKDYzxNNkxoMwLqgIt1aNPHd/DV1RmMVbKEtaT
	gy3nK9JjqzEGcuIvycEepEGD8E7hjL3HmlFKVpSuJqnjZ8BcWeK0onzhSZa2uzxql7n0pCRaOsQ
	865kOLA==
X-Google-Smtp-Source: AGHT+IFUhiWcXN9bU2ND/K0giYKCFQZzaN5zZxIHxrwi6uP30HK/Z2BvPyqYySemNdXUTpkAxDwohQ==
X-Received: by 2002:ac2:5511:0:b0:512:fded:e674 with SMTP id j17-20020ac25511000000b00512fdede674mr20886lfk.61.1709589031039;
        Mon, 04 Mar 2024 13:50:31 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906085b00b00a44ef54b6b6sm2905535ejd.58.2024.03.04.13.50.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:50:30 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44628725e3so632807266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:50:30 -0800 (PST)
X-Received: by 2002:a17:906:d0d4:b0:a45:22e2:bd6 with SMTP id
 bq20-20020a170906d0d400b00a4522e20bd6mr3503408ejb.23.1709589029913; Mon, 04
 Mar 2024 13:50:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302111244.3a1674be@gandalf.local.home> <CAHk-=wj376WMgZ24wKGEWDs_ojNtod-LDZBedPzDYRRcY60UYA@mail.gmail.com>
 <20240302145958.05aabdd2@rorschach.local.home> <CAHk-=wgjhdRj1V847NTF4veMN_tCbrySiEHXO8RO3n05cNeXeA@mail.gmail.com>
 <20240302154713.71e29402@rorschach.local.home> <CAHk-=wioeo5vyEWUZcGBKMsf3jnjrnnHc3uJiV=JjSKPdvZOEw@mail.gmail.com>
 <20240303075937.36fc6043@rorschach.local.home> <CAHk-=wiLdWetJgKHB72VeDALZsjpggEyyuiZ2KmoY_g+3horwQ@mail.gmail.com>
 <20240303140705.0f655e36@rorschach.local.home> <CAHk-=wiTGmAXfHiRB8ku4diLxRpN=Hac_q86=j65oiP3J5uXKg@mail.gmail.com>
 <20240303160024.458d4f91@rorschach.local.home> <20240304164205.3245608a@gandalf.local.home>
In-Reply-To: <20240304164205.3245608a@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 13:50:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
Message-ID: <CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 13:40, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> As I mentioned that the design is based on that the allocated buffer size is
> the string length rounded up to the word size, all I need to do is to make
> sure that there's a nul terminating byte within the last word of the
> allocated buffer. Then "%s" is all I need.

Please don't add pointless code that helps nothing.

> Would this work for you?

No. This code only adds debug code, and doesn't actually improve anything.

We *have* debug code already. Things like KASAN already find array
overruns, and your ex-tempore debug code adds zero actual value.

That, btw, is why your old stupid precision code was not only
triggering warnings, but was ACTIVELY DETRIMENTAL.

All that precision code could ever do was to potentially hide bugs if
the string wasn't NUL-terminated.

So no. I absolutely do NOT want you to write more code to hide bugs or
do half-arsed checking.

I want you to *simplify* the code, and put proper limits in place for strings.

I want to see the code that actually notices when somebody generates a
crazy string, and stops that garbage in its tracks.

What I do *not* want to see is more ad-hoc code that tries to deal
with the symptoms of you not having done so.

                 Linus

