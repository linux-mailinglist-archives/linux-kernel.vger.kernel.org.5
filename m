Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B27885D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbjHYLeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjHYLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:33:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDD1FF7;
        Fri, 25 Aug 2023 04:33:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E91721F99;
        Fri, 25 Aug 2023 11:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692962932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XTQTzS7jcW5Dyy70M1pwbotuquEpW0pW0g8qkbMwvjI=;
        b=Y7RosvmMmMWKXTY3jAPvch+LYM6Xhah4CZ+LYCfgpYHbAdSsNIYgy0+56Ed9DWkGnesy/X
        AKbVO9/nwMeAFrNmEWV4b6rJWClbzKf0vs3Vti/AyE0mV378sqNAfxbfMLa2o5IuOnRl3f
        ycyIsbg9uXQIeITAarhBvm7L2J1yw7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692962932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XTQTzS7jcW5Dyy70M1pwbotuquEpW0pW0g8qkbMwvjI=;
        b=sZQ4exe0xCHdRY6mCYV3Wv1Xzq6NgHdVEAUMcacq8P8Od6utsz0UsAJLFyobcasbPZLTml
        gMzDSDR2NiT7XUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E85E0138F9;
        Fri, 25 Aug 2023 11:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K2u3OHOQ6GSJPAAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 25 Aug 2023 11:28:51 +0000
Date:   Fri, 25 Aug 2023 13:29:08 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <kmnosm2p2vct7sxalz2dhr2yt32s2vdx2hvuvk4jli2hwjudv7@gdkrlayoojrf>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 07:34:21AM +0000, Shinichiro Kawasaki wrote:
> IMO, SC2119 is not broken. SC2119 (and its companion SC2120) assumes that bash
> functions do not have optional arguments. If any functions which refer arguments
> are called without arguments, it complains. With the assumption, SC2119 is
> useful to detect missing arguments of function calls. (I guess Bart thinks this
> is useful.)

I wanted to say that the implementation of SC2119 is broken, not the
SC2119/SC2120 itself. Sorry for the confusion.

> However, when we implement argument parsers in bash functions so that the
> arguments can be optional, the assumption for the SC2119 is wrong. Then SC2119
> reports are useless. Until recently, blktests had few functions with such
> optional arguments, such as _init_null_blk or _init_scsi_debug. But most of
> calls to those functions had some arguments, and it was rare to call them
> without any argument. So SC2119 reports were easy to suppress and not a pain.
>
>     I doubt Shellcheck can be improved and detect if functions have the optional
>     argument parsers...

No idea. But we are not alone with this problem:

https://github.com/koalaman/shellcheck/issues/2511

> Recently, you actively cleans up tests/nvme/* (which is great!), and introduced
> argument parsers in test/nvme/rc. The first one is _nvme_connect_subsys, and the
> second one is this _nvme_target_setup. It looks for me this is a bash coding
> style change in blktests, from "don't use optional arguments often" to "use
> optional arguments aggressively".

Yes, it's a bit excessive to hand in all possible arguments all the
time. Especially it makes it even hard to review if only value changes
but 6 default values are passed to the setup function.

> If we apply this change, we should suppress
> SC2119. If we keep the old coding style, we should keep on enabling SC2119. What
> I see here is the style difference between you and Bart.
>
> Now I'm tempted to disable SC2119, and to go with the new coding style...
> 
> If I have any misunderstanding, or if anyone has more comments on this, please
> let me know.

All good from my side.
