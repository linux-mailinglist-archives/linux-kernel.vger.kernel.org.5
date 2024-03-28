Return-Path: <linux-kernel+bounces-123233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1018904DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1241C2F4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94E1327F6;
	Thu, 28 Mar 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0r/vY99k"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA94130E4E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642736; cv=none; b=kHBe1neIUrCBXWWdXwtt2aWtVzmpoToCAb4yh2MVwVML8R0mY3uav3GXcEfc4Eikm3+N2kREmxgIkqxHXkEVBgejzWuXhWyX0OVAq9l4WSe9kYrH/ACzOa5kuUrphPfKzJcl3LB8ueRQk9CojwF3PXadBvEEhnJNcG2lG10JYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642736; c=relaxed/simple;
	bh=GBsn4xh0VH3bSK4OltJrohHyGLgnl+zZmaIezM4iDdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N2nHrvAgFLtroqxaDvj5SRP3Mbj1lBDZtROhMXUDwcyoL3lOVwuxJhNE5DAdAiNRnIBptUuAN6dQBlILF2MwRnCEnSRfXjRAmJLdQX7xbcdn/rXK7gCddS9KGxrJn7Nz0lPQclG/QuEb1WHrgr7z643BmhbILqMIEKmaByfsLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0r/vY99k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so1593103276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711642734; x=1712247534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=umIDKJbLUeVjB30WBmxntoX4c0W2blxouvOQBNQgTYQ=;
        b=0r/vY99kXoMzxkp4WPFgKJ0GDP+V8Gwm+QmvZ+Fc9oyjqDd5/gHMIjMRlRhtHIY10D
         WVDAlKUYiZWlKgYN67wG3236TFGcol02GKfz0/4C0dUcq25hVT4GJk+RFoGPsmFBSGLt
         KK5rOj1yqtH7/2QFgvAuwJf9X7QMZfYvkLZCGs9c0u7h4hbhxSh2VlLzdXGYrn02EEkX
         ix7r9HQCoNchwR6mXhKkBziU3ubyXuEMouTDkkeOH63kgPA5AdHsK3YdXechPbqHEP6c
         Q169M/2uYfBbNUDkJSEkiMvdeXyImB4UCpnzJwl7joD4KsmkbKeuJfvTjdEZDeyhE9pd
         2fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642734; x=1712247534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umIDKJbLUeVjB30WBmxntoX4c0W2blxouvOQBNQgTYQ=;
        b=YjOj81Qwxc2WCdzw8n2Cr3u8yqlCgbvZokutIJya8lEvRtWnfI1TtXy1Y7L8P7VzfA
         1RWxj8kZWC1SopnNSsNa3i8dzXxlbiBXUd9C/cHLIZ1DqAlhvsZT8qwFdpg9F6i9lu79
         wSCPxLZue4jxYqtEJ/mmygJEG1ePwOj/XwLuVa8f41qB2GTOrwiZFosKPMk4e+MO9wME
         2JVxJ1e66aYO36AWIVGF23aoXARZuwppLcEhqtcqcr90kQymfRoRkUqpi037Oa41zp5J
         37M88Jm4aB6NFbopAL9ZkOhj1a9A2Jj7Exh6Hyu+GtWcxb/+H2y0AEL3e7AyL5yoNt9C
         y84A==
X-Forwarded-Encrypted: i=1; AJvYcCWN99u5A+x89J7OJBeHg3l9PEA+KX3ictXF/EwDFPCWqBxBpNKca7n1FAWW5tdkuiFWQVc1nxDMsbl01W7yXEeAgfKLvwaj7FggZU6Y
X-Gm-Message-State: AOJu0Yykt1NYGtONn3zXAOHy/1xtZepxzqNUEJ/HOig10RPwcMqoHPAE
	c1ItM3dmdJOmkot3rlNQ1B0zUQ8kAqTDtbUeZg5ryVbldNXOF/XPj3q0CWhVf16QsFkSlwKeSBV
	L7Ux4HQ==
X-Google-Smtp-Source: AGHT+IG3wG69Xu1UOnAeobYYfeZbnbL1W7AO1OICQ5yW749ORUJQcN09ufbTLMPe/kI+kz+CtqMiH5GZrRAU
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1b13])
 (user=gthelen job=sendgmr) by 2002:a05:6902:2292:b0:ddd:7581:1234 with SMTP
 id dn18-20020a056902229200b00ddd75811234mr194893ybb.11.1711642734480; Thu, 28
 Mar 2024 09:18:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:18:52 -0700
In-Reply-To: <20240328110103.28734-1-ncopa@alpinelinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328110103.28734-1-ncopa@alpinelinux.org>
Message-ID: <xr93zfuifhxv.fsf@gthelen-cloudtop.c.googlers.com>
Subject: Re: [PATCH] tools/resolve_btfids: fix build with musl libc
From: Greg Thelen <gthelen@google.com>
To: Natanael Copa <ncopa@alpinelinux.org>, bpf@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>, stable@vger.kernel.org, 
	Viktor Malik <vmalik@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-kernel@vger.kernel.org, Khazhy Kumykov <khazhy@chromium.org>, 
	Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Natanael Copa <ncopa@alpinelinux.org> wrote:

> Include the header that defines u32.

> Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with  
> types from btf_ids.h")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218647

Tested-by: Greg Thelen <gthelen@google.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
> This fixes build of 6.6.23 and 6.1.83 kernels for Alpine Linux, which
> uses musl libc. I assume that GNU libc indirecly pulls in linux/types.h.

>   tools/include/linux/btf_ids.h | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 72535f00572f..72ea363d434d 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>   #ifndef _LINUX_BTF_IDS_H
>   #define _LINUX_BTF_IDS_H

> +#include <linux/types.h> /* for u32 */
> +
>   struct btf_id_set {
>   	u32 cnt;
>   	u32 ids[];

