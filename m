Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899079E3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjIMJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjIMJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:29:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440EDD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:29:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d7b79a4899bso5777141276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694597351; x=1695202151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+MFrQb049CZGpD5Zjrkdb/5Mi4AniQ9UI6VaAP+DKI=;
        b=nqobbugR0J71jJav4XvddP5C8S7awiekldJ/jzjRx4AKyl50wOWNzjflUI14AUFAIO
         NM36yEiaa1NpqZ+DcgBUF0JAjxW/OPyeSs6YtcchwUXDg7en7kZhoJIEqE9JhA4+yEwY
         ZxtDc+u8gZEO2lymribJBvOBKBLdcj+x07jWQbbblHp6mZVbwgcyMJRK0MERUMMVc29F
         f837xFMA4HZhlzc7VaLYVOOsRwkLo97BDf1mvnQkmfGb5BF2TwneSYG65etoN9hECm8R
         p1YjFYcl8Ag+7LRrnCCNNKXa2flTdYMII8ejoinlsqUS79+UxZ7GlriQfTxtvEMYkneH
         ekyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597351; x=1695202151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+MFrQb049CZGpD5Zjrkdb/5Mi4AniQ9UI6VaAP+DKI=;
        b=Jgs/CsY8fnxvTPmEVAlcYKGyXk5eQVgCjWR/azF18Y184op3SE/T9X3vmVGF/mt9RI
         FaMV7WVbuoAHNQlkhASosW5rXqfXzhqkFjLnSWN26eoBo7XYooH9B3qhc/xROauNehD7
         so5n413SQsTBqJEx6dpLNnyTclvd5hqFm+k/0ipz5TztzoY4Ck1LFqzeBC06occ0LAGo
         oq8f5/EPXmIR7vsNiHV2cjp5yzCXobvDFl3UjgMObCu7c1N7HJJWVrk5BAk8n4HN1Kt+
         xCnaqLwRrmwXHX7l61MMngswK1FjwzDQQiQ3BlFKmaHqRgK7F4XQUlTLCuVO8HCAH3Gv
         Aidg==
X-Gm-Message-State: AOJu0Yzzt1SkhKNJRIOqJBGxnJPmNW+k6r4/6i3cRJaIUSnPIMYgdyV1
        zdP9KTxjyCwHSnOyXQJ6bbOT86Bnc8fbztNNs92TtQ==
X-Google-Smtp-Source: AGHT+IGVYATgybqJdQWccuvKju5FLYK1upeu8sUATvMnSclQgqyxQgb2vhtl1TPyVBSLk/BEp3cBzJWvCfm+nCEdZeA=
X-Received: by 2002:a5b:982:0:b0:d78:341d:e475 with SMTP id
 c2-20020a5b0982000000b00d78341de475mr1702968ybq.44.1694597351319; Wed, 13 Sep
 2023 02:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230913065421.12615-1-juerg.haefliger@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 11:28:59 +0200
Message-ID: <CACRpkdaJd9PA96ryKnJbxotT_+sH-qKgOq=xJDQdXXwTvYBC0w@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible arrays
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        marcan@marcan.st, keescook@chromium.org, gustavoars@kernel.org,
        hdegoede@redhat.com, ryohei.kondo@cypress.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 8:54=E2=80=AFAM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:

> Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> 'element' and 'channel_list' will trigger warnings, so make them proper
> flexible arrays.
>
> False positive warnings were:
>
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm8=
0211/brcmfmac/cfg80211.c:6984:20
>   index 1 is out of range for type '__le32 [1]'
>
>   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm8=
0211/brcmfmac/cfg80211.c:1126:27
>   index 1 is out of range for type '__le16 [1]'
>
> for these lines of code:
>
>   6884  ch.chspec =3D (u16)le32_to_cpu(list->element[i]);
>
>   1126  params_le->channel_list[i] =3D cpu_to_le16(chanspec);
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Obviously the right solution, thanks for looking into this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
