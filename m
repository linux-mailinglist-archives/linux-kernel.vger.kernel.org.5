Return-Path: <linux-kernel+bounces-90639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D534D87029E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885EB1F21A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A93D982;
	Mon,  4 Mar 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jmmr/ecJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F23D578;
	Mon,  4 Mar 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558714; cv=none; b=t8FSCVgsEigVWgQcq2y3vVZ4pQAvoGVlKsvCYlHcduylbCGqv7ime8mSk418fqsh4QoJ0GPsO2uh8xve0wgbHVhuvMQfcTGa9mYySHSws1ZvMGs8RCbcM/VWhJhdshOSb4ss4ULyp7nx4ko4keaPJTFMADCoWnnfAubwpdBhTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558714; c=relaxed/simple;
	bh=mE7WbTRPh0y+V6gk6+gRHEpzW2RaqAFTJA9wLdw90Hw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Uz8mWiLyJdhUfD40jaVKPRJRRgBXTF8BXqApYJJ8XAKuv4kf4U1O74pXSSFcRX0Zh5vqRQ805MQFOBE2LlJLgff07XJt+14QBZgn3Crw/q8JN5afHnrEUbonsysvHrIAkY5FgjhdT+s/7F3TWwTwJ57D/ZIq3nYshXYkiCSdC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jmmr/ecJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558713; x=1741094713;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mE7WbTRPh0y+V6gk6+gRHEpzW2RaqAFTJA9wLdw90Hw=;
  b=Jmmr/ecJ62mbgMHYC9iH+7OGCE7Mu+R1UmvprjwUHYhWdqYsi8zwADLJ
   sszOwDqoEn0y6BerjCm2vPSGG5giEppEtd5sNZB44LNgc6zhk6xOdB/Gk
   aKkoHiC8sBMi9QXrizwqSHFvFwnguEBOiioMa/SYDy3tGKa8M6N6KNJy2
   MytQw/I6s3FbqYJnbPaQr45fx3w+5kHW+tptcHerN2i7F9qoCn7AsyauW
   bEZcNQZFml9VFtU32RPdlv6dQH9nTvHOAzBfBRCjJjagqhSAMX+UJc3H2
   apK1XD2OcOPKRqfUfEy5EaqrzQvTWTXpKxh+qM/hWreh3u3X1cBSxILKc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26513704"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="26513704"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9369745"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:25:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 15:25:05 +0200 (EET)
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
cc: "David E. Box" <david.e.box@linux.intel.com>, rajvi.jingar@linux.intel.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH V2 2/9] platform/x86/intel/sdsi: Combine read and write
 mailbox flows
In-Reply-To: <dd9ab7d1-5c03-404a-90c7-7ccbc0fb5c4c@linux.intel.com>
Message-ID: <b7b842e8-2609-aa8f-f90a-27a8ee8327cb@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com> <20240228000016.1685518-3-david.e.box@linux.intel.com> <dd9ab7d1-5c03-404a-90c7-7ccbc0fb5c4c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1914460003-1709558705=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1914460003-1709558705=:986
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Feb 2024, Kuppuswamy Sathyanarayanan wrote:
> On 2/27/24 4:00 PM, David E. Box wrote:
> > The current mailbox commands are either read-only or write-only and the
> > flow is different for each. New commands will need to send and receive
> > data. In preparation for these commands, create a common polling functi=
on
> > to handle sending data and receiving in the same transaction.
> >
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >
> > V2 - In sdsi_cmd_read() remove unnecessary check for non-zero packet_si=
ze
> >      in do loop since the loop is exited earlier when packet_size is
> >      zero.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1914460003-1709558705=:986--

