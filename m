Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0072676FD4F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjHDJbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHDJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB249FA;
        Fri,  4 Aug 2023 02:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D976861F11;
        Fri,  4 Aug 2023 09:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CEBC433C8;
        Fri,  4 Aug 2023 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691141460;
        bh=ytIilxh+58GrQ8OHf133q4mTeWcJ92IHYhytXiXB5rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfAgx545kZ70EWgy/+Qb+hWmMEmrKZQ4cXGMJdY2hV7euni4BE1fHneZEIwQoT2tD
         kpG95qee0OZIpoJNWQtYz1004mw5SxWuamuq9N27z25x+G+x6dXM5smrmEkqP9liQ4
         R+uXXT2TpN7giDd+y24XYCNJWdLQvZl/EkhLcNWE=
Date:   Fri, 4 Aug 2023 11:30:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Atul Raut <rauji.raut@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath6kl: replace one-element array with flexible-array
 member
Message-ID: <2023080410-unadorned-vertigo-c0b8@gregkh>
References: <20230804045554.6934-1-rauji.raut@gmail.com>
 <2023080433-patio-staining-2cfe@gregkh>
 <87sf8zs2oi.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf8zs2oi.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:10:37AM +0300, Kalle Valo wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Aug 03, 2023 at 09:55:54PM -0700, Atul Raut wrote:
> >
> >> One-element arrays are no longer relevant, and their
> >> place has been taken by flexible array members thus,
> >> use a flexible-array member to replace the one-element
> >> array in struct ath6kl_usb_ctrl_diag_cmd_write
> >> 
> >> This fixes warnings such as:
> >> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >> 
> >> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> >> ---
> >>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> >> index 5220809841a6..c8ecc9e85897 100644
> >> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> >> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> >> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
> >>  	__le32 cmd;
> >>  	__le32 address;
> >>  	__le32 value;
> >> -	__le32 _pad[1];
> >> +	__le32 _pad[];
> >
> > Are you sure this is actually a variable length array?
> 
> It's not, it's just padding. We both told this in v1:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230731012941.21875-1-rauji.raut@gmail.com/

Hey, I'm consistent, nice!  :)

But Atul, that's not good to ignore our review comments.  Usually that
ends up meaning that everyone will then just ignore your submissions,
generally a not-good resolution.

thanks,

greg k-h
