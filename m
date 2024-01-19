Return-Path: <linux-kernel+bounces-31062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E6832836
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EBBB21144
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4F4CB3A;
	Fri, 19 Jan 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGcjhtHe"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3BDF71;
	Fri, 19 Jan 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661493; cv=none; b=sSe012oiK695Z8sysAlEAO0xMkXuRnl1ggOAevc+z1N3PxRPg0DUS0rKAygrRREFAudR8h5fI6msfvN5Bl4wmElIFXfxOTx+kadgwMi7s3dxQjyWIVjj5eSBb4Vu9XYJ9WLDeuwTlOl9PjsIZyqk/ZiGoGDRf35MaIK03O4KRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661493; c=relaxed/simple;
	bh=mmJMFX/yMqul7R/1AAX1HbrHQilika2cXTOvDyZmG2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b78+NW43b6FDrDPHXaThRJxo45ebzZTXY9Rh9+LPyf/NqtgetTZudCGd/49F1uxRxTU2Q+xjLRWEnK3aIjNGFNNBm4TwfHi1eMNHu/zRwoXJKWf+wSOIO+L81WyblS3co5JnYGExnoDGn8j9zji8gkx8jQ9KgE93+D5ySqUZInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGcjhtHe; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705661490; x=1737197490;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mmJMFX/yMqul7R/1AAX1HbrHQilika2cXTOvDyZmG2Y=;
  b=mGcjhtHe15k4bxnTjmT4Rs3WSZ+EM7kv5aPbG1G2ZkFbXRwBM7V2S+z6
   sVvd1z/Janxh5jp26h8OG0/T5XLoQQ4X96i9mthNP4NSq7sw2KjoAVCRw
   DYaDljjRwjZ1avmLpZCQQugoXvzLtswtsf7eBKszMERpl2R0erOYiD6cq
   Klfl1E2Qj0zUwjy3pgIto1p2+HXz2gsCAe8ByODjbKH1fuOcTB8dFUCVr
   /aolRQsOTtwT0LQWEal4YveD0wtzfLLmC/rkm3c/jjl0AThN1Td7vfj7U
   0wlYnqCHJvf6ZVHphe1H7tP4lhGmemuVrDN91dXtoQuEj2lNk2asT2ggn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="464997926"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="464997926"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 02:51:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788329742"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788329742"
Received: from vstill-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.223])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 02:51:24 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>, Werner
 Sembach <wse@tuxedocomputers.com>
Cc: jikos@kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, linux-input@vger.kernel.org,
 ojeda@kernel.org, linux-leds@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
In-Reply-To: <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
 <ZSmg4tqXiYiX18K/@duo.ucw.cz>
 <CANiq72mfP+dOLFR352O0UNVF8m8yTi_VmOY1zzQdTBjPWCRowg@mail.gmail.com>
 <87sf61bm8t.fsf@intel.com> <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
Date: Fri, 19 Jan 2024 12:51:21 +0200
Message-ID: <87bk9hppee.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 19 Jan 2024, Hans de Goede <hdegoede@redhat.com> wrote:
> For per key controllable rgb LEDs we need to discuss a coordinate
> system. I propose using a fixed size of 16 rows of 64 keys,
> so 64x16 in standard WxH notation.
>
> And then storing RGB in separate bytes, so userspace will then
> always send a buffer of 192 bytes per line (64x3) x 14 rows
> = 3072 bytes. With the kernel driver ignoring parts of
> the buffer where there are no actual keys.
>
> I would then like the map the standard 105 key layout onto this,
> starting at x.y (column.row) coordinates of 16.6 (with 0.0 being
> the top left). Leaving plenty of space on the left top and right
> (and some on the bottom) for extra media key rows, macro keys, etc.
>
> The idea to have the standard layout at a fixed place is to allow
> userspace to have a database of preset patterns which will work
> everywhere.
>
> Note I say standard 105 key layout, but in reality for
> defining the standardized part of the buffer we should
> use the maximum amount of keys per row of all the standard layouts,
> so for row 6 (the ESC row) and for extra keys on the right outside
> the main block we use the standard layout as shown here:

Doesn't the input stack already have to have pretty much all of this
already covered? I can view the keyboard layout in my desktop
environment, and it's a reasonably accurate match, even if unlikely to
be pixel perfect. But crucially, it has to have all the possible layouts
covered already.

And while I would personally hate it, you can imagine a use case where
you'd like a keypress to have a visual effect around the key you
pressed. A kind of force feedback, if you will. I don't actually know,
and correct me if I'm wrong, but feels like implementing that outside of
the input subsystem would be non-trivial.

Cc: Dmitry, could we at least have some input from the input subsystem
POV on this? AFAICT we have received none.


BR,
Jani.


>
> http://www.maxkeyboard.com/images/105_ISO_6_25_Key_Layout.jpg
>
> For the main area of the keyboard looking at:
>
> http://bopqehorizon.weebly.com/uploads/1/3/4/3/134337299/913246919_orig.png
>
> We want to max rows per key, so this means that per row we use
> (from the above image) :
>
> row  7: 106/109 - JIS 
> row  8: 101/104 - ANSI
> row  9: 102/105 - ISO
> row 10: 104/107 - ABNT
> row 11: 106/109 - JIS
>
> (with row 7 being the main area top row)
>
> This way we can address all the possible keys in the various
> standard layouts in one standard wat and then the drivers can
> just skip keys which are not there when preparing the buffer
> to send to the hw / fw.
>
> One open question is if we should add padding after the main
> area so that the printscreen / ins / del / leftarrow of the
> "middle" block of 
>
> http://www.maxkeyboard.com/images/105_ISO_6_25_Key_Layout.jpg
>
> all start at the same x (say 32) or we just pack these directly
> after the main area.
>
> And the same question for the numlock block, do we align
> this to an x of say 36, or pack it ?
>
>
> As for the actual IOCTL API I think there should be
> the following ioctls:
>
> 1. A get-info ioctl returning a struct with the following members:
>
> {
> char name[64]      /* Keyboard model name / identifier */
> int row_begin[16]; /* The x address of the first available key per row. On a std 105key kbd this will be 16 for rows 6-11, 0 for other rows */
> int row_end[16];   /* x+1 for the address of the last available key per row, end - begin gives number of keys in a row */
> int rgb_zones;     /* number of rgb zones for zoned keyboards. Note both
>                       zones and per key addressing may be available if
>                       effects are applied per zone. */
> ?
> }
>
> 2. A set-leds ioctl which takes the earlier discussed 3092 bytes buffer
> to set all the LEDs at once, only valid if at least one row has a non 0 lenght.
>
> 3. A set-zones ioctl which takes an array of bytes sized 3 * number-of-zones
> containing RGB values for each zone
>
> 4. A enum_effects ioctl which takes a struct with the following members:
>
> {
> long size; /* Size of passed in struct including the size member itself */
> long effects_mask[]
> }
>
> the idea being that there is an enum with effects, which gets extended
> as we encounter more effects and the bitmask in effects_mask has a bit set
> for each effects enum value which is supported. effects_mask is an array
> so that we don't run out of bits. If older userspace only passes 1 long
> (size == (2*sizeof(long)) when 2 are needed at some point in the future 
> then the kernel will simply only fill the first long.
>
> 5. A set_effect ioctl which takes a struct with the following members:
>
> {
> long size; /* Size of passed in struct including the size member itself */
> int effect_nr; /* enum value of the effect to enable, 0 for disable effect */
> int zone;  /* zone to apply the effect to */
> int speed; /* cycle speed of the effect in milli-hz */
> char color1[3]; /* effect dependend may be unused. */
> char color2[3]; /* effect dependend may be unused. */
> }
>
> Again the idea with the size member is that the struct can be extended with
> new members if necessary and the kernel will supply a default value for
> older userspaces which provide a smaller struct (note size being smaller
> then sizeof(struct-v1) will invalid).
>
>
> Note this is all just a rough sketch suggestions welcome!
>
> Regards,
>
> Hans
>
>
>

-- 
Jani Nikula, Intel

