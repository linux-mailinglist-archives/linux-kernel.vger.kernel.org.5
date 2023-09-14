Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4041E7A058C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjINN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjINN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:27:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B191BEF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:27:01 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so14991761fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694698019; x=1695302819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltHqz7sJ0v4Q+i/Z4aqTT31SnmE06twy+6dA1CwyTLk=;
        b=rtZFztPw4h/mSEQGqUEa4pDAKZyf22VNuosysvFOrd/r2PHZMZ5+1DqDFyPyUNrkeM
         TMa3f5F5+h91ROod8sqGTGaqvZReTjIr71Vb/KLXR0cjszbq+40BC5RKs6nM+DJDgCuD
         QDZ0jidcCmZNiKnho+Yzetat3Rn1hpEg06fgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698019; x=1695302819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltHqz7sJ0v4Q+i/Z4aqTT31SnmE06twy+6dA1CwyTLk=;
        b=gtk2A9OnJUKfKfw9guWu61kHmTtbXKOfOBxHeRt3f6xg9BIuX2o+SdQuO48495H30F
         v2DI4gfSw6aHUrnfAiYCW0J/3ldshrQi12OVuQpa+wo8M8xzwlQh5pChtbokuyMa1VAD
         GLLWTfkBNIQaVP5pylLYrf1aQPYGxZ5bRsuCCGPYLPRS+krmDxVnuR1EwimMXx+zNTbl
         rq9Q+bKRsJnQvSLCzQmDzMxV9v2kckj9hfJimDPMyQ9HtHxI7iXe/7dIlALizLFw5kiL
         lND70ACl4zAPKIcfNlcySrBqL7FwhksnjQ0d0b5Uu5nW4TBeOBKzuiroiRDIkwCwaDAm
         9XRw==
X-Gm-Message-State: AOJu0YxnrlFb5oFX6qUy71j7iqSQ8iXIXGRd2C5JSAKmiX66DPNiRTVX
        aLe4Bc1cXzCCqd83K/o9NqKtavHv1hDkxj7FlMFzZA==
X-Google-Smtp-Source: AGHT+IGiJCk28LoPbESHsjLdhrJ0/gXo8cS0+4LSvHYL0id89l3yXfBskknMhP3BCFXXEOpLMcflSkrtQKNRVdE2N08=
X-Received: by 2002:a2e:8887:0:b0:2bd:1fee:aacb with SMTP id
 k7-20020a2e8887000000b002bd1feeaacbmr5319566lji.14.1694698019603; Thu, 14 Sep
 2023 06:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230912104406.312185-1-frederic@kernel.org> <20230912104406.312185-4-frederic@kernel.org>
 <CAEXW_YTwzK9jkUdMUPY0t++yYvwSHx1EZiPX6NiSt7hPhHZbpA@mail.gmail.com> <ZQLShD1ujiuqLiJI@lothringen>
In-Reply-To: <ZQLShD1ujiuqLiJI@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 14 Sep 2023 09:26:48 -0400
Message-ID: <CAEXW_YTh2mC-v2aqMjZBJGM28w6x2DgfMO_Ma_gvQeZa3q0P-A@mail.gmail.com>
Subject: Re: [PATCH 3/5] tick/nohz: Don't shutdown the lowres tick from itself
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, vineethrp@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 5:29=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> On Wed, Sep 13, 2023 at 09:17:21PM -0400, Joel Fernandes wrote:
> > On Tue, Sep 12, 2023 at 6:44=E2=80=AFAM Frederic Weisbecker <frederic@k=
ernel.org> wrote:
> > >
> > > In lowres dynticks mode, just like in highres dynticks mode, when the=
re
> > > is no tick to program in the future, the tick eventually gets
> > > deactivated either:
> > >
> > > * From the idle loop if in idle mode.
> > > * From the IRQ exit if in full dynticks mode.
> > >
> > > Therefore there is no need to deactivate it from the tick itself. Thi=
s
> > > just just brings more overhead in the idle tick path for no reason.
> > >
> > > Fixes: 62c1256d5447 ("timers/nohz: Switch to ONESHOT_STOPPED in the l=
ow-res handler when the tick is stopped")
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >
> > If on some weird hardware, say  ts->next_tick =3D KTIME_MAX but a
> > spurious timer interrupt went off and tick_nohz_handler() did get
> > called (yeah weird hypothetical situation), then in
> > tick_nohz_stop_tick() we might early return from:
> >
> > /* Skip reprogram of event if its not changed */
> > if (ts->tick_stopped && (expires =3D=3D ts->next_tick))
> >
> > without no "eventual" reprogramming.
> >
> > Maybe we should also reprogram with KTIME_MAX in such a situation?
> > Then we can get rid of it from tick_nohz_handler() for the common case
> > as you are doing.
> >
> > So for weird hardware, with this patch we are not doing an extra
> > tick_program_event(KTIME_MAX, 1); like Nick was doing. That makes me a
> > tad bit nervous.
>
> So when a tick happens, ts->next_tick is reset to 0 (in tick_sched_handle=
()).
> This way if a timer interrupt fires too early, and that includes also tim=
er
> interrupts when next_tick is KTIME_MAX, the timer is always reprogrammed =
upon
> the next idle loop iteration. So this shouldn't happen.

Ah you are right, I missed that. So then I am good with it:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
