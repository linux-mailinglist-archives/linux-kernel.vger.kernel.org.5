Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B167792845
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjIEQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354307AbjIEKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:40:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C25E8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:39:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B13821850;
        Tue,  5 Sep 2023 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693910396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxL7juv5/sEpLVZRkPTB76RBwFoczrKMqzvZ2otKvu0=;
        b=XvyS7ci+Gzc2tebs1hE88GngORss7gTKmhW0slYef07W1bL1VI0u+ufgxigHqt4nDa3pGe
        c3CzAwHWAmFufkIqifBvoaXPZWu27Hm4MMlDP2gJ2JTNskAYBfFI7SW2a6nVNlXrdA7u5v
        WTve5Qz17/XHghKmQhv06RMR9lp6QjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693910396;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxL7juv5/sEpLVZRkPTB76RBwFoczrKMqzvZ2otKvu0=;
        b=QC34U4AyZ9BeP1qTOWcLduVTYsgt9KWWFduofCBvYAg8JSL1XakmHLpQA8TV4ZuOt3ddF1
        2B6BwJ2rrm8hp+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72B5713499;
        Tue,  5 Sep 2023 10:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cIhAG3wF92RiVwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 05 Sep 2023 10:39:56 +0000
Date:   Tue, 5 Sep 2023 12:40:24 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905065032.GC19701@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:50:32AM +0200, Christoph Hellwig wrote:
> > +	/* No port assigned, portentrybinding is missing */
> 
> Double new line above, and I think a missing white space before
> binding.

Yep, sorry.

> But I'm still confused how we can get here without req->port
> set.  Can you try to do a little more analysis as I suspect we have
> a deeper problem somewhere.

I am only able to reproduce this if there are two connect/discovery
attempts happening at the same time. I'll collect some logs and attempt
to make some sense out of it.
