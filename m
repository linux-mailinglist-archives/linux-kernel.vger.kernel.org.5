Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233227FD633
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjK2MCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjK2MCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:02:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7791D48;
        Wed, 29 Nov 2023 04:02:56 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 855351FCFE;
        Wed, 29 Nov 2023 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701259373;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yw/XIw5coCIlNnynmsFGRhp35bs4mVOy79EN53352Ts=;
        b=MjZWe4mMM4IznNoH/ARywYBUkxAhkLShnVSX5yiBWbXQ9WgoA62Dl71DEWCtz71PfDnKwn
        WhL2UpDr7bsj4Z0bntUPXeSCgQQmoBTAIClZINGzm3WvKmi8vaLO1kO24/l4SGrCjwZbTw
        i8C7VsuORd21IhbuF7odJBb8uQd8y6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701259373;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yw/XIw5coCIlNnynmsFGRhp35bs4mVOy79EN53352Ts=;
        b=TpC8O/QePgE9pVjDkyADQ8SgFGJT9R1eTdkuKNDeLnGV3Sv4VLofH5WJ2mGnYtYvIhzhcI
        4CGyrACd7n9ZMPCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 66E341336F;
        Wed, 29 Nov 2023 12:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id OibhGG0oZ2X/AgAAn2gu4w
        (envelope-from <dsterba@suse.cz>); Wed, 29 Nov 2023 12:02:53 +0000
Date:   Wed, 29 Nov 2023 12:55:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix btrfs_parse_param() build failure
Message-ID: <20231129115536.GQ18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231129120036.3908495-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129120036.3908495-1-arnd@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.02 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,arndb.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.02)[54.68%]
X-Spam-Score: -1.02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 01:00:29PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_BTRFS_FS_POSIX_ACL disabled, the newly added function fails
> to build because of an apparent broken rebase:
> 
> fs/btrfs/super.c: In function 'btrfs_parse_param':
> fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this function); did you mean 'net'?
>   416 |                         ret = -EINVAL;
>       |                         ^~~
> 
> Just return the error directly here instead of the incorrect unwinding.
> 
> Fixes: a7293bf27082 ("btrfs: add parse_param callback for the new mount api")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Should be fixed in today's for-next snapshot, thanks.
