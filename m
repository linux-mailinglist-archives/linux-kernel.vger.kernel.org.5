Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFD7CECDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJSAja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:39:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BD4FE;
        Wed, 18 Oct 2023 17:39:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083f61312eso9048605e9.3;
        Wed, 18 Oct 2023 17:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697675965; x=1698280765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEUeI7TkzWzqhkzUnSidN8EfbC071WzYkxQl0FkcC+E=;
        b=evvpExrPzIcw2aZPw7rul3bKCvqgt2l9frhohlZjkMaZIQ3lREjSdrycBoJsUEG8zd
         QE0n9ngEscHIT/Y/KOr6oSAJrf2Frg7mg3qEC2QYDOjtHzK97Hnb+LMumbVGxL2vdvVl
         FQfkLmnS5ONJajCtni0NS3rKFfUTkL8T7epjS67X2aZfUCh/MVEa/6YoqTQ7vlH78nog
         rIepsctzwi+/8MUfF7Lz0w1iFTpqu7RH6Hi2xfWBRMRLK1t9/KHXTPwwvlTO8rmAUSfs
         q5qscRnJH/yxIx/ZqRht/8CwIdY8BKAWyRPo8XQKoYTbuBRcwcPQ6wiDx8s3FFEtc65H
         4+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697675965; x=1698280765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEUeI7TkzWzqhkzUnSidN8EfbC071WzYkxQl0FkcC+E=;
        b=U6ijm+8lSXPySCGIOhO8YrG+x3thViIb8Viy3wa3JrT62f+f2MdSphOUnOJpdVLs+3
         jvazD+fubvb7EhRyk3REk9c9yQPgS5kIEBGS+uTu+9m7vGI6MiLt9+4PU9CMU+RDeXUB
         M0ekTWM6hdWZsRELJOcFssOTgJODMclGfWIyEl30U/uTGltqo6igTvW7Hk5Bye+Gflet
         RU3ju6pb/+eZegq1x2hwUTzb23C6qSNPUjC6IF6X6qp6LpAn3KgqhQYQzmcPFTfxpMy3
         3Q/N5V+xwculhFsbLHevp3GeALB48CKkxDcj4cfRiy/xS1OW/WlzZbTmtzujBkD85Mar
         cGxw==
X-Gm-Message-State: AOJu0Yx59SS9A9ZxYlsvK7gBI4VgUIoDVrISxAWfuCrNe/g86F133so4
        nKXRoJrnd2n4grRTGFrnx+I=
X-Google-Smtp-Source: AGHT+IGDeesw3VWl9zLEaZDEVphHnZLOPk0plbscyyVstodE7Jnw+ixNcfD3lFVAUBngSITgmTE5oA==
X-Received: by 2002:a05:600c:4693:b0:406:53e4:4d23 with SMTP id p19-20020a05600c469300b0040653e44d23mr588493wmo.23.1697675964405;
        Wed, 18 Oct 2023 17:39:24 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c481200b00407b93d8085sm2939485wmo.27.2023.10.18.17.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:39:24 -0700 (PDT)
Date:   Thu, 19 Oct 2023 03:39:21 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v6 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231019003921.vgdc5wg2eoaq6t2n@skbuf>
References: <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-1-florian.fainelli@broadcom.com>
 <20231018175820.455893-2-florian.fainelli@broadcom.com>
 <20231018175820.455893-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018175820.455893-2-florian.fainelli@broadcom.com>
 <20231018175820.455893-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:58:19AM -0700, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
