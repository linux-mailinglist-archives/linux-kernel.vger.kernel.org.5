Return-Path: <linux-kernel+bounces-22217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC7829B07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2DA1C20C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B0487A4;
	Wed, 10 Jan 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="tFOiG5JG"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2C48794
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id C562B2FC005B;
	Wed, 10 Jan 2024 14:14:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704892461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XXWzf6RfsompBPEpJXXqoA3QY72hJE9BCknBlltgU=;
	b=tFOiG5JGP63gUPxytuSaXh/9yy7SdS7kKoiE7F9gkO9wjO53+5d/H/jqPdNpMuqTjvGHft
	5DQe+5DPNJez8uLzSscCUnvJ3yoCroj6fr/rGUf0B+1bO27Wyr7h0rL9JcST9M0Q94BjTG
	ZJXjiUdQlmZjvUbgXnM+Tij+l93L6nA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <67808818-ee34-4d04-ad90-cd5c6eb9bb26@tuxedocomputers.com>
Date: Wed, 10 Jan 2024 14:14:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amd/display: Add handling for new "active color
 format" property
Content-Language: en-US
To: Daniel Vetter <daniel@ffwll.ch>, Andri Yngvason <andri@yngvason.is>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Simon Ser <contact@emersion.fr>
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-4-andri@yngvason.is>
 <ZZ57Nl3CnRMPcfbj@phenom.ffwll.local>
 <CAFNQBQzo17cK4M-S=Mje8Lxub9Y74xFGj7iEq57vKJr47oiz5Q@mail.gmail.com>
 <CAKMK7uGhMCwbztGdEmG4gFgpyhw6j-JFow-AaprFxcX710=qXA@mail.gmail.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CAKMK7uGhMCwbztGdEmG4gFgpyhw6j-JFow-AaprFxcX710=qXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 10.01.24 um 14:09 schrieb Daniel Vetter:
> On Wed, 10 Jan 2024 at 13:53, Andri Yngvason <andri@yngvason.is> wrote:
>> mið., 10. jan. 2024 kl. 11:10 skrifaði Daniel Vetter <daniel@ffwll.ch>:
>>> On Tue, Jan 09, 2024 at 06:11:00PM +0000, Andri Yngvason wrote:
>>>> +     /* Extract information from crtc to communicate it to userspace as connector properties */
>>>> +     for_each_new_connector_in_state(state, connector, new_con_state, i) {
>>>> +             struct drm_crtc *crtc = new_con_state->crtc;
>>>> +             struct dc_stream_state *stream;
>>>> +
>>>> +             if (crtc) {
>>>> +                     new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>>>> +                     dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>>> +                     stream = dm_new_crtc_state->stream;
>>>> +
>>>> +                     if (stream) {
>>>> +                             drm_connector_set_active_color_format_property(connector,
>>>> +                                     convert_dc_pixel_encoding_into_drm_color_format(
>>>> +                                             dm_new_crtc_state->stream->timing.pixel_encoding));
>>>> +                     }
>>>> +             } else {
>>>> +                     drm_connector_set_active_color_format_property(connector, 0);
>>> Just realized an even bigger reason why your current design doesn't work:
>>> You don't have locking here.
>>>
>>> And you cannot grab the required lock, which is
>>> drm_dev->mode_config.mutex, because that would result in deadlocks. So
>>> this really needs to use the atomic state based design I've described.
>>>
>> Maybe we should just drop "actual color format" and instead fail the
>> modeset if the "preferred color format" property cannot be satisfied?
>> It seems like the simplest thing to do here, though it is perhaps less
>> convenient for userspace. In that case, the "preferred color format"
>> property should just be called "color format".
> Yeah that's more in line with how other atomic properties work. This
> way userspace can figure out what works with a TEST_ONLY commit too.
> And for this to work you probably want to have an "automatic" setting
> too.
> -Sima

The problem with TEST_ONLY probing is that color format settings are 
interdependent: https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_966634

So changing any other setting may require every color format to be TEST_ONLY 
probed again.

Greetings

Werner


