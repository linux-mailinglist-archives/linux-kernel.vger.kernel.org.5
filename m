Return-Path: <linux-kernel+bounces-45443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA78430D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40CC1F24BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EA7EF1C;
	Tue, 30 Jan 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D/64/Do8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB277EF11
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655994; cv=none; b=HNsDgqgwZLEbHKO9mCKUNLsPZPCvbAiO4KRd3q9H/PxK1tw172ov3y0fNdfLjQ13gKE26f8n+9A2wpRz6MaFrFMixPH4ODyALm64+GnjAHPevyQPMIIkFhooVL8N1yOX0JJcq+zHbkKmLUZVO0hUhcw9lGWvwIFnLVRz7ut6I2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655994; c=relaxed/simple;
	bh=XHfQdT5xppI0sxHBN2lXjiAv8/rSbOiPYsD4DbY6//I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE2ghUUx6fqfinUF4LV+aSod9bE9PIQUGozP520EBixlm6nyHheam/ePguOV7NwdC6aT/fM7RD6ZdvYsLwSRJULWZWfAj1sq3EXVcQ2nYldpg98XfiP1BCTSk9OUQU0UDodUz5qZCPnV7FMml25RPs/dQDzD660Wxent72blbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D/64/Do8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51124e08565so162472e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706655990; x=1707260790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsAQvVSaSL32A30A6uQETKC8YhkCEz/oSK87u+lSg5M=;
        b=D/64/Do81E/DpaWxPWjTFqUGeqlRy077VCdwonWLcyZtGJdzVPHza0DnieLXJ+FxGb
         jFtl1gpH36pKJm4a3CbuBc4M+z1553D/0ry4vjK7ZjUGms6VwggZaLoEqMokWSSTCDAl
         9fg54NfWpr79zIN2eJKuHcihcHaV+elSTXIOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655990; x=1707260790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsAQvVSaSL32A30A6uQETKC8YhkCEz/oSK87u+lSg5M=;
        b=kfqBLZLjiPp2XjUsDLPFhsdbSA7NT6PSEAa4ZD9JyYiPx/a2bZ5JAoGeHZGhJ11fjQ
         1qCLRIaS3I8egvfR8/sQcwZFhNiTmxmhJ5kLwjXeLlHdSVll0tVfk6bMZyNNLUd/M1Uh
         OS25obN81YKhfpuwHDtrTOfFAIXAp6l5xLHYbpaOp26SUwhkgZE5JTewbOyxnkW8qksb
         bx1t3GrcFpIIesrxNEulEhJ9JYTEb8G1MNPw/AuOCLyXmhelXh+5s1tYD9rEprKwpvze
         4onV6khWKxyQwyL0Wama1PL5lGlvivcOP47etS4ryUaQxUXDdvwyYnsXnck1bBMqJf0B
         bCrw==
X-Gm-Message-State: AOJu0YwHxftfSdG+Y2lE13gSMRVzKIlY2V7/CqRM6OogpNquc3drO4qj
	4XT/7MKQlWdpi5vQ6yULT+jKXZg1l7681FcVA8XLS+Y0GkRsaKLeW89iVhEhZ7cR7/vi2hlIntX
	P4Nk/YA==
X-Google-Smtp-Source: AGHT+IFYnV72+xor1dDRxChBzpOfgj2fo4/s355HiIAwnfc9KHkR54B48DJhVc2gFR1eJTGHJzlb+g==
X-Received: by 2002:ac2:4dbc:0:b0:50e:3082:1afe with SMTP id h28-20020ac24dbc000000b0050e30821afemr61968lfe.22.1706655990554;
        Tue, 30 Jan 2024 15:06:30 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id vh5-20020a170907d38500b00a3517d26918sm5050027ejc.107.2024.01.30.15.06.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 15:06:30 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so5028844a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:06:29 -0800 (PST)
X-Received: by 2002:a05:6402:17c7:b0:55f:7b91:cbd5 with SMTP id
 s7-20020a05640217c700b0055f7b91cbd5mr234469edy.8.1706655989651; Tue, 30 Jan
 2024 15:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com> <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
In-Reply-To: <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 15:06:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com>
Message-ID: <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 14:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> With that, the base size of 'struct eventfs_inode' actually becomes 96
> bytes for me.

It can be shrunk some more.

The field ordering is suboptimal. Pointers are 8 bytes and 8-byte
aligned, but 'struct kref' is just 4 bytes, and 'struct eventfs_attr'
is 12 bytes and 4-byte aligned.

So if you pack all the 8-byte-aligned fields at the beginning, and the
4-byte-aligned ones at the end, you get 88 bytes.

At which point a name pointer would *just* fit in 96 bytes.

..  and then some debug option is enabled, and it all goes to hell again.

              Linus

