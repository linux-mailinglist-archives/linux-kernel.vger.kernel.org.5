Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048A27F50E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKVTpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVTo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:44:58 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAF12A;
        Wed, 22 Nov 2023 11:44:54 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c5071165d5so2127161fa.0;
        Wed, 22 Nov 2023 11:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700682293; x=1701287093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khlJpqJuft4n03C9Ho0HlV0suFMRaRR1X49QgmayVfk=;
        b=gziyusxaJDPfsF8+YY8x1HP8OhHTGzpeBbYyDAqUgsZMfVTgI75UfqiZs6hWs9qP5D
         EVNbMcIQmzj/bTbZfboK6iDA0AZHE5BEA250QfyAnltHAqmAvxMAFd8YALgsEp4x/Uks
         YX5SPDck8XFMkKovO8z7iBYTJlm7fUF6xr+e1XaX1CitXMZdhqBnBI9IzrGOA3niwxOf
         fDMVwrX/s+6U7uBoiWO/JxfZDK1r2L2Gl09FLI/MnQ7zx0e3urqkDuvOso3S/wKyIrDo
         mqMxlkV6MPN8t/4Q3Dr4qFPHvT8iHNYuFLuiULZwaSeDZoFKZsquFP/j/SxecCShHGnx
         TtGA==
X-Gm-Message-State: AOJu0Ywnpe5W8X8thj255BCKn9zCjW36UMznBj+qcPwqqcCJoAu8FZYu
        /M6Tk4RnVj0JJzFj0yYQPwc=
X-Google-Smtp-Source: AGHT+IGheHILyDckW8QssKhbkJMO8M91VBHHMt4W/vvsMCACmfCVHwxUhNbE7Fk09r2WsQQlfCi5PQ==
X-Received: by 2002:a05:651c:1047:b0:2c8:8813:2e7b with SMTP id x7-20020a05651c104700b002c888132e7bmr2380549ljm.2.1700682292637;
        Wed, 22 Nov 2023 11:44:52 -0800 (PST)
Received: from gmail.com ([2a02:c7c:5b4b:e600:751f:437c:bb5f:eda2])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b004077219aed5sm436545wmq.6.2023.11.22.11.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:44:52 -0800 (PST)
Date:   Wed, 22 Nov 2023 11:44:53 -0800
From:   Breno Leitao <leitao@debian.org>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     platform-driver-x86@vger.kernel.org, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com,
        ibm-acpi-devel@lists.sourceforge.net, mario.limonciello@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: Add support for improved performance
 mode
Message-ID: <20231122194453.GA497690@gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:54:33AM -0500, Mark Pearson wrote:
> @@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>  	if (err)
>  		goto unlock;
>  
> +	/* Set TMS mode appropriately (enable for performance), if available */
> +	if (dytc_ultraperf_cap) {
> +		int cmd;
> +
> +		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
> +				       profile == PLATFORM_PROFILE_PERFORMANCE);
> +		err = dytc_command(cmd, &output);
> +		if (err)
> +			return err;

Aren't you returning holding the 'dytc_mutex' mutex?

From what I understand, in the first line of this function you get the lock,
and release later, at the exit, so, returning without releasing the lock might
be dangerous. Here is a summary of how I read this function with your change:


	mutex_lock_interruptible(&dytc_mutex);
	...
	err = dytc_command(cmd, &output);
	if (err)
		return err;

unlock:
	mutex_unlock(&dytc_mutex);
	return err;


I think "goto unlock" might solve it.
