Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C277ED727
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjKOWYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOWYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:24:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13921B5;
        Wed, 15 Nov 2023 14:24:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FF3C433C8;
        Wed, 15 Nov 2023 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700087088;
        bh=o7doXvqwltwUV8V68TqR52d0LmoD4TiQv6gTiuIzICY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lAzQTfPii7YyO9EJiuGq1lHzs2XKAOSZgAeoBL5XTTjDKDEdZM8Qx3cYI0APH5+GB
         807YMWx8T3U4GrvZtnzBWAvr6gU9kr4bBYBsJvAOETdgkcSHUIWFu61z6VLCCV5UeZ
         6csz4zTm8y9LQfGEzi4MbBcHnmwIZQNjedBJFq6M=
Date:   Wed, 15 Nov 2023 14:24:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 5/5] ramfs: Initialize security of in-memory inodes
Message-Id: <20231115142447.91e59671ad26f7671bbf7467@linux-foundation.org>
In-Reply-To: <379f6a45a3102e8cd1ed992c1895ac9f69ae0595.camel@huaweicloud.com>
References: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
        <20230724151341.538889-6-roberto.sassu@huaweicloud.com>
        <379f6a45a3102e8cd1ed992c1895ac9f69ae0595.camel@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 09:01:52 +0100 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

> On Mon, 2023-07-24 at 17:13 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add a call security_inode_init_security() after ramfs_get_inode(), to let
> > LSMs initialize the inode security field. Skip ramfs_fill_super(), as the
> > initialization is done through the sb_set_mnt_opts hook.
> > 
> > Calling security_inode_init_security() call inside ramfs_get_inode() is
> > not possible since, for CONFIG_SHMEM=n, tmpfs also calls the former after
> > the latter.
> > 
> > Pass NULL as initxattrs() callback to security_inode_init_security(), since
> > the purpose of the call is only to initialize the in-memory inodes.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> + Andrew
> 
> Hi Andrew
> 
> I'm proposing an extension to initialize the inode security field at
> inode creation time for filesystems that don't support xattrs (ramfs in
> this case).
> 
> The LSM infrastructure already supports setting the inode security
> field, but only at run-time, with the inode_setsecurity hook.
> 
> I developed this to do some testing on the Smack LSM, and I thought it
> could be useful anyway.
> 
> Casey would need your acked-by, to carry this patch in his repository.
> I'm not completely sure if you are the maintainer, but in the past you
> accepted a patch for ramfs.
> 
> If you have time and you could have a look, that would be great!

Patch looks OK to me.  Please cc Hugh and myself on a resend.

One little thing:

> > +++ b/fs/ramfs/inode.c
> > @@ -102,6 +102,14 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >  	int error = -ENOSPC;
> >  
> >  	if (inode) {
> > +		error = security_inode_init_security(inode, dir,
> > +						     &dentry->d_name, NULL,
> > +						     NULL);
> > +		if (error) {
> > +			iput(inode);
> > +			return error;

A `break' here would be better.  To avoid having multiple return
points, which are often a maintenance hassle.  Same treatment at
the other sites.


