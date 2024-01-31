Return-Path: <linux-kernel+bounces-45798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F25D843654
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE81428901D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887323DBB3;
	Wed, 31 Jan 2024 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cBPK5zEU"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B953DBBF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680667; cv=none; b=sC8FgBnt+3Ka7IjcPiyyfFRQD1SOIpp/+Ma6oMqZr8iZtG39mdH1fD1PMCEqXoDAbOsh2TkTImjF7rw24RQtgEr0fX1JBaslV0dvsrWzPU8A9j9GzlK2Y900s3nvlE5DGsdsd8Jrroab4CxPZhGFmdV2jC4m6JwD36piqTMcT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680667; c=relaxed/simple;
	bh=vOyih3ICf+cC/rEztfmfpM3LdNIl0b2I9wSmpv/NLFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIbQzBTqAp16ljZ/NVSKi+NHWSgZxc+1K9UkaIEgvggdBUk0w7fDIFcQ2m4apYJw04ngSMJVE9OpndXHzNz9IzZmC+TIzYQl1bIF7wIdIxdHEoualQK8ZYN7sQp8tYKMRC1MDjxtTyrDsdTzFyIx7dIGh5kgZtPcHv5WRtW64sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cBPK5zEU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35385da5bbso632340566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706680664; x=1707285464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJmhQWnMdv5xPINffOj6QDTUCMF7DMEzkKe7lbx6KIE=;
        b=cBPK5zEUQs9ZGjlwe0sQxa8pWCYVhR/pb0wKhpLAkfs9O9yK8E7q1fKltCbD3nHaBI
         uL6V7bHSbSnzmN2ZQF+zojIHIIsbQ8j+qyzNpbue9ZjQtCKo1tV74q2nf8jXmAaQTV4+
         FwEKEMyxTWcgDFB/IXT8G1Ra67gNVqobnr8Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680664; x=1707285464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJmhQWnMdv5xPINffOj6QDTUCMF7DMEzkKe7lbx6KIE=;
        b=soZYCfAJPjYxAwFvbUM79dItiJWakbxf9fuwthFBYaKlBlc73YA0FW9En7onJrcQto
         FSHxv7Y2PqeNIHtPnPV1hFujP1uQu/5f0CvDw566eIiOYQL2SnY5VyWUET1G8l4OfjGM
         sFSrXoXsKuI8INvTl3pQ5JexvDGq4j0u6neeFi4imBMOH8VSRDMkYTWnAgC05V8kQg6B
         R0beTpLiGCb4t17JFyxrt+4MhZ/Jc2jN8jYpH1IgRVB2H079sGIiHDHGN3tKGBDAQyIn
         9CubZTDXEddzBHgfQ9lWNb1de9dm0hK+bbnKjPeQgQEPXVn5GWxVH2W0uF8d9FUa7SSq
         1EZg==
X-Gm-Message-State: AOJu0Yz/qsUME4usOTQ9b1MEONJ0pBbi0KdpkvAqgqnAZgvlgfB9vqHO
	KMAg4zgTyY1EghscqapJn0l8VFJZerLsPlkwdmiL7MWyVXfMhGtJYjdil9X0ym3QVj2Irc2rI8l
	aGplJiQ==
X-Google-Smtp-Source: AGHT+IGbRbGiu4f/WIKa1Rl6P5/oSPIPIKx0utpggoYHWfRPlazQ0PgDLOu8TGgi/ECTLhJGpVzvtA==
X-Received: by 2002:a17:906:4c54:b0:a34:d426:1b86 with SMTP id d20-20020a1709064c5400b00a34d4261b86mr368990ejw.9.1706680663974;
        Tue, 30 Jan 2024 21:57:43 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id zh11-20020a170906880b00b00a359c588d31sm3442074ejb.100.2024.01.30.21.57.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 21:57:43 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso3661704a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:57:43 -0800 (PST)
X-Received: by 2002:aa7:ca47:0:b0:55e:eade:fcba with SMTP id
 j7-20020aa7ca47000000b0055eeadefcbamr342103edt.5.1706680663061; Tue, 30 Jan
 2024 21:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240131000956.3dbc0fc0@gandalf.local.home>
 <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com> <20240131003317.7a63e799@gandalf.local.home>
In-Reply-To: <20240131003317.7a63e799@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 21:57:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
Message-ID: <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 21:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> With even the last patch included, without the d_invalidate() I get errors
> with simply doing:
>
>  # cd /sys/kernel/tracing
>  # mkdir instances/foo
>  # ls instances/foo/events
>  # rmdir instances/foo
>
> As the rmdir calls tracefs_remove() that calls simple_recursive_removal()
> that then walks into the "events" directory. Without that d_invalidate, it
> walks beyond just the top directory and then splats on the dentries that
> are cached.

Ugh.

This is only an issue for that "events" dir, right? The one that has a
proper refcount on the dentry in 'ei->events_dir'?

Because yes, then doing d_invalidate() looks like the right thing.

           Linus

