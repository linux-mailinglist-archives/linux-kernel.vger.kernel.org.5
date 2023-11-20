Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25267F1AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjKTRjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjKTRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE310FA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700501934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA+PtELgafBL4lMg/ITaiAmG0etiKFjvCQCjeW2B3vQ=;
        b=Pe330Hz/xaL4EIFUTd6Ex3Gzak7vsP3vAJeJHUBw5dy0GYbpMzG4y7PUaUz+womKsycIG+
        gtN+y+X4Bk5C/0ERRjtJJ6bIz9BTJXLPw3EayWVHJEbeOol3lZ5JlNosX5HtqiyDzxiVN2
        +svMD7cLm+lfveZ0zkWRJr8/gL/WPxA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-Na6stRs_OgCUBQeGFALXBw-1; Mon, 20 Nov 2023 12:38:51 -0500
X-MC-Unique: Na6stRs_OgCUBQeGFALXBw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7aff051bed0so510971239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501930; x=1701106730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA+PtELgafBL4lMg/ITaiAmG0etiKFjvCQCjeW2B3vQ=;
        b=RRmzgzrcP/s40NXzf44dEbixh4MADmmF2XjcwRg+6PDcPil0tWad2VAipujVXlfdkl
         3Hvl+O/M5Hx8r9sly18rLdS3+BJjtKnvYGIaR2nhgZarFgbrOciQDefYp3lAWYlizjr1
         3zGbIjjVBO0cpm1yFIYPS0mFeqqhyVA8uREoszD7GndQTBhdvNLy13Tio6WYJ5xzOBvD
         Lzhy1VbN4QmrKN8cdwgTIbwl0Mz7tEbXzXkoVw4/6BSQL45ejBp2HCtq8+ke8czaavFL
         4NW8crulTcLLuQ4m28w4AJZTmlLBICOEl5Dp33EjfAiTDk0Q7WspUEnn5DOfeiZ7fyad
         8M0g==
X-Gm-Message-State: AOJu0YyyI24aBvU/y8KWLa93SNz8/D/xPTIm/hqD0lGCWZKC5L+9vj9/
        9IywV+Fk5I4ErS8K7CPC0NBrxsujn/jO2HPr94d23FqohDrMOkxlLj0T7DNsTPxs44jooAwfSgy
        Wt0YcjC77wGn+HfuwsO/A4qFK
X-Received: by 2002:a05:6602:b0b:b0:795:183b:1e3 with SMTP id fl11-20020a0566020b0b00b00795183b01e3mr3093006iob.6.1700501930218;
        Mon, 20 Nov 2023 09:38:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHT3qhfz3/6ZznnTsb8wnrznUIvtVKE6389r6+Eh6UTrnGUjcgYOv9oE6khUuQ9hoe4DhC0w==
X-Received: by 2002:a05:6602:b0b:b0:795:183b:1e3 with SMTP id fl11-20020a0566020b0b00b00795183b01e3mr3092992iob.6.1700501929955;
        Mon, 20 Nov 2023 09:38:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id y22-20020a5d94d6000000b00790b6b9d14bsm2329827ior.49.2023.11.20.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:38:49 -0800 (PST)
Date:   Mon, 20 Nov 2023 10:38:48 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     JianChunfu <chunfu.jian@shingroup.cn>
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, shenghui.qu@shingroup.cn
Subject: Re: [PATCH] vfio/pci: Separate INTx-enabled vfio_pci_device from
 unenabled to make the code logic clearer.
Message-ID: <20231120103848.337b6833.alex.williamson@redhat.com>
In-Reply-To: <20231120031752.522139-1-chunfu.jian@shingroup.cn>
References: <20231120031752.522139-1-chunfu.jian@shingroup.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 11:17:52 +0800
JianChunfu <chunfu.jian@shingroup.cn> wrote:

> It seems a little unclear when dealing with vfio_intx_set_signal()
> because of vfio_pci_device which is irq_none,
> so separate the two situations.
> 
> Signed-off-by: JianChunfu <chunfu.jian@shingroup.cn>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 6069a11fb51a..b6d126c48393 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -468,6 +468,8 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
>  				     unsigned index, unsigned start,
>  				     unsigned count, uint32_t flags, void *data)
>  {
> +	int32_t fd = *(int32_t *)data;

This is a null pointer dereference if anyone were to use
VFIO_IRQ_SET_DATA_NONE.  Note this is also invalid for
VFIO_IRQ_SET_DATA_BOOL.  I think this is largely why the function has
the current layout.

> +
>  	if (is_intx(vdev) && !count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
>  		vfio_intx_disable(vdev);
>  		return 0;
> @@ -476,28 +478,25 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
>  	if (!(is_intx(vdev) || is_irq_none(vdev)) || start != 0 || count != 1)
>  		return -EINVAL;
>  
> -	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
> -		int32_t fd = *(int32_t *)data;
> +	if (!is_intx(vdev)) {
>  		int ret;
> +		if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {

@ret should be scoped within this branch with this layout and there
should be a blank line after variable declaration.

> +			ret = vfio_intx_enable(vdev);
> +			if (ret)
> +				return ret;
>  
> -		if (is_intx(vdev))
> -			return vfio_intx_set_signal(vdev, fd);
> +			ret = vfio_intx_set_signal(vdev, fd);
> +			if (ret)
> +				vfio_intx_disable(vdev);
>  
> -		ret = vfio_intx_enable(vdev);
> -		if (ret)
>  			return ret;
> -
> -		ret = vfio_intx_set_signal(vdev, fd);
> -		if (ret)
> -			vfio_intx_disable(vdev);
> -
> -		return ret;
> +		} else
> +			return -EINVAL;

Single line branches also get braces if the previous branch required
braces.  Thanks,

Alex

>  	}
>  
> -	if (!is_intx(vdev))
> -		return -EINVAL;
> -
> -	if (flags & VFIO_IRQ_SET_DATA_NONE) {
> +	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
> +		return vfio_intx_set_signal(vdev, fd);
> +	} else if (flags & VFIO_IRQ_SET_DATA_NONE) {
>  		vfio_send_intx_eventfd(vdev, NULL);
>  	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>  		uint8_t trigger = *(uint8_t *)data;

