Return-Path: <linux-kernel+bounces-45467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323E843122
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FA01C206A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D247D3E6;
	Tue, 30 Jan 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWelPv54"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5387AE70
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657103; cv=none; b=Zd+tmqdLndfj6sDX+Vz3NrV0OEG1+GqI3iRewoJSjScXOpwfJQzueZpty7mMlE1wb+IelKR9JHa+2jo6KZgriZqRyTTfMDe+D9gC3cleCrhU0TXU7tLapVf2P3wXQRQYQPnpYEtLVpx2SUyU3hnFq+QpIwzMf88IZWafF2og8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657103; c=relaxed/simple;
	bh=QLf5+s2EXzxM6NEMqH1PSQJKz8I1rG4C6C6q/v8c3r0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s8ixA8Qb9By3bALMk3mV+cfCx0XnDK+RAdhNXPiLWar7URB4GejHn+qxBMl0IrlBW5WTJGukZbGPkzZMquk95rqhM45XQmikOdL56VYAxc5M40czCJIivqX6E5sK0kTWDoupzTLVerilQyAxxzDd8F5LANa7OCCYBuFQVsurWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWelPv54; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6531fa07fso6829251276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706657100; x=1707261900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DZOnZhgrOi058fY32LTm4dCLP0HDk6nBa+5Ze3KMOU=;
        b=jWelPv54eDo7fZbkAfQdoYMNqSE9W2eURCcFAAA8KLVPJuYJWzkQ2xFgyJEQ0mx4GD
         Uh++H1LVRuFa36dYpXQBpL05IIBrupZHE2TN/+gQmWK/U9jtH7Rq+Su9qxcvQTZjK/8a
         7pf+T6Wx3KLgEKoidtFNRXAhFxSZ/FcMOAO0SeUX4KEKH1ml9B3Axq5wREGlW2RSFeq/
         4p+31Xd0dhM4BcSonDkxvh14Dl5fYY9HV076SHQWnde3Zo3waw7uYCPTTMTkqz1H/Jc5
         2vgZod7KZOJyJXb/zVMxmVNHfmi/SwwXItU7N29NwPzitsAdVLBtNwxIDCzRN5WhlLI1
         E8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657100; x=1707261900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DZOnZhgrOi058fY32LTm4dCLP0HDk6nBa+5Ze3KMOU=;
        b=uqaq56l/SMCi1wUI+qeoCm3gFwiYi4SrhprmIqPGA0Tstvo5x2hUM8SxVhUn5SKyfw
         ERbxbyBV1woXjXMfbOKQBkWe6hGNqmjnftzMY+rJfWcda5qZwbp7GskOtm3Rx0hd7R7l
         7VRPZh00x78Tnyl2uUPBRS4sHFeMcv3p5FdAMvuRhLJkxHqaE/P+NOL3q9UP4jIyKNtk
         d2hJ7IhG5EIUcJjPLHT3fu8zdfpJ829kKbRbgLAFpL4/H3dPyWFlBS5JMTGd2EwqI099
         nf67lbtlBpMbeL0qJj8RkleOge3RP7+Ow2PzBPuRU0nD5l9yiA+Nhdl1QJzaZh0XeqfQ
         t5Nw==
X-Gm-Message-State: AOJu0Yymx79AEHnNEAXqYb4zv2MTeQJcCC56Vgd1a16BkSW1mitb928R
	l+4UtY47FWObzKEghsveCEkXUGunbyEmtr/+BP+xuQ/SIsPmClSGLaincVaZDHfTvAp9hDzV1jh
	T3A==
X-Google-Smtp-Source: AGHT+IF3YmDiUVLol3Ma2dGjY66h66Myp8jul3JHp2eJRacVDXua9zfCDa1EBBpN/JLALWFl8Uus4BKOxZ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1b8d:b0:dc2:331e:48b9 with SMTP id
 ei13-20020a0569021b8d00b00dc2331e48b9mr313ybb.12.1706657100630; Tue, 30 Jan
 2024 15:25:00 -0800 (PST)
Date: Tue, 30 Jan 2024 15:24:58 -0800
In-Reply-To: <20240109141121.1619463-2-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109141121.1619463-1-vkuznets@redhat.com> <20240109141121.1619463-2-vkuznets@redhat.com>
Message-ID: <ZbmFSuPBix_USbif@google.com>
Subject: Re: [PATCH 1/5] KVM: selftests: Generalize check_clocksource() from kvm_clock_test
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 09, 2024, Vitaly Kuznetsov wrote:
> +bool sys_clocksource_is_tsc(void)
> +{
> +	char *clk_name = sys_get_cur_clocksource();
> +	bool ret = false;
> +
> +	if (!strcmp(clk_name, "tsc\n"))
> +		ret = true;

This can more simply be:

	bool ret = !strcmp(clk_name, "tsc\n");

and then

	bool ret = !strcmp(clk_name, "tsc\n") ||
		   !strcmp(clk_name, "hyperv_clocksource_tsc_page\n");

when the Hyper-V variant comes along.  I'll fixup when applying unless you
violently disagree.

