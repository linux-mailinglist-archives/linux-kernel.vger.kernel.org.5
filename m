Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C17A11EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjINXiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjINXiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:38:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD771FE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:38:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso1434490b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694734697; x=1695339497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QVyuGB/xvHjbsQ6Zy6WC5UERFVDAMx/lplVOWzlB7nk=;
        b=Bb1gd0oCn0kV4ULdPhXKK99PK8gVenpWGW9KDzmBileH9K41rHs1rZESe632EcuKPU
         EVjE2Jzv8r6n2pnoD6m6VHvQy9X1HjocaHkie1wJ6Fe+s9BiY1iwqhnvTNpZH0A8UAvZ
         +ftpp737dtCN7uk+jTlKhgI3zyvujzln3697Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734697; x=1695339497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVyuGB/xvHjbsQ6Zy6WC5UERFVDAMx/lplVOWzlB7nk=;
        b=Dz0imdCbYzx0FiNdP3BHo/zpZmTXA/2xEB6TnQrnpDNqwBn+z6XnFGlLlBnJxgtMdj
         QR7eeSLwMmeQggfSoXDbChl/VH39WoACZiADJcT/so4oQYSGFs5Puxm0ps82Ze3CIKBU
         FL9i6xvgTfXcNFK7taCNi7/pPO/YaFTRDayLvXwo8BIAOcSZAgoNAKc/troz3asYaeXk
         sjj5E+NBGn5BUaw2XfsJb8/RhIZc6ryl5KXTnSn5J9T/AsHTRIN7Kph6u0KibLjwgfzF
         NHPjrTGyeQlzV9c86vmG1mMKINE/It3YW1xJZ5NHURW2S6a58tThJKM6txf5aJqsaBwn
         VYkA==
X-Gm-Message-State: AOJu0YxkdkyvpDq5BpyThNxGqW4fhKX+kJOezg9P2+/+h6S+NbzIAiaE
        tQHwj6vnPsExF+lib7HD+Mbbzg==
X-Google-Smtp-Source: AGHT+IEavKprO9EKeotlIDh1wQtMwXnrWhscNhhuioVis4w+5F1efm6qbgrdiJJhGjthFuyMn0czcg==
X-Received: by 2002:a05:6a00:22d1:b0:68e:3772:4e40 with SMTP id f17-20020a056a0022d100b0068e37724e40mr135414pfj.3.1694734697224;
        Thu, 14 Sep 2023 16:38:17 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:79c3:9a77:bfee:9881])
        by smtp.gmail.com with UTF8SMTPSA id n21-20020aa79055000000b0068a54866ca8sm1796533pfo.134.2023.09.14.16.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 16:38:16 -0700 (PDT)
Date:   Thu, 14 Sep 2023 16:38:13 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Matthew Wang <matthewmwang@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix oob check condition in
 mwifiex_process_rx_packet
Message-ID: <ZQOZZZgHP2EeDNix@google.com>
References: <20230908104308.1546501-1-treapking@chromium.org>
 <ZQIcDWKrmgoPkwlN@google.com>
 <CAEXTbpc=QC6wC-W2VZCaRCp6rSpyNSsq5M6cxNcqAQxciNj0vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXTbpc=QC6wC-W2VZCaRCp6rSpyNSsq5M6cxNcqAQxciNj0vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:09:47PM +0800, Pin-yen Lin wrote:
> On Thu, Sep 14, 2023 at 4:31 AM Brian Norris <briannorris@chromium.org> wrote:
> > I'd appreciate another review/test from one of the others here
> > (Matthew?), even though I know y'all are already working together.

I'd still appreciate some comment here.

> > > -     if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
> > > -                  sizeof(bridge_tunnel_header))) ||
> > > -         (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
> > > -                  sizeof(rfc1042_header)) &&
> > > -          ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_AARP &&
> > > -          ntohs(rx_pkt_hdr->rfc1042_hdr.snap_type) != ETH_P_IPX)) {
> > > +     if (sizeof(*rx_pkt_hdr) + rx_pkt_off <= skb->len &&
> >
> > Are you sure you want this length check to fall back to the non-802.3
> > codepath? Isn't it an error to look like an 802.3 frame but to be too
> > small? I'd think we want to drop such packets, not process them as-is.
> 
> I did that because I saw other drivers (e.g., [1], [2]) use similar
> approaches, and I assumed that the rest of the pipeline will
> eventually drop it if the packet cannot be recognized. But, yes, we
> can just drop the packet here if it doesn't look good.
> 
> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/intersil/hostap/hostap_80211_rx.c#L1035
> [2]: https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/intel/ipw2x00/libipw_rx.c#L735

Hmm, I suppose. I'm frankly not sure how exactly all upper layers handle
this, but at least in a non-raw mode, we'll drop them. (We might be
delivering awfully weird packets to tcpdump though, but this is already
a weird situation, if it's such a weird-looking packet.)

> > If I'm correct, then this check should move inside the 'if' branch of
> > this if/else.
> 
> We can't simply move the check inside the if branch because the
> condition also checks rx_pkt_hdr->rfc1042_hdr.snap_type. Though, of
> course, it is doable by adding another `if` conditions.

Right.

I guess this is probably OK as-is:

Acked-by: Brian Norris <briannorris@chromium.org>
