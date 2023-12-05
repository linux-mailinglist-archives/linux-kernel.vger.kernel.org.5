Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811408051C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376955AbjLELOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345082AbjLELO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:14:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC84113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:14:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BB3C433C8;
        Tue,  5 Dec 2023 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701774875;
        bh=73OmEx/ffdjmiPEOThkveKIEzd2DYDI4NvXIfUxZjdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGRbNWQ+IVQsfsMM9YLNcHR1m+fzzIM0EaRQrWrQL/rBcp8r3DBycTQdbHRA3dOe2
         1doWXZaDiDWl331klEewtGDlvTUyY02UQoBkw2bXQDnawc6ApM6Abh2EjT+juFRe/n
         +PTbAjPNNw4IwxnKyjjJ4oKjKIQzqLBrsnsP3OnZzdug4c5s7gs/ATpUeYcZH9EzPo
         hi6PdxLFwShnchuxaeJLJ8fOIXHiDUAzll/enY/d//GIFDG3na4pqSeTnDPiL7ggXY
         WKVyCh8Zx8d1alPNFf7wUDxz6UJyXpBCKznT+eKMD3exFCutM8YNpO1zIPMnv0t2Uk
         smO5K6e9ZvNiA==
Date:   Tue, 5 Dec 2023 12:14:29 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
> On 12/4/23 2:02 PM, NeilBrown wrote:
> > It isn't clear to me what _GPL is appropriate, but maybe the rules
> > changed since last I looked..... are there rules?
> > 
> > My reasoning was that the call is effectively part of the user-space
> > ABI.  A user-space process can call this trivially by invoking any
> > system call.  The user-space ABI is explicitly a boundary which the GPL
> > does not cross.  So it doesn't seem appropriate to prevent non-GPL
> > kernel code from doing something that non-GPL user-space code can
> > trivially do.
> 
> By that reasoning, basically everything in the kernel should be non-GPL
> marked. And while task_work can get used by the application, it happens
> only indirectly or implicitly. So I don't think this reasoning is sound
> at all, it's not an exported ABI or API by itself.
> 
> For me, the more core of an export it is, the stronger the reason it
> should be GPL. FWIW, I don't think exporting task_work functionality is
> a good idea in the first place, but if there's a strong reason to do so,

Yeah, I'm not too fond of that part as well. I don't think we want to
give modules the ability to mess with task work. This is just asking for
trouble.
