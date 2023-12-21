Return-Path: <linux-kernel+bounces-8899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF581BDDE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C5B25EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701C64A92;
	Thu, 21 Dec 2023 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O3M09i9y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B866351A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a23350cd51cso130191766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1703181712; x=1703786512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UFhYgBQMy/5618m05/BdiCx0uBB+GH471mXeLigE3V4=;
        b=O3M09i9yUEXI7TqUXOLTBUsoDXFNe961FJX017RFLnmk36cOzkxNbn2yVdPHjyI+/t
         RphjXwzay1Hx3BN7gnTbGg05irSH7jgJujx170r288FhVv83uSeyyKSyR/TnQtXosqnl
         j7p844/Dbu9A/O6FWH+S4vLZ/E0m5KfRe9Bxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181712; x=1703786512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFhYgBQMy/5618m05/BdiCx0uBB+GH471mXeLigE3V4=;
        b=NlVP9QVff9CEoUxYWn77MKepgSaJ/8NpROOtO7BL3J/WXlWOCwFTZ0GWIlhpYxONiM
         C8C3XUEBVYG4QEF3tm4h8E0TxVNiCBl5U+TwP1afm4wy49HfixTPcHBm/3wUB2xaGwC2
         Gid7w9rH1+R/s8SmACg+SLS+MFA0T60w3mNg5965S7tFUF7JFnjTzMnh8QodfMCP87yd
         yRhE6KU1u/HFrCCEkDOpFDvaTGbMlF/vbVfzX1QRI86UVhGlyR8CQYdC3rHJPeXt43uc
         qXfi8FUNlNIU3YQn+iZtc099W1CBcX0iaijGGzksVSWhigGtKjoHX+4I7qULJqlOZ2X2
         LZqg==
X-Gm-Message-State: AOJu0Yy7GV+1Di2HhypLvquO3SvcOpsicUqANY9LxKY5vKkFiapUBdj4
	LUpM0kefXyfEAwCGkc7N30zj9Q/UbYe/clKNhSjZeAZLRReR9Whz
X-Google-Smtp-Source: AGHT+IGLr8Z2fwv7Qpgq1mzcmJ8R7hl1pja1WmfQMcE88o5louAV87ZCrlMQ6xPsAbmS8UBw9qIZTw==
X-Received: by 2002:a17:906:bcc7:b0:a23:5898:5123 with SMTP id lw7-20020a170906bcc700b00a2358985123mr72775ejb.86.1703181712617;
        Thu, 21 Dec 2023 10:01:52 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id d3-20020a170907272300b00a230f3799a4sm1193546ejl.225.2023.12.21.10.01.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 10:01:51 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55370780c74so1292001a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:01:51 -0800 (PST)
X-Received: by 2002:a17:906:748b:b0:a23:52d2:44c8 with SMTP id
 e11-20020a170906748b00b00a2352d244c8mr97647ejl.37.1703181710093; Thu, 21 Dec
 2023 10:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1842328.1703171371@warthog.procyon.org.uk>
In-Reply-To: <1842328.1703171371@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Dec 2023 10:01:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJtcyi=oRf7Rtf2RueWq_336KEsSf9b-BKPxRcHHQx+Q@mail.gmail.com>
Message-ID: <CAHk-=wjJtcyi=oRf7Rtf2RueWq_336KEsSf9b-BKPxRcHHQx+Q@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix overwriting of result of DNS query
To: David Howells <dhowells@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 07:09, David Howells <dhowells@redhat.com> wrote:
>
> Could you apply this fix, please?

Ok, so this is just *annoying*.

Why did you send me this as a patch, and then *twenty minutes* later
you send me an AFS pull request that does *not* include this patch?

WTF?

I've applied this, but I'm really annoyed, because it really feels
like you went out of your way to just generate unnecessary noise and
pointless workflow churn.

It's not even like the pull request contained anything different. The
patch _and_ the pull request were both not just about AFS, but about
DNS issues in AFS.

Get your act together.

                    Linus

