Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2707FFCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjK3Unb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjK3Una (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:43:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5AE10DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28652d59505so272456a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377016; x=1701981816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdNYtN41s2jpwnfeA1V4jjdLs2pUYVZuwjOD5GJva84=;
        b=M97g5dWUv2qK7YEVeRI3SH4KalaygsB0vB9UgZW08qVyJZlaABUPy54+MiBd5H08AF
         e43J3cLT79T4SGPNp8150+na/fR2kAxGilUSu9YKNOLFjQFYMjtgCR9dtHbV+HQQQucB
         i5yQLS6rF6m7LyYKCpf+VnVe1cX6cOyz+iH/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377016; x=1701981816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdNYtN41s2jpwnfeA1V4jjdLs2pUYVZuwjOD5GJva84=;
        b=MPXvs0ZJhTBmU8g1yTbt58jXZVk91dTbHoDUz/CpCSrak9yhDBcaqVfMmiEn4syAmv
         C9fIhjQM1OU0KHen1tMPWTcIueJ9tMl1K4pw0amzvJarJQ57wS4rXPllOw9J/fZto3m8
         GWVxOjmavLW43KVQOe052TwquDA1Tqzn1Y4PCsOq1QSdtAz3cTVkUUWv5djM7dRUM05O
         b+3+Oc6D4r1GevAz1lN/Yu5a/DWIcIueIKbzsv0+iBcebCx+MKytsX415Q0KF01BdH37
         xxk9ETHZfKd9Qse/7UM9nfGu/IZ9pvr8nXgzKJYD4nHHCUPGuu7MPS1QYG1fsw7xsN1M
         Gt0A==
X-Gm-Message-State: AOJu0YyoinVvSG1EtbkCgWARYIgopAC8GY99SfXDNbmER8b3lZ5XT38k
        yafaXeXEL4ZIFrIn79XgSHtBTQ==
X-Google-Smtp-Source: AGHT+IFcCWPCS5aAuYhRFgwSXNFOr9+0EHuLwrCI1lVTjpQUPkKOStN+Dh+dc5+CPp21DSIvXhJYxw==
X-Received: by 2002:a17:90a:350:b0:286:40e7:e99 with SMTP id 16-20020a17090a035000b0028640e70e99mr2520980pjf.28.1701377016042;
        Thu, 30 Nov 2023 12:43:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b00283991e2b8esm1872854pjc.57.2023.11.30.12.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:43:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] SUNRPC: Replace strlcpy() with strscpy()
Date:   Thu, 30 Nov 2023 12:43:31 -0800
Message-Id: <170137700879.3640204.581331941374933494.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114175407.work.410-kees@kernel.org>
References: <20231114175407.work.410-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 09:54:18 -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] SUNRPC: Replace strlcpy() with strscpy()
      https://git.kernel.org/kees/c/cb6d2fd30ddd

Take care,

-- 
Kees Cook

