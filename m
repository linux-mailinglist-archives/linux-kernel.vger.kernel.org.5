Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E57810AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378681AbjLMG5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378655AbjLMG5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:57:50 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B343AD;
        Tue, 12 Dec 2023 22:57:57 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58dd3528497so4074728eaf.3;
        Tue, 12 Dec 2023 22:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702450676; x=1703055476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0x8XsR4YAwwo97TrAM/5YN28oe0YmORax7Uew12g+YI=;
        b=IqLkmP5gF3V+D0swjuf1jkFdcPmGpsnrBVrUJdalFnDUd9wqORSy67NDYBtrhJ7msX
         Qu2j6UDbfjNkgg+lO0+AWlZbQA0J1UsQNmCbVvzzAmMUbvqW5lQI4CJqBLXmgVH1VDVm
         Br8E+nv9wlgzvFSBETnxcFCmgIRUnsb9tBaNev3GEWg5nUcOMCl7iDf4xnq7LGWMRAcc
         QiQXzDeVWL+jvWeoArdBCVlfz+ZEAmRcfVNFZEu+rSwXEi7AKBJYJ+hewiBeHH+E70+p
         cA1QA6W84bmVrQly46IbJHrS/XpB9Atk4j1xg3i6uoDxedFfWYG6mLf7FTq2M+r1wLSQ
         xlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702450676; x=1703055476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x8XsR4YAwwo97TrAM/5YN28oe0YmORax7Uew12g+YI=;
        b=rpnAU+q/H/UlJXfG8rCnkOMrcVmbOiE49h5fmpeL5QMcBOjhGz6UgJtAdO5Bpj+bEV
         xaJ6L6A1xqh4xMvKl1woQB+XD6VMRDpGpHEvulcw7wDb8qYfED9PdlU/lt7jkRxspMxs
         i7yAlLjIkZF0nZyVfiSnnbU6Ky0JGqGCZahBOu3oiM5DQXgn1LiDBmXWsw24sC5/7VW8
         oj5K4M1WLPoBqyR9C8uahdTRhOtBwBDAFXUTw/QN6qYF+iSdqSfNPiNrMJsRtsPXB2tb
         zPShCjpxceKGRpjoNtoVM1AuC1GOLW8kbO8SnrzeIWENkPhZD3mCopO0fVeLLIGTh1X/
         BMsg==
X-Gm-Message-State: AOJu0YzLtdQhCmKG72pw1EnieeddZ6zQKxSeXsi5/rTqlEhyrPEBxWZ1
        Q6XMkvPBEUA3GTRHp7polWw=
X-Google-Smtp-Source: AGHT+IElKzhtzSCEhBL3bROQSWht+atWFoSQ0f+N73GnAQYYmg3rf9EZTvLg30skzzknESxlSgmRDw==
X-Received: by 2002:a05:6358:7248:b0:172:93c5:5913 with SMTP id i8-20020a056358724800b0017293c55913mr19150rwa.48.1702450676288;
        Tue, 12 Dec 2023 22:57:56 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902759500b001d326103500sm4477635pll.277.2023.12.12.22.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:57:55 -0800 (PST)
Date:   Tue, 12 Dec 2023 22:57:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeff@labundy.com
Subject: Re: [PATCH v2] Input: rmi4: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <ZXlV8Wzss77JLeH8@google.com>
References: <202212021504062431427@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212021504062431427@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 03:04:06PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
