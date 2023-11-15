Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2067EC00F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjKOKAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjKOJ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:59:44 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0400D44
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:10 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so6553771276.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700042350; x=1700647150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMYbJ2pYyOF1bQRIseaOIgNKpTkxL2DUlV+Adcdxow0=;
        b=RrLiRV+F5TKUSeWyyD7BgqiwEFAcdNAMot6tUi/wm3wOKKCKwfGMUhPMWaupE0GsEt
         W2TxZgIrnh5k0frUnB+6eeWdjQ2He1h6RfE52T9eMJ7mtInxw0YQh49M3/OaKUshio0k
         2r1GKhIsuH3SWEo90k4hauylgWU24iWkYF5YIYjB1ps7C8/2j/9YxvigGj5rszOoqza2
         olbx6Y23QAVEbwWF7ejTot7wwrUZYWUQq67l+dIUOBGOfPXbXxQjATAAYLXz2Xko6w97
         ma519hHrtQjGjQhbAWd6KUHFtb9IINh0ocVWnMRvKdan6TvNAaenVN7WYIJ2Yw89ESUJ
         rh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700042350; x=1700647150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMYbJ2pYyOF1bQRIseaOIgNKpTkxL2DUlV+Adcdxow0=;
        b=RW7jxsfcVc1cUZpTOniS3JwqPEvTX7ha3MNmiGKtJGpNxzNLqlIuGZYoiYlo954B76
         hHLLTFdvuU5nTSnbV2z2l8z8rk1LAq3YA7zglbXhqe+51bjjcd6gsnzLrVTvsZPQPl8v
         FAMx7964Rav/ttET08wLRaxzE0ClWdYUKEy3irMnE43tTONQZoegiYlr8tJ5t6qUpC5s
         5W8pKyuj3bVL259fHSsOONUhZD3be8BOR9mHY1zXBB0UkB3oAQ7ZyBnHeTn3I+uZxyWF
         WDoOjnvbg2kJFz7rRaatSDmWq/0a5AkcWiNZ7te6++W6Wuoqjo6c9qV7ahH5WzFnIY3W
         1BDA==
X-Gm-Message-State: AOJu0YzaeOW00AHMUwWA8d5btKgbUdN/Wm97W3JMOk+2Mj7ip3KkxkP1
        KfGA+Q45OPwhlb1d0LKlgysoBNxYEL5yj+SPAZKPsg==
X-Google-Smtp-Source: AGHT+IFIi2V7s4Jk14pZAM7pqhWmLZYA7ebEMthP/5WmyIYDlMdlE/vDv+mOO97GJHHKq2nsoZVf3yhHI/ZXUDn1P7M=
X-Received: by 2002:a25:3d81:0:b0:da3:b814:2500 with SMTP id
 k123-20020a253d81000000b00da3b8142500mr11637353yba.18.1700042349793; Wed, 15
 Nov 2023 01:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20231115010906.35357-1-quic_aiquny@quicinc.com>
In-Reply-To: <20231115010906.35357-1-quic_aiquny@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Nov 2023 10:58:58 +0100
Message-ID: <CACRpkdbmw=goFFiSYOC4_ybiHiiBJJqmVv2Gh=v5nuTnQ1Z1Gg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: avoid reload of p state in list iteration
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maria,

On Wed, Nov 15, 2023 at 2:13=E2=80=AFAM Maria Yu <quic_aiquny@quicinc.com> =
wrote:

> When in the list_for_each_entry iteration, reload of p->state->settings
> with a local setting from old_state will makes the list iteration in a
> infinite loop.
> The typical issue happened, it will frequently have printk message like:
>   "not freeing pin xx (xxx) as part of deactivating group xxx - it is
> already used for some other setting".
> This is a compiler-dependent problem, one instance was got using Clang
> version 10.0 plus arm64 architecture.
>
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> Cc: stable@vger.kernel.org

Thanks, very much to the point.

Can you please send a v3 and add the info Andy requested too,
and I will apply it!

Yours,
Linus Walleij
