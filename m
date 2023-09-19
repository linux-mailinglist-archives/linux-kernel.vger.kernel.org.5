Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2347A6B26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjISTDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjISTDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:03:08 -0400
Received: from out-223.mta0.migadu.com (out-223.mta0.migadu.com [IPv6:2001:41d0:1004:224b::df])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD48E42
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:42 -0700 (PDT)
Date:   Tue, 19 Sep 2023 15:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695150158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSD6lpVbHBqAtzSxV7kIH7qFpEjKvTmQlWLkLF1u4Ms=;
        b=bto8GwMS4ZTGGH/Mwp3my/ZOHXdRpU/xssFyvCL/f5UtNmlfivvStIOJk7cCa/0RnOXdzz
        lsvbQOoov7JH2QJc3I7pqop/1EeDaHKwBW1FuNrNPb+EYmG7a9MDcftcjoRDogfN332Piz
        BVrGq0jZ60/miy5kkCd7pJEEpk5W/ko=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use snprintf() instead of scnprintf() when
 appropriate
Message-ID: <20230919190234.2k7v75htqlbfqofh@moria.home.lan>
References: <9a998be3e2dbedcd3a9eae5f81ae6dcc6c0f98c4.1694849375.git.christophe.jaillet@wanadoo.fr>
 <ZQmfZ/nPMgiJK9eW@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQmfZ/nPMgiJK9eW@bfoster>
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

On Tue, Sep 19, 2023 at 09:17:27AM -0400, Brian Foster wrote:
> On Sat, Sep 16, 2023 at 09:30:19AM +0200, Christophe JAILLET wrote:
> > snprintf() and scnprintf() are the same, except for the returned value.
> > When this value is not used, it is more logical to use snprintf() which is
> > slightly simpler.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> 
> Seems reasonable:
> 
> Reviewed-by: Brian Foster <bfoster@redhat.com>

No, let's stay with scnprintf as the default - snprintf should be
deprecated except for when its return value is actually needed, using it
incorrectly has been a source of buffer overruns in the past.
