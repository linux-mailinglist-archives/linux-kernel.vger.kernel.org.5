Return-Path: <linux-kernel+bounces-54620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658A84B195
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0A61F241A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A412D765;
	Tue,  6 Feb 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Kpo4au"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F1512D15A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212923; cv=none; b=ir2S2ihHIzzUoSifrvy+ksLUPFRRW0BTaS+WSoUfd1rJRFwvwoLBu0pn2l69REmVYGz44wMhfqLLnSULCclZ3+ClIvbZ4t8ohdBEpvn+LwSpxfdyJqGPTVGAkPE16a8hLgvbEb34j2tmRWEv/0grclOLZTCIOys0a/EDWWNqpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212923; c=relaxed/simple;
	bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPPzi95PhBCZHO3iDysSpjoHJE1CsQdwTo4c6MMD9QV4eVKHUb65qz6PFVu8P+r0prb1Y0BxhAyiOnOKxPx46Iv0FlbB3xaeCJfKQrCIuLD7GEDRlAORH/OQFrnR1HOZCRUlAUuAEmTq7rEkHjAp5Oh5QcBXZ4jHjyQmq3MTuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2Kpo4au; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
	b=h2Kpo4au8g19SBUWo3a8Cx5lJg6nR1Lh8rSG51SzWkcH+1O1+lR1nyGFoSxBt4m9vtV3QP
	Kg5aYpyHnrNpMy/c57SJbBdD6CLppMH2y+OAL0+PpRl61/oT+4eA8Zh0MclHuO57A9c6gP
	DlyPVIrtAhrxvhls6tH6QUp8Jzm6M5U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-F_pSe24gMzu4yDLKGfIusg-1; Tue, 06 Feb 2024 04:48:39 -0500
X-MC-Unique: F_pSe24gMzu4yDLKGfIusg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7816bea8d28so71322185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212919; x=1707817719;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZECXte5D6jxim+3xK4HKfAtIsgXPnPOa+pKdouz7m2A=;
        b=RMVX9bad+A9U/UzkNoFxx+bnWgz8s/O7F9bi3n5u5d19On65lXbkcwaMAeiwbIhsmI
         sjegJ4mCaRqH9l4oW45pUl+ddX/6msCnrjrGcQnembOoMIDhzPVBJej19HAj/etar37U
         pBSc0FY9l8fRt69ejSw9zse4G/CH2kh2jTvXaBcHfRlRD8hlJXFKQxX6hkazOP4xbx3G
         bHwfDbIHT/heV38iHf+DfeX5C2JR3mavsD4e8jb5vx2jcjsje7ahgHAXIY4nECGFiVwW
         2W1kbERZF2Y5Coe3IKsihwsH6mA+XG2lxqqOpTkzIOxMNUjHhAXBnhZjM9Y2AdKSXauX
         UF0w==
X-Gm-Message-State: AOJu0Yyc/SMFNIlpxE8N39yPDtG2yLXhMW+4X9URoTyUPJ/R4U6CrAdS
	1Cam1qKU0jJno41NvubQwZRjixg5OBsrcN8I1VWsZ35y6cX11cWrTU0KVSe/dJ6eCapMdxa9lYk
	zcuG4ZiiDCw+uNN2UPJwOQBI3za8SabTMT+KLpBVhlvYn2HHTl0j9CYqL+5sFzw==
X-Received: by 2002:a05:620a:a0a:b0:785:440c:88d9 with SMTP id i10-20020a05620a0a0a00b00785440c88d9mr3132320qka.26.1707212919016;
        Tue, 06 Feb 2024 01:48:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVZHwKbOSJItUHx/ikHRtM9wqEPD3H5+QvbQpwtzXtmamlTFpTYFt3g/syo8NgZPxdcW1S0Q==
X-Received: by 2002:a05:620a:a0a:b0:785:440c:88d9 with SMTP id i10-20020a05620a0a0a00b00785440c88d9mr3132299qka.26.1707212918799;
        Tue, 06 Feb 2024 01:48:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrwQH0hQVhe0VPR2hZe1xCBNzOga+tBypyXg9hbQvH1pSJTdI7ZgtdHVcgn6rRQl+DcDxogftvodzYEPMJcaE1n9N7qNBFDS0DzHuY5qac4HvBPl4xY1ZKtO+OG4//zVUqXI6pu9szxT6PbFd+Mg3/Q9NK+yt1QHl673JhfVjN68a+gsIW7JBv8B72s99yHahQdNhMJQCacc10tltod0G851RTWM9eydTsNB65V+244gDRPrxEs38kkuQhc6VsRrfWU8+x+p2KzxN+bFCXjenbh5UvaUgCP/k6wcRaVPZrJmqidM9WzpAXS3w4drJCjsCrAcyPeFlYA3KX3DIPbbrQYBfaanGCJ0r+tQvk66smv+0XgnTtph+0swz1geuaMIoW0VbyW6unIY58owxDU/xoismXsKre7CN8N+hBbz5NFQwr1kx4d9KCg+tBBCw9KWPXRf+Msue1u9Zrurx3kdKYb5j5P+NtCZ28MKScxPbx7tshK/gRorlyHgmpvKz39Q2Wr9OKV7QbVqKcQsTDAwFBNc6/VzBZYuROo9rQkomBdVIQMrxdgleexKu8XRwurJTaACHsWiMlbACtt6c7Aqv5VstSx/I8wnE6bQ==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id vr11-20020a05620a55ab00b007815c25b32bsm764188qkn.35.2024.02.06.01.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:48:38 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Onkarnarth <onkarnath.1@samsung.com>, rafael@kernel.org,
 lenb@kernel.org, bhelgaas@google.com, viresh.kumar@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 r.thapliyal@samsung.com, maninder1.s@samsung.com, Onkarnath
 <onkarnath.1@samsung.com>
Subject: Re: [PATCH 2/2] kernel: sched: print errors with %pe for better
 readability of logs
In-Reply-To: <20240206051120.4173475-2-onkarnath.1@samsung.com>
References: <20240206051120.4173475-1-onkarnath.1@samsung.com>
 <CGME20240206051402epcas5p2ae3737fc0d71ba1d7a7f8bee90438ff2@epcas5p2.samsung.com>
 <20240206051120.4173475-2-onkarnath.1@samsung.com>
Date: Tue, 06 Feb 2024 10:48:33 +0100
Message-ID: <xhsmhh6ilhqj2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 06/02/24 10:41, Onkarnarth wrote:
> From: Onkarnath <onkarnath.1@samsung.com>
>
> instead of printing errros as a number(%ld), it's better to print in string
> format for better readability of logs.
>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>

I quick ripgrep tells me this is the only culprit in sched, so:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


