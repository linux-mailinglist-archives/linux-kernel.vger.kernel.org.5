Return-Path: <linux-kernel+bounces-86682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5D86C8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2128C1C22489
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345167D06D;
	Thu, 29 Feb 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkSQySyR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE377CF20
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208932; cv=none; b=SUKRxaeXt5LBxDennLpxiQSTYmVLt60XlRx64ptHIjDvlXVkVFjfQjMCoyFgy9RFOMbIhcWoPeRYgupIux+HJtejBRMpKMF2jWswM8C35BAEWWwi2uTl75bbTOuDrOc0kwXwxZe/6fY3SrElqXTXV5h2yysradiTLGkbuy4Q1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208932; c=relaxed/simple;
	bh=7JW5a96LhXrKrTtbr+0l/ZJtLu422Uf2mF5PXmTYswI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Cc:From:To:
	 Subject:Message-ID:Date; b=MWMNDkmhqLYybok0XZluJbeWWT8LVuFAAE/USVtQ7U7tcLrcQg02H5QVBrSfFV5Qmudjrsruav8ztAHgXEW6j8wTYRtujdgxaD1lN9Ffk733XoJolONCKkrlQIXnsXWSMyf+gYxsxYEtGbFJGj6kk9bU3tKWohb8Gb0LAFmTHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkSQySyR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709208931; x=1740744931;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:cc:from:to:subject:message-id:date;
  bh=7JW5a96LhXrKrTtbr+0l/ZJtLu422Uf2mF5PXmTYswI=;
  b=gkSQySyRmKxX6139tDTfRO4Hl/wZHGy6aOT7tJqVx/fKLWNovE8o6blk
   fGFq+NPx93RRoTxagt3MXkFZwVl4PFA0BcI0NYlQamyZKxUymqqV2TPUj
   EDDha3atdc0jZaMT2RXMZLP6lM3qPr/OiUByeWXQ1F1X2ouKRtjjSVrhm
   VT5QhMsV/5THk3ELyKXtMnWacQ+E46Rqv55tWMQSXDw5EkhsSkBd9SoBb
   2ZCGsuVxdgjADT1gvOd4IjtMtefqzUwoSKskRQPH0DSNfXjMAE7qDlz+L
   p4GCRSzklDL43eTzH6nXbGKmUViIgudLAr2AnAy9PyNuckmWI2m015Uhn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3552419"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3552419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:15:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38649580"
Received: from unknown (HELO localhost) ([10.245.244.80])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:15:27 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
References: <20240228142240.2539358-1-tvrtko.ursulin@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update email address for Tvrtko Ursulin
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <170920892379.4178.17894356700899757288@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date: Thu, 29 Feb 2024 14:15:23 +0200

Quoting Tvrtko Ursulin (2024-02-28 16:22:40)
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>=20
> I will lose access to my @.*intel.com e-mail addresses soon so let me
> adjust the maintainers entry and update the mailmap too.
>=20
> While at it consolidate a few other of my old emails to point to the
> main one.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

Acked-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Regards, Joonas

