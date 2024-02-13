Return-Path: <linux-kernel+bounces-62908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A38527BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4F81C22FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A0A939;
	Tue, 13 Feb 2024 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPAsLX4J"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B528C17
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794826; cv=none; b=GHLsTOapmN4PbiLmdR452uY5iawDX3uMbnWhRM9CKGxeGz3FiWOPSJ3uiiT1U9DsAMIcYubZGCwEgxIrUXbbaNnOnOUNt9Fe8hc5xzzncyWdaefIKT+myrVt2d/5URpkU3sUa5YppSxnmxYpi65u52xZ6wiKomoX68ARCFr/cUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794826; c=relaxed/simple;
	bh=k2gfEby2avrtvHzBUfVvHLiP3n7nkuPha9dr1uxkNDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N4y2mi0J4zakt1NP6iq4KZMKO+mBu9mO4dH3PRjxr9acf4AFC31qMa58iu8F9w3Tusdgr9lJIRAFtwIND8VJSCjYtBAvcXcRNCrGOSZI1+R/Uv9gveB4tTnny7yYNrvKdHXyuEnMNbP8mcVOrQgaZPboWS+8B9mhnn5QMfQ//cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPAsLX4J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d9a7b598aeso52770305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707794824; x=1708399624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ol3QEcIEiOh1BLpsgDjP1PLEFR06C0O0EZBWIwePAQ=;
        b=hPAsLX4JAFtWSeIXBiYDp/mqdk/QYjb/PkY6qxc26+n1eDWL5fPuc0z6MlUfOS31wF
         nU6uW9aeSFqMJ8pV9a7JRn1oG2FsouvxhFH8IOh511oCTCDZCeJGXj9hEcPpudfdbMuh
         le/q1Aj582nIGj+Alts/b07IfsG8GkDKerzsJuTdho97VH6hSEE6xtA8s50b7bIBH7J0
         fL6RjOvaSJYAMPLdfyaLxkYxDm9mBmGOhD8CX77/ffYt/Lo78wPLWF8k8uyB427lcpEv
         /cy3E41HUzlCN4psYW/EEjv1ccsFK3qYSmuN0zREpFF7vVK+bOo+1Tu8ii1mrNoVJla2
         xPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707794824; x=1708399624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ol3QEcIEiOh1BLpsgDjP1PLEFR06C0O0EZBWIwePAQ=;
        b=wcbZO9T0+FgbGeYF/EWvSnNTIReE8arEV7diVZjJJ/yHqajej1QEAL+neEVXxY9iDb
         qhE2Q4rMzCztB577WCjMKnVApfgRlFO9iB7U3EvVKVK9Yw8DKM04QxfncjcFu71wdxv9
         +x4dke3aRpGuxrX/Xax2j+jTrn3Ru7IEX3c2YdMd9UUDaPx4LigYJuSsXUbpBRBTZ411
         rWlADgyD6+tskLfJikBd2Pxhr0Oi7jp/F6qz5mUL+IdnUiSwXRD6yQDovauXL0sJxfsD
         HxNUvVto2THZvPRJqiC/uS+7EO0MJZmzjsRlvCu/CN9QCaaZgSp0rvvhucOCybGttJIV
         +HXA==
X-Gm-Message-State: AOJu0Yy+I2c+DgsYXNhuMtVgkB2xwKFejIP+UXMcuGQFdvRjOfTdl0xI
	ZXJoV9jC8ewatp4RLoWgg6T0+8MRjxveR7qiwYlg9QKuWsdiPGrLluKOwQekmfttrWnX4ZLXlOP
	srw==
X-Google-Smtp-Source: AGHT+IE2/lvtUFa4iT45UhB99RCmacSvJqZ8c+JoTQ8zKhR7XCLP/GpvbJ/Z65s2wACzXrxrb6MA3pLj5cc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5c5:b0:1d9:3d47:a440 with SMTP id
 u5-20020a170902e5c500b001d93d47a440mr278839plf.9.1707794824407; Mon, 12 Feb
 2024 19:27:04 -0800 (PST)
Date: Mon, 12 Feb 2024 19:27:03 -0800
In-Reply-To: <20230911021637.1941096-3-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <20230911021637.1941096-3-stevensd@google.com>
Message-ID: <Zcrhh1CyWjCn8eQm@google.com>
Subject: Re: [PATCH v9 2/6] KVM: mmu: Introduce __kvm_follow_pfn function
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 11, 2023, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Introduce __kvm_follow_pfn, which will replace __gfn_to_pfn_memslot.

Please use parantheses when refeferencing functions, i.e. __kvm_follow_pfn(),
__gfn_to_pfn_memslot(), etc.

> __kvm_follow_pfn refactors the old API's arguments into a struct and,
> where possible, combines the boolean arguments into a single flags
> argument.

This needs a more verbose changelog, but I honestly wouldn't mind doing that myself
as a way of refreshing all of this, and to lay out out what the end state will
(hopefully) look like when all architectures are converted.

