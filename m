Return-Path: <linux-kernel+bounces-99767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20194878CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A117F282C45
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2B6FB9;
	Tue, 12 Mar 2024 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IT7k+2Bc"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B217F7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210329; cv=none; b=ecKLeFj3Fku8W/UcqD1+ih/1yl2oGPab2jj62Iyki0afxyTFFUYvJXJCIVRnO8VHwlweRf43gjML7HVhpbe1fxDc+tz9OnM2Mwngc9SyOMQ6/psWuCyBRKHHcZDKg8iWaXhSAnorICAB+XUjt/NuVvrYBqjQopwcylfedgAH2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210329; c=relaxed/simple;
	bh=FOFhFlZwDYaYZJ78MEhwu5CQoQ5L1/MROugnSq9349Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U35L//+vLF3KELgvWVkK9Bdwix8Q6rezm2Zd/TBRooe0XHvbvMIxiBJd+ZkxhkEvEcq1MnUKBMKs4zqWQ2+DuRrxbzG1Z3Ggga9YaXZPlt/4iokszGpgKwwj+cog40vBUGl+ruB+WTdpzku0eRCy88hgqgX+e5vf0wy86YV6jYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IT7k+2Bc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4467d570cdso420674466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710210326; x=1710815126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n9I8hxzcgp3Ln+LOJaI0E00AHAUMAJV7Win5EAVVObg=;
        b=IT7k+2BcTffP6MJ7BD2NNAbIXr5Xjes7Cg776YKaCCnH3V0KQlcbTN8OH5SrKXwkfs
         cZ8C7uq8do9kXhzV7dfsl91Gko5aGin69HGzuRf9Pg/FYeDMCIY5OUJ2A0Bt+SAFOg9E
         9076kO5Y+FtQFvyrpILfZJH9e163SWGpmN+kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710210326; x=1710815126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9I8hxzcgp3Ln+LOJaI0E00AHAUMAJV7Win5EAVVObg=;
        b=fKtwqrFH0rALO+oQI2ti7iEHZXEfqVnUTS3RHXbaw+AGwDXF+CFAx2qinM0TZb/ITb
         W72DuFMqtfICnH9zo3NtQr5UbGPWjCHxlwjJDDZgPqOq9llokoRgUq2y8EegllsOnoAF
         Tres6IlyZygb1f1SyzGhgUUaK1sWf78+xOx8s1wrFQ1B59EsmKuh0b2gfGyYhMzyWc19
         Xst93j2UcYMawIRgnb1vxiQkejXz0Bjrz8RhKXmILprhtvQtbSbwbnVTzGSCZpHeo8FU
         D0/boh2oD25e7aAdZ/Qkc7/Pe8XE0HewYPAcShumsFZfCAahMQQnZmgWqPMQG2KLWKOJ
         dxTw==
X-Forwarded-Encrypted: i=1; AJvYcCWRLjhQYIC7Dln4Mq5GdzkTRqvxW/gIZj65iCD180lPDytbFp7MCanifgeOvk0UQxBs2iP87MRVFII8qsEKpIWaLn3I1+E9kkwFGsJ4
X-Gm-Message-State: AOJu0YzZyzEaMnheDjfrVqwgMQJr3cUVg1U+y354CQ5RkdOMjVuCPi5U
	26YkI5R5eRwEvS6YLMCaVzaUKY747eANY+pGybxhFujZJXckhMUsi1nrwR8bUj2GkF1DQPUXA8h
	nOTpm9g==
X-Google-Smtp-Source: AGHT+IHAEnVkdVtkEY4AmjtJm0cerCsDNGNIMVUYDJWp5FH4CDUEdXb8OLbf+oKwCoVlMevdRtjO3w==
X-Received: by 2002:a17:906:3c56:b0:a45:b631:1045 with SMTP id i22-20020a1709063c5600b00a45b6311045mr5106955ejg.21.1710210325836;
        Mon, 11 Mar 2024 19:25:25 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090627d400b00a453b2261b4sm3357278ejc.184.2024.03.11.19.25.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 19:25:25 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4467d570cdso420672466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:25:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH8ivs9oc3+QrtgcBgMFnUUXaSpz1HcDct1tqJi1nBuqDkku9CmVROZsqiyud1VPEjZo7zedri9tmKz2PO9mXP8kyu+MBwxzg1Nu96
X-Received: by 2002:a17:906:1715:b0:a45:8a13:447f with SMTP id
 c21-20020a170906171500b00a458a13447fmr4518070eje.5.1710210324748; Mon, 11 Mar
 2024 19:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com> <a4bdcf74-5c6f-4483-a4f0-8ad6558a3c8d@infradead.org>
In-Reply-To: <a4bdcf74-5c6f-4483-a4f0-8ad6558a3c8d@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 19:25:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUPvds75HLJb98ZNXdZe4rTQn0wK33OQYYfQBqxTjfhw@mail.gmail.com>
Message-ID: <CAHk-=wiUPvds75HLJb98ZNXdZe4rTQn0wK33OQYYfQBqxTjfhw@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for v6.9
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, 
	linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 19:24, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> and there's an extra/trailing ';'.

Ayup, I fixed that too while I was in there anyway.

              Linus

