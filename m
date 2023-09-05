Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681717925D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjIEQCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354258AbjIEKZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:25:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC8CE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:25:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E90921832;
        Tue,  5 Sep 2023 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693909519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=694nKN4ExyQrxRRysh2YmMnPN+5dzRGEaf0BQ2Mbzm0=;
        b=A3XnTG6oHa5tCYnpBeqqKHOXcgArPLPpSP580o2PjGBN1DCBX+ApYKHdTVjL+sCUzKcEdF
        0yEFzeo5SIW4rDH3Wz+9gAfkWmmsf+8i1JE3OOmVvRPn39nCKbjtZdd3mqpj4mNGHDfj8T
        bkMkV1KKbNZph/XMPPtw64NTvf88Yjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693909519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=694nKN4ExyQrxRRysh2YmMnPN+5dzRGEaf0BQ2Mbzm0=;
        b=1NBvVtGHMjvFJlhgRXTDEQ9OmW3hOKT/RRLiHXsuvwAlE0PLUeEruIOXTRlMEBnNzCLydi
        8nIxEZ2NC5yqqyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F6EC13911;
        Tue,  5 Sep 2023 10:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eeV1Dw8C92QyTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 05 Sep 2023 10:25:19 +0000
Date:   Tue, 5 Sep 2023 12:25:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 2/4] nvmet-trace: null terminate device name string
 correctly
Message-ID: <jnuxxernxywnyrcotnm3peryeiw6adc3gd7qn4u35lpwz4ekds@nl6zd5fecdju>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-3-dwagner@suse.de>
 <20230905064921.GB19701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905064921.GB19701@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:49:21AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 29, 2023 at 11:13:47AM +0200, Daniel Wagner wrote:
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  drivers/nvme/target/trace.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
> > index 6997bd7e45cf..9ba466b49613 100644
> > --- a/drivers/nvme/target/trace.h
> > +++ b/drivers/nvme/target/trace.h
> > @@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
> >  		return;
> >  	}
> >  
> > -	strncpy(name, req->ns->device_path,
> > -		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
> > +	strscpy(name, req->ns->device_path,
> > +		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));
> 
> I'd just switch to snprintf instead, that the best way to ensure
> termination..

Okay, but we still need the +1 as the string is cut short; 'loop0' gets
logged as 'loop' at least with the strscpy variant.
