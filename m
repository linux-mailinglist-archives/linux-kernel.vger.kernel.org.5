Return-Path: <linux-kernel+bounces-143067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5D08A33B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E198B1F22DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BA148FEE;
	Fri, 12 Apr 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NzKX1LLL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758714A4EC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938939; cv=none; b=aVt41rXAa5tZkncomCwgkCWpnqKmwNQwjrI8iICzGaMGBcCT9v1MvM6cBntXmBysIoCVmavyOGs5oP3ZOb89kRzELghFO0UsmZl0Bch5/Tp6JStQSeqf1Ny5CB5lK9FfJB8NNadZcaLlL+DBAW3ySD6/eAvh0+N6TPh8QtPYXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938939; c=relaxed/simple;
	bh=IzlxdJ+mZtjTQeO2IVOi0abdb9couLeImodhhBSYr5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifFj1MJhw+u16U6blRaJ2NejOy6gfVGjfOm3WcR0sd5+HyUjj5iwKn2LP9jOXiT14XwzzdmuZ3mFxUbm5/Cec0mxxJTQAtaENRfcYOkN2kL64OTEckJzh5sD2npTcrrXjHSBgeCUwAIxQTjI2bwH/JJ7zosJjzQI85e1OuQHINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NzKX1LLL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso11917091fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712938936; x=1713543736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utRlliweFDNJdF9kvWRJ+k7pG5tatGAFIzow7u+hheo=;
        b=NzKX1LLLd1Maw51AD0MBQcKXbGJZPx9hn2tBImtWJ+U/zjMtrPc2upyc6p0uYwHVxq
         VzjSGYu/BQJKVMrro4avRd/Iez18VNnKezkD7/i0XYkMGZTGEAJL+lxTVPWnkZ4HeQ1U
         I3CCv8Z4LuJ0qGNGKptX/PKpaxte+ZK4AcsGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712938936; x=1713543736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utRlliweFDNJdF9kvWRJ+k7pG5tatGAFIzow7u+hheo=;
        b=TSxD2RlDLYK5hQz6XNi29ytxaOQa34Ma1f70K7buwpBCuobs19+/YVaGKk370y63Vm
         vpL9gWpMQL6HpEZesympfb25t7pEaKPBiUW0o1F6Dr3kzporPVmDCFcy3moqAS+LJgER
         JQziCIe77lyiWdRWcatxBBUXsivK8av/etaGKo2CB8F0zAkMse1HH9ujsqH6pw8HecDy
         Boxkca4xtdpicsfg9ZEyqR92iCasnsxq3exWOsE48dPHs18EVYT65FLNrOgn7n33VJH2
         NzKjrqr1iFn6dlJU6tvgvu6DOnGqnjbL/QcPzYLXZ8ijFy6CgBT+tj1YZFuORk/NN075
         bq3A==
X-Forwarded-Encrypted: i=1; AJvYcCWfrdeVYCxa7LDspvJx4+Ip4xcruvnMUUSW8D1TkEMST95bRtzNzLXt00D99QLJ3IuPGLmiprYngA+7yUU4wgrOvDxYPv0D2PyVy/r6
X-Gm-Message-State: AOJu0YzOOV0Hd9byKTF+ezULQjo8rzQIbAg9VDJFdIvms0IXSij07kan
	DhuWajZ2NFa+qj6ovsWBfOeLokVAMH59OCMz/em6SkxSUnlz+Gjg8oElZkWnDuL+15GuVoUuaX1
	4ZNX0RQ==
X-Google-Smtp-Source: AGHT+IGs0FdppodY5v+fctDOGASU8u8CiaHQf+xNvWZJIcWGTSKe3ABJ93NA47hZMT05Bd2NIGD49g==
X-Received: by 2002:a05:651c:1242:b0:2d9:b2c0:a212 with SMTP id h2-20020a05651c124200b002d9b2c0a212mr2148771ljh.27.1712938936202;
        Fri, 12 Apr 2024 09:22:16 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f1-20020a2e9501000000b002d69186df71sm543807ljh.54.2024.04.12.09.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 09:22:15 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d0162fa1so1322523e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:22:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyYjuuC6VvYcDLm1j/9Hf2jEWmiIbza4ixsufCB99MI95KLwt3BMgrF6fPavKW2m7F7e5rAAbEUhVaXg3uN337xihyue3P52Zey2it
X-Received: by 2002:ac2:48b7:0:b0:518:6d35:e4cc with SMTP id
 u23-20020ac248b7000000b005186d35e4ccmr2329676lfg.25.1712938935003; Fri, 12
 Apr 2024 09:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412103204.453d912c@gandalf.local.home> <CAHk-=wgw2NW5tar-Xew614JZPKfyTdet5fC0mgwK+2sUsZ0Ekw@mail.gmail.com>
 <20240412121531.24669544@gandalf.local.home> <5ab77ba9-721a-413e-bb26-6c842679f61a@infradead.org>
In-Reply-To: <5ab77ba9-721a-413e-bb26-6c842679f61a@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 09:21:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJgRfOnt4TVFOaXfjkjTAh1AdY64zw1ohZxv7yzqzBxQ@mail.gmail.com>
Message-ID: <CAHk-=wiJgRfOnt4TVFOaXfjkjTAh1AdY64zw1ohZxv7yzqzBxQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.9
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Prasad Pandit <pjp@fedoraproject.org>, Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 09:20, Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Argh. What parser is this? We need to fix this craziness.
>
> something that fedora cares about.
> out-of-tree I expect.

Ok, that shit will now be broken immediately by me adding tabs to our
Kconfig file.

Because no, some out-of-tree garbage is not relevant, and if they
don't fix it out of tree, that's *their* problem, not ours.

                Linus

