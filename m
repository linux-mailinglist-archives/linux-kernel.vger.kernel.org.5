Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E576892B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjG3Wo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG3Wo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:44:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91924AB;
        Sun, 30 Jul 2023 15:44:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so2629113f8f.1;
        Sun, 30 Jul 2023 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690757096; x=1691361896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNIyjOmTuuTtM6Hs4Wl0S7V+TDvtLBJA22YFIc67fGQ=;
        b=pCKYNAtVhJhyCXv+kff/oTo4RPnZ6YZC1x2dpZFmXtzmfkPbTZbV2cCf9fKV1swcB1
         zs/QZPkaPncsaEmgTc4ufOzNRioThzi9qzRz67JWL/Dt7M5mSlsP/AXZ+aYu5r19jnzf
         6h6LStIOX6lCgWdARvcHFl0hHGDty00HF0heNF7d99BfT4kgu3t2M6gGkp2+Sav0nxfz
         HMLADHgDo7qA5C6Nl0PDuuokrjNJBHpO83lQ6evH+0BaJBjlvaCIypt5brEkGLE4wokX
         S1slhHDsndt9lmIBQuTIhUcq83aGgnvKVeLb0nNK4+ZaL/q7Y0h9mR+eYQqOErupA3jG
         XBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690757096; x=1691361896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNIyjOmTuuTtM6Hs4Wl0S7V+TDvtLBJA22YFIc67fGQ=;
        b=bHgZ7fE8+YItaTeqAku6+QhrXgpM0id8L8iVa2pnrRCTw8RqNJFHAQzzqKY/wnNG0X
         XtqoQqjw7jhhWPTggYuSh+f1DMFovZ29I8JUGZn33D3XOW99svrhh7xnrdgzPZs6Tc1d
         LPGBRG5KK50/mIId3gPH8TpA+hnv6nIoyhqQ019TPbbKorWFa/BffVYdsRfroXCUz7fi
         ENlvrJnPUgIQbbcpnEa8y3WTMfAoLodsJkiGezWMMcqp1aZLgwuX2iWBD0aCpkq5mEDz
         Hi71mr9Sow+kp8zGtTfZ6piH27uDTG602PbtYaOZ2yWWOXcyIdZnLlsanvTziyXK08G7
         sTug==
X-Gm-Message-State: ABy/qLblt2QTC85VTYMu22RPyPr0g9RLxs7TQkRQdEp9tvEEPaYDJtzd
        B09c3bmzba06RdEEWfr0o1I=
X-Google-Smtp-Source: APBJJlHw1jeS+xJWBIL/nyWLcB0ZhIIW/bfictAmlO5niGjSqN9npWkx4TmjjPzTsPctVXz4lFOW1A==
X-Received: by 2002:a5d:42c8:0:b0:317:597f:3aa6 with SMTP id t8-20020a5d42c8000000b00317597f3aa6mr8923586wrr.18.1690757095977;
        Sun, 30 Jul 2023 15:44:55 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id o3-20020adfe803000000b003143b7449ffsm7482062wrm.25.2023.07.30.15.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:44:55 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] clk: sunxi: sun9i-mmc: Use
 devm_platform_get_and_ioremap_resource()
Date:   Mon, 31 Jul 2023 00:44:54 +0200
Message-ID: <1936419.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 05. julij 2023 ob 08:53:01 CEST je Yangtao Li napisal(a):
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied, thanks!

Best regards,
Jernej


