Return-Path: <linux-kernel+bounces-96333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15004875A58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFC1C20BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFFE3399F;
	Thu,  7 Mar 2024 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxdUKHDe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C731E86E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850983; cv=none; b=K0D5e5r6dxx6gX0alTt109gq2XlMyaGsxp77TtzMiHa+U6/7kfkci9ekCKrA/brvW+ftkgwld1xJZAZg+bhgHzHV6lp1MLRZaB+rtN/6rTgIh/AcDzmAIfACnmUtXBkRWvwCCobGZQDCWjpMOdt9AXT4N5e0xYbxtgnnWDOgSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850983; c=relaxed/simple;
	bh=o+0H5vuiH0oRSMJ1IHCrSxVI4KRF4Ypwjqb7Qvd5Qis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mmeo6HCxqpxHaAZRY4rtatrGmqW0x8hAoebpNRIwafELB3Cof0ftMkcbTv+HBa5Cczi4Ktw41EcyKnggS0q4n/VOsYOH3bJ1QaNQYHfa7SVQz5pXVyJpwYxXlctqLinqSf0De1Ubu4KHNArkZc+PGG40IEqrXKpS33ryl5B1smQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxdUKHDe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709850981; x=1741386981;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=o+0H5vuiH0oRSMJ1IHCrSxVI4KRF4Ypwjqb7Qvd5Qis=;
  b=FxdUKHDeVM3bq0Tt+nVJZbhmGVHoEPZ54O2UWPKBCbHbwHhoEov70p0E
   HESI9Qve32JxSNd810T7+7I2boNoCKyUkKgLGZj5nixBMHyo9Xf6rShgL
   +UkeZvjIgsPw/gubFn8po7VFKoi+Iq4pD0L4iS+zvKprivagGWN/Cxhb8
   NgHd317BmAr6ImLmqvm2xpDkn5wn2cdJklEj7kfbmGx9GFBR3EDVZy4y4
   qhm5L2Ud57RnZ/66YUj0S9IHmP2Rs6B9laZPpxZY0Npfnm6HKiVitsAQz
   H1UPWI1utq7e8wZKgaJSNE8tXiHvQTomHH/wtzqRrLSBTYYjeYcE5+jkd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4480935"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4480935"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 14:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10362122"
Received: from tofferse-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.212])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 14:36:16 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm/edid: Add a function to match EDID with
 identity
In-Reply-To: <CAJMQK-igm-OXa=L-Bb0hdm5+KL98sk9UAznvAR7SptP9iwWAoA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240306200353.1436198-1-hsinyi@chromium.org>
 <20240306200353.1436198-4-hsinyi@chromium.org>
 <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com>
 <CAJMQK-i=0COuMGW+PGv3zT4+JgwJc_Qj9oQHva6EQys_n3xoHA@mail.gmail.com>
 <CAD=FV=VHaU4HZHGp6tSoVuJRbYD9nrMZfNdnOait=ApRcvcmug@mail.gmail.com>
 <87r0gmw544.fsf@intel.com>
 <CAJMQK-igm-OXa=L-Bb0hdm5+KL98sk9UAznvAR7SptP9iwWAoA@mail.gmail.com>
Date: Fri, 08 Mar 2024 00:36:11 +0200
Message-ID: <87plw5vfdw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> On Thu, Mar 7, 2024 at 5:20=E2=80=AFAM Jani Nikula <jani.nikula@linux.int=
el.com> wrote:
>>
>> On Wed, 06 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
>> > Hi,
>> >
>> > On Wed, Mar 6, 2024 at 4:20=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.o=
rg> wrote:
>> >>
>> >> On Wed, Mar 6, 2024 at 3:30=E2=80=AFPM Doug Anderson <dianders@chromi=
um.org> wrote:
>> >> >
>> >> > Hi,
>> >> >
>> >> > On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromi=
um.org> wrote:
>> >> > >
>> >> > > +static void
>> >> > > +match_identity(const struct detailed_timing *timing, void *data)
>> >> > > +{
>> >> > > +       struct drm_edid_match_closure *closure =3D data;
>> >> > > +       unsigned int i;
>> >> > > +       const char *name =3D closure->ident->name;
>> >> > > +       unsigned int name_len =3D strlen(name);
>> >> > > +       const char *desc =3D timing->data.other_data.data.str.str;
>> >> > > +       unsigned int desc_len =3D ARRAY_SIZE(timing->data.other_d=
ata.data.str.str);
>> >> > > +
>> >> > > +       if (name_len > desc_len ||
>> >> > > +           !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_N=
AME) ||
>> >> > > +             is_display_descriptor(timing, EDID_DETAIL_MONITOR_S=
TRING)))
>> >> > > +               return;
>> >> > > +
>> >> > > +       if (strncmp(name, desc, name_len))
>> >> > > +               return;
>> >> > > +
>> >> > > +       /* Allow trailing white spaces and \0. */
>> >> > > +       for (i =3D name_len; i < desc_len; i++) {
>> >> > > +               if (desc[i] =3D=3D '\n')
>> >> > > +                       break;
>> >> > > +               if (!isspace(desc[i]) && !desc[i])
>> >> > > +                       return;
>> >> > > +       }
>> >> >
>> >> > If my code analysis is correct, I think you'll reject the case wher=
e:
>> >> >
>> >> > name =3D "foo"
>> >> > desc[13] =3D "foo \0zzzzzzzz"
>> >> >
>> >> > ...but you'll accept these cases:
>> >> >
>> >> > desc[13] =3D "foo \nzzzzzzzz"
>> >> > desc[13] =3D "foo \0\0\0\0\0\0\0\0\0"
>> >> >
>> >> > It somehow seems weird to me that a '\n' terminates the string but =
not a '\0'.
>> >>
>> >> I'm also not sure about \0... based on
>> >> https://git.linuxtv.org/edid-decode.git/tree/parse-base-block.cpp#n49=
3,
>> >> they use \n as terminator. Maybe we should also reject \0 before\n?
>> >> Since it's not printable.
>> >
>> > Ah, OK. I guess the EDID spec simply doesn't allow for '\0' in there.
>> > I guess in that case I'd prefer simply removing the code to handle
>> > '\0' instead of treating it like space until we see some actual need
>> > for it. So just get rid of the "!desc[i]" case?
>>
>> The spec text, similar for both EDID_DETAIL_MONITOR_NAME and
>> EDID_DETAIL_MONITOR_STRING:
>>
>>         Up to 13 alphanumeric characters (using ASCII codes) may be used
>>         to define the model name of the display product. The data shall
>>         be sequenced such that the 1st byte (ASCII code) =3D the 1st
>>         character, the 2nd byte (ASCII code) =3D the 2nd character,
>>         etc. If there are less than 13 characters in the string, then
>>         terminate the display product name string with ASCII code =E2=80=
=980Ah=E2=80=99
>>         (line feed) and pad the unused bytes in the field with ASCII
>>         code =E2=80=9820h=E2=80=99 (space).
>>
>> In theory, only checking for '\n' for termination should be enough, and
>> this is what drm_edid_get_monitor_name() does. If there's a space
>> *before* that, it should be considered part of the name, and not
>> ignored. (So my suggestion in reply to the previous version is wrong.)
>>
>> However, since the match name uses NUL termination, maybe we should
>> ignore NULs *before* '\n'? Like so:
>>
>> for (i =3D name_len; i < desc_len; i++) {
>>         if (desc[i] =3D=3D '\n')
>>                 break;
>>         if (!desc[i])
>>                 return;
>> }
>>
> Allow trailing white spaces so we don't need to add the trailing white
> space in edp_panel_entry.

Just so it's clear here too: Agreed.

>
> https://lore.kernel.org/lkml/CAA8EJpr7LHvqeGXhbFQ8KNn0LGDuv19cw0i04qVUz51=
TJeSQrA@mail.gmail.com/
>
>>
>> BR,
>> Jani.
>>
>>
>> >
>> > -Doug
>>
>> --
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel

