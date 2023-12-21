Return-Path: <linux-kernel+bounces-9008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C237F81BF38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010F31C24508
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3413651B8;
	Thu, 21 Dec 2023 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S42+2qFd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F53651B3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3a9b9634dso24085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703187956; x=1703792756; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UlLTxJhr+3mvS0lWPu166Qi9WAJIRoa2lC5FF3ixSk=;
        b=S42+2qFdB0KBvF1MShNOriTXPh0q6GWQdW0G5QoDSn6MzLjtBAFxPa9n7wsIxryhTu
         kSaqNOECeiiPqYRvD17l/8DFRamha3NUHxts48yDRCNXf8T0zKtaoshDrzVA1BXmv8M6
         2FeAaULIeZD7k51G0BEfJ+dhmbNVAqRKDzT1khPyssxPh01Hk8vn6SMskM3i8llLB/Yo
         ys9LmjTfAW8EjKY20xQa9ZZ+EQtl5KXDHiQEMpw0lJZ1lug29PGywu1K5CqRgIwDHNeF
         PNaXbpTju3iktccqhSb9aoOFPchhXn00K2vMjCV4Sln5J+1Z4/ll3/9LkkOSzPJeEnBw
         KKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187956; x=1703792756;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UlLTxJhr+3mvS0lWPu166Qi9WAJIRoa2lC5FF3ixSk=;
        b=TAd0kyOJA9l89zCE8JHDWHYUHbLT/ncx182yIfq+kQ0LUro/PMVZIiuMu1Z8oiPHHD
         KDRaippa+vIn2Y0efKx5LdrdJEqxdOf5/GnXx7HrdJ+/yBrbBHji1NyXhRyZ7XUaTZID
         AYReeBk7fZ4Fqj269D8phLGSUAiLm6favNGojtluv2pD9uvMghpkBW1KsyWWegkKYjaM
         ArISq2qe61sIoSkIhZnk8xEBwuq9hh44R4YgOnWElJ2G8DGyJQkTPsioJYUEmaIfKWJO
         2w0dbzbH0pon3eXeE8vB0CqUplvL+sApk9GNFGszqHRNMZ4izBih8D1GzAKlakRjTqcp
         ifxw==
X-Gm-Message-State: AOJu0YyzizyHtP+33G+0RCg/5XPgKdaJKe8aDRMhGAweFGic3DetyCVc
	gpnnaxXiVMkZBb+izpubjJuBksXojJCR
X-Google-Smtp-Source: AGHT+IHH0GZ0TEFMwakAl2DnF3SX8iuFbzzVFzA49lYHkBAf260BuKQi9+ViLEG6cHxawyJx4YAxJA==
X-Received: by 2002:a17:902:e551:b0:1d4:cae:9a03 with SMTP id n17-20020a170902e55100b001d40cae9a03mr13592plf.23.1703187956107;
        Thu, 21 Dec 2023 11:45:56 -0800 (PST)
Received: from [2620:0:1008:15:184:1476:510:6ea1] ([2620:0:1008:15:184:1476:510:6ea1])
        by smtp.gmail.com with ESMTPSA id e15-20020a056a0000cf00b006d967315fbbsm1974678pfj.136.2023.12.21.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 11:45:55 -0800 (PST)
Date: Thu, 21 Dec 2023 11:45:54 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: David Hildenbrand <david@redhat.com>, 
    Mina Almasry <almasrymina@google.com>, 
    James Houghton <jthoughton@google.com>
cc: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
In-Reply-To: <9c7cc2ed-6f9d-4305-8efa-6381eb9e39d3@redhat.com>
Message-ID: <ab373102-9192-e3bd-e829-63048365b3ca@google.com>
References: <20231220220843.73586-1-mike.kravetz@oracle.com> <9c7cc2ed-6f9d-4305-8efa-6381eb9e39d3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Dec 2023, David Hildenbrand wrote:

> On 20.12.23 23:08, Mike Kravetz wrote:
> > I am stepping away from my role as hugetlb maintainer.  There should be
> > no gap in coverage as Muchun Song is also a hugetlb maintainer.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Mike, thank you so much for all your hard work over all these years!
> 
> It's been a real pleasure working with you every time our upstream paths
> crossed! :)
> 

+100.

Mike, your ownership, expertise, and collaboration have been deeply needed 
but also very motivating and inspiring.

You know how I feel about it.  It's been a pleasure.

