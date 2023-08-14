Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F198B77B8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHNMqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjHNMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:46:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A28E5D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3180fd48489so3488883f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692017174; x=1692621974;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6yw+XBIE9/REIBBvFAe5sVlUZd6t4HnAxmJFaso1i4=;
        b=S77h37MdfrU0+uCMRE2QSMfHgyJh4/cMbN9E3OCLUZBjmCoE66XkBPTm43+cLIRXNu
         YUgd/B8nrEHvJKS37ZLk6A3d9Huw91uRzhaPau8wSNzLi/cHqVchpzyHrmOX71GCSR6H
         LCN7pjA8Lavy+MipUXGsg5TeKZN18Axi180Kt0TJL/cW8obI6ESFBeTL3SDR7oPLqvBS
         rXGntm737FnUK7LCQk/WYpudjob54S2LM6ct4rgkVlO3YK3WulLpDGjtmeQfoHJXPJPh
         jfUUEqGNptIH4QZ6cQMZ72wRLQPqPFCdWV9bJ6/aZ4ZI7lXnGopfbr0xez/1jTyjQdB6
         pocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017174; x=1692621974;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6yw+XBIE9/REIBBvFAe5sVlUZd6t4HnAxmJFaso1i4=;
        b=Mkqe+uYLW3MDhARUy9IG8OrmFjyafAcYpNswJcZsPXGXSmgslFJBBcZ0cGcCKkbjrd
         /1zvuuQfvZ1qGwy0CFADBYnfoAfpmlXs004hfs2wrJy8FTnJkVZR+X1GiI3wsl9XLEoK
         wz3ffqxVDT9tzAbVNBqAbt4HMAPjnX0weYiFQa5nCpmUjrXDWrIZFsDFIf4DTiOBGuc7
         ZUU5DFy1OPxPIRBiIFUw2x3VqIqWFtlH4NKxsWoHiUzQlau+TQ1vZLBp2MqvPxklxmFk
         LGq79hRSHGY/GzkvgVYD3iR/jjKN543CxCZfZyfFFoWObEIX5u/wgkmfls5BzWB0xN7S
         ESzA==
X-Gm-Message-State: AOJu0Yxt5UIuefnO2rxHjcnV+XqfaFsNB78a/yjsyq1ry2G7R2NIxp5+
        XhvSmv9QGp4X1v+cv1AJfsYSdEZWb6pWUBprBVVkWQ==
X-Google-Smtp-Source: AGHT+IFXuZoZok0PogyHoeGg4IURmaLD7MMyshcsbQemPgFJZDeOiYelAyVrf1QaJCCFCVTTcpNKUg==
X-Received: by 2002:a5d:5309:0:b0:313:e57b:e96d with SMTP id e9-20020a5d5309000000b00313e57be96dmr6074259wrv.36.1692017174465;
        Mon, 14 Aug 2023 05:46:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm14249506wrr.32.2023.08.14.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:46:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Heidelberg <david@ixit.cz>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230812183404.374718-1-david@ixit.cz>
References: <20230812183404.374718-1-david@ixit.cz>
Subject: Re: [PATCH] drm/panel: JDI LT070ME05000 drop broken link
Message-Id: <169201717354.1374248.2742017075159670711.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 14:46:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 12 Aug 2023 20:34:03 +0200, David Heidelberg wrote:
> Link is no longer functional and web.archive.org doesn't provide PDF
> with detail information.
> 
> Some informations can be found from web.archive.org here:
> https://web.archive.org/web/20170629205602/http://panelone.net/en/7-0-inch/JDI_LT070ME05000_7.0_inch-datasheet
> 
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/panel: JDI LT070ME05000 drop broken link
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d19859a042668277d79f8df0165ed75011f11e6d

-- 
Neil

