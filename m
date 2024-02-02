Return-Path: <linux-kernel+bounces-50471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6C847984
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CEE28851E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320168175B;
	Fri,  2 Feb 2024 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="B+zXFQma"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601281732
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901314; cv=none; b=WM/K6ejnJqVtCO+URHrmryM+9Ohgj+BAf7o4Y78fQAxNjO3rFsrWpduA3a5x244d53LiLf/m1iZHOMM404d9RkGcLmyxbX+q6UROG+SWqk81AULlD91ToutpUM9lO635nMOg55WlbZQ3ekomg/9gL2uupNl0iJ5mnZXk7HDhr+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901314; c=relaxed/simple;
	bh=Qkg5eFUSCl733X8fpmEZ2SfBmPh8Cs0pCAFSoIGM7XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8pEQTpMAamtcPY9wpnvchvcM7m+ccePN95k88nKK1E/GftMC5jGY0hGDCEWLWZGjhnbuHzzBtXY4BQscDZOHCqLie2xCykWAfR/PF5lmfWdneLM6Izy2Tl+3NjHuz9EawUrQgpy6A7P0xeGt2UHkRyCXXSnv1y6w2FiULN0Z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=B+zXFQma reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a4516ec46so11095751cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706901312; x=1707506112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkg5eFUSCl733X8fpmEZ2SfBmPh8Cs0pCAFSoIGM7XM=;
        b=B+zXFQma58Eaurq1lGtPMKYnAsFFSt8lixgg2rr3UzdzuMFvjfHm0qntzY9e8r+qZ5
         gSETG0QwmgFdrABZMEXXorhDJdMnVJbcL4yxy3LIOJmy8posW4gbd1X1pQftuz+5bZMz
         HENl2PDDgj8GjDu7xwtEB7+UASkh6yI+Yqg6Dz9/MDNzsxWWOzPMiMHOClNcuRIm/QpX
         1x2CbXvALFFmYXfL6K7t0kDdYd0xO8EpfTrnHPQ2xZ6gS1BQsCznD45KFBWhBsneuT/0
         iJMNdnGE6oboyWOUWJ6ob1x3wrztTQI65duMkWzvCU7GSkQtmmoSkPNGvcwnyTHGPNgw
         JZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901312; x=1707506112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qkg5eFUSCl733X8fpmEZ2SfBmPh8Cs0pCAFSoIGM7XM=;
        b=hMwH8rpTbxAqRx/gojzuUT59punyDWTpktBESbEdXQoSgrGHEBZZ5ExEgGDph5Y5e1
         5ymmrFcrdOm7l7pUGNidiYdLx+JaaagH7Fob+wxoukacKok1npDX5jX6zm9C9aGa6ZD1
         a1xz5QsIrCifbZgXGU24/m0ts54P3r6CWeQCbAdUl+X3P/niIv5XOxoneoJ+v6DM7mib
         d8UtIcZwhe3qT77ow67eRHhR0ExXDx2Uq6h7PSluoRSEZFNd3a4fAe0x5u6H4dldGClE
         QjtT67n//UH/bjChEY59gUdy1y7Q45np6Lf6Dd9QyFxyQdTyLk1oYqBwqEtCh6xrBgnG
         mXBw==
X-Gm-Message-State: AOJu0Yx3U5Dq43uPORy11MPe+s5NdH9mJWnm41n8s4BNyEvsJCOugQga
	b5tjetsfl+hqhpKolMNSsT7/KyDze799W+XvF9i05Y7IXcCF9qWMIvIOj85v79Hx03yr1PeaghI
	9Fp4FqggvCS9GVEPRVDU9yo/6rIxxvG3clf05nQ==
X-Google-Smtp-Source: AGHT+IGRYLsM+jFPG/+OQ6YbfxNeymzH6TMB4pT268OsL/EM4HwUGWuXnrdcfT7i3XzApUte4yWs+G5NVXUrdrCl+P4=
X-Received: by 2002:a05:622a:ce:b0:42a:9d1f:d0e5 with SMTP id
 p14-20020a05622a00ce00b0042a9d1fd0e5mr123854qtw.11.1706901312011; Fri, 02 Feb
 2024 11:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com>
 <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com> <CA+CK2bCFbeRHT172KUci5+8WJNUeo-2A1M=UXsSqqOy64w1LJw@mail.gmail.com>
 <bcddef81-3979-4ad0-b3f6-771871a44433@arm.com>
In-Reply-To: <bcddef81-3979-4ad0-b3f6-771871a44433@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Feb 2024 14:14:35 -0500
Message-ID: <CA+CK2bD=h+rp4M8+vf3pjzrGAw3QE_LjxK0c-8YCNT=D+wYknQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> Yikes, so it really does just have that many IOMMU groups? OK, fair
> enough, call me convinced :)
>
> On balance though, I think I'd prefer to just stick the lifecycle
> management into iova_cache_{get,put} for simplicity - spending ~256
> bytes on another kmem_cache we might not use can hardly be significantly
> more than the extra code and static data necessary to track its usage
> separately anyway.

Sure, I will send a v2 soon.

Pasha

