Return-Path: <linux-kernel+bounces-81748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CA867A72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46266B318D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46512AAEE;
	Mon, 26 Feb 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6L8ztEn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F012AAC4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959486; cv=none; b=f5ByEcKzUCCwGfYjojJYIkizT75PPnRylTN/nbE0VWc96oRfN7bq6YWWyHlFyCpHgqIN2ljRLhtwHpZirCqd5WoE18r977Hk56h8ztEbIu/Y5CQ5Zyor649mpXsascdghGmT+D/2fJPyyFMYUE8+CjkTRhr0z49asSFpgdbSQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959486; c=relaxed/simple;
	bh=kL0QfoZ6P1nfZ64PEp9mANVk6/r8ms3ZNTWK9icE4ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q4TdyK29W2eZHnHe5eJjKiKpy3S7cZqBqnxAU3jxFhFXDScXxi4TwmjELPrCKBTwCphJeLjM82ZteQ7KSmMc8hTr4lS677M2+Pv0rrU1/X19xDKeNXr1s6tzLE4P8NqHFulZuitkdWJ6HRiueUJ/osHwMkSVd9H06iaXkP1CTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6L8ztEn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708959484; x=1740495484;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=kL0QfoZ6P1nfZ64PEp9mANVk6/r8ms3ZNTWK9icE4ik=;
  b=e6L8ztEnfrjbFDgT2SvwQsGnlokWbjEKWc42tBgi7I1hDhgns1YBLwK9
   TA6Y64cCO8OH6Yip6qmyZ0WNKequavAYpFOK4mNI72lO7bp4jgqZeYs6H
   ydjvM09Gp5KTaz8v4Rwk5XDFkH23wmJLLov5y0RQj05X16u8y7FcyJj+i
   P2wbo76pG/DU6H0A/2uUctc1cscRqSSxTAXzsy7KQGsN2FvE+t0xML/aT
   3IkobQsg3uPRur9V52MhDbM8Z6uCkyqRfUt2XQgd33qsskk4VmMeECTap
   60+LAJqz5MQ+K6y8pbW/1r17JReASzsUzgcYudX4mrB8n4G/2C6T6MtiO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3119372"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3119372"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="37482087"
Received: from hibeid-mobl.amr.corp.intel.com (HELO localhost) ([10.252.46.254])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 06:57:58 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Rodrigo
 Vivi
 <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
In-Reply-To: <Zdj2ONs8BZ6959Xb@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com> <Zdj2ONs8BZ6959Xb@intel.com>
Date: Mon, 26 Feb 2024 16:57:58 +0200
Message-ID: <87bk83mfwp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Feb 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Thu, Feb 22, 2024 at 04:46:12PM -0500, Rodrigo Vivi wrote:
>> On Thu, Feb 15, 2024 at 06:40:44PM +0200, Ville Syrjala wrote:
>> > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> >=20
>> > intel_crtc_check_fastset() is done per-pipe, so it would be nice
>> > to know which pipe it was that failed its checkup.
>> >=20
>> > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_display.c | 6 ++++--
>> >  1 file changed, 4 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gp=
u/drm/i915/display/intel_display.c
>> > index 00ac65a14029..a7f487f5c2b2 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_display.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
>> > @@ -5562,14 +5562,16 @@ static int intel_modeset_checks(struct intel_a=
tomic_state *state)
>> >  static void intel_crtc_check_fastset(const struct intel_crtc_state *o=
ld_crtc_state,
>> >  				     struct intel_crtc_state *new_crtc_state)
>> >  {
>> > -	struct drm_i915_private *i915 =3D to_i915(old_crtc_state->uapi.crtc-=
>dev);
>> > +	struct intel_crtc *crtc =3D to_intel_crtc(new_crtc_state->uapi.crtc);
>> > +	struct drm_i915_private *i915 =3D to_i915(crtc->base.dev);
>> >=20=20
>> >  	/* only allow LRR when the timings stay within the VRR range */
>> >  	if (old_crtc_state->vrr.in_range !=3D new_crtc_state->vrr.in_range)
>> >  		new_crtc_state->update_lrr =3D false;
>> >=20=20
>> >  	if (!intel_pipe_config_compare(old_crtc_state, new_crtc_state, true))
>> > -		drm_dbg_kms(&i915->drm, "fastset requirement not met, forcing full =
modeset\n");
>> > +		drm_dbg_kms(&i915->drm, "[CRTC:%d:%s] fastset requirement not met, =
forcing full modeset\n",
>> > +			    crtc->base.base.id, crtc->base.name);
>>=20
>> looking to other patches in this same series, I wonder
>> if we shouldn't benefit of a crct_dbg(crtc, "message") that would print
>> [CRTC:%d:%s] underneath.
>
> There has been some discussion on this topic recently, but
> I don't think that particular approach is good because:
> a) it only works when you need to talk about one partiuclar
>    object and often we need to talk about more than one
> b) different debug function for every little thing is just ugly,
>    and we'd probably end up with dozens of differently named
>    variants which takes up too many slots in my brain's pattern
>    matcher

Agreed. I dislike the approach in i915 gem and xe drivers. There are
just too many logging variants now, and as the gates are open, more are
coming. Please let's not go there with display.

> I think Jani proposed that drm_dbg_kms() could take different kinds
> of objects as its first parameter to do this, but I don't like that
> either because of point a).

Fair, but arguably that's not as bad, as you'd then have the "main"
object you're logging with, the info for that comes for free, and you
can add the additional stuff for the other objects manually. But indeed
only solves part of the problem.

> One idea that was floating about was that each object would embed
> a .debug_string or somesuch thing which would include the preferred
> formatting. With that you could prints with just a simple %s. The
> downside is that when you then read the format string you have no
> idea what kind of thing each %s refers to unless you also parse
> the full argument list to figure out which is which.

Also, that would have to be a fixed string, initialized at object
creation. Can't have a function returning the string, because it gets
complicated with C.

> And one basic idea I was mulling over at some point was simply
> to define DRM_CRTC_FMT/ARGS/etc. macros and use those. But that
> makes the format string super ugly and hard to read.

Agreed.

> I think the proper solution would be to have actually
> sensible conversion specifiers in the format string.
> So instead of %<set of random characters> we'd have something
> more like %{drm_crtc} (or whatever color you want to throw
> on that particular bikeshed).

Personally I suck at remembering even the standard printf conversion
specifiers, let alone all the kernel extensions. I basically have to
look them up every time. I'd really love some %{name} format for named
pointer things. And indeed preferrably without the %p. Just %{name}.

And then we could discuss adding support for drm specific things. I
guess one downside is that the functions to do this would have to be in
vsprintf.c instead of drm. Unless we add some code in drm for this
that's always built-in.

BR,
Jani.


>
> Adding vsprintf.c folks to cc in case they have some ideas...

--=20
Jani Nikula, Intel

