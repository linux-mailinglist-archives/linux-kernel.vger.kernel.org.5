Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80F67CEAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJRWER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJRWEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:04:15 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AF10F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:04:13 -0700 (PDT)
Date:   Wed, 18 Oct 2023 18:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697666651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2s3U1yAkM0di0yOCxQzp2ytWG3Emh1ypqTY1EYO4mxw=;
        b=s1UMVl3cbdUUtkb57UUvuFyq4GhP0cIIbcrHXN/hjQSZ2ymQwfVvzpXbJQZ2G90Ex+DldY
        TT4ybtNZhgETfTVatkwg6v/+EhdN1E0i1zmDhyWdg5Y46EHh0KpwMwFpDXINvBF7qTsnF0
        6yNmfX0ieuecgs8Po7tHkg9dWk4NVGU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310131637.D0C66BFBA@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > Hi Kees,
> > 
> > I'm curious if this is something that could be buried in bch_val given
> > it's already kind of a fake structure..? If not, my only nitty comment
> 
> I was thinking it would be best to keep the flexible array has "high" in
> the struct as possible, as in the future more refactoring will be needed
> to avoid having flex arrays overlap with other members in composite
> structures. So instead of pushing into bch_val, I left it at the highest
> level possible, bch_i, as that's the struct being used by the memcpy().

I agree with Brian here - I'd like this buried in bch_val, if possible.

I also went with unsafe_memcpy() for now - that's now in my for-next
tree. I'm not seeing any advantage of DECLARE_FLEX_ARRAY over that -
perhaps later if we could use __counted_by that would make more sense.
