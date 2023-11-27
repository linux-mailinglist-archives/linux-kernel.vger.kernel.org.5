Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953507FA192
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjK0Nyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjK0Ny0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C501BC8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867F4C433C8;
        Mon, 27 Nov 2023 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093265;
        bh=7vEEYXwdldOl0+hbzRROH0fsUfrm1FJL2AMIgiIM8hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCpwdevGn/bBVXxwyoSHZSQ5cZhiY+qDoSvFtllnFWEYT3QvFcPE2v1ZVUm/T7MkV
         HCBRsbnMXXDfsAbUAqc+HJ+71JsZTdyhRXcFxMVy8pXtfK2Di/1tRwe2gwTluk4rH5
         GEhPydTx9xSeCA0Ae5zUb2prUVa93xtVeVxuE/CA=
Date:   Mon, 27 Nov 2023 13:38:18 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next 1/2] mei: add check for offline bit in every
 register access
Message-ID: <2023112706-abroad-gangway-f7d2@gregkh>
References: <20231018101024.271437-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018101024.271437-1-tomas.winkler@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:10:23PM +0300, Tomas Winkler wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
> 
> Added check for offline in every register access function.
> When offline bit is set the driver should not access any mei hw.
> 
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/hw-me.c | 154 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 146 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index d11a0740b47c96c33591e69a..565da19bb980c845bc2cf3ed 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -58,6 +58,9 @@ static inline void mei_me_reg_write(const struct mei_me_hw *hw,
>   */
>  static inline u32 mei_me_mecbrw_read(const struct mei_device *dev)
>  {
> +	if (dev->dev->offline)
> +		return 0;

Dropped from my review queue due to lack of response :(
