Return-Path: <linux-kernel+bounces-34297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256348377C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5867B1C240AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A64E1AC;
	Mon, 22 Jan 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7Gp1DGx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30474D59A;
	Mon, 22 Jan 2024 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966410; cv=none; b=YwGBhD8KS+bVfXLAlKwcZvPhu6evbaCsrprpire0k5AcF7fEBXfpQXiXue6hH2DkHd/UEwAe+ZQKLvHT5+si2sKpdug/dUb5p/0fHafcXTCJ5WpzZYMU2rheC4Cla9N0L1FnQlXcFTpIEGBiYc5X8pXRkRzaose4ncW3cYhbknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966410; c=relaxed/simple;
	bh=3ua4aeYsQyY22UzxCGBCdj5W+o+Q8xSEVa1JTmEzpJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KnHO0LCeVChoI8/njRxyMZo3ydUfm/bvjykWwhgQzLeyrpX+ELd2WkXyNH86vAr7+qsPFi73bojTkcYS6+yFTLOCTrcMAhiZKSgKrIznBsOoGeUV6MBEJgvYa3PSmjzkpQigTiKYl1NzLKRPFdkENfmW+rVj0uyLy5Q2JaVYxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7Gp1DGx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705966409; x=1737502409;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3ua4aeYsQyY22UzxCGBCdj5W+o+Q8xSEVa1JTmEzpJ4=;
  b=K7Gp1DGxNlD+ftKxFlxPdvLDnXv/SXb5SBvtgBPXbft9P7qwEvjN978c
   CYqO7b9fuB4CD56o5TwRIg6rclw8I9tJkeXRYSuZqVqH98mQ40ynuw+pG
   CN0DL0VGOIiii3Bd9A8fl/VXMsge2lW7RKTvJNAX3j+0o6tTsJcXh92TJ
   CRzcXoH6KuOJhgoGwXre6kj72LNNXLfAGWTGufyfD9SJs/0IqEspDFFDw
   e9jfnkZzw6QR5irYzchjstRWMC1C4hvhrb45b9vOIR/I3Lsx7hg5qgdZk
   NYwRUyLPjaRVBUzMQ3Y21Uu/Q44sizQNvAC0s6+m4jQj/a+M6Cb1gJwua
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8032317"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="8032317"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 15:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1117040587"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1117040587"
Received: from ishandes-mobl1.amr.corp.intel.com (HELO [10.209.49.194]) ([10.209.49.194])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 15:33:27 -0800
Message-ID: <d6b7203d11aac2d83ddcd181f05a6074388d32d4.camel@linux.intel.com>
Subject: Re: [PATCH] tick-sched: fix idle and iowait sleeptime accounting vs
 CPU hotplug
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 22 Jan 2024 15:33:27 -0800
In-Reply-To: <Za7swp31JRzGJwzS@pavilion.home>
References: <20240115163555.1004144-1-hca@linux.ibm.com>
	 <0928660b39aea2828a79a87fef57447e657d43b4.camel@linux.intel.com>
	 <Za7swp31JRzGJwzS@pavilion.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 23:31 +0100, Frederic Weisbecker wrote:
> Le Mon, Jan 22, 2024 at 10:19:30AM -0800, Tim Chen a =C3=A9crit :
> > On Mon, 2024-01-15 at 17:35 +0100, Heiko Carstens wrote:
> > >=20
> > > =20
> > > +	idle_sleeptime =3D ts->idle_sleeptime;
> > > +	iowait_sleeptime =3D ts->iowait_sleeptime;
> > >  	memset(ts, 0, sizeof(*ts));
> > > +	ts->idle_sleeptime =3D idle_sleeptime;
> > > +	ts->iowait_sleeptime =3D iowait_sleeptime;
> > >  }
> >=20
> > Should idle_calls and idle_sleeps be preserved and
> > restored too? =C2=A0
> >=20
> > Seems like if we preserve the
> > idle_sleeptime, and wish to compute the average
> > sleep time per sleep, we will need to know the value of
> > idle_sleeps that's also preserved across CPU offline/online.
>=20
> I guess those can be saved as well. Would you like to send the patch?
>=20

Okay, sent the patch in a separate email.

Tim

