Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135C81360F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjLNQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443573AbjLNQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:20:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401E121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:20:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28aec2f2b74so1162238a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702570850; x=1703175650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=79GfLUa0xMatqK9z0JePPS7PR/6+NWr/zvH936PUut4=;
        b=l0DZzb17IQWERdrx6jzedry2WIMfb8k35YeV7kF52pw/nDgsk/A0BGuRWuOcqXW/rD
         lqSDY9cm4BdvmnKAhT7SNSPHHlEMzLOdN8Y5gmHafhuLPPEz9W0bNydOhe7Ehj9/HTqb
         b/7VRSGuYNC4Pp4/A8KKl0TBjPUdLae4zP9fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570850; x=1703175650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79GfLUa0xMatqK9z0JePPS7PR/6+NWr/zvH936PUut4=;
        b=gClKn1KJ1Fwh8sJyMp+2dtakbvrHGQn53PyBEX/kIOzJXkEU3QtqHfsztmLph3OCYQ
         KvCJVCDK16ZjSMxiaSNC+77Su36Q5UPbYOKl3bULmC7hBCrIxniH8aDat48Ps7dHAxWY
         xz4WMxvBaNuP8JG8Y0DGJDP1RbQ/xQtytzIEiDp8qZXdQOBxhakBUfmVOOeJBudnw86A
         AbPVOFQ9IealXkRxJ1CbtPsStSWXz4NbQvX7kY5ZHP9iVc6EelJrOS/g/AzwyBHf3BzR
         Re80WWj/m5sqesSg5n6gfJmgr8vuyKcGkoiTws/pUk88OKhdqO05AxEswL8YNiAiDzCQ
         R2hA==
X-Gm-Message-State: AOJu0YwrhT3F9qG7BcFHCOLar1c1qeKhV/ay/4ZyMZdI45XWfwbou3o9
        Y7H2zRs0QE+DKzVhMMQyBKQ79bGKi3674fKprug=
X-Google-Smtp-Source: AGHT+IEhI+QDxAaic/CLBtw+Zk3ZLQbTienw7Lr5nTBHffs68v9bR0Iv7kinrPvub6G8TOnFIQ6ZgQ==
X-Received: by 2002:a17:90a:fb4d:b0:28b:2519:4764 with SMTP id iq13-20020a17090afb4d00b0028b25194764mr42334pjb.44.1702570850749;
        Thu, 14 Dec 2023 08:20:50 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b0028b07d1f63csm1833557pjc.50.2023.12.14.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:20:50 -0800 (PST)
Date:   Thu, 14 Dec 2023 08:20:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     yang.guang5@zte.com.cn
Cc:     kherbst@redhat.com, jiang.xuexin@zte.com.cn,
        chen.haonan2@zte.com.cn, cgel.zte@gmail.com, lyude@redhat.com,
        dakr@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        bskeggs@redhat.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] drm/nouveau/disp: switch to use kmemdup()
 helper
Message-ID: <202312140820.EC1C6079F@keescook>
References: <202312142003220684160@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312142003220684160@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 08:03:22PM +0800, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use kmemdup() helper instead of open-coding to
> simplify the code.
> 
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>

Sure, good cleanup.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
