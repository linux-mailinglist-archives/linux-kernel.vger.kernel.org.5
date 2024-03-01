Return-Path: <linux-kernel+bounces-88321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0D86E000
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B361F22BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20A23BD;
	Fri,  1 Mar 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euAvnW5x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517E6CDD1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291661; cv=none; b=JXX/luiQQDbrDaODUMa9IgpaTKo088n5tQSZPDAupBHaohPZgUR3jrSfuCY2ZJCiYuhA3vLzEk636a2Vr3fCKgHNs5zDqRddWC6KJ+vwNNiqvxliqT5hbdTrW1EdlodMqs3r2fXBQ3i90xqCw9liOa7X/6CBqc72AwRRSyz70Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291661; c=relaxed/simple;
	bh=BeWbTL/w4ec1nypcZmB3J2mBD806Yjz02fMt5od6LIQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=D3ZGXCDxR5ujKwmID4I1lQzXR3qkXQE0q4Pv46A5KGMnwOqTteNUxhYNOnu5E5rdzaolepw5Bw22hFNEtIo4A4Ml3w6l0dCbJWiL/OJevoI0DhlYcOAczVScesgUTRy2pbhxt+Rk0cB9sw5gvqhDddmYXhpkcZmLqw2mYGjXrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=euAvnW5x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709291658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEE62HUTb2Km+FBqYhB0pIcbLbRriFu9+pLa43NvRsg=;
	b=euAvnW5xib1g7OC0k0nJTwzqrybMHi+o5eV8MuFNmjCv6HEuLkRsHjSYfAoFYFzS4HKyik
	Ld2AGkwPJBWfoMJunn7xCBppxKaVIr8DPSad6HDGTaytR10e5H+oHqRA/e9y9iy4z2xVeK
	uJDCRhsKScr4E+/AER7Pplmixw2w3Js=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-Ljfl5rmePhK2COfMD8K3mw-1; Fri, 01 Mar 2024 06:14:16 -0500
X-MC-Unique: Ljfl5rmePhK2COfMD8K3mw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412bb0a770bso9666465e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291655; x=1709896455;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fEE62HUTb2Km+FBqYhB0pIcbLbRriFu9+pLa43NvRsg=;
        b=aRhrZEskMpYuvJ9r18h069ClZH3epo492yi3u4WobOmw/H0VfFUOwysGpFyHaLPhKu
         8izhzAjnkfLsXITQFIu71VLXMP7lKyoWAi3epx9TNDDLjHYrIZk7YpGYkoP7dZ00xN70
         cBlRmpalYjzipWLfTQrQB6O+Z3HyRSaz3VbUzm5EdmdBpCetWv8chWE8oVpx93q2lB+E
         Lae41fISykhK2F/sMejicgsBmMMGx/d/8ksOdFumD/Yt1fuiF3iJk+edvDIWs6wQVAXH
         umzC4+J79dn0h0Z+VGjQaBaPRqfnzp/87Us/RXTWVqF4qOnh8yixHS5WKcj5cjnoHJIP
         yqLg==
X-Gm-Message-State: AOJu0YztFtoIIQ3Ktu60ckN3WoMuFmsLjulY/p3eHDatXrmacNgjxD5+
	vU0PkSZULFTl2Zdlcjr2Mzcqy40Lg7tRG4HUAACPhVt4hay3i/b7qb/GCS/IeOaq4K6aC8nzplo
	9Fwh2A3Xf7M+680Zl6S4y1po+dAYJtRYEzNO9hrsMUgT2HhEV5qFcla8XsJ1ngX0majMO8sP1OH
	O/eMdwPysU7RlmRnaSZPNO3i1NME5yMpu/1NT3S59M/171HsXS
X-Received: by 2002:a05:600c:46cd:b0:412:abe9:b011 with SMTP id q13-20020a05600c46cd00b00412abe9b011mr1239798wmo.25.1709291654884;
        Fri, 01 Mar 2024 03:14:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX4vhWUpLzjqkUt2iL5RROANZ+KBN2JNGU+nOrrm8U1XZkHM6jXQJ2tnbKyKLklpLbECrcAA==
X-Received: by 2002:a05:600c:46cd:b0:412:abe9:b011 with SMTP id q13-20020a05600c46cd00b00412abe9b011mr1239766wmo.25.1709291654398;
        Fri, 01 Mar 2024 03:14:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00412a31d2e2asm5124244wmq.32.2024.03.01.03.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 03:14:13 -0800 (PST)
Message-ID: <266579a9-fde6-40ff-b13d-fb2312db406c@redhat.com>
Date: Fri, 1 Mar 2024 12:14:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [RFC] How to test panic handlers, without crashing the kernel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Daniel Vetter <daniel@ffwll.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lukas Wunner <lukas@wunner.de>,
 Uros Bizjak <ubizjak@gmail.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

While writing a panic handler for drm devices [1], I needed a way to 
test it without crashing the machine.
So from debugfs, I called 
atomic_notifier_call_chain(&panic_notifier_list, ...), but it has the 
side effect of calling all other panic notifiers registered.

So Sima suggested to move that to the generic panic code, and test all 
panic notifiers with a dedicated debugfs interface.

I can move that code to kernel/, but before doing that, I would like to 
know if you think that's the right way to test the panic code.


The second question is how to simulate a panic context in a 
non-destructive way, so we can test the panic notifiers in CI, without 
crashing the machine. The worst case for a panic notifier, is when the 
panic occurs in NMI context, but I don't know how to simulate that. The 
goal would be to find early if a panic notifier tries to sleep, or do 
other things that are not allowed in a panic context.


Best regards,

-- 

Jocelyn

[1] https://patchwork.freedesktop.org/patch/580183/?series=122244&rev=8


