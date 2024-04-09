Return-Path: <linux-kernel+bounces-136114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0789D025
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026CE1F22BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46B50251;
	Tue,  9 Apr 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCUhcjb5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AB4F887
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628104; cv=none; b=D4d81iewvxPneqXdo8HUuZx+qbwVyWjROQkI5CMGnpeF5DEGXwR989Fe60XIXZWoMAicnsSNOPPolbOKQ58HgV5+LifCz7NDhsgTl+WtxA96fsAq/dkZsGtb7lfkdOj2enpYtB77mbQhzHCKyLxjMnQnt0XTJvmL7Bj9c0iISyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628104; c=relaxed/simple;
	bh=R6wBWyvbKby2JcJVzeeM1JrJCn8KU1dV5kM9O1XYv3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NYn+ik+7rjssDtGBf6flFnyq/10YNrqEAQ8O9oBVz4mT7kdiw8pL+HTv8pg1ECWxIgjd8fK0vMWJcUfA7slM46sksTI4d0Z9iizashtOOWe1SqIipi2UiFT0+nSOeqLom/p4vmat2EjwZ5vQ1W37jlx0cgny91GAsqfXwePXPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZCUhcjb5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2b1b90148so36676795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712628103; x=1713232903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0MyZK4MuxKPsN1IFuhdXaa5jTxGtBSl229mSO00MeI=;
        b=ZCUhcjb52QfkkFes1dMyrI8FuCUbanlJSdbQVHCMie14W5/7Db6S9zRI/EIw2a7bz7
         j9hllqEEIwbnw8WOOY0tYWyRtBqi1anNrq+QOqR95v++Xo+Z4TpIe8l6OldodNHduR6v
         aeOek1YYXVsGEA3F6QEG9r+eZ8gG86ydI/uS/uHndHxD4OG4Cn+En30dPrvjhbIT31Bc
         vJy7vMQVbwayovf/+ntEBQdSl3ehsixSlcPgaWSeEr5D75i9AbaYHxaS5OZnrp1wa6SN
         HOi8//TtyxdHvuLNO+IzYeYySs54xVJJG2Pi/SOnQJG0iyk4RZOsjS1IakklWCpylAD3
         RHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712628103; x=1713232903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0MyZK4MuxKPsN1IFuhdXaa5jTxGtBSl229mSO00MeI=;
        b=fy9poUkYv0d+J8Ux9YP3ZXp9euwcqbaTaLB8Kwmzisx5gTa6uGMaSQr5sqfYVtfHZM
         1Alxb+3pnGL9WfL4M5C50JSygb7Oi35dCSjZraOESd+nEhEOJEq3zbQr9cUZQvEhLulX
         vVP3+/cwVH67EGCEXJOgWQnKA68CcAS7fRwDwInlmMl2amkNr8mF0+Kar13PHkZJKg52
         srW2CYMG+2bnpkfXSSNrY9pWqhDkvpz6uu+j78AogNmGbKPYnlpQ81pwMUaggk/Wi50C
         bXaYJTNpj/DYu1V/EHhhRs0X+qm/ETeeE1EhbWBcef/kre9FPtSaFzWmo891/dEVZ345
         12Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXPlAOi0WzMpH2fMESN/EviBqfYR/2sk1LOHK04svrdmcLOe7qgBfgKie2W2PYL6DTU/yh1DlQLPsHhzId2nKjiTkr52vob1TqsSO/R
X-Gm-Message-State: AOJu0Yz30mgiByq9FjhsD+dj1gKkNQ9AOBXXXapI6ytjxLA7hGpZQQFW
	d6AYV2r3bBvpFPDzM5dLlF8quybFAqB397ujjJHwDl4LjhiIhjYZKNzZNZZj1/RYgOW6EaoW8Ew
	NjA==
X-Google-Smtp-Source: AGHT+IEIPayHK+UX+osTqfTWTO/3CwsU9ry/srH5ydOUG3vLHFJYt7lorcS1BHoOUKDu2QDorHh+mWnI7pc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50a:b0:1e4:881f:bed1 with SMTP id
 b10-20020a170902d50a00b001e4881fbed1mr92462plg.7.1712628102823; Mon, 08 Apr
 2024 19:01:42 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:01:25 -0700
In-Reply-To: <20240314212902.2762507-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314212902.2762507-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <171262711269.1419750.7343660666296265143.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: x86: Don't overflow lpage_info when
 checking attributes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 14 Mar 2024 14:29:02 -0700, Rick Edgecombe wrote:
> Fix KVM_SET_MEMORY_ATTRIBUTES to not overflow lpage_info array and trigger
> KASAN splat, as seen in the private_mem_conversions_test selftest.
> 
> When memory attributes are set on a GFN range, that range will have
> specific properties applied to the TDP. A huge page cannot be used when
> the attributes are inconsistent, so they are disabled for those the
> specific huge pages. For internal KVM reasons, huge pages are also not
> allowed to span adjacent memslots regardless of whether the backing memory
> could be mapped as huge.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86/mmu: x86: Don't overflow lpage_info when checking attributes
      https://github.com/kvm-x86/linux/commit/992b54bd083c

--
https://github.com/kvm-x86/linux/tree/next

