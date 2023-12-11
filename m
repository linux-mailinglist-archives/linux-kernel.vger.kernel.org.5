Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D780CFB5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344107AbjLKPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344386AbjLKPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:36:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E72E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:36:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FAC433C7;
        Mon, 11 Dec 2023 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702308983;
        bh=1KvwnOdKn846sf3NBCoHv3K2XeZjYpErYFAYjSoZsuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGlrXRHHFeOBWA4wq1r4umoZLQo088nLaUT2d4ZwZMhGf2qAE9mT2Oi0qU63jbd3o
         XSuRRDg6bJTDWWPj1WPh8QWw0nRaZblP0OxvwwwQsUa1SoaX0ttlI6pK7cgFLIFFUr
         J00m7LXOZcAyUwmKQGOIRvnpSX6rYOy/CElyn6qmE3RxM14xisAtYWuR4NJwf6SVzI
         ktv4NZYqVcTFwufwU5qp1tVsp/gDZK0yAXIDmQeV/b9t+szXNlVxIbo3/MaoN93SlN
         49xRWHkVl7F3oSqllXIGPGqcWMar8akdbOCzFphHB8PYVIPrFurZO1VeH3cHsCo1Y9
         Mx6PjjtXlTMfA==
Date:   Mon, 11 Dec 2023 09:36:21 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com,
        jlayton@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Message-ID: <ZXcsdf6BzszwZc9h@do-x1extreme>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:56:06PM +0100, Roberto Sassu wrote:
> Ok, I will try.
> 
> I explain first how EVM works in general, and then why EVM does not
> work with overlayfs.
> 
> EVM gets called before there is a set/removexattr operation, and after,
> if that operation is successful. Before the set/removexattr operation
> EVM calculates the HMAC on current inode metadata (i_ino, i_generation,
> i_uid, i_gid, i_mode, POSIX ACLs, protected xattrs). Finally, it
> compares the calculated HMAC with the one in security.evm.
> 
> If the verification and the set/removexattr operation are successful,
> EVM calculates again the HMAC (in the post hooks) based on the updated
> inode metadata, and sets security.evm with the new HMAC.
> 
> The problem is the combination of: overlayfs inodes have different
> metadata than the lower/upper inodes; overlayfs calls the VFS to
> set/remove xattrs.

I don't know all of the inner workings of overlayfs in detail, but is it
not true that whatever metadata an overlayfs mount presents for a given
inode is stored in the lower and/or upper filesystem inodes? If the
metadata for those inodes is verified with EVM, why is it also necessary
to verify the metadata at the overlayfs level? If some overlayfs
metadata is currently omitted from the checks on the lower/upper inodes,
is there any reason EVM couldn't start including that its checksums?
Granted that there could be some backwards compatibility issues, but
maybe inclusion of the overlayfs metadata could be opt-in.

Thanks,
Seth
