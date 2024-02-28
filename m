Return-Path: <linux-kernel+bounces-85510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A686B6DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DC1C24560
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495379B93;
	Wed, 28 Feb 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2tlfq6O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2E79B83;
	Wed, 28 Feb 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143814; cv=none; b=omySp02xDQlJ/25lwNmApFE6ftBs+OieH1tK9ipTzVXG2N5H2fQBJbIeJJzYwCz551vutkmAV8MIGIrPdn7ksLZHUggrisY6DuNgQPJzKNhpku8QbhSMgs3xhV5cBagcPYkHF+3Hm2j6qQBe+fLFZ3cY4/vfJJVPxu/K0FaCTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143814; c=relaxed/simple;
	bh=7nVt3hJRNv8Y1TTfxyAmSPl7PgcYwNa0Ckx272J3/3c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXZF1Zga70URt3hOfCQKJ3JUUSpn5gz0HrFbXBApsn2TyzaZfAc/z8dMWTs0JDrCRNVLFzQe2mdM8rB6F44wfWPY0aa/nJR59qzZ/Q463/wPPZm4vBu7DNEoCg6daqKENOEee144TEAood2YKffYe9JXL81AptL84RIoJzCc5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2tlfq6O; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709143812; x=1740679812;
  h=message-id:subject:from:reply-to:to:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7nVt3hJRNv8Y1TTfxyAmSPl7PgcYwNa0Ckx272J3/3c=;
  b=l2tlfq6O+FHzYszTPdPEezEBhHhegL+BY6snC1MuEyzNVQ5puLkgBuC9
   tyESXMHoRaoybFzg6uIkeY+G16bErNxWvSPXEP4ieMkkaIuGwmeTo+BBL
   DwVZQrjzhS/BxVusyHhmSITjM+A7SWyp3J5iscueGBCJKw8JqWiaWAQSo
   ZWXOQeDwdqM9HJHl6UU2/nxcw0b4UZt9yPONDbjTRk9sRvIHhJeyTfxyu
   xH4AGG0iGrzSJizripBvkeHMp+cBTiY+v3DuaoeakIRRCHmglsuxU+u5W
   FeO6vkY2VmNP/oIg6TuD/N3g28fvCn5okvUZX8PF0rfU3MnjRvd9O/bW6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14274255"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14274255"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12230615"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:10:11 -0800
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
	by linux.intel.com (Postfix) with ESMTP id 1EB48580B99;
	Wed, 28 Feb 2024 10:10:11 -0800 (PST)
Message-ID: <2dba47561b467c483263b65606aa3e79c05c91a3.camel@linux.intel.com>
Subject: Re: [PATCH V2 2/9] platform/x86/intel/sdsi: Combine read and write
 mailbox flows
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Date: Wed, 28 Feb 2024 10:10:11 -0800
In-Reply-To: <dd9ab7d1-5c03-404a-90c7-7ccbc0fb5c4c@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
	 <20240228000016.1685518-3-david.e.box@linux.intel.com>
	 <dd9ab7d1-5c03-404a-90c7-7ccbc0fb5c4c@linux.intel.com>
Autocrypt: addr=david.e.box@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBF2w2YABCACw5TpqmFTR6SgsrNqZE8ro1q2lUgVZda26qIi8GeHmVBmu572RfPydisEpCK246rYM5YY9XAps810ZxgFlLyBqpE/rxB4Dqvh04QePD6fQNui/QCSpyZ6j9F8zl0zutOjfNTIQBkcar28hazL9I8CGnnMko21QDl4pkrq1dgLSgl2r2N1a6LJ2l8lLnQ1NJgPAev4BWo4WAwH2rZ94aukzAlkFizjZXmB/6em+lhinTR9hUeXpTwcaAvmCHmrUMxeOyhx+csO1uAPUjxL7olj2J83dv297RrpjMkDyuUOv8EJlPjvVogJF1QOd5MlkWdj+6vnVDRfO8zUwm2pqg25DABEBAAG0KkRhdmlkIEUuIEJveCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPokBTgQTAQgAOBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH7Mry1gl3p/NusIAK9z1xnXphedgZMGNzifGUs2UUw/xNl91Q9qRaYGyNYATI6E7zBYmynsUL/4yNFnXK8P/I7WMffiLoMqmUvNp9pG6oYYj8ouvbCexS21jgw54I3m61M+wTokieRIO/GettVlCGhz7YHlHtGGqhzzWB3CGPSJMwsouDPvyFFE+28p5d2v9l6rXSb7T297Kh50VX9Ele8QEKngrG+Z/u2lr/bHEhvx24vI8ka22cuTaZvThYMwLTSC4kq9L9WgRv31JBSa1pcbcHLOCoUl0RaQwe6J8w9hN2uxCssHrrfhSA4YjxKNIIp3YH4IpvzuDR3AadYz1klFTnEOxIM7fvQ2iGu5AQ0EXbDZgAEIAPGbL3wvbYUDGMoBSN89GtiC6ybWo28JSiYIN5N9LhDTwfWROenkRvmTESaE5fAM24sh8S0h+F+eQ7j/E/RF3pM31gSovTKw0Pxk7GorK
	FSa25CWemxSV97zV8fVegGkgfZkBMLUId+AYCD1d2R+tndtgjrHtVq/AeN0N09xv/d3a+Xzc4ib/SQh9mM50ksqiDY70EDe8hgPddYH80jHJtXFVA7Ar1ew24TIBF2rxYZQJGLe+Mt2zAzxOYeQTCW7WumD/ZoyMm7bg46/2rtricKnpaACM7M0r7g+1gUBowFjF4gFqY0tbLVQEB/H5e9We/C2zLG9r5/Lt22dj7I8A6kAEQEAAYkBNgQYAQgAIBYhBBFoZ8DYRC+DyeuV6X7Mry1gl3p/BQJdsNmAAhsMAAoJEH7Mry1gl3p/Z/AH/Re8YwzY5I9ByPM56B3Vkrh8qihZjsF7/WB14Ygl0HFzKSkSMTJ+fvZv19bk3lPIQi5lUBuU5rNruDNowCsnvXr+sFxFyTbXw0AQXIsnX+EkMg/JO+/V/UszZiqZPkvHsQipCFVLod/3G/yig9RUO7A/1efRi0E1iJAa6qHrPqE/kJANbz/x+9wcx1VfFwraFXbdT/P2JeOcW/USW89wzMRmOo+AiBSnTI4xvb1s/TxSfoLZvtoj2MR+2PW1zBALWYUKHOzhfFKs3cMufwIIoQUPVqGVeH+u6Asun6ZpNRxdDONop+uEXHe6q6LzI/NnczqoZQLhM8d1XqokYax/IZ4=
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 18:38 -0800, Kuppuswamy Sathyanarayanan wrote:
>=20
> On 2/27/24 4:00 PM, David E. Box wrote:
> > The current mailbox commands are either read-only or write-only and the
> > flow is different for each. New commands will need to send and receive
> > data. In preparation for these commands, create a common polling functi=
on
> > to handle sending data and receiving in the same transaction.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >=20
> > V2 - In sdsi_cmd_read() remove unnecessary check for non-zero packet_si=
ze
> > =C2=A0=C2=A0=C2=A0=C2=A0 in do loop since the loop is exited earlier wh=
en packet_size is
> > =C2=A0=C2=A0=C2=A0=C2=A0 zero.
> >=20
> > =C2=A0drivers/platform/x86/intel/sdsi.c | 79 +++++++++++++++++---------=
-----
> > =C2=A01 file changed, 44 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/sdsi.c
> > b/drivers/platform/x86/intel/sdsi.c
> > index a70c071de6e2..d80c2dc0ce71 100644
> > --- a/drivers/platform/x86/intel/sdsi.c
> > +++ b/drivers/platform/x86/intel/sdsi.c
> > @@ -15,6 +15,7 @@
> > =C2=A0#include <linux/iopoll.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/module.h>
> > +#include <linux/overflow.h>
> > =C2=A0#include <linux/pci.h>
> > =C2=A0#include <linux/slab.h>
> > =C2=A0#include <linux/sysfs.h>
> > @@ -156,8 +157,8 @@ static int sdsi_status_to_errno(u32 status)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > -static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox=
_info
> > *info,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t *data_size)
> > +static int sdsi_mbox_poll(struct sdsi_priv *priv, struct sdsi_mbox_inf=
o
> > *info,
> > +			=C2=A0 size_t *data_size)
> > =C2=A0{
> > =C2=A0	struct device *dev =3D priv->dev;
> > =C2=A0	u32 total, loop, eom, status, message_size;
> > @@ -166,18 +167,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *p=
riv,
> > struct sdsi_mbox_info *inf
> > =C2=A0
> > =C2=A0	lockdep_assert_held(&priv->mb_lock);
> > =C2=A0
> > -	/* Format and send the read command */
> > -	control =3D FIELD_PREP(CTRL_EOM, 1) |
> > -		=C2=A0 FIELD_PREP(CTRL_SOM, 1) |
> > -		=C2=A0 FIELD_PREP(CTRL_RUN_BUSY, 1) |
> > -		=C2=A0 FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> > -	writeq(control, priv->control_addr);
> > -
> > =C2=A0	/* For reads, data sizes that are larger than the mailbox size a=
re
> > read in packets. */
> > =C2=A0	total =3D 0;
> > =C2=A0	loop =3D 0;
> > =C2=A0	do {
> > -		void *buf =3D info->buffer + (SDSI_SIZE_MAILBOX * loop);
> > =C2=A0		u32 packet_size;
> > =C2=A0
> > =C2=A0		/* Poll on ready bit */
> > @@ -195,6 +188,11 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *pr=
iv,
> > struct sdsi_mbox_info *inf
> > =C2=A0		if (ret)
> > =C2=A0			break;
> > =C2=A0
> > +		if (!packet_size) {
> > +			sdsi_complete_transaction(priv);
> > +			break;
> > +		}
> > +
> > =C2=A0		/* Only the last packet can be less than the mailbox size.
> > */
> > =C2=A0		if (!eom && packet_size !=3D SDSI_SIZE_MAILBOX) {
> > =C2=A0			dev_err(dev, "Invalid packet size\n");
> > @@ -208,9 +206,13 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *pr=
iv,
> > struct sdsi_mbox_info *inf
> > =C2=A0			break;
> > =C2=A0		}
> > =C2=A0
> > -		sdsi_memcpy64_fromio(buf, priv->mbox_addr,
> > round_up(packet_size, SDSI_SIZE_CMD));
> > +		if (info->buffer) {
> > +			void *buf =3D info->buffer +
> > array_size(SDSI_SIZE_MAILBOX, loop);
> > =C2=A0
> > -		total +=3D packet_size;
> > +			sdsi_memcpy64_fromio(buf, priv->mbox_addr,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 round_up(packet_size,
> > SDSI_SIZE_CMD));
> > +			total +=3D packet_size;
> > +		}
> > =C2=A0
> > =C2=A0		sdsi_complete_transaction(priv);
> > =C2=A0	} while (!eom && ++loop < MBOX_MAX_PACKETS);
> > @@ -230,16 +232,33 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *p=
riv,
> > struct sdsi_mbox_info *inf
> > =C2=A0		dev_warn(dev, "Read count %u differs from expected count
> > %u\n",
> > =C2=A0			 total, message_size);
> > =C2=A0
> > -	*data_size =3D total;
> > +	if (data_size)
> > +		*data_size =3D total;
> > =C2=A0
>=20
> Is there a chance for it to be NULL with current callers?

Yes. Write only callers set this to NULL.

David

