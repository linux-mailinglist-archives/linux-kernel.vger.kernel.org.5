Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A987F265F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjKUHcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKUHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:32:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D867100
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:32:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so19226775e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700551920; x=1701156720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFtch3Nap710cpf4er7eW9cGVSpjM0L/7+OjaAxxZa8=;
        b=T/DYxps/BIIYLYvAVIBph/sN27dfJVCjpFYKz0VKEAPWkqDGvtDGlPClXah0iuupoF
         +0A+DdIsQwh9yAvQYpgFYbKmuQvdeMrJCV7LDQVQKsQ8rx3r0yueMa3TrClSkGDfV5Wu
         YEycnUTRDSl8DozHEmqJVvTfIpV08HL8lSrM7572IlV9S+Pg1foTeKnNDHljgYykAkVd
         kYI0U+MPsE0KC+UDqavMNSbqfxiupO1vwU386u42EIxIMV3287/7FsqNlTew275RV3pl
         GwUbHrq8gD1fMVcS2hVUAEAAI3Vl4X9C0Mn92UIfX6h3L/KHFvr8Xd1qW/ROnnazO8kx
         PWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700551920; x=1701156720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFtch3Nap710cpf4er7eW9cGVSpjM0L/7+OjaAxxZa8=;
        b=wUAqDGgCg6jDlLa67pSRHqGnAQAdBluEPVnoBDBASo8MehMgTyrgBhJWkNe/r5eYRR
         LZ2NeAf+OezJnMZTGiVHOgxlloLCyK9PLMBIEGbZ/RPPK0m1NY93ZGEbUNwEdwJnSwBO
         G0Qe/4J0dT+XXiSUNSMBdRW/sez+OD8HftsYF/9+Hu0jFQDA++wbKziOJpgXo6E+4s6n
         WaZ0PHWU1Wrfp9kprr8bprEtLX0OLlH5awecOXYy1XUZvPVj5SLQKQtqlHLhNsHGBIZU
         cuPYEhyHSYO3Y6a2GHg8gbCmQQ+kv/wsIgLQe0Rq+YmC9MZRpmG5APLyJOHLadN3xuwY
         q0Tg==
X-Gm-Message-State: AOJu0YxrQd1kA81QT8aOImIKRgu0KxOFFAicvykz139KOEzaAwR1ICuR
        xSxlxB0+uE649ZXGyogULBHpj29PAyUsJBTF2hw=
X-Google-Smtp-Source: AGHT+IEzsgomKk4nfW00c6Ga9yeFtrm6C6dS4SdxymDIFlffCn3x55AEMbIKPQCO4+8GI6yjSgHbhw==
X-Received: by 2002:a5d:64e1:0:b0:332:cf3d:a041 with SMTP id g1-20020a5d64e1000000b00332cf3da041mr177747wri.8.1700551919385;
        Mon, 20 Nov 2023 23:31:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b00331a55d3875sm9435549wrb.38.2023.11.20.23.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:31:59 -0800 (PST)
Date:   Tue, 21 Nov 2023 02:31:56 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] staging: rtl8192e: IS_DOT11D_ENABLE() returns
 always false
Message-ID: <d911d509-8677-444c-ad7f-92dd141e8e1e@suswa.mountain>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

