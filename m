Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E080AF4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574831AbjLHWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574796AbjLHWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:01:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8B10E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:01:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A21C433C8;
        Fri,  8 Dec 2023 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702072881;
        bh=SNEIuK1x82a/ituBsnrXjG/P6Xh0PqqHypBFD2xqtKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKAhh+wz98l5nq5AMUM9KBCVxe786nbpWT05ZNlH3IVPCDVJua0Mus2Bwm7GCM6Mo
         D2QGnJZeO7CBR3qdK3Wely9K8VhPuB8QBJb0LSSZtVQnUCzx3pUG/kOKEuxaE3C0q4
         YR97a1CJt9qex8GMpMrwqLyIv755Nnzqdd1hERKdeBajk/7p9/1WiA6+IKtvMAhUI5
         zMjkYPvgTjUs4Nwb1aNValqVAJiHGLdLAhe+GIAOm+ncgDtp2qrca6sJi2b72hBYht
         lmMrwdyyLCQtwGWqr9C+oUmlug2zjNnou8UnNmbBcd0WB2yM99dImg1SOzFAKbxMlH
         mojxOyRHlqXEg==
Date:   Fri, 8 Dec 2023 23:01:15 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com,
        jlayton@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Message-ID: <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 11:55:19PM +0200, Amir Goldstein wrote:
> On Fri, Dec 8, 2023 at 7:25 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > EVM updates the HMAC in security.evm whenever there is a setxattr or
> > removexattr operation on one of its protected xattrs (e.g. security.ima).
> >
> > Unfortunately, since overlayfs redirects those xattrs operations on the
> > lower filesystem, the EVM HMAC cannot be calculated reliably, since lower
> > inode attributes on which the HMAC is calculated are different from upper
> > inode attributes (for example i_generation and s_uuid).
> >
> > Although maybe it is possible to align such attributes between the lower
> > and the upper inode, another idea is to map security.evm to another name
> > (security.evm_overlayfs)
> 
> If we were to accept this solution, this will need to be trusted.overlay.evm
> to properly support private overlay xattr escaping.
> 
> > during an xattr operation, so that it does not
> > collide with security.evm set by the lower filesystem.
> 
> You are using wrong terminology and it is very confusing to me.

Same.

> see the overlay mount command has lowerdir= and upperdir=.
> Seems that you are using lower filesystem to refer to the upper fs
> and upper filesystem to refer to overlayfs.
> 
> >
> > Whenever overlayfs wants to set security.evm, it is actually setting
> > security.evm_overlayfs calculated with the upper inode attributes. The
> > lower filesystem continues to update security.evm.
> >
> 
> I understand why that works, but I am having a hard time swallowing
> the solution, mainly because I feel that there are other issues on the
> intersection of overlayfs and IMA and I don't feel confident that this
> addresses them all.
> 
> If you want to try to convince me, please try to write a complete
> model of how IMA/EVM works with overlayfs, using the section
> "Permission model" in Documentation/filesystems/overlayfs.rst
> as a reference.

I want us to go the other way. Make the overlayfs layer completely
irrelevant for EVM and IMA. See a related discussion here:

Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
https://lore.kernel.org/r/ZXHZ8uNEg1IK5WMW@do-x1extreme

Amir, if you have some time I'd appreciate a comment on that.
