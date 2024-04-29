Return-Path: <linux-kernel+bounces-163024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46698B63D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803B92857DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A42178CFA;
	Mon, 29 Apr 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u26yrP+P"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2121177998
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423537; cv=none; b=ApTVrnI4nYEVVNyi7uBZBjC/N1qgVjwxcDTae7fiQ0rLZVhnCFyKP0CdMSUnGHNDmtuPzmyxFoUMhQj/rNGpQjML9iB/4k4E80wQbTfIgpOk4ilNnO3Q4u8zPpV9kUC6tGvRrc2/7XIUCqajgi4fdMplccf6Yt5QdvlcFxdkKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423537; c=relaxed/simple;
	bh=swqQysmDwMqqr88s2ywDiAH95K0lzxn5LK729hkN2aw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lj39v0mTob35mwRLYWxTyXlqvvjZqVolql9MD5dYPqMzsH2seSugEbfFkac5Rh+vSPJKdhUoAldo10uNhZ+Q0E4EabYrUDQGwhFWbIV0WZLWut9AROCVltk1xiYZdwZD+AP3CSh0xEqsMUNpT9ts/vS1sRmkuOFQOTIs9ucQfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u26yrP+P; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2a1619cfcso40829065ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714423535; x=1715028335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2fmwuVTRYT2T76+zXs3/JLoDv4rTdaNSw/3Jy5CfVQ=;
        b=u26yrP+PtnzcG3AqL3z8fc9NtRzX892JKPMOvCgWvwZ5IQpvlgf1Lc+AsKMVcFd0mS
         p12jdazhmAh0SAyL4nGs9I2DHt5oLXIBbDflElPyHsvTEUkFxD5z9KVjg0ihh4gERNwK
         PUIfcRjHmMTXqvKd2tFG8RsqgKpojZInPgnDBdj01bL6lAj10m7+YHJiJPChznWvsvDt
         GcCoD/mSutsuO98kLsrylKCOESRVM2//IO7X/Q9G4hYzg3Ib/iJrFbMkpMejJ8AR6WLK
         1z99FzK6Nt5J+BBTvPRKJBAGVXeF2cvobMuUryxB3R8CR4KgM1m/uYF3+5y3JKVHgNTp
         u0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423535; x=1715028335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2fmwuVTRYT2T76+zXs3/JLoDv4rTdaNSw/3Jy5CfVQ=;
        b=esSJy3TKD2fSf7WoGxtwl5tOhU5XFaQ5h8pma7fWIAcfQ8331sbkbtRA6+Nuv3bDI/
         tbfWydIqIVcUvsUtW8Al6q9BdGzBN2xwBNKGVockK9rEwUJFCxrG7BsflgshN8JVt/Z+
         6WVsqfdqz2l+qdvI8KivepnQqs7qGLHCMzIYKVAug+lye+uWQdNQVKA1HVI6QGzN8KYz
         tpE0yiZ2/FSkOFCDs/Sui3R1mgQmMM1UokixWSw3kKxhEIsmy79cGhCmQfusY7W4LB5E
         JNZMk4HPwU7kLr/7biZROnlRowvkv0ONtsa24JZOXVoMEtsZZiBrU6c0XOd9FB5s0snR
         IJyw==
X-Forwarded-Encrypted: i=1; AJvYcCUFhW0OVOekReCUKNsMcJ291iKa5GGQKlk9S4ZUyFc7Y+7H+M9CtMFHnVNcAwmvcX5B9+SZGJQeAD4FML62ovUj5r6ikSBqqADxSFyh
X-Gm-Message-State: AOJu0YyUeZkmRzVBijkNOP1OH9Wd8Wwo1Q72pOmtNbF3a/80suceEIj8
	WuEzdiUKDHk1StYoeazrrfKUqHKRAntNXb7pNVfjEY5C8e9kVle5DfFgXNzoGGaFQBuRpaT2/Xx
	blA==
X-Google-Smtp-Source: AGHT+IHTxVOr3Y2390m4Vk8ysi9jybVvKP27rvMP+9atp9ocgxWXWjUvkGjNfYfnlwWwa0iT/CXNfGjzEfY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dace:b0:1e5:5c69:fcd7 with SMTP id
 q14-20020a170902dace00b001e55c69fcd7mr2293plx.5.1714423535293; Mon, 29 Apr
 2024 13:45:35 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:45:17 -0700
In-Reply-To: <20240315093629.2431491-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315093629.2431491-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <171408614081.3338343.3036858355679882617.b4-ty@google.com>
Subject: Re: [PATCH][next] KVM: selftests: Remove second semicolon
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 15 Mar 2024 09:36:29 +0000, Colin Ian King wrote:
> There is a statement with two semicolons. Remove the second one, it
> is redundant.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Remove second semicolon
      https://github.com/kvm-x86/linux/commit/d85465f2773d

--
https://github.com/kvm-x86/linux/tree/next

