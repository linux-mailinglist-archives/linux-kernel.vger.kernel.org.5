Return-Path: <linux-kernel+bounces-130304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6249E897694
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D211F2B961
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD0158D7B;
	Wed,  3 Apr 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRzAGhJ4"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8A158A39
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164685; cv=none; b=PciEMcZFyOXs/NoIl+6Vc9xt3U9HkpmkY1f+ZFVuLEOL0cvPcyT/wcqXj1VEYAhhTBhUyfpuguCfcaEo6spm9OEvANBtEyf6f8qQ58rrDDGIqjfzWwY3IVeNORWNkSz4d+4EVxQSYjiZAqwBR41pQXkUJgPWj9s0OaWc/d+7pr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164685; c=relaxed/simple;
	bh=cgIpFTm99MpdTzyPZYKw3D/coSq1ZoRn4annV/LzkvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8cma77K/yHfRhuDKQ9QUJuTFm5I/hzkVrX5Fcve/Z5yMh4xLmHWne8i5XW62apyMrRSEXmuQEs42ZPsT+QuKqtSdl6qdPAdmqtOBTXB6UG/hvAnrr4dt0XcHvND1ksnUJUJz68/lyRuPZXZ1aVNdJz6tz3tyLVcsSYV6fxTUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kanepyork.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRzAGhJ4; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kanepyork.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so7708039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712164683; x=1712769483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkcCXkYZtxutNxWMBfyXkJ46XFZsRUkulK3ZanFA0o=;
        b=LRzAGhJ4ouI3rFLgWzh4+u2zHBlLtSj5Tqn7OzCfcEJb+bee3qOAYcr6coE6vz6Uzg
         fXTPYQ0mjJQ1joWv+vz0WG1GvjNtFwsLGA4f3nctSF9s+HMJAoCaM+dnceSCmXusM5un
         oWRwbre4xLMe4GNq/rLk5ubLxUQYSiPUgx5ZmeUzQH0MR8r/yLgW6wlk1aLox2H36k/x
         MPYh2Ogsf6ZFt20liE36b+2+ZqBPHYlKz6TMNmq1oMnX91RBdDLK28Ooqn1S71eNPE/m
         DyUFdkrNaEnRFtc32SZLVO+CUMhgIby/vibpqIV7UgXzy6htrWij0Z9qTebNtw1GXojt
         g/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164683; x=1712769483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbkcCXkYZtxutNxWMBfyXkJ46XFZsRUkulK3ZanFA0o=;
        b=fpPpPkJgPTcbkCi/vqy04Th1VT0hpjvgNasbBogfKkvnnuo1b2MVKQpNN/rLdCvlL2
         k1KB+c28R/RxruSV0h11HrM1sAhoYsFI1ps4v7P5NtdEVJT5irnmpg5qkAumg/WfKmuN
         foDgK/WA/FxtV2g09EYKeWy27p39WZahin2KfrXjeC3MiP6XPd+b8cVIXD4P8vDcLQiF
         jAa6m0pNRZVmS+WExMFakfC/aheJsqv606aIf08dk5iRvzJf6dWfICReZYxoYbETIwRH
         d9znPM8lpUpg2L8ua0R9eYWjKUq+LdBerwBplHwc4z4vYqVWtfQjLhViFOCVFktfYBIT
         7+2g==
X-Forwarded-Encrypted: i=1; AJvYcCXicXmPKuq9UwmhN/E1DbalewjKKHk6P/CiRQxJk+zfULWWk0AAMXYTGvpXGclZ7ZgHnjOkPQUpDfBrXtrcBM9CuyBlW9bUXfBRTlfJ
X-Gm-Message-State: AOJu0YyCse8S3ejFgKLgYSl6wYM6OnCh7E3avEkrI9as4ndJJqt8ZcyC
	fKQ02kUddXrAl0IonuPNZgzawuRtrmfkb3TKVvpJO/4khABhJR6esNJUJdDSK+c4BY9uoTK1PiP
	sXS+Zq050OAE+aA==
X-Google-Smtp-Source: AGHT+IGDgAUSghRSCaSK7FjK7l3p/vhfcyCUDJB3xx9wufV3VhcTqFeASbZhs3nQpc/lW/EtiNCOEuhK8aWBfXs=
X-Received: from kanepyork-c.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1c38])
 (user=kanepyork job=sendgmr) by 2002:a05:6602:27c9:b0:7cf:16d5:181c with SMTP
 id l9-20020a05660227c900b007cf16d5181cmr12816ios.4.1712164683013; Wed, 03 Apr
 2024 10:18:03 -0700 (PDT)
Date: Wed,  3 Apr 2024 17:18:01 +0000
In-Reply-To: <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403171801.1774333-1-kanepyork@google.com>
Subject: Re: [PATCH 1/9] rust: list: add ListArc
From: Kane York <kanepyork@google.com>
To: aliceryhl@google.com
Cc: a.hindborg@samsung.com, akpm@linux-foundation.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	colyli@suse.de, elver@google.com, gary@garyguo.net, keescook@chromium.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	ojeda@kernel.org, pabeni@redhat.com, pierre.gondois@arm.com, 
	richard.weiyang@gmail.com, rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, 
	willy@infradead.org
Content-Type: text/plain; charset="utf-8"

> +impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
> +    /// Constructs a new reference counted instance of `T`.
> +    pub fn try_new(contents: T) -> Result<Self, AllocError> {
> +        Ok(Self::from_unique(UniqueArc::try_new(contents)?))
> +    }

This needs to be updated for the `alloc` changes to accept allocator flags.

