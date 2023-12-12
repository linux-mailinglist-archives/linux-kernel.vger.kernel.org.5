Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FED80F8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377394AbjLLVBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjLLVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F2F9B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702414893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVAsjbMqpYyZ3IkWoFHSbEJwyLTdmo/iH1LCGeQmZh8=;
        b=fznMueJ6GIEXFsusPyDnZFR275uKWrdcFghfXTxuLDjvjXACUO8ZiZb8n1Mber5wOIpevP
        sFBfJTl59MFEQkBetEt/4r9jnRc9wP5DeJwi9d+mAfwTcWoKdpp1ydJKgDgEVwiCpQTvzg
        /u9W+rkcALdy4kFxncHLqW+TU0NI3Qw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-WT3Ic6TKN1-tLirAgbhO2g-1; Tue, 12 Dec 2023 16:01:31 -0500
X-MC-Unique: WT3Ic6TKN1-tLirAgbhO2g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67ee7d18256so14440016d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414890; x=1703019690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVAsjbMqpYyZ3IkWoFHSbEJwyLTdmo/iH1LCGeQmZh8=;
        b=c36scvdmf6kHyl/8kNScNzAdLj/YN1243/LKNbms1AS8m+t7xWF6jc+azRJQZaEFpV
         Qat+Wg8Kq+btTjhbHZ08oh59FbzXpEDejojLYCn2mF/rfDqaod5ByXBLfwZn8zLBuLT8
         s3p+0p7FAnkFhug+XvvLc5GearAApEOTx89HjMJ1s1YPF1GsSWyLela/3Vt/yhKWZNAe
         nvTdXvgYxkpMCFiVsumtLV6hk/Yzj/c4jcq3Xy+q33eMmv6baDfHsusrqa7j5psny8M+
         YhgUc/Azk6rGktK4Sf8KM10KiMKHYrNwsJQ9lFAmpTGdZPXPsoJRoU891N08y3E/eVqK
         1Eig==
X-Gm-Message-State: AOJu0Yw/PlAqSu3TkfoXUcQcgr5QhBA8kuS48xHkW+cXFY9a0Z765XBx
        y3ejb6LMAd9m2EnPx1tWgNHIVvz3SxTh6iRUD7L+o9X/WxNoXf9gh8GKlhGJlx4+AMU336BIIdh
        0dUS3xSrIA2E6jEjF+WCIuXVH9pbDDVxi
X-Received: by 2002:a05:6214:e8d:b0:67e:aa5b:8e9f with SMTP id hf13-20020a0562140e8d00b0067eaa5b8e9fmr8845940qvb.62.1702414890655;
        Tue, 12 Dec 2023 13:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVewhRs7Hdh5QT+34KH2wML5O8m9XHLGWFWDGFa8wOrPNpZCusPikbcT6klf4Qm0z2wwfb/g==
X-Received: by 2002:a05:6214:e8d:b0:67e:aa5b:8e9f with SMTP id hf13-20020a0562140e8d00b0067eaa5b8e9fmr8845928qvb.62.1702414890410;
        Tue, 12 Dec 2023 13:01:30 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id n6-20020a056214008600b0067ea8085b71sm4471934qvr.5.2023.12.12.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:01:29 -0800 (PST)
Date:   Tue, 12 Dec 2023 15:01:27 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     hdegoede@redhat.com, deller@gmx.de, treding@nvidia.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev/simplefb: change loglevel when the power domains
 cannot be parsed
Message-ID: <lv3bauwrmy2bkycijpmgmym6x2kxo57twl62ttpgsbwecmxoge@quhe7siu6zdp>
References: <20231212195754.232303-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212195754.232303-1-bmasney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 02:57:54PM -0500, Brian Masney wrote:
> When the power domains cannot be parsed, the message is incorrectly
> logged as an info message. Let's change this to an error since an error
> is returned.
> 
> Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Acked-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/video/fbdev/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 6f58ee276ad1..028a56525047 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -470,7 +470,7 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
>  		if (err == -ENOENT)
>  			return 0;
>  
> -		dev_info(dev, "failed to parse power-domains: %d\n", err);
> +		dev_err(dev, "failed to parse power-domains: %d\n", err);
>  		return err;
>  	}
>  
> -- 
> 2.43.0
> 

