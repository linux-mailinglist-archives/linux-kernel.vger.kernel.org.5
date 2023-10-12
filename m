Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D627C721F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379483AbjJLQKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379457AbjJLQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:10:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF2794
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:10:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b1e3a809so8974485ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697127013; x=1697731813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uywQQTLnXLWpXOPun4QKJKuWvTo48kWYaCdd1C3bRtY=;
        b=eXB57y8nF6Lv2jjt8DJUA5l8vtoO9MlqrHWgvl9EC/lLrBSxANJOHH8Zofq9nI0j5B
         a8yE0FsRdtOSnrjHXJN28K587uCxeTmtYXzxo2XlJs0YpHI3b65TaAvAsLiHgZsfuuZW
         +5ShGjLpTL7+ux/gIPtpAndl/Up79e8MWNCl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127013; x=1697731813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uywQQTLnXLWpXOPun4QKJKuWvTo48kWYaCdd1C3bRtY=;
        b=OXoFGzgsuFRd66rrNFcoDyf1XLxbl1wCkLRhhCh9pZL0wKetYAa2qW2UBYvJeecieR
         c/PmB67dnrazXUJcY2DV4mjgOawGSA6POrvqUK5PYL9dIY/OgF3b7F7fFRCfEro5nt0x
         tVRJJ7VE9fJ/7au8U7EnxfzN+cZKX/EA8at9vzOGDQiDFS3r2GDjbu0B5G2f0fCUT9l/
         75a3vUfGBg31sCtDXh16Ldq0UR5H4gG5nY0HkOdvRmBDnVl6jM5C8t1UFjbh9kr0nU/S
         tCDI2vj9U2tHdGkLX6pI2wsyhqMd2uZonqs56oPASXG/CX9Vj1VCNRN5KDpMnZFSUjXC
         PzLQ==
X-Gm-Message-State: AOJu0YzkGdVUC1iHC3+LGdJFqMSN5+oQD45avcmNoWJMrjbQbC5NLtJ+
        emkufRQLRSPpIbFYqyu4tQoTcf5hk4Ml50ddSk8=
X-Google-Smtp-Source: AGHT+IE70nC8DSZzov+QUlaT8psAeyZAo6cLbH9AArJEY5B9saYS5UPiiNtcut6ioYKyhJakE+UGSQ==
X-Received: by 2002:a17:903:120e:b0:1bb:c64f:9a5e with SMTP id l14-20020a170903120e00b001bbc64f9a5emr26657038plh.5.1697127012911;
        Thu, 12 Oct 2023 09:10:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090274c700b001c72f51b84asm2177860plt.52.2023.10.12.09.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:10:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     iommu@lists.linux.dev, Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hardening: x86: drop reference to removed config AMD_IOMMU_V2
Date:   Thu, 12 Oct 2023 09:10:07 -0700
Message-Id: <169712700540.4491.11130004795723202092.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 06:50:40 +0200, Lukas Bulwahn wrote:
> Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
> config AMD_IOMMU_V2.
> 
> Remove the reference to this config in the x86 architecture-specific
> hardening config fragment as well.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] hardening: x86: drop reference to removed config AMD_IOMMU_V2
      https://git.kernel.org/kees/c/faed498d0db7

Take care,

-- 
Kees Cook

