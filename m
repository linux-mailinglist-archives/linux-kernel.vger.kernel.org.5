Return-Path: <linux-kernel+bounces-161372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0508B4B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640661C2114F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385B56B60;
	Sun, 28 Apr 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="jSR9prnQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F9AD52
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299935; cv=none; b=OiPH2ICyLm5QOPwvo4izXcieYeFPFh7oOYkAofQ0sLhYe6Of4T6IrBc5gZa+9EJ7dExCx1IlmDCzwjo1TvgPt/OqKI9xHEIlopc9vvXbHOC+zLGtk9ghtlfIWhes4fYfc7xJUHNSFeEqeSaSlT9FhiLwuohuMl+VhVSIKwfBlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299935; c=relaxed/simple;
	bh=WxuAqSxCg1vtU7xm7gjRm4d/XafuDRCeCssBqHkvuno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kc2w9DY3D2fNzJ795nGAtd8opJmYetOuYfWCjpr9r3h+LdtQHs+YhuXZ3X9WnhB/bwFTawMLUfzOpQ0G+IBJw7zyLrcwTLlRT0HhnrS0t7nFekcwOS60bLplt7CWcgOjjhGFEgZFQ5d7b4Nhn0owaHc5qjieim0+gWS/XYgcTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=jSR9prnQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso3087036b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1714299933; x=1714904733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAUDl2EQOQQL16rvtcMFG+TGjH0r2wEnOekpaWH5GNc=;
        b=jSR9prnQTbqUt2HLAGPT1f8ATcJTWq6UQFAqV1oxdnfkLN72SD1pcbtnfw6PHFQjEK
         vgI38iw0Jz4//NWc5NEfUNzyWW2XsibMSbBFxBmH595b9Dt4WpnPcAXLE6aNiRCHmhIJ
         GKiyROFAx57HpiKLZOJeEAzXw6Du2wDka+nJ2fcnF5rHe278MLlCaH9rkvrSAf4edmuw
         Le/6SdzEvl3+Cal2/HMJ31nUmM/w7h2B8lNZ4sMwciHBu+h7/D2udRd9kWBT04EKms+u
         2h/CNbVKw5BpOrtT8nXTrAIyGgkTdjyZgJBkVZlogai+dfxvqEMCbDpjQfCvt99Y3BPm
         vgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714299934; x=1714904734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAUDl2EQOQQL16rvtcMFG+TGjH0r2wEnOekpaWH5GNc=;
        b=jDWY8KnF0qIIvi1IiExI4uijyyV/hrQZETWO1F8al7pgUkTFdEPl+whXB98MY5sJCC
         U/YovNx7mSMIFUJRI3CFiuAe73ZiyZ/FpnR7dhM6JCSurbkLrP8zYlx0BoSHmK1CTlvD
         NzgXkm3AgWRP2AbtJ+c+qNo4BvUqiV9WtLejKVC1ka3i1aNsdunhfMFkLBjZ9T/EOTAy
         5+dum/SX3Kon2UGWGYEVqQNP6A4K17MNZO2WU4BWdpPPZGI9sjr78IxBDXuWqSNUpuDE
         GL5AE6d3kuvlf3pTzhk5jvBAp7pgRRemolGgpdSch6CaBhIckMJt3JjNDcue1miqCJ/q
         /Kxg==
X-Forwarded-Encrypted: i=1; AJvYcCUUcEW/5ZHhrLzbF5acln7y6Jedpfedckrek2IKiA9dMv9krka+RXkr23rPaiuWorG1OnqDMo7aY3AS8LmrVClgcVHVyAY3+H7vL9GO
X-Gm-Message-State: AOJu0YzpRSosLQaE2I3nnybZreA/7gbpbtazHBvwz5/+j6yf/w3Omvo8
	gdRY3in91XA+/ZBT71xwg2FzeZtYx5es541iwQ49VKsGv8RBiivlsDubyF7bHcA=
X-Google-Smtp-Source: AGHT+IE2lardqMKGHkiv5DcqtQwvACm2Pn82KmgG+STCOsw2geLTwrgTrRGeg90NVB5ebwqXxmJ46A==
X-Received: by 2002:a05:6a00:22c1:b0:6ec:fc71:3be2 with SMTP id f1-20020a056a0022c100b006ecfc713be2mr9863100pfj.21.1714299933641;
        Sun, 28 Apr 2024 03:25:33 -0700 (PDT)
Received: from C02FRH0UMD6M.cn.corp.seagroup.com ([143.92.118.30])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b006ecf00ecfe2sm18028894pfe.12.2024.04.28.03.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 03:25:33 -0700 (PDT)
From: kwb <wangbing.kuang@shopee.com>
To: sagi@grimberg.me
Cc: axboe@fb.com,
	chunguang.xu@shopee.com,
	hch@lst.de,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	wangbing.kuang@shopee.com
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
Date: Sun, 28 Apr 2024 18:25:27 +0800
Message-Id: <20240428102527.37462-1-wangbing.kuang@shopee.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
References: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>On 28/04/2024 12:16, Wangbing Kuang wrote:
>> "The error_recovery work should unquiesce the admin_q, which should fail
>> fast all pending admin commands,
>> so it is unclear to me how the connect process gets stuck."
>> I think the reason is: the command can be unquiesce but the tag cannot be
>> return until command success.
>
>The error recovery also cancels all pending requests. See 
>nvme_cancel_admin_tagset

nvme_cancel_admin_tagset can cancel requests before stop admin queue, but 
cannot cancel requests before next reconnect time.
The time line is:
recover failed(we can reproduce by hang io for more time) 
-> reconnect delay 
-> multi nvme list issue(used up tagset) 
-> reconnect start(wait for tag when call nvme_enabel_ctrl and nvme_wait_ready)


>>
>> "What is step (2) - make nvme io timeout to recover the connection?"
>> I use spdk-nvmf-target for backend.  It is easy to set read/write
>> nvmf-target io  hang and unhang.  So I just set the io hang for over 30
>> seconds, then trigger linux-nvmf-host trigger io timeout event. then io
>> timeout will trigger connection recover.
>> by the way, I use multipath=0
>
>Interesting, does this happen with multipath=Y ?
>I didn't expect people to be using multipath=0 for fabrics in the past few
>years.

No certain, I did not test on multipath=Y.We choose multipath=0 cos less code and we need only one path

>>
>> "Is this reproducing with upstream nvme? or is this some distro kernel
>> where this happens?"
>> it is reproduced in a kernel based from v5.15, but I think this is common
>> error.
>
>It would be beneficial to verify this.

ok, test need more time, but we can first verify it only in v5.15.

>Do you have the below patch applied?
>de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")

yes, my modification is inspired from the commit. Chungguang.xu is my coleague

