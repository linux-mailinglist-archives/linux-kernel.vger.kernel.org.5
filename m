Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795767C6118
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjJKXae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjJKXac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:30:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25719E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:30:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c77449a6daso3309855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697067030; x=1697671830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pc+L1c0TA8jsyBbY9tjU9uQpsWZgRUC3tgdYjXtGyo4=;
        b=fpQuM+QDwVTunnXGAuDPMDsAQDON5u5mbvw8m9SHrCt6X355eV9QiLAyrUashN2VLl
         2agRT6FQYAi89OCc2D5cEmogEvc0N89yB4TprjHTW/Wzi/vlC6KwYKLMEdw5cp+mknxu
         /zESs/N4qmvYvqfo9z/FZ+zkBiVzPbCsJsVUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697067030; x=1697671830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc+L1c0TA8jsyBbY9tjU9uQpsWZgRUC3tgdYjXtGyo4=;
        b=me3E6BBF0AoXy/fFE5pNkDFI9DfcIeiDgS7vGbnH3spnyNhENFRrJfcqaBnHONoH4V
         /gVfWcHgyGmSoPsy1+IBmw90M35vsiS292b431s0SCIhn1bow+241rDlComZRTQ+Y775
         62Vi+ppUWLQMWF8Rqmw0jue30zpHtDhaKd4v7n0kGg2HUDTbGvICxrIgUcrTn8UTLVxJ
         JcVAppZ2Ju1oSZZbFlU7rGV+dAPW2so7PakUWn+Ye8Gd6y41t6+WlhhW2eU4d6RuMDZB
         K/J1XdomjqW1h+9gyrV7an74ZalDYSWFw8OWZ5IqcTiLvponnD2EJyV5sfye5nmlju8x
         PCHg==
X-Gm-Message-State: AOJu0YxwH0mgP7rifLPtOpbcF8dg3WJ7PP76sWps7VSU/ixAmRqEsJyF
        EyRso23ZSKtYXkq7EnuE0KewfQ==
X-Google-Smtp-Source: AGHT+IGL/COvJmyF1vy5JMp/XRjDoRvPXZ0Sk5gmC14VhdhX3JwBvInAy1jn8bD+gmMT5Jd4gIdF8A==
X-Received: by 2002:a17:902:8b8c:b0:1c3:2532:ac71 with SMTP id ay12-20020a1709028b8c00b001c32532ac71mr20665887plb.31.1697067030081;
        Wed, 11 Oct 2023 16:30:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001c78446d65fsm429861pla.113.2023.10.11.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:30:29 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:30:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
Message-ID: <202310111629.4CE6D1A72@keescook>
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:53:44PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not needed due to `ident` being memset'd to 0 just before
> the copy.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, looks like a direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
