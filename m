Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48957AE8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjIZJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjIZJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA9AE9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:19:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD47C433C8;
        Tue, 26 Sep 2023 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695719998;
        bh=HzbEbZtASjTJB3RhDRnx8gM/YjcynxWzT3Xudsg8SzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh1cHwzf9nvtQopCJS14ZitmlFtcO6JBJQ+SjXMsK7rStxkaojY/85hVHUmBCCOpI
         nxVNgBBj5Swv9zmMrn5HWJY6TL6h5BOO/FgaEqimaRk5hSVUpNfQ51pD1kU7HyGMJ0
         3WgHkA/VnC5z504019Da4BpaA6NH6Hv/QTClY2zU=
Date:   Tue, 26 Sep 2023 11:19:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Tree Davies <tdavies@darkphysics.net>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: fix structure alignment
Message-ID: <2023092618-finally-dropbox-6bff@gregkh>
References: <20230925155413.471287-1-arnd@kernel.org>
 <9d96db4f-0b79-0940-ef95-d9bd70dc9a18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d96db4f-0b79-0940-ef95-d9bd70dc9a18@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:11:14PM +0200, Philipp Hortmann wrote:
> On 9/25/23 17:54, Arnd Bergmann wrote:
> > From: Arnd Bergmann<arnd@arndb.de>
> > 
> > A recent cleanup changed the rtl8192e from using the custom misaligned
> > rtllib_hdr_3addr structure to the generic ieee80211_hdr_3addr definition
> > that enforces 16-bit structure alignment in memory.
> > 
> > This causes a gcc warning about conflicting alignment requirements:
> > 
> > drivers/staging/rtl8192e/rtllib.h:645:1: error: alignment 1 of 'struct rtllib_authentication' is less than 2 [-Werror=packed-not-aligned]
> >    645 | } __packed;
> >        | ^
> > rtllib.h:650:1: error: alignment 1 of 'struct rtllib_disauth' is less than 2 [-Werror=packed-not-aligned]
> > rtllib.h:655:1: error: alignment 1 of 'struct rtllib_disassoc' is less than 2 [-Werror=packed-not-aligned]
> > rtllib.h:661:1: error: alignment 1 of 'struct rtllib_probe_request' is less than 2 [-Werror=packed-not-aligned]
> > rtllib.h:672:1: error: alignment 1 of 'struct rtllib_probe_response' is less than 2 [-Werror=packed-not-aligned]
> > rtllib.h:683:1: error: alignment 1 of 'struct rtllib_assoc_request_frame' is less than 2 [-Werror=packed-not-aligned]
> > rtllib.h:691:1: error: alignment 1 of 'struct rtllib_assoc_response_frame' is less than 2 [-Werror=packed-not-aligned]
> > 
> > Change all of the structure definitions that include this one to also
> > use 16-bit alignment. This assumes that the objects are actually aligned
> > in memory, but that is normally guaranteed by the slab allocator already.
> > 
> > All members of the structure definitions are already 16-bit aligned,
> > so the layouts do not change. As an added benefit, 16-bit accesses are
> > generally faster than 8-bit accesses, so architectures without unaligned
> > load/store instructions can produce better code now by avoiding byte-wise
> > accesses.
> > 
> > Fixes: 71ddc43ed7c71 ("staging: rtl8192e: Replace struct rtllib_hdr_3addr in structs of rtllib.h")
> > Signed-off-by: Arnd Bergmann<arnd@arndb.de>
> 
> Hi,
> 
> thanks for your support.
> 
> your patches cannot be applied on top of the 24 patches which are in the
> queue. But may be Greg will not accept all of the patches send in.
> 
> Will see what happens when Greg sorts them out.
> 
> I tried your patches on hardware without the 24 patches send in. All OK
> 
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

The first one didn't apply as it was already sent by someone else, but
the second one applied fine, thanks.

greg k-h
