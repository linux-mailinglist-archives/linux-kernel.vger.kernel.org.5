Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70F1812A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjLNITl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 03:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjLNITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:19:40 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52234CF;
        Thu, 14 Dec 2023 00:19:45 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e282ec7537so19738327b3.3;
        Thu, 14 Dec 2023 00:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541984; x=1703146784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPc9UucRRwQsPIIhSc+Zwo7ILNiT77DD2oaIHdq0gow=;
        b=UQcJlk4BFZT5PY4eB9mQRfnmL8/ivfAvE19crMWWde9REl0k6p0MAAQm2XlHIAikVA
         /Y0RoSGcYs2VVBeQLD8Gra23fZzVcB3FQ95HGfdqGngo93MD8S+67U4nzPze8vx0doFK
         Y3fKmwiMaK4hd+oYo200dENeZ+USRQH3IUK3WqkEUJOhaaLzlxclGVVwrrIwoYwlVGpj
         KVrJikumvziTDW4AziWjdErLlBEOEIpXJinvlbJd2iCJQhUOn9pr5RCa76KOttifJjZT
         NM6+l59207Op0Yt1OV+QxctQ2bwvac+QBrBQAkvb9/Ir7cLWrWmz5bmdG9BYwHQhPuzy
         ezAg==
X-Gm-Message-State: AOJu0Yylr2Dmgd59voaCC9VTflCb9ZoeplhvYfqP7ZJ5FuGIV18Oyja6
        evE0m+cy4LVcU0Vce0hKCTz0RSwmfYKRFQ==
X-Google-Smtp-Source: AGHT+IErLVuNeT51nq/c2ikhZIrEUHQnZF3mUanKftBOAb/zlWrmJqh8EG17RQcJ7dMDl27rx6PNuQ==
X-Received: by 2002:a0d:f9c6:0:b0:5d3:464d:18d0 with SMTP id j189-20020a0df9c6000000b005d3464d18d0mr6842189ywf.22.1702541983945;
        Thu, 14 Dec 2023 00:19:43 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x8-20020a814a08000000b005d3b4fce438sm5271562ywa.65.2023.12.14.00.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 00:19:43 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e2cfece112so14356677b3.2;
        Thu, 14 Dec 2023 00:19:43 -0800 (PST)
X-Received: by 2002:a81:6c4a:0:b0:5e3:6064:e394 with SMTP id
 h71-20020a816c4a000000b005e36064e394mr979772ywc.35.1702541983377; Thu, 14 Dec
 2023 00:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20231214074358.8711-1-wsa+renesas@sang-engineering.com> <20231214074358.8711-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20231214074358.8711-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Dec 2023 09:19:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW3wo5oaSpE5Pf7p6hg-njaQj1mvqwuVfEMc1YuZvisyQ@mail.gmail.com>
Message-ID: <CAMuHMdW3wo5oaSpE5Pf7p6hg-njaQj1mvqwuVfEMc1YuZvisyQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: rcar: add FastMode+ support for Gen4
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 8:44 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> To support FM+, we mainly need to turn the SMD constant into a parameter
> and set it accordingly. That also means we can finally fix SMD to our
> needs instead of bailing out. A sanity check for SMD then becomes a
> sanity check for 'x == 0'. After all that, activating the enable bit for
> FM+ is all we need to do. Tested with a Renesas Falcon board using R-Car
> V3U.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since v1:
>
> * rebased to 6.7-rc4
> * gained S4 specific handling from patch 1
> * keep SCL filters active for FM+ by still writing to CDF
> * if default SMD is too large, fix it instead of bailing out

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
