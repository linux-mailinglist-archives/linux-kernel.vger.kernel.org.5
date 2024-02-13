Return-Path: <linux-kernel+bounces-64226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A7D853C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AC02850FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82643612DA;
	Tue, 13 Feb 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAWKHQ+K"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21E8480
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856232; cv=none; b=A4tZyoWd+wJN3JofM6CBPtnUXE59McAqNhoIGb97MaX/d1sIDMdWraDwiQcJMgENuBpxx8sFRRXobmJ90sZ8H2UiPZ7qNDQL6s0oNED79PLeq1Myoe4TX8aYEZdd8daKicgqf6eSPDkTWZTC08CAykuS2O/NzT/ioM872QTZaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856232; c=relaxed/simple;
	bh=PesFFSKJWcXTA7xOm4UNGbifKR6N6hhjwm4Y+slzZ1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ikkyWvG2atANNGITb2pV1Sk/qQ3CmPg+0mZ+WCdScnRVNPiZgc519IMxF5jMnUXbPS0AgZNan12Pu9gfm/FpWa5EkB6kE6PqHSJRuekoLZR0MEyFDIUdqN9qlI74334hjAG76MDydb4WyTzKlfSlGPTDPlJxTAxctNV1GTwKNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAWKHQ+K; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso2225695276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707856230; x=1708461030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0uuu43lTFl8r6pWLqrwjRtNbmG7fv3pMPO4DSIXq6o=;
        b=RAWKHQ+KZUZcY6wHkuIDNhl3No2GeVUwOAcadGunM4v3wF+gP4MUzXjhQif3FmkmEZ
         4Mgokh14hdwYhTNPFXmX46qdwu74xl9LkZhmI7yZbSCnAE0c73DuwyoNCvttbhtFozYt
         G41skr9ormW64WjywJHnc7nwjgymdg3NPSI/9kxE8UUxXeg3FOVkbPOcg9g6dg6qU0y/
         9WBgOzvzj0ksm73fEj2dKuXaCd7SmqVZRK94rMN2bXY0mlnlhcNeG8qiV3GELbelrQ1b
         404cjqAXsHA5pwF1LoHfcwTkaQWkqU6EQ7pINAD1QV+pH+JKRZh1DrVAYBGy21QDQTer
         J30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856230; x=1708461030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0uuu43lTFl8r6pWLqrwjRtNbmG7fv3pMPO4DSIXq6o=;
        b=wNsa1JSeLngLrVc8V/l1g+WYuih1LUouJoPHI+5f+Kzj/Ae+x5pS8b1x3kEMAxflgS
         6rS1WjPSoaFAq5Y9fQFnXv9qfZEW8GrOuEkizfFz623oDNsJG/1ZsaOpyCbiY+rquUd/
         701l2B1ju/DYE93r1AR3+mwbmAgauc25sNxc3jSS6lEY1r0EQ7OuN7vHRkIk711i/BaZ
         k4oLkWOB2puVh/gVGuI76FvPHUXiWSQD2MdWZ69qru2XHwrvelnGFGsHNhLNnhbWIbRV
         WKgaIP8x4mbcDFnOrbMm5EqO18JKJ+4of+GQigiyxu/G3UZjcwLmr5mCp/ysbpJH2/oc
         vabw==
X-Gm-Message-State: AOJu0YzOV6RsC0srnBHwU5owCi+yWgQpTFuiYWkzzgtt9JsqYncTQFYA
	buFJCCVOrzj17LbLombvzJ850gJgJoMSn46YPbDfkT+5lR0JBcN3KtizSV3Qh0hHu5SgN1hXJwW
	Jp5q7JSmiJA==
X-Google-Smtp-Source: AGHT+IGjwC/aRtmU3dUlV7LcK8rWJjH6CW+/wjLKjuzsyl0Q+RyEB0+pFjVl8VQJY4ly96hStj2Dh7r8d6xQ8A==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:6902:1027:b0:dc7:5aad:8965 with SMTP
 id x7-20020a056902102700b00dc75aad8965mr34184ybt.0.1707856230329; Tue, 13 Feb
 2024 12:30:30 -0800 (PST)
Date: Tue, 13 Feb 2024 20:30:28 +0000
In-Reply-To: <87ttmch7k0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87ttmch7k0.ffs@tglx>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213203028.1593499-1-pranavpp@google.com>
Subject: Re: [PATCH v2 2/2] alarmtimer: Modify alarmtimer suspend callback to
 check for imminent alarm using PM notifier
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com
Content-Type: text/plain; charset="UTF-8"

> Why is this a warning? If at all it wants to be pr_debug() and the
> __func_ is pretty useless as grep is able to find the string, no?

Agreed with the pr_debug(), doesn't need to be a warning. I had
made it a warning so that it is logged by default (KERN_WARN),
so that it can grepped for without enabling dynamic debug for this
module.

> How is this supposed to work? rtc is NULL.

alarmtimer_get_soonest() has the following:
	rtc = alarmtimer_get_rtcdev();
        if (!rtc)
		return 0;

rtc is set in alarmtimer_get_soonest(). If rtc is NULL, the notifier
returns NOTIFY_DONE before even reaching pm_wakeup_event(), hence there is
no NULL pointer dereference expected.

I agree that I should move it out of alarmtimer_get_soonest() and assign
it before the function call as it is unrelated to getting the soonest
alarm.

> How was this ever tested?

I tested it by forcing kernel suspend writing 'mem' to /sys/power/state and
using a large window (120s instead of the current 2s) so that a pending
alarm is likely. The debug print is logged as expected without any kernel
crash, and the suspend gets aborted.

Thanks for the other comments, Thomas and John!
I shall send out a v3 with all the fixes.

Regards,
Pranav



