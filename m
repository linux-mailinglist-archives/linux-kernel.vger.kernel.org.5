Return-Path: <linux-kernel+bounces-47916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2B845496
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207901F2B304
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E84DA09;
	Thu,  1 Feb 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udU+noJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07B4D9F1;
	Thu,  1 Feb 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781350; cv=none; b=aW4IJoTqVhJ9XdOPSanFGcj/l0kKX97al8zM6KiWRnH+rRoKBzh+mgb5sn96eZFeq5FGuUpjkqez7OdPYZlA5arIAAI+TzuCAns3s/EwRs4KsuTt3uGvT5h3iiRTZXQYQCvv0Roc6MimaTtg0W/YmzCcaiWnw0jTA5xZ7XIiNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781350; c=relaxed/simple;
	bh=vJ1BkR2GfCGMDVdnAPNTubCrwkh1sWpvq2C/V4sxRlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftDsPLa7x1iaAVBCKqoOGyHGoDZlfa0Xaq0cq0Flvvn4VTOc4ghHwhPeYztN7Sa/ZZpf8nSAl3ND56Com3PnuM3RFBNQ8maJnKexYCUN2LjdNlWlgRRagNYfO9l12PRYwbC2RmRa7Bttoi8uAmQHL9gSfh2PSMoWaPrDTPjcuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udU+noJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD99C43394;
	Thu,  1 Feb 2024 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781350;
	bh=vJ1BkR2GfCGMDVdnAPNTubCrwkh1sWpvq2C/V4sxRlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udU+noJs3w5E5ck/mdeMWLhTqvrzTumyFgYCEg16WRSyWn0uAvjMDBnR+Cf2YT19f
	 Oky6gZw+fSKadzmpuH2b704oVqsnIkl+eGZVYWkw9gz4CZZhe8aEU4Ozo6a2uK5XEI
	 +5FyIOFhEyX3BKdfkHi9FiQwWdstJCtJ5dCD76mYcl63T+Jq7rK53AlYEqQGKhGOn2
	 4q3ScG3RDRZHOIg8isVdYgToSQMSTyiafCADkCrm9Pk5/NuvZrg2VNNtBA6DyZin28
	 u7ZOsNX5BTN/QidK6xJ4VVS91u/naiOUjvw7FTexORi8n3cFkAst70UZhAkiQyZJW+
	 qOBQpuhQ4X1wg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rVTnT-0000000069s-1XJ5;
	Thu, 01 Feb 2024 10:55:52 +0100
Date: Thu, 1 Feb 2024 10:55:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid-of: fix NULL-deref on failed power up
Message-ID: <Zbtqp1wgHI0LSSaE@hovoldconsulting.com>
References: <20240126170901.893-1-johan+linaro@kernel.org>
 <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>

On Fri, Jan 26, 2024 at 09:47:23AM -0800, Doug Anderson wrote:
> On Fri, Jan 26, 2024 at 9:10 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > A while back the I2C HID implementation was split in an ACPI and OF
> > part, but the new OF driver never initialises the client pointer which
> > is dereferenced on power-up failures.

> Good catch and thanks for the fix. FWIW, I'd be OK w/
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> That being said, I'd be even happier if you simply removed the
> "client" from the structure and removed the error printout.
> regulator_bulk_enable() already prints error messages when a failure
> happens and thus the error printout is redundant and wastes space.

True, but that error message does not include the device that tried to
use the regulator.

I actually hit this when adding dev_dbg() to the function in question.
For such cases, it's also convenient to have struct device easily
accessible so I think it should be ok to just leave this pointer in.

Johan

