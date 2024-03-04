Return-Path: <linux-kernel+bounces-91402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267378710FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268621C221A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2F7C6E3;
	Mon,  4 Mar 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M8pq/eUN"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016131E4A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594474; cv=none; b=WuoZBn7+fTzkJisoB8SP0A4zHsZNeU+AVzdoDriydtan6/TOl9iXczc19QKWKDvfJ/5hf7oku8OwmAv55aK32gS6KQwGfZInTokx7qzfzwlLiBBvJtrre3NmbcaQW7/BTx/04OGXuCUjTvEFod1K57Jdh+iTlXL8b3Yq12AnPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594474; c=relaxed/simple;
	bh=L8wre41DKSFxRx1jDCxqg2DDV/BFGY6G8DQ0Y942V+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+gjIrR/27LSpXITB3JmBRwRVMQzY48vZMyJYZGjCYUvt9ibLsF1XXSPGpJY197wgIaijPBk+exzSYLGLQTivyczIF5ui2WceDCf2x5HbPAGTGC8MxXKmuzucHISyPg2U1IAADsQc9jTTAaFK3kgUA/rgKFsOWIbVXL9tJ9Gn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M8pq/eUN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44628725e3so640429866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 15:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709594470; x=1710199270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfyiMDu4k9WJyJDcAdOCLHKLoRNRZ0hT5SNlHLbFleA=;
        b=M8pq/eUN8gLP0duLV3YA+XUI9rGrTBjs2ts8TXLbt9oXdpTQfUFMpA2GucHKBwjg+U
         lLUgJU092FA/C9ByO8CsGWJWy+cWt8QoCjSJrHoei075s/lLEAvXN79fhMts931adnVb
         t0UTIXPSD/H7MFU0RBwqH8lT/QQMXCmhub8Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709594470; x=1710199270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfyiMDu4k9WJyJDcAdOCLHKLoRNRZ0hT5SNlHLbFleA=;
        b=PTdiwp3/lR1hgZCEyJda1z34j7rfTH6MwXjDojUPZD2GEF/gPkYJLo4t7yasmjUgZi
         J7jd4kaYO9f45BUmee0rZTBBVB9BXkTsyezDoUjoZRs/4DswRKQRKZkjPEVwY7gr56Vb
         Ixuqz3kpA+Wb9ATshbiq4Nbw1957xytEWMOsmwPUAVFjOxGKZ9uAWrD5kPyzfqlKKOgP
         ZyhuORDDfrJ6JzWAlhnw4BuJBMq3EWkgZJBbkP88zoQQCoJUHcL4csdR0RN2Vl8BjUoY
         UseOiVUay6MODjGb2JFXn4lkrkaMM7xYB/+uQjYj3aSRnwU+gNxigcfcLTeG15RHB8BQ
         upVg==
X-Gm-Message-State: AOJu0YyWVOk/GXD/TDYGfVO+NDl+bLw1ETe3UkeUUu0vh6O6U8j2Z8my
	TSol4zon21Ge5ENJITJ/gehzXHEYj3mFqVAd4jH2dHQC/IIdj990hv8kAUCGYd16axQMb54C4D9
	GiKE=
X-Google-Smtp-Source: AGHT+IERlzFlJ952VFRy4fiFu0IQXNKYxsxPovQ0xVmOWpadK1xVpwcL2B9DZg3mAUmaVgmox4/8/Q==
X-Received: by 2002:a17:906:c30e:b0:a44:deba:2e8 with SMTP id s14-20020a170906c30e00b00a44deba02e8mr4875032ejz.69.1709594470014;
        Mon, 04 Mar 2024 15:21:10 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906070e00b00a4582d12253sm831808ejb.25.2024.03.04.15.21.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 15:21:09 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44665605f3so536844366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 15:21:09 -0800 (PST)
X-Received: by 2002:a17:906:aa0e:b0:a45:4ba5:2917 with SMTP id
 ko14-20020a170906aa0e00b00a454ba52917mr2701230ejb.75.1709594468963; Mon, 04
 Mar 2024 15:21:08 -0800 (PST)
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
 <CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com> <20240304171034.08d037aa@gandalf.local.home>
In-Reply-To: <20240304171034.08d037aa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 15:20:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
Message-ID: <CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 14:08, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Fine, I'll just remove the precision as that's not needed. There was no
> other overflows involved here.

I really want you to add the size check on the trace buffer *creation* side.

I don't understand why you refuse to accept the fact that the
precision warning found a PROBLEM.

And no, the fix was never to paper over the problem by limiting the
precision field. Hiding a problem isn't fixing it.

And no, the fix was also never to chop up the printing of the string
in smaller pieces to hide paper over the precision field. Again,
hiding a problem isn't fixing it.

And finally, NO, the fix was also never to add extra debug code to see
that there was a NUL character there.

The fix was *always* to simply not accept insanely long strings in the
first place, and make sure that the field was correctly *set*.

IOW, at *creation* time the code needed a proper check for length
(which obviously indirectly includes checking for the terminating NUL
character at that point).

Why do these threads with you always have to end up this long? Why do
I Nhave to explain every single step of the way that you need to *FIX*
the problem, not try to hide it with new extra code.

                  Linus

