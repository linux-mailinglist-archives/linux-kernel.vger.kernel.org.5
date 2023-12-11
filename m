Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A480D4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjLKSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjLKSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:01:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0C9D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:01:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCCEC433C7;
        Mon, 11 Dec 2023 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702317678;
        bh=YJWISt590/g0otblmkssjtUeSQnjpGCXYjZSjuDzcf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewKcaYCzaPwT9dVHWHwwInwt5Sej4niDOrEwZv6S36t142PbL4/VOJpVE+ojMsGC0
         qork2wL3Mv6DeeO9RmzPXQdcBxjOf1150pRqFqB2zCQbWB6h2hXTIxG9zC9gTLZbqj
         H8hyw7zdZ8QcPEeG2aoZaPYWwzkbwwINoPB+SJuJHBbNXs7QohPpcp3X/9HB4R1NxS
         epRO96d6Y1ja1aq6HuWdeHBrFU1fTXl21VbDG3jywLiRbc9EYtQiITIPVIBZOOA8bZ
         Pb/E52Z6bBCbaP2L/GYXiAve1A82LlgYQj1fbiW7qmE3cT1AWXydoqS37ORc6E25jj
         UKvO45i8ZaXcg==
Date:   Mon, 11 Dec 2023 19:01:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Seth Forshee <sforshee@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com,
        jlayton@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Message-ID: <20231211-fortziehen-basen-b8c0639044b8@brauner>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The second problem is that one security.evm is not enough. We need two,
> to store the two different HMACs. And we need both at the same time,
> since when overlayfs is mounted the lower/upper directories can be
> still accessible.

"Changes to the underlying filesystems while part of a mounted overlay
filesystem are not allowed. If the underlying filesystem is changed, the
behavior of the overlay is undefined, though it will not result in a
crash or deadlock."

https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-filesystems

So I don't know why this would be a problem.

> In the example I described, IMA tries to update security.ima, but this
> causes EVM to attempt updating security.evm twice (once after the upper
> filesystem performed the setxattr requested by overlayfs, another after
> overlayfs performed the setxattr requested by IMA; the latter fails

So I think phrasing it this way is confusiong. All that overlayfs does
is to forward that setxattr request to the upper layer. So really the
overlayfs layer here is irrelevant?

> since EVM does not allow the VFS to directly update the HMAC).

Callchains and details, please. I don't understand what you mean.

> 
> Remapping security.evm to security.evm_overlayfs (now
> trusted.overlay.evm) allows us to store both HMACs separately and to
> know which one to use.
> 
> I just realized that the new xattr name should be public, because EVM
> rejects HMAC updates, so we should reject HMAC updates based on the new
> xattr name too.

I won't support any of this going in unless there's a comprehensive
description of where this is all supposed to go and there's a
comprehensive and coherent story of what EVM and IMA want to achieve for
overlayfs or stacking filesystems in general. The past months we've seen
a bunch of ductape to taper over this pretty basic question and there's
no end in sight apparently.

Really, we need a comprehensive solution for both IMA and EVM it seems.
And before that is solved we'll not be merging anything of this sort and
won't make any impactful uapi changes such as exposing a new security.*
xattr.
