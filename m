Return-Path: <linux-kernel+bounces-46507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263878440B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285D41C2A0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32D7F495;
	Wed, 31 Jan 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrqadjBR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9279DB2;
	Wed, 31 Jan 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708216; cv=none; b=W09WisMduquRfW3u84waGlaQO+6geTiGQdzmr6AqttpIIzFUQbs2P8hcyydWl6x1CKx0rZvkKqx8LCKcBRWx3EhLjHGsXxKwyZTSEcZJnD1prD4RyyW5ZS8Bq88O+O68oBCTuktrq+l1IQLAwKF4NUmLatMBy+dVmL9jwiFIG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708216; c=relaxed/simple;
	bh=nadzkVbnmNxY4/DIbqPxR5fBiBmBnpW4pu3x3zRyu6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB3QkOHEVAE3ljF41VAgdtqQ2TxXVFiYBq/YH9z/+m1EWIk3oDqXWZTr8Nw5jz5VFeIpmys/24VGCFEuU9WfJUHm0mZDib1k3MWx0j4+dp5bvsTBvU092nvKxDJ4zRrIOPlfW9z21UxJcdMf9WoqDVRrUPiRPq7Is7Bfh6wkwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrqadjBR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706708215; x=1738244215;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nadzkVbnmNxY4/DIbqPxR5fBiBmBnpW4pu3x3zRyu6Q=;
  b=VrqadjBROnOxb+p/n3GyqoaHD0ogjSSu/2ET2575jX4J6tK1PQFZtB4I
   l/C4c+f2OkeGHWaATC4DGq82NvzCHxTCPdPU+EoVjv+ocCejTYpaMcc79
   N7DpShqX5mLjsE6M8D/HbngHhUUusq44yivKf8l38rEY7K5JTaz3953+q
   ODiiOQqX+WSUp/q54ZUffcgYyjnEnUQJBByDcx5KTfbWbKVKNF0O4muUb
   ZTUhY/aNeoET+W4T91JBSz4nF86KNPKOP6As8n3fHrtrWJfh+A77/lizH
   d4rfT07Du8Iu8ygA0OEz06WZiIuAUg1HsRXmY9ruqagHVd7LfKVMoz0zh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2540746"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2540746"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4164782"
Received: from bkucman-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.48.222])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:36:51 -0800
Date: Wed, 31 Jan 2024 14:36:40 +0100
From: Blazej Kucman <blazej.kucman@linux.intel.com>
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Dan Moulding <dan@danm.net>,
 carlos@fisica.ufpr.br, gregkh@linuxfoundation.org, junxiao.bi@oracle.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org, "yukuai (C)"
 <yukuai3@huawei.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Message-ID: <20240131143640.00003296@linux.intel.com>
In-Reply-To: <CAPhsuW7QHq4e+cHvZcw8c=ePpeSM69UKTEi8P40=-jOZn+YyyA@mail.gmail.com>
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
	<20240126154610.24755-1-dan@danm.net>
	<20240130172524.0000417b@linux.intel.com>
	<95f2e08e-2daf-e298-e696-42ebfa7b9bbf@huaweicloud.com>
	<CAPhsuW7QHq4e+cHvZcw8c=ePpeSM69UKTEi8P40=-jOZn+YyyA@mail.gmail.com>
Organization: intel
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jan 2024 20:55:39 -0800
Song Liu <song@kernel.org> wrote:

> On Tue, Jan 30, 2024 at 6:41=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com>
> >
> > Can you test the following patch?
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index e3a56a958b47..a8db84c200fe 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -578,8 +578,12 @@ static void submit_flushes(struct work_struct
> > *ws) rcu_read_lock();
> >                  }
> >          rcu_read_unlock();
> > -       if (atomic_dec_and_test(&mddev->flush_pending))
> > +       if (atomic_dec_and_test(&mddev->flush_pending)) {
> > +               /* The pair is percpu_ref_get() from
> > md_flush_request() */
> > +               percpu_ref_put(&mddev->active_io);
> > +
> >                  queue_work(md_wq, &mddev->flush_work);
> > +       }
> >   }
> >
> >   static void md_submit_flush_data(struct work_struct *ws) =20
>=20
> This fixes the issue in my tests. Please submit the official patch.
> Also, we should add a test in mdadm/tests to cover this case.
>=20
> Thanks,
> Song
>=20

Hi Kuai,

On my hardware issue also stopped reproducing with this fix.=20

I applied the fix on current HEAD of master
branch in kernel/git/torvalds/linux.git repo.

Thansk,
Blazej




