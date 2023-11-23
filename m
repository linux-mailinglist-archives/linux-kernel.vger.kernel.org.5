Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBBA7F6455
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjKWQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73A10CF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700757946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBjBl6RiMXteiisXslLo0Yh7FdmVurXCHqt4qx72G+0=;
        b=T0xeNeGuHgM8oAlBSepRjy1ujklJTSYE94ThpaOy0gwyq4ff1HBrNVqeqphSknIdlgnWxC
        q02i4eTgwI0DpI6kq7VbhlWso+NE3SXIge2rh30ZY6FznOD8ArJW+0HFG+uA9vmCINGRBQ
        HTwfr8NUx0CB3D2DVvOEqRvMQc8PgAU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-8BE8i8UINf-mxL4MfJZroQ-1; Thu, 23 Nov 2023 11:45:42 -0500
X-MC-Unique: 8BE8i8UINf-mxL4MfJZroQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a0009a87651so67136266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757941; x=1701362741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBjBl6RiMXteiisXslLo0Yh7FdmVurXCHqt4qx72G+0=;
        b=Ug7WHeT0VLb9lYp3MPE6OkkcwEBZT2pgPJNmtigbMAwTSyzvET0YLJr2FKx+8pT1q/
         QpIFJqFyI88rlr99vz3aUbmCyUM5AwZsKRBbM8sVaXfMFf/2no7DEJl/mrkvKf02W7NI
         VV5QkMILbMCgjWz48oZmHifcCk7O6UasCqqmYcY2+uXejHtJGvWSxYctziTB6tYHC6aU
         QbJIxrfSFYNP3KFV6RuLfJKAMUG+6Z74mplogWnSXy1qB+KhNnbhHndfVZh58Ik6boLs
         2Sm63mjX2mUfQXyhBl3+hSG8Zq8zxrS2U56sjOVI5XnF6sI7nLDymEoC3PpSNj0R3Jgc
         suQw==
X-Gm-Message-State: AOJu0Yxdfkog3Y7N2pN9NPahZCnIlLEqNiWvJtBVJ7jNanvfCMOrJak7
        /4J9vNAyjXIKaZHhkCZmf0/sg+pRtzBkdq4qm40Zpu/eq4a4qL0yrooB88hqnrmTmR1zDrivr+h
        8tEF1YEZJd2NpKemFujiBLN5ZAu4muMoIURxUW3VE
X-Received: by 2002:a17:906:14d:b0:9e0:5d5c:aa6d with SMTP id 13-20020a170906014d00b009e05d5caa6dmr4276176ejh.20.1700757941728;
        Thu, 23 Nov 2023 08:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfaOoZK8ZVUHRmRcmkEFqZf7x8Mab1KDGr4SWVV+OmpRRd1SIVYmQoomns8qprSr9GXpfGYdGZr2ToP/DcJ7w=
X-Received: by 2002:a17:906:14d:b0:9e0:5d5c:aa6d with SMTP id
 13-20020a170906014d00b009e05d5caa6dmr4276162ejh.20.1700757941494; Thu, 23 Nov
 2023 08:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com>
 <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com> <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
In-Reply-To: <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
From:   Valentin Schneider <vschneid@redhat.com>
Date:   Thu, 23 Nov 2023 17:45:29 +0100
Message-ID: <CAD235PTyEce0S-22vg=opQdq0MUwEovdx5henU=9Mwh3Rf8QrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To:     Eric Dumazet <edumazet@google.com>
Cc:     dccp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 17:32, Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Nov 23, 2023 at 3:34=E2=80=AFPM Valentin Schneider <vschneid@redh=
at.com> wrote:
> > I thought that was already the case, per inet_twsk_hashdance():
> >
> > /* tw_refcnt is set to 3 because we have :
> >  * - one reference for bhash chain.
> >  * - one reference for ehash chain.
> >  * - one reference for timer.
> >
> > and
> >
> > tw_timer_handler()
> > `\
> >   inet_twsk_kill()
> >   `\
> >     inet_twsk_put()
> >
> > So AFAICT, after we go through the hashdance, there's a reference on
> > tw_refcnt held by the tw_timer.
> > inet_twsk_deschedule_put() can race with arming the timer, but it only
> > calls inet_twsk_kill() if the timer
> > was already armed & has been deleted, so there's no risk of calling it
> > twice... If I got it right :-)
> >
>
> Again, I think you missed some details.
>
> I am OOO for a few days, I do not have time to elaborate.
>
> You will need to properly track active timer by elevating
> tw->tw_refcnt, or I guarantee something wrong will happen.
>

Gotcha, let me dig into this then!

