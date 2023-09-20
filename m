Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E17A6FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjITAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITAi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:38:59 -0400
Received: from out-217.mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F3AD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:38:53 -0700 (PDT)
Date:   Tue, 19 Sep 2023 20:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695170331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaQ4quY2FOsV6dNr0SfZBxe3SAq2X9fKDNK/mTJUPJo=;
        b=fcDGTbVMFIQBEQQkC1wwEadLsMgzFYjQD45cjxVUPdUiWnXP7BAGG2BBy9HL98dl1VVqv8
        MrbxQqzERfO5k8wwlYNRmfFUpUB/liPIKJRtQ+IXJZCPp6TRaP2iiSJG8RAaSd6ifLb7yc
        vSjQ5g13+izc5myuYNdH/3DYZgCA+AA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use snprintf() instead of scnprintf() when
 appropriate
Message-ID: <20230920003847.nus6l45zqhv5hseb@moria.home.lan>
References: <9a998be3e2dbedcd3a9eae5f81ae6dcc6c0f98c4.1694849375.git.christophe.jaillet@wanadoo.fr>
 <ZQmfZ/nPMgiJK9eW@bfoster>
 <20230919190234.2k7v75htqlbfqofh@moria.home.lan>
 <011234f5-19f3-21c5-f0cf-8027971397e7@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <011234f5-19f3-21c5-f0cf-8027971397e7@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:23:47PM +0200, Christophe JAILLET wrote:
> Le 19/09/2023 à 21:02, Kent Overstreet a écrit :
> > On Tue, Sep 19, 2023 at 09:17:27AM -0400, Brian Foster wrote:
> > > On Sat, Sep 16, 2023 at 09:30:19AM +0200, Christophe JAILLET wrote:
> > > > snprintf() and scnprintf() are the same, except for the returned value.
> > > > When this value is not used, it is more logical to use snprintf() which is
> > > > slightly simpler.
> > > > 
> > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > ---
> > > 
> > > Seems reasonable:
> > > 
> > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > 
> > No, let's stay with scnprintf as the default - snprintf should be
> > deprecated except for when its return value is actually needed, using it
> > incorrectly has been a source of buffer overruns in the past.
> > 
> 
> Ok, I was not aware of it.
> 
> In this case, there are also some s/snprintf/scnprintf/ opportunities in
> fs/bcachefs
> 
> Does it make sense to update them or is it too low value changes?

Not terribly important - long term, I want to depracate both snprintf
and scnprintf and convert everything to printbufs.
