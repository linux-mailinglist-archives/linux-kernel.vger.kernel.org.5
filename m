Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673E379C24A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjILCIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbjILCF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:05:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0B15CEF9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:01:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4721055f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694476778; x=1695081578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUB9pQ99asoGOgqvxmkpQIQ255CUSXO571C6qXV5/QY=;
        b=WMV5hymgd87S6rLSfV8HEs+tcpinmQD0AiouaKTcCGJeDk1rsR6D3QUnGTtCWu6RSM
         O6gW0m6doc5XSOtZtVOiUpKdeWo4Tf0YueogdShyLHPA0MmArZBJ+X3feydWC0T5PnNF
         aS8GgE5awhiQyofcfSw6KtM2ZkKY8QEgIZt8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694476778; x=1695081578;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUB9pQ99asoGOgqvxmkpQIQ255CUSXO571C6qXV5/QY=;
        b=nmvekISlFkZfcD5JNU6q850IuZbUOGC4KcE92YRDJiL9zPSNOINZDIBUx/e98aKASi
         Uj4yMrTwI+KUUaq33QLORxyLulgcGeOjVHI1di1QBA62oM/VASwy4VrdfDgOiSqCHWyC
         3GfjSLrli0qoQPhzTu9520NF+/JboXELvS/kSMiauwJnJuNwoKMZdFGwtqG/X756P6NX
         hoJylBpY2fxCiBZezwfLc1IIC8Vdj99HXuAXSyrWKwW/VS1TGHRd9JLt8So5VWMUrxG8
         m5sxJFjvKoK51dIKR4PQJAkMRV1DFfLeQMnD9UBOVJzk+Uc/F1QWg78Gjw5pSPx4xfpP
         /BSQ==
X-Gm-Message-State: AOJu0YxCrq7a9+ISNI5aQ+0aS6QnaYcDyerNbJL0bUBWJNfrvNzgSSEA
        9u66tfuLzjdcw41kVsCv7icbX0h2Nak8eyh3uBWz/4VtwBx88A5q
X-Google-Smtp-Source: AGHT+IHTfh2/l5NDrFmzs478pSCg3HnYRUxWfxEhRfh3L6QE0nsgCzAHcDa28aBNjuW3dNSDxWds+sBGbPakrgojpHI=
X-Received: by 2002:a2e:321a:0:b0:2bb:a28b:58e1 with SMTP id
 y26-20020a2e321a000000b002bba28b58e1mr8678269ljy.41.1694468510418; Mon, 11
 Sep 2023 14:41:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Sep 2023 14:41:49 -0700
MIME-Version: 1.0
In-Reply-To: <ZP+D4hlUXhAboFBJ@smile.fi.intel.com>
References: <20230911193937.302552-1-swboyd@chromium.org> <20230911193937.302552-2-swboyd@chromium.org>
 <ZP+D4hlUXhAboFBJ@smile.fi.intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 11 Sep 2023 14:41:49 -0700
Message-ID: <CAE-0n52Rs05Grmno5g9YPdDS-nwJuSk0dvbg8SF1D52XJczPCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2023-09-11 14:17:22)
> On Mon, Sep 11, 2023 at 12:39:33PM -0700, Stephen Boyd wrote:
> > It's possible for the polling loop in busy_loop() to get scheduled away
> > for a long time.
> >
> >   status = ipc_read_status(scu); // status = IPC_STATUS_BUSY
> >   <long time scheduled away>
> >   if (!(status & IPC_STATUS_BUSY))
> >
> > If this happens, then the status bit could change while the task is
> > scheduled away and this function would never read the status again after
> > timing out. Instead, the function will return -ETIMEDOUT when it's
> > possible that scheduling didn't work out and the status bit was cleared.
> > Bit polling code should always check the bit being polled one more time
> > after the timeout in case this happens.
> >
> > Fix this by reading the status once more after the while loop breaks.
> > The read_poll_timeout() macro implements all of this, and it is
> > shorter, so use that macro here to consolidate code and fix this.
> >
> > There were some concerns with using read_poll_timeout() because it uses
> > timekeeping, and timekeeping isn't running early on or during the late
> > stages of system suspend or early stages of system resume, but an audit
> > of the code concluded that this code isn't called during those times so
> > it is safe to use the macro.
>
> ...
>
> > +     err = read_poll_timeout(ipc_read_status, status, !(status & IPC_STATUS_BUSY),
> > +                             100, jiffies_to_usecs(IPC_TIMEOUT), false, scu);
>
> Since "false" you probably can utilize readx_poll_timeout().
>

You mean 'addr' will be 'scu'? Ok.
