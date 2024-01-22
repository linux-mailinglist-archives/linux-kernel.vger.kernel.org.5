Return-Path: <linux-kernel+bounces-33968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CCC83710C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724B71C293FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B2487AB;
	Mon, 22 Jan 2024 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXuBM0uX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0695A107;
	Mon, 22 Jan 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947573; cv=none; b=tBivJMg5tDQZmNEx0be+hAXvqYgFR/Vrpisax6OXgZZs9DVOwQBMOAGS5xXMzZo457Tg3ynCBxJdNFS89JUuKnpbo71zy0APNsNvJQjBLLNLw0FfwlQEQawNNigqmon8u3rnnVyDEKDYn7nMxxIW8CpmuOFPkoDrCS07vkN+wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947573; c=relaxed/simple;
	bh=swZ6pIRu+dIDL5S263ggqS4f6C3ZBFvdtjbOcRTvwwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOyePOtQ5SuR0gmPYSZb1SJo6yfDErGq/1TSPV4ieAox8AmhupacfRqP3+ENgSsacW+vZiYRun6jJ/kBSgCQXN2eXmdPf5NNMNiWIrYV4EkBVyg2StCVHGeBbe1pkYWTkf849L1BwcgMY6u1W5QYMMimR2ce4cwln8Zu0w3WZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXuBM0uX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705947572; x=1737483572;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=swZ6pIRu+dIDL5S263ggqS4f6C3ZBFvdtjbOcRTvwwg=;
  b=TXuBM0uXrwasSO7k+8JRVS1txuZ2TBj0nYPmJKpT7GWGFs++SkfSOTyQ
   yXnyGvNd27UmhEAHrvhsoaeJ+2Jud8AsccRSkLWmMc11Wcjv+b4pwm8Ji
   LFbtfaq5d76JUkvgU0cTHP8dpmEmIK1kcSYT4Z4V2NgErJEx82a3dKDuU
   l7YD5TbCigvhn5HFwRmDRQkbk5SjQPB1M2Knv4eYu1QwAV+GgbZvvs6qc
   lwh0xizZ+f1k07XoOOy4pXNjzyxg/+B6djyP8UEGrw5IJfEuMIiSFhmES
   15iPNr1SiL2J9jX3xzsa0m+0VFHbR4MQLpNoLUUsffiRpjOC+du1hE2FO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8041026"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8041026"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1297694"
Received: from ishandes-mobl1.amr.corp.intel.com (HELO [10.209.49.194]) ([10.209.49.194])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:19:31 -0800
Message-ID: <0928660b39aea2828a79a87fef57447e657d43b4.camel@linux.intel.com>
Subject: Re: [PATCH] tick-sched: fix idle and iowait sleeptime accounting vs
 CPU hotplug
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Heiko Carstens <hca@linux.ibm.com>, Frederic Weisbecker
	 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	 <mingo@kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Alexander Gordeev
	 <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 22 Jan 2024 10:19:30 -0800
In-Reply-To: <20240115163555.1004144-1-hca@linux.ibm.com>
References: <20240115163555.1004144-1-hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 17:35 +0100, Heiko Carstens wrote:
>=20
> =20
> +	idle_sleeptime =3D ts->idle_sleeptime;
> +	iowait_sleeptime =3D ts->iowait_sleeptime;
>  	memset(ts, 0, sizeof(*ts));
> +	ts->idle_sleeptime =3D idle_sleeptime;
> +	ts->iowait_sleeptime =3D iowait_sleeptime;
>  }

Should idle_calls and idle_sleeps be preserved and
restored too? =C2=A0

Seems like if we preserve the
idle_sleeptime, and wish to compute the average
sleep time per sleep, we will need to know the value of
idle_sleeps that's also preserved across CPU offline/online.

Tim

