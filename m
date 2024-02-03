Return-Path: <linux-kernel+bounces-50824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B7847E69
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F591C2189D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2574694;
	Sat,  3 Feb 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32mR5Qd5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B41FCC
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927423; cv=none; b=rJ/9jiJfes8R/cnt2+8BAvgveqVPA8ljOr3aCVXNZ2hH5Hz2shUBnEXo25/iuNP6yZqORpl88nanIUta5n6qPqCAbuNRtaQ80JFHeQavVPrwtmXnlGmSMKJhc9SwjG9MFWOfdLo6FFAEizrm1ofUcdQiorSym5YQNqatVhISgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927423; c=relaxed/simple;
	bh=31MALDMSUlwza8Dx/4jdfU0IQzumSFSUtKLVbEOi408=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gYp6ifBV+84N9Xm3uOCmoldBiclVGCkosYPgR6B1URqqa23odl3darSmCag8NCoUcOAi9j/b0PvEAHZ9BlDgdD9ws0LbY8DlZfb5uh/tATcYlIM/pM9SPU/Rmfwnd7GmBLQVh0ZJ2qsukNYOHu+yJP+9KcpnpSL6Mm28vvq0xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32mR5Qd5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d89f0ab02bso33735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 18:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706927421; x=1707532221; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XiG6CHWcYdWsI51hB+FTszglKDybzSu63LtpZjDM7i0=;
        b=32mR5Qd5K4IbmXXr65Gv5dvewTWAXdJ16FTFeTg0fwYXqMXS+inlGm0BfdQN20TfTV
         zf6yfqIEKEI/9Q/2l+7k1vrAuVKENANxDv0VAB4z3sA4kJbEOsgYpAGuwl6VJIfgNX+U
         2jhatu0ygruO0+ePvPy481s8JLhEjuRFR9DJ0aZtzlflGnHXW4lT6jTB2X7HDKLC2Lut
         v5XV2whbZXQQvzhjUZBrpc6C12jVprcBrN1bAHBndSJGY/2AjMhJoQf2SCJxG/KuCblk
         Qpn07AE1bDr8Zj8bPfb6ISBI24achdKf+5K7wT1nluOOmfbl0NA+1CrJ2vvCvib+lnEt
         DdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706927421; x=1707532221;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiG6CHWcYdWsI51hB+FTszglKDybzSu63LtpZjDM7i0=;
        b=M+Dgy1/fcDCgTi2WoeWzC8EJsvMuF6eXEw60pET59j9rxMiPuTZB3i6EJBjeCdtRVp
         OMKmAvrbdPo2NKCrPLs6GO5jP1BEIrgB5+aLDRRE9BovfAxFkYLNS6UAQE0MKVEZZAEk
         yyp3Tgu8995J0H2HjHemCVgHQQngLujXAJeyU/93XkiqZRvjXGHOkJupeWt46LAqGSSw
         dil4RfZuXt9/g4oTt1R/FLx9tYOwK3PB7tO8iFFSc1x/wdeisiRfDxmg7sH1dcdOUyuy
         evUEX3UsFZ+s3ulrBpFmat9RHdpnMGWbm5y2F6EPO9VC0zVIsPN5fZ3YKanSAsVowHME
         KCCA==
X-Gm-Message-State: AOJu0YxDQhv+lyn4xrhDgYkJ/nkHQWQ2KKQWVaikHY6lI+Dg7ICgB3Ck
	I+dzVRCu5rLqBH46+MbCdqbbv5LFGqtplyWpJbsRJ4aQ2jSM4EBbgL2OFElUUA==
X-Google-Smtp-Source: AGHT+IHg996dygyt9LnIiSvyqK9FLVoUTcVkp9Miw1CYvlt+COnosUlv02z5yOlwrNv7Cbz2O6gz9w==
X-Received: by 2002:a17:902:fccc:b0:1d9:8e37:56cc with SMTP id mi12-20020a170902fccc00b001d98e3756ccmr24869plb.10.1706927420652;
        Fri, 02 Feb 2024 18:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTJg+AEeBfOkpo/qJURUeu9o91x/nT1ZbAlXanN+fx4CgxYbFsH5DaRxefHDJLKAYgGLQ9IF9TOBbXgio9d1sxnArAMI62kfjIQwVRJFFH1C9Ih6WTB1vIMmmUJuIENK0KKVsZQ4f704yNfhvb8lj6P0i5wwsr5hTBgf/Qp63kzfRV9uhpKaPlEc3BSUA1ANE+aU210RCJmd+3VGAQMclintHIwqZRC6nPSf5y5OBzfg==
Received: from [2620:0:1008:15:5706:ac37:6d6d:7587] ([2620:0:1008:15:5706:ac37:6d6d:7587])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090ad50b00b0029658c7bd53sm747960pju.5.2024.02.02.18.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 18:30:20 -0800 (PST)
Date: Fri, 2 Feb 2024 18:30:19 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
    iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    yosryahmed@google.com
Subject: Re: [PATCH v2] iommu/iova: use named kmem_cache for iova magazines
In-Reply-To: <20240202192820.536408-1-pasha.tatashin@soleen.com>
Message-ID: <d506a467-8af7-dc26-709a-ba49e6c5a3a6@google.com>
References: <20240202192820.536408-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Feb 2024, Pasha Tatashin wrote:

> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability purpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
> 
> With this change:
> 
> > slabtop -o | head
>  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>  Active / Total Caches (% used)     : 135 / 211 (64.0%)
>  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> 
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> 
> On this machine it is now clear that magazine use 242M of kmem memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Very impressive!

Acked-by: David Rientjes <rientjes@google.com>

