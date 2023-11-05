Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FCA7E161A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjKETdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjKETdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:33:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EAE1;
        Sun,  5 Nov 2023 11:33:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46F5C433C8;
        Sun,  5 Nov 2023 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699212785;
        bh=1ZSn8fX1O+pE4SPZosecaz3eXsXrtCg5RT9YyalLzBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDJkErVAgzE5crGSHh9WVGqTANQW6FYwKB+ggVryU3HKPwW3R6wjoQR5CbA4YD9w2
         LcJ0Wtwe6qzm6WV2AL8nlOSTNJxfH4Mh3tSVYkhFvn5BM9fvxILPt930TbZS664iwl
         go2apfOhcyRzx13OulPkXhb4XADFnWT0i48k33wUnfy4a6MMQrc/iTdRTU5rwzbf+M
         lQId99jXFLhOeJrsgM0D2LoVIJnbHXuppXlxEq3+j17Nzxmiu904HLzLHrLlyjYoOj
         Y+21BauTD0lf+QjXFD2mIqLdEKNlHOccETUWyRCDMB20gdEZz+/ON/i4SZy9udTirw
         bfVm9Hmqz8oFA==
Date:   Sun, 5 Nov 2023 11:33:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Steve French <smfrench@gmail.com>, John Sanpe <sanpeqf@gmail.com>,
        stfrench@microsoft.com, linkinjeon@kernel.org, pc@manguebit.com,
        sprasad@microsoft.com, linux-cifs@vger.kernel.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        samba-technical <samba-technical@lists.samba.org>,
        Jeremy Allison <jra@samba.org>
Subject: Re: [PATCH] fs/smb: using crypto lib instead cifs_arc4
Message-ID: <20231105193303.GA91123@sol.localdomain>
References: <20231022183917.1013135-1-sanpeqf@gmail.com>
 <CAH2r5mvAvXaXTWr8CWnVZcXa3tiU+ZfpBoo0tiY-RH194f2xow@mail.gmail.com>
 <CAH2r5mvAOYqjP7JvGxF5Jt58386Sjwke7516XUet-6L6XW3_NQ@mail.gmail.com>
 <CAN05THRzP6uFyza90kBy5Ku8yGKMi2K5VYX1TJsjbvQrLfAEiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN05THRzP6uFyza90kBy5Ku8yGKMi2K5VYX1TJsjbvQrLfAEiw@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:42:11AM +1000, ronnie sahlberg wrote:
> You are right. The reason that arc4 and friend were moved into cifs
> was because the crypto guys told us "we will delete these algorithms
> from the crypto library"

This was suggested for md4 but not for arc4.  arc4 still has multiple users in
the kernel, so having it as a library makes sense.

- Eric
