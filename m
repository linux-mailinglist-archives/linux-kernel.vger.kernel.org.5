Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380737905A8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351688AbjIBGpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DF1702
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 977F8B826E5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 06:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AB4C433C7;
        Sat,  2 Sep 2023 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693637134;
        bh=wm7sF3zBamiGg1IKBgBJoi9/dxFcUsHD5vBVs/FLRKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kpEZD1wAHo2PFqfXCJRNmCxiDym84VPD5lD8/IBID5D1LZkeIySjde+TcRs0HztF1
         pWePFBEg/7xTOA0k/GfrMFNAxYVlLl+JHS9P2lkiWj4TzMjloniiXVoCnsjpUafsHJ
         VfSGJQ3Fv6XRwhiSjkSUDQdQHKMYCfYBlz8RcueI=
Date:   Sat, 2 Sep 2023 08:45:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup() in
 stable-5.10.y
Message-ID: <2023090222-rover-gilled-22d2@gregkh>
References: <ZPKG3VxTIcATSLCX@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPKG3VxTIcATSLCX@westworld>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 05:50:37PM -0700, Kyle Zeng wrote:
> Basically porting c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 to
> stable-v5.10.y to avoid race condition between configfs_dir_lseek and
> configfs_lookup since they both operate ->s_childre and configfs_lookup
> forgets to obtain the lock.
> 
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> ---
>  fs/configfs/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 12388ed4faa5..0b7e9ab517d5 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -479,6 +479,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  	if (!configfs_dirent_is_ready(parent_sd))
>  		goto out;
>  
> +	spin_lock(&configfs_dirent_lock);
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
>  		if (sd->s_type & CONFIGFS_NOT_PINNED) {
>  			const unsigned char * name = configfs_get_name(sd);
> @@ -491,6 +492,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
>  			break;
>  		}
>  	}
> +	spin_unlock(&configfs_dirent_lock);
>  
>  	if (!found) {
>  		/*
> -- 
> 2.34.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
