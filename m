Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1637F373C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjKUUYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:24:03 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A9C191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:23:59 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so80946591fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700598236; x=1701203036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDVfUt3nV/fPKQAH9Uyx3Am8VhgQpdnyu+ywO2Er6HQ=;
        b=ZtKiBLsEiq4lox67HIB3uf7cowX7Hnwd4mNNBj2hI5XfWBrFaN/dyxyIzLNKJWmIte
         qP2x4Eu39Zxw2MqA2nt4jXqYwtSvDUpRXzqsGtBeDePeCn1tTkkPlIqEKkzp0se/OWbf
         n+W9fjDra+zhUP9l9Jxzp75uKiJVUPvK4FjeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598236; x=1701203036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDVfUt3nV/fPKQAH9Uyx3Am8VhgQpdnyu+ywO2Er6HQ=;
        b=gZPdk3l7le0FIG3RjRu2e709XyXebg59Dxt0uuxEscQbByaR3n3Si6MAZJLoqMN1d/
         cMhqyhmlbaasguj8hdMZZEFrM4MAY5TH67+Mak/BZixGxPKBlidmAcqyu623zfNCpSUr
         2mgQ5rcbFQpnSmmHsr0VrX/5+zXQZmAF2fTJI4KRaMbRQEECE/vLDsOxVXb+JXNfkTA8
         6O4o9bmazV8fo73wtH4sYdH9R3frfZx+k+EhIh4QIrZ0GQrUMUiRpkMWIJoM3l00OOxC
         dT15iswjHYO6/Za4qFOJDBg7ZW2TeFiX5kzYUGJPXVysDvK6c5pSKsvwxmoOMRaFDhtj
         agUQ==
X-Gm-Message-State: AOJu0YznHqttoBk0ehXzpP+pHMIIVtadQ/Ly8XEcJstGg+5U8Z+L12do
        qu027QOt2wAVqPdKi0RJvEb8D52d8SiFha6EXYv/aA==
X-Google-Smtp-Source: AGHT+IEuKj6w+Dv29ac2pUeeMmwlT/AZVcjYIP4S9TtytZ2s3QZt9zlGZdQBtj1+Dx6Ypvs+48t+ocDGCduXZCrXsJU=
X-Received: by 2002:a05:651c:1990:b0:2c5:1045:71cb with SMTP id
 bx16-20020a05651c199000b002c5104571cbmr201792ljb.32.1700598236283; Tue, 21
 Nov 2023 12:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
 <fbcf0fee-b97d-8f47-9df4-44bc1b475144@redhat.com>
In-Reply-To: <fbcf0fee-b97d-8f47-9df4-44bc1b475144@redhat.com>
From:   Jonathan Denose <jdenose@chromium.org>
Date:   Tue, 21 Nov 2023 14:23:45 -0600
Message-ID: <CALNJtpUH_0+ETa+7MfKRbpc_c1TTTasUrZ4zA4V9EHb_BtAUwg@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Takashi Iwai <tiwai@suse.de>,
        Werner Sembach <wse@tuxedocomputers.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On Tue, Sep 26, 2023 at 5:37=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 9/25/23 23:33, Jonathan Denose wrote:
> > The ThinkPad T14 Gen 1 touchpad works fine except that clicking
> > and dragging by tapping the touchpad or depressing the touchpad
> > do not work. Disabling PNP for controller setting discovery enables
> > click and drag without negatively impacting other touchpad features.
> >
> > Signed-off-by: Jonathan Denose <jdenose@google.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Regards,
>
> Hans

I just wanted to double check that I haven't missed anything, has this
patch been applied yet?

Best,
Jonathan
