Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461937D5F11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjJYA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbjJYA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:28:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026DD7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:28:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf55a81eeaso36076475ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698193714; x=1698798514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1VOdbNwXAH3NHxdn8pigR7QBmM0uZMTBZfW6F7KshE=;
        b=IZJJbnUsk2yQA2mU78DmBH83qZOWJWvpY0RxMEMSP/3Zh56Bag65bTpA+yVudag0OQ
         lDxJxtX+ixpEUySmJ6PMUeyB7U1pZDgeJEBlsfSmiQ/0xC1idBb/2r9Bckw3vixdisPW
         LjEDTztFrBZ6FjabGApG4DI3++YQG5RTj22/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193714; x=1698798514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1VOdbNwXAH3NHxdn8pigR7QBmM0uZMTBZfW6F7KshE=;
        b=MGazvzkIPJ/KmqecTQjnv/6Uv+4oOLx3Dek+aeWFRGfj6oB3K3hT4+099/mYSwBbpr
         PiSG4QBZSuhT54acJtNFhth+CP8tTrFB7c6JAZD9qbZRCEWa1S83LHcDb4AFl6Py8NlN
         bsaMTT25Pcv2IoKUlGlkFsNSMb5HDv+LjTz8oVTxMb4ejLoOSVPidVpS4Dn7iacpeHeT
         cKPl7Monrsa8UVh6J/bGjrt6924WD+qhk/XjIqTM5DIZj1HVCe/tgyU466UcUmD2YxM6
         7qaeHDf1ABQ3lyPccQb6zEPYx97UvLzpvEsqSazDk35kcslwk4yq94bgM9IcdYZZXPZY
         vnbg==
X-Gm-Message-State: AOJu0Ywe5s+z0rGXRVuW/4YZPOD5HscIBy30IR6ElhKyO2NEX/6Gr+ma
        kdiXayyoF/i+B8tIREbMTf8Tjw==
X-Google-Smtp-Source: AGHT+IEnXLVJRa3cR/YMGF26nXSPNxl2kYEhL044D3Dodeq+sGspMNV1yT079dieG/mr4U+ldjBmZA==
X-Received: by 2002:a17:903:6d0:b0:1ca:de41:753f with SMTP id kj16-20020a17090306d000b001cade41753fmr6488394plb.15.1698193713899;
        Tue, 24 Oct 2023 17:28:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001c724732058sm7964995plb.235.2023.10.24.17.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:28:33 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:28:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: replace deprecated strncpy with strscpy
Message-ID: <202310241728.6CEDB92754@keescook>
References: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:12:22PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect hba->chip_num to be NUL-terminated based on its usage with
> format strings:
> 
> 	snprintf(fc_host_symbolic_name(lport->host), 256,
> 		 "%s (QLogic %s) v%s over %s",
> 		BNX2FC_NAME, hba->chip_num, BNX2FC_VERSION,
> 		interface->netdev->name);
> 
> Moreover, NUL-padding is not required as hba is zero-allocated from its
> callsite:
> 
> 	hba = kzalloc(sizeof(*hba), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Regarding stats_addr->version, I've opted to also use strscpy() instead
> of strscpy_pad() as I typically see these XYZ_get_strings() pass
> zero-allocated data. I couldn't track all of where
> bnx2fc_ulp_get_stats() is used and if required, we could opt for
> strscpy_pad().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This all looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
