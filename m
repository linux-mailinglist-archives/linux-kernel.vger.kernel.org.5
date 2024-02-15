Return-Path: <linux-kernel+bounces-66895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C292D85633C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEA3B20F77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CB12CD80;
	Thu, 15 Feb 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTLykivq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F226AC1;
	Thu, 15 Feb 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000379; cv=none; b=GKatZA6QlwhtweurE14q8QCNiKwS7awWgjULJiE0KC7QuiPiP85CNJ1AWSZzrtOqrHHY0ebi5WexXIqKUb+/A+ojE6gi6AbfjwJQUghvuAAnxJnFzbtTRLYk7cRyaUd4KUpGzsrwWIYl0Q9Y2E+3C+qOlxJMUEN68chTJ7CD3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000379; c=relaxed/simple;
	bh=+yZHVOxPwtSHgYOsHfdC9zc8dcNjdL8/ctIdxLRviB0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AgJ4WRYXO2iP0eDIMjgrkB/094O85mvun67DLwN4UqMMEXTqebfH5+qgRqnAv/K3hjnGMUtH4+AygXP59VcQxk3DHSfi2P/HugOU5h1xlZo7PZEWo1B3n4hg1U9GRcHDCc/4c1uL8LsWA2wCZlGtH5U0uEHecn0emnZ4fkN8mJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTLykivq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708000378; x=1739536378;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+yZHVOxPwtSHgYOsHfdC9zc8dcNjdL8/ctIdxLRviB0=;
  b=NTLykivqdq5OzwiI7m/i7fi9ZcxXtmpWHgfQmRJdLuzvGwgHTVVr0N/W
   eaNjLl0GAnRJa8DlgyU7aNg68qpNDddVaMfN1l820zepy5c0InYbRfcDh
   HT2ioxfOgRf9IIolnw9prrg9yphHbt7Ou+rqGUO4y7zOEJnfwy/iDJazw
   q5fl9+pFjbk8gSC29WR7YHcBzrbsVBideg/bxMi1ZF2tlgFUeHxUWsMVn
   pTR9+TnCPzAw65Lhu7gbRXiFztOv7/7it9RzU96aTVRUovinst57IbnME
   aiT3IktfkJNV6xR85gB2RLYRePmCdJqsKEMvHupxSjWZMNfUg94R3WJ+p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13479812"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="13479812"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8147113"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.150])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:32:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Feb 2024 14:32:14 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] platform/x86: wmi: Prevent incompatible event driver
 from probing
In-Reply-To: <20240214070433.2677-2-W_Armin@gmx.de>
Message-ID: <d7d3ed2d-bee9-13de-fb3c-faf229ed92d5@linux.intel.com>
References: <20240214070433.2677-1-W_Armin@gmx.de> <20240214070433.2677-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Armin Wolf wrote:

> If a WMI event driver has no_notify_data set, then he indicates

Drivers are not "he". :-)

-- 
 i.


