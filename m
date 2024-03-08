Return-Path: <linux-kernel+bounces-97614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE8876C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7743281FD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036035FB8A;
	Fri,  8 Mar 2024 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PPbUiBZG"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D365CDC9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934140; cv=none; b=ajIZxzCqzBA/GD4dfqTLIS/nED++EKxNk2mP6sTvYlOeClAnDkPM3l3FdjlIeYgG99enrP/flpnJk/bfHcNqS09g/qDIpnDFYLxf7AXseWYjMiSvD3Cdj7F7LjFQullMQ0H0B1TP64opHaYKehvzNkb4TMv6tfR/0L/IJoCwbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934140; c=relaxed/simple;
	bh=CYYr/NajUCCcjsIAOZaIwuy4+0QjCsXxLc8V7MKFSIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAgkwMeT5kaQE16Lr0nyex+BNJhAW3YDynXfzoQF+iFQk/nyX4KUUWKW5oNxAebgGZI1npOPKVBmFQGjA5SIDjvKmMBze4Wji1rXCC2iSXjOeRIF1f0L4VQU5PRuXJc0Z2paPjSdEibqGq2yKfe40V5vajHLUQ77cLDT2K9F9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PPbUiBZG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so376530466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709934137; x=1710538937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZOJX8+ZYX9H0UL4MHKNxLD9n79jC8SKE/Gmx2LAZcI=;
        b=PPbUiBZGnSxxFybsD1YKQ5TJY4gRPjZN5XEiWdIaBjGZ7Gs3xXIFAKXpsoifq8cO+O
         0JMVGI2v9ly+mo3pg+HiqGscn+wcZBYqDhyNRh69C3fuQG1j2K3stSpt2fPGISi9HHH1
         38BrD5WKQKQuC0pkBCHgSpqRLq6IA7NBTKcy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709934137; x=1710538937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZOJX8+ZYX9H0UL4MHKNxLD9n79jC8SKE/Gmx2LAZcI=;
        b=jVINomr+i+s0C6rqYn5dITtc0lmJKvbFGtygZOIrxvNgTcROIBQbKGWMY97XKtl8Tt
         3tcghfmALBuPrBQbBkZBkorOdIP9lFptujZA1HSrn5GBdwX3TSbxyi91PaT92RVPYPfv
         VJ1eCFPwyTC+9KDZdjhVK7Ua0fRW2i+MMy3RnKXqORcba0H1pXGA0tJcjwxWW11fU/x3
         4BNI/oWbKxNjKzFai+58qUjJtj4g8ZQyfQl58jZrG9hvuccIeJLuCLbtG7Q/0EZoicvO
         BimxKYK9l7kDK5bs+fNO8/s9aQkuGQwxea1GMWCwTh7J7d3qS2kbIwd/KYtZ0WmucNe3
         /uxA==
X-Gm-Message-State: AOJu0YwCUy0TaIkwE8jEoota1nhnElLkbanuhxh8m2ahIP+5ud/esZaV
	5dOwHS7CURr6mKYEQW/w+eCzsbD3/yptMn2Bh/d/E9drvWaQz4Mun9vybnvdXSzADm/3Zgwv3KU
	CcJzdrw==
X-Google-Smtp-Source: AGHT+IEeTY6sIviyWuwzZszDs4NnDPQA0evtF/K3zVueuijFn2EU3AZsLEA89Yi7vQRWz18TYA0sSg==
X-Received: by 2002:a17:906:1d47:b0:a45:279f:3256 with SMTP id o7-20020a1709061d4700b00a45279f3256mr180248ejh.20.1709934136957;
        Fri, 08 Mar 2024 13:42:16 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090628c300b00a444526962asm192306ejd.128.2024.03.08.13.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 13:42:16 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45bdf6e9c2so310115566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:42:16 -0800 (PST)
X-Received: by 2002:a17:906:f0cb:b0:a45:446c:6beb with SMTP id
 dk11-20020a170906f0cb00b00a45446c6bebmr148512ejb.50.1709934135922; Fri, 08
 Mar 2024 13:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308183816.676883229@goodmis.org> <CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com>
 <20240308163528.3980c639@gandalf.local.home> <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
In-Reply-To: <CAHk-=whaVBe14mbW4QWNuywBP_ZvGJYRZ3dbgx9-ebSxnNTXiQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Mar 2024 13:41:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWbhhNLCZgb97PP9Bo-XbNNMdPxqr0YRjYWXP5E3a1ug@mail.gmail.com>
Message-ID: <CAHk-=whWbhhNLCZgb97PP9Bo-XbNNMdPxqr0YRjYWXP5E3a1ug@mail.gmail.com>
Subject: Re: [PATCH 0/6] tracing/ring-buffer: Fix wakeup of ring buffer waiters
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joel@joelfernandes.org, linke li <lilinke99@qq.com>, Rabin Vincent <rabin@rab.in>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 13:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the above "complexity" is *literally* just changing the
>
>                   (new = atomic_read_acquire(&my->seq)) != old
>
> condition to
>
>                   should_exit ||
>                   (new = atomic_read_acquire(&my->seq)) != old

. and obviously you'll need to add the exit condition to the actual
"deal with events" loop too.

                Linus

