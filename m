Return-Path: <linux-kernel+bounces-78961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7BE861B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58BC1F2717F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2A1448D5;
	Fri, 23 Feb 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4K/GDrfG"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326131448C8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712151; cv=none; b=rslN0htKspvzhOXmzXrMX8PJUOT+iZMZRL7XD39eDVp9AhaGhJeUSz7N70gnqVn/lnsU4VlxeeimGFP3GP70udB2T5oONdrYCLG9nkCOpPB7xdc9vH0nLFnKTufKfg2Iq6NcZRam7JbKW725OhGwyeBLe0x4txFQ/huo11jrhfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712151; c=relaxed/simple;
	bh=TmOB000kb/6C0zV1Tjn3FDWwgSTMgtlcQPywExWS40Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ab3Gew2sOfvbmOz+0cEWUQhOXTrRmCxQMiGYCL0gwUjXAYbMb/EnPjVIWm0DUugeLUbXIti6FPIeL0F5JNgY8nCF24S/TIKrhjwJP17XpHN4tmkq6CpZUVXj+WtiFBwGJLaXvpB3SkaKWRLw1AUcKPZlVzWQn4rp90TpocKuZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4K/GDrfG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e43ee3f5e5so844471b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708712149; x=1709316949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gofRIUedDT/xKc1ubX52tMH/cpYoaQz6NlKbBcrt6+o=;
        b=4K/GDrfGXSy3PX2UnKUkv4g9jMc3Yw3IHr/gytYLl0sLA/v0UVdlaPNKJcXFMFaOrT
         gARteDaNNhtoizZfN+Vf16rGmlFMoOTjnIelZ5Vjb/6cQBhlwNuBD48kB7Pv5ATIY/Nj
         hfOIz3ZUxNt7I46Rqhp+IjSSGxVf80YZoMcoV30SPK9OD8azaco7cFPg8BNKE7DBdVdV
         Ngef8Gm6GZy2lCqFWQU0pPcezitPPVHXWoPG8CwCjsDi+Ll8bj//BsG2t14P2zdUGgRI
         upxJ8TK+X6HlVG2fvinx4o7QAkOzqHFNAQ4ftxxMWW2gI8CkhVoAGV3niV1oqJc3AFS8
         JFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708712149; x=1709316949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gofRIUedDT/xKc1ubX52tMH/cpYoaQz6NlKbBcrt6+o=;
        b=BYPK5Q6nPQqrwd42TgHz8jfHsr9hCnSmF3V+tqoBwnf0YMgyXRKim+Dp33BV+1Mske
         AG5qFprAwHIxxav3gAbTp8kIBu18llJGApoOmBfDoD1NXzR18DLAmKoaxByqDWN0EM5R
         ZuF8HWsGDYS69ghktDsSYLiYSUUy9s5UvMJEi2d3QT66nuaFZU1DtFgZ5p3/hFQd/p7M
         hlbWsDp4wVcSGfbbfH3I78GzLQhtuguugN+7NvEBLeWbBNn8Pr55mleKL509/1xqorbt
         Oym3lnzVqJreR0U5+h4WOua/DN7uGP2x5w4kg4DnHGd4s8WxeL0/GKh2ISRp+wywSet1
         vl5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtQw/VULIToMUTlBu72l7PtRWLfPAPBwutR2FaFlpoKh0N5U94I7chqjr9vIGb1RncZ6ovyJqPMnoCjJu+SEKlrlhJ3XLQ6C1Ar/eE
X-Gm-Message-State: AOJu0YxG0IzlbzKEZe2UcQppOJrCrmxJN1umSe7vuFbOMaLPgfDUzIBy
	WsOP4xGkLMUkQoRVHthQiNkyxDpb9W/1gxbPvoEWSTjT8GbI97hiKnNWHD7STZMCvgsO6WwK/W3
	0KA==
X-Google-Smtp-Source: AGHT+IHA5qGOajgwwELgeACPaUAO9bYXI+j7cFhw6n4sGKQCPsx0kAV3xwWYpcshRjU31slvpCwO6XmpndI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:9298:b0:6e4:67cf:fa03 with SMTP id
 jw24-20020a056a00929800b006e467cffa03mr42271pfb.4.1708712149448; Fri, 23 Feb
 2024 10:15:49 -0800 (PST)
Date: Fri, 23 Feb 2024 10:15:47 -0800
In-Reply-To: <ZdgoYcteDOxazzWG@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222012640.2820927-1-seanjc@google.com> <ZdgoYcteDOxazzWG@yzhao56-desk.sh.intel.com>
Message-ID: <Zdjg06QE14w2YDnf@google.com>
Subject: Re: [PATCH v5] KVM: x86/mmu: Retry fault before acquiring mmu_lock if
 mapping is changing
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Friedrich Weber <f.weber@proxmox.com>, Kai Huang <kai.huang@intel.com>, 
	Yuan Yao <yuan.yao@linux.intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 23, 2024, Yan Zhao wrote:
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

Squashed, new hash below.  Thanks!

[1/1] KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is changing
      https://github.com/kvm-x86/linux/commit/d02c357e5bfa

