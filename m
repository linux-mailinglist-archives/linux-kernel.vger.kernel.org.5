Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075776F981
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjHDFU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHDFSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:18:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388525277;
        Thu,  3 Aug 2023 22:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9168061F39;
        Fri,  4 Aug 2023 05:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B8C433C8;
        Fri,  4 Aug 2023 05:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691126146;
        bh=USmLM7XlRgBQi58d1O7rkZwpAoU1QZU1TYBFKp261ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RFNvgdxKrimI8wHa+gINMl4wknnhcFE7xlFV+zDo9HVifudBf+5/8Xl3YKW289F7+
         xM/BMTI7P8TClWhZ+M+fiP3p7tXyaHTNbj97ayBPNOwNKFRO6ADdRlknO1gTT+076m
         J9fVXeGFEOG2aKGoBK9cyEDVflbGM+mrzeLshpUc=
Date:   Fri, 4 Aug 2023 07:15:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Raut <rauji.raut@gmail.com>
Cc:     kvalo@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath6kl: replace one-element array with flexible-array
 member
Message-ID: <2023080433-patio-staining-2cfe@gregkh>
References: <20230804045554.6934-1-rauji.raut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804045554.6934-1-rauji.raut@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:55:54PM -0700, Atul Raut wrote:
> One-element arrays are no longer relevant, and their
> place has been taken by flexible array members thus,
> use a flexible-array member to replace the one-element
> array in struct ath6kl_usb_ctrl_diag_cmd_write
> 
> This fixes warnings such as:
> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
> index 5220809841a6..c8ecc9e85897 100644
> --- a/drivers/net/wireless/ath/ath6kl/usb.c
> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>  	__le32 cmd;
>  	__le32 address;
>  	__le32 value;
> -	__le32 _pad[1];
> +	__le32 _pad[];

Are you sure this is actually a variable length array?

And you just changed the size of this structure, are you sure this is
correct?

There have been lots of work on this type of thing in the past on the
hardening mailing list, I suggest you work there with the developers to
see if this is even a valid change first.

thanks,

greg k-h
