Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1E788BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbjHYO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbjHYO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:26:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA710FF;
        Fri, 25 Aug 2023 07:26:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECD311F45E;
        Fri, 25 Aug 2023 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692973573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3nAwwAKsWLIJVd2iWItRZG4ru0xIHX7/IuiHEF8IZI=;
        b=HTeF6bZ0VA0DIQlN1T/x+27q58yPLJCNqFMa2xjRtd8bFTQ6dk9RVdiBHaYEGQQD3yhC9p
        gEOECZeO+ZOfcaGAB/MJ+mWkj5Qr0d3klYpkmbT0F/pewNHc1CUjQ0aHfaHe2FhGbh6tNF
        N1zGEue3U39PRNZ5CH+NJ8efsV5lceA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692973573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3nAwwAKsWLIJVd2iWItRZG4ru0xIHX7/IuiHEF8IZI=;
        b=GoFNno7AIFl6spdBIffFERcOsaottt++Igia4izVWJonLfyGRogq00gB6bd5sO/NrKNxaJ
        SHKapJhRtDUbT8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC997138F9;
        Fri, 25 Aug 2023 14:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2H6jNQW66GRzFgAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 25 Aug 2023 14:26:13 +0000
Date:   Fri, 25 Aug 2023 16:26:29 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:45:25AM -0700, Bart Van Assche wrote:
> On 8/25/23 00:34, Shinichiro Kawasaki wrote:
> > Recently, you actively cleans up tests/nvme/* (which is great!), and introduced
> > argument parsers in test/nvme/rc. The first one is _nvme_connect_subsys, and the
> > second one is this _nvme_target_setup. It looks for me this is a bash coding
> > style change in blktests, from "don't use optional arguments often" to "use
> > optional arguments aggressively". If we apply this change, we should suppress
> > SC2119. If we keep the old coding style, we should keep on enabling SC2119. What
> > I see here is the style difference between you and Bart.
> > 
> > Now I'm tempted to disable SC2119, and to go with the new coding style...
> > 
> > If I have any misunderstanding, or if anyone has more comments on this, please
> > let me know.
> 
> I don't like the "new style". What is so hard about typing "$@" to pass all function
> arguments to _nvmet_target_setup()? Leaving out "$@" makes it much harder than
> necessary to figure out the intent of the code author - not passing any arguments
> or passing all caller arguments implicitly.

Because "$@" is just not correct. Also by using defaults we really see
where the test is special.

Let's look at this here:

 _create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"

Both arguments are default values and could just be left out. It makes
reading the code way simpler,

 _create_nvmet_subsystem

Another example, if setup a default target

 _nvmet_target_setup

and if we want to enable the auth code:

 _nvmet_target_setup --ctrlkey "${ctrlkey}" --hostkey "${hostkey}"

and that's all. You can easily see what's is different from the default
values.

The "old" style is expecting that the caller gets the number of
arguments and position correct:

 _create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}" "${ctrlkey}"

And this isn't always the case. I already fixed a couple of bugs where
the test got the order wrong.
