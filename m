Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ACD7628F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGZC5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZC5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:57:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6771733
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:57:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4411384a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 19:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690340236; x=1690945036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzW/rGy0LH4fLap0MWB55Z1wHu6aT4al09wHOfF+Fkg=;
        b=Lx3RvL8PGnRpdj0gs5Nff7ZN5lTV1K2HUd8DXaOCVSlt00IXLloat8B9zWzAXj8gd7
         YN0go/qOiXHWOOqIkdMfr7Wd+MzLSf6z3DXj1efrB9MelA8ezROYuDZsFAF6yfGMOp76
         DpnfxX6QRJR6B1/00mAG7FntmlZ5qhRrOsM9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340236; x=1690945036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzW/rGy0LH4fLap0MWB55Z1wHu6aT4al09wHOfF+Fkg=;
        b=VzfKdyHxWo8/6XxVMfkEeY5M2IUrk4e1vkZEDPrxDd1p+i9BMUsAzUEDglRYX+Vmbc
         zq/6uptVDLsSwgl9xJ4EZwsfkiKT024QV+fBYkyrJ2c20zrtPDbXYdnbwI5AakU4xLoL
         QQ6bAvB6g/gzuX167xSZ0oVXeiDf3PkpmjQbKVKd38DVoWavoXKzk7OS7MTfQBue0HNV
         IN+UK97K1qrhnvu2sXflotyiPvFc88Re5C20dvwudajL645OPQtM92RjfYDjpuxsGajl
         EDPQgEx1Yd5ORMR9ROfMoGygc5N6YtMuT/g82n4PSSeXibVszem6hLhKV8P7Y36Asufv
         fd7A==
X-Gm-Message-State: ABy/qLZ53pplGAaOJ5bCtG7FHY+mzZgKxMhtl295gFBt3wfF7lzu4tG8
        uECkltCdoLqvjDTPe0wcOUNfCQ==
X-Google-Smtp-Source: APBJJlFUk0Z43kk1Az93vm7xK9BJbIOtVoFyjdZiRzE/WW3xC26bs5uXcxwhdbRPXvg8cpevnX5lgA==
X-Received: by 2002:a05:6a20:3d10:b0:133:71e4:c172 with SMTP id y16-20020a056a203d1000b0013371e4c172mr1061473pzi.15.1690340236429;
        Tue, 25 Jul 2023 19:57:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a2a4:d590:6375:66ba])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b001bb1f0605b2sm11726272pla.214.2023.07.25.19.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 19:57:16 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:57:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        wsd_upstream@mediatek.com, casper.li@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zsmalloc: Fix races between modifications of fullness
 and isolated
Message-ID: <20230726025711.GI955071@google.com>
References: <20230721063705.11455-1-andrew.yang@mediatek.com>
 <20230726023122.GH955071@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726023122.GH955071@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/26 11:31), Sergey Senozhatsky wrote:
> On (23/07/21 14:37), Andrew Yang wrote:
> > 
> > Since fullness and isolated share the same unsigned int,
> > modifications of them should be protected by the same lock.
> 
> Sorry, I don't think I follow. Can you please elaborate?
> What is fullness in this context?

Oh, my bad, so that's zspage's fullness:FULLNESS_BITS and
isolated:ISOLATED_BITS.  I somehow thought about something
very different (page isolated, not zspage isolated).
