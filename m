Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0923A810ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378660AbjLMG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjLMG6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:58:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC9AD;
        Tue, 12 Dec 2023 22:58:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so5834663b3a.3;
        Tue, 12 Dec 2023 22:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702450709; x=1703055509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wic1P/RSwBSkJoPClk6Bjehh4w4WUsx8DSq4pkdR4QA=;
        b=JpYnycoSnjgMZiJ0KMb076P5lG5MHkaqj+OOR7tOsNoBdY3S6fJ642jw0PkaqPauyk
         TKlk3wmxwffeOn588n0P7y7NmzFMFeAi21ve5hz0eSfErU86weUhLGmnIDdx6VF3gVE+
         z7MIspRcLkJVG7Jv6EaDjzSikAHlZ6hqym1hAZTsUegy2kH6MhA/MaPGlgPn/Wp12kSV
         wBRLmqUvojifEHrfyXz+SndatXzSpH8hCn3R/HpvjLLsVtBQ7xoYQx1Ee86X3AOvt7uO
         mCQg/Eu8dklLzz2NuNGwHJD9DaNVKx0WY1UZV44cG8N08zhUik61WikFpebFHBaZL2v0
         MX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702450709; x=1703055509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wic1P/RSwBSkJoPClk6Bjehh4w4WUsx8DSq4pkdR4QA=;
        b=f9fwAQSk4kmXLwkyoh8r1Y0NjaJxeR6+bpNaNC9OHR6xjmLGrwSCBw2BYUZjY1WDii
         WmpVg/yGcFFYXh8AfQHj6hlQ1zMSyK2w6Vm6GdLFnTuNTgykVVsodTNUuGETQ9xBSPIp
         krZZOXT0KYGLdwykws2HwHYYF8qBDKqtNRMPfc5xeOJtrkhGK2smzvjYiymHm2tXN+Fd
         GUYZO8d+hNYfxx/CVKa5iWb6IizVjuN1Dptcn3omblvSNdSjUot4zHg9fpknHBXeyh7K
         cS4IbDG0+nCaR58bnUbT2udGMh/UgUs1q+wrcg9S+JioOpT/I5RqL/sfqRHuqBRzYMfI
         6t0g==
X-Gm-Message-State: AOJu0YywxlfwzLtFG/i3vkhNKj47P50X04T1lvkXlEOu0Q40HCRjYA3M
        YW2G1FJ7CPpFrnJpmhd8DQwD6VbaBrnh/A==
X-Google-Smtp-Source: AGHT+IFk+alYFBDVJfTQYeYs4nXlrKQy/RMeDDGPvzoGjogaZhEpHTCh0O+mN5tn70vUdzAC4dy65Q==
X-Received: by 2002:a62:ab19:0:b0:6ce:6cae:c284 with SMTP id p25-20020a62ab19000000b006ce6caec284mr7391722pff.61.1702450708905;
        Tue, 12 Dec 2023 22:58:28 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006ce70490445sm9224357pfv.85.2023.12.12.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:58:28 -0800 (PST)
Date:   Tue, 12 Dec 2023 22:58:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeff@labundy.com
Subject: Re: [PATCH] Input: Convert to use sysfs_emit_at() API
Message-ID: <ZXlWEqPz5t0hI3hy@google.com>
References: <202212071644171074630@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212071644171074630@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:44:17PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
