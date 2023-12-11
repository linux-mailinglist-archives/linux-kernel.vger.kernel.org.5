Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53780D372
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbjLKRPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344301AbjLKRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:15:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699279B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:15:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C42AC433C8;
        Mon, 11 Dec 2023 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702314943;
        bh=cOadndWNrJ59Ef3Nb9Yx1iYcwUhRgTCTQRPzgwoU4Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FILBYqHUPcbUyd5MWCTu3mNk5EOs8PJ4rWZFg9GLN0kT6ocPIWsAtBIc8ph7HLp+e
         4WqN/oiKzN2vUkqnG6fGp2h1pxUuYbEkyrOYSJH1+Nsbp+r3mm3k7aYpivk7JPKKeS
         wbHJRIWhLntVfkEoGT3bjtNKCoLHZ8E+c/gyN15Wkrj7dad+eFA1iZaSPDPu+hPVMQ
         b1nUWtfn7X8Z99blOTIAOyrPjtDz20Jp3CNfsKlIvvoQnF8X+QGwsLWMyx1gGzTBxM
         7sJjeq6UnqyjLaI4yt57m1HzB8oSNs2j0KFKpPJxRUB8x7h+/H/KG8CVvh6dwK8o4k
         Q5NljSbajP44Q==
Date:   Mon, 11 Dec 2023 11:15:42 -0600
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
Message-ID: <ZXdDvgbjSNo78zM2@do-x1extreme>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
 <ZXcsdf6BzszwZc9h@do-x1extreme>
 <6e05677355d6d134dddd11da56709b424b631079.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e05677355d6d134dddd11da56709b424b631079.camel@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 04:41:46PM +0100, Roberto Sassu wrote:
> On Mon, 2023-12-11 at 09:36 -0600, Seth Forshee wrote:
> > On Mon, Dec 11, 2023 at 03:56:06PM +0100, Roberto Sassu wrote:
> > > Ok, I will try.
> > > 
> > > I explain first how EVM works in general, and then why EVM does not
> > > work with overlayfs.
> > > 
> > > EVM gets called before there is a set/removexattr operation, and after,
> > > if that operation is successful. Before the set/removexattr operation
> > > EVM calculates the HMAC on current inode metadata (i_ino, i_generation,
> > > i_uid, i_gid, i_mode, POSIX ACLs, protected xattrs). Finally, it
> > > compares the calculated HMAC with the one in security.evm.
> > > 
> > > If the verification and the set/removexattr operation are successful,
> > > EVM calculates again the HMAC (in the post hooks) based on the updated
> > > inode metadata, and sets security.evm with the new HMAC.
> > > 
> > > The problem is the combination of: overlayfs inodes have different
> > > metadata than the lower/upper inodes; overlayfs calls the VFS to
> > > set/remove xattrs.
> > 
> > I don't know all of the inner workings of overlayfs in detail, but is it
> > not true that whatever metadata an overlayfs mount presents for a given
> > inode is stored in the lower and/or upper filesystem inodes? If the
> > metadata for those inodes is verified with EVM, why is it also necessary
> > to verify the metadata at the overlayfs level? If some overlayfs
> > metadata is currently omitted from the checks on the lower/upper inodes,
> > is there any reason EVM couldn't start including that its checksums?
> 
> Currently, the metadata where there is a misalignment are:
> i_generation, s_uuid, (i_ino?). Maybe there is more?
> 
> If metadata are aligned, there is no need to store two separate HMACs.

I can only think of three possible sources for the metadata overlayfs
presents:

 1. It comes directly from the underlying filesystems
 2. overlayfs synthesizes if from the underlying filesystem data
 3. It's purely generated at runtime

Are there others?

1 and 2 should be covered by EVM on the underlying filesystems. If 3 is
happening then it seems like hashing that data is just confirming that
overlayfs consistently generates the same values for that data, and
verifying code behavior doesn't seem in-scope for EVM.
