Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CE077D928
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbjHPDi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbjHPDeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:34:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF362690
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:34:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdef6f5352so14554115ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692156863; x=1692761663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E64xP/xgSDs+NpkKdH0D/gkdQzULRu7E4iozMrG/RLw=;
        b=Os14XUAU+blPxJYknm9CJrmbTJz4HXqM7gJh171g8wwauMErYzwoMLMWgrKpDNYhwR
         8ZJeofqT3GdTRb865CnWu0YvehWgxNANR+R+AnxE5TiEbiHNTmJ7YPnvp/MHz0OIAq6T
         yX06hzgGhDt/rSZMoGJzLx+rOyPf/ThmECnVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156863; x=1692761663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E64xP/xgSDs+NpkKdH0D/gkdQzULRu7E4iozMrG/RLw=;
        b=lUFSWr21Ur0n0+jk4NsY9KAzmiV68gX1iJB5V4pcLDV1n0sGQ2dwlqoFr013fErWxP
         u4+lS1TSyzlN2nW+xERlBW11UY6vXWDeVz1qvBxqBU+Edn1uUmh2PlK8dtK469tnJO3+
         DKXXKDfFEUwAo3nypS6dX+SJ4W7OqZ+nokhwRCtdgPK/LHS1Gu7Ks1H8zcTbx2sLv4R8
         p4jKTnA0MFPR/1coy0B3SjdzfU8/glkbmGgsaz0Ggbr9k+WJWxEzSADdV4/NpNAXXK/c
         +qZ81GJLZ/Py/KtyBpMqXchONi8a4O4RbchTsfcCyt8Ee4SD4gfIVrD6h/EjuPUhdkSx
         NsWw==
X-Gm-Message-State: AOJu0YyRpdYD4UxhaQ+xPRE1OzM08+WTbdiNafeWFV75Dqu45gS5CAGz
        /RR1ofWUEgSncxYT3j8F25Gn4g==
X-Google-Smtp-Source: AGHT+IEU5giKTTdU+rZ4DGXRPGd/wJxNpisZshlDZz4EFiLP5iVXhhC5rR9ENdKTCmf+uwyDxWkuuA==
X-Received: by 2002:a17:902:d4c3:b0:1bd:f314:7896 with SMTP id o3-20020a170902d4c300b001bdf3147896mr779224plg.25.1692156862903;
        Tue, 15 Aug 2023 20:34:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1601:f73d:719a:8de1])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902788900b001bc6536051bsm11743683pll.184.2023.08.15.20.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:34:22 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:34:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hexdump: add a new dump prefix DUMP_PREFIX_CUSTOM
Message-ID: <20230816033418.GD681074@google.com>
References: <20230811074922.1388-1-thunder.leizhen@huaweicloud.com>
 <20230811074922.1388-3-thunder.leizhen@huaweicloud.com>
 <ZNuMGyJ2x21RpVyR@alley>
 <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/16 11:20), Leizhen (ThunderTown) wrote:
> > IMHO, this is pretty bad interface.
> > 
> >   + From the user POV:
> > 
> >     It is far from clear what values will be passed for the given
> >     printf format. It can be docummented but...
> > 
> > 
> >   + From the security POV:
> > 
> >     The compiler could not check if the printk() parameters
> >     match the format. I mean if the number of types of
> >     the parameters are correct.
> 
> Yes, it has these problems. So, back to v2, how about add DUMP_PREFIX_ADDRESS_LOW16?
> Or named DUMP_PREFIX_ADDR16 or others. Or change the format of DUMP_PREFIX_ADDRESS
> from "%p" to "%px"，Or add DUMP_PREFIX_RAWADDR. Or keep the status quo.

Linus quite likely will dislike (with passion) the idea of using %px.
