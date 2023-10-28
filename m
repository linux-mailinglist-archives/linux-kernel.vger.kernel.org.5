Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B27DA945
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJ1UWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1UWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:22:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80AEA7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:22:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso2920341b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698524550; x=1699129350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe5fXMkIr7EM+O0J9n+FRFXxzPWDHsSnu766yF1x2Vw=;
        b=d3A3ci3DpXHTqkaBiKxpOiHptLGe1UzHCmnN0r3SRpNgsJKSJXeGsxGruNzkH+H9mD
         thezGsZpdHkIgK8w9m1qOiPVOA/g953xlS0STZUcYkvhzGy9S9FzXXdKvOFrt479+PHh
         BLlFY8p3+cSGgIOo3T6zB7rHU6WJ2Du4n5fklsaDHuLmxkIvWZGQrYhGifKdNGEbo3em
         24pYHQAlOa37qvVbEp/L1aMm+jvBlOYBIclcxm1czGAwDdTyR0Ax2vnQ5gYyVB6Y9sa2
         Byc7eDLMVMkorW+Ff7lzmFSCueU64OivtZ4cQobJk/zJk0vIJnbwmnYRs6U9ski5r/0O
         mXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698524550; x=1699129350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe5fXMkIr7EM+O0J9n+FRFXxzPWDHsSnu766yF1x2Vw=;
        b=LMozOOfV7dr65ol2znS60hsqPKDNrGQpQB0t+YJjipnJhVtqw1HjZd8TWr8vyZquzC
         yw3inyYnd3K+th6Hq4Bs/XBBzu4wIpOuWW6ueY/ypMl952DMycpO10BsAdRsfXnEX/Fo
         d6Flz7I2aFpEkY+UcIRGaSkJLKB8Y18wNBRquKXYewg77EaJQr0KAalnKvmEnUVEK/+W
         PhsPaOp+Kw8oZEdOlufvNzZRc3SDGxf2j4qyGeymwltH3Zj5x92SlaBH4scGEPFU51sQ
         UpKyjaSuTWxvRtbt52Z8EnFanTxOT4o/qSEHyF/Zpu+PgVbMMOMl1nFKkR5vNLJdDEWl
         7pww==
X-Gm-Message-State: AOJu0YxI18DMnlNqe96kHXqWpr4GURmcHDfm+02k4dqfy4q2i1aTxlK4
        p7Xz0aCxlpiDcbhMegRj1mM=
X-Google-Smtp-Source: AGHT+IFdkZReASb/EOwlYOdiXGWEctOWhxdfuppy/VQoYmCS9GGra1jo2ndmWGzw3i5h2aj7sGXhsA==
X-Received: by 2002:a05:6a20:3d83:b0:13f:c40c:379 with SMTP id s3-20020a056a203d8300b0013fc40c0379mr7358092pzi.13.1698524550125;
        Sat, 28 Oct 2023 13:22:30 -0700 (PDT)
Received: from ubuntu ([122.171.167.85])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902684100b001c74df14e6esm3658613pln.51.2023.10.28.13.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:22:29 -0700 (PDT)
Date:   Sat, 28 Oct 2023 13:22:20 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/3] staging: greybus: camera: Alignment should match
 open parenthesis
Message-ID: <20231028202220.GA2432@ubuntu>
References: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
 <d2630a16ff9eca40b03dcade63c197fdd5e5b78f.1697976302.git.nandhakumar.singaram@gmail.com>
 <7703f20b-60e1-4140-8380-5a5157bc49b0@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7703f20b-60e1-4140-8380-5a5157bc49b0@ieee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:18:04PM -0500, Alex Elder wrote:
> On 10/22/23 7:15 AM, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > CHECK: Alignment should match open parenthesis
> 
> Generally, the result of this patch in isolation looks OK.
> But when you compare it with your next patch, what you're
> doing here becomes inconsistent with the indentation used
> for the function arguments there.
> 
> There is value in consistency as advocated by checkpatch,
> but there's also value in consistency within a single
> source file.
> 
> I'd stay away from these white space changes.
> 
> 					-Alex
> 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > ---
> >   drivers/staging/greybus/camera.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > index ae49e37a87e9..6516e7efaab9 100644
> > --- a/drivers/staging/greybus/camera.c
> > +++ b/drivers/staging/greybus/camera.c
> > @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
> >   }
> >   static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> > -		struct gb_camera_configure_streams_response *resp)
> > +				      struct gb_camera_configure_streams_response *resp)
> >   {
> >   	unsigned int max_pkt_size = 0;
> >   	unsigned int i;
> > @@ -378,8 +378,8 @@ struct ap_csi_config_request {
> >   #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
> >   static int gb_camera_setup_data_connection(struct gb_camera *gcam,
> > -		struct gb_camera_configure_streams_response *resp,
> > -		struct gb_camera_csi_params *csi_params)
> > +					   struct gb_camera_configure_streams_response *resp,
> > +					   struct gb_camera_csi_params *csi_params)
> >   {
> >   	struct ap_csi_config_request csi_cfg;
> >   	struct gb_connection *conn;
> > @@ -783,8 +783,8 @@ static ssize_t gb_camera_op_capabilities(void *priv, char *data, size_t len)
> >   }
> >   static int gb_camera_op_configure_streams(void *priv, unsigned int *nstreams,
> > -		unsigned int *flags, struct gb_camera_stream *streams,
> > -		struct gb_camera_csi_params *csi_params)
> > +					  unsigned int *flags, struct gb_camera_stream *streams,
> > +					  struct gb_camera_csi_params *csi_params)
> >   {
> >   	struct gb_camera *gcam = priv;
> >   	struct gb_camera_stream_config *gb_streams;
>

Thanks Alex for the review.

yeah, I understood about the indentation issue when comparing 
to other patch but fixing the indentation there results in 
another checkpatch check(CHECK: line length of 113 exceeds 100
columns) so didn't added any change over there. 

Regards,
Nandha Kumar
