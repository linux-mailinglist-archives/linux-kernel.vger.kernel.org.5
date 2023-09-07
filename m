Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01EC797BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbjIGSeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjIGSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:34:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1C135
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:33:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68becf931bfso1121944b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694111635; x=1694716435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcyxOSggFnT8Ic9CqC6qcF6Fq10Tfk/L3Y7hgvwEr3E=;
        b=fPK//GMZ7itxqIpCWKPNPJX0zq4Ehz6eGv6YLHUwWetPaJQdpmxixuFv/Y6rED+1h/
         NRK3yWj2eEFmUQ+UnVAhMuQQhVGlUxO7GfJq7H2PvFkymZd43Ke06i6mbecSOh0bA4wI
         ZMXm1Z5mBJilZllTqRmMR5wPcefJfI2TXrxq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111635; x=1694716435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcyxOSggFnT8Ic9CqC6qcF6Fq10Tfk/L3Y7hgvwEr3E=;
        b=IumPNprgOrUT1kZK2ScwP+pDW8guclcGWe9cxYEjg5VZuF9VwTs8roT5zusgkAQI6W
         Hnkz0Uv14pwp9hkFFIGqi09N8a2x06mWHFihKFaEjIj9WrgVCFi7SYufY2Te6sdxyueH
         tK9UJEGkk9xhpLwev/Wf6iHYjkJp9MREf4V+fT1VsVYOWOcPn4Fi3+QdxYuu+/HAjj5b
         fe640oK+3PezJ752T0epF7oteEmTnKAaR3ZjdDPZ/CvUhpSq4uZ2KzqJUzppjqyWSxYY
         rPR4oCzPvsl9LLpk3DEKRTXFt1EwZkPZjqC8QdZoMo0aaHjAOiuKtm9bXlOvgbtQl4ZC
         L/Yg==
X-Gm-Message-State: AOJu0YwYd8xGei/WMqO7ZaAZqq6Iv2iUE2LeX2LDsEQrM6zxrXcs2S4e
        TI15mLnnOvuY+Kp4REyyQnbNotO7U31XpQQ3WoYY+wbsABQMz0z5wz8=
X-Google-Smtp-Source: AGHT+IE1IQmuAu98wfTAfZnH2ci2ShqHzINUOMlkN2e6kVnLPzYtV/ukSH3+yRZnJP0M3HaXc8gD7QD57G7ei/fmKv0=
X-Received: by 2002:a05:6820:284:b0:573:7828:ce53 with SMTP id
 q4-20020a056820028400b005737828ce53mr17148380ood.4.1694077854745; Thu, 07 Sep
 2023 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230906102940.1120269-1-treapking@chromium.org>
In-Reply-To: <20230906102940.1120269-1-treapking@chromium.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Thu, 7 Sep 2023 11:10:44 +0200
Message-ID: <CABRiz0r8qHgx-4b7QdCj6iz9FDsyChznEHOn5eByVoUYuLa-PQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -       if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> -                    sizeof(bridge_tunnel_header))) ||
> -           (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> -                    sizeof(rfc1042_header)) &&
> -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
> -            ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
> +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <= skb->len &&

sizeof(*rx_pkt_hdr)?
