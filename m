Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44E078B37F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjH1Or1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjH1Oq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:46:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5E131
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c0c6d4d650so25886435ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693234010; x=1693838810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEYtr8V/fktSZTifRUB9ASx/4sFKcy6buk58qRmPz38=;
        b=ZlMeB4JgOYuCVRgsXeqFonPY8IbqVcg0WlOyM2FEn8psyI4ZndgkyeFdJUIcLX4sxi
         1EipQxeAbgjbhGie+/5gTPm9hASTTvC29zUd5U1pm1wvvwVwB6E4Zws9foVRayNuPBdt
         dPpM7CMLQ9CNARZAfT5hRjaBF+ETLnKdqMtHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234010; x=1693838810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEYtr8V/fktSZTifRUB9ASx/4sFKcy6buk58qRmPz38=;
        b=W+zzG+93GRaTKU4EVS+rcUs2raENUpFm8pcEf9acPE5xuXZ8N2k+O44d7LWKXmvk8q
         QyasEqt0c2XIK1yq/chFrvkEFKk64vJXC7fMEFg556LDuEwB6F33kUyjLCkVH7Pk0CGk
         c5N6M1OM/xytUUg4R0WeQNC9QJ48x3H+AQTEpZ+oyLYkKLRrMcXI+dQVA550opxs+qzK
         MaKPaU3IF1WugGifg2d52sc6FEyosBeml8psqXU5p35IOidTB0zAusTr3sa0IVO52srz
         PInJ+Xl6inRBgVk4JYIDQWIV2V9VaaKBOSqe0h0eY3btbgYlsxt/roh9TmyEUcCpUL4R
         fk8g==
X-Gm-Message-State: AOJu0YxHrrDurTASkszXgUVFSYDd0NZ4NUN3IYDE4sk6wzXF4HE4AB6t
        QzvHWHOUAT3NxdxEMtoSjkS4YOHG4xixsKB7elkJQw==
X-Google-Smtp-Source: AGHT+IG4zpabqadmwypRX1FvyZoPXaUiVEvAlDzyWO2H5OwtbLF1xQRBmEVyynF11+a3Cx9U5SYwazsp0+Fwwqol9NM=
X-Received: by 2002:a17:90b:2348:b0:268:e43a:dbfd with SMTP id
 ms8-20020a17090b234800b00268e43adbfdmr24068342pjb.1.1693234010758; Mon, 28
 Aug 2023 07:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230704153630.1591122-1-revest@chromium.org> <20230704153630.1591122-5-revest@chromium.org>
 <ZOtLWxokPxBCg0ao@arm.com>
In-Reply-To: <ZOtLWxokPxBCg0ao@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 28 Aug 2023 16:46:39 +0200
Message-ID: <CABRcYmLYiwDBK-sMQMcpjZEcLicoj2PyRmJrs5hB0EaTHzX1Vg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 3:10=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, Jul 04, 2023 at 05:36:28PM +0200, Florent Revest wrote:
> > @@ -2384,9 +2406,7 @@ static inline int prctl_get_mdwe(unsigned long ar=
g2, unsigned long arg3,
> >  {
> >       if (arg2 || arg3 || arg4 || arg5)
> >               return -EINVAL;
> > -
> > -     return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
> > -             PR_MDWE_REFUSE_EXEC_GAIN : 0;
> > +     return (int)get_current_mdwe();
>
> Nitpick: the type conversion should be handled by the compiler as
> prctl_get_mdwe() returns an int already.

Ah yes. Not sure why I added this one... :) thank you!
