Return-Path: <linux-kernel+bounces-159836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B48B34F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934B828914E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF51428E9;
	Fri, 26 Apr 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEmbo4p5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA9142645
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126139; cv=none; b=E3GoR/vekb8F+aG3jSBKTpfBtkH0LyxTWvV3GQaLoW79xaM4BC35degZGHOdV5rH0oJqD7YbIqLELdS7KsFxkVIRKpi+r/m+HdPZBe8sMzV3RT5gh8gPhrBlfdOyFYdHBadXGFPqa8kMIUTURPa3u8w+V3sb9b/oNoDV/JY1cJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126139; c=relaxed/simple;
	bh=hdNA40BsOA8zMYaPa+l0B6i1Mar9bV4wN0skFoiJ/TM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eT/wn+xPX8e2113XJmdfM4VoJqu8XvC8cd25g2aRW1z6+ifehMxbfm3tZRilkXcyaIagCCMOK++1C7AWIYB0rn1/cprVcBOMVNbwrvCLBDlhBzVHbvEsDbgFmf6kU/OC/XFcYC2ooiR2APMpKY8gnZaj9tyD0KbRB+KQlzt+FDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEmbo4p5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714126137; x=1745662137;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=hdNA40BsOA8zMYaPa+l0B6i1Mar9bV4wN0skFoiJ/TM=;
  b=NEmbo4p5/8o7E0Jxkzo7+g1un6HCXmNbmsWANadYVzkWvLgYfINUSj4o
   XEWfxrRpl/hu2a7op0MnP1nvRsLlO0A8zClCkwbHXWEyyoKtgiWZReD3+
   9KTstqgeblfeZBFoYgzxbKJUQzUpPLNOvYKXmIQsuwD22nXC6QE6XXjfd
   814cPklK4asLusbc+qZwx3WiRh2+HXj6at3jQCDTi0Mh12czqwc5059KS
   wKmJRsLaNlp2TW4qw/Hlq9/Sux9hVGWcr9V1Eto1uS/MJ53c0jcdF3dUy
   d0EuBpeNJKDRWRkeiF117ZUXWNRzvdoa3WvcTLZQnjj1kHtRUugpaJTsO
   A==;
X-CSE-ConnectionGUID: 4miyIuAnR4uVKXSGi3BWBQ==
X-CSE-MsgGUID: UlN37oznT6u7iwB6A/463w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9781858"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9781858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 03:08:57 -0700
X-CSE-ConnectionGUID: MfYF0uoHQHeICccbNe6BxQ==
X-CSE-MsgGUID: Zavh7QhmSC+sewtU5ozICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25370659"
Received: from dgarbuz-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 03:08:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Javier Martinez Canillas
 <javierm@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>, linus.walleij@linaro.org, Cong
 Yang <yangcong5@huaqin.corp-partner.google.com>,
 lvzhaoxiong@huaqin.corp-partner.google.com, Hsin-Yi Wang
 <hsinyi@google.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mipi-dsi: Reduce driver bloat of
 mipi_dsi_*_write_seq()
In-Reply-To: <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
 <87pludq2g0.fsf@intel.com>
 <CAD=FV=W+Pcr+voBkcfeE_UC+ukN_hLXgoqMk0watROWRXe_2dg@mail.gmail.com>
Date: Fri, 26 Apr 2024 13:08:48 +0300
Message-ID: <8734r85tcf.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Apr 2024, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Apr 25, 2024 at 1:19=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>>
>> > @@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
>> >
>> >  ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
>> >                                 const void *data, size_t len);
>> > +ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
>> > +                                      const void *data, size_t len);
>> >  ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
>> >                          const void *data, size_t len);
>> >  ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *=
data,
>> > @@ -317,14 +321,10 @@ int mipi_dsi_dcs_get_display_brightness_large(st=
ruct mipi_dsi_device *dsi,
>> >  #define mipi_dsi_generic_write_seq(dsi, seq...)                      =
          \
>> >       do {                                                            =
       \
>> >               static const u8 d[] =3D { seq };                        =
         \
>> > -             struct device *dev =3D &dsi->dev;                       =
         \
>> >               int ret;                                                =
       \
>> > -             ret =3D mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));  =
         \
>> > -             if (ret < 0) {                                          =
       \
>> > -                     dev_err_ratelimited(dev, "transmit data failed: =
%d\n", \
>> > -                                         ret);                       =
       \
>> > +             ret =3D mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE=
(d));    \
>> > +             if (ret < 0)                                            =
       \
>> >                       return ret;                                     =
       \
>> > -             }                                                       =
       \
>> >       } while (0)
>>
>> The one thing that I've always disliked about these macros (even if I've
>> never actually used them myself) is that they hide control flow from the
>> caller, i.e. return directly. You don't see that in the code, it's not
>> documented, and if you wanted to do better error handling yourself,
>> you're out of luck.
>
> Yeah, I agree that it's not the cleanest. That being said, it is
> existing code and making the existing code less bloated seems worth
> doing.
>
> I'd also say that it feels worth it to have _some_ solution so that
> the caller doesn't need to write error handling after every single cmd
> sent. If we get rid of / discourage these macros that's either going
> to end us up with ugly/verbose code or it's going to encourage people
> to totally skip error handling. IMO neither of those are wonderful
> solutions.
>
> While thinking about this there were a few ideas I came up with. None
> of them are amazing, but probably they are better than the hidden
> "return" like this. Perhaps we could mark the current function as
> "deprecated" and pick one of these depending on what others opinions
> are:
>
> 1. Use "goto" and force the caller to give a goto target for error handli=
ng.
>
> This is based on an idea that Dmitry came up with, but made a little
> more explicit. Example usage:
>
> int ret;
>
> ret =3D 0;
> mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETSPCCMD, 0xcd,
>                             some_cmd_failed);
> mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETMIPI, 0x84,
>                             some_cmd_failed);
> mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETSPCCMD, 0x3f,
>                             some_cmd_failed);
> mipi_dsi_dcs_write_seq_goto(dsi, &ret, HX83102_SETVDC, 0x1b, 0x04,
>                             some_cmd_failed);
>
> ...
>
> some_cmd_failed:
>   pr_err("Commands failed to write: %d", ret);
>   return ret;
> }
>
> One downside here is that you can't easily tell which command failed
> to put it in the error message. A variant of this idea (1a?) could be
> to hoist the print back into the write command. I'd want to pick one
> or the other. I guess my preference would be to hoist the print into
> the write command and if someone really doesn't want the print then
> they call mipi_dsi_dcs_write_buffer() directly.
>
> ---
>
> 2. Accept that a slightly less efficient handling of the error case
> and perhaps a less intuitive API, but avoid the goto.
>
> Essentially you could pass in "ret" and have the function be a no-op
> if an error is already present. Something like this:
>
> void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_device *dsi,
> const void *data, size_t len, int *accum_ret)
> {
>   if (*accum_ret)
>     return;
>
>   *accum_ret =3D mipi_dsi_dcs_write_buffer(dsi, data, len);

No reason you couldn't do error logging here

	if (*accum_ret)
		dev_err(...)

> }
>
> ...and then the caller:
>
> int ret;
>
> ret =3D 0;
> mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETSPCCMD, 0xcd, &ret);
> mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETMIPI, 0x84, &ret);
> mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETSPCCMD, 0x3f, &ret);
> mipi_dsi_dcs_write_seq_multi(dsi, HX83102_SETVDC, 0x1b, 0x04, &ret);
> if (ret)
>   goto some_cmd_failed;
>
> This has similar properties to solution #1.

I like this option the best, for the simple reason that the caller side
is aware of what's going on, there's no magic control flow happening,
and they can add error handling in the middle if they so choose.

I don't find this unintuitive, but if it helps, you could conceivably
add a context parameter:

	struct mipi_dsi_seq_context context =3D {
		.dsi =3D dsi,
	};

	mipi_dsi_dcs_write_seq(&context, HX83102_SETSPCCMD, 0xcd);
	...

	if (context.ret)
		...

And even have further control in the context whether to log or keep
going or whatever.

I don't think the efficiency in error cases is a problem worth thinking
about, but you could address that by turning this into a macro so
there's no extra calls on errors.

BR,
Jani.


>
> ---
>
> 3. Accept that callers don't want to error handling but just need a print.
>
> I'm not 100% sure we want to encourage this. On the one hand it's
> unlikely anyone is really going to be able to reliably recover super
> properly from an error midway through a big long command sequence. On
> the other hand, this means we can't pass the error back to the caller.
> In theory the caller _could_ try to handle errors by resetting / power
> cycling things, so that's a real downside.
>
> Example usage:
>
> mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETSPCCMD, 0xcd);
> mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETMIPI, 0x84);
> mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETSPCCMD, 0x3f);
> mipi_dsi_dcs_write_seq_chatty(dsi, HX83102_SETVDC, 0x1b, 0x04);
>
> ---
>
> I think I'd lean towards #1a (user passes goto label and we include
> the error print in the helper), but I'd personally be happy with any
> of #1 or #2. I don't love #3.
>
>> Be that as it may, the combo of ratelimited error printing and return on
>> errors does not make much sense to me. If there's something to print,
>> you bail out, that's it. I suspect we never hit the ratelimit.
>
> Yeah, I'm in favor of removing the ratelimit.
>
>
>> You might even want to try *only* changing the ratelimited printing to a
>> regular error message, and see if the compiler can combine the logging
>> to a single exit point in the callers. Ratelimited it obviously can't
>> because every single one of them is unique.
>
> It wasn't quite as good. Comparing the "after" solution (AKA applying
> $SUBJECT patch) vs. _not_ taking $SUBJECT patch and instead changing
> dev_err_ratelimited() to dev_err().
>
> $ scripts/bloat-o-meter \
>    .../after/panel-novatek-nt36672e.ko \
>   .../noratelimit/panel-novatek-nt36672e.ko
> add/remove: 0/0 grow/shrink: 1/0 up/down: 3404/0 (3404)
> Function                                     old     new   delta
> nt36672e_1080x2408_60hz_init                7260   10664   +3404
> Total: Before=3D11669, After=3D15073, chg +29.17%
>
> ...so $SUBJECT patch is still better.
>
> ---
>
> Where does that leave us? IMO:
>
> a) If others agree, we should land $SUBJECT patch. It doesn't change
> the behavior at all and gives big savings. It adds an extra function
> hop, but presumably the fact that we have to fetch _a lot_ less stuff
> from RAM might mean we still get better performance (likely it doesn't
> matter anyway since this is not hotpath code).
>
> b) Atop this patch, we should consider changing dev_err_ratelimited()
> to dev_err(). It doesn't seem to make lots of sense to me to ratelimit
> this error.
>
> c) Atop this patch, we should consider making the two existing macros
> "deprecated" in favor of a new macro that makes the control flow more
> obvious.
>
> How does that sound to folks?
>
> -Doug

--=20
Jani Nikula, Intel

