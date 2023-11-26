Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAC7F959F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjKZVzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4EB101
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701035723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbvJtYTtIvQRI2d4NOXWwsD4H2hzcPgDD+3up9r2zCY=;
        b=TE7icV5jhWPIELcobs6ZjMyvUvyxdE12xLLke6EzhssNSj9FafsOg/wGb2BRiDwtzku4o4
        dMDrEeD5+a95yv8jWY3IAaP8W28xcr7ZQzQwnU5EZ+3LE/FG1CoSD60oAeDWAvRmxfmji8
        LyWv8g0sm07zIwG+dR26Ydhbi9+3Rfw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-YqaFML-jMe6aX38p6asZ7w-1; Sun, 26 Nov 2023 16:55:22 -0500
X-MC-Unique: YqaFML-jMe6aX38p6asZ7w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67a06b43afcso10573546d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701035722; x=1701640522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbvJtYTtIvQRI2d4NOXWwsD4H2hzcPgDD+3up9r2zCY=;
        b=qVnwc7tMSnJU5I13Pi6DUEKWeGejdxSJY5AJmwEl3A15hSfJw4tU6ye3ab16jlwXFq
         Ba4uVc1qDStLuJJthSNBfHo7+uKTY6/mQ/UPZNDgs/reXKioBieTrxnS7hHrAWXfxE3e
         5QdgZUxYsap3GPLz++Eg9XvI8IFYmZTvD5RomOifYPKbtMxNmF+EPahHp/RDoJomV3Po
         LbKFdL06A782uYspDtBodzfxWdtpzgvh9pa6KZlzHf7KfDhpxMhQCphoOQLJHkfXefNu
         dtMoE+iVdXsBDuQtasYXbh5KaoIJ6WKOsCGivLMPoW1ME+cdCBopMc6iKv9HgRgWfjqO
         Bj8Q==
X-Gm-Message-State: AOJu0Yy/IN0zXVghMDNph+UR18rCw4VmfrueJJrqbXmMYYi6Po9xyLE7
        AzB0qZXyhOu1geJn46yL3KFPj+HMi8UJilGK6jPrVDApoXsXzQw5UtL83CoFe5Uka7B81KtEVqG
        wp5lCHkMK4fQXRNzFk0CpH8wp
X-Received: by 2002:a05:6214:1399:b0:678:35a9:c363 with SMTP id pp25-20020a056214139900b0067835a9c363mr10204052qvb.4.1701035721817;
        Sun, 26 Nov 2023 13:55:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrj7rvSi4WYmtvmsm7IEhv876JUypNDuTPYd75xUfSQZ7KXreqK0bnc3jiC5Le0Za2wN2+gA==
X-Received: by 2002:a05:6214:1399:b0:678:35a9:c363 with SMTP id pp25-20020a056214139900b0067835a9c363mr10204039qvb.4.1701035721527;
        Sun, 26 Nov 2023 13:55:21 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id a13-20020a0cb34d000000b00677adcfd261sm893391qvf.89.2023.11.26.13.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 13:55:20 -0800 (PST)
Date:   Sun, 26 Nov 2023 16:55:19 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/gup: Fix follow_devmap_p[mu]d() on page==NULL handling
Message-ID: <ZWO-x_ElKe6qtsIq@x1n>
References: <20231123180222.1048297-1-peterx@redhat.com>
 <20231124112059.3519d6fdfe71f846f8bf726f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124112059.3519d6fdfe71f846f8bf726f@linux-foundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:20:59AM -0800, Andrew Morton wrote:
> On Thu, 23 Nov 2023 13:02:22 -0500 Peter Xu <peterx@redhat.com> wrote:
> 
> > This is a bug found not by any report but only by code observations.
> > 
> > When GUP sees a devpmd/devpud and if page==NULL is returned, it means a
> > fault is probably required.  Here falling through when page==NULL can cause
> > unexpected behavior.
> > 
> 
> Well this is worrisome.  We aren't able to construct a test case to
> demonstrate this bug?  Why is that?  Is it perhaps just dead code?

IIUC it's not dead code. Take the example of follow_devmap_pmd(), it can
return page==NULL at least when seeing write bit missing:

	if (flags & FOLL_WRITE && !pmd_write(*pmd))
		return NULL;

AFAICT it can happen if someone does "echo 4 > /proc/$PID/clear_refs" when
the mm contains the devmap pmd.  Same to pud.

It'll be nice if someone that works with dax would like to verify it.  In
my series (refactor hugetlb gup, part 2) IIUC some hugetlb selftest can
start to trigger this path, but I'll need to check.  So far it's dax-only.

Thanks,

-- 
Peter Xu

