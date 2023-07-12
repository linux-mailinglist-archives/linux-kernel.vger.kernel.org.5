Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E817511A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjGLUEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGLUEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:04:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4146B1FE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:04:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2632a72f289so3697863a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689192290; x=1691784290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2bP4FrSa/tMRfra6gyMcKmFEKjFt+SejG9bgvuc104=;
        b=blCpgqFQrYp3ZwfMlAfta5ZoQm+9hdBurc5h/OVxTVLnT+FmS33fWf2B53pSFgLCc3
         IDTfJwHMxmMP0lTo0MT0CK1hKF0KObeYFt7EwnmRkS5CiNRje0+uTgpFDyRw48Xl24+T
         pTWl9j9boIgO7sISR2+FooRd5oAmYs0zSk1yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689192290; x=1691784290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2bP4FrSa/tMRfra6gyMcKmFEKjFt+SejG9bgvuc104=;
        b=Np7MpklcTexrMcuV5tOTd6dSZc6NGRDFCb6ARUsc3UuaUvQJEWpBR86D1q7Z1Qkasi
         zO6SbOTzHg0tWco9CVuSitzAHdJ1TVlTHarSrr+wYLL4hu7l86ENuJVGH+DV8YlADzsi
         2p/en7DFaGZtcJUCPij9ni+zqp0cgrYR/fiGoLGm7tos4Vx0OBRXT6U1/G+441SQ9bda
         AFJ88asDUErg5qxVDjoavRRY/iiTi7SO/D0YQ2YEJgq6Sj14UhjbeIfEQI7v0UgJnw7a
         4otdaKG6blpu5j3HEyKCBP1l+lRNN4PHfGRTdvoWDy84LE9h5Gf0d/lNuszJsDPN4wIQ
         iLJQ==
X-Gm-Message-State: ABy/qLZy6vDpwpTSUeuZ7lXZK5wy2uVGlHS8OgQUAHzrSgyj6cKvNBeJ
        a5ItupOlpSbo3V1F+Nx0cuXg9A==
X-Google-Smtp-Source: APBJJlEFcbL/I1keeccNKgOeWSTqzmfmg1AA+pifisunZTA888Iovl0kJq6Hck30Ew+Wwubxzpgr1g==
X-Received: by 2002:a17:90a:bc84:b0:263:7d4a:4d43 with SMTP id x4-20020a17090abc8400b002637d4a4d43mr2537145pjr.1.1689192289698;
        Wed, 12 Jul 2023 13:04:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a035500b00265d023c233sm3613496pjf.6.2023.07.12.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 13:04:49 -0700 (PDT)
Date:   Wed, 12 Jul 2023 13:04:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zheng Zhang <zheng.zhang@email.ucr.edu>
Subject: Re: [PATCH 1/7] KVM: Grab a reference to KVM for VM and vCPU stats
 file descriptors
Message-ID: <202307121303.85C768B3BD@keescook>
References: <20230711230131.648752-1-seanjc@google.com>
 <20230711230131.648752-2-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711230131.648752-2-seanjc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 04:01:25PM -0700, Sean Christopherson wrote:
> Grab a reference to KVM prior to installing VM and vCPU stats file
> descriptors to ensure the underlying VM and vCPU objects are not freed
> until the last reference to any and all stats fds are dropped.
> 
> Note, the stats paths manually invoke fd_install() and so don't need to
> grab a reference before creating the file.
> 
> Fixes: ce55c049459c ("KVM: stats: Support binary stats retrieval for a VCPU")
> Fixes: fcfe1baeddbf ("KVM: stats: Support binary stats retrieval for a VM")
> Reported-by: Zheng Zhang <zheng.zhang@email.ucr.edu>
> Closes: https://lore.kernel.org/all/CAC_GQSr3xzZaeZt85k_RCBd5kfiOve8qXo7a81Cq53LuVQ5r=Q@mail.gmail.com
> Cc: stable@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks for preparing this! Looks like the common get/put code pattern,
so I can review this patch, unlike the rest of the series. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
