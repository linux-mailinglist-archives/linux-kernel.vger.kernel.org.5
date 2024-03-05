Return-Path: <linux-kernel+bounces-91441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34B7871184
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CD52850C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F112579;
	Tue,  5 Mar 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kb3JD2ii"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87363D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597857; cv=none; b=bryxynpageE71tA+Bf2bppoTc4xZrxu7X2/JvNch2iIVa0UE9DxM0lMwdNc6p5vVLQOBG/IMRNIUlOGSwZDRuPh1Z5jY9Zis1+an6Xa580W7yeMv61THfeoqeh102lzPLZedPM4wvUIYwz2TtmNt8xGe0B708kOg7B8FjNWhCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597857; c=relaxed/simple;
	bh=EGdt9lHTEjDMZR1HMzL2el49l+RGwZsoTUfjQ6aH4DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu+Vm2+rzKwaHst/UFF5fY6qdJTpXr4wSeFGRLgMDAuGYef4tF1UYWaG8gWMgR5vJmqG1iDVTvZycEFLrhoAq6H2fnVUgq8HMHdLEm8NmEYbhdsLncAdBSYXrTPzPb8h9J3JExrREqNUXF8FsIPD4uiB+n1M3Bg/77+qRQelvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kb3JD2ii; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d275e63590so72943951fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709597853; x=1710202653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=04RFNLETldESkGJGwcG8LM1lX28hFKdyu6jyBc5NNUg=;
        b=Kb3JD2ii6BL1wVJ8B0eoLy0j3xwYHYDhQQKII09NHYl0/cE+wg8tlrM2PYrWfKr7ZW
         t2u3NSB4R6Mm+p9CRbZP9AeGa7Pf/tuRm9jSyu17NbfvK07fkBEdu9pkeR1b4ucU4mha
         DuMNdFAuPSFGIfjMS34DmchutKR3XznsvBrzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709597853; x=1710202653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04RFNLETldESkGJGwcG8LM1lX28hFKdyu6jyBc5NNUg=;
        b=N1JvhtQK3zS697pQl4LRiEU9u3NqhBVvB5lmRgWbHrpLtiIaNmjg8Fx2/Ma6Jy6Gl6
         RSW3ZHJM26UvAZb7jjoeL/IOCrhRrYi1mpkYBJAfioHltAkDam9xIYTcASSmQM0VeDZb
         tg+1eqdl6iIwdzccjJ70RzrNc7jyulTfb3ajJXQYfnJE+TXhv+wbNw7wcPdXyuMW7OIt
         OaB5PyDFmR9fTdD0cJ4KvFYuujuzSRbJSa4wgE3tTYv0IbO5qk3/GhLS5ORFeDo3JMws
         rXNMRXZUJK/M0m7cUVQY3ouvHdaAM+RWXwZozyipd8paenxjYSS0uXoG18vfRs/WN/F5
         k5Dg==
X-Gm-Message-State: AOJu0YxtF+yeFdmi5L5rzezVqbr6RhdMHwzaT3pCEHjRoyoLBZp8mhW6
	7GmVXMGHHeqiTnPif4h6US2jo3thsJzkWtDeI95oD75KwSAmZAFqj2fF3n3RmZC/CPl7PSwJGvg
	UOvQ=
X-Google-Smtp-Source: AGHT+IEXTOqSwNo7t8edbmirFg7XmqOtY/3OQ+SftBDNP5nadb9K1Qi2SkhdZlGNuBl7HF3eqoSP7A==
X-Received: by 2002:a2e:884a:0:b0:2d3:a1fd:4ad2 with SMTP id z10-20020a2e884a000000b002d3a1fd4ad2mr240078ljj.37.1709597853605;
        Mon, 04 Mar 2024 16:17:33 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y26-20020a2e321a000000b002d2ddcc12acsm1913955ljy.42.2024.03.04.16.17.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 16:17:33 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so7099123e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:17:32 -0800 (PST)
X-Received: by 2002:a05:6512:3ca9:b0:513:2508:7b2a with SMTP id
 h41-20020a0565123ca900b0051325087b2amr212844lfv.65.1709597852572; Mon, 04 Mar
 2024 16:17:32 -0800 (PST)
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
 <CAHk-=wgwy-p_zodT0JvkVkkd5MWy9NffC3jiDiczMMHPj1eQ9w@mail.gmail.com>
 <20240304171034.08d037aa@gandalf.local.home> <CAHk-=wi53cJEKim7UvUXtdhQG1BR7oU5TABPXaOq5SmBKLSKYg@mail.gmail.com>
 <20240304184725.55449e70@gandalf.local.home> <20240304185241.7ce42097@gandalf.local.home>
In-Reply-To: <20240304185241.7ce42097@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Mar 2024 16:17:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgR7NrXTk8rJbWEv0PBN5z8kbyWaWqKO_UDnK1DXoSbqg@mail.gmail.com>
Message-ID: <CAHk-=wgR7NrXTk8rJbWEv0PBN5z8kbyWaWqKO_UDnK1DXoSbqg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Prevent trace_marker being bigger than
 unsigned short
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sachin Sant <sachinp@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 15:50, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But this still isn't fixing anything. It's just adding a limit.

Limiting things to a common maximum size is a good thing. The kernel
limits much  more important things for very good reasons.

The kernel really shouldn't have big strings. EVER.  And it literally
shows in our kernel infrastructure. It showed in that vsnprintf
precision thing. It shows in our implementation choices, where we tend
to have simplistic implementations because doing things a byte at a
time is simple and cheap when the strings are limited in size (and we
don't want fancy and can't use vector state anyway).

If something as core as a pathname can be limited to 4kB, then
something as unimportant as a trace string had better be limited too.
Because we simply DO NOT WANT to have to deal with longer strings in
the kernel.

             Linus

