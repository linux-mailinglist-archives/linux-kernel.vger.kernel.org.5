Return-Path: <linux-kernel+bounces-52402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6048497A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ACE1F2128F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA1171A4;
	Mon,  5 Feb 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vtae4UTg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570E168CD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128353; cv=none; b=H0sN6e5PPrwYKS0r8Sn0qRPruJPf1aEOuoJ5CS7hIu8GsdqwP2ykCfC4Okcb4K2+mulkssBHzeUURtj/tE2i8MKcJeppMlNAarOKB58rVSXpIaAjSCz/woCuylCp11xn2Id4cdDf7soQNmUw1MixME+gZX6QsjQtk0UqP6g+tTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128353; c=relaxed/simple;
	bh=g3cGRfrRQfifaAzqu+6P17jzpgCcdn4yyTQIo/WzczM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIv7QhTMcQbUzs4yW9lwL9W9Dp8ojA7xSz6ZNluwN7s5vyo2V4uM65Uzmq9qBwDt8WuXJ41xIQWl+9qaqn6Xhy44m4qU+TyBR0+2SENEBqhB0IR+zIr/mdF0AIWdl2xYm0pHrTAzTV7yyJPPTGChYdOtJZGSHDqEwTyRWEooxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vtae4UTg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707128350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZiCSDOMQx0r+Y6ZIinTjg4xtwQtHmbUiaCU/bhqSTk=;
	b=Vtae4UTgU9XrijrsX56fOKZfISflU9+ey1AJbsM3hGoO0lz/5Sjq5OEelxEbn/emjGrRjW
	9hpsVabpw3mQ/D8DsT3HVEGpMchX6ZU5yKwYw5JfCrQ0Pz4YSo7QBfaRSAWsTy2wmzKkXo
	L0Z/gL0KFLZWaUi7xhX7fRR07Stituo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-6q4W6vxaOky5SAUsR1E4zQ-1; Mon, 05 Feb 2024 05:19:07 -0500
X-MC-Unique: 6q4W6vxaOky5SAUsR1E4zQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6dbd919aba8so1190966b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128346; x=1707733146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZiCSDOMQx0r+Y6ZIinTjg4xtwQtHmbUiaCU/bhqSTk=;
        b=F+ZpiCGpNVwvsDYnjGonOUxpn0VTzEkCiqgsV9bVsDj/ryL6d5gCBeD9btBanI7EIY
         2RzdXKm7/C5t+A8pQFSONkoq+kpSbMuXUhAWqCAe8MhO+gPpGjJXqCl4ag1YfPNF2ftD
         THlLrmTJLBh2I0TmIqYLPwDc4Q4c+ny4ZIdRaB1S0pdPeycFnX53c7SAZlfk2Tr82/6L
         TDquJbhu+bPhTG0ngYFH/8SmFwFFAo8kHvdOtX2cIKT5WpLUGIS9LtOKUIcjG+fHn0M5
         pzMZJgtoWFIeJKBOlmpV/WkmDPi+Em9YqQZN4EFtbEcXZhFZrxs/yOUDJcX9jl4kKiwj
         gpfQ==
X-Forwarded-Encrypted: i=0; AJvYcCXORhtc0LqrD76QDNGhsCUMLEUPGin5NroCpixoNt4zPDjIKz/S5VasYlTL6QiBrROv3XKOmofKOo43RF0XkdbluAKg8EkAfBWCP94k
X-Gm-Message-State: AOJu0Ywai94WH74Y66CDOoAtK8k84hksIG41xKzHP7KXmwT8ZgBL/ax8
	XcyXNeeuZRwKrYGQ+rI03GzFrFOsCsu/NnLWx1rpnBdTfAhSfCDVTvXhEOw1xF+GRC2I89Tmn2Z
	TwvTUnRtMRchM3+HtJveQRW12lwhryGYBzVr1fxS+Bc5rIKxRZqLPUqlH7cIVMg==
X-Received: by 2002:a05:6a00:1d0a:b0:6e0:289e:dff1 with SMTP id a10-20020a056a001d0a00b006e0289edff1mr5974088pfx.3.1707128346145;
        Mon, 05 Feb 2024 02:19:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZQKDRl8o/1iGPsIhVGprocCxPa5Iz8Kku4Tx6ex7yJJMOtqiMdEBAu3Ka9koR2yblb65raQ==
X-Received: by 2002:a05:6a00:1d0a:b0:6e0:289e:dff1 with SMTP id a10-20020a056a001d0a00b006e0289edff1mr5974078pfx.3.1707128345807;
        Mon, 05 Feb 2024 02:19:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcOyW7mMT4wB0Jt5DexfvWge30XrJlhInrF+qP5V+8o0oxx0d7VYCrBOqMPA6WH87JS/grX1xKzzyu85Lfeai2+3Gso0RN5IKzCdXvG7crSX6WyfwNScbtmJat4fp8eIHrhcmR4T/zr1n+S+Q+GFSnSrVsoG132/o9wXxT3eyXMHuMeC18Jmfi5dTBEGFwBf9Kn+YciP/UoIfnkTTYoyx+pUbzBr8maQ==
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006e02f4bb4e4sm3753931pfv.18.2024.02.05.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:19:05 -0800 (PST)
Date: Mon, 5 Feb 2024 18:18:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: selftests: Fix the dirty_log_test semaphore
 imbalance
Message-ID: <ZcC2EJEh9lGG-WyK@x1n>
References: <20240202064332.9403-1-shahuang@redhat.com>
 <ZcCyzrUhXSlhKyqC@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcCyzrUhXSlhKyqC@x1n>

On Mon, Feb 05, 2024 at 06:05:02PM +0800, Peter Xu wrote:
> Shaoqin, Sean,
> 
> Apologies for a late comment.  I'm trying to remember what I wrote..
> 
> On Fri, Feb 02, 2024 at 01:43:32AM -0500, Shaoqin Huang wrote:
> > Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
> > the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
> > at the end of each dirty-ring test. It can cause two cases:
> 
> As a possible alternative, would it work if we simply reset all the sems
> for each run?  Then we don't care about the leftovers.  E.g. sem_destroy()
> at the end of run_test(), then always init to 0 at entry.

One more thing when I was reading the code again: I had a feeling that I
missed one call to vcpu_handle_sync_stop() for the dirty ring case:

======
@@ -395,8 +395,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
 
        /* A ucall-sync or ring-full event is allowed */
        if (get_ucall(vcpu, NULL) == UCALL_SYNC) {
-               /* We should allow this to continue */
-               ;
+               vcpu_handle_sync_stop();
        } else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL ||
                   (ret == -1 && err == EINTR)) {
                /* Update the flag first before pause */
======

Otherwise it'll be meaningless for run_test() to set
vcpu_sync_stop_requested for the ring test, if the ring test never reads
it..

Without about change, the test will still work (and I assume that's why
nobody noticed including myself..), but IIUC the vcpu can stop later,
e.g. until the ring fulls, or there's some leftover SIGUSR1 around.

With this change, the vcpu can stop earlier, as soon as the main thread
requested a stop, which should be what the code wanted to do.

Shaoqin, feel free to have a look there too if you're working on the test.

Thanks,

-- 
Peter Xu


