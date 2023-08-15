Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73777D21A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjHOSlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbjHOSlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:41:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAC1FFF;
        Tue, 15 Aug 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mHNIn7uKFSnnp1nclxCiQ71rOU8lQSHsplgNRbzIIZU=; b=sCk6p3X3FLNz2GBwVieDWA851+
        C67vmH7PCNrrj74EbklCKoeyxMsaWnSyuTnyidgfnWp18q72l+AWY03pQ7BICGWpENiJsMUb4T2r0
        s/1eSydCRw0XYOUkpOsi/8Ugxm15ZtDgwg+LnhG0lWvWhxkWG1iSrG3J8nZEZBg585vTC9JmqH+a/
        IaggnNu9LVgdYExzY/Ud1PwvQ0V8xp8T8my+W+LaT2Tiu7IXHJmLv5zWOKfzUsvIAtr/r0eUpLyr5
        cTLhx46Q7MPweb8Dev0rTbSu/mpJMCIMh3gdU6KdbPQlpa9azM+ZJkVAA7vVr8t4ub2hbGWFe+sJS
        Ju0llqvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVyyl-009mPh-NS; Tue, 15 Aug 2023 18:41:19 +0000
Date:   Tue, 15 Aug 2023 19:41:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
Message-ID: <ZNvGz4v2QYowrhk0@casper.infradead.org>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=8DH8SZS2TZF+nHzCq3onXz-OuyE-xmYZncDmiKqVfzQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:35:40PM +0200, Miguel Ojeda wrote:
> On Tue, Aug 15, 2023 at 8:23 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > As an alternative, of course, we could consider turning off those
> > specific warnings entirely for normal builds.
> 
> It could be nice to get to enforce warning-free builds as soon as possible.
> 
> Perhaps we could move those to a `W=1`-like group and clean them over
> time instead? Or do we have that already?

I think the problem is that we don't run kernel-doc by default.  Instead,
it's only run for W=1 (and higher) builds.  That's why Carlos doesn't
see the problems he is introducing in his own builds.  Of course, if
AMD required building with W=1 then they'd see these problems earlier
in their own testing.  Apparently they don't.

Is it time to just run kernel-doc by default?  There aren't _that_
many kernel-doc warnings now.  Not compared to how they used to be.
And enabling them for everyone means that new ones won't sneak in.
I haven't timed how much extra time kernel-doc adds to a build.
Perhaps that's infeasible.
