Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000907C945D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjJNLiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 07:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5BB83
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697283483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7OKQnwlDTZH7fc4ejRpfuY4K+3qj8VyeLuTkuv/YT4=;
        b=iiuDQj3JLRln0M8GzeuKyDwPDwTYMkQ+yWc95NhTa6Pst+fuLMgA6FAUswP2pwBt245KcY
        5QcMDRXKpSNeiBxb4pl/GpN+kdcZpC23OeDoMgb14rw8mKVLkl5kiqa2Tm7hEhJ4TfWlxJ
        lifquPdHrCvc1XGwbDSpESdaetF3uFA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-n6mgSbeuNs2BXYL6CyK9gQ-1; Sat, 14 Oct 2023 07:37:57 -0400
X-MC-Unique: n6mgSbeuNs2BXYL6CyK9gQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-503177646d2so2681863e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 04:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697283475; x=1697888275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7OKQnwlDTZH7fc4ejRpfuY4K+3qj8VyeLuTkuv/YT4=;
        b=ZrE6AG/sJqH90Q/qB/gLOpQJrXXbCYM8E8YT24dwKLSdXIFMTxlpvsH5A2IHWpOwr+
         jhyldsDx51IwLP3Ox2HSowF7omkDtFwyqXQH+3nlqcgxCeT1KpRh/S8TlMNpR8bLGZaY
         Q05yJyGVt10D+5b+dbWrCXL4D+aZvXxqUckRLPI3Hr1+pv5inu77UVxMVlYx9AWfu3F6
         D0ZdyLMaZkLQT/BKAWEFoTNJUSEokBBmtSEYm6xqw8OGO0T9209e2QMjX8QaVnt9NxEn
         C9w2sjDGSCyaF6F/npKHkbKz2/xbNeY1T89UpcG8azCw1prYRyBSo79TKORmkhrkug8+
         OPVQ==
X-Gm-Message-State: AOJu0YydpD8pDeQ6POmYG22/W+YYdBAEq3XKIyAkENfBY2e8Ri1pW9E6
        YhdF89xzBRTQFbIt34jwG52YCh6GuiIc0YhmVdsyu9nZJnbYRyIe0DMueBCaNSdibK4tWkMmFng
        2RKEHZKEXr/lXNwhLe25DuoovzgCcZYDGoAsyiBmv
X-Received: by 2002:a05:6512:32d1:b0:500:c292:e44e with SMTP id f17-20020a05651232d100b00500c292e44emr28662168lfg.54.1697283475650;
        Sat, 14 Oct 2023 04:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUFtQ6aw9XDovPqLFwY8Aolbb7Mfxyb/ninQMxSK4uIoJcgAKOlzcZJRVXLp7OZ8LMV+1Ilz7gTIWednQhLPc=
X-Received: by 2002:a05:6512:32d1:b0:500:c292:e44e with SMTP id
 f17-20020a05651232d100b00500c292e44emr28662154lfg.54.1697283475322; Sat, 14
 Oct 2023 04:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
 <20231010-upstream-net-next-20231006-mptcp-ynl-v1-4-18dd117e8f50@kernel.org> <20231013172823.GR29570@kernel.org>
In-Reply-To: <20231013172823.GR29570@kernel.org>
From:   Davide Caratti <dcaratti@redhat.com>
Date:   Sat, 14 Oct 2023 13:37:43 +0200
Message-ID: <CAKa-r6uYbhF3zZrDaZdCE1fo4A8WF0MHNGmLS21fh11WcSfqOg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] uapi: mptcp: use header file generated from
 YAML spec
To:     Simon Horman <horms@kernel.org>
Cc:     Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Simon, thanks for reading!

On Fri, Oct 13, 2023 at 7:30=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Oct 10, 2023 at 09:21:45PM +0200, Matthieu Baerts wrote:
> > From: Davide Caratti <dcaratti@redhat.com>
> >
> > generated with:
> >
> >  $ ./tools/net/ynl/ynl-gen-c.py --mode uapi \
> >  > --spec Documentation/netlink/specs/mptcp.yaml \
> >  > --header -o include/uapi/linux/mptcp_pm.h

[...]

> > +/**
> > + * enum mptcp_event_type
>
> Hi Davide and Matthieu,
>
> I understand that is autogenerated.
> But it is missing an entry here for @MPTCP_EVENT_UNSPEC.
> Can that be addressed somehow?

probably it just needs
    doc: unused event

in the YAML file, I will add it and regenerate the uAPI header
--=20
davide

