Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFC7BA552
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbjJEQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjJEQNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF172526C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:35:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so214255166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696520114; x=1697124914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68bjcUX5hs6+inYPf70/vLT8wlDEox6QRQHbzrWGlAc=;
        b=mTSxzQm1JZgjz3DjXHXIIqEzC/IaByO+CxoVHLmFUCNz5rbPXcmaEveiuYYs+c8ss1
         Z6ELYzdEXMq/xIhpg1FH883yBKSbtGqJ11xyK4KkwDEf274utCVlgC34ElsrzGMeowOy
         PqOZJUavlzA21xXPFh3aFgBaW4cChm3+GpYhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520114; x=1697124914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68bjcUX5hs6+inYPf70/vLT8wlDEox6QRQHbzrWGlAc=;
        b=FwDcdZRES83BWt6K347GHH+8hPt+u55633KfCSlHp5StpoRQbbzChRDs07sIzFF9bY
         gcNxBClV4iNVXi9BszYqCkX8N6XgX3RiyD1lzshU1GdWoa/lcEAo1iOBVSCQpQjdq8Ua
         q3OdEtE22HrnJqYdNJRx4CS5ChtiOTj9R77mN8SytHlIg7lLnVdtqNl1l8F2Q80C2TpR
         RHh+Y8rWy6C2bL5Bl8XewNO0P4pxxS0AxB2bY/9dR3SROT5ymnU3bpqBBpUWxOydMZFh
         ryUbv/7NmCzGafpBdA7ZKYDKzcfOXcw5WBjnVkKWxWttJWAIUpZwH+M5pLilB7i1qS3Y
         Gr0w==
X-Gm-Message-State: AOJu0YxdtpHq0kETT1gkPN9bFsSWjUhvn3pyV2nbG+NsM+fjuCcEadgc
        JpdrgFeBsvFc2eK51npH5pWK96IKNrPQrahjSJ1gPHgh
X-Google-Smtp-Source: AGHT+IGszdeIPwMOZ7Ekg3HDU2xVrLHb7eUtF/Tbv9vi0WqipvSd00Wb3rbejFrSqoh6WuM8CZfu3Q==
X-Received: by 2002:a17:906:6a19:b0:9a5:a0c6:9e8e with SMTP id qw25-20020a1709066a1900b009a5a0c69e8emr6655160ejc.31.1696520113843;
        Thu, 05 Oct 2023 08:35:13 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709064a5200b0099bcdfff7cbsm1352844ejv.160.2023.10.05.08.35.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 08:35:13 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40662119cd0so81815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 08:35:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3414:b0:3f4:fb7:48d4 with SMTP id
 y20-20020a05600c341400b003f40fb748d4mr61209wmp.3.1696520112451; Thu, 05 Oct
 2023 08:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
 <ZRwJKBZaYwF1rrur@FVFF77S0Q05N> <CAD=FV=WASz1uvTgwsu3H3cTr3smHk+E_XNUVnjoPpttwv095rQ@mail.gmail.com>
 <ZRxCCZxZWCG0NBur@FVFF77S0Q05N> <CAD=FV=Xk-OMKQPXxU9Z9HOcWwUxxrmLZ4vD0u5ouZRW_zDFDPg@mail.gmail.com>
 <ZR03liCodnTQWs7s@FVFF77S0Q05N> <86jzs2ofqs.wl-maz@kernel.org>
 <CAD=FV=XasZR6dhKBjpbYfby4F1Nu_bsq1m_HP+NpufjsJi0COg@mail.gmail.com> <ZR6Pjk_3gpx1K3pF@FVFF77S0Q05N>
In-Reply-To: <ZR6Pjk_3gpx1K3pF@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Oct 2023 08:34:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VbxM-hftVKsp2JhQpnQm9u_H86rQbnucS5-x-q8j0QQA@mail.gmail.com>
Message-ID: <CAD=FV=VbxM-hftVKsp2JhQpnQm9u_H86rQbnucS5-x-q8j0QQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 5, 2023 at 3:27=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Wed, Oct 04, 2023 at 07:04:12AM -0700, Doug Anderson wrote:
> > On Wed, Oct 4, 2023 at 3:15=E2=80=AFAM Marc Zyngier <maz@kernel.org> wr=
ote:
> > >
> > > On Wed, 04 Oct 2023 10:59:50 +0100,
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > Given you haven't seen any issues, I suspect those are getting rese=
t to fixed
> > > > values that happens to work out for us, but it is a bit worrisome m=
ore
> > > > generally (e.g. the LPI case above).
> > >
> > > It is likely that these SoCs don't even have an ITS.
> >
> > Right. That was what we decided [1] when Marc pointed this out earlier.
> >
> > Overall: we know that this firmware behavior is not good but we're
> > stuck with it. :( At the very least, any new devices coming out will
> > have this fixed. Presumably if old devices are working OK enough today
> > (as long as you don't enable pseudo-NMI) then they can be made to keep
> > working?
> >
> > So circling back: what patch should we actually land?
>
> For now I'd prefer we took the patch I sent in:
>
>   https://lore.kernel.org/linux-arm-kernel/ZRr8r7XMoyDKaitd@FVFF77S0Q05N.=
cambridge.arm.com/
>
> ... as that leaves us no worse than before this series, and it's pretty s=
imple.

Sounds good to me!

Catalin / Will: Please yell if there's anything you need me to do.
Otherwise I'll assume you'll pick up Mark's patch instead of my patch
#1 and then you'll pick up my patch #2.


> > As of right now only pseudo-NMI is broken, but it would be good to make=
 sure
> > that if the kernel later adds other features that would be broken on th=
is
> > hardware that it gets handled properly...
>
> Going further than the above, I think there are three options here:
>
> 1) Complete fix: depend on a working firmware, and throw this workaround =
away.
>
>    IIUC from the above, that's not something you can commit to.

Right. We've landed the fix in the firmware branch for many of the
devices that had the issue but there's a whole process (and cost
involved) in getting this actually rolled out. Each unique board needs
to kick off a FW qual. Given that nothing is actually broken today
it's hard to justify a FW qual just for this, so we're left
piggybacking on the next reason for a FW qual (if there is one).
...even if we could kick them off all instantly, though, it's always
best not to rely on a FW fix, especially if (as in this case) it's to
keep us from crashing. There'll always be some case where someone
tries to boot a new OS with an old firmware. One such case can happen
when booting recovery images on ChromeOS where the device always boots
from the Read-only (not updatable) firmware.


> 2) Partial fix: have the kernel save/restore everything.
>
>    IIUC this is unpalatable.

Yeah, Marc already NAKed it.


> 3) Partial fix: make the ARM64_HAS_GIC_PRIO_MASKING cpucap depend on the
>    absence of a "mediatek,broken-save-restore-fw" property in the DT. I b=
elieve
>    we can check that in early_enable_pseudo_nmi() or can_use_gic_prioriti=
es().
>
>    That'll avoid potential issues if/when we change the priorities used f=
or
>    pNMI (which is something I've been looking at).
>
> I'm happy with (3) if Marc is.

Yeah, that seems best to me as a long term solution, too.

-Doug
