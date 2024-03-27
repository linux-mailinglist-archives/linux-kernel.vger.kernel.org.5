Return-Path: <linux-kernel+bounces-121573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED588E9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089B51C31606
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3F12F584;
	Wed, 27 Mar 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLPjnDHg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F961EB39
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554540; cv=none; b=mnybBtPQo/k67XwW/obyrEaDI6BRTS2SaBj5q36bizcO1YMG5D9+MXeCpIBk3FSDwlKY/a6yOlqaDbdPRRuDwK3Nx738EyhZi+HPcWKDqqlfT3+VGLU0VVjK3vi4Zwae5PdF1frr6Q22fUu0SLPnr4fJke9MxaeCQJruLEfhf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554540; c=relaxed/simple;
	bh=1JEBFVvgpt+AK0UYB8PdiFuLztxGMTAvlKxCQtFg5ow=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=adeadxlNF6PYNqkxeZux4EZmkmJEniAELz5Zyo/LNJdtvAP46pFiCKt8I12wa/YShiHNxb5U5O29KWjPpg+RAuzEe2a29OykPblMMtdIUTi3FsEGKeBCuGXh7EyeNtlAFEcbe0S3LTcbBl/N/CtroAdBaLJhjKnKHbECtt2QQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLPjnDHg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711554538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=1JEBFVvgpt+AK0UYB8PdiFuLztxGMTAvlKxCQtFg5ow=;
	b=bLPjnDHghe6O0E2YGtBUsbBmwkQagb/R4erDqxad6myv9e8/XbalE6dgM093zcY8vI9hc8
	04zyfP09DxfviHqNBWtOnuioTVvVWhN4fLJZP/d4OgVtlV28G0XJGiDOnPcAuM4BfiHd8J
	XfrZZci7uv6uoThI27muCiSeG2Q2kNU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-DU0fDMqSPzexVt38Jh1uFg-1; Wed, 27 Mar 2024 11:48:56 -0400
X-MC-Unique: DU0fDMqSPzexVt38Jh1uFg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d491456df2so5143851fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711554535; x=1712159335;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1JEBFVvgpt+AK0UYB8PdiFuLztxGMTAvlKxCQtFg5ow=;
        b=g4rWB8nmndQe6ivInXjBXaoGkxnMVS+ymsbQwxLtH2UPeQj7nv4P497OM/0AJDQSt3
         DKOdHVhrESPnLXzLAnMRJwNCcwj4hm5jBUEgbzsQbODazMDODPoVRTcNuBqwC1KSI7GX
         q4Lrx96YK5kPvc0ZGclzhhqu7ACv5qGwlyujkfiew06JOOCIicFvtIzwwdVvVBivXwGT
         2hl1eHoPiQAoeG2n8Gb36D9jJ6+KoZGhMEvlHbiTsMfPKKJN403NOh8KTkrpNMuKQoWz
         eJd9YQozxRHhdJInPZpfqDKxIX869386+uDvunmM3hems/SEMW+CPfuWiGhroN+w0iG6
         vZ1Q==
X-Gm-Message-State: AOJu0YyXIS/Z6FowkcDj/16slqUZ8f4hodA0RAtGeemaoUA/BwUhOo1V
	7ebfilQlMsTe5oSeqq/8SHQFVjAr9i/fT8ID2HThnO8DHLvQk1cbINrjhjF1zcFSwylAHc3RQuD
	zlrP2bHSU4g0iW25II28Z8YySRdm94ITqEW5IfmZC4gBQ0TdLpdFkkq1/hZtDmc0WERdFt9CirC
	ow5raL8IUke4Y7TzUmOCnhLyLF+57ziiziqDs50KJ0GxUW5zE=
X-Received: by 2002:a05:651c:150a:b0:2d6:f17f:f975 with SMTP id e10-20020a05651c150a00b002d6f17ff975mr1855338ljf.2.1711554535050;
        Wed, 27 Mar 2024 08:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi7a+HqfScThf7Q1EQVy43yWBkUorPXtKnUtUHAdaE0/GM2Yc7Vn/QFi2fBEPvXO5LnKkfFNH66HKUacS0KGM=
X-Received: by 2002:a05:651c:150a:b0:2d6:f17f:f975 with SMTP id
 e10-20020a05651c150a00b002d6f17ff975mr1855335ljf.2.1711554534718; Wed, 27 Mar
 2024 08:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 27 Mar 2024 11:48:43 -0400
Message-ID: <CAK-6q+i_r3obNeD=DLMRp704pnoSEgeMAv3EcMCg-r0_nxM9Dg@mail.gmail.com>
Subject: hammering timers cause soft lockup?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am currently trying to debug a timer issue on v6.9-rc1 and was able
to write a small reproducer module [0]. If this module gets loaded I
run into a soft lockup e.g. [1]. As far I see several concurrent
timers are getting soft lockups.

As far as I know, I am not doing anything wrong in my timer module
[2]. Please somebody correct me if I am wrong. It does not do much,
except hammering timers. I tried a longterm kernel v6.6.23 and still
have issues.

I appreciate any help somebody can provide.

Thanks.

- Alex

[0] https://gitlab.com/netcoder/timer_softlock
[1] https://gitlab.com/netcoder/timer_softlock/-/blob/main/calltrace_softlockup
[2] https://gitlab.com/netcoder/timer_softlock/-/blob/main/timer_softlock.c


