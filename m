Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956AF7C45EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjJKAOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbjJKAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:14:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A130D9D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:14:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-69fc829d7b1so3139196b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983288; x=1697588088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUCeSJPd8HQSJUW/ehPZETplrqc/WZGCTN4su2s0Zbg=;
        b=mfVp80U1B7KBJ71IzevXg/i3MVsyIy7mOuOu/Pr5I6FD3SUAO0nI93uGktOFHVC8c4
         iBGAKXIvcc0qvOyXRPetyyqTxq45xB3TUH9TjXUmdJUCaGxzXbSSdeqRG4ThNOWHYwwh
         9os+jMtkkZIVkjA9hhsQKLsL6UadgNVptM7oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983288; x=1697588088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUCeSJPd8HQSJUW/ehPZETplrqc/WZGCTN4su2s0Zbg=;
        b=PtZdTB84y8IhtGrDC4oLn+sNRgzMFGoE0p3dYZj27vKAazG7fRyHN8pVHZnAvHBQ3N
         uwwJukN1Vmy1hmdRA1KSbk+mLsr57EXcxuNZrxcQjVFaH7nr4B+T6A/1KLiw+kz5cP2j
         mJ5f+CRLmy8pTiD25T5fBPXgqciI1AKzwWlkt4KmbggFkjhQUi5Q7PLsa3kVkFHqaZaC
         dJHXPQV9t4OPW2KAyZefYMH93bZRSzZ8u7qhrSn43QXRA99EjtYkeP2MiG+Bt0uUT6aj
         nVz09Aow4arD5Zbvpibl0XqzytuY0EA4syopbL+D8w08GbwBnFtofS06fs8a7Zl/BkL1
         sOLA==
X-Gm-Message-State: AOJu0Yznic5/QAETIANI55f/2PJGqoBc/+2GE2AG+q7rT0nf60OSKoLr
        WiEqUzJpo+/XADK+coleXHx41w==
X-Google-Smtp-Source: AGHT+IEu0iHuIbKap0+Pgy72dLzHa/+bzOMU0Ip3s2PvOlQ15Wm9uvCQXCz63lutTjoXxYd+igxBRw==
X-Received: by 2002:a05:6a20:5483:b0:16b:80f2:c234 with SMTP id i3-20020a056a20548300b0016b80f2c234mr18020146pzk.59.1696983288122;
        Tue, 10 Oct 2023 17:14:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e1-20020a63aa01000000b0057ab7d42a4dsm10695323pgf.86.2023.10.10.17.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:14:47 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:14:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
        wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 1/4] seccomp: Refactor filter copy/create for reuse
Message-ID: <202310101714.FFBD84BE@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-2-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-2-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:40:43PM +0000, Hengqi Chen wrote:
> This extracts two helpers for reuse in subsequent additions.
> No functional change intended, just a prep work.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Thanks! This looks like a clean refactoring. I actually think the error
handling is more obvious now too. :)

-- 
Kees Cook
