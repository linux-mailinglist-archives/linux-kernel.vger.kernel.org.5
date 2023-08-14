Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625777BBED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjHNOr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjHNOrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:47:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A4FB;
        Mon, 14 Aug 2023 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692024437; x=1723560437;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SwxToorH4LgH7jwfHn1hXLYyL2h15SyaEeJMRni0FNM=;
  b=S/kdzO/ticF5natalJ8S8GEMS8g5etsr/58glyFROSYxrTPvJQk2h1rW
   WXl7yQv9bkteIxANYQwhxouiDKnhHvSZ2UfT57IwRrnHqmq2Xr4F3D8hw
   LLWPSvquE33BnwBo07QkkHyqqP9ahd8ZUA73vDo+6Rr8OkF7z4en5ydpe
   xRm94BdhpkqzUPAWfEYPBpWpnfnO2qKvDRQ5Jr8KVyt5xr7GThk9+Lj2x
   WFZo6xD8vyhc6HVe74jcnTWGTeJXmPeipkTKMwJL0NbOQ1ejQthaXJj74
   Wd+WArToaGeVKsbtNsKq/G/hc4D6m/sn7sAN4/kvpBVFWmBrIbhGi9YnI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438386031"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438386031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="798838558"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="798838558"
Received: from lgarello-mobl.ger.corp.intel.com ([10.249.40.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 07:47:14 -0700
Date:   Mon, 14 Aug 2023 17:47:12 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/36] tty: type unifications -- part I.
In-Reply-To: <8a0b6de4-3459-76fb-9117-287e71e315f1@kernel.org>
Message-ID: <88934c8-43f2-1928-e02f-469ca3ed37b@linux.intel.com>
References: <20230810091510.13006-1-jirislaby@kernel.org> <728dc060-d38c-b8d4-783-2322115cf4b4@linux.intel.com> <8a0b6de4-3459-76fb-9117-287e71e315f1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-381600617-1692024436=:8221"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-381600617-1692024436=:8221
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 14 Aug 2023, Jiri Slaby wrote:

> On 11. 08. 23, 12:26, Ilpo Järvinen wrote:
> > On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:
> > 
> > > Currently, the tty layer ops and functions use various types for same
> > > things:
> > > * characters and flags: unsigned char, char are used on a random basis,
> > > * counts: int, unsigned int, size_t are used, again more-or-less
> > >    randomly.
> > > 
> > > This makes it rather hard to remember where each type is required and it
> > > also makes the code harder to follow. Also the code has to do min_t() on
> > > many places simply because the variables hold the same kind of data, but
> > > of different type.
> > > 
> > > This is the first part of the series to unify the types:
> > > * make characters and flags 'u8'. This is what the hardware expects and
> > >    what feeds the tty layer with. Since we compile with -funsigned-char,
> > >    char and unsigned char are the same types on all platforms. So there
> > >    is no actual change in type.
> > > * make sizes/counts 'size_t'. This is what comes from the VFS layer and
> > >    some tty functions already operate on this. So instead of using
> > >    "shorter" (in term of bytes on 64bit) unsigned int, stick to size_t
> > >    and promote it to most places.
> > > 
> > > More cleanup and spreading will be done in tty_buffer, n_tty, and
> > > likely other places later.
> > > 
> > > Patches 1-8 are cleanups only. The rest (the real switch) depends on
> > > those.
> > 
> > Yeah, very much needed change and step into the right direction!
> > 
> > It's a bit tedious to review all this and comment a particular subchange
> > but e.g. n_tty_receive_buf_common() still seems to still have int count
> > which I think fall into the same call chain about size/count (probably
> > most related change is #15). Note though that it also has room which I
> > think can actually become negative so it might not be as straightforward
> > search and replace like some other parts are.
> 
> tl;dr
> https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=9abb593df5a9b9b72d13438f1862ca67936f6b66
> 
> ----
> 
> Yes, sorry, my bad -- I forgot to elaborate on why this is "part I." and what
> is going to be part II., III., ...
> 
> So yeah, I have more in my queue which is growing a lot. I had to cut it at
> some point as I was losing myself in all the changes already. So I flushed
> this "part I.". It is only a minimalistic change in the core and necessary
> changes in drivers' hooks. Parts II. and on will spread this more, of course.
> Ideally, to every single loop in every driver ;) (in long-term).
> 
> I still have a bunch of changes for tty_buffer and n_tty in my queue. As soon
> as I rebase on the today's -next which is already supposed to contain this
> part I., I will send part II. with these changes. I could have merged those
> II. changes to some earlier I. patches. At first, I actually did try, but the
> patches were growing with more and more dependencies, so I stopped this
> approach. Instead, I separated the changes per the core/ldisc/drivers. The
> parts are self-contained, despite it might look like the changes are
> incomplete (i.e. not everything is changed everywhere). After all, I wanted to
> avoid one hundred+ patches series.

Yeah, right. Very much understandable. I realized you probably had more 
patches somewhere due to "Part I" designation but I couldn't check so I 
just noted the things that I came up during the review.


-- 
 i.

--8323329-381600617-1692024436=:8221--
