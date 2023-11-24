Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABFC7F6A58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKXB6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjKXB6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:58:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F0D73
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:58:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso237535a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1700791084; x=1701395884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOC6kpNCxEHj4hSbgSX+oEF0PmKIHwNNPHtfvbmHLCM=;
        b=zNMs+r2r3go/HB9wyrr/a3ZEm6TzRNIg0fOry33kZUpw7L2rhQuXIGLvOaKP2D0QGd
         gGkdbryz5kGWABlK5teX9BqU+FHFrmrLt5k9HWCVANDae+ymgHomaR7VCpUteighQF2S
         h9/bgEc7Ix9rQ70pFkQap2CyEb6/J/CIZdF20gcwHgytsesxBbv8vxGM2JwL9Hq7qdMd
         OMtJJ9Qs8FL1x2FI7cJ1glphzG9nMlu9KPovsfx+6n4wKqrnCcUM/E40EANBVhwy9pDO
         VIyCvqtZoD3OEDe5NkHfWGswmG2LOnXbMhJGd+G2Q5fGyirlPCjpEuQEKNY4OGkK/Bq3
         X3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700791084; x=1701395884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOC6kpNCxEHj4hSbgSX+oEF0PmKIHwNNPHtfvbmHLCM=;
        b=bRvnYS38LKgyV0yMp8YuqxEbhIlV5Rc3icG3DJRPHdcPImJwn44Xf4Qm5PbGdqG+dp
         yq5lhhnYObfWhyzeLMW/BfXfEI2Kz7YoiZBBw9CGxZiGalfIsaQW5F9exp5fk+v+g6Eq
         3xJjbVRk2gU8i+cQkq0p0JO4BiPXrRdSgzVKmFxKM50XwtOK97Ni+t81Jd1joSj8cPgq
         Gen2z+RiCEWMfnTrdJ82//FlyR3BgDL+XgQpbpo1yy1uDsuwBr7N0UI/O35DpnhJYQhC
         MRxrrGbFX11X3p+tb0fXyltyEYF2MgXhNlP5bbBCUpXp4qnfk4EFzulqRKhkIem85Hau
         B68g==
X-Gm-Message-State: AOJu0Yw6sFMkwWL6j8SPxvtPgeAVRwLARR4NJmFBwk08W/f28GnVNPE3
        VEcK5qlewZUQdAoAkxzBhG96tbbvlX9RoG1b81I=
X-Google-Smtp-Source: AGHT+IGgua0Zo8eVhZHf65bHplCf8miKyTXtFX2D4MKSzCsryR9maOkL19p6pIxBWII4yx8+ghZKwA==
X-Received: by 2002:a17:906:116:b0:9c5:cfa3:d030 with SMTP id 22-20020a170906011600b009c5cfa3d030mr760258eje.54.1700791084287;
        Thu, 23 Nov 2023 17:58:04 -0800 (PST)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id kt20-20020a170906aad400b009c3f8f46c22sm1426212ejb.77.2023.11.23.17.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 17:58:03 -0800 (PST)
Date:   Fri, 24 Nov 2023 02:58:01 +0100
From:   Petr Malat <oss@malat.biz>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <ZWADKWURCDZXyJTQ@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:41:06PM +0900, Masami Hiramatsu wrote:
> On Wed, 22 Nov 2023 00:13:42 +0100
> Petr Malat <oss@malat.biz> wrote:
> > +	static int prev_rtn __initdata;
> 
> I would rather like 'done_retval' instead of 'prev_rtn'.
 
OK, I will rename it.

> > -	/* Cut out the bootconfig data even if we have no bootconfig option */
> > -	initrd_data = get_boot_config_from_initrd(&initrd_size);
> > -	/* If there is no bootconfig in initrd, try embedded one. */
> > -	if (!initrd_data || IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD))
> > -		embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
> > +	if (prev_rtn)
> > +		return prev_rtn;
> >  
> > +	embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
> >  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> >  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> >  			 bootconfig_params);
> 
> This copy & check should be skipped if IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) because
> this only checks "bootconfig" is in the cmdline.
> Can you introduce following flag and initialize it here?
> 
> #ifdef CONFIG_BOOT_CONFIG_FORCE
> #define bootconfig_enabled	(true)
> #else
> static bool bootconfig_enabled __initdata;
> #endif

Even when CONFIG_BOOT_CONFIG_FORCE is set, we must call parse_args to find
the location of -- to know where init options should be added. It's done the
same way in the current code.

 
> > -
> > -	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
> > -		return;
> > -
> > +	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))) {
> > +		prev_rtn = embeded_data ? -ENOMSG : -ENODATA;
> > +		return prev_rtn;
> 
> Than we don't need to set a strange error value...

It's used for error logging as the current code emits a different
messages in these situations, but I will try to refactor it.


> > +	}
> >  	/* parse_args() stops at the next param of '--' and returns an address */
> >  	if (err)
> >  		initargs_offs = err - tmp_cmdline;
> >  
> > -	if (!initrd_data && !embeded_data) {
> > -		/* If user intended to use bootconfig, show an error level message */
> > -		if (bootconfig_found)
> > -			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> > -		else
> > -			pr_info("No bootconfig data provided, so skipping bootconfig");
> > -		return;
> > +	if (!embeded_data) {
> > +		prev_rtn = -ENOPROTOOPT;
> 
> Also, we can recheck xbc_get_embedded_bootconfig(&embeded_size) later instead of
> using this error code.

ok, I will try to refactor the error logging. Calling
xbc_get_embedded_bootconfig is cheap.

> > +		return prev_rtn;
> >  	}
> >  
> >  	ret = xbc_init(embeded_data, embeded_size, &msg, &pos);
> > -	if (ret < 0)
> > -		goto err0;
> > +	if (ret < 0) {
> > +		boot_config_pr_err(msg, pos, "embedded");
> > +		prev_rtn = ret;
> > +		return prev_rtn;
> > +	}
> > +	prev_rtn = 1;
> 
> This function should be splitted into init_embedded_boot_config() and
> apply_boot_config_early(). The latter one should not be called twice.
>
> > .....
> > +
> > +static void __init setup_boot_config(void)
> > +{
> > +	const char *msg, *initrd_data;
> > +	int pos, ret;
> > +	size_t initrd_size, s;
> > +
> > +	/* Cut out the bootconfig data even if we have no bootconfig option */
> > +	initrd_data = get_boot_config_from_initrd(&initrd_size);
> > +
> > +	ret = setup_boot_config_early();
> 
> Because you should not apply early_params here, you need to call only
> init_embedded_boot_config() here.

setup_boot_config_early() must be called from 2 places, because there is
no guarantee the architecture specific code calls parse_early_param() - it's
not mandatory. If it's not called by architecture, it's called quite late
by start_kernel(), later than setup_boot_config().
I want to avoid different behavior on different architectures, so I always
process early options in the embedded config only, although on some
architectures even these from initrd could be used, but it could cause
issues in the future if the architecture would need to switch.


> > +	if (ret == -ENOMSG || (ret == -ENODATA && initrd_data)) {
> 
> Also, this can be
> 	if (!bootconfig_enabled) {
> 		if (initrd_data || xbc_get_embedded_bootconfig(&s))
> 
> > +		pr_info("Bootconfig data present, but handling is disabled\n");
> > +		return;
> 
> 
> > +	} else if (ret == -ENODATA) {
> > +		/* Bootconfig disabled and bootconfig data are not present */
> > +		return;
> 
> this can be removed.
> 
> > +	} else if (ret == -ENOPROTOOPT) {
> 
> This should be
> 
> 	} else {
> 
> > +		/* Embedded bootconfig not found */
> > +		if (!initrd_data) {
> > +			pr_err("'bootconfig' found on command line, but no bootconfig data found\n");
> > +			return;
> > +		}
> > +		ret = xbc_init(NULL, 0, &msg, &pos);
> > +		if (ret)
> > +			goto err0;
> 
> > +	} else if (ret < 0) {
> > +		/* Other error, should be logged already */
> > +		return;
> 
> So this is checked at first.
> 
> > +	} else if (initrd_data && !IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD)) {
> 
> And as I pointed, we can remove CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD so this case
> should be removed.

I have added BOOT_CONFIG_EMBED_APPEND_INITRD, because it's not backward
compatible change and I didn't want to risk breaking current use cases.
My change tries to get early options working without affecting how
other options are handled, but I think appending the config is more
reasonable behavior and if you do not see it as a problem to not be
backward compatible here, I will delete the "replace" behavior.

I will try to refactor the error handling.
  Petr
