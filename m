Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B877DD47
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbjHPJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbjHPJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:28:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C426A4;
        Wed, 16 Aug 2023 02:28:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E7882186F;
        Wed, 16 Aug 2023 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692178115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3v+/Wi405rsVGzzaExajmDFKvpMN/i7HI4eeAj0pfWU=;
        b=XkJanD5yZJgl8bb9mkFXnFDcEx4sySY7RY+x5ufziG1rwpF/bMKnVLphGL1drSm2Y6Ey8r
        2lT7PhBYmm0ZAupI2KUGviMcxa/21SjJBIra0ZxJQkCpVdaBiqoa3mUzdAlXW/yT1gA5IA
        GDxpTfIoyVkJNqCuwQ7H1OWX7j/+sB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692178115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3v+/Wi405rsVGzzaExajmDFKvpMN/i7HI4eeAj0pfWU=;
        b=ULIR+MRWe5CidH1YupjqjCLKpm8hhUkOrppAkcxLSc/mnMVX09az9R0PI4dEpRV+H4MjkQ
        YJ1HkDHmpT3oQfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F29F9133F2;
        Wed, 16 Aug 2023 09:28:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uq0mO8KW3GTYTQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 16 Aug 2023 09:28:34 +0000
Date:   Wed, 16 Aug 2023 11:28:44 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 13/13] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <lfr3tkzz3sqnsw4y7sqyxc42ptvzkyfqfpeko6gzs42jdgjl2d@u5fbzjksbztd>
References: <20230811093614.28005-1-dwagner@suse.de>
 <20230811093614.28005-14-dwagner@suse.de>
 <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 05:55:48PM +0300, Sagi Grimberg wrote:
> > --- a/tests/nvme/003
> > +++ b/tests/nvme/003
> > @@ -22,15 +22,9 @@ test() {
> >   	_setup_nvmet
> > -	local loop_dev
> >   	local port
> > -	port="$(_create_nvmet_port "${nvme_trtype}")"
> > -
> > -	loop_dev="$(losetup -f)"
> > -
> > -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> > -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> > +	port="$(_nvmet_target_setup --blkdev=device)"
> >   	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
> > @@ -46,9 +40,8 @@ test() {
> >   	fi
> >   	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
> > -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> > -	_remove_nvmet_subsystem "${def_subsysnqn}"
> > -	_remove_nvmet_port "${port}"
> > +
> > +	_nvmet_target_cleanup "${port}"
> 
> It is very very strange that _setup returns a port
> which is passed to _cleanup...

This is the only information the _cleanup helper needs and that is why
it survived the refactoring so far.

> I think that _cleanup should simply remove all
> ports, and that setup should not return a port
> to begin with.

This assumes that blktests is the single user and can blindly remove
everything. I would like to play nice here and only cleanup resources
blktests actually allocates.

> If someone needs the actual port number, then it
> should either not use this _setup helper or
> query it somehow.

I try to figure out how to implement such a query helper then.
