Return-Path: <linux-kernel+bounces-168259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D98BB5D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7127E1C223BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8E7E56B;
	Fri,  3 May 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTkdwO2Q"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812B5EE97
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772041; cv=none; b=ENtzoqQayZltxPtgRI5j0ywzrkpjbZIJE0cGOHLAF+VLzf52Ty9ikSgJCRo+p6xv0oOgaiXqFq4qSpyKEewnQgFvhPZ5iEi83qC+Gi0vBSeE4LV5ZwMW4woObM5ki2va/nmOlMee+Q/0TMzNKD1IuX3Z4vRIXfelNzF6CmDA6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772041; c=relaxed/simple;
	bh=36cC8g6JzA71GzN4T022yAAHjxmmp9DkEXU0+S/limo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nqkEXARhdCdjCwK22poiD+ay8xYx7jQdAhJp+u5VTA0PZ+R1GZf/d4TO7poyE3kuBMa6mU7w5aRq8i7q3AOtt8AE9UVOtWHJmUOYu6fx6oszSrN+XiaP6CnGNaH5QvlcGVHC1VIMlrPhB91aweXYPkcFO/yEgEldeHf8y0048ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTkdwO2Q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be1fcf9abso1467807b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714772039; x=1715376839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0iglmd5+pvv0IzZJ2EwpPcomRjeC9m/a/ZDXqUlyNc=;
        b=FTkdwO2Q0qFQI+x4EFaBNyldzsnFxNAEnfuardp4NYCPiKCYBwJynVK4HR4dtGvuTD
         I+giQ9wcxHqax0J8QCj30ocNXI81KDHIpecjPLt8XcMU40OU3E0SSZpPUzkUWLJxMyKh
         cLqbI4C6oUlCBNTqHtMKobRwlngFLlh3m5e/0NgHUdzM/9SuHXJo7vGyPVsL/OXDWSZM
         iBCgato1w6TXbOg+qv+zC4hZatJlq263lAh14lAzkX4j/qnUd0V72LBQ0wthMt4COofC
         Ac470buC1Eky41+o2DVi7QN5xODs0Y+mXZb2NwrFxFwQcBVP9HOfOIIHKBlJ24/u9czX
         btGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772039; x=1715376839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0iglmd5+pvv0IzZJ2EwpPcomRjeC9m/a/ZDXqUlyNc=;
        b=QsFarlBsUfhXMy1P+Yo4dddGBSZtE65sk6kQ88gXv2fHzioaVOvzdj5hseMV+xWxYi
         blpCIUuI8bDKDcnxRT6eifDNTP0h96yZI9CHeQZnbjG6ilTqs6Q9Ulp8thDF8raLcL6I
         ZtIvKTFeR6KhMG+POmuLZMt/pg3qEPPkKTi+rxVtvp2p3/WA6WgXI//FpAuaD4IANaNl
         G4YuihLk0AVk9XbI6Wn9EijfcboqODbOTWaHOL01QtlVtXo0Q9R5JqC2QWjgM+KEHbJG
         6qk6bEeg5/6xviJlpLmtVLRdXVI8taauCaJX8+DH99j8x4UmdXl2Hl+Max5yCGOACxcU
         8rug==
X-Forwarded-Encrypted: i=1; AJvYcCXI/p53qeDSGod0rKobf5P0H4tf9LraZrxpsf5eNCbvlMEMp7FWXBWuL9hnXTX7Lef+vw0TYB5WfjEZ5+LHuiM93/0jzW/A/p5vXmrz
X-Gm-Message-State: AOJu0YwG2tPqJOwEh2/mA+jKGJQ75gpq84rpz0VVycCc9ZxoQs8fTiZs
	9b8k5eS1lShy0Fm4cZAT8aAYPmZYS6h2mLAMZNk0JvtFifYC+Z/wGwiSmYB3M/Tug89U31bAK1g
	V1A==
X-Google-Smtp-Source: AGHT+IF5dXs1fxVhjzOwO9GU+QPtNYVXc/pRtCAsau9j2ShBcSUB/AOahcpvakyScMkodl1gAz1tf/99wUY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e6d5:0:b0:61b:e50d:46c4 with SMTP id
 p204-20020a0de6d5000000b0061be50d46c4mr1000932ywe.3.1714772039570; Fri, 03
 May 2024 14:33:59 -0700 (PDT)
Date: Fri,  3 May 2024 14:32:16 -0700
In-Reply-To: <20240408231500.1388122-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408231500.1388122-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <171465959389.758834.11674247619237178621.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Allow, don't ignore, same-value writes to
 immutable MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 08 Apr 2024 16:15:00 -0700, Sean Christopherson wrote:
> When handling userspace writes to immutable feature MSRs for a vCPU that
> has already run, fall through into the normal code to set the MSR instead
> of immediately returning '0'.  I.e. allow such writes, instead of ignoring
> such writes.  This fixes a bug where KVM incorrectly allows writes to the
> VMX MSRs that enumerate which CR{0,4} can be set, but only if the vCPU has
> already run.
> 
> [...]

Applied to kvm-x86 misc.

[1/1] KVM: x86: Allow, don't ignore, same-value writes to immutable MSRs
      https://github.com/kvm-x86/linux/commit/1d294dfaba8c

--
https://github.com/kvm-x86/linux/tree/next

