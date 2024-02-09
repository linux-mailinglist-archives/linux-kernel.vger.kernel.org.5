Return-Path: <linux-kernel+bounces-59486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9084F7C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184D1B2329D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD6D69DF9;
	Fri,  9 Feb 2024 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMEOghU7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42C6DD1E;
	Fri,  9 Feb 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489716; cv=none; b=j8brSjdbbWJgsdFztTXW9RoNm/rk9Ywevylbqrfz0+LJwlxw3IcdJuK5F3PG0p3zoPBeCob8QmGS6k6rCB2r/y8SOMogU9uE6IRzG6mBJB6hCdJXjEi+umbIJbi4h5JaG3qoJ0jkAGtqmzfNwTPvcQ5mOgKeai0PFGCXKhkaMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489716; c=relaxed/simple;
	bh=j68vyMhx+KOvb0NoTod5BOmz14iYjHTu4xiog85c8js=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVoz/8ZqlGyUcISeympND+eVzJ2QVUIXzTncTmbDR+5u6QWvVfQdInWo5SXDWKO6ih2G/VNSEFVmhfPdT5x3CPvlIMqTbiGEfYWflbKPiJuD/nAQ+ZKAejMGICz2PQ8ThBJcacDWmNUUFv1cDheW+yAvxV4MlSZkCK9eadg/VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMEOghU7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707489716; x=1739025716;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=j68vyMhx+KOvb0NoTod5BOmz14iYjHTu4xiog85c8js=;
  b=XMEOghU7y0Q+2Fh+ncGBomORRy6DWfraSkRGs4RkI0Q8oAcA2XE92Cze
   o4kdQah3IRrbYbkFzDMDcTRiofc4xE00mVL03sWaqMFEMMTdGi5WRCzYk
   9PJONwxt1/qfv3zM0SUM4E3rhOpMMapN6igAhAHtxod9P7czrff/1ZjhN
   81WKMhGp53MOAARkJoND8fv3VRRLKoryan7L3lUK9AGCrFnsMnnQy0Rni
   uGulGpGm4eIhngKig3wueqpJuy5Bzfd/mjq/hT7LRXazlT7jxMRpg2ng/
   ci9jxUf2WFIBbqJg+8aJGPzV+55RiklLwcT78T1TQ2Jb7vo1BcZcvEQEy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1591700"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1591700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1939708"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:41:54 -0800
Message-ID: <64ee580b9969335d60966e23e9bd859e8f075953.camel@linux.intel.com>
Subject: Re: [PATCH] HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI
 S3 suspend
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Even Xu <even.xu@intel.com>, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 09 Feb 2024 06:41:53 -0800
In-Reply-To: <20240209065232.15486-1-even.xu@intel.com>
References: <20240209065232.15486-1-even.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 14:52 +0800, Even Xu wrote:
> After legacy suspend/resume via ACPI S3, sensor read operation fails
> with timeout. Also, it will cause delay in resume operation as there
> will be retries on failure.
>=20
> This is caused by commit f645a90e8ff7 ("HID: intel-ish-hid:
> ishtp-hid-client: use helper functions for connection"), which used
> helper functions to simplify connect, reset and disconnect process.
> Also avoid freeing and allocating client buffers again during
> reconnect
> process.
>=20
> But there is a case, when ISH firmware resets after ACPI S3 suspend,
> ishtp bus driver frees client buffers. Since there is no realloc
> again
> during reconnect, there are no client buffers available to send
> connection
> requests to the firmware. Without successful connection to the
> firmware,
> subsequent sensor reads will timeout.
>=20
> To address this issue, ishtp bus driver does not free client buffers
> on
> warm reset after S3 resume. Simply add the buffers from the read list
> to free list of buffers.
>=20
> Fixes: f645a90e8ff7 ("HID: intel-ish-hid: ishtp-hid-client: use
> helper functions for connection")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218442
> Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Hi Jiri,

This regression is introduced with 6.8-rc1, so need a pull request for
this rc cycle.

Thanks,
Srinivas

> ---
> =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c=C2=A0=C2=A0=C2=A0 | 2 ++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/client.c | 4 +++-
> =C2=A02 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index aa6cb033bb06..03d5601ce807 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -722,6 +722,8 @@ void ishtp_bus_remove_all_clients(struct
> ishtp_device *ishtp_dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&ishtp_=
dev->cl_list_lock, flags);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry(cl, &=
ishtp_dev->cl_list, link) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0cl->state =3D ISHTP_CL_DISCONNECTED;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (warm_reset && cl->device->reference_count)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Wake any pending process. The waiter would check
> dev->state
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c
> b/drivers/hid/intel-ish-hid/ishtp/client.c
> index 82c907f01bd3..8a7f2f6a4f86 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client.c
> @@ -49,7 +49,9 @@ static void ishtp_read_list_flush(struct ishtp_cl
> *cl)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry_safe(=
rb, next, &cl->dev->read_list.list,
> list)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (rb->cl && ishtp_cl_cmp_id(cl, rb->cl)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lis=
t_del(&rb->list);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ishtp_io_=
rb_free(rb);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock=
(&cl->free_list_spinlock);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_add_=
tail(&rb->list, &cl-
> >free_rb_list.list);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlo=
ck(&cl->free_list_spinlock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irqrestore(&c=
l->dev->read_list_spinlock, flags);
> =C2=A0}


