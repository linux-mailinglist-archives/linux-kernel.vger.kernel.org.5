Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6537A6B72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjISTVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjISTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:21:32 -0400
Received: from out-216.mta0.migadu.com (out-216.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CCDEA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:21:24 -0700 (PDT)
Date:   Tue, 19 Sep 2023 15:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695151283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xv5u0Lx1YAVDxDp3kvlPUOZmsTDFIJUQDAJJsFCrr2A=;
        b=QGhXnlwyiiTKo6V3l9i+IcB3nPbyRjViI/FaG1sSaSPTIvRQsYqebWdAX637n8jmuDtMcs
        54AElG8hJwLmttVH/Jma4ZQRglZBA6phRznJFMMYHKT1uKmPcIuGd3FAiP3GvjXGPsOsD6
        HawovIgyshQVZPC713mAW4tfRcIJw+U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Avoid a potential memory over-allocation in
 bch2_printbuf_make_room()
Message-ID: <20230919192120.x7xijy6qdcyhvkek@moria.home.lan>
References: <2e6a82a83d0ddd9ce7f36ea889dd7ffc30f5fbc9.1694853900.git.christophe.jaillet@wanadoo.fr>
 <ZQmfpzxX+qjLtJjm@bfoster>
 <2931c006-d987-2261-1c39-5c41a4b17f75@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2931c006-d987-2261-1c39-5c41a4b17f75@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 08:34:00PM +0200, Christophe JAILLET wrote:
> Le 19/09/2023 à 15:18, Brian Foster a écrit :
> > On Sat, Sep 16, 2023 at 10:45:23AM +0200, Christophe JAILLET wrote:
> > > kmalloc() and co. don't always allocate a power of 2 number of bytes.
> > > There are some special handling for 64<n<=96 and 128<n<=192 cases.
> > > 
> > 
> > It's not immediately clear to me what you mean by "special handling."
> > Taking a quick look at slabinfo, it looks like what you mean is that
> > slab rounding is a bit more granular than power of two, particularly in
> > these ranges. Is that right? If so, JFYI it would be helpful to describe
> > that more explicitly in the commit log.
> 
> That's what I tried to do with my 2 phrases.
> Sound good and clear to the French speaking man I am :)
> 
> Would you mind updating the phrasing yourself?
> A trial and error method about wording with a non native English speaking
> person can be somewhat a long and boring experience to me.
> 
> All what I could propose, with the help of google translate, is:
> 
> "
> kmalloc() does not necessarily allocate a number of bytes equal to a power
> of two. There are special cases for sizes between 65 and 96 and between 129
> and 192. In these cases, 96 and 192 bytes are allocated respectively.
> 
> So, instead of forcing an allocation always equal to a power of two, it may
> be interesting to use the same rounding rules as kmalloc(). This helps avoid
> over-allocating some memory.
> 
> Use kmalloc_size_roundup() instead of roundup_pow_of_two().

kmalloc_size_roundup() actually isn't correct in this situation.

Whenever doing a dynamically growable array (e.g. a vector), when
reallocating the new size has to be a constant factor multiple of the
old size. This gets you amortized constant time for vector insertion;
growing the array differently can easily get you O(n^2) time.

IOW, avoiding internal fragmentation isn't what we want; internal
fragmentation is already bounded by the current code.
