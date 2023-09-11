Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4353279B1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345601AbjIKVVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjIKKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:07:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D0101
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:07:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 378722184D;
        Mon, 11 Sep 2023 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694426846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cxPXPMibTU/WQCgXGbiL/szHxJfWSieTNiAS+pJX5EQ=;
        b=IrV7P1MJYIzyfQEKZuvm1I05jsHjizYTsIAn5GC1c1BRO7qOHymsF9qNvbtxbMqmcHfw61
        9txiRa419pMLFZfNc4TlmZxbXwTEmb8WCz9W5sEnYdadhwls5j95bNlIcCoJrcgeRG3/Gr
        gym0kEONOjdlFXYpJBEsIrXpsx6KH+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694426846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cxPXPMibTU/WQCgXGbiL/szHxJfWSieTNiAS+pJX5EQ=;
        b=Vu3Ink0bNrUEvNZM4E/2cRG9LbDABx7hW8SY59QWX7iG0+QM59YIRKKrYssWfxENqngtla
        ADEfDmlp8inithDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28D0F139CC;
        Mon, 11 Sep 2023 10:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1CboCd7m/mRZPQAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 10:07:26 +0000
Date:   Mon, 11 Sep 2023 12:08:01 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC v1 3/4] nvmet-fc: untangle cross refcounting objects
Message-ID: <kl45f37ubitdm7djwb37zxox22e4bieoqdyetxibgb4dtmaevc@jafhs7q2ajy2>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-4-dwagner@suse.de>
 <69c8e29a-cba6-4bd4-adfe-81f507415d5f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c8e29a-cba6-4bd4-adfe-81f507415d5f@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:22:28PM +0200, Hannes Reinecke wrote:
 >   	destroy_workqueue(queue->work_q);
> >   	kfree_rcu(queue, rcu);
> > @@ -1100,6 +1093,11 @@ nvmet_fc_delete_assoc(struct work_struct *work)
> >   		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
> >   	nvmet_fc_delete_target_assoc(assoc);
> > +
> > +	/* release get taken in nvmet_fc_find_target_assoc */
> > +	nvmet_fc_tgt_a_put(assoc);
> > +
> > +	/* final reference from nvmet_fc_ls_create_association */
> >   	nvmet_fc_tgt_a_put(assoc);
> >   }
> That feels wrong. If we're having to do two put in a row it seems that
> we're taking one reference too many here.

When the association is created the first reference is taken. This is
the one we want to release here. But as nvmet_fc_find_target_assoc
always takes a reference we have to drop that one too. One possibility
would be to introduce a lookup function which doesn't take the
reference.

 > +	/* prevent new I/Os entering the queues */
> > +	for (i = NVMET_NR_QUEUES; i >= 0; i--)
> > +		rcu_assign_pointer(assoc->queues[i], NULL);
> > +	list_del_rcu(&assoc->a_list);
> > +	synchronize_rcu();
> Watch out for 'list_del_rcu()'. That does _not_ modify the pointer for the
> element in question, only those from the list.
> So to avoid concurrency with nvmet_fc_alloc_target_assoc() I guess we need
> to get the tgtport lock here.

Yes, we need to protect from concurent write access obviously.
