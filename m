Return-Path: <linux-kernel+bounces-42401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025338400DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032641C22B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459C54F9F;
	Mon, 29 Jan 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOzGMpKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAC54F85
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519043; cv=none; b=pPiUfx5/Wf1zfM1Ai+QYOmMQpbm3fXvXCjX25tmzDoncRKCaI8tDOCQsIFIM/FsI9R2lDLaXJzF2RSlCw1TBMWxBhmJr48VTKe5lmDlgQUw/dlJnSyTCTrZKcg9ICJ/8FqHf8P/NSuWSknN/TBEaTCOdlbfmLqO/jkfWie2051w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519043; c=relaxed/simple;
	bh=aaqzDJagx7VtoO97qs85Dq0uoWjJTuO/qVeqF8e7ssc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BT5rW9ZMXFO5y3yzolnMwZ1BaqAop5HmlM55NymXeU6lO8Oxch9sBEXkG7YGq1CaWGCoba+EDwyOpBhqEmWEmTKulZzjCxrRHXmtcisLUfm/49WQ14dhm/UBKBwghFi1RKWY/FO1Z93xBDzu6VpH0I9eXjvfau933XE+4qWomCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOzGMpKS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706519040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LxNQVXsu9usio1d9bkE2ficZHEFLd5sQcdQVhw5rlw=;
	b=eOzGMpKSeLiLd7FwtDIT8zen2fAOkOU/o9d545NgQoFtYn+/k9JeW1ajrP0OllwHEyCc2z
	d21ymKSUTV9xCx3iHeyxB/6o7DYymDO9ZVMAA6hIW/CEznCOIwqkA/AFOtUs0amd1GGfVp
	x5gzEeMBt3iBzeeAAASKkBAgYBymsYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-u3TTXWLbOjWryuQfpWF8gA-1; Mon, 29 Jan 2024 04:03:59 -0500
X-MC-Unique: u3TTXWLbOjWryuQfpWF8gA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ae6433d55so673324f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519038; x=1707123838;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LxNQVXsu9usio1d9bkE2ficZHEFLd5sQcdQVhw5rlw=;
        b=cQj3YL4jqQIluuwfDkO8PuRSEqz+lYP5GafuDTfLIrVOVI8vZwwKsBbXmL0q79stEh
         aATWNlZ15k5E2hQ/ysRz50VYTAKa/uK3y74dITxP7IesM8ckF4Je9XZs6CJMiIcy7NOm
         0qZUFqx0gIukEEbzaraMoLUVM0jqdB+lmc4RSx9KNObUSppOLZaX924imIHDZBn6FCJA
         JmfU/Cd3NrEccfAtFQ5cSCyDcmJ1cZBF8em5nRsFqekUYaqCf8ef6ogskJRV1fLb/olH
         uLt23dzal/B3HLdLgxgc+NJ4Fctg7wQtov8n4QL/H2VCfb1YJU+ie22qsM955MHFsMj2
         52/g==
X-Gm-Message-State: AOJu0Yy9uPKWFsAaYLUrWQ9p7/OfhdYGR+f1NFpNd6C+A/iAyC+uT2kg
	zUdfvWch3Ibo15GOkfivkOqXw9dzFcYmOXNtVhMSBLTLhcHvRY5grggpWwxKAZyCAZedG0apImD
	OPm5XpgnGRZXcH3ya0fYLlD49FfyUSA1hV/Qjsl1GZEaq/ru0kTCXVWeCxInkJl4ruunUKFfeNB
	5zYJLy8Y1FoRkqJQEb5J2J9/zGh/K5jbcLqJ9prROj5LGdHA==
X-Received: by 2002:adf:e909:0:b0:33a:ded1:b01 with SMTP id f9-20020adfe909000000b0033aded10b01mr3642088wrm.28.1706519038045;
        Mon, 29 Jan 2024 01:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVKnXjePT8qznNPLmkBfNjFF0aIxtCnpc7cma66ujpkb6g0ZWX63QCwUZYiXc7/8xFmdApqg==
X-Received: by 2002:adf:e909:0:b0:33a:ded1:b01 with SMTP id f9-20020adfe909000000b0033aded10b01mr3642074wrm.28.1706519037728;
        Mon, 29 Jan 2024 01:03:57 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033946c0f9e7sm7564062wrb.17.2024.01.29.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:03:57 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>
Cc: Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: selftests: Fix clocksource requirements in tests
In-Reply-To: <20240109141121.1619463-1-vkuznets@redhat.com>
References: <20240109141121.1619463-1-vkuznets@redhat.com>
Date: Mon, 29 Jan 2024 10:03:56 +0100
Message-ID: <87a5oo8q9v.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> It was discovered that 'hyperv_clock' fails miserably when the system is
> using an unsupported (by KVM) clocksource, e.g. 'kvm-clock'. The root cause
> of the failure is that 'hyperv_clock' doesn't actually check which clocksource
> is currently in use. Other tests (kvm_clock_test, vmx_nested_tsc_scaling_test)
> have the required check but each test does it on its own.
>
> Generalize clocksource checking infrastructure, make all three clocksource
> dependent tests run with 'tsc' and 'hyperv_clocksource_tsc_page', and skip
> gracefully when run in an unsupported configuration.
>
> The last patch of the series is a loosely related minor nitpick for KVM
> code itself.
>
> Vitaly Kuznetsov (5):
>   KVM: selftests: Generalize check_clocksource() from kvm_clock_test
>   KVM: selftests: Use generic sys_clocksource_is_tsc() in
>     vmx_nested_tsc_scaling_test
>   KVM: selftests: Run clocksource dependent tests with
>     hyperv_clocksource_tsc_page too
>   KVM: selftests: Make hyperv_clock require TSC based system clocksource
>   KVM: x86: Make gtod_is_based_on_tsc() return 'bool'

Ping)

-- 
Vitaly


