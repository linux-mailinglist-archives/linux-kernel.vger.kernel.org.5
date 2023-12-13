Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204A810EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377845AbjLMKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377968AbjLMKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:51:22 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B22111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:51:28 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67ab16c38caso43702006d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702464688; x=1703069488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsRX4OChLjIi43OniRoBz0jKL2cIX50vjKJWm+IfNkg=;
        b=HiV/TA4Y2ZVntbDB7i+K2E9FxKszVZzIfl/mynW/dhKrlAfl/7vfTdBHXIaMa2vldp
         RKsPUm/jVHz8APKy/yYtGGRdjtZ9OozyQj2IbmgCcJWFVrbYedC0MB9SDB9yGAvtVcXG
         mxgh2vH7i9KQkAuCBNP9+fkAN+qKPykxDs9XS9GhMK4tAtKyMlT3VQ8qfbFQt3SFT6Fc
         /4Jxv4clJq+kOD647L0NCFxrwftoPD0UfZaKbeiSjWjQoQ0Lyb10+QLE6p23XN+tSjwc
         S2RFJW4GeZfB0M1trIcTfteHWCICl6aFLhQHSUfr9pzwetXwQvA/XYwzLFp/lWopoSGB
         iUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464688; x=1703069488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsRX4OChLjIi43OniRoBz0jKL2cIX50vjKJWm+IfNkg=;
        b=ZhJa975vopH3fIIAhBDB9o0RjOsmLfgsAw/YPQ0/pSOMYwyVe+STYqUmIwXdeiUR+K
         Qo9IQ3HQaextb4LLh4pJAwQ4ssooalV94U/SFGcMrcDrArYh32qwuILxOUPU1kBs6HkZ
         VxkVPse0LRI7twF3RVnOpwHotapm51FwLSfUiV+XuAV4WEBEdIeEidycEKwcCuNLZaAD
         k2uLDL97qCR0gDoP7b8R0C0jSjtGMGGFnQZMEDzcCqpxUq8NDJc7OlAQcCDBXmTsYSOy
         rvai5kaAmD9q5sUpTcVp7y9xzsJKutXYoIiF6xiWgjOAhwV68PByVWVo+Na40exeSsrj
         BKmA==
X-Gm-Message-State: AOJu0Yxg8bVI26D516FNDanT0c0lhaemQy6LHrVJxn4FZDr4TIZUzvht
        GfOP5kMEal0GWYlqje7BQRxYhDBqER5Np2JUTXBCNg==
X-Google-Smtp-Source: AGHT+IFjgwPpHwzbvxbC3Tisbj77ZSIg/pKABb/74yh5X1y4ErdCCfythI2bN3xslqJOop8lR67H7T1SPck2ziqINEA=
X-Received: by 2002:a05:6214:5606:b0:67e:cf4b:4071 with SMTP id
 mg6-20020a056214560600b0067ecf4b4071mr5725767qvb.49.1702464687697; Wed, 13
 Dec 2023 02:51:27 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f66a3005fa578223@google.com> <20231213104950.1587730-1-glider@google.com>
In-Reply-To: <20231213104950.1587730-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 13 Dec 2023 11:50:50 +0100
Message-ID: <CAG_fn=XDZehsCQbTfKjjBuan9=ri74n6AtXDg-Q9nbzYskVc4Q@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
To:     syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
        dchinner@redhat.com
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

On Wed, Dec 13, 2023 at 11:49=E2=80=AFAM Alexander Potapenko <glider@google=
.com> wrote:
>
> Hi Christoph, Dave,
>
> The repro provided by Xingwei indeed works.
(the mentioned repro is at
https://lore.kernel.org/all/CABOYnLzjtGnP35qE3VVyiu_mawizPtiugFATSaWwmdL1w+=
pqWA@mail.gmail.com/)
