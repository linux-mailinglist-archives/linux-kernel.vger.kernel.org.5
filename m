Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13D0787FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjHYGZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHYGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:24:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D83A1BDB;
        Thu, 24 Aug 2023 23:24:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1007F1F8B0;
        Fri, 25 Aug 2023 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692944678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUtDy3vy5owHa1nT7w/gfPpkT2zQPnqVi3pslPb35oc=;
        b=KjL+qbyt3oKatnDWHUK+0GA6xt9mmc7xpJ0yM/pocrAofJaCW+82fvEqeMVyIx1gR/urpz
        S/viyFJS3n2cHx2kK5hoGg+g8U36wWLlDJVvPuPw97v5oeC3kH14APVYAe1/6Jasb6Mooe
        4I1eC1b5rAox9MICii2iMdkZh71DyGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692944678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gUtDy3vy5owHa1nT7w/gfPpkT2zQPnqVi3pslPb35oc=;
        b=qT9WmPLRfqMP1Qm8+ziDKk9uH4PY41ZoprTBna3qyhiIQKKVVi5CIuqEo/TulajcpemShO
        RI1d20vY8aiYO3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 010D01340A;
        Fri, 25 Aug 2023 06:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I+ZuOyVJ6GTrKAAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 25 Aug 2023 06:24:37 +0000
Date:   Fri, 25 Aug 2023 08:24:53 +0200
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
Message-ID: <fkj36wd64v3nzs5uy776zqqxqlyxucsyf7xbjzuxdy6d4lfagz@kzryxwk6ptfr>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 07:36:12AM -0700, Bart Van Assche wrote:
> On 8/23/23 20:09, Shinichiro Kawasaki wrote:
> > CC+: Bart,
> > 
> > This patch makes shellcheck unhappy:
> > 
> > tests/nvme/003:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/004:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/005:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/006:24:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/008:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/010:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/012:29:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/014:28:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/018:26:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/019:27:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > tests/nvme/023:25:2: note: Use _nvmet_target_setup "$@" if function's $1 should mean script's $1. [SC2119]
> > 
> > But I think the warn SC2119 is false-positive and we should suppress it. In the
> > past, blktests had suppressed it until the recent commit 26664dff17b6 ("Do not
> > suppress any shellcheck warnings"). I think this commit should be reverted
> > together with this series.
> Please do not revert commit 26664dff17b6 because it produces useful
> warnings. Do you agree that the above warnings are easy to suppress,
> e.g. by changing "_nvmet_target_setup" into
> "_nvmet_target_setup ignored_argument"?

Well, these warnings could be address by adding back '--blkdev=device',
but I just dropped them on Sagi's request.

So what is it going to be? Ignoring SC2119 or adding and default
argument? I personally would rather add SC2119 because there a lot of
more callers which hand in default arguments which I would like to
remove anyway. Working around ShellCheck current limitation seems wrong
to me.
