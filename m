Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0078B5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjH1RDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjH1RDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:03:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BEF1B4;
        Mon, 28 Aug 2023 10:03:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5728D1F893;
        Mon, 28 Aug 2023 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693242179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fKxbHovoW9XOUx8UBnrQ59wSczavgRhLVHzRx9n7a+w=;
        b=VirYMM3rl+Mg0M8e2Vr9grkGN6ys+JjWzk1rIJgcaxd6VV416mfMsJeZNn2BWcBsObrfuJ
        u0BS3ALDU//eg0fHWtGuoTnvW4g4ggiaK2vLyMwpH1YLiLdlca1PuhLERFN7Vtp0YOR508
        rzubehfeg95Jwvb6r3suFQIkDpov3i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693242179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fKxbHovoW9XOUx8UBnrQ59wSczavgRhLVHzRx9n7a+w=;
        b=ddl3c+iOwY/c+T3tQvOOpFihSYHD/CAbsfzAgiDVUJh+BEN2QtQ1mKhS9aow+epTg3cjs1
        uIyDh/nmqOw+YICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49048139CC;
        Mon, 28 Aug 2023 17:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xR6jEUPT7GTHMgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 28 Aug 2023 17:02:59 +0000
Date:   Mon, 28 Aug 2023 19:03:18 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <3mp746jccer7dbn4ra4h5ag66d7dn7gqebriwliicdgzevrmgn@lir2lwtnlbhz>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <8e407992-d6da-46e2-a006-ad3b3cdfb101@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e407992-d6da-46e2-a006-ad3b3cdfb101@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:14:09AM -0700, Bart Van Assche wrote:
> On 8/22/23 01:38, Daniel Wagner wrote:
> > +	while [[ $# -gt 0 ]]; do
> > +		case $1 in
> > +			--blkdev)
> > +				blkdev_type="$2"
> > +				shift 2
> > +				;;
> > +			--ctrlkey)
> > +				ctrlkey="$2"
> > +				shift 2
> > +				;;
> > +			--hostkey)
> > +				hostkey="$2"
> > +				shift 2
> > +				;;
> > +			*)
> > +				shift
> > +				;;
> > +		esac
> > +	done
> 
> So all arguments that are not recognized are ignored? That will
> make debugging typo's harder than necessary. Shouldn't this function
> complain if an unrecognized argument is encountered?

Sure, I'll add a warning.
