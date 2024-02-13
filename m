Return-Path: <linux-kernel+bounces-62921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A268527DE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5338DB22EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B310A23;
	Tue, 13 Feb 2024 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7GRHvgW"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FA10A0A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795898; cv=none; b=r7mJqifXbZ98e4se8eEYYWQFDIGXCkBQOJTkMFbSrJWIXJb5lovJF8+5r+NU2lvU9JK7cz+FRFIVyiAUlFvuBSF5FN1v6W9Lq/TnkBEc9sHqznrro5/RQmupoljlHPmvS0DYdZ2k7Cj+E9TqU+NGKODxgirNROnCSTt4zI4iKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795898; c=relaxed/simple;
	bh=JwAyQWe7miwq6SVX7IfW52aLND0+2gi89T9lvHbisTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2qIpUPlioCj7qFWWwVho0wrXmVSuf55xnF0lDeG0ltYTG4b3QHEzllQHuQYoQQ6uKjW27thQXs3xjkCOmzYtWF+EK/HpU36S7C/5ATYRJRxzAaNm+Hp3/Hf8QnZ49QEMAau6INOhBh2hq7cBO758MfY48hQlXSa2Jeu3oxnS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7GRHvgW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so5013602a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707795896; x=1708400696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp/byxLraC807sITtGRawodDTA1fNMfQwGWNUUbWF5s=;
        b=s7GRHvgWhCXh14WRSKXFW/ByH0AZyJHehzuN41gbqTqM+QaSYhCs9SJN6oFWV14fkb
         CKCXiQIitezUvS7U46oQoEDJECdXGdH6cOec6pI+aFjh3t2RcyuUFSa5piVNJQbIQ24/
         6DriUNx7l5khhjekPoUQug4hbu+CBHC0oc2E86+qCDR2i3BG8q+10r0kPZ7PZXRZtn+c
         JarO4139iLUcdsEF3mcBg+1uoBgZWHmkEmDjYUn6cjzZHQV+D5e/WRw2V4nh5nhVZkg1
         2c2F3RODZZipczIls7LnutyI6SD7Kb7pl2a1Vyfw1hjoGjXxXIELa+/iIzsFQtKZUxj9
         nv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795896; x=1708400696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp/byxLraC807sITtGRawodDTA1fNMfQwGWNUUbWF5s=;
        b=u6WcpfKHkvZjOeiUrKjcLTlzVcJAwIKehe3zPAnbkTGesvHdqqpxBTnsEoypn88RA/
         Tvgp/aVYegv/ALkQEcB42pA86SdilgUVIqRsgy+kY5+I0NjdfVjVJqS/AKpf0ZurceQL
         wM95xdD6iAp44/nRP4ZbrhysBbvzd+Z+7PDO19Qqp8BYDh8DMKN1gikstT5efi8mqwy3
         ns587Fs2eUvK1U2fsValsVzRpd3Y1onPD9Y+u0CFKQ66TTNJAi99hCbIVlvdXlEMzTSz
         eyKXnY1zm0qCRmN3CAqbINVrXlVUXD9gUcoyQgoWwD58/xMAPhAkO8VfZzS0mBWQEUmI
         4N7w==
X-Forwarded-Encrypted: i=1; AJvYcCX+idw7Z/0CYgOvb4i5IQGfEsoKNTQVyNEZrp1fDebr7sQjjB3zZLj3iAttf9aIcfYOg5SHq3yf+5Rq/drAWIrRMmRmfcb56oavnq+1
X-Gm-Message-State: AOJu0YyGJ2QKP2BBdCQQZmeLiz+kdcpmv1LLaB4lNm9n20MAzfpXkg7H
	/wnd67ENY36k9ejNLwSa/4RAsfFgxWkNF64EivF1Xik2cyiR1dIlz9C60aezbsgAZvl6YfezSj0
	VAg==
X-Google-Smtp-Source: AGHT+IGGI8Fty4SnswScI0YALjv0to7a7pfcE8bH+CFvNEGLJ/DcJmrEz5SnXPWzfMn3EDSiz3p6QME0aDg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6e85:0:b0:5d8:af18:eee0 with SMTP id
 bm5-20020a656e85000000b005d8af18eee0mr107250pgb.12.1707795896559; Mon, 12 Feb
 2024 19:44:56 -0800 (PST)
Date: Mon, 12 Feb 2024 19:44:55 -0800
In-Reply-To: <20230911021637.1941096-3-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <20230911021637.1941096-3-stevensd@google.com>
Message-ID: <Zcrlt0xHdRubEDLJ@google.com>
Subject: Re: [PATCH v9 2/6] KVM: mmu: Introduce __kvm_follow_pfn function
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 11, 2023, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Introduce __kvm_follow_pfn, which will replace __gfn_to_pfn_memslot.

Belated question: why is there no kvm_follow_pfn()?

