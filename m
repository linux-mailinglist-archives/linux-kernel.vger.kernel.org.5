Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209177FC3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjK1SxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjK1SxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:53:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F01BC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:53:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so29944095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701197605; x=1701802405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHog2PoF+PrI2ROThVE0vCKLJ47MxbzQfCwNy5d6t08=;
        b=IWvLOS+onzppotWn1wA0SS7ke6LTU0oQ/AKMEG0On0Rr7WtEbj3D/0ZAc12HVlekDl
         7SRZU5ovX1wONW3fWtsk0atTrjRqXfPIcmMw4jBtLJ5GyW2rts43MgFxdUbW/GbeRBiK
         zDXFA11sU9kxx9WK+F5JweiE56O66VkE7eezZBs1a4W7fOwM/oqk/B4aSkBcTgH0gsXO
         gsPhpDSG00x7PUr0T1ZqI1alOrE04YmG1MW2S+nisgLoHPN7OX07WG+ndaAbNzo35wrF
         SuKhhef6DcEOtCMJVm169rsp7Ra9jRYoDFyTas3LagQMOru8pwXzHhwLGGUD3PnrLHNX
         FUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701197605; x=1701802405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHog2PoF+PrI2ROThVE0vCKLJ47MxbzQfCwNy5d6t08=;
        b=Tbk/wtCqVMsyCpwp/FVTA+r7nGWXgL+n6qk5J6QUwMl6xUnkdoVBF4B22K+s11l04t
         U6LDMUE5IiKdb+272ZwiyXci8BGsMyldSIED4s2NbfKr3hlF+/H7kDPH7y6BRystjno5
         5AnZE3RcgfeUrCT6xNoVPdg33qwLyw/ncAAwoRYXQh8yKsDyKm7kLOjAe6lmS/lW5ARt
         UoIkOQGudcxjH1BKw0kdbGfIEGYflCZVXCGxAK/HLgYabsxJt0JUbfLl6fT56nG26UDz
         lKstpMGqz3vlQLheEWVlZFSCtSDWKVjo++cAjRlPdBTxo1XqWOwN7dj7cC9g95lpW5Aw
         sGpA==
X-Gm-Message-State: AOJu0YzZIC8Kow+aq2bTqLmKOARgw9CYNx4blsIh0r57BMJKfvVDVYBl
        AOmOYHz72jSBU16+SG2koDfzEOyHuSBJ1uOMyyHIQQ==
X-Google-Smtp-Source: AGHT+IEQGVz0XCq3tzX/XQMDDIf2TV1S2jWs5RJaMNm2tBGDFtKdXoxwgJ2TgLm29KWYAv0mW+7nKSqfB9vozofENNw=
X-Received: by 2002:a5d:4f03:0:b0:31a:d4e4:4f63 with SMTP id
 c3-20020a5d4f03000000b0031ad4e44f63mr9772881wru.18.1701197605305; Tue, 28 Nov
 2023 10:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20231127220047.2199234-1-royluo@google.com> <2023112827-repent-broadband-e557@gregkh>
In-Reply-To: <2023112827-repent-broadband-e557@gregkh>
From:   Roy Luo <royluo@google.com>
Date:   Tue, 28 Nov 2023 10:52:49 -0800
Message-ID: <CA+zupgxfxaB_bO51ZXW+5T3-FMF94=Tm+mqZ92LCYBZtwiQd3A@mail.gmail.com>
Subject: Re: [PATCH v2] USB: gadget: core: adjust uevent timing on gadget unbind
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:00=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.

I don't see a need for this patch to go into stable kernels after
reviewing Documentation/process/stable-kernel-rules.rst, please let me
know if you think otherwise.

Thanks,
Roy
