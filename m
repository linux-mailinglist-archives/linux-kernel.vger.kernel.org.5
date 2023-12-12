Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0B480E252
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbjLLCuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLCuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:50:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90358AD;
        Mon, 11 Dec 2023 18:50:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0b2752dc6so45447915ad.3;
        Mon, 11 Dec 2023 18:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702349423; x=1702954223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5wKOiCgqswdmnAE+7GTByJH/L22v0TKX6Ot3bMlqWs=;
        b=D5Fkcq6lLgkYpR2n3TGxEpX8CyGrJ48HOymhkJwVZzlX0DFTPM8DY4gwS4PRuaZDVx
         zPrn8mJ6qPeSKdX1UFrh6CTRO6nStm/kyHPfGYSbelo1CP3vSgbCekHX8+mhargJWoVj
         h+g6mCA09LZOSys/pwu+IGVqaHkdsIvviSfRsyGn8dfhTOSD1mo+kLm3rPbC9VloJoEV
         fvFJIO75Jn9YkffpNKnKwkY/klZ1oSurQ/ApayM/Q7LaKsgxnM8ZJILlE6KwEekuKCey
         2CX0ui2RBY+kHB5kXNpiZxNx1N4Qll+broESwoQBrlsOfBpn1R172oX16ZuVIMxKo+3V
         0q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702349423; x=1702954223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5wKOiCgqswdmnAE+7GTByJH/L22v0TKX6Ot3bMlqWs=;
        b=VphMqxHcwIKTBQmeEXW5bOu8dsWqaYTm7uclozXch1lJB0tzy075nJ2dtnfbcnqSZa
         26FJ4/ht/uWaoytGFfoH0Bk5QosnOgl30Rzt9813MKq9mV3K51/FeMsc6dfPkgDm4nGF
         41z/ileQYL84AjfhRTyFAWn2uFcRdZMsDNpmC5J68Dl662x1Px7AB4poUx2X/ANMTb8P
         CP7P1V+Kosk5yoVV/Hjf4800+NpLZ3yB9Z7l1KPt3y9ChXtcHf2eTJeEYuwoUM6OOyoL
         9v0JlP7p1NZg4J1KAqsm6lKv94dxjoUR4ETy4jxXkdRlNDYNSllBkNEAUJjsAq7BkDup
         dNKg==
X-Gm-Message-State: AOJu0Yz17CIPtgshF7P/8KW7E+ua2hnimeBGWoHwZEmtrdIOPJAOFiQi
        c8x9uGrkNHfTwt9PZES6qb8J+YkCfPbW5w==
X-Google-Smtp-Source: AGHT+IHZNi5dCKJ59opPtFzEyCZt2GcAMbOQONIBrgmAJOj06J3uNAoDVaL19FQTCvoYrB8RxekVuw==
X-Received: by 2002:a17:903:2791:b0:1d0:6ffd:9e30 with SMTP id jw17-20020a170903279100b001d06ffd9e30mr5493893plb.130.1702349422865;
        Mon, 11 Dec 2023 18:50:22 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:46e0:3920:a552:71cb])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001cfc15993efsm7408879plg.163.2023.12.11.18.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:50:22 -0800 (PST)
Date:   Mon, 11 Dec 2023 18:50:19 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan.Cameron@huawei.com, tony@atomide.com, robh@kernel.org,
        frank.li@vivo.com, u.kleine-koenig@pengutronix.de,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: omap4-keypad: react on keypresses if device is
 runtime-suspended
Message-ID: <ZXfKa_LjCgvskb99@google.com>
References: <20231211221757.517427-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211221757.517427-1-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:17:57PM +0100, Andreas Kemnade wrote:
> According to SWPU235AB, table 26-6, fclk is required to generate events
> at least on OMAP4460, so keep fclk enabled all the time the device
> is opened.
> 
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Applied, thank you.

-- 
Dmitry
