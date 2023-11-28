Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA47FB8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjK1LC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbjK1LC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:02:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB4D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:03:03 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23ACC2195A;
        Tue, 28 Nov 2023 11:03:02 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1FA139FC;
        Tue, 28 Nov 2023 11:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id UV1cBubIZWUVcAAAn2gu4w
        (envelope-from <jack@suse.cz>); Tue, 28 Nov 2023 11:03:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8438A07CB; Tue, 28 Nov 2023 12:03:01 +0100 (CET)
Date:   Tue, 28 Nov 2023 12:03:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] f2fs: fix to avoid dirent corruption
Message-ID: <20231128110301.pk3qbhopptmhvxet@quack3>
References: <20231128092516.2882629-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128092516.2882629-1-chao@kernel.org>
X-Spamd-Bar: ++++++++++++++
X-Spam-Score: 14.12
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 23ACC2195A
X-Spamd-Result: default: False [14.12 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(2.75)[0.917];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.52)[80.29%]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 17:25:16, Chao Yu wrote:
> As Al reported in link[1]:
> 
> f2fs_rename()
> ...
> 	if (old_dir != new_dir && !whiteout)
> 		f2fs_set_link(old_inode, old_dir_entry,
> 					old_dir_page, new_dir);
> 	else
> 		f2fs_put_page(old_dir_page, 0);
> 
> You want correct inumber in the ".." link.  And cross-directory
> rename does move the source to new parent, even if you'd been asked
> to leave a whiteout in the old place.
> 
> [1] https://lore.kernel.org/all/20231017055040.GN800259@ZenIV/
> 
> With below testcase, it may cause dirent corruption, due to it missed
> to call f2fs_set_link() to update ".." link to new directory.
> - mkdir -p dir/foo
> - renameat2 -w dir/foo bar
> 
> [ASSERT] (__chk_dots_dentries:1421)  --> Bad inode number[0x4] for '..', parent parent ino is [0x3]
> [FSCK] other corrupted bugs                           [Fail]
> 
> Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
> Cc: Jan Kara <jack@suse.cz>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Chao Yu <chao@kernel.org>

Thanks for fixing this! Makes sense to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/f2fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 3b1793cfb002..ede6afb81762 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -1105,7 +1105,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	}
>  
>  	if (old_dir_entry) {
> -		if (old_dir != new_dir && !whiteout)
> +		if (old_dir != new_dir)
>  			f2fs_set_link(old_inode, old_dir_entry,
>  						old_dir_page, new_dir);
>  		else
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
