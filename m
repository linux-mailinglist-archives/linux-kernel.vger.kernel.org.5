Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480777A30E7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbjIPOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIPOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 10:32:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66640CE8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 07:32:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ad9155414so2846204f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694874766; x=1695479566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuCMRYRUI5pE2pACmrLEmespxY+dxj38Ol7yGsVBHSU=;
        b=PuqGDe6CZBYIFMsaW2bIwkwwRy+umt+pbvUsZgYaxXTsxpY1MY6UcdFcZ32Xbzhh7N
         MPtR9SDdRpoYnQ0CJWuUAl5Zwuu2iXIwQSB45yIEHNI6QN0qkpOWvtr38c5rMBi7UW+1
         kB0Dg/gHWlFRM3RvaEZd3pEYv/vyuwqBb+TTigDXkYC8Dww5Y43o8X7CF8ebSVexZmyU
         6mxVceBfza4WEp8kmD+9IZjzi65t87Cw1Ro47uIq72+4iovstqZ+Oqtk31ztOpUy8PK+
         KNDiPibdXcAckXdAguzGwFnZOMa54ovBINgtgM8kNgG7HoETDk3KvXVCv+iIedCWkTqk
         mXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694874766; x=1695479566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuCMRYRUI5pE2pACmrLEmespxY+dxj38Ol7yGsVBHSU=;
        b=PRMPvkXuG8/qZ5Out/WlQv5JucUk15/6S/285MGezthZtMRu2SwbJMv+mbixbiBVux
         VTEC8udvar9H15Gh3xQWCQrkm8b6PlI0aEJsi7ci68fDWFFvO3rZ//MUJDtecWPoP085
         IKkncgXKjVhFGWUo4HvyoxvAFBRovtFK4m4n+S2RB5pLpKgsLVHuRRxiTmTiozQcMIkk
         8ZlU1Yu7prYksPpED+ghNN5KPcJZdQ1I4RwV2i/qpGlOoqQWzKHPjvfTydDM2D6/EFxk
         RVtIa4jkj41NKekdzxQw+TdKkEwN5oXBtEU88uk2BRTgFXlyS+HKee4XPeNdt7tEPxPd
         4Wrw==
X-Gm-Message-State: AOJu0YyTXdNRB4wnLNzDHkmg5iwad2J6KSK6FmVx0uyY8rxDFuwIzTaR
        SbKwpT88saNI3aBUZg2OCCxJWw==
X-Google-Smtp-Source: AGHT+IFo2cGGQRjJb8BtVCZ+zzLXMvuJine6w6l4fG9U93EB+rQqIuIbo58+ykYvKJeUmr2pjBhAfA==
X-Received: by 2002:a05:6000:a1a:b0:31f:facb:e1ba with SMTP id co26-20020a0560000a1a00b0031ffacbe1bamr2807958wrb.70.1694874765714;
        Sat, 16 Sep 2023 07:32:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b0031779a6b451sm7270032wrt.83.2023.09.16.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 07:32:45 -0700 (PDT)
Date:   Sat, 16 Sep 2023 17:32:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
Message-ID: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
References: <cover.1694202430.git.pstanner@redhat.com>
 <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:
> +static inline void *memdup_array_user(const void __user *src, size_t n, size_t size)
> +{
> +	size_t nbytes;
> +
> +	if (unlikely(check_mul_overflow(n, size, &nbytes)))
> +		return ERR_PTR(-EOVERFLOW);

No need for an unlikely() because check_mul_overflow() already has one
inside.  I feel like -ENOMEM is more traditional but I doubt anyone/userspace
cares.

> +
> +	return memdup_user(src, nbytes);
> +}

regards,
dan carpenter
