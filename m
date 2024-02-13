Return-Path: <linux-kernel+bounces-64225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBEA853C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AB61F256C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105360B9E;
	Tue, 13 Feb 2024 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9zMfEMf"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44BD60B8D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856193; cv=none; b=Lorv5nn+d1iNHWQBKDQJIQErVnldikjgH9Zh3ryJ44DdLUqhch0xY6/KV2Bd2/kdSHK44OvFOiTH3H8GEGniG4GqXrUn7OGarTZ/t27nzik+fuk5UhyNNaT+aNunkyYPRGsmR/lR2tvydFxNaazP951/2vM5E+sXOXO1hXDiEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856193; c=relaxed/simple;
	bh=UEVO0B26uhK0w0gYwAWEhrJzXFGcmP6byGGLKq+PWvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/m0K4P8ZVc9dwl+cCY3svdNvu/ZhImHYRDp91ETOWGRJZl9hH1hfZ/WBeF1QBidmk0GPQTGGh8hCJXy8Snw8eOiBLXkfV46HLs8+ahguNUfzUPF4qBSDIs6qfSrd6K/4EYbrIZKFQJCqN2VJAwXW/yyWhtGZnxW/QyZmpmuuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9zMfEMf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6078b764778so20450737b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707856191; x=1708460991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/4WgCQSUw1TXLBEg/cdyp6BGe+F8+Dx7OhLtWDh8xI=;
        b=P9zMfEMfj6jppf832Q5adIVvwOD5JdPoc1IDoZG+KHvXQ9Or9td2B3fCoYfjybiJzK
         33Wof1ZaaDkMXURv+xsWKUTMrdYonqDWc1tls658COKCtxKwJrR44qA1rboE5nQylYmn
         JnE5AT9kJ+HWnsnqfeUETQBbFbdB1hjtN35v1IxO38mQLecDiQ08p5eOEshFmG26lU7Y
         ceBrLC/DD04jCYnTbQxGes5besas6Y6EalJM8H+oPNXGRxgnuJWB43rej5maUyzLBy4a
         bE9gU9jmFhuvvpsmFfgFSUHDLMnDBvpvQLFUt0320io8+NfSxzh0o2JnCYFNux3Wr3o/
         fM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856191; x=1708460991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/4WgCQSUw1TXLBEg/cdyp6BGe+F8+Dx7OhLtWDh8xI=;
        b=jX9dAkp42yAmTEPrPOzattaia3+qqdxB4SCfA8+WfzLoOLsdKvJMJJ3OWXfuypq+jj
         b2F5ZocOR/TAUNS5xpWOjG9ALN1ooLXIrCZ+NCtshpuO+UoZ24HQkmJdBrmL/xDQ77bu
         RbnpKXK6JfvJ2qAY+EU3nvkIm2eEwZHiX3kJfGa1nmasiKUTj0/faxNHwBpNY0N+ALAa
         31KVEf2syWEq5DHoUByS41uzKN3Me2/BezAtxPnueL//jYfM1+3rDngYRmPdPydf30O7
         WsiIP9qzKtjMDG3U7tmpbcBG/+6UCtFZ4QH12IE9F5FTyehYOu6d8qTpX3vtZSgBqGoA
         EBDg==
X-Forwarded-Encrypted: i=1; AJvYcCXCRev5F+zToe52sfOfmEH5JiUGjjTvygZziBMyUWNjFw2TMa79eNxatRHz8Tajt3msPnPUjKP00iOffL82W3p8arhBVgFKYGzXZevu
X-Gm-Message-State: AOJu0YwKHB1RTVVhntGAYvCa/eCdv/kYmT6H2UpRFU64uCm05KtnyTDt
	niplIHPjfwMa06f+el422DhRIpe6j5dV7DVbKzcqpZ9wrfbhw5XogyEN9jOZHj6kV3ZqnU/VrAT
	EzxGx9xH6z0CJalRAlQ==
X-Google-Smtp-Source: AGHT+IFUpetQu6KwC00uaQK/HUEiM8lKKNaIEqPcnbDpHfhpKTjtjwUKHH+Y9Xx3e3TlJKreq9z0ndGHYLkZpwPZ
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a81:5254:0:b0:607:87cd:a94d with SMTP
 id g81-20020a815254000000b0060787cda94dmr96969ywb.5.1707856190871; Tue, 13
 Feb 2024 12:29:50 -0800 (PST)
Date: Tue, 13 Feb 2024 20:29:45 +0000
In-Reply-To: <CAJM55Z9MOoZ3A=h4uFaO2hD461U3BMDyWxXLBt0tUdOuJJ5t+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAJM55Z9MOoZ3A=h4uFaO2hD461U3BMDyWxXLBt0tUdOuJJ5t+g@mail.gmail.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213202945.2554307-1-ericchancf@google.com>
Subject: Re: [PATCH v3 4/4] riscv/barrier: Resolve checkpatch.pl error
From: Eric Chan <ericchancf@google.com>
To: emil.renner.berthing@canonical.com
Cc: aou@eecs.berkeley.edu, ericchancf@google.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"

Hi Emil,

  Thank you for reviewing my patch! I appreciate the feedback.
  I've updated patch v4 at [0].
  Please let me know if you have any further questions or suggestions.

[0] [https://lore.kernel.org/lkml/20240213200923.2547570-1-ericchancf@google.com/]

Sincerely,
  Eric Chan

