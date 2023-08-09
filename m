Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0693776AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHIVYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHIVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A81724
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691616241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pab5T/wYPnPTPqi6VHLKDV5cGJ+aQFsll7X5AJmwYhg=;
        b=AoRmKUYKbNmzxKASeWe9UjYkSZC18acVG3Gn08nzCZZGHrPE4rjPQzmUnTGhsaqmrBf5+K
        ZBWCkIAJGg681rk95uiOmTbm0+zaicvmB2IZZsL1bmXznamAM4I059TSFJn6Kordiu26zY
        CitXXi/8FaIVv2GH3hvbN2sHE16gPks=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-qa54dwonM86yNpSA1UNyuA-1; Wed, 09 Aug 2023 17:23:59 -0400
X-MC-Unique: qa54dwonM86yNpSA1UNyuA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63f96fcb4ccso644116d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 14:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691616239; x=1692221039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pab5T/wYPnPTPqi6VHLKDV5cGJ+aQFsll7X5AJmwYhg=;
        b=HQde5Mtl4KtOzVEz4t37uTg7ZpZ/IYxsYZMS4YApqQFQx0yDZXAXv2tLy6tcQFSJ3p
         gttdHkm03PkY5tzw8TadgblUhyAmoADNZNXbdCsclM8CtVPPzmsFygs8mEsqj6rpaPHJ
         u/uy8ZmGLg5VJSjtYpzZOXmMCws/nIwD8xOAQYA7yNcRReRQoC6jjfjSwED3qBGjawVX
         06HdJaDA0VK0QXJsywBP7NT0W3FiFDn6Pt7c4kmwYmJqL0yXZoX01DxNMqCghZdPzUwj
         uu9hSNovh4AgrCmlJ7Z6YhZ57qlEqCNL9ccWtSbSNhf4qgDBTo8NqgvbpA7rL5tmBU7w
         25HQ==
X-Gm-Message-State: AOJu0Yyp6mgy9bNANCVYuyFDfTmxnaZmALE8XLyB2ec9D7vMxD3+ElgW
        hLrBMn3oVOv+EjbM9YvkX0ssCnTGKzCXvDNonCldRyYTO1cx0h5goC3G/qlRPoLRhkNwI2lBD/K
        1S5Kdes3+jF/HeYXCKi9nbGoA
X-Received: by 2002:ad4:5f87:0:b0:63c:f852:aa3a with SMTP id jp7-20020ad45f87000000b0063cf852aa3amr422290qvb.4.1691616239118;
        Wed, 09 Aug 2023 14:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHi2kXqydousZJhJDvXoAPDN6/pIDbQYIYiwnoX8uPhzD3iHOwErPThsw+blPrDnInkOW/ZQ==
X-Received: by 2002:ad4:5f87:0:b0:63c:f852:aa3a with SMTP id jp7-20020ad45f87000000b0063cf852aa3amr422283qvb.4.1691616238907;
        Wed, 09 Aug 2023 14:23:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p1-20020a0c8c81000000b0063f8025407bsm3518958qvb.66.2023.08.09.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:23:58 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:23:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNQD4pxo8svpGmvX@x1n>
References: <20230809083256.699513-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809083256.699513-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David,

Some pure questions below..

On Wed, Aug 09, 2023 at 10:32:56AM +0200, David Hildenbrand wrote:
> Let's track the total mapcount for all large folios in the first subpage.
> 
> The total mapcount is what we actually want to know in folio_mapcount()
> and it is also sufficient for implementing folio_mapped(). This also
> gets rid of any "raceiness" concerns as expressed in
> folio_total_mapcount().

Any more information for that "raciness" described here?

> 
> With sub-PMD THP becoming more important and things looking promising
> that we will soon get support for such anon THP, we want to avoid looping
> over all pages of a folio just to calculate the total mapcount. Further,
> we may soon want to use the total mapcount in other context more
> frequently, so prepare for reading it efficiently and atomically.

Any (perhaps existing) discussion on reduced loops vs added atomic
field/ops?

I had a feeling that there's some discussion behind the proposal of this
patch, if that's the case it'll be great to attach the link in the commit
log.

Thanks,

-- 
Peter Xu

