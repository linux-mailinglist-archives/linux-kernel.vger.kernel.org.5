Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B9782CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjHUPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHUPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F3D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692630534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiftg8Pr9vE2gWFnJOhq8DTyEekLoXKGZzeRO133jUE=;
        b=XwlzAZzPweFN8ajgqnaWsVwnsNHq/L3p9RRRkJt1PxRVrk/+Q/Eh94subaiYudzzhIFff7
        znUDhHM1aiRAJVTP/mKdFnP2zP0wtw3HHu2cWk5jKBiOIrlKtT3kqMoClWZgM9iP8F0bxl
        9ngsMagfzikS9F3bIIC3e/sErXgkyQs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-maXSM3I3N-q78MsbPMzeng-1; Mon, 21 Aug 2023 11:08:52 -0400
X-MC-Unique: maXSM3I3N-q78MsbPMzeng-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bf2e81ce63so3343577fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630532; x=1693235332;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiftg8Pr9vE2gWFnJOhq8DTyEekLoXKGZzeRO133jUE=;
        b=hKrXflG2DnCjkEpadQ9ZHCm58We5oRKCBwcByzSCzqLTaMbyXgYX8Hr/k86/BIIZl6
         /MmVA9OMYZQnc2tfa4eaFTpNm11S1utc5qbmDg8VJGskr/IMrLEVXgZQfz+14xlilnv2
         xoubkTlt3kibBRoqwfjzKaPNxhYBH2uSae1B4EUvnJAUrQMvAASz9+oCt3KSNroKoXs5
         j4OiZ4RO+GnO9Fs/flKyW4YoIwq2diwCP17/JA4FSNvka+Au7hlvAwc06+8tR+uY+CrY
         WCGaz5NQpmH/dkre/BUsNAnjzThEhQZVBlbxnGVjhq/FBpeKiem6tvE25VxOicKdHiVo
         SE5A==
X-Gm-Message-State: AOJu0YzwMK+17tFhY1lbREzW+sqeF5e7OJYn+vi/jnnDTkcflW5J9tx/
        6nYCZio0E7FVJMWWqF2webBrWgVfayhpsWqBYXCEN4d7j1+VWeTkq4HQt+Pm69nOGHz/QIRdIe4
        W2vNKIxQnW9PEeK96nei74L9N
X-Received: by 2002:a05:6870:470e:b0:1bb:c0ee:5554 with SMTP id b14-20020a056870470e00b001bbc0ee5554mr4604204oaq.2.1692630531985;
        Mon, 21 Aug 2023 08:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2t2gnAZ9Ox+eHrEFNPmV0KQPQOcL1byJgHVkK10yzfG4Npq1bEBvFEY5S6z60VY01Ww08Bg==
X-Received: by 2002:a05:6870:470e:b0:1bb:c0ee:5554 with SMTP id b14-20020a056870470e00b001bbc0ee5554mr4604187oaq.2.1692630531478;
        Mon, 21 Aug 2023 08:08:51 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687004c200b001c0f4484d20sm4296627oam.25.2023.08.21.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:08:50 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:08:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <brett.creeley@amd.com>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <horms@kernel.org>, <shannon.nelson@amd.com>
Subject: Re: [PATCH -next] vfio/pds: fix return value in
 pds_vfio_get_lm_file()
Message-ID: <20230821090849.79fe44a4.alex.williamson@redhat.com>
In-Reply-To: <20230819023716.3469037-1-yangyingliang@huawei.com>
References: <20230819023716.3469037-1-yangyingliang@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 10:37:16 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> anon_inode_getfile() never returns NULL pointer, it will return
> ERR_PTR() when it fails, so replace the check with IS_ERR().
> 
> Fixes: bb500dbe2ac6 ("vfio/pds: Add VFIO live migration support")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/vfio/pci/pds/lm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
> index aec75574cab3..79fe2e66bb49 100644
> --- a/drivers/vfio/pci/pds/lm.c
> +++ b/drivers/vfio/pci/pds/lm.c
> @@ -31,7 +31,7 @@ pds_vfio_get_lm_file(const struct file_operations *fops, int flags, u64 size)
>  	/* Create file */
>  	lm_file->filep =
>  		anon_inode_getfile("pds_vfio_lm", fops, lm_file, flags);
> -	if (!lm_file->filep)
> +	if (IS_ERR(lm_file->filep))
>  		goto out_free_file;
>  
>  	stream_open(lm_file->filep->f_inode, lm_file->filep);

Applied to vfio next branch for v6.6.  Thanks,

Alex

