Return-Path: <linux-kernel+bounces-40676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A318383E3F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69F61C2252A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665024A08;
	Fri, 26 Jan 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q7ydLpfR"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA12250E8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304682; cv=none; b=aQ5XuqP4UaLTulwv3EA1oW2uuKFv2mIsf+Af+Tqjd5sDfVYUnQuU2OK6YMnFG5gwmi7smJkYxpoGkYs0BSd1VT1JRUtw1VvHTYF3QxL4sFWZPOY8unuEDLuK7dtRfQRA0VgWsUfDGH5uLPQWeTf9zC6OHkxXItkxsI04tF2oEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304682; c=relaxed/simple;
	bh=6mukGWAjPX2YjUL4JezyXFLuCN/rYL2RbG8PlJMIYCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKg1lZE0pR7x+9IzNBsWOYfnVC9aMYj6r3xgxkkpfEa5alPAOSasRM2M4LUgItIiBjcggPbWp8NN5k1xMeCIsT4oNnme1Hx+JpPluB/dCFfnrkjFGxMKn9tpSBdCRjANYXmcNKnnzYIc4alWBLIZH0T3XBvMAevMcedBglmlUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q7ydLpfR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1483818a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706304678; x=1706909478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=maDpcikpyh6FEh8N/tIM7o82tGen2/tmETzOibUg/is=;
        b=Q7ydLpfRJBIPc1zDGpnWKX59E/L2MQWkHam27t3ye3pXQ8KhaHdVt0cKFF7tR4dRhW
         8FJHYZqd8atnsWngv3bauKLiWGGaYBjyXN/6BBDtmjfKU0cxI5e9ZJu7aCAHhq8d6EVd
         ERs1EzNLsVqS933T2uYBsrpwCzZJu/0QPBC+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304678; x=1706909478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maDpcikpyh6FEh8N/tIM7o82tGen2/tmETzOibUg/is=;
        b=Gxi7vc900tx/VyMv7mjDX0L1X4cBLCb0Cw4FLLhzKeYjAsOJoosVU3oe0hPX8cM7nE
         eE5P7a7cKwvpMwC/XqKQWlcWyhQIWev4sOI1mgicntGwcBHFmdE3khmjS39kK4S6ocCB
         ZAi8SKf+wyMhbAFxwFHqC38h+V3yNOrFj/+5rc41jF/BxLb5rp2a3jdX6ldtLsODeM9O
         2GewESqroHbv+G92yCWgM0+4POpbWqc6S2hI1dXnHSoP94ptqaqvFIFvIOeaCstxqRyH
         F9ccbzcg3mHNdfth5cK74X0eZJk3d4dgMZHiGFSZN1TKhay380zwxCw3AfY1jd7fGDJx
         Bw3w==
X-Gm-Message-State: AOJu0YwPfsDiTxwsCyOKSxGF5bv+xctd5c/zedeCelyg9yEV9QP5ZytQ
	n3kMc4kfQwmbHC//F87HzXE8LbbFAJMEI4/wQy/3UQUDLR3zCtS1Eiogx+gTNa5IfuAxmFK77c2
	1do+6cw==
X-Google-Smtp-Source: AGHT+IF33M0aFYM5KuRbsHEt+FSQrMJ1VWRhzJohWMNHuO7K16O3vToYWbZZ9EoY4HdqXSB93ectrA==
X-Received: by 2002:a05:6402:1509:b0:55c:8533:c7d1 with SMTP id f9-20020a056402150900b0055c8533c7d1mr2612199edw.0.1706304678387;
        Fri, 26 Jan 2024 13:31:18 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b0055c104274e7sm979227eds.78.2024.01.26.13.31.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:31:17 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a313b51cf1fso150336566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:31:17 -0800 (PST)
X-Received: by 2002:a17:907:75cd:b0:a30:e9a6:68f6 with SMTP id
 jl13-20020a17090775cd00b00a30e9a668f6mr2088169ejc.37.1706304677484; Fri, 26
 Jan 2024 13:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
In-Reply-To: <20240126162626.31d90da9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:31:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=witahEb8eXvRHGUGDQPj5u0uTBW+W=AwznWRf3=9GhzxQ@mail.gmail.com>
Message-ID: <CAHk-=witahEb8eXvRHGUGDQPj5u0uTBW+W=AwznWRf3=9GhzxQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So we keep the same inode number until something breaks with it, even
> though, using unique ones is not that complicated?

Using unique ones for directories was a trivial cleanup.

The file case is clearly different. I thought it would be the same
trivial one-liner, but nope.

When you have to add 30 lines of code just to get unique inode numbers
that nobody has shown any interest in, it's 30 lines too much.

And when it happens in a filesystem that has a history of copying code
from the VFS layer and having nasty bugs, it's *definitely* too much.

Simplify. If you can clean things up and we have a few release of
not-horrendous-bugs every other day, I may change my mind.

As it is, I feel like I have to waste my time checking all your
patches, and I'm saying "it's not worth it".

               Linus

