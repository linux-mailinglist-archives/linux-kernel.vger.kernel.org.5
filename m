Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417047E50F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjKHHaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjKHHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1A1AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:30:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2BDC433C8;
        Wed,  8 Nov 2023 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699428601;
        bh=yo7b1LGNFyvDpF1t3rH3P/9deVIKXquQeoyvxzFhZ0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkhXJ7Ewr/fNRkHHqlD8wzG3L5thil15gOltKdbJxoYBn9ZW/PdFIWeOTEb95ES9h
         S062er0V6eQzPe82wMFHixIkfWeYoclSgNATcdBmNt9WIxjjIXNS4Q0yRmT6GAIE5+
         dFXsFvg2TYOp5HHIq7IR01jIPslm/BClcHAsS+0M=
Date:   Wed, 8 Nov 2023 08:29:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drm/amd/pm: replace 1-element arrays with flexible-array
 members
Message-ID: <2023110835-magnolia-prune-02d0@gregkh>
References: <20231108065436.13969-1-jose.pekkarinen@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231108065436.13969-1-jose.pekkarinen@foxhound.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 08:54:35AM +0200, José Pekkarinen wrote:
> The following case seems to be safe to be replaced with a flexible array
> to clean up the added coccinelle warning. This patch will just do it.
> 
> drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h:76:38-63: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> index c7b61222d258..1ce4087005f0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> @@ -73,7 +73,7 @@ struct smu8_register_index_data_pair {
>  
>  struct smu8_ih_meta_data {
>  	uint32_t command;
> -	struct smu8_register_index_data_pair register_index_value_pair[1];
> +	struct smu8_register_index_data_pair register_index_value_pair[];

Did you just change this structure size without any need to change any
code as well?  How was this tested?

thanks,

greg k-h
