Return-Path: <linux-kernel+bounces-116940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D062288A556
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8662E1F3B482
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA881CAC84;
	Mon, 25 Mar 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SECI+TkZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B7813C9D2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366185; cv=none; b=ZKVJkpHzj4x7LQO6pDBdewf0F+WORS2b5BlAxS5sm2zbM5W0UptWLjsd3lzXI7rarU7XoWENbuSd/iX7hNLFJBA/GekRWBwF8IKN2BmAJhYmO4+yitXELbcL0pYsjv5VmRIqvULjdfI5RrZ/jv+V6fWGjeVWDT5mS9EjhGMT6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366185; c=relaxed/simple;
	bh=DfPqsjzS7hM0pHS4XcLmOdcjRtfbF39TxfamCWHwy68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWMJQACc8tMe8IOs70QuKc9MqNedK1nSXH8VPHdPY5rJMO7+KwMaEM9aXWkQmEFR3D7n7DVH+OyvlbIW/Scbd80K7gFMdi1v8oKoVY8NGTmZWKLPvcLfX5PISVMswuK9+mcT38qLNZCjYeT1KEsqhvAnVyMFHjgJsVgKtqujCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SECI+TkZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4148c09ec6bso14055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711366182; x=1711970982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkNYJvsdSYu5fwK3ocDdS3LzfZ1gl4LLmO/SR89+rGY=;
        b=SECI+TkZtWa6fxuHDrhV19cnE/nhQr3ucQo/erfztRXKO9lCdYO5pA7AtZ1aTW3umU
         faD7KYjkhpmqJ/JBeL1eO0dYPAVj0GRAY77vF1dOaubQd0AmqpESX5Xe6i+ODq7NFO/Z
         cXTY5nZ2+yELeMx8dbvB6olDLkMw4D62McSOzZd9btDd6vAfhYGgotLAU6uyA3tOw0c+
         DBe1OVy2e6/ro7aRDJOWLqPbubNepMz8pB1r7ZmDRB5QehbSn3w1UKDKAChn9bORwjYl
         6qK51c/RM/+IyLYR0zjcae0CvJraLXAlRyOHthYVTMnomAic0Hpwv0F2RBi2PplYh+43
         VKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711366182; x=1711970982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkNYJvsdSYu5fwK3ocDdS3LzfZ1gl4LLmO/SR89+rGY=;
        b=LqXx/183fh6mBXRxGr91UyCeP9inQFlFfSno6nHGZAaUCdv+w0s8h7lxVbXEZdG67X
         awUlz3SL+uUyHeSqg/lAmi/GC4SCaFE0oVDZogCWkHc+vi6xi1Uu0SqGwzg1+hvATt7+
         wsqbBodatINZ2Mo3JDiYoKR7i/SXEmdGRO1PGH4BfdywrovxGj/d9gF6kHG287+CR/OG
         AivdDTZLZSbD2EVH01EviFjIigs93OSh9HHuN3LvtTj6i1jGdC/skdJ5/dWHW8xqU2Ct
         jiLOEvtxH9p/EbYljASwlV2PWcCnfddHvM3OhOKGpWbr1foRCad9Wc+hfHeXhGJ4b2WR
         Nssw==
X-Forwarded-Encrypted: i=1; AJvYcCUGI3KG8DbyB5tG/IrSwiBTA5UvV4GVrA+HMXBeLNY6PPQiE23sYzYDXyvX6R5HKdN+Laj1jpPSLSGInkvBohH1bSml285bSJV5hiPp
X-Gm-Message-State: AOJu0YxDP9MaVxfFhuDsoidoDvuPddkGuWFfCncIdnVyN6tehvtVNl3e
	429h2eQCHU7SgpDhMDpUYRhCeJeZSS1GIAthuUiHPbMefQDC5dZ7aJmInRGFIw==
X-Google-Smtp-Source: AGHT+IEqrqZ/kvgiywLjCv3Lnov4/3EfG9IoekwC7LJMklqp7fgDJFEOrVMhVA0far1ZCvdOK2vGMQ==
X-Received: by 2002:a05:600c:35d6:b0:414:866e:4437 with SMTP id r22-20020a05600c35d600b00414866e4437mr203074wmq.1.1711366181603;
        Mon, 25 Mar 2024 04:29:41 -0700 (PDT)
Received: from google.com (248.199.140.34.bc.googleusercontent.com. [34.140.199.248])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c511800b004148090cf86sm2943880wms.0.2024.03.25.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:29:41 -0700 (PDT)
Date: Mon, 25 Mar 2024 11:29:39 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, qperret@google.com, qwandor@google.com,
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH 2/2] KVM: arm64: Allow only the specified FF-A calls to
 be forwarded to TZ
Message-ID: <ZgFgI0Ky2m4MUbw-@google.com>
References: <20240322124303.309423-1-sebastianene@google.com>
 <20240322124303.309423-2-sebastianene@google.com>
 <Zf45eDs8Bd1UQ94Z@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf45eDs8Bd1UQ94Z@linux.dev>

On Fri, Mar 22, 2024 at 07:07:52PM -0700, Oliver Upton wrote:
> On Fri, Mar 22, 2024 at 12:43:03PM +0000, Sebastian Ene wrote:
> > The previous logic used a deny list to filter the FF-A calls. Because of
> > this, some of the calls escaped the check and they were forwarded by
> > default to Trustzone. (eg. FFA_MSG_SEND_DIRECT_REQ was denied but the 64
> > bit version of the call was not).
> > Modify the logic to use an allowlist and allow only the calls specified in
> > the filter function to be proxied to TZ from the hypervisor.

Hi Oliver,

> 
> I had discussed this with Will back when the feature was upstreamed and
> he said there's a lot of off-label calls that necessitate a denylist
> implementation. Has anything changed to give us confidence that we can
> be restrictive, at least on the FF-A range?
> 

I remember your proposal for having an allowlist instead. The current change makes
sense if we have https://lore.kernel.org/kvmarm/20240322124303.309423-1-sebastianene@google.com/
which opens the window for more FF-A calls to be forwarded to TZ.

Let me know if this clarifies, thanks
Seb

> -- 
> Thanks,
> Oliver

