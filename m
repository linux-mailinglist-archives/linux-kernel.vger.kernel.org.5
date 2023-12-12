Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B380E122
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbjLLB7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLB7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:59:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB36A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:59:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50be24167efso5919632e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702346377; x=1702951177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ89ZIrgto37G/xlhKf3Jw+2Aq+MN68zNYm03Mdawcg=;
        b=SB6BeEZho+ukE1MNuiXfqDu/LnWvFVInOnYiZkWvmggYv5PDycuHUF3XPgkLQ/r7Vy
         ftm6JaAGba6uqN2T646YLRZwn1b3hajmKLLi+JNKHZrKNHC2uH1c2Hx8sRa9N4YXmfUQ
         L5xlAE417xWxRmEp+IvK4rVnLOBSWemlmGHwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702346377; x=1702951177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ89ZIrgto37G/xlhKf3Jw+2Aq+MN68zNYm03Mdawcg=;
        b=YnI9ppdoH44rCNViZC0rdmFBSxrAaUjF8HZbJ6OYpbGw8WeyHrPpRKrj9H6IPksnA/
         wKavRt6WVduodU/VNW5OtUvGM+QYBvVI8XleqNwBMSVm5zsxSDvH/aPpUuVZw5jdBuqo
         YZVhrm7LQTmJUTUB0h3seXkSl2JRSZAFRjA+9JbfhsS74v2umdPIAc77M+rzvySf+mIj
         6KFKXBXSqLRIyvSd09f8S3FiNC4WiOBlPJFJA6Q+w63b0s6Ab5wjrp6awmlHagLn9A58
         ngTCDtR4SNfarfLHz81XQkVESIdaWA5j/EUk1efyiGsnAWuh+wvN9O4WYVf6SWQAA9qC
         hQ1w==
X-Gm-Message-State: AOJu0YzLRZEUMhpIvbfkE7N+hVshWilQeCsKKLe7sEBGGtfcDFAx2hbA
        /SX/IdwhY8rwZ5A6oytcoayYmsZYN3+ijxiIGJt3rw==
X-Google-Smtp-Source: AGHT+IFPkMwM+ODEL8jAac04JHQ1iWXAbY+dSF92QrVLp74yCwtnOhjG/2NaE3hAxNkItRtrSNp0Jef+ghFheIRqHhQ=
X-Received: by 2002:a05:6512:23a7:b0:50d:1a10:d27f with SMTP id
 c39-20020a05651223a700b0050d1a10d27fmr1444302lfv.201.1702346376180; Mon, 11
 Dec 2023 17:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <CAD=HUj5733eL9momi=V53njm85BQv_QkVrX92xReiq0_9JhqxQ@mail.gmail.com>
 <ZUEPn_nIoE-gLspp@google.com>
In-Reply-To: <ZUEPn_nIoE-gLspp@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 12 Dec 2023 10:59:25 +0900
Message-ID: <CAD=HUj5g9BoziHT5SbbZ1oFKv75UuXoo32x8DC3TYgLGZ6G_Bw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] KVM: allow mapping non-refcounted pages
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
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

On Tue, Oct 31, 2023 at 11:30=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, Oct 31, 2023, David Stevens wrote:
> > Sean, have you been waiting for a new patch series with responses to
> > Maxim's comments? I'm not really familiar with kernel contribution
> > etiquette, but I was hoping to get your feedback before spending the
> > time to put together another patch series.
>
> No, I'm working my way back toward it.  The guest_memfd series took prece=
dence
> over everything that I wasn't confident would land in 6.7, i.e. larger se=
ries
> effectively got put on the back burner.  Sorry :-(

Is this series something that may be able to make it into 6.8 or 6.9?

-David
