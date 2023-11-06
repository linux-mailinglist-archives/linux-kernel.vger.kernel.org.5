Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727EA7E1F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjKFK7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjKFK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:59:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D0C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699268390; x=1730804390;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ksxX8ZB2iKJNhHr74r8TAgFTpDQHldOBy0SCsgxL9iI=;
  b=ROFre+cG9KJTiNNt7QencBPIb1TZsV8tdiXbxCvig60j8C2vEQjPmDR9
   OZsGeTHNbNRxuVHPGNPEXaklxh4nrxvLv0TRcxSUdbrbyPdjdNsMxw3eL
   LBsJpm4fDtTOZ5rXmF5EjJatVHo/IUyhbJ2P6iZIVlhPgkMb20iyJd9P1
   qaBcF7eg+gEEeFPaVPoNjo5oRgQCpj09v8VZGIoMVs/sJGHPijfakIBEw
   8MQ/O4cJIlwNzZsjZe3jTVLFIungJ67euaacy90gbq3dfqeSX3wsARRaP
   9rk7lvZ10JKNB/0ig5zEzXm/TremMiZrt+M6AsMSgEjZ60BsREDC2gpzj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="455735079"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="455735079"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="755817188"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="755817188"
Received: from lpilolli-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.222])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:59:46 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
In-Reply-To: <ze5xz52jt4helttcmntzmr6fr4ohu7wtslywalbxc4w7w6uvly@nwweqyyl4wf2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231101212604.1636517-1-hsinyi@chromium.org>
 <20231101212604.1636517-4-hsinyi@chromium.org>
 <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
 <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com>
 <ze5xz52jt4helttcmntzmr6fr4ohu7wtslywalbxc4w7w6uvly@nwweqyyl4wf2>
Date:   Mon, 06 Nov 2023 12:59:43 +0200
Message-ID: <87v8afywo0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> On Thu, Nov 02, 2023 at 07:33:48AM -0700, Doug Anderson wrote:
>> Hi,
>>=20
>> On Wed, Nov 1, 2023 at 11:31=E2=80=AFPM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>> >
>> > On Wed, 1 Nov 2023 at 23:26, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>> > >
>> > > If a non generic edp-panel is under aux-bus, the mode read from edid=
 would
>> > > still be selected as preferred and results in multiple preferred mod=
es,
>> > > which is ambiguous.
>> > >
>> > > If a hard-coded mode is present, unset the preferred bit of the mode=
s read
>> > > from edid.
>> >
>> > Can we skip the EDID completely if the hardcoded override is present?
>>=20
>> Yeah, I wondered about that too. The blending of the hardcoded with
>> the EDID predates my involvement with the driver. You can see even as
>> of commit 280921de7241 ("drm/panel: Add simple panel support") that
>> the driver would start with the EDID modes (if it had them) and then
>> go onto add the hardcoded modes. At least for eDP panels, though,
>> nobody (or almost nobody?) actually provided panel-simple a DDC bus at
>> the same time it was given a hardcoded panel.
>>=20
>> I guess I could go either way, but I have a slight bias to adding the
>> extra modes and just making it clear to userspace that none of them
>> are "preferred". That seems like it would give userspace the most
>> flexibility
>
> I disagree. "Flexibility" here just means "the way to shoot itself in
> the foot without knowing it's aiming at its foot".
>
> If a mode is broken, we shouldn't expose it, just like we don't for all
> modes that require a maximum frequency higher than what the controller
> can provide on HDMI for example.

Agreed. This is exactly what the ->mode_valid connector helper callback
is for.

>
>> and also is closer to what we've historically done (though,
>> historically, we just allowed there to be more than one "preferred"
>> mode).
>
> I have no idea what history you're referring to here
>
>> One thing we definitely want to do, though, is to still expose the
>> EDID to userspace even if we're using a hardcoded mode. I believe
>> that, at least on ChromeOS, there are some tools that look at the EDID
>> directly for some reason or another.
>
> If the EDID is known to be broken and unreliable, what's the point?

I don't think it's unheard of to have bogus modes in the EDID while
other stuff is required.

I think the current agreement pretty much is that the kernel handles the
modes, either from the EDID or some other channel, and the userspace
does not look at the EDID for modes.

BR,
Jani.



--=20
Jani Nikula, Intel
