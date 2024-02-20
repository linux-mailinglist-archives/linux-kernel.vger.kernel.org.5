Return-Path: <linux-kernel+bounces-73709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF5485C6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD3CB20FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF64151CDC;
	Tue, 20 Feb 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZ4gpzuP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8314A4E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463030; cv=none; b=rsz7N4sH1wF3DNRen7yjY9B7ZwSMvbt3+SHy4adE4HllBYWA3bTLeEHWaf/jLGl9Yb80i7aHoR4K4iyeRJq5D6LfF4uDSXE33V7EIWwVhFwCdYMOhPr+jqdFioWWYw55yrngDWvAysQB27CScRxLEbysBUZ/hObbcVnQngb3zHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463030; c=relaxed/simple;
	bh=3kAUrurtNiP3UC2xmS0OvkVVvGjX0dVAutxqdUZ2qnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qUUJDE2NbL5P15Q9XXMrMfH+WZ7GFHzOpbSsB+lvPi4n+AvAACAecglIxAVAruA6AUwekNoWrUqwMLy2CZ+0YMC0FReHKbZ3yhr/QkVPgtrtuztlLA/nZOg6NZEd1+bUdbYqnEk9ORMSl2e+sEE74KdRBNaMI2CRvCf0klXKctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZ4gpzuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708463027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+zwA9HmxBE9kkApmb5DFejONB4Ab5PK9ozyBZlq85qY=;
	b=UZ4gpzuPJROqtDVU9JgiwI/0lW5K91XLLfXAbcLT0fRc+dJH7nBw6XCf8lK2KvXfJ14fhJ
	qBMahT11Pg1xlDxAOlaU8erBCdf1K8oHwr3YhzPgXxYqNqJov1AiaUYTLNctwyW5If4PWY
	ecucV2G9iVzDsfb2dmuII7D52rxFY70=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-z8F9sLwuPyKwyelG-VQjuA-1; Tue, 20 Feb 2024 16:03:46 -0500
X-MC-Unique: z8F9sLwuPyKwyelG-VQjuA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3ed504b0a9so109760066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463025; x=1709067825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zwA9HmxBE9kkApmb5DFejONB4Ab5PK9ozyBZlq85qY=;
        b=fP+eeYF4FgXRyr4eS6q+rq3rXR1uLH30UTuTPc26Hwb83PWsapa1oyGAPBErMykQiB
         ZCZKGp58h0CQpFT4IQq7/mQMOwSiKuaxgS4UNEhwqVM5Qr4LIgRMYXDS72Cnfam9fLvO
         wGf7upQZQSVmMxk13cfZF2DFpU6Y2CM1OWVb0WNMrEZhvd52jIRpKIgoI0oPKz+u/KoE
         wB7eXU3wa6blOS5XmZbXg1yoLz8ONpLw0TYKUL3Q6vUmIfD4HBXdhcBt+MXAaOFm52WP
         tgi+gsdWLo/DyAzA5q1/Or4WIzDHHsZSakFzqcds5XOjTtjLbZshbiZqHoY2+GN6nSfi
         xBXw==
X-Gm-Message-State: AOJu0YzBgCFyKjqyZCuY+bWdDZcJNqqSGTNTbjvlSIFecWb1IJisfpzo
	/u+8EeLVgty8Jn0UcM0IqZizOFOFnLBaquK1FHO2Yzl/aIsxdEtwoiGtbUiIowFDLP1vXfxvrRm
	x2JS998X+Fmx6R15RYr2DZpKNNqVVd9txiLoJtXB9yg1eqyXQvr7IGTPG70NTHNloyF/Paw==
X-Received: by 2002:a17:906:b885:b0:a3e:9952:e13f with SMTP id hb5-20020a170906b88500b00a3e9952e13fmr4074071ejb.13.1708463024786;
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/ijJ9Hlq7WY8BZGRla/sShQW1G/ckI7AdP5MFERXYPNtvx5V8pEGMRemteB7pNtpZbizTig==
X-Received: by 2002:a17:906:b885:b0:a3e:9952:e13f with SMTP id hb5-20020a170906b88500b00a3e9952e13fmr4074068ejb.13.1708463024495;
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ss15-20020a170907c00f00b00a3e0dc787bfsm4245971ejc.17.2024.02.20.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:03:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B02E510F63EC; Tue, 20 Feb 2024 22:03:43 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 0/4] Change BPF_TEST_RUN use the system page pool for live XDP frames
Date: Tue, 20 Feb 2024 22:03:37 +0100
Message-ID: <20240220210342.40267-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we have a system-wide page pool, we can use that for the live
frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
avoid the cost of creating a separate page pool instance for each
syscall invocation. See the individual patches for more details.

This series targets net-next because it depends on this series of
Lorenzo's, that adds a global system page pool:

https://lore.kernel.org/r/cover.1707729884.git.lorenzo@kernel.org

Changelog:
v2:
 - Change the cookie that marks the page for recycling to be a 128-bit
   value (Paolo)
 - Add a patch that removes the init_callback parameter from page
   pool (Olek)
 - Carry forward review tags from v1

Toke Høiland-Jørgensen (4):
  net: Register system page pool as an XDP memory model
  bpf: test_run: Use system page pool for XDP live frame mode
  bpf: test_run: Fix cacheline alignment of live XDP frame data
    structures
  page pool: Remove init_callback parameter

 include/linux/netdevice.h     |   1 +
 include/net/page_pool/types.h |   4 -
 net/bpf/test_run.c            | 143 +++++++++++++++++-----------------
 net/core/dev.c                |  13 +++-
 net/core/page_pool.c          |   4 -
 5 files changed, 86 insertions(+), 79 deletions(-)

-- 
2.43.0


