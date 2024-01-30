Return-Path: <linux-kernel+bounces-45037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C3842ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E49B258FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7912BEAA;
	Tue, 30 Jan 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TOn1Lcre"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15BA1292DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635539; cv=none; b=sTPXG890t9gIxjFPAC2c1lBgTQwzfvYyC8VsZz2dNG6jsIRs8m79ZZ1rWwUI+//QfEocx7XoDmMkm8hhy557/qnvnAuLOtL7z4ZFNit/89vjkpptfxaSSgTmzjerMXucWdO1K1E7hZCgUUBoNYdzv1oAFYQKoe9duukTNQzDPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635539; c=relaxed/simple;
	bh=FcwkWgQyZxHw0vq0MR9FTO1uQCeqns6oU7XSsrjb7aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucavaf4N2bkj1x8S/IJ0ljua5Ecob/MCCXDuVK0MTSf2o5RSx1gtR/ATW1wjp7h0hJR+PRjVO+tXXMlqu73Nu40fTEZNLU7NEex36xACuiMx8p5VuNRXFxAv53UUVXmUmYmHcMJh0gGEyfEj54+7L7Fz/EXHwEo5Yf8Ag8DIFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=none smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TOn1Lcre; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf42ca9bb2so50164191fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706635536; x=1707240336; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3M0wWn2WcqB5JyFL/iZZPD7cHnf4NTD7VpnGyg3ebus=;
        b=TOn1LcreSMIM6/zFLzh4cG5qTx+j3gS42S7jY7daQlEKRMEXTFX5dTUwH1HQo+bhlG
         xa7deIbmurGZi/QjEqzH/VtXqNqAECJXK/E2mT2hzt6095S0qg7HxSjMKrB4AmTbV3o5
         XNW/tAikyUj7pX/1ejL4o6+uz3TBWzrQkhQrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635536; x=1707240336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3M0wWn2WcqB5JyFL/iZZPD7cHnf4NTD7VpnGyg3ebus=;
        b=IZyyfrRYHt/a0XMjxm7F+5BgLmUxOE32WzBxsevvlcR66DDtgq0u3ZheOT+RYtZZ4m
         QKyLOCICtOzyiy2yscGSg1MzqSscoKyeuYavb+ILM9RZqHnEo7/zPT1hg2h5CLb9pdlS
         J+ssswkTALjPfpRoTQJL6hk34Fu1iyrSDnszUjJnC7GI6NPBWbEqaEFqAAR8YpCI2mVD
         jRB2lY8rDTlyi4lVnhO4PgAJc3ixJ+iVulJcap/2J56isSMLU0EzU8ZnpM3nLopaf3F8
         gNrs0OPejeQCtAukqj1T7PoIhaH2yMtHELLEMd3Br3dX9SQjPtmXH2jylIOTO0t6Nu0E
         B0Mw==
X-Gm-Message-State: AOJu0YyuSF8xn2Vyul2m398ScT7v+NkwIwPcfGNHYryRhhCPhikSa9pS
	ghHNdX4/dmCyEZbnJ2Os5fH4+IKd3mcpzHyX5eCSDvWSyKS4KKm55diF01swVDiwSyl06+DJp2/
	WtTM=
X-Google-Smtp-Source: AGHT+IGaMamlDa1w2BQcSCYowXLm3mqLObyVo0H6OVj96UmK+2LcC2cCL0T/kkvEpVjs41pN5HHSuQ==
X-Received: by 2002:a2e:960d:0:b0:2cc:6fe2:4ddc with SMTP id v13-20020a2e960d000000b002cc6fe24ddcmr6246933ljh.3.1706635535717;
        Tue, 30 Jan 2024 09:25:35 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id f24-20020a2eb5b8000000b002d05fe442f4sm173149ljn.50.2024.01.30.09.25.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:25:35 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100cb238bcso7646447e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:25:34 -0800 (PST)
X-Received: by 2002:a2e:8417:0:b0:2cf:36b:9abb with SMTP id
 z23-20020a2e8417000000b002cf036b9abbmr5802206ljg.44.1706635533757; Tue, 30
 Jan 2024 09:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-4-tj@kernel.org>
In-Reply-To: <20240130091300.2968534-4-tj@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 09:25:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyr9jtwpiF8=es3j+D3tFF_338nJqdUq3f3oc=oJAPMA@mail.gmail.com>
Message-ID: <CAHk-=whyr9jtwpiF8=es3j+D3tFF_338nJqdUq3f3oc=oJAPMA@mail.gmail.com>
Subject: Re: [PATCH 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
To: Tejun Heo <tj@kernel.org>
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 01:13, Tejun Heo <tj@kernel.org> wrote:
>
> This patch implements BH workqueues which share the same semantics and
> features of regular workqueues but execute their work items in the softirq
> context.

Thanks for doing this. Honestly, while I felt this was a natural thing
to do and would clean things up, every time I look at the workqueue
code I just shudder and go "I'm sure Tejun can work this out".

Patches look fine to me - I'd love to actually have the dm-crypt
people (and networking people, for that matter) verify that there are
no performance gotchas from the slightly heavier (but more generic)
workqueue interfaces.

                   Linus

