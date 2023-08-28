Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E284778B5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjH1RDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjH1RCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:02:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7B9CFA;
        Mon, 28 Aug 2023 10:02:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE23E21A70;
        Mon, 28 Aug 2023 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693242106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/98S7UGlGVbuoQo/nQkeiOHz185uMZm/ktFwF4RCt0=;
        b=xlJ2neZhkbrzFt+WcvyWK8eqKP/KAH6rOCB0Csv9ybo5xb4Q3guoy1ibGE5wFCj0WmU04q
        x1SKzZ7UHYWgfHaYWtqtPSwFxejkuRidXAgFbZGt3nT6homX9QemjYw2zFWeaHw95i+xrg
        9CpvKqnX/hc9Ccz/uU7O9I0pq3a2AbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693242106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/98S7UGlGVbuoQo/nQkeiOHz185uMZm/ktFwF4RCt0=;
        b=+JsAubtjiKmzSzUxbJ9lyruBfJY/xAAswrNP81eJp0SXHMhKadCIhsZ17Sw7MWksuy6iY3
        muYkWOR+i0q2OwBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D029D139CC;
        Mon, 28 Aug 2023 17:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BInEMvrS7GRHMgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 28 Aug 2023 17:01:46 +0000
Date:   Mon, 28 Aug 2023 19:02:06 +0200
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
Message-ID: <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
References: <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:14:31AM -0700, Bart Van Assche wrote:
> On 8/27/23 21:13, Shinichiro Kawasaki wrote:
> > For me, your original suggestion to add "ignored_agument" looks better
> > than "$@". (or in short, "noarg" or something)
> 
> It is not clear to me what the intention is of the _nvmet_target_setup
> calls without arguments.

Create a target. That's it. It is really not that complicated.

> Is the intention to pass all arguments that have
> been passed to the caller or is the intention not to pass any
> arguments?

If there are no arguments, the indent is not to pass any arguments.

> In the latter case I think it would be wrong to suppress SC2119 because
> there really is a problem in this case.

IMO, SC2119 is not helping at all. What does it prevent? It doesn't even
understand how many arguments are supposed to be passed into a function.
The few error cases it catches are very limitted.

> How about passing -- as argument
> if the intention is not to pass any arguments? It is a well established
> convention for shell commands and shell functions to ignore the double
> hyphen if it is encountered in the argument list.

I am against adding code just to make ShellCheck happy. If there is
another way achieve this I am all ear.
