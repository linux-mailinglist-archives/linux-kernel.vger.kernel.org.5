Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C637E049D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377776AbjKCOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjKCOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:22:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F917D42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED2CC433C7;
        Fri,  3 Nov 2023 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699021334;
        bh=i4n+Ca8lHKiU8bKf7X1drUsWnYBFo6sjVmEhJySGhLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBqtSDCsfrF7qq6D7S2hdg43EUXJkXtETu1ye6NCHLfGWUk5WFYCsZrUuYLqAsCG1
         RFAFUs7K4GLdJK2NtMq9QdY9FWmbKwh1RcGWD6uf6w5GCk5YfS6pfJ7H6rO5/0O84X
         WE1GGVz9XFPH42p9ClNiUBdTvuZG5JPovtUIPVNHyWJfcvARVmnRiLtNisMK+M6JYO
         D1uAxNFEnuVvkamh3TYXPwYoS2xMnQL+NXtUFscHQrryhTKFX06y2oEfTKUd5JTp7Q
         VEhFhuoYTTwYOfN0q4fzcAO16+d1NjbYo0dMXA6MeyfWwadRjGFOiZ56gR1cZSdtCF
         770S+I+gJJoRA==
Date:   Fri, 3 Nov 2023 08:22:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103135857.GA1871@lst.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 02:58:57PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2023 at 01:11:02PM +0100, Daniel Wagner wrote:
> > This particular firmware seem to interpret afi one based, while
> > the this patch assumes it is zero based
> 
> >   Active Firmware Info (AFI): Specifies information about the active
> >                               firmware revision.
> > 
> >   Bit 7    is reserved.
> >   Bits 6:4 indicates the firmware slot that is going to be activated
> >            at the next Controller Level Reset. If this field is 0h,
> >            then the controller does not indicate the firmware slot that
> >            is going to be activated at the next Controller Level Reset.
> >   Bit 3    is reserved.
> >   Bits 2:0 indicates the firmware slot from which the actively running
> >            firmware revision was loaded.
> > 
> > 
> > It's not clear to me if afi bits 2:0 is zero or one based. Bits 6:4
> > indicate to be 1 based.
> 
> All 0's based (what a stupid term..) fields in NVMe are explicitly
> marked as such.  And even if that wasn't the case I'd very much
> expect the same encoding for the two sub-fields.

Yeah, it's just the firmware slot number, taken literally. AFI = 1 means
slot 1, AFI = 2 means slot 2, etc... Slot 0 either has special meaning
(firmware commit SF field, or fw log AFI bits 6:4), or is reserved
value, like in Identify Controller FRMW.NOFS, and has no place in the FW
Slot Info log page.

Our first slot in the log page is defined as slot one, so we have to
subtract one from the AFI field to index into the slot array. I messed
up for not catching that earlier, but thanks for pointing it out now.
