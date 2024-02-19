Return-Path: <linux-kernel+bounces-71608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5B85A7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304A1284D78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BF3A260;
	Mon, 19 Feb 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpdtygvf"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3E381CE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357355; cv=none; b=Ej8NOqn9Ga5ZTAS3TU55/HIW0blqI5GrXhbCa5+cJHqWISrOJbTU8vIqVugvXGdG1RjpqNNJkFYnZNDQWvowDNsMz8WtDJUKuWIrDNb99+0344Q8vWLeJF4Hg2TxauYineH1iiQTdKwjju/lxjAfDl8X1ja6mYsPtC9inkfdo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357355; c=relaxed/simple;
	bh=wj61I486EjyO1qYwgfET66TLg5dslxS1n431490cCnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cGkCsgPgLK7YYoabAgyOUoJ0jRP086SPeAoB8q24arxRJd9IqoCR4w2hlseOA79J5DbB1Y8ZH02gEKc8sBw7N+riD55QUGNYoExn1e6G7Iwd4Gyr4J0oI8TS0pzBKzuqThB7Q30KKlkNgcAwv970adXYvIdPzB8IKNj0/Vt/Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpdtygvf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29976f92420so1438626a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708357353; x=1708962153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkbtvoXv8I1HOzc4S1HwE/Bz2nPMqgyZdTFHOJj0DP0=;
        b=lpdtygvfEdsO0XcdJ/rNWIdrVcR0bNKZbbLKtEFmxLXtc8QmyzljcgvWRyy2iy8wAs
         XFw5/VLKfekgxlK+LOvBpT/zboV0IMYfgwPHaOiD2lyAsHCOnyZuhV2D0yB1395u2HFa
         U0xMbPyuVmCtHaXTGrPeDD6D0HpCK+fULZq94YhH9ud1kgVqZeBi4jPG0JEy0JV6w35v
         KMYQG/ExZ9FjjyUO55HEV/cA9in2iN0l5jDy8xNunXEIxme4n3TGCDBdU46qu83kG2Be
         cBBGzdnOVE2jTJcSTo9Poyaqnbd570TIODMpaXjnhrHkXqne3PlQM/iQ5MALS7q5sCgj
         l+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708357353; x=1708962153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkbtvoXv8I1HOzc4S1HwE/Bz2nPMqgyZdTFHOJj0DP0=;
        b=Y6guK6jSEVL1D7iqWL7bGRkPcCc/8Bc2BPoUCXt49AuyT1zhZ7sR65TERe7lBr1pdm
         y9/JcpZVtzUO0MV61dfRJda5wQujd1f34voDdspqktM6XYTNgLBoJEx5HByoor771h4H
         DKeFYSaPNksP3rcLjuFpsTuS12psrcEvcBGEU5iBElWJWKdpKSozNxLAhquq9zjDFpbC
         jAbmSv0GZJ4yYSgxNa7wl15REy4g7WpBpLQMYKcKN91oLXGHWD+KoHZNuGsaZtiAlfjN
         +PSM8O7iUMDdzR89KqZWLIc/bid3AnF/8QaIDxhHMSR/eELrC0n+/4mBTkDKuaf2DkHP
         M5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVngd8BWVx5FWJc6rMowRep29Wsh6vwGvQk8db8OfAj0QmLESvohHP/+Oxp/3+fDY2jVvtHrbd9g9xh+iK/RS5jL+yL+CCB3NZcWS//
X-Gm-Message-State: AOJu0YzmKIYlqnYqX2/+ACYmHjugCaaTUZDiPRbyc2g+KH4LsWtIQJ6M
	N6iUEQSPOuwntW/cmohcmXcB/5PRw35G2PtgEYtFekeuFSJArrfgH047mWA/YTDb8hsqevA728g
	o0g==
X-Google-Smtp-Source: AGHT+IHyawgxsGsWSn7GpZ9qoWbojUmjfE/452LWhbiaud8cLNLV2xacELZtOdewy1VtFC69wSJlC+n/kQI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c690:b0:299:41ea:ff12 with SMTP id
 n16-20020a17090ac69000b0029941eaff12mr39553pjt.1.1708357352979; Mon, 19 Feb
 2024 07:42:32 -0800 (PST)
Date: Mon, 19 Feb 2024 07:42:31 -0800
In-Reply-To: <20240216202527.2493264-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216202527.2493264-1-arnd@kernel.org>
Message-ID: <ZdN2558tx6zBcfGZ@google.com>
Subject: Re: [PATCH] x86/fred: fix building without CONFIG_KVM
From: Sean Christopherson <seanjc@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 16, 2024, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Some constants are only defined if KVM is enabled:
> 
> arch/x86/entry/entry_fred.c:117:9: error: use of undeclared identifier 'POSTED_INTR_VECTOR'
>   117 |         SYSVEC(POSTED_INTR_VECTOR,              kvm_posted_intr_ipi),
>       |                ^
> arch/x86/entry/entry_fred.c:118:9: error: use of undeclared identifier 'POSTED_INTR_WAKEUP_VECTOR'
>   118 |         SYSVEC(POSTED_INTR_WAKEUP_VECTOR,       kvm_posted_intr_wakeup_ipi),
>       |                ^
> arch/x86/entry/entry_fred.c:119:9: error: use of undeclared identifier 'POSTED_INTR_NESTED_VECTOR'
>   119 |         SYSVEC(POSTED_INTR_NESTED_VECTOR,       kvm_posted_intr_nested_ipi),
>       |                ^
> 
> Hiding the references behind the same preprocessor conditional is
> probably the best fix here.
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Late to the party :-)

https://lore.kernel.org/all/20240215133631.136538-1-max.kellermann@ionos.com

