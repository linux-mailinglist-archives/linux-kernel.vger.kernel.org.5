Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E77782D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjHJVsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHJVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:48:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48201273D;
        Thu, 10 Aug 2023 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8vTYiM25zm5QiHj6u+PpIV7asjNd6laYCLcoo/Q4uEM=; b=cu+Q71lgi2lFBnmQy8bl+qJEDx
        QZlZ0QhUlUFNALuDSWWL+c7+IazU0lhKgqFpEE1l8uhytThtCeIUpEqOU0AwC0wpj2Z5fSCtLbg42
        LUs1Peuo6wlCs+RGjk/Gmli+ibfliizbJVp2oiS0P7ywpoeA+VWpON6ewfLwOqpDjEV9TnUXXNk1w
        N8mEj5bdpk8i9GEbgYioVJpLuXNQZpqYX5N6nHkSplGlncS9sIGN8u5T9vYmaDoFJDWWX+i2Fe2tm
        13XojrkrMCnf0GJskN5ceXd3f5GFKgtSjymEj9iBCrgOAnvi4jMujBg+jeOYH1dkI7DIPfHJEfkNU
        EjC3XOpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUDWL-00Et27-RY; Thu, 10 Aug 2023 21:48:41 +0000
Date:   Thu, 10 Aug 2023 22:48:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNVbObUGbos73ZJ5@casper.infradead.org>
References: <20230809083256.699513-1-david@redhat.com>
 <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com>
 <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
 <ZNVPJ9xxd2oarR3I@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNVPJ9xxd2oarR3I@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:57:11PM -0400, Peter Xu wrote:
> AFAICS if that patch was all correct (while I'm not yet sure..), you can
> actually fit your new total mapcount field into page 1 so even avoid the
> extra cacheline access.  You can have a look: the trick is refcount for
> tail page 1 is still seems to be free on 32 bits (if that was your worry
> before).  Then it'll be very nice if to keep Hugh's counter all in tail 1.

No, refcount must be 0 on all tail pages.  We rely on this in many places
in the MM.
