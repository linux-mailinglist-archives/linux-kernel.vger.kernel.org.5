Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BD7E8D91
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 00:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjKKXjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 18:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKXjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 18:39:14 -0500
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C230D0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 15:39:11 -0800 (PST)
Date:   Sat, 11 Nov 2023 18:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699745947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bY38uoL3AzwYw27KFUn5BoU0Pr+lAR8U8j2TvcseFJU=;
        b=TUWsG0Ias66t2B3KVVYr7DFZSdj2lgF1ESXEOUdEPI0uIxcDqKbKXQhNHv8JZSRShhSWwg
        bfA/DsZ0pXxYGOvCRGQiMq40cugAKnNL6kXXf6z446Rzg/W1o/SdLva61q8u58zOf1LWVT
        Z7eI7U3rVcKDdTeHg9hwlfqZzbkeabg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] bcachefs: remove redundant initialization of
 variable level
Message-ID: <20231111233904.zxgqyw3epefiqiro@moria.home.lan>
References: <20231111204528.339603-1-colin.i.king@gmail.com>
 <20231111210208.qra7xhf2nd4pqvst@moria.home.lan>
 <184af6778ab64b3eb6a4a6071974d5e8@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184af6778ab64b3eb6a4a6071974d5e8@AcuMS.aculab.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 09:19:40PM +0000, David Laight wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> > Sent: 11 November 2023 21:02
> > > Variable level is being initialized a value that is never read, the
> > > variable is being re-assigned another value several statements later
> > > on. The initialization is redundant and can be removed. Cleans up
> > > clang scan build warning:
> > >
> > > fs/bcachefs/btree_iter.c:1217:11: warning: Value stored to 'level'
> > > during its initialization is never read [deadcode.DeadStores]
> > >
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > 
> > since we're no longer gnu89, we can simply declare the variable when
> > it's first used, like so:
> 
> ugg... I think that is still frowned upon.
> It makes it very difficult for the average human to find
> the variable declaration.

No, it's 2023, there's no good reason to be declaring variables before
giving them values.
