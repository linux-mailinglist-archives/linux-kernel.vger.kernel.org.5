Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F97AEF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjIZPYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIZPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8500120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695741815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=foWM0UugyLFv9pmPiACjZ0qxG3GLmlHlix6zXFIpKKE=;
        b=BB5gLHwdMq6hBJQ6X6tzGpy99B80yrJAEmRZruAvh2KGQpujPQ78G0n/8vdMeO71BFQ804
        7M7L1q+BcirPYvqrFZucEGgh7aY0IeJ4OSmVIT2VLNXoIUZLGQYgDyDjE2j9TP4Trk0D+/
        QXQTvS0BlXvqW3ClAoc0F0xyBipk0ig=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-qGpYPtVDNQatTXUvArc4Xg-1; Tue, 26 Sep 2023 11:23:33 -0400
X-MC-Unique: qGpYPtVDNQatTXUvArc4Xg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6931db743a0so1631550b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695741812; x=1696346612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foWM0UugyLFv9pmPiACjZ0qxG3GLmlHlix6zXFIpKKE=;
        b=SzsHOqeiRL0OB3kjol2BQRQFFP2kAsxtWM8fmggM0yp5mHulO0yDuwWiq4QaFv5/A8
         OjDmS5sos0yzp4LsywvojYoOoTkmQxHjwWzvVlDiWyl7DQ1nKMUT5jLOoSNNYFOcf/AR
         5gqaZxkQCgPguZmTgrDydJ1NibInPU5UKIRsifCW4jBQnFnSTHT8+qBCoEw+Oy2hDV7C
         JaVLN/JwsyHPI9o3Pt1HBECGp//k3SH/7yXk/L2eQZJtcFrBF/JI3bA5obrqaTrXKL3E
         0uFjoRUHTy0MU+DmKD1+EFP+B9NQZdrJBz0OtZDhYSxcIIwZtZB/VxdA75jnd5BUjtWw
         oHEQ==
X-Gm-Message-State: AOJu0YzlicEtlOzZRs7Pu/vJO+bfwcWQKRHYO7R+xubgGdS8O+AJGCu1
        K7AqDj5dfnG6B9XzS4AKyuKbLrEk1kM6Ix1hao+Or84ACDtvcGxIZuZ9XmGfjarRsq5Q8bucQQW
        4tbkwHeH3PGYJslqjFBvfWxT2
X-Received: by 2002:a05:6a20:101a:b0:14b:3681:567e with SMTP id gs26-20020a056a20101a00b0014b3681567emr7100137pzc.29.1695741812056;
        Tue, 26 Sep 2023 08:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd13muXd3yaFfAafmi9pC48FJu40UOXFB7h+zxJ/SZD6Rc19emz7CdNPFRKJPpxplEzjl3mQ==
X-Received: by 2002:a05:6a20:101a:b0:14b:3681:567e with SMTP id gs26-20020a056a20101a00b0014b3681567emr7100114pzc.29.1695741811749;
        Tue, 26 Sep 2023 08:23:31 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001c5f7e06256sm7410616plf.152.2023.09.26.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:23:31 -0700 (PDT)
Date:   Tue, 26 Sep 2023 23:23:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH] ovl: disable IOCB_DIO_CALLER_COMP
Message-ID: <20230926152328.5vpz7yddmsjahkxt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71897125-e570-46ce-946a-d4729725e28f@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:21:35AM -0600, Jens Axboe wrote:
> overlayfs copies the kiocb flags when it sets up a new kiocb to handle
> a write, but it doesn't properly support dealing with the deferred
> caller completions of the kiocb. This means it doesn't get the final
> write completion value, and hence will complete the write with '0' as
> the result.
> 
> We could support the caller completions in overlayfs, but for now let's
> just disable them in the generated write kiocb.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Link: https://lore.kernel.org/io-uring/20230924142754.ejwsjen5pvyc32l4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> Fixes: 8c052fb3002e ("iomap: support IOCB_DIO_CALLER_COMP")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---

Thanks Jens, the fstests generic/617 works on latest linux kernel with this
patch now.

> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 4193633c4c7a..693971d20280 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -391,6 +391,12 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
>  		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
>  
> +	/*
> +	 * Overlayfs doesn't support deferred completions, don't copy
> +	 * this property in case it is set by the issuer.
> +	 */
> +	ifl &= ~IOCB_DIO_CALLER_COMP;
> +
>  	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>  	if (is_sync_kiocb(iocb)) {
>  		file_start_write(real.file);
> 
> -- 
> Jens Axboe
> 
> 	
> 

