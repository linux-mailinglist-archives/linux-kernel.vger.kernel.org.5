Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A17FF67E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjK3Qng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3Qnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:43:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE110DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:43:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E27C433C7;
        Thu, 30 Nov 2023 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701362621;
        bh=Y4sgZDhs4wynPu47QMjQjQHfSY0fT9c/kB/u77jBAg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWmkzBCcc03gYkV1g/4ZMIMtNwjz8M8v20ER1M80R/lbHM3FMU6q/uOuSCweHsyCt
         i9B1Q5/QsNYeJEm50I/mcZO8F6+dURkViHUWGV99uMg/lzVCpGdYXAonMMvirJeOeX
         PzHwSe+jzSNwLF02Qc6OgwFWGE2WbHgBm3IC+S+nauyTpZORqTYW5mn89ikFgZOSJY
         6/joQKMbn3Mc7+WBZ9v+be2BEsyDQmS0IxOiVoDg8jNyMaOmNZZfbel6yVXtExBvLl
         rswEj7+T8NbulbipMkNtf0n1Kk98brwqIXbz6sFbEHoXmFyU5WfkyqwtXXGw72IlZ5
         rj/aFVcvYlO2A==
Date:   Thu, 30 Nov 2023 10:43:40 -0600
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 12/16] ovl: use vfs_{get,set}_fscaps() for copy-up
Message-ID: <ZWi7vATF7xIKxlsr@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-12-da5a26058a5b@kernel.org>
 <CAOQ4uxj=oR+yj19rUm0E6cHTiStniqvebtZSDhV3XZC1qz6n6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj=oR+yj19rUm0E6cHTiStniqvebtZSDhV3XZC1qz6n6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:23:28AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:50 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Using vfs_{get,set}xattr() for fscaps will be blocked in a future
> > commit, so convert ovl to use the new interfaces. Also remove the now
> > unused ovl_getxattr_value().
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> 
> You may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks!

> I am assuming that this work is destined to be merged via the vfs tree?
> Note that there is already a (non-conflicting) patch to copy_up.c on
> Christian's vfs.rw branch.

I'll leave that up to Christian. There are also other mnt_idmapping.h
changes on vfs.misc which could cause (probably minor) conflicts.
