Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96F6758608
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGRUXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGRUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:23:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68364B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:23:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6db61f7f64so5941053276.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689711828; x=1692303828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaUDO+XAvGDEDxeBgdROw79oqHKS8ZVfSnHPWOLh4Ps=;
        b=sDhQPD6HRuU5a8LfR9o8IZ5FbsbSMdxLx3xiLb3amEp1fzUMS/hoUxUOOYP/YpYGSr
         u3AK/EBrpexE3IEu1DNoSqYfnD5gRdx5fIA8xItGURPEYR9JXu0gSePRPIpsfYUeLhbI
         gGbkdsIRD4oMocDTh1xEAxtZHjFOqLxdgevBunTBwC44ouraGQn+S8eL07qr7ANi6zZf
         cxmBaBl42pWpTVzoTuGqbCJ6x1At/eelI4NXzl4Q/by3Vi+JoGYU9gHfTyTPg7NYF9QE
         BfuHT/ri5lKAhenerLYMyobEAj/Vbc8Hkrat6xDxY0k556UjO0QU7N7TnXKhR89kskBu
         2+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689711828; x=1692303828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaUDO+XAvGDEDxeBgdROw79oqHKS8ZVfSnHPWOLh4Ps=;
        b=W+lfmRmecmS195fmh8OpJGfB/vViZZDGhGcVH8gMfWOIk2tcgLDepXAOHOIN4BuVjv
         9IFnMfuthqVUc6ikMBPAU7UyOqKmTuiRQz4EPQfh9aakEfw0rD7N4JXDXbNZ/SmrsWGc
         XNuyY9nFOo/Ntc5hPqUQuSgx20B6gaJg3dwSWsgXqJ5+XL1jFYXIUO5blPowGXYbBmw7
         NPpMaYutlNQq7BBPWLtaSb6JJ9MgS3Mg21InLcFnMrtq528Hicq/p35W0zrqEJIAXJ9y
         jajvYF+vbNloHheQrKQg+HOBYrNyIUJ3nn19syhs6YMctbxArWc4YwjnXJDkMj7UuJkq
         t2KA==
X-Gm-Message-State: ABy/qLYt8R0tmCpczlJkNqWISeopHzsRbmOuRFlrDjfZ+jj19NseVUYp
        tjqYSXngK5KRRXh4xMJMtG9VArM+xyJW02CjSQ==
X-Google-Smtp-Source: APBJJlFinVBlcCNroNPQAxsRWi6jlqX7JL4P4fZ1IpZxMBCLntEGWwQT1Qj2LwDDdPVantfjIQzbLLzphPqfFVFdSw==
X-Received: from yuxiao.svl.corp.google.com ([2620:15c:2a3:200:92bf:e2fa:ba2d:585f])
 (user=yuxiaozhang job=sendgmr) by 2002:a25:bfcd:0:b0:c00:3434:f639 with SMTP
 id q13-20020a25bfcd000000b00c003434f639mr6701ybm.1.1689711828713; Tue, 18 Jul
 2023 13:23:48 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:23:47 -0700
In-Reply-To: <20230630205358.3601280-1-yuxiaozhang@google.com>
Mime-Version: 1.0
References: <20230630205358.3601280-1-yuxiaozhang@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718202347.3320812-1-yuxiaozhang@google.com>
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozhang@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping, any update on this?
