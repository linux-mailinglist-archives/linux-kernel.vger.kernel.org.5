Return-Path: <linux-kernel+bounces-91434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5F871170
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494521C22FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9E5EC2;
	Tue,  5 Mar 2024 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ER6GJ3B6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A84EDE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597398; cv=none; b=Hf6VdW1qtY5OY2LTiUt2rhPF+LDj3DhH6rc6mET9XAx+355Vj6+zL5cJJFIFdqcNLHGFSlgfNYHsFmpzExCK+hov/9Z90RMA1vazuo//YF9BB1XrstQy8FMR5rBnQWbKVUMadbfVuyP/73MBRBULFB5TgpDDs57Y48pcZW1Vv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597398; c=relaxed/simple;
	bh=sxwRPIeHhnGwmE6TMkVaxGE/qOGK/s2muW2cFbd2vEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGfurYyMccjDTc3xekqBj6WcnH1uJHdPPTwznpEkUWQlOcjcswhgXI33aFIBrZVCAZmAUSgDJIpf3mjT9wrGkNPo89GfVtrgZaoqGOWgAENvOz47em3A8A0PZKp/TVyhlotsyhAqyY7TkXezG7PxRKT0dIw1MmMw0sqBh36Mhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ER6GJ3B6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709597396; x=1741133396;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=sxwRPIeHhnGwmE6TMkVaxGE/qOGK/s2muW2cFbd2vEY=;
  b=ER6GJ3B6K88HhiZpx8ztFEJU7Hzer2cfpO9agf1DAgXz7RraI/ISPdd5
   tnp/YTSoaNwOXGLjeeglzMPPGqPwGR/ztm/ZxbBuVrRLBYNnIShBdXa6E
   8GAgTdZnXdABq7YUJAf3J5KsAIHl7rm6muz2Gz9gkoyuit/U2nlUFwhKZ
   JjthCnpwXmgCyMdw2uorB4e5VzlmaXjQYrXygW6bITnW83B/0jpqF1LtL
   jhGIz2nSpz4nugnHy1ESAomjNMYcMRdLCnrjD3O0hKMD8lgbWH8sT/5Rw
   3yc1ae67Xg/O0nhAbHTedhuOdWi7hoNmiS7pBGmI/HaZdQkt298JrQxes
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3982369"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3982369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 16:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9076604"
Received: from syakovle-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.3])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 16:09:45 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
In-Reply-To: <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240304195214.14563-1-hsinyi@chromium.org>
 <20240304195214.14563-3-hsinyi@chromium.org> <87a5nd4tsg.fsf@intel.com>
 <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
Date: Tue, 05 Mar 2024 02:09:34 +0200
Message-ID: <874jdl4k01.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> On Mon, Mar 4, 2024 at 12:38=E2=80=AFPM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
>>
>> On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>> > Add a function to check if the EDID base block contains a given string.
>> >
>> > One of the use cases is fetching panel from a list of panel names, sin=
ce
>> > some panel vendors put the monitor name after EDID_DETAIL_MONITOR_STRI=
NG
>> > instead of EDID_DETAIL_MONITOR_NAME.
>> >
>> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> > ---
>> > v2->v3: move string matching to drm_edid
>> > ---
>> >  drivers/gpu/drm/drm_edid.c | 49 ++++++++++++++++++++++++++++++++++++++
>> >  include/drm/drm_edid.h     |  1 +
>> >  2 files changed, 50 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> > index 13454bc64ca2..fcdc2bd143dd 100644
>> > --- a/drivers/gpu/drm/drm_edid.c
>> > +++ b/drivers/gpu/drm/drm_edid.c
>> > @@ -2789,6 +2789,55 @@ u32 drm_edid_get_panel_id(struct edid_base_bloc=
k *base_block)
>> >  }
>> >  EXPORT_SYMBOL(drm_edid_get_panel_id);
>> >
>> > +/**
>> > + * drm_edid_has_monitor_string - Check if a EDID base block has certa=
in string.
>> > + * @base_block: EDID base block to check.
>> > + * @str: pointer to a character array to hold the string to be checke=
d.
>> > + *
>> > + * Check if the detailed timings section of a EDID base block has the=
 given
>> > + * string.
>> > + *
>> > + * Return: True if the EDID base block contains the string, false oth=
erwise.
>> > + */
>> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, =
const char *str)
>> > +{
>> > +     unsigned int i, j, k, buflen =3D strlen(str);
>> > +
>> > +     for (i =3D 0; i < EDID_DETAILED_TIMINGS; i++) {
>> > +             struct detailed_timing *timing =3D &base_block->edid.det=
ailed_timings[i];
>> > +             unsigned int size =3D ARRAY_SIZE(timing->data.other_data=
data.str.str);
>> > +
>> > +             if (buflen > size || timing->pixel_clock !=3D 0 ||
>> > +                 timing->data.other_data.pad1 !=3D 0 ||
>> > +                 (timing->data.other_data.type !=3D EDID_DETAIL_MONIT=
OR_NAME &&
>> > +                  timing->data.other_data.type !=3D EDID_DETAIL_MONIT=
OR_STRING))
>> > +                     continue;
>> > +
>> > +             for (j =3D 0; j < buflen; j++) {
>> > +                     char c =3D timing->data.other_data.data.str.str[=
j];
>> > +
>> > +                     if (c !=3D str[j] ||  c =3D=3D '\n')
>> > +                             break;
>> > +             }
>> > +
>> > +             if (j =3D=3D buflen) {
>> > +                     /* Allow trailing white spaces. */
>> > +                     for (k =3D j; k < size; k++) {
>> > +                             char c =3D timing->data.other_data.data.=
str.str[k];
>> > +
>> > +                             if (c =3D=3D '\n')
>> > +                                     return true;
>> > +                             else if (c !=3D ' ')
>> > +                                     break;
>> > +                     }
>> > +                     if (k =3D=3D size)
>> > +                             return true;
>> > +             }
>> > +     }
>> > +
>> > +     return false;
>> > +}
>> > +
>>
>> So we've put a lot of effort into converting from struct edid to struct
>> drm_edid, passing that around in drm_edid.c, with the allocation size it
>> provides, and generally cleaning stuff up.
>>
>> I'm not at all happy to see *another* struct added just for the base
>> block, and detailed timing iteration as well as monitor name parsing
>> duplicated.
>>
>> With struct drm_edid you can actually return an EDID that only has the
>> base block and size 128, even if the EDID indicates more
>> extensions. Because the whole thing is *designed* to handle that
>> gracefully. The allocated size matters, not what the blob originating
>> outside of the kernel tells you.
>>
>> What I'm thinking is:
>>
>> - Add some struct drm_edid_ident or similar. Add all the information
>>   that's needed to identify a panel there. I guess initially that's
>>   panel_id and name.
>>
>>     struct drm_edid_ident {
>>         u32 panel_id;
>>         const char *name;
>>     };
>>
>> - Add function:
>>
>>     bool drm_edid_match(const struct drm_edid *drm_edid, const struct dr=
m_edid_ident *ident);
>>
>>   Check if stuff in ident matches drm_edid. You can use and extend the
>>   existing drm_edid based iteration etc. in
>>   drm_edid.c. Straightforward. The fields in ident can trivially be
>>   extended later, and the stuff can be useful for other drivers and
>>   quirks etc.
>>
>> - Restructure struct edp_panel_entry to contain struct
>>   drm_edid_ident. Change the iteration of edp_panels array to use
>>   drm_edid_match() on the array elements and the edid.
>>
>> - Add a function to read the EDID base block *but* make it return const
>>   struct drm_edid *. Add warnings in the comments that it's only for
>>   panel and for transition until it switches to reading full EDIDs.
>>
>>     const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *=
adapter);
>>
>>   This is the *only* hackish part of the whole thing, and it's nicely
>>   isolated. For the most part you can use drm_edid_get_panel_id() code
>>   for this, just return the blob wrapped in a struct drm_edid envelope.
>
> To clarify:
> struct drm_edid currently is only internal to drm_edid.c. So with
> change we will have to move it to the header drm_edid.h

Absolutely not, struct drm_edid must remain an opaque type. The point is
that you ask drm_edid.c if there's a match or not, and the panel code
does not need to care what's inside struct drm_edid.

>
>>
>> - Remove function:
>>
>>     u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>>
>
> Probably change to u32 drm_edid_get_panel_id(const struct drm_edid
> *);? Given that we still need to parse id from
> drm_edid_read_base_block().

No, we no longer need to parse the id outside of drm_edid.c. You'll have
the id's in panel code in the form of struct drm_edid_ident (or
whatever), and use the match function to see if the opaque drm_edid
matches.

>
>> - Refactor edid_quirk_list to use the same id struct and match function
>>   and mechanism within drm_edid.c (can be follow-up too).
>>
>
> edid_quirk currently doesn't have panel names in it, and it might be a
> bit difficult to get all the correct names of these panels without
> having the datasheets.
> One way is to leave the name as null and if the name is empty and skip
> matching the name in drm_edid_match().

Exactly. NULL in drm_edid_ident would mean "don't care". I think most of
the ones in panel code also won't use the name for matching.

BR,
Jani.

>
>> - Once you change the panel code to read the whole EDID using
>>   drm_edid_read family of functions in the future, you don't have to
>>   change *anything* about the iteration or matching or anything, because
>>   it's already passing struct drm_edid around.
>>
>>
>> I hope this covers everything.
>>
>> BR,
>> Jani.
>>
>>
>> >  /**
>> >   * drm_edid_get_base_block - Get a panel's EDID base block
>> >   * @adapter: I2C adapter to use for DDC
>> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
>> > index 2455d6ab2221..248ddb0a6b5d 100644
>> > --- a/include/drm/drm_edid.h
>> > +++ b/include/drm/drm_edid.h
>> > @@ -416,6 +416,7 @@ struct edid *drm_get_edid(struct drm_connector *co=
nnector,
>> >                         struct i2c_adapter *adapter);
>> >  struct edid_base_block *drm_edid_get_base_block(struct i2c_adapter *a=
dapter);
>> >  u32 drm_edid_get_panel_id(struct edid_base_block *base_block);
>> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, =
const char *str);
>> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>> >                                    struct i2c_adapter *adapter);
>> >  struct edid *drm_edid_duplicate(const struct edid *edid);
>>
>> --
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel

