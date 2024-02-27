Return-Path: <linux-kernel+bounces-83386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5746869721
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025681C22A38
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1901419A0;
	Tue, 27 Feb 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDU/MjjR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873578B61;
	Tue, 27 Feb 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043508; cv=none; b=IXspAXlj808R9GHfQbnCidlv1BCXv73BaGPvxvYOoCOA9fFL43r4jP1JUPPDpqTxL06Be70Um3cBAoWwTBORL80l0s3GY3iqOQI7gUq9pwynUVAphktwaCa1sLojYVLawFEgfdwMwqCtiJo2Ac5Fnp6AD7quRlKZXIyP5Yg+2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043508; c=relaxed/simple;
	bh=VueADUHrmKeLxfNkfS1pxBtKAFuatRLAfPYn6fpc3WM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IOjiQc54i4sG4QjZvJJl0yYoTQSbMLP8jhp+uDV2pykHkIZy07B2gfa0KN3JziVOfWtJSxWxQC34ZguUjKQJnvj7ZMcLsSxl+21xcsVt+GRnbcwYvkouuJOw77p8dnoOuheD4fmpBMOTBFRC1vhoBFnL/FsKQ7eM0osbGAuWmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDU/MjjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F76C433C7;
	Tue, 27 Feb 2024 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709043508;
	bh=VueADUHrmKeLxfNkfS1pxBtKAFuatRLAfPYn6fpc3WM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eDU/MjjRIO8ceHH8FKZsvTt/a84nWESIQbDEciknFmHlHHWp97KIHwgE07wP3UcSl
	 tffTIsgxmNKtD5la8gPOqczl2YWzzeIy7iW8S1EoyiriKTRks76t18jTEIXWxwJ+4u
	 ngKtZNkLNV7TNzeD9GvFBnFMsMvzbBxrxnvW38Vl6AJLY7mc+A5YJfoZZcer30BAux
	 YZTzT20uQxn79a31dGHUagXJMBgrhI9qlhqzGT1OypoHrdWh2NALVLz4JzSsE3iRMD
	 Rlx7tXxdNFe2ur3xGoLa4TeyfCW2gfz9QcWKrvtuEwOOF7W9/UQDsAmJlMmi5YhNZS
	 35UZjvet8U54g==
Date: Tue, 27 Feb 2024 15:18:29 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, kenalba@google.com, 
    dianders@chromium.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: avoid polling stylus battery on Chromebook
 Pompom
In-Reply-To: <ZdknA5qa8B-nB6ta@google.com>
Message-ID: <nycvar.YFH.7.76.2402271518110.21798@cbobk.fhfr.pm>
References: <ZdknA5qa8B-nB6ta@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Dmitry Torokhov wrote:

> Internal touchscreen on Trogdor Pompom (AKA Dynabook Chromebook C1)
> supports USI stylus. Unfortunately the HID descriptor for the stylus
> interface does not contain "Stylus" physical collection, which makes
> the kernel to try and pull battery information, resulting in errors.
> 
> Apply HID_BATTERY_QUIRK_AVOID_QUERY to the device.

Applied, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs


