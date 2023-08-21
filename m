Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B9782355
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjHUF5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHUF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:57:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6DCA6;
        Sun, 20 Aug 2023 22:57:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28E8A22806;
        Mon, 21 Aug 2023 05:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692597427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVsEL6nmxsm5sImPuZh6istdB2g6qSwClPclyJUG2CE=;
        b=x9vPvOQFSnEMOFkX/D7staROVPNyqnojEUH3p4rgPpMzhfWnB7MZAEGtPgb3u7YEXjAESA
        F9niEuxS1KsUBzNBj+Y/J3mFlE1nCuqozw0zEP0e226GulLXLGU7oG4Z8aPbFfZG4ANVDz
        NmFL38tuWDROC5nSy4N36RiVhTw1i6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692597427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BVsEL6nmxsm5sImPuZh6istdB2g6qSwClPclyJUG2CE=;
        b=cmZ/5/j4KKOkdBSdxlQac4oKT/KvczSUpJZZmi3xRJY8t9Srj0dAsyh5TkaRRoexRis46A
        aKedYmidDpbyTsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F9C813421;
        Mon, 21 Aug 2023 05:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MCDJA7P84mRrdAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 21 Aug 2023 05:57:07 +0000
Date:   Mon, 21 Aug 2023 07:57:20 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v2 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <u2esnihohobu5jaxgz3xdfpjfvfrnmkklzajjrckdnr6g3i54b@qofopy4bhhlp>
References: <20230818141537.22332-1-dwagner@suse.de>
 <20230818141537.22332-4-dwagner@suse.de>
 <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 05:58:34PM +0300, Sagi Grimberg wrote:
> > diff --git a/tests/nvme/003 b/tests/nvme/003
> > index 71b82ce758a3..eed1f549866a 100755
> > --- a/tests/nvme/003
> > +++ b/tests/nvme/003
> > @@ -22,15 +22,8 @@ test() {
> >   	_setup_nvmet
> > -	local loop_dev
> > -	local port
> > -	port="$(_create_nvmet_port "${nvme_trtype}")"
> > -
> > -	loop_dev="$(losetup -f)"
> > -
> > -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> > -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> > +	_nvmet_target_setup --blkdev=device
> 
> --blkdev=device by default no?

Yes. I thought it is better to be explicit in the tests. I don't mind
dropping --blkdev=device if you think we should use the defaults.
