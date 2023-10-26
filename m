Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDE7D87C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjJZRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjJZRpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:45:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F83B1A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:45:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b709048f32so1143413b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698342329; x=1698947129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAfQHwAPGilY5JFUvY07Iu65/aCmQBkbdIAGwWe4Mw4=;
        b=OOokzr/xpQa586UCRy1xcsAo2JXtjXKK1A4AH0Mi0GigDWK5n5q4u1PR/MPf7y4mZx
         6lfsYsgMkX3AgdzCDUoaVBEAyZ6mKBXXMfIbGM7AQzKUgVkEUaMNlphLER8SP3XX3QRD
         RJOB3ss9gxH8pBplRtLEDGjf1MqM7kQSLI8uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698342329; x=1698947129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAfQHwAPGilY5JFUvY07Iu65/aCmQBkbdIAGwWe4Mw4=;
        b=cPgDqlsPOioRl0ecUfz04zLs9yRHj1KbIx8Mg6PjYOsrNa8NB8sF87WCCSuwYe86rg
         r6XO8/obCRv7ZVD9veQiZ2Ymj9cM3KS74bz3LRXTBWnXbXRtlG4NeCbRzbVx2uYFE+Ym
         HVVXa9+7HJo35/7DHNyHYOlySiI8el+ozwUATDMHrs7gNBNdqL2pCEDvUSWOY1uAqmBs
         6bSc6Y9BJw51Atg507LNqHOwcpecEsH9X9uEYe17LTeK+s8DAv84k81K5+uMHhfq4Ue7
         uezWbf47zkujb48m3Tubn5SVxwexFmQ9sXZuUs8PBv9BU0K1cmeYC+mTfjHS+Iwzofln
         wAOA==
X-Gm-Message-State: AOJu0YwKzgDtW0XxxtWQY30JQrLFTpN6gAYzpbCrVhiu5aCdy4mTDZIQ
        Acl58afvkax7ccZZ/mG4htjhAA==
X-Google-Smtp-Source: AGHT+IFBdjZbnbEQ859p1Brndxt1jXVT1XtY8KlXeTsIfFnjlV9Z2Y1YMFdXHByJlyYQdj3BFcCO5w==
X-Received: by 2002:a05:6a00:114c:b0:6bd:b7c5:f777 with SMTP id b12-20020a056a00114c00b006bdb7c5f777mr188412pfm.16.1698342329654;
        Thu, 26 Oct 2023 10:45:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b006be047268d5sm11822297pfo.174.2023.10.26.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:45:29 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:45:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: elx: libefc: replace deprecated strncpy with
 strscpy_pad/memcpy
Message-ID: <202310261045.5D815BE@keescook>
References: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-scsi-elx-libefc-efc_node-h-v2-1-5c083d0c13f4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:53:13AM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> To keep node->current_state_name and node->prev_state_name NUL-padded
> and NUL-terminated let's use strscpy_pad() as this implicitly provides
> both.
> 
> For the swap between the two, a simple memcpy will suffice.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! I think this looks good now.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
