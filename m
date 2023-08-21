Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA40D782995
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjHUMx5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjHUMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:53:56 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42DD1;
        Mon, 21 Aug 2023 05:53:52 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-58fba83feb0so20451947b3.3;
        Mon, 21 Aug 2023 05:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622431; x=1693227231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KBAyS2nelrV8Hc2Bh+9OdYb0ynFHCN4++LO/LB55WE=;
        b=aoQEY1bRpp8nvIOGGZJzmgC3VcEsjht2A0NeNuj69k8iPt0wEKlS+z+akybclMKkJh
         3zWh+SB1PI2EJZnwkaQkpZWvvyK1vEqielNQUW3HIaq1bTa+K8SxsRUURSIjOCeQKShx
         xi1xlg7rOrAPXpHhbEMSJb/xGJTOzzoGewsFLanBXujUdLxG+Z5BWBV60jkDpc7uRqjy
         xzBOtlso7IEFQ7eQNu5aN0252ywgfasPQ5ZbX4ha/gpQFuA8ayPMz4kfjPqKit1kZD5d
         9cAoRpZQE6BFonio7xtOF+UA0A97dTJgWJBsIDSiFlzfAYbr2gOkPJvBO+k2DTCc9azP
         KoDQ==
X-Gm-Message-State: AOJu0Yx/jKzMdA5UEyXSGpk4KHzMOQh9QBuCX7LAmx9f2sKXEsdpyhip
        5qaD+jFLim1yTkQtOZoPglqg1+Gix7y9Sw==
X-Google-Smtp-Source: AGHT+IFuHIxhGscqxoXClrtki7YWU7ILZuWq6nJe6qgU5ZJFG0fHy4Xx5ypYm/WreYx/wCKm88M+2A==
X-Received: by 2002:a0d:db56:0:b0:58c:93b0:17ba with SMTP id d83-20020a0ddb56000000b0058c93b017bamr5893384ywe.31.1692622431443;
        Mon, 21 Aug 2023 05:53:51 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id x186-20020a0deec3000000b00586108dd8f5sm2211699ywe.18.2023.08.21.05.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:53:51 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58fba83feb0so20451807b3.3;
        Mon, 21 Aug 2023 05:53:51 -0700 (PDT)
X-Received: by 2002:a25:238b:0:b0:d19:d73d:7956 with SMTP id
 j133-20020a25238b000000b00d19d73d7956mr5994381ybj.32.1692622430872; Mon, 21
 Aug 2023 05:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org> <20230801-dt-changeset-fixes-v3-4-5f0410e007dd@kernel.org>
In-Reply-To: <20230801-dt-changeset-fixes-v3-4-5f0410e007dd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Aug 2023 14:53:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvOTRBdYR=z1yp1_2j8dcazPaY-2E-MPaKeZut14hrLA@mail.gmail.com>
Message-ID: <CAMuHMdUvOTRBdYR=z1yp1_2j8dcazPaY-2E-MPaKeZut14hrLA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] of: dynamic: Fix race in getting old property when
 updating property
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your patch!

On Fri, Aug 18, 2023 at 10:41 PM Rob Herring <robh@kernel.org> wrote:
> __of_update_property() returns the existing property if there is one, but
> that value is never added to the changeset. Updates work because the
> existing property is also retrieved in of_changeset_action(), but that is

Perhaps s/is also retrieved/was also retrieved before/, as
of_overlay_apply() calls build_changeset() before
__of_changeset_apply_entries()?

> racy as of_changeset_action() doesn't hold any locks. The property could
> be changed before the changeset is applied.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
