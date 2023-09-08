Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125667985CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbjIHKZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbjIHKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:25:13 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B21BFC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:24:43 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-572a7141434so1037126eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694168629; x=1694773429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DfAHPe/yZCXK6Ipx6KCp+2nRJ597fetZ8tOP8x/Y3eI=;
        b=RW7hdYqGQpjDkk3wX60XLgI92w6fqhyAw1bNRxHxw5FyMsCk2J+lGsjonR12jhoSqf
         RlAdCCf6zxYoWProgfHvAcYasA/IEV9FyY0vdYAUU/jaMfSYr5v11IDWf48fzZnze9ke
         MnLeFiFdd+QXLRwYnRwVV72mJ46oSqUm0eaLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168629; x=1694773429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfAHPe/yZCXK6Ipx6KCp+2nRJ597fetZ8tOP8x/Y3eI=;
        b=xJLlsjCV36Q9c+woNI1TrdAP/QFD1Ov8d+ztGC3sPBqGxavAnVjsYK7mjFxGzAfMzj
         zBWuvZmBXzV0qoB4pUbHmE3MCivpGL+MZI7PT8Jrsi+oxEd+b57sHpjBaY8J26aK5sVY
         KZoVvhi+1kKs6gTZF/lnbvNRuDsoSSF5Fs8rkW2AKhd4kUNymYGwCyKU5QqZzxXc7LZw
         MNG2s/aPr+GaKlLrJCcsyuOn3XnGGsTnhfnjx4ulpP4F+vvQpI7TGEtOVnpEtCNWENrW
         HQj1bJQBMd1QBkUcObAlyKo1hYBa1/7G6Ohs2424M10caypf76A1KwCNCAW+DCYt6Yr7
         BVwA==
X-Gm-Message-State: AOJu0YwACzBjWxmrdCF+3KUeiU5WKE0NDY5V+WNed+u0+aRT6PsU5AUr
        D+xS6NLmwCTSe4v4X/8uggdezcSKB3Kp8H+pLcAW7HIQcft2y2Dz
X-Google-Smtp-Source: AGHT+IEcsmWOaMN0sex/8VHBoGvhpIIwF11+aTivlfQzaWl3/Ih0CLNR8jF84J+DLODiKgcCnMCvalnsR/9BmpX0bTQ=
X-Received: by 2002:a05:6820:2296:b0:56e:a1d3:747e with SMTP id
 ck22-20020a056820229600b0056ea1d3747emr997434oob.6.1694168628939; Fri, 08 Sep
 2023 03:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230907093927.400634-1-treapking@chromium.org>
In-Reply-To: <20230907093927.400634-1-treapking@chromium.org>
From:   Matthew Wang <matthewmwang@chromium.org>
Date:   Fri, 8 Sep 2023 12:23:38 +0200
Message-ID: <CABRiz0q9TjryfNs8m6czuExWRCpXiVYw0K7kW62r+jstBAm2Lw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Polaris Pi <pinkperfect2021@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +       if (sizeof(rx_pkt_hdr) + rx_pkt_off <= skb->len &&

Not fixed. Did you accidentally resend the same patch?
