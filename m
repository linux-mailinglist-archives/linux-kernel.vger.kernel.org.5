Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66C80F4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbjLLReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLLRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:33:58 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377BA1;
        Tue, 12 Dec 2023 09:34:04 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b8b8372e30so4410672b6e.3;
        Tue, 12 Dec 2023 09:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402444; x=1703007244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0z2AT1BJQCnr747Qe1roJ7ZoVnIRvZI+JcfC+nIFJY=;
        b=L0Gg8vLBN/QdLnBK+t25yyYd5JFQJumGXF5XELe+oBMae3Fk8PQ3OGe4Hs8mfZclrI
         XPuUTeGGHScuRZr3NqDg+tmsg7J87TvqvXs3nfZemXOTAGW5RfbALaZzEXFBUqmXHRGy
         nvOy6TUxWWkR++XjGrKRjocTP6i+rzgI9Od3dATmHPxm2X4HtoHQ7/Zf2YwbLaPZvH7N
         7rUcMtCTC8pcJacY1jVtYzCEplyBTmC5jkkQsfVR0ALl+mB2Lyh6Ew5APPcRvtfJumnS
         bynd0agfkvp8VEXWhfFNoCGbpMBo5U78nVn8mXiCCqgx6ahNG26Uuz+T/HViRVuKNNmw
         zOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402444; x=1703007244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0z2AT1BJQCnr747Qe1roJ7ZoVnIRvZI+JcfC+nIFJY=;
        b=I9yjtAS+mVA7rtn+OjF+sQN54cIAAzQ/q2BdXw3nl54UQtdSE6JMAy74iEF7gdMnlD
         3dmcVPkHqR92WNTle6g+ywGThQdWGZSijExZmPN7wRL1XSLW8f/3mloMfHo+07yO6PLH
         h1/hZWH51B/5pfe0W50M6AIiYwIgq1bnx1YE4oy3NOPtv4PugPE1933QMvZKXpIznzQ0
         fr7WegjSyRlMhO1RbmGiwiuUDWMxbto2gr86ffIj7Xhx9pluin5aDGM2gitMOkjIr+bd
         2XO01hL735Pd0SjT2wbzmYJQ5vASb5AD5W7EMS7eLj4PhYP4RQ/CEOICK7K6ooM0R0P1
         5SFA==
X-Gm-Message-State: AOJu0YzUOBInNKk2G1RJRMUd09qUeaHyXDQG1NIJi+IUK3qV6Fhsr8OM
        zzk4hvJDGZLaYuh2J0wtk8s=
X-Google-Smtp-Source: AGHT+IFCiLt4rwoXp6x0bRjRpea/9EBC/0MF+xgyL2PXBDccmn3cy84+U+frpTFB5Idvb9FJiO+44A==
X-Received: by 2002:a05:6870:4153:b0:1fa:fe4b:21d0 with SMTP id r19-20020a056870415300b001fafe4b21d0mr8077857oad.47.1702402444232;
        Tue, 12 Dec 2023 09:34:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ps5-20020a0568709e0500b001fb33181cfasm3180566oab.55.2023.12.12.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:34:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 09:34:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
Message-ID: <a461d8ce-cf28-4840-af5c-6c7895c300e5@roeck-us.net>
References: <20231211182036.606660304@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:19:50PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 545 pass: 545 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
