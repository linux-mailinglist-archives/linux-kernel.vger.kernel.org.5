Return-Path: <linux-kernel+bounces-168260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28B8BB5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FC0B24523
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA05A79B;
	Fri,  3 May 2024 21:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Et1FCOL4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9458AA5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772070; cv=none; b=jRCHKk9CXL2+s/YebfPx2IV8stbF/9xhgkHoT6t9Iiy3Os5C4OXk0R2YLRddMmhQlJA40uWbeADxmNC1F7wFT7bWhWQhucdgQ0B5I8hBKVX0Urh2cCOIbeaP84o0FqLk7DWKT4s/DSBHIsbuWCQI3qLxlVt43k/MagZSTywOZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772070; c=relaxed/simple;
	bh=oq0unBzSDZxfLcXtYKNrFLrUch8MutkRmuUhAom/O00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F06gK0rL3uOC324tb292ai9YKhsCtK74qyQ0YDOz7DLFGWnoIrtYyjj03516nREi6AS3JbuwAxQVBenI/aXyrymv8tMFfFdWIOA/Z2RBVILNHJmjpx4sNF1D3+tE5lwRzHhH+NsGRu6mKtP0EY+mXQ/Wg8lKb+iw+B1ZxDhjP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Et1FCOL4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61d21cf3d3bso1432627b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714772068; x=1715376868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfDtOIpv/VQBANmhQA7+/FUy8DMKChgN64LUKk5KMsI=;
        b=Et1FCOL43rZ1qxj4F4U6+NFEVT8IyIQgUTGCVAG+/omDfGUzjXYL5GYPiz0CNP4YHu
         hVXqw290eFeen0rN+ROGHFkrNk1DpOolsvxJ7k1kZa+xlTE2DsUc/7bCV7ziDF38KDyQ
         RrvLw0Yf9K+cK5uu7yJtuDKiQtXIriP09iaxDQBK2brpsF34iNqIf688w/RTGpIUkNdq
         XeavoRmQYBhm830MjY/9hXHUSk0k/thA0OWDvd3b4ABnOpClTrFLEpbszWX1Ih3eUFsF
         ldaXPNDyuo8t9AgWQ4ga0vwfLUuR2c9Ci+fWNv0Ugkq05Y6/a0Yyk0zXbM8JqB5DvzOR
         e3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772068; x=1715376868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfDtOIpv/VQBANmhQA7+/FUy8DMKChgN64LUKk5KMsI=;
        b=bNz9TkNCu1h7l2c0ChpPZT/jUARZN9AJ9MHy4ZlFMW1bYD21YRhK5eJBRpWGc2SZmQ
         u2OIYdqEk0UpVA6Dx8ubJ3synyHP/v6yTX4xoXUJQkb5DTiCDP3Zly7ToxPBiMDPesOh
         AmD9KYOz3P6rZeCz8GvV7XLiF6BXcmFWrmG4dAh4vw5/6sRF5DIOifL72Lp+Ou/4TG7d
         IBhxQArf+Ejb8MgCOkiVxeM57+2+nLGxqdIdHSP1wBn9B0QsBiDdA+x1e1WKuPDdMruq
         r6amIKPm9+j6tji+BwYYYUS/ispym0ZlE2g10QSUryG2bnqCmizEUtYrGJE6NpTqdeL+
         Ouow==
X-Forwarded-Encrypted: i=1; AJvYcCXM4qcdqzaRRCZAi298u7OV/x1wmmvvMLoOa/V1m5Rs96r59nru6EhevpoF2Oe6LR3+3QIG+GIN/+OJXEGUvRXz8tHcinaiy8mxFXaq
X-Gm-Message-State: AOJu0YyphtC5+0lHrU/hCoPfDukkr7z0B6TKUi9ZFhv40ffjw+P9P0V0
	nquFzYOoHRgOZsK6d+duxk5eeF+yE/kl8k15m5jY0gKZSw8OWPiYQPSU+rCue8eZIs1iIvz0vQg
	CGg==
X-Google-Smtp-Source: AGHT+IF/se/5We+ADnMl1CUfttYfOuat1yw+wr3JyaJMsRPfx1XmFzz6oFuflwlXtV+V3r+BecrwvQkFOUQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a147:0:b0:61b:e103:804d with SMTP id
 y68-20020a81a147000000b0061be103804dmr779582ywg.0.1714772067906; Fri, 03 May
 2024 14:34:27 -0700 (PDT)
Date: Fri,  3 May 2024 14:32:24 -0700
In-Reply-To: <20240423193114.2887673-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423193114.2887673-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <171469177238.1010157.17892485185197174264.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: x86/mmu: Fix a largely theoretical race in kvm_mmu_track_write()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 23 Apr 2024 12:31:14 -0700, Sean Christopherson wrote:
> Add full memory barriers in kvm_mmu_track_write() and account_shadowed()
> to plug a (very, very theoretical) race where kvm_mmu_track_write() could
> miss a 0->1 transition of indirect_shadow_pages and fail to zap relevant,
> *stale* SPTEs.
> 
> Without the barriers, because modern x86 CPUs allow (per the SDM):
> 
> [...]

Applied to kvm-x86 mmu.

[1/1] KVM: x86/mmu: Fix a largely theoretical race in kvm_mmu_track_write()
      https://github.com/kvm-x86/linux/commit/226d9b8f1688

--
https://github.com/kvm-x86/linux/tree/next

