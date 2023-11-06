Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6C7E2A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjKFQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:44:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8D191
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:44:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5688C433C7;
        Mon,  6 Nov 2023 16:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699289083;
        bh=lwJGtrml9/BgrDRgIC5tla53Nlno4JDjCOXCP23EQDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4DdHXUJuh/SmClx633LjRNEta2shZD6iz6oYhV19nmfkaeaMz1gIgehwrDxRA0D0
         EMIH3PR8CTbejhC7n4bL4wDtbBejOqOZy39eMizFgg34EHNUmlPHw35uSHxHknXIsu
         kydnEJXa7tjrti7GTRRxelxrCq/ONQEBvx0wGpUw8Xd/Q+7g5yP5NnY5rDaIhEwYT6
         YZ0D8F9vQoys/cntstVZQ449HhV09eRuon2ZuuH2sjCsi/ZaRi42dWG0gcz7BxvpyU
         rR5PqW2STsA408kvutNZuSl1EWg1Zl10JQZCuHkBEk/oxQpyfpQjXb1Fx4SDSBOXFm
         zN6dm38at9V4A==
Date:   Mon, 6 Nov 2023 09:44:39 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <ZUkX9z1M3ZxjIp6Z@kbusch-mbp.dhcp.thefacebook.com>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
 <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
 <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:00:44AM +0100, Daniel Wagner wrote:
> On Fri, Nov 03, 2023 at 08:22:11AM -0600, Keith Busch wrote:
> > > All 0's based (what a stupid term..) fields in NVMe are explicitly
> > > marked as such.  And even if that wasn't the case I'd very much
> > > expect the same encoding for the two sub-fields.
> > 
> > Yeah, it's just the firmware slot number, taken literally. AFI = 1 means
> > slot 1, AFI = 2 means slot 2, etc... Slot 0 either has special meaning
> > (firmware commit SF field, or fw log AFI bits 6:4), or is reserved
> > value, like in Identify Controller FRMW.NOFS, and has no place in the FW
> > Slot Info log page.
> > 
> > Our first slot in the log page is defined as slot one, so we have to
> > subtract one from the AFI field to index into the slot array. I messed
> > up for not catching that earlier, but thanks for pointing it out now.
> 
> Thanks for the clarification.
> 
> Do you want me to send a follow up patch, a new version of this one or
> do you fix up yourself?

Fixed up inline when applying the original patch. Let me know if you
have any concerns with the result, currently here:

  https://git.infradead.org/nvme.git/commitdiff/983a338b96c8a25b81e773b643f80634358e81bc
