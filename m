Return-Path: <linux-kernel+bounces-67472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E2856C21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4561B2499A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF891369AD;
	Thu, 15 Feb 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBUd6OpH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272413849A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020506; cv=none; b=pZ/U8WoJfE5lNuVR0nU913b6wM0OMzwe49ELdwEoxfbdpnzRrvUrCoDm857m4DUTHhV5nZqfUSwnE/WATSyhgBCgbisK0iaYNkQgxZrcqANJkvlO3jhwatVdzos4GUT/rEzR0s2SmkDcOthPHG+mDfwGHa4poMgQZa6bqgeYdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020506; c=relaxed/simple;
	bh=lA8uWfKDTswhUYSt0szr4iG14O2IbQR7ZiKLS2FP2UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkL7eflOFIJkpTy04cL2EAwKAll8yjEJI5wdHvNA04Qpx/i3cQOjTttP/hA1mDP0xQeRniNae+wV2Rokh8giqeVeVXP/n5R77yaJulbS5TgLmM0Ydz6NJCsI6m238Sv9MCMNuD1Hop9ToKwu2gNOSjmY2mx+dEOWhIspYnp7r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBUd6OpH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708020503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnmBz4W0WlRvmkbmmS8uJZWQuvZ3cJwME84PlXfuzx0=;
	b=FBUd6OpHYK2Wp3IzjCr4ua38uI1Wwf2ILn1WSVzl/jRp+O3WLsFzX6gG8ivRE4Q2QE6krh
	tt6pksg58gnKYpbpnT6LvnC3lZ9bsTHHIIgvcjxst9HOffcy07AL1vmHvCmXwOxMYviRWG
	Mwa1f3x6BlsBisosiS9oU0XbOee3y2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-vN18rTxhPcKJEs9wcxOqTw-1; Thu, 15 Feb 2024 13:08:20 -0500
X-MC-Unique: vN18rTxhPcKJEs9wcxOqTw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4120faa1dacso5444775e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020499; x=1708625299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnmBz4W0WlRvmkbmmS8uJZWQuvZ3cJwME84PlXfuzx0=;
        b=KgxuHR/6u/LyC2xX/mdu9gFJbeZTafhNnDUg7WGk2L9b7NtyB3bpmXSexnSZq6SzVM
         ui+K38/51p9JPOicouqySnU8RqFm480BC5yDEKzoqNOItS+JXYFdfFVAba1wYTSeMqeU
         +lI4nO/XxuiKjbSqoAVKfDZvdAFsj3kcUNR2hiPYMAWDYBrFayjTYzj7dEXMTI1eImcN
         rE2UMxQnL+oGje6kmeLXGXB/QRYZ3ntizdfvxBKy4xqligIt0MTSBF+T3UDc53klUhyT
         GGzWYOoiHJMj7+CFNRSqHn7zhiLGTz5WTyuQ/c/OB/JEUaUAhFlLCFl2VGhfyL/0z5rP
         a8ng==
X-Gm-Message-State: AOJu0YzwB09xeEryet0RgV/64ArNA/vLbh9AuPlogqNP1A/T/9415xXZ
	ekWFfE4hNin1ca4jb88fhkXMyIE5jzSmZ41FXG1R4MPDq/kP4UzBc/zLZcseKNjWCXPFRgRyDcR
	cRiOq9ZB7fAv6Cyqkn8LcNPorjDAlZ4+zZh9Yr6GOwFEdVMXBtAM//CNsFDgEfs/2aketkxsq6T
	nQFDgJPWf+uqucVOu/RGgA/3aK7SpVyd8sOG8D
X-Received: by 2002:a05:6000:1ac6:b0:33b:1bcc:7ed9 with SMTP id i6-20020a0560001ac600b0033b1bcc7ed9mr2414650wry.44.1708020499280;
        Thu, 15 Feb 2024 10:08:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyOBx2D7FF89GxYJanOXARZNUqXAQM8c3U4pdS7RlP/P/IdLC8GDGRKdBrw4p6ppAf6jA3EKkXQjbhgdYesJU=
X-Received: by 2002:a05:6000:1ac6:b0:33b:1bcc:7ed9 with SMTP id
 i6-20020a0560001ac600b0033b1bcc7ed9mr2414635wry.44.1708020498985; Thu, 15 Feb
 2024 10:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209183743.22030-1-pbonzini@redhat.com> <20240209183743.22030-10-pbonzini@redhat.com>
 <20240215013415.bmlsmt7tmebmgtkh@amd.com> <ddabdb1f-9b33-4576-a47f-f19fe5ca6b7e@redhat.com>
 <20240215144422.st2md65quv34d4tk@amd.com> <CABgObfb1YSa0KrxsFJmCoCSEDZ7OGgSyDuCpn1Bpo__My-ZxAg@mail.gmail.com>
 <20240215175456.yg3rck76t2k77ttg@amd.com>
In-Reply-To: <20240215175456.yg3rck76t2k77ttg@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Feb 2024 19:08:06 +0100
Message-ID: <CABgObfa_ktGybPcai=OgBbYMMvm4jS_Hehc-cdLdFoev68z-GQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] KVM: SEV: introduce KVM_SEV_INIT2 operation
To: Michael Roth <michael.roth@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	aik@amd.com, isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:55=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> > The fallout was caused by old kernels not supporting debug-swap and
> > now by failing measurements. As far as I know there is no downside of
> > leaving it disabled by default, and it will fix booting old guest
> > kernels.
>
> Yah, agreed on older guest kernels, but it's the measurement side of thin=
gs
> where we'd expect some additional fallout. The guidance was essentially t=
hat
> if you run a newer host kernel with debug-swap support, you need either n=
eed
> to:
>
>   a) update your measurements to account for the additional VMSA feature
>   b) disable debug-swap param to maintain previous behavior/measurement

Out of curiosity, where was this documented? While debug-swap was a
pretty obvious culprit of the failed measurement, I didn't see any
mention to it anywhere (and also didn't see any mention that old
kernels would fail to boot in the KVM patches---which would have been
a pretty clear indication that something like these patches was
needed).

> So those who'd taken approach a) would see another unexpected measurement
> change when they eventually update to a newer kernel.

But they'd see it anyway if userspace starts disabling it by default.
In general, enabling _anything_ by default is a mistake in either KVM
or userspace if you care about guest ABI (which you obviously do in
the case of confidential computing).

Paolo


