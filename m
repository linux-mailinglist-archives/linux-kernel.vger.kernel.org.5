Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DACB780B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376816AbjHRMQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376854AbjHRMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:15:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C2E7C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:15:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso8218465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692360956; x=1692965756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCgI6ch4syeqbbC+MLzIQRbozJOcNueG12S2nRvRB3g=;
        b=KGYGlhrItx4oMmSB4E4B2wzb/G5KqQ+DsiHE/S2E0Fcdb9M514IWvfAz5bWmX0kkkU
         jA6Q9fXG/1WBSkflFBiyKUzwkCoHyCkH+TussngbRS/pOyuUtXjAeXXDX2Gy2q79867U
         Zk68Huw/zSfGKac6Y/MyBpp4WxU8YB9QhsqVN0P9A5juNcfJYVTP8xOPb0fW6LW0Yael
         eyHelAdxY2PXhdS6Dt+Zqdti4GPzcatjq6JKVPuCZNYVu1hnfmPqPaiPC0/LuIJNPe6w
         1owBgxnKUAVkvlv7pRAWfMEn2bkzMYl/jKDsjKTDqy3uAExEjtBw0DkDFnTPxAhSHIrv
         qTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692360956; x=1692965756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCgI6ch4syeqbbC+MLzIQRbozJOcNueG12S2nRvRB3g=;
        b=JdQrzcCcnZ8Qa2cIFFI6kEESCt3Sy+NGFCTbt+bFml7J5mMNs+mtFewVThjM+CVYSo
         yDcIn/8k0jAcZWkrt956sg3RuSWgf/OmVmWpzOic8LITq7XtXG+XH9qI6Wwi9mQXJXkp
         2tCWFgeX/Vg+58DxtQRWhHvJYtGXTnGSzf7P4/Wf2RsTwFGJfLYdayfMWt+331y8J8ib
         EJ8RlKYwXLDy/QJhhNR5sgDPGGPSpEY44nBEMneI/41Ubgnt28mKKOBLKz36LiamGY+6
         e+NM2PLQCofOaiTj+T/M5p+ln8zQQ8eg1UErErC57xAautienDQo/FzRyvUzw/8hd7+t
         lXrg==
X-Gm-Message-State: AOJu0YwNz0cRhNDHXzJVz/IwVRRBX9QU72h4pIcwb7Sg16qu0E4S67+A
        8BjssvGljeZYifJGACLhMDz1WQ==
X-Google-Smtp-Source: AGHT+IGuKAK1hI1Rcu2KUZAzVgDhRfKGsoGfU42JO4C95xXOaGB/6yg7KFCSGqBCGUdbFR2BZLMhPg==
X-Received: by 2002:a5d:650f:0:b0:317:5eb8:b1c4 with SMTP id x15-20020a5d650f000000b003175eb8b1c4mr2436993wru.2.1692360955747;
        Fri, 18 Aug 2023 05:15:55 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d410d000000b003142e438e8csm2629268wrp.26.2023.08.18.05.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 05:15:55 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:15:53 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <ZN9g+dwZcqaX8hTO@nanopsycho>
References: <20230818115501.209945-1-justinlai0215@realtek.com>
 <20230818115501.209945-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818115501.209945-2-justinlai0215@realtek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Aug 18, 2023 at 01:55:00PM CEST, justinlai0215@realtek.com wrote:
V>This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
>applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
>
>Below is a simplified block diagram of the chip and its relevant interfaces.
>
>          *************************
>          *                       *
>          *  CPU network device   *
>          *    ____________       *
>          *   |            |      *
>          *   |  PCIE Host |      *
>          *************************
>                    ||
>                   PCIE
>                    ||
>  ****************************************
>  *          | PCIE Endpoint |           *
>  *          |---------------|           *
>  *              | GMAC |                *
>  *              |------|  Realtek       *
>  *                 ||   RTL90xx Series  *
>  *                 ||                   *
>  *    _____________||______________     *
>  *   |            |MAC|            |    *
>  *   |            |---|            |    *
>  *   |                             |    *
>  *   |     Ethernet Switch Core    |    *
>  *   |                             |    *
>  *   |  -----             -----    |    *
>  *   |  |MAC| ............|MAC|    |    *
>  *   |__|___|_____________|___|____|    *
>  *      |PHY| ............|PHY|         *
>  *      -----             -----         *
>  *********||****************||***********
>
>The block of the Realtek RTL90xx series is our entire chip architecture, the GMAC is connected to the switch core,
>and there is no PHY in between. In addition, this driver is mainly used to control GMAC, but does not control the switch core,
>so it is not the same as DSA.

[..]


>+
>+#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
>+
>+#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX
>+#define NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX

[..]

I see 3 essentials wrong from 10sec review:
1) You don't cc people who commented your previous versions
2) You don't respect 72cols for patch description text (checkpatch did
   warn you, didn't it?)
3) You are defining very odd macros like these 3

No need to read any longer... Really, can't you please ask someone who
knows to help you with the submission preparation? You are vasting
time of people :/
