Return-Path: <linux-kernel+bounces-32145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17199835735
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E821C20C53
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79404381DD;
	Sun, 21 Jan 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t6T54n+7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2100381C6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705860737; cv=none; b=EbjJiwuA1/0BBw1CPNAG/xsfR7veDIsh/eC62PutT9avAIDaPr63kmMDuBrl3v/7EJpeyA/avE8hjpTf+7luV2XUW3PzFsghsFc/mj4Z6oTI2FJ735o2RaddFRFETJtEjYbqApQF81lYYOClEi6UntbmY7SykmC3VyuJXZLhGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705860737; c=relaxed/simple;
	bh=V7R3RSzDKGYhZPWJ9ig/EoHQy8yLiErGelH8RUO8qDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0yeSAk1zt+VEy8B6iW1s9UQ/cBzLj8R+pIm3UInHaHdxLvK9Xz+kC+7EKmm/TiaWNAd9G6JyazKakAajRqJKOh9CdiwCzDEBxbC5OwhROaQIXr91gHFBrQu1vVjJaSQjwOU9pYFv3Q2BJ1FXq6Yo/e9J73SQsn2is2d/7NjF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t6T54n+7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33931b38b65so506587f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705860734; x=1706465534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nnKbsnxsY20xhVcSmfYZXg9QGG5JwLaHd8BDjP1Kj0=;
        b=t6T54n+7eVVNHs9XCLv0GK/QMHWXySthzxSDGgOjOkrx5RLWNFmth+tsw1VFDxJ7ph
         /bAbhM/YEtaca+y3OUhsKo2xaQ4KpcJOAHTLuyuH8bpojEyXpKnHBlAIjR90hieEnIkL
         I59HFDqWyno6opNXqhmRrX5AagsVqFJlAmOpJ7TG95+JLWPO7QgOT+zuDbAB8+6ClngD
         ubtbrrxXLx8gTydFH4MhC4fAzu7TG7/enqRjKiFCYobffXKF3P3CZTRfysqY2QEl4zjM
         1byvGmw3LdrepYa0hlkINpk+/7NzBh+nupjxDnRsCSfBGMJJjuy2g5hccWIQ3/17WeYz
         7abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705860734; x=1706465534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nnKbsnxsY20xhVcSmfYZXg9QGG5JwLaHd8BDjP1Kj0=;
        b=XwWVGYRJE3hCsVHmRSanFFa7z/CA8wrKxyBNS0wycd4qArlEFQuT2qOeC0F1pPJRpt
         BR0lde9VbrHOBMYLne+NVrpSNke8xczT7DL4KYaNqFiOGezFCSs+0RBVrQXXQ1kCo1DA
         re/8+yB/jGpburnyqrtTrxm56o3a040xtKbD7xm9wbanrvAUkM4Iv5XWPlimmXNZPPys
         35VFC2tZJzzVjZNT487U+HLNWkFshLbYeLJKJwUg65sir7bPVpgqG2zLf9UnAG2zOuHC
         Yg3/NAKX0fk6rJOv2o0QXklLQaSBa60LPiLEkBkNVQZ8pj7wun0DV4APSlrXRTSPY4CJ
         fE+Q==
X-Gm-Message-State: AOJu0Yw9HKJaGA7mRD08n5hkrPo0YTB2yqNYFJTeF7S4vtdV1ncwojpU
	OsZSWyJSJ/Hi5FmvtsgS1FJCl14mXFSHxose1uegVXLQ5LB4A/pLAnguUFP6U/g=
X-Google-Smtp-Source: AGHT+IF92bsrQZmY+tgRhf/55ibpl1QJYlh90dPWVCp/zoRaTrolG6ya4uDyNKOjRIZUQeKumr2iIA==
X-Received: by 2002:adf:f84c:0:b0:337:c2ca:c9fb with SMTP id d12-20020adff84c000000b00337c2cac9fbmr947446wrq.93.1705860733685;
        Sun, 21 Jan 2024 10:12:13 -0800 (PST)
Received: from vermeer (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id h8-20020adfa4c8000000b00337d67a85c1sm8560925wrb.62.2024.01.21.10.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 10:12:13 -0800 (PST)
Date: Sun, 21 Jan 2024 19:11:41 +0100
From: Samuel Ortiz <sameo@rivosinc.com>
To: biao.lu@intel.com
Cc: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
Message-ID: <Za1eXWiKPQp//1CO@vermeer>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240118033515.2293149-1-biao.lu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118033515.2293149-1-biao.lu@intel.com>

On Thu, Jan 18, 2024 at 11:35:15AM +0800, biao.lu@intel.com wrote:
> Samuel Ortiz wrote:
> > Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
> > CoVE) provide their guests with a set of measurements registers that can
> > be extended at runtime, i.e. after the initial, host-initiated
> > measurements of the TVM are finalized. Those runtime measurement
> > registers (RTMR) are isolated from the host accessible ones but TSMs
> > include them in their signed attestation reports.
> >
> > All architectures supporting RTMRs expose a similar interface to their
> > TVMs: An extension command/call that takes a measurement value and an
> > RTMR index to extend it with, and a readback command for reading an RTMR
> > value back (taking an RTMR index as an argument as well). This patch series
> > builds an architecture agnostic, configfs-based ABI for userspace to extend
> > and read RTMR values back. It extends the current TSM ops structure and
> > each confidential computing architecture can implement this extension to
> > provide RTMR support.
> 
> Hi, Samuel
> The ABI does not include eventlog, but eventlog is usually used with RTMR.
> What do you think about how to implement eventlog?

Since the event log is typically maintained in the firmware and not in
the TSM itself, I don't think we should expose e.g. an event log
extension ABI through the config-tsm one.
We could decide to check for an EFI CC protocol availability and extend
the event log when any RTMR gets extended, and that would be an
internal, not userspace visible operation. I'm not sure that this
would scale well with e.g. IMA (a lot more events than pre-OS boot
afaik).

Cheers,
Samuel.

