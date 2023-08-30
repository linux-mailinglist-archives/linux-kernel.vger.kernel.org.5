Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8613578DD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbjH3Svp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbjH3PGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:06:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37BAC;
        Wed, 30 Aug 2023 08:06:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53E271F74B;
        Wed, 30 Aug 2023 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693407960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQgATRv0Yi8dSOXsizpcql2/oe40FoEEth/0M4vOQzM=;
        b=i74ke5EYmN+nuBvfIpv5fQssIN/iuwRGjWUWPuvhq4yxm0U6tFvN5uHv1WDVVwblXr7u7L
        5NIcfJXMboFmwLmsOVTLumnuwmLMel9y3IKHj8dt+l3J/XF7G/mld86ZE06xzjNboH/8P+
        oyted/cJUQeM/7Clf1H9A6UE0NweGMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693407960;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQgATRv0Yi8dSOXsizpcql2/oe40FoEEth/0M4vOQzM=;
        b=9GX8ofwxXSF4PgfWcK3B9cLiDA031+L2dIToWIlgI4jgwZr8uZzr0FrILvEhqMBnympM9z
        ZdE3Es6JtcsS+WAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43C741353E;
        Wed, 30 Aug 2023 15:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id woJ9ENha72T7IgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 30 Aug 2023 15:06:00 +0000
Date:   Wed, 30 Aug 2023 17:06:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v4 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <c36hdvkw2ia5g2e6k2jkagux3by453stigjoik2wf7neinfrew@t35ny54nn7gt>
References: <20230830092019.9846-1-dwagner@suse.de>
 <20230830092019.9846-4-dwagner@suse.de>
 <fhwbcvhmm57c55ozfgtczcix42zri63cswjavre46l42tmzgo7@3krpokexbslw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fhwbcvhmm57c55ozfgtczcix42zri63cswjavre46l42tmzgo7@3krpokexbslw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:38:03PM +0000, Shinichiro Kawasaki wrote:
> > diff --git a/tests/nvme/018 b/tests/nvme/018
> > index 68729c3cb070..19e439f3f3e0 100755
> > --- a/tests/nvme/018
> > +++ b/tests/nvme/018
> > @@ -21,16 +21,9 @@ test() {
> >  
> >  	_setup_nvmet
> >  
> > -	local port
> >  	local nvmedev
> >  
> > -	truncate -s "${nvme_img_size}" "${def_file_path}"
> > -
> > -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> > -		 "${def_subsys_uuid}"
> > -	port="$(_create_nvmet_port "${nvme_trtype}")"
> > -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> > -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> > +	_nvmet_target_setup
> 
> As I noted for v3, I think the line above should be,
> 
> 	_nvmet_target_setup --blkdev file
> 
> If the change is ok for you, I'll add this fix up and apply the
> series.

Sorry, I didn't see it in the response. Sure thing, no objection from my
side.
