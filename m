Return-Path: <linux-kernel+bounces-144841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DDE8A4B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94F81F21159
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D500495CC;
	Mon, 15 Apr 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9gHXsUg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EE44C61
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173810; cv=none; b=WUsY4zspuS2X0bq7Etkhr5UpxAkCOVq8gphXK6+VK0ZLul1o67LZ2Cub0O7XsbS+e0avlJWJYNylDUIwNM5kW9oeYS4xc3C9fAN8K1qJBQR54Ix/VsWBG3xnvtCIrvJOSw9bsBPfrN3kvXvWDhXstuJ1CWMAofzQNS933KFk1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173810; c=relaxed/simple;
	bh=sYu9CYOIKB5l1TfXf/Jun3yt971AqlY1Oe53lKaH+04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGcxPoSjAKKlJfr/ReerA5WrjdONoqsxNDTO6qLVIkU8pogwMaLVLYHJXxjf8oYn4htuWIrq2KmEBnXCRpHzrqwxZdWvQvh0z3s7mg7lF9ldvFxyrP6OEEcDNzIKAGvGJqCDFvbcKWGC90BLTzHKmZKfnjwi4yf3GfzB6tKADaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9gHXsUg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713173808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYu9CYOIKB5l1TfXf/Jun3yt971AqlY1Oe53lKaH+04=;
	b=L9gHXsUgUiY/YUql7ZLO8f4k/d1UkVAij95YEbgZNhpcj3LMJ3/BicD2kHljCqZnZjhqMc
	qlQC0vzJzgVEASQeMrPB9sO79qN/nZZoHoaKVmWSN7rj7wLHkMuC3P2WgcDRMn2TSPL++r
	C+p5RKmbyJZSYTHRLulLBure/p3/IgA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-oBTifECQPOeWkCFebJTwbA-1; Mon, 15 Apr 2024 05:36:46 -0400
X-MC-Unique: oBTifECQPOeWkCFebJTwbA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343e00c8979so2311634f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713173805; x=1713778605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYu9CYOIKB5l1TfXf/Jun3yt971AqlY1Oe53lKaH+04=;
        b=AhipM7eepyhVQtxeVIxQdzVra3n5a9PKQNmGQbsSDivf7zGC1jrbb2fxw1/2E17WGI
         PVEimN9l1JCH69Pnf6dleKu2WJK8ctBVlzdvC2X9aQpWLPcuW+gBLdtKMoiBYtx2tWBT
         Os+xhbEt70lhDEYHR7+KDRu8UERL0c9IrbnfWl5NyWlyklbWPbFpnXVb6S9NWgRu4yjr
         8M8W003qSC4JvQNWIBNH72mLeMnp7VUKlk5voZppPhtY/o2UVX6go/bp2A7mwIMcuVKh
         6iC7Fh/B44jiIaS9bb6UpzS+Zk0aTEbrsfvY7t9bMk9wHLMaaRI+ZIpsh5qT3zisL8kJ
         wp5A==
X-Forwarded-Encrypted: i=1; AJvYcCWXr8f+XdPd0sDIb/Hz33xsMKEtRwofOLyz8EoBTwLbXg2L8Ahuin/4rP/K0Xxv4EqwFaJVc3GXhJIoRkpKEITQTEhKLvgSr1Wp2/JC
X-Gm-Message-State: AOJu0YyanCTgh5wYCV+EVO+uvMPUxnQLujZVqHV/qQV8xSaPF5gQzSBW
	7vy0Rg2RdhenS4wuIQPwJiIYzxHBZZRiwXuWLA3Tr2ilWF8djugslZEVp/3ud7XUsgP9ZFUCeXs
	wYghJXnA3Z88U+74f2iTI2ffSn4U6p/4CWtjyjxWteQxlrUlwsD/lLgcJnoORRo/gjQHVdTj3Lv
	qo/srW0dErfevx61dPgWEVUXCBu1xmj5/vxZbd
X-Received: by 2002:adf:fecf:0:b0:343:7116:815e with SMTP id q15-20020adffecf000000b003437116815emr6536021wrs.67.1713173805487;
        Mon, 15 Apr 2024 02:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9VyZ4cL1gMt5C3Rm1mGMeCbp0ev+ZnK3ISZDwjaOKhsE/5f1c9W3T/BTch/CNZkcUDNliLoFPQCPyAXOe+kI=
X-Received: by 2002:adf:fecf:0:b0:343:7116:815e with SMTP id
 q15-20020adffecf000000b003437116815emr6536002wrs.67.1713173805166; Mon, 15
 Apr 2024 02:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com> <20240229025759.1187910-9-stevensd@google.com>
 <15865985-4688-4b7e-9f2d-89803adb8f5b@collabora.com> <CAD=HUj72-0hkmsyGXj4+qiGkT5QZqskkPLbmuQPqjHaZofCbJQ@mail.gmail.com>
In-Reply-To: <CAD=HUj72-0hkmsyGXj4+qiGkT5QZqskkPLbmuQPqjHaZofCbJQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Apr 2024 11:36:33 +0200
Message-ID: <CABgObfbvkuCHT0sFFdJbGHBD7k=QbU9c=kA4xYE4j4S2Mu46ZA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] KVM: x86/mmu: Handle non-refcounted pages
To: David Stevens <stevensd@chromium.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Sean Christopherson <seanjc@google.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:29=E2=80=AFAM David Stevens <stevensd@chromium.or=
g> wrote:
> Sean, is there any path towards getting this series merged, or is it
> blocked on cleaning up the issues in KVM code raised by Christoph?

I think after discussing that we can proceed. The series is making
things _more_ consistent in not using refcounts at all for the
secondary page tables, and Sean even had ideas on how to avoid the
difference between 32- and 64-bit versions.

Paolo


