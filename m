Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2887D5D65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344456AbjJXVnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjJXVnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:43:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CA133
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:43:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9e072472bso34886175ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183791; x=1698788591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frJVLA8q7CpIZN6bJ4cxEnaKNLHB5xpXe8qh07vj8Ko=;
        b=GiRR8zU/7JNpDaokPQXBor81wyQ0QFtHCEOBlgGjzg70V5AoiMlLJQ8rV1o3ha7UwO
         0SgZUSofr/jvqMDVKZuN8jQE4/GdCWJJgVZeo+wObU8oUNldJdFxdUj7Sy1kCO4KFVIh
         SHtsBbSdpIwO2tA1GTJ8xI64/CWUt+z/25frE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183791; x=1698788591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frJVLA8q7CpIZN6bJ4cxEnaKNLHB5xpXe8qh07vj8Ko=;
        b=ITL5xwZFZxSpT5CV/wOrWrC2AyryKa9h8BofYOkwSiJg1OwrRP0gRZFrHhpTW0mF2e
         Ef9NLGaWIyXVPs/1RS3tXQMd60iPky561Y3fKY4oDte7AATYY0wgPGXeAm2p9ObzWgZ3
         jaJ/Ujdys78ETnzTU8B4i5sEzcXfkB9u4eiBz4AWkPg5fmu7SGoIzu/FXnyxWHHbZSjS
         ppJQbZNk847IDhcFIP48Qs7vLBlXlD04iW1Z4KwkF/ZyA3r8xhvf0NOKbaN+HSmgxaxQ
         P+Oc4ZVczR2wTlZuy7oCaAp/S12XKbHxH2lR23IUAJlKpgCAqp4JbN3isTD30ACXfhjP
         TLSw==
X-Gm-Message-State: AOJu0Yw5K81VNOsAUNqCY33Pv6egr2DrAX3CO2C/5tfQFhKbuPJiPSEF
        fXqWjRQL/iO48VK8g34G5NUQl6980wknstYIL5k=
X-Google-Smtp-Source: AGHT+IG8jAZqjr17l2IkN2BhET8ny2FkIIjuMkCIzCSC/KN1r/G1kIQNXfVGVkoHBTaZGXVDBbwJfw==
X-Received: by 2002:a17:902:f687:b0:1c9:cc88:5008 with SMTP id l7-20020a170902f68700b001c9cc885008mr13338416plg.43.1698183791215;
        Tue, 24 Oct 2023 14:43:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001bc18e579aesm7844217plg.101.2023.10.24.14.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:43:10 -0700 (PDT)
Date:   Tue, 24 Oct 2023 14:43:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Message-ID: <202310241442.0E90AB9@keescook>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
 <87wmvcxjdy.fsf@kernel.org>
 <90328e09-5e48-4bd0-ac67-62a104b6eb76@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90328e09-5e48-4bd0-ac67-62a104b6eb76@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 07:11:51AM -0700, Jeff Johnson wrote:
> On 10/24/2023 6:03 AM, Kalle Valo wrote:
> > What about using just memcpy() to make it clear it's not really a proper
> > string:
> > 
> > arvif->u.ap.ssid_len = 4;
> > memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);
> > 
> 
> In the "changed & BSS_CHANGED_SSID" case that comes soon after this we just
> set the length and use memcpy without clearing the rest of the buffer, so
> doing the same here, as you suggest, would be consistent.

Ah, please ignore my other email asking about memcpy safety -- I'm
reading threads backwards.  :)

-- 
Kees Cook
