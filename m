Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5476861A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjG3Otq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG3Otp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:49:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FFE10FC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690728582; bh=TRywIwPXDbHu1vSNNPMz1Joh4YYQ4PeMEVeLuCqRoP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izuL/t4lxQw+GaprvhGV3fAftYInA/FG0b4TTR9vVqvitJ1+1NWqTlYfdkLi64SUo
         TqSGrTXST9vCgQbo01i3IrKA6fwKqEWWIne0YLKMeqcMCA1NJ2LnGhoLQ55rWN1gEA
         hDyT2W6KSrzgEBSrefKbFIh6HRM5kXs2eFMyR/Ok=
Date:   Sun, 30 Jul 2023 16:49:41 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
Message-ID: <498e86f9-a7c3-4689-b277-319633a11789@t-8ch.de>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
 <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
 <bdd94a7c-7364-c262-ed01-d7e6fcb26007@linux.alibaba.com>
 <9299dd4c-c2da-4ed1-8979-87fa44c68f77@t-8ch.de>
 <ab54e2a5-ecbf-508f-b382-05648fb3a36c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab54e2a5-ecbf-508f-b382-05648fb3a36c@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-30 22:37:19+0800, Gao Xiang wrote:
> On 2023/7/30 22:28, Thomas Weißschuh wrote:
> > On 2023-07-30 22:01:11+0800, Gao Xiang wrote:
> > > On 2023/7/30 21:31, Thomas Weißschuh wrote:
> > > > On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
> > > > > Later we're going to try the self-contained image verification.
> > > > > The current superblock checksum feature has quite limited
> > > > > functionality, instead, merkle trees can provide better protection
> > > > > for image integrity.
> > > > 
> > > > The crc32c checksum is also used by libblkid to gain more confidence
> > > > in its filesystem detection.
> > > > I guess a merkle tree would be much harder to implement.
> > > > 
> > > > This is for example used by the mount(8) cli program to allow mounting
> > > > of devices without explicitly needing to specify a filesystem.
> > > > 
> > > > Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
> > > > break when the checksum is removed.
> > 
> > > I'm not sure if we could switch EROFS_FEATURE_SB_CSUM to a simpler
> > > checksum instead (e.g. just sum each byte up if both
> > > EROFS_FEATURE_SB_CSUM and COMPAT_XATTR_FILTER bits are set, or
> > > ignore checksums completely at least in the kernel) if the better
> > > filesystem detection by using sb chksum is needed (not sure if other
> > > filesystems have sb chksum or just do magic comparsion)?
> > 
> > Overloading EROFS_FEATURE_SB_CSUM in combination with
> > COMPAT_XATTR_FILTER would break all existing deployments of libblkid, so
> > it's not an option.
> 
> I think for libblkid, you could still use:
>   EROFS_FEATURE_SB_CSUM is not set, don't check anything;
>   EROFS_FEATURE_SB_CSUM only is set, check with crc32c;
>   EROFS_FEATURE_SB_CSUM | COMPAT_XATTR_FILTER (or some other bit) is
> set, check with a simpler hash?

We could change this in newer versions of libblkid.
But we can't change the older versions that are already deployed today.

And the current code does

if (EROFS_FEATURE_SB_CSUM)
  validate_crc32c();

So to stay compatible we need to keep the relationship of
EROFS_FEATURE_SB_CSUM -> crc32c.

> > All other serious and halfway modern filesystems do have superblock
> > checksums which are also checked by libblkid.
> > 
> > > The main problem here is after xattr name filter feature is added
> > > (xxhash is generally faster than crc32c), there could be two
> > > hard-depended hashing algorithms, this increases more dependency
> > > especially for embededed devices.
> > 
> >  From libblkid side nothing really speaks against a simpler checksum.
> > XOR is easy to implement and xxhash is already part of libblkid for
> > other filesystems.
> > 
> > The drawbacks are:
> > * It would need a completely new feature bit in erofs.
> > * Old versions of libblkid could not validate checksums on newer
> >    filesystems.
> 
> just checking magic for Old versions of libblkid will cause false
> positive in which extent?

Hard to tell for sure. But it would not surprise me if it would indeed
affect users as experience has shown.

Imagine for example erofs filesystems that have then been overwritten
with another filesystem but still have a valid erofs magic.
With the checksum validation the new filesystem is detected correctly,
without it will find the old erofs.

Sometimes the files inside some filesystem look like the superblock of
another filesystem and break the detection.

etc.

Having some sort of checksum makes this much easier to handle.
