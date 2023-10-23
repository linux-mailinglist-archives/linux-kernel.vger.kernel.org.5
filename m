Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE17D4062
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjJWTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjJWTkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:40:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E141D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:40:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27e4e41a4fcso938197a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698090051; x=1698694851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVj+JLfwak+wPIlRvDRspF5/51cnTVEmP+dvEBCxyf4=;
        b=nMdwC97Z6fOV9ac8g9iZQdfL62lYKXpejpVg9/IZDftqY1LQ6WCf+toAkNjtpVa63F
         Of6J153pD0JrgIaCtl5fv0K14V/zmtQ7THJGqvsqnurE0AdkSbIf+TbDGA8VwbrnofzG
         8dEwx8viMHEfzTmMvzBLNSKTqDz3P3dzHOxpSUwUkk4WFwlVXoStTUvAlax4yhddhr9j
         aioU6iHnzDNoZeIOCRe8hIqGhFz1MEXRqPjLuNdHt5zd/PmcUQdD87X7NAW6s54nN5OS
         CTpewvFnie0CyUrCg8Vaj/HKVAFU8NomYNex0ZwXobmMVlXBwKeMs7VXFAmsjIb3A1k1
         5c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090051; x=1698694851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVj+JLfwak+wPIlRvDRspF5/51cnTVEmP+dvEBCxyf4=;
        b=c9rOXsHob81wwrzpmGGcbCBbur1i/1Flh8p2f/N4TKeQl5tT5oP49eWQNxRY6Lu8JF
         V57NRwZP5/SOfQk+cmJJnkYFTNBXpNxxJelfJF835YFqHoLvrQAC9U6l1yMxaZrzxFgi
         3g/HdO3x4yLy5AkjZPdHVZZTjWvZDg8CY+W8F/XxYNsvO5OqqAxNLt4ZGiHN+SRuCBFM
         yQfK07Vg0VLuFFFWCyNdTspTc1KUQGS2UXbhREVr8UN4Y7uxDkR+qUASqlk/23sOHArk
         jmrkemCtRVLOCdHXOS9zbltn4fZbnpWYffif2JnQJ6Hkh7QnrxtcXMXq0EmOOKRjwJnP
         +D3g==
X-Gm-Message-State: AOJu0YyMzqDyP7AhHXhXqv6FQvnTY7EOtrE5kBYGqt69QOMpo5Ikrd03
        APlq+SITAtC1lIsucP1wZ+a6lA==
X-Google-Smtp-Source: AGHT+IEbL4Zez3ADFZnsI4I9Z1IZ1Vk9IdtY77ZM1DYNYAULr+jv5vBD3dJjcQNYbb83VYV0+fHH4Q==
X-Received: by 2002:a17:90b:3d8c:b0:27d:c92:e897 with SMTP id pq12-20020a17090b3d8c00b0027d0c92e897mr8672798pjb.37.1698090050928;
        Mon, 23 Oct 2023 12:40:50 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:85b7:8283:12b2:30f8])
        by smtp.gmail.com with ESMTPSA id az7-20020a17090b028700b0027d157e686asm5836594pjb.49.2023.10.23.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:40:50 -0700 (PDT)
Date:   Mon, 23 Oct 2023 13:40:48 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] rpmsg: virtio: replace deprecated strncpy with
 strscpy/_pad
Message-ID: <ZTbMQC9IhcJR3a/a@p14s>
References: <20231023-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v2-1-dc591c36f5ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v2-1-dc591c36f5ed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 06:12:28PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch replaces 3 callsites of strncpy().
> 
> The first two populate the destination buffer `nsm.name` -- which we
> expect to be NUL-terminated based on their use with format strings.
> 
> Firstly, as I understand it, virtio_rpmsg_announce_create() creates an
> rpmsg_ns_msg and sends via:
> 
> virtio_rpmsg_bus.c:
> 336: err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
> 
> ... which uses:
> virtio_rpmsg_sendto() -> rpmsg_send_offchannel_raw()
> 
> ... which copies its data into an rpmsg_hdr `msg` in virtio_rpmsg_bus.c
> 618: memcpy(msg->data, data, len);
> 
> This callback is invoked when a message is received from the remote
> processor:
> 
> rpmsg_ns.c:
> 30: /* invoked when a name service announcement arrives */
> 31: static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> 32: 		       void *priv, u32 src)
> 33: {
> 34:         struct rpmsg_ns_msg *msg = data;
> ...
> 50:         /* don't trust the remote processor for null terminating the name */
> 51:         msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> 
> ... which leads into the use of `name` within a format string:
> rpmsg_ns.c:
> 57: dev_info(dev, "%sing channel %s addr 0x%x\n",
> 58:          rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
> 59:          "destroy" : "creat", msg->name, chinfo.dst);
> 
> We can also observe that `nsm` is not zero-initialized and as such we
> should maintain the NUL-padding behavior that strncpy() provides:
> 
> virtio_rpmsg_bus.c:
> 330: struct rpmsg_ns_msg nsm;
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> Now, for the third and final destination buffer rpdev->id.name we can
> just go for strscpy() (not _pad()) as rpdev points to &vch->rpdev:
> |       rpdev = &vch->rpdev;
> 
> ... and vch is zero-allocated:
> |       vch = kzalloc(sizeof(*vch), GFP_KERNEL);
> 
> ... this renders any additional NUL-byte assignments (like the ones
> strncpy() or strscpy_pad() does) redundant.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - update commit msg (thanks Mathieu)
> - Link to v1: https://lore.kernel.org/r/20231021-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-v1-1-8abb919cbe24@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

I have applied all 3 of your patches.

Thanks,
Mathieu

> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 905ac7910c98..dc87965f8164 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -329,7 +329,7 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
>  	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
>  		struct rpmsg_ns_msg nsm;
>  
> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> +		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
>  		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
>  		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_CREATE);
>  
> @@ -353,7 +353,7 @@ static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
>  	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
>  		struct rpmsg_ns_msg nsm;
>  
> -		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
> +		strscpy_pad(nsm.name, rpdev->id.name, sizeof(nsm.name));
>  		nsm.addr = cpu_to_rpmsg32(rpdev, rpdev->ept->addr);
>  		nsm.flags = cpu_to_rpmsg32(rpdev, RPMSG_NS_DESTROY);
>  
> @@ -424,7 +424,7 @@ static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
>  	 */
>  	rpdev->announce = rpdev->src != RPMSG_ADDR_ANY;
>  
> -	strncpy(rpdev->id.name, chinfo->name, RPMSG_NAME_SIZE);
> +	strscpy(rpdev->id.name, chinfo->name, sizeof(rpdev->id.name));
>  
>  	rpdev->dev.parent = &vrp->vdev->dev;
>  	rpdev->dev.release = virtio_rpmsg_release_device;
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231020-strncpy-drivers-rpmsg-virtio_rpmsg_bus-c-dba15db4e890
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
