Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE57D7EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjJZIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344676AbjJZIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65408183
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698310163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2H+EMeMg/1Fs19heJFc8GaaunsyixJ8rWAna5sIJER0=;
        b=FKaw2HvzzjA5kQ6DoV+U2yU/M4hsNXqnFJdiE8jhzT5V9EeHUTRHuAphrUKeHFq9YdXP0n
        l+BiyfCl4rEw8ULswVe2dVNcjZxLBNGAt65EiNVsfuvZaoDEohaYJNnee8vasnKhstnj6K
        jyGbSXGY9bP4MSQBfHGo2fXK5kw7ifA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-TNNBxl2zM46jW7YV1qRjxQ-1; Thu, 26 Oct 2023 04:49:22 -0400
X-MC-Unique: TNNBxl2zM46jW7YV1qRjxQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c167384046so3099066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698310161; x=1698914961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2H+EMeMg/1Fs19heJFc8GaaunsyixJ8rWAna5sIJER0=;
        b=LTgp5INXP1jZ72ILsJRMhTF7F1smoSRm8uiZvqNXthBE8jG2dKSmtqamWcRX7tbfr8
         nAVbEsyNtHjU2NnlzkO90qp/MFBwYBJ5T96GdTmD6KzoDWxeL2gIQ3arDlL0zSfn52NQ
         A87pU8lQaIh0lz7KZuV0bwnmeO3XAkhghV8sx/5P4hUkO0EFtMDrHanoBM/TmP1fxLuC
         sGHP1atpQ02+H3QPuRpkPljwwh2zLzQYz+yf32gkC6eAH1OzYijWAavN7PjaP8VYIMEG
         zZewrKuSASva4AGNk/f2+mWxB3W5P67i46aMVoSqxxIlU6AynANKvDRPsNwSgZXIRs4y
         znag==
X-Gm-Message-State: AOJu0Ywas1wv+JNBehADWeNWH2Bt2a4GdrYiZMDyEx78QusAg/8TnTVG
        i+7X6GEcvatcKyR2Npy6hR+iIFrKJlabhbwefqwBgCI7S0yr9OTkYINQiNqoNEvTJJLWYz3dIoI
        xgYWLEqES+bHHuaLV8IFQ9BygRjrvfY5U
X-Received: by 2002:a17:906:59a5:b0:9cb:798f:91e8 with SMTP id m37-20020a17090659a500b009cb798f91e8mr6042911ejs.6.1698310161027;
        Thu, 26 Oct 2023 01:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZsbE+cQ3LMb4ECdoxZfpuUbiYD6x9nJTxK6ZQbe8zyNDpdTDVELuBDambmmxEsjCFgbEOag==
X-Received: by 2002:a17:906:59a5:b0:9cb:798f:91e8 with SMTP id m37-20020a17090659a500b009cb798f91e8mr6042893ejs.6.1698310160621;
        Thu, 26 Oct 2023 01:49:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-52.dyn.eolo.it. [146.241.245.52])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709062dcd00b009ae54585aebsm11319511eji.89.2023.10.26.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 01:49:20 -0700 (PDT)
Message-ID: <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
From:   Paolo Abeni <pabeni@redhat.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        kernel@pengutronix.de
Date:   Thu, 26 Oct 2023 10:49:18 +0200
In-Reply-To: <20231026070310.GY3359458@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
         <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
         <20231026070310.GY3359458@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 09:03 +0200, Sascha Hauer wrote:
> On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
> > On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> > > It can happen that a socket sends the remaining data at close() time.
> > > With io_uring and KTLS it can happen that sk_stream_wait_memory() bai=
ls
> > > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> > > current task. This flag has been set in io_req_normal_work_add() by
> > > calling task_work_add().
> > >=20
> > > It seems signal_pending() is too broad, so this patch replaces it wit=
h
> > > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
> >=20
> > This looks dangerous, at best. Other possible legit users setting
> > TIF_NOTIFY_SIGNAL will be broken.
> >=20
> > Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?
>=20
> I don't have an idea how io_run_task_work() comes into play here, but it
> seems it already clears TIF_NOTIFY_SIGNAL:
>=20
> static inline int io_run_task_work(void)
> {
>         /*
>          * Always check-and-clear the task_work notification signal. With=
 how
>          * signaling works for task_work, we can find it set with nothing=
 to
>          * run. We need to clear it for that case, like get_signal() does=
.
>          */
>         if (test_thread_flag(TIF_NOTIFY_SIGNAL))
>                 clear_notify_signal();
> 	...
> }

I see, io_run_task_work() is too late, sk_stream_wait_memory() is
already woken up.

I still think this patch is unsafe. What about explicitly handling the
restart in tls_sw_release_resources_tx() ? The main point is that such
function is called by inet_release() and the latter can't be re-
started.

Cheers,

Paolo

