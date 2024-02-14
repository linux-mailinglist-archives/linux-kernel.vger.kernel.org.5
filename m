Return-Path: <linux-kernel+bounces-65381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCCC854C27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A91A1C264D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D195BAC2;
	Wed, 14 Feb 2024 15:05:05 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6791C5B5DB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923105; cv=none; b=kMzwsr3FPoOiohu1o7ZJDR8t3Vfhlpo0T6na3OMDfBg8x3zF0ne9LiGcDP6GJ/7lwKepBwmCvnsdJpZj1kpJx12t2pvEkm7GlEogb6iHTZoWjF2p2gqAFoZ4D5qllNZ9SxvVFQVjICllEv34bcrfteGmknpsU+Mc7wdjEuvmO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923105; c=relaxed/simple;
	bh=77hqZacp7RPt/Y7Aykf062O5VL0oTkoRQ9q8TQoSnXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlaeMRgpzD2VNI2kW2R7Er+aMEBLTQ5WkFUprDfEvBF4wR8+b6yJXuFeKn72Fy4mzMiFslKQLq1opAJR6P3B1k/dID2vqRdDXo1Javu4moc9rOD/yggamlzNzhYrq/tNbG3mC9yRjaRU/hjeKF2a6Su1UafoypAZ8v2w3q6g6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 403091 invoked by uid 1000); 14 Feb 2024 10:04:56 -0500
Date: Wed, 14 Feb 2024 10:04:56 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Selvarasu Ganesan <quic_selvaras@quicinc.com>
Cc: tern@rowland.harvard.edu, gregkh@linuxfoundation.org,
  linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
  quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH] usb-storage: Add US_FL_FIX_INQUIRY quirk for Intenso
 Twist Line USB 3.2
Message-ID: <39cd8789-7764-4904-8cb9-21f239b3c04c@rowland.harvard.edu>
References: <20240214111721.18346-1-quic_selvaras@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214111721.18346-1-quic_selvaras@quicinc.com>

On Wed, Feb 14, 2024 at 03:17:21AM -0800, Selvarasu Ganesan wrote:
> The Intenso Twist Line USB 3.2 flash drive fails to respond to the
> INQUIRY data stage request for a 36 bulk in request from the host. This
> commit adds the US_FL_FIX_INQUIRY flag to fake the INQUIRY command for
> this device, preventing a storage enumeration failure.
> 
> USBMON log:
> ffffff8a3ee06a00 3192811972 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
> ffffff8a3ee06a00 3192862051 C Ci:2:009:0 -2 0
> ffffff8a3ee06a00 3192862185 S Ci:2:009:0 s c0 33 0000 0000 0002 2 <
> ffffff8a3ee06a00 3192912299 C Ci:2:009:0 -2 0
> ffffff8a3ee06e00 3193040068 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
> ffffff8a3ee06e00 3193040214 C Ci:2:003:0 0 4 = 880b0700
> ffffff8a3ee06e00 3193040279 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
> ffffff8a3ee06e00 3193040427 C Ci:2:002:0 0 4 = 00010000
> ffffff8a3ee06e00 3193040470 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
> ffffff8a3ee06e00 3193040672 C Ci:2:002:0 0 4 = 03050000
> ffffff892b309500 3193824092 S Ci:2:009:0 s a1 fe 0000 0000 0001 1 <
> ffffff892b309500 3193824715 C Ci:2:009:0 0 1 = 00
> ffffff892b309500 3193825060 S Bo:2:009:2 -115 31 = 55534243 01000000 24000000 80000612 00000024 00000000 00000000 000000
> ffffff892b309500 3193825150 C Bo:2:009:2 0 31 >
> ffffff8b8419d400 3193825737 S Bi:2:009:1 -115 36 <
> ffffff8a3ee06400 3194040175 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <
> ffffff8a3ee06400 3194040372 C Ci:2:003:0 0 4 = 880b0700
> ffffff89bee5b100 3194040591 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
> ffffff89bee5b100 3194040681 C Ci:2:002:0 0 4 = 00010000
> ffffff89bee5b100 3194040999 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
> ffffff89bee5b100 3194041083 C Ci:2:002:0 0 4 = 03050000
> ffffff8a3ee06a00 3195040349 S Ci:2:003:0 s c1 04 0930 bf80 0004 4 <

This is very surprising.  A mass-storage device that doesn't respond to 
INQUIRY commands won't work with Windows or Mac OSX.  Have you tried 
testing the device with those operating systems to see what they send 
and how it responds?

Alan Stern

